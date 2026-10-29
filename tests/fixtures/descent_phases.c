/* Diagnostic-only clocks around complete F64 derivative phases, never per node.
 * This observer accepts one active tape and a successful complete solve. */
enum { DESCENT_SETUP, DESCENT_FORWARD, DESCENT_REVERSE_SETUP,
       DESCENT_REVERSE, DESCENT_RESULT, DESCENT_RETIRE, DESCENT_PHASES };
static uint64_t descent_phase_ns[DESCENT_PHASES], descent_last_ns;
static uint64_t descent_updates, descent_nodes, descent_inputs;
static int descent_active_phase = -1, descent_registered;
static void descent_phase_fail(void) {
    fputs("descent phase observer: incomplete or unsupported phase sequence\n", stderr);
    _Exit(233);
}
static uint64_t descent_clock(void) {
    struct timespec value;
    if (clock_gettime(CLOCK_MONOTONIC, &value)) descent_phase_fail();
    return (uint64_t)value.tv_sec * UINT64_C(1000000000) + (uint64_t)value.tv_nsec;
}
static void descent_phase_report(void) {
    if (descent_active_phase != -1) descent_phase_fail();
    const char *names[] = {"setup", "forwardWithRecording", "reverseSetup",
                           "reverseTraversal", "resultArray", "retirement"};
    fprintf(stderr, "{\"derivativePhases\":{\"updates\":%llu,\"inputs\":%llu,\"nodes\":%llu,\"nanoseconds\":{",
            (unsigned long long)descent_updates, (unsigned long long)descent_inputs,
            (unsigned long long)descent_nodes);
    for (int phase = 0; phase < DESCENT_PHASES; phase++)
        fprintf(stderr, "%s\"%s\":%llu", phase ? "," : "", names[phase],
                (unsigned long long)descent_phase_ns[phase]);
    fputs("}}}\n", stderr);
}
static void descent_phase_step(int next) {
    if (next < 0 || next > DESCENT_PHASES || next != descent_active_phase + 1)
        descent_phase_fail();
    uint64_t now = descent_clock();
    if (descent_active_phase >= 0) {
        if (now < descent_last_ns) descent_phase_fail();
        descent_phase_ns[descent_active_phase] += now - descent_last_ns;
    }
    if (next == DESCENT_PHASES) {
        descent_updates++;
        descent_active_phase = -1;
    } else descent_active_phase = next;
    descent_last_ns = now;
}
static void descent_phase_init(void) {
    if (descent_registered) return;
    if (atexit(descent_phase_report)) descent_phase_fail();
    descent_registered = 1;
}
