static int packed_recover(void) { return 1; }
static fwp_task packed_task;
int main(void) {
    fwp_prog_out = stdout;
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    for (int round = 0; round < 16; round++) {
        for (volatile int mode = 0; mode < 8; mode++) for (unsigned aliases = 0; aliases < 4; aliases++) {
            double baseline = fwp_heap.live;
            V seed = fwp_rc_fresh(fwp_record(2, (V[]){7, fwp_from_f64(0.25)}));
            V xs = 0;
            for (int i = 3; i > 0; i--) xs = fwp_rc_fresh(fwp_cons((V)i, xs));
            if (aliases & 1) fwp_rc_dup(seed);
            if (aliases & 2) fwp_rc_dup(xs);
            packed_mode = mode; packed_stage = 0; packed_map_visits = packed_fold_visits = packed_fail_allocation = 0;
            jmp_buf jump;
            fwp_trap_recover = packed_recover;
            fwp_trap_jb = &jump; fwp_trap_cleanup = 0;
            memset(&packed_task, 0, sizeof packed_task);
            int cancel = mode == 3 || mode == 4;
            if (cancel) {
                packed_task.base = &jump;
                fwp_cur = &packed_task; fwp_budget = 1000000;
            }
            if (!setjmp(jump)) {
                V result = TRANSFORM(mode == 1 ? FWP_TRUE : FWP_FALSE, seed, xs);
                if (mode != 7) return 240;
                if (OBJ(result)->f[0] != 13 || fwp_f64(OBJ(result)->f[1]) != 1.75) return 245;
                DROP_POINT(result);
            } else if (mode == 7) return 246;
            fwp_cur = NULL;
            fwp_trap_recover = NULL; fwp_trap_jb = NULL;
            packed_fail_allocation = 0;
            if (fwp_cleanups || (cancel && !packed_task.unwinding)) return 241;
            int maps = mode == 5 ? 0 : (mode == 0 || mode == 3) ? 2 : 3;
            int folds = (mode == 2 || mode == 4) ? 2 : (mode == 6 || mode == 7) ? 3 : 0;
            if (packed_map_visits != maps || packed_fold_visits != folds) return 242;
            if (aliases & 1) {
                if (*fwp_rc_slot(seed) != 1 || OBJ(seed)->f[0] != 7 ||
                    fwp_f64(OBJ(seed)->f[1]) != 0.25) return 243;
                DROP_POINT(seed);
            }
            if (aliases & 2) {
                if (*fwp_rc_slot(xs) != 1 || OBJ(xs)->f[0] != 1) return 244;
                DROP_LIST(xs);
            }
            if (fwp_heap.live != baseline || fwp_heap.rc_wide_len) return 90;
        }
    }
    puts("packed map, seed, fold, allocation and cancellation cleanup verified");
    return 0;
}
