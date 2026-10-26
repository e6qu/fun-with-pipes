/* Runs inside the emitted library so ownership is checked at each return,
 * before the normal teardown could conceal a missed release. */
static void *current_registration;
static int hook_mode;
static unsigned hook_calls;
static int callback_live(void *p) {
    return owner_ledger_slots[owner_ledger_find((uintptr_t)p)] != 0;
}
static void callback_expect(int condition, int status) {
    if (!condition) _Exit(status);
}
void callback_hook(void) {
    fwp_callback_context *context = current_registration;
    V capture = context->captures[0];
    hook_calls++;
    callback_expect(context->active > 0, 240);
    if (hook_mode == 1) fwp_callback_close(context);
    if (hook_mode == 2) fwp_callback_release(context);
    if (hook_mode == 3) {
        hook_mode = 2;
        const char *inner = NULL;
        callback_expect(fwp_invoke_inside(current_registration, &inner), 240);
        callback_expect(!strcmp(inner, "reentrant"), 240);
        fwp_release_inside(inner);
    }
    /* Test identity before reading possibly freed storage in a broken build. */
    callback_expect(callback_live(context) && callback_live((void *)(uintptr_t)capture), 242);
    callback_expect(!strcmp(STR(capture)->d, "reentrant"), 240);
}
const char *retained_fail(void) {
    const char *result = NULL;
    (void)fwp_invoke_failing(current_registration, &result);
    return result;
}
void retained_block(void) {
    const char *result = NULL;
    (void)fwp_invoke_blocked(current_registration, &result);
    if (result) fwp_release_blocked(result);
}
static jmp_buf callback_failure;
static int callback_recover(void) { return 1; }
static void callback_baseline(intptr_t bytes, size_t live) {
    callback_expect(!fwp_callback_registrations, 243);
    callback_expect(fwp_heap.live == bytes && owner_ledger_live == live, 241);
    callback_expect(!fwp_cleanups, 244);
}
#ifdef _WIN32
static DWORD WINAPI wrong_thread(void *unused) {
#else
static void *wrong_thread(void *unused) {
#endif
    (void)unused;
    int64_t result;
    (void)fwp_invoke_unary(current_registration, 1, &result);
    return 0;
}
#ifdef _WIN32
__declspec(dllexport)
#endif
int callback_probe(int mode, unsigned rounds) {
    fwp_lib_init();
    fwp_tasks_init();
    if (mode == 1) {
        current_registration = fwp_register_unary();
#ifdef _WIN32
        HANDLE thread = CreateThread(NULL, 0, wrong_thread, NULL, 0, NULL);
        callback_expect(thread != NULL, 240);
        WaitForSingleObject(thread, INFINITE); CloseHandle(thread);
#else
        pthread_t thread;
        callback_expect(!pthread_create(&thread, NULL, wrong_thread, NULL), 240);
        pthread_join(thread, NULL);
#endif
        return 240; /* The runtime must stop the wrong-thread entry. */
    }
    if (mode == 2) {
        current_registration = fwp_register_unary();
        fwp_lib_finish();
        return 240; /* Outstanding registrations must prevent unload. */
    }
    if (mode == 3) {
        current_registration = fwp_register_unary();
        return 0; /* Actual loader unload must reject this outstanding owner. */
    }
#ifdef __linux__
    /* An external descriptor need not close before library unload. Its idle
     * bookkeeping still belongs to this scheduler and must be released. */
    (void)fwp_fdw_get(0);
#endif
    size_t bytes = fwp_heap.live;
    size_t live = owner_ledger_live;
    for (unsigned round = 0; round < rounds; round++) {
        char input[] = "captured";
        struct fwp_callback_keep *registration = fwp_register_keep(input);
        memset(input, 'X', sizeof input - 1);
        const char *first = NULL, *second = NULL;
        callback_expect(fwp_invoke_keep(registration, &first) && fwp_invoke_keep(registration, &second), 240);
        fwp_close_keep(registration); fwp_close_keep(registration);
        const char *untouched = "sentinel";
        callback_expect(!fwp_invoke_keep(registration, &untouched) && !strcmp(untouched, "sentinel"), 240);
        fwp_release_callback_keep(registration);
        callback_expect(!strcmp(first, "captured") && !strcmp(second, "captured"), 240);
        fwp_release_keep(first); fwp_release_keep(second);
        struct fwp_callback_count *counted = fwp_register_count("héllo");
        int64_t total = -1;
        callback_expect(fwp_invoke_count(counted, 7, &total) && total == 12, 240);
        fwp_release_callback_count(counted);
        struct fwp_callback_second *two = fwp_register_second("first", "second");
        const char *last = NULL;
        callback_expect(fwp_invoke_second(two, &last) && !strcmp(last, "second"), 240);
        fwp_release_callback_second(two); fwp_release_second(last);
        struct fwp_callback_words *record = fwp_register_words((struct fwp_c_Words){.first="first", .second="second"});
        struct fwp_c_Words returned;
        callback_expect(fwp_invoke_words(record, &returned), 240);
        fwp_release_callback_words(record);
        callback_expect(!strcmp(returned.first, "first") && !strcmp(returned.second, "second"), 240);
        fwp_release_words(returned);
        struct fwp_callback_discard *unit = fwp_register_discard("discard");
        callback_expect(fwp_invoke_discard(unit), 240);
        fwp_release_callback_discard(unit);
        struct fwp_callback_unary *single = fwp_register_unary();
        callback_expect(fwp_invoke_unary(single, 41, &total) && total == 42, 240);
        fwp_release_callback_unary(single);
        callback_baseline(bytes, live);
    }
    for (int mode = 1; mode <= 3; mode++) {
        current_registration = fwp_register_inside("reentrant");
        hook_mode = mode; hook_calls = 0;
        const char *result = NULL;
        callback_expect(fwp_invoke_inside(current_registration, &result), 240);
        if (mode == 1) fwp_release_callback_inside(current_registration);
        callback_expect(!strcmp(result, "reentrant") && hook_calls == (mode == 3 ? 2U : 1U), 240);
        fwp_release_inside(result);
        callback_baseline(bytes, live);
    }
    /* The language handler catches an error after the C owner is released
     * inside the active callback. Its cleanup must finish during unwind. */
    current_registration = fwp_register_failing("reentrant"); hook_mode = 2;
    callback_expect(caught(), 240);
    callback_baseline(bytes, live);
    current_registration = fwp_register_blocked("reentrant"); hook_mode = 2;
    cancel();
    callback_baseline(bytes, live);
    /* A malformed later argument must release earlier copied captures and
     * the registration itself. Traps are intercepted only by this test hook. */
    fwp_trap_recover = callback_recover; fwp_trap_jb = &callback_failure;
    fwp_trap_cleanup = fwp_cleanups;
    if (!setjmp(callback_failure)) { fwp_register_second("first", NULL); return 240; }
    callback_baseline(bytes, live);
    if (!setjmp(callback_failure)) {
        fwp_register_words((struct fwp_c_Words){.first="first", .second="\xff"}); return 240;
    }
    callback_baseline(bytes, live);
    for (unsigned stage = 1; stage <= 3; stage++) {
        callback_fail_after = stage;
        if (!setjmp(callback_failure)) { fwp_register_second("first", "second"); return 240; }
        callback_expect(!callback_fail_after, 240);
        callback_baseline(bytes, live);
    }
    struct fwp_callback_keep *bad_result = fwp_register_keep("captured");
    if (!setjmp(callback_failure)) { fwp_invoke_keep(bad_result, NULL); return 240; }
    callback_expect(((fwp_callback_context *)bad_result)->active == 0, 243);
    fwp_release_callback_keep(bad_result);
    fwp_trap_recover = 0; fwp_trap_jb = 0;
    callback_baseline(bytes, live);
    return 0;
}
