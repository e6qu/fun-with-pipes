/* Reverse-mode autodiff tapes and device kernels (the `ad.*` and
 * `device.*` primitives of lib/autodiff.fwp and lib/tensor.fwp). The
 * interpreter has the same in src/numerics.rs, with the same operation
 * order, so results agree bit for bit.
 *
 * Tapes hold numbers only (parents and partial derivatives), so they live
 * in malloc'ed memory. A reverse-mode value refers to its node as
 * (tape id << 32) | index, constants as -1; a tape id is
 * (generation << 16) | (slot + 1), so a value that outlives its tape is
 * detected.
 *
 * Kernels are fused elementwise expressions in postfix form, evaluated
 * FWP_KCHUNK elements at a time. CpuParallel runs contiguous ranges of
 * chunks on POSIX threads; the workers read the input arrays and write
 * malloc'ed memory, and never allocate from the collected heap (the
 * calling task waits for them, so no collection runs meanwhile).
 * Reductions sum blocks of FWP_KBLOCK elements from the left, then the
 * block sums from the left, whatever the number of threads. */

/* ------------------------------------------------------------------ tapes */

typedef struct {
    int32_t head;
} fwp_tape_scope;

typedef struct {
    uint32_t gen;
    int live;
    int64_t leaves, len, cap;
    int32_t *pa, *pb;
    double *da, *db;
    fwp_tape_scope *scope;
    int32_t scope_prev, scope_next;
} fwp_tape;

static fwp_tape *fwp_tapes = 0;
static int64_t fwp_ntapes = 0;

/* Slot indices remain stable when the tape registry reallocates. */
static void fwp_tape_unlink_scope(fwp_tape *t) {
    fwp_tape_scope *scope = t->scope;
    if (!scope) return;
    if (t->scope_prev >= 0) fwp_tapes[t->scope_prev].scope_next = t->scope_next;
    else scope->head = t->scope_next;
    if (t->scope_next >= 0) fwp_tapes[t->scope_next].scope_prev = t->scope_prev;
    t->scope = 0;
    t->scope_prev = t->scope_next = -1;
}

static void fwp_tape_scope_release(void *arg) {
    fwp_tape_scope *scope = (fwp_tape_scope *)arg;
    while (scope->head >= 0) {
        fwp_tape *t = &fwp_tapes[scope->head];
        fwp_tape_unlink_scope(t);
        t->live = 0;
        free(t->pa);free(t->pb);free(t->da);free(t->db);
        t->pa = t->pb = 0;t->da = t->db = 0;
        t->len = t->cap = t->leaves = 0;
    }
}

/* The cleanup chain is already saved/restored by task context switches. */
static void fwp_tape_link_scope(fwp_tape *t, int32_t slot) {
    t->scope = 0;
    t->scope_prev = t->scope_next = -1;
    for (fwp_cleanup *c = fwp_cleanups; c; c = c->prev) {
        if (c->release == fwp_tape_scope_release) {
            fwp_tape_scope *scope = (fwp_tape_scope *)c->arg;
            t->scope = scope;t->scope_next = scope->head;
            if (scope->head >= 0) fwp_tapes[scope->head].scope_prev = slot;
            scope->head = slot;
            break;
        }
    }
}

static V fwp_ad_scope_apply(V callback, uint32_t argc, const V *args) {
    fwp_tape_scope scope = {-1};
    fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup, fwp_tape_scope_release, &scope);
    V result = fwp_apply_borrowed(callback, argc, args);
    fwp_cleanup_pop(&cleanup);
    fwp_tape_scope_release(&scope);
    FWP_KEEP_ALIVE(callback);
    FWP_KEEP_ALIVE(args);
    return result;
}

static V fwp_p_ad_scope(V callback, V input) {
    return fwp_ad_scope_apply(callback, 1, &input);
}
static V fwp_p_ad_scope2(V callback, V first, V second) {
    V args[2] = {first, second};
    return fwp_ad_scope_apply(callback, 2, args);
}

static const char *FWP_AD_OUTSIDE =
    "autodiff: a reverse-mode value was used after the grad that made it returned";
static const char *FWP_AD_MIXED =
    "autodiff: values of two different grad computations were combined (nested reverse mode is not supported)";

static const char *FWP_AD_INVALID_NODE = "autodiff: invalid node index";

/* Own detached tape buffers until backward returns or unwinds. */
typedef struct {
    int32_t *pa, *pb;
    double *da, *db, *adj;
} fwp_tape_buffers;

static void fwp_tape_buffers_release(void *arg) {
    fwp_tape_buffers *b = (fwp_tape_buffers *)arg;
    free(b->pa);
    free(b->pb);
    free(b->da);
    free(b->db);
    free(b->adj);
}

