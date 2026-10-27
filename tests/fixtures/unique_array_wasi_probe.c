/* Return from the recovery frame before checking the allocation baseline. */
static int unique_probe_attempt(void) {
    fwp_handler handler;
    handler.prev = fwp_handlers; handler.state_depth = fwp_state_len;
    handler.cleanup = fwp_cleanups; fwp_handlers = &handler;
    if (!setjmp(handler.jb)) { @ENTRY@(@FAIL_LENGTH@); return 228; }
    fwp_handlers = handler.prev;
    return fwp_cleanups == handler.cleanup ? 0 : 229;
}

int main(void) {
    fwp_fns = fwp_fn_table; fwp_init_consts();
    size_t baseline = wasm_arc_bytes, entries = fwp_wasm_counts_live;
    const size_t lengths[] = {0, 16, 4096};
    for (size_t i = 0; i < 3; ++i) {
        unique_probe_owner = 0;
        unique_probe_allocations = unique_probe_frees = unique_probe_counts = 0;
        unique_probe_active = 1;
        if (@PARTIAL@) {
            int error = unique_probe_attempt();
            if (error) return error;
        } else if (@ENTRY@((V)lengths[i]) != 2 * lengths[i]) return 226;
        /* extra-count-control */
        if (unique_probe_counts || fwp_wasm_counts_live != entries) return 224;
        if (unique_probe_allocations != 1 || unique_probe_frees != 1) return 227;
        if (wasm_arc_bytes != baseline) return 225;
        unique_probe_active = 0;
    }
    return 0;
}
