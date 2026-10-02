/* Primitives for command-line programs: the file system, the environment,
 * the terminal and processes (mirrors src/sys.rs). Errors are IoErrors
 * whose message is "<path>: <strerror>". */

#include <dirent.h>
#include <sys/stat.h>
#include <unistd.h>
#ifndef __wasi__
#include <spawn.h>
#include <poll.h>
#include <fcntl.h>
#include <sys/wait.h>
#endif

extern char **environ;

static V fwp_p_file_exists(V path) {
    struct stat st;
    return stat(STR(path)->d, &st) == 0 ? FWP_TRUE : FWP_FALSE;
}

static V fwp_p_file_is_dir(V path) {
    struct stat st;
    return stat(STR(path)->d, &st) == 0 && S_ISDIR(st.st_mode) ? FWP_TRUE : FWP_FALSE;
}

static V fwp_p_file_info(V path, const fwp_desc *err) {
    struct stat st;
    if (stat(STR(path)->d, &st) != 0) return fwp_io_error_path("stat", STR(path)->d, err);
#if defined(__APPLE__)
    int64_t ns = (int64_t)st.st_mtimespec.tv_sec * 1000000000LL + st.st_mtimespec.tv_nsec;
#else
    int64_t ns = (int64_t)st.st_mtim.tv_sec * 1000000000LL + st.st_mtim.tv_nsec;
#endif
    /* fields in canonical order: is-dir, modified, size */
    V f[3] = {S_ISDIR(st.st_mode) ? FWP_TRUE : FWP_FALSE, fwp_duration(ns), (V)(int64_t)st.st_size};
    return fwp_record(3, f);
}

static V fwp_p_file_remove(V path, const fwp_desc *err) {
    if (unlink(STR(path)->d) != 0) return fwp_io_error_path("remove", STR(path)->d, err);
    return FWP_UNIT;
}

static V fwp_p_dir_remove(V path, const fwp_desc *err) {
    if (rmdir(STR(path)->d) != 0) return fwp_io_error_path("remove", STR(path)->d, err);
    return FWP_UNIT;
}

static V fwp_p_file_rename(V to, V from, const fwp_desc *err) {
    if (rename(STR(from)->d, STR(to)->d) != 0) return fwp_io_error_path("rename", STR(from)->d, err);
    return FWP_UNIT;
}

static V fwp_p_file_append(V path, V s, const fwp_desc *err) {
    FILE *f = fopen(STR(path)->d, "ab");
    if (!f) return fwp_io_error_path("write", STR(path)->d, err);
    size_t n = fwrite(STR(s)->d, 1, STR(s)->len, f);
    if (fclose(f) != 0 || n != STR(s)->len) return fwp_io_error_path("write", STR(path)->d, err);
    return FWP_UNIT;
}

static V fwp_p_file_write_bytes(V path, V s, const fwp_desc *err) {
    FILE *f = fopen(STR(path)->d, "wb");
    if (!f) return fwp_io_error_path("write", STR(path)->d, err);
    size_t n = fwrite(STR(s)->d, 1, STR(s)->len, f);
    if (fclose(f) != 0 || n != STR(s)->len) return fwp_io_error_path("write", STR(path)->d, err);
    return FWP_UNIT;
}

static int fwp_cmp_cstr(const void *a, const void *b) {
    const V x = *(const V *)a, y = *(const V *)b;
    size_t n = STR(x)->len < STR(y)->len ? STR(x)->len : STR(y)->len;
    int c = memcmp(STR(x)->d, STR(y)->d, n);
    if (c) return c;
    return STR(x)->len < STR(y)->len ? -1 : STR(x)->len > STR(y)->len;
}

static V fwp_p_dir_list(V path, const fwp_desc *err) {
    DIR *d = opendir(STR(path)->d);
    if (!d) return fwp_io_error_path("list", STR(path)->d, err);
    size_t n = 0, cap = 16;
    V *names = (V *)malloc(cap * sizeof(V));
    struct dirent *e;
    errno = 0;
    while ((e = readdir(d)) != 0) {
        if (strcmp(e->d_name, ".") == 0 || strcmp(e->d_name, "..") == 0) continue;
        if (n == cap) { cap *= 2; names = (V *)realloc(names, cap * sizeof(V)); }
        names[n++] = fwp_str_lossy(e->d_name, strlen(e->d_name));
    }
    int failed = errno != 0;
    closedir(d);
    if (failed) { free(names); return fwp_io_error_path("list", STR(path)->d, err); }
    qsort(names, n, sizeof(V), fwp_cmp_cstr);
    V r = fwp_list_from(names, n);
    free(names);
    return r;
}

static V fwp_p_dir_create(V path, const fwp_desc *err) {
    if (mkdir(STR(path)->d, 0777) != 0) return fwp_io_error_path("create", STR(path)->d, err);
    return FWP_UNIT;
}

static V fwp_p_dir_create_all(V path, const fwp_desc *err) {
    const char *p = STR(path)->d;
    size_t len = STR(path)->len;
    char *buf = (char *)fwp_alloc(len + 1);
    struct stat st;
    for (size_t i = 1; i <= len; i++) {
        if (i < len && p[i] != '/') continue;
        memcpy(buf, p, i);
        buf[i] = 0;
        if (stat(buf, &st) == 0 && S_ISDIR(st.st_mode)) continue;
        if (mkdir(buf, 0777) != 0 && !(errno == EEXIST && stat(buf, &st) == 0 && S_ISDIR(st.st_mode)))
            return fwp_io_error_path("create", p, err);
    }
    return FWP_UNIT;
}

static int fwp_cmp_env(const void *a, const void *b) {
    V x = *(const V *)a, y = *(const V *)b;
    int c = fwp_cmp_cstr(&OBJ(x)->f[0], &OBJ(y)->f[0]);
    return c ? c : fwp_cmp_cstr(&OBJ(x)->f[1], &OBJ(y)->f[1]);
}

static V fwp_p_env_vars(void) {
    size_t n = 0;
    for (char **e = environ; e && *e; e++) n++;
    V *items = (V *)malloc((n + 1) * sizeof(V));
    size_t k = 0;
    for (char **e = environ; e && *e; e++) {
        const char *eq = strchr(*e, '=');
        if (!eq) continue;
        V f[2] = {fwp_str_lossy(*e, (size_t)(eq - *e)), fwp_str_lossy(eq + 1, strlen(eq + 1))};
        items[k++] = fwp_record(2, f);
    }
    qsort(items, k, sizeof(V), fwp_cmp_env);
    V r = fwp_list_from(items, k);
    free(items);
    return r;
}

static V fwp_p_env_cwd(void) {
    char buf[4096];
    if (!getcwd(buf, sizeof buf)) return fwp_cstr(".");
    return fwp_str_lossy(buf, strlen(buf));
}

static V fwp_p_term_is_tty(V fd) {
    int f = (int)(int64_t)fd;
    if (f < 0 || f > 2) return FWP_FALSE;
    fwp_flush();
    return isatty(f) ? FWP_TRUE : FWP_FALSE;
}

#ifndef __wasi__
/* exit status as a shell reports it */
static int fwp_status_code(int st) {
    if (WIFEXITED(st)) return WEXITSTATUS(st);
    if (WIFSIGNALED(st)) return 128 + WTERMSIG(st);
    return 1;
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
    fwp_flush();
    fflush(stderr);
    pid_t pid;
    if (!capture) {
        int rc = posix_spawnp(&pid, args[0], 0, 0, args, environ);
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
