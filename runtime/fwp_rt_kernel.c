/* Reverse-mode autodiff tapes and device kernels (the `ad.*` and
 * `device.*` primitives of lib/autodiff.fwp and lib/tensor.fwp). The
 * interpreter has the same in src/numerics.rs, with the same operation
 * order, so results agree bit for bit.
 *
 * F16/BF16/F32/F64 tapes hold numeric parents and F64 partial derivatives in
 * malloc'ed buffers. F128 and nested tapes own typed weights and callbacks in
 * scanned runtime
 * storage, and execute adjoint operations on enclosing tapes. A reverse-mode
 * value refers to its node as
 * (tape id << 32) | index, constants as -1; a tape id is
 * (generation << 16) | (slot + 1), so a value that outlives its tape is
 * detected.
 *
 * Kernels are fused elementwise expressions in postfix form, evaluated
 * FWP_KCHUNK elements at a time. CpuParallel runs contiguous ranges of
 * chunks on native threads; the workers read the input arrays and write
 * the owned output array or native reduction storage. Workers never allocate
 * from the managed heap; the calling task waits until they all finish.
 * Reductions sum blocks of FWP_KBLOCK elements from the left, then the
 * block sums from the left, whatever the number of threads. */

/* ------------------------------------------------------------------ tapes */

/* F128 and nested reverse weights are language values. Keep them in scanned mutable
 * storage with explicit typed owners, rooted independently of the reallocable
 * numeric registry. Detached backward passes stay on this list across reentry. */
typedef struct fwp_owned_tape {
    struct fwp_owned_tape *prev, *next;
    const fwp_desc *elem;
    uint64_t task; /* Zero identifies the root before and after task startup. */
    V zero, add, mul, inactive_zero;
    V *weights, *adj;
    int64_t leaves, len, cap, nadj;
} fwp_owned_tape;
static fwp_owned_tape *fwp_owned_tapes;

static void fwp_owned_tape_release(void *pointer) {
    fwp_owned_tape *owner = pointer;
    if (!owner) return;
    if (owner->prev) owner->prev->next = owner->next;
    else fwp_owned_tapes = owner->next;
    if (owner->next) owner->next->prev = owner->prev;
    if (owner->elem->drop) {
        for (int64_t i = 0; i < owner->len - owner->leaves; i++) {
            owner->elem->drop(owner->weights[2*i]);
            owner->elem->drop(owner->weights[2*i+1]);
        }
        for (int64_t i = 0; i < owner->nadj; i++) owner->elem->drop(owner->adj[i]);
        owner->elem->drop(owner->zero);
    }
    fwp_closure_drop(owner->add); fwp_closure_drop(owner->mul);
    fwp_closure_drop(owner->inactive_zero);
    fwp_mem_free(owner->weights); fwp_mem_free(owner->adj); fwp_mem_free(owner);
}

static void fwp_owned_tape_reserve(fwp_owned_tape *owner, int64_t cap) {
    if (cap <= owner->cap) return;
    if ((uint64_t)cap > (size_t)PTRDIFF_MAX / (2 * sizeof(V)))
        fwp_trap("autodiff: the tape is full");
    V *weights = fwp_mem_realloc(owner->weights, (size_t)owner->cap * 2 * sizeof(V),
                               (size_t)cap * 2 * sizeof(V));
    memset(weights + 2 * owner->cap, 0, (size_t)(cap - owner->cap) * 2 * sizeof(V));
    owner->weights = weights; owner->cap = cap;
}

typedef struct {
    int32_t head;
} fwp_tape_scope;

typedef struct {
    uint32_t gen;
    int live;
    int64_t leaves, len, cap;
    /* Operation offsets exclude inputs; parent values remain node indices.
     * pa/pb share one allocation; numeric da/db share another. */
    int32_t *pa, *pb;
    double *da, *db, *adj;
    int64_t adjcap;
    fwp_tape_scope *scope;
    int32_t scope_prev, scope_next;
    fwp_owned_tape *owned;
} fwp_tape;

static fwp_tape *fwp_tapes = 0;
static int64_t fwp_ntapes = 0;
static int64_t fwp_tapes_cap = 0;
/* Every slot below this cursor is live or permanently generation-exhausted. */
static int64_t fwp_tape_next_slot = 0;
static void fwp_tape_retire(fwp_tape *t);
static void fwp_tape_finish(void);

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
        fwp_tape_retire(t);
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
    if (!t->scope) fwp_trap("internal: ARC autodiff tape has no proved scope");
}

