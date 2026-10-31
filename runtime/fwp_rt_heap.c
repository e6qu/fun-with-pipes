/* Counted storage. Native targets use a reserved region split into 64 KiB
 * chunks and size-class slots. WebAssembly uses calloc and a side table for
 * counts. Typed owners release values; neither allocator discovers roots or
 * traces object contents. Library shutdown disposes remaining runtime resources
 * before unmapping its region. */

#if defined(__wasi__) || defined(__wasm__)
#define FWP_NATIVE_HEAP 0
#else
#define FWP_NATIVE_HEAP 1
#endif


#if !FWP_NATIVE_HEAP

static void *fwp_alloc(size_t n) {
    void *p = calloc(1, n ? n : 1);
    if (!p) {
        fprintf(stderr, "fwp: out of memory\n");
        exit(102);
    }
    return p;
}

static void *fwp_alloc_leaf(size_t n) { return fwp_alloc(n); }
static void *fwp_alloc_unique(size_t n) { return fwp_alloc(n); }
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
static void fwp_heap_start(void) {}
static void fwp_heap_finalizer(void *obj, void (*fn)(void *)) { (void)obj; (void)fn; }
static void fwp_heap_forget_finalizer(void *obj) { (void)obj; }
/* Entries track live counted owners; value layouts and reuse stay unchanged.
 * No counter operation reads arbitrary value words as allocation headers. */
#define FWP_WASM_RC_BUCKETS 4096
typedef struct fwp_wasm_rc {
    V value;
    uint64_t count;
    struct fwp_wasm_rc *next;
    uint8_t slot;
} fwp_wasm_rc;
static fwp_wasm_rc *fwp_wasm_counts[FWP_WASM_RC_BUCKETS];
static size_t fwp_wasm_counts_live;
static fwp_wasm_rc **fwp_wasm_count_link(V value) {
    uintptr_t hash = (uintptr_t)value >> 4;
    hash ^= hash >> 13;
    fwp_wasm_rc **link = &fwp_wasm_counts[hash & (FWP_WASM_RC_BUCKETS - 1)];
    while (*link && (*link)->value != value) link = &(*link)->next;
    return link;
}
static uint64_t fwp_wasm_count(fwp_wasm_rc *entry) {
    /* Runtime code can clear/read the compact slot just as on native targets. */
    if (entry->slot != 255) entry->count = entry->slot;
    return entry->count;
}
static void fwp_wasm_set_count(fwp_wasm_rc *entry, uint64_t count) {
    entry->count = count;
    entry->slot = count < 255 ? (uint8_t)count : 255;
}
static inline uint8_t *fwp_rc_slot(V value) {
    if (value < 4096) return NULL;
    fwp_wasm_rc *entry = *fwp_wasm_count_link(value);
    return entry ? &entry->slot : NULL;
}
static inline V fwp_rc_fresh(V value) {
    if (value < 4096) return value;
    fwp_wasm_rc **link = fwp_wasm_count_link(value);
    if (!*link) {
        fwp_wasm_rc *entry = (fwp_wasm_rc *)malloc(sizeof *entry);
        if (!entry) { fprintf(stderr, "fwp: out of memory\n"); exit(102); }
        entry->value = value; entry->next = NULL;
        *link = entry; fwp_wasm_counts_live++;
    }
    fwp_wasm_set_count(*link, 1);
    return value;
}
static inline void fwp_rc_dup(V value) {
    fwp_wasm_rc *entry = *fwp_wasm_count_link(value);
    if (!entry) return;
    uint64_t count = fwp_wasm_count(entry);
    if (!count) return;
    if (count == UINT64_MAX) fwp_trap("reference count overflow");
    fwp_wasm_set_count(entry, count + 1);
}
static inline void fwp_rc_drop(V value) {
    fwp_wasm_rc *entry = *fwp_wasm_count_link(value);
    if (entry && fwp_wasm_count(entry) > 1) fwp_wasm_set_count(entry, entry->count - 1);
}
static void fwp_wasm_forget_count(V value) {
    fwp_wasm_rc **link = fwp_wasm_count_link(value);
    if (*link) {
        fwp_wasm_rc *entry = *link; *link = entry->next;
        free(entry); fwp_wasm_counts_live--;
    }
}
static inline void fwp_rc_share(V value) {
    fwp_wasm_rc *entry = *fwp_wasm_count_link(value);
    if (entry && fwp_wasm_count(entry))
        fwp_trap("internal: counted owner escaped ARC contract");
    fwp_wasm_forget_count(value);
}
static inline int fwp_rc_last(V value) {
    fwp_wasm_rc *entry = *fwp_wasm_count_link(value);
    return entry && fwp_wasm_count(entry) == 1;
}
static inline int fwp_rc_release_last(V value) {
    fwp_wasm_rc *entry = *fwp_wasm_count_link(value);
    if (!entry || !fwp_wasm_count(entry)) return 0;
    if (entry->count == 1) return 1;
    fwp_wasm_set_count(entry, entry->count - 1); return 0;
}
/* Only typed last-owner destruction reaches this path. Stack objects and
 * shared runtime graphs have no count entry and cannot be freed here. Remove
 * metadata before storage reuse so a recycled address never inherits owners. */
static inline void fwp_rc_free_obj(V value) {
    if (!fwp_rc_last(value)) return;
    fwp_wasm_forget_count(value);
#ifndef FWP_RESOURCE_NO_FREE
    free((void *)(uintptr_t)value);
#endif
}
static inline void fwp_rc_free_arr(V value) { fwp_rc_free_obj(value); }
static inline V fwp_rc_shared(V value) { fwp_rc_share(value); return value; }
static inline int fwp_rc_unique(V value) { (void)value; return 0; }
static inline int fwp_rc_unique_mut(V value) { (void)value; return 0; }
static inline size_t fwp_rc_capacity(V value) { (void)value; return 0; }

#else /* FWP_NATIVE_HEAP */

#ifdef _WIN32
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#include <windows.h>
#define PSAPI_VERSION 2
#include <psapi.h>
#else
#include <sys/mman.h>
#include <unistd.h>
#endif
#ifdef __APPLE__
#include <sys/resource.h>
#endif

#define HEAP_SHIFT 16
#define HEAP_CHUNK ((size_t)1 << HEAP_SHIFT)
#define HEAP_NCLS 40
#define HEAP_MAX_SMALL 16384
#define HEAP_COMMIT_STEP 64 /* chunks committed at a time */

enum { HEAP_FREE = 0, HEAP_SMALL, HEAP_BIG, HEAP_BIG_TAIL };
enum { HEAP_UNIQUE = 3, HEAP_KINDS = 4 };

