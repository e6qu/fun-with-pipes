//! Runtime application retains owners while entering compiled callbacks.
use std::path::PathBuf;
use std::process::{Command, Output};

#[path = "support/exported_probe.rs"]
mod exported_probe;

#[path = "support/record_probe.rs"]
mod record_probe;

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

const SOURCE: &str = r#"export cap-error : String -> I64 -> I64 ! {Error[String]}
cap-error = curry (both (.0 | string.length) (.1 | if (eq 0) (const "expected" | fail) (add 1)) | .1)
main = 0 | attempt (cap-error ("owned" | concat " capture")) | echo
"#;

#[test]
fn failed_calls_reclaim_function_storage_without_collection() {
    let dir = Scratch::new("counts");
    let src = dir.0.join("counts.fwp");
    std::fs::write(&src, SOURCE).unwrap();

    let emitted = exported_probe::generate(&src);
    let start = emitted
        .find("/* cap-error :")
        .expect("missing exported probe entry `cap-error`");
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
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    double before=(double)fwp_heap.live;
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
    double remaining=(double)fwp_heap.live-before;
    printf("failed call remaining bytes: %.0f\n", remaining);
    return remaining==0?0:171;
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
    for opt in ["-O1", "-O2"] {
        let mut remaining = Vec::new();
        for (name, code, expected) in [("leaking", &leaking, 171), ("owned", &owned, 0)] {
            let exe = dir.0.join(format!("counted{opt}-{name}.exe"));
            fwp::cgen::compile_c(code, &exe, opt).unwrap();
            let out = Command::new(&exe).output().unwrap();
            record_probe::save(
                "runtime_call_ownership",
                &format!("counted{opt}-failed-{name}"),
                code,
                &exe,
                &out,
            );
            assert_eq!(out.status.code(), Some(expected), "{name}: {out:?}");
            assert!(out.stderr.is_empty(), "{out:?}");
            let text = String::from_utf8(out.stdout).unwrap();
            remaining.push(
                text.trim()
                    .strip_prefix("failed call remaining bytes: ")
                    .unwrap()
                    .parse::<u64>()
                    .unwrap(),
            );
        }
        // A consumed closure must release its own storage even when its captures
        // have already moved into the failing callee. Check exact retained bytes;
        // rounded freed-byte statistics cannot distinguish that smaller leak.
        assert!(remaining[0] >= 10000 * 16, "{remaining:?}");
        assert_eq!(remaining[1], 0);
    }
}

#[test]
fn consumed_function_releases_captures_when_its_entry_fails() {
    let dir = Scratch::new("captures");
    let src = dir.0.join("capture.fwp");
    let exe = dir.0.join("capture.exe");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(&src, SOURCE).unwrap();
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src),
    );

    let emitted = exported_probe::generate(&src);
    let start = emitted
        .find("/* cap-error :")
        .expect("missing exported probe entry `cap-error`");
    let id = emitted[start..]
        .split("static V f")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let probe = r#"
static volatile V captured, function_value;
/* Read the live allocator metadata, never the freed payload. */
static int released(V v) { return *fwp_rc_slot(v) == 0; }
int main(void) {
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    if (!fwp_fns[FUNCTION].owned || !fwp_fns[FUNCTION].owned->drop_arguments) return 1;
    size_t baseline=fwp_heap.live;
    for(int round=0;round<32;round++) {
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
        if (!released(function_value) || !released(captured)) return 5;
    }
    ARC_BALANCE
    }
    puts("consumed closures release across failed entries");
    return 0;
}
"#
    .replace("FUNCTION", id);
    let probe = {
        probe.replace(
            "ARC_BALANCE",
            "if(fwp_heap.live!=baseline || fwp_heap.rc_wide_len)return 90;",
        )
    };
    let runtime = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let missing = probe.replace(
        "fwp_closure_drop(function_value);",
        "/* omitted outside alias */",
    );
    assert_ne!(missing, probe);
    let cases = [
        ("captures", format!("{runtime}\n{probe}"), 0),
        ("captures-missing-alias", format!("{runtime}\n{missing}"), 5),
    ];
    for opt in ["-O1", "-O2"] {
        for (label, code, status) in &cases {
            fwp::cgen::compile_c(code, &exe, opt).unwrap();

            let out = Command::new(&exe).output().unwrap();
            let label = format!("counted{opt}-{label}");
            record_probe::save("runtime_call_ownership", &label, code, &exe, &out);
            assert_eq!(out.status.code(), Some(*status), "{label}: {out:?}");
            assert!(out.stderr.is_empty(), "{label}: {out:?}");
            assert_eq!(
                String::from_utf8(out.stdout).unwrap().replace("\r\n", "\n"),
                if *status == 0 {
                    "consumed closures release across failed entries\n"
                } else {
                    ""
                },
                "{label}"
            );
        }
        let exe = dir.0.join(format!("counted{opt}-source.exe"));
        fwp::cgen::compile_c(&emitted, &exe, opt).unwrap();

        let out = Command::new(&exe).output().unwrap();
        let label = format!("counted{opt}-captures-source");
        record_probe::save("runtime_call_ownership", &label, &emitted, &exe, &out);
        assert_eq!(
            out.status.code(),
            reference.status.code(),
            "{label}: {out:?}"
        );
        assert_eq!(out.stdout, reference.stdout, "{label}");
        assert_eq!(out.stderr, reference.stderr, "{label}");
    }
}

