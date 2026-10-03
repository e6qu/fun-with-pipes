/* Static memory (`fwp build --memory static`): all the memory a program
 * uses is mapped once, when it starts, and nothing is asked of the
 * operating system after that. One region holds
 *
 *   - the pool behind malloc, calloc, realloc and free, which this file
 *     defines, so the C library's own allocations come from it too;
 *   - the collector's heap and its metadata (runtime/fwp_rt_gc.c), which
 *     is still collected but never grows;
 *   - the main thread's stack, a fixed number of task stacks, and the
 *     stacks of the threads of `CpuParallel` kernels.
 *
 * The sizes are compiled in (FWP_STATIC_* below, from the build's
 * options). The region is populated when it is mapped, so its pages are
 * resident before the program runs. Running out of any part is reported
 * by name and ends the program with exit code 102. FWP_MEMORY_REPORT=1
 * prints the layout and the high-water mark of each part at exit. */

#include <sys/mman.h>
#include <unistd.h>
#include <pthread.h>

#ifndef FWP_STATIC_HEAP
#define FWP_STATIC_HEAP ((size_t)64 << 20)
#endif
#ifndef FWP_STATIC_POOL
#define FWP_STATIC_POOL ((size_t)32 << 20)
#endif
#ifndef FWP_STATIC_STACK
#define FWP_STATIC_STACK ((size_t)16 << 20)
#endif
#ifndef FWP_STATIC_TASKS
#define FWP_STATIC_TASKS 64
#endif
#ifndef FWP_STATIC_TASK_STACK
#define FWP_STATIC_TASK_STACK ((size_t)1 << 20)
#endif
#ifndef FWP_STATIC_THREADS
#define FWP_STATIC_THREADS 8
#endif
#define FWP_STATIC_THREAD_STACK ((size_t)1 << 20)

static struct {
    int ready;
    char *base, *cur, *end;
    /* the pool */
    char *pool, *pool_cur, *pool_end;
    void *pool_free[256];
    size_t pool_used, pool_peak;
    volatile int lock;
    /* the collector's heap and metadata */
    char *heap, *meta;
    size_t heap_bytes, meta_bytes;
    /* stacks */
    char *main_stack;
    char *task_stack[FWP_STATIC_TASKS];
    int task_free[FWP_STATIC_TASKS], ntask_free, tasks_peak;
    char *thread_stack[FWP_STATIC_THREADS];
} fwp_static;

static void fwp_static_full(const char *what, size_t size, const char *option) {
    char buf[200];
    int n = snprintf(buf, sizeof buf, "fwp: out of memory: the static %s (%zu KiB) is full; build with a larger %s\n",
                     what, size >> 10, option);
    if (write(2, buf, (size_t)n) < 0) { /* nothing more to do */ }
    _exit(102);
}

static char *fwp_static_carve(size_t n, size_t align) {
    uintptr_t p = ((uintptr_t)fwp_static.cur + align - 1) & ~(uintptr_t)(align - 1);
    fwp_static.cur = (char *)(p + n);
    return (char *)p;
}

/* bytes of collector metadata for a heap of `heap` bytes (GC_CHUNK and
 * gc_chunk come from runtime/fwp_rt_gc.c, which is included later) */
static size_t fwp_static_meta_bytes(size_t heap);

