/* ARC cleanup checks do not inspect freed objects. The address ledger and
 * byte balance observe storage; the OS independently reports file closure. */
static unsigned released, order[16], cancelled, file_mode;
static V file_path, open_handle;
static intptr_t opened;
static jmp_buf recovered;
static fwp_cleanup *recover_stop;
static const struct { uint32_t fn, n; } scope_function = {0, 0}, file_function = {1, 0};
static const struct { uint32_t tag, n; V fields[1]; } forever = {0, 1, {INT64_MAX}};
struct held { V value; unsigned id; };
static void require(int condition, int status) { if (!condition) _Exit(status); }
static int live(V value) { return owner_ledger_slots[owner_ledger_find((uintptr_t)value)] != 0; }
static void release_held(void *value) {
    struct held *owner = value;
    require(released < 16, 230);
    order[released++] = owner->id;
    require(fwp_rc_release_last(owner->value), 230);
    fwp_rc_free_obj(owner->value);
    require(!live(owner->value), 231);
}
static void hold(fwp_cleanup *cleanup, struct held *owner, unsigned id) {
    owner->id = id;
    owner->value = fwp_rc_fresh(fwp_cstr("owned during unwind"));
    fwp_cleanup_push(cleanup, release_held, owner);
}
static int recover(void) {
    fwp_trap_jb = &recovered;
    fwp_trap_cleanup = recover_stop;
    return 1;
}
static void nested_error(void) {
    fwp_cleanup outer;
    struct held parent;
    hold(&outer, &parent, 2);
    fwp_handler handler = {.prev=fwp_handlers, .state_depth=fwp_state_len, .cleanup=fwp_cleanups};
    fwp_handlers = &handler;
    if (!setjmp(handler.jb)) {
        fwp_cleanup first, last;
        struct held a, b;
        hold(&first, &a, 3); hold(&last, &b, 4);
        fwp_fail(FWP_UNIT, NULL);
    }
    require(released == 3 && order[1] == 4 && order[2] == 3, 232);
    require(fwp_cleanups == &outer && live(parent.value) && *fwp_rc_slot(parent.value) == 1, 232);
    fwp_handlers = handler.prev;
    fwp_fail(handler.value, handler.desc);
}
static V scoped(V *args) {
    (void)args;
    fwp_cleanup cleanup;
    struct held value;
    hold(&cleanup, &value, 7);
    fwp_fail(FWP_UNIT, NULL);
    return 0;
}
static void sleeping(void *argument, int was_cancelled) {
    if (was_cancelled) { cancelled++; return; }
    fwp_cleanup cleanup;
    struct held value;
    hold(&cleanup, &value, (unsigned)(uintptr_t)argument);
    fwp_p_task_sleep(PTR(&forever));
    _Exit(233);
}
static void remember_file(FILE *file) {
#ifdef _WIN32
    opened = _get_osfhandle(_fileno(file));
#else
    opened = fileno(file);
#endif
}
static int descriptor_closed(void) {
#ifdef _WIN32
    DWORD flags;
    SetLastError(0);
    return !GetHandleInformation((HANDLE)opened, &flags) && GetLastError() == ERROR_INVALID_HANDLE;
#else
    errno = 0;
    return fcntl((int)opened, F_GETFD) == -1 && errno == EBADF;
#endif
}
static V file_body(V *args) {
    fwp_value_owner input = {args[0], fwp_file_drop};
    fwp_cleanup cleanup; fwp_value_protect(&input, &cleanup);
    open_handle = args[0];
    remember_file(((fwp_file *)(uintptr_t)open_handle)->f);
    if (file_mode == 1) fwp_fail(FWP_UNIT, NULL);
    if (file_mode == 2) fwp_p_task_sleep(PTR(&forever));
    if (file_mode == 3) fwp_trap("owned file trap");
    /* The typed callback entry owns the argument duplicated by its caller. */
    V result = fwp_rc_fresh(fwp_tuple2(42, open_handle));
    (void)fwp_value_finish(&input, &cleanup);
    return result;
}
static void drop_pair(V pair) {
    if (!fwp_rc_release_last(pair)) return;
    fwp_file_drop(OBJ(pair)->f[1]);
    fwp_rc_free_obj(pair);
}
static void file_task(void *argument, int was_cancelled) {
    (void)argument;
    if (was_cancelled) { cancelled++; return; }
    fwp_p_file_with_owned(file_path, PTR(&file_function), NULL, drop_pair, NULL);
    _Exit(234);
}
static void no_captures(V function, int duplicate) { (void)function; (void)duplicate; }
static void unit_arguments(V *args, uint32_t start, uint32_t count) {
    (void)args; require(start <= 1 && count <= 1 - start, 230);
}
static void file_arguments(V *args, uint32_t start, uint32_t count) {
    require(start <= 1 && count <= 1 - start, 230);
    for (uint32_t i = 0; i < count; i++) fwp_file_dup(args[i]);
}
static void drop_file_arguments(V *args, uint32_t start, uint32_t count) {
    require(start <= 1 && count <= 1 - start, 230);
    for (uint32_t i = 0; i < count; i++) fwp_file_drop(args[i]);
}
static const fwp_owned_fninfo scope_owned = {scoped, no_captures, unit_arguments, unit_arguments};
static const fwp_owned_fninfo file_owned = {file_body, no_captures, file_arguments, drop_file_arguments};
static const fwp_fninfo functions[] = {{1, scoped, "scope", &scope_owned}, {1, file_body, "file", &file_owned}};
static void check_closed(void) {
    require(descriptor_closed(), 235);
    require(!live(open_handle) && !fwp_cleanups, 236);
}
static void one_round(void) {
    released = cancelled = 0;
    memset(order, 0, sizeof order);
    fwp_cleanup ordinary;
    struct held a;
    hold(&ordinary, &a, 1);
    fwp_cleanup_pop(&ordinary);
    require(!released && !fwp_cleanups, 232);
    release_held(&a);
    fwp_handler top = {.prev=fwp_handlers, .state_depth=fwp_state_len, .cleanup=fwp_cleanups};
    fwp_handlers = &top;
    if (!setjmp(top.jb)) nested_error();
    fwp_handlers = top.prev;
    require(released == 4 && order[3] == 2 && !fwp_cleanups, 232);
    fwp_cleanup outer;
    struct held parent;
    hold(&outer, &parent, 5);
    recover_stop = &outer;
    fwp_trap_recover = recover;
    if (!setjmp(recovered)) {
        fwp_cleanup inner;
        struct held child;
        hold(&inner, &child, 6);
        fwp_trap("owned cleanup trap");
    }
    fwp_trap_recover = 0;
    require(released == 5 && order[4] == 6 && fwp_cleanups == &outer, 232);
    require(live(parent.value), 232);
    fwp_cleanup_pop(&outer); release_held(&parent);
    fwp_handlers = &top;
    if (!setjmp(top.jb)) fwp_p_task_scope_borrowed(PTR(&scope_function), NULL);
    fwp_handlers = top.prev;
    require(released == 7 && order[6] == 7 && !fwp_cleanups, 232);
    fwp_cleanup root;
    struct held root_owner;
    hold(&root, &root_owner, 8);
    fwp_task *first = fwp_spawn_task(0, sleeping, (void *)(uintptr_t)9, 0, 0);
    fwp_task_own_internal(first, 1);
    fwp_task *second = fwp_spawn_task(0, sleeping, (void *)(uintptr_t)10, 0, 0);
    fwp_task_own_internal(second, 1);
    fwp_p_task_yield();
    require(released == 7 && fwp_cleanups == &root, 233);
    fwp_p_task_cancel(PTR(first));
    require(fwp_p_task_await(PTR(first)) == FWP_NONE && first->done && released == 8 && order[7] == 9, 233);
    fwp_p_task_cancel(PTR(second));
    require(fwp_p_task_await(PTR(second)) == FWP_NONE && second->done && released == 9 && order[8] == 10, 233);
    require(cancelled == 2 && fwp_cleanups == &root && live(root_owner.value), 233);
    fwp_task_drop(PTR(first)); fwp_task_drop(PTR(second)); fwp_free_zombie();
    fwp_cleanup_pop(&root); release_held(&root_owner);
    require(released == 10 && !fwp_cleanups, 232);
    file_mode = 0;
    require(fwp_p_file_with_owned(file_path, PTR(&file_function), NULL, drop_pair, NULL) == 42, 234);
    check_closed();
    file_mode = 1;
    fwp_handlers = &top;
    if (!setjmp(top.jb)) { fwp_p_file_with_owned(file_path, PTR(&file_function), NULL, drop_pair, NULL); _Exit(234); }
    fwp_handlers = top.prev;
    check_closed();
    FILE *early = tmpfile();
    require(early != NULL, 234); remember_file(early);
    fwp_file_cleanup pending = {early, 0};
    fwp_cleanup early_cleanup;
    fwp_cleanup_push(&early_cleanup, fwp_close_owned_scoped_file, &pending);
    recover_stop = NULL; fwp_trap_recover = recover;
    if (!setjmp(recovered)) fwp_trap("before file handle allocation");
    check_closed();
    file_mode = 3;
    if (!setjmp(recovered)) { fwp_p_file_with_owned(file_path, PTR(&file_function), NULL, drop_pair, NULL); _Exit(234); }
    fwp_trap_recover = 0; fwp_trap_jb = 0; fwp_trap_cleanup = 0;
    fwp_handlers = top.prev;
    check_closed();
    file_mode = 2;
    fwp_task *task = fwp_spawn_task(0, file_task, NULL, 0, 0);
    fwp_task_own_internal(task, 1);
    fwp_p_task_yield();
    require(live(open_handle) && !descriptor_closed(), 234);
    fwp_p_task_cancel(PTR(task));
    require(fwp_p_task_await(PTR(task)) == FWP_NONE && cancelled == 3, 234);
    fwp_task_drop(PTR(task)); fwp_free_zombie();
    check_closed();
}
int main(int argc, char **argv) {
    require(argc == 3, 230);
    fwp_heap_start();
    fwp_fns = functions; fwp_tasks_init();
    file_path = fwp_rc_fresh(fwp_cstr(argv[1]));
    size_t bytes = fwp_heap.live;
    size_t live_before = owner_ledger_live, finalizers = fwp_heap.nfins;
    for (unsigned round = 0; round < (unsigned)strtoul(argv[2], NULL, 10); round++) {
        one_round();
        require(fwp_heap.live == bytes && owner_ledger_live == live_before, 237);
        require(fwp_heap.nfins == finalizers, 238);
    }
    fwp_rc_free_obj(file_path);
    fwp_tasks_finish(); fwp_native_tasks_finish();
    owner_ledger_finish();
    return 0;
}
