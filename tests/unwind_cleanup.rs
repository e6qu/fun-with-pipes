//! Typed cleanup runs before failure/trap/cancellation invalidates stack frames.
use std::path::PathBuf;
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let out = command.output().unwrap();
    assert!(
        out.status.success(),
        "{command:?}: status {:?}: {}",
        out.status.code(),
        String::from_utf8_lossy(&out.stderr)
    );
    out
}
struct Scratch(PathBuf);
impl Scratch {
    fn new(name: &str) -> Self {
        let p = std::env::temp_dir().join(format!("fwp-unwind-{}-{name}", std::process::id()));
        std::fs::create_dir_all(&p).unwrap();
        Self(p)
    }
}
impl Drop for Scratch {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}

#[test]
fn cleanup_scopes_and_suspended_tasks_unwind_exactly_once() {
    let dir = Scratch::new("native");
    let src = dir.0.join("probe.fwp");
    let cfile = dir.0.join("probe.c");
    std::fs::write(&src, "main = task.yield () | echo\n").unwrap();
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
    let runtime = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let probe = r#"
static volatile int nreleased, release_order[16], callback_cancelled;
static volatile V values[16];
struct held { V value; int id; };
static void release_held(void *arg) {
    struct held *p = arg;
    release_order[nreleased++] = p->id;
    if (!fwp_rc_release_last(p->value)) abort();
    fwp_rc_free_obj(p->value);
}
static void register_held(fwp_cleanup *c, struct held *p, int id) {
    p->id = id;
    p->value = fwp_rc_fresh(fwp_cstr("owned cleanup"));
    values[id] = p->value;
    fwp_cleanup_push(c, release_held, p);
}
static void nested_error(void) {
    fwp_cleanup outer;
    struct held p;
    register_held(&outer, &p, 2);
    fwp_handler h;
    h.prev = fwp_handlers; h.state_depth = fwp_state_len; h.cleanup = fwp_cleanups;
    fwp_handlers = &h;
    if (!setjmp(h.jb)) {
        fwp_cleanup first, last;
        struct held a, b;
        register_held(&first, &a, 3);
        register_held(&last, &b, 4);
        fwp_fail(FWP_UNIT, 0);
    }
    if (fwp_cleanups != &outer || nreleased != 3 ||
        release_order[1] != 4 || release_order[2] != 3 ||
        *fwp_rc_slot(p.value) != 1) abort();
    fwp_handlers = h.prev;
    fwp_fail(h.value, h.desc);
}
static jmp_buf trap_target;
static fwp_cleanup *trap_stop;
static int recover_probe(void) {
    fwp_trap_jb = &trap_target;
    fwp_trap_cleanup = trap_stop;
    return 1;
}
static V scope_body(V *args) {
    (void)args;
    fwp_cleanup c;
    struct held p;
    register_held(&c, &p, 7);
    fwp_fail(FWP_UNIT, 0);
    return 0;
}
static const fwp_fninfo probe_fns[] = {{1, scope_body, "scope body", 0}};
static void sleeping_body(void *arg, int cancelled) {
    int id = (int)(uintptr_t)arg;
    if (cancelled) { callback_cancelled++; return; }
    fwp_cleanup c;
    struct held p;
    register_held(&c, &p, id);
    V long_wait = fwp_data(0, 1, (V[]){INT64_MAX});
    fwp_p_task_sleep(long_wait);
    abort(); /* cancellation must bypass normal return */
}
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));
    fwp_fns = probe_fns;
    fwp_cleanup normal;
    struct held a;
    register_held(&normal, &a, 1);
    fwp_cleanup_pop(&normal);
    if (nreleased || fwp_cleanups) return 1;
    release_held(&a);
    fwp_handler top;
    top.prev = fwp_handlers; top.state_depth = fwp_state_len; top.cleanup = fwp_cleanups;
    fwp_handlers = &top;
    if (!setjmp(top.jb)) nested_error();
    fwp_handlers = top.prev;
    if (nreleased != 4 || release_order[3] != 2 || fwp_cleanups) return 2;
    fwp_cleanup outer;
    struct held b;
    register_held(&outer, &b, 5);
    trap_stop = &outer;
    fwp_trap_recover = recover_probe;
    if (!setjmp(trap_target)) {
        fwp_cleanup inner;
        struct held c;
        register_held(&inner, &c, 6);
        fwp_trap("recoverable probe");
    }
    fwp_trap_recover = 0;
    if (nreleased != 5 || release_order[4] != 6 || fwp_cleanups != &outer ||
        strcmp(fwp_trap_msg, "recoverable probe")) return 3;
    fwp_cleanup_pop(&outer); release_held(&b);
    top.cleanup = fwp_cleanups;
    fwp_handlers = &top;
    if (!setjmp(top.jb)) fwp_p_task_scope(fwp_pap(0, 0, 0));
    fwp_handlers = top.prev;
    if (nreleased != 7 || release_order[6] != 7 || fwp_cleanups) return 4;
    fwp_cleanup root;
    struct held root_value;
    register_held(&root, &root_value, 8);
    fwp_task *first = fwp_spawn_task(0, sleeping_body, (void *)(uintptr_t)9, 0, 0);
    fwp_task *second = fwp_spawn_task(0, sleeping_body, (void *)(uintptr_t)10, 0, 0);
    fwp_p_task_yield(); /* both register and suspend */
    if (fwp_cleanups != &root || nreleased != 7) return 5;
    fwp_p_task_cancel(PTR(first));
    if (fwp_p_task_await(PTR(first)) != FWP_NONE || !first->done ||
        nreleased != 8 || release_order[7] != 9 || fwp_cleanups != &root) return 6;
    fwp_p_task_cancel(PTR(second));
    if (fwp_p_task_await(PTR(second)) != FWP_NONE || !second->done ||
        nreleased != 9 || release_order[8] != 10 || callback_cancelled != 2 ||
        fwp_cleanups != &root || *fwp_rc_slot(root_value.value) != 1) return 7;
    fwp_cleanup_pop(&root); release_held(&root_value);
    if (nreleased != 10 || fwp_cleanups) return 8;
    for (int i = 1; i <= 10; i++) {
        if (fwp_reuse_verify) {
            if (STR(values[i])->len) return 9;
        } else if (*fwp_rc_slot(values[i])) return 10;
    }
    puts("failure, trap, scope and cancellation cleanup preserved");
    return 0;
}
"#;
    for opt in ["-O1", "-O2"] {
        let exe = dir.0.join(opt);
        fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let out = checked(
                Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison),
            );
            assert_eq!(
                out.stdout,
                b"failure, trap, scope and cancellation cleanup preserved\n"
            );
        }
    }
}

