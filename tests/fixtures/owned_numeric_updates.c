static int numeric_recover(void) { return 1; }
static fwp_task numeric_task;

static void numeric_begin(jmp_buf *jump, int mode, int failure) {
    numeric_mode = mode; numeric_calls = numeric_allocations = 0;
    numeric_fail_after = failure;
    fwp_trap_recover = numeric_recover; fwp_trap_jb = jump; fwp_trap_cleanup = 0;
    memset(&numeric_task, 0, sizeof numeric_task);
    if (mode == 2) { numeric_task.base = jump; fwp_cur = &numeric_task; fwp_budget = 1000000; }
}
static int numeric_finish(int mode) {
    fwp_cur = NULL; fwp_trap_recover = NULL; fwp_trap_jb = NULL;
    numeric_fail_after = 0; numeric_alias = 0;
    return !fwp_cleanups && (mode != 2 || numeric_task.unwinding);
}

int main(void) {
    fwp_prog_out = stdout;
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    const int lengths[] = {0, 1, 4};
    const int array_lengths[] = {0, 1, 3, 5};
    int reuse_enabled = 1;
#ifdef FWP_NO_REUSE
    reuse_enabled = 0;
#endif
    unsigned traps = 0, cancellations = 0, allocation_failures = 0;
    /* The producer result is a temporary owner. A preceding record field is
     * also an owner, even when no outside alias protects the original array. */
    for (unsigned produced = 0; produced < 2; produced++)
    for (unsigned length = 0; length < 3; length++)
    for (unsigned observed = 0; observed < 2; observed++)
    for (volatile int mode = 0; mode < 4; mode++)
    for (int failure = 0; failure < 5; failure++) {
        int n = lengths[length];
        if (mode && (n < 2 || failure)) continue;
        size_t live = owner_ledger_live, baseline = fwp_heap.live;
        V input = 0;
        if (produced) {
            for (int i = n; i > 0; i--)
                input = fwp_rc_fresh(fwp_cons(mode == 3 && i == 2 ? (V)INT64_MAX : (V)i, input));
        } else {
            input = fwp_rc_fresh(fwp_arr_new(n));
            for (int i = 0; i < n; i++)
                ARR(input)->d[i] = mode == 3 && i == 1 ? (V)INT64_MAX : (V)(i + 1);
        }
        if (observed) fwp_rc_dup(input);
        size_t allocations = owner_ledger_allocations;
        jmp_buf jump;
        numeric_begin(&jump, mode, failure);
        if (!setjmp(jump)) {
            V output = produced ? TEMP_ENTRY(input) : SHARED_ENTRY(input);
            if (mode) return 240;
            V changed = produced ? output : OBJ(output)->f[1];
            if (fwp_array_len(changed) != (size_t)n || numeric_calls != n) return 244;
            for (int i = 0; i < n; i++) {
                if (ARR(changed)->d[i] != (V)(i + 2)) return 241;
                if (!produced && ARR(OBJ(output)->f[0])->d[i] != (V)(i + 1)) return 247;
            }
            if (!produced && (OBJ(output)->f[0] != input || changed == input)) return 242;
            if (owner_ledger_allocations - allocations != (size_t)(produced ? 1 + !reuse_enabled : 2)) return 243;
            if (produced) DROP_ARRAY(output);
            else {
                if (*fwp_rc_slot(output) != 1) return 248;
                DROP_ARRAY(OBJ(output)->f[0]);
                DROP_ARRAY(OBJ(output)->f[1]);
                fwp_rc_free_obj(output);
            }
        } else {
            if (mode == 1 || mode == 3) traps++;
            else if (mode == 2) cancellations++;
            else if (failure && numeric_allocations == failure) allocation_failures++;
            else return 245;
        }
        if (!numeric_finish(mode)) return 246;
        if (observed) {
            V cursor = input;
            for (int i = 0; i < n; i++) {
                V value = produced ? OBJ(cursor)->f[0] : ARR(input)->d[i];
                if (value != (mode == 3 && i == 1 ? (V)INT64_MAX : (V)(i + 1))) return 247;
                if (produced) cursor = OBJ(cursor)->f[1];
            }
            if (input && *fwp_rc_slot(input) != 1) return 248;
            if (produced) DROP_LIST(input); else DROP_ARRAY(input);
        }
        if (owner_ledger_live != live || fwp_heap.live != baseline || fwp_heap.rc_wide_len) return 90;
    }
    const V bits32[] = {0, UINT32_C(0x80000000), 1, UINT32_C(0x7f800000),
        UINT32_C(0xffc00042), UINT32_C(0x7f800042), UINT32_C(0x3f800000)};
    const V bits64[] = {0, UINT64_C(0x8000000000000000), 1, UINT64_C(0x7ff0000000000000),
        UINT64_C(0xfff8000000000042), UINT64_C(0x7ff0000000000042), UINT64_C(0x3ff0000000000000)};
    for (int captured = 0; captured < 3; captured++)
    for (int wide = 0; wide < 2; wide++) for (int sharing = 0; sharing < 2; sharing++) {
        size_t live = owner_ledger_live, baseline = fwp_heap.live;
        const fwp_desc scalar = {.kind = wide ? K_F64 : K_F32};
        const V *bits = wide ? bits64 : bits32;
        V input = fwp_array_typed_new(7, &scalar);
        for (int i = 0; i < 7; i++) fwp_array_store(input, i, bits[i], &scalar);
        if (sharing) fwp_rc_dup(input);
        numeric_mode = numeric_calls = numeric_fail_after = 0;
        size_t allocations = owner_ledger_allocations;
        V replacement = captured == 2 ? bits[4] : 0;
        V output = captured
            ? (wide ? CAP64_ENTRY(replacement, input) : CAP32_ENTRY(replacement, input))
            : (wide ? MAP64_ENTRY(input) : MAP32_ENTRY(input));
        if (numeric_calls != 7 || fwp_array_len(output) != 7) return 244;
        if (owner_ledger_allocations - allocations != (size_t)(sharing || !reuse_enabled)) return 243;
        for (int i = 0; i < 7; i++) {
            if (fwp_array_load(output, i, &scalar) != (captured == 2 ? replacement : bits[i])) return 241;
            if (sharing && fwp_array_load(input, i, &scalar) != bits[i]) return 247;
        }
        if (wide) { DROP_F64_ARRAY(output); if (sharing) DROP_F64_ARRAY(input); }
        else { DROP_F32_ARRAY(output); if (sharing) DROP_F32_ARRAY(input); }
        if (owner_ledger_live != live || fwp_heap.live != baseline) return 90;
    }
    for (unsigned captured = 0; captured < 2; captured++)
    for (unsigned length = 0; length < 3; length++)
    for (unsigned sharing = 0; sharing < 3; sharing++)
    for (volatile int mode = 0; mode < 4; mode++)
    for (int failure = 0; failure < 4; failure++) {
        int n = lengths[length];
        if (mode && (n < 2 || failure)) continue;
        size_t live = owner_ledger_live, baseline = fwp_heap.live;
        V input = fwp_rc_fresh(fwp_arr_new(n)), alias = 0;
        for (int i = 0; i < n; i++) ARR(input)->d[i] = (V)(i + 1);
        if (mode == 3) ARR(input)->d[1] = (V)INT64_MAX;
        if (sharing == 1) { alias = input; fwp_rc_dup(alias); }
        if (sharing == 2) {
            DROP_ARRAY(input);
            alias = fwp_rc_fresh(fwp_arr_new(n + 2));
            for (int i = 0; i < n + 2; i++) ARR(alias)->d[i] = (V)i;
            if (mode == 3) ARR(alias)->d[2] = (V)INT64_MAX;
            fwp_array_view *view = (fwp_array_view *)fwp_alloc_init(sizeof *view);
            view->len = FWP_ARRAY_VIEW_FLAG | (uint64_t)n;
            view->owner = alias; view->data = fwp_array_data(alias) + sizeof(V);
            fwp_rc_dup(alias); input = fwp_rc_fresh(PTR(view));
        }
        size_t allocations = owner_ledger_allocations;
        jmp_buf jump;
        numeric_begin(&jump, mode, failure);
        if (!setjmp(jump)) {
            V output = captured ? CAPTURE_ENTRY(1, 1, input) : MAP_ENTRY(input);
            if (mode) return 240;
            if (fwp_array_len(output) != (size_t)n) return 241;
            for (int i = 0; i < n; i++) if (ARR(output)->d[i] != (V)(i + 2)) return 241;
            int reused = reuse_enabled && !sharing;
            if ((output == input) != reused) return 242;
            if (owner_ledger_allocations - allocations != (size_t)!reused) return 243;
            if (numeric_calls != n) return 244;
            DROP_ARRAY(output);
        } else {
            if (mode == 1 || mode == 3) traps++;
            else if (mode == 2) cancellations++;
            else if (failure && numeric_allocations == failure) allocation_failures++;
            else return 245;
        }
        if (!numeric_finish(mode)) return 246;
        if (alias) {
            int size = sharing == 2 ? n + 2 : n;
            for (int i = 0; i < size; i++)
                if (ARR(alias)->d[i] != (mode == 3 && i == (sharing == 2 ? 2 : 1)
                    ? (V)INT64_MAX : (V)(sharing == 2 ? i : i + 1))) return 247;
            if (*fwp_rc_slot(alias) != 1) return 248;
            DROP_ARRAY(alias);
        }
        if (owner_ledger_live != live || fwp_heap.live != baseline || fwp_heap.rc_wide_len) return 90;
    }
    for (unsigned direction = 0; direction < 2; direction++)
    for (unsigned length = 0; length < 3; length++)
    for (unsigned array_length = 0; array_length < 4; array_length++)
    for (unsigned array_sharing = 0; array_sharing < 3; array_sharing++)
    for (unsigned sharing = 0; sharing < 4; sharing++)
    for (volatile int mode = 0; mode < 4; mode++)
    for (int failure = 0; failure < 9; failure++) {
        int n = lengths[length], m = array_lengths[array_length], count = n < m ? n : m;
        if (mode && (count < 2 || failure)) continue;
        int shared_start = sharing == 1 ? 0 : sharing == 2 ? 1 : sharing == 3 ? 2 : n;
        if (sharing && shared_start >= n) continue;
        size_t live = owner_ledger_live, baseline = fwp_heap.live;
        V xs = 0, alias = 0;
        for (int i = n; i > 0; i--) xs = fwp_rc_fresh(fwp_cons((V)(i * 10), xs));
        if (mode == 3) OBJ(OBJ(xs)->f[1])->f[0] = (V)INT64_MIN;
        if (sharing) {
            alias = xs;
            for (int i = 0; i < shared_start; i++) alias = OBJ(alias)->f[1];
            fwp_rc_dup(alias);
            /* Descendants have count one despite being reachable by both
             * owners of this shared ancestor. They must never be overwritten. */
            V child = OBJ(alias)->f[1];
            if (child && *fwp_rc_slot(child) != 1) return 249;
        }
        int backing_count = array_sharing == 2 ? m + 2 : m;
        V values = fwp_rc_fresh(fwp_arr_new(backing_count)), array_alias = 0;
        for (int i = 0; i < backing_count; i++)
            ARR(values)->d[i] = (V)(array_sharing == 2 ? i : i + 1);
        if (array_sharing) {
            array_alias = values;
            fwp_rc_dup(array_alias);
        }
        if (array_sharing == 2) {
            fwp_array_view *view = (fwp_array_view *)fwp_alloc_init(sizeof *view);
            view->len = FWP_ARRAY_VIEW_FLAG | (uint64_t)m;
            view->owner = array_alias; view->data = fwp_array_data(array_alias) + sizeof(V);
            values = fwp_rc_fresh(PTR(view));
        }
        size_t allocations = owner_ledger_allocations;
        jmp_buf jump;
        numeric_begin(&jump, mode, failure);
        numeric_alias = sharing == 1 ? alias : 0;
        if (!setjmp(jump)) {
            V output = direction ? RIGHT_ENTRY(values, xs) : LEFT_ENTRY(values, xs);
            if (mode) return 240;
            V cursor = output;
            for (int i = 0; i < count; i++) {
                if (!cursor || OBJ(cursor)->f[0] != (V)(9 * (i + 1))) return 241;
                cursor = OBJ(cursor)->f[1];
            }
            if (cursor) return 241;
            int prefix = reuse_enabled ? (shared_start < count ? shared_start : count) : 0;
            if (count && ((output == xs) != (prefix > 0))) return 242;
            /* Exclusive ordinary arrays supply scratch; aliases/views need one
             * independent request. Copied suffix cells remain separate. */
            int scratch_request = !reuse_enabled || array_sharing;
            if (owner_ledger_allocations - allocations != (size_t)(scratch_request + count - prefix)) return 243;
            if (numeric_calls != count) return 244;
            DROP_LIST(output);
        } else {
            if (mode == 1 || mode == 3) traps++;
            else if (mode == 2) cancellations++;
            else if (failure && numeric_allocations == failure) allocation_failures++;
            else return 245;
        }
        if (!numeric_finish(mode)) return 246;
        if (array_alias) {
            if (*fwp_rc_slot(array_alias) != 1) return 248;
            for (int i = 0; i < backing_count; i++)
                if (ARR(array_alias)->d[i] != (V)(array_sharing == 2 ? i : i + 1)) return 247;
            DROP_ARRAY(array_alias);
        }
        if (alias) {
            V cursor = alias;
            for (int i = shared_start; i < n; i++) {
                if (!cursor || OBJ(cursor)->f[0] != (mode == 3 && i == 1
                    ? (V)INT64_MIN : (V)(10 * (i + 1)))) return 247;
                cursor = OBJ(cursor)->f[1];
            }
            if (cursor || *fwp_rc_slot(alias) != 1) return 248;
            DROP_LIST(alias);
        }
        if (owner_ledger_live != live || fwp_heap.live != baseline || fwp_heap.rc_wide_len) return 90;
    }
    if (!traps || !cancellations || !allocation_failures) return 250;
    owner_ledger_finish();
    printf("consumed numeric storage verified: traps=%u cancellations=%u allocation-failures=%u\n",
        traps, cancellations, allocation_failures);
    return 0;
}
