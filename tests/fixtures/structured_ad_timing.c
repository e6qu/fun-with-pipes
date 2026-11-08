/* Complete-gradient call: all conversions and output assembly stay timed.
 * Input aliases and analytic checks are outside the computation interval. */
static uint64_t gradient_clock(void) {
    struct timespec now;
    if (clock_gettime(CLOCK_MONOTONIC, &now) != 0) {
        fputs("clock_gettime failed\n", stderr); exit(1);
    }
    return (uint64_t)now.tv_sec * UINT64_C(1000000000) + (uint64_t)now.tv_nsec;
}
static double input_value(size_t index) {
#if OBJECTIVE == 0
    return index % 2 ? 1.0 : -1.2;
#elif OBJECTIVE == 1
    const double values[5] = {-1.25, -0.5, 0.0, 0.5, 1.25};
    return values[index % 5];
#else
    return ((int64_t)((7 * index + 3) % 17) - 8) / 8.0;
#endif
}
static double matrix_value(size_t row, size_t column) {
    return ((int64_t)((17 * row + 13 * column + 5) % 31) - 15) / 16.0;
}
static void verify_input(V values, size_t count) {
    for (size_t i = 0; i < count; i++) {
        if (!values || OBJ(values)->tag != 1 || OBJ(values)->n != 2 ||
            OBJ(values)->f[0] != fwp_from_f64(input_value(i))) exit(213);
        values = OBJ(values)->f[1];
    }
    if (values) exit(213);
}
int main(int argc, char **argv) {
    if (argc != 2) return 210;
    char *end;
    unsigned long parsed = strtoul(argv[1], &end, 10);
    if (!argv[1][0] || *end || parsed != INPUT_COUNT) return 210;
    const size_t count = (size_t)parsed, repeats = REPEAT_COUNT;
    const double expected[INPUT_COUNT + 1] = {EXPECTED_VALUES};
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts(); fwp_tasks_init();
    fwp_stack_guard_init((size_t)64 * 1024 * 1024);
    size_t initial = fwp_heap.live;
    size_t retained_after_call = initial;
    /* Structured gradient observer starts here. */
    uint64_t construction = 0, work = 0, release = 0;
    uint64_t checksum = UINT64_C(14695981039346656037);
    uint64_t total_start = gradient_clock();
    for (size_t round = 0; round < repeats; round++) {
        uint64_t start = gradient_clock();
        V input = 0, weights = 0;
        for (size_t i = count; i > 0; i--)
            input = fwp_rc_fresh(fwp_cons(fwp_from_f64(input_value(i - 1)), input));
#if OBJECTIVE == 2
        for (size_t i = count; i > 0; i--) {
            V row = 0;
            for (size_t j = count; j > 0; j--)
                row = fwp_rc_fresh(fwp_cons(fwp_from_f64(matrix_value(i - 1, j - 1)), row));
            weights = fwp_rc_fresh(fwp_cons(row, weights));
        }
#endif
        V input_alias = input, matrix_alias = weights;
        fwp_rc_dup(input_alias); fwp_rc_dup(matrix_alias);
        __asm__ volatile("" : "+r"(input), "+r"(weights) :: "memory");
        construction += gradient_clock() - start;
        start = gradient_clock();
        V result = MEASURE_ENTRY(weights, input);
        __asm__ volatile("" : "+r"(result) :: "memory");
        work += gradient_clock() - start;
        V cursor = result;
        for (size_t i = 0; i < count; i++) {
            if (!cursor || OBJ(cursor)->tag != 1 || OBJ(cursor)->n != 2) return 211;
            double value = fwp_f64(OBJ(cursor)->f[0]);
            if (!isfinite(value) || fabs(value - expected[i]) > 1e-10 + 1e-10 * fabs(expected[i])) return 212;
            checksum = (checksum ^ OBJ(cursor)->f[0]) * UINT64_C(1099511628211);
            cursor = OBJ(cursor)->f[1];
        }
        if (cursor) return 211;
        verify_input(input_alias, count);
#if OBJECTIVE == 2
        cursor = matrix_alias;
        for (size_t i = 0; i < count; i++) {
            if (!cursor || OBJ(cursor)->tag != 1 || OBJ(cursor)->n != 2) return 216;
            V row = OBJ(cursor)->f[0];
            for (size_t j = 0; j < count; j++) {
                if (!row || OBJ(row)->tag != 1 || OBJ(row)->n != 2 ||
                    OBJ(row)->f[0] != fwp_from_f64(matrix_value(i, j))) return 216;
                row = OBJ(row)->f[1];
            }
            if (row) return 216;
            cursor = OBJ(cursor)->f[1];
        }
        if (cursor) return 216;
#endif
        start = gradient_clock();
        DROP_VALUES(result); DROP_VALUES(input_alias); DROP_MATRIX(matrix_alias);
        release += gradient_clock() - start;
        /* Pure global constants may initialize on the first call. Retain their
         * normal lifetime, require subsequent calls to stay bounded, then check
         * exact reclamation after the real constant teardown below. */
        if (fwp_heap.live < initial) return 214;
        if (round == 0) retained_after_call = fwp_heap.live;
        else if (fwp_heap.live != retained_after_call) return 214;
        if (fwp_cleanups || fwp_owned_tapes) return 215;
        for (int32_t i = 0; i < fwp_ntapes; i++) if (fwp_tapes[i].live) return 215;
    }
    uint64_t finish_start = gradient_clock();
    fwp_caf_finish();
    release += gradient_clock() - finish_start;
    if (fwp_heap.live != initial) return 214;
    uint64_t total = gradient_clock() - total_start;
    /* Structured gradient observer stops here. */
    printf("{\"constructionNs\":%llu,\"computationNs\":%llu,\"releaseNs\":%llu,\"loopNs\":%llu,\"checksum\":%llu,\"retainedManagedBytesAfterCall\":%zu,\"initialLiveBytes\":%zu,\"finalLiveBytes\":%zu}\n",
        (unsigned long long)construction, (unsigned long long)work,
        (unsigned long long)release, (unsigned long long)total,
        (unsigned long long)checksum, retained_after_call - initial, initial, fwp_heap.live);
    fwp_native_tasks_finish();
    return 0;
}