static V fwp_ad_scope_apply(V callback, uint32_t argc, V *args) {
    fwp_tape_scope scope = {-1};
    fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup, fwp_tape_scope_release, &scope);
    V result = fwp_apply_borrowed(callback, argc, args);
    fwp_cleanup_pop(&cleanup);
    fwp_tape_scope_release(&scope);


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
    "autodiff: values of two different grad computations were combined";
static const char *FWP_AD_REPRESENTATION = "autodiff: tape scalar representation mismatch";

static const char *FWP_AD_INVALID_NODE = "autodiff: invalid node index";

/* Own detached tape buffers until backward returns or unwinds. */
typedef struct {
    int32_t *pa, *pb;
    double *da, *db, *adj;
    int64_t cap, adjcap;
} fwp_tape_buffers;

/* A single detached owner bounds idle memory even across many tape slots. */
#define FWP_AD_WORKSPACE_BUDGET ((size_t)512 * 1024)
static fwp_tape_buffers fwp_tape_workspace;
static size_t fwp_tape_cached_bytes;
static int fwp_tape_workspace_enabled(void) {
    const char *setting = getenv("FWP_AD_WORKSPACE");
    return !setting || strcmp(setting, "0") != 0;
}
static void fwp_tape_buffers_dispose(void *pointer) {
    fwp_tape_buffers *b = pointer;
    free(b->pa);
    free(b->da);
    free(b->adj);
    memset(b, 0, sizeof *b);
}
static size_t fwp_tape_workspace_size(const fwp_tape_buffers *b) {
    if (b->cap < 0 || b->adjcap < 0 || (uint64_t)b->cap > FWP_AD_WORKSPACE_BUDGET / 24) return SIZE_MAX;
    size_t nodes = (size_t)b->cap * 24;
    if ((uint64_t)b->adjcap > (FWP_AD_WORKSPACE_BUDGET - nodes) / sizeof(double)) return SIZE_MAX;
    return nodes + (size_t)b->adjcap * sizeof(double);
}
static void fwp_tape_buffers_release(void *arg) {
    fwp_tape_buffers *b = (fwp_tape_buffers *)arg;
    size_t bytes = fwp_tape_workspace_size(b);
    if (fwp_tape_workspace_enabled() && bytes && bytes <= FWP_AD_WORKSPACE_BUDGET) {
        fwp_tape_buffers_dispose(&fwp_tape_workspace);
        fwp_tape_workspace = *b;
        fwp_tape_cached_bytes = bytes;
        memset(b, 0, sizeof *b);
    } else fwp_tape_buffers_dispose(b);
}
static void fwp_tape_retire(fwp_tape *t) {
    fwp_tape_buffers buffers = {t->pa, t->pb, t->da, t->db, t->adj, t->cap, t->adjcap};
    fwp_owned_tape *owned = t->owned; t->owned = NULL;
    t->pa = t->pb = 0;t->da = t->db = t->adj = 0;
    t->live = 0;t->len = t->cap = t->leaves = t->adjcap = 0;
    if (t->gen < 32767 && t - fwp_tapes < fwp_tape_next_slot)
        fwp_tape_next_slot = t - fwp_tapes;
    if (owned) {
        fwp_tape_buffers_dispose(&buffers);
        fwp_owned_tape_release(owned);
    } else fwp_tape_buffers_release(&buffers);
}
static void fwp_tape_finish(void) {
    /* Shutdown releases both the bounded cache and unscoped live tapes. */
    fwp_tape_buffers_dispose(&fwp_tape_workspace);fwp_tape_cached_bytes = 0;
    for (int64_t i = 0; i < fwp_ntapes; i++) {
        fwp_tape *t = &fwp_tapes[i];
        fwp_tape_buffers buffers = {t->pa, t->pb, t->da, t->db, t->adj, t->cap, t->adjcap};
        fwp_tape_buffers_dispose(&buffers);
        fwp_owned_tape_release(t->owned); t->owned = NULL;
    }
    free(fwp_tapes);fwp_tapes = 0;fwp_ntapes = fwp_tapes_cap = 0;
    fwp_tape_next_slot = 0;
}

/* Library teardown calls this before freeing the managed heap. */

