/* Exercise actual generated wrappers, descriptors and drops. The insertion
 * oracle is independent of merge sorting; wide comparisons preserve all bits. */
static const fwp_desc *const sort_types[] = {STRING_DESCRIPTOR, QUAD_DESCRIPTOR};
static V (*const sort_calls[])(V) = {STRING_SORT, QUAD_SORT};
static void (*const sort_drops[])(V) = {STRING_DROP, QUAD_DROP};
static int sort_armed, array_probe_recording, sort_step, sort_failure, sort_live, sort_cancel;
static void *sort_allocations[1024];
static volatile V sort_input, sort_alias, sort_result;
static jmp_buf sort_jump;
static fwp_task sort_task;
static fwp_task *sort_saved_task;
static int sort_recover(void) { return 1; }
static void array_probe_tick(void) {
    if (!sort_armed || ++sort_step != sort_failure) return;
    if (sort_cancel) { sort_task.cancelled = 1; fwp_check_cancel(); }
    fwp_trap("injected array-sort failure");
}
static void array_probe_record(void *p) {
    if (!array_probe_recording || !p) return;
    for (size_t i = 0; i < 1024; i++) if (!sort_allocations[i]) {
        sort_allocations[i] = p; sort_live++; return;
    }
    abort();
}
static void array_probe_release(void *p) {
    for (size_t i = 0; i < 1024; i++) if (p && sort_allocations[i] == p) {
        sort_allocations[i] = NULL; sort_live--; return;
    }
}
static unsigned sort_value(size_t i, size_t n, int pattern) {
    switch (pattern) {
    case 0: return (unsigned)(i % 8);
    case 1: return (unsigned)((n - 1 - i) % 8);
    case 2: return (unsigned)((i * 17 + 3) % 8);
    case 3: return 2;
    default: return (unsigned)((i ^ (i >> 1)) % 8);
    }
}
static V sort_make(int kind, size_t n, int pattern) {
    static const float128_t numbers[] = {
        {{0, UINT64_C(0x8000000000000000)}}, {{0, 0}},
        {{0, UINT64_C(0x3fff000000000000)}}, {{0, UINT64_C(0xbfff000000000000)}},
        {{0, UINT64_C(0x4000000000000000)}}, {{0, UINT64_C(0xc000000000000000)}},
        {{1, UINT64_C(0x3fff000000000000)}}, {{2, UINT64_C(0x3fff000000000000)}}
    };
    V a = fwp_array_typed_new(n, sort_types[kind]);
    for (size_t i = 0; i < n; i++) {
        unsigned value = sort_value(i, n, pattern);
        V element;
        if (kind) element = PTR(&numbers[value]);
        else { char word[] = {(char)('a' + value), 0}; element = fwp_rc_fresh(fwp_cstr(word)); }
        fwp_array_store(a, i, element, sort_types[kind]);
    }
    return a;
}
static int sort_case(int kind, size_t n, int pattern, int sharing,
                     int failure, int cancel, int *steps) {
    size_t before = fwp_heap.live;
    array_probe_recording = 1; sort_failure = failure; sort_step = 0; sort_cancel = cancel;
    sort_input = sort_make(kind, n + (sharing == 2 ? 2 : 0), pattern);
    if (sharing == 1) { sort_alias = sort_input; fwp_rc_dup(sort_alias); }
    if (sharing == 2) {
        sort_alias = sort_input;
        sort_input = fwp_p_array_slice_typed(1, n, sort_input, NULL, sort_types[kind]);
        if (!fwp_array_is_view(sort_input)) return 201;
    }
    size_t order[257]; V expected[257]; float128_t wide[257];
    V original[259]; float128_t original_wide[259];
    for (size_t i = 0; i < n; i++) {
        size_t j = i;
        while (j && fwp_cmp(fwp_array_load(sort_input, order[j - 1], sort_types[kind]),
                           fwp_array_load(sort_input, i, sort_types[kind]), sort_types[kind]) > 0) {
            order[j] = order[j - 1]; j--;
        }
        order[j] = i;
    }
    for (size_t i = 0; i < n; i++) {
        V value = fwp_array_load(sort_input, order[i], sort_types[kind]);
        if (kind) memcpy(&wide[i], (const void *)(uintptr_t)value, 16);
        else expected[i] = value;
    }
    size_t alias_count = sort_alias ? fwp_array_len(sort_alias) : 0;
    for (size_t i = 0; i < alias_count; i++) {
        V value = fwp_array_load(sort_alias, i, sort_types[kind]);
        if (kind) memcpy(&original_wide[i], (const void *)(uintptr_t)value, 16);
        else original[i] = value;
    }
    V input_address = sort_input;
    sort_saved_task = fwp_cur; memset(&sort_task, 0, sizeof sort_task);
    if (cancel) {
        fwp_cur = &sort_task;
    }
    fwp_budget = 1000000; sort_armed = 1;
    fwp_trap_recover = sort_recover; fwp_trap_jb = &sort_jump;
    fwp_trap_cleanup = fwp_cleanups;
    jmp_buf task_base; sort_task.base = &task_base;
    if (setjmp(task_base)) {
        if (!cancel) return 202;
    } else if (setjmp(sort_jump)) {
        if (!failure) return 203;
    } else {
        V argument = sort_input; sort_input = 0;
        sort_result = sort_calls[kind](argument);
        sort_armed = 0;
        if (failure || fwp_array_len(sort_result) != n) return 204;
        int reused = sort_result == input_address;
        int should_reuse = n < 2 || sharing == 0;
#ifdef FWP_NO_REUSE
        if (n > 1) should_reuse = 0;
#endif
        if (reused != should_reuse) return 205;
        for (size_t i = 0; i < n; i++) {
            V value = fwp_array_load(sort_result, i, sort_types[kind]);
            if (kind ? memcmp(&wide[i], (const void *)(uintptr_t)value, 16) != 0 : value != expected[i]) return 206;
            if (!kind && *fwp_rc_slot(value) != (sharing == 1 && n > 1 ? 2 : 1)) return 207;
        }
        sort_drops[kind](sort_result); sort_result = 0;
    }
    sort_task.base = NULL; sort_armed = 0; fwp_cur = sort_saved_task;
    fwp_trap_recover = NULL; fwp_trap_jb = NULL; *steps = sort_step;
    if (fwp_cleanups || (cancel && !sort_task.unwinding)) return 208;
    for (size_t i = 0; i < alias_count; i++) {
        V value = fwp_array_load(sort_alias, i, sort_types[kind]);
        if (kind ? memcmp(&original_wide[i], (const void *)(uintptr_t)value, 16) != 0 : value != original[i]) return 209;
        if (!kind && (*fwp_rc_slot(value) != 1 || STR(value)->len != 1)) return 210;
    }
    if (sort_alias) sort_drops[kind](sort_alias);
    sort_alias = sort_input = 0; array_probe_recording = 0;
    if (sort_live) { fprintf(stderr, "array-sort live allocations: %d\n", sort_live); return 211; }
    if (fwp_heap.live != before || fwp_heap.rc_wide_len) return 212;
    return 0;
}
int main(void) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 253;
#endif
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    int cases = 0, failures = 0;
    const size_t lengths[] = {0, 1, 2, 3, 17, 257};
    for (int round = 0; round < 4; round++) {
        for (int kind = 0; kind < 2; kind++) for (int sharing = 0; sharing < 3; sharing++) {
            if (sharing == 2 && !kind) continue;
            for (size_t at = 0; at < 6; at++) for (int pattern = 0; pattern < 5; pattern++) {
                size_t n = lengths[at]; if (sharing == 2 && n < 3) continue;
                int steps = 0, status = sort_case(kind, n, pattern, sharing, 0, 0, &steps);
                if (status) { fprintf(stderr, "array sort kind %d size %zu pattern %d sharing %d: %d\n", kind, n, pattern, sharing, status); return status; }
                cases++;
                if (n != 3 || pattern != 2) continue;
                for (int cancel = 0; cancel < 2; cancel++) for (int fail = 1; fail <= steps; fail++) {
                    int observed = 0; status = sort_case(kind, n, pattern, sharing, fail, cancel, &observed);
                    if (status) { fprintf(stderr, "array sort kind %d sharing %d failure %d/%d cancel %d: %d\n", kind, sharing, fail, steps, cancel, status); return status; }
                    failures++;
                }
            }
        }
    }
    printf("array sort: %d stable alias/bit-pattern cases and %d allocation/retain/comparison interruptions cleaned\n", cases, failures);
    return 0;
}
