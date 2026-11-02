//! Fold accumulators and scratch storage release on nonlocal unwind.
use std::path::PathBuf;
use std::process::{Command, Output};

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
export direct : String -> List[String] -> String ! {Error[String]}
direct = fold-right step
export captured : String -> String -> List[String] -> String ! {Error[String]}
captured = step-cap | fold-right
export dynamic : (String -> String -> String ! {Error[String]}) -> String -> List[String] -> String ! {Error[String]}
dynamic = fold-right
scalar-step : I64 -> I64 -> I64 ! {Error[String]}
scalar-step = curry (if (.0 | eq 2) (const "expected" | fail) (.1 | add 1))
export scalar-run : I64 -> List[I64] -> I64 ! {Error[String]}
scalar-run = fold-right scalar-step
main = [task.yield (),
    [2, 1] | attempt (scalar-run 0) | echo,
    ["stop", "ok"] | attempt (direct "seed") | echo,
    ["stop", "ok"] | attempt (captured ("cap" | concat "!") "seed") | echo,
    ["stop", "ok"] | attempt (dynamic step "seed") | echo,
    ["a", "b"] | direct "seed" | echo,
] | ignore
"#;
// The C probes call these exports directly. An ordinary executable roots only
// main, so optimization may correctly remove the entry points they need.
fn probe_source() -> String {
    fwp::driver::with_big_stack(|| {
        let (compilation, program) = fwp::driver::compile_source(
            "fold-unwind.fwp",
            SOURCE,
            fwp::mono::Roots {
                main: true,
                exports: true,
                ..Default::default()
            },
        )
        .map_err(|error| error.rendered)
        .unwrap();
        assert!(
            compilation.warnings.is_empty(),
            "{}",
            compilation.render_warnings()
        );
        let emitted = fwp::cgen::generate(&program).unwrap();
        if let Some(root) = std::env::var_os("FWP_ARC_ARTIFACTS") {
            let directory = PathBuf::from(root).join("record-ownership/fold_unwind_source");
            std::fs::create_dir_all(&directory).unwrap();
            std::fs::write(directory.join("input.fwp"), SOURCE).unwrap();
            std::fs::write(directory.join("generated.c"), &emitted).unwrap();
        }
        emitted
    })
}
fn function_id<'a>(emitted: &'a str, name: &str) -> &'a str {
    let start = emitted
        .find(&format!("/* {name} :"))
        .unwrap_or_else(|| panic!("missing generated probe entry `{name}`"));
    emitted[start..]
        .split("static V f")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap()
}
#[test]
fn numeric_record_fold_releases_owners_on_trap_box_failure_and_cancellation() {
    let dir = Scratch::new("numeric-records");
    let src = dir.0.join("records.fwp");
    let cfile = dir.0.join("records.c");
    std::fs::write(&src, r#"
Point = {index: I64, value: F64}
step : Point -> Point -> Point
step = fn a -> fn b -> Point {index = (a | .index) + (b | .index), value = (a | .value) + (b | .value)}
export transform : Bool -> Point -> List[Point] -> Point ! {Async}
transform = fn pause -> fn seed -> fn values ->
    let ready = pause | match
        True -> task.yield ()
        False -> ()
    in fold step seed values
"#).unwrap();
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args([
                "build",
                "--fn",
                "transform",
                "--memory",
                "dynamic",
                "--emit-c",
            ])
            .arg(&src)
            .arg("-o")
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
    assert!(emitted.contains("#define FWP_UNWIND 1"));
    assert!(emitted.contains("#define FWP_TASK_TICKS 1"));
    let drop_name = |ty: &str| {
        let start = emitted
            .find(&format!("/* {ty} */\nstatic void fwp_drop"))
            .unwrap();
        emitted[start..]
            .split("static void ")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap()
    };
    let point_drop = drop_name("Point");
    let probe = include_str!("fixtures/record_fold_unwind.c")
        .replace(
            "TRANSFORM",
            &format!("f{}", function_id(&emitted, "transform")),
        )
        .replace("DROP_POINT", point_drop)
        .replace("DROP_LIST", drop_name("List[Point]"));
    let start = emitted.find("static V fwp_record_fold").unwrap();
    let end = start + emitted[start..].find("\n}\n").unwrap() + 3;
    let helper = &emitted[start..end];
    assert_eq!(helper.matches("        accumulator = w").count(), 1);
    let instrumented = helper.replace("        accumulator = w",
        "        record_fold_visits++;\n        if (record_fold_mode == 0 && record_fold_visits == 2) fwp_trap(\"injected callback failure\");\n        if (record_fold_mode == 2 && record_fold_visits == 2) { fwp_cur->cancelled = 1; fwp_budget = 0; }\n        accumulator = w")
        .replace("    return fwp_rc_fresh(fwp_record(",
            "    record_fold_fail_box = record_fold_mode == 1;\n    return fwp_rc_fresh(fwp_record(");
    let mut code = emitted[..emitted.find("int main(").unwrap()].replace(helper, &instrumented)
        .replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic int record_fold_mode, record_fold_visits, record_fold_fail_box;\nstatic void fwp_trap(const char *);");
    let allocation = "static inline void *fwp_alloc_init(size_t n) {";
    assert_eq!(code.matches(allocation).count(), 1);
    code = code.replace(allocation, &format!("{allocation}\n    if (record_fold_fail_box) fwp_trap(\"injected result allocation failure\");"));
    code += &probe;
    let missing_seed = code.replace(
        &format!("    {point_drop}(z);\n    while (xs)"),
        "    while (xs)",
    );
    assert_ne!(code, missing_seed);
    for opt in ["-O1", "-O2"] {
        for (name, source, expected) in
            [("ordinary", &code, 0), ("missing-seed", &missing_seed, 90)]
        {
            let exe = dir.0.join(format!("{name}-{opt}.exe"));
            fwp::cgen::compile_c(source, &exe, opt).unwrap();
            let output = Command::new(&exe).output().unwrap();
            record_probe::save(
                "record_fold_unwind",
                &format!("{name}-{opt}"),
                source,
                &exe,
                &output,
            );
            assert_eq!(
                output.status.code(),
                Some(expected),
                "{name}/{opt}: {output:?}"
            );
        }
    }
}

#[test]
fn right_fold_releases_accumulator_and_scratch_on_failure() {
    let dir = Scratch::new("failure");
    let src = dir.0.join("fold.fwp");
    let exe = dir.0.join("fold.exe");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(&src, SOURCE).unwrap();
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src),
    );
    {
        let emitted = probe_source();
        let probe = r#"
static volatile V input_seed, source_list, input_capture;
static int recover_fold(void) { return 1; }
static int dead_string(V v) {
 return *fwp_rc_slot(v)==0;
}
static int dead_scratch(V v) {
    size_t ci;
    heap_chunk *chunk = fwp_heap_chunk_of((uintptr_t)v, &ci);
    if (!chunk || chunk->type == HEAP_FREE) return 1;
    if (chunk->type != HEAP_SMALL) return 0;
    for (char *p = fwp_heap.lists[chunk->leaf][chunk->cls].free; p; p = (char *)~*(uintptr_t *)p)
        if (PTR(p) == v) return 1;
    return 0;
}
int main(void) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 253;
#endif
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    size_t baseline=fwp_heap.live;
    for(int round=0;round<32;round++){
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
    if(fwp_heap.live!=baseline || fwp_heap.rc_wide_len)return 90;
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
        for (name, element, accumulator, borrowed) in
            [("step", 0, 1, false), ("fold-right-fn", 1, 2, true)]
        {
            let id = function_id(&emitted, name);
            let entry = format!("static V fwp_owned_entry{id}(V *a) {{");
            assert_eq!(runtime.matches(&entry).count(), usize::from(!borrowed));
            if borrowed {
                // This callback has only direct borrowed uses: no owned adapter
                // remains. Observe the body that the captured fold actually calls.
                let marker = format!("/* borrowed fold callback for f{id}:");
                let (_, helper) = emitted.split_once(&marker).unwrap();
                let entry = helper.lines().nth(1).unwrap();
                assert!(entry.starts_with("static V fwp_borrowed_fold"));
                assert_eq!(runtime.matches(entry).count(), 1);
                runtime = runtime.replace(entry, &format!("{entry}\n    if (STR(args[{element}])->len == 4) observed_accumulator = args[{accumulator}];"));
            } else {
                runtime = runtime.replace(&entry,&format!("{entry}\n    if (STR(a[{element}])->len == 4) observed_accumulator = a[{accumulator}];"));
            }
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
        let cancelled_probe = probe.replace("static volatile V input_seed, source_list, input_capture;", "static volatile V input_seed, source_list, input_capture;\nstatic fwp_task fold_cancel;\nstatic void cancel_after_fold_result(void) { if (fwp_cur) { fwp_cur->cancelled = 1; fwp_budget = 0; } }").replace("        if (!setjmp(h.jb))", "        memset(&fold_cancel, 0, sizeof fold_cancel); fwp_cur = &fold_cancel; fwp_budget = 1000000;\n        jmp_buf fold_cancel_base; fold_cancel.base = &fold_cancel_base;\n        if (!setjmp(fold_cancel_base))").replace("        fwp_handlers = h.prev;", "        fold_cancel.base = NULL; fwp_cur = NULL; if (!fold_cancel.unwinding) return 7;\n        fwp_handlers = h.prev;");
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
            for (name, code, probe) in [
                ("callback-error", &runtime, &probe),
                ("scratch-error", &allocating, &allocation_probe),
                ("cancellation", &cancelled, &cancelled_probe),
                ("argument-error", &preparing, &preparation_probe),
            ] {
                let mut cases = vec![("normal", format!("{code}\n{probe}"), 0)];
                {
                    let missing = probe.replace("fwp_rc_free_obj(input_capture);", ";");
                    assert_ne!(missing, *probe);
                    cases.push(("missing-release", format!("{code}\n{missing}"), 90));
                }
                if name != "scratch-error" {
                    let start = code
                        .find("static void fwp_scratch_release(void *arg)")
                        .unwrap();
                    let end = start + code[start..].find("\n}").unwrap();
                    let release = "if (items) fwp_mem_free(items);";
                    assert_eq!(code[start..end].matches(release).count(), 1);
                    let missing = format!(
                        "{}{}{}",
                        &code[..start],
                        code[start..end].replace(release, ""),
                        &code[end..]
                    );
                    cases.push(("missing-scratch", format!("{missing}\n{probe}"), 4));
                }
                for (label, code, status) in cases {
                    fwp::cgen::compile_c(&code, &exe, opt).unwrap();
                    let artifacts = std::env::var_os("FWP_CALLBACK_CAPTURE_ARTIFACTS")
                        .map(|path| PathBuf::from(path).join("unwind"));
                    let stem = format!("{name}{opt}");
                    if label == "normal" {
                        if let Some(path) = &artifacts {
                            std::fs::create_dir_all(path).unwrap();
                            std::fs::write(path.join(format!("{stem}.c")), &code).unwrap();
                            std::fs::copy(&exe, path.join(format!("{stem}.exe"))).unwrap();
                        }
                    }
                    {
                        let out = Command::new(&exe).output().unwrap();
                        record_probe::save(
                            "fold_unwind_ownership",
                            &format!("counted{opt}-{name}-{label}"),
                            &code,
                            &exe,
                            &out,
                        );
                        if label == "normal" {
                            if let Some(path) = &artifacts {
                                let observation = format!("{stem}-0");
                                std::fs::write(
                                    path.join(format!("{observation}.stdout")),
                                    &out.stdout,
                                )
                                .unwrap();
                                std::fs::write(
                                    path.join(format!("{observation}.stderr")),
                                    &out.stderr,
                                )
                                .unwrap();
                                std::fs::write(
                                    path.join(format!("{observation}.status")),
                                    format!("{:?}\n", out.status.code()),
                                )
                                .unwrap();
                            }
                        }
                        assert_eq!(
                            out.status.code(),
                            Some(status),
                            "counted {opt} {name}/{label}: {out:?}"
                        );
                        assert!(
                            out.stderr.is_empty(),
                            "counted {opt} {name}/{label}: {out:?}"
                        );
                        let expected = if status == 0 {
                            &b"fold accumulator and scratch release on failure\n"[..]
                        } else {
                            &b""[..]
                        };
                        assert_eq!(out.stdout, expected);
                    }
                }
            }
            checked(
                Command::new(fwp)
                    .env("FWP_STACK", "1")
                    .args(["build", "--memory", "dynamic"])
                    .arg(&src)
                    .args([opt, "-o"])
                    .arg(&exe),
            );
            let out = checked(&mut Command::new(&exe));
            assert_eq!(out.stdout, reference.stdout);
        }
    }
}

