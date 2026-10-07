/* Memory: a non-moving mark-and-sweep collector.
 *
 * The heap is one reserved region of address space, committed in chunks
 * of 64 KiB. A chunk holds objects of one size class and one kind, or is
 * part of one big object. Per chunk, out of line: its class, its kind and
 * a mark bit per slot. So any word can be tested cheaply for pointing into
 * the heap, and the object it points into found by division.
 *
 * Kinds: leaf objects (strings, bytes, boxed 128-bit integers, byte and
 * float buffers) are never scanned; every other object is scanned
 * conservatively, word by word. Records, variants, lists, arrays, maps and
 * closures are words, and runtime structures that may hold values (tasks,
 * channels, gRPC connections, temporary arrays) are allocated here too, so
 * that the values they hold are found.
 *
 * Roots are found conservatively: the registers (spilled to the stack),
 * the stack of the running code, the stack of every suspended task (from
 * its saved stack pointer; runtime/fwp_rt_task.c) and the writable data of
 * the program (static constants, CAFs, runtime globals). A word pointing
 * anywhere inside an object keeps it alive; from a stack, a word pointing
 * just past the end of an object too (compilers keep such pointers).
 *
 * Collections are generational, with the marks kept from one collection
 * to the next ("sticky" mark bits): an object that survived a collection
 * is old and stays marked. A minor collection marks from the roots without
 * tracing into old objects, so its cost is that of the young survivors,
 * and frees only young garbage; a major one clears the marks and traces
 * everything. This is sound because old objects do not point to young
 * ones, with one exception that is scanned: objects of the third kind.
 * There are three kinds of non-big objects:
 *
 *   0  values complete when allocated (fwp_alloc_init: records, variants,
 *      list cells), never written again;
 *   1  leaves (fwp_alloc_leaf), which hold no values;
 *   2  memory filled after it is allocated (fwp_alloc: arrays, maps,
 *      partial applications, temporary arrays, runtime structures), which
 *      may come to point to younger objects: every old one is scanned by
 *      every minor collection.
 *
 * A collection starts when the bytes allocated since the last one exceed
 * the live heap (twice it when collection is not generational; 8 MiB at
 * least); it is major when the heap kept
 * since the last major collection has grown past twice its size then (and
 * 16 MiB). Slots freed by a collection go to free lists; empty chunks are
 * reused for any class, and their memory is given back to the system
 * beyond a reserve.
 *
 * FWP_GC=off disables collection, FWP_GC=full makes every collection a
 * major one, FWP_GC_STATS=1 prints statistics at exit and FWP_GC_STRESS=n
 * collects at every n-th allocation (1: every one), to find missing roots.
 * FWP_GC_VERIFY=1 checks each minor collection against a full trace and
 * stops at the first object it missed.
 *
 * WebAssembly keeps a bump allocator that never frees: the stack lives
 * partly in WebAssembly locals, which cannot be scanned. Libraries
 * (--staticlib, --cdylib) use the collector's allocator but never collect,
 * as the host's stacks are unknown. */

#if defined(__wasi__) || defined(__wasm__)
#define FWP_GC 0
#else
#define FWP_GC 1
#endif

#if !FWP_GC

static char *fwp_heap_cur = 0, *fwp_heap_end = 0;

static void *fwp_alloc(size_t n) {
    n = (n + 15) & ~(size_t)15;
    if ((size_t)(fwp_heap_end - fwp_heap_cur) < n) {
        size_t chunk = n > (1 << 20) ? n : (1 << 20);
        fwp_heap_cur = (char *)calloc(1, chunk);
        if (!fwp_heap_cur) {
            fprintf(stderr, "fwp: out of memory\n");
            exit(102);
        }
        fwp_heap_end = fwp_heap_cur + chunk;
    }
    void *p = fwp_heap_cur;
    fwp_heap_cur += n;
    return p;
}

static void *fwp_alloc_leaf(size_t n) { return fwp_alloc(n); }
static void *fwp_alloc_init(size_t n) { return fwp_alloc(n); }
static void *fwp_mem_alloc(size_t n) {
    void *p = calloc(1, n ? n : 1);
    if (!p) {
        fprintf(stderr, "fwp: out of memory\n");
        exit(102);
    }
    return p;
}
static void *fwp_mem_realloc(void *p, size_t old, size_t n) {
    (void)old;
    p = realloc(p, n ? n : 1);
    if (!p) {
        fprintf(stderr, "fwp: out of memory\n");
        exit(102);
    }
    return p;
}
static void fwp_mem_free(void *p) { free(p); }
static void fwp_gc_start(void *top) { (void)top; }
static void fwp_gc_finalizer(void *obj, void (*fn)(void *)) { (void)obj; (void)fn; }
/* without the collector's metadata, everything is shared */
static inline V fwp_rc_fresh(V v) { return v; }
static inline void fwp_rc_dup(V v) { (void)v; }
static inline void fwp_rc_drop(V v) { (void)v; }
static inline void fwp_rc_share(V v) { (void)v; }
static inline int fwp_rc_unique(V v) { (void)v; return 0; }
static inline int fwp_rc_unique_mut(V v) { (void)v; return 0; }
static inline int fwp_rc_last(V v) { (void)v; return 0; }
static inline void fwp_rc_free_obj(V v) { (void)v; }
static inline void fwp_rc_free_arr(V v) { (void)v; }
static inline size_t fwp_rc_capacity(V v) { (void)v; return 0; }
static inline void fwp_rc_poison(V v) { (void)v; }
static inline V fwp_rc_shared(V v) { return v; }
static inline int fwp_rc_young(V v) { (void)v; return 0; }
static inline uint8_t *fwp_rc_slot(V v) { (void)v; return NULL; }

#else /* FWP_GC */

#include <sys/mman.h>
#include <unistd.h>
#ifdef __linux__
#include <elf.h>
#endif
#ifdef __APPLE__
#include <mach-o/dyld.h>
#include <mach-o/loader.h>
#include <sys/resource.h>
#endif

#define GC_SHIFT 16
#define GC_CHUNK ((size_t)1 << GC_SHIFT)
#define GC_NCLS 40
#define GC_MAX_SMALL 16384
#define GC_MIN_BUDGET ((intptr_t)8 << 20)
#define GC_COMMIT_STEP 64 /* chunks committed at a time */

enum { GC_FREE = 0, GC_SMALL, GC_BIG, GC_BIG_TAIL };

typedef struct {
    uint8_t type, leaf, cls, mark; /* leaf: the kind (0, 1, 2); mark: big objects */
    uint8_t dirty;                 /* free, but its memory not given back */
    uint32_t slot, nslots;
    uint32_t head;                 /* big: number of chunks; tail: its head */
    size_t size;                   /* big: bytes */
    uint32_t recip;                /* small: 2^32 / slot, rounded up */
    uint64_t bits[GC_CHUNK / 16 / 64]; /* small: a mark bit per slot */
    uint8_t rc[GC_CHUNK / 16];     /* small, kinds 0 and 2: references counted
                                    * (fwp_rc_*); big: rc[0] */
} gc_chunk;

typedef struct { char *free, *bump, *end; } gc_list;
typedef struct { char *p; size_t n; } gc_range;
typedef struct { void *obj; void (*fn)(void *); } gc_fin;

/* All of the collector's state is here, so that scanning the program's
 * data for roots can skip it. */
