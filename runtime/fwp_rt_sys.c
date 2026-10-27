/* Primitives for command-line programs: the file system, the environment,
 * the terminal and processes (mirrors src/sys.rs). Errors are IoErrors
 * whose message is "<path>: <strerror>". */

static int fwp_cmp_cstr(const void *a, const void *b) {
    const V x = *(const V *)a, y = *(const V *)b;
    size_t n = STR(x)->len < STR(y)->len ? STR(x)->len : STR(y)->len;
    int c = memcmp(STR(x)->d, STR(y)->d, n);
    if (c) return c;
    return STR(x)->len < STR(y)->len ? -1 : STR(x)->len > STR(y)->len;
}

static int fwp_cmp_env(const void *a, const void *b) {
    V x = *(const V *)a, y = *(const V *)b;
    int c = fwp_cmp_cstr(&OBJ(x)->f[0], &OBJ(y)->f[0]);
    return c ? c : fwp_cmp_cstr(&OBJ(x)->f[1], &OBJ(y)->f[1]);
}

static V fwp_p_file_append(V path, V s, const fwp_desc *err) {
    if (fwp_path_has_nul(path)) return fwp_io_error("write", "path contains a NUL character", err);
    FILE *f = fwp_path_fopen(path, "ab");
    if (!f) return fwp_io_error_path("write", STR(path)->d, err);
    int error = fwrite(STR(s)->d, 1, STR(s)->len, f) == STR(s)->len ? 0 : errno;
    if (fclose(f) != 0 && !error) error = errno;
    if (error) {
        errno = error;
        return fwp_io_error_path("write", STR(path)->d, err);
    }
    return FWP_UNIT;
}

static V fwp_p_file_write_bytes(V path, V s, const fwp_desc *err) {
    if (fwp_path_has_nul(path)) return fwp_io_error("write", "path contains a NUL character", err);
    FILE *f = fwp_path_fopen(path, "wb");
    if (!f) return fwp_io_error_path("write", STR(path)->d, err);
    int error = fwrite(STR(s)->d, 1, STR(s)->len, f) == STR(s)->len ? 0 : errno;
    if (fclose(f) != 0 && !error) error = errno;
    if (error) {
        errno = error;
        return fwp_io_error_path("write", STR(path)->d, err);
    }
    return FWP_UNIT;
}

#ifndef _WIN32
#include <dirent.h>
#include <sys/stat.h>
#include <unistd.h>
#ifndef __wasi__
#include <termios.h>
#include <sys/ioctl.h>
#include <spawn.h>
#include <poll.h>
#include <fcntl.h>
#include <sys/wait.h>
#endif

extern char **environ;

static V fwp_p_file_exists(V path) {
    if (fwp_path_has_nul(path)) return FWP_FALSE;
    struct stat st;
    return stat(STR(path)->d, &st) == 0 ? FWP_TRUE : FWP_FALSE;
}

static V fwp_p_file_is_dir(V path) {
    if (fwp_path_has_nul(path)) return FWP_FALSE;
    struct stat st;
    return stat(STR(path)->d, &st) == 0 && S_ISDIR(st.st_mode) ? FWP_TRUE : FWP_FALSE;
}

static V fwp_p_file_info(V path, const fwp_desc *err) {
    if (fwp_path_has_nul(path)) return fwp_io_error("stat", "path contains a NUL character", err);
    struct stat st;
    if (stat(STR(path)->d, &st) != 0) return fwp_io_error_path("stat", STR(path)->d, err);
#if defined(__APPLE__)
    int64_t seconds = st.st_mtimespec.tv_sec, nanos = st.st_mtimespec.tv_nsec;
#else
    int64_t seconds = st.st_mtim.tv_sec, nanos = st.st_mtim.tv_nsec;
#endif
    /* Match the interpreter: pre-epoch time is zero; wide nanoseconds narrow
     * modulo 2^64, without signed multiplication overflow. */
    int64_t ns = seconds < 0 ? 0 : (int64_t)((uint64_t)seconds * UINT64_C(1000000000) + (uint64_t)nanos);
    fwp_value_owner modified = {fwp_rc_fresh(fwp_duration(ns)), fwp_rc_free_obj};
    fwp_cleanup cleanup;
    fwp_value_protect(&modified, &cleanup);
    /* fields in canonical order: is-dir, modified, size */
    V fields[3] = {S_ISDIR(st.st_mode) ? FWP_TRUE : FWP_FALSE, modified.value, (V)(int64_t)st.st_size};
    V result = fwp_rc_fresh(fwp_record(3, fields));
    (void)fwp_value_finish(&modified, &cleanup);

    return result;
}

