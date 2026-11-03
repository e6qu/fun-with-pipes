/* Generated typed entries own their arguments. The callback's yield primitive
 * is replaced with iteration_checkpoint, after its argument owner is installed. */
static int iteration_fault, iteration_steps;
static fwp_task iteration_task;
static jmp_buf iteration_jump;
static int iteration_recover(void) { return 1; }
static V iteration_checkpoint(V unit) {
    (void)unit;
    if (++iteration_steps != 3) return 0;
    if (iteration_fault == 1) fwp_trap("iteration callback failed");
    if (iteration_fault == 2) {
        iteration_task.cancelled = 1;
        fwp_check_cancel();
    }
    return 0;
}
static void iteration_drop_state(V value) {
    if (fwp_fn_table[4].owned->drop_arguments)
        fwp_fn_table[4].owned->drop_arguments(&value, 0, 1);
}
static void iteration_dup_state(V value) {
    fwp_fn_table[4].owned->arguments(&value, 0, 1);
}
static V iteration_call(V count, V callback, V state) {
    V arguments[] = {count, callback, state};
    return fwp_fn_table[2].owned->entry(arguments);
}
static void iteration_drop_result(V value) {
    fwp_fn_table[6].owned->drop_arguments(&value, 0, 1);
}
int main(int argc, char **argv) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0 ||
        _setmode(_fileno(stderr), _O_BINARY) < 0) return 253;
#endif
    if (argc != 2) return 93;
    int missing = !strcmp(argv[1], "missing-release");
    if (!missing && strcmp(argv[1], "complete")) return 94;
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts(); fwp_budget = 1000000;
    if (!fwp_fn_table[2].owned || !fwp_fn_table[4].owned ||
        !fwp_fn_table[6].owned || !fwp_fn_table[7].owned) return 95;
    const int counts[] = {-1, 0, 1, 4, 64};
    for (iteration_sliced = 0; iteration_sliced <= ITERATION_ARRAY; iteration_sliced++)
    for (int captured = 0; captured < 2; captured++)
    for (int alias = 0; alias < 2; alias++)
    for (size_t c = 0; c < sizeof counts / sizeof *counts; c++) {
        int count = counts[c];
        size_t baseline = fwp_heap.live, live = owner_ledger_live;
        V input = iteration_new_state(0);
        if (alias) iteration_dup_state(input);
        V capture = captured ? iteration_new_state(1) : 0;
        V callback = fwp_rc_fresh(fwp_pap(captured ? 7 : 4, captured, &capture));
        iteration_steps = 0;
        size_t allocations = owner_ledger_allocations;
        V result = iteration_call((V)(int64_t)count, callback, input);
        size_t added = owner_ledger_allocations - allocations;
        size_t expected = count > 0 ? (size_t)count * ITERATION_SPINES + 1 : 0;
        /* Scalar callbacks do not box results. Wide callbacks may allocate at
         * their typed ABI; record those costs without calling them list nodes. */
        if ((ITERATION_COUNT_SCALAR && added != expected) ||
            iteration_steps != (count > 0 ? count - 1 : 0)) return 80;
        printf("iteration allocations: count=%d capture=%d alias=%d slice=%d added=%zu\n",
            count, captured, alias, iteration_sliced, added);
        if (count <= 0) {
            if (result) return 81;
        } else {
            if (!result || OBJ(result)->tag != 1 ||
                !iteration_check_state(OBJ(result)->f[0], captured && count > 1)) return 82;
            if (!missing) iteration_drop_result(result);
        }
        if (alias) {
            if (!iteration_check_state(input, 0)) return 83;
            iteration_drop_state(input);
        }
        if (fwp_heap.live != baseline || owner_ledger_live != live || fwp_heap.rc_wide_len) return 90;
    }
    /* Failure at the third callback, cancellation, and count rejection must
     * release the consumed input, current state, history and callback capture. */
    for (iteration_sliced = 0; iteration_sliced <= ITERATION_ARRAY; iteration_sliced++)
    for (volatile int mode = 1; mode <= 3; mode++)
    for (int captured = 0; captured < 2; captured++)
    for (int alias = 0; alias < 2; alias++) {
        size_t baseline = fwp_heap.live, live = owner_ledger_live;
        V input = iteration_new_state(0);
        if (alias) iteration_dup_state(input);
        V capture = captured ? iteration_new_state(1) : 0;
        V callback = fwp_rc_fresh(fwp_pap(captured ? 7 : 4, captured, &capture));
        iteration_steps = 0; iteration_fault = mode;
        fwp_trap_recover = iteration_recover; fwp_trap_jb = &iteration_jump; fwp_trap_cleanup = 0;
        memset(&iteration_task, 0, sizeof iteration_task);
        if (mode == 2) {
            iteration_task.base = &iteration_jump; fwp_cur = &iteration_task; fwp_budget = 1000000;
        }
        if (!setjmp(iteration_jump)) {
            (void)iteration_call(mode == 3 ? INT64_MAX : 64, callback, input);
            return 84;
        }
        fwp_cur = NULL; fwp_trap_recover = NULL; fwp_trap_jb = NULL; iteration_fault = 0;
        if (fwp_cleanups || iteration_steps != (mode == 3 ? 0 : 3)) return 85;
        if (mode == 2 && !iteration_task.unwinding) return 86;
        if (mode != 2 && strcmp(fwp_trap_msg,
                mode == 3 ? "iterate too large" : "iteration callback failed")) return 87;
        if (alias) {
            if (!iteration_check_state(input, 0)) return 88;
            iteration_drop_state(input);
        }
        if (fwp_heap.live != baseline || owner_ledger_live != live || fwp_heap.rc_wide_len) return 90;
    }
    owner_ledger_finish();
    puts("final iteration: exact bits, counts, aliases, captures, failure and cancellation pass");
    return 0;
}
