//! Completed map results and scratch storage release on nonlocal unwind.
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
        let p = std::env::temp_dir().join(format!("fwp-fold-unwind-{}-{name}", std::process::id()));
        std::fs::create_dir_all(&p).unwrap();
        Self(p)
    }
}
impl Drop for Scratch {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}

const SOURCE: &str = r#"step : String -> String -> String ! {Error[String]}
step = curry (if (.0 | eq "stop") (const "expected" | fail) (fork concat .0 .1))
step-cap : String -> String -> String -> String ! {Error[String]}
step-cap = curry3 (if (.1 | eq "stop") (const "expected" | fail) (fork concat .0 (fork concat .1 .2)))
direct : String -> List[String] -> String ! {Error[String]}
direct = fold-right step
captured : String -> String -> List[String] -> String ! {Error[String]}
captured = step-cap | fold-right
dynamic : (String -> String -> String ! {Error[String]}) -> String -> List[String] -> String ! {Error[String]}
dynamic = fold-right
scalar-step : I64 -> I64 -> I64 ! {Error[String]}
scalar-step = curry (if (.0 | eq 2) (const "expected" | fail) (.1 | add 1))
scalar-run : I64 -> List[I64] -> I64 ! {Error[String]}
scalar-run = fold-right scalar-step
main = [task.yield (),
    [2, 1] | attempt (scalar-run 0) | echo,
    ["stop", "ok"] | attempt (direct "seed") | echo,
    ["stop", "ok"] | attempt (captured ("cap" | concat "!") "seed") | echo,
    ["stop", "ok"] | attempt (dynamic step "seed") | echo,
    ["a", "b"] | direct "seed" | echo,
] | ignore
"#;
fn function_id<'a>(emitted: &'a str, name: &str) -> &'a str {
    let start = emitted.find(&format!("/* {name} :")).unwrap();
    emitted[start..]
        .split("static V f")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap()
}
#[test]
fn right_fold_releases_accumulator_and_scratch_on_failure() {
    let dir = Scratch::new("failure");
    let src = dir.0.join("fold.fwp");
    let cfile = dir.0.join("fold.c");
    let exe = dir.0.join("fold");
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
    let probe = r#"
static volatile V input_seed, source_list, input_capture;
static int recover_fold(void) { return 1; }
static int dead_string(V v) { return fwp_reuse_verify ? STR(v)->len == 0 : *fwp_rc_slot(v) == 0; }
static int dead_scratch(V v) {
    gc_chunk *chunk = fwp_gc_chunk_of((uintptr_t)v, NULL);
    if (!chunk || chunk->type == GC_FREE) return 1;
    if (chunk->type != GC_SMALL) return 0;
    for (char *p = fwp_gc.lists[chunk->leaf][chunk->cls].free; p; p = (char *)~*(uintptr_t *)p)
        if (PTR(p) == v) return 1;
    return 0;
}
int main(void) {
    fwp_gc_start(__builtin_frame_address(0)); fwp_fns = fwp_fn_table; fwp_init_consts();
    for (volatile int mode = 0; mode < 3; mode++) {
        input_seed = fwp_rc_fresh(fwp_str_new("seed", 4));
        input_capture = fwp_rc_fresh(fwp_str_new("cap", 3));
        V stop = fwp_rc_fresh(fwp_str_new("stop", 4));
        V ok = fwp_rc_fresh(fwp_str_new("ok", 2));
        V tail = fwp_rc_fresh(fwp_data(1, 2, (V[]){ok, 0}));
        source_list = fwp_rc_fresh(fwp_data(1, 2, (V[]){stop, tail}));
        observed_scratch = 0; observed_accumulator = 0;
        fwp_handler h;
        h.prev = fwp_handlers; h.state_depth = fwp_state_len; h.cleanup = fwp_cleanups;
        fwp_handlers = &h; fwp_trap_recover = recover_fold; fwp_trap_jb = &h.jb; fwp_trap_cleanup = h.cleanup;
        if (!setjmp(h.jb)) {
            if (mode == 0) fDIRECT(input_seed, source_list);
            else if (mode == 1) fCAPTURED(input_capture, input_seed, source_list);
            else fDYNAMIC(PTR(&fcSTEP), input_seed, source_list);
            return 1;
        }
        fwp_handlers = h.prev; fwp_trap_recover = NULL; fwp_trap_jb = NULL;
        if (fwp_cleanups || !dead_string(input_seed)) return 2;
        if (!observed_accumulator || !dead_string(observed_accumulator)) return 3;
        if (!observed_scratch || !dead_scratch(observed_scratch)) return 4;
        if (!dead_string(stop) || !dead_string(ok)) return 5;
        if (mode == 1) { if (!dead_string(input_capture)) return 6; }
        else fwp_rc_free_obj(input_capture);
    }
    puts("fold accumulator and scratch release on failure");
    return 0;
}
"#.replace("DIRECT", function_id(&emitted,"direct")).replace("CAPTURED",function_id(&emitted,"captured")).replace("DYNAMIC",function_id(&emitted,"dynamic")).replace("STEP",function_id(&emitted,"step"));
    let marker = "static void fwp_value_release(void *arg) {";
    let mut runtime = emitted
        .replace(
            marker,
            "static volatile V observed_accumulator;\nstatic void fwp_value_release(void *arg) {",
        )
        .replace(
            "static void fwp_scratch_release(void *arg) {",
            "static volatile V observed_scratch;\nstatic void fwp_scratch_release(void *arg) {",
        )
        .replace(
            "    V *items = *slot;",
            "    V *items = *slot; observed_scratch = PTR(items);",
        )
        .replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        );
    for (name, element, accumulator) in [("step", 0, 1), ("fold-right-fn", 1, 2)] {
        let id = function_id(&emitted, name);
        let entry = format!("static V fwp_owned_entry{id}(V *a) {{");
        assert_eq!(runtime.matches(&entry).count(), 1);
        runtime = runtime.replace(&entry,&format!("{entry}\n    if (STR(a[{element}])->len == 4) observed_accumulator = a[{accumulator}];"));
    }
    let allocation = "    V *a = (V *)fwp_mem_alloc((*n + 1) * sizeof(V));";
    assert_eq!(runtime.matches(allocation).count(), 1);
    let allocating = runtime.replace(allocation,"    fwp_trap(\"injected fold scratch allocation failure\");\n    V *a = (V *)fwp_mem_alloc((*n + 1) * sizeof(V));");
    let allocation_probe = probe
        .replace(
            "if (!observed_accumulator || !dead_string(observed_accumulator))",
            "if (observed_accumulator)",
        )
        .replace(
            "if (!observed_scratch || !dead_scratch(observed_scratch))",
            "if (observed_scratch)",
        );
    let mut cancelled = "static void cancel_after_fold_result(void);\n".to_string() + &runtime;
    for update in [
        "owner.value = fwp_apply_borrowed_span(f, 2, args, 1, 1);",
        "owner.value = f(a[i - 1], next);",
        "owner.value = z;",
    ] {
        assert!(cancelled.contains(update));
        cancelled = cancelled.replace(update, &format!("{update} cancel_after_fold_result();"));
    }
    let cancelled_probe = probe.replace("static volatile V input_seed, source_list, input_capture;", "static volatile V input_seed, source_list, input_capture;\nstatic fwp_task fold_cancel;\nstatic void cancel_after_fold_result(void) { if (fwp_cur) { fwp_cur->cancelled = 1; fwp_budget = 0; } }").replace("        if (!setjmp(h.jb))", "        memset(&fold_cancel, 0, sizeof fold_cancel); fwp_cur = &fold_cancel; fwp_budget = 1000000;\n        if (!setjmp(fold_cancel.base))").replace("        fwp_handlers = h.prev;", "        fwp_cur = NULL; if (!fold_cancel.unwinding) return 7;\n        fwp_handlers = h.prev;");
    let preparing = runtime.replace(
        "fi->owned->arguments(args + i, c->n + i, 1);",
        "fwp_trap(\"injected borrowed argument preparation failure\");",
    );
    assert_ne!(preparing, runtime);
    let preparation_probe = probe
        .replace("mode = 0; mode < 3", "mode = 2; mode < 3")
        .replace(
            "if (!observed_accumulator || !dead_string(observed_accumulator))",
            "if (observed_accumulator)",
        );
    for opt in ["-O1", "-O2"] {
        for (code, probe) in [
            (&runtime, &probe),
            (&allocating, &allocation_probe),
            (&cancelled, &cancelled_probe),
            (&preparing, &preparation_probe),
        ] {
            fwp::cgen::compile_c(&format!("{code}\n{probe}"), &exe, opt).unwrap();
            for poison in ["0", "1"] {
                let out = checked(
                    Command::new(&exe)
                        .env("FWP_GC_STRESS", "1")
                        .env("FWP_GC_VERIFY", "1")
                        .env("FWP_REUSE_VERIFY", poison),
                );
                assert_eq!(
                    out.stdout,
                    b"fold accumulator and scratch release on failure\n"
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
fn borrowed_prefix_duplicates_and_scalar_words_release_precisely() {
    let dir = Scratch::new("preparation");
    let src = dir.0.join("preparation.fwp");
    let cfile = dir.0.join("preparation.c");
    let exe = dir.0.join("preparation");
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
    let probe = r#"
static volatile V first, second, function_value, scalar_word;
static jmp_buf prepare_trap;
static int recover_prepare(void) { return 1; }
static fwp_obj scalar_tail = {1, 2, {1, 0}};
static fwp_obj scalar_head = {1, 2, {2, PTR(&scalar_tail)}};
int main(void) {
    fwp_gc_start(__builtin_frame_address(0)); fwp_fns = fwp_fn_table; fwp_init_consts();
    first = fwp_rc_fresh(fwp_str_new("first",5)); second = fwp_rc_fresh(fwp_str_new("second",6));
    function_value = fwp_rc_fresh(fwp_pap(STEP,0,NULL));
    fwp_trap_recover = recover_prepare; fwp_trap_jb = &prepare_trap; fwp_trap_cleanup = 0;
    if (!setjmp(prepare_trap)) { fwp_apply_borrowed(function_value,2,(V[]){first,second}); return 1; }
    fwp_trap_recover = NULL; fwp_trap_jb = NULL;
    if (fwp_cleanups || *fwp_rc_slot(first)!=1 || *fwp_rc_slot(second)!=1 || *fwp_rc_slot(function_value)!=1) return 2;
    if (STR(first)->len!=5 || STR(second)->len!=6) return 3;
    fwp_closure_drop(function_value); fwp_rc_free_obj(first); fwp_rc_free_obj(second);
    scalar_word = fwp_rc_fresh(fwp_str_new("scalar bits",11));
    fwp_handler h;
    h.prev=fwp_handlers; h.state_depth=fwp_state_len; h.cleanup=fwp_cleanups; fwp_handlers=&h;
    if (!setjmp(h.jb)) { fSCALAR(scalar_word,PTR(&scalar_head)); return 4; }
    fwp_handlers=h.prev;
    if (fwp_cleanups || *fwp_rc_slot(scalar_word)!=1 || STR(scalar_word)->len!=11 || memcmp(STR(scalar_word)->d,"scalar bits",11)) return 5;
    fwp_rc_free_obj(scalar_word);
    puts("borrowed duplicates and scalar fold words retain exact ownership");
    return 0;
}
"#.replace("STEP",function_id(&emitted,"step")).replace("SCALAR",function_id(&emitted,"scalar-run"));
    let duplication = "fi->owned->arguments(args + before + transferred + i, c->n + before + transferred + i, 1);";
    assert_eq!(emitted.matches(duplication).count(), 1);
    let runtime = emitted.replace(duplication,"if (i == 1) fwp_trap(\"injected second borrowed duplicate failure\"); fi->owned->arguments(args + before + transferred + i, c->n + before + transferred + i, 1);").replace("int main(int argc, char **argv)","int original_main(int argc, char **argv)");
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
                b"borrowed duplicates and scalar fold words retain exact ownership\n"
            );
        }
    }
}