static void *fwp_k_malloc(size_t n) {
    void *p = malloc(n ? n : 1);
    if (!p) {
        fprintf(stderr, "fwp: out of memory\n");
        exit(102);
    }
    return p;
}

static fwp_tape *fwp_tape_of(int64_t id) {
    int64_t slot = (id & 0xffff) - 1;
    uint32_t gen = (uint32_t)(id >> 16);
    if (slot < 0 || slot >= fwp_ntapes || !fwp_tapes[slot].live || fwp_tapes[slot].gen != gen)
        fwp_trap(FWP_AD_OUTSIDE);
    return &fwp_tapes[slot];
}

/* Match Rust Vec's byte bound, independently of native pointer width. */
static int64_t fwp_tape_limit(void) {
    size_t limit = (size_t)PTRDIFF_MAX / sizeof(double);
    return limit < (size_t)INT32_MAX ? (int64_t)limit : INT32_MAX;
}

static void fwp_tape_reserve(fwp_tape *t, int64_t n) {
    int64_t limit = fwp_tape_limit();
    if (n < 0 || n > limit) fwp_trap("autodiff: the tape is full");
    if (n <= t->cap) return;
    int64_t cap = t->cap ? t->cap : (limit < 64 ? limit : 64);
    while (cap < n) cap = cap > limit / 2 ? limit : cap * 2;
    /* Commit each successful realloc; a failed call still owns the old buffer. */
    void *next = realloc(t->pa, (size_t)cap * sizeof(int32_t));
    if (!next) goto oom;
    t->pa = (int32_t *)next;
    next = realloc(t->pb, (size_t)cap * sizeof(int32_t));
    if (!next) goto oom;
    t->pb = (int32_t *)next;
    next = realloc(t->da, (size_t)cap * sizeof(double));
    if (!next) goto oom;
    t->da = (double *)next;
    next = realloc(t->db, (size_t)cap * sizeof(double));
    if (!next) goto oom;
    t->db = (double *)next;
    t->cap = cap;
    return;
oom:
    fwp_tape_unlink_scope(t);
    free(t->pa);free(t->pb);free(t->da);free(t->db);
    t->pa = t->pb = 0;t->da = t->db = 0;
    t->live = 0;t->len = t->cap = t->leaves = 0;
    fprintf(stderr, "fwp: out of memory\n");
    exit(102);
}

static V fwp_p_ad_tape(V nv) {
    int64_t n = (int64_t)nv;
    if (n < 0 || n > fwp_tape_limit()) fwp_trap("autodiff: too many inputs");
    int64_t slot = 0;
    while (slot < fwp_ntapes && (fwp_tapes[slot].live || fwp_tapes[slot].gen >= 32767)) slot++;
    if (slot == fwp_ntapes) {
        if (fwp_ntapes >= 0xffff) fwp_trap("autodiff: too many grad computations at once");
        fwp_tape *next = (fwp_tape *)realloc(fwp_tapes, (size_t)(fwp_ntapes + 1) * sizeof(fwp_tape));
        if (!next) {
            fprintf(stderr, "fwp: out of memory\n");
            exit(102);
        }
        fwp_tapes = next;
        memset(&fwp_tapes[fwp_ntapes], 0, sizeof(fwp_tape));
        fwp_ntapes++;
    }
    fwp_tape *t = &fwp_tapes[slot];
    t->gen++;
    t->live = 1;
    t->leaves = n;
    t->len = 0;
    fwp_tape_reserve(t, n);
    for (int64_t i = 0; i < n; i++) {
        t->pa[i] = -1;
        t->pb[i] = -1;
        t->da[i] = 0.0;
        t->db[i] = 0.0;
    }
    t->len = n;
    fwp_tape_link_scope(t, (int32_t)slot);
    int64_t id = ((int64_t)t->gen << 16) | (slot + 1);
    return (V)(id << 32);
}

/* (a, da, b, db): a node with parents a and b (-1: none) */
static V fwp_p_ad_push(V tup) {
    int64_t ra = (int64_t)OBJ(tup)->f[0], rb = (int64_t)OBJ(tup)->f[2];
    double da = fwp_f64(OBJ(tup)->f[1]), db = fwp_f64(OBJ(tup)->f[3]);
    if (ra < 0 && rb < 0) return (V)(int64_t)-1;
    if (ra >= 0 && rb >= 0 && (ra >> 32) != (rb >> 32)) fwp_trap(FWP_AD_MIXED);
    if (ra < 0) {
        ra = rb;
        da = db;
        rb = -1;
        db = 0.0;
    }
    int64_t id = ra >> 32;
    fwp_tape *t = fwp_tape_of(id);
    int64_t idx = t->len;
    if (idx >= fwp_tape_limit()) fwp_trap("autodiff: the tape is full");
    if ((ra & 0xffffffff) >= idx || (rb >= 0 && (rb & 0xffffffff) >= idx))
        fwp_trap(FWP_AD_INVALID_NODE);
    fwp_tape_reserve(t, idx + 1);
    t->pa[idx] = (int32_t)(ra & 0xffffffff);
    t->da[idx] = da;
    t->pb[idx] = rb < 0 ? -1 : (int32_t)(rb & 0xffffffff);
    t->db[idx] = db;
    t->len = idx + 1;
    return (V)((id << 32) | idx);
}