typedef struct {
    uint8_t type, leaf, cls;       /* allocation kind; HEAP_UNIQUE has no counts */
    uint32_t slot, nslots;
    uint32_t head;                 /* big: number of chunks; tail: its head */
    size_t size;                   /* big: bytes */
    uint32_t recip;                /* small: 2^32 / slot, rounded up */
    uint32_t rc_len;
    uint8_t *rc;                   /* counted slots only; null for unique storage */
} heap_chunk;

typedef struct { char *free, *bump, *end; } heap_list;
typedef struct { void *obj; void (*fn)(void *); } heap_fin;
typedef struct heap_rc_wide {
    uint8_t *slot; /* metadata address, never a language value/root */
    size_t count;
    struct heap_rc_wide *next;
} heap_rc_wide;

static struct {
    heap_list lists[HEAP_KINDS][HEAP_NCLS]; /* [allocation kind][size class] */
    uint32_t slot[HEAP_NCLS];
    uint8_t cls_of[HEAP_MAX_SMALL / 16 + 1];
    int ready, stats;
    char *base;
    void *reservation;
    size_t reservation_bytes;
    uintptr_t heap_bytes; /* high-water chunk extent, not live payload bytes */
    size_t nchunks, top, committed, rover, big_rover;
    heap_chunk *meta;
    size_t meta_bytes;
    heap_fin *fins;
    size_t nfins, fins_cap;
    size_t live, peak, nfree_chunks;
    double total_alloc, freed;
    heap_rc_wide *rc_wide[256];
    size_t rc_wide_len, rc_bytes;
} fwp_heap;

static void fwp_heap_oom(void) {
    fprintf(stderr, "fwp: out of memory\n");
    fflush(NULL); _Exit(102);
}

/* 0 has no counted owner; 1..254 are inline; 255 denotes an exact wide count.
 * Side entries live outside the value heap and use stable metadata keys. */
static heap_rc_wide **fwp_rc_wide_link(uint8_t *slot) {
    uintptr_t hash = (uintptr_t)slot;
    hash ^= hash >> 17;
    hash ^= hash >> 9;
    heap_rc_wide **link = &fwp_heap.rc_wide[hash & 255];
    while (*link && (*link)->slot != slot) link = &(*link)->next;
    return link;
}
static void fwp_rc_forget_slot(uint8_t *slot) {
    if (*slot != 255) return;
    heap_rc_wide **link = fwp_rc_wide_link(slot);
    if (!*link) fwp_trap("internal: missing wide reference count");
    heap_rc_wide *entry = *link;
    *link = entry->next;
    free(entry);
    fwp_heap.rc_wide_len--;
}
static inline void fwp_rc_clear_slot(uint8_t *slot) {
    if (__builtin_expect(*slot == 255, 0)) fwp_rc_forget_slot(slot);
    *slot = 0;
}
/* Count arrays have stable addresses while any slot can hold a live owner.
 * Unique chunks reserve no count slots, including when a free counted chunk
 * is reused. These bytes are allocator metadata, not language-value storage. */
static void fwp_rc_prepare_chunk(heap_chunk *chunk, size_t slots) {
    if (fwp_heap.rc_wide_len)
        for (size_t i = 0; i < chunk->rc_len; i++)
            if (chunk->rc[i] == 255) fwp_rc_forget_slot(&chunk->rc[i]);
    if (chunk->rc_len != slots) {
        fwp_heap.rc_bytes -= chunk->rc_len;
        free(chunk->rc);
        chunk->rc = slots ? (uint8_t *)calloc(slots, 1) : NULL;
        if (slots && !chunk->rc) fwp_heap_oom();
        chunk->rc_len = (uint32_t)slots;
        fwp_heap.rc_bytes += slots;
    } else if (slots) {
        memset(chunk->rc, 0, slots);
    }
}
static void fwp_rc_wide_dup(uint8_t *slot) {
    heap_rc_wide **link = fwp_rc_wide_link(slot);
    if (*slot == 254) {
        if (*link) fwp_trap("internal: stale wide reference count");
        heap_rc_wide *entry = (heap_rc_wide *)malloc(sizeof *entry);
        if (!entry) fwp_heap_oom();
        entry->slot = slot;
        entry->count = 255;
        entry->next = NULL;
        *link = entry;
        *slot = 255;
        fwp_heap.rc_wide_len++;
    } else {
        if (!*link) fwp_trap("internal: missing wide reference count");
        if ((*link)->count == SIZE_MAX) fwp_trap("reference count overflow");
        (*link)->count++;
    }
}
static void fwp_rc_wide_drop(uint8_t *slot) {
    heap_rc_wide **link = fwp_rc_wide_link(slot);
    if (!*link) fwp_trap("internal: missing wide reference count");
    if (--(*link)->count == 254) {
        fwp_rc_forget_slot(slot);
        *slot = 254;
    }
}
static inline void fwp_rc_drop_slot(uint8_t *slot) {
    if (__builtin_expect(*slot == 255, 0)) fwp_rc_wide_drop(slot);
    else if (*slot > 1) (*slot)--;
}

