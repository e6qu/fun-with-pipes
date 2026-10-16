/* Structured concurrency, networking and metrics.
 *
 * Tasks are green threads (ucontext) on one OS thread. A task runs until
 * it suspends on a timer, a channel, another task or a socket, or until
 * its slice ends: programs that use tasks count the entries to their
 * functions (FWP_TICK), and after FWP_SLICE of them (FWP_PREEMPT) the
 * task notices its cancellation or deadline and lets the other ready
 * tasks run (fwp_preempt). The count is deterministic and the same as the
 * interpreter's. Sockets are non-blocking; a task waiting for one is
 * parked on an event loop (epoll on Linux, poll elsewhere).
 *
 * Tasks form a tree: a task finishes only after its children finished, and
 * cancelling a task cancels its subtree. A cancelled task unwinds (longjmp
 * to its base) at its next suspension point. Each task has its own Error
 * handler chain and State stack, swapped in and out with the task.
 *
 * Without glibc (musl has no makecontext), or with FWP_OWN_CONTEXT,
 * tasks switch with a few instructions of their own on x86-64 and
 * AArch64 (fwp_ctx_swap): the callee-saved registers are pushed on the
 * task's stack, which the collector scans from the saved stack pointer.
 *
 * On WebAssembly (FWP_FIBERS) there is no ucontext: each task is a fiber
 * whose stack the JavaScript host suspends and resumes with JavaScript
 * Promise Integration (web/fibers.js). The scheduler below is the same;
 * only switching, task stacks and waiting for timers differ, and there
 * are no sockets or signal handlers. */

#include <limits.h>
#ifdef __wasi__
#define FWP_FIBERS 1
#elif defined(_WIN32)
#include <signal.h>
#else
#if !defined(__GLIBC__) && (defined(__x86_64__) || defined(__aarch64__)) && !defined(FWP_OWN_CONTEXT)
#define FWP_OWN_CONTEXT 1
#endif
#ifndef FWP_OWN_CONTEXT
#include <ucontext.h>
#endif
#include <sys/mman.h>
#include <sys/resource.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <fcntl.h>
#include <unistd.h>
#include <signal.h>
#include <poll.h>
#ifdef __linux__
#include <sys/epoll.h>
#endif
#ifndef MSG_NOSIGNAL
#define MSG_NOSIGNAL 0
#endif
#endif /* __wasi__ */

typedef struct fwp_task fwp_task;

#ifdef FWP_OWN_CONTEXT
/* a suspended task: its stack pointer, below the registers it saved */
typedef struct { void *sp; } fwp_ctx_t;
/* save the callee-saved registers (and the floating-point control) on
 * the stack, store the stack pointer in *from, switch to `to` and
 * restore what it saved */
void fwp_ctx_swap(void **from, void *to);
#define FWP_CTX_STRING_(s) #s
#define FWP_CTX_STRING(s) FWP_CTX_STRING_(s)
#ifdef __APPLE__
#define FWP_CTX_NAME "_" FWP_CTX_STRING(fwp_ctx_swap)
#define FWP_CTX_BEGIN ".text\n.globl " FWP_CTX_NAME "\n.private_extern " FWP_CTX_NAME "\n" FWP_CTX_NAME ":\n"
#define FWP_CTX_END ""
#else
#define FWP_CTX_NAME FWP_CTX_STRING(fwp_ctx_swap)
#if defined(__x86_64__)
#define FWP_CTX_TYPE ".type " FWP_CTX_NAME ",@function\n"
#else
#define FWP_CTX_TYPE ".type " FWP_CTX_NAME ",%function\n"
#endif
#define FWP_CTX_BEGIN ".text\n.globl " FWP_CTX_NAME "\n.hidden " FWP_CTX_NAME "\n" FWP_CTX_TYPE FWP_CTX_NAME ":\n"
#define FWP_CTX_END ".size " FWP_CTX_NAME ", .-" FWP_CTX_NAME "\n"
#endif
#if defined(__x86_64__)
__asm__(FWP_CTX_BEGIN
        "    pushq %rbp\n"
        "    pushq %rbx\n"
        "    pushq %r12\n"
        "    pushq %r13\n"
        "    pushq %r14\n"
        "    pushq %r15\n"
        "    subq $8, %rsp\n"
        "    stmxcsr (%rsp)\n"
        "    fnstcw 4(%rsp)\n"
        "    movq %rsp, (%rdi)\n"
        "    movq %rsi, %rsp\n"
        "    ldmxcsr (%rsp)\n"
        "    fldcw 4(%rsp)\n"
        "    addq $8, %rsp\n"
        "    popq %r15\n"
        "    popq %r14\n"
        "    popq %r13\n"
        "    popq %r12\n"
        "    popq %rbx\n"
        "    popq %rbp\n"
        "    ret\n"
        FWP_CTX_END);
/* bytes fwp_ctx_swap keeps on the stack, and where it returns to */
#define FWP_CTX_FRAME 72
#define FWP_CTX_RET 56
#elif defined(__aarch64__)
__asm__(FWP_CTX_BEGIN
        "    sub sp, sp, #176\n"
        "    stp x19, x20, [sp, #0]\n"
        "    stp x21, x22, [sp, #16]\n"
        "    stp x23, x24, [sp, #32]\n"
        "    stp x25, x26, [sp, #48]\n"
        "    stp x27, x28, [sp, #64]\n"
        "    stp x29, x30, [sp, #80]\n"
        "    stp d8, d9, [sp, #96]\n"
        "    stp d10, d11, [sp, #112]\n"
        "    stp d12, d13, [sp, #128]\n"
        "    stp d14, d15, [sp, #144]\n"
        "    mrs x2, fpcr\n"
        "    str x2, [sp, #160]\n"
        "    mov x2, sp\n"
        "    str x2, [x0]\n"
        "    mov sp, x1\n"
        "    ldr x2, [sp, #160]\n"
        "    msr fpcr, x2\n"
        "    ldp x19, x20, [sp, #0]\n"
        "    ldp x21, x22, [sp, #16]\n"
        "    ldp x23, x24, [sp, #32]\n"
        "    ldp x25, x26, [sp, #48]\n"
        "    ldp x27, x28, [sp, #64]\n"
        "    ldp x29, x30, [sp, #80]\n"
        "    ldp d8, d9, [sp, #96]\n"
        "    ldp d10, d11, [sp, #112]\n"
        "    ldp d12, d13, [sp, #128]\n"
        "    ldp d14, d15, [sp, #144]\n"
        "    add sp, sp, #176\n"
        "    ret\n"
        FWP_CTX_END);
#define FWP_CTX_FRAME 176
#define FWP_CTX_RET 88
#else
#error "FWP_OWN_CONTEXT is written for x86-64 and AArch64"
#endif
#undef FWP_CTX_BEGIN
#undef FWP_CTX_END
#undef FWP_CTX_NAME
#undef FWP_CTX_STRING
#undef FWP_CTX_STRING_
#ifndef __APPLE__
#undef FWP_CTX_TYPE
#endif
#endif

/* a list of parked tasks */
typedef struct { fwp_task *head; } fwp_wl;

struct fwp_task {
    uint64_t identity; /* Never reused when allocator slots or fibers are reused. */
#ifdef _WIN32
    fwp_win_context ctx;
#elif defined(FWP_OWN_CONTEXT)
    fwp_ctx_t ctx;
#elif !defined(FWP_FIBERS)
    ucontext_t ctx;
#endif
    char *stack;
    size_t stack_size;
    fwp_task *parent;
    fwp_task *first_child, *next_sibling, *prev_sibling; /* live children */
    fwp_wl children_done; /* the task itself, waiting for its children */
    fwp_wl waiters;       /* tasks awaiting this one */
    int done, cancelled, unwinding, has_result, ready, timed, timed_out, io_ready;
    int64_t deadline; /* monotonic ns, 0 = none */
    int64_t wake_at;  /* timer while parked, 0 = none */
    V thunk, result;
    int owns_thunk, counted;
    void (*result_drop)(V);
    jmp_buf base;
    /* saved runtime state */
    fwp_handler *handlers;
    fwp_cleanup *cleanups;
    fwp_foreign_callback *foreign_callbacks;
    V *st;
    size_t st_len, st_cap;
    fwp_state_owner *state_owners;
    struct fwp_scope *scope;
    /* a task running C code (gRPC connections and calls): called with 0,
     * then again with 1 if the task was cancelled while running it */
    void (*cfn)(void *arg, int cancelled);
    void *carg;
    /* Nonallocating, nonthrowing disposal after all inherited-context children finish. */
    void (*cfinish)(void *arg);
    fwp_cleanup *trap_cleanup;
    jmp_buf *trap_jb;           /* traps recovered here (a served call) */
    void *gctx;                 /* gRPC context, inherited by children */
#ifdef FWP_GCTX_OWNERS
    void *gctx_owner;           /* retained original context, even if gctx changes */
#endif
    /* links */
    fwp_task *next_ready;
    fwp_task *tprev, *tnext;    /* timer list */
    fwp_wl *wl;                 /* list this task is parked on */
    fwp_task *wprev, *wnext;
    /* tasks with a stack, whose stacks hold roots for the collector
     * (runtime/fwp_rt_gc.c): scanned from the stack pointer saved when
     * the task was switched out */
    char *gc_sp;
    fwp_task *gc_prev, *gc_next;
};

typedef struct fwp_scope {
    fwp_task **tasks;
    size_t n, cap;
    struct fwp_scope *prev;
} fwp_scope;

static fwp_task *fwp_cur = 0, *fwp_root = 0, *fwp_zombie = 0;
static fwp_task *fwp_ready_head = 0, *fwp_ready_tail = 0;
static fwp_task *fwp_timers = 0;
static int fwp_epfd = -1, fwp_io_waiting = 0;
#ifdef FWP_FIBERS
static volatile int fwp_shutdown = 0;
#elif defined(_WIN32)
#include <stdatomic.h>
static _Atomic int fwp_shutdown = 0; /* console handlers run on another thread */
#else
static volatile sig_atomic_t fwp_shutdown = 0;
#endif
static int fwp_signals_installed = 0;
#if defined(FWP_LIBRARY) && !defined(FWP_FIBERS) && !defined(_WIN32)
static struct sigaction fwp_prior_sigint, fwp_prior_sigterm;
static int fwp_saved_sigint, fwp_saved_sigterm;
#endif

static int64_t fwp_dur_ns(V d) { return (int64_t)OBJ(d)->f[0]; }

/* the monotonic time a duration from now, saturating instead of
 * overflowing for very long durations */
static int64_t fwp_after(V d) {
    int64_t n = fwp_dur_ns(d), now = fwp_now_ns();
    if (n <= 0) return now;
    return n > INT64_MAX - now ? INT64_MAX : now + n;
}

/* a task is collected once it finished and nothing refers to it */
#ifdef FWP_GCTX_OWNERS
static void *(*fwp_gctx_acquire)(void *) = 0;
static void (*fwp_gctx_release)(void *) = 0;
static void fwp_gctx_pending_release(void *arg) {
    void **held = (void **)arg;
    if (*held) { fwp_gctx_release(*held); *held = 0; }
}
#endif

static uint64_t fwp_task_identity;
static fwp_task *fwp_task_new(void) {
    if (fwp_task_identity == UINT64_MAX) fwp_trap("task identity exhausted");
    fwp_task *task = fwp_mem_alloc(sizeof *task);
    task->identity = ++fwp_task_identity;
    return task;
}

static fwp_task *fwp_gc_tasks = 0;

