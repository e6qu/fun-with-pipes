/* Replaces the CLI entry to observe the generated function's own allocation. */
int main(void) {
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    size_t baseline = fwp_heap.live;
    const size_t lengths[] = {0, 16, 4096};
    for (size_t i = 0; i < 3; i++) {
        unique_probe_owner = 0;
        unique_probe_allocations = unique_probe_frees = unique_probe_counts = 0;
        unique_probe_active = 1;
        if (@PARTIAL@) {
            fwp_handler handler;
            handler.prev = fwp_handlers; handler.state_depth = fwp_state_len;
            handler.cleanup = fwp_cleanups; fwp_handlers = &handler;
            if (!setjmp(handler.jb)) { @ENTRY@(4); return 228; }
            fwp_handlers = handler.prev;
            if (fwp_cleanups != handler.cleanup) return 229;
        } else {
            V result = @ENTRY@((V)lengths[i]);
            if ((int64_t)result != 2 * (int64_t)lengths[i]) return 226;
        }
        /* extra-count-control */
        if (unique_probe_counts) return 224;
        if (unique_probe_allocations != 1 || unique_probe_frees != 1) return 227;
        if (fwp_heap.live != baseline) return 225;
        unique_probe_active = 0;
    }
    return 0;
}