#[test]
fn overapplication_releases_pending_arguments_without_counting_scalars() {
    let dir = Scratch::new("overapply");
    let src = dir.0.join("overapply.fwp");
    let cfile = dir.0.join("overapply.c");
    let exe = dir.0.join("overapply.exe");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(
        &src,
        r#"choose : I64 -> (String -> String)
choose = if (eq 0) (div 0 | const id) (const id)
main = 1 | attempt choose | result.unwrap-or id | apply "!" | echo
"#,
    )
    .unwrap();
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src),
    );

    checked(
        Command::new(fwp)
            .env_remove("FWP_NO_OPT")
            .env("FWP_STACK", "1")
            .args(["build", "--memory", "dynamic", "-O2"])
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(&cfile).unwrap();
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
static int released(V v) { return *fwp_rc_slot(v) == 0; }
int main(void) {
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    memcpy(prefix_fns, fwp_fn_table, sizeof prefix_fns);
    prefix_owned = *fwp_fn_table[FUNCTION].owned;
    prefix_owned.entry = prefix_entry;
    prefix_fns[FUNCTION].arity = 1;
    prefix_fns[FUNCTION].entry = prefix_entry;
    prefix_fns[FUNCTION].owned = &prefix_owned;
    fwp_fns = prefix_fns;
    if (!prefix_owned.drop_arguments) return 1;
    size_t baseline=fwp_heap.live;
    for(int round=0;round<32;round++) {
    pending = fwp_rc_fresh(fwp_str_new("pending", 7));
    function_value = fwp_rc_fresh(fwp_pap(FUNCTION, 0, 0));
    fwp_trap_recover = recover_pending;
    if (!setjmp(pending_trap)) { fwp_apply_owned(function_value, 2, (V[]){0, pending}); return 2; }
    fwp_trap_recover = 0;
    if (fwp_cleanups || !released(pending)) return 3;
    if (*fwp_rc_slot(function_value) != 0) return 4;
    scalar_word = fwp_rc_fresh(fwp_str_new("scalar bits", 11));
    pending = fwp_rc_fresh(fwp_str_new("result", 6));
    function_value = fwp_rc_fresh(fwp_pap(FUNCTION, 0, 0));
    V result = fwp_apply_owned(function_value, 2, (V[]){scalar_word, pending});
    if (result != pending || *fwp_rc_slot(result) != 1 || *fwp_rc_slot(scalar_word) != 1 ||
        STR(scalar_word)->len != 11 || fwp_cleanups) return 5;
    if (!fwp_rc_release_last(result) || !fwp_rc_release_last(scalar_word)) return 6;
    fwp_mem_free((void *)(uintptr_t)result);
    fwp_mem_free((void *)(uintptr_t)scalar_word);
    ARC_BALANCE
    }
    fwp_trap_jb=NULL;fwp_fns=fwp_fn_table;
    puts("overapplication owns pending typed arguments");
    return 0;
}
"#
    .replace("FUNCTION", id)
    .replace("IDENTITY", identity);
    let probe = {
        probe.replace(
            "ARC_BALANCE",
            "if(fwp_heap.live!=baseline || fwp_heap.rc_wide_len)return 90;",
        )
    };
    let runtime = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let consumed_check = "if (*fwp_rc_slot(function_value) != 0) return 4;";
    assert_eq!(probe.matches(consumed_check).count(), 1);
    let span_probe = probe
            .replace(
                "fwp_apply_owned(function_value, 2, (V[]){0, pending})",
                "fwp_apply_borrowed_span(function_value, 2, (V[]){0, pending}, 1, 1)",
            )
            .replace(
                consumed_check,
                "if (*fwp_rc_slot(function_value) != 1) return 4; fwp_closure_drop(function_value);",
            )
            .replace(
                "fwp_apply_owned(function_value, 2, (V[]){scalar_word, pending})",
                "fwp_apply_borrowed_span(function_value, 2, (V[]){scalar_word, pending}, 1, 1)",
            )
            .replace(
                "    if (!fwp_rc_release_last(result)",
                "    if (*fwp_rc_slot(function_value) != 1) return 7; fwp_closure_drop(function_value);\n    if (!fwp_rc_release_last(result)",
            );
    let mut cases = vec![
        ("overapply", format!("{runtime}\n{probe}"), 0),
        ("span", format!("{runtime}\n{span_probe}"), 0),
    ];

    let missing = probe.replace(
        "fwp_mem_free((void *)(uintptr_t)scalar_word);",
        "/* omitted scalar owner */",
    );
    assert_ne!(missing, probe);
    cases.push((
        "overapply-missing-scalar",
        format!("{runtime}\n{missing}"),
        90,
    ));

    for opt in ["-O1", "-O2"] {
        for (label, code, status) in &cases {
            fwp::cgen::compile_c(code, &exe, opt).unwrap();

            let out = Command::new(&exe).output().unwrap();
            let label = format!("counted{opt}-{label}");
            record_probe::save("runtime_call_ownership", &label, code, &exe, &out);
            assert_eq!(out.status.code(), Some(*status), "{label}: {out:?}");
            assert!(out.stderr.is_empty(), "{label}: {out:?}");
            assert_eq!(
                String::from_utf8(out.stdout).unwrap().replace("\r\n", "\n"),
                if *status == 0 {
                    "overapplication owns pending typed arguments\n"
                } else {
                    ""
                },
                "{label}"
            );
        }
        let exe = dir.0.join(format!("counted{opt}-source.exe"));
        fwp::cgen::compile_c(&emitted, &exe, opt).unwrap();

        let out = Command::new(&exe).output().unwrap();
        let label = format!("counted{opt}-overapply-source");
        record_probe::save("runtime_call_ownership", &label, &emitted, &exe, &out);
        assert_eq!(
            out.status.code(),
            reference.status.code(),
            "{label}: {out:?}"
        );
        assert_eq!(out.stdout, reference.stdout, "{label}");
        assert_eq!(out.stderr, reference.stderr, "{label}");
    }
}

