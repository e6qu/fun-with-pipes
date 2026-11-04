static void field_drop(V value) {
    if (fwp_fn_table[4].owned->drop_arguments)
        fwp_fn_table[4].owned->drop_arguments(&value, 0, 1);
}
static void field_list_drop(V value) {
    fwp_fn_table[5].owned->drop_arguments(&value, 0, 1);
}
static V field_list(int count) {
    V result = 0;
    for (int i = count; i > 0; i--) result = fwp_rc_fresh(fwp_cons(field_new(i - 1), result));
    return result;
}
static int field_list_check(V xs, int count) {
    for (int i = 0; i < count; i++) {
        if (!xs || !field_check(OBJ(xs)->f[0], i)) return 0;
        xs = OBJ(xs)->f[1];
    }
    return xs == 0;
}
static int field_steps, field_fault;
static fwp_task field_task;
static jmp_buf field_jump;
static int field_recover(void) { return 1; }
static V field_checkpoint(V unit) {
    (void)unit;
    if (++field_steps == 3) {
        if (field_fault == 1) fwp_trap("field callback failed");
        if (field_fault == 2) {
            field_task.cancelled = 1;
            fwp_check_cancel();
        }
    }
    return 0;
}
int main(int argc, char **argv) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0 ||
        _setmode(_fileno(stderr), _O_BINARY) < 0) return 253;
#endif
    if (argc != 3) return 93;
    field_path = argv[2];
    int missing = !strcmp(argv[1], "missing-release");
    field_corrupt_tag = !strcmp(argv[1], "corrupt-tag");
    if (!missing && !field_corrupt_tag && strcmp(argv[1], "complete")) return 94;
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts(); fwp_budget = 1000000;
    const int indices[] = {-1, 0, 1, 2, 9};
    for (int length = 0; length <= 3; length += 3)
    for (int alias = 0; alias < 2; alias++)
    for (int last = 0; last < 2; last++)
    for (size_t at = 0; at < sizeof indices / sizeof *indices; at++)
    for (int boxed = 0; boxed < 2; boxed++) {
        int index = last ? length - 1 : indices[at];
        int found = index >= 0 && index < length;
        size_t baseline = fwp_heap.live, live = owner_ledger_live;
        V xs = field_list(length), otherwise = field_new(9);
        if (alias) fwp_rc_dup(xs);
        size_t allocations = owner_ledger_allocations;
        V result;
        if (boxed) {
            /* The generic primitive borrows the list and returns an owned box.
             * Transfer its payload, then consume the same caller arguments. */
            V option = last ? f3(xs) : f2((V)(int64_t)index, xs);
            if (option) {
                result = OBJ(option)->f[0];
                fwp_rc_free_obj(option);
                field_drop(otherwise);
            } else result = otherwise;
            field_list_drop(xs);
        } else if (last) {
            V args[] = {xs, otherwise};
            result = fwp_fn_table[1].owned->entry(args);
        } else {
            V args[] = {(V)(int64_t)index, xs, otherwise};
            result = fwp_fn_table[0].owned->entry(args);
        }
        size_t added = owner_ledger_allocations - allocations;
        if (!field_check(result, found ? index : 9)) return 82;
        if (added != (size_t)(boxed && found)) return 80;
        if (alias) {
            if (!field_list_check(xs, length)) return 83;
            field_list_drop(xs);
        }
        if (!(missing && found)) field_drop(result);
        if (fwp_heap.live != baseline || owner_ledger_live != live || fwp_heap.rc_wide_len) return 90;
        printf("option fields: length=%d alias=%d last=%d index=%d boxed=%d allocations=%zu\n",
            length, alias, last, index, boxed, added);
    }
