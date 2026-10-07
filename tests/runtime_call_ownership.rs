//! Runtime application retains owners while entering compiled callbacks.
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
        let p =
            std::env::temp_dir().join(format!("fwp-runtime-call-{}-{name}", std::process::id()));
        std::fs::create_dir_all(&p).unwrap();
        Self(p)
    }
}
impl Drop for Scratch {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}

const SOURCE: &str = r#"cap-error : String -> I64 -> I64 ! {Error[String]}
cap-error = curry (both (.0 | string.length) (.1 | if (eq 0) (const "expected" | fail) (add 1)) | .1)
main = 0 | attempt (cap-error ("owned" | concat " capture")) | echo
"#;

#[test]
fn failed_calls_reclaim_function_storage_without_collection() {
    let dir = Scratch::new("counts");
    let src = dir.0.join("counts.fwp");
    let cfile = dir.0.join("counts.c");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(&src, SOURCE).unwrap();
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
    let start = emitted.find("/* cap-error :").unwrap();
    let id = emitted[start..]
        .split("static V f")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let probe = r#"
static volatile V captured, function_value;
int main(void) {
    fwp_gc_start(__builtin_frame_address(0)); fwp_fns = fwp_fn_table; fwp_init_consts();
    for (volatile int i = 0; i < 10000; i++) {
        captured = fwp_rc_fresh(fwp_str_new("capture", 7));
        function_value = fwp_rc_fresh(fwp_pap(FUNCTION, 1, (V[]){captured}));
        fwp_handler h;
        h.prev = fwp_handlers; h.state_depth = fwp_state_len; h.cleanup = fwp_cleanups;
        fwp_handlers = &h;
        if (!setjmp(h.jb)) { fwp_apply_owned(function_value, 1, (V[]){0}); return 1; }
        fwp_handlers = h.prev;
        if (fwp_cleanups) return 2;
    }
    printf("failed call collections: %zu\n", fwp_gc.ncollect);
    fwp_gc_report();
    return 0;
}
"#
    .replace("FUNCTION", id);
    let owned = format!(
        "{}\n{probe}",
        emitted.replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)"
        )
    );
    // Restore only the runtime frame's former missing consumed-function release.
    let release = "if (function) fwp_closure_drop(function);";
    assert_eq!(owned.matches(release).count(), 1);
    let leaking = owned.replace(release, "(void)function;");
    let mut freed = Vec::new();
    for (name, code) in [("leaking", &leaking), ("owned", &owned)] {
        let exe = dir.0.join(name);
        fwp::cgen::compile_c(code, &exe, "-O1").unwrap();
        let out = checked(
            Command::new(&exe)
                .env("FWP_GC", "off")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_GC_STRESS", "0")
                .env("FWP_REUSE_VERIFY", "0"),
        );
        assert_eq!(out.stdout, b"failed call collections: 0\n");
        let stats = String::from_utf8_lossy(&out.stderr);
        freed.push(
            stats
                .split(" MiB freed by counts")
                .next()
                .unwrap()
                .rsplit('(')
                .next()
                .unwrap()
                .parse::<f64>()
                .unwrap(),
        );
    }
    eprintln!("failed call MiB freed by counts: {freed:?}");
    // Statistics round to 0.1 MiB; require a difference beyond that precision.
    assert!(freed[1] > freed[0] + 0.2, "{freed:?}");
}

