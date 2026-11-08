/* Replaced tokens select a fixed input and ordinary owned entry. No timers or
 * allocation counters are inserted into the measured function body. */
static uint64_t metadata_clock(void) {
    struct timespec now;
    if (clock_gettime(CLOCK_MONOTONIC, &now) != 0) {
        fputs("measurement clock failed\n", stderr); exit(1);
    }
    return (uint64_t)now.tv_sec * UINT64_C(1000000000) + (uint64_t)now.tv_nsec;
}
int main(void) {
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    const fwp_desc scalar = {.kind = K_F64};
    const size_t count = INPUT_COUNT, repeats = REPEAT_COUNT;
    const uint64_t expected[] = {EXPECTED_WORDS};
    size_t initial = fwp_heap.live;
    uint64_t setup = 0, work = 0, release = 0, checksum = 0;
    uint64_t total_start = metadata_clock();
    for (size_t round = 0; round < repeats; round++) {
        uint64_t start = metadata_clock();
        V input;
#if INPUT_LOOP
        input = (V)count;
#else
        input = fwp_rc_fresh(fwp_array_new_packed(count, &scalar));
        for (size_t index = 0; index < count; index++)
            fwp_array_store(input, index, fwp_from_f64(INPUT_VALUE), &scalar);
#endif
        __asm__ volatile("" : "+r"(input) :: "memory");
        setup += metadata_clock() - start;
        start = metadata_clock();
        V result = MEASURE_ENTRY(input);
        __asm__ volatile("" : "+r"(result) :: "memory");
        work += metadata_clock() - start;
        /* Validation is outside all three phase timers. */
#if OUTPUT_ARRAY
        if (fwp_array_len(result) != count) return 211;
        for (size_t index = 0; index < count; index++) {
            V value = fwp_array_load(result, index, &scalar);
            if (value != expected[index]) return 212;
            checksum ^= value + round;
        }
#else
        if (result != expected[0]) return 213;
        checksum ^= result + round;
#endif
        start = metadata_clock();
#if OUTPUT_ARRAY
        fwp_rc_free_arr(result);
#endif
        release += metadata_clock() - start;
        if (fwp_heap.live != initial) return 214;
    }
    uint64_t total = metadata_clock() - total_start;
    printf("{\"constructionNs\":%llu,\"computationNs\":%llu,\"releaseNs\":%llu,\"loopNs\":%llu,\"checksum\":%llu,\"initialLiveBytes\":%zu,\"finalLiveBytes\":%zu}\n",
           (unsigned long long)setup, (unsigned long long)work,
           (unsigned long long)release, (unsigned long long)total,
           (unsigned long long)checksum, initial, fwp_heap.live);
    return 0;
}
