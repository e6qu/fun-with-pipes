/* Exercise the generated kernel, not a copy of the sort algorithm. */
static size_t key_allocations, key_fail_at, key_calls, key_fail_call;
static int key_active;
static void key_allocation(void) {
    if (key_active && ++key_allocations == key_fail_at) fwp_fail(0, NULL);
}
static void key_entry(void) {
    if (key_active && ++key_calls == key_fail_call) fwp_fail(0, NULL);
}
static int key_case(size_t n, size_t fail_at, size_t fail_call) {
    const char *texts[] = {"b", "a", "a", "z", "a", "x", "y"};
    int64_t numbers[] = {0, 0, 0, INT64_MIN, 0, INT64_MAX, -1};
    size_t order[] = {3, 6, 1, 2, 4, 0, 5};
    V pairs[7], xs = 0;
    size_t baseline = fwp_heap.live;
    for (size_t i = n; i; i--) {
        size_t j = i - 1;
        V text = fwp_rc_fresh(fwp_cstr(texts[j]));
        pairs[j] = fwp_rc_fresh(fwp_record(2, (V[]){text, (V)numbers[j]}));
        xs = fwp_rc_fresh(fwp_cons(pairs[j], xs));
    }
    fwp_handler handler;
    handler.prev = fwp_handlers; handler.state_depth = fwp_state_len;
    handler.cleanup = fwp_cleanups; fwp_handlers = &handler;
    key_allocations = key_calls = 0;
    key_fail_at = fail_at; key_fail_call = fail_call; key_active = 1;
    if (!setjmp(handler.jb)) {
        V result = @sort@(xs);
        key_active = 0;
        if (fail_at || fail_call) return 221;
        if (key_allocations != n + (n > 1 ? 4 : 2) || key_calls != n) return 222;
        size_t i = 0;
        for (V node = result; node; node = OBJ(node)->f[1]) {
            if (i >= n || OBJ(node)->f[0] != pairs[n == 7 ? order[i] : i]) return 223;
            i++;
        }
        if (i != n) return 224;
        (@list@)->drop(result);
    } else {
        key_active = 0;
        if (!fail_at && !fail_call) return 225;
    }
    fwp_handlers = handler.prev;
    if (fwp_cleanups != handler.cleanup) return 226;
    for (size_t i = 0; i < n; i++) {
        if (*fwp_rc_slot(pairs[i]) != 1 || *fwp_rc_slot(OBJ(pairs[i])->f[0]) != 1) return 227;
        if (strcmp(STR(OBJ(pairs[i])->f[0])->d, texts[i])) return 228;
    }
    (@list@)->drop(xs);
    if (fwp_heap.live != baseline) return 229;
    return 0;
}
int main(void) {
    _Static_assert(sizeof(fwp_i64_string_key) == 16, "key field layout");
    _Static_assert(_Alignof(fwp_i64_string_key) == 8, "key field alignment");
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    fwp_budget = INT32_MAX;
    for (size_t n = 0; n <= 7; n += n ? 6 : 1) {
        int result = key_case(n, 0, 0); if (result) return result;
        /* Every scratch and output-spine allocation can fail. */
        for (size_t failure = 1; failure <= n + (n > 1 ? 4 : 2); failure++) {
            result = key_case(n, failure, 0); if (result) return result;
        }
        for (size_t failure = 1; failure <= n; failure++) {
            result = key_case(n, 0, failure); if (result) return result;
        }
    }
    return 0;
}
