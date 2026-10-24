/* Observe managed charge after each real allocation. Input lanes are stack
 * arrays here; the whole-program benchmark separately includes their heap use. */
static double map_storage_charge(void) {
    return fwp_gc.total_alloc + (double)(fwp_gc.budget_given - fwp_gc.budget);
}
static void map_storage_sample(void) {
    if (map_storage_active) {
        double live = map_storage_charge() - map_storage_start;
        if (live > map_storage_peak) map_storage_peak = live;
    }
}
int main(int argc, char **argv) {
    if (argc != 2 || (strcmp(argv[1], "map") && strcmp(argv[1], "set"))) return 2;
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 3;
#endif
    size_t columns = !strcmp(argv[1], "map") ? 2 : 1;
    fwp_gc_start(__builtin_frame_address(0));
    fwp_fns = fwp_fn_table;
    fwp_init_consts();
    enum { N = 4096 };
    _Static_assert(N * sizeof(V) > GC_MAX_SMALL, "use exact large-object charges");
    V keys[N], values[N];
    for (size_t i = 0; i < N; i++) { keys[i] = (i * 73) % N; values[i] = i * 2; }
    const fwp_desc scalar = {.kind = K_I64};
    const fwp_map_ops ops = {NULL, NULL, NULL, NULL, fwp_rc_free_obj, NULL, columns};
    map_storage_start = map_storage_charge();
    map_storage_active = 1;
    V result = fwp_map_build_typed(keys, columns == 2 ? values : NULL, N, &ops, &scalar);
    if (MAP(result)->len != N) return 4;
    for (size_t i = 0; i < N; i++) {
        if (MAP(result)->d[columns * i] != i) return 5;
        if (columns == 2 && MAP(result)->d[2 * i + 1] != ((i * 505) % N) * 2) return 6;
    }
    fwp_rc_free_obj(result);
    map_storage_active = 0;
    double final = map_storage_charge() - map_storage_start;
    size_t limit = sizeof(fwp_map) + columns * N * sizeof(V);
    printf("%s peak=%.0f limit=%zu final=%.0f\n", argv[1], map_storage_peak, limit, final);
    if (final != 0 || fwp_cleanups) return 7;
    if (map_storage_peak > (double)limit) return 241;
    if (map_storage_peak != (double)limit) return 8;
    return 0;
}