#if FWP_GC
/* the lowest address of a suspended task's stack in use */
#ifdef FWP_OWN_CONTEXT
#define FWP_TASK_LOW(t) ((char *)(t)->ctx.sp)
#else
#define FWP_TASK_LOW(t) ((t)->gc_sp)
#endif
static void fwp_gc_scan_stacks(char *sp) {
#ifdef _WIN32
    char *top = fwp_cur ? fwp_cur->ctx.top : fwp_gc.main_top;
    fwp_gc_scan_root(sp, top);
    for (fwp_task *t = fwp_gc_tasks; t; t = t->gc_next)
        if (t != fwp_cur) fwp_win_context_scan(&t->ctx);
    if (fwp_root && fwp_cur != fwp_root) fwp_win_context_scan(&fwp_root->ctx);
#else
    char *top = fwp_cur && fwp_cur->stack ? fwp_cur->stack + fwp_cur->stack_size : fwp_gc.main_top;
    fwp_gc_scan_root(sp, top);
    for (fwp_task *t = fwp_gc_tasks; t; t = t->gc_next)
        if (t != fwp_cur && t->stack && t->gc_sp) fwp_gc_scan_root(FWP_TASK_LOW(t), t->stack + t->stack_size);
    if (fwp_root && fwp_cur != fwp_root && fwp_root->gc_sp)
        fwp_gc_scan_root(FWP_TASK_LOW(fwp_root), fwp_gc.main_top);
#endif
}
#endif

#if defined(_WIN32) && defined(FWP_STATIC_MEMORY)
typedef struct { void *fiber; char *top; int busy; } fwp_static_fiber;
static fwp_static_fiber fwp_static_fibers[FWP_STATIC_TASKS];
static void fwp_static_fibers_init(void);
static void fwp_static_fiber_release(void *fiber) {
    for (int i = 0; i < FWP_STATIC_TASKS; i++) {
        if (fwp_static_fibers[i].fiber != fiber) continue;
        if (!fwp_static_fibers[i].busy) abort();
        fwp_static_fibers[i].busy = 0;
        fwp_static.task_free[fwp_static.ntask_free++] = i;
        return;
    }
    abort();
}
#endif
static void fwp_tasks_init(void) {
    if (fwp_cur) return;
    fwp_root = fwp_task_new();
#ifdef _WIN32
    fwp_win_context_root(&fwp_root->ctx);
#endif
    fwp_cur = fwp_root;
#if defined(_WIN32) && defined(FWP_STATIC_MEMORY)
    fwp_static_fibers_init();
#endif
}

#ifdef FWP_FIBERS
/* The fiber interface of web/fibers.js. The host writes the table slots of
 * its hooks into fwp_fiber_hooks (the stack pointer hook is not needed
 * here); they stay 0 in hosts without JSPI, where starting a task traps.
 * Fiber 0 is the root task (the one running _start); the others are
 * numbered by their task's address. The exports exist only in programs
 * that use tasks (FWP_ASYNC), so that the others run without JSPI, on the
 * engine's ordinary stack. */
#ifdef FWP_ASYNC
#define FWP_EXPORT(name) __attribute__((export_name(name)))
#else
#define FWP_EXPORT(name)
#endif
typedef struct { uint32_t sw, idle, sp; } fwp_fiber_hooks_t;
static fwp_fiber_hooks_t fwp_hooks;
FWP_EXPORT("fwp_fiber_hooks") fwp_fiber_hooks_t *fwp_fiber_hooks(void) { return &fwp_hooks; }
static int fwp_fiber_id(fwp_task *t) { return t == fwp_root ? 0 : (int)(uintptr_t)t; }
static fwp_task *fwp_fiber_task(int id) { return id == 0 ? fwp_root : (fwp_task *)(uintptr_t)id; }
/* the initial stack pointer of a task's fiber */
FWP_EXPORT("fwp_fiber_stack") uint32_t fwp_fiber_stack(int id) {
    fwp_task *t = fwp_fiber_task(id);
    return (uint32_t)((uintptr_t)(t->stack + t->stack_size) & ~(uintptr_t)15);
}
/* for the host, after the engine's stack ran out in a fiber: what the
 * program printed so far, before it reports the stack overflow */
FWP_EXPORT("fwp_fiber_flush") void fwp_fiber_flush(void) { fwp_flush(); }
/* suspend the program for `ms` (every task waits for a timer) */
static void fwp_fiber_idle(int ms) {
    if (fwp_hooks.idle) {
        ((int (*)(double))(uintptr_t)fwp_hooks.idle)((double)ms);
    } else {
        struct timespec ts = {ms / 1000, (long)(ms % 1000) * 1000000L};
        nanosleep(&ts, 0);
    }
}
#endif

/* ----- wait lists and timers */

static void fwp_wl_add(fwp_wl *wl, fwp_task *t) {
    t->wl = wl;
    t->wprev = 0;
    t->wnext = wl->head;
    if (wl->head) wl->head->wprev = t;
    wl->head = t;
}

static void fwp_wl_remove(fwp_task *t) {
    if (!t->wl) return;
    if (t->wprev) t->wprev->wnext = t->wnext;
    else t->wl->head = t->wnext;
    if (t->wnext) t->wnext->wprev = t->wprev;
    t->wl = 0;
    t->wprev = t->wnext = 0;
}

static void fwp_timer_add(fwp_task *t, int64_t at) {
    t->wake_at = at;
    t->timed = 1;
    t->tprev = 0;
    t->tnext = fwp_timers;
    if (fwp_timers) fwp_timers->tprev = t;
    fwp_timers = t;
}

static void fwp_timer_remove(fwp_task *t) {
    if (!t->timed) return;
    if (t->tprev) t->tprev->tnext = t->tnext;
    else fwp_timers = t->tnext;
    if (t->tnext) t->tnext->tprev = t->tprev;
    t->timed = 0;
    t->tprev = t->tnext = 0;
}

static void fwp_make_ready(fwp_task *t) {
    if (t->ready || t->done) return;
    t->ready = 1;
    t->next_ready = 0;
    if (fwp_ready_tail) fwp_ready_tail->next_ready = t;
    else fwp_ready_head = t;
    fwp_ready_tail = t;
}

static fwp_task *fwp_dequeue(void) {
    fwp_task *t = fwp_ready_head;
    if (!t) return 0;
    fwp_ready_head = t->next_ready;
    if (!fwp_ready_head) fwp_ready_tail = 0;
    t->ready = 0;
    return t;
}

static void fwp_wake_all(fwp_wl *wl) {
    while (wl->head) {
        fwp_task *t = wl->head;
        fwp_wl_remove(t);
        fwp_make_ready(t);
    }
}

/* ----- tasks waiting on file descriptors (epoll): per descriptor, the
 * tasks waiting to read and to write, and the events registered for them
 * (the union of both directions) */

#ifdef __linux__
typedef struct { fwp_wl rd, wr; uint32_t mask; } fwp_fdw;
/* entries are allocated individually: wait lists must not move */
static fwp_fdw **fwp_fdws = 0;
static size_t fwp_nfdws = 0, fwp_live_fdws = 0;

static fwp_fdw *fwp_fdw_get(int fd) {
    if ((size_t)fd >= fwp_nfdws) {
        size_t n = fwp_nfdws ? fwp_nfdws : 64;
        while (n <= (size_t)fd) n *= 2;
        fwp_fdws = (fwp_fdw **)fwp_mem_realloc(fwp_fdws, fwp_nfdws * sizeof(fwp_fdw *), n * sizeof(fwp_fdw *));
        memset(fwp_fdws + fwp_nfdws, 0, (n - fwp_nfdws) * sizeof(fwp_fdw *));
        fwp_nfdws = n;
    }
    if (!fwp_fdws[fd]) {
        fwp_fdws[fd] = (fwp_fdw *)fwp_mem_alloc(sizeof(fwp_fdw));
        fwp_live_fdws++;
    }
    return fwp_fdws[fd];
}

/* register the events the descriptor's waiters need; -1 if epoll refuses
 * the descriptor */
static int fwp_fd_sync(int fd) {
    /* A close can wake a parked task and dispose its wait lists before that
     * task resumes. Synchronizing the old descriptor must not recreate them. */
    if (fd < 0 || (size_t)fd >= fwp_nfdws || !fwp_fdws[fd]) return 0;
    fwp_fdw *w = fwp_fdws[fd];
    uint32_t want = (w->rd.head ? EPOLLIN | EPOLLRDHUP : 0) | (w->wr.head ? EPOLLOUT : 0);
    if (want == w->mask) return 0;
    struct epoll_event ev;
    memset(&ev, 0, sizeof ev);
    ev.events = want;
    ev.data.fd = fd;
    int op = !w->mask ? EPOLL_CTL_ADD : !want ? EPOLL_CTL_DEL : EPOLL_CTL_MOD;
    int rc = epoll_ctl(fwp_epfd, op, fd, &ev);
    if (rc != 0 && op == EPOLL_CTL_ADD && errno == EEXIST) rc = epoll_ctl(fwp_epfd, EPOLL_CTL_MOD, fd, &ev);
    if (rc == 0 || op == EPOLL_CTL_DEL) w->mask = want;
    return rc == 0 || op == EPOLL_CTL_DEL ? 0 : -1;
}
#endif

static void fwp_wake_io(fwp_wl *wl) {
    while (wl->head) {
        fwp_task *t = wl->head;
        t->io_ready = 1;
        fwp_wl_remove(t);
        fwp_make_ready(t);
    }
}

/* A descriptor is about to be closed: unregister it and wake the tasks
 * waiting on it (they find the socket closed and fail). Closing first
 * would silently drop the descriptor from epoll and strand them. */
static void fwp_fd_closing(fwp_socket_t fd) {
#ifdef __linux__
    if (fd < 0 || (size_t)fd >= fwp_nfdws || !fwp_fdws[fd]) return;
    fwp_fdw *w = fwp_fdws[fd];
    if (w->mask) epoll_ctl(fwp_epfd, EPOLL_CTL_DEL, fd, 0);
    w->mask = 0;
    fwp_wake_io(&w->rd);
    fwp_wake_io(&w->wr);
    fwp_fdws[fd] = NULL;
    fwp_mem_free(w);
    if (!--fwp_live_fdws) {
        fwp_mem_free(fwp_fdws);
        fwp_fdws = NULL;
        fwp_nfdws = 0;
    }
#else
    (void)fd;
#endif
}

static void fwp_cancel_tree(fwp_task *t) {
    if (t->done) return;
    t->cancelled = 1;
    if (t != fwp_cur) fwp_make_ready(t);
    for (fwp_task *c = t->first_child; c; c = c->next_sibling) fwp_cancel_tree(c);
}

/* A scheduler reference survives until its stack and GC links are removed. */
static void fwp_task_drop(V value) {
    if (!fwp_rc_release_last(value)) return;
    fwp_task *t = (fwp_task *)(uintptr_t)value;
    if (!t->done || t->stack) abort();
    V result = t->result;
    t->result = 0;
    t->has_result = 0;
    if (t->result_drop && result) t->result_drop(result);
    fwp_mem_free(t->st);
    t->st = 0;
    t->counted = 0;
    /* Task storage is mutable kind 2, not a record/variant header. */
    fwp_rc_resource_free_arr(value);
}

/* ----- switching */

/* stacks of finished tasks, kept for reuse */
static char *fwp_stack_pool[64];
static int fwp_stack_pool_n = 0;
#define FWP_NATIVE_TASK_STACK ((size_t)256 << 20)

