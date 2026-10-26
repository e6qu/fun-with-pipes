/* Windows fibers own their ABI context and demand-committed stacks.
 * Reserve stack-overflow handling space for every new context. */
#ifdef _WIN32
#include <windows.h>

typedef struct {
    void *fiber;
    char *top;
    int converted_thread;
} fwp_win_context;

static void fwp_win_context_started(fwp_win_context *context) {
    ULONG_PTR low, high;
    GetCurrentThreadStackLimits(&low, &high);
    context->top = (char *)high;
    ULONG guarantee = 65536;
    if (!SetThreadStackGuarantee(&guarantee))
        fwp_trap("cannot reserve stack overflow handling space");
}

static void fwp_win_context_root(fwp_win_context *context) {
    if (IsThreadAFiber()) {
        context->fiber = GetCurrentFiber();
    } else {
        context->fiber = ConvertThreadToFiberEx(NULL, FIBER_FLAG_FLOAT_SWITCH);
        if (!context->fiber) fwp_trap("cannot initialize task fibers");
        context->converted_thread = 1;
    }
    fwp_win_context_started(context);
}

static __attribute__((noinline)) void fwp_win_context_switch(
    fwp_win_context *from, const fwp_win_context *to
) {
    (void)from;
    SwitchToFiber(to->fiber);
}


static void fwp_win_context_root_finish(fwp_win_context *context) {
    if (context->converted_thread && !ConvertFiberToThread()) abort();
    memset(context, 0, sizeof *context);
}
#endif
