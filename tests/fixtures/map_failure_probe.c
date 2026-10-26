/* Inject every allocation/retain/comparison failure into real typed map/set operations.
 * The allocation ledger also observes logical frees under reuse poisoning. */
static int map_test_armed, map_test_step, map_test_fail, map_test_live;
static void *map_test_allocations[256];
static void map_test_tick(void) {
    if (map_test_armed && ++map_test_step == map_test_fail)
        fwp_trap("injected map storage failure");
}
static void map_test_record(void *p) {
    if (!map_test_armed || !p) return;
    for (size_t i = 0; i < 256; i++) if (!map_test_allocations[i]) {
        map_test_allocations[i] = p; map_test_live++; return;
    }
    abort();
}
static void map_test_release(void *p) {
    for (size_t i = 0; i < 256; i++) if (p && map_test_allocations[i] == p) {
        map_test_allocations[i] = NULL; map_test_live--; return;
    }
}
static jmp_buf map_test_jb;
static int map_test_recover(void) { return 1; }
static V map_test_leaf[6], map_test_base, map_test_set, map_test_other;
static V map_test_pairs, map_test_keys, map_test_nodes[6], map_test_input;
static const fwp_map_ops map_test_scalar_ops = SCALAR_OPS;
static V map_test_scalar(V v) { DROP_STRING(v); return map_test_leaf[5]; }
static const fwp_map_ops map_test_ops = MAP_OPS;
static const fwp_map_ops map_test_set_ops = SET_OPS;
static const fwp_map_ops map_test_columns = COLUMN_OPS;
static const fwp_map_ops map_test_pairs_ops = PAIR_OPS;
static const fwp_desc *map_test_key_type = KEY_TYPE;
static const fwp_desc map_test_string = {.kind = K_STR, .dup = fwp_rc_dup, .drop = DROP_STRING};
static const fwp_desc map_test_map_type = {.kind = K_MAP, .elem = &map_test_string,
    .elem2 = &map_test_string, .dup = fwp_rc_dup, .drop = DROP_MAP};

