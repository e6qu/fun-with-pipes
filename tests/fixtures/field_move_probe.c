static jmp_buf move_failure;
static int move_recover(void) { return 1; }
static void move_drop(V value) {
    if (value && fwp_rc_release_last(value)) fwp_rc_free_obj(value);
}
static int move_text(V value, const char *expected) {
    size_t n = strlen(expected);
    return STR(value)->len == n && !memcmp(STR(value)->d, expected, n);
}
int main(void) {
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    size_t live_bytes = fwp_heap.live;
    for (int shared = 0; shared < 2; shared++) {
        for (int alias = 0; alias < 2; alias++) {
            for (int repeat = 0; repeat < 64; repeat++) {
                V input = fwp_rc_fresh(fwp_cstr("abc"));
                if (alias) fwp_rc_dup(input);
                move_retains = 0;
                V result = shared ? f4(input) : f2(input);
                if (!move_text(result, shared ? "abc" : "abcabc")) return 196;
                if (*fwp_rc_slot(result) != (shared && alias ? 2 : 1)) return 197;
                if (move_retains != (size_t)shared) {
                    fprintf(stderr, "unexpected retains: shared=%d alias=%d count=%zu\n", shared, alias, move_retains);
                    return 198;
                }
                move_drop(result);
                if (alias) {
                    if (*fwp_rc_slot(input) != 1 || !move_text(input, "abc")) return 199;
                    move_drop(input);
                }
                if (fwp_heap.live != live_bytes) return 200;
                if (fwp_cleanups) return 201;
            }
        }
    }
    fwp_trap_recover = move_recover; fwp_trap_jb = &move_failure;
    fwp_trap_cleanup = fwp_cleanups;
    for (int repeat = 0; repeat < 64; repeat++) {
        V input = fwp_rc_fresh(fwp_cstr("abc"));
        if (!setjmp(move_failure)) { (void)f6(input); return 202; }
        if (fwp_cleanups != fwp_trap_cleanup) return 203;
        if (fwp_heap.live != live_bytes) return 204;
    }
    return 0;
}