static void *fwp_heap_reserve(size_t *bytes) {
    for (size_t n = *bytes; n >= ((size_t)256 << 20); n /= 4) {
#ifdef _WIN32
        void *p = VirtualAlloc(NULL, n + HEAP_CHUNK, MEM_RESERVE, PAGE_NOACCESS);
        if (p) {
#else
        void *p = mmap(0, n + HEAP_CHUNK, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
        if (p != MAP_FAILED) {
#endif
            *bytes = n;
            return p;
        }
    }
    return 0;
}

static void fwp_heap_init(void) {
    fwp_heap.ready = 1;
    /* size classes: 16-byte steps up to 256, then four per doubling */
    int c = 0;
    for (uint32_t s = 16; s <= 256; s += 16) fwp_heap.slot[c++] = s;
    for (uint32_t b = 256; b < HEAP_MAX_SMALL; b *= 2)
        for (uint32_t k = 1; k <= 4; k++) fwp_heap.slot[c++] = b + b / 4 * k;
    for (size_t i = 0, k = 0; i <= HEAP_MAX_SMALL / 16; i++) {
        while (fwp_heap.slot[k] < i * 16) k++;
        fwp_heap.cls_of[i] = (uint8_t)k;
    }
#ifdef FWP_STATIC_MEMORY
    /* the heap and its metadata were mapped with the rest of the static
     * memory (runtime/fwp_rt_static.c), all of it usable */
    fwp_static_init();
    fwp_heap.base = fwp_static.heap;
    fwp_heap.nchunks = fwp_static.heap_bytes >> HEAP_SHIFT;
    fwp_heap.meta_bytes = fwp_static.meta_bytes;
    fwp_heap.meta = (heap_chunk *)fwp_static.meta;
    fwp_heap.committed = fwp_heap.nchunks;
#else
    size_t bytes = sizeof(void *) == 8 ? (size_t)1 << 36 : (size_t)1 << 30;
    char *r = (char *)fwp_heap_reserve(&bytes);
    if (!r) fwp_heap_oom();
    fwp_heap.reservation = r;
    fwp_heap.reservation_bytes = bytes + HEAP_CHUNK;
    fwp_heap.base = (char *)(((uintptr_t)r + HEAP_CHUNK - 1) & ~(uintptr_t)(HEAP_CHUNK - 1));
    fwp_heap.nchunks = bytes >> HEAP_SHIFT;
    fwp_heap.meta_bytes = fwp_heap.nchunks * sizeof(heap_chunk);
#ifdef _WIN32
    void *m = VirtualAlloc(NULL, fwp_heap.meta_bytes, MEM_RESERVE, PAGE_NOACCESS);
    if (!m) fwp_heap_oom();
#else
    void *m = mmap(0, fwp_heap.meta_bytes, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
    if (m == MAP_FAILED) fwp_heap_oom();
#endif
    fwp_heap.meta = (heap_chunk *)m;
#endif
    const char *e = getenv("FWP_ALLOC_STATS");
    fwp_heap.stats = e && *e && strcmp(e, "0") != 0;
}

#ifdef FWP_STATIC_MEMORY
static size_t fwp_static_meta_bytes(size_t heap) { return (heap >> HEAP_SHIFT) * sizeof(heap_chunk); }
#endif

/* commit chunks up to `top` */
static void fwp_heap_commit(size_t top) {
    if (top <= fwp_heap.committed) return;
#ifdef FWP_STATIC_MEMORY
    fwp_static_full("heap", fwp_static.heap_bytes, "--heap");
#endif
    if (top > fwp_heap.nchunks) fwp_heap_oom();
    size_t to = top + HEAP_COMMIT_STEP;
    if (to > fwp_heap.nchunks) to = fwp_heap.nchunks;
#ifdef _WIN32
    if (!VirtualAlloc(fwp_heap.base + (fwp_heap.committed << HEAP_SHIFT),
                      (to - fwp_heap.committed) << HEAP_SHIFT, MEM_COMMIT, PAGE_READWRITE)) fwp_heap_oom();
    SYSTEM_INFO info;
    GetSystemInfo(&info);
    size_t pg = info.dwPageSize;
#else
    if (mprotect(fwp_heap.base + (fwp_heap.committed << HEAP_SHIFT), (to - fwp_heap.committed) << HEAP_SHIFT,
                 PROT_READ | PROT_WRITE) != 0)
        fwp_heap_oom();
    size_t pg = (size_t)sysconf(_SC_PAGESIZE);
#endif
    uintptr_t lo = (uintptr_t)(fwp_heap.meta + fwp_heap.committed) & ~(uintptr_t)(pg - 1);
    uintptr_t hi = ((uintptr_t)(fwp_heap.meta + to) + pg - 1) & ~(uintptr_t)(pg - 1);
#ifdef _WIN32
    if (!VirtualAlloc((void *)lo, hi - lo, MEM_COMMIT, PAGE_READWRITE)) fwp_heap_oom();
#else
    if (mprotect((void *)lo, hi - lo, PROT_READ | PROT_WRITE) != 0) fwp_heap_oom();
#endif
    fwp_heap.committed = to;
}

static inline char *fwp_heap_chunk_addr(size_t ci) { return fwp_heap.base + (ci << HEAP_SHIFT); }

/* `k` free chunks in a row, or SIZE_MAX when a bounded heap has no run. */
static size_t fwp_heap_chunks(size_t k) {
    size_t *rover = k == 1 ? &fwp_heap.rover : &fwp_heap.big_rover;
    size_t run = 0;
    for (size_t i = *rover; i < fwp_heap.top; i++) {
        if (fwp_heap.meta[i].type != HEAP_FREE) { run = 0; continue; }
        if (++run == k) {
            *rover = i + 1;
            fwp_heap.nfree_chunks -= k;
            return i + 1 - k;
        }
    }
    /* a free run ending at the top grows into fresh chunks */
    size_t first = fwp_heap.top - run;
#ifdef FWP_STATIC_MEMORY
    if (first + k > fwp_heap.nchunks) return SIZE_MAX;
#endif
    fwp_heap.nfree_chunks -= run;
    fwp_heap_commit(first + k);
    fwp_heap.top = first + k;
    if (fwp_heap.top << HEAP_SHIFT > fwp_heap.heap_bytes) fwp_heap.heap_bytes = fwp_heap.top << HEAP_SHIFT;
    return first;
}

/* Charge physical slot bytes, or requested bytes for a large allocation.
 * This measures live storage independently from the test-only address ledger. */
static inline void fwp_heap_charge(size_t bytes) {
    if (bytes > SIZE_MAX - fwp_heap.live) fwp_heap_oom();
    fwp_heap.live += bytes;
    if (fwp_heap.live > fwp_heap.peak) fwp_heap.peak = fwp_heap.live;
    fwp_heap.total_alloc += (double)bytes;
}

static __attribute__((noinline)) void *fwp_heap_alloc_big(size_t n, int leaf) {
    if (n > ((size_t)1 << 62)) fwp_heap_oom();
    size_t k = (n + HEAP_CHUNK - 1) >> HEAP_SHIFT;
    size_t ci = fwp_heap_chunks(k);
#ifdef FWP_STATIC_MEMORY
    if (ci == SIZE_MAX) fwp_static_full("heap", fwp_static.heap_bytes, "--heap");
#endif
    heap_chunk *m = &fwp_heap.meta[ci];
    m->type = HEAP_BIG;
    m->leaf = (uint8_t)leaf;
    m->head = (uint32_t)k;
    m->size = n;
    fwp_rc_prepare_chunk(m, leaf == HEAP_UNIQUE ? 0 : 1);
    for (size_t i = 1; i < k; i++) {
        heap_chunk *t = &fwp_heap.meta[ci + i];
        fwp_rc_prepare_chunk(t, 0);
        t->type = HEAP_BIG_TAIL;
        t->head = (uint32_t)ci;
    }
    char *p = fwp_heap_chunk_addr(ci);
    memset(p, 0, n);
    fwp_heap_charge(n);
    return p;
}

/* the free list and the bump space of a class are empty: a new chunk */
static __attribute__((noinline)) char *fwp_heap_refill(heap_list *l, unsigned c, int leaf) {
    size_t ci = fwp_heap_chunks(1);
#ifdef FWP_STATIC_MEMORY
    if (ci == SIZE_MAX) fwp_static_full("heap", fwp_static.heap_bytes, "--heap");
#endif
    heap_chunk *m = &fwp_heap.meta[ci];
    m->type = HEAP_SMALL;
    m->leaf = (uint8_t)leaf;
    m->cls = (uint8_t)c;
    m->slot = fwp_heap.slot[c];
    m->nslots = (uint32_t)(HEAP_CHUNK / m->slot);
    m->recip = (uint32_t)((((uint64_t)1 << 32) + m->slot - 1) / m->slot);
    fwp_rc_prepare_chunk(m, leaf == HEAP_UNIQUE ? 0 : m->nslots);
    char *p = fwp_heap_chunk_addr(ci);
    l->bump = p + m->slot;
    l->end = p + (size_t)m->nslots * m->slot;
    return p;
}

static __attribute__((noinline)) void *fwp_heap_alloc_slow(size_t n, int kind) {
    if (!fwp_heap.ready) fwp_heap_init();
    if (n > HEAP_MAX_SMALL) return fwp_heap_alloc_big(n, kind);
    unsigned c = fwp_heap.cls_of[(n + 15) >> 4];
    size_t sz = fwp_heap.slot[c];
    heap_list *l = &fwp_heap.lists[kind][c];
    char *p = l->free;
    if (p) l->free = (char *)~*(uintptr_t *)p;
    else if (l->bump && (size_t)(l->end - l->bump) >= sz) { p = l->bump; l->bump += sz; }
    else p = fwp_heap_refill(l, c, kind);
    memset(p, 0, (kind == 1 || kind == HEAP_UNIQUE) ? n : sz);
    fwp_heap_charge(sz);
    return p;
}

static inline void *fwp_heap_alloc(size_t n, int kind) {
    if (__builtin_expect(fwp_heap.ready && n <= HEAP_MAX_SMALL, 1)) {
        unsigned c = fwp_heap.cls_of[(n + 15) >> 4];
        size_t sz = fwp_heap.slot[c];
        heap_list *l = &fwp_heap.lists[kind][c];
        char *p = l->free;
        if (p) {
            l->free = (char *)~*(uintptr_t *)p;
            memset(p, 0, (kind == 1 || kind == HEAP_UNIQUE) ? n : sz);
            fwp_heap_charge(sz);
            return p;
        }
        if (l->bump && (size_t)(l->end - l->bump) >= sz) {
            p = l->bump;
            l->bump += sz;
            memset(p, 0, (kind == 1 || kind == HEAP_UNIQUE) ? n : sz);
            fwp_heap_charge(sz);
            return p;
        }
    }
    return fwp_heap_alloc_slow(n, kind);
}

/* Zeroed mutable runtime storage. */
static inline void *fwp_alloc(size_t n) { return fwp_heap_alloc(n, 2); }
/* The caller initializes the first n bytes before publishing the value. */
static inline void *fwp_alloc_init(size_t n) {
    if (__builtin_expect(fwp_heap.ready && n <= HEAP_MAX_SMALL, 1)) {
        unsigned c = fwp_heap.cls_of[(n + 15) >> 4];
        size_t sz = fwp_heap.slot[c];
        heap_list *l = &fwp_heap.lists[0][c];
        char *p = l->free;
        if (p) l->free = (char *)~*(uintptr_t *)p;
        else if (l->bump && (size_t)(l->end - l->bump) >= sz) { p = l->bump; l->bump += sz; }
        if (p) {
            for (size_t i = n & ~(size_t)7; i < sz; i += 8) *(uint64_t *)(p + i) = 0;
            fwp_heap_charge(sz);
            return p;
        }
    }
    return fwp_heap_alloc(n, 0);
}
/* Zeroed bytes/numbers; unused slot padding need not be initialized. */
static inline void *fwp_alloc_leaf(size_t n) { return fwp_heap_alloc(n, 1); }
/* Compiler-proved unique storage; destruction uses fwp_mem_free directly. */
static inline void *fwp_alloc_unique(size_t n) { return fwp_heap_alloc(n, HEAP_UNIQUE); }

/* the chunk of a heap address, or 0 */
static inline heap_chunk *fwp_heap_chunk_of(uintptr_t a, size_t *ci) {
    uintptr_t off = a - (uintptr_t)fwp_heap.base;
    if (off >= fwp_heap.top << HEAP_SHIFT) return 0;
    *ci = off >> HEAP_SHIFT;
    return &fwp_heap.meta[*ci];
}

/* Give back an object nothing else refers to (runtime memory only). */
static void fwp_mem_free(void *p) {
    size_t ci;
    heap_chunk *m = p ? fwp_heap_chunk_of((uintptr_t)p, &ci) : 0;
    if (!m) return;
    if (m->type == HEAP_SMALL) {
        heap_list *l = &fwp_heap.lists[m->leaf][m->cls];
        size_t i = (size_t)((uintptr_t)p & (HEAP_CHUNK - 1)) / m->slot;
        if (m->rc) fwp_rc_clear_slot(&m->rc[i]);
        *(uintptr_t *)p = ~(uintptr_t)l->free;
        l->free = (char *)p;
        fwp_heap.live -= m->slot;
        fwp_heap.freed += (double)m->slot;
    } else if (m->type == HEAP_BIG && (char *)p == fwp_heap_chunk_addr(ci)) {
        fwp_heap.live -= m->size;
        fwp_heap.freed += (double)m->size;
        if (m->rc) fwp_rc_clear_slot(&m->rc[0]);
        size_t k = m->head;
        for (size_t i = 0; i < k; i++) fwp_heap.meta[ci + i].type = HEAP_FREE;
        fwp_heap.nfree_chunks += k;
        if (ci < fwp_heap.big_rover) fwp_heap.big_rover = ci;
        if (ci < fwp_heap.rover) fwp_heap.rover = ci;
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

/* Typed reference counts identify the last owner and permit unique reuse.
 * Zero denotes storage with a separate runtime owner or unmanaged storage;
 * erasing a live counted owner at an unknown boundary is an internal error. */

/* The count of a small allocation (including pointer-free leaves), or
 * of the start of a big allocation. An unmanaged pointer has no count. */
static inline uint8_t *fwp_rc_slot(V v) {
    uintptr_t off = (uintptr_t)v - (uintptr_t)fwp_heap.base;
    if (off >= fwp_heap.top << HEAP_SHIFT) return 0;
    heap_chunk *m = &fwp_heap.meta[off >> HEAP_SHIFT];
    if (!m->rc) return 0;
    if (m->type == HEAP_BIG && (off & (HEAP_CHUNK - 1)) == 0) return &m->rc[0];
    if (m->type != HEAP_SMALL) return 0;
    /* (a word pointing inside an object counts for that object: only too
     * high, never too low, as words are only dropped through values) */
    size_t i = (size_t)(((uint64_t)(off & (HEAP_CHUNK - 1)) * m->recip) >> 32);
    if (i >= m->rc_len) return 0; /* unused trailing bytes are not an allocation */
    return &m->rc[i];
}

static inline V fwp_rc_fresh(V v) {
    uint8_t *c = fwp_rc_slot(v);
    if (c) {
        if (__builtin_expect(*c == 255, 0)) fwp_rc_forget_slot(c);
        *c = 1;
    }
    return v;
}

/* ARC keeps the ownership-contract check, but not a copy in every generic
 * function entry. Native ARM64/AMD64 measurements show smaller code; this
 * changes code placement, not which values may cross an uncounted boundary. */
static __attribute__((noinline)) void fwp_rc_share(V v);

static inline void fwp_rc_dup(V v) {
    uint8_t *c = fwp_rc_slot(v);
    if (c && *c) {
        if (__builtin_expect(*c >= 254, 0)) fwp_rc_wide_dup(c);
        else (*c)++;
    }
}
static inline void fwp_rc_drop(V v) {
    uint8_t *c = fwp_rc_slot(v);
    if (c && *c > 1) fwp_rc_drop_slot(c);
}
/* Typed destruction consumes one reference; the last reference's fields
 * and storage are then released by its generated type-specific caller. */
static inline int fwp_rc_release_last(V v) {
    uint8_t *c = fwp_rc_slot(v);
    if (!c || !*c) return 0;
    if (*c == 1) return 1;
    fwp_rc_drop_slot(c);
    return 0;
}

/* An unknown ownership boundary may receive only uncounted storage. */
static void fwp_rc_share(V v) {
    uint8_t *c = fwp_rc_slot(v);
    if (c && *c) fwp_trap("internal: counted owner escaped ARC contract");
}

/* Validate an uncounted boundary and return its value unchanged. */
static inline V fwp_rc_shared(V v) {
    fwp_rc_share(v);
    return v;
}


/* One owner permits destructive reuse; FWP_NO_REUSE is a test control. */
static inline int fwp_rc_unique(V v) {
#ifdef FWP_NO_REUSE
    (void)v; return 0;
#endif

    uint8_t *c = fwp_rc_slot(v);
    if (!c || *c != 1) return 0;
    return 1;
}

/* Mutable containers use the same last-owner condition. */
static inline int fwp_rc_unique_mut(V v) {
#ifdef FWP_NO_REUSE
    (void)v; return 0;
#endif

    uint8_t *c = fwp_rc_slot(v);
    if (!c || *c != 1) return 0;
    return 1;
}

/* whether `v` has one reference, which is being given up: the references
 * it holds go too (a count that is only too high stays so) */
static inline int fwp_rc_last(V v) {
    uint8_t *c = fwp_rc_slot(v);
    return c && *c == 1;
}

/* Typed child cleanup has already completed before physical release. */
static void fwp_rc_free_obj(V v) {
    if (fwp_rc_last(v)) fwp_mem_free((void *)(uintptr_t)v);
}
static void fwp_rc_free_arr(V v) {
    if (fwp_rc_last(v)) fwp_mem_free((void *)(uintptr_t)v);
}

/* the bytes usable from `v`, the start of a small object of kind 2 or of
 * a big one (its slot or chunks), or 0 */
static inline size_t fwp_rc_capacity(V v) {
    uintptr_t off = (uintptr_t)v - (uintptr_t)fwp_heap.base;
    if (off >= fwp_heap.top << HEAP_SHIFT) return 0;
    heap_chunk *m = &fwp_heap.meta[off >> HEAP_SHIFT];
    if (m->type == HEAP_BIG && (off & (HEAP_CHUNK - 1)) == 0) return m->size;
    if (m->type == HEAP_SMALL && m->leaf == 2 && (off & (HEAP_CHUNK - 1)) % m->slot == 0) return m->slot;
    return 0;
}

/* Register external-resource cleanup for library shutdown. Explicit release
 * removes the registration before its object storage can be reused. */
static void fwp_heap_finalizer(void *obj, void (*fn)(void *)) {
    if (fwp_heap.nfins == fwp_heap.fins_cap) {
        if (fwp_heap.fins_cap > SIZE_MAX / sizeof(heap_fin) / 2) fwp_heap_oom();
        size_t cap = fwp_heap.fins_cap ? fwp_heap.fins_cap * 2 : 64;
        heap_fin *fins = (heap_fin *)realloc(fwp_heap.fins, cap * sizeof(heap_fin));
        if (!fins) fwp_heap_oom();
        /* Commit growth only after allocation succeeds. */
        fwp_heap.fins = fins;
        fwp_heap.fins_cap = cap;
    }
    fwp_heap.fins[fwp_heap.nfins].obj = obj;
    fwp_heap.fins[fwp_heap.nfins].fn = fn;
    fwp_heap.nfins++;
}

/* Explicit destruction must remove weak finalizer registrations before storage
 * reuse. No allocation or callback occurs during removal. */
static void fwp_heap_forget_finalizer(void *obj) {
    for (size_t i = 0; i < fwp_heap.nfins;) {
        if (fwp_heap.fins[i].obj == obj)
            fwp_heap.fins[i] = fwp_heap.fins[--fwp_heap.nfins];
        else i++;
    }
}


#ifdef FWP_LIBRARY
/* The host has finished its calls and the scheduler has drained. Finalizers
 * still see live objects; only then give up the complete loaded-program region,
 * including shared graphs and wide-count metadata. No host roots are traced. */
static void fwp_heap_finish(void) {
    if (!fwp_heap.ready) return;
    while (fwp_heap.nfins) {
        heap_fin f = fwp_heap.fins[--fwp_heap.nfins];
        f.fn(f.obj);
    }
    free(fwp_heap.fins);
    for (size_t i = 0; i < fwp_heap.top; i++) free(fwp_heap.meta[i].rc);
    for (size_t i = 0; i < 256; i++) {
        heap_rc_wide *entry = fwp_heap.rc_wide[i];
        while (entry) {
            heap_rc_wide *next = entry->next;
            free(entry);
            entry = next;
        }
    }
#ifndef FWP_STATIC_MEMORY
#ifdef _WIN32
    if (fwp_heap.meta) VirtualFree(fwp_heap.meta, 0, MEM_RELEASE);
    if (fwp_heap.reservation) VirtualFree(fwp_heap.reservation, 0, MEM_RELEASE);
#else
    if (fwp_heap.meta) munmap(fwp_heap.meta, fwp_heap.meta_bytes);
    if (fwp_heap.reservation) munmap(fwp_heap.reservation, fwp_heap.reservation_bytes);
#endif
#endif
    memset(&fwp_heap, 0, sizeof fwp_heap);
}
#endif

static long fwp_heap_status_kb(const char *key) {
#ifdef _WIN32
    PROCESS_MEMORY_COUNTERS memory = {0};
    if (strcmp(key, "VmHWM") != 0 || !GetProcessMemoryInfo(GetCurrentProcess(), &memory, sizeof memory)) return -1;
    return (long)(memory.PeakWorkingSetSize / 1024);
#elif defined(__APPLE__)
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

static void fwp_heap_report(void) {
    fprintf(stderr,
            "fwp allocation: %.0f bytes allocated, %.0f bytes released, "
            "%zu live bytes, %zu peak live bytes, %zu heap extent bytes, max RSS %ld KiB\n",
            fwp_heap.total_alloc, fwp_heap.freed, fwp_heap.live, fwp_heap.peak,
            (size_t)fwp_heap.heap_bytes, fwp_heap_status_kb("VmHWM"));
}

static void fwp_heap_start(void) {
    if (!fwp_heap.ready) fwp_heap_init();
    if (fwp_heap.stats) atexit(fwp_heap_report);
#ifdef FWP_STATIC_MEMORY
    const char *mr = getenv("FWP_MEMORY_REPORT");
    if (mr && *mr && strcmp(mr, "0") != 0) atexit(fwp_static_report);
#endif
}

#ifdef FWP_STATIC_MEMORY
/* FWP_MEMORY_REPORT=1: the static memory's parts, and how much of each was
 * used at most */
static void fwp_static_report(void) {
    fprintf(stderr,
#ifdef _WIN32
            "fwp: static memory: %zu KiB runtime storage mapped at startup; stacks committed separately\n"
#else
            "fwp: static memory: %zu KiB mapped at startup\n"
#endif
            "  heap        %8zu KiB, %zu KiB used at most (%zu KiB live at most)\n"
            "  pool        %8zu KiB, %zu KiB used at most\n"
            "  main stack  %8zu KiB\n"
            "  tasks       %d stacks of %zu KiB, %d used at most\n"
            "  threads     %d stacks of %zu KiB\n",
            (size_t)(fwp_static.end - fwp_static.base) >> 10, fwp_static.heap_bytes >> 10,
            (size_t)fwp_heap.heap_bytes >> 10, fwp_heap.peak >> 10, (size_t)FWP_STATIC_POOL >> 10,
            fwp_static.pool_peak >> 10, (size_t)FWP_STATIC_STACK >> 10, FWP_STATIC_TASKS,
            (size_t)FWP_STATIC_TASK_STACK >> 10, fwp_static.tasks_peak, FWP_STATIC_THREADS,
            (size_t)FWP_STATIC_THREAD_STACK >> 10);
}
#endif

#endif /* FWP_NATIVE_HEAP */

/* A resource parent must finish its logical lifetime even when object storage
 * is deliberately retained. On WebAssembly this also disposes counter metadata;
 * native disabled-free behavior continues to leave object storage untouched. */
static inline void fwp_rc_resource_free_obj(V value) {
#if FWP_NATIVE_HEAP && defined(FWP_RESOURCE_NO_FREE)
    fwp_rc_drop(value);
#else
    fwp_rc_free_obj(value);
#endif
}
static inline void fwp_rc_resource_free_arr(V value) {
#if FWP_NATIVE_HEAP && defined(FWP_RESOURCE_NO_FREE)
    fwp_rc_drop(value);
#else
    fwp_rc_free_arr(value);
#endif
}

/* A reuse token owns only its emptied outer cell. Clear the ownership slot
 * first, so nested unwind registrations observing it cannot release it twice. */
static void fwp_rc_cleanup_cell(void *arg) {
    V *slot = arg, value = *slot;
    *slot = 0;
    if (value) fwp_rc_free_obj(value);
}
static void fwp_rc_cleanup_count(void *arg) {
    V *slot = arg, value = *slot;
    *slot = 0;
    if (value) fwp_rc_drop(value);
}

/* Compiled dynamic application consumes the function and its arguments.
 * Runtime callbacks retain the conservative shared entry in fwp_rt.c. */
struct fwp_closure_drop_work {
    V *items;
    size_t len, cap;
    V local[64];
};
/* WASI has no runtime threads. Native cleanup may enter through a host
 * callback, so its temporary work context is per thread. No safe point
 * occurs while processing this queue. */
#if defined(FWP_LIBRARY) && defined(_WIN32)
static DWORD fwp_closure_drop_key = TLS_OUT_OF_INDEXES;
static void fwp_closure_drop_init(void) {
    if (fwp_closure_drop_key != TLS_OUT_OF_INDEXES) return;
    fwp_closure_drop_key = TlsAlloc();
    if (fwp_closure_drop_key == TLS_OUT_OF_INDEXES) fwp_trap("cannot create closure cleanup key");
}
static fwp_closure_drop_work *fwp_closure_drop_get(void) {
    return fwp_closure_drop_key == TLS_OUT_OF_INDEXES ? NULL : TlsGetValue(fwp_closure_drop_key);
}
static void fwp_closure_drop_set(fwp_closure_drop_work *work) {
    if (fwp_closure_drop_key == TLS_OUT_OF_INDEXES || !TlsSetValue(fwp_closure_drop_key, work)) abort();
}
static void fwp_closure_drop_finish(void) {
    if (fwp_closure_drop_key == TLS_OUT_OF_INDEXES) return;
    TlsFree(fwp_closure_drop_key);
    fwp_closure_drop_key = TLS_OUT_OF_INDEXES;
}
#elif defined(FWP_LIBRARY) && !defined(__wasm__)
/* A native TLS descriptor can keep a dylib resident after dlclose on Darwin.
 * Libraries use an explicitly deleted pthread key for the same per-thread
 * temporary context. Initialization happens before accepting any export call. */
#include <pthread.h>
static pthread_key_t fwp_closure_drop_key;
static int fwp_closure_drop_key_ready;
static void fwp_closure_drop_init(void) {
    if (fwp_closure_drop_key_ready) return;
    if (pthread_key_create(&fwp_closure_drop_key, 0)) fwp_trap("cannot create closure cleanup key");
    fwp_closure_drop_key_ready = 1;
}
static fwp_closure_drop_work *fwp_closure_drop_get(void) {
    return fwp_closure_drop_key_ready ? pthread_getspecific(fwp_closure_drop_key) : NULL;
}
static void fwp_closure_drop_set(fwp_closure_drop_work *work) {
    if (!fwp_closure_drop_key_ready || pthread_setspecific(fwp_closure_drop_key, work)) abort();
}
static void fwp_closure_drop_finish(void) {
    if (!fwp_closure_drop_key_ready) return;
    pthread_key_delete(fwp_closure_drop_key);
    fwp_closure_drop_key_ready = 0;
}
#else
#ifdef __wasm__
static fwp_closure_drop_work *fwp_closure_drop_active;
#else
static _Thread_local fwp_closure_drop_work *fwp_closure_drop_active;
#endif
static fwp_closure_drop_work *fwp_closure_drop_get(void) { return fwp_closure_drop_active; }
static void fwp_closure_drop_set(fwp_closure_drop_work *work) { fwp_closure_drop_active = work; }
#endif

static void fwp_closure_drop_push(fwp_closure_drop_work *work, V f) {
    if (work->len == work->cap) {
        if (work->cap > SIZE_MAX / 2 / sizeof(V)) fwp_trap("closure cleanup too large");
        size_t cap = work->cap * 2;
        /* Allocation failure is terminal, as in the value allocator. Recovery
         * would discard pending owners after destruction has already begun. */
        V *items = (V *)malloc(cap * sizeof(V));
        if (!items) {
            fprintf(stderr, "fwp: out of memory\n");
            fflush(NULL); _Exit(102);
        }
        memcpy(items, work->items, work->len * sizeof(V));
        if (work->items != work->local) free(work->items);
        work->items = items;
        work->cap = cap;
    }
    work->items[work->len++] = f;
}

static void fwp_closure_drop(V f) {
    if (!fwp_rc_release_last(f)) return;
    fwp_closure_drop_work *active = fwp_closure_drop_get();
    if (active) {
        fwp_closure_drop_push(active, f);
        return;
    }
    fwp_closure_drop_work work;
    work.items = work.local;
    work.len = 0;
    work.cap = sizeof work.local / sizeof *work.local;
    fwp_closure_drop_set(&work);
    fwp_closure_drop_push(&work, f);
    while (work.len) {
        V next = work.items[--work.len];
        const fwp_owned_fninfo *owned = fwp_fns[CLO(next)->fn].owned;
        if (!owned) fwp_trap("internal: owned closure without capture types");
        owned->captures(next, 0);
    }
    /* No suspension or recoverable failure occurs during destruction. */
    fwp_closure_drop_set(NULL);
    if (work.items != work.local) free(work.items);
}

#ifndef FWP_UNWIND
#define FWP_UNWIND 0
#endif
#if FWP_UNWIND
/* Only completed duplicates are owned; the original argument slice borrows. */
typedef struct {
    V *args;
    void (*drop)(V *, uint32_t, uint32_t);
    uint32_t start, n;
} fwp_args_owner;
static void fwp_args_release(void *arg) {
    fwp_args_owner *owner = arg;
    uint32_t n = owner->n;
    owner->n = 0;
    if (n) owner->drop(owner->args, owner->start, n);
}

/* The current function stays owned until its entry returns. Supplied arguments
 * transfer only at entry; overapplication's tail waits in this runtime frame. */
typedef struct {
    V function;
    V *args;
    const fwp_owned_fninfo *types;
    uint32_t start, offset, n;
} fwp_apply_owner;
static void fwp_apply_release(void *arg) {
    fwp_apply_owner *owner = arg;
    V function = owner->function;
    owner->function = 0;
    uint32_t count = owner->n - owner->start;
    if (count && owner->types->drop_arguments)
        owner->types->drop_arguments(owner->args + owner->start, owner->offset + owner->start, count);
    owner->start = owner->n;
    if (function) fwp_closure_drop(function);
}
#endif

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
#if FWP_UNWIND
        fwp_apply_owner owner = {f, args, fi->owned, 0, have, n};
        fwp_cleanup cleanup;
        uint8_t *slot = fwp_rc_slot(f);
        int registered = (slot && *slot) ||
            (fi->owned->drop_arguments && (have || have + n < ar || n > ar - have));
        if (registered) fwp_cleanup_push(&cleanup, fwp_apply_release, &owner);
#endif
        if (have + n < ar) {
            fwp_clo *r = (fwp_clo *)fwp_alloc_init(sizeof(fwp_clo) + (have + n) * sizeof(V));
            r->fn = c->fn;
            r->n = have + n;
#if FWP_UNWIND
            /* Child aliases are not yet owned. A failed capture duplicate
             * releases the empty outer cell, not its copied borrowed fields. */
            V building = fwp_rc_fresh(PTR(r));
            fwp_cleanup building_cleanup;
            fwp_cleanup_push(&building_cleanup, fwp_rc_cleanup_cell, &building);
#endif
            for (uint32_t i = 0; i < have; i++) r->a[i] = c->a[i];
            for (uint32_t i = 0; i < n; i++) r->a[have + i] = args[i];
            /* The consumed closure can transfer its captures when exclusive.
             * Their destination is ready; clearing n prevents its later cleanup
             * from releasing the transferred values. Shared closures still copy. */
            if (fwp_rc_last(f)) c->n = 0;
            else fi->owned->captures(f, 1);
            V result = fwp_rc_fresh(PTR(r));
#if FWP_UNWIND
            owner.start = n; /* the fresh closure now owns supplied arguments */
            building = 0;
            fwp_cleanup_pop(&building_cleanup);
            if (registered) fwp_cleanup_pop(&cleanup);
#endif


            fwp_closure_drop(f);
            return result;
        }
        uint32_t need = ar - have;
        V result;
        if (!have && ar) {
#if FWP_UNWIND
            owner.start = need; /* the entry takes exactly this prefix */
#endif
            result = fi->owned->entry(args);
        } else {
            V all[ar ? ar : 1];
            for (uint32_t i = 0; i < have; i++) all[i] = c->a[i];
            for (uint32_t i = 0; i < need; i++) all[have + i] = args[i];
            /* The consumed closure can transfer its captures when exclusive.
             * Their destination is ready; clearing n prevents its later cleanup
             * from releasing the transferred values. Shared closures still copy. */
            if (fwp_rc_last(f)) c->n = 0;
            else fi->owned->captures(f, 1);
#if FWP_UNWIND
            owner.start = need; /* captures prepared; entry now takes the prefix */
#endif
            result = fi->owned->entry(all);
        }
#if FWP_UNWIND
        if (registered) fwp_cleanup_pop(&cleanup);
#endif


        fwp_closure_drop(f);
        if (n == need) return result;
        f = result;
        args += need;
        n -= need;
    }
}

/* Borrow a callback and supplied arguments, returning one owned result.
 * Split overapplication at actual function boundaries: scalar argument bits
 * must never be interpreted as counted pointers. Returned function values
 * are already owned and are consumed by the next application. */
static V fwp_apply_borrowed_span(V f, uint32_t n, V *args, uint32_t owned_start, uint32_t owned_len) {
    if (owned_start > n || owned_len > n - owned_start)
        fwp_trap("internal: invalid owned callback span");
    int first = 1;
    for (;;) {
        fwp_clo *c = CLO(f);
        const fwp_fninfo *fi = &fwp_fns[c->fn];
        if (!fi->owned) {
            /* Unknown runtime entries retain the conservative convention. */
            fwp_rc_share(f);
            for (uint32_t i = 0; i < n; i++) fwp_rc_share(args[i]);
            return fwp_apply(f, n, args);
        }
        /* The initial callable is borrowed. With plain parameters and exactly
         * enough arguments, its captures need no duplicates and no transfer.
         * Copy them before entry; the callback may fail or suspend, and its
         * caller keeps the original owner. An owned returned callable later in
         * an overapplication still goes through the consuming path below. */
        if (first && !fi->owned->drop_arguments && n == fi->arity - c->n) {
            if (!c->n) return fi->owned->entry(args);
            V all[fi->arity ? fi->arity : 1];
            memcpy(all, c->a, c->n * sizeof(V));
            /* An empty supplied slice may be NULL, even for a zero-byte copy. */
            if (n) memcpy(all + c->n, args, n * sizeof(V));
            return fi->owned->entry(all);
        }
#if FWP_UNWIND
        /* Keep the duplicated function and consumed span owned while typed
         * borrowed arguments are prepared; application takes them at entry. */
        /* An empty argument slice may be NULL; even adding zero to it is invalid C. */
        fwp_apply_owner pending = {first ? 0 : f, owned_len ? args + owned_start : NULL, fi->owned, 0, c->n + owned_start, owned_len};
        fwp_cleanup pending_cleanup;
        uint8_t *pending_slot = fwp_rc_slot(f);
        int protected = (pending_slot && *pending_slot) ||
            (owned_len && fi->owned->drop_arguments);
        if (protected) fwp_cleanup_push(&pending_cleanup, fwp_apply_release, &pending);
#endif
        if (first) {
            fwp_rc_dup(f);
            first = 0;
#if FWP_UNWIND
            pending.function = f;
#endif
        }
        uint32_t need = fi->arity - c->n;
        uint32_t chunk = n < need ? n : need;
        uint32_t before = owned_start < chunk ? owned_start : chunk;
        uint32_t transferred = owned_len < chunk - before ? owned_len : chunk - before;
        uint32_t after = chunk - before - transferred;
#if FWP_UNWIND
        /* Each successful borrowed duplicate becomes owned immediately. A
         * later duplicate can fail before application consumes that prefix. */
        fwp_apply_owner before_owner = {0, args, fi->owned, 0, c->n, 0};
        fwp_apply_owner after_owner = {0, after ? args + before + transferred : NULL, fi->owned, 0, c->n + before + transferred, 0};
        fwp_cleanup before_cleanup, after_cleanup;
        int protect_before = before && fi->owned->drop_arguments;
        int protect_after = after && fi->owned->drop_arguments;
        if (protect_before) fwp_cleanup_push(&before_cleanup, fwp_apply_release, &before_owner);
        if (protect_after) fwp_cleanup_push(&after_cleanup, fwp_apply_release, &after_owner);
        for (uint32_t i = 0; i < before; i++) {
            fi->owned->arguments(args + i, c->n + i, 1);
            before_owner.n++;
        }
        for (uint32_t i = 0; i < after; i++) {
            fi->owned->arguments(args + before + transferred + i, c->n + before + transferred + i, 1);
            after_owner.n++;
        }
        before_owner.start = before_owner.n;
        after_owner.start = after_owner.n;
#else
        if (before) fi->owned->arguments(args, c->n, before);
        if (after) fi->owned->arguments(args + before + transferred, c->n + before + transferred, after);
#endif
#if FWP_UNWIND
        pending.function = 0; /* application owns the function now */
        pending.start = transferred; /* keep an overapplication suffix here */
#endif
        V result = fwp_apply_owned(f, chunk, args);
#if FWP_UNWIND
        if (protect_after) fwp_cleanup_pop(&after_cleanup);
        if (protect_before) fwp_cleanup_pop(&before_cleanup);
        if (protected) fwp_cleanup_pop(&pending_cleanup);
#endif

        if (chunk == n) return result;
        f = result;
        args += chunk;
        n -= chunk;
        owned_start = owned_start > chunk ? owned_start - chunk : 0;
        owned_len -= transferred;
    }
}

static V fwp_apply_borrowed_prefix(V f, uint32_t n, V *args, uint32_t owned_prefix) {
    return fwp_apply_borrowed_span(f, n, args, 0, owned_prefix);
}

static V fwp_apply_borrowed(V f, uint32_t n, V *args) {
    return fwp_apply_borrowed_prefix(f, n, args, 0);
}

/* Numeric arrays may use pointer-free leaf slots. Keep generic reuse's
 * ordinary-object slot restriction so records cannot acquire leaf storage. */
static inline size_t fwp_array_capacity(V v, const fwp_desc *elem) {
    if (fwp_array_is_view(v)) return 0;
    size_t capacity = fwp_rc_capacity(v);
    if (capacity || !fwp_array_numeric(elem)) return capacity;
#if FWP_NATIVE_HEAP
    uintptr_t off = (uintptr_t)v - (uintptr_t)fwp_heap.base;
    if (off >= fwp_heap.top << HEAP_SHIFT) return 0;
    heap_chunk *m = &fwp_heap.meta[off >> HEAP_SHIFT];
    if (m->type == HEAP_SMALL && m->leaf == 1 && (off & (HEAP_CHUNK - 1)) % m->slot == 0) return m->slot;
#else
    (void)v;
#endif
    return 0;
}
