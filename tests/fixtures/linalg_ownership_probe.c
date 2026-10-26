/* Exercise ownership separately from algorithm timing. Collection and injected
 * traps occur only after scratch/results have acquired a cleanup owner. */
static jmp_buf la_failure;
static int la_events, la_fail_at, la_collect;
static int la_recover(void) { return 1; }
static void la_event(void) {
    if (++la_events == la_fail_at) fwp_trap("solver allocation probe");
}
static V la_input(const double *values, size_t count) {
    V array = fwp_rc_fresh(fwp_arr_new(count));
    for (size_t i = 0; i < count; i++) ARR(array)->d[i] = fwp_from_f64(values[i]);
    return array;
}
static V la_call(int kind, V matrix, V rhs) {
    switch (kind) {
    case 0: return fwp_p_lu_solve(2, matrix, rhs);
    case 1: return fwp_p_det(2, matrix);
    case 2: return fwp_p_inverse(2, matrix);
    case 3: return fwp_p_cholesky(2, matrix);
    case 4: return fwp_p_qr(2, 2, matrix);
    default: return fwp_p_cg(8, fwp_from_f64(0.000001), 2, matrix, rhs);
    }
}
static void la_drop(int kind, V result) {
    if (kind == 1) return;
    if (kind == 5) { fwp_rc_free_arr(result); return; }
    if (result == FWP_NONE) return;
    fwp_rc_free_arr(OBJ(result)->f[0]);
    if (kind == 4) fwp_rc_free_arr(OBJ(result)->f[1]);
    fwp_rc_free_obj(result);
}
int main(void) {
    fwp_heap_start();
    fwp_fns = fwp_fn_table;
    fwp_init_consts();
    const char *setting = getenv("FWP_LINALG_COLLECTION");
    la_collect = setting && !strcmp(setting, "1");
    const double diagonal[] = {4, 0, 0, 9}, vector[] = {8, 18};
    const double singular[] = {1, 2, 2, 4}, indefinite[] = {1, 2, 2, 1};
    V matrix = la_input(diagonal, 4), rhs = la_input(vector, 2);
    V bad = la_input(singular, 4), negative = la_input(indefinite, 4);
    size_t live_bytes = fwp_heap.live;
    for (int kind = 0; kind < 6; kind++) {
        for (int iteration = 0; iteration < 256; iteration++) {
            la_events = 0;
            V result = la_call(kind, matrix, rhs);
            if (kind == 1 && fwp_f64(result) != 36.0) return 221;
            if (kind == 0 && (fwp_f64(ARR(OBJ(result)->f[0])->d[0]) != 2.0 ||
                             fwp_f64(ARR(OBJ(result)->f[0])->d[1]) != 2.0)) return 221;
            la_drop(kind, result);
            if (!la_collect && fwp_heap.live != live_bytes) return 222;
        }
        int allocations = la_events;
        fwp_trap_recover = la_recover;
        fwp_trap_jb = &la_failure;
        fwp_trap_cleanup = fwp_cleanups;
        for (int step = 1; step <= allocations; step++) {
            la_events = 0; la_fail_at = step;
            if (!setjmp(la_failure)) { (void)la_call(kind, matrix, rhs); return 223; }
            if (fwp_cleanups != fwp_trap_cleanup ||
                (!la_collect && fwp_heap.live != live_bytes)) return 224;
            if (*fwp_rc_slot(matrix) != 1 || *fwp_rc_slot(rhs) != 1) return 225;
        }
        la_fail_at = 0;
        fwp_trap_recover = 0; fwp_trap_jb = 0; fwp_trap_cleanup = 0;
    }
    if (fwp_p_lu_solve(2, bad, rhs) != FWP_NONE ||
        fwp_p_inverse(2, bad) != FWP_NONE ||
        fwp_p_cholesky(2, negative) != FWP_NONE ||
        fwp_f64(fwp_p_det(2, bad)) != 0.0) return 226;
    if (!la_collect && fwp_heap.live != live_bytes) return 222;
    for (size_t i = 0; i < 4; i++)
        if (fwp_f64(ARR(matrix)->d[i]) != diagonal[i]) return 227;
    if (la_collect && !fwp_heap.ncollect) return 228;
    fwp_rc_free_arr(matrix); fwp_rc_free_arr(rhs);
    fwp_rc_free_arr(bad); fwp_rc_free_arr(negative);
    return 0;
}