#if FIELD_COUNTED
    /* A failed retain owns no result. Preserve the external list alias while
     * the caller releases its list reference and its unused default. */
    for (volatile int last = 0; last < 2; last++) {
        size_t baseline = fwp_heap.live, live = owner_ledger_live;
        V xs = field_list(3), selected = OBJ(OBJ(xs)->f[1])->f[0];
        if (last) selected = OBJ(OBJ(OBJ(xs)->f[1])->f[1])->f[0];
        fwp_rc_dup(xs);
#if FIELD_RESOURCE
        ((fwp_file *)(uintptr_t)selected)->refs = UINT64_MAX;
#else
        for (int i = 1; i < 255; i++) fwp_rc_dup(selected);
        (*fwp_rc_wide_link(fwp_rc_slot(selected)))->count = SIZE_MAX;
#endif
        size_t retained = fwp_heap.live;
        V otherwise = field_new(9);
        fwp_trap_recover = field_recover; fwp_trap_jb = &field_jump; fwp_trap_cleanup = 0;
        if (!setjmp(field_jump)) {
            if (last) { V args[] = {xs, otherwise}; (void)fwp_fn_table[1].owned->entry(args); }
            else { V args[] = {1, xs, otherwise}; (void)fwp_fn_table[0].owned->entry(args); }
            return 84;
        }
        fwp_trap_recover = NULL; fwp_trap_jb = NULL;
        if (strcmp(fwp_trap_msg, "reference count overflow") || fwp_cleanups ||
            !fwp_rc_last(xs) || fwp_heap.live != retained || !field_list_check(xs, 3)) return 85;
#if FIELD_RESOURCE
        if (((fwp_file *)(uintptr_t)selected)->refs != UINT64_MAX) return 86;
        ((fwp_file *)(uintptr_t)selected)->refs = 1;
#else
        if ((*fwp_rc_wide_link(fwp_rc_slot(selected)))->count != SIZE_MAX) return 86;
        fwp_rc_fresh(selected);
#endif
        field_list_drop(xs);
        if (fwp_heap.live != baseline || owner_ledger_live != live || fwp_heap.rc_wide_len) return 90;
    }
#endif
#if FIELD_ITERATION
    const int counts[] = {-1, 0, 1, 4, 64};
    for (int alias = 0; alias < 2; alias++)
    for (size_t at = 0; at < sizeof counts / sizeof *counts; at++) {
        int count = counts[at];
        size_t baseline = fwp_heap.live, live = owner_ledger_live;
        V initial = field_new(0), otherwise = field_new(9);
        if (alias && fwp_fn_table[4].owned->arguments)
            fwp_fn_table[4].owned->arguments(&initial, 0, 1);
        V callback = fwp_rc_fresh(fwp_pap(9, 0, NULL));
        size_t allocations = owner_ledger_allocations;
        field_steps = 0;
        V args[] = {(V)(int64_t)count, callback, initial, otherwise};
        V result = fwp_fn_table[8].owned->entry(args);
        if (!field_check(result, count > 0 ? 0 : 9) || field_steps != (count > 0 ? count - 1 : 0)) return 82;
        /* Wide callback ABIs can allocate independently of an Option wrapper. */
        size_t added = owner_ledger_allocations - allocations;
        if (!FIELD_COUNTED && added != 0) return 80;
        if (alias) {
            if (!field_check(initial, 0)) return 83;
            field_drop(initial);
        }
        field_drop(result);
        if (fwp_heap.live != baseline || owner_ledger_live != live || fwp_heap.rc_wide_len) return 90;
        printf("iteration fields: count=%d alias=%d allocations=%zu\n", count, alias, added);
    }
    for (volatile int mode = 1; mode <= 4; mode++)
    for (volatile int alias = 0; alias < 2; alias++) {
        size_t baseline = fwp_heap.live, live = owner_ledger_live;
        V initial = field_new(0);
        if (alias && fwp_fn_table[4].owned->arguments)
            fwp_fn_table[4].owned->arguments(&initial, 0, 1);
        V callback = fwp_rc_fresh(fwp_pap(9, 0, NULL));
        /* Mode 4 calls the whole-value entry and faults only its final box. */
        V otherwise = mode == 4 ? 0 : field_new(9);
        field_steps = 0; field_fault = mode; field_fail_box = mode == 4;
        fwp_trap_recover = field_recover; fwp_trap_jb = &field_jump; fwp_trap_cleanup = 0;
        memset(&field_task, 0, sizeof field_task);
        if (mode == 2) { field_task.base = &field_jump; fwp_cur = &field_task; }
        if (!setjmp(field_jump)) {
            if (mode == 4) {
                V args[] = {1, callback, initial};
                (void)fwp_fn_table[7].owned->entry(args);
            } else {
                V args[] = {mode == 3 ? INT64_MAX : 64, callback, initial, otherwise};
                (void)fwp_fn_table[8].owned->entry(args);
            }
            return 84;
        }
        fwp_cur = NULL; fwp_trap_recover = NULL; fwp_trap_jb = NULL;
        field_fault = 0; field_fail_box = 0;
        if (fwp_cleanups || field_steps != (mode <= 2 ? 3 : 0)) return 85;
        if (mode == 2 && !field_task.unwinding) return 86;
        if (mode != 2 && strcmp(fwp_trap_msg, mode == 1 ? "field callback failed" :
                mode == 3 ? "iterate too large" : "injected option boxing failure")) return 87;
        if (alias) {
            if (!field_check(initial, 0)) return 83;
            field_drop(initial);
        }
        if (fwp_heap.live != baseline || owner_ledger_live != live || fwp_heap.rc_wide_len) return 90;
    }
#endif
    owner_ledger_finish();
    return 0;
}