#[test]
fn consumed_function_releases_captures_when_its_entry_fails() {
    let dir = Scratch::new("captures");
    let src = dir.0.join("capture.fwp");
    let cfile = dir.0.join("capture.c");
    let exe = dir.0.join("capture");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(&src, SOURCE).unwrap();
    let reference = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
    let start = emitted.find("/* cap-error :").unwrap();
    let id = emitted[start..]
        .split("static V f")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let probe = r#"
static volatile V captured, function_value;
static int dead_string(V v) { return fwp_reuse_verify ? STR(v)->len == 0 : *fwp_rc_slot(v) == 0; }
static int dead_function(V v) { return fwp_reuse_verify ? CLO(v)->fn == 0xdead : *fwp_rc_slot(v) == 0; }
int main(void) {
    fwp_gc_start(__builtin_frame_address(0)); fwp_fns = fwp_fn_table; fwp_init_consts();
    if (!fwp_fns[FUNCTION].owned || !fwp_fns[FUNCTION].owned->drop_arguments) return 1;
    for (int alias = 0; alias < 2; alias++) {
        captured = fwp_rc_fresh(fwp_str_new("capture", 7));
        function_value = fwp_rc_fresh(fwp_pap(FUNCTION, 1, (V[]){captured}));
        if (alias) fwp_rc_dup(function_value);
        fwp_handler h;
        h.prev = fwp_handlers; h.state_depth = fwp_state_len; h.cleanup = fwp_cleanups;
        fwp_handlers = &h;
        if (!setjmp(h.jb)) { fwp_apply_owned(function_value, 1, (V[]){0}); return 2; }
        fwp_handlers = h.prev;
        if (fwp_cleanups) return 3;
        if (alias) {
            if (*fwp_rc_slot(function_value) != 1 || *fwp_rc_slot(captured) != 1 ||
                STR(captured)->len != 7 || memcmp(STR(captured)->d, "capture", 7)) return 4;
            fwp_closure_drop(function_value);
        }
        if (!dead_function(function_value) || !dead_string(captured)) return 5;
    }
    puts("consumed closures release across failed entries");
    return 0;
}
"#.replace("FUNCTION", id);
    let runtime = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    for opt in ["-O1", "-O2"] {
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
                b"consumed closures release across failed entries\n"
            );
        }
        checked(
            Command::new(fwp)
                .arg("build")
                .arg(&src)
                .args([opt, "-o"])
                .arg(&exe),
        );
        let out = checked(
            Command::new(&exe)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", "1"),
        );
        assert_eq!(out.stdout, reference.stdout);
    }
}

