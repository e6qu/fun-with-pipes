static int nested_mode, nested_hit;
static size_t nested_expected_frees, nested_actual_frees;
static jmp_buf nested_recovered;
static fwp_task nested_cancelled;
static int nested_recover(void) { return 1; }
static void nested_point(int stage) {
    if (nested_hit || (nested_mode != stage && !(nested_mode == 6 && stage == 4))) return;
    nested_hit = stage;
    if (nested_mode == 6) {
        nested_cancelled.identity = UINT64_MAX;
        nested_cancelled.cancelled = 1;
        fwp_check_cancel();
        abort();
    }
    fwp_trap("managed tape unwind control");
}
static void nested_free(void *pointer) {
    if (pointer) nested_actual_frees++;
    fwp_mem_free(pointer);
}
int main(int argc, char **argv) {
    if (argc != 2) return 190;
    nested_mode = atoi(argv[1]);
    fwp_heap_start();
    fwp_fns = fwp_fn_table; fwp_init_consts(); fwp_tasks_init();
    size_t live_bytes = fwp_heap.live;
    fwp_task *saved = fwp_cur;
    fwp_trap_recover = nested_recover;
    fwp_trap_jb = &nested_recovered; fwp_trap_cleanup = NULL;
    if (nested_mode == 6) {
#ifdef _WIN32
        /* This injected task runs on the current stack, not a new fiber. */
        nested_cancelled.ctx.top = saved->ctx.top;
#endif
        fwp_cur = &nested_cancelled;
        jmp_buf nested_cancelled_base; nested_cancelled.base = &nested_cancelled_base;
        if (!setjmp(nested_cancelled_base)) { NESTED_MAIN(); return 191; }
        nested_cancelled.base=NULL;fwp_cur = saved;
        if (!nested_cancelled.unwinding) return 192;
    } else if (!setjmp(nested_recovered)) {
        NESTED_MAIN();
        if (nested_mode) return 191;
    } else if (!nested_mode || strcmp(fwp_trap_msg,"managed tape unwind control")) return 192;
    fwp_handlers = NULL;
    fwp_caf_finish(); /* Ownership observation point: before runtime teardown. */ fwp_tasks_finish();
    if (fwp_cleanups || fwp_owned_tapes) return 193;
    for (int64_t i=0;i<fwp_ntapes;i++) if (fwp_tapes[i].live) return 194;
    if (!nested_expected_frees || nested_actual_frees != nested_expected_frees) return 195;
    if (nested_mode && !nested_hit) return 196;
#if FWP_ARC_ONLY
    if (fwp_heap.enabled || fwp_heap.ncollect || fwp_heap.live > live_bytes) return 197;
#endif
    puts("managed tapes release on callback failure and cancellation");
    return 0;
}