static struct {
    intptr_t budget;          /* bytes until the next collection */
    gc_list lists[3][GC_NCLS]; /* [kind][class] */
    uint32_t slot[GC_NCLS];
    uint8_t cls_of[GC_MAX_SMALL / 16 + 1];
    int ready, enabled, armed, collecting, stats;
    int generational, verify, major_next;
    size_t live_after_major, nminor;
    long stress, stress_count;
    char *base;               /* the reserved region */
    uintptr_t heap_bytes;     /* chunks in use (high-water), in bytes */
    size_t nchunks, top, committed, rover, big_rover;
    gc_chunk *meta;
    size_t meta_bytes;
    char *main_top;           /* the top of the main stack */
    gc_range data[16];        /* writable data of the program */
    int ndata;
    gc_range *mstack;         /* mark stack */
    size_t msp, mcap;
    gc_fin *fins;             /* objects to finalize when they die */
    size_t nfins, fins_cap;
    size_t live, peak, ncollect, nfree_chunks;
    double total_alloc, pause_total, pause_max, root_bytes;
    double freed;             /* bytes freed by counts (fwp_rc_free_obj) */
    intptr_t budget_given;
} fwp_gc = {-1};

static void fwp_gc_oom(void) {
    fprintf(stderr, "fwp: out of memory\n");
    exit(102);
}

