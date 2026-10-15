/* Called by both a statically linked host and a dynamically loading host. */
static jmp_buf arc_failure;
static int arc_recover(void) { return 1; }

static int arc_library_call(void) {
    char text[] = "abcd";
    struct fwp_c_Summary result = summarize((struct fwp_c_Input){7, text});
    if (result.count != 4 || result.value != 7.0) return 181;
    if (text_length("h\xc3\xa9llo") != 5 || slope(3.0) != 6.0 || pipeline(10) != 55)
        return 182;
    text[0] = 'z';
    if (result.count != 4 || result.value != 7.0) return 183;
    return 0;
}

int fwp_test_probe(void) {
    fwp_lib_init();
    int result = arc_library_call();
    if (result) return result;
    intptr_t budget = fwp_gc.budget;
    double freed = fwp_gc.freed;
    fwp_cleanup *boundary = fwp_cleanups;
    for (int i = 0; i < 256; ++i) {
        result = arc_library_call();
        if (result) return result;
    }
    fwp_trap_recover = arc_recover;
    fwp_trap_jb = &arc_failure;
    fwp_trap_cleanup = boundary;
    if (!setjmp(arc_failure)) { (void)crash("owned before failure"); return 184; }
    fwp_trap_recover = 0;
    fwp_trap_jb = 0;
    fwp_trap_cleanup = 0;
    if (fwp_cleanups != boundary) return 185;
    if (fwp_gc.budget < budget || fwp_gc.freed <= freed) return 186;
    if (fwp_gc.enabled || fwp_gc.ncollect) return 187;
    printf("%lld\n%lld\n%.1f\n%lld\n", (long long)text_length("h\xc3\xa9llo"),
        (long long)summarize((struct fwp_c_Input){7, "abcd"}).count,
        slope(3.0), (long long)pipeline(10));
    return 0;
}

static void fwp_test_finished(void) {
    const char *path = getenv("FWP_ARC_LIBRARY_REPORT");
    if (!path) return;
    FILE *file = fopen(path, "a");
    if (!file) abort();
    /* Called after typed globals and tapes finish, before the arena is freed. */
    fprintf(file, "%ld %zu\n", (long)(fwp_gc.budget_given - fwp_gc.budget),
        (size_t)fwp_gc.ncollect);
    if (fclose(file)) abort();
}
