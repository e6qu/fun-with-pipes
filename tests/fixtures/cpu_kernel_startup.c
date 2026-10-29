/* Static worker attributes must succeed; partially started jobs must join. */
int main(void) {
    fwp_static_init();
    fwp_heap_start();
    const int64_t code[] = {FWP_K_CONST};
    const V constants[] = {fwp_from_f64(2.5)};
    const fwp_kernel kernel = {.code=code, .ncode=1, .consts=constants, .depth=1};
    /* Worker writes survive the recoverable setup trap without setjmp locals. */
    static double output[4 * FWP_KCHUNK];
    for (int failure = 0; failure < 4; failure++) {
        kernel_counters_reset();
        kernel_attr_attempts = kernel_attr_live = kernel_attr_destroyed = 0;
        kernel_attr_failure = failure;
        kernel_thread_fail = failure == 3 ? 2 : 0;
        for (size_t i = 0; i < 4 * FWP_KCHUNK; i++) output[i] = -99;
        fwp_trap_recover = kernel_recover;
        fwp_trap_jb = &kernel_jump;
        fwp_trap_cleanup = fwp_cleanups;
        if (!setjmp(kernel_jump)) {
            fwp_kernel_parallel(&kernel, 0, 4 * FWP_KCHUNK, 4, 4, output);
            if (failure) return 247;
            for (size_t i = 0; i < 4 * FWP_KCHUNK; i++)
                if (output[i] != 2.5) return 247;
        } else if (!failure || strcmp(fwp_trap_msg, "cannot create numerical worker thread")) {
            return 247;
        }
        fwp_trap_recover = NULL; fwp_trap_jb = NULL;
        if (fwp_cleanups || kernel_attr_live || atomic_load(&kernel_live)) return 248;
        if (failure) {
            int destroyed = failure == 1 ? 1 : 2;
            int attempted = failure == 3 ? 2 : 1;
            if (kernel_attr_attempts != 2 || kernel_attr_destroyed != destroyed ||
                kernel_thread_attempts != attempted || kernel_thread_started != 1 ||
                kernel_thread_joined != 1 || output[0] != -99) return 249;
        } else if (kernel_attr_attempts != 3 || kernel_attr_destroyed != 3 ||
                   kernel_thread_started != 3 || kernel_thread_joined != 3) return 249;
    }
    puts("static worker setup failures release attributes and join started workers");
    return 0;
}
