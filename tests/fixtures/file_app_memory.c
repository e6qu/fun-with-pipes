/* Inserted after the generated runtime, before its main worker. The counters
   observe managed charge, directory/file.read handles and file.read scratch bytes; allocator pages,
   other C buffers and process RSS are separate quantities. */
static double file_app_start;
static double file_app_phase_charge[3];
static unsigned file_app_samples[3];
static double file_app_charge(void) {
    return fwp_gc.total_alloc + (double)(fwp_gc.budget_given - fwp_gc.budget);
}
void file_app_checkpoint(int64_t phase, int64_t remaining) {
    if (phase < 0 || phase >= 3 || remaining != 64 - file_app_samples[phase]) exit(240);
    double charge = file_app_charge() - file_app_start;
    if (!file_app_samples[phase]) file_app_phase_charge[phase] = charge;
    if (charge != file_app_phase_charge[phase] || file_app_opened != file_app_closed || file_app_raw) {
        fprintf(stderr, "file-memory changed: phase=%lld remaining=%lld charge=%.0f baseline=%.0f open=%llu closed=%llu raw=%llu\n",
            (long long)phase, (long long)remaining, charge, file_app_phase_charge[phase],
            (unsigned long long)file_app_opened, (unsigned long long)file_app_closed, (unsigned long long)file_app_raw);
        exit(241);
    }
    const char *sample = getenv("FWP_FILE_APP_RSS");
    if (!sample || (strcmp(sample, "0") && strcmp(sample, "1"))) exit(240);
    file_app_samples[phase]++;
    file_app_active = 1;
    fprintf(stderr, "file-memory\t%lld\t%lld\t%.0f\t%llu\t%llu\n",
        (long long)phase, (long long)remaining, charge,
        (unsigned long long)(file_app_opened - file_app_closed), (unsigned long long)file_app_raw);
    if (!strcmp(sample, "1") && (remaining == 64 || remaining == 32 || remaining == 1)) {
        fflush(stderr);
        if (getchar() != '\n') exit(240);
    }
}
static void file_app_finish(void) {
    if (fwp_gc.enabled || fwp_gc.ncollect || file_app_charge() != file_app_start ||
        file_app_opened != file_app_closed || file_app_raw) exit(241);
    for (unsigned phase = 0; phase < 3; phase++) if (file_app_samples[phase] != 64) exit(240);
    fprintf(stderr, "file-final\t0\t0\t0\n");
}
