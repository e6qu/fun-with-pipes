static V record_fold_input(size_t n) {
    V result = 0;
    for (size_t i = n; i; i--) {
        V value = fwp_rc_fresh(fwp_record(2, (V[]){(V)(i - 1), fwp_from_f64((double)i - 0.5)}));
        result = fwp_rc_fresh(fwp_cons(value, result));
    }
    return result;
}
static int record_fold_input_valid(V xs, size_t n) {
    size_t i = 0;
    for (V at = xs; at; at = OBJ(at)->f[1], i++) {
        V value = OBJ(at)->f[0];
        if ((int64_t)OBJ(value)->f[0] != (int64_t)i ||
            fwp_f64(OBJ(value)->f[1]) != (double)i + 0.5) return 0;
    }
    return i == n;
}
int main(void) {
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    const size_t sizes[] = {0, 1, 7, 129};
    for (int round = 0; round < 32; round++) {
        for (size_t test = 0; test < 4; test++) for (unsigned alias = 0; alias < 4; alias++) {
            size_t n = sizes[test];
            double baseline = fwp_heap.live;
            V seed = fwp_rc_fresh(fwp_record(2, (V[]){7, fwp_from_f64(0.25)}));
            V xs = record_fold_input(n);
            if (alias & 1) fwp_rc_dup(seed);
            if (alias & 2) fwp_rc_dup(xs);
            uint64_t allocations = record_fold_allocations, bytes = record_fold_bytes;
            uint64_t retains = record_fold_retains;
            V result = RECORD_FOLD(seed, xs);
            if (record_fold_allocations - allocations != (uint64_t)(n != 0) ||
                record_fold_bytes - bytes != (uint64_t)(n != 0) * 24 ||
                record_fold_retains != retains) return 241;
            if (!n && result != seed) return 242;
            if ((int64_t)OBJ(result)->f[0] != 7 + (int64_t)(n * (n - (n != 0)) / 2) ||
                fwp_f64(OBJ(result)->f[1]) != 0.25 + (double)(n * n) * 0.5) return 243;
            /* negative control: omit the final result release */
            DROP_POINT(result);
            if (alias & 1) {
                if ((int64_t)OBJ(seed)->f[0] != 7 || fwp_f64(OBJ(seed)->f[1]) != 0.25) return 244;
                DROP_POINT(seed);
            }
            if (!record_fold_input_valid(xs, n)) return 245;
            DROP_LIST(xs);
            if (alias & 2) {
                if (!record_fold_input_valid(xs, n)) return 246;
                DROP_LIST(xs);
            }
            if (fwp_heap.live != baseline || fwp_heap.rc_wide_len) return 90;
        }
    }
    puts("record folds: one final box, no temporary retains, aliases and reuse verified");
    return 0;
}