static V fwp_p_file_remove(V path, const fwp_desc *err) {
    if (fwp_path_has_nul(path)) return fwp_io_error("remove", "path contains a NUL character", err);
    if (unlink(STR(path)->d) != 0) return fwp_io_error_path("remove", STR(path)->d, err);
    return FWP_UNIT;
}

static V fwp_p_dir_remove(V path, const fwp_desc *err) {
    if (fwp_path_has_nul(path)) return fwp_io_error("remove", "path contains a NUL character", err);
    if (rmdir(STR(path)->d) != 0) return fwp_io_error_path("remove", STR(path)->d, err);
    return FWP_UNIT;
}

static V fwp_p_file_rename(V to, V from, const fwp_desc *err) {
    if (fwp_path_has_nul(from) || fwp_path_has_nul(to)) return fwp_io_error("rename", "path contains a NUL character", err);
    if (rename(STR(from)->d, STR(to)->d) != 0) return fwp_io_error_path("rename", STR(from)->d, err);
    return FWP_UNIT;
}

static void fwp_directory_release(void *arg) {
    DIR **directory=arg;
    if (*directory) closedir(*directory);
    *directory=NULL;
}

static V fwp_p_dir_list(V path, const fwp_desc *err, void (*drop_list)(V)) {
    if (fwp_path_has_nul(path)) return fwp_io_error("list", "path contains a NUL character", err);
    DIR *directory=opendir(STR(path)->d);
    if (!directory) return fwp_io_error_path("list", STR(path)->d, err);
    fwp_cleanup directory_cleanup;
    fwp_cleanup_push(&directory_cleanup, fwp_directory_release, &directory);
    fwp_map_owner owner={NULL,0,0,fwp_rc_free_obj,drop_list};
    fwp_cleanup cleanup; fwp_map_protect(&owner,&cleanup);
    size_t capacity=16;
    owner.items=(V *)fwp_mem_alloc(capacity*sizeof(V));
    int failed=0;
    for (;;) {
        errno=0;
        struct dirent *entry=readdir(directory);
        if (!entry) {failed=errno;break;}
        if (!strcmp(entry->d_name,".") || !strcmp(entry->d_name,"..")) continue;
        if (owner.count==capacity) {
            if (capacity>SIZE_MAX/sizeof(V)/2) fwp_trap("directory too large");
            owner.items=fwp_mem_realloc(owner.items,capacity*sizeof(V),capacity*2*sizeof(V));
            capacity*=2;
        }
        owner.items[owner.count]=fwp_rc_fresh(fwp_str_lossy(entry->d_name,strlen(entry->d_name)));
        owner.count++;
    }
    if (failed) {errno=failed;return fwp_io_error_path("list",STR(path)->d,err);}
    qsort(owner.items,owner.count,sizeof(V),fwp_cmp_cstr);
    V result=fwp_map_finish_protected(&owner,&cleanup);
    fwp_cleanup_pop(&directory_cleanup);fwp_directory_release(&directory);
    return result;
}

static V fwp_p_dir_create(V path, const fwp_desc *err) {
    if (fwp_path_has_nul(path)) return fwp_io_error("create", "path contains a NUL character", err);
    if (mkdir(STR(path)->d, 0777) != 0) return fwp_io_error_path("create", STR(path)->d, err);
    return FWP_UNIT;
}