static void fwp_free_zombie(void) {
    if (fwp_zombie && fwp_zombie != fwp_cur) {
#ifdef _WIN32
#ifdef FWP_STATIC_MEMORY
        fwp_static_fiber_release(fwp_zombie->ctx.fiber);
#else
        DeleteFiber(fwp_zombie->ctx.fiber);
#endif
        memset(&fwp_zombie->ctx, 0, sizeof fwp_zombie->ctx);
#else
#ifdef FWP_STATIC_MEMORY
        if (1) fwp_static_task_stack_free(fwp_zombie->stack);
        else
#endif
        if (fwp_stack_pool_n < 64) fwp_stack_pool[fwp_stack_pool_n++] = fwp_zombie->stack;
#ifdef FWP_FIBERS
        else free(fwp_zombie->stack);
#else
        else munmap(fwp_zombie->stack, fwp_zombie->stack_size);
#endif
#endif
        fwp_zombie->stack = 0;
        if (fwp_zombie->gc_prev) fwp_zombie->gc_prev->gc_next = fwp_zombie->gc_next;
        else fwp_gc_tasks = fwp_zombie->gc_next;
        if (fwp_zombie->gc_next) fwp_zombie->gc_next->gc_prev = fwp_zombie->gc_prev;
        fwp_zombie->gc_prev = fwp_zombie->gc_next = 0;
        fwp_task *finished = fwp_zombie;
        fwp_zombie = 0;
        if (finished->counted) fwp_task_drop(PTR(finished));
    }
}

/* make `to` the current task, with its runtime state */
static void fwp_enter(fwp_task *to) {
    fwp_cur = to;
#ifdef FWP_ASYNCIFY
    fwp_stack_low = to->stack ? (uintptr_t)to->stack + 65536 : 0;
#endif
    fwp_handlers = to->handlers;
    fwp_cleanups = to->cleanups;
    fwp_foreign_callbacks = to->foreign_callbacks;
    fwp_state = to->st;
    fwp_state_len = to->st_len;
    fwp_state_cap = to->st_cap;
    fwp_state_owners = to->state_owners;
}

static void fwp_leave(fwp_task *from) {
    from->handlers = fwp_handlers;
    from->cleanups = fwp_cleanups;
    from->foreign_callbacks = fwp_foreign_callbacks;
    from->st = fwp_state;
    from->st_len = fwp_state_len;
    from->st_cap = fwp_state_cap;
    from->state_owners = fwp_state_owners;
}
static void fwp_switch(fwp_task *to) {
    fwp_task *from = fwp_cur;
    if (to == from) return;
    fwp_leave(from);
    fwp_enter(to);
#if FWP_GC
    from->gc_sp = fwp_gc_sp();
#endif
#ifdef FWP_FIBERS
    ((int (*)(int))(uintptr_t)fwp_hooks.sw)(fwp_fiber_id(to));
#elif defined(_WIN32)
    fwp_win_context_switch(&from->ctx, &to->ctx);
#elif defined(FWP_OWN_CONTEXT)
    fwp_ctx_swap(&from->ctx.sp, to->ctx.sp);
#else
    swapcontext(&from->ctx, &to->ctx);
#endif
    fwp_free_zombie();
}

static void fwp_poll_events(void) {
    int64_t now = fwp_now_ns();
    int64_t next = -1;
    for (fwp_task *t = fwp_timers; t; t = t->tnext)
        if (next < 0 || t->wake_at < next) next = t->wake_at;
    if (next < 0 && !fwp_io_waiting) {
        fwp_flush();
        fprintf(stderr, "fwp: trap: deadlock: every task is waiting\n");
        exit(101);
    }
    int timeout = -1;
    if (next >= 0) {
        int64_t d = next - now;
        int64_t ms = d <= 0 ? 0 : d / 1000000 + (d % 1000000 != 0);
        timeout = ms > INT_MAX ? INT_MAX : (int)ms;
    }
#if defined(FWP_FIBERS)
    if (timeout > 0) fwp_fiber_idle(timeout);
#elif defined(_WIN32)
    if (timeout > 0 || fwp_io_waiting)
        Sleep((DWORD)(fwp_io_waiting && (timeout < 0 || timeout > 10) ? 10 : timeout));
#elif defined(__linux__)
    if (fwp_io_waiting) {
        struct epoll_event evs[64];
        int n = epoll_wait(fwp_epfd, evs, 64, timeout);
        for (int i = 0; i < n; i++) {
            int fd = evs[i].data.fd;
            uint32_t e = evs[i].events;
            if ((size_t)fd >= fwp_nfdws || !fwp_fdws[fd]) continue;
            fwp_fdw *w = fwp_fdws[fd];
            if (e & (EPOLLIN | EPOLLRDHUP | EPOLLHUP | EPOLLERR)) fwp_wake_io(&w->rd);
            if (e & (EPOLLOUT | EPOLLHUP | EPOLLERR)) fwp_wake_io(&w->wr);
            fwp_fd_sync(fd);
        }
    } else if (timeout > 0) {
        struct timespec ts = {timeout / 1000, (long)(timeout % 1000) * 1000000L};
        nanosleep(&ts, 0);
    }
#else
    if (timeout > 0 || fwp_io_waiting) poll(0, 0, fwp_io_waiting && (timeout < 0 || timeout > 10) ? 10 : timeout);
#endif
    now = fwp_now_ns();
    fwp_task *t = fwp_timers;
    while (t) {
        fwp_task *nx = t->tnext;
        if (t->wake_at <= now) {
            fwp_timer_remove(t);
            t->timed_out = 1;
            if (t->deadline && now >= t->deadline && !t->cancelled) fwp_cancel_tree(t);
            fwp_make_ready(t);
        }
        t = nx;
    }
}

/* ----- preemption: function entries left in the running task's slice
 * (a new slice when a task starts or resumes after suspending) */
#define FWP_SLICE 10000
static int32_t fwp_slice = 0;

static void fwp_new_slice(void) {
    if (!fwp_slice) {
        const char *s = getenv("FWP_PREEMPT");
        long long n = s && *s ? strtoll(s, 0, 10) : FWP_SLICE;
        fwp_slice = n <= 0 || n > INT32_MAX ? INT32_MAX : (int32_t)n;
    }
    fwp_budget = fwp_slice;
}

/* Run other tasks until the current one is made ready again. */
static void fwp_block(void) {
    for (;;) {
        fwp_task *t = fwp_dequeue();
        if (t) {
            if (t != fwp_cur) fwp_switch(t);
            fwp_new_slice();
            return;
        }
        fwp_poll_events();
    }
}

/* Make the tasks whose timers passed, or whose sockets are ready, ready,
 * without waiting. */
static void fwp_poll_ready(void) {
    if (!fwp_timers && !fwp_io_waiting) return;
#if defined(__linux__) && !defined(FWP_FIBERS)
    if (fwp_io_waiting) {
        struct epoll_event evs[64];
        int n = epoll_wait(fwp_epfd, evs, 64, 0);
        for (int i = 0; i < n; i++) {
            int fd = evs[i].data.fd;
            uint32_t e = evs[i].events;
            if ((size_t)fd >= fwp_nfdws || !fwp_fdws[fd]) continue;
            fwp_fdw *w = fwp_fdws[fd];
            if (e & (EPOLLIN | EPOLLRDHUP | EPOLLHUP | EPOLLERR)) fwp_wake_io(&w->rd);
            if (e & (EPOLLOUT | EPOLLHUP | EPOLLERR)) fwp_wake_io(&w->wr);
            fwp_fd_sync(fd);
        }
    }
#endif
    if (!fwp_timers) return;
    int64_t now = fwp_now_ns();
    for (fwp_task *t = fwp_timers, *nx; t; t = nx) {
        nx = t->tnext;
        if (t->wake_at <= now) {
            fwp_timer_remove(t);
            t->timed_out = 1;
            if (t->deadline && now >= t->deadline && !t->cancelled) fwp_cancel_tree(t);
            fwp_make_ready(t);
        }
    }
}

static void fwp_root_cancelled(void);

/* Unwind if the current task was cancelled (or its deadline passed). */
static void fwp_check_cancel(void) {
    fwp_task *t = fwp_cur;
    if (!t || t->unwinding) return;
    if (t->deadline && !t->cancelled && fwp_now_ns() >= t->deadline) fwp_cancel_tree(t);
    if (!t->cancelled) return;
    t->unwinding = 1;
    fwp_cleanup_unwind(0);
    if (t == fwp_root) fwp_root_cancelled();
    longjmp(t->base, 1);
}

/* The slice of the current task is over: unwind it if it was cancelled
 * or its deadline passed, otherwise run the other ready tasks first. */
static __attribute__((noinline)) void fwp_preempt(void) {
    fwp_new_slice();
    fwp_task *t = fwp_cur;
    if (!t) return;
    fwp_check_cancel();
    fwp_poll_ready();
    if (!fwp_ready_head) return;
    fwp_make_ready(t);
    fwp_block();
    fwp_check_cancel();
}

/* Park the current task on `wl` (may be null) until woken or `at`
 * (0 = no timer) passes; the task's deadline also wakes it. Returns 1 if
 * the timer fired. */
static int fwp_park(fwp_wl *wl, int64_t at) {
    fwp_task *t = fwp_cur;
    if (!t->unwinding && t->deadline && (at == 0 || t->deadline < at)) at = t->deadline;
    if (wl) fwp_wl_add(wl, t);
    if (at) fwp_timer_add(t, at);
    t->timed_out = 0;
    fwp_block();
    fwp_wl_remove(t);
    fwp_timer_remove(t);
    return t->timed_out;
}

/* ----- task lifecycle */

static void fwp_unlink_child(fwp_task *t) {
    fwp_task *p = t->parent;
    if (!p) return;
    if (t->prev_sibling) t->prev_sibling->next_sibling = t->next_sibling;
    else p->first_child = t->next_sibling;
    if (t->next_sibling) t->next_sibling->prev_sibling = t->prev_sibling;
    if (!p->first_child) fwp_wake_all(&p->children_done);
    t->parent = t->next_sibling = t->prev_sibling = 0;
}

/* Wait for every child of the current task; its deadline (or
 * cancellation) cancels them, and waiting continues until they unwound. */
static void fwp_join_children(void) {
    fwp_task *t = fwp_cur;
    int was = t->unwinding;
    t->unwinding = 1;
    while (t->first_child) {
        if (t->deadline && !t->cancelled && fwp_now_ns() >= t->deadline) fwp_cancel_tree(t);
        fwp_park(&t->children_done, t->cancelled ? 0 : t->deadline);
    }
    t->unwinding = was;
}