static void *fwp_k_malloc(size_t n) {
    void *p = malloc(n ? n : 1);
    if (!p) {
        fprintf(stderr, "fwp: out of memory\n");
        fflush(NULL); _Exit(102);
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
    /* Each pair fits size_t even at the existing PTRDIFF_MAX/8 node bound.
     * Keep old offsets until all allocations succeed: managed weight growth
     * can trap, leaving the live tape usable with its original capacity. */
    fwp_owned_tape *owned = t->owned;
    size_t used = (size_t)(t->len - t->leaves);
    void *next = realloc(t->pa, (size_t)cap * (2 * sizeof(int32_t)));
    if (!next) goto oom;
    t->pa = (int32_t *)next;
    t->pb = t->pa + t->cap;
    if (owned) {
        fwp_owned_tape_reserve(owned, cap);
    } else {
        next = realloc(t->da, (size_t)cap * (2 * sizeof(double)));
        if (!next) goto oom;
        t->da = (double *)next;
        t->db = t->da + t->cap;
        if (used) memmove(t->da + cap, t->db, used * sizeof(double));
        t->db = t->da + cap;
    }
    if (used) memmove(t->pa + cap, t->pb, used * sizeof(int32_t));
    t->pb = t->pa + cap;
    t->cap = cap;
    return;
oom:
    fwp_tape_unlink_scope(t);
    free(t->pa);free(t->da);free(t->adj);
    t->pa = t->pb = 0;t->da = t->db = t->adj = 0;
    t->live = 0;t->len = t->cap = t->leaves = t->adjcap = 0;
    fprintf(stderr, "fwp: out of memory\n");
    fflush(NULL); _Exit(102);
}

static V fwp_ad_tape_new(V nv, fwp_owned_tape *owned) {
    int64_t n = (int64_t)nv;
    if (n < 0 || n > fwp_tape_limit()) fwp_trap("autodiff: too many inputs");
#ifndef FWP_LIBRARY
    static int registered_finish;
    if (!registered_finish) {
        if (atexit(fwp_tape_finish)) { fprintf(stderr, "fwp: out of memory\n");fflush(NULL); _Exit(102); }
        registered_finish = 1;
    }
#endif
    int64_t slot = fwp_tape_next_slot;
    while (slot < fwp_ntapes && (fwp_tapes[slot].live || fwp_tapes[slot].gen >= 32767)) slot++;
    if (slot == fwp_ntapes) {
        if (fwp_ntapes >= 0xffff) fwp_trap("autodiff: too many grad computations at once");
        if (fwp_ntapes == fwp_tapes_cap) {
            int64_t cap = fwp_tapes_cap ? fwp_tapes_cap * 2 : 1;
            if (cap > 0xffff) cap = 0xffff;
            fwp_tape *next = (fwp_tape *)realloc(fwp_tapes, (size_t)cap * sizeof(fwp_tape));
            if (!next) {
                fprintf(stderr, "fwp: out of memory\n");
                fflush(NULL); _Exit(102);
            }
            fwp_tapes = next;
            fwp_tapes_cap = cap;
        }
        memset(&fwp_tapes[fwp_ntapes], 0, sizeof(fwp_tape));
        fwp_ntapes++;
    }
    fwp_tape *t = &fwp_tapes[slot];
    t->owned = owned;
    if (!owned && fwp_tape_workspace_enabled() && fwp_tape_cached_bytes) {
        t->pa = fwp_tape_workspace.pa;t->pb = fwp_tape_workspace.pb;
        t->da = fwp_tape_workspace.da;t->db = fwp_tape_workspace.db;t->adj = fwp_tape_workspace.adj;
        t->cap = fwp_tape_workspace.cap;t->adjcap = fwp_tape_workspace.adjcap;
        memset(&fwp_tape_workspace, 0, sizeof fwp_tape_workspace);fwp_tape_cached_bytes = 0;
    }
    t->gen++;
    t->live = 1;
    fwp_tape_next_slot = slot + 1;
    t->leaves = n;
    t->len = n;
    fwp_tape_link_scope(t, (int32_t)slot);
    int64_t id = ((int64_t)t->gen << 16) | (slot + 1);
    return (V)(id << 32);
}

static V fwp_p_ad_tape(V nv) { return fwp_ad_tape_new(nv, NULL); }

static V fwp_p_ad_tape_owned(V parameters, V inputs, const fwp_desc *elem) {
    int64_t n = (int64_t)fwp_list_len(inputs);
    if (n < 0 || n > fwp_tape_limit()) fwp_trap("autodiff: too many inputs");
    fwp_owned_tape *owner = fwp_mem_alloc(sizeof *owner);
    memset(owner, 0, sizeof *owner);
    owner->elem = elem;
    owner->task = fwp_cur == fwp_root ? 0 : fwp_cur->identity;
    owner->next = fwp_owned_tapes;
    if (owner->next) owner->next->prev = owner;
    fwp_owned_tapes = owner;
    fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup, fwp_owned_tape_release, owner);
    /* Publish each field only after its retain succeeds. Recovery must release
     * exactly the completed prefix, without consuming borrowed parameters. */
    V zero = OBJ(parameters)->f[0];
    if (elem->dup) elem->dup(zero);
    owner->zero = zero;
    V callback = OBJ(parameters)->f[1]; fwp_rc_dup(callback); owner->add = callback;
    callback = OBJ(parameters)->f[2]; fwp_rc_dup(callback); owner->mul = callback;
    callback = OBJ(parameters)->f[3]; fwp_rc_dup(callback); owner->inactive_zero = callback;
    owner->leaves = owner->len = n;
    V base = fwp_ad_tape_new((V)n, owner);
    fwp_cleanup_pop(&cleanup);


    return base;
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
    if (t->owned) fwp_trap(FWP_AD_REPRESENTATION);
    int64_t idx = t->len;
    if (idx >= fwp_tape_limit()) fwp_trap("autodiff: the tape is full");
    if ((ra & 0xffffffff) >= idx || (rb >= 0 && (rb & 0xffffffff) >= idx))
        fwp_trap(FWP_AD_INVALID_NODE);
    int64_t op = idx - t->leaves;
    fwp_tape_reserve(t, op + 1);
    t->pa[op] = (int32_t)(ra & 0xffffffff);
    t->da[op] = da;
    t->pb[op] = rb < 0 ? -1 : (int32_t)(rb & 0xffffffff);
    t->db[op] = db;
    t->len = idx + 1;
    return (V)((id << 32) | idx);
}