#[test]
fn overapplication_releases_pending_arguments_without_counting_scalars() {
    let dir = Scratch::new("overapply");
    let src = dir.0.join("overapply.fwp");
    let cfile = dir.0.join("overapply.c");
    let exe = dir.0.join("overapply");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(
        &src,
        r#"choose : I64 -> (String -> String)
choose = if (eq 0) (div 0 | const id) (const id)
main = 1 | attempt choose | result.unwrap-or id | apply "!" | echo
"#,
    )
    .unwrap();
    let reference = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
    let start = emitted.find("/* choose :").unwrap();
    let id = emitted[start..]
        .split("static V f")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let id_start = emitted.find("/* id :").unwrap();
    let identity = emitted[id_start..]
        .split("static V f")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let probe = r#"
static volatile V pending, scalar_word, function_value;
/* Exercise the runtime's curried entry ABI using the real generated type
 * metadata, rather than changing the source language's full-spine arity. */
static fwp_owned_fninfo prefix_owned;
static fwp_fninfo prefix_fns[sizeof fwp_fn_table / sizeof *fwp_fn_table];
static V prefix_entry(V *args) {
    if (!args[0]) fwp_trap("pending prefix trap");
    return PTR(&fcIDENTITY);
}
static jmp_buf pending_trap;
static int recover_pending(void) { fwp_trap_jb = &pending_trap; fwp_trap_cleanup = 0; return 1; }
static int dead_string(V v) { return fwp_reuse_verify ? STR(v)->len == 0 : *fwp_rc_slot(v) == 0; }
int main(void) {
    fwp_gc_start(__builtin_frame_address(0)); fwp_fns = fwp_fn_table; fwp_init_consts();
    memcpy(prefix_fns, fwp_fn_table, sizeof prefix_fns);
    prefix_owned = *fwp_fn_table[FUNCTION].owned;
    prefix_owned.entry = prefix_entry;
    prefix_fns[FUNCTION].arity = 1;
    prefix_fns[FUNCTION].entry = prefix_entry;
    prefix_fns[FUNCTION].owned = &prefix_owned;
    fwp_fns = prefix_fns;
    if (!prefix_owned.drop_arguments) return 1;
    pending = fwp_rc_fresh(fwp_str_new("pending", 7));
    function_value = fwp_rc_fresh(fwp_pap(FUNCTION, 0, 0));
    fwp_trap_recover = recover_pending;
    if (!setjmp(pending_trap)) { fwp_apply_owned(function_value, 2, (V[]){0, pending}); return 2; }
    fwp_trap_recover = 0;
    if (fwp_cleanups || !dead_string(pending)) return 3;
    if (fwp_reuse_verify ? CLO(function_value)->fn != 0xdead : *fwp_rc_slot(function_value) != 0) return 4;
    scalar_word = fwp_rc_fresh(fwp_str_new("scalar bits", 11));
    pending = fwp_rc_fresh(fwp_str_new("result", 6));
    function_value = fwp_rc_fresh(fwp_pap(FUNCTION, 0, 0));
    V result = fwp_apply_owned(function_value, 2, (V[]){scalar_word, pending});
    if (result != pending || *fwp_rc_slot(result) != 1 || *fwp_rc_slot(scalar_word) != 1 ||
        STR(scalar_word)->len != 11 || fwp_cleanups) return 5;
    if (!fwp_rc_release_last(result) || !fwp_rc_release_last(scalar_word)) return 6;
    fwp_mem_free((void *)(uintptr_t)result);
    fwp_mem_free((void *)(uintptr_t)scalar_word);
    puts("overapplication owns pending typed arguments");
    return 0;
}
"#.replace("FUNCTION", id).replace("IDENTITY", identity);
    let runtime = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let span_probe = probe.replace("fwp_apply_owned(function_value, 2, (V[]){0, pending})", "fwp_apply_borrowed_span(function_value, 2, (V[]){0, pending}, 1, 1)").replace("if (fwp_reuse_verify ? CLO(function_value)->fn != 0xdead : *fwp_rc_slot(function_value) != 0) return 4;", "if (*fwp_rc_slot(function_value) != 1) return 4; fwp_closure_drop(function_value);").replace("fwp_apply_owned(function_value, 2, (V[]){scalar_word, pending})", "fwp_apply_borrowed_span(function_value, 2, (V[]){scalar_word, pending}, 1, 1)").replace("    if (!fwp_rc_release_last(result)", "    if (*fwp_rc_slot(function_value) != 1) return 7; fwp_closure_drop(function_value);\n    if (!fwp_rc_release_last(result)");
    for opt in ["-O1", "-O2"] {
        for probe in [&probe, &span_probe] {
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
                    b"overapplication owns pending typed arguments\n"
                );
            }
        }
        checked(
            Command::new(fwp)
                .arg("build")
                .arg(&src)
                .args([opt, "-o"])
                .arg(&exe),
        );
        let out = checked(
            Command::new(&exe)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", "1"),
        );
        assert_eq!(out.stdout, reference.stdout);
    }
}