/* the adjoints of the inputs, seeding the outputs; frees the tape */
static V fwp_p_ad_backward(V base, V outs, V seeds) {
    int64_t id = (int64_t)base >> 32;
    fwp_tape *t = fwp_tape_of(id);
    fwp_tape_unlink_scope(t);
    fwp_tape tp = *t;
    t->live = 0;
    t->pa = t->pb = 0;
    t->da = t->db = 0;
    t->len = t->cap = t->leaves = 0;
    fwp_tape_buffers buffers = {tp.pa, tp.pb, tp.da, tp.db, 0};
    fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup, fwp_tape_buffers_release, &buffers);
    double *adj = (double *)calloc((size_t)(tp.len ? tp.len : 1), sizeof(double));
    buffers.adj = adj;
    if (!adj) {
        fwp_cleanup_pop(&cleanup);
        fwp_tape_buffers_release(&buffers);
        fprintf(stderr, "fwp: out of memory\n");
        exit(102);
    }
    size_t no = fwp_array_len(outs), ns = fwp_array_len(seeds), m = no < ns ? no : ns;
    for (size_t i = 0; i < m; i++) {
        int64_t o = (int64_t)fwp_array_load(outs, i, NULL);
        if (o < 0) continue;
        if ((o >> 32) != id) fwp_trap(FWP_AD_MIXED);
        if ((o & 0xffffffff) >= tp.len) fwp_trap(FWP_AD_INVALID_NODE);
        adj[o & 0xffffffff] += fwp_f64(fwp_array_load(seeds, i, NULL));
    }
    for (int64_t i = tp.len - 1; i >= tp.leaves; i--) {
        double a = adj[i];
        if (a == 0.0) continue;
        if (tp.pa[i] >= 0) adj[tp.pa[i]] += a * tp.da[i];
        if (tp.pb[i] >= 0) adj[tp.pb[i]] += a * tp.db[i];
    }
    V r = fwp_arr_new((size_t)tp.leaves);
    for (int64_t i = 0; i < tp.leaves; i++) ARR(r)->d[i] = fwp_from_f64(adj[i]);
    fwp_cleanup_pop(&cleanup);
    fwp_tape_buffers_release(&buffers);
    return r;
}

/* ---------------------------------------------------------------- kernels */

enum {
    FWP_K_LEAF, FWP_K_CONST, FWP_K_ADD, FWP_K_SUB, FWP_K_MUL, FWP_K_DIV, FWP_K_NEG,
    FWP_K_SQRT, FWP_K_EXP, FWP_K_LN, FWP_K_SIN, FWP_K_COS, FWP_K_TAN, FWP_K_ABS
};

#define FWP_KCHUNK 256
#define FWP_KBLOCK 4096

typedef struct {
    const int64_t *code;
    size_t ncode;
    const V *consts;
    const double **inputs;
    size_t depth;
} fwp_kernel;

/* elements start..start+len (len <= FWP_KCHUNK) into out */
static inline double fwp_kernel_constant(const fwp_kernel *k, size_t index) {
    V bits;
    memcpy(&bits, (const unsigned char *)k->consts + index * sizeof(V), sizeof bits);
    return fwp_f64(bits);
}

