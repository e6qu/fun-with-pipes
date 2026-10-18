/* Measurement control from 9f0632f9c1abf4f067fa659f1d95c5768cb8a965.
 * Never linked into the compiler/runtime; reconstructs the old buffer layout. */
static V fwp_map_build_typed(V *keys, V *vals, size_t n, const fwp_map_ops *ops, const fwp_desc *kd) {
    if (!n) return FWP_EMPTY_MAP;
    V *tk = (V *)fwp_mem_alloc((n + 1) * sizeof(V));
    fwp_cleanup tk_cleanup, tv_cleanup;
    fwp_scratch_protect(&tk, &tk_cleanup);
    V *tv = NULL;
    if (vals) {
        tv = (V *)fwp_mem_alloc((n + 1) * sizeof(V));
        fwp_scratch_protect(&tv, &tv_cleanup);
    }
    fwp_msort(keys, vals ? vals : keys, n, kd, tk, tv ? tv : tk);
    size_t len = 0;
    for (size_t i = 0; i < n; len++) {
        size_t j = i + 1;
        while (j < n && fwp_cmp(keys[j], keys[i], kd) == 0) j++;
        tk[len] = keys[i];
        if (tv) tv[len] = vals[j - 1];
        i = j;
    }
    V result = fwp_map_typed_new(len);
    MAP(result)->len = 0;
    fwp_value_owner owner = {result, ops->drop_map};
    fwp_cleanup cleanup;
    fwp_value_protect(&owner, &cleanup);
    for (size_t i = 0; i < len; i++) {
        if (ops->dup_key) ops->dup_key(tk[i]);
        MAP(result)->d[2 * i] = tk[i];
        MAP(result)->len = i + 1;
        V value = tv ? tv[i] : 0;
        if (ops->dup_value) ops->dup_value(value);
        MAP(result)->d[2 * i + 1] = value;
    }
    fwp_value_finish(&owner, &cleanup);
    if (tv) fwp_scratch_finish(&tv, &tv_cleanup);
    fwp_scratch_finish(&tk, &tk_cleanup);
    FWP_KEEP_ALIVE(keys); FWP_KEEP_ALIVE(vals);
    return result;
}
static V fwp_p_map_from_list_typed(V xs, const fwp_map_ops *ops, const fwp_desc *kd) {
    V source = xs;
    size_t n = fwp_list_len(xs);
    if (n >= SIZE_MAX / sizeof(V)) fwp_trap("map too large");
    V *keys = (V *)fwp_mem_alloc((n + 1) * sizeof(V));
    fwp_cleanup keys_cleanup, vals_cleanup;
    fwp_scratch_protect(&keys, &keys_cleanup);
    V *vals = (V *)fwp_mem_alloc((n + 1) * sizeof(V));
    fwp_scratch_protect(&vals, &vals_cleanup);
    for (size_t i = 0; xs; i++, xs = OBJ(xs)->f[1]) {
        V pair = OBJ(xs)->f[0]; keys[i] = OBJ(pair)->f[0]; vals[i] = OBJ(pair)->f[1];
    }
    V result = fwp_map_build_typed(keys, vals, n, ops, kd);
    fwp_scratch_finish(&vals, &vals_cleanup);
    fwp_scratch_finish(&keys, &keys_cleanup);
    FWP_KEEP_ALIVE(source);
    return result;
}