static V fwp_p_dir_create_all(V path, const fwp_desc *err) {
    if (fwp_path_has_nul(path)) return fwp_io_error("create", "path contains a NUL character", err);
    const char *p = STR(path)->d;
    size_t len = STR(path)->len;
    V *scratch=NULL;fwp_cleanup cleanup;fwp_scratch_protect(&scratch,&cleanup);
    char *buf = (char *)fwp_alloc_leaf(len + 1);scratch=(V *)buf;
    struct stat st;
    for (size_t i = 1; i <= len; i++) {
        if (i < len && p[i] != '/') continue;
        memcpy(buf, p, i);
        buf[i] = 0;
        if (stat(buf, &st) == 0) {
            if (S_ISDIR(st.st_mode)) continue;
            if (i < len) {
                /* Ask about the original path: a trailing slash has different
                 * mkdir diagnostics on Linux and macOS. */
                if (mkdir(p, 0777) != 0) return fwp_io_error_path("create", p, err);
                break;
            }
        }
        if (mkdir(buf, 0777) != 0) {
            int error = errno;
            if (error == EEXIST && stat(buf, &st) == 0) {
                if (S_ISDIR(st.st_mode)) continue;
                if (i < len) {
                    if (mkdir(p, 0777) == 0) break;
                    error = errno;
                }
            }
            errno = error;
            return fwp_io_error_path("create", p, err);
        }
    }
    fwp_scratch_finish(&scratch,&cleanup);
    return FWP_UNIT;
}

static V fwp_p_env_vars(void (*drop_pair)(V), void (*drop_list)(V)) {
    size_t capacity=16;
    fwp_map_owner owner={NULL,0,0,drop_pair,drop_list};
    fwp_cleanup cleanup;fwp_map_protect(&owner,&cleanup);
    owner.items=(V *)fwp_mem_alloc(capacity*sizeof(V));
    for (char **entry=environ;entry && *entry;entry++) {
        const char *equal=strchr(*entry,'=');if(!equal)continue;
        if(owner.count==capacity) {
            if(capacity>SIZE_MAX/sizeof(V)/2)fwp_trap("environment too large");
            owner.items=fwp_mem_realloc(owner.items,capacity*sizeof(V),capacity*2*sizeof(V));
            capacity*=2;
        }
        fwp_value_owner key={fwp_rc_fresh(fwp_str_lossy(*entry,(size_t)(equal-*entry))),fwp_rc_free_obj};
        fwp_cleanup key_cleanup;fwp_value_protect(&key,&key_cleanup);
        fwp_value_owner value={fwp_rc_fresh(fwp_str_lossy(equal+1,strlen(equal+1))),fwp_rc_free_obj};
        fwp_cleanup value_cleanup;fwp_value_protect(&value,&value_cleanup);
        owner.items[owner.count]=fwp_rc_fresh(fwp_record(2,(V[]){key.value,value.value}));
        owner.count++;
        (void)fwp_value_finish(&value,&value_cleanup);
        (void)fwp_value_finish(&key,&key_cleanup);
    }
    qsort(owner.items,owner.count,sizeof(V),fwp_cmp_env);
    return fwp_map_finish_protected(&owner,&cleanup);
}

static V fwp_p_env_cwd(const fwp_desc *error) {
    fwp_buf path = {0};
    path.d = getcwd(NULL, 0);
    if (!path.d) return fwp_io_error("cwd", strerror(errno), error);
    fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup, fwp_buf_release, &path);
    V result = fwp_str_lossy(path.d, strlen(path.d));
    fwp_cleanup_pop(&cleanup);
    fwp_buf_release(&path);
    return result;
}

static V fwp_p_term_is_tty(V fd) {
    if ((int64_t)fd < 0 || fd > 2) return FWP_FALSE;
    int f = (int)fd;
    fwp_flush();
    return isatty(f) ? FWP_TRUE : FWP_FALSE;
}

/* the width of the terminal: COLUMNS (digits only), else the terminal of
 * stdout, stderr or stdin, else 80 (src/sys.rs term_width) */
static V fwp_p_term_width(void) {
    const char *c = getenv("COLUMNS");
    if (c && *c && strlen(c) <= 5 && strspn(c, "0123456789") == strlen(c)) {
        long w = strtol(c, 0, 10);
        if (w > 0) return (V)(int64_t)w;
    }
#ifndef __wasi__
    int fds[3] = {1, 2, 0};
    for (int i = 0; i < 3; i++) {
        struct winsize ws;
        if (ioctl(fds[i], TIOCGWINSZ, &ws) == 0 && ws.ws_col > 0) return (V)(int64_t)ws.ws_col;
    }
#endif
    return (V)(int64_t)80;
}

#ifndef __wasi__
typedef struct { struct termios saved; int changed; } fwp_terminal;
static void fwp_terminal_restore(void *pointer) {
    fwp_terminal *terminal = (fwp_terminal *)pointer;
    if (terminal->changed) tcsetattr(0, TCSAFLUSH, &terminal->saved);
}
#endif