#[test]
fn scoped_files_close_on_return_error_trap_and_cancellation() {
    let dir = Scratch::new("files");
    let src = dir.0.join("file.fwp");
    let cfile = dir.0.join("file.c");
    std::fs::write(&src, "main = task.yield () | echo\n").unwrap();
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
    let runtime = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let probe = r#"
static volatile int file_mode, open_fd, cancelled_calls;
static volatile V open_handle, file_path;
static jmp_buf file_trap;
static int file_recover(void) {
    fwp_trap_jb = &file_trap;
    fwp_trap_cleanup = 0;
    return 1;
}
static V file_body(V *args) {
    open_handle = args[0];
    open_fd = fileno(((fwp_file *)(uintptr_t)args[0])->f);
    if (file_mode == 1) fwp_fail(FWP_UNIT, 0);
    if (file_mode == 2) {
        V wait = fwp_data(0, 1, (V[]){INT64_MAX});
        fwp_p_task_sleep(wait);
    }
    if (file_mode == 3) fwp_trap("scoped file trap");
    return fwp_tuple2(42, args[0]);
}
static const fwp_fninfo file_fns[] = {{1, file_body, "file body", 0}};
static void file_task(void *arg, int cancelled) {
    (void)arg;
    if (cancelled) { cancelled_calls++; return; }
    fwp_p_file_with(file_path, fwp_pap(0, 0, 0), 0);
    abort();
}
static int closed(void) {
    errno = 0;
    return !((fwp_file *)(uintptr_t)open_handle)->f &&
        fcntl(open_fd, F_GETFD) == -1 && errno == EBADF && !fwp_cleanups;
}
int main(int argc, char **argv) {
    if (argc != 2) return 1;
    fwp_gc_start(__builtin_frame_address(0));
    fwp_fns = file_fns;
    file_path = fwp_cstr(argv[1]);
    if (fwp_p_file_with(file_path, fwp_pap(0, 0, 0), 0) != 42 || !closed()) return 2;
    file_mode = 1;
    fwp_handler h;
    h.prev = fwp_handlers; h.state_depth = fwp_state_len; h.cleanup = fwp_cleanups;
    fwp_handlers = &h;
    if (!setjmp(h.jb)) { fwp_p_file_with(file_path, fwp_pap(0, 0, 0), 0); return 3; }
    fwp_handlers = h.prev;
    if (!closed()) return 4;
    /* A recoverable failure before handle allocation must close the stream too. */
    FILE *early = tmpfile();
    if (!early) return 9;
    open_fd = fileno(early);
    fwp_file_cleanup early_file = {early, 0};
    fwp_cleanup early_cleanup;
    fwp_cleanup_push(&early_cleanup, fwp_close_scoped_file, &early_file);
    fwp_trap_recover = file_recover;
    if (!setjmp(file_trap)) fwp_trap("before handle allocation");
    if (!closed()) return 10;
    file_mode = 3;
    fwp_trap_recover = file_recover;
    if (!setjmp(file_trap)) { fwp_p_file_with(file_path, fwp_pap(0, 0, 0), 0); return 5; }
    fwp_trap_recover = 0;
    fwp_handlers = 0; /* trap bypassed file.with's error handler */
    if (!closed() || strcmp(fwp_trap_msg, "scoped file trap")) return 6;
    file_mode = 2;
    fwp_task *t = fwp_spawn_task(0, file_task, 0, 0, 0);
    fwp_p_task_yield();
    if (!((fwp_file *)(uintptr_t)open_handle)->f) return 7;
    fwp_p_task_cancel(PTR(t));
    if (fwp_p_task_await(PTR(t)) != FWP_NONE || !closed() || cancelled_calls != 1) return 8;
    puts("scoped file descriptors closed on every exit");
    return 0;
}
"#;
    for opt in ["-O1", "-O2"] {
        let exe = dir.0.join(opt);
        fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let out = checked(
                Command::new(&exe)
                    .arg(dir.0.join("scoped.txt"))
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison),
            );
            assert_eq!(
                out.stdout,
                b"scoped file descriptors closed on every exit\n"
            );
        }
    }
}

#[test]
fn scoped_file_handlers_match_interpreter() {
    let dir = Scratch::new("agreement");
    let src = dir.0.join("file.fwp");
    let data = dir.0.join("data.txt");
    let missing = dir.0.join("missing/data.txt");
    std::fs::write(&data, "scoped file contents").unwrap();
    std::fs::write(
        &src,
        format!(
            r#"
main = [
    "{}" | attempt (flip file.with file.read-all) | echo,
    "{}" | attempt (flip file.with file.read-all) | echo,
] | ignore
"#,
            data.display(),
            missing.display()
        ),
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
    assert!(reference
        .stdout
        .starts_with(b"Ok \"scoped file contents\"\nErr "));
    for opt in ["-O1", "-O2"] {
        let exe = dir.0.join(opt);
        checked(
            Command::new(fwp)
                .arg("build")
                .arg(&src)
                .args([opt, "-o"])
                .arg(&exe),
        );
        for poison in ["0", "1"] {
            let out = checked(
                Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison),
            );
            assert_eq!(out.stdout, reference.stdout, "{opt}, poison={poison}");
        }
    }
}
