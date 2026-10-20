/* Windows fibers own their ABI context and demand-committed stacks. The OS
 * context is opaque to the collector, so save nonvolatile registers in an
 * explicit root range before switching. Never treat a fiber handle as a stack. */
#ifdef _WIN32
#include <windows.h>

typedef struct {
    void *fiber;
    char *top, *sp;
    jmp_buf registers;
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
    /* setjmp captures integer and floating-point nonvolatile registers on
     * both supported Windows ABIs. The stack range covers spilled values;
     * the explicit register range also preserves interior/one-past roots. */
    if (setjmp(from->registers)) abort();
    from->sp = fwp_gc_sp();
    SwitchToFiber(to->fiber);
    from->sp = NULL;
    memset(from->registers, 0, sizeof from->registers);
}

#if FWP_GC && !defined(FWP_ARC_ONLY)
static void fwp_win_context_scan(const fwp_win_context *context) {
    if (!context->sp) return;
    fwp_gc_scan_root((char *)context->registers,
                     (char *)context->registers + sizeof context->registers);
    fwp_gc_scan_root(context->sp, context->top);
}
#endif

static void fwp_win_context_root_finish(fwp_win_context *context) {
    if (context->converted_thread && !ConvertFiberToThread()) abort();
    memset(context, 0, sizeof *context);
}
#endif