static void fwp_static_init(void) {
    if (fwp_static.ready) return;
    fwp_static.ready = 1;
    size_t page = (size_t)sysconf(_SC_PAGESIZE);
    size_t meta = fwp_static_meta_bytes(FWP_STATIC_HEAP);
    size_t total = FWP_STATIC_POOL + meta + FWP_STATIC_HEAP + FWP_STATIC_STACK +
                   (size_t)FWP_STATIC_TASKS * FWP_STATIC_TASK_STACK +
                   (size_t)FWP_STATIC_THREADS * FWP_STATIC_THREAD_STACK + ((size_t)1 << 20);
    total = (total + page - 1) & ~(page - 1);
    int flags = MAP_PRIVATE | MAP_ANONYMOUS;
#ifdef MAP_POPULATE
    flags |= MAP_POPULATE;
#endif
    void *r = mmap(0, total, PROT_READ | PROT_WRITE, flags, -1, 0);
    if (r == MAP_FAILED) {
        static const char msg[] = "fwp: out of memory: cannot map the program's static memory\n";
        if (write(2, msg, sizeof msg - 1) < 0) { /* nothing more to do */ }
        _exit(102);
    }
    fwp_static.base = fwp_static.cur = (char *)r;
    fwp_static.end = (char *)r + total;
    fwp_static.pool = fwp_static.pool_cur = fwp_static_carve(FWP_STATIC_POOL, 16);
    fwp_static.pool_end = fwp_static.pool + FWP_STATIC_POOL;
    fwp_static.meta = fwp_static_carve(meta, page);
    fwp_static.meta_bytes = meta;
    fwp_static.heap = fwp_static_carve(FWP_STATIC_HEAP, (size_t)1 << 16);
    fwp_static.heap_bytes = FWP_STATIC_HEAP;
    fwp_static.main_stack = fwp_static_carve(FWP_STATIC_STACK, page);
    for (int i = 0; i < FWP_STATIC_TASKS; i++) {
        fwp_static.task_stack[i] = fwp_static_carve(FWP_STATIC_TASK_STACK, page);
        /* a guard page below each stack, where an overflow faults */
        mprotect(fwp_static.task_stack[i], page, PROT_NONE);
        fwp_static.task_free[i] = FWP_STATIC_TASKS - 1 - i;
    }
    fwp_static.ntask_free = FWP_STATIC_TASKS;
    for (int i = 0; i < FWP_STATIC_THREADS; i++) fwp_static.thread_stack[i] = fwp_static_carve(FWP_STATIC_THREAD_STACK, page);
}

/* ---------------------------------------------------------------- the pool
 * Blocks in size classes of four per doubling (32, 40, 48, 56, 64, 80,
 * ...: a block wastes at most a quarter), each with a 16-byte header (its
 * class, and for an aligned block the distance back to the header of the
 * block it is in); freed blocks go to their class's list. */

typedef struct { uint32_t cls, back; uint64_t pad; } fwp_pool_hdr;

static void fwp_pool_lock(void) {
    while (__atomic_test_and_set(&fwp_static.lock, __ATOMIC_ACQUIRE)) { }
}
static void fwp_pool_unlock(void) { __atomic_clear(&fwp_static.lock, __ATOMIC_RELEASE); }

/* class c is 2^(c/4) plus c%4 quarters of it */
static size_t fwp_pool_size(unsigned c) {
    size_t b = (size_t)1 << (c / 4);
    return b + (c % 4) * (b / 4);
}

static unsigned fwp_pool_class(size_t n) {
    if (n < 32) n = 32;
    unsigned e = 63 - (unsigned)__builtin_clzll((unsigned long long)n);
    size_t b = (size_t)1 << e, q = b / 4;
    size_t k = (n - b + q - 1) / q;
    return k == 4 ? (e + 1) * 4 : e * 4 + (unsigned)k;
}

static void *fwp_pool_get(size_t n) {
    if (!fwp_static.ready) fwp_static_init();
    if (n > FWP_STATIC_POOL) fwp_static_full("malloc pool", FWP_STATIC_POOL, "--pool");
    unsigned c = fwp_pool_class(n + sizeof(fwp_pool_hdr));
    size_t sz = fwp_pool_size(c);
    fwp_pool_lock();
    fwp_pool_hdr *h = (fwp_pool_hdr *)fwp_static.pool_free[c];
    if (h) {
        fwp_static.pool_free[c] = *(void **)(h + 1);
    } else {
        if ((size_t)(fwp_static.pool_end - fwp_static.pool_cur) < sz) {
            fwp_pool_unlock();
            fwp_static_full("malloc pool", FWP_STATIC_POOL, "--pool");
        }
        h = (fwp_pool_hdr *)fwp_static.pool_cur;
        fwp_static.pool_cur += sz;
    }
    fwp_static.pool_used += sz;
    if (fwp_static.pool_used > fwp_static.pool_peak) fwp_static.pool_peak = fwp_static.pool_used;
    fwp_pool_unlock();
    h->cls = c;
    h->back = 0;
    return h + 1;
}

