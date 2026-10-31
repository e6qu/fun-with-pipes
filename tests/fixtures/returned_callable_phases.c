/* Emitted only in diagnostic builds, after the runtime definitions. */
static size_t callable_start_charge, callable_start_counts;

void returned_phase_begin(void) {
    memset(&callable_counts, 0, sizeof callable_counts);
    callable_counts.peak = callable_live;
    callable_start_charge = fwp_heap.live;
    callable_start_counts = fwp_heap.rc_bytes;
    callable_active = 1;
}

void returned_phase_end(int32_t kind, int64_t calls, int32_t phase) {
    callable_active = 0;
    size_t count_bytes = 0;
    for (size_t i = 0; i < fwp_heap.top; i++) count_bytes += fwp_heap.meta[i].rc_len;
    if (count_bytes != fwp_heap.rc_bytes) abort();
    fprintf(stderr, "phase %d %lld %d %llu %llu %llu %llu %llu %llu %llu %zu %zu %zu %zu %zu\n",
        kind, (long long)calls, phase,
        (unsigned long long)callable_counts.requests,
        (unsigned long long)callable_counts.bytes,
        (unsigned long long)callable_counts.frees,
        (unsigned long long)callable_counts.retains,
        (unsigned long long)callable_counts.releases,
        (unsigned long long)callable_counts.applications,
        (unsigned long long)callable_counts.peak, callable_live,
        callable_start_charge, fwp_heap.live,
        callable_start_counts, fwp_heap.rc_bytes);
}

int returned_profile_clean(void) {
    return !callable_live && returned_storage_clean();
}
