/* Static memory (`fwp build --memory static`) bounds runtime-owned storage.
 * One populated region holds
 *
 *   - the pool behind malloc, calloc, realloc and free, which this file
 *     defines (Windows uses private names and an explicit decimal allocator);
 *   - the collector's heap and its metadata (runtime/fwp_rt_gc.c), which
 *     is still collected but never grows;
 *   - on POSIX, main/task/worker stacks. Windows commits OS-managed stacks
 *     separately at startup and reuses fixed fiber and worker pools.
 * External DLL allocations and OS resources are outside this storage budget.
 *
 * The sizes are compiled in (FWP_STATIC_* below, from the build's
 * options). The region is populated when it is mapped, so its pages are
 * touched before the program runs (the OS may subsequently page them out).
 * Running out of any part is reported
 * by name and ends the program with exit code 102. FWP_MEMORY_REPORT=1
 * prints the layout and the high-water mark of each part at exit. */

#ifdef _WIN32
/* DLL-internal allocations retain their own allocator. Runtime allocations
 * use this explicit pool; never free a DLL allocation through these names. */
#define malloc fwp_static_malloc
#define calloc fwp_static_calloc
#define realloc fwp_static_realloc
#define free fwp_static_free
#define strdup fwp_static_strdup
static void *fwp_static_malloc(size_t);
static void *fwp_static_calloc(size_t, size_t);
static void *fwp_static_realloc(void *, size_t);
static void fwp_static_free(void *);
static char *fwp_static_strdup(const char *text) {
    size_t size = strlen(text) + 1;
    char *copy = fwp_static_malloc(size);
    memcpy(copy, text, size);
    return copy;
}
#else
#include <sys/mman.h>
#include <unistd.h>
#include <pthread.h>
#endif

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

static void fwp_static_die(const char *message, size_t length) {
#ifdef _WIN32
    DWORD written;
    WriteFile(GetStdHandle(STD_ERROR_HANDLE), message, (DWORD)length, &written, NULL);
    ExitProcess(102);
#else
    if (write(2, message, length) < 0) { }
    _exit(102);
#endif
}

static void fwp_static_full(const char *what, size_t size, const char *option) {
    char buf[200];
    int n = snprintf(buf, sizeof buf, "fwp: out of memory: the static %s (%zu KiB) is full; build with a larger %s\n",
                     what, size >> 10, option);
    fwp_static_die(buf, (size_t)n);
}

#ifdef _WIN32
typedef struct {
    HANDLE thread, wake, done;
    LONG busy, stop;
    LPTHREAD_START_ROUTINE run;
    void *argument;
    DWORD result;
} fwp_static_worker;
static fwp_static_worker fwp_static_workers[FWP_STATIC_THREADS];

/* Commit is requested at creation; touch writable stack pages during startup.
 * Leave Windows' guard pages intact. https://learn.microsoft.com/en-us/windows/win32/procthread/thread-stack-size */
static void fwp_static_touch_stack(void) {
    ULONG_PTR low, high;
    SYSTEM_INFO system; GetSystemInfo(&system);
    GetCurrentThreadStackLimits(&low, &high);
    for (uintptr_t at = low; at < high;) {
        MEMORY_BASIC_INFORMATION region;
        if (!VirtualQuery((void *)at, &region, sizeof region)) abort();
        uintptr_t end = (uintptr_t)region.BaseAddress + region.RegionSize;
        if (end > high) end = high;
        if (region.State == MEM_COMMIT && !(region.Protect & (PAGE_GUARD | PAGE_NOACCESS))) {
            for (uintptr_t page = at; page < end; page += system.dwPageSize) {
                volatile unsigned char *byte = (volatile unsigned char *)page;
                *byte = *byte;
            }
        }
        if (end <= at) abort();
        at = end;
    }
}
static DWORD WINAPI fwp_static_worker_main(void *argument) {
    fwp_static_worker *worker = argument;
    fwp_static_touch_stack();
    if (!SetEvent(worker->done)) abort();
    for (;;) {
        if (WaitForSingleObject(worker->wake, INFINITE) != WAIT_OBJECT_0) abort();
        if (InterlockedCompareExchange(&worker->stop, 0, 0)) return 0;
        worker->result = worker->run(worker->argument);
        if (!SetEvent(worker->done)) abort();
    }
}
static void fwp_static_workers_finish(void) {
    for (int i = 0; i < FWP_STATIC_THREADS; i++) {
        fwp_static_worker *worker = &fwp_static_workers[i];
        if (!worker->thread) continue;
        if (WaitForSingleObject(worker->done, INFINITE) != WAIT_OBJECT_0) abort();
        InterlockedExchange(&worker->stop, 1);
        if (!SetEvent(worker->wake)) abort();
        if (WaitForSingleObject(worker->thread, INFINITE) != WAIT_OBJECT_0) abort();
        CloseHandle(worker->thread); CloseHandle(worker->wake); CloseHandle(worker->done);
        memset(worker, 0, sizeof *worker);
    }
}
static void fwp_static_workers_init(void) {
    for (int i = 0; i < FWP_STATIC_THREADS; i++) {
        fwp_static_worker *worker = &fwp_static_workers[i];
        worker->wake = CreateEventW(NULL, FALSE, FALSE, NULL);
        worker->done = CreateEventW(NULL, TRUE, FALSE, NULL);
        if (!worker->wake || !worker->done)
            fwp_static_full("worker startup", FWP_STATIC_THREAD_STACK, "--threads");
        worker->thread = CreateThread(NULL, FWP_STATIC_THREAD_STACK, fwp_static_worker_main, worker, 0, NULL);
        if (!worker->thread) fwp_static_full("worker startup", FWP_STATIC_THREAD_STACK, "--threads");
        if (WaitForSingleObject(worker->done, INFINITE) != WAIT_OBJECT_0) abort();
    }
    if (atexit(fwp_static_workers_finish)) abort();
}
static fwp_static_worker *fwp_static_worker_start(LPTHREAD_START_ROUTINE run, void *argument) {
    for (int i = 0; i < FWP_STATIC_THREADS; i++) {
        fwp_static_worker *worker = &fwp_static_workers[i];
        if (InterlockedCompareExchange(&worker->busy, 1, 0)) continue;
        if (!ResetEvent(worker->done)) abort();
        worker->run = run; worker->argument = argument;
        if (!SetEvent(worker->wake)) abort();
        return worker;
    }
    fwp_static_full("worker slots", FWP_STATIC_THREADS * FWP_STATIC_THREAD_STACK, "--threads");
    return NULL;
}
static void fwp_static_worker_wait(fwp_static_worker *worker) {
    if (WaitForSingleObject(worker->done, INFINITE) != WAIT_OBJECT_0) abort();
}
static void fwp_static_worker_release(fwp_static_worker *worker) {
    fwp_static_worker_wait(worker);
    worker->run = NULL; worker->argument = NULL;
    if (InterlockedExchange(&worker->busy, 0) != 1) abort();
}
#endif

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
#ifdef _WIN32
    SYSTEM_INFO system; GetSystemInfo(&system);
    size_t page = system.dwPageSize;
