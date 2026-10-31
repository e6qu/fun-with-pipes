static int process_test_mode, process_test_copies;
static int process_test_appends, process_test_waits, process_test_disposals;
static int process_test_freed_buffers;
static jmp_buf process_test_failure;
static fwp_handler process_test_handler;
static int process_test_recover(void) { return 1; }
static V process_test_string(const char *text, size_t size) {
    process_test_copies++;
    if ((process_test_mode == 2 && process_test_copies == 1) ||
        (process_test_mode == 3 && process_test_copies == 2))
        fwp_trap("process string construction failure");
    return fwp_str_lossy(text, size);
}
static V process_test_record(uint32_t count, const V *fields) {
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
#define PROCESS_HANDLE(h) do { HANDLE saved = (h); if (saved && saved != INVALID_HANDLE_VALUE) handles[count++] = saved; } while (0)
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
static volatile sig_atomic_t process_test_pipe_deliveries;
static void process_test_pipe(int signal_number) { (void)signal_number; process_test_pipe_deliveries++; }
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
        size_t expected = process_test_mode == 10 ? 0 : 65536;
        if (STR(text)->len != expected || (expected && STR(text)->d[0] != (i == 1 ? 'e' : 'o'))) _Exit(238);
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
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
#ifdef _WIN32
    const int mode_limit = 5;
#else
    const int mode_limit = 10;
#endif
    size_t live_bytes = fwp_heap.live;
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
            struct sigaction old_pipe, host_pipe = {0};
            sigset_t old_mask;
            if (process_test_mode == 10) {
                host_pipe.sa_handler = process_test_pipe; sigemptyset(&host_pipe.sa_mask);
                if (sigaction(SIGPIPE, &host_pipe, &old_pipe) || pthread_sigmask(SIG_SETMASK, NULL, &old_mask)) return 245;
                process_test_pipe_deliveries = 0;
            }
            int saved_input = -1;
            if (process_test_mode == 0 && repeat == 0) { saved_input = dup(0); close(0); }
#endif
            V result = fEXERCISE((V)(process_test_mode == 10 ? 2 : 0));
#ifndef _WIN32
            if (process_test_mode == 10) {
                struct sigaction current;
                sigset_t current_mask;
                if (sigaction(SIGPIPE, NULL, &current) || pthread_sigmask(SIG_SETMASK, NULL, &current_mask)) return 245;
                if (current.sa_handler != process_test_pipe || process_test_pipe_deliveries ||
                    sigismember(&old_mask, SIGPIPE) != sigismember(&current_mask, SIGPIPE)) return 246;
                int closed_pipe[2]; sigset_t blocked, saved_mask, pending;
                if (pipe(closed_pipe)) return 245;
                close(closed_pipe[0]);
                sigemptyset(&blocked); sigaddset(&blocked, SIGPIPE);
                if (pthread_sigmask(SIG_BLOCK, &blocked, &saved_mask) || raise(SIGPIPE)) return 245;
                if (fwp_process_write(closed_pipe[1], "x", 1) != -1 || errno != EPIPE) return 246;
                close(closed_pipe[1]);
                if (sigpending(&pending) || !sigismember(&pending, SIGPIPE)) return 246;
                int delivered;
                if (sigwait(&blocked, &delivered) || delivered != SIGPIPE ||
                    pthread_sigmask(SIG_SETMASK, &saved_mask, NULL)) return 245;
                if (sigaction(SIGPIPE, &old_pipe, NULL)) return 245;
            }
            if (process_test_mode == 0 && repeat == 0 && saved_input >= 0) {
                if (dup2(saved_input, 0) < 0) return 241;
                close(saved_input);
            }
            if (process_test_mode == 8 && process_test_waits < 2) return 242;
#endif
            process_test_result(result);
        }
        if (process_test_disposals != 1 || fwp_cleanups) return 243;
        if (fwp_heap.live != live_bytes) return 244;
    }
    return 0;
}
