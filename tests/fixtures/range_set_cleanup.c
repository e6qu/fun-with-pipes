static int range_fail, range_allocations;
static jmp_buf range_jump;
static int range_recover(void) { return 1; }
static V range_test_new(size_t n, size_t columns) {
    range_allocations++;
    if (range_fail) fwp_trap("range set allocation failure");
    return fwp_map_typed_new(n, columns);
}
int main(void) {
    fwp_gc_start(__builtin_frame_address(0)); fwp_fns = fwp_fn_table; fwp_init_consts();
    for (int trial=0; trial<6; trial++) for (int repeat=0; repeat<64; repeat++) {
        const fwp_desc element = {.kind=trial==3 || trial==5 ? K_U64 : K_I64};
        V lo = trial==2 ? (V)INT64_MIN : trial==3 ? 0 : trial==5 ? UINT64_MAX : (V)-2;
        V hi = trial==2 ? (V)INT64_MAX : trial==3 ? UINT64_MAX : trial==4 ? lo : trial==5 ? 0 : 3;
        intptr_t before = fwp_gc.budget_given - fwp_gc.budget;
        range_allocations = 0;
        // Also intercept oversized allocations if the size guard is removed.
        // The negative control must fail without attempting a huge allocation.
        range_fail = trial>=1 && trial<=3;
        fwp_trap_recover = range_recover; fwp_trap_jb = &range_jump;
        fwp_trap_cleanup = fwp_cleanups;
        if (!setjmp(range_jump)) {
            V result = fwp_p_set_range(lo, hi, &element);
            if (trial>=1 && trial<=3) return 242;
            if (MAP(result)->len != (trial==0 ? 5 : 0)) return 242;
            if (trial==0 && (MAP(result)->d[0]!=(V)-2 || MAP(result)->d[4]!=2)) return 242;
            fwp_rc_free_obj(result);
        } else if (trial==0 || trial>=4) return 242;
        fwp_trap_recover = NULL; fwp_trap_jb = NULL;
        if (fwp_cleanups || fwp_gc.budget_given - fwp_gc.budget != before) return 243;
        if (range_allocations != (trial<2 ? 1 : 0)) return 245;
    }
    return 0;
}