/* the adjoints of the inputs, seeding the outputs; frees the tape */
static V fwp_p_ad_backward(V base, V outs, V seeds) {
    int64_t id = (int64_t)base >> 32;
    fwp_tape *t = fwp_tape_of(id);
    if (t->owned) fwp_trap(FWP_AD_REPRESENTATION);
    fwp_tape_unlink_scope(t);
    fwp_tape tp = *t;
    t->live = 0;
    int64_t slot = (id & 0xffff) - 1;
    if (t->gen < 32767 && slot < fwp_tape_next_slot)
        fwp_tape_next_slot = slot;
    t->pa = t->pb = 0;
    t->da = t->db = t->adj = 0;
    t->len = t->cap = t->leaves = t->adjcap = 0;
    fwp_tape_buffers buffers = {tp.pa, tp.pb, tp.da, tp.db, tp.adj, tp.cap, tp.adjcap};
    fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup, fwp_tape_buffers_release, &buffers);
    /* Parents precede their children. Nodes after the last seeded output
     * cannot contribute; retain every input even when no output is active.
     * Validate before indexing and keep the detached buffers owned on traps. */
    int64_t active = tp.leaves;
    size_t no = fwp_array_len(outs), ns = fwp_array_len(seeds), m = no < ns ? no : ns;
    for (size_t i = 0; i < m; i++) {
        int64_t o = (int64_t)fwp_array_load(outs, i, NULL);
        if (o < 0) continue;
        if ((o >> 32) != id) fwp_trap(FWP_AD_MIXED);
        int64_t node = o & 0xffffffff;
        if (node >= tp.len) fwp_trap(FWP_AD_INVALID_NODE);
        if (node >= active) active = node + 1;
    }
    int64_t needed = active;
    double *adj = buffers.adj;
    if (buffers.adjcap < needed) {
        int64_t capacity = buffers.adjcap ? buffers.adjcap : needed;
        while (capacity < needed)
            capacity = capacity > fwp_tape_limit() / 2 ? needed : capacity * 2;
        adj = buffers.adj ? (double *)realloc(buffers.adj, (size_t)capacity * sizeof(double))
                          : (double *)calloc((size_t)capacity, sizeof(double));
        if (adj) { buffers.adj = adj;buffers.adjcap = capacity; }
    }
    if (needed && !adj) {
        fwp_cleanup_pop(&cleanup);
        fwp_tape_buffers_release(&buffers);
        fprintf(stderr, "fwp: out of memory\n");
        fflush(NULL); _Exit(102);
    }
    if (needed) memset(adj, 0, (size_t)needed * sizeof(double));
    for (size_t i = 0; i < m; i++) {
        int64_t o = (int64_t)fwp_array_load(outs, i, NULL);
        if (o < 0) continue;
        adj[o & 0xffffffff] += fwp_f64(fwp_array_load(seeds, i, NULL));
    }
    for (int64_t i = active - 1; i >= tp.leaves; i--) {
        double a = adj[i];
        if (a == 0.0) continue;
        int64_t op = i - tp.leaves;
        if (tp.pa[op] >= 0) adj[tp.pa[op]] += a * tp.da[op];
        if (tp.pb[op] >= 0) adj[tp.pb[op]] += a * tp.db[op];
    }
    V r = fwp_arr_new((size_t)tp.leaves);
    for (int64_t i = 0; i < tp.leaves; i++) ARR(r)->d[i] = fwp_from_f64(adj[i]);
    fwp_cleanup_pop(&cleanup);
    fwp_tape_buffers_release(&buffers);
    return r;
}

