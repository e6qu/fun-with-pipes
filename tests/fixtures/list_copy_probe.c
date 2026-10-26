/* Run the real runtime helpers with generated String/List descriptors. The
 * allocation ledger observes allocation and release events, so a missing owner
 * release fails independently of allocator accounting. Inputs have independent live aliases. */
static int copy_armed, copy_step, copy_failure, copy_live, copy_calls;
static int copy_callback_failure, copy_cancel;
static void *copy_allocations[128];
static jmp_buf copy_jump;
static fwp_task copy_task;
static fwp_task *copy_saved_task;
static volatile V copy_input, copy_tail, copy_nested, copy_leaves[3];
static const fwp_desc *copy_list = LIST_DESCRIPTOR;
static int copy_recover(void) { return 1; }
static void copy_interrupt(void) {
    if (copy_cancel) { copy_task.cancelled = 1; fwp_check_cancel(); }
    fwp_trap("injected copied-list failure");
}
static void copy_tick(void) {
    if (copy_armed && ++copy_step == copy_failure) copy_interrupt();
}
static void copy_record(void *p) {
    if (!copy_armed || !p) return;
    for (size_t i = 0; i < 128; i++) if (!copy_allocations[i]) {
        copy_allocations[i] = p; copy_live++; return;
    }
    abort();
}
static void copy_release(void *p) {
    for (size_t i = 0; i < 128; i++) if (p && copy_allocations[i] == p) {
        copy_allocations[i] = NULL; copy_live--; return;
    }
}
static V copy_key(V *args) {
    if (++copy_calls == copy_callback_failure) copy_interrupt();
    return fwp_rc_fresh(fwp_str_new(STR(args[0])->d, STR(args[0])->len));
}
/* This test entry borrows its arguments and has no captured values. */
static void copy_arguments(V *args, uint32_t start, uint32_t n) {
    (void)args; (void)start; (void)n;
}
static void copy_captures(V f, int duplicate) { (void)f; (void)duplicate; }
static const fwp_owned_fninfo copy_owned = {copy_key, copy_captures, copy_arguments};
static const fwp_fninfo copy_functions[] = {{1, copy_key, "owned String key", &copy_owned}};
static fwp_clo copy_callback = {0, 0};
static V copy_operation(int op) {
    switch (op) {
    case 0: return fwp_p_sort_copied(copy_input, copy_list->elem, copy_list);
    case 1: return fwp_p_reverse_copied(copy_input, copy_list);
    case 2: return fwp_p_append_copied(copy_tail, copy_input, copy_list);
    case 3: return fwp_p_flatten_copied(copy_nested, copy_list);
    case 4: return fwp_p_take_copied(2, copy_input, copy_list);
    case 5: return fwp_p_unique_copied(copy_input, copy_list->elem, copy_list);
    case 6: return fwp_p_sort_by_copied(PTR(&copy_callback), copy_input,
        copy_list->elem, copy_list->elem->drop, copy_list);
    default: abort();
    }
}
static int copy_case(int op, int failure, int callback, int cancel, int *steps) {
    size_t before = fwp_heap.live;
    copy_failure = failure; copy_step = copy_calls = 0;
    copy_callback_failure = callback; copy_cancel = cancel; copy_armed = 1;
    copy_saved_task = fwp_cur;
    memset(&copy_task, 0, sizeof copy_task);
    if (cancel) {
        fwp_cur = &copy_task;
    }
    fwp_budget = 1000000;
    fwp_trap_recover = copy_recover; fwp_trap_jb = &copy_jump;
    fwp_trap_cleanup = fwp_cleanups;
    jmp_buf task_base; copy_task.base = &task_base;
    if (setjmp(task_base)) {
        if (!cancel) return 214;
    } else if (setjmp(copy_jump)) {
        if (!failure && !callback) return 214;
    } else {
        V result = copy_operation(op);
        if (failure || callback) return 210;
        const char *expected[] = {"abc", "bac", "cab ab", "cabcab", "ca", "cab", "abc"};
        const char *p = expected[op];
        for (V xs = result; xs; xs = OBJ(xs)->f[1]) {
            if (*p == ' ') p++;
            V value = OBJ(xs)->f[0];
            if (!*p || STR(value)->len != 1 || STR(value)->d[0] != *p++) return 211;
        }
        if (*p) return 212;
        copy_list->drop(result);
    }
    copy_task.base = NULL; copy_armed = 0; fwp_cur = copy_saved_task;
    fwp_trap_recover = NULL; fwp_trap_jb = NULL;
    *steps = copy_step;
    if (copy_live) { fprintf(stderr, "copied-list live allocations: %d\n", copy_live); return 213; }
    if (fwp_cleanups) return 215;
    if (cancel && !copy_task.unwinding) return 216;
    if (callback && copy_calls != callback) return 217;
    V xs = copy_input;
    for (int i = 0; i < 3; i++) {
        if (!xs || OBJ(xs)->f[0] != copy_leaves[i] ||
            *fwp_rc_slot(copy_leaves[i]) != 2 ||
            STR(copy_leaves[i])->len != 1 || STR(copy_leaves[i])->d[0] != "cab"[i] ||
            *fwp_rc_slot(xs) != (i == 0 ? 3 : i == 1 ? 2 : 1)) return 218;
        xs = OBJ(xs)->f[1];
    }
    if (xs) return 219;
    if (fwp_heap.live != before) return 220;
    return 0;
}
int main(void) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 253;
#endif
    fwp_heap_start(); fwp_fns = copy_functions; fwp_init_consts();
    size_t baseline = fwp_heap.live;
    for (int round = 0; round < 8; round++) {
        for (int i = 2; i >= 0; i--) {
            copy_leaves[i] = fwp_rc_fresh(fwp_str_new("cab" + i, 1));
            fwp_rc_dup(copy_leaves[i]);
            copy_input = fwp_rc_fresh(fwp_cons(copy_leaves[i], copy_input));
        }
        copy_tail = OBJ(copy_input)->f[1]; fwp_rc_dup(copy_tail);
        for (int i = 0; i < 2; i++) {
            fwp_rc_dup(copy_input);
            copy_nested = fwp_rc_fresh(fwp_cons(copy_input, copy_nested));
        }
        int failures = 0, callbacks = 0;
        for (int op = 0; op < 7; op++) {
            int steps = 0, observed = 0, result = copy_case(op, 0, 0, 0, &steps);
            if (result) { fprintf(stderr, "copy %d baseline: %d\n", op, result); return result; }
            for (int cancel = 0; cancel < 2; cancel++) for (int fail = 1; fail <= steps; fail++) {
                result = copy_case(op, fail, 0, cancel, &observed);
                if (result) { fprintf(stderr, "copy %d allocation/retain %d/%d cancel %d: %d\n", op, fail, steps, cancel, result); return result; }
                failures++;
            }
            if (op == 6) for (int cancel = 0; cancel < 2; cancel++) for (int at = 1; at <= 3; at++) {
                result = copy_case(op, 0, at, cancel, &observed);
                if (result) { fprintf(stderr, "copy %d callback %d cancel %d: %d\n", op, at, cancel, result); return result; }
                callbacks++;
            }
        }
        while (copy_nested) {
            V next = OBJ(copy_nested)->f[1]; copy_list->drop(OBJ(copy_nested)->f[0]);
            fwp_rc_free_obj(copy_nested); copy_nested = next;
        }
        copy_list->drop(copy_tail); copy_tail = 0;
        copy_list->drop(copy_input); copy_input = 0;
        for (int i = 0; i < 3; i++) { copy_list->elem->drop(copy_leaves[i]); copy_leaves[i] = 0; }
        if (fwp_heap.live != baseline || fwp_heap.rc_wide_len) return 221;
        if (round == 7) printf("7 copied-list operations: %d allocation/retain failures and %d callback exits cleaned; aliases preserved\n", failures, callbacks);
    }
    return 0;
}