#[test]
fn owned_primitive_arguments_and_stack_captures_release_on_trap() {
    let dir = Scratch::new("primitive-stack");
    let src = dir.0.join("primitive.fwp");
    let cfile = dir.0.join("primitive.c");
    let exe = dir.0.join("primitive.exe");
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
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src),
    );

    checked(
        Command::new(fwp)
            .env_remove("FWP_NO_OPT")
            .env("FWP_STACK", "1")
            .args(["build", "--memory", "dynamic", "-O2"])
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(&cfile).unwrap();
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
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    size_t baseline=fwp_heap.live;
    for(int round=0;round<32;round++) {
    original_capture = fwp_rc_fresh(fwp_str_new("original", 8));
    trap_concat = 1; fwp_trap_recover = recover_primitive;
    if (!setjmp(primitive_trap)) { EXECUTE(original_capture); return 1; }
    fwp_trap_recover = 0; trap_concat = 0;
    if (strcmp(fwp_trap_msg, "owned primitive trap") || fwp_cleanups) return 2;
    if (*fwp_rc_slot(original_capture) != 0) return 3;
    ARC_BALANCE
    }
    fwp_trap_jb=NULL;
    puts("primitive arguments and stack captures release on trap");
    return 0;
}
"#.replace("EXECUTE", &execute);
    let probe = {
        probe.replace(
            "ARC_BALANCE",
            "if(fwp_heap.live!=baseline || fwp_heap.rc_wide_len)return 90;",
        )
    };
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
    let code = format!("static volatile int trap_concat;\n{runtime}\n{probe}");
    let cases = [("primitive", code, 0)];
    for opt in ["-O1", "-O2"] {
        for (label, code, status) in &cases {
            fwp::cgen::compile_c(code, &exe, opt).unwrap();

            let out = Command::new(&exe).output().unwrap();
            let label = format!("counted{opt}-{label}");
            record_probe::save("runtime_call_ownership", &label, code, &exe, &out);
            assert_eq!(out.status.code(), Some(*status), "{label}: {out:?}");
            assert!(out.stderr.is_empty(), "{label}: {out:?}");
            assert_eq!(
                String::from_utf8(out.stdout).unwrap().replace("\r\n", "\n"),
                if *status == 0 {
                    "primitive arguments and stack captures release on trap\n"
                } else {
                    ""
                },
                "{label}"
            );
        }
        let exe = dir.0.join(format!("counted{opt}-source.exe"));
        fwp::cgen::compile_c(&emitted, &exe, opt).unwrap();

        let out = Command::new(&exe).output().unwrap();
        let label = format!("counted{opt}-primitive-source");
        record_probe::save("runtime_call_ownership", &label, &emitted, &exe, &out);
        assert_eq!(
            out.status.code(),
            reference.status.code(),
            "{label}: {out:?}"
        );
        assert_eq!(out.stdout, reference.stdout, "{label}");
        assert_eq!(out.stderr, reference.stderr, "{label}");
    }
}