static fwp_pool_hdr *fwp_pool_hdr_of(void *p) {
    fwp_pool_hdr *h = (fwp_pool_hdr *)p - 1;
    if (h->back) h = (fwp_pool_hdr *)((char *)h - h->back);
    return h;
}

void free(void *p) {
    if (!p) return;
    fwp_pool_hdr *h = fwp_pool_hdr_of(p);
    fwp_pool_lock();
    fwp_static.pool_used -= fwp_pool_size(h->cls);
    *(void **)(h + 1) = fwp_static.pool_free[h->cls];
    fwp_static.pool_free[h->cls] = h;
    fwp_pool_unlock();
}

void *malloc(size_t n) { return fwp_pool_get(n ? n : 1); }

void *calloc(size_t k, size_t n) {
    if (n && k > (size_t)-1 / n) return 0;
    void *p = fwp_pool_get(k * n ? k * n : 1);
    memset(p, 0, k * n);
    return p;
}

void *realloc(void *p, size_t n) {
    if (!p) return malloc(n);
    if (!n) { free(p); return 0; }
    fwp_pool_hdr *h = fwp_pool_hdr_of(p);
    size_t have = fwp_pool_size(h->cls) - (size_t)((char *)p - (char *)h);
    if (n <= have) return p;
    void *q = malloc(n);
    memcpy(q, p, have);
    free(p);
    return q;
}

static void *fwp_pool_aligned(size_t align, size_t n) {
    if (align <= 16) return malloc(n);
    char *raw = (char *)fwp_pool_get(n + align);
    fwp_pool_hdr *h = (fwp_pool_hdr *)raw - 1;
    uintptr_t p = ((uintptr_t)raw + align - 1) & ~(uintptr_t)(align - 1);
    if (p == (uintptr_t)raw) return raw;
    fwp_pool_hdr *a = (fwp_pool_hdr *)p - 1;
    a->cls = h->cls;
    a->back = (uint32_t)((char *)a - (char *)h);
    return (void *)p;
}

int posix_memalign(void **out, size_t align, size_t n) {
    *out = fwp_pool_aligned(align, n);
    return 0;
}
void *aligned_alloc(size_t align, size_t n) { return fwp_pool_aligned(align, n); }
void *memalign(size_t align, size_t n) { return fwp_pool_aligned(align, n); }
void *valloc(size_t n) { return fwp_pool_aligned((size_t)sysconf(_SC_PAGESIZE), n); }
void *pvalloc(size_t n) {
    size_t pg = (size_t)sysconf(_SC_PAGESIZE);
    return fwp_pool_aligned(pg, (n + pg - 1) & ~(pg - 1));
}
size_t malloc_usable_size(void *p) {
    if (!p) return 0;
    fwp_pool_hdr *h = fwp_pool_hdr_of(p);
    return fwp_pool_size(h->cls) - (size_t)((char *)p - (char *)h);
}

/* ----------------------------------------------------------------- stacks */

static char *fwp_static_task_stack(void) {
    if (!fwp_static.ready) fwp_static_init();
    if (fwp_static.ntask_free == 0) {
        char buf[160];
        int n = snprintf(buf, sizeof buf,
                         "fwp: out of memory: the static memory has stacks for %d tasks; build with a larger --tasks\n",
                         FWP_STATIC_TASKS);
        if (write(2, buf, (size_t)n) < 0) { /* nothing more to do */ }
        _exit(102);
    }
    int i = fwp_static.task_free[--fwp_static.ntask_free];
    int busy = FWP_STATIC_TASKS - fwp_static.ntask_free;
    if (busy > fwp_static.tasks_peak) fwp_static.tasks_peak = busy;
    return fwp_static.task_stack[i];
}

static void fwp_static_task_stack_free(char *s) {
    for (int i = 0; i < FWP_STATIC_TASKS; i++)
        if (fwp_static.task_stack[i] == s) {
            fwp_static.task_free[fwp_static.ntask_free++] = i;
            return;
        }
}

static void fwp_static_report(void);
