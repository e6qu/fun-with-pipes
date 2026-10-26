/* Exercise the same direct owned-entry convention as generated String maps.
 * Every case returns the physical managed allocation charge to its baseline. */
static jmp_buf map_jump;
static fwp_task map_cancelled;
static int map_force, map_fail_at, map_calls;
static int map_recover(void) { return 1; }
static void map_leaf_drop(V value) {
    if (fwp_rc_release_last(value)) fwp_rc_free_obj(value);
}
static void map_list_drop(V value) {
    while (value && fwp_rc_release_last(value)) {
        V tail = OBJ(value)->f[1];
        map_leaf_drop(OBJ(value)->f[0]);
        fwp_rc_free_obj(value);
        value = tail;
    }
}
static V map_text(const char *text) {
    return fwp_rc_fresh(fwp_str_new(text, strlen(text)));
}
static V map_source(void) {
    V tail = 0;
    const char *words[] = {"AbC", "DeF", "GhI"};
    for (size_t i = 3; i; i--) {
        V text = map_text(words[i - 1]);
        tail = fwp_rc_fresh(fwp_cons(text, tail));
    }
    return tail;
}
static uint64_t map_hash(V list) {
    uint64_t h = 1;
    for (; list; list = OBJ(list)->f[1]) {
        V text = OBJ(list)->f[0];
        for (size_t i = 0; i < STR(text)->len; i++) h = h * 131 + (unsigned char)STR(text)->d[i];
    }
    return h;
}
static V map_step(V *args) {
    fwp_value_owner value = {args[0], map_leaf_drop}; fwp_cleanup cleanup;
    fwp_value_protect(&value, &cleanup);
    if (++map_calls == map_fail_at) {
        if (map_force == 1) fwp_trap("map callback control");
        if (map_force == 2) fwp_check_cancel();
    }
    V result = fwp_p_case(value.value, 0);
    if (result == value.value) return fwp_value_finish(&value, &cleanup);
    fwp_rc_fresh(result);
    fwp_value_release(&value); fwp_value_finish(&value, &cleanup);
    return result;
}
int main(void) {
    fwp_heap_start();
    fwp_fns = fwp_fn_table; fwp_init_consts(); fwp_tasks_init();
    size_t initial = fwp_heap.live;
    for (int repeat = 0; repeat < 64; repeat++) for (int alias_kind = 0; alias_kind < 4; alias_kind++) {
        V source = map_source(), alias = 0;
        if (alias_kind == 1) alias = source;
        if (alias_kind == 2) alias = OBJ(source)->f[1];
        if (alias_kind == 3) alias = OBJ(source)->f[0];
        if (alias) fwp_rc_dup(alias);
        uint64_t before = alias_kind == 1 || alias_kind == 2 ? map_hash(alias) : 0;
        map_calls = 0;
        V result = fwp_k_map_strings_owned(map_step, source, map_leaf_drop, map_list_drop);
        if (map_calls != 3 || fwp_list_len(result) != 3) return 241;
        const char *expected[] = {"abc", "def", "ghi"};
        V cursor = result;
        for (size_t i = 0; i < 3; i++, cursor = OBJ(cursor)->f[1]) {
            V text = OBJ(cursor)->f[0];
            if (STR(text)->len != 3 || memcmp(STR(text)->d, expected[i], 3)) return 242;
        }
        if (alias_kind == 1 || alias_kind == 2) {
            if (map_hash(alias) != before) return 243;
            map_list_drop(alias);
        }
        if (alias_kind == 3) {
            if (STR(alias)->len != 3 || memcmp(STR(alias)->d, "AbC", 3)) return 243;
            map_leaf_drop(alias);
        }
        map_list_drop(result);
        if (fwp_cleanups || fwp_heap.live != initial) return 245;
    }
    if (fwp_k_map_strings_owned(map_step, 0, map_leaf_drop, map_list_drop)) return 241;
    for (int kind = 1; kind <= 5; kind++) for (int position = 1; position <= 3; position++) for (int alias_kind = 0; alias_kind < 4; alias_kind++) {
        V source = map_source(), alias = 0;
        if (alias_kind == 1) alias = source;
        if (alias_kind == 2) alias = OBJ(source)->f[1];
        if (alias_kind == 3) alias = OBJ(source)->f[0];
        if (alias) fwp_rc_dup(alias);
        uint64_t before = alias_kind == 1 || alias_kind == 2 ? map_hash(alias) : 0;
        map_force = kind; map_fail_at = position; map_calls = 0;
        fwp_trap_recover = map_recover; fwp_trap_jb = &map_jump; fwp_trap_cleanup = NULL;
        fwp_task *previous = fwp_cur;
        memset(&map_cancelled, 0, sizeof map_cancelled);
        if (kind == 2) {
            map_cancelled.identity = UINT64_MAX; map_cancelled.cancelled = 1;
#ifdef _WIN32
            map_cancelled.ctx.top = previous->ctx.top;
#endif
            map_cancelled.base = &map_jump; fwp_cur = &map_cancelled;
        }
        if (!setjmp(map_jump)) {
            fwp_k_map_strings_owned(map_step, source, map_leaf_drop, map_list_drop);
            return 244;
        }
        map_cancelled.base = NULL; fwp_cur = previous;
        fwp_trap_recover = NULL; fwp_trap_jb = NULL; map_force = 0;
        if (kind == 1 && strcmp(fwp_trap_msg, "map callback control")) return 244;
        if (kind == 2 && !map_cancelled.unwinding) return 244;
        if (kind >= 3 && strcmp(fwp_trap_msg, "map allocation control")) return 244;
        if (alias_kind == 1 || alias_kind == 2) {
            if (map_hash(alias) != before) return 243;
            map_list_drop(alias);
        }
        if (alias_kind == 3) {
            if (STR(alias)->len != 3 || memcmp(STR(alias)->d, "AbC", 3)) return 243;
            map_leaf_drop(alias);
        }
        if (fwp_cleanups || fwp_heap.live != initial) return 245;
    }
    fwp_tasks_finish();
    if (fwp_heap.live != initial) return 245;
    puts("string maps preserve aliases and release source, results and scratch");
    return 0;
}