static void *fwp_gc_reserve(size_t *bytes) {
    for (size_t n = *bytes; n >= ((size_t)256 << 20); n /= 4) {
        void *p = mmap(0, n + GC_CHUNK, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
        if (p != MAP_FAILED) {
            *bytes = n;
            return p;
        }
    }
    return 0;
}

static void fwp_gc_init(void) {
    fwp_gc.ready = 1;
    /* size classes: 16-byte steps up to 256, then four per doubling */
    int c = 0;
    for (uint32_t s = 16; s <= 256; s += 16) fwp_gc.slot[c++] = s;
    for (uint32_t b = 256; b < GC_MAX_SMALL; b *= 2)
        for (uint32_t k = 1; k <= 4; k++) fwp_gc.slot[c++] = b + b / 4 * k;
    for (size_t i = 0, k = 0; i <= GC_MAX_SMALL / 16; i++) {
        while (fwp_gc.slot[k] < i * 16) k++;
        fwp_gc.cls_of[i] = (uint8_t)k;
    }
#ifdef FWP_STATIC_MEMORY
    /* the heap and its metadata were mapped with the rest of the static
     * memory (runtime/fwp_rt_static.c), all of it usable */
    fwp_static_init();
    fwp_gc.base = fwp_static.heap;
    fwp_gc.nchunks = fwp_static.heap_bytes >> GC_SHIFT;
    fwp_gc.meta_bytes = fwp_static.meta_bytes;
    fwp_gc.meta = (gc_chunk *)fwp_static.meta;
    fwp_gc.committed = fwp_gc.nchunks;
#else
    size_t bytes = sizeof(void *) == 8 ? (size_t)1 << 36 : (size_t)1 << 30;
    char *r = (char *)fwp_gc_reserve(&bytes);
    if (!r) fwp_gc_oom();
    fwp_gc.base = (char *)(((uintptr_t)r + GC_CHUNK - 1) & ~(uintptr_t)(GC_CHUNK - 1));
    fwp_gc.nchunks = bytes >> GC_SHIFT;
    fwp_gc.meta_bytes = fwp_gc.nchunks * sizeof(gc_chunk);
    void *m = mmap(0, fwp_gc.meta_bytes, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
    if (m == MAP_FAILED) fwp_gc_oom();
    fwp_gc.meta = (gc_chunk *)m;
#endif
    const char *e = getenv("FWP_GC");
    fwp_gc.enabled = !(e && (!strcmp(e, "off") || !strcmp(e, "0")));
    e = getenv("FWP_GC_STATS");
    fwp_gc.stats = e && *e && strcmp(e, "0") != 0;
    e = getenv("FWP_GC");
    fwp_gc.generational = !(e && !strcmp(e, "full"));
    fwp_gc.major_next = 1;
    e = getenv("FWP_GC_VERIFY");
    fwp_gc.verify = e && *e && strcmp(e, "0") != 0;
    e = getenv("FWP_GC_STRESS");
    fwp_gc.stress = e ? atol(e) : 0;
    if (fwp_gc.stress < 0) fwp_gc.stress = 0;
    fwp_gc.budget = fwp_gc.budget_given = GC_MIN_BUDGET;
}

#ifdef FWP_STATIC_MEMORY
static size_t fwp_static_meta_bytes(size_t heap) { return (heap >> GC_SHIFT) * sizeof(gc_chunk); }
#endif

/* commit chunks up to `top` */
static void fwp_gc_commit(size_t top) {
    if (top <= fwp_gc.committed) return;
#ifdef FWP_STATIC_MEMORY
    fwp_static_full("heap", fwp_static.heap_bytes, "--heap");
#endif
    if (top > fwp_gc.nchunks) fwp_gc_oom();
    size_t to = top + GC_COMMIT_STEP;
    if (to > fwp_gc.nchunks) to = fwp_gc.nchunks;
    if (mprotect(fwp_gc.base + (fwp_gc.committed << GC_SHIFT), (to - fwp_gc.committed) << GC_SHIFT,
                 PROT_READ | PROT_WRITE) != 0)
        fwp_gc_oom();
    size_t pg = (size_t)sysconf(_SC_PAGESIZE);
    uintptr_t lo = (uintptr_t)(fwp_gc.meta + fwp_gc.committed) & ~(uintptr_t)(pg - 1);
    uintptr_t hi = ((uintptr_t)(fwp_gc.meta + to) + pg - 1) & ~(uintptr_t)(pg - 1);
    if (mprotect((void *)lo, hi - lo, PROT_READ | PROT_WRITE) != 0) fwp_gc_oom();
    fwp_gc.committed = to;
}

static inline char *fwp_gc_chunk_addr(size_t ci) { return fwp_gc.base + (ci << GC_SHIFT); }

static void fwp_gc_collect(void);

/* `k` free chunks in a row (index of the first) */
static size_t fwp_gc_chunks(size_t k) {
    size_t *rover = k == 1 ? &fwp_gc.rover : &fwp_gc.big_rover;
    size_t run = 0;
    for (size_t i = *rover; i < fwp_gc.top; i++) {
        if (fwp_gc.meta[i].type != GC_FREE) { run = 0; continue; }
        if (++run == k) {
            *rover = i + 1;
            fwp_gc.nfree_chunks -= k;
            return i + 1 - k;
        }
    }
    /* a free run ending at the top grows into fresh chunks */
    size_t first = fwp_gc.top - run;
#ifdef FWP_STATIC_MEMORY
    /* the heap cannot grow: collect, once, before giving up */
    static int retrying = 0;
    if (first + k > fwp_gc.nchunks && fwp_gc.armed && !fwp_gc.collecting && !retrying) {
        retrying = 1;
        fwp_gc.rover = fwp_gc.big_rover = 0;
        fwp_gc_collect();
        fwp_gc.rover = fwp_gc.big_rover = 0;
        size_t ci = fwp_gc_chunks(k);
        retrying = 0;
        return ci;
    }
#endif
    fwp_gc.nfree_chunks -= run;
    fwp_gc_commit(first + k);
    fwp_gc.top = first + k;
    if (fwp_gc.top << GC_SHIFT > fwp_gc.heap_bytes) fwp_gc.heap_bytes = fwp_gc.top << GC_SHIFT;
    return first;
}

static void fwp_gc_collect(void);

/* the budget ran out: collect (or, when stressing, count) */
static void fwp_gc_spent(void) {
    if (!fwp_gc.ready) fwp_gc_init();
    if (fwp_gc.armed && fwp_gc.stress) {
        if (++fwp_gc.stress_count >= fwp_gc.stress) {
            fwp_gc.stress_count = 0;
            fwp_gc_collect();
        }
        fwp_gc.total_alloc += (double)(fwp_gc.budget_given - fwp_gc.budget);
        fwp_gc.budget = fwp_gc.budget_given = 0;
    } else if (fwp_gc.armed) {
        fwp_gc_collect();
    } else {
        fwp_gc.total_alloc += (double)(fwp_gc.budget_given - fwp_gc.budget);
        fwp_gc.budget = fwp_gc.budget_given = GC_MIN_BUDGET;
    }
}

static __attribute__((noinline)) void *fwp_gc_alloc_big(size_t n, int leaf) {
    if (n > ((size_t)1 << 62)) fwp_gc_oom();
    if ((fwp_gc.budget -= (intptr_t)n) < 0) fwp_gc_spent();
    size_t k = (n + GC_CHUNK - 1) >> GC_SHIFT;
    size_t ci = fwp_gc_chunks(k);
    gc_chunk *m = &fwp_gc.meta[ci];
    m->type = GC_BIG;
    m->leaf = (uint8_t)leaf;
    m->mark = 0;
    m->dirty = 1;
    m->head = (uint32_t)k;
    m->size = n;
    m->rc[0] = 0;
    for (size_t i = 1; i < k; i++) {
        gc_chunk *t = &fwp_gc.meta[ci + i];
        t->type = GC_BIG_TAIL;
        t->dirty = 1;
        t->head = (uint32_t)ci;
    }
    char *p = fwp_gc_chunk_addr(ci);
    memset(p, 0, n);
    return p;
}

/* the free list and the bump space of a class are empty: a new chunk */
static __attribute__((noinline)) char *fwp_gc_refill(gc_list *l, unsigned c, int leaf) {
    size_t ci = fwp_gc_chunks(1);
    gc_chunk *m = &fwp_gc.meta[ci];
    m->type = GC_SMALL;
    m->leaf = (uint8_t)leaf;
    m->cls = (uint8_t)c;
    m->dirty = 1;
    m->slot = fwp_gc.slot[c];
    m->nslots = (uint32_t)(GC_CHUNK / m->slot);
    m->recip = (uint32_t)((((uint64_t)1 << 32) + m->slot - 1) / m->slot);
    memset(m->rc, 0, sizeof m->rc);
    char *p = fwp_gc_chunk_addr(ci);
    /* verifying, a reused chunk's stale words are cleared (see the sweep) */
    if (fwp_gc.verify) memset(p, 0, GC_CHUNK);
    l->bump = p + m->slot;
    l->end = p + (size_t)m->nslots * m->slot;
    return p;
}

static __attribute__((noinline)) void *fwp_gc_alloc_slow(size_t n, int leaf) {
    if (!fwp_gc.ready) fwp_gc_init();
    if (n > GC_MAX_SMALL) return fwp_gc_alloc_big(n, leaf);
    unsigned c = fwp_gc.cls_of[(n + 15) >> 4];
    size_t sz = fwp_gc.slot[c];
    if (fwp_gc.budget < 0) fwp_gc_spent();
    gc_list *l = &fwp_gc.lists[leaf][c];
    char *p = l->free;
    if (p) l->free = (char *)~*(uintptr_t *)p;
    else if ((size_t)(l->end - l->bump) >= sz) { p = l->bump; l->bump += sz; }
    else p = fwp_gc_refill(l, c, leaf);
    memset(p, 0, leaf == 1 ? n : sz);
    return p;
}

static inline void *fwp_gc_alloc(size_t n, int leaf) {
    if (__builtin_expect(n <= GC_MAX_SMALL, 1)) {
        unsigned c = fwp_gc.cls_of[(n + 15) >> 4];
        size_t sz = fwp_gc.slot[c];
        gc_list *l = &fwp_gc.lists[leaf][c];
        if (__builtin_expect((fwp_gc.budget -= (intptr_t)sz) >= 0, 1)) {
            char *p = l->free;
            if (p) {
                l->free = (char *)~*(uintptr_t *)p;
                memset(p, 0, leaf == 1 ? n : sz);
                return p;
            }
            if ((size_t)(l->end - l->bump) >= sz) {
                p = l->bump;
                l->bump += sz;
                memset(p, 0, leaf == 1 ? n : sz);
                return p;
            }
        }
    }
    return fwp_gc_alloc_slow(n, leaf);
}

/* zeroed memory, scanned for values, that may be written after more
 * allocations (kind 2) */
static inline void *fwp_alloc(size_t n) { return fwp_gc_alloc(n, 2); }
/* memory the caller fills (its first n bytes) before the next allocation:
 * only the rest of the slot is zeroed, so the collector, which scans whole
 * slots, finds no stale values there */
static inline void *fwp_alloc_init(size_t n) {
    if (__builtin_expect(n <= GC_MAX_SMALL, 1)) {
        unsigned c = fwp_gc.cls_of[(n + 15) >> 4];
        size_t sz = fwp_gc.slot[c];
        gc_list *l = &fwp_gc.lists[0][c];
        if (__builtin_expect((fwp_gc.budget -= (intptr_t)sz) >= 0, 1)) {
            char *p = l->free;
            if (p) l->free = (char *)~*(uintptr_t *)p;
            else if ((size_t)(l->end - l->bump) >= sz) { p = l->bump; l->bump += sz; }
            if (p) {
                for (size_t i = n & ~(size_t)7; i < sz; i += 8) *(uint64_t *)(p + i) = 0;
                return p;
            }
        }
        /* the slow path does the budget's bookkeeping again */
        fwp_gc.budget += (intptr_t)sz;
    }
    return fwp_gc_alloc(n, 0);
}
/* zeroed memory that holds no values (bytes, numbers) */
static inline void *fwp_alloc_leaf(size_t n) { return fwp_gc_alloc(n, 1); }

/* the chunk of a heap address, or 0 */
static inline gc_chunk *fwp_gc_chunk_of(uintptr_t a, size_t *ci) {
    uintptr_t off = a - (uintptr_t)fwp_gc.base;
    if (off >= fwp_gc.top << GC_SHIFT) return 0;
    *ci = off >> GC_SHIFT;
    return &fwp_gc.meta[*ci];
}

/* Give back an object nothing else refers to (runtime memory only). */
static void fwp_mem_free(void *p) {
    size_t ci;
    gc_chunk *m = p ? fwp_gc_chunk_of((uintptr_t)p, &ci) : 0;
    if (!m) return;
    if (m->type == GC_SMALL) {
        gc_list *l = &fwp_gc.lists[m->leaf][m->cls];
        /* reused unmarked: young again */
        size_t i = (size_t)((uintptr_t)p & (GC_CHUNK - 1)) / m->slot;
        m->bits[i >> 6] &= ~((uint64_t)1 << (i & 63));
        m->rc[i] = 0;
        *(uintptr_t *)p = ~(uintptr_t)l->free;
        l->free = (char *)p;
        fwp_gc.budget += m->slot;
    } else if (m->type == GC_BIG && (char *)p == fwp_gc_chunk_addr(ci)) {
        fwp_gc.budget += (intptr_t)m->size;
        m->mark = 0;
        m->rc[0] = 0;
        size_t k = m->head;
        for (size_t i = 0; i < k; i++) fwp_gc.meta[ci + i].type = GC_FREE;
        fwp_gc.nfree_chunks += k;
        if (ci < fwp_gc.big_rover) fwp_gc.big_rover = ci;
        if (ci < fwp_gc.rover) fwp_gc.rover = ci;
    }
}

static void *fwp_mem_alloc(size_t n) { return fwp_alloc(n); }

/* grow (or shrink) runtime memory of `old` bytes */
static void *fwp_mem_realloc(void *p, size_t old, size_t n) {
    void *r = fwp_alloc(n);
    if (p) {
        memcpy(r, p, old < n ? old : n);
        fwp_mem_free(p);
    }
    return r;
}

/* ----- unique objects, updated in place
 *
 * Counts identify unique values for updates and reclaim eligible objects
 * when typed drops release their last reference. Compiled records/variants
 * and selected primitive result leaves/trees start with one reference
 * (fwp_rc_fresh). Compiled code counts references taken and given up
 * (fwp_rc_dup, fwp_rc_drop, from src/rc.rs). Runtime allocations start
 * shared, count 0, until an explicit ownership contract claims their fresh
 * result. Unknown/retaining boundaries (closures, callbacks, other tasks)
 * promote an escaping value and its descendants to sharing (fwp_rc_share).
 * A count can only be too high (a word that looks like a pointer counted, a reference
 * dropped by a dead object never given back): an object is reused only
 * when it truly has one reference. Complete old values must not acquire
 * young fields; mutable kind-2 containers remain scanned by minor collections. */

/* The count of a small allocation (including pointer-free leaves), or
 * of the start of a big allocation. An unmanaged pointer has no count. */
static inline uint8_t *fwp_rc_slot(V v) {
    uintptr_t off = (uintptr_t)v - (uintptr_t)fwp_gc.base;
    if (off >= fwp_gc.top << GC_SHIFT) return 0;
    gc_chunk *m = &fwp_gc.meta[off >> GC_SHIFT];
    if (m->type == GC_BIG && (off & (GC_CHUNK - 1)) == 0) return &m->rc[0];
    if (m->type != GC_SMALL) return 0;
    /* (a word pointing inside an object counts for that object: only too
     * high, never too low, as words are only dropped through values) */
    size_t i = (size_t)(((uint64_t)(off & (GC_CHUNK - 1)) * m->recip) >> 32);
    return &m->rc[i];
}

static inline V fwp_rc_fresh(V v) {
    uint8_t *c = fwp_rc_slot(v);
    if (c) *c = 1;
    return v;
}

static void fwp_rc_share(V v);

static inline void fwp_rc_dup(V v) {
    uint8_t *c = fwp_rc_slot(v);
    if (c && *c) {
        /* Saturation hands the value to the shared runtime discipline.
         * Its descendants must also be shared before callbacks borrow
         * them without taking independently counted references. */
        if (*c == 255) fwp_rc_share(v);
        else (*c)++;
    }
}

static inline void fwp_rc_drop(V v) {
    uint8_t *c = fwp_rc_slot(v);
    if (c && *c > 1) (*c)--;
}

/* `v` and everything it reaches become shared */
static void fwp_rc_share(V v) {
    uint8_t *c = fwp_rc_slot(v);
    if (!c || !*c) return;
    V stack[64];
    size_t sp = 0;
    *c = 0;
    stack[sp++] = v;
    while (sp) {
        V o = stack[--sp];
        size_t ci = ((uintptr_t)o - (uintptr_t)fwp_gc.base) >> GC_SHIFT;
        gc_chunk *mc = &fwp_gc.meta[ci];
        if (mc->leaf == 1) continue; /* payload bytes are not child references */
        size_t slot = mc->type == GC_BIG ? mc->size : mc->slot;
        /* rc_slot also accepts interior-looking words (counts may be
         * too high). Always traverse from the actual object start. */
        uintptr_t start = (uintptr_t)o;
        if (mc->type == GC_SMALL) {
            size_t inside = start & (GC_CHUNK - 1);
            size_t index = (size_t)(((uint64_t)inside * mc->recip) >> 32);
            start = (uintptr_t)fwp_gc_chunk_addr(ci) + index * mc->slot;
        }
        V *w = (V *)start;
        for (size_t k = 0; k < slot / sizeof(V); k++) {
            uint8_t *d = fwp_rc_slot(w[k]);
            if (!d || !*d) continue;
            if (sp < 64) {
                *d = 0;
                stack[sp++] = w[k];
            } else {
                /* The recursive entry must still see a counted root. */
                fwp_rc_share(w[k]);
            }
        }
    }
}

/* whether the object `v` points into is young: it has not survived a
 * collection (a reused cell must be, at the moment it is written) */
static inline int fwp_rc_young(V v) {
    uint8_t *c = fwp_rc_slot(v);
    if (!c) return 0;
    uintptr_t off = (uintptr_t)v - (uintptr_t)fwp_gc.base;
    gc_chunk *m = &fwp_gc.meta[off >> GC_SHIFT];
    size_t i = (size_t)(c - m->rc);
    return !(m->bits[i >> 6] & ((uint64_t)1 << (i & 63)));
}

/* `v`, shared (a value the runtime keeps) */
static inline V fwp_rc_shared(V v) {
    fwp_rc_share(v);
    return v;
}

/* an object that was judged to have one reference, under
 * FWP_REUSE_VERIFY: any later use of it reads nonsense (and a match on it
 * finds no arm) */
static void fwp_rc_poison(V v) {
    uintptr_t off = (uintptr_t)v - (uintptr_t)fwp_gc.base;
    gc_chunk *m = &fwp_gc.meta[off >> GC_SHIFT];
    if (m->leaf == 1) {
        size_t size = m->type == GC_BIG ? m->size : m->slot;
        memset((void *)(uintptr_t)v, 0xdd, size);
        STR(v)->len = 0;
        STR(v)->d[0] = 0;
        return;
    }
    fwp_obj *o = (fwp_obj *)(uintptr_t)v;
    o->tag = 0xdead;
    for (uint32_t k = 0; k < o->n; k++) o->f[k] = (V)0xdeadbeefdeadbeefULL;
}

/* FWP_REUSE_VERIFY=1: an object that would be reused is copied instead,
 * and the original poisoned, so that a wrong judgment shows */
static int fwp_reuse_verify = -1;

/* 1: `v` has one reference and may be written in place; 2: it would be,
 * but is to be copied and poisoned (FWP_REUSE_VERIFY) */
static inline int fwp_rc_unique(V v) {
    uint8_t *c = fwp_rc_slot(v);
    if (!c || *c != 1) return 0;
    uintptr_t off = (uintptr_t)v - (uintptr_t)fwp_gc.base;
    gc_chunk *m = &fwp_gc.meta[off >> GC_SHIFT];
    size_t i = (size_t)(c - m->rc);
    if (m->bits[i >> 6] & ((uint64_t)1 << (i & 63))) return 0; /* old */
    if (__builtin_expect(fwp_reuse_verify < 0, 0)) {
        const char *e = getenv("FWP_REUSE_VERIFY");
        fwp_reuse_verify = e && *e && strcmp(e, "0") != 0;
    }
    return fwp_reuse_verify ? 2 : 1;
}

/* 1: the object of kind 2 `v` (an array) has one reference and may be
 * written in place, whatever its age (old objects of kind 2 are scanned
 * by every minor collection); 2: it would be, but is to be copied and
 * poisoned (FWP_REUSE_VERIFY) */
static inline int fwp_rc_unique_mut(V v) {
    uint8_t *c = fwp_rc_slot(v);
    if (!c || *c != 1) return 0;
    if (__builtin_expect(fwp_reuse_verify < 0, 0)) {
        const char *e = getenv("FWP_REUSE_VERIFY");
        fwp_reuse_verify = e && *e && strcmp(e, "0") != 0;
    }
    return fwp_reuse_verify ? 2 : 1;
}

/* whether `v` has one reference, which is being given up: the references
 * it holds go too (a count that is only too high stays so) */
static inline int fwp_rc_last(V v) {
    uint8_t *c = fwp_rc_slot(v);
    return c && *c == 1;
}

/* whether the object `v` starts has not survived a collection: only such
 * an object is freed by its count, as no old object points to it (the
 * collector's invariant), so its cell can be given out again; an old one
 * is left to a major collection */
static inline int fwp_rc_unmarked(V v) {
    uintptr_t off = (uintptr_t)v - (uintptr_t)fwp_gc.base;
    if (off >= fwp_gc.top << GC_SHIFT) return 0;
    gc_chunk *m = &fwp_gc.meta[off >> GC_SHIFT];
    if (m->type == GC_BIG) return (off & (GC_CHUNK - 1)) == 0 && !m->mark;
    if (m->type != GC_SMALL) return 0;
    size_t i = (size_t)(off & (GC_CHUNK - 1)) / m->slot;
    return !(m->bits[i >> 6] & ((uint64_t)1 << (i & 63)));
}

/* An object whose last counted reference compiled code gave up (its
 * references gone first, by their types: the `fwp_drop` functions of the
 * program): freed, or poisoned under FWP_REUSE_VERIFY so that a wrong
 * judgment shows. The bytes freed still count as allocated. */
static void fwp_rc_free_obj(V v) {
    if (__builtin_expect(fwp_reuse_verify < 0, 0)) {
        const char *e = getenv("FWP_REUSE_VERIFY");
        fwp_reuse_verify = e && *e && strcmp(e, "0") != 0;
    }
    if (fwp_reuse_verify) {
        fwp_rc_poison(v);
        return;
    }
    if (!fwp_rc_unmarked(v)) return;
    intptr_t before = fwp_gc.budget;
    fwp_mem_free((void *)(uintptr_t)v);
    fwp_gc.freed += (double)(fwp_gc.budget - before);
}

/* an array, map or set, the same way (poisoned: empty) */
static void fwp_rc_free_arr(V v) {
    if (__builtin_expect(fwp_reuse_verify < 0, 0)) {
        const char *e = getenv("FWP_REUSE_VERIFY");
        fwp_reuse_verify = e && *e && strcmp(e, "0") != 0;
    }
    if (fwp_reuse_verify) {
        ARR(v)->len = 0;
        return;
    }
    if (!fwp_rc_unmarked(v)) return;
    intptr_t before = fwp_gc.budget;
    fwp_mem_free((void *)(uintptr_t)v);
    fwp_gc.freed += (double)(fwp_gc.budget - before);
}

/* the bytes usable from `v`, the start of a small object of kind 2 or of
 * a big one (its slot or chunks), or 0 */
static inline size_t fwp_rc_capacity(V v) {
    uintptr_t off = (uintptr_t)v - (uintptr_t)fwp_gc.base;
    if (off >= fwp_gc.top << GC_SHIFT) return 0;
    gc_chunk *m = &fwp_gc.meta[off >> GC_SHIFT];
    if (m->type == GC_BIG && (off & (GC_CHUNK - 1)) == 0) return m->size;
    if (m->type == GC_SMALL && m->leaf == 2 && (off & (GC_CHUNK - 1)) % m->slot == 0) return m->slot;
    return 0;
}

/* ----- marking */

static __attribute__((noinline)) void fwp_gc_push(char *p, size_t n) {
    if (fwp_gc.msp == fwp_gc.mcap) {
        fwp_gc.mcap = fwp_gc.mcap ? fwp_gc.mcap * 2 : 4096;
        fwp_gc.mstack = (gc_range *)realloc(fwp_gc.mstack, fwp_gc.mcap * sizeof(gc_range));
        if (!fwp_gc.mstack) fwp_gc_oom();
    }
    fwp_gc.mstack[fwp_gc.msp].p = p;
    fwp_gc.mstack[fwp_gc.msp].n = n;
    fwp_gc.msp++;
}

/* mark the object `a` points into */
static inline void fwp_gc_mark(uintptr_t a) {
    size_t ci;
    gc_chunk *m = fwp_gc_chunk_of(a, &ci);
    if (!m) return;
    switch (m->type) {
    case GC_SMALL: {
        size_t i = (size_t)(a & (GC_CHUNK - 1)) / m->slot;
        if (i >= m->nslots) return;
        uint64_t bit = (uint64_t)1 << (i & 63);
        if (m->bits[i >> 6] & bit) return;
        m->bits[i >> 6] |= bit;
        if (m->leaf != 1) fwp_gc_push(fwp_gc_chunk_addr(ci) + i * m->slot, m->slot);
        return;
    }
    case GC_BIG_TAIL:
        ci = m->head;
        m = &fwp_gc.meta[ci];
        /* fall through */
    case GC_BIG:
        if (m->mark) return;
        m->mark = 1;
        if (m->leaf != 1) fwp_gc_push(fwp_gc_chunk_addr(ci), m->size);
        return;
    default:
        return;
    }
}

/* Scan a range for words that point into the heap. Roots (stacks) also
 * keep the object a word points just past the end of. Reading stacks and
 * globals word by word is out of bounds as far as AddressSanitizer is
 * concerned. */
__attribute__((no_sanitize_address)) static void fwp_gc_scan(const char *lo, const char *hi, int root) {
    uintptr_t a = ((uintptr_t)lo + 7) & ~(uintptr_t)7;
    uintptr_t base = (uintptr_t)fwp_gc.base, size = fwp_gc.top << GC_SHIFT;
    for (; a + 8 <= (uintptr_t)hi; a += 8) {
        uintptr_t w = *(const uintptr_t *)a;
        if (w - base < size) {
            fwp_gc_mark(w);
            if (root) fwp_gc_mark(w - 1);
        } else if (root && w - base == size) {
            fwp_gc_mark(w - 1);
        }
    }
}

static void fwp_gc_drain(void) {
    while (fwp_gc.msp) {
        gc_range r = fwp_gc.mstack[--fwp_gc.msp];
        fwp_gc_scan(r.p, r.p + r.n, 0);
    }
}

/* a root range (a stack): scanned now, its objects traced later */
static void fwp_gc_scan_root(const char *lo, const char *hi) {
    if (!lo || !hi || hi <= lo) return;
    fwp_gc.root_bytes += (double)(hi - lo);
    fwp_gc_scan(lo, hi, 1);
}

/* the stacks of the running code and of the suspended tasks
 * (runtime/fwp_rt_task.c) */
static void fwp_gc_scan_stacks(char *sp);

/* ----- the program's writable data */

#ifdef __linux__
/* the start of `struct dl_phdr_info` (<link.h> declares it only with
 * _GNU_SOURCE) */
struct fwp_dl_info {
    uintptr_t addr;
    const char *name;
#if UINTPTR_MAX > 0xffffffffu
    const Elf64_Phdr *phdr;
#else
    const Elf32_Phdr *phdr;
#endif
    uint16_t phnum;
};
extern int dl_iterate_phdr(int (*)(struct fwp_dl_info *, size_t, void *), void *);

static int fwp_gc_find_data(struct fwp_dl_info *info, size_t size, void *arg) {
    (void)size;
    (void)arg;
    uintptr_t self = (uintptr_t)&fwp_gc;
    int mine = 0;
    for (int i = 0; i < info->phnum; i++) {
        uintptr_t lo = info->addr + info->phdr[i].p_vaddr;
        if (info->phdr[i].p_type == PT_LOAD && self >= lo && self < lo + info->phdr[i].p_memsz) mine = 1;
    }
    if (!mine) return 0;
    for (int i = 0; i < info->phnum; i++) {
        if (info->phdr[i].p_type != PT_LOAD || !(info->phdr[i].p_flags & PF_W)) continue;
        if (fwp_gc.ndata == (int)(sizeof fwp_gc.data / sizeof fwp_gc.data[0])) break;
        fwp_gc.data[fwp_gc.ndata].p = (char *)(info->addr + info->phdr[i].p_vaddr);
        fwp_gc.data[fwp_gc.ndata].n = info->phdr[i].p_memsz;
        fwp_gc.ndata++;
    }
    return 1;
}
#elif defined(__APPLE__)
/* Only the image containing this runtime owns program globals. Libraries
 * never arm collection: the embedding host's roots are not known. Include
 * writable-at-load segments (also __DATA_CONST), including zero-fill data. */
static void fwp_gc_find_data(void) {
    uintptr_t self = (uintptr_t)&fwp_gc;
    for (uint32_t i = 0; i < _dyld_image_count(); i++) {
        const struct mach_header_64 *h = (const struct mach_header_64 *)_dyld_get_image_header(i);
        if (!h || h->magic != MH_MAGIC_64) continue;
        intptr_t slide = _dyld_get_image_vmaddr_slide(i);
        const char *commands = (const char *)(h + 1);
        const struct load_command *cmd = (const struct load_command *)commands;
        int mine = 0;
        for (uint32_t j = 0; j < h->ncmds; j++) {
            if (cmd->cmd == LC_SEGMENT_64) {
                const struct segment_command_64 *s = (const struct segment_command_64 *)cmd;
                uintptr_t lo = (uintptr_t)(s->vmaddr + slide);
                if (self >= lo && self - lo < s->vmsize) mine = 1;
            }
            cmd = (const struct load_command *)((const char *)cmd + cmd->cmdsize);
        }
        if (!mine) continue;
        cmd = (const struct load_command *)commands;
        for (uint32_t j = 0; j < h->ncmds; j++) {
            if (cmd->cmd == LC_SEGMENT_64) {
                const struct segment_command_64 *s = (const struct segment_command_64 *)cmd;
                if ((s->initprot & (VM_PROT_READ | VM_PROT_WRITE)) == (VM_PROT_READ | VM_PROT_WRITE) && s->vmsize) {
                    if (fwp_gc.ndata == (int)(sizeof fwp_gc.data / sizeof fwp_gc.data[0]))
                        fwp_trap("too many program data segments for the collector");
                    fwp_gc.data[fwp_gc.ndata].p = (char *)(uintptr_t)(s->vmaddr + slide);
                    fwp_gc.data[fwp_gc.ndata++].n = (size_t)s->vmsize;
                }
            }
            cmd = (const struct load_command *)((const char *)cmd + cmd->cmdsize);
        }
        return;
    }
}
#endif

static void fwp_gc_scan_data(void) {
    const char *self = (const char *)&fwp_gc, *self_end = self + sizeof fwp_gc;
    for (int i = 0; i < fwp_gc.ndata; i++) {
        const char *lo = fwp_gc.data[i].p, *hi = lo + fwp_gc.data[i].n;
        fwp_gc.root_bytes += (double)(hi - lo);
        if (self >= lo && self_end <= hi) {
            fwp_gc_scan(lo, self, 0);
            fwp_gc_scan(self_end, hi, 0);
        } else {
            fwp_gc_scan(lo, hi, 0);
        }
    }
}

/* is the object at `p` marked (or not in the heap)? */
static int fwp_gc_marked(void *p) {
    size_t ci;
    gc_chunk *m = fwp_gc_chunk_of((uintptr_t)p, &ci);
    if (!m) return 1;
    if (m->type == GC_BIG_TAIL) m = &fwp_gc.meta[m->head];
    if (m->type == GC_BIG) return m->mark;
    if (m->type != GC_SMALL) return 0;
    size_t i = (size_t)((uintptr_t)p & (GC_CHUNK - 1)) / m->slot;
    return (m->bits[i >> 6] >> (i & 63)) & 1;
}

/* Call `fn(obj)` when `obj` is found unreachable, before its memory is
 * reused. Finalizers release memory outside the heap (malloc'ed buffers
 * of gRPC connections and streams); they must not allocate. */
static void fwp_gc_finalizer(void *obj, void (*fn)(void *)) {
    if (fwp_gc.nfins == fwp_gc.fins_cap) {
        fwp_gc.fins_cap = fwp_gc.fins_cap ? fwp_gc.fins_cap * 2 : 64;
        fwp_gc.fins = (gc_fin *)realloc(fwp_gc.fins, fwp_gc.fins_cap * sizeof(gc_fin));
        if (!fwp_gc.fins) fwp_gc_oom();
    }
    fwp_gc.fins[fwp_gc.nfins].obj = obj;
    fwp_gc.fins[fwp_gc.nfins].fn = fn;
    fwp_gc.nfins++;
}

static void fwp_gc_finalize(void) {
    for (size_t i = 0; i < fwp_gc.nfins;) {
        gc_fin f = fwp_gc.fins[i];
        if (fwp_gc_marked(f.obj)) { i++; continue; }
        fwp_gc.fins[i] = fwp_gc.fins[--fwp_gc.nfins];
        f.fn(f.obj);
    }
}

/* ----- sweeping */

static void fwp_gc_sweep(void) {
    memset(fwp_gc.lists, 0, sizeof fwp_gc.lists);
    size_t live = 0, nfree = 0;
    for (size_t ci = 0; ci < fwp_gc.top; ci++) {
        gc_chunk *m = &fwp_gc.meta[ci];
        if (m->type == GC_SMALL) {
            size_t n = m->nslots, words = (n + 63) / 64, used = 0;
            for (size_t w = 0; w < words; w++) used += (size_t)__builtin_popcountll(m->bits[w]);
            if (used == 0) {
                m->type = GC_FREE;
                nfree++;
                continue;
            }
            live += used * m->slot;
            gc_list *l = &fwp_gc.lists[m->leaf][m->cls];
            char *p = fwp_gc_chunk_addr(ci);
            for (size_t i = n; i-- > 0;) {
                if (m->bits[i >> 6] & ((uint64_t)1 << (i & 63))) continue;
                char *s = p + i * m->slot;
                /* verifying, stale words of dead objects are cleared: a
                 * conservative full trace would follow them through a free
                 * slot that a stale root marked */
                if (fwp_gc.verify) memset(s, 0, m->slot);
                m->rc[i] = 0;
                *(uintptr_t *)s = ~(uintptr_t)l->free;
                l->free = s;
            }
        } else if (m->type == GC_BIG) {
            size_t k = m->head;
            if (m->mark) {
                live += m->size; /* the mark stays: old */
            } else {
                m->rc[0] = 0;
                for (size_t i = 0; i < k; i++) fwp_gc.meta[ci + i].type = GC_FREE;
                nfree += k;
            }
            ci += k - 1;
        } else if (m->type == GC_FREE) {
            nfree++;
        }
    }
    fwp_gc.live = live;
    fwp_gc.nfree_chunks = nfree;
    fwp_gc.rover = fwp_gc.big_rover = 0;
    /* give the memory of free chunks back beyond a reserve */
    size_t keep = (live > ((size_t)16 << 20) ? live : ((size_t)16 << 20)) >> GC_SHIFT;
    if (nfree > keep) {
        size_t extra = nfree - keep;
        for (size_t ci = fwp_gc.top; ci-- > 0 && extra > 0;) {
            gc_chunk *m = &fwp_gc.meta[ci];
            if (m->type != GC_FREE) continue;
            extra--;
            if (!m->dirty) continue;
            m->dirty = 0;
            size_t run = 1;
            while (ci > 0 && extra > 0 && fwp_gc.meta[ci - 1].type == GC_FREE && fwp_gc.meta[ci - 1].dirty) {
                ci--;
                extra--;
                fwp_gc.meta[ci].dirty = 0;
                run++;
            }
#ifndef FWP_STATIC_MEMORY
            /* static memory keeps its pages: they were given at startup */
            madvise(fwp_gc_chunk_addr(ci), run << GC_SHIFT, MADV_DONTNEED);
#endif
        }
    }
}

/* ----- collection */

/* a stack address below the caller's frame */
static __attribute__((noinline)) char *fwp_gc_sp(void) { return (char *)__builtin_frame_address(0); }

static __attribute__((noinline)) void fwp_gc_mark_all(void) {
    fwp_gc_scan_stacks(fwp_gc_sp());
    fwp_gc_drain();
    fwp_gc_scan_data();
    fwp_gc_drain();
}

static void fwp_gc_clear_marks(void) {
    for (size_t ci = 0; ci < fwp_gc.top; ci++) {
        gc_chunk *m = &fwp_gc.meta[ci];
        if (m->type == GC_SMALL) memset(m->bits, 0, (m->nslots + 63) / 64 * 8);
        else if (m->type == GC_BIG) m->mark = 0;
    }
}

/* a minor collection's extra roots: every old object of kind 2 */
static void fwp_gc_scan_old_filled(void) {
    for (size_t ci = 0; ci < fwp_gc.top; ci++) {
        gc_chunk *m = &fwp_gc.meta[ci];
        if (m->leaf != 2) continue;
        if (m->type == GC_SMALL) {
            char *p = fwp_gc_chunk_addr(ci);
            for (size_t w = 0, words = (m->nslots + 63) / 64; w < words; w++) {
                uint64_t b = m->bits[w];
                while (b) {
                    size_t i = w * 64 + (size_t)__builtin_ctzll(b);
                    b &= b - 1;
                    fwp_gc_push(p + i * m->slot, m->slot);
                }
            }
        } else if (m->type == GC_BIG && m->mark) {
            fwp_gc_push(fwp_gc_chunk_addr(ci), m->size);
        }
    }
    fwp_gc_drain();
}

/* FWP_GC_VERIFY: after a minor collection's marking, trace everything
 * again from scratch; an object reachable then must have been marked */
static void fwp_gc_verify_minor(void) {
    size_t n = fwp_gc.top;
    uint64_t(*saved)[GC_CHUNK / 16 / 64] = malloc(n * sizeof *saved);
    uint8_t *saved_big = malloc(n ? n : 1);
    if (!saved || !saved_big) fwp_gc_oom();
    for (size_t ci = 0; ci < n; ci++) {
        memcpy(saved[ci], fwp_gc.meta[ci].bits, sizeof saved[ci]);
        saved_big[ci] = fwp_gc.meta[ci].mark;
    }
    fwp_gc_clear_marks();
    fwp_gc_mark_all();
    for (size_t ci = 0; ci < n; ci++) {
        gc_chunk *m = &fwp_gc.meta[ci];
        int missed = 0;
        size_t slot = 0;
        if (m->type == GC_SMALL) {
            for (size_t w = 0; w < (m->nslots + 63) / 64 && !missed; w++) {
                uint64_t lost = m->bits[w] & ~saved[ci][w];
                if (lost) {
                    missed = 1;
                    slot = w * 64 + (size_t)__builtin_ctzll(lost);
                }
            }
        } else if (m->type == GC_BIG) {
            missed = m->mark && !saved_big[ci];
        }
        if (missed) {
            char *obj = fwp_gc_chunk_addr(ci) + slot * m->slot;
            size_t len = m->type == GC_SMALL ? m->slot : m->size;
            fprintf(stderr, "fwp gc verify: a minor collection missed the reachable object at %p (kind %d, %zu bytes)\n",
                    (void *)obj, m->leaf, len);
            /* the old objects that point to it */
            for (size_t cj = 0; cj < n; cj++) {
                gc_chunk *o = &fwp_gc.meta[cj];
                if (o->type != GC_SMALL || o->leaf == 1) continue;
                for (size_t k = 0; k < o->nslots; k++) {
                    if (!((saved[cj][k >> 6] >> (k & 63)) & 1)) continue;
                    uintptr_t *w = (uintptr_t *)(fwp_gc_chunk_addr(cj) + k * o->slot);
                    for (size_t j = 0; j < o->slot / 8; j++)
                        if (w[j] >= (uintptr_t)obj && w[j] < (uintptr_t)obj + len)
                            fprintf(stderr, "  from the old object at %p (kind %d, %u bytes), word %zu; its first words %lx %lx %lx\n",
                                    (void *)w, o->leaf, o->slot, j, (unsigned long)w[0], (unsigned long)w[1],
                                    (unsigned long)w[2]);
                }
            }
            abort();
        }
    }
    free(saved);
    free(saved_big);
    /* the full trace's marks stand: they are exact */
}

static __attribute__((noinline)) void fwp_gc_collect(void) {
    if (fwp_gc.collecting) return;
    fwp_gc.collecting = 1;
    struct timespec t0, t1;
    clock_gettime(CLOCK_MONOTONIC, &t0);
    fwp_gc.total_alloc += (double)(fwp_gc.budget_given - fwp_gc.budget);
    int major = !fwp_gc.generational || fwp_gc.major_next;
    if (major) fwp_gc_clear_marks();
    /* the registers, on the stack: the callee-saved ones are spilled by
     * __builtin_unwind_init, the others saved by setjmp */
    jmp_buf regs;
    __builtin_unwind_init();
    setjmp(regs);
    fwp_gc.root_bytes = 0;
    fwp_gc_mark_all();
    if (!major) {
        fwp_gc_scan_old_filled();
        if (fwp_gc.verify) fwp_gc_verify_minor();
    }
    fwp_gc_finalize();
    fwp_gc_sweep();
    fwp_gc.ncollect++;
    if (!major) fwp_gc.nminor++;
    if (fwp_gc.live > fwp_gc.peak) fwp_gc.peak = fwp_gc.live;
    if (major) {
        fwp_gc.live_after_major = fwp_gc.live;
        fwp_gc.major_next = 0;
    } else {
        /* the old generation holds dead objects too, until a major collection */
        size_t limit = fwp_gc.live_after_major + fwp_gc.live_after_major / 2;
        if (limit < ((size_t)16 << 20)) limit = (size_t)16 << 20;
        fwp_gc.major_next = fwp_gc.live > limit;
    }
    /* under stress, a major collection now and then too */
    if (fwp_gc.stress && fwp_gc.ncollect % 8 == 0) fwp_gc.major_next = 1;
    /* minor collections are cheap: they come sooner, which keeps the
     * heap smaller */
    intptr_t b = (fwp_gc.generational ? 1 : 2) * (intptr_t)fwp_gc.live + (intptr_t)fwp_gc.root_bytes;
    fwp_gc.budget = fwp_gc.budget_given = b > GC_MIN_BUDGET ? b : GC_MIN_BUDGET;
    clock_gettime(CLOCK_MONOTONIC, &t1);
    double ms = (double)(t1.tv_sec - t0.tv_sec) * 1e3 + (double)(t1.tv_nsec - t0.tv_nsec) / 1e6;
    fwp_gc.pause_total += ms;
    if (ms > fwp_gc.pause_max) fwp_gc.pause_max = ms;
    fwp_gc.collecting = 0;
}

static long fwp_gc_status_kb(const char *key) {
#ifdef __APPLE__
    struct rusage usage;
    if (strcmp(key, "VmHWM") != 0 || getrusage(RUSAGE_SELF, &usage) != 0) return -1;
    return usage.ru_maxrss / 1024; /* Darwin reports bytes, Linux KiB. */
#else
    FILE *f = fopen("/proc/self/status", "r");
    if (!f) return -1;
    char line[256];
    long kb = -1;
    size_t kl = strlen(key);
    while (fgets(line, sizeof line, f))
        if (!strncmp(line, key, kl) && line[kl] == ':') kb = atol(line + kl + 1);
    fclose(f);
    return kb;
#endif
}

static void fwp_gc_report(void) {
    fwp_gc.total_alloc += (double)(fwp_gc.budget_given - fwp_gc.budget);
    fwp_gc.budget_given = fwp_gc.budget;
    fprintf(stderr,
            "fwp gc: %zu collections (%zu minor), %.1f MiB allocated (%.1f MiB freed by counts), heap %.1f MiB, "
            "live %.1f MiB (peak %.1f), pauses %.1f ms (max %.2f ms), max RSS %ld KiB%s\n",
            fwp_gc.ncollect, fwp_gc.nminor, (fwp_gc.total_alloc + fwp_gc.freed) / 1048576.0,
            fwp_gc.freed / 1048576.0, (double)fwp_gc.heap_bytes / 1048576.0,
            (double)fwp_gc.live / 1048576.0, (double)fwp_gc.peak / 1048576.0, fwp_gc.pause_total,
            fwp_gc.pause_max, fwp_gc_status_kb("VmHWM"), fwp_gc.armed ? "" : " (collection off)");
}

/* called at the top of the main thread: collection may start */
static void fwp_gc_start(void *top) {
    if (!fwp_gc.ready) fwp_gc_init();
    fwp_gc.main_top = (char *)top;
#ifdef __linux__
    dl_iterate_phdr(fwp_gc_find_data, 0);
#elif defined(__APPLE__)
    fwp_gc_find_data();
#endif
#if defined(__linux__) || defined(__APPLE__)
    fwp_gc.armed = fwp_gc.enabled && fwp_gc.ndata > 0;
#endif
    if (fwp_gc.stats) atexit(fwp_gc_report);
#ifdef FWP_STATIC_MEMORY
    const char *mr = getenv("FWP_MEMORY_REPORT");
    if (mr && *mr && strcmp(mr, "0") != 0) atexit(fwp_static_report);
#endif
    if (fwp_gc.armed && fwp_gc.stress) {
        fwp_gc.total_alloc += (double)(fwp_gc.budget_given - fwp_gc.budget);
        fwp_gc.budget = fwp_gc.budget_given = 0;
    }
}

#ifdef FWP_STATIC_MEMORY
/* FWP_MEMORY_REPORT=1: the static memory's parts, and how much of each was
 * used at most */
static void fwp_static_report(void) {
    fprintf(stderr,
            "fwp: static memory: %zu KiB mapped at startup\n"
            "  heap        %8zu KiB, %zu KiB used at most (%zu KiB live at most, %zu collections)\n"
            "  pool        %8zu KiB, %zu KiB used at most\n"
            "  main stack  %8zu KiB\n"
            "  tasks       %d stacks of %zu KiB, %d used at most\n"
            "  threads     %d stacks of %zu KiB\n",
            (size_t)(fwp_static.end - fwp_static.base) >> 10, fwp_static.heap_bytes >> 10,
            (size_t)fwp_gc.heap_bytes >> 10, fwp_gc.peak >> 10, fwp_gc.ncollect, (size_t)FWP_STATIC_POOL >> 10,
            fwp_static.pool_peak >> 10, (size_t)FWP_STATIC_STACK >> 10, FWP_STATIC_TASKS,
            (size_t)FWP_STATIC_TASK_STACK >> 10, fwp_static.tasks_peak, FWP_STATIC_THREADS,
            (size_t)FWP_STATIC_THREAD_STACK >> 10);
}
#endif

#endif /* FWP_GC */

/* Compiled dynamic application consumes the function and its arguments.
 * Runtime callbacks retain the conservative shared entry in fwp_rt.c. */
typedef struct {
    V *items;
    size_t len, cap;
    V local[64];
} fwp_closure_drop_work;
/* WASI has no runtime threads. Native cleanup may enter through a host
 * callback, so its temporary work context is per thread. No safe point
 * or collected allocation occurs while processing this queue. */
#ifdef __wasm__
static fwp_closure_drop_work *fwp_closure_drop_active;
#else
static _Thread_local fwp_closure_drop_work *fwp_closure_drop_active;
#endif

static void fwp_closure_drop_push(fwp_closure_drop_work *work, V f) {
    if (work->len == work->cap) {
        if (work->cap > SIZE_MAX / 2 / sizeof(V)) fwp_trap("closure cleanup too large");
        size_t cap = work->cap * 2;
        /* The spill buffer is explicitly released and never causes GC. */
        V *items = (V *)malloc(cap * sizeof(V));
        if (!items) fwp_trap("out of memory");
        memcpy(items, work->items, work->len * sizeof(V));
        if (work->items != work->local) free(work->items);
        work->items = items;
        work->cap = cap;
    }
    work->items[work->len++] = f;
}

static void fwp_closure_drop(V f) {
    uint8_t *count = fwp_rc_slot(f);
    if (!count || !*count) return;
    if (*count > 1) { (*count)--; return; }
    if (fwp_closure_drop_active) {
        fwp_closure_drop_push(fwp_closure_drop_active, f);
        return;
    }
    fwp_closure_drop_work work;
    work.items = work.local;
    work.len = 0;
    work.cap = sizeof work.local / sizeof *work.local;
    fwp_closure_drop_active = &work;
    fwp_closure_drop_push(&work, f);
    while (work.len) {
        V next = work.items[--work.len];
        const fwp_owned_fninfo *owned = fwp_fns[CLO(next)->fn].owned;
        if (!owned) fwp_trap("internal: owned closure without capture types");
        owned->captures(next, 0);
    }
    fwp_closure_drop_active = NULL;
    if (work.items != work.local) free(work.items);
}

static V fwp_apply_owned(V f, uint32_t n, V *args) {
    for (;;) {
        fwp_clo *c = CLO(f);
        const fwp_fninfo *fi = &fwp_fns[c->fn];
        if (!fi->owned) {
            fwp_rc_share(f);
            for (uint32_t i = 0; i < n; i++) fwp_rc_share(args[i]);
            return fwp_apply(f, n, args);
        }
        uint32_t ar = fi->arity, have = c->n;
        if (have + n < ar) {
            fwp_clo *r = (fwp_clo *)fwp_alloc_init(sizeof(fwp_clo) + (have + n) * sizeof(V));
            r->fn = c->fn;
            r->n = have + n;
            for (uint32_t i = 0; i < have; i++) r->a[i] = c->a[i];
            for (uint32_t i = 0; i < n; i++) r->a[have + i] = args[i];
            fi->owned->captures(f, 1);
            V result = fwp_rc_fresh(PTR(r));
            FWP_KEEP_ALIVE(f);
            FWP_KEEP_ALIVE(args);
            fwp_closure_drop(f);
            return result;
        }
        uint32_t need = ar - have;
        V result;
        if (!have && ar) {
            result = fi->owned->entry(args);
        } else {
            V all[ar ? ar : 1];
            for (uint32_t i = 0; i < have; i++) all[i] = c->a[i];
            for (uint32_t i = 0; i < need; i++) all[have + i] = args[i];
            fi->owned->captures(f, 1);
            result = fi->owned->entry(all);
        }
        FWP_KEEP_ALIVE(f);
        FWP_KEEP_ALIVE(args);
        fwp_closure_drop(f);
        if (n == need) return result;
        f = result;
        args += need;
        n -= need;
    }
}