#[test]
fn owned_primitive_arguments_and_stack_captures_release_on_trap() {
    let dir = Scratch::new("primitive-stack");
    let src = dir.0.join("primitive.fwp");
    let cfile = dir.0.join("primitive.c");
    let exe = dir.0.join("primitive");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(
        &src,
        r#"rec twice : (String -> String) -> String -> String
twice = curry (fork apply (fork apply .1 .0) .0)
execute : String -> I64
execute = fork twice concat (const "!") | string.length
main = "owned" | concat " input" | attempt execute | echo
"#,
    )
    .unwrap();
    let reference = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
    assert!(
        emitted.contains("/* stack argument child */"),
        "fixture must use an owned stack capture"
    );
    assert!(emitted.contains("fwp_cleanup_push(&c, fwp_entry_release"));
    let start = emitted.find("/* execute :").unwrap();
    let execute = format!(
        "f{}",
        emitted[start..]
            .split("static V f")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap()
    );
    let probe = r#"
static volatile V original_capture;
static jmp_buf primitive_trap;
static int recover_primitive(void) { fwp_trap_jb = &primitive_trap; fwp_trap_cleanup = 0; return 1; }
int main(void) {
    fwp_gc_start(__builtin_frame_address(0)); fwp_fns = fwp_fn_table; fwp_init_consts();
    original_capture = fwp_rc_fresh(fwp_str_new("original", 8));
    trap_concat = 1; fwp_trap_recover = recover_primitive;
    if (!setjmp(primitive_trap)) { EXECUTE(original_capture); return 1; }
    fwp_trap_recover = 0; trap_concat = 0;
    if (strcmp(fwp_trap_msg, "owned primitive trap") || fwp_cleanups) return 2;
    if (fwp_reuse_verify ? STR(original_capture)->len != 0 : *fwp_rc_slot(original_capture) != 0) return 3;
    puts("primitive arguments and stack captures release on trap");
    return 0;
}
"#.replace("EXECUTE", &execute);
    // Inject a recoverable failure at the real primitive's entry. The actual
    // compiled caller, stack closure, owned wrapper and releases stay intact.
    let mut runtime = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    assert!(runtime.contains("static V fwp_p_concat(V t, V s) {"));
    runtime = runtime.replace(
        "static V fwp_p_concat(V t, V s) {",
        "static V fwp_p_concat(V t, V s) { if (trap_concat) fwp_trap(\"owned primitive trap\");",
    );
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(
            &format!("static volatile int trap_concat;\n{runtime}\n{probe}"),
            &exe,
            opt,
        )
        .unwrap();
        for poison in ["0", "1"] {
            let out = checked(
                Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison),
            );
            assert_eq!(
                out.stdout,
                b"primitive arguments and stack captures release on trap\n"
            );
        }
        checked(
            Command::new(fwp)
                .arg("build")
                .arg(&src)
                .args([opt, "-o"])
                .arg(&exe),
        );
        let out = checked(
            Command::new(&exe)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", "1"),
        );
        assert_eq!(out.stdout, reference.stdout);
    }
}

#[test]
fn cancelled_entry_releases_runtime_function_and_callee_parameters() {
    let dir = Scratch::new("cancelled-call");
    let src = dir.0.join("cancelled.fwp");
    let cfile = dir.0.join("cancelled.c");
    let exe = dir.0.join("cancelled");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let source = SOURCE.replace("main = 0 | attempt (cap-error (\"owned\" | concat \" capture\")) | echo",
        "main = [task.yield (), 0 | attempt (cap-error (\"owned\" | concat \" capture\")) | echo] | ignore");
    std::fs::write(&src, source).unwrap();
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
    let start = emitted.find("/* cap-error :").unwrap();
    let id = emitted[start..]
        .split("static V f")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let probe = r#"
static volatile V captured, function_value;
static fwp_task cancelled_call;
int main(void) {
    fwp_gc_start(__builtin_frame_address(0)); fwp_fns = fwp_fn_table; fwp_init_consts();
    captured = fwp_rc_fresh(fwp_str_new("cancel capture", 14));
    function_value = fwp_rc_fresh(fwp_pap(FUNCTION, 1, (V[]){captured}));
    cancelled_call.cancelled = 1; fwp_cur = &cancelled_call; fwp_budget = 0;
    if (!setjmp(cancelled_call.base)) { fwp_apply_owned(function_value, 1, (V[]){0}); return 1; }
    fwp_cur = 0;
    if (!cancelled_call.unwinding || fwp_cleanups) return 2;
    if (fwp_reuse_verify) {
        if (CLO(function_value)->fn != 0xdead || STR(captured)->len != 0) return 3;
    } else if (*fwp_rc_slot(function_value) || *fwp_rc_slot(captured)) return 4;
    puts("runtime function and incoming owners release on cancellation");
    return 0;
}
"#
    .replace("FUNCTION", id);
    let runtime = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    for opt in ["-O1", "-O2"] {
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
                b"runtime function and incoming owners release on cancellation\n"
            );
        }
    }
}
