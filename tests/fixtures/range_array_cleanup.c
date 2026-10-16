static int range_fail, range_allocations;
static jmp_buf range_jump;
static int range_recover(void) { return 1; }
static V range_test_new(size_t n, const fwp_desc *element) {
    range_allocations++;
    if (range_fail) fwp_trap("range array allocation failure");
    return fwp_array_typed_new(n, element);
}
int main(void) {
    fwp_gc_start(__builtin_frame_address(0)); fwp_fns = fwp_fn_table; fwp_init_consts();
    const fwp_desc element = {.kind=K_I64};
    for (int trial=0; trial<3; trial++) for (int repeat=0; repeat<64; repeat++) {
        intptr_t before = fwp_gc.budget;
        range_allocations = 0; range_fail = trial == 1;
        fwp_trap_recover = range_recover; fwp_trap_jb = &range_jump;
        fwp_trap_cleanup = fwp_cleanups;
        if (!setjmp(range_jump)) {
            V result = fwp_p_array_range(trial==2 ? (V)INT64_MIN : (V)-2,
                trial==2 ? (V)INT64_MAX : 3, &element);
            if (trial || fwp_array_len(result)!=5 ||
                fwp_array_load(result,0,&element)!=(V)-2 ||
                fwp_array_load(result,4,&element)!=2) return 242;
            fwp_rc_resource_free_arr(result);
        } else if (!trial) return 242;
        fwp_trap_recover = NULL; fwp_trap_jb = NULL;
        if (fwp_cleanups || fwp_gc.budget != before) return 243;
        if (range_allocations != (trial==2 ? 0 : 1)) return 245;
    }
    return 0;
}
