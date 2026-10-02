/* Structured concurrency, networking and metrics.
 *
 * Tasks are green threads (ucontext) on one OS thread, scheduled
 * cooperatively: a task runs until it suspends on a timer, a channel,
 * another task or a socket. Sockets are non-blocking; a task waiting for
 * one is parked on an event loop (epoll on Linux, poll elsewhere).
 *
 * Tasks form a tree: a task finishes only after its children finished, and
 * cancelling a task cancels its subtree. A cancelled task unwinds (longjmp
 * to its base) at its next suspension point. Each task has its own Error
 * handler chain and State stack, swapped in and out with the task. */

#ifdef __wasi__
/* no tasks or sockets on WASI: programs using them are rejected when
 * compiling for that target */
static void fwp_tasks_finish(void) {}
static void fwp_tasks_abort(void) {}
static void fwp_stack_guard_init(size_t size) { (void)size; }
#else
#include <ucontext.h>
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
#include <limits.h>
#ifdef __linux__
#include <sys/epoll.h>
#endif
#ifndef MSG_NOSIGNAL
#define MSG_NOSIGNAL 0
#endif

typedef struct fwp_task fwp_task;

/* a list of parked tasks */
typedef struct { fwp_task *head; } fwp_wl;

struct fwp_task {
    ucontext_t ctx;
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
    jmp_buf base;
    /* saved runtime state */
    fwp_handler *handlers;
    V *st;
    size_t st_len, st_cap;
    struct fwp_scope *scope;
    /* a task running C code (gRPC connections and calls): called with 0,
     * then again with 1 if the task was cancelled while running it */
    void (*cfn)(void *arg, int cancelled);
    void *carg;
    jmp_buf *trap_jb;           /* traps recovered here (a served call) */
    void *gctx;                 /* gRPC context, inherited by children */
    /* links */
    fwp_task *next_ready;
    fwp_task *tprev, *tnext;    /* timer list */
    fwp_wl *wl;                 /* list this task is parked on */
    fwp_task *wprev, *wnext;
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
static volatile sig_atomic_t fwp_shutdown = 0;
static int fwp_signals_installed = 0;

static int64_t fwp_now_ns(void) {
    struct timespec t;
    clock_gettime(CLOCK_MONOTONIC, &t);
    return (int64_t)t.tv_sec * 1000000000LL + t.tv_nsec;
}

static int64_t fwp_dur_ns(V d) { return (int64_t)OBJ(d)->f[0]; }

/* the monotonic time a duration from now, saturating instead of
 * overflowing for very long durations */
static int64_t fwp_after(V d) {
    int64_t n = fwp_dur_ns(d), now = fwp_now_ns();
    if (n <= 0) return now;
    return n > INT64_MAX - now ? INT64_MAX : now + n;
}

static fwp_task *fwp_task_new(void) {
    fwp_task *t = (fwp_task *)calloc(1, sizeof(fwp_task));
    if (!t) { fprintf(stderr, "fwp: out of memory\n"); exit(102); }
    return t;
}

static void fwp_tasks_init(void) {
    if (fwp_cur) return;
    fwp_root = fwp_task_new();
    fwp_cur = fwp_root;
}

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
static size_t fwp_nfdws = 0;

static fwp_fdw *fwp_fdw_get(int fd) {
    if ((size_t)fd >= fwp_nfdws) {
        size_t n = fwp_nfdws ? fwp_nfdws : 64;
        while (n <= (size_t)fd) n *= 2;
        fwp_fdws = (fwp_fdw **)realloc(fwp_fdws, n * sizeof(fwp_fdw *));
        if (!fwp_fdws) { fprintf(stderr, "fwp: out of memory\n"); exit(102); }
        memset(fwp_fdws + fwp_nfdws, 0, (n - fwp_nfdws) * sizeof(fwp_fdw *));
        fwp_nfdws = n;
    }
    if (!fwp_fdws[fd]) {
        fwp_fdws[fd] = (fwp_fdw *)calloc(1, sizeof(fwp_fdw));
        if (!fwp_fdws[fd]) { fprintf(stderr, "fwp: out of memory\n"); exit(102); }
    }
    return fwp_fdws[fd];
}

/* register the events the descriptor's waiters need; -1 if epoll refuses
 * the descriptor */
static int fwp_fd_sync(int fd) {
    fwp_fdw *w = fwp_fdw_get(fd);
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
static void fwp_fd_closing(int fd) {
#ifdef __linux__
    if (fd < 0 || (size_t)fd >= fwp_nfdws || !fwp_fdws[fd]) return;
    fwp_fdw *w = fwp_fdws[fd];
    if (w->mask) epoll_ctl(fwp_epfd, EPOLL_CTL_DEL, fd, 0);
    w->mask = 0;
    fwp_wake_io(&w->rd);
    fwp_wake_io(&w->wr);
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

/* ----- switching */

/* stacks of finished tasks, kept for reuse */
static char *fwp_stack_pool[64];
static int fwp_stack_pool_n = 0;

static void fwp_free_zombie(void) {
    if (fwp_zombie && fwp_zombie != fwp_cur) {
        if (fwp_stack_pool_n < 64) fwp_stack_pool[fwp_stack_pool_n++] = fwp_zombie->stack;
        else munmap(fwp_zombie->stack, fwp_zombie->stack_size);
        fwp_zombie->stack = 0;
        fwp_zombie = 0;
    }
}

static void fwp_switch(fwp_task *to) {
    fwp_task *from = fwp_cur;
    if (to == from) return;
    from->handlers = fwp_handlers;
    from->st = fwp_state;
    from->st_len = fwp_state_len;
    from->st_cap = fwp_state_cap;
    fwp_cur = to;
    fwp_handlers = to->handlers;
    fwp_state = to->st;
    fwp_state_len = to->st_len;
    fwp_state_cap = to->st_cap;
    swapcontext(&from->ctx, &to->ctx);
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
#ifdef __linux__
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

/* Run other tasks until the current one is made ready again. */
static void fwp_block(void) {
    for (;;) {
        fwp_task *t = fwp_dequeue();
        if (t) {
            if (t != fwp_cur) fwp_switch(t);
            return;
        }
        fwp_poll_events();
    }
}

static void fwp_root_cancelled(void);

/* Unwind if the current task was cancelled (or its deadline passed). */
static void fwp_check_cancel(void) {
    fwp_task *t = fwp_cur;
    if (!t || t->unwinding) return;
    if (t->deadline && !t->cancelled && fwp_now_ns() >= t->deadline) fwp_cancel_tree(t);
    if (!t->cancelled) return;
    if (t == fwp_root) fwp_root_cancelled();
    longjmp(t->base, 1);
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

static void fwp_task_main(void) {
    fwp_free_zombie();
    fwp_task *t = fwp_cur;
    if (setjmp(t->base) == 0) {
        if (t->cfn) {
            t->cfn(t->carg, 0);
        } else {
            fwp_check_cancel();
            t->result = fwp_apply1(t->thunk, FWP_UNIT);
            t->has_result = 1;
        }
    } else if (t->cfn) {
        t->unwinding = 1;
        fwp_handlers = 0;
        fwp_state_len = 0;
        t->trap_jb = 0;
        t->cfn(t->carg, 1);
    }
    t->unwinding = 1;
    fwp_handlers = 0;
    fwp_join_children();
    t->done = 1;
    fwp_wake_all(&t->waiters);
    fwp_unlink_child(t);
    fwp_zombie = t;
    for (;;) {
        fwp_task *n = fwp_dequeue();
        if (n && n != t) fwp_switch(n);
        else if (!n) fwp_poll_events();
    }
}

/* Start a task running `thunk`, or `cfn(carg)` when `cfn` is set. A
 * detached task is not a child of the current one: nothing waits for it
 * or cancels it. */
static fwp_task *fwp_spawn_task(V thunk, void (*cfn)(void *, int), void *carg, int64_t deadline, int detached) {
    fwp_tasks_init();
    fwp_task *t = fwp_task_new();
    t->thunk = thunk;
    t->cfn = cfn;
    t->carg = carg;
    t->deadline = deadline;
    t->gctx = fwp_cur->gctx;
    fwp_scope *s = 0;
    if (!detached) {
        t->parent = fwp_cur;
        t->next_sibling = fwp_cur->first_child;
        if (fwp_cur->first_child) fwp_cur->first_child->prev_sibling = t;
        fwp_cur->first_child = t;
        if (fwp_cur->cancelled) t->cancelled = 1;
        s = fwp_cur->scope;
    }
    if (s) {
        if (s->n == s->cap) {
            s->cap = s->cap ? s->cap * 2 : 8;
            s->tasks = (fwp_task **)realloc(s->tasks, s->cap * sizeof(fwp_task *));
        }
        s->tasks[s->n++] = t;
    }
    t->stack_size = (size_t)256 << 20;
    if (fwp_stack_pool_n > 0) {
        t->stack = fwp_stack_pool[--fwp_stack_pool_n];
    } else {
        t->stack = (char *)mmap(0, t->stack_size, PROT_READ | PROT_WRITE,
                                MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
        if (t->stack == MAP_FAILED) fwp_trap("cannot allocate a task stack");
        mprotect(t->stack, 4096, PROT_NONE); /* guard page */
    }
    getcontext(&t->ctx);
    t->ctx.uc_stack.ss_sp = t->stack;
    t->ctx.uc_stack.ss_size = t->stack_size;
    t->ctx.uc_link = 0;
    makecontext(&t->ctx, fwp_task_main, 0);
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
    if (!fwp_cur) return;
    fwp_join_children();
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

static V fwp_p_task_await(V t) {
    fwp_tasks_init();
    return fwp_await((fwp_task *)(uintptr_t)t);
}

static V fwp_p_task_within(V d, V thunk) {
    int64_t at = fwp_after(d);
    return fwp_await(fwp_spawn(thunk, at));
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

static V fwp_p_task_scope(V body) {
    fwp_tasks_init();
    fwp_task *t = fwp_cur;
    fwp_scope s = {0, 0, 0, t->scope};
    t->scope = &s;
    fwp_handler h;
    h.prev = fwp_handlers;
    h.state_depth = fwp_state_len;
    fwp_handlers = &h;
    V r = 0;
    int failed = 0;
    if (setjmp(h.jb) == 0) {
        r = fwp_apply1(body, FWP_UNIT);
    } else {
        failed = 1;
        fwp_state_len = h.state_depth;
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
    free(s.tasks);
    if (failed) fwp_fail(h.value, h.desc);
    fwp_check_cancel();
    return r;
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
} fwp_chan;

static V fwp_p_channel_make(V capv) {
    fwp_tasks_init();
    int64_t cap = (int64_t)capv;
    if (cap < 1) cap = 1;
    fwp_chan *c = (fwp_chan *)calloc(1, sizeof(fwp_chan));
    if (!c) fwp_trap("out of memory");
    c->cap = (size_t)cap;
    return PTR(c);
}

static void fwp_chan_grow(fwp_chan *c) {
    size_t n = c->size ? c->size * 2 : 16;
    if (n < c->size || n > c->cap) n = c->cap;
    if (n > SIZE_MAX / sizeof(V)) fwp_trap("out of memory");
    V *b = (V *)malloc(n * sizeof(V));
    if (!b) fwp_trap("out of memory");
    for (size_t i = 0; i < c->len; i++) b[i] = c->buf[(c->head + i) % c->size];
    free(c->buf);
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

static V fwp_chan_recv(V ch, int64_t at) {
    fwp_tasks_init();
    fwp_chan *c = (fwp_chan *)(uintptr_t)ch;
    for (;;) {
        if (c->len) {
            V x = c->buf[c->head];
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

static V fwp_p_channel_close(V ch) {
    fwp_chan *c = (fwp_chan *)(uintptr_t)ch;
    c->closed = 1;
    fwp_wake_all(&c->recvq);
    fwp_wake_all(&c->sendq);
    return FWP_UNIT;
}

/* ----- sockets */

typedef struct { int fd; int kind; } fwp_sock; /* kind: 0 listener, 1 conn, 2 udp */

static V fwp_os_error(const char *kind, const char *what, const fwp_desc *d) {
    char buf[1024];
    int e = errno;
    if (what) snprintf(buf, sizeof buf, "%s: %s (os error %d)", what, strerror(e), e);
    else snprintf(buf, sizeof buf, "%s (os error %d)", strerror(e), e);
    return fwp_io_error(kind, buf, d);
}

/* Wait until fd is ready; 0 when `at` passed first. */
static int fwp_wait_fd(int fd, int write, int64_t at) {
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
    /* poll fallback: re-check every 10ms */
    int ready = 0;
    for (;;) {
        struct pollfd p = {fd, (short)(write ? POLLOUT : POLLIN), 0};
        if (poll(&p, 1, 0) > 0) { ready = 1; break; }
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

static void fwp_nonblock(int fd) {
    int fl = fcntl(fd, F_GETFL, 0);
    fcntl(fd, F_SETFL, fl | O_NONBLOCK);
    fcntl(fd, F_SETFD, FD_CLOEXEC);
}

static V fwp_sock_new(int fd, int kind) {
    fwp_sock *s = (fwp_sock *)malloc(sizeof(fwp_sock));
    s->fd = fd;
    s->kind = kind;
    return PTR(s);
}

#define SOCK(v) ((fwp_sock *)(uintptr_t)(v))

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

static struct addrinfo *fwp_resolve(const char *addr, int socktype, int passive, const char *kind,
                                    const fwp_desc *err) {
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
    struct addrinfo *res = fwp_resolve(STR(addr)->d, SOCK_STREAM, 1, "listen", err);
    int fd = -1;
    errno = 0;
    for (struct addrinfo *ai = res; ai; ai = ai->ai_next) {
        fd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
        if (fd < 0) continue;
        int one = 1;
        setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof one);
        if (bind(fd, ai->ai_addr, ai->ai_addrlen) == 0 && listen(fd, 1024) == 0) break;
        int e = errno;
        close(fd);
        errno = e;
        fd = -1;
    }
    freeaddrinfo(res);
    if (fd < 0) return fwp_os_error("listen", STR(addr)->d, err);
    fwp_nonblock(fd);
    return fwp_sock_new(fd, 0);
}

static V fwp_p_local_addr(V s) {
    struct sockaddr_storage ss;
    socklen_t len = sizeof ss;
    char buf[128] = "";
    if (SOCK(s)->fd >= 0 && getsockname(SOCK(s)->fd, (struct sockaddr *)&ss, &len) == 0)
        fwp_fmt_addr((struct sockaddr *)&ss, buf, sizeof buf);
    return fwp_cstr(buf);
}

static V fwp_p_peer_addr(V s) {
    struct sockaddr_storage ss;
    socklen_t len = sizeof ss;
    char buf[128] = "";
    if (SOCK(s)->fd >= 0 && getpeername(SOCK(s)->fd, (struct sockaddr *)&ss, &len) == 0)
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
        int lfd = SOCK(l)->fd;
        if (lfd < 0) return fwp_closed_error("listener", err);
        int fd = accept(lfd, 0, 0);
        if (fd >= 0) {
            fwp_nonblock(fd);
            int one = 1;
            setsockopt(fd, IPPROTO_TCP, TCP_NODELAY, &one, sizeof one);
            return fwp_sock_new(fd, 1);
        }
        if (errno == EAGAIN || errno == EWOULDBLOCK || errno == EINTR || errno == ECONNABORTED) {
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
    if (SOCK(l)->fd >= 0) {
        int fd = SOCK(l)->fd;
        SOCK(l)->fd = -1;
        fwp_fd_closing(fd);
        close(fd);
    }
    return FWP_UNIT;
}

static V fwp_p_tcp_connect(V addr, const fwp_desc *err) {
    fwp_tasks_init();
    fwp_check_cancel();
    struct addrinfo *res = fwp_resolve(STR(addr)->d, SOCK_STREAM, 0, "connect", err);
    int fd = -1;
    errno = 0;
    for (struct addrinfo *ai = res; ai; ai = ai->ai_next) {
        fd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
        if (fd < 0) continue;
        fwp_nonblock(fd);
        if (connect(fd, ai->ai_addr, ai->ai_addrlen) == 0) break;
        if (errno == EINPROGRESS) {
            fwp_wait_fd(fd, 1, 0);
            int e = 0;
            socklen_t el = sizeof e;
            getsockopt(fd, SOL_SOCKET, SO_ERROR, &e, &el);
            if (e == 0) break;
            errno = e;
        }
        int e = errno;
        close(fd);
        errno = e;
        fd = -1;
    }
    freeaddrinfo(res);
    if (fd < 0) return fwp_os_error("connect", STR(addr)->d, err);
    int one = 1;
    setsockopt(fd, IPPROTO_TCP, TCP_NODELAY, &one, sizeof one);
    return fwp_sock_new(fd, 1);
}

/* returns 0 on timeout */
static V fwp_tcp_read(V nv, V c, int64_t at, const fwp_desc *err) {
    int64_t n = (int64_t)nv;
    if (n < 1) n = 1;
    char *buf = (char *)malloc((size_t)n);
    for (;;) {
        int fd = SOCK(c)->fd;
        if (fd < 0) { free(buf); return fwp_closed_error("connection", err); }
        ssize_t k = read(fd, buf, (size_t)n);
        if (k >= 0) {
            V r = fwp_str_new(buf, (size_t)k);
            free(buf);
            return r;
        }
        if (errno == EAGAIN || errno == EWOULDBLOCK || errno == EINTR) {
            if (!fwp_wait_fd(fd, 0, at)) { free(buf); return 0; }
            continue;
        }
        free(buf);
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
        int fd = SOCK(c)->fd;
        if (fd < 0) return fwp_closed_error("connection", err);
        ssize_t k = send(fd, STR(data)->d + off, len - off, MSG_NOSIGNAL);
        if (k > 0) { off += (size_t)k; continue; }
        if (k < 0 && (errno == EAGAIN || errno == EWOULDBLOCK || errno == EINTR)) {
            if (!fwp_wait_fd(fd, 1, at)) return fwp_io_error("timeout", "write timed out", err);
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
    if (SOCK(c)->fd >= 0) {
        int fd = SOCK(c)->fd;
        SOCK(c)->fd = -1;
        fwp_fd_closing(fd);
        if (SOCK(c)->kind == 1) shutdown(fd, SHUT_RDWR);
        close(fd);
    }
    return FWP_UNIT;
}

static V fwp_p_udp_bind(V addr, const fwp_desc *err) {
    struct addrinfo *res = fwp_resolve(STR(addr)->d, SOCK_DGRAM, 1, "bind", err);
    int fd = -1;
    errno = 0;
    for (struct addrinfo *ai = res; ai; ai = ai->ai_next) {
        fd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
        if (fd < 0) continue;
        if (bind(fd, ai->ai_addr, ai->ai_addrlen) == 0) break;
        int e = errno;
        close(fd);
        errno = e;
        fd = -1;
    }
    freeaddrinfo(res);
    if (fd < 0) return fwp_os_error("bind", STR(addr)->d, err);
    fwp_nonblock(fd);
    return fwp_sock_new(fd, 2);
}

static V fwp_p_udp_send_to(V addr, V data, V s, const fwp_desc *err) {
    struct addrinfo *res = fwp_resolve(STR(addr)->d, SOCK_DGRAM, 0, "send", err);
    for (;;) {
        int fd = SOCK(s)->fd;
        if (fd < 0) { freeaddrinfo(res); return fwp_closed_error("socket", err); }
        ssize_t k = sendto(fd, STR(data)->d, STR(data)->len, 0, res->ai_addr, res->ai_addrlen);
        if (k >= 0) break;
        if (errno == EAGAIN || errno == EWOULDBLOCK || errno == EINTR) {
            fwp_wait_fd(fd, 1, 0);
            continue;
        }
        freeaddrinfo(res);
        return fwp_os_error("send", STR(addr)->d, err);
    }
    freeaddrinfo(res);
    return FWP_UNIT;
}

static V fwp_p_udp_recv_from(V nv, V s, const fwp_desc *err) {
    int64_t n = (int64_t)nv;
    if (n < 1) n = 1;
    char *buf = (char *)malloc((size_t)n);
    for (;;) {
        int fd = SOCK(s)->fd;
        if (fd < 0) { free(buf); return fwp_closed_error("socket", err); }
        struct sockaddr_storage ss;
        socklen_t len = sizeof ss;
        ssize_t k = recvfrom(fd, buf, (size_t)n, 0, (struct sockaddr *)&ss, &len);
        if (k >= 0) {
            char a[128];
            fwp_fmt_addr((struct sockaddr *)&ss, a, sizeof a);
            V r = fwp_tuple2(fwp_str_new(buf, (size_t)k), fwp_cstr(a));
            free(buf);
            return r;
        }
        if (errno == EAGAIN || errno == EWOULDBLOCK || errno == EINTR) {
            fwp_wait_fd(fd, 0, 0);
            continue;
        }
        free(buf);
        return fwp_os_error("receive", 0, err);
    }
}

static V fwp_p_dns_resolve(V host, const fwp_desc *err) {
    struct addrinfo hints, *res = 0;
    memset(&hints, 0, sizeof hints);
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;
    int rc = getaddrinfo(STR(host)->d, 0, &hints, &res);
    if (rc != 0) {
        char buf[512];
        snprintf(buf, sizeof buf, "%s: failed to lookup address information: %s", STR(host)->d,
                 gai_strerror(rc));
        return fwp_io_error("resolve", buf, err);
    }
    V items[64];
    char seen[64][INET6_ADDRSTRLEN];
    size_t n = 0;
    for (struct addrinfo *ai = res; ai && n < 64; ai = ai->ai_next) {
        char ip[INET6_ADDRSTRLEN];
        if (ai->ai_family == AF_INET)
            inet_ntop(AF_INET, &((struct sockaddr_in *)ai->ai_addr)->sin_addr, ip, sizeof ip);
        else if (ai->ai_family == AF_INET6)
            inet_ntop(AF_INET6, &((struct sockaddr_in6 *)ai->ai_addr)->sin6_addr, ip, sizeof ip);
        else continue;
        int dup = 0;
        for (size_t i = 0; i < n; i++) if (!strcmp(seen[i], ip)) dup = 1;
        if (dup) continue;
        strcpy(seen[n], ip);
        items[n++] = fwp_cstr(ip);
    }
    freeaddrinfo(res);
    return fwp_list_from(items, n);
}

/* ----- signals */

static void fwp_on_signal(int sig) {
    (void)sig;
    fwp_shutdown = 1;
}

static V fwp_p_shutdown_requested(void) {
    if (!fwp_signals_installed) {
        fwp_signals_installed = 1;
        signal(SIGINT, fwp_on_signal);
        signal(SIGTERM, fwp_on_signal);
    }
    return fwp_shutdown ? FWP_TRUE : FWP_FALSE;
}

static V fwp_p_request_shutdown(void) {
    fwp_shutdown = 1;
    return FWP_UNIT;
}

/* ----- metrics: name -> (kind, value), listed in name order */

typedef struct { char *name; const char *kind; double x; } fwp_metric;
static fwp_metric *fwp_metrics = 0;
static size_t fwp_nmetrics = 0, fwp_metrics_cap = 0;

static fwp_metric *fwp_metric_get(const char *name, size_t len, const char *kind) {
    for (size_t i = 0; i < fwp_nmetrics; i++)
        if (strlen(fwp_metrics[i].name) == len && !memcmp(fwp_metrics[i].name, name, len))
            return &fwp_metrics[i];
    if (fwp_nmetrics == fwp_metrics_cap) {
        fwp_metrics_cap = fwp_metrics_cap ? fwp_metrics_cap * 2 : 16;
        fwp_metrics = (fwp_metric *)realloc(fwp_metrics, fwp_metrics_cap * sizeof(fwp_metric));
    }
    fwp_metric *m = &fwp_metrics[fwp_nmetrics++];
    m->name = (char *)malloc(len + 1);
    memcpy(m->name, name, len);
    m->name[len] = 0;
    m->kind = kind;
    m->x = 0;
    return m;
}

static V fwp_p_metrics_update(int op, V name, V xv) {
    double x = fwp_f64(xv);
    const char *n = STR(name)->d;
    size_t len = STR(name)->len;
    if (op == 0) fwp_metric_get(n, len, "counter")->x += x;
    else if (op == 1) {
        fwp_metric *m = fwp_metric_get(n, len, "gauge");
        m->kind = "gauge";
        m->x = x;
    } else {
        char *buf = (char *)malloc(len + 8);
        memcpy(buf, n, len);
        memcpy(buf + len, "_count", 6);
        fwp_metric_get(buf, len + 6, "summary")->x += 1;
        memcpy(buf + len, "_sum", 4);
        fwp_metric_get(buf, len + 4, "summary")->x += x;
        free(buf);
    }
    return FWP_UNIT;
}

static int fwp_metric_cmp(const void *a, const void *b) {
    return strcmp(((const fwp_metric *)a)->name, ((const fwp_metric *)b)->name);
}

static V fwp_p_metrics_snapshot(void) {
    qsort(fwp_metrics, fwp_nmetrics, sizeof(fwp_metric), fwp_metric_cmp);
    V *items = (V *)fwp_alloc((fwp_nmetrics + 1) * sizeof(V));
    for (size_t i = 0; i < fwp_nmetrics; i++) {
        V f[3] = {fwp_cstr(fwp_metrics[i].name), fwp_cstr(fwp_metrics[i].kind),
                  fwp_from_f64(fwp_metrics[i].x)};
        items[i] = fwp_record(3, f);
    }
    return fwp_list_from(items, fwp_nmetrics);
}

/* ----- stack overflow
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
        overflow = fwp_near(a, lo > slack ? lo - slack : 0, lo + 4096);
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
#endif /* __wasi__ */
