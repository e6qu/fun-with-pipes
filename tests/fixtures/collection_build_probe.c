/* Exercise actual generated builders, including direct map and set callbacks. */
static int build_armed, build_step, build_failure, build_live, build_calls;
static int build_callback_failure, build_cancel;
static void *build_allocations[128];
static jmp_buf build_jump;
static fwp_task build_task;
static fwp_task *build_saved_task;
static int build_recover(void) { return 1; }
static void build_tick(void) {
    if (build_armed && ++build_step == build_failure)
        fwp_trap("injected collection allocation/retain failure");
}
static void build_record(void *p) {
    if (!build_armed || !p) return;
    for (size_t i = 0; i < 128; i++) if (!build_allocations[i]) {
        build_allocations[i] = p; build_live++; return;
    }
    abort();
}
static void build_release(void *p) {
    for (size_t i = 0; i < 128; i++) if (p && build_allocations[i] == p) {
        build_allocations[i] = NULL; build_live--; return;
    }
}
static void build_callback(void) {
    if (!build_armed) return;
    build_calls++;
    if (build_calls == build_callback_failure) {
        if (build_cancel) fwp_check_cancel();
        fwp_trap("injected collection callback failure");
    }
}
static V build_operation(int op) {
    switch (op) {
    case 0: return MAP_RANGE(PTR(&PAIR_CALLBACK), 0, 4);
    case 1: return SET_RANGE(PTR(&KEY_CALLBACK), 0, 4);
    case 2: return MAP_LIST(PTR(&PAIR_CALLBACK), build_input);
    case 3: return SET_LIST(PTR(&KEY_CALLBACK), build_input);
    case 4: return build_direct_map_range();
    case 5: return build_direct_map_list();
    case 6: return build_direct_set_range();
    case 7: return build_direct_set_list();
    default: abort();
    }
}
static int build_case(int op, int failure, int callback, int cancel, int *steps) {
    size_t before = fwp_heap.live;
    build_failure = failure; build_step = build_calls = 0;
    build_callback_failure = callback; build_cancel = cancel; build_armed = 1;
    build_saved_task = fwp_cur;
    memset(&build_task, 0, sizeof(build_task));
    if (cancel) {
        build_task.cancelled = 1; fwp_cur = &build_task;
#ifdef _WIN32
        build_task.ctx.top = fwp_heap.main_top;
#endif
    }
    fwp_trap_recover = build_recover; fwp_trap_jb = &build_jump;
    fwp_trap_cleanup = fwp_cleanups;
    jmp_buf build_task_base; build_task.base = &build_task_base;
    if (setjmp(build_task_base)) {
        if (!cancel) return 214;
    } else if (setjmp(build_jump)) {
        if (!failure && !callback) return 214;
    } else {
        V result = build_operation(op);
        if (failure || callback) return 210;
        int is_set = op == 1 || op == 3 || op == 6 || op == 7;
        size_t columns = is_set ? 1 : 2;
        if (MAP(result)->len != 3 || MAP(result)->d[0] != 0 ||
            MAP(result)->d[columns] != 1 || MAP(result)->d[2 * columns] != 2) return 211;
        if (!is_set && MAP(result)->d[1] != 3) return 212;
        fwp_rc_free_obj(result);
    }
    build_task.base = NULL; build_armed = 0; fwp_cur = build_saved_task;
    fwp_trap_recover = NULL; fwp_trap_jb = NULL;
    *steps = build_step;
    if (build_live) { fprintf(stderr, "collection live allocations: %d\n", build_live); return 213; }
    if (fwp_cleanups) return 215;
    if (cancel && !build_task.unwinding) return 216;
    if (callback && build_calls != callback) return 217;
    V xs = build_input;
    for (V i = 0; i < 4; i++) {
        if (!xs || OBJ(xs)->f[0] != i || *fwp_rc_slot(xs) != 1) return 218;
        xs = OBJ(xs)->f[1];
    }
    if (xs) return 219;
    if (fwp_heap.live != before) return 220;
    return 0;
}
/* Size arithmetic must fail before allocating or touching caller storage. */
static int build_bounds(void) {
    V keys[] = {7}, values[] = {11};
    const fwp_desc key = {.kind = K_I64};
    for (size_t lanes = 1; lanes <= 2; lanes++) {
        const fwp_map_ops ops = {NULL, NULL, NULL, NULL, fwp_rc_free_obj, NULL, lanes};
        fwp_cleanup *boundary = fwp_cleanups;
        build_armed = 1; build_failure = build_step = 0;
        fwp_trap_recover = build_recover; fwp_trap_jb = &build_jump;
        fwp_trap_cleanup = boundary;
        if (!setjmp(build_jump)) {
            (void)fwp_map_build_typed(keys, lanes == 2 ? values : NULL,
                SIZE_MAX / ((size_t)lanes * sizeof(V)) + 1, &ops, &key);
            return 221;
        }
        build_armed = 0; fwp_trap_recover = NULL; fwp_trap_jb = NULL;
        if (build_step || build_live || fwp_cleanups != boundary || keys[0] != 7 || values[0] != 11)
            return 222;
    }
    return 0;
}
int main(void) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 253;
#endif
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    for (V i = 4; i; i--) build_input = fwp_rc_fresh(fwp_cons(i - 1, build_input));
    int bounds = build_bounds(); if (bounds) return bounds;
    int failures = 0, callbacks = 0;
    for (int op = 0; op < 8; op++) {
        int steps = 0, observed = 0, result = build_case(op, 0, 0, 0, &steps);
        if (result) { fprintf(stderr, "builder %d baseline: %d\n", op, result); return result; }
        for (int fail = 1; fail <= steps; fail++) {
            result = build_case(op, fail, 0, 0, &observed);
            if (result) { fprintf(stderr, "builder %d allocation %d/%d: %d\n", op, fail, steps, result); return result; }
            failures++;
        }
        for (int cancel = 0; cancel < 2; cancel++) for (int at = 1; at <= 4; at++) {
            result = build_case(op, 0, at, cancel, &observed);
            if (result) { fprintf(stderr, "builder %d callback %d cancel %d: %d\n", op, at, cancel, result); return result; }
            callbacks++;
        }
    }
    while (build_input) { V next = OBJ(build_input)->f[1]; fwp_rc_free_obj(build_input); build_input = next; }
    printf("8 builders: %d allocation failures and %d callback exits cleaned; aliases preserved\n", failures, callbacks);
    return 0;
}