static void fwp_kernel_eval(const fwp_kernel *k, size_t start, size_t len, double *out, double *stack) {
    size_t sp = 0, li = 0, ci = 0;
    for (size_t pc = 0; pc < k->ncode; pc++) {
        int64_t op = k->code[pc];
        double *x = sp ? stack + (sp - 1) * FWP_KCHUNK : stack;
        switch (op) {
        case FWP_K_LEAF:
            memcpy(stack + sp * FWP_KCHUNK, k->inputs[li++] + start, len * sizeof(double));
            sp++;
            break;
        case FWP_K_CONST: {
            double c = fwp_kernel_constant(k, ci++), *s = stack + sp * FWP_KCHUNK;
            for (size_t j = 0; j < len; j++) s[j] = c;
            sp++;
            break;
        }
        case FWP_K_ADD: case FWP_K_SUB: case FWP_K_MUL: case FWP_K_DIV: {
            double *a = stack + (sp - 2) * FWP_KCHUNK, *b = x;
            if (op == FWP_K_ADD) for (size_t j = 0; j < len; j++) a[j] += b[j];
            else if (op == FWP_K_SUB) for (size_t j = 0; j < len; j++) a[j] -= b[j];
            else if (op == FWP_K_MUL) for (size_t j = 0; j < len; j++) a[j] *= b[j];
            else for (size_t j = 0; j < len; j++) a[j] /= b[j];
            sp--;
            break;
        }
        case FWP_K_NEG: for (size_t j = 0; j < len; j++) x[j] = -x[j]; break;
        case FWP_K_SQRT: for (size_t j = 0; j < len; j++) x[j] = sqrt(x[j]); break;
        case FWP_K_EXP: for (size_t j = 0; j < len; j++) x[j] = exp(x[j]); break;
        case FWP_K_LN: for (size_t j = 0; j < len; j++) x[j] = log(x[j]); break;
        case FWP_K_SIN: for (size_t j = 0; j < len; j++) x[j] = sin(x[j]); break;
        case FWP_K_COS: for (size_t j = 0; j < len; j++) x[j] = cos(x[j]); break;
        case FWP_K_TAN: for (size_t j = 0; j < len; j++) x[j] = tan(x[j]); break;
        default: for (size_t j = 0; j < len; j++) x[j] = fabs(x[j]); break;
        }
    }
    memcpy(out, stack, len * sizeof(double));
}

/* elements start..start+len into out */
static void fwp_kernel_range(const fwp_kernel *k, size_t start, size_t len, double *out) {
    double *stack = (double *)fwp_k_malloc((k->depth ? k->depth : 1) * FWP_KCHUNK * sizeof(double));
    for (size_t i = 0; i < len; i += FWP_KCHUNK) {
        size_t m = len - i < FWP_KCHUNK ? len - i : FWP_KCHUNK;
        fwp_kernel_eval(k, start + i, m, out + i, stack);
    }
    free(stack);
}

/* the sums of blocks b0..b0+nb of n elements */
static void fwp_kernel_sums(const fwp_kernel *k, size_t n, size_t b0, size_t nb, double *sums) {
    double *stack = (double *)fwp_k_malloc((k->depth ? k->depth : 1) * FWP_KCHUNK * sizeof(double));
    double buf[FWP_KCHUNK];
    for (size_t b = 0; b < nb; b++) {
        size_t start = (b0 + b) * FWP_KBLOCK, end = start + FWP_KBLOCK < n ? start + FWP_KBLOCK : n;
        double acc = 0.0;
        for (size_t i = start; i < end; i += FWP_KCHUNK) {
            size_t m = end - i < FWP_KCHUNK ? end - i : FWP_KCHUNK;
            fwp_kernel_eval(k, i, m, buf, stack);
            for (size_t j = 0; j < m; j++) acc += buf[j];
        }
        sums[b] = acc;
    }
    free(stack);
}

typedef struct {
    const fwp_kernel *k;
    int sum;
    size_t n, lo, hi; /* units: chunks (run) or blocks (sum) */
    double *out;
} fwp_kjob;

static void fwp_kjob_do(fwp_kjob *j) {
    if (j->sum) {
        fwp_kernel_sums(j->k, j->n, j->lo, j->hi - j->lo, j->out + j->lo);
    } else {
        size_t start = j->lo * FWP_KCHUNK, end = j->hi * FWP_KCHUNK < j->n ? j->hi * FWP_KCHUNK : j->n;
        fwp_kernel_range(j->k, start, end - start, j->out + start);
    }
}

#ifndef __wasi__
static void *fwp_kjob_thread(void *p) {
    fwp_kjob_do((fwp_kjob *)p);
    return 0;
}
#endif

/* units split into contiguous ranges, one per thread (the first on the
 * calling thread) */
