/* ------------------------------------------------------------------ tapes */

/* F128 and nested reverse weights are language values. Keep them in mutable
 * storage with explicit typed owners, independent of the reallocable
 * numeric registry. Detached backward passes stay on this list across reentry. */
typedef struct fwp_owned_tape {
    struct fwp_owned_tape *prev, *next;
    const fwp_desc *elem;
    uint64_t task; /* Zero identifies the root before and after task startup. */
    V zero, add, mul, inactive_zero;
    V *weights, *adj; /* An adjoint equal to zero borrows that tape-owned value. */
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
        for (int64_t i = 0; i < owner->nadj; i++)
            if (owner->adj[i] != owner->zero) owner->elem->drop(owner->adj[i]);
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
    /* Shutdown releases the bounded cache and any unfinished scoped tapes. */
    fwp_tape_buffers_dispose(&fwp_tape_workspace);fwp_tape_cached_bytes = 0;
    for (int64_t i = 0; i < fwp_ntapes; i++) {
        fwp_tape *t = &fwp_tapes[i];
        fwp_tape_unlink_scope(t);
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

static void fwp_tape_grow(fwp_tape *t, int64_t n, int64_t limit) {
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

/* Keep the usual no-growth path at the caller, without duplicating buffer
 * allocation and recovery. Validate before taking the capacity shortcut. */
static inline __attribute__((always_inline)) void fwp_tape_reserve(fwp_tape *t, int64_t n) {
    int64_t limit = fwp_tape_limit();
    if (n < 0 || n > limit) fwp_trap("autodiff: the tape is full");
    if (n <= t->cap) return;
    fwp_tape_grow(t, n, limit);
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

/* Only a compiler-proved, non-suspending numeric worker may retain this pair.
 * Its call graph cannot create/retire tapes or reenter the runtime. Scalar
 * append can grow the tape's buffers, but never moves the tape registry.
 * Initialize each invocation with {-1, NULL}; active IDs are nonnegative. */
typedef struct {
    int64_t id;
    fwp_tape *tape;
} fwp_ad_recording;

/* A node with parents a and b (-1: none), with immediate F64 weights.
 * Ordinary callers explicitly pass NULL and validate every lookup. Inline the
 * same checked body so native compilers can specialize known arguments; keep
 * growth, traps and tape lifetime rules unchanged. */
static inline __attribute__((always_inline)) V fwp_p_ad_push(V a, V wa, V b, V wb, fwp_ad_recording *recording) {
    int64_t ra = (int64_t)a, rb = (int64_t)b;
    double da = fwp_f64(wa), db = fwp_f64(wb);
    if (ra < 0 && rb < 0) return (V)(int64_t)-1;
    if (ra >= 0 && rb >= 0 && (ra >> 32) != (rb >> 32)) fwp_trap(FWP_AD_MIXED);
    if (ra < 0) {
        ra = rb;
        da = db;
        rb = -1;
        db = 0.0;
    }
    int64_t id = ra >> 32;
    fwp_tape *t;
    if (recording && recording->id == id) {
        t = recording->tape;
    } else {
        t = fwp_tape_of(id);
        if (t->owned) fwp_trap(FWP_AD_REPRESENTATION);
        if (recording) {
            recording->id = id;
            recording->tape = t;
        }
    }
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
/* The source slices borrow ordinary array payloads or a caller's two scalar
 * words. No pointer is retained, released, or exposed to a callback. Read via
 * memcpy: a stack word needs neither an array header nor heap ownership. */
static V fwp_ad_backward_values(V base, const unsigned char *outs,
                                const unsigned char *seeds, size_t count) {
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

    for (size_t i = 0; i < count; i++) {
        V bits; memcpy(&bits, outs + i * sizeof(V), sizeof bits);
        int64_t o = (int64_t)bits;
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
    for (size_t i = 0; i < count; i++) {
        V bits; memcpy(&bits, outs + i * sizeof(V), sizeof bits);
        int64_t o = (int64_t)bits;
        if (o < 0) continue;
        V seed; memcpy(&seed, seeds + i * sizeof(V), sizeof seed);
        adj[o & 0xffffffff] += fwp_f64(seed);
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

static V fwp_p_ad_backward(V base, V outs, V seeds) {
    size_t no = fwp_array_len(outs), ns = fwp_array_len(seeds);
    return fwp_ad_backward_values(base, fwp_array_data(outs), fwp_array_data(seeds), no < ns ? no : ns);
}
static V fwp_p_ad_backward_one(V base, V root, V seed) {
    return fwp_ad_backward_values(base, (const unsigned char *)&root,
                                  (const unsigned char *)&seed, 1);
}

static V fwp_p_ad_push_owned(V a, V da, V b, V db, const fwp_desc *elem) {
    /* Both arguments arrive with independent owners, even when they alias. */
    fwp_value_owner left = {da, elem->drop}, right = {db, elem->drop};
    fwp_cleanup left_cleanup, right_cleanup;
    fwp_cleanup_push(&left_cleanup, fwp_value_release, &left);
    fwp_cleanup_push(&right_cleanup, fwp_value_release, &right);
    int64_t ra = (int64_t)a, rb = (int64_t)b;
    if (ra < 0 && rb < 0) {
        fwp_cleanup_pop(&right_cleanup); fwp_value_release(&right);
        fwp_cleanup_pop(&left_cleanup); fwp_value_release(&left);
        return (V)(int64_t)-1;
    }
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
    owner->weights[2*op] = da; owner->weights[2*op+1] = db;
    t->pa[op] = ra < 0 ? -1 : (int32_t)(ra & 0xffffffff);
    t->pb[op] = rb < 0 ? -1 : (int32_t)(rb & 0xffffffff);
    /* No failure point lies between removing these guards and publication. */
    fwp_cleanup_pop(&right_cleanup);
    fwp_cleanup_pop(&left_cleanup);
    owner->len = t->len = idx + 1;

    return (V)((id << 32) | idx);
}

static V fwp_owned_tape_add(fwp_owned_tape *owner, V value, V old) {
    V args[2] = {value, old};
    V result = fwp_apply_borrowed(owner->add, 2, args);
    /* Callback results own their value, even when they return a borrowed input.
     * Normalize the exact shared zero to a borrowed slot; numerical equality
     * would incorrectly conflate distinct owned values. */
    if (owner->elem->drop) {
        if (result == owner->zero) owner->elem->drop(result);
        if (old != owner->zero) owner->elem->drop(old);
    }
    return result;
}

typedef enum { FWP_AD_ROOT_LIST, FWP_AD_ROOT_SINGLE } fwp_ad_root_layout;

/* Both seed representations borrow their values for the complete call. The
 * explicit layout selects list traversal or one scalar root/seed; neither
 * stores a cursor in the tape or passes a container to scalar callbacks. */
static V fwp_ad_backward_owned(V base, V outs, V seeds, const fwp_desc *array_type,
                               fwp_ad_root_layout layout) {
    int64_t id = (int64_t)base >> 32;
    fwp_tape *t = fwp_tape_of(id);
    fwp_owned_tape *owner = t->owned;
    if (!owner || owner->elem != array_type->elem) fwp_trap(FWP_AD_REPRESENTATION);
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
    size_t count = layout == FWP_AD_ROOT_SINGLE ? 1 : fwp_list_len(outs);
    if (layout == FWP_AD_ROOT_LIST && count != fwp_list_len(seeds))
        fwp_trap("autodiff: seed count differs from output count");
    owner->adj = fwp_mem_alloc((size_t)(tp.len ? tp.len : 1) * sizeof(V));
    /* The tape owns zero until all slots and result transfers are finished. */
    for (int64_t i = 0; i < tp.len; i++) {
        owner->adj[i] = owner->zero; owner->nadj = i + 1;
    }
    V output_cursor = outs, seed_cursor = seeds;
    for (size_t i = 0; i < count; i++) {
        int64_t o = (int64_t)(layout == FWP_AD_ROOT_SINGLE ? outs : OBJ(output_cursor)->f[0]);
        V seed = layout == FWP_AD_ROOT_SINGLE ? seeds : OBJ(seed_cursor)->f[0];
        if (o >= 0) {
            if ((o >> 32) != id) fwp_trap(FWP_AD_MIXED);
            int64_t node = o & 0xffffffff;
            if (node >= tp.len) fwp_trap(FWP_AD_INVALID_NODE);
            owner->adj[node] = fwp_owned_tape_add(owner, seed, owner->adj[node]);
        }
        if (layout == FWP_AD_ROOT_LIST) {
            output_cursor = OBJ(output_cursor)->f[1]; seed_cursor = OBJ(seed_cursor)->f[1];
        }
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
    fwp_array_builder result = {
        fwp_array_typed_new((size_t)tp.leaves, owner->elem), 0, owner->elem
    };
    fwp_cleanup result_cleanup;
    fwp_array_builder_protect(&result, &result_cleanup);
    for (int64_t i = 0; i < tp.leaves; i++) {
        V value = owner->adj[i];
        if (value == owner->zero && owner->elem->dup) owner->elem->dup(value);
        fwp_value_owner input_owner = {value, owner->elem->drop};
        fwp_cleanup input_cleanup;
        fwp_cleanup_push(&input_cleanup, fwp_value_release, &input_owner);
        owner->adj[i] = owner->zero;
        fwp_array_store_owned(result.value, (size_t)i, value, owner->elem);
        result.filled++;
        fwp_cleanup_pop(&input_cleanup);
    }
    V output = fwp_array_builder_finish(&result, &result_cleanup);
    fwp_cleanup_pop(&value_cleanup); fwp_owned_tape_release(owner);
    fwp_cleanup_pop(&tape_cleanup); fwp_tape_buffers_dispose(&buffers);

    return output;
}

static V fwp_p_ad_backward_owned(V base, V outs, V seeds, const fwp_desc *array_type) {
    return fwp_ad_backward_owned(base, outs, seeds, array_type, FWP_AD_ROOT_LIST);
}
static V fwp_p_ad_backward_owned_one(V base, V root, V seed, const fwp_desc *array_type) {
    return fwp_ad_backward_owned(base, root, seed, array_type, FWP_AD_ROOT_SINGLE);
}

