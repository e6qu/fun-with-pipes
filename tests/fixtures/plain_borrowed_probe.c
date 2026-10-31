/* A borrowed callable keeps its owner even when scalar bits look like pointers.
 * The allocation ledger independently detects an owned returned callable that
 * an overapplication accidentally treats as borrowed. */
static V plain_function;
static int plain_mode;
static fwp_task plain_cancelled;
static fwp_fninfo plain_table[sizeof fwp_fn_table / sizeof *fwp_fn_table + 1];

static void plain_entry_hook(void) {
    if (plain_mode == 1) fwp_fail(0, NULL);
    if (plain_mode == 2) fwp_check_cancel();
}
static void plain_release(void *arg) {
    V *owner = arg, value = *owner;
    *owner = 0;
    if (value) fwp_closure_drop(value);
}
static V plain_factory(V *args) {
    return fwp_rc_fresh(fwp_pap(ADD_FN, 1, args));
}
static void plain_factory_caps(V f, int duplicate) {
    if (!duplicate) fwp_rc_free_obj(f);
}
static void plain_no_args(V *args, uint32_t start, uint32_t count) {
    (void)args; (void)start; (void)count;
}
static const fwp_owned_fninfo plain_factory_owned = {
    plain_factory, plain_factory_caps, plain_no_args, NULL
};

static int plain_typed_failure(void) {
    plain_function = fwp_rc_fresh(fwp_pap(ERROR_FN, 0, NULL));
    fwp_handler handler = {0};
    handler.prev = fwp_handlers;
    handler.cleanup = fwp_cleanups;
    handler.state_depth = fwp_state_len;
    fwp_handlers = &handler;
    if (!setjmp(handler.jb)) {
        (void)fwp_apply_borrowed(plain_function, 1, (V[]){(V)(int64_t)-1});
        return 231;
    }
    fwp_handlers = handler.prev;
    if (handler.value != (V)(int64_t)-1 || !handler.desc ||
        *fwp_rc_slot(plain_function) != 1 || fwp_cleanups) return 232;
    if (fwp_apply_borrowed(plain_function, 1, (V[]){3}) != 4) return 233;
    plain_release(&plain_function);
    return 0;
}

static int plain_unwind(int cancellation) {
    size_t before = fwp_heap.live;
    plain_function = fwp_rc_fresh(fwp_pap(ADD_FN, 1, (V[]){0}));
    plain_mode = cancellation ? 2 : 1;
    fwp_handler handler = {0};
    handler.prev = fwp_handlers;
    handler.cleanup = fwp_cleanups;
    handler.state_depth = fwp_state_len;
    fwp_handlers = &handler;
    fwp_task *previous = fwp_cur;
    memset(&plain_cancelled, 0, sizeof plain_cancelled);
    jmp_buf task_base;
    plain_cancelled.base = &task_base;
    if (cancellation) {
        fwp_cur = &plain_cancelled;
        plain_cancelled.cancelled = 1;
    }
    if (!setjmp(task_base)) {
        if (!setjmp(handler.jb)) {
            fwp_cleanup cleanup;
            fwp_cleanup_push(&cleanup, plain_release, &plain_function);
            (void)fwp_apply_borrowed(plain_function, 1, (V[]){7});
            return 234;
        }
    }
    fwp_cur = previous;
    fwp_handlers = handler.prev;
    plain_mode = 0;
    if (plain_cancelled.unwinding != cancellation || plain_function ||
        fwp_cleanups || fwp_heap.live != before) return 235;
    plain_function = fwp_rc_fresh(fwp_pap(ADD_FN, 1, (V[]){7}));
    if (fwp_apply_borrowed(plain_function, 1, (V[]){3}) != 10) return 236;
    plain_release(&plain_function);
    return fwp_heap.live == before ? 0 : 237;
}

int main(void) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 242;
#endif
    fwp_heap_start(); fwp_init_consts(); fwp_fns = plain_table;
    memcpy(plain_table, fwp_fn_table, sizeof fwp_fn_table);
    size_t factory = sizeof fwp_fn_table / sizeof *fwp_fn_table;
    plain_table[factory] = (fwp_fninfo){1, plain_factory, "scalar factory", &plain_factory_owned};
    for (size_t i = 0; i < 3; i++) {
        size_t id = (size_t[]){ADD_FN, SHOW_FN, ERROR_FN}[i];
        if (!plain_table[id].owned || plain_table[id].owned->drop_arguments) return 227;
    }
    size_t baseline = fwp_heap.live;
    for (unsigned round = 0; round < 64; round++) {
        V bits = fwp_rc_fresh(fwp_cstr("pointer-shaped scalar"));
        for (unsigned alias = 0; alias < 2; alias++) {
            V function = fwp_rc_fresh(fwp_pap(ADD_FN, 1, (V[]){0}));
            if (alias) fwp_rc_dup(function);
            plain_retains = plain_releases = 0; plain_counting = 1;
            V result = fwp_apply_borrowed(function, 1, &bits);
            plain_counting = 0;
            if (result != bits || plain_retains || plain_releases ||
                *fwp_rc_slot(bits) != 1 || *fwp_rc_slot(function) != 1 + alias ||
                CLO(function)->n != 1 || CLO(function)->a[0] != 0) return 228;
            /* Supplying too few arguments must still construct an owned result. */
            V partial = fwp_apply_borrowed(function, 0, NULL);
            if (CLO(partial)->n != 1 || *fwp_rc_slot(function) != 1 + alias) return 230;
            fwp_closure_drop(partial);
            if (alias) fwp_closure_drop(function);
            fwp_closure_drop(function);
        }
        V show = fwp_rc_fresh(fwp_pap(SHOW_FN, 0, NULL));
        V text = fwp_apply_borrowed(show, 1, (V[]){123});
        if (*fwp_rc_slot(text) != 1 || STR(text)->len != 3 || memcmp(STR(text)->d, "123", 3)) return 238;
        fwp_rc_free_obj(text); fwp_closure_drop(show);
        size_t before = fwp_heap.live;
        V function = fwp_rc_fresh(fwp_pap((uint32_t)factory, 0, NULL));
        if (fwp_apply_borrowed(function, 2, (V[]){7, 3}) != 10) return 239;
        fwp_closure_drop(function);
        if (fwp_heap.live != before) return 229;
        int status = plain_typed_failure();
        if (status) return status;
        for (int cancellation = 0; cancellation < 2; cancellation++) {
            status = plain_unwind(cancellation);
            if (status) return status;
        }
        if (*fwp_rc_slot(bits) != 1) return 240;
        fwp_rc_free_obj(bits);
        if (fwp_heap.live != baseline || fwp_cleanups || fwp_state_len || fwp_state_owners) return 241;
    }
    owner_ledger_finish();
    puts("plain borrowed calls preserve counts, returned owners and unwind cleanup");
    return 0;
}