static int map_test_consumes(int op) {
    return op == 1 || op == 2 || op == 3 || op == 13 || op == 14 || op == 15 || (op >= 18 && op <= 20);
}
static V map_test_operation(int op) {
    const fwp_map_ops *m = &map_test_ops, *s = &map_test_set_ops;
    V k = map_test_leaf[0], v = map_test_leaf[5], third = map_test_leaf[2];
    switch (op) {
    case 0: return fwp_map_typed_copy(map_test_base, 3, 1, m);
    case 1: case 13: return fwp_p_map_insert_typed(third, v, map_test_input, m, map_test_key_type);
    case 2: return fwp_p_map_insert_typed(k, v, map_test_input, m, map_test_key_type);
    case 3: case 14: return fwp_p_map_remove_typed(k, map_test_input, m, map_test_key_type);
    case 4: return fwp_p_map_get_typed(k, map_test_base, m, map_test_key_type);
    case 5: return fwp_p_map_keys_typed(map_test_base, &map_test_columns);
    case 6: return fwp_p_map_values_typed(map_test_base, &map_test_columns);
    case 7: return fwp_p_map_to_list_typed(map_test_base, &map_test_pairs_ops);
    case 8: return fwp_p_map_from_list_typed(map_test_pairs, m, map_test_key_type);
    case 9: return fwp_p_set_from_list_typed(map_test_keys, s, map_test_key_type);
    case 10: return fwp_p_set_union_typed(map_test_other, map_test_set, s, map_test_key_type);
    case 11: return fwp_p_set_intersect_typed(map_test_other, map_test_set, s, map_test_key_type);
    case 12: return fwp_p_set_diff_typed(map_test_other, map_test_set, s, map_test_key_type);
    case 15: return fwp_p_map_update_typed(k, CALLBACK, v, map_test_input, m, map_test_key_type);
    case 16: return fwp_p_map_map_values_typed(CALLBACK, map_test_base, m);
    case 17: {
        fwp_decode_fields fields;
        fwp_decode_fields_begin(&fields, 4, NULL, 0, &map_test_string);
        for (size_t i = 0; i < 4; i++) {
            V value = map_test_leaf[i % 2 + (i % 2 ? 2 : 0)];
            fwp_rc_dup(value); fields.values[i] = value;
        }
        return fwp_decode_map(&fields, &map_test_map_type);
    }
    case 18: return fwp_p_set_insert_typed(third, map_test_input, s, map_test_key_type);
    case 19: return fwp_p_set_remove_typed(k, map_test_input, s, map_test_key_type);
    case 20: return fwp_p_map_remove_typed(third, map_test_input, m, map_test_key_type);
    case 21: return fwp_p_map_map_values_typed(SCALAR_CALLBACK, map_test_base, &map_test_scalar_ops);
    default: abort();
    }
}
static void map_test_drop_result(int op, V value) {
    if (op == 21) map_test_scalar_ops.drop_map(value);
    else if (op == 4) DROP_OPTION(value);
    else if (op == 5 || op == 6) map_test_columns.drop_result(value);
    else if (op == 7) map_test_pairs_ops.drop_result(value);
    else if ((op >= 9 && op <= 12) || op == 18 || op == 19) DROP_SET(value);
    else DROP_MAP(value);
}
static int map_test_case(int op, int failure, int *steps) {
    unsigned char counts[6];
    for (size_t i = 0; i < 6; i++) counts[i] = *fwp_rc_slot(map_test_leaf[i]);
    size_t before = fwp_heap.live;
    map_test_input = (op == 18 || op == 19) ? map_test_set : map_test_base;
    if (op == 13 || op == 14)
        map_test_input = fwp_map_typed_copy(map_test_base, 2, 1, &map_test_ops);
    else if (map_test_consumes(op)) fwp_rc_dup(map_test_input);
    map_test_step = map_test_live = 0; map_test_fail = failure; map_test_armed = 1;
    if (op == 13 || op == 14) map_test_record((void *)(uintptr_t)map_test_input);
    fwp_trap_recover = map_test_recover; fwp_trap_jb = &map_test_jb; fwp_trap_cleanup = fwp_cleanups;
    if (!setjmp(map_test_jb)) {
        V result = map_test_operation(op);
        if (failure) return 210;
        map_test_drop_result(op, result);
    } else if (!failure) return 211;
    map_test_armed = 0; fwp_trap_recover = NULL; fwp_trap_jb = NULL;
    *steps = map_test_step;
    if (fwp_cleanups) return 212;
    if (map_test_live) return 213;
    if (*fwp_rc_slot(map_test_base) != 1 || *fwp_rc_slot(map_test_set) != 1) return 214;
    if (MAP(map_test_base)->len != 2 || MAP(map_test_base)->d[0] != map_test_leaf[0] ||
        MAP(map_test_base)->d[1] != map_test_leaf[3] || MAP(map_test_set)->len != 2) return 215;
    for (size_t i = 0; i < 6; i++)
        if (*fwp_rc_slot(map_test_leaf[i]) != counts[i] || !STR(map_test_leaf[i])->len) return 216;
#ifdef FWP_ARC_ONLY
    if (fwp_heap.live != before) return 217;
#else
    (void)before;
#endif
    return 0;
}
int main(void) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 253;
#endif
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    const char *texts[] = {"a", "b", "c", "first", "second", "third"};
    for (size_t i = 0; i < 6; i++) map_test_leaf[i] = fwp_rc_fresh(fwp_cstr(texts[i]));
    map_test_base = fwp_map_typed_new(2, 2); map_test_set = fwp_map_typed_new(2, 1); map_test_other = fwp_map_typed_new(2, 1);
    for (size_t i = 0; i < 2; i++) {
        fwp_rc_dup(map_test_leaf[i]); fwp_rc_dup(map_test_leaf[i + 3]);
        MAP(map_test_base)->d[2*i] = map_test_leaf[i]; MAP(map_test_base)->d[2*i+1] = map_test_leaf[i+3];
        fwp_rc_dup(map_test_leaf[i]); MAP(map_test_set)->d[i] = map_test_leaf[i];
        fwp_rc_dup(map_test_leaf[i+1]); MAP(map_test_other)->d[i] = map_test_leaf[i+1];
    }
    /* These test-only input spines borrow the independently rooted leaves. */
    for (size_t i = 2; i; i--) {
        V pair = fwp_rc_fresh(fwp_tuple2(map_test_leaf[i-1], map_test_leaf[i+2]));
        map_test_nodes[3*(i-1)] = pair;
        map_test_pairs = fwp_rc_fresh(fwp_cons(pair, map_test_pairs));
        map_test_nodes[3*(i-1)+1] = map_test_pairs;
        map_test_keys = fwp_rc_fresh(fwp_cons(map_test_leaf[i-1], map_test_keys));
        map_test_nodes[3*(i-1)+2] = map_test_keys;
    }
    int failures = 0;
    for (int op = 0; op <= 21; op++) {
        int steps = 0, observed;
        int result = map_test_case(op, 0, &steps);
        if (result) { fprintf(stderr, "map operation %d baseline: %d\n", op, result); return result; }
        for (int fail = 1; fail <= steps; fail++) {
            result = map_test_case(op, fail, &observed);
            if (result) { fprintf(stderr, "map operation %d failure %d/%d: %d\n", op, fail, steps, result); return result; }
            failures++;
        }
    }
    DROP_MAP(map_test_base); DROP_SET(map_test_set); DROP_SET(map_test_other);
    for (size_t i = 0; i < 6; i++) { fwp_rc_free_obj(map_test_nodes[i]); DROP_STRING(map_test_leaf[i]); }
    printf("22 map/set operations: %d injected failures cleaned; aliases preserved\n", failures);
    return 0;
}
