int main(void) {
    fwp_prog_out = stdout;
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    const uint64_t wide[] = {
        0, UINT64_C(0x8000000000000000), 1, UINT64_C(0x8000000000000001),
        UINT64_C(0x7fefffffffffffff), UINT64_C(0xffefffffffffffff),
        UINT64_C(0x7ff0000000000000), UINT64_C(0xfff0000000000000),
        UINT64_C(0x7ff8000000001234), UINT64_C(0xfff8000000005678),
        UINT64_C(0x7ff0000000000001)
    };
    const uint32_t narrow[] = {
        0, UINT32_C(0x80000000), 1, UINT32_C(0x80000001),
        UINT32_C(0x7f7fffff), UINT32_C(0xff7fffff),
        UINT32_C(0x7f800000), UINT32_C(0xff800000),
        UINT32_C(0x7fc01234), UINT32_C(0xffc05678), UINT32_C(0x7f800001)
    };
    for (size_t i = 0; i < 11; i++) for (size_t j = 0; j < 11; j++) {
        size_t live = owner_ledger_live, bytes = fwp_heap.live;
        V words[2] = {FLOAT_WIDTH == 64 ? wide[i] : narrow[i], FLOAT_WIDTH == 64 ? wide[j] : narrow[j]};
        V xs = fwp_rc_fresh(fwp_cons(words[0], fwp_rc_fresh(fwp_cons(words[1], 0))));
        V seed = fwp_rc_fresh(fwp_record(2, (V[]){0, 0}));
        V result = TRANSFORM((V)(int64_t)-3, (V)(int64_t)-1, seed, xs);
        if (OBJ(result)->f[0] != (V)(int64_t)(-2 - SELECTED_INDEX)
            || OBJ(result)->f[1] != words[SELECTED_INDEX]) return 241;
        DROP_POINT(result);
        if (owner_ledger_live != live || fwp_heap.live != bytes || fwp_cleanups) return 90;
    }
    owner_ledger_finish();
    puts("packed input float bits verified");
    return 0;
}