#ifdef FWP_FIBERS
FWP_EXPORT("fwp_fiber_entry") int fwp_fiber_entry(int id) {
    (void)id; /* the task was entered by the switch that started it */
#else
static void fwp_task_main(void) {
#endif
    fwp_free_zombie();
    fwp_new_slice();
    fwp_task *t = fwp_cur;
    if (setjmp(t->base) == 0) {
        if (t->cfn) {
            t->cfn(t->carg, 0);
        } else {
            fwp_check_cancel();
            if (t->owns_thunk) {
                V thunk = t->thunk, unit = FWP_UNIT;
                t->thunk = 0;
                t->owns_thunk = 0;
                V result = fwp_apply_owned(thunk, 1, &unit);
                /* A counted handle owns the result; unknown shared boundaries
                 * retain tracing. Scalars never pass through generic sharing. */
                uint8_t *count = fwp_rc_slot(PTR(t));
                t->result = t->result_drop && (!count || !*count) ? fwp_rc_shared(result) : result;
            } else {
                t->result = fwp_apply1(t->thunk, FWP_UNIT);
            }
            t->has_result = 1;
        }
    } else if (t->cfn) {
        t->unwinding = 1;
        fwp_handlers = 0;
        fwp_state_restore(0);
        t->trap_jb = 0;
        t->trap_cleanup = 0;
        t->cfn(t->carg, 1);
    }
    t->unwinding = 1;
    fwp_handlers = 0;
    fwp_state_restore(0);
    fwp_join_children();
    if (t->cfinish) {
        void (*finish)(void *) = t->cfinish;
        t->cfinish = 0;
        finish(t->carg);
    }
    if (t->owns_thunk) {
        V thunk = t->thunk;
        t->thunk = 0;
        t->owns_thunk = 0;
        fwp_closure_drop(thunk);
    }
#ifdef FWP_GCTX_OWNERS
    if (t->gctx_owner) {
        void *held = t->gctx_owner;
        t->gctx_owner = 0;
        fwp_gctx_release(held);
    }
#endif
    t->done = 1;
    t->cleanups = 0; /* no cleanup link may outlive its task stack */
    fwp_wake_all(&t->waiters);
    fwp_unlink_child(t);
    fwp_zombie = t;
    for (;;) {
        fwp_task *n = fwp_dequeue();
#ifdef FWP_FIBERS
        /* return to the host, which resumes `n`; this fiber's stack is
         * freed (or kept for reuse) by the next one */
        if (n && n != t) {
            fwp_enter(n);
            return fwp_fiber_id(n);
        }
#elif defined(_WIN32) && defined(FWP_STATIC_MEMORY)
        if (n && n != t) {
            /* The next task retires this task object and returns the fiber
             * slot. On reuse, return without touching the retired object. */
            fwp_leave(t);
            fwp_enter(n);
            SwitchToFiber(n->ctx.fiber);
            return;
        }
#else
        if (n && n != t) fwp_switch(n);
#endif
        else if (!n) fwp_poll_events();
    }
}

/* Start a task running `thunk`, or `cfn(carg)` when `cfn` is set. A
 * detached task is not a child of the current one: nothing waits for it
 * or cancels it. */
#ifdef FWP_OWN_CONTEXT
/* where a new task's first switch returns to */
static void fwp_ctx_entry(void) { fwp_task_main(); }
#endif
#ifdef _WIN32
#ifdef FWP_STATIC_MEMORY
static void CALLBACK fwp_win_task_entry(void *arg) {
    fwp_static_fiber *slot = arg;
    fwp_win_context context = {0};
    fwp_win_context_started(&context);
    slot->top = context.top;
    fwp_static_touch_stack();
    SwitchToFiber(fwp_root->ctx.fiber);
    for (;;) fwp_task_main();
}
static void fwp_static_fibers_finish(void) {
    /* Normally the runtime thread has joined; detached fibers can remain
     * suspended. A fatal exit can instead originate on a fiber: Windows owns
     * that current stack until process exit, so never delete it underneath us. */
    void *current = IsThreadAFiber() ? GetCurrentFiber() : NULL;
    for (int i = 0; i < FWP_STATIC_TASKS; i++) {
        if (fwp_static_fibers[i].fiber != current)
            DeleteFiber(fwp_static_fibers[i].fiber);
        fwp_static_fibers[i].fiber = NULL;
    }
}
static void fwp_static_fibers_init(void) {
    for (int i = 0; i < FWP_STATIC_TASKS; i++) {
        fwp_static_fiber *slot = &fwp_static_fibers[i];
        slot->fiber = CreateFiberEx(FWP_STATIC_TASK_STACK, FWP_STATIC_TASK_STACK,
            FIBER_FLAG_FLOAT_SWITCH, fwp_win_task_entry, slot);
        if (!slot->fiber) fwp_static_full("task stacks", FWP_STATIC_TASK_STACK, "--task-stack");
        SwitchToFiber(slot->fiber);
    }
    if (atexit(fwp_static_fibers_finish)) abort();
}
#else
static void CALLBACK fwp_win_task_entry(void *arg) {
    fwp_task *task = (fwp_task *)arg;
    fwp_win_context_started(&task->ctx);
    fwp_task_main();
    abort();
}
#endif
#endif

static fwp_task *fwp_spawn_task(V thunk, void (*cfn)(void *, int), void *carg, int64_t deadline, int detached) {
    fwp_tasks_init();
    fwp_task *t = fwp_task_new();
    fwp_cleanup task_cleanup;
    fwp_cleanup_push(&task_cleanup, fwp_mem_free, t);
    t->thunk = thunk;
    t->cfn = cfn;
    t->carg = carg;
    t->deadline = deadline;
    t->gctx = fwp_cur->gctx;
#ifdef FWP_GCTX_OWNERS
    void *context_hold = fwp_gctx_acquire ? fwp_gctx_acquire(t->gctx) : 0;
    fwp_cleanup context_cleanup;
    if (context_hold) fwp_cleanup_push(&context_cleanup, fwp_gctx_pending_release, &context_hold);
#endif
    /* Reserve scope storage before allocating the stack. Publish no child
     * or runnable task until all fallible preparation has completed. */
    fwp_scope *s = detached ? 0 : fwp_cur->scope;
    if (s && s->n == s->cap) {
        size_t old = s->cap;
        if (old > SIZE_MAX / 2 / sizeof(fwp_task *)) fwp_trap("task scope too large");
        size_t cap = old ? old * 2 : 8;
        fwp_task **tasks = (fwp_task **)fwp_mem_realloc(s->tasks, old * sizeof(fwp_task *), cap * sizeof(fwp_task *));
        s->tasks = tasks;
        s->cap = cap;
    }
#ifdef _WIN32
#ifdef FWP_STATIC_MEMORY
    if (!fwp_static.ntask_free)
        fwp_static_full("task slots", FWP_STATIC_TASKS * FWP_STATIC_TASK_STACK, "--tasks");
    int slot = fwp_static.task_free[--fwp_static.ntask_free];
    if (fwp_static_fibers[slot].busy) abort();
    fwp_static_fibers[slot].busy = 1;
    t->ctx.fiber = fwp_static_fibers[slot].fiber;
    t->ctx.top = fwp_static_fibers[slot].top;
    int busy = FWP_STATIC_TASKS - fwp_static.ntask_free;
    if (busy > fwp_static.tasks_peak) fwp_static.tasks_peak = busy;
#else
    t->ctx.fiber = CreateFiberEx(65536, FWP_NATIVE_TASK_STACK,
        FIBER_FLAG_FLOAT_SWITCH, fwp_win_task_entry, t);
    if (!t->ctx.fiber) fwp_trap("cannot allocate a task stack");
#endif
#elif defined(FWP_FIBERS)
    if (!fwp_hooks.sw)
        fwp_trap("tasks need a WebAssembly host with JavaScript Promise Integration (JSPI), such as the fwp loader in a recent browser");
    /* WebAssembly keeps most locals off this stack (in the engine's own,
     * which the host gives each fiber), so it can be small */
    t->stack_size = (size_t)1 << 20;
    if (fwp_stack_pool_n > 0) {
        t->stack = fwp_stack_pool[--fwp_stack_pool_n];
    } else {
        t->stack = (char *)malloc(t->stack_size);
        if (!t->stack) fwp_trap("cannot allocate a task stack");
    }
#elif defined(FWP_STATIC_MEMORY)
    t->stack_size = FWP_STATIC_TASK_STACK;
    t->stack = fwp_static_task_stack();
#else
    t->stack_size = FWP_NATIVE_TASK_STACK;
    if (fwp_stack_pool_n > 0) {
        t->stack = fwp_stack_pool[--fwp_stack_pool_n];
    } else {
        t->stack = (char *)mmap(0, t->stack_size, PROT_READ | PROT_WRITE,
                                MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
        if (t->stack == MAP_FAILED) fwp_trap("cannot allocate a task stack");
        mprotect(t->stack, (size_t)sysconf(_SC_PAGESIZE), PROT_NONE); /* guard page */
    }
#endif
    t->gc_next = fwp_gc_tasks;
    if (fwp_gc_tasks) fwp_gc_tasks->gc_prev = t;
    fwp_gc_tasks = t;
#ifdef FWP_OWN_CONTEXT
    {
        /* what fwp_ctx_swap restores: zeroed registers, the default
         * floating-point control, and a return to fwp_ctx_entry, entered
         * as a function is (a 16-byte aligned stack before the call) */
        uintptr_t top = ((uintptr_t)t->stack + t->stack_size) & ~(uintptr_t)15;
        char *sp = (char *)(top - FWP_CTX_FRAME);
        memset(sp, 0, FWP_CTX_FRAME);
#if defined(__x86_64__)
        uint32_t mxcsr = 0x1f80;
        uint16_t fpucw = 0x037f;
        memcpy(sp, &mxcsr, 4);
        memcpy(sp + 4, &fpucw, 2);
#endif
        void (*entry)(void) = fwp_ctx_entry;
        memcpy(sp + FWP_CTX_RET, &entry, sizeof entry);
        t->ctx.sp = sp;
    }
#elif !defined(FWP_FIBERS) && !defined(_WIN32)
    getcontext(&t->ctx);
    t->ctx.uc_stack.ss_sp = t->stack;
    t->ctx.uc_stack.ss_size = t->stack_size;
    t->ctx.uc_link = 0;
    makecontext(&t->ctx, fwp_task_main, 0);
#endif
#ifdef FWP_GCTX_OWNERS
    if (context_hold) {
        t->gctx_owner = context_hold;
        fwp_cleanup_pop(&context_cleanup);
    }
#endif
    if (!detached) {
        t->parent = fwp_cur;
        t->next_sibling = fwp_cur->first_child;
        if (fwp_cur->first_child) fwp_cur->first_child->prev_sibling = t;
        fwp_cur->first_child = t;
        if (fwp_cur->cancelled) t->cancelled = 1;
    }
    if (s) s->tasks[s->n++] = t;
    fwp_cleanup_pop(&task_cleanup);
    fwp_make_ready(t);
    return t;
}

static fwp_task *fwp_spawn(V thunk, int64_t deadline) { return fwp_spawn_task(thunk, 0, 0, deadline, 0); }

static void fwp_root_cancelled(void) {
    fwp_join_children();
    fwp_flush();
    fprintf(stderr, "fwp: the main task was cancelled\n");
    exit(1);
}

/* the end of a root function (main or a test): wait for its tasks */
static void fwp_tasks_finish(void) {
    if (fwp_cur) fwp_join_children();
    /* Root State storage is runtime scratch, not a permanent value owner. */
    if (!fwp_state_len && !fwp_state_owners) {
        fwp_mem_free(fwp_state);
        fwp_state = NULL;
        fwp_state_cap = 0;
        if (fwp_cur) { fwp_cur->st = NULL; fwp_cur->st_cap = 0; }
    }
}

/* a root function failed: cancel its tasks and wait for them */
static void fwp_tasks_abort(void) {
    if (!fwp_cur) return;
    for (fwp_task *c = fwp_cur->first_child; c; c = c->next_sibling) fwp_cancel_tree(c);
    fwp_join_children();
}

static V fwp_opt_result(fwp_task *t) { return t->has_result ? fwp_some(t->result) : FWP_NONE; }

static V fwp_await(fwp_task *t) {
    while (!t->done) {
        fwp_check_cancel();
        fwp_park(&t->waiters, 0);
        fwp_check_cancel();
    }
    return fwp_opt_result(t);
}

static V fwp_p_task_spawn(V thunk) { return PTR(fwp_spawn(thunk, 0)); }

/* Borrowed at the compiler boundary, retained until the task takes it.
 * Protect only the extra reference if stack/scope preparation fails. */
static fwp_task *fwp_spawn_retained(V thunk, int64_t deadline, void (*drop)(V)) {
    if (!fwp_fns[CLO(thunk)->fn].owned) {
        fwp_rc_share(thunk);
        return fwp_spawn(thunk, deadline);
    }
    fwp_rc_dup(thunk);
    fwp_value_owner owner = {thunk, fwp_closure_drop};
    fwp_cleanup cleanup;
    fwp_value_protect(&owner, &cleanup);
    fwp_task *t = fwp_spawn(thunk, deadline);
    t->owns_thunk = 1;
    t->result_drop = drop;
    t->counted = 1;
    fwp_rc_fresh(PTR(t));
    fwp_rc_dup(PTR(t)); /* caller and scheduler */
    if (fwp_cur->scope) fwp_rc_dup(PTR(t)); /* scope task array */
    fwp_value_finish(&owner, &cleanup);
    return t;
}

static V fwp_p_task_spawn_retained(V thunk, void (*drop)(V)) {
    return PTR(fwp_spawn_retained(thunk, 0, drop));
}

static V fwp_p_task_await(V t) {
    fwp_tasks_init();
    return fwp_await((fwp_task *)(uintptr_t)t);
}

static void fwp_task_option_outer_drop(V value) {
    if (fwp_rc_release_last(value)) fwp_rc_free_obj(value);
}
static V fwp_await_owned(fwp_task *t, void (*dup)(V)) {
    V result = fwp_rc_fresh(fwp_await(t));
    if (!result) return result;
    fwp_value_owner owner = {result, fwp_task_option_outer_drop};
    fwp_cleanup cleanup;
    fwp_value_protect(&owner, &cleanup);
    if (dup) dup(OBJ(result)->f[0]);
    return fwp_value_finish(&owner, &cleanup);
}
static V fwp_p_task_await_owned(V t, void (*dup)(V)) {
    fwp_tasks_init();
    return fwp_await_owned((fwp_task *)(uintptr_t)t, dup);
}

static V fwp_p_task_within(V d, V thunk) {
    int64_t at = fwp_after(d);
    return fwp_await(fwp_spawn(thunk, at));
}

static V fwp_p_task_within_retained(V d, V thunk, void (*drop)(V), void (*dup)(V)) {
    int64_t at = fwp_after(d);
    fwp_task *t = fwp_spawn_retained(thunk, at, drop);
    fwp_value_owner owner = {PTR(t), fwp_task_drop};
    fwp_cleanup cleanup;
    fwp_value_protect(&owner, &cleanup);
    V result = fwp_await_owned(t, dup);
    fwp_value_finish(&owner, &cleanup);
    fwp_task_drop(PTR(t));
    return result;
}

static V fwp_p_task_cancel(V t) {
    fwp_tasks_init();
    fwp_cancel_tree((fwp_task *)(uintptr_t)t);
    return FWP_UNIT;
}

static V fwp_p_task_sleep(V d) {
    fwp_tasks_init();
    int64_t at = fwp_after(d);
    for (;;) {
        fwp_check_cancel();
        if (fwp_now_ns() >= at) return FWP_UNIT;
        fwp_park(0, at);
    }
}

static V fwp_p_task_yield(void) {
    fwp_tasks_init();
    fwp_check_cancel();
    fwp_make_ready(fwp_cur);
    fwp_block();
    fwp_check_cancel();
    return FWP_UNIT;
}

static V fwp_p_task_deadline(V d, V x) {
    fwp_tasks_init();
    int64_t at = fwp_after(d);
    if (!fwp_cur->deadline || at < fwp_cur->deadline) fwp_cur->deadline = at;
    return x;
}

static V fwp_p_task_cancelled(void) {
    fwp_tasks_init();
    fwp_task *t = fwp_cur;
    if (t->deadline && !t->cancelled && fwp_now_ns() >= t->deadline) fwp_cancel_tree(t);
    return t->cancelled ? FWP_TRUE : FWP_FALSE;
}

typedef struct { fwp_task *task; fwp_scope *scope; fwp_handler *handlers; } fwp_scope_owner;
static void fwp_scope_release(void *arg) {
    fwp_scope_owner *owner = arg;
    owner->task->scope = owner->scope->prev;
    fwp_handlers = owner->handlers;
    for (size_t i = 0; i < owner->scope->n; i++) fwp_task_drop(PTR(owner->scope->tasks[i]));
    fwp_mem_free(owner->scope->tasks);
    owner->scope->tasks = 0;
}

static V fwp_task_scope_impl(V body, int borrowed, void (*drop)(V)) {
    fwp_tasks_init();
    fwp_task *t = fwp_cur;
    fwp_scope s = {0, 0, 0, t->scope};
    t->scope = &s;
    fwp_scope_owner scope_owner = {t, &s, fwp_handlers};
    fwp_cleanup scope_cleanup;
    fwp_cleanup_push(&scope_cleanup, fwp_scope_release, &scope_owner);
    fwp_value_owner result_owner = {0, drop};
    fwp_cleanup result_cleanup;
    fwp_value_protect(&result_owner, &result_cleanup);
    fwp_handler h;
    h.prev = fwp_handlers;
    h.state_depth = fwp_state_len;
    h.cleanup = fwp_cleanups;
    fwp_handlers = &h;
    V r = 0;
    int failed = 0;
    if (setjmp(h.jb) == 0) {
        V unit = FWP_UNIT;
        r = borrowed ? fwp_apply_borrowed(body, 1, &unit) : fwp_apply1(body, FWP_UNIT);
        result_owner.value = r;
    } else {
        failed = 1;
        fwp_state_restore(h.state_depth);
    }
    fwp_handlers = h.prev;
    t->scope = s.prev;
    if (failed)
        for (size_t i = 0; i < s.n; i++) fwp_cancel_tree(s.tasks[i]);
    int was = t->unwinding;
    t->unwinding = 1;
    for (size_t i = 0; i < s.n; i++) {
        while (!s.tasks[i]->done) {
            if (t->deadline && !t->cancelled && fwp_now_ns() >= t->deadline) fwp_cancel_tree(t);
            fwp_park(&s.tasks[i]->waiters, t->cancelled ? 0 : t->deadline);
        }
    }
    t->unwinding = was;
    if (failed) fwp_fail(h.value, h.desc);
    fwp_check_cancel();
    r = fwp_value_finish(&result_owner, &result_cleanup);
    fwp_cleanup_pop(&scope_cleanup);
    fwp_scope_release(&scope_owner);
    FWP_KEEP_ALIVE(body);
    return r;
}

static V fwp_p_task_scope(V body) { return fwp_task_scope_impl(body, 0, NULL); }
static V fwp_p_task_scope_borrowed(V body, void (*drop)(V)) {
    return fwp_task_scope_impl(body, 1, drop);
}

/* ----- channels */

/* a ring buffer of `size` slots, grown on demand up to the capacity
 * (so a huge capacity costs nothing until the channel fills up) */
typedef struct {
    V *buf;
    size_t cap, size, head, len;
    int closed;
    fwp_wl recvq, sendq;
    /* a channel whose values go to a gRPC stream (a served function's
     * `Channel[T]` parameter): 0 when the stream is closed */
    int (*sink)(void *ctx, V x);
    void *sink_ctx;
    void (*value_drop)(V), (*value_dup)(V);
} fwp_chan;

static V fwp_p_channel_make(V capv) {
    fwp_tasks_init();
    int64_t cap = (int64_t)capv;
    if (cap < 1) cap = 1;
    fwp_chan *c = (fwp_chan *)fwp_mem_alloc(sizeof(fwp_chan));
    c->cap = (size_t)cap;
    return PTR(c);
}

static V fwp_p_channel_make_owned(V cap, void (*drop)(V), void (*dup)(V)) {
    V value = fwp_rc_fresh(fwp_p_channel_make(cap));
    fwp_chan *c = (fwp_chan *)(uintptr_t)value;
    c->value_drop = drop;
    c->value_dup = dup;
    return value;
}

static void fwp_channel_drop(V value) {
    if (!fwp_rc_release_last(value)) return;
    fwp_chan *c = (fwp_chan *)(uintptr_t)value;
    if (c->sendq.head || c->recvq.head) abort();
    if (c->value_drop) for (size_t i = 0; i < c->len; i++) {
        size_t at = (c->head + i) % c->size;
        V element = c->buf[at];
        c->buf[at] = 0;
        c->value_drop(element);
    }
    c->len = 0;
    fwp_mem_free(c->buf);
    c->buf = 0;
    fwp_rc_resource_free_arr(value);
}

static void fwp_chan_grow(fwp_chan *c) {
    size_t n = c->size ? c->size * 2 : 16;
    if (n < c->size || n > c->cap) n = c->cap;
    if (n > SIZE_MAX / sizeof(V)) fwp_trap("out of memory");
    V *b = (V *)fwp_mem_alloc(n * sizeof(V));
    for (size_t i = 0; i < c->len; i++) b[i] = c->buf[(c->head + i) % c->size];
    fwp_mem_free(c->buf);
    c->buf = b;
    c->size = n;
    c->head = 0;
}

static V fwp_p_channel_send(V ch, V x) {
    fwp_tasks_init();
    fwp_chan *c = (fwp_chan *)(uintptr_t)ch;
    if (c->sink) return !c->closed && c->sink(c->sink_ctx, x) ? FWP_TRUE : FWP_FALSE;
    for (;;) {
        if (c->closed) return FWP_FALSE;
        if (c->len < c->cap) {
            if (c->len == c->size) fwp_chan_grow(c);
            c->buf[(c->head + c->len) % c->size] = x;
            c->len++;
            fwp_wake_all(&c->recvq);
            return FWP_TRUE;
        }
        fwp_check_cancel();
        fwp_park(&c->sendq, 0);
        fwp_check_cancel();
    }
}

static V fwp_p_channel_send_owned(V ch, V x, void (*dup)(V)) {
    fwp_tasks_init();
    fwp_chan *c = (fwp_chan *)(uintptr_t)ch;
    if (c->sink) {
        if (c->closed) return FWP_FALSE;
        if (dup) fwp_rc_share(x);
        return c->sink(c->sink_ctx, x) ? FWP_TRUE : FWP_FALSE;
    }
    for (;;) {
        if (c->closed) return FWP_FALSE;
        if (c->len < c->cap) {
            if (c->len == c->size) fwp_chan_grow(c);
            uint8_t *count = fwp_rc_slot(ch);
            if (count && *count) {
                if (c->value_dup) c->value_dup(x);
            } else if (dup) fwp_rc_share(x);
            c->buf[(c->head + c->len) % c->size] = x;
            c->len++;
            fwp_wake_all(&c->recvq);
            return FWP_TRUE;
        }
        fwp_check_cancel();
        fwp_park(&c->sendq, 0);
        fwp_check_cancel();
    }
}

static V fwp_chan_recv(V ch, int64_t at) {
    fwp_tasks_init();
    fwp_chan *c = (fwp_chan *)(uintptr_t)ch;
    for (;;) {
        if (c->len) {
            V x = c->buf[c->head];
            c->buf[c->head] = 0; /* not kept alive by the channel */
            c->head = (c->head + 1) % c->size;
            c->len--;
            fwp_wake_all(&c->sendq);
            return fwp_some(x);
        }
        if (c->closed || c->sink) return FWP_NONE;
        fwp_check_cancel();
        if (at && fwp_now_ns() >= at) return FWP_NONE;
        fwp_park(&c->recvq, at);
        fwp_check_cancel();
    }
}

static V fwp_p_channel_recv(V ch) { return fwp_chan_recv(ch, 0); }
static V fwp_p_channel_recv_for(V d, V ch) { return fwp_chan_recv(ch, fwp_after(d)); }

static V fwp_chan_recv_owned(V ch, int64_t at, void (*dup)(V)) {
    fwp_tasks_init();
    fwp_chan *c = (fwp_chan *)(uintptr_t)ch;
    for (;;) {
        if (c->len) {
            V x = c->buf[c->head];
            uint8_t *count = fwp_rc_slot(ch);
            if ((!count || !*count) && dup) fwp_rc_share(x);
            /* Allocate before removing the queue owner; no fallible operation
             * follows its transfer into this owned Option. */
            V result = fwp_rc_fresh(fwp_some(x));
            c->buf[c->head] = 0;
            c->head = (c->head + 1) % c->size;
            c->len--;
            fwp_wake_all(&c->sendq);
            return result;
        }
        if (c->closed || c->sink) return FWP_NONE;
        fwp_check_cancel();
        if (at && fwp_now_ns() >= at) return FWP_NONE;
        fwp_park(&c->recvq, at);
        fwp_check_cancel();
    }
}
static V fwp_p_channel_recv_owned(V ch, void (*dup)(V)) { return fwp_chan_recv_owned(ch, 0, dup); }
static V fwp_p_channel_recv_for_owned(V d, V ch, void (*dup)(V)) {
    return fwp_chan_recv_owned(ch, fwp_after(d), dup);
}

static V fwp_p_channel_close(V ch) {
    fwp_chan *c = (fwp_chan *)(uintptr_t)ch;
    c->closed = 1;
    fwp_wake_all(&c->recvq);
    fwp_wake_all(&c->sendq);
    return FWP_UNIT;
}

/* ----- sockets */
#ifndef FWP_FIBERS

/* kind: 0 listener, 1 conn, 2 udp; tls: a listener's TLS context, a
 * connection's TLS session (fwp_rt_tls.c), or 0 */
typedef struct { fwp_socket_t fd; int kind; void *tls; uint64_t refs; } fwp_sock;

#ifdef FWP_TLS
/* TLS sessions (fwp_rt_tls.c, embedded in programs that use TLS): like
 * read and send, with -2 for a TLS failure described in fwp_tls_err, and
 * *ww telling which way to wait after EAGAIN (1: to write) */
static char fwp_tls_err[512];
static ssize_t fwp_tls_recv(void *ssl, char *buf, size_t n, int *ww);
static ssize_t fwp_tls_send(void *ssl, const char *buf, size_t n, int *ww);
static void fwp_tls_free(void *ssl);
static void fwp_tls_dispose(void *ssl);
static void fwp_tls_server_drop(void *ctx);
static void *fwp_tls_accepted(void *ctx, fwp_socket_t fd);
#endif

static V fwp_os_error(const char *kind, const char *what, const fwp_desc *d) {
    char buf[1024], message[768];
    int e = errno;
    const char *detail = fwp_socket_message(e, message, sizeof message);
    if (what) snprintf(buf, sizeof buf, "%s: %s (os error %d)", what, detail, e);
    else snprintf(buf, sizeof buf, "%s (os error %d)", detail, e);
    return fwp_io_error(kind, buf, d);
}

/* Wait until fd is ready; 0 when `at` passed first. */
static int fwp_wait_fd(fwp_socket_t fd, int write, int64_t at) {
    fwp_tasks_init();
    fwp_check_cancel();
    if (at && fwp_now_ns() >= at) return 0;
#ifdef __linux__
    if (fwp_epfd < 0) fwp_epfd = epoll_create1(EPOLL_CLOEXEC);
    /* a reader and a writer may wait on the same descriptor (one task
     * reading a connection while another writes to it) */
    fwp_fdw *w = fwp_fdw_get(fd);
    fwp_cur->io_ready = 0;
    fwp_wl_add(write ? &w->wr : &w->rd, fwp_cur);
    if (fwp_fd_sync(fd) != 0) {
        fwp_wl_remove(fwp_cur);
        fwp_fd_sync(fd);
        return 1;
    }
    fwp_io_waiting++;
    fwp_park(0, at); /* removes the task from the wait list */
    fwp_io_waiting--;
    fwp_fd_sync(fd);
    int ready = fwp_cur->io_ready;
#else
    /* poll/WSAPoll scheduler: re-check readiness every 10ms. */
    int ready = 0;
    for (;;) {
#ifdef _WIN32
        WSAPOLLFD p = {fd, (short)(write ? POLLWRNORM : POLLRDNORM), 0};
        int result = WSAPoll(&p, 1, 0);
#else
        struct pollfd p = {fd, (short)(write ? POLLOUT : POLLIN), 0};
        int result = poll(&p, 1, 0);
#endif
        if (result != 0) { ready = 1; break; }
        int64_t slice = fwp_now_ns() + 10000000LL;
        if (at && at < slice) slice = at;
        fwp_io_waiting++;
        fwp_park(0, slice);
        fwp_io_waiting--;
        if (fwp_cur->cancelled || (at && fwp_now_ns() >= at)) break;
    }
#endif
    fwp_check_cancel();
    return ready || !(at && fwp_now_ns() >= at);
}


/* Implicit teardown must not send close_notify or alter host SIGPIPE policy. */
static void fwp_sock_final(void *p) {
    fwp_sock *s = (fwp_sock *)p;
#ifdef FWP_TLS
    if (s->tls) {
        if (s->kind == 0) fwp_tls_server_drop(s->tls);
        else fwp_tls_dispose(s->tls);
        s->tls = 0;
    }
#endif
    if (s->fd != FWP_INVALID_SOCKET) { fwp_fd_closing(s->fd); fwp_socket_close(s->fd); s->fd = FWP_INVALID_SOCKET; }
}

static V fwp_sock_new(fwp_socket_t fd, int kind) {
    fwp_sock *s = kind == 2 ? (fwp_sock *)fwp_alloc_leaf(sizeof(fwp_sock))
                            : (fwp_sock *)fwp_mem_alloc(sizeof(fwp_sock));
    s->fd = fd;
    s->kind = kind;
    s->tls = 0;
    s->refs = kind == 2 ? 1 : 0;
#if defined(FWP_LIBRARY)
    fwp_gc_finalizer(s, fwp_sock_final);
#elif !defined(FWP_ARC_ONLY)
    if (kind == 2) fwp_gc_finalizer(s, fwp_sock_final);
#endif
    return kind == 2 ? fwp_rc_fresh(PTR(s)) : PTR(s);
}

#define SOCK(v) ((fwp_sock *)(uintptr_t)(v))

/* Value owners are independent of conservative allocator sharing. Explicit
 * close changes the shared descriptor; the final owner also closes it. */
static void fwp_udp_dup(V value) {
    if (!value) return;
    fwp_sock *s = SOCK(value);
    if (!s->refs) fwp_trap("internal: duplicate discarded UDP socket");
    if (s->refs == UINT64_MAX) fwp_trap("reference count overflow");
    s->refs++;
}
static void fwp_udp_drop(V value) {
    if (!value) return;
    fwp_sock *s = SOCK(value);
    if (!s->refs || --s->refs) return;
    fwp_sock_final(s);
    fwp_gc_forget_finalizer(s);
#ifndef FWP_RESOURCE_NO_FREE
    if (!fwp_rc_last(value)) return;
    if (fwp_reuse_verify < 0) {
        const char *e = getenv("FWP_REUSE_VERIFY");
        fwp_reuse_verify = e && *e && strcmp(e, "0") != 0;
    }
    /* This leaf has a socket layout, not a String header. Its zero owners and
     * invalid descriptor already expose a later accidental use. */
    if (fwp_reuse_verify) return;
    intptr_t before = fwp_gc.budget;
    fwp_mem_free(s);
    fwp_gc.freed += (double)(fwp_gc.budget - before);
#endif
}

/* split "host:port" (host may be bracketed IPv6); the host must not be
 * empty and the port is a decimal number up to 65535, as in the
 * interpreter */
static int fwp_split_addr(const char *addr, char *host, size_t hn, char *port, size_t pn) {
    const char *colon = strrchr(addr, ':');
    if (!colon) return 0;
    size_t hl = (size_t)(colon - addr);
    const char *h = addr;
    if (hl >= 2 && h[0] == '[' && h[hl - 1] == ']') { h++; hl -= 2; }
    size_t pl = strlen(colon + 1);
    if (hl == 0 || hl >= hn || pl == 0 || pl > 5 || pl >= pn) return 0;
    long pv = 0;
    for (size_t i = 0; i < pl; i++) {
        if (colon[1 + i] < '0' || colon[1 + i] > '9') return 0;
        pv = pv * 10 + (colon[1 + i] - '0');
    }
    if (pv > 65535) return 0;
    memcpy(host, h, hl);
    host[hl] = 0;
    strcpy(port, colon + 1);
    return 1;
}

static struct addrinfo *fwp_resolve(V address, int socktype, int passive, const char *kind,
                                    const fwp_desc *err) {
    const char *addr = STR(address)->d;
    if (memchr(addr, 0, STR(address)->len)) {
        fwp_io_error(kind, "socket address contains a NUL byte", err);
        return NULL;
    }
    if (fwp_sockets_init()) { fwp_os_error(kind, addr, err); return NULL; }
    char host[256], port[32], buf[512];
    if (!fwp_split_addr(addr, host, sizeof host, port, sizeof port)) {
        snprintf(buf, sizeof buf, "%s: invalid socket address", addr);
        fwp_io_error(kind, buf, err);
    }
    struct addrinfo hints, *res = 0;
    memset(&hints, 0, sizeof hints);
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = socktype;
    hints.ai_flags = AI_NUMERICSERV | (passive ? AI_PASSIVE : 0);
    int rc = getaddrinfo(host, port, &hints, &res);
    if (rc != 0) {
        snprintf(buf, sizeof buf, "%s: failed to lookup address information: %s", addr, gai_strerror(rc));
        fwp_io_error(kind, buf, err);
    }
    return res;
}

static void fwp_fmt_addr(const struct sockaddr *sa, char *out, size_t n) {
    char ip[INET6_ADDRSTRLEN];
    if (sa->sa_family == AF_INET) {
        const struct sockaddr_in *a = (const struct sockaddr_in *)sa;
        inet_ntop(AF_INET, &a->sin_addr, ip, sizeof ip);
        snprintf(out, n, "%s:%d", ip, ntohs(a->sin_port));
    } else if (sa->sa_family == AF_INET6) {
        const struct sockaddr_in6 *a = (const struct sockaddr_in6 *)sa;
        inet_ntop(AF_INET6, &a->sin6_addr, ip, sizeof ip);
        snprintf(out, n, "[%s]:%d", ip, ntohs(a->sin6_port));
    } else {
        snprintf(out, n, "?");
    }
}

static V fwp_p_tcp_listen(V addr, const fwp_desc *err) {
    struct addrinfo *res = fwp_resolve(addr, SOCK_STREAM, 1, "listen", err);
    fwp_socket_t fd = FWP_INVALID_SOCKET;
    errno = 0;
    for (struct addrinfo *ai = res; ai; ai = ai->ai_next) {
        fd = fwp_socket_open(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
        if (fd == FWP_INVALID_SOCKET) continue;
        int one = 1;
        setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, (const char *)&one, sizeof one);
        if (fwp_socket_bind(fd, ai->ai_addr, ai->ai_addrlen) == 0 && fwp_socket_listen(fd, 1024) == 0) break;
        int e = errno;
        fwp_socket_close(fd);
        errno = e;
        fd = FWP_INVALID_SOCKET;
    }
    freeaddrinfo(res);
    if (fd == FWP_INVALID_SOCKET) return fwp_os_error("listen", STR(addr)->d, err);
    if (fwp_socket_nonblock(fd)) {
        int error = errno; fwp_socket_close(fd); errno = error;
        return fwp_os_error("listen", STR(addr)->d, err);
    }
    return fwp_sock_new(fd, 0);
}

static V fwp_p_local_addr(V s) {
    struct sockaddr_storage ss;
    socklen_t len = sizeof ss;
    char buf[128] = "";
    if (SOCK(s)->fd != FWP_INVALID_SOCKET && getsockname(SOCK(s)->fd, (struct sockaddr *)&ss, &len) == 0)
        fwp_fmt_addr((struct sockaddr *)&ss, buf, sizeof buf);
    return fwp_cstr(buf);
}

static V fwp_p_peer_addr(V s) {
    struct sockaddr_storage ss;
    socklen_t len = sizeof ss;
    char buf[128] = "";
    if (SOCK(s)->fd != FWP_INVALID_SOCKET && getpeername(SOCK(s)->fd, (struct sockaddr *)&ss, &len) == 0)
        fwp_fmt_addr((struct sockaddr *)&ss, buf, sizeof buf);
    return fwp_cstr(buf);
}

static V fwp_closed_error(const char *what, const fwp_desc *err) {
    char buf[64];
    snprintf(buf, sizeof buf, "%s is closed", what);
    return fwp_io_error("closed", buf, err);
}

/* `at` = 0: no timeout; returns 0 (no connection) on timeout */
static V fwp_accept(V l, int64_t at, const fwp_desc *err) {
    for (;;) {
        fwp_socket_t lfd = SOCK(l)->fd;
        if (lfd == FWP_INVALID_SOCKET) return fwp_closed_error("listener", err);
        fwp_socket_t fd = fwp_socket_accept(lfd, 0, 0);
        if (fd != FWP_INVALID_SOCKET) {
            if (fwp_socket_nonblock(fd)) {
                int error = errno; fwp_socket_close(fd); errno = error;
                return fwp_os_error("accept", 0, err);
            }
            int one = 1;
            setsockopt(fd, IPPROTO_TCP, TCP_NODELAY, (const char *)&one, sizeof one);
            V c = fwp_sock_new(fd, 1);
#ifdef FWP_TLS
            /* the handshake happens on the first read or write, in the
             * task that serves the connection */
            if (SOCK(l)->tls) {
                SOCK(c)->tls = fwp_tls_accepted(SOCK(l)->tls, fd);
                if (!SOCK(c)->tls) {
                    SOCK(c)->fd = FWP_INVALID_SOCKET;
                    fwp_socket_close(fd);
                    return fwp_io_error("tls", fwp_tls_err, err);
                }
            }
#endif
            return c;
        }
        if (fwp_socket_again(errno) || fwp_socket_aborted(errno)) {
            if (!fwp_wait_fd(lfd, 0, at)) return 0;
            continue;
        }
        return fwp_os_error("accept", 0, err);
    }
}

static V fwp_p_tcp_accept(V l, const fwp_desc *err) { return fwp_accept(l, 0, err); }

static V fwp_p_tcp_accept_for(V d, V l, const fwp_desc *err) {
    V c = fwp_accept(l, fwp_after(d), err);
    return c ? fwp_some(c) : FWP_NONE;
}

static V fwp_p_tcp_stop(V l) {
    if (SOCK(l)->fd != FWP_INVALID_SOCKET) {
        fwp_socket_t fd = SOCK(l)->fd;
        SOCK(l)->fd = FWP_INVALID_SOCKET;
        fwp_fd_closing(fd);
        fwp_socket_close(fd);
    }
#ifdef FWP_TLS
    if (SOCK(l)->tls) { fwp_tls_server_drop(SOCK(l)->tls); SOCK(l)->tls = 0; }
#endif
    return FWP_UNIT;
}

static void fwp_addrinfo_release(void *arg) {
    struct addrinfo **result = arg;
    int saved = errno;
    if (*result) freeaddrinfo(*result);
    *result = NULL;
    errno = saved;
}
typedef struct { fwp_socket_t fd; struct addrinfo *addresses; } fwp_connect_owner;
static void fwp_connect_finish(void *p) {
    fwp_connect_owner *owner = (fwp_connect_owner *)p;
    int saved = errno;
    if (owner->fd != FWP_INVALID_SOCKET) {
        fwp_socket_t fd = owner->fd;
        owner->fd = FWP_INVALID_SOCKET;
        fwp_fd_closing(fd);
        fwp_socket_close(fd);
    }
    if (owner->addresses) { freeaddrinfo(owner->addresses); owner->addresses = 0; }
    errno = saved;
}

static V fwp_p_tcp_connect(V addr, const fwp_desc *err) {
    fwp_tasks_init();
    fwp_check_cancel();
    fwp_connect_owner owner = {FWP_INVALID_SOCKET, 0};
    fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup, fwp_connect_finish, &owner);
    struct addrinfo *res = fwp_resolve(addr, SOCK_STREAM, 0, "connect", err);
    owner.addresses = res;
    fwp_socket_t fd = FWP_INVALID_SOCKET;
    errno = 0;
    for (struct addrinfo *ai = res; ai; ai = ai->ai_next) {
        fd = fwp_socket_open(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
        owner.fd = fd;
        if (fd == FWP_INVALID_SOCKET) continue;
        if (fwp_socket_nonblock(fd)) {
            int error = errno; fwp_socket_close(fd); errno = error;
            owner.fd = fd = FWP_INVALID_SOCKET;
            continue;
        }
        if (fwp_socket_connect(fd, ai->ai_addr, ai->ai_addrlen) == 0) break;
        if (fwp_socket_pending(errno)) {
            fwp_wait_fd(fd, 1, 0);
            if (fwp_socket_connect_error(fd) == 0) break;
        }
        int e = errno;
        owner.fd = FWP_INVALID_SOCKET;
        fwp_fd_closing(fd);
        fwp_socket_close(fd);
        errno = e;
        fd = FWP_INVALID_SOCKET;
    }
    freeaddrinfo(res);
    owner.addresses = 0;
    if (fd == FWP_INVALID_SOCKET) {
        fwp_cleanup_pop(&cleanup);
        return fwp_os_error("connect", STR(addr)->d, err);
    }
    int one = 1;
    setsockopt(fd, IPPROTO_TCP, TCP_NODELAY, (const char *)&one, sizeof one);
    V result = fwp_sock_new(fd, 1);
    owner.fd = FWP_INVALID_SOCKET; /* the socket wrapper now owns it */
    fwp_cleanup_pop(&cleanup);
    return result;
}

/* returns 0 on timeout */
static V fwp_tcp_read(V nv, V c, int64_t at, const fwp_desc *err) {
    int64_t n = (int64_t)nv;
    if (n < 1) n = 1;
    char *buf = (char *)malloc((size_t)n);
    if (!buf) fwp_trap("socket receive allocation failed");
    fwp_cleanup buffer_cleanup;
    fwp_cleanup_push(&buffer_cleanup, free, buf);
    for (;;) {
        fwp_socket_t fd = SOCK(c)->fd;
        if (fd == FWP_INVALID_SOCKET) { fwp_cleanup_pop(&buffer_cleanup); free(buf); return fwp_closed_error("connection", err); }
        int ww = 0;
        ssize_t k;
#ifdef FWP_TLS
        if (SOCK(c)->tls) k = fwp_tls_recv(SOCK(c)->tls, buf, (size_t)n, &ww);
        else
#endif
            k = fwp_socket_recv(fd, buf, (size_t)n, 0);
        if (k >= 0) {
            V r = fwp_str_new(buf, (size_t)k);
            fwp_cleanup_pop(&buffer_cleanup); free(buf);
            return r;
        }
#ifdef FWP_TLS
        if (k == -2) { fwp_cleanup_pop(&buffer_cleanup); free(buf); return fwp_io_error("tls", fwp_tls_err, err); }
#endif
        if (fwp_socket_again(errno)) {
            if (!fwp_wait_fd(fd, ww, at)) { fwp_cleanup_pop(&buffer_cleanup); free(buf); return 0; }
            continue;
        }
        fwp_cleanup_pop(&buffer_cleanup); free(buf);
        return fwp_os_error("read", 0, err);
    }
}

static V fwp_p_tcp_read(V n, V c, const fwp_desc *err) { return fwp_tcp_read(n, c, 0, err); }

static V fwp_p_tcp_read_for(V d, V n, V c, const fwp_desc *err) {
    V r = fwp_tcp_read(n, c, fwp_after(d), err);
    return r ? fwp_some(r) : FWP_NONE;
}

/* `at` = 0: no timeout; a "timeout" error when it passes first */
static V fwp_tcp_write(V data, V c, int64_t at, const fwp_desc *err) {
    size_t off = 0, len = STR(data)->len;
    while (off < len) {
        fwp_socket_t fd = SOCK(c)->fd;
        if (fd == FWP_INVALID_SOCKET) return fwp_closed_error("connection", err);
        int ww = 1;
        ssize_t k;
#ifdef FWP_TLS
        if (SOCK(c)->tls) k = fwp_tls_send(SOCK(c)->tls, STR(data)->d + off, len - off, &ww);
        else
#endif
            k = fwp_socket_send(fd, STR(data)->d + off, len - off, MSG_NOSIGNAL);
        if (k > 0) { off += (size_t)k; continue; }
#ifdef FWP_TLS
        if (k == -2) return fwp_io_error("tls", fwp_tls_err, err);
#endif
        if (k < 0 && (fwp_socket_again(errno))) {
            if (!fwp_wait_fd(fd, ww, at)) return fwp_io_error("timeout", "write timed out", err);
            continue;
        }
        if (k == 0) return fwp_io_error("write", "connection closed by peer", err);
        return fwp_os_error("write", 0, err);
    }
    return FWP_UNIT;
}

static V fwp_p_tcp_write(V data, V c, const fwp_desc *err) { return fwp_tcp_write(data, c, 0, err); }

static V fwp_p_tcp_write_for(V d, V data, V c, const fwp_desc *err) {
    return fwp_tcp_write(data, c, fwp_after(d), err);
}

static V fwp_p_sock_close(V c) {
    if (SOCK(c)->fd != FWP_INVALID_SOCKET) {
        fwp_socket_t fd = SOCK(c)->fd;
        SOCK(c)->fd = FWP_INVALID_SOCKET;
        fwp_fd_closing(fd);
#ifdef FWP_TLS
        if (SOCK(c)->kind == 1 && SOCK(c)->tls) { fwp_tls_free(SOCK(c)->tls); SOCK(c)->tls = 0; }
#endif
        if (SOCK(c)->kind == 1) shutdown(fd, SHUT_RDWR);
        fwp_socket_close(fd);
    }
    return FWP_UNIT;
}

static V fwp_p_udp_bind(V addr, const fwp_desc *err) {
    struct addrinfo *res = fwp_resolve(addr, SOCK_DGRAM, 1, "bind", err);
    fwp_socket_t fd = FWP_INVALID_SOCKET;
    errno = 0;
    for (struct addrinfo *ai = res; ai; ai = ai->ai_next) {
        fd = fwp_socket_open(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
        if (fd == FWP_INVALID_SOCKET) continue;
        if (fwp_socket_bind(fd, ai->ai_addr, ai->ai_addrlen) == 0) break;
        int e = errno;
        fwp_socket_close(fd);
        errno = e;
        fd = FWP_INVALID_SOCKET;
    }
    freeaddrinfo(res);
    if (fd == FWP_INVALID_SOCKET) return fwp_os_error("bind", STR(addr)->d, err);
    if (fwp_socket_nonblock(fd)) {
        int error = errno; fwp_socket_close(fd); errno = error;
        return fwp_os_error("bind", STR(addr)->d, err);
    }
    fwp_connect_owner owner = {fd, NULL};
    fwp_cleanup cleanup; fwp_cleanup_push(&cleanup, fwp_connect_finish, &owner);
    V result = fwp_sock_new(fd, 2);
    owner.fd = FWP_INVALID_SOCKET;
    fwp_cleanup_pop(&cleanup);
    FWP_KEEP_ALIVE(addr);
    return result;
}

static V fwp_p_udp_send_to(V addr, V data, V s, const fwp_desc *err) {
    struct addrinfo *res = fwp_resolve(addr, SOCK_DGRAM, 0, "send", err);
    fwp_cleanup address_cleanup;
    fwp_cleanup_push(&address_cleanup, fwp_addrinfo_release, &res);
    for (;;) {
        fwp_socket_t fd = SOCK(s)->fd;
        if (fd == FWP_INVALID_SOCKET) { fwp_cleanup_pop(&address_cleanup); fwp_addrinfo_release(&res); return fwp_closed_error("socket", err); }
        ssize_t k = fwp_socket_sendto(fd, STR(data)->d, STR(data)->len, 0, res->ai_addr, res->ai_addrlen);
        if (k >= 0) break;
        if (fwp_socket_again(errno)) {
            fwp_wait_fd(fd, 1, 0);
            continue;
        }
        fwp_cleanup_pop(&address_cleanup); fwp_addrinfo_release(&res);
        return fwp_os_error("send", STR(addr)->d, err);
    }
    fwp_cleanup_pop(&address_cleanup); fwp_addrinfo_release(&res);
    return FWP_UNIT;
}



#endif /* !FWP_FIBERS */

/* ----- signals (WebAssembly has none: only a requested shutdown) */

#ifdef FWP_FIBERS
static V fwp_p_shutdown_requested(void) { return fwp_shutdown ? FWP_TRUE : FWP_FALSE; }
#elif defined(_WIN32)
static BOOL WINAPI fwp_on_console_signal(DWORD signal) {
    if (signal != CTRL_C_EVENT && signal != CTRL_BREAK_EVENT && signal != CTRL_CLOSE_EVENT)
        return FALSE;
    fwp_shutdown = 1;
    return TRUE;
}

static V fwp_p_shutdown_requested(void) {
    if (!fwp_signals_installed) {
        if (!SetConsoleCtrlHandler(fwp_on_console_signal, TRUE))
            fwp_trap("cannot install shutdown handler");
        fwp_signals_installed = 1;
    }
    return fwp_shutdown ? FWP_TRUE : FWP_FALSE;
}
#else
static void fwp_on_signal(int sig) {
    (void)sig;
    fwp_shutdown = 1;
}

static V fwp_p_shutdown_requested(void) {
    if (!fwp_signals_installed) {
        fwp_signals_installed = 1;
#ifdef FWP_LIBRARY
        struct sigaction action;
        memset(&action, 0, sizeof action);
        action.sa_handler = fwp_on_signal;
        action.sa_flags = SA_RESTART;
        sigemptyset(&action.sa_mask);
        fwp_saved_sigint = sigaction(SIGINT, &action, &fwp_prior_sigint) == 0;
        fwp_saved_sigterm = sigaction(SIGTERM, &action, &fwp_prior_sigterm) == 0;
#else
        signal(SIGINT, fwp_on_signal);
        signal(SIGTERM, fwp_on_signal);
#endif
    }
    return fwp_shutdown ? FWP_TRUE : FWP_FALSE;
}
#endif

static V fwp_p_request_shutdown(void) {
    fwp_shutdown = 1;
    return FWP_UNIT;
}

/* ----- metrics: name -> (kind, value), listed in name order */

typedef struct { char *name; size_t len; const char *kind; double x; } fwp_metric;
static fwp_metric *fwp_metrics = 0;
static size_t fwp_nmetrics = 0, fwp_metrics_cap = 0;
static void fwp_metrics_finish(void);

/* The registry owns name bytes for its lifetime. Observation suffixes are
 * compared/copied directly, without allocating a temporary joined name. */
static fwp_metric *fwp_metric_get(const char *name, size_t len,
        const char *suffix, size_t suffix_len, const char *kind) {
    if (len == SIZE_MAX || suffix_len > SIZE_MAX - len - 1) fwp_trap("out of memory");
#ifndef FWP_LIBRARY
    static int registered_finish;
    if (!registered_finish) {
        if (atexit(fwp_metrics_finish)) fwp_trap("cannot register metrics cleanup");
        registered_finish = 1;
    }
#endif
    size_t total = len + suffix_len;
    for (size_t i = 0; i < fwp_nmetrics; i++)
        if (fwp_metrics[i].len == total && !memcmp(fwp_metrics[i].name, name, len) &&
                !memcmp(fwp_metrics[i].name + len, suffix, suffix_len))
            return &fwp_metrics[i];
    if (fwp_nmetrics == fwp_metrics_cap) {
        if (fwp_metrics_cap > SIZE_MAX / sizeof(fwp_metric) / 2) fwp_trap("out of memory");
        size_t cap = fwp_metrics_cap ? fwp_metrics_cap * 2 : 16;
        fwp_metric *next = (fwp_metric *)realloc(fwp_metrics, cap * sizeof(fwp_metric));
        if (!next) fwp_trap("out of memory");
        fwp_metrics = next;
        fwp_metrics_cap = cap;
    }
    char *copy = (char *)malloc(total + 1);
    if (!copy) fwp_trap("out of memory");
    memcpy(copy, name, len);
    memcpy(copy + len, suffix, suffix_len);
    copy[total] = 0;
    fwp_metric *m = &fwp_metrics[fwp_nmetrics++];
    m->name = copy;
    m->len = total;
    m->kind = kind;
    m->x = 0;
    return m;
}

static V fwp_p_metrics_update(int op, V name, V xv) {
    double x = fwp_f64(xv);
    const char *n = STR(name)->d;
    size_t len = STR(name)->len;
    if (op == 0) fwp_metric_get(n, len, "", 0, "counter")->x += x;
    else if (op == 1) {
        fwp_metric *m = fwp_metric_get(n, len, "", 0, "gauge");
        m->kind = "gauge";
        m->x = x;
    } else {
        fwp_metric_get(n, len, "_count", 6, "summary")->x += 1;
        fwp_metric_get(n, len, "_sum", 4, "summary")->x += x;
    }
    FWP_KEEP_ALIVE(name);
    return FWP_UNIT;
}

static int fwp_metric_cmp(const void *a, const void *b) {
    const fwp_metric *x = a, *y = b;
    size_t n = x->len < y->len ? x->len : y->len;
    int order = memcmp(x->name, y->name, n);
    return order ? order : (x->len > y->len) - (x->len < y->len);
}

static void fwp_metrics_finish(void) {
    for (size_t i = 0; i < fwp_nmetrics; i++) free(fwp_metrics[i].name);
    free(fwp_metrics);
    fwp_metrics = 0;
    fwp_nmetrics = fwp_metrics_cap = 0;
}

#if defined(FWP_LIBRARY) && !defined(FWP_FIBERS)
static void fwp_library_tasks_finish(void) {
    if (fwp_cur && fwp_cur != fwp_root) abort();
    if (fwp_root) {
        fwp_root->unwinding = 1;
        /* Detached runtime tasks are not root children, but still have stacks
         * in this list. Cancel all of them before disposing any mapping. */
        for (fwp_task *t = fwp_gc_tasks; t; t = t->gc_next) fwp_cancel_tree(t);
        while (fwp_gc_tasks) {
            fwp_make_ready(fwp_root);
            fwp_block();
            fwp_free_zombie();
        }
    }
    fwp_free_zombie();
#ifdef _WIN32
    if (fwp_root) fwp_win_context_root_finish(&fwp_root->ctx);
#elif !defined(FWP_STATIC_MEMORY)
    while (fwp_stack_pool_n) munmap(fwp_stack_pool[--fwp_stack_pool_n], FWP_NATIVE_TASK_STACK);
#endif
#ifndef _WIN32
    if (fwp_epfd >= 0) close(fwp_epfd);
#endif
    fwp_epfd = -1;
#ifdef __linux__
    fwp_fdws = 0;
    fwp_nfdws = 0;
    fwp_live_fdws = 0;
#endif
    fwp_io_waiting = 0;
    fwp_cur = fwp_root = fwp_zombie = 0;
    fwp_gc_tasks = fwp_ready_head = fwp_ready_tail = fwp_timers = 0;
    fwp_cleanups = 0;
    fwp_foreign_callbacks = 0;
    fwp_handlers = 0;
    fwp_state = 0;
    fwp_state_len = fwp_state_cap = 0;
    fwp_state_owners = 0;
#ifdef _WIN32
    if (fwp_signals_installed) SetConsoleCtrlHandler(fwp_on_console_signal, FALSE);
    fwp_signals_installed = 0;
#else
    struct sigaction current;
    if (fwp_saved_sigint && sigaction(SIGINT, 0, &current) == 0 &&
        !(current.sa_flags & SA_SIGINFO) && current.sa_handler == fwp_on_signal)
        sigaction(SIGINT, &fwp_prior_sigint, 0);
    if (fwp_saved_sigterm && sigaction(SIGTERM, 0, &current) == 0 &&
        !(current.sa_flags & SA_SIGINFO) && current.sa_handler == fwp_on_signal)
        sigaction(SIGTERM, &fwp_prior_sigterm, 0);
    fwp_saved_sigint = fwp_saved_sigterm = fwp_signals_installed = 0;
#endif
    fwp_shutdown = 0;
    fwp_metrics_finish();
}
#endif

/* ----- stack overflow */

#ifdef FWP_FIBERS
/* the engine reports an exhausted stack (web/fibers.js and the loaders) */
static void fwp_stack_guard_init(size_t size) { (void)size; }
#elif defined(_WIN32)
static LONG CALLBACK fwp_stack_exception(EXCEPTION_POINTERS *exception) {
    if (exception->ExceptionRecord->ExceptionCode != EXCEPTION_STACK_OVERFLOW)
        return EXCEPTION_CONTINUE_SEARCH;
    static const char message[] = "fwp: trap: stack overflow\n";
    DWORD written;
    WriteFile(GetStdHandle(STD_ERROR_HANDLE), message, sizeof message - 1, &written, NULL);
    ExitProcess(101);
}

static void fwp_stack_guard_init(size_t size) {
    (void)size;
    ULONG guarantee = 65536;
    if (!SetThreadStackGuarantee(&guarantee) || !AddVectoredExceptionHandler(1, fwp_stack_exception))
        fwp_trap("cannot install stack overflow handler");
}
#else
/*
 * A fault next to the end of the running stack (the main thread's, of
 * fwp_main_stack_size bytes below fwp_main_stack_top, or the current
 * task's) is a stack overflow: it is reported as a trap, with the message
 * and exit code of the interpreter. Other faults keep their default
 * action. The handler runs on an alternate signal stack. */

static char *fwp_main_stack_top = 0;
static size_t fwp_main_stack_size = 0;

static int fwp_near(uintptr_t a, uintptr_t lo, uintptr_t hi) { return a >= lo && a < hi; }

static void fwp_segv(int sig, siginfo_t *si, void *uc) {
    (void)uc;
    uintptr_t a = (uintptr_t)si->si_addr, slack = (uintptr_t)1 << 20;
    int overflow = 0;
    if (fwp_cur && fwp_cur->stack) {
        uintptr_t lo = (uintptr_t)fwp_cur->stack;
        overflow = fwp_near(a, lo > slack ? lo - slack : 0, lo + (uintptr_t)sysconf(_SC_PAGESIZE));
    } else if (fwp_main_stack_top) {
        uintptr_t end = (uintptr_t)fwp_main_stack_top - fwp_main_stack_size;
        overflow = fwp_near(a, end - slack, end + slack);
    }
    if (!overflow) {
        signal(sig, SIG_DFL); /* the fault repeats with the default action */
        return;
    }
    fwp_flush();
    static const char msg[] = "fwp: trap: stack overflow\n";
    if (write(2, msg, sizeof msg - 1) < 0) { /* nothing more to do */ }
    _exit(101);
}

/* called at the top of the main thread, whose stack has `size` bytes */
static void fwp_stack_guard_init(size_t size) {
    char here;
    fwp_main_stack_top = &here;
    fwp_main_stack_size = size;
    static char alt[1 << 16];
    stack_t ss;
    ss.ss_sp = alt;
    ss.ss_size = sizeof alt;
    ss.ss_flags = 0;
    if (sigaltstack(&ss, 0) != 0) return;
    struct sigaction sa;
    memset(&sa, 0, sizeof sa);
    sa.sa_sigaction = fwp_segv;
    sa.sa_flags = SA_SIGINFO | SA_ONSTACK;
    sigemptyset(&sa.sa_mask);
    sigaction(SIGSEGV, &sa, 0);
    sigaction(SIGBUS, &sa, 0);
}
#endif /* FWP_FIBERS */