static void fwp_kernel_parallel(const fwp_kernel *k, int sum, size_t n, size_t units, int64_t threads, double *out) {
    size_t t = threads < 1 ? 1 : threads > 256 ? 256 : (size_t)threads;
    if (t > units) t = units ? units : 1;
#ifdef __wasi__
    t = 1;
#endif
    fwp_kjob jobs[256];
    for (size_t i = 0; i < t; i++) {
        jobs[i].k = k;
        jobs[i].sum = sum;
        jobs[i].n = n;
        jobs[i].lo = i * units / t;
        jobs[i].hi = (i + 1) * units / t;
        jobs[i].out = out;
    }
#ifndef __wasi__
    pthread_t tids[256];
    int started[256] = {0};
#ifdef FWP_STATIC_MEMORY
    /* threads on the stacks mapped at startup; the results do not depend
     * on how many there are */
    if (t > FWP_STATIC_THREADS + 1) t = FWP_STATIC_THREADS + 1;
    for (size_t i = 0; i < t; i++) {
        jobs[i].lo = i * units / t;
        jobs[i].hi = (i + 1) * units / t;
    }
    for (size_t i = 1; i < t; i++) {
        pthread_attr_t a;
        pthread_attr_init(&a);
        pthread_attr_setstack(&a, fwp_static.thread_stack[i - 1], FWP_STATIC_THREAD_STACK);
        started[i] = pthread_create(&tids[i], &a, fwp_kjob_thread, &jobs[i]) == 0;
        pthread_attr_destroy(&a);
    }
#else
    for (size_t i = 1; i < t; i++) started[i] = pthread_create(&tids[i], 0, fwp_kjob_thread, &jobs[i]) == 0;
#endif
    fwp_kjob_do(&jobs[0]);
    for (size_t i = 1; i < t; i++) {
        if (started[i]) pthread_join(tids[i], 0);
        else fwp_kjob_do(&jobs[i]);
    }
#else
    fwp_kjob_do(&jobs[0]);
#endif
}

static int fwp_kernel_workspace_fits(size_t depth) {
    return depth <= SIZE_MAX / FWP_KCHUNK / sizeof(double);
}

/* check a kernel and gather its inputs; *inputs is malloc'ed */
static void fwp_kernel_prepare(fwp_kernel *k, V code, V consts, V inputs, size_t n) {
    size_t sp = 0, depth = 0, leaves = 0, nconsts = 0;
    k->code = (const int64_t *)((const V *)fwp_array_data(code));
    k->ncode = fwp_array_len(code);
    for (size_t i = 0; i < k->ncode; i++) {
        int64_t op = k->code[i];
        if (op == FWP_K_LEAF || op == FWP_K_CONST) {
            if (op == FWP_K_LEAF) leaves++;
            else nconsts++;
            sp++;
            if (sp > depth) depth = sp;
        } else if (op >= FWP_K_ADD && op <= FWP_K_DIV) {
            if (sp < 2) fwp_trap("device: malformed kernel");
            sp--;
        } else if (op >= FWP_K_NEG && op <= FWP_K_ABS) {
            if (sp < 1) fwp_trap("device: malformed kernel");
        } else {
            fwp_trap("device: malformed kernel");
        }
    }
    size_t nin = fwp_list_len(inputs);
    if (sp != 1 || leaves != nin || nconsts != fwp_array_len(consts)) fwp_trap("device: malformed kernel");
    k->consts = ((const V *)fwp_array_data(consts));
    k->depth = depth;
    k->inputs = (const double **)fwp_k_malloc((nin ? nin : 1) * sizeof(double *));
    V xs = inputs;
    for (size_t i = 0; i < nin; i++) {
        V a = OBJ(xs)->f[0];
        if (fwp_array_len(a) != n) {
            char msg[128];
            snprintf(msg, sizeof msg, "device: input %zu has %llu elements, the kernel %zu", i,
                     (unsigned long long)fwp_array_len(a), n);
            free((void *)k->inputs);
            fwp_trap(msg);
        }
        k->inputs[i] = (const double *)((const V *)fwp_array_data(a));
        xs = OBJ(xs)->f[1];
    }
    if (!fwp_kernel_workspace_fits(depth)) {
        free((void *)k->inputs);
        fwp_trap("device: kernel too large");
    }
}

static V fwp_p_device_run(V threads, V nv, V code, V consts, V inputs) {
    uint64_t count = (int64_t)nv < 0 ? 0 : (uint64_t)nv;
    size_t n = (size_t)count;
    fwp_kernel k;
    fwp_kernel_prepare(&k, code, consts, inputs, n);
    if (count > (SIZE_MAX - sizeof(fwp_arr)) / sizeof(V)) {
        free((void *)k.inputs);
        fwp_trap("array too large");
    }
    double *out = (double *)fwp_k_malloc(n * sizeof(double));
    fwp_kernel_parallel(&k, 0, n, (n + FWP_KCHUNK - 1) / FWP_KCHUNK, (int64_t)threads, out);
    free((void *)k.inputs);
    V r = fwp_arr_new(n);
    memcpy(ARR(r)->d, out, n * sizeof(double));
    free(out);
    return r;
}

static V fwp_p_device_sum(V threads, V nv, V code, V consts, V inputs) {
    size_t n = (int64_t)nv < 0 ? 0 : (size_t)(int64_t)nv;
    fwp_kernel k;
    fwp_kernel_prepare(&k, code, consts, inputs, n);
    size_t blocks = (n + FWP_KBLOCK - 1) / FWP_KBLOCK;
    double *sums = (double *)fwp_k_malloc(blocks * sizeof(double));
    fwp_kernel_parallel(&k, 1, n, blocks, (int64_t)threads, sums);
    free((void *)k.inputs);
    double total = 0.0;
    for (size_t b = 0; b < blocks; b++) total += sums[b];
    free(sums);
    return fwp_from_f64(total);
}