#else
    size_t page = (size_t)sysconf(_SC_PAGESIZE);
#endif
    size_t meta = fwp_static_meta_bytes(FWP_STATIC_HEAP);
    size_t total = FWP_STATIC_POOL + meta + FWP_STATIC_HEAP + ((size_t)1 << 20);
#ifndef _WIN32
    total += FWP_STATIC_STACK +
                   (size_t)FWP_STATIC_TASKS * FWP_STATIC_TASK_STACK +
                   (size_t)FWP_STATIC_THREADS * FWP_STATIC_THREAD_STACK;
#endif
    total = (total + page - 1) & ~(page - 1);
#ifdef _WIN32
    void *r = VirtualAlloc(NULL, total, MEM_RESERVE | MEM_COMMIT, PAGE_READWRITE);
    int failed = !r;
#else
    int flags = MAP_PRIVATE | MAP_ANONYMOUS;
#ifdef MAP_POPULATE
    flags |= MAP_POPULATE;
#endif
    void *r = mmap(0, total, PROT_READ | PROT_WRITE, flags, -1, 0);
    int failed = r == MAP_FAILED;
#endif
    if (failed) {
        static const char msg[] = "fwp: out of memory: cannot map the program's static memory\n";
        fwp_static_die(msg, sizeof msg - 1);
    }
    fwp_static.base = fwp_static.cur = (char *)r;
    fwp_static.end = (char *)r + total;
    fwp_static.pool = fwp_static.pool_cur = fwp_static_carve(FWP_STATIC_POOL, 16);
    fwp_static.pool_end = fwp_static.pool + FWP_STATIC_POOL;
    fwp_static.meta = fwp_static_carve(meta, page);
    fwp_static.meta_bytes = meta;
    fwp_static.heap = fwp_static_carve(FWP_STATIC_HEAP, (size_t)1 << 16);
    fwp_static.heap_bytes = FWP_STATIC_HEAP;
#ifdef _WIN32
    for (size_t i = 0; i < total; i += page) ((volatile char *)r)[i] = 0;
    for (int i = 0; i < FWP_STATIC_TASKS; i++) fwp_static.task_free[i] = FWP_STATIC_TASKS - 1 - i;
    fwp_static.ntask_free = FWP_STATIC_TASKS;
#ifdef FWP_EXACT_FLOAT
    fwp_decimal_set_allocator(fwp_static_malloc, fwp_static_free);
#endif
    fwp_static_workers_init();
#else
    fwp_static.main_stack = fwp_static_carve(FWP_STATIC_STACK, page);
    for (int i = 0; i < FWP_STATIC_TASKS; i++) {
        fwp_static.task_stack[i] = fwp_static_carve(FWP_STATIC_TASK_STACK, page);
        /* a guard page below each stack, where an overflow faults */
        if (mprotect(fwp_static.task_stack[i], page, PROT_NONE)) {
            static const char msg[] = "fwp: cannot protect static task stack guard page\n";
            munmap(r, total);
            fwp_static_die(msg, sizeof msg - 1);
        }
        fwp_static.task_free[i] = FWP_STATIC_TASKS - 1 - i;
    }
    fwp_static.ntask_free = FWP_STATIC_TASKS;
    for (int i = 0; i < FWP_STATIC_THREADS; i++) fwp_static.thread_stack[i] = fwp_static_carve(FWP_STATIC_THREAD_STACK, page);
#endif
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

#ifndef _WIN32
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
#endif

/* ----------------------------------------------------------------- stacks */

#ifndef _WIN32
static char *fwp_static_task_stack(void) {
    if (!fwp_static.ready) fwp_static_init();
    if (fwp_static.ntask_free == 0) {
        char buf[160];
        int n = snprintf(buf, sizeof buf,
                         "fwp: out of memory: the static memory has stacks for %d tasks; build with a larger --tasks\n",
                         FWP_STATIC_TASKS);
        fwp_static_die(buf, (size_t)n);
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
#endif

static void fwp_static_report(void);
