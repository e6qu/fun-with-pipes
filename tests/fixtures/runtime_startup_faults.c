/* Test-only failures from real POSIX setup calls, inserted after runtime headers. */
#include <signal.h>
#include <unistd.h>
static int startup_initialized, startup_destroyed;
static int startup_fault(const char *name) {
    const char *selected = getenv("FWP_STARTUP_FAULT");
    if (!selected) _Exit(246);
    return strcmp(selected, name) == 0;
}
static void startup_check_attributes(void) {
    /* These failures happen before creating a thread, so there is no race with
     * its exit path. A configured attribute must be destroyed even on failure. */
    if (startup_fault("attributes")) {
        if (startup_initialized || startup_destroyed) _Exit(248);
    } else if (startup_fault("stack") || startup_fault("create") || startup_fault("none")) {
        if (startup_initialized != 1 || startup_destroyed != 1) _Exit(248);
    }
}
static int startup_attr_init(pthread_attr_t *attribute) {
    if (atexit(startup_check_attributes)) _Exit(246);
    if (startup_fault("attributes")) return ENOMEM;
    int result = pthread_attr_init(attribute);
    if (!result) startup_initialized++;
    return result;
}
static int startup_attr_destroy(pthread_attr_t *attribute) {
    int result = pthread_attr_destroy(attribute);
    if (!result) startup_destroyed++;
    return result;
}
static int startup_stack_size(pthread_attr_t *attribute, size_t size) {
    if (startup_fault("stack")) return EINVAL;
    return pthread_attr_setstacksize(attribute, size);
}
static int startup_stack(pthread_attr_t *attribute, void *address, size_t size) {
    if (startup_fault("stack")) return EINVAL;
    return pthread_attr_setstack(attribute, address, size);
}
static int startup_create(pthread_t *thread, const pthread_attr_t *attribute,
                          void *(*entry)(void *), void *argument) {
    if (startup_fault("create")) return EAGAIN;
    return pthread_create(thread, attribute, entry, argument);
}
static int startup_altstack(const stack_t *stack, stack_t *old) {
    if (startup_fault("altstack")) { errno = ENOMEM; return -1; }
    return sigaltstack(stack, old);
}
static int startup_emptyset(sigset_t *set) {
    if (startup_fault("signal-mask")) { errno = EINVAL; return -1; }
    return sigemptyset(set);
}
static int startup_sigaction(int signal_number, const struct sigaction *action,
                             struct sigaction *old) {
    if ((signal_number == SIGSEGV && startup_fault("segv")) ||
        (signal_number == SIGBUS && startup_fault("bus"))) {
        errno = EINVAL;
        return -1;
    }
    return sigaction(signal_number, action, old);
}
#define pthread_attr_init(value) startup_attr_init(value)
#define pthread_attr_destroy(value) startup_attr_destroy(value)
#define pthread_attr_setstacksize(attribute, size) startup_stack_size(attribute, size)
#define pthread_attr_setstack(attribute, address, size) startup_stack(attribute, address, size)
#define pthread_create(...) startup_create(__VA_ARGS__)
#define sigaltstack(stack, old) startup_altstack(stack, old)
#define sigemptyset(set) startup_emptyset(set)
#define sigaction(...) startup_sigaction(__VA_ARGS__)