/* ------------------------------------------------------------------ OpenCL
 *
 * libOpenCL is loaded with dlopen on first use (FWP_OPENCL_LIB names
 * another library); without it, or without a device with double
 * precision, the GPU device is unavailable. */

#if !defined(__wasi__) && (defined(__linux__) || defined(__APPLE__))
#include <dlfcn.h>

typedef void *fwp_clp;
static struct {
    int tried;
    char error[256];
    int32_t (*get_platforms)(uint32_t, fwp_clp *, uint32_t *);
    int32_t (*get_devices)(fwp_clp, uint64_t, uint32_t, fwp_clp *, uint32_t *);
    int32_t (*device_info)(fwp_clp, uint32_t, size_t, void *, size_t *);
    fwp_clp (*create_context)(const intptr_t *, uint32_t, const fwp_clp *, void *, void *, int32_t *);
    fwp_clp (*create_queue)(fwp_clp, fwp_clp, uint64_t, int32_t *);
    fwp_clp (*program_with_source)(fwp_clp, uint32_t, const char **, const size_t *, int32_t *);
    int32_t (*build_program)(fwp_clp, uint32_t, const fwp_clp *, const char *, void *, void *);
    int32_t (*build_info)(fwp_clp, fwp_clp, uint32_t, size_t, void *, size_t *);
    fwp_clp (*create_kernel)(fwp_clp, const char *, int32_t *);
    fwp_clp (*create_buffer)(fwp_clp, uint64_t, size_t, void *, int32_t *);
    int32_t (*set_arg)(fwp_clp, uint32_t, size_t, const void *);
    int32_t (*enqueue)(fwp_clp, fwp_clp, uint32_t, const size_t *, const size_t *, const size_t *,
                       uint32_t, const fwp_clp *, fwp_clp *);
    int32_t (*read_buffer)(fwp_clp, fwp_clp, uint32_t, size_t, size_t, void *, uint32_t,
                           const fwp_clp *, fwp_clp *);
    int32_t (*finish)(fwp_clp);
    int32_t (*release_mem)(fwp_clp);
    int32_t (*release_kernel)(fwp_clp);
    int32_t (*release_program)(fwp_clp);
    void *library;
    int32_t (*release_queue)(fwp_clp), (*release_context)(fwp_clp);
    fwp_clp device, context, queue;
} fwp_cl;

static int fwp_cl_pick(void) {
    uint32_t np = 0;
    if (fwp_cl.get_platforms(0, 0, &np) != 0 || np == 0) {
        snprintf(fwp_cl.error, sizeof fwp_cl.error, "no OpenCL device: there is no OpenCL platform");
        return 0;
    }
    fwp_clp *ps = (fwp_clp *)fwp_k_malloc(np * sizeof(fwp_clp));
    fwp_cl.get_platforms(np, ps, &np);
    uint64_t types[2] = {1 << 2, 0xffffffffu};
    for (int ti = 0; ti < 2; ti++) {
        for (uint32_t p = 0; p < np; p++) {
            uint32_t nd = 0;
            if (fwp_cl.get_devices(ps[p], types[ti], 0, 0, &nd) != 0 || nd == 0) continue;
            fwp_clp *ds = (fwp_clp *)fwp_k_malloc(nd * sizeof(fwp_clp));
            fwp_cl.get_devices(ps[p], types[ti], nd, ds, &nd);
            for (uint32_t d = 0; d < nd; d++) {
                char ext[8192];
                size_t len = 0;
                if (fwp_cl.device_info(ds[d], 0x1030, sizeof ext - 1, ext, &len) == 0) {
                    ext[len < sizeof ext ? len : sizeof ext - 1] = 0;
                    if (strstr(ext, "cl_khr_fp64")) {
                        fwp_cl.device = ds[d];
                        free(ds);
                        free(ps);
                        return 1;
                    }
                }
            }
            free(ds);
        }
    }
    free(ps);
    snprintf(fwp_cl.error, sizeof fwp_cl.error,
             "no OpenCL device: no OpenCL device supports double precision (cl_khr_fp64)");
    return 0;
}

/* Calls finish before releasing a successful queue, then release the context
 * while the dynamically loaded entry points are still valid. Partial load
 * failure uses the same ownership path and preserves the cached diagnostic. */
static void fwp_cl_finish(void) {
    if (fwp_cl.queue) {
        fwp_cl.finish(fwp_cl.queue);
        fwp_cl.release_queue(fwp_cl.queue);
        fwp_cl.queue = 0;
    }
    if (fwp_cl.context) {
        fwp_cl.release_context(fwp_cl.context);
        fwp_cl.context = 0;
    }
    if (fwp_cl.library) {
        dlclose(fwp_cl.library);
        fwp_cl.library = 0;
    }
}