/* Restore terminal echo on normal return and before unwinding this frame. */
static V fwp_p_term_read_secret(void) {
    fwp_flush(); fflush(stderr);
#ifndef __wasi__
    fwp_terminal terminal = {0};
    if (isatty(0) && tcgetattr(0, &terminal.saved) == 0) {
        struct termios quiet = terminal.saved;
        quiet.c_lflag &= ~(tcflag_t)ECHO;
        terminal.changed = tcsetattr(0, TCSAFLUSH, &quiet) == 0;
    }
    fwp_cleanup cleanup; fwp_cleanup_push(&cleanup, fwp_terminal_restore, &terminal);
#endif
    V result = fwp_p_read_line();
#ifndef __wasi__
    fwp_cleanup_pop(&cleanup); fwp_terminal_restore(&terminal);
    if (terminal.changed) fputc('\n', stderr);
#endif
    return result;
}

#ifndef __wasi__
/* exit status as a shell reports it */
static int fwp_status_code(int st) {
    if (WIFEXITED(st)) return WEXITSTATUS(st);
    if (WIFSIGNALED(st)) return 128 + WTERMSIG(st);
    return 1;
}

/* Whether `prog` names a file, found on PATH as execvp finds it (one
 * found but not executable is left to posix_spawnp, which says so). posix_spawnp reports a missing program itself only where the C
 * library spawns with vfork semantics (glibc 2.24 and later, on hardware);
 * elsewhere (older C libraries, qemu-user) the child exits with 127, so
 * the lookup is done here first. */
static int fwp_program_exists(const char *prog) {
    if (strchr(prog, '/')) return access(prog, F_OK) == 0;
    const char *path = getenv("PATH");
    if (!path) path = "/bin:/usr/bin";
    size_t pl = strlen(prog);
    for (const char *p = path;; ) {
        const char *e = strchr(p, ':');
        size_t dl = e ? (size_t)(e - p) : strlen(p);
        char buf[4096];
        if (dl + pl + 2 <= sizeof buf) {
            if (dl == 0) { memcpy(buf, ".", 1); dl = 1; } else memcpy(buf, p, dl);
            buf[dl] = '/';
            memcpy(buf + dl + 1, prog, pl + 1);
            struct stat sb;
            if (stat(buf, &sb) == 0 && S_ISREG(sb.st_mode)) return 1;
        }
        if (!e) return 0;
        p = e + 1;
    }
}

/* Own temporary argument storage, pipe endpoints, output buffers and the child
 * until waitpid confirms it has been reaped. Unwinding closes and reaps too. */
typedef struct {
    char **args;
    int fds[6];
    pid_t pid;
    posix_spawn_file_actions_t actions;
    int actions_initialized;
    posix_spawnattr_t attributes;
    int attributes_initialized;
    fwp_buf out, err;
} fwp_process;
static void fwp_process_close(int *fd) {
    if (*fd >= 0) { close(*fd); *fd = -1; }
}
static void fwp_process_finish(void *pointer) {
    fwp_process *process = (fwp_process *)pointer;
    for (int i = 0; i < 6; i++) fwp_process_close(&process->fds[i]);
    if (process->pid > 0) {
        int status;
        pid_t waited;
        do { waited = waitpid(process->pid, &status, WNOHANG); } while (waited < 0 && errno == EINTR);
        if (!waited) {
            kill(process->pid, SIGKILL);
            do { waited = waitpid(process->pid, &status, 0); } while (waited < 0 && errno == EINTR);
        }
        process->pid = 0;
    }
    if (process->actions_initialized) {
        posix_spawn_file_actions_destroy(&process->actions);
        process->actions_initialized = 0;
    }
    if (process->attributes_initialized) {
        posix_spawnattr_destroy(&process->attributes);
        process->attributes_initialized = 0;
    }
    fwp_mem_free(process->args); process->args = NULL;
    fwp_buf_release(&process->out);
    fwp_buf_release(&process->err);
}

/* Block broken-pipe delivery only on this thread around write. Libraries must
 * preserve the host's signal disposition and any already-pending SIGPIPE. */
