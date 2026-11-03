/* Entry failure, real cancellation, post-transfer yield failure, and result
 * boxing failure. Shared outer boxes/children must remain valid afterward. */
static void field_unwind_@width@(int direct, int shared, int same, int mode) {
    size_t baseline = fwp_heap.live;
    V children[@width@];
    for (size_t i = 0; i < @width@; i++) {
        if (same && i) { children[i] = children[0]; fwp_rc_dup(children[i]); }
        else children[i] = fwp_rc_fresh(fwp_cstr("field"));
    }
    V box = 0;
    if (direct) {
        if (shared) for (size_t i = 0; i < @width@; i++) fwp_rc_dup(children[i]);
    } else {
        box = fwp_rc_fresh(fwp_record(@width@, children));
        if (shared) fwp_rc_dup(box);
    }
    field_mode = mode; field_entries = field_yields = field_fail_allocation = 0;
    jmp_buf jump;
    fwp_trap_recover = field_recover; fwp_trap_jb = &jump; fwp_trap_cleanup = 0;
    memset(&field_task, 0, sizeof field_task);
    int cancel = mode == 2 || mode == 4;
    fwp_budget = INT32_MAX;
    if (cancel) { field_task.base = &jump; fwp_cur = &field_task; }
    if (!setjmp(jump)) {
        if (direct) {
            @result_type@ result = @worker@(@arguments@);
            (void)result;
        } else {
            @entry@(box);
        }
        exit(241);
    }
    fwp_cur = NULL; fwp_trap_recover = NULL; fwp_trap_jb = NULL;
    field_fail_allocation = 0;
    if (fwp_cleanups || (cancel && !field_task.unwinding)) exit(242);
    if (field_entries != 1 || field_yields != (mode <= 2 ? 0 : 1)) exit(243);
    if (shared) {
        if (!direct) {
            if (*fwp_rc_slot(box) != 1) exit(244);
            for (size_t i = 0; i < @width@; i++) if (OBJ(box)->f[i] != children[i]) exit(244);
            fwp_rc_free_obj(box);
        }
        for (size_t i = 0; i < @width@; i++) {
            size_t remaining = same ? @width@ - i : 1;
            if (*fwp_rc_slot(children[i]) != remaining || STR(children[i])->len != 5
                || memcmp(STR(children[i])->d, "field", 5)) exit(244);
            if (fwp_rc_release_last(children[i])) fwp_mem_free((void *)(uintptr_t)children[i]);
        }
    }
    if (fwp_heap.live != baseline || fwp_heap.rc_wide_len) exit(245);
}