static V fwp_p_ad_push_owned(V tuple, const fwp_desc *elem) {
    int64_t ra = (int64_t)OBJ(tuple)->f[0], rb = (int64_t)OBJ(tuple)->f[2];
    if (ra < 0 && rb < 0) return (V)(int64_t)-1;
    if (ra >= 0 && rb >= 0 && (ra >> 32) != (rb >> 32)) fwp_trap(FWP_AD_MIXED);
    int64_t id = (ra >= 0 ? ra : rb) >> 32;
    fwp_tape *t = fwp_tape_of(id);
    fwp_owned_tape *owner = t->owned;
    if (!owner || owner->elem != elem) fwp_trap(FWP_AD_REPRESENTATION);
    if (owner->task != (fwp_cur == fwp_root ? 0 : fwp_cur->identity))
        fwp_trap("autodiff: managed tape belongs to another task");
    int64_t idx = t->len;
    if (idx >= fwp_tape_limit()) fwp_trap("autodiff: the tape is full");
    if ((ra >= 0 && (ra & 0xffffffff) >= idx) || (rb >= 0 && (rb & 0xffffffff) >= idx))
        fwp_trap(FWP_AD_INVALID_NODE);
    int64_t op = idx - t->leaves;
    fwp_tape_reserve(t, op + 1);
    V da = OBJ(tuple)->f[1], db = OBJ(tuple)->f[3];
    if (elem->dup) {
        elem->dup(da);
        fwp_value_owner weight = {da, elem->drop};
        fwp_cleanup weight_cleanup;
        fwp_cleanup_push(&weight_cleanup, fwp_value_release, &weight);
        elem->dup(db);
        fwp_cleanup_pop(&weight_cleanup);
    }
    owner->weights[2*op] = da; owner->weights[2*op+1] = db;
    t->pa[op] = ra < 0 ? -1 : (int32_t)(ra & 0xffffffff);
    t->pb[op] = rb < 0 ? -1 : (int32_t)(rb & 0xffffffff);
    owner->len = t->len = idx + 1;

    return (V)((id << 32) | idx);
}

static V fwp_owned_tape_add(fwp_owned_tape *owner, V value, V old) {
    V args[2] = {value, old};
    V result = fwp_apply_borrowed(owner->add, 2, args);
    if (owner->elem->drop) owner->elem->drop(old);
    return result;
}

