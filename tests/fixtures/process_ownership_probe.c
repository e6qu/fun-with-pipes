static int process_test_mode, process_test_collect, process_test_copies;
static int process_test_appends, process_test_waits, process_test_disposals;
static int process_test_freed_buffers;
static jmp_buf process_test_failure;
static fwp_handler process_test_handler;
static int process_test_recover(void) { return 1; }
static void process_test_collect_now(void) {
#if !FWP_ARC_ONLY
    if (process_test_collect) fwp_gc_collect();
#endif
}
static V process_test_string(const char *text, size_t size) {
    process_test_copies++;
    process_test_collect_now();
    if ((process_test_mode == 2 && process_test_copies == 1) ||
        (process_test_mode == 3 && process_test_copies == 2))
        fwp_trap("process string construction failure");
    return fwp_str_lossy(text, size);
}
static V process_test_record(uint32_t count, const V *fields) {
    process_test_collect_now();
    if (process_test_mode == 4) fwp_trap("process record construction failure");
    return fwp_record(count, fields);
}
#ifdef _WIN32
static void *process_test_realloc(void *old, size_t size) {
    if (process_test_mode == 5) return NULL;
    return realloc(old, size);
}
static void process_test_free_output(void *pointer) {
    if (pointer) process_test_freed_buffers++;
    free(pointer);
}
static void process_test_finish(void *pointer) {
    fwp_win_process *process = (fwp_win_process *)pointer;
    HANDLE handles[10]; int count = 0;
#define PROCESS_HANDLE(h) do { if (h) handles[count++] = (h); } while (0)
    PROCESS_HANDLE(process->process.hProcess); PROCESS_HANDLE(process->process.hThread);
    PROCESS_HANDLE(process->input);
    for (int i = 0; i < 3; i++) PROCESS_HANDLE(process->inherited[i]);
    int buffers = 0;
    for (int i = 0; i < 2; i++) {
        PROCESS_HANDLE(process->output[i].handle);
#ifndef FWP_STATIC_MEMORY
        PROCESS_HANDLE(process->readers[i]);
#endif
        buffers += process->output[i].data != NULL;
    }
#undef PROCESS_HANDLE
    int before = process_test_freed_buffers;
    fwp_win_process_finish(pointer);
    if (process_test_freed_buffers - before != buffers) _Exit(233);
    for (int i = 0; i < count; i++) {
        DWORD flags;
        if (GetHandleInformation(handles[i], &flags) || GetLastError() != ERROR_INVALID_HANDLE) _Exit(236);
    }
    process_test_disposals++;
}
#else
static void process_test_append(fwp_buf *buffer, const void *bytes, size_t size) {
    process_test_appends++;
    if (process_test_mode == 5 && process_test_appends == 2)
        fwp_trap("process capture buffer failure");
    buf_put(buffer, bytes, size);
}
static void process_test_buf_release(void *pointer) {
    if (((fwp_buf *)pointer)->d) process_test_freed_buffers++;
    fwp_buf_release(pointer);
}
static int process_test_poll(struct pollfd *fds, nfds_t count, int timeout) {
    if (process_test_mode == 6) { errno = EIO; return -1; }
    return poll(fds, count, timeout);
}
static ssize_t process_test_read(int fd, void *buffer, size_t size) {
    if (process_test_mode == 7) { errno = EIO; return -1; }
    return read(fd, buffer, size);
}
static pid_t process_test_wait(pid_t pid, int *status, int options) {
    process_test_waits++;
    if (process_test_mode == 8 && process_test_waits == 1) { errno = EINTR; return -1; }
    if (process_test_mode == 9) { errno = EIO; return -1; }
    return waitpid(pid, status, options);
}
static void process_test_finish(void *pointer) {
    fwp_process *process = (fwp_process *)pointer;
    int fds[6]; memcpy(fds, process->fds, sizeof fds);
    pid_t pid = process->pid;
    int buffers = (process->out.d != NULL) + (process->err.d != NULL);
    int before = process_test_freed_buffers;
    fwp_process_finish(pointer);
    if (process_test_freed_buffers - before != buffers) _Exit(233);
    for (int i = 0; i < 6; i++) if (fds[i] >= 0) {
        if (fcntl(fds[i], F_GETFD) != -1 || errno != EBADF) _Exit(236);
    }
    if (pid > 0) {
        int status;
        if (waitpid(pid, &status, WNOHANG) != -1 || errno != ECHILD) _Exit(237);
    }
    process_test_disposals++;
}
#endif
static void process_test_drop(V value) {
    if (fwp_rc_release_last(value)) fwp_rc_free_obj(value);
}
static void process_test_result(V value) {
    if (*fwp_rc_slot(value) != 1) _Exit(234);
    if ((int32_t)OBJ(value)->f[0] != 7) _Exit(238);
    for (int i = 1; i < 3; i++) {
        V text = OBJ(value)->f[i];
        if (*fwp_rc_slot(text) != 1) _Exit(235);
        if (STR(text)->len != 65536 || STR(text)->d[0] != (i == 1 ? 'e' : 'o')) _Exit(238);
        process_test_drop(text);
    }
    process_test_drop(value);
}
static void process_test_error(V value) {
    if (*fwp_rc_slot(value) != 1) _Exit(234);
    V kind = OBJ(value)->f[0], message = OBJ(value)->f[1];
    if (*fwp_rc_slot(kind) != 1 || *fwp_rc_slot(message) != 1) _Exit(235);
    if (STR(kind)->len != 5 || memcmp(STR(kind)->d, "spawn", 5)) _Exit(238);
    process_test_drop(kind); process_test_drop(message); process_test_drop(value);
}
int main(void) {
    fwp_gc_start(__builtin_frame_address(0)); fwp_fns = fwp_fn_table; fwp_init_consts();
#if FWP_ARC_ONLY
    const int collect_limit = 0;
#else
    const int collect_limit = 1;
#endif
#ifdef _WIN32
    const int mode_limit = 5;
#else
    const int mode_limit = 9;
#endif
    for (process_test_collect = 0; process_test_collect <= collect_limit; process_test_collect++) {
        intptr_t budget = fwp_gc.budget;
        for (process_test_mode = 0; process_test_mode <= mode_limit; process_test_mode++) for (int repeat = 0; repeat < 8; repeat++) {
            process_test_copies = process_test_appends = process_test_waits = process_test_disposals = 0;
            int error = process_test_mode == 1;
            int trap = process_test_mode >= 2 && process_test_mode <= 4;
#ifdef _WIN32
            error |= process_test_mode == 5;
#else
            trap |= process_test_mode == 5;
            error |= process_test_mode == 6 || process_test_mode == 7 || process_test_mode == 9;
#endif
            if (error) {
                fwp_handler *handler = &process_test_handler;
                memset(handler, 0, sizeof *handler); handler->prev = fwp_handlers; handler->cleanup = fwp_cleanups; fwp_handlers = handler;
                if (!setjmp(handler->jb)) { (void)fEXERCISE((V)(process_test_mode == 1)); return 239; }
                fwp_handlers = handler->prev;
                process_test_error(handler->value); handler->value = 0;
            } else if (trap) {
                fwp_trap_recover = process_test_recover; fwp_trap_jb = &process_test_failure; fwp_trap_cleanup = fwp_cleanups;
                if (!setjmp(process_test_failure)) { (void)fEXERCISE(0); return 240; }
                fwp_trap_recover = 0; fwp_trap_jb = 0; fwp_trap_cleanup = 0;
            } else {
#ifndef _WIN32
                int saved_input = -1;
                if (process_test_mode == 0 && repeat == 0) { saved_input = dup(0); close(0); }
#endif
                V result = fEXERCISE(0);
#ifndef _WIN32
                if (process_test_mode == 0 && repeat == 0 && saved_input >= 0) {
                    if (dup2(saved_input, 0) < 0) return 241;
                    close(saved_input);
                }
                if (process_test_mode == 8 && process_test_waits < 2) return 242;
#endif
                process_test_result(result);
            }
            if (process_test_disposals != 1 || fwp_cleanups) return 243;
            if (!process_test_collect && fwp_gc.budget != budget) return 244;
        }
    }
    return 0;
}
