/* Returned aliases, an escaping closure and an unknown callback need ordinary
 * owners. Test their actual entries, not versions inlined into source main. */
int main(void) {
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    size_t baseline = fwp_heap.live;
    const size_t lengths[] = {0, 16, 4096};
    for (size_t i = 0; i < 3; ++i) {
        V n = (V)lengths[i];
        escape_probe_unique = 0;
        V pair = @shared@(n);
        V left = OBJ(pair)->f[0], right = OBJ(pair)->f[1];
        if (left != right || !fwp_rc_slot(left) || fwp_rc_unique(left)) return 231;
        fwp_rc_free_obj(pair);
        if (fwp_rc_release_last(left)) return 232;
        if (fwp_array_len(right) != lengths[i] || !fwp_rc_release_last(right)) return 232;
        fwp_mem_free((void *)(uintptr_t)right);
        /* unexpected-unique-control */
        if (escape_probe_unique || fwp_heap.live != baseline) return 233;

        V record = @captured@(n);
        V callback = OBJ(record)->f[0];
        if (!fwp_rc_slot(callback)) return 234;
        fwp_rc_dup(callback);
        /* retain-callback */
        if (fwp_rc_unique(callback)) return 234;
        fwp_rc_free_obj(record);
        V first = fwp_apply_owned(callback, 1, (V[]){0});
        V second = fwp_apply_owned(callback, 1, (V[]){0});
        if (first != n || second != n) return 235;
        if (escape_probe_unique || fwp_heap.live != baseline) return 236;

        record = @reader@(0);
        callback = OBJ(record)->f[0];
        fwp_rc_free_obj(record);
        if (@unknown@(callback, n) != n) return 237;
        if (escape_probe_unique || fwp_heap.live != baseline) return 238;
    }
    return 0;
}