static V fwp_p_ad_backward_owned(V base, V outs, V seeds, const fwp_desc *list_type) {
    int64_t id = (int64_t)base >> 32;
    fwp_tape *t = fwp_tape_of(id);
    fwp_owned_tape *owner = t->owned;
    if (!owner || owner->elem != list_type->elem) fwp_trap(FWP_AD_REPRESENTATION);
    if (owner->task != (fwp_cur == fwp_root ? 0 : fwp_cur->identity))
        fwp_trap("autodiff: managed tape belongs to another task");
    fwp_tape_unlink_scope(t);
    fwp_tape tp = *t;
    t->owned = NULL; t->live = 0;
    int64_t slot = (id & 0xffff) - 1;
    if (t->gen < 32767 && slot < fwp_tape_next_slot)
        fwp_tape_next_slot = slot;
    t->pa = t->pb = NULL; t->da = t->db = t->adj = NULL;
    t->len = t->cap = t->leaves = t->adjcap = 0;
    fwp_tape_buffers buffers = {tp.pa, tp.pb, tp.da, tp.db, tp.adj, tp.cap, tp.adjcap};
    fwp_cleanup tape_cleanup, value_cleanup;
    fwp_cleanup_push(&tape_cleanup, fwp_tape_buffers_dispose, &buffers);
    fwp_cleanup_push(&value_cleanup, fwp_owned_tape_release, owner);
    if (fwp_list_len(outs) != fwp_list_len(seeds))
        fwp_trap("autodiff: seed count differs from output count");
    owner->adj = fwp_mem_alloc((size_t)(tp.len ? tp.len : 1) * sizeof(V));
    memset(owner->adj, 0, (size_t)(tp.len ? tp.len : 1) * sizeof(V));
    for (int64_t i = 0; i < tp.len; i++) {
        if (owner->elem->dup) owner->elem->dup(owner->zero);
        owner->adj[i] = owner->zero; owner->nadj = i + 1;
    }
    V output_cursor = outs, seed_cursor = seeds;
    while (output_cursor) {
        int64_t o = (int64_t)OBJ(output_cursor)->f[0];
        V seed = OBJ(seed_cursor)->f[0];
        if (o >= 0) {
            if ((o >> 32) != id) fwp_trap(FWP_AD_MIXED);
            int64_t node = o & 0xffffffff;
            if (node >= tp.len) fwp_trap(FWP_AD_INVALID_NODE);
            owner->adj[node] = fwp_owned_tape_add(owner, seed, owner->adj[node]);
        }
        output_cursor = OBJ(output_cursor)->f[1]; seed_cursor = OBJ(seed_cursor)->f[1];
    }
    for (int64_t i = tp.len - 1; i >= tp.leaves; i--) {
        V a = owner->adj[i];
        if (fwp_apply_borrowed(owner->inactive_zero, 1, &a) == FWP_TRUE) continue;
        int64_t op = i - tp.leaves;
        for (int side = 0; side < 2; side++) {
            int32_t parent = side ? tp.pb[op] : tp.pa[op];
            if (parent < 0) continue;
            V args[2] = {owner->weights[2*op+side], a};
            fwp_value_owner product = {fwp_apply_borrowed(owner->mul, 2, args), owner->elem->drop};
            fwp_cleanup product_cleanup;
            fwp_cleanup_push(&product_cleanup, fwp_value_release, &product);
            owner->adj[parent] = fwp_owned_tape_add(owner, product.value, owner->adj[parent]);
            fwp_cleanup_pop(&product_cleanup); fwp_value_release(&product);
        }
    }
    fwp_value_owner result = {0, list_type->drop};
    fwp_cleanup result_cleanup;
    fwp_cleanup_push(&result_cleanup, fwp_value_release, &result);
    for (int64_t i = tp.leaves; i; i--) {
        V value = owner->adj[i - 1];
        if (owner->elem->dup) owner->elem->dup(value);
        result.value = fwp_rc_fresh(fwp_cons(value, result.value));
    }
    fwp_cleanup_pop(&result_cleanup);
    fwp_cleanup_pop(&value_cleanup); fwp_owned_tape_release(owner);
    fwp_cleanup_pop(&tape_cleanup); fwp_tape_buffers_dispose(&buffers);

    return result.value;
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
        size_t start = (b0 + b) * FWP_KBLOCK;
        size_t end = start + (n - start < FWP_KBLOCK ? n - start : FWP_KBLOCK);
        double acc = 0.0;
        for (size_t i = start; i < end;) {
            size_t m = end - i < FWP_KCHUNK ? end - i : FWP_KCHUNK;
            fwp_kernel_eval(k, i, m, buf, stack);
            for (size_t j = 0; j < m; j++) acc += buf[j];
            i += m;
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

#ifdef _WIN32
static DWORD WINAPI fwp_kjob_thread(void *p) {
    fwp_kjob_do((fwp_kjob *)p);
    return 0;
}
#elif !defined(__wasi__)
static void *fwp_kjob_thread(void *p) {
    fwp_kjob_do((fwp_kjob *)p);
    return 0;
}
#endif

/* units split into contiguous ranges, one per thread (the first on the
 * calling thread) */
static void fwp_kernel_parallel(const fwp_kernel *k, int sum, size_t n, size_t units, int64_t threads, double *out) {
    size_t t = (size_t)threads;
    if (t > units) t = units ? units : 1;
#ifdef __wasi__
    t = 1;
#endif
#ifdef FWP_STATIC_MEMORY
    if (t > FWP_STATIC_THREADS + 1) t = FWP_STATIC_THREADS + 1;
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
#ifdef _WIN32
#ifdef FWP_STATIC_MEMORY
    fwp_static_worker *workers[256];
    for (size_t i = 1; i < t; i++) workers[i] = fwp_static_worker_start(fwp_kjob_thread, &jobs[i]);
    fwp_kjob_do(&jobs[0]);
    for (size_t i = 1; i < t; i++) fwp_static_worker_release(workers[i]);
#else
    HANDLE tids[256];
    size_t started = 1;
    for (; started < t; started++) {
        tids[started] = CreateThread(NULL, (size_t)1 << 20, fwp_kjob_thread,
                                     &jobs[started], STACK_SIZE_PARAM_IS_A_RESERVATION, NULL);
        if (!tids[started]) break;
    }
    if (started == t) fwp_kjob_do(&jobs[0]);
    for (size_t i = 1; i < started; i++) {
        if (WaitForSingleObject(tids[i], INFINITE) != WAIT_OBJECT_0) abort();
        CloseHandle(tids[i]);
    }
    if (started != t) fwp_trap("cannot create numerical worker thread");
#endif
#elif !defined(__wasi__)
    pthread_t tids[256];
    size_t started = 1;
    for (; started < t; started++) {
#ifdef FWP_STATIC_MEMORY
        pthread_attr_t a;
        pthread_attr_init(&a);
        pthread_attr_setstack(&a, fwp_static.thread_stack[started - 1], FWP_STATIC_THREAD_STACK);
        int status = pthread_create(&tids[started], &a, fwp_kjob_thread, &jobs[started]);
        pthread_attr_destroy(&a);
#else
        int status = pthread_create(&tids[started], 0, fwp_kjob_thread, &jobs[started]);
#endif
        if (status) break;
    }
    if (started == t) fwp_kjob_do(&jobs[0]);
    for (size_t i = 1; i < started; i++)
        if (pthread_join(tids[i], 0)) abort();
    if (started != t) fwp_trap("cannot create numerical worker thread");
#else
    fwp_kjob_do(&jobs[0]);
#endif
}

static int fwp_kernel_workspace_fits(size_t depth) {
    return depth <= SIZE_MAX / FWP_KCHUNK / sizeof(double);
}

/* The caller owns every temporary across validation, result allocation and
 * worker startup. A worker-creation failure joins started workers before a trap. */
typedef struct { fwp_kernel kernel; V output; double *sums; } fwp_kernel_owner;
static void fwp_kernel_release(void *arg) {
    fwp_kernel_owner *owner = arg;
    free((void *)owner->kernel.inputs); owner->kernel.inputs = NULL;
    free(owner->sums); owner->sums = NULL;
    if (owner->output) fwp_rc_free_arr(owner->output);
    owner->output = 0;
}

/* check a kernel and gather its inputs; *inputs is malloc'ed */
static void fwp_kernel_prepare(fwp_kernel *k, V code, V consts, V inputs, uint64_t n) {
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
    if (nin > SIZE_MAX / sizeof(double *)) fwp_trap("device: kernel too large");
    k->inputs = (const double **)fwp_k_malloc((nin ? nin : 1) * sizeof(double *));
    V xs = inputs;
    for (size_t i = 0; i < nin; i++) {
        V a = OBJ(xs)->f[0];
        if (fwp_array_len(a) != n) {
            char msg[128];
            snprintf(msg, sizeof msg, "device: input %zu has %llu elements, the kernel %llu", i,
                     (unsigned long long)fwp_array_len(a), (unsigned long long)n);
            fwp_trap(msg);
        }
        k->inputs[i] = (const double *)((const V *)fwp_array_data(a));
        xs = OBJ(xs)->f[1];
    }
    if (!fwp_kernel_workspace_fits(depth)) fwp_trap("device: kernel too large");
}

static V fwp_p_device_run(V threads, V nv, V code, V consts, V inputs) {
    if ((int64_t)threads < 1 || (int64_t)threads > 256)
        fwp_trap("device: thread count must be between 1 and 256");
    uint64_t count = (int64_t)nv < 0 ? 0 : (uint64_t)nv;
    fwp_kernel_owner owner = {0};
    fwp_cleanup cleanup; fwp_cleanup_push(&cleanup, fwp_kernel_release, &owner);
    fwp_kernel_prepare(&owner.kernel, code, consts, inputs, count);
    if (count > (SIZE_MAX - sizeof(fwp_arr)) / sizeof(V)) fwp_trap("array too large");
    size_t n = (size_t)count;
    owner.output = fwp_rc_fresh(fwp_arr_new(n));
    /* Each worker copies evaluated chunks into distinct output byte ranges.
     * No full-size native output, second copy, or managed allocation in workers. */
    fwp_kernel_parallel(&owner.kernel, 0, n, n / FWP_KCHUNK + (n % FWP_KCHUNK != 0),
                        (int64_t)threads, (double *)ARR(owner.output)->d);
    V result = owner.output; owner.output = 0;
    fwp_cleanup_pop(&cleanup); fwp_kernel_release(&owner);

    return result;
}

static V fwp_p_device_sum(V threads, V nv, V code, V consts, V inputs) {
    if ((int64_t)threads < 1 || (int64_t)threads > 256)
        fwp_trap("device: thread count must be between 1 and 256");
    uint64_t count = (int64_t)nv < 0 ? 0 : (uint64_t)nv;
    fwp_kernel_owner owner = {0};
    fwp_cleanup cleanup; fwp_cleanup_push(&cleanup, fwp_kernel_release, &owner);
    fwp_kernel_prepare(&owner.kernel, code, consts, inputs, count);
    if (count > SIZE_MAX) fwp_trap("device: kernel too large");
    size_t n = (size_t)count;
    size_t blocks = n / FWP_KBLOCK + (n % FWP_KBLOCK != 0);
    owner.sums = (double *)fwp_k_malloc(blocks * sizeof(double));
    fwp_kernel_parallel(&owner.kernel, 1, n, blocks, (int64_t)threads, owner.sums);
    double total = 0.0;
    for (size_t b = 0; b < blocks; b++) total += owner.sums[b];
    fwp_cleanup_pop(&cleanup); fwp_kernel_release(&owner);

    return fwp_from_f64(total);
}

/* F64 matrix fast path: exact shape guards preserve cast/malformed fallback. */
/* Three 32-by-32 F64 tile payloads occupy 24 KiB. */
#define FWP_MATRIX_TILE 32
static V fwp_p_matrix_valid_f64(V mv,V kv,V brv,V nv,V left,V right) {
    int64_t m=(int64_t)mv,k=(int64_t)kv,br=(int64_t)brv,n=(int64_t)nv;
    if(m<0 || k<0 || br!=k || n<0 || (uint64_t)m>SIZE_MAX || (uint64_t)k>SIZE_MAX || (uint64_t)n>SIZE_MAX)return FWP_FALSE;
    uint64_t rows=(uint64_t)m,inner=(uint64_t)k,cols=(uint64_t)n;
    uint64_t limit=(SIZE_MAX-sizeof(fwp_arr))/sizeof(V);
    if((inner && rows>limit/inner) || (cols && inner>limit/cols) || (cols && rows>limit/cols))return FWP_FALSE;
    return (fwp_array_len(left)==rows*inner && fwp_array_len(right)==inner*cols) ? FWP_TRUE : FWP_FALSE;
}
static void fwp_matrix_output_release(void *arg) { fwp_rc_free_arr(*(V *)arg); }
static V fwp_p_matrix_mul_f64(V mv,V kv,V nv,V left,V right) {
    /* The compiler calls this only after the shape predicate succeeds. */
    size_t m=(size_t)mv,k=(size_t)kv,n=(size_t)nv;const fwp_desc scalar={.kind=K_F64};
    V result=fwp_array_typed_new(m*n,&scalar);
    fwp_cleanup cleanup;fwp_cleanup_push(&cleanup,fwp_matrix_output_release,&result);
    /* F64 occupies eight bytes in both packed and word arrays. Resolve views
     * once; fixed-size copy intrinsics preserve C aliasing/alignment rules and
     * stay visible to vectorization (Darwin's fortified memcpy can hide stores).
     * The shape predicate bounds every copy. Only the fresh output is
     * restrict-qualified: inputs may share backing. */
    const unsigned char *a=fwp_array_data(left),*b=fwp_array_data(right);
    unsigned char *restrict out=(unsigned char *)(uintptr_t)result+sizeof(fwp_arr);
    memset(out,0,m*n*sizeof(double));
    for(size_t ib=0;n && k && ib<m;ib+=FWP_MATRIX_TILE){
        size_t ie=m-ib<FWP_MATRIX_TILE?m:ib+FWP_MATRIX_TILE;
        for(size_t kb=0;kb<k;kb+=FWP_MATRIX_TILE){
            size_t ke=k-kb<FWP_MATRIX_TILE?k:kb+FWP_MATRIX_TILE;FWP_TICK();
            for(size_t jb=0;jb<n;jb+=FWP_MATRIX_TILE){
                size_t je=n-jb<FWP_MATRIX_TILE?n:jb+FWP_MATRIX_TILE;
                for(size_t i=ib;i<ie;i++)for(size_t q=kb;q<ke;q++){
                    double x;__builtin_memcpy(&x,a+(i*k+q)*sizeof(double),sizeof x);
                    for(size_t j=jb;j<je;j++){
                        double y,prior;__builtin_memcpy(&y,b+(q*n+j)*sizeof(double),sizeof y);
                        __builtin_memcpy(&prior,out+(i*n+j)*sizeof(double),sizeof prior);
                        double product=x*y,value=product+prior;
                        __builtin_memcpy(out+(i*n+j)*sizeof(double),&value,sizeof value);
                    }
                }
            }
        }
    }
    fwp_cleanup_pop(&cleanup);return result;
}
