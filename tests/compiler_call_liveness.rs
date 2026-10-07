//! Live caller owners survive normal calls and release on nonlocal unwind.
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
        let p = std::env::temp_dir().join(format!("fwp-call-{}-{name}", std::process::id()));
        std::fs::create_dir_all(&p).unwrap();
        Self(p)
    }
}
impl Drop for Scratch {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}

const SOURCE: &str = r#"guard : I64 -> I64 ! {Error[String]}
guard = if (eq 0) (const "expected" | fail) (add 1)
hold : (I64 -> I64 ! {Error[String]}) -> String -> String ! {Error[String]}
hold = curry (both (.0 | apply 0) .1 | .1)
main = "owned" | concat " input" | attempt (hold guard) | echo
"#;
#[test]
fn actual_caller_releases_owned_values_and_preserves_aliases() {
    let dir = Scratch::new("caller");
    let src = dir.0.join("caller.fwp");
    let cfile = dir.0.join("caller.c");
    let exe = dir.0.join("caller");
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
    let wrapper = |name: &str| {
        let start = emitted.find(&format!("/* {name} :")).unwrap();
        let suffix = emitted[start..]
            .split("static V f")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap();
        format!("f{suffix}")
    };
    let probe = r#"
static volatile int fail_call;
static volatile V input_value;
static V caller_entry(V *args) { return fail_call ? GUARD(args[0]) : (V)7; }
static const fwp_fninfo caller_fns[] = {{1, caller_entry, "caller probe", 0}};
static fwp_clo caller_fn = {0, 0};
static int released(V v) { return fwp_reuse_verify ? STR(v)->len == 0 : *fwp_rc_slot(v) == 0; }
int main(void) {
    fwp_gc_start(__builtin_frame_address(0)); fwp_init_consts(); fwp_fns = caller_fns;
    input_value = fwp_rc_fresh(fwp_str_new("normal", 6));
    if (HOLD(PTR(&caller_fn), input_value) != input_value || fwp_cleanups ||
        *fwp_rc_slot(input_value) != 1) return 1;
    if (!fwp_rc_release_last(input_value)) return 2;
    fwp_mem_free((void *)(uintptr_t)input_value);
    for (int alias = 0; alias < 2; alias++) {
        input_value = fwp_rc_fresh(fwp_str_new("retained", 8));
        if (alias) fwp_rc_dup(input_value);
        double before = fwp_gc.freed;
        fwp_handler h;
        h.prev = fwp_handlers; h.state_depth = fwp_state_len; h.cleanup = fwp_cleanups;
        fwp_handlers = &h; fail_call = 1;
        if (!setjmp(h.jb)) { HOLD(PTR(&caller_fn), input_value); return 3; }
        fwp_handlers = h.prev; fail_call = 0;
        if (fwp_cleanups) return 4;
        if (alias) {
            if (*fwp_rc_slot(input_value) != 1 || STR(input_value)->len != 8 ||
                memcmp(STR(input_value)->d, "retained", 8)) return 5;
            if (!fwp_rc_release_last(input_value)) return 6;
            fwp_mem_free((void *)(uintptr_t)input_value);
        } else {
            if (!released(input_value)) return 7;
            if (!fwp_reuse_verify && fwp_gc.freed <= before) return 8;
        }
    }
    puts("live caller owners release exactly once");
    return 0;
}
"#
    .replace("GUARD", &wrapper("guard"))
    .replace("HOLD", &wrapper("hold"));
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
            assert_eq!(out.stdout, b"live caller owners release exactly once\n");
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
fn earlier_argument_is_released_when_later_argument_fails() {
    let dir = Scratch::new("arguments");
    let src = dir.0.join("arguments.fwp");
    let cfile = dir.0.join("arguments.c");
    let exe = dir.0.join("arguments");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(
        &src,
        r#"guard : I64 -> String ! {Error[String]}
guard = if (eq 0) (const "expected" | fail) show
pair : (I64 -> String ! {Error[String]}) -> I64 -> (String, String) ! {Error[String]}
pair = curry (both (fork apply .1 .0) (fork apply (const 0) .0))
main = 2 | attempt (pair guard) | echo
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
    let wrapper = |name: &str| {
        let start = emitted.find(&format!("/* {name} :")).unwrap();
        let suffix = emitted[start..]
            .split("static V f")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap();
        format!("f{suffix}")
    };
    let probe = r#"
static volatile V first_argument;
static V argument_entry(V *args) {
    if (!args[0]) return GUARD(args[0]);
    first_argument = fwp_rc_fresh(fwp_str_new("first", 5));
    return first_argument;
}
static const fwp_fninfo argument_fns[] = {{1, argument_entry, "argument probe", 0}};
static fwp_clo argument_fn = {0, 0};
int main(void) {
    fwp_gc_start(__builtin_frame_address(0)); fwp_init_consts(); fwp_fns = argument_fns;
    fwp_handler h;
    h.prev = fwp_handlers; h.state_depth = fwp_state_len; h.cleanup = fwp_cleanups;
    fwp_handlers = &h;
    if (!setjmp(h.jb)) { PAIR(PTR(&argument_fn), 2); return 1; }
    fwp_handlers = h.prev;
    if (!first_argument || fwp_cleanups) return 2;
    if (fwp_reuse_verify ? STR(first_argument)->len != 0 : *fwp_rc_slot(first_argument) != 0) return 3;
    puts("pending arguments release on later failure");
    return 0;
}
"#.replace("GUARD", &wrapper("guard")).replace("PAIR", &wrapper("pair"));
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
            assert_eq!(out.stdout, b"pending arguments release on later failure\n");
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
fn boxed_wrapper_and_unboxed_worker_release_separate_owners() {
    let dir = Scratch::new("worker");
    let src = dir.0.join("worker.fwp");
    let cfile = dir.0.join("worker.c");
    let exe = dir.0.join("worker");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let source = format!(
        "Box = {{ text: String }}\n{}",
        SOURCE
            .replace("-> String -> String !", "-> Box -> String !")
            .replace("both (.0 | apply 0) .1", "both (.0 | apply 0) (.1 | .text)")
            .replace(
                "main = \"owned\" | concat \" input\"",
                "main = Box { text = \"owned\" | concat \" input\" }"
            )
    );
    std::fs::write(&src, source).unwrap();
    let reference = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
    let wrapper = |name: &str| {
        let start = emitted.find(&format!("/* {name} :")).unwrap();
        let suffix = emitted[start..]
            .split("static V f")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap();
        format!("f{suffix}")
    };
    assert!(emitted.contains("fwp_cleanup_push(&cleanup, fwp_owner_release"));
    let probe = r#"
static volatile V boxed_input, text_input;
static V worker_entry(V *args) { return GUARD(args[0]); }
static const fwp_fninfo worker_fns[] = {{1, worker_entry, "worker probe", 0}};
static fwp_clo worker_fn = {0, 0};
int main(void) {
    fwp_gc_start(__builtin_frame_address(0)); fwp_init_consts(); fwp_fns = worker_fns;
    text_input = fwp_rc_fresh(fwp_str_new("child", 5));
    boxed_input = fwp_rc_fresh(fwp_record(1, (V[]){text_input}));
    fwp_handler h;
    h.prev = fwp_handlers; h.state_depth = fwp_state_len; h.cleanup = fwp_cleanups;
    fwp_handlers = &h;
    if (!setjmp(h.jb)) { HOLD(PTR(&worker_fn), boxed_input); return 1; }
    fwp_handlers = h.prev;
    if (fwp_cleanups) return 2;
    if (fwp_reuse_verify) {
        if (OBJ(boxed_input)->tag != 0xdead || STR(text_input)->len != 0) return 3;
    } else if (*fwp_rc_slot(boxed_input) || *fwp_rc_slot(text_input)) return 4;
    puts("wrapper and worker owners release exactly once");
    return 0;
}
"#
    .replace("GUARD", &wrapper("guard"))
    .replace("HOLD", &wrapper("hold"));
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
                b"wrapper and worker owners release exactly once\n"
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
fn incoming_parameters_release_before_cancelled_entry_tick() {
    let dir = Scratch::new("cancel-entry");
    let src = dir.0.join("entry.fwp");
    let cfile = dir.0.join("entry.c");
    let exe = dir.0.join("entry");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let source = SOURCE.replace("main = \"owned\" | concat \" input\" | attempt (hold guard) | echo",
        "main = [task.yield (), \"owned\" | concat \" input\" | attempt (hold guard) | echo] | ignore");
    std::fs::write(&src, source).unwrap();
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
    let start = emitted.find("/* hold :").unwrap();
    let hold = format!(
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
static volatile V incoming;
static volatile int entered_callback;
static V entry_callback(V *args) { (void)args; entered_callback++; return 7; }
static const fwp_fninfo entry_fns[] = {{1, entry_callback, "entry probe", 0}};
static fwp_clo entry_fn = {0, 0};
static fwp_task cancelled_task;
int main(void) {
    fwp_gc_start(__builtin_frame_address(0)); fwp_init_consts(); fwp_fns = entry_fns;
    incoming = fwp_rc_fresh(fwp_str_new("incoming", 8));
    cancelled_task.cancelled = 1;
    fwp_cur = &cancelled_task;
    fwp_budget = 0;
    if (!setjmp(cancelled_task.base)) { HOLD(PTR(&entry_fn), incoming); return 1; }
    fwp_cur = 0;
    if (entered_callback || fwp_cleanups || !cancelled_task.unwinding) return 2;
    if (fwp_reuse_verify ? STR(incoming)->len != 0 : *fwp_rc_slot(incoming) != 0) return 3;
    puts("incoming owners release before cancellation");
    return 0;
}
"#
    .replace("HOLD", &hold);
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
            assert_eq!(out.stdout, b"incoming owners release before cancellation\n");
        }
    }
}

#[test]
fn struct_variant_owner_releases_its_typed_payload() {
    let dir = Scratch::new("variant");
    let src = dir.0.join("variant.fwp");
    let cfile = dir.0.join("variant.c");
    let exe = dir.0.join("variant");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(
        &src,
        r#"Wrapped = | Empty | Wrapped String
guard : I64 -> I64 ! {Error[String]}
guard = if (eq 0) (const "expected" | fail) (add 1)
choose : String -> Wrapped
choose = if (string.length | eq 0) (const Empty) Wrapped
hold : (I64 -> I64 ! {Error[String]}) -> String -> String ! {Error[String]}
hold = curry (both (.1 | choose) (.0 | apply 0) | .0 | match
    Empty -> ""
    Wrapped _ -> id)
main = "owned" | concat " input" | attempt (hold guard) | echo
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
    let wrapper = |name: &str| {
        let start = emitted.find(&format!("/* {name} :")).unwrap();
        format!(
            "f{}",
            emitted[start..]
                .split("static V f")
                .nth(1)
                .unwrap()
                .split('(')
                .next()
                .unwrap()
        )
    };
    assert!(
        emitted.contains("fwp_u1 v0;"),
        "fixture must exercise a struct variant cleanup owner"
    );
    let probe = r#"
static volatile V payload;
static V variant_entry(V *args) { return GUARD(args[0]); }
static const fwp_fninfo variant_fns[] = {{1, variant_entry, "variant probe", 0}};
static fwp_clo variant_fn = {0, 0};
int main(void) {
    fwp_gc_start(__builtin_frame_address(0)); fwp_init_consts(); fwp_fns = variant_fns;
    payload = fwp_rc_fresh(fwp_str_new("payload", 7));
    fwp_handler h;
    h.prev = fwp_handlers; h.state_depth = fwp_state_len; h.cleanup = fwp_cleanups;
    fwp_handlers = &h;
    if (!setjmp(h.jb)) { HOLD(PTR(&variant_fn), payload); return 1; }
    fwp_handlers = h.prev;
    if (fwp_cleanups) return 2;
    if (fwp_reuse_verify ? STR(payload)->len != 0 : *fwp_rc_slot(payload) != 0) return 3;
    puts("struct variant payload releases on unwind");
    return 0;
}
"#
    .replace("GUARD", &wrapper("guard"))
    .replace("HOLD", &wrapper("hold"));
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
            assert_eq!(out.stdout, b"struct variant payload releases on unwind\n");
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
    // Normal transfer must also preserve the payload through the new struct
    // moves, including the nullary branch where there is no payload to count.
    let original = std::fs::read_to_string(&src).unwrap();
    for text in ["owned", ""] {
        let normal = original
            .replace("(.0 | apply 0)", "(.0 | apply 1)")
            .replace(
                "\"owned\" | concat \" input\"",
                &format!("\"{text}\" | concat \"\""),
            );
        std::fs::write(&src, normal).unwrap();
        let reference = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
        checked(
            Command::new(fwp)
                .arg("build")
                .arg(&src)
                .args(["-O2", "-o"])
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
