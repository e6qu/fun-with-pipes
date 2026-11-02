static double construction_value(size_t index, size_t round) {
    return ((double)(int)((index + round) % 19) - 9.0) / 4.0;
}
static V construction_driver(size_t count, size_t round, const fwp_desc *scalar) {
    V result = fwp_rc_fresh(fwp_array_new_packed(count, scalar));
    for (size_t index = 0; index < count; index++)
        fwp_array_store(result, index, fwp_from_f64(construction_value(index, round)), scalar);
    return result;
}
int main(void) {
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    const fwp_desc scalar = {.kind = K_F64};
    const size_t counts[] = {0, 1, 19, 33, 65537, 262145};
    int first = 1;
    puts("{\"cases\":[");
    for (size_t c = 0; c < sizeof(counts) / sizeof(counts[0]); c++) {
        size_t count = counts[c];
        for (size_t round = 0; round < 8; round++) {
            double sum = -0.0;
            for (size_t index = 0; index < count; index++) {
                double mapped = construction_value(index, round) * 3.0;
                mapped = mapped + 1.0;
                sum = mapped + sum;
            }
            for (size_t role = 0; role < 3; role++) {
                construction_calls = construction_bytes = construction_retains = 0;
                size_t initial = fwp_heap.live;
                V result;
                if (role == 2) result = fCONSTRUCTION_WORK(round, count);
                else {
                    V input = role == 0 ? construction_driver(count, round, &scalar)
                                        : fCONSTRUCTION_MAKE(round, count);
                    if (fwp_array_len(input) != count) return 210;
                    for (size_t index = 0; index < count; index++)
                        if (fwp_array_load(input, index, &scalar) != fwp_from_f64(construction_value(index, round)))
                            return 211;
                    result = fCONSTRUCTION_REDUCE(input);
                }
                if (result != fwp_from_f64(sum)) return 212;
                if (fwp_heap.live != initial) return 213;
                printf("%s{\"count\":%zu,\"round\":%zu,\"role\":%zu,\"resultBits\":\"%016llx\",\"requests\":%llu,\"requestedBytes\":%llu,\"retains\":%llu,\"finalLiveBytes\":%zu}",
                    first ? "" : ",\n", count, round, role, (unsigned long long)result,
                    (unsigned long long)construction_calls, (unsigned long long)construction_bytes,
                    (unsigned long long)construction_retains, fwp_heap.live - initial);
                first = 0;
            }
        }
    }
    /* A deliberately omitted release must be visible before process exit. */
    size_t initial = fwp_heap.live;
    V leftover = fCONSTRUCTION_MAKE(0, 33);
    fwp_rc_free_arr(leftover); /* construction-final-release control */
    if (fwp_heap.live != initial) {
        fputs("construction result retained before exit\n", stderr);
        return 219;
    }
    if (fwp_heap.live != 0) return 220;
    puts("]}");
    return 0;
}