#[test]
fn borrowed_prefix_duplicates_and_scalar_words_release_precisely() {
    let dir = Scratch::new("preparation");
    let exe = dir.0.join("preparation.exe");
    {
        let emitted = probe_source();
        let probe = r#"
static volatile V first, second, function_value, scalar_word;
static jmp_buf prepare_trap;
static int recover_prepare(void) { return 1; }
static fwp_obj scalar_tail = {1, 2, {1, 0}};
static fwp_obj scalar_head = {1, 2, {2, PTR(&scalar_tail)}};
int main(void) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 253;
#endif
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    size_t baseline=fwp_heap.live;
    for(int round=0;round<32;round++){
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
    if(fwp_heap.live!=baseline || fwp_heap.rc_wide_len)return 90;
    }
    puts("borrowed duplicates and scalar fold words retain exact ownership");
    return 0;
}
"#.replace("STEP",function_id(&emitted,"step")).replace("SCALAR",function_id(&emitted,"scalar-run"));
        let duplication = "fi->owned->arguments(args + before + transferred + i, c->n + before + transferred + i, 1);";
        assert_eq!(emitted.matches(duplication).count(), 1);
        let runtime = emitted.replace(duplication,"if (i == 1) fwp_trap(\"injected second borrowed duplicate failure\"); fi->owned->arguments(args + before + transferred + i, c->n + before + transferred + i, 1);").replace("int main(int argc, char **argv)","int original_main(int argc, char **argv)");
        for opt in ["-O1", "-O2"] {
            let mut cases = vec![("normal", probe.clone(), 0)];
            {
                let missing = probe.replace("fwp_rc_free_obj(scalar_word);", "");
                assert_ne!(missing, probe);
                cases.push(("missing-release", missing, 90));
            }
            for (label, probe, status) in cases {
                let code = format!("{runtime}\n{probe}");
                fwp::cgen::compile_c(&code, &exe, opt).unwrap();
                {
                    let out = Command::new(&exe).output().unwrap();
                    record_probe::save(
                        "fold_unwind_ownership",
                        &format!("counted{opt}-prefix-{label}"),
                        &code,
                        &exe,
                        &out,
                    );
                    assert_eq!(
                        out.status.code(),
                        Some(status),
                        "counted {opt} {label}: {out:?}"
                    );
                    assert!(out.stderr.is_empty(), "counted {opt} {label}: {out:?}");
                    let expected = if status == 0 {
                        &b"borrowed duplicates and scalar fold words retain exact ownership\n"[..]
                    } else {
                        &b""[..]
                    };
                    assert_eq!(out.stdout, expected);
                }
            }
        }
    }
}
