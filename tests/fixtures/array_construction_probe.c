/* Move only a uniquely owned prefix; a shared tail keeps every descendant. */
static const fwp_desc *const construct_types[] = {STRING_DESCRIPTOR, QUAD_DESCRIPTOR};
static V (*const construct_calls[])(V) = {STRING_CONSTRUCT, QUAD_CONSTRUCT};
static void (*const construct_drops[])(V) = {STRING_ARRAY_DROP, QUAD_ARRAY_DROP};
static int construct_armed, array_probe_recording, construct_step, construct_failure, construct_live, construct_cancel;
static void *construct_allocations[1024];
static volatile V construct_input, construct_alias, construct_result;
static jmp_buf construct_jump;
static fwp_task construct_task;
static fwp_task *construct_saved_task;
static int construct_recover(void) { return 1; }
static void array_probe_tick(void) {
    if (!construct_armed || ++construct_step != construct_failure) return;
    if (construct_cancel) { construct_task.cancelled = 1; fwp_check_cancel(); }
    fwp_trap("injected array-construction failure");
}
static void array_probe_record(void *p) {
    if (!array_probe_recording || !p) return;
    for (size_t i = 0; i < 1024; i++) if (!construct_allocations[i]) {
        construct_allocations[i] = p; construct_live++; return;
    }
    abort();
}
static void array_probe_release(void *p) {
    for (size_t i = 0; i < 1024; i++) if (p && construct_allocations[i] == p) {
        construct_allocations[i] = NULL; construct_live--; return;
    }
}
static void (*const construct_list_drops[])(V) = {STRING_LIST_DROP, QUAD_LIST_DROP};
static V construct_make(int kind, size_t n, int pattern) {
    static const float128_t numbers[] = {
        {{0, UINT64_C(0x8000000000000000)}}, {{0, 0}},
        {{0, UINT64_C(0x3fff000000000000)}}, {{0, UINT64_C(0xbfff000000000000)}},
        {{0, UINT64_C(0x4000000000000000)}}, {{0, UINT64_C(0xc000000000000000)}},
        {{1, UINT64_C(0x3fff000000000000)}}, {{2, UINT64_C(0x3fff000000000000)}}
    };
    V xs = 0;
    for (size_t i = n; i; i--) {
        unsigned value = (unsigned)((i - 1 + (pattern ? 3 : 0)) % 8);
        V element;
        if (kind) element = fwp_rc_fresh(fwp_box_f128(numbers[value]));
        else { char word[] = {(char)('a' + value), 0}; element = fwp_rc_fresh(fwp_cstr(word)); }
        xs = fwp_rc_fresh(fwp_cons(element, xs));
    }
    return xs;
}
static int construct_case(int kind, size_t n, int pattern, int sharing,
                          int failure, int cancel, int *steps) {
    intptr_t before = fwp_gc.budget_given - fwp_gc.budget;
    array_probe_recording = 1;
    construct_failure = failure; construct_step = 0; construct_cancel = cancel;
    construct_input = construct_make(kind, n, pattern);
    size_t shared_start = sharing == 1 ? 0 : n / 2;
    if (sharing && n) {
        V tail = construct_input;
        for (size_t i = 0; i < shared_start; i++) tail = OBJ(tail)->f[1];
        construct_alias = tail; fwp_rc_dup(tail);
    }
    V expected[257]; float128_t wide[257];
    V cursor = construct_input;
    for (size_t i = 0; i < n; i++) {
        V value = OBJ(cursor)->f[0];
        if (kind) memcpy(&wide[i], (const void *)(uintptr_t)value, 16);
        else expected[i] = value;
        cursor = OBJ(cursor)->f[1];
    }
    construct_saved_task = fwp_cur; memset(&construct_task, 0, sizeof construct_task);
    if (cancel) {
        fwp_cur = &construct_task;
#ifdef _WIN32
        construct_task.ctx.top = fwp_gc.main_top;
#endif
    }
    fwp_budget = 1000000; construct_armed = 1; array_probe_retains = 0;
    fwp_trap_recover = construct_recover; fwp_trap_jb = &construct_jump;
    fwp_trap_cleanup = fwp_cleanups;
    jmp_buf task_base; construct_task.base = &task_base;
    if (setjmp(task_base)) {
        if (!cancel) return 202;
    } else if (setjmp(construct_jump)) {
        if (!failure) return 203;
    } else {
        V argument = construct_input; construct_input = 0;
        construct_result = construct_calls[kind](argument);
        construct_armed = 0;
        if (failure || fwp_array_len(construct_result) != n) return 204;
        size_t retained = kind || !sharing ? 0 : n - shared_start;
        if ((size_t)array_probe_retains != retained) return 205;
        for (size_t i = 0; i < n; i++) {
            V value = fwp_array_load(construct_result, i, construct_types[kind]);
            if (kind ? memcmp(&wide[i], (const void *)(uintptr_t)value, 16) != 0 : value != expected[i]) return 206;
            if (!kind && *fwp_rc_slot(value) != (sharing && i >= shared_start ? 2 : 1)) return 207;
        }
        construct_drops[kind](construct_result); construct_result = 0;
    }
    construct_task.base = NULL; construct_armed = 0; fwp_cur = construct_saved_task;
    fwp_trap_recover = NULL; fwp_trap_jb = NULL; *steps = construct_step;
    if (fwp_cleanups || (cancel && !construct_task.unwinding)) return 208;
    cursor = construct_alias;
    for (size_t i = shared_start; cursor && i < n; i++) {
        V value = OBJ(cursor)->f[0];
        if (kind ? memcmp(&wide[i], (const void *)(uintptr_t)value, 16) != 0 : value != expected[i]) return 209;
        if (*fwp_rc_slot(value) != 1 || (!kind && STR(value)->len != 1)) return 210;
        cursor = OBJ(cursor)->f[1];
    }
    if (cursor) return 209;
    if (construct_alias) construct_list_drops[kind](construct_alias);
    construct_alias = construct_input = 0; array_probe_recording = 0;
    if (construct_live) { fprintf(stderr, "array-construction live allocations: %d\n", construct_live); return 211; }
#ifdef FWP_ARC_ONLY
    if (fwp_gc.budget_given - fwp_gc.budget != before || fwp_gc.rc_wide_len || fwp_gc.ncollect) return 212;
#else
    (void)before;
#endif
    return 0;
}
int main(void) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 253;
#endif
    fwp_gc_start(__builtin_frame_address(0)); fwp_fns = fwp_fn_table; fwp_init_consts();
    int cases = 0, failures = 0;
    const size_t lengths[] = {0, 1, 3, 17, 257};
    for (int round = 0; round < 4; round++) {
        for (int kind = 0; kind < 2; kind++) for (int sharing = 0; sharing < 3; sharing++) {
            for (size_t at = 0; at < 5; at++) for (int pattern = 0; pattern < 2; pattern++) {
                size_t n = lengths[at]; if (sharing == 2 && n < 3) continue;
                int steps = 0, status = construct_case(kind, n, pattern, sharing, 0, 0, &steps);
                if (status) { fprintf(stderr, "array construction kind %d size %zu sharing %d: %d\n", kind, n, sharing, status); return status; }
                cases++;
                if (n != 3 || pattern != 0) continue;
                for (int cancel = 0; cancel < 2; cancel++) for (int fail = 1; fail <= steps; fail++) {
                    int observed = 0; status = construct_case(kind, n, pattern, sharing, fail, cancel, &observed);
                    if (status) { fprintf(stderr, "array construction kind %d sharing %d failure %d/%d cancel %d: %d\n", kind, sharing, fail, steps, cancel, status); return status; }
                    failures++;
                }
            }
        }
    }
    printf("array construction: %d alias/bit-pattern cases and %d allocation/retain interruptions cleaned\n", cases, failures);
    return 0;
}
