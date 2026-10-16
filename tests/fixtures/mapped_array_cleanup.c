static int mapped_test_calls, mapped_test_fail, mapped_test_collect;
static jmp_buf mapped_test_jump;
static int mapped_test_recover(void) { return 1; }
static V mapped_test_apply(V value) {
    mapped_test_calls++;
#ifndef FWP_ARC_ONLY
    if (mapped_test_collect) fwp_gc_collect();
#endif
    if (mapped_test_fail && mapped_test_calls == 2) fwp_trap("mapped array callback failure");
    return fwp_from_f64(fwp_f64(value) * 2.0);
}
int main(void) {
    fwp_gc_start(__builtin_frame_address(0)); fwp_fns = fwp_fn_table; fwp_init_consts();
    const fwp_desc element = {.kind=K_F64};
    V source = fwp_rc_fresh(fwp_cons(fwp_from_f64(1.5), fwp_rc_fresh(fwp_cons(fwp_from_f64(-2.0), 0))));
    for (mapped_test_collect = 0; mapped_test_collect < 2; mapped_test_collect++) {
        for (mapped_test_fail = 0; mapped_test_fail < 2; mapped_test_fail++) for (int repeat=0; repeat<16; repeat++) {
            intptr_t before = fwp_gc.budget;
            mapped_test_calls = 0;
            fwp_trap_recover = mapped_test_recover; fwp_trap_jb = &mapped_test_jump;
            fwp_trap_cleanup = fwp_cleanups;
            if (!setjmp(mapped_test_jump)) {
                V result = fwp_p_array_map_list(0, source, &element);
                if (mapped_test_fail || fwp_array_len(result)!=2 ||
                    fwp_array_load(result,0,&element)!=fwp_from_f64(3.0) ||
                    fwp_array_load(result,1,&element)!=fwp_from_f64(-4.0)) return 230;
                fwp_rc_resource_free_arr(result);
            } else if (!mapped_test_fail) return 230;
            fwp_trap_recover = NULL; fwp_trap_jb = NULL;
            if (fwp_cleanups || mapped_test_calls != 2) return 232;
            if (!mapped_test_collect && fwp_gc.budget != before) return 231;
            if (OBJ(source)->f[0] != fwp_from_f64(1.5)) return 233;
        }
    }
    FWP_KEEP_ALIVE(source); return 0;
}
