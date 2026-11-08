/* Ordinary entry calls. Runtime coefficients cross a compiler barrier; no
 * counters are inserted into the timed worker. Validation is outside phases. */
static uint64_t capture_clock(void) {
    struct timespec now;
    if (clock_gettime(CLOCK_MONOTONIC, &now) != 0) {
        fputs("clock_gettime failed\n", stderr); exit(1);
    }
    return (uint64_t)now.tv_sec * UINT64_C(1000000000) + (uint64_t)now.tv_nsec;
}
static V initial_word(size_t index) {
#if SENSOR
    return fwp_from_f64((double)(index % 17));
#else
    return (V)(index % 17);
#endif
}
static V expected_word(size_t index) {
#if SENSOR
    double value = (double)(index % 17);
    for (size_t step = 0; step < UPDATE_COUNT; step++) value = value * 1.0 + 0.25;
    return fwp_from_f64(value);
#else
    return (V)(index % 17 + UPDATE_COUNT);
#endif
}
int main(void) {
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    const fwp_desc scalar = {.kind = ELEMENT_KIND};
    const size_t count = INPUT_COUNT, repeats = REPEAT_COUNT;
    size_t initial = fwp_heap.live;
    uint64_t setup = 0, work = 0, release = 0, checksum = 0;
    uint64_t total_start = capture_clock();
    for (size_t round = 0; round < repeats; round++) {
        uint64_t start = capture_clock();
        size_t backing_count = count + (SHARING == 2 ? 2 : 0);
        V input = fwp_array_typed_new(backing_count, &scalar), alias = 0;
        for (size_t i = 0; i < backing_count; i++)
            fwp_array_store(input, i, initial_word(SHARING == 2 ? (i ? i - 1 : 16) : i), &scalar);
        if (SHARING == 1) { alias = input; fwp_rc_dup(alias); }
        if (SHARING == 2) {
            alias = input;
            fwp_array_view *view = (fwp_array_view *)fwp_alloc_init(sizeof *view);
            view->len = FWP_ARRAY_VIEW_FLAG | count;
            view->owner = alias; view->data = fwp_array_data(alias) + fwp_array_stride(&scalar);
            fwp_rc_dup(alias); input = fwp_rc_fresh(PTR(view));
        }
        V scale = SCALE_WORD, offset = OFFSET_WORD, updates = UPDATE_COUNT;
        __asm__ volatile("" : "+r"(input), "+r"(scale), "+r"(offset), "+r"(updates) :: "memory");
        setup += capture_clock() - start;
        start = capture_clock();
        V result = MEASURE_ENTRY(scale, offset, updates, input);
        __asm__ volatile("" : "+r"(result) :: "memory");
        work += capture_clock() - start;
        if (fwp_array_len(result) != count) return 211;
        for (size_t i = 0; i < count; i++) {
            V value = fwp_array_load(result, i, &scalar);
            if (value != expected_word(i)) return 212;
            checksum ^= value + round;
        }
        if (alias) for (size_t i = 0; i < backing_count; i++)
            if (fwp_array_load(alias, i, &scalar) != initial_word(SHARING == 2 ? (i ? i - 1 : 16) : i)) return 213;
        start = capture_clock();
        if (fwp_rc_release_last(result)) fwp_rc_free_arr(result);
        if (alias && fwp_rc_release_last(alias)) fwp_rc_free_arr(alias);
        release += capture_clock() - start;
        if (fwp_heap.live != initial) return 214;
    }
    uint64_t total = capture_clock() - total_start;
    printf("{\"constructionNs\":%llu,\"computationNs\":%llu,\"releaseNs\":%llu,\"loopNs\":%llu,\"checksum\":%llu,\"initialLiveBytes\":%zu,\"finalLiveBytes\":%zu}\n",
        (unsigned long long)setup, (unsigned long long)work,
        (unsigned long long)release, (unsigned long long)total,
        (unsigned long long)checksum, initial, fwp_heap.live);
    return 0;
}