static ssize_t fwp_process_write(int fd, const void *bytes, size_t size) {
    sigset_t blocked, saved, pending;
    sigemptyset(&blocked); sigaddset(&blocked, SIGPIPE);
    if (pthread_sigmask(SIG_BLOCK, &blocked, &saved)) fwp_trap("cannot block SIGPIPE during process input");
    if (sigpending(&pending)) {
        pthread_sigmask(SIG_SETMASK, &saved, NULL);
        fwp_trap("cannot inspect pending process signals");
    }
    int already_pending = sigismember(&pending, SIGPIPE);
    ssize_t result = write(fd, bytes, size);
    int failed = errno;
    if (result < 0 && failed == EPIPE && !already_pending) {
        if (sigpending(&pending) == 0 && sigismember(&pending, SIGPIPE)) {
            int delivered; sigwait(&blocked, &delivered);
        }
    }
    if (pthread_sigmask(SIG_SETMASK, &saved, NULL)) fwp_trap("cannot restore process signal mask");
    errno = failed;
    return result;
}

/* With capture, send input and collect both streams without pipe deadlock;
 * otherwise inherit the standard streams and return the child exit status. */
static V fwp_run_process(V argv, V input, int capture, const fwp_desc *err) {
    size_t n = 0;
    for (V list = argv; list; list = OBJ(list)->f[1]) {
        if (fwp_path_has_nul(OBJ(list)->f[0]))
            return fwp_io_error("spawn", "command argument contains a NUL character", err);
        if (n == SIZE_MAX / sizeof(char *) - 1) fwp_trap("too many process arguments");
        n++;
    }
    if (!n) return fwp_io_error("spawn", "empty command", err);
    fwp_process process = {.fds = {-1, -1, -1, -1, -1, -1}};
    fwp_cleanup cleanup; fwp_cleanup_push(&cleanup, fwp_process_finish, &process);
    process.args = (char **)fwp_mem_alloc((n + 1) * sizeof(char *));
    n = 0;
    for (V list = argv; list; list = OBJ(list)->f[1]) process.args[n++] = STR(OBJ(list)->f[0])->d;
    process.args[n] = NULL;
    const char *program = STR(OBJ(argv)->f[0])->d;
    int failed = 0, status;
    if (!fwp_program_exists(program)) { failed = ENOENT; goto finish; }
    fwp_flush(); fflush(stderr);
    int rc = posix_spawn_file_actions_init(&process.actions);
    if (rc) { failed = rc; goto finish; }
    process.actions_initialized = 1;
    if (capture) {
        for (int i = 0; i < 6; i += 2) {
            if (pipe(&process.fds[i])) { failed = errno; goto finish; }
        }
        const int sources[3] = {process.fds[0], process.fds[3], process.fds[5]};
        for (int i = 0; i < 3; i++) {
            rc = posix_spawn_file_actions_adddup2(&process.actions, sources[i], i);
            if (rc) { failed = rc; goto finish; }
        }
        for (int i = 0; i < 6; i++) {
            /* A pipe can occupy an initially closed standard descriptor.
             * After dup2, descriptors 0..2 are the child's intended streams. */
            if (process.fds[i] < 3) continue;
            rc = posix_spawn_file_actions_addclose(&process.actions, process.fds[i]);
            if (rc) { failed = rc; goto finish; }
        }
    } else if (fwp_prog_out == stderr) {
        rc = posix_spawn_file_actions_adddup2(&process.actions, 2, 1);
        if (rc) { failed = rc; goto finish; }
    }
    /* The parent ignores broken-pipe signals for its own IO. Rust Command
     * restores SIGPIPE in children; native children must have the same policy. */
    rc = posix_spawnattr_init(&process.attributes);
    if (rc) { failed = rc; goto finish; }
    process.attributes_initialized = 1;
    sigset_t defaults; sigemptyset(&defaults); sigaddset(&defaults, SIGPIPE);
    rc = posix_spawnattr_setsigdefault(&process.attributes, &defaults);
    if (rc) { failed = rc; goto finish; }
    rc = posix_spawnattr_setflags(&process.attributes, POSIX_SPAWN_SETSIGDEF);
    if (rc) { failed = rc; goto finish; }
    pid_t pid;
    rc = posix_spawnp(&pid, program, &process.actions, &process.attributes, process.args, environ);
    if (rc) { failed = rc; goto finish; }
    process.pid = pid;
    posix_spawnattr_destroy(&process.attributes);
    process.attributes_initialized = 0;
    posix_spawn_file_actions_destroy(&process.actions);
    process.actions_initialized = 0;
    if (capture) {
        fwp_process_close(&process.fds[0]);
        fwp_process_close(&process.fds[3]);
        fwp_process_close(&process.fds[5]);
        int flags = fcntl(process.fds[1], F_GETFL);
        if (flags < 0 || fcntl(process.fds[1], F_SETFL, flags | O_NONBLOCK) < 0) {
            failed = errno; goto finish;
        }
        size_t off = 0, len = STR(input)->len;
        if (!len) fwp_process_close(&process.fds[1]);
        while (process.fds[1] >= 0 || process.fds[2] >= 0 || process.fds[4] >= 0) {
            struct pollfd pollfds[3];
            int np = 0, iw = -1, io = -1, ie = -1;
            if (process.fds[1] >= 0) { iw = np; pollfds[np++] = (struct pollfd){process.fds[1], POLLOUT, 0}; }
            if (process.fds[2] >= 0) { io = np; pollfds[np++] = (struct pollfd){process.fds[2], POLLIN, 0}; }
            if (process.fds[4] >= 0) { ie = np; pollfds[np++] = (struct pollfd){process.fds[4], POLLIN, 0}; }
            if (poll(pollfds, (nfds_t)np, -1) < 0) {
                if (errno == EINTR) continue;
                failed = errno; goto finish;
            }
            if (iw >= 0 && pollfds[iw].revents) {
                ssize_t written = fwp_process_write(process.fds[1], STR(input)->d + off, len - off);
                if (written > 0) off += (size_t)written;
                /* A child may finish without reading all input, as in the interpreter. */
                if (written < 0 && errno != EAGAIN && errno != EINTR) off = len;
                if (off >= len) fwp_process_close(&process.fds[1]);
            }
            char bytes[65536];
            const int positions[2] = {io, ie}, slots[2] = {2, 4};
            fwp_buf *buffers[2] = {&process.out, &process.err};
            for (int i = 0; i < 2; i++) if (positions[i] >= 0 && pollfds[positions[i]].revents) {
                ssize_t count = read(process.fds[slots[i]], bytes, sizeof bytes);
                if (count > 0) buf_put(buffers[i], bytes, (size_t)count);
                else if (!count) fwp_process_close(&process.fds[slots[i]]);
                else if (errno != EINTR) { failed = errno; goto finish; }
            }
        }
    }
    pid_t waited;
    do { waited = waitpid(process.pid, &status, 0); } while (waited < 0 && errno == EINTR);
    if (waited < 0) { failed = errno; goto finish; }
    process.pid = 0;
    V result = (V)(int64_t)fwp_status_code(status);
    if (capture) {
        fwp_value_owner stderr_value = {fwp_rc_fresh(fwp_str_lossy(process.err.d ? process.err.d : "", process.err.len)), fwp_rc_free_obj};
        fwp_cleanup stderr_cleanup; fwp_value_protect(&stderr_value, &stderr_cleanup);
        fwp_value_owner stdout_value = {fwp_rc_fresh(fwp_str_lossy(process.out.d ? process.out.d : "", process.out.len)), fwp_rc_free_obj};
        fwp_cleanup stdout_cleanup; fwp_value_protect(&stdout_value, &stdout_cleanup);
        V fields[3] = {result, stderr_value.value, stdout_value.value};
        result = fwp_rc_fresh(fwp_record(3, fields));
        (void)fwp_value_finish(&stdout_value, &stdout_cleanup);
        (void)fwp_value_finish(&stderr_value, &stderr_cleanup);
    }
    fwp_cleanup_pop(&cleanup); fwp_process_finish(&process);

    return result;
finish:
    fwp_cleanup_pop(&cleanup); fwp_process_finish(&process);
    errno = failed;
    return fwp_io_error_path("spawn", program, err);
}

static V fwp_p_process_run_input(V input, V argv, const fwp_desc *err) { return fwp_run_process(argv, input, 1, err); }
static V fwp_p_process_call(V argv, const fwp_desc *err) { return fwp_run_process(argv, 0, 0, err); }
#endif /* __wasi__ */

#endif /* !_WIN32 */
