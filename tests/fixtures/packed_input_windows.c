static int windows_recover(void) { return 1; }
static fwp_task windows_task;

int main(void) {
    fwp_prog_out = stdout;
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    const int64_t bounds[][2] = {
        {-2, 3}, {INT64_MIN, INT64_MAX}, {INT64_MAX - 3, INT64_MAX},
        {5, 2}, {2, 2}, {0, 1}, {0, 2}
    };
    const int lengths[] = {0, 1, 3, 4};
    for (int round = 0; round < 4; round++) for (unsigned b = 0; b < 7; b++)
    for (unsigned length = 0; length < 4; length++)
    for (volatile int mode = 0; mode < 11; mode++) for (unsigned aliases = 0; aliases < 4; aliases++) {
        uint64_t available = bounds[b][1] > bounds[b][0]
            ? (uint64_t)bounds[b][1] - (uint64_t)bounds[b][0] : 0;
        int count = lengths[length];
        if (available < (uint64_t)count) count = (int)available;
        if ((mode == 1 || mode == 2) && count < 2) continue;
        if (mode >= 3 && mode <= 6 && count < 3) continue;
        if (mode == 9 && count < 2) continue;
        size_t baseline = fwp_heap.live, live = owner_ledger_live;
        V seed = fwp_rc_fresh(fwp_record(2, (V[]){99, 5}));
        V xs = 0;
        for (int i = lengths[length]; i > 0; i--) xs = fwp_rc_fresh(fwp_cons((V)(i * 10), xs));
        if (aliases & 1) fwp_rc_dup(seed);
        if (aliases & 2) fwp_rc_dup(xs);
        windows_mode = mode;
        windows_phase = windows_inputs = windows_pairs = windows_folds = windows_fail_allocation = 0;
        windows_input_buffer = windows_pair_buffer = 0;
        size_t allocations = owner_ledger_allocations;
        jmp_buf jump;
        fwp_trap_recover = windows_recover; fwp_trap_jb = &jump; fwp_trap_cleanup = 0;
        memset(&windows_task, 0, sizeof windows_task);
        int cancel = mode == 2 || mode == 4 || mode == 6;
        if (cancel) { windows_task.base = &jump; fwp_cur = &windows_task; fwp_budget = 1000000; }
        if (!setjmp(jump)) {
            V result = TRANSFORM((V)bounds[b][0], (V)bounds[b][1], 7, seed, xs);
            if (mode != 0) return 240;
            V expected_index = count > 1 ? (V)((uint64_t)bounds[b][0] + (uint64_t)(count - 2 + TAIL_OFFSET)) : 99;
            int expected_value = 5;
            for (int i = 0; i + 1 < count; i++) expected_value += (i + 1) * 10 + 7 + (i + 2) * 10 + 7;
            if (OBJ(result)->f[0] != expected_index || OBJ(result)->f[1] != (V)expected_value) return 241;
            /* Two buffers and the boxed export result. The internal fold also
             * boxes its result for a nonempty map; the export worker consumes
             * that box (or the empty-map seed) before returning numeric fields.
             * Caller seed/list construction is outside this observation. */
            size_t added = owner_ledger_allocations - allocations;
            size_t expected_allocations = 3 + (size_t)(count > 1);
            if (added != expected_allocations) {
                fprintf(stderr, "packed input allocations: inputs=%d bounds=%u aliases=%u expected=%zu actual=%zu\n",
                    count, b, aliases, expected_allocations, added);
                return 248;
            }
            if (!round) printf("inputs=%d bounds=%u aliases=%u managed-objects=%zu\n", count, b, aliases, added);
            DROP_POINT(result);
        } else if (mode == 0) return 242;
        fwp_cur = NULL; fwp_trap_recover = NULL; fwp_trap_jb = NULL;
        windows_fail_allocation = 0;
        if (fwp_cleanups || (cancel && !windows_task.unwinding)) return 243;
        int inputs = mode == 7 ? 0 : (mode == 1 || mode == 2) ? 2 : count;
        int pairs = mode == 7 || mode == 8 || mode == 10 || mode == 1 || mode == 2 ? 0
            : (mode == 3 || mode == 4) ? 2 : count > 0 ? count - 1 : 0;
        int folds = mode == 0 || mode == 9 ? pairs : (mode == 5 || mode == 6) ? 2 : 0;
        if (windows_inputs != inputs || windows_pairs != pairs || windows_folds != folds) return 244;
        if (aliases & 1) {
            if (*fwp_rc_slot(seed) != 1 || OBJ(seed)->f[0] != 99 || OBJ(seed)->f[1] != 5) return 245;
            DROP_POINT(seed);
        }
        if (aliases & 2) {
            V cursor = xs;
            for (int i = 0; i < lengths[length]; i++) {
                if (!cursor || OBJ(cursor)->f[0] != (V)((i + 1) * 10)) return 246;
                cursor = OBJ(cursor)->f[1];
            }
            if (cursor || (xs && *fwp_rc_slot(xs) != 1)) return 247;
            DROP_LIST(xs);
        }
        if (fwp_heap.live != baseline || owner_ledger_live != live || fwp_heap.rc_wide_len) return 90;
    }
    owner_ledger_finish();
    puts("packed input windows, aliases, ordering and nonlocal cleanup verified");
    return 0;
}
