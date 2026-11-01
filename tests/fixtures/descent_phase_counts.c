/* Diagnostic counters share the timing observer's exact runtime boundaries.
 * derivative_phase is zero outside a gradient, then one through six. */
enum { DESCENT_SETUP, DESCENT_FORWARD, DESCENT_REVERSE_SETUP,
       DESCENT_REVERSE, DESCENT_RESULT, DESCENT_RETIRE, DESCENT_PHASES };
static uint64_t descent_updates, descent_nodes, descent_inputs;
static int descent_active_phase = -1, descent_registered;
static void descent_phase_fail(void) {
    fputs("descent phase observer: incomplete or unsupported phase sequence\n", stderr);
    _Exit(233);
}
static void descent_phase_report(void) {
    if (descent_active_phase != -1) descent_phase_fail();
    fprintf(stderr, "{\"derivativeVisits\":{\"updates\":%llu,\"inputs\":%llu,\"nodes\":%llu}}\n",
            (unsigned long long)descent_updates, (unsigned long long)descent_inputs,
            (unsigned long long)descent_nodes);
}
static void descent_phase_step(int next) {
    if (next < 0 || next > DESCENT_PHASES || next != descent_active_phase + 1)
        descent_phase_fail();
    if (next == DESCENT_PHASES) {
        descent_updates++;
        descent_active_phase = -1;
        derivative_phase = 0;
    } else {
        descent_active_phase = next;
        derivative_phase = (size_t)next + 1;
    }
    /* Include storage inherited from the preceding phase in this phase's peak. */
    iteration_sample();
}
static void descent_phase_init(void) {
    if (descent_registered) return;
    if (atexit(descent_phase_report)) descent_phase_fail();
    descent_registered = 1;
}
