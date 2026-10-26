/* Explicit, uniquely owned C callback registrations. No executable trampolines.
 * A registration owns its captured arguments; active calls borrow those owners.
 * close disables entry, release gives up the host's one registration owner, and
 * the last active call performs any deferred destruction. */
#ifdef FWP_RETAINED_CALLBACKS
#ifdef __wasm__
#error retained C callbacks require a native library
#endif

typedef struct fwp_callback_context {
    size_t active;
    int closed, released;
    void (*drop_captures)(struct fwp_callback_context *);
    V captures[];
} fwp_callback_context;

static size_t fwp_callback_registrations;
#ifdef _WIN32
static DWORD fwp_callback_thread;
#else
static pthread_t fwp_callback_thread;
#endif

static void fwp_callback_runtime_init(void) {
#ifdef _WIN32
    fwp_callback_thread = GetCurrentThreadId();
#else
    fwp_callback_thread = pthread_self();
#endif
}

static void fwp_callback_check_thread(void) {
#ifdef _WIN32
    int same = fwp_callback_thread == GetCurrentThreadId();
#else
    int same = pthread_equal(fwp_callback_thread, pthread_self());
#endif
    /* Do not unwind another thread's cleanup stack on a host protocol error. */
    if (!same) {
        fputs("fwp: callback library called from a different OS thread\n", stderr);
        abort();
    }
}

static void fwp_callback_settle(fwp_callback_context *context) {
    if (context->active) return;
    if (context->closed && context->drop_captures) {
        void (*drop)(fwp_callback_context *) = context->drop_captures;
        context->drop_captures = NULL;
        drop(context);
    }
    if (context->released) {
        if (!fwp_callback_registrations) abort();
        fwp_callback_registrations--;
        fwp_mem_free(context);
    }
}

static void fwp_callback_close(fwp_callback_context *context) {
    fwp_callback_check_thread();
    context->closed = 1;
    fwp_callback_settle(context);
}

static void fwp_callback_release(void *value) {
    fwp_callback_context *context = value;
    fwp_callback_check_thread();
    if (context->released) abort();
    context->released = context->closed = 1;
    fwp_callback_settle(context);
}

static fwp_callback_context *fwp_callback_create(size_t captures,
        void (*drop)(fwp_callback_context *)) {
    fwp_callback_check_thread();
    if (captures > (SIZE_MAX - sizeof(fwp_callback_context)) / sizeof(V) ||
        fwp_callback_registrations == SIZE_MAX) fwp_trap("callback registration overflow");
    fwp_callback_context *context = fwp_mem_alloc(sizeof *context + captures * sizeof(V));
    context->drop_captures = drop;
    fwp_callback_registrations++;
    return context;
}

static int fwp_callback_enter(fwp_callback_context *context) {
    fwp_callback_check_thread();
    if (context->closed) return 0;
    if (context->active == SIZE_MAX) fwp_trap("callback nesting overflow");
    context->active++;
    return 1;
}

static void fwp_callback_leave(void *value) {
    fwp_callback_context *context = value;
    if (!context->active) abort();
    context->active--;
    fwp_callback_settle(context);
}

static void fwp_callback_runtime_finish(void) {
    fwp_callback_check_thread();
    if (fwp_callback_registrations) {
        fputs("fwp: release callback registrations before unloading the library\n", stderr);
        abort();
    }
}
#endif