static int fwp_cl_load(void) {
    if (fwp_cl.tried) return fwp_cl.queue != 0;
    fwp_cl.tried = 1;
    const char *env = getenv("FWP_OPENCL_LIB");
    void *h = 0;
    if (env && *env) {
        h = dlopen(env, RTLD_NOW);
        if (!h) {
            snprintf(fwp_cl.error, sizeof fwp_cl.error,
                     "no OpenCL device: the OpenCL library (%s) could not be loaded", env);
            return 0;
        }
    } else {
#ifdef __APPLE__
        h = dlopen("/System/Library/Frameworks/OpenCL.framework/OpenCL", RTLD_NOW);
#else
        h = dlopen("libOpenCL.so.1", RTLD_NOW);
        if (!h) h = dlopen("libOpenCL.so", RTLD_NOW);
#endif
        if (!h) {
            snprintf(fwp_cl.error, sizeof fwp_cl.error,
#ifdef __APPLE__
                     "no OpenCL device: the OpenCL framework could not be loaded");
#else
                     "no OpenCL device: the OpenCL library (libOpenCL.so.1, libOpenCL.so) could not be loaded");
#endif
            return 0;
        }
    }
    fwp_cl.library = h;
#define FWP_CL_SYM(field, name) \
    if (!(*(void **)&fwp_cl.field = dlsym(h, name))) { \
        snprintf(fwp_cl.error, sizeof fwp_cl.error, "no OpenCL device: the OpenCL library has no `%s`", name); \
        fwp_cl_finish(); \
        return 0; \
    }
    FWP_CL_SYM(get_platforms, "clGetPlatformIDs")
    FWP_CL_SYM(get_devices, "clGetDeviceIDs")
    FWP_CL_SYM(device_info, "clGetDeviceInfo")
    FWP_CL_SYM(create_context, "clCreateContext")
    FWP_CL_SYM(create_queue, "clCreateCommandQueue")
    FWP_CL_SYM(program_with_source, "clCreateProgramWithSource")
    FWP_CL_SYM(build_program, "clBuildProgram")
    FWP_CL_SYM(build_info, "clGetProgramBuildInfo")
    FWP_CL_SYM(create_kernel, "clCreateKernel")
    FWP_CL_SYM(create_buffer, "clCreateBuffer")
    FWP_CL_SYM(set_arg, "clSetKernelArg")
    FWP_CL_SYM(enqueue, "clEnqueueNDRangeKernel")
    FWP_CL_SYM(read_buffer, "clEnqueueReadBuffer")
    FWP_CL_SYM(finish, "clFinish")
    FWP_CL_SYM(release_mem, "clReleaseMemObject")
    FWP_CL_SYM(release_kernel, "clReleaseKernel")
    FWP_CL_SYM(release_program, "clReleaseProgram")
    FWP_CL_SYM(release_queue, "clReleaseCommandQueue")
    FWP_CL_SYM(release_context, "clReleaseContext")
#undef FWP_CL_SYM
    if (!fwp_cl_pick()) { fwp_cl_finish(); return 0; }
    int32_t err = 0;
    fwp_cl.context = fwp_cl.create_context(0, 1, &fwp_cl.device, 0, 0, &err);
    if (!fwp_cl.context || err) {
        snprintf(fwp_cl.error, sizeof fwp_cl.error, "no OpenCL device: clCreateContext failed (%d)", (int)err);
        fwp_cl_finish();
        return 0;
    }
    fwp_cl.queue = fwp_cl.create_queue(fwp_cl.context, fwp_cl.device, 0, &err);
    if (!fwp_cl.queue || err) {
        snprintf(fwp_cl.error, sizeof fwp_cl.error, "no OpenCL device: clCreateCommandQueue failed (%d)", (int)err);
        fwp_cl_finish();
        return 0;
    }
    return 1;
}

static V fwp_p_gpu_available(void) { return fwp_cl_load() ? FWP_TRUE : FWP_FALSE; }

static V fwp_cl_err(const char *msg) {
    V s = fwp_cstr(msg);
    return fwp_data(1, 1, &s);
}

