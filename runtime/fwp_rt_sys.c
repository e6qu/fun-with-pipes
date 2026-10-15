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
    FWP_KEEP_ALIVE(path);
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
    FWP_KEEP_ALIVE(path);return result;
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
    FWP_KEEP_ALIVE(path);return FWP_UNIT;
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
    int f = (int)(int64_t)fd;
    if (f < 0 || f > 2) return FWP_FALSE;
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

/* a line read with the terminal's echo off (when stdin is one), then a
 * newline on stderr */
static V fwp_p_term_read_secret(void) {
    fwp_flush();
    fflush(stderr);
#ifndef __wasi__
    struct termios old, quiet;
    int tty = isatty(0) && tcgetattr(0, &old) == 0;
    if (tty) {
        quiet = old;
        quiet.c_lflag &= ~(tcflag_t)ECHO;
        tcsetattr(0, TCSAFLUSH, &quiet);
    }
#endif
    V r = fwp_p_read_line();
#ifndef __wasi__
    if (tty) {
        tcsetattr(0, TCSAFLUSH, &old);
        fputc('\n', stderr);
    }
#endif
    return r;
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

/* Run a command: with `capture`, give it `input` and capture its output;
 * without, share the standard streams and return the
 * status. */
static V fwp_run_process(V argv, V input, int capture, const fwp_desc *err) {
    size_t n = 0;
    for (V l = argv; l; l = OBJ(l)->f[1]) n++;
    if (n == 0) return fwp_io_error("spawn", "empty command", err);
    char **args = (char **)fwp_alloc((n + 1) * sizeof(char *));
    n = 0;
    for (V l = argv; l; l = OBJ(l)->f[1]) args[n++] = STR(OBJ(l)->f[0])->d;
    args[n] = 0;
    if (!fwp_program_exists(args[0])) {
        errno = ENOENT;
        return fwp_io_error_path("spawn", args[0], err);
    }
    fwp_flush();
    fflush(stderr);
    pid_t pid;
    if (!capture) {
        /* the program's own output goes to stderr (FWP_OUT=bin): so does
         * the called program's */
        posix_spawn_file_actions_t fa;
        posix_spawn_file_actions_init(&fa);
        if (fwp_prog_out == stderr) posix_spawn_file_actions_adddup2(&fa, 2, 1);
        int rc = posix_spawnp(&pid, args[0], &fa, 0, args, environ);
        posix_spawn_file_actions_destroy(&fa);
        if (rc != 0) { errno = rc; return fwp_io_error_path("spawn", args[0], err); }
        int st;
        while (waitpid(pid, &st, 0) < 0 && errno == EINTR) {}
        return (V)(int64_t)fwp_status_code(st);
    }
    int in[2], out[2], er[2];
    if (pipe(in) != 0) return fwp_io_error_path("spawn", args[0], err);
    if (pipe(out) != 0) { close(in[0]); close(in[1]); return fwp_io_error_path("spawn", args[0], err); }
    if (pipe(er) != 0) {
        close(in[0]); close(in[1]); close(out[0]); close(out[1]);
        return fwp_io_error_path("spawn", args[0], err);
    }
    posix_spawn_file_actions_t fa;
    posix_spawn_file_actions_init(&fa);
    posix_spawn_file_actions_adddup2(&fa, in[0], 0);
    posix_spawn_file_actions_adddup2(&fa, out[1], 1);
    posix_spawn_file_actions_adddup2(&fa, er[1], 2);
    int fds[6] = {in[0], in[1], out[0], out[1], er[0], er[1]};
    for (int i = 0; i < 6; i++) posix_spawn_file_actions_addclose(&fa, fds[i]);
    int rc = posix_spawnp(&pid, args[0], &fa, 0, args, environ);
    posix_spawn_file_actions_destroy(&fa);
    close(in[0]);
    close(out[1]);
    close(er[1]);
    if (rc != 0) {
        close(in[1]); close(out[0]); close(er[0]);
        errno = rc;
        return fwp_io_error_path("spawn", args[0], err);
    }
    /* write the input and read both outputs without blocking on either */
    signal(SIGPIPE, SIG_IGN);
    fcntl(in[1], F_SETFL, fcntl(in[1], F_GETFL) | O_NONBLOCK);
    fwp_buf ob = {0}, eb = {0};
    size_t off = 0, len = STR(input)->len;
    int win = in[1], rout = out[0], rerr = er[0];
    if (len == 0) { close(win); win = -1; }
    while (win >= 0 || rout >= 0 || rerr >= 0) {
        struct pollfd p[3];
        int np = 0, iw = -1, io = -1, ie = -1;
        if (win >= 0) { iw = np; p[np].fd = win; p[np++].events = POLLOUT; }
        if (rout >= 0) { io = np; p[np].fd = rout; p[np++].events = POLLIN; }
        if (rerr >= 0) { ie = np; p[np].fd = rerr; p[np++].events = POLLIN; }
        if (poll(p, (nfds_t)np, -1) < 0) {
            if (errno == EINTR) continue;
            break;
        }
        if (iw >= 0 && p[iw].revents) {
            ssize_t w = write(win, STR(input)->d + off, len - off);
            if (w > 0) off += (size_t)w;
            if (w < 0 && errno != EAGAIN && errno != EINTR) off = len;
            if (off >= len) { close(win); win = -1; }
        }
        char tmp[65536];
        if (io >= 0 && p[io].revents) {
            ssize_t r = read(rout, tmp, sizeof tmp);
            if (r > 0) buf_put(&ob, tmp, (size_t)r);
            else if (r == 0 || errno != EINTR) { close(rout); rout = -1; }
        }
        if (ie >= 0 && p[ie].revents) {
            ssize_t r = read(rerr, tmp, sizeof tmp);
            if (r > 0) buf_put(&eb, tmp, (size_t)r);
            else if (r == 0 || errno != EINTR) { close(rerr); rerr = -1; }
        }
    }
    int st;
    while (waitpid(pid, &st, 0) < 0 && errno == EINTR) {}
    /* fields in canonical order: status, stderr, stdout */
    V f[3] = {(V)(int64_t)fwp_status_code(st), fwp_str_lossy(eb.d ? eb.d : "", eb.len),
              fwp_str_lossy(ob.d ? ob.d : "", ob.len)};
    free(ob.d);
    free(eb.d);
    return fwp_record(3, f);
}

static V fwp_p_process_run_input(V input, V argv, const fwp_desc *err) { return fwp_run_process(argv, input, 1, err); }
static V fwp_p_process_call(V argv, const fwp_desc *err) { return fwp_run_process(argv, 0, 0, err); }
#endif /* __wasi__ */

#endif /* !_WIN32 */
