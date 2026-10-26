/* Test the production context switch with live register-held allocations,
 * rounding modes and signal masks. Each allocation has one explicit owner. */
#include <fenv.h>
#if !defined(FWP_LIBC_CONTEXT)
#error "This probe requires the libc context implementation"
#endif
#if PROBE_CONTEXT_STACK
#define PROBE_CONTEXT(t) ((t)->ctx)
#else
#define PROBE_CONTEXT(t) (&(t)->ctx)
#endif
#if defined(__aarch64__)
#define PROBE_REGISTER "x28"
#else
#define PROBE_REGISTER "r15"
#endif
static int probe_signal_blocked(void) {
    sigset_t mask;
    if (sigprocmask(SIG_SETMASK, NULL, &mask)) _Exit(194);
    return sigismember(&mask, SIGUSR1);
}

static void probe_root_reader(void *unused, int cancelled) {
    (void)unused;
    if (cancelled || fegetround() != FE_UPWARD || probe_signal_blocked()) _Exit(194);
    sigset_t mask;
    sigemptyset(&mask);
    sigaddset(&mask, SIGUSR1);
    if (fesetround(FE_DOWNWARD) || sigprocmask(SIG_BLOCK, &mask, NULL)) _Exit(194);
}

static void probe_child_owner(void *unused, int cancelled) {
    (void)unused;
    if (cancelled) _Exit(194);
    fwp_task *self = fwp_cur;
    register char *held __asm__(PROBE_REGISTER) = fwp_alloc_leaf(128);
    strcpy(held, "child saved register");
    fwp_enter(fwp_root);
    __asm__ volatile("" : "+r"(held));
    swapcontext(PROBE_CONTEXT(self), PROBE_CONTEXT(fwp_root));
    __asm__ volatile("" : "+r"(held));
    if (strcmp(held, "child saved register")) _Exit(194);
    fwp_mem_free(held);
}

static void probe_context_state(void) {
    fenv_t environment;
    sigset_t signals, clear;
    if (fegetenv(&environment) || sigprocmask(SIG_SETMASK, NULL, &signals)) _Exit(194);
    sigemptyset(&clear);
    sigaddset(&clear, SIGUSR1);
    if (fesetround(FE_UPWARD) || sigprocmask(SIG_UNBLOCK, &clear, NULL)) _Exit(194);
    fwp_tasks_init();
    fwp_task *child = fwp_spawn_task(0, probe_root_reader, NULL, 0, 0);
    fwp_task_own_internal(child, 0);
    if (fwp_dequeue() != child) _Exit(194);
    register char *held __asm__(PROBE_REGISTER) = fwp_alloc_leaf(64);
    strcpy(held, "root saved register");
    fwp_make_ready(fwp_root);
    fwp_enter(child);
    __asm__ volatile("" : "+r"(held));
    swapcontext(PROBE_CONTEXT(fwp_root), PROBE_CONTEXT(child));
    __asm__ volatile("" : "+r"(held));
    if (strcmp(held, "root saved register") || fegetround() != FE_UPWARD
        || probe_signal_blocked()) _Exit(194);
    fwp_mem_free(held);
    fwp_free_zombie();

    child = fwp_spawn_task(0, probe_child_owner, NULL, 0, 0);
    fwp_task_own_internal(child, 0);
    if (fwp_dequeue() != child) _Exit(194);
    fwp_enter(child);
    swapcontext(PROBE_CONTEXT(fwp_root), PROBE_CONTEXT(child));
    fwp_make_ready(fwp_root);
    fwp_enter(child);
    swapcontext(PROBE_CONTEXT(fwp_root), PROBE_CONTEXT(child));
    fwp_free_zombie();
    if (fesetenv(&environment) || sigprocmask(SIG_SETMASK, &signals, NULL)) _Exit(194);
    puts("saved registers, rounding and signals pass");
}