static V fwp_p_gpu_run(V src, V nv, V consts, V inputs) {
    if (!fwp_cl_load()) return fwp_cl_err(fwp_cl.error);
    size_t n = (int64_t)nv < 0 ? 0 : (size_t)(int64_t)nv;
    if (n == 0) {
        V a = fwp_arr_new(0);
        return fwp_data(0, 1, &a);
    }
    char msg[16640];
    int32_t err = 0;
    const char *text = STR(src)->d;
    fwp_clp prog = fwp_cl.program_with_source(fwp_cl.context, 1, &text, 0, &err);
    if (!prog || err) {
        snprintf(msg, sizeof msg, "OpenCL: clCreateProgramWithSource failed (%d)", (int)err);
        return fwp_cl_err(msg);
    }
    fwp_clp kernel = 0, mems[260];
    size_t nmem = 0, nin = fwp_list_len(inputs);
    double *result = 0;
    msg[0] = 0;
    if (nin > 256) {
        snprintf(msg, sizeof msg, "OpenCL: too many inputs");
        goto done;
    }
    if (fwp_cl.build_program(prog, 1, &fwp_cl.device, "-cl-fp32-correctly-rounded-divide-sqrt", 0, 0) != 0) {
        char log[16384];
        size_t len = 0;
        fwp_cl.build_info(prog, fwp_cl.device, 0x1183, sizeof log - 1, log, &len);
        log[len < sizeof log ? len : sizeof log - 1] = 0;
        size_t l = strlen(log);
        while (l > 0 && (log[l - 1] == '\n' || log[l - 1] == ' ')) log[--l] = 0;
        snprintf(msg, sizeof msg, "OpenCL: building the kernel failed:\n%s", log);
        goto done;
    }
    kernel = fwp_cl.create_kernel(prog, "fwp_kernel", &err);
    if (!kernel || err) {
        snprintf(msg, sizeof msg, "OpenCL: clCreateKernel failed (%d)", (int)err);
        goto done;
    }
    /* buffers: the output, the constants, then the inputs */
    for (size_t i = 0; i < nin + 2; i++) {
        V a = i == 0 ? 0 : i == 1 ? consts : OBJ(inputs)->f[0];
        if (i >= 2) inputs = OBJ(inputs)->f[1];
        size_t len = i == 0 ? n : fwp_array_len(a);
        uint64_t flags = i == 0 ? (1 << 1) : (1 << 2);
        void *host = (i > 0 && len > 0) ? (void *)((const V *)fwp_array_data(a)) : 0;
        if (host) flags |= 1 << 5;
        mems[nmem] = fwp_cl.create_buffer(fwp_cl.context, flags, (len ? len : 1) * sizeof(double), host, &err);
        if (!mems[nmem] || err) {
            snprintf(msg, sizeof msg, "OpenCL: clCreateBuffer failed (%d)", (int)err);
            goto done;
        }
        nmem++;
    }
    int64_t nn = (int64_t)n;
    int32_t st = fwp_cl.set_arg(kernel, 0, sizeof(fwp_clp), &mems[0]);
    st |= fwp_cl.set_arg(kernel, 1, sizeof(fwp_clp), &mems[1]);
    st |= fwp_cl.set_arg(kernel, 2, 8, &nn);
    for (size_t i = 0; i < nin; i++) st |= fwp_cl.set_arg(kernel, (uint32_t)(3 + i), sizeof(fwp_clp), &mems[2 + i]);
    if (st) {
        snprintf(msg, sizeof msg, "OpenCL: clSetKernelArg failed");
        goto done;
    }
    size_t global = n;
    st = fwp_cl.enqueue(fwp_cl.queue, kernel, 1, 0, &global, 0, 0, 0, 0);
    if (st) {
        snprintf(msg, sizeof msg, "OpenCL: clEnqueueNDRangeKernel failed (%d)", (int)st);
        goto done;
    }
    result = (double *)fwp_k_malloc(n * sizeof(double));
    st = fwp_cl.read_buffer(fwp_cl.queue, mems[0], 1, 0, n * sizeof(double), result, 0, 0, 0);
    fwp_cl.finish(fwp_cl.queue);
    if (st) snprintf(msg, sizeof msg, "OpenCL: clEnqueueReadBuffer failed (%d)", (int)st);
done:
    for (size_t i = 0; i < nmem; i++) fwp_cl.release_mem(mems[i]);
    if (kernel) fwp_cl.release_kernel(kernel);
    fwp_cl.release_program(prog);
    if (msg[0]) {
        free(result);
        return fwp_cl_err(msg);
    }
    V r = fwp_arr_new(n);
    memcpy(ARR(r)->d, result, n * sizeof(double));
    free(result);
    return fwp_data(0, 1, &r);
}

#else

static void fwp_cl_finish(void) {}
static V fwp_p_gpu_available(void) { return FWP_FALSE; }

static V fwp_p_gpu_run(V src, V nv, V consts, V inputs) {
    (void)src; (void)nv; (void)consts; (void)inputs;
    V s = fwp_cstr("no OpenCL device: OpenCL is not available on this target");
    return fwp_data(1, 1, &s);
}

#endif
