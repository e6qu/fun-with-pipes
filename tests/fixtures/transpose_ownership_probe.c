static jmp_buf transpose_failure;
static int fail_duplicate, fail_node, duplicates, nodes;
static int transpose_recover(void) { return 1; }
static void transpose_drop_text(V v) {
    if (fwp_rc_release_last(v)) fwp_rc_free_obj(v);
}
static void transpose_drop_row(V xs) {
    while (xs && fwp_rc_release_last(xs)) {
        V next = OBJ(xs)->f[1];
        transpose_drop_text(OBJ(xs)->f[0]);
        fwp_rc_free_obj(xs);
        xs = next;
    }
}
static void transpose_drop_matrix(V xs) {
    while (xs && fwp_rc_release_last(xs)) {
        V next = OBJ(xs)->f[1];
        transpose_drop_row(OBJ(xs)->f[0]);
        fwp_rc_free_obj(xs);
        xs = next;
    }
}
static void transpose_duplicate(V v) {
    if (++duplicates == fail_duplicate) fwp_trap("transpose retain probe");
    fwp_rc_dup(v);
}
static V transpose_cons(V head, V tail) {
    if (++nodes == fail_node) fwp_trap("transpose construction probe");
    return fwp_cons(head, tail);
}

int main(void) {
    fwp_heap_start();
    fwp_fns = fwp_fn_table;
    fwp_init_consts();
    size_t baseline = fwp_heap.live;
    V values[6], input = 0;
    for (int i = 0; i < 6; ++i) values[i] = fwp_rc_fresh(fwp_str_new("alias", 5));
    for (int i = 2; i >= 0; --i) {
        V row = fwp_rc_fresh(fwp_cons(values[2*i+1], 0));
        row = fwp_rc_fresh(fwp_cons(values[2*i], row));
        input = fwp_rc_fresh(fwp_cons(row, input));
    }
    size_t live_bytes = fwp_heap.live;
    V result = fwp_p_list_transpose_owned(input, transpose_duplicate,
        transpose_drop_text, transpose_drop_row, transpose_drop_matrix);
    V column = result;
    for (int j = 0; j < 2; ++j) {
        if (!column) return 200;
        V row = OBJ(column)->f[0];
        for (int i = 0; i < 3; ++i) {
            if (!row || OBJ(row)->f[0] != values[2*i+j]) return 200;
            if (*fwp_rc_slot(values[2*i+j]) != 2) return 201;
            row = OBJ(row)->f[1];
        }
        if (row) return 200;
        column = OBJ(column)->f[1];
    }
    if (column) return 200;
    transpose_drop_matrix(result);
    if (fwp_heap.live != live_bytes) return 202;

    /* Trap at each retain and node construction, including after a completed
     * column. All input counts and scratch/output storage must be restored. */
    fwp_trap_recover = transpose_recover;
    fwp_trap_jb = &transpose_failure;
    fwp_trap_cleanup = fwp_cleanups;
    for (int mode = 0; mode < 2; ++mode) {
        for (int step = 1; step <= (mode ? 8 : 6); ++step) {
            duplicates = nodes = 0;
            fail_duplicate = mode ? 0 : step;
            fail_node = mode ? step : 0;
            if (!setjmp(transpose_failure)) {
                (void)fwp_p_list_transpose_owned(input, transpose_duplicate,
                    transpose_drop_text, transpose_drop_row, transpose_drop_matrix);
                return 203;
            }
            if (fwp_cleanups != fwp_trap_cleanup || (fwp_heap.live != live_bytes)) return 204;
            for (int i = 0; i < 6; ++i) if (*fwp_rc_slot(values[i]) != 1) return 205;
        }
    }
    fwp_trap_recover = 0; fwp_trap_jb = 0; fwp_trap_cleanup = 0;
    transpose_drop_matrix(input);
    if (fwp_heap.live != baseline) return 206;
    return 0;
}
