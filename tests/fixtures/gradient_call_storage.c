static fwp_task storage_task;
static int storage_recover(void) { return 1; }
static int storage_values(V xs, double first, double second) {
    return xs && OBJ(xs)->f[1] && !OBJ(OBJ(xs)->f[1])->f[1]
        && fwp_f64(OBJ(xs)->f[0]) == first
        && fwp_f64(OBJ(OBJ(xs)->f[1])->f[0]) == second;
}
int main(void) {
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    size_t baseline = fwp_heap.live, live = owner_ledger_live;
    unsigned failures = 0, cancellations = 0;
    for (int alias = 0; alias < 2; alias++)
    for (volatile int mode = 0; mode < 4; mode++)
    for (int fail = 1; fail < 9; fail++) {
        storage_mode = 0; storage_fail_after = 0;
        V xs = fwp_rc_fresh(fwp_cons(fwp_from_f64(4), 0));
        xs = fwp_rc_fresh(fwp_cons(fwp_from_f64(2), xs));
        if (alias) fwp_rc_dup(xs);
        storage_input = xs; storage_retains = storage_allocations = 0;
        storage_mode = mode; storage_fail_after = mode == 3 ? fail : 0;
        jmp_buf jump;
        memset(&storage_task, 0, sizeof storage_task);
        if (mode == 2) {
            storage_task.base = &jump; fwp_cur = &storage_task; fwp_budget = 1000000;
        }
        fwp_trap_recover = storage_recover; fwp_trap_jb = &jump; fwp_trap_cleanup = NULL;
        if (!setjmp(jump)) {
            V result = SCOPED_ENTRY(xs);
            if (storage_retains) return 231;
            if (mode == 1 || mode == 2) return 232;
            if (!storage_values(OBJ(result)->f[0], 3, 0)
                || !storage_values(OBJ(result)->f[1], 2, 4)) return 233;
            DROP_LIST(OBJ(result)->f[0]); DROP_LIST(OBJ(result)->f[1]);
            fwp_rc_free_obj(result);
        } else {
            if (storage_retains) return 231;
            failures++;
            if (mode == 2) cancellations++;
            else if (mode != 1 && !(mode == 3 && storage_allocations == fail)) return 234;
        }
        fwp_cur = NULL; fwp_trap_recover = NULL; fwp_trap_jb = NULL;
        storage_input = 0; storage_fail_after = 0;
        if (fwp_cleanups || (mode == 2 && !storage_task.unwinding)) return 235;
        if (alias) {
            if (!storage_values(xs, 2, 4) || *fwp_rc_slot(xs) != 1) return 236;
            DROP_LIST(xs);
        }
        fwp_tape_finish();
        if (fwp_heap.live != baseline || owner_ledger_live != live || fwp_heap.rc_wide_len) return 90;
    }
    if (!failures || !cancellations) return 237;
    puts("scoped input: zero retains, aliases preserved, all owners released");
    return 0;
}
