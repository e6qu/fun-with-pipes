static int record_fold_recover(void) { return 1; }
static fwp_task record_fold_task;
int main(void) {
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    for (int round = 0; round < 32; round++) {
        for (volatile int mode = 0; mode < 3; mode++) for (unsigned aliases = 0; aliases < 4; aliases++) {
            double baseline = fwp_heap.live;
            V seed = fwp_rc_fresh(fwp_record(2, (V[]){7, fwp_from_f64(0.25)}));
            V xs = 0;
            for (int i = 3; i > 0; i--) {
                V value = fwp_rc_fresh(fwp_record(2, (V[]){(V)i, fwp_from_f64((double)i)}));
                xs = fwp_rc_fresh(fwp_cons(value, xs));
            }
            if (aliases & 1) fwp_rc_dup(seed);
            if (aliases & 2) fwp_rc_dup(xs);
            record_fold_mode = mode;
            record_fold_visits = 0;
            record_fold_fail_box = 0;
            jmp_buf jump;
            fwp_trap_recover = record_fold_recover;
            fwp_trap_jb = &jump; fwp_trap_cleanup = 0;
            memset(&record_fold_task, 0, sizeof record_fold_task);
            if (mode == 2) {
                record_fold_task.base = &jump;
                fwp_cur = &record_fold_task; fwp_budget = 1000000;
            }
            if (!setjmp(jump)) {
                TRANSFORM(FWP_FALSE, seed, xs);
                return 240;
            }
            fwp_cur = NULL;
            fwp_trap_recover = NULL; fwp_trap_jb = NULL;
            record_fold_fail_box = 0;
            if (fwp_cleanups || (mode == 2 && !record_fold_task.unwinding)) return 241;
            if (record_fold_visits != (mode == 1 ? 3 : 2)) return 242;
            if (aliases & 1) {
                if (*fwp_rc_slot(seed) != 1 || OBJ(seed)->f[0] != 7 ||
                    fwp_f64(OBJ(seed)->f[1]) != 0.25) return 243;
                DROP_POINT(seed);
            }
            if (aliases & 2) {
                if (*fwp_rc_slot(xs) != 1 || OBJ(OBJ(xs)->f[0])->f[0] != 1) return 244;
                DROP_LIST(xs);
            }
            if (fwp_heap.live != baseline || fwp_heap.rc_wide_len) return 90;
        }
    }
    puts("record fold callback, result allocation and cancellation cleanup verified");
    return 0;
}