#[test]
fn cancelled_entry_releases_runtime_function_and_callee_parameters() {
    let dir = Scratch::new("cancelled-call");
    let src = dir.0.join("cancelled.fwp");
    let exe = dir.0.join("cancelled.exe");
    let source = SOURCE.replace("main = 0 | attempt (cap-error (\"owned\" | concat \" capture\")) | echo",
        "main = [task.yield (), 0 | attempt (cap-error (\"owned\" | concat \" capture\")) | echo] | ignore");
    std::fs::write(&src, source).unwrap();

    let emitted = exported_probe::generate(&src);
    let start = emitted
        .find("/* cap-error :")
        .expect("missing exported probe entry `cap-error`");
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
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    size_t baseline=fwp_heap.live;
    for(int round=0;round<32;round++) {
    memset(&cancelled_call,0,sizeof(cancelled_call));
    captured = fwp_rc_fresh(fwp_str_new("cancel capture", 14));
    function_value = fwp_rc_fresh(fwp_pap(FUNCTION, 1, (V[]){captured}));
    cancelled_call.cancelled = 1; fwp_cur = &cancelled_call; fwp_budget = 0;
    jmp_buf cancelled_call_base; cancelled_call.base = &cancelled_call_base;
    if (!setjmp(cancelled_call_base)) { fwp_apply_owned(function_value, 1, (V[]){0}); return 1; }
    cancelled_call.base = NULL; fwp_cur = 0;
    if (!cancelled_call.unwinding || fwp_cleanups) return 2;
    if (*fwp_rc_slot(function_value) || *fwp_rc_slot(captured)) return 4;
    ARC_BALANCE
    }
    puts("runtime function and incoming owners release on cancellation");
    return 0;
}
"#
    .replace("FUNCTION", id);
    let probe = {
        probe.replace(
            "ARC_BALANCE",
            "if(fwp_heap.live!=baseline || fwp_heap.rc_wide_len)return 90;",
        )
    };
    let runtime = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let cases = [("cancelled", format!("{runtime}\n{probe}"), 0)];
    for opt in ["-O1", "-O2"] {
        for (label, code, status) in &cases {
            fwp::cgen::compile_c(code, &exe, opt).unwrap();

            let out = Command::new(&exe).output().unwrap();
            let label = format!("counted{opt}-{label}");
            record_probe::save("runtime_call_ownership", &label, code, &exe, &out);
            assert_eq!(out.status.code(), Some(*status), "{label}: {out:?}");
            assert!(out.stderr.is_empty(), "{label}: {out:?}");
            assert_eq!(
                String::from_utf8(out.stdout).unwrap().replace("\r\n", "\n"),
                if *status == 0 {
                    "runtime function and incoming owners release on cancellation\n"
                } else {
                    ""
                },
                "{label}"
            );
        }
    }
}
