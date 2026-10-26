/* The stack record transfers its sole array owner. External aliases survive;
 * failures after transfer release that owner without a collector. */
static jmp_buf stack_array_jump;
static fwp_task stack_array_task;
static int stack_array_recover(void) { return 1; }
static const fwp_desc stack_array_element = {.kind = K_F64};
static double stack_array_charge(void) {
    return (double)fwp_heap.live;
}
static V stack_array_input(void) {
    V value = fwp_array_typed_new(2, &stack_array_element);
    fwp_array_store(value, 0, fwp_from_f64(1.25), &stack_array_element);
    fwp_array_store(value, 1, fwp_from_f64(-2.5), &stack_array_element);
    return value;
}
static int stack_array_valid(V value) {
    return fwp_array_len(value) == 2 &&
        fwp_f64(fwp_array_load(value, 0, &stack_array_element)) == 1.25 &&
        fwp_f64(fwp_array_load(value, 1, &stack_array_element)) == -2.5;
}
static void stack_array_drop(V value) {
    fwp_fns[0].owned->drop_arguments(&value, 0, 1);
}
int main(void) {
    fwp_heap_start(); fwp_fns = fwp_fn_table;
    fwp_init_consts(); fwp_tasks_init();
    if (!fwp_fns[0].owned || !fwp_fns[0].owned->drop_arguments) return 200;
    const char *stress = getenv("FWP_GC_STRESS");
    int collecting = stress && !strcmp(stress, "1");
    double before = stack_array_charge();
    for (int alias = 0; alias < 2; alias++) for (int repeat = 0; repeat < 64; repeat++) {
        V input = stack_array_input(); if (alias) fwp_rc_dup(input);
        stack_array_retains = 0;
        V result = f0(input);
        if (stack_array_retains) return 201;
        if (result != input || !stack_array_valid(result) || *fwp_rc_slot(result) != 1 + alias) return 202;
        stack_array_drop(result);
        if (alias) {
            if (!stack_array_valid(input) || *fwp_rc_slot(input) != 1) return 203;
            stack_array_drop(input);
        }
        if (!collecting && stack_array_charge() != before) return 204;
        if (fwp_cleanups) return 205;
    }
    for (volatile int mode = 0; mode < 2; mode++) for (volatile int repeat = 0; repeat < 64; repeat++) {
        V input = stack_array_input();
        fwp_task *previous = fwp_cur;
        fwp_trap_recover = stack_array_recover; fwp_trap_jb = &stack_array_jump;
        fwp_trap_cleanup = fwp_cleanups;
        memset(&stack_array_task, 0, sizeof stack_array_task);
        if (mode) {
            stack_array_task.identity = UINT64_MAX;
#ifdef _WIN32
            stack_array_task.ctx.top = previous->ctx.top;
#endif
            stack_array_task.base = &stack_array_jump; fwp_cur = &stack_array_task;
        }
        stack_array_cancel = mode;
        if (!setjmp(stack_array_jump)) {
            if (mode) (void)f5(input); else (void)f3(input);
            return 206;
        }
        stack_array_cancel = 0; stack_array_task.base = NULL; fwp_cur = previous;
        fwp_trap_recover = NULL; fwp_trap_jb = NULL;
        if (mode ? !stack_array_task.unwinding : strcmp(fwp_trap_msg, "stack array move") != 0) return 207;
        if (fwp_cleanups) return 208;
        if (!collecting && stack_array_charge() != before) return 209;
    }
    return 0;
}
