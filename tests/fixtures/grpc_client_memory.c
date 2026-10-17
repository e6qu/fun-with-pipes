/* Inserted before the generated client's entry thread, after runtime definitions.
 * Allocation wrappers sample after each managed allocation. This excludes raw
 * socket/message buffers, allocator metadata/pages and the server process. */
static double client_charge(void) {
    return fwp_gc.total_alloc + (double)(fwp_gc.budget_given - fwp_gc.budget);
}
static void client_sample(void) {
    if (!client_active) return;
    double current = client_charge() - client_start_charge;
    if (current > client_peak_charge) client_peak_charge = current;
}
static void client_measure_begin(void) {
    client_start_charge = client_charge();
    client_active = 1;
}
static void client_measure_end(void) {
    client_sample();
    client_active = 0;
    fprintf(stderr, "client-memory\t%llu\t%llu\t%llu\t%.0f\t%.0f\t%zu\n",
        (unsigned long long)client_requests,
        (unsigned long long)client_requested_bytes,
        (unsigned long long)client_retains,
        client_peak_charge, client_charge() - client_start_charge, fwp_gc.ncollect);
}
