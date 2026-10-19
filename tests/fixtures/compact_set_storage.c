/* Observe the allocator request made by the actual generated set builder.
 * I64 keys are inline; the final allocation excludes scratch and allocator headers. */
int main(void) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 253;
#endif
    fwp_gc_start(__builtin_frame_address(0));
    fwp_fns = fwp_fn_table; fwp_init_consts();
    const fwp_desc key = {.kind = K_I64};
    const V counts[] = {0, 1, 7, 257, 4096};
    for (size_t c = 0; c < sizeof(counts) / sizeof(counts[0]); c++) {
        V n = counts[c];
        intptr_t before = fwp_gc.budget_given - fwp_gc.budget;
        set_last_request = 0;
        V result = BUILD_SET(n);
        size_t requested = set_last_request;
        size_t expected = n ? sizeof(fwp_map) + n * sizeof(V) : 0;
        if (MAP(result)->len != n || requested != expected) {
            fprintf(stderr, "set %llu: requested %zu, expected %zu\n",
                (unsigned long long)n, requested, expected);
            return 211;
        }
        for (V i = 0; i < n; i++) {
            int found;
            if (MAP(result)->d[i] != i || fwp_map_find(result, i, &key, &found, 1) != i || !found)
                return 212;
        }
        intptr_t charged = fwp_gc.budget_given - fwp_gc.budget - before;
        fwp_rc_free_obj(result);
#ifdef FWP_ARC_ONLY
        if (fwp_gc.budget_given - fwp_gc.budget != before) return 213;
#endif
        printf("keys=%llu requested=%zu charged=%lld\n", (unsigned long long)n,
            requested, (long long)charged);
    }
    return 0;
}
