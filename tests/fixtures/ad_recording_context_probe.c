static int loop_recover(void) { return 1; }
static fwp_tape_scope loop_scope = {-1};
static fwp_cleanup loop_scope_owner;

int main(void) {
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    const int lengths[] = {0, 1, 2, 4, 65};
    size_t baseline = fwp_heap.live;
    for (unsigned length = 0; length < 5; length++)
    for (int mode = 0; mode < 6; mode++) for (int alias = 0; alias < 2; alias++) {
        int count = lengths[length], pairs = count ? count - 1 : 0;
        if (mode >= 2 && mode <= 4 && pairs < 2) continue;
        fwp_cleanup_push(&loop_scope_owner, fwp_tape_scope_release, &loop_scope);
        V first = fwp_p_ad_tape(4), second = fwp_p_ad_tape(4);
        V xs = 0;
        for (int i = count; i > 0; i--) {
            V node = mode == 5 ? (V)-1 : mode == 1 && (i - 1) % 2 ? second : first;
            if (mode == 2 && i == 1) node = first + 4;
            xs = fwp_rc_fresh(fwp_cons(node, xs));
        }
        if (alias) fwp_rc_dup(xs);
        loop_lookups = loop_appends = 0;
        loop_fail_at = mode == 3 ? 2 : mode == 4 ? (unsigned)pairs + 1 : 0;
        jmp_buf jump;
        fwp_trap_recover = loop_recover; fwp_trap_jb = &jump;
        fwp_trap_cleanup = loop_scope_owner.prev;
        if (!setjmp(jump)) {
            V result = TRANSFORM(xs);
            if (mode >= 2 && mode <= 4) return 81;
            unsigned expected = !pairs || mode == 5 ? 0 : mode == 1 ? 2U * (unsigned)pairs : 2;
            if (loop_lookups != expected) return 82;
            if (loop_appends != (mode == 5 ? 0U : 2U * (unsigned)pairs)) return 83;
            V root = OBJ(result)->f[0];
            if (fwp_f64(OBJ(result)->f[1]) != 2.0 * pairs) return 84;
            if (!pairs || mode == 5) {
                if (root != (V)-1) return 85;
            } else {
                V base = mode == 1 && (pairs - 1) % 2 ? second : first;
                if ((root >> 32) != (base >> 32)) return 86;
                V gradient = fwp_rc_fresh(fwp_p_ad_backward_one(base, root, fwp_from_f64(1.0)));
                if (ARR(gradient)->len != 4 || fwp_f64(ARR(gradient)->d[0]) != 1.0) return 87;
                for (int i = 1; i < 4; i++) if (fwp_f64(ARR(gradient)->d[i]) != 0.0) return 87;
                fwp_rc_free_arr(gradient);
            }
            fwp_rc_free_obj(result); /* Point has only immediate numeric fields. */
            fwp_cleanup_pop(&loop_scope_owner);
            fwp_tape_scope_release(&loop_scope);
        } else {
            const char *expected = mode == 2 ? FWP_AD_INVALID_NODE : "injected loop recording failure";
            if (mode < 2 || mode > 4 || strcmp(fwp_trap_msg, expected)) return 88;
            if (mode != 2 && loop_appends != loop_fail_at) return 89;
        }
        fwp_trap_recover = NULL; fwp_trap_jb = NULL; fwp_trap_cleanup = NULL;
        loop_fail_at = 0;
        if (alias) {
            V cursor = xs;
            for (int i = 0; i < count; i++) {
                V expected = mode == 5 ? (V)-1 : mode == 1 && i % 2 ? second : first;
                if (mode == 2 && i == 0) expected = first + 4;
                if (!cursor || OBJ(cursor)->f[0] != expected) return 90;
                cursor = OBJ(cursor)->f[1];
            }
            if (cursor || (xs && *fwp_rc_slot(xs) != 1)) return 90;
            DROP_LIST(xs);
        }
        if (fwp_cleanups || loop_scope.head != -1) return 91;
        fwp_tape_finish(); fwp_caf_finish();
        if (fwp_tapes || fwp_ntapes || fwp_tapes_cap || fwp_tape_cached_bytes
            || fwp_heap.live != baseline || fwp_heap.rc_wide_len) return 92;
    }
    return 0;
}
