//! Raw interpreter oracles, tracked effects, and bounded-stack traversal for
//! direct consumers. Golden suites separately cover ownership checks and reuse.
use fwp::driver::check_source;
use fwp::ir::{Body, Expr, Func, Pat, Program, TypeShape, MT};
use fwp::value::Value;
use std::path::Path;
use std::process::Command;

#[path = "support/ownership_ledger.rs"]
mod ownership_ledger;
#[path = "support/record_probe.rs"]
mod record_probe;

#[test]
fn final_iteration_releases_numeric_states_and_removes_only_unused_history() {
    let directory = fwp::cgen::TempDir::new("fwp-final-iteration-owners").unwrap();
    let scalar = MT::con("std::F64");
    let states = [
        (
            "scalar",
            scalar.clone(),
            r#"
static V iteration_new_state(int seed) { return UINT64_C(0xfff8000000000042) + seed; }
static int iteration_check_state(V value, int seed) { return value == iteration_new_state(seed); }
"#,
        ),
        (
            "quad",
            MT::con("std::F128"),
            r#"
static V iteration_new_state(int seed) {
    float128_t bits = {{UINT64_C(0x123456789abcdef0) + seed, UINT64_C(0xffff000000000000)}};
    return fwp_rc_fresh(fwp_box_f128(bits));
}
static int iteration_check_state(V value, int seed) {
    float128_t bits = fwp_f128(value);
    return bits.v[0] == UINT64_C(0x123456789abcdef0) + seed && bits.v[1] == UINT64_C(0xffff000000000000);
}
"#,
        ),
        (
            "list",
            MT::Con("std::List".into(), vec![scalar.clone()]),
            r#"
static V iteration_new_state(int seed) {
    V result = 0;
    for (int i = 2; i >= 0; i--) result = fwp_rc_fresh(fwp_cons(UINT64_C(0xfff8000000000042) + seed + i, result));
    return result;
}
static int iteration_check_state(V value, int seed) {
    for (int i = 0; i < 3; i++) {
        if (!value || OBJ(value)->f[0] != UINT64_C(0xfff8000000000042) + seed + i) return 0;
        value = OBJ(value)->f[1];
    }
    return value == 0;
}
"#,
        ),
        (
            "array",
            MT::Con("std::Array".into(), vec![scalar]),
            r#"
static const fwp_desc iteration_scalar = {.kind = K_F64};
static V iteration_new_state(int seed) {
    V result = fwp_array_typed_new(iteration_sliced ? 7 : 3, &iteration_scalar);
    for (int i = 0; i < (iteration_sliced ? 7 : 3); i++)
        fwp_array_store(result, i, UINT64_C(0xfff8000000000042) + seed + i - iteration_sliced, &iteration_scalar);
    if (iteration_sliced) {
        V view = fwp_p_array_slice_typed(1, 3, result, NULL, &iteration_scalar);
        fwp_fn_table[4].owned->drop_arguments(&result, 0, 1);
        result = view;
    }
    return result;
}
static int iteration_check_state(V value, int seed) {
    if (fwp_array_len(value) != 3) return 0;
    for (int i = 0; i < 3; i++)
        if (fwp_array_load(value, i, &iteration_scalar) != UINT64_C(0xfff8000000000042) + seed + i) return 0;
    return 1;
}
"#,
        ),
    ];
    let mut failures = Vec::new();
    for (name, state, construction) in states {
        let integer = MT::con("std::I64");
        let list = MT::Con("std::List".into(), vec![state.clone()]);
        let option = MT::Con("std::Option".into(), vec![state.clone()]);
        let callback = MT::Fun(Box::new(state.clone()), Box::new(state.clone()));
        let producer = MT::Fun(
            Box::new(integer.clone()),
            Box::new(MT::Fun(
                Box::new(callback.clone()),
                Box::new(MT::Fun(Box::new(state.clone()), Box::new(list.clone()))),
            )),
        );
        let entry = MT::Fun(
            Box::new(integer.clone()),
            Box::new(MT::Fun(
                Box::new(callback.clone()),
                Box::new(MT::Fun(Box::new(state.clone()), Box::new(option.clone()))),
            )),
        );
        let consumer = MT::Fun(Box::new(list.clone()), Box::new(option.clone()));
        let capture = MT::Fun(Box::new(state.clone()), Box::new(callback.clone()));
        let discard = MT::Fun(Box::new(option.clone()), Box::new(MT::unit()));
        let mut program = Program::default();
        program.shapes.insert(
            option.clone(),
            TypeShape::Adt(vec![
                ("None".into(), vec![]),
                ("Some".into(), vec![state.clone()]),
            ]),
        );
        program.funcs = vec![
            Func {
                name: "iterate".into(),
                arity: 3,
                locals: vec![integer.clone(), callback.clone(), state.clone()],
                ty: producer,
                body: Body::Prim("iterate".into()),
            },
            Func {
                name: "last".into(),
                arity: 1,
                locals: vec![list.clone()],
                ty: consumer.clone(),
                body: Body::Prim("last".into()),
            },
            Func {
                name: "final".into(),
                arity: 3,
                locals: vec![integer, callback.clone(), state.clone()],
                ty: entry.clone(),
                body: Body::Expr(Expr::Call(
                    1,
                    vec![Expr::Call(
                        0,
                        vec![Expr::Local(0), Expr::Local(1), Expr::Local(2)],
                    )],
                )),
            },
            Func {
                name: "main".into(),
                arity: 0,
                locals: vec![],
                ty: MT::Record(vec![
                    ("0".into(), entry),
                    ("1".into(), callback.clone()),
                    ("2".into(), discard.clone()),
                    ("3".into(), capture.clone()),
                ]),
                body: Body::Expr(Expr::Record(vec![
                    Expr::Func(2),
                    Expr::Func(4),
                    Expr::Func(6),
                    Expr::Func(7),
                ])),
            },
            Func {
                name: "step".into(),
                arity: 1,
                locals: vec![state.clone(), MT::unit()],
                ty: callback,
                body: Body::Expr(Expr::Let(
                    1,
                    Box::new(Expr::Call(5, vec![Expr::Const(Value::unit())])),
                    Box::new(Expr::Local(0)),
                )),
            },
            Func {
                name: "checkpoint".into(),
                arity: 1,
                locals: vec![MT::unit()],
                ty: MT::Fun(Box::new(MT::unit()), Box::new(MT::unit())),
                body: Body::Prim("task.yield".into()),
            },
            Func {
                name: "discard".into(),
                arity: 1,
                locals: vec![option],
                ty: discard,
                body: Body::Expr(Expr::Const(Value::unit())),
            },
            Func {
                name: "capture".into(),
                arity: 2,
                locals: vec![state.clone(), state.clone(), MT::unit()],
                ty: capture,
                body: Body::Expr(Expr::Let(
                    2,
                    Box::new(Expr::Call(5, vec![Expr::Const(Value::unit())])),
                    Box::new(Expr::Local(0)),
                )),
            },
            Func {
                name: "reverse".into(),
                arity: 1,
                locals: vec![list.clone()],
                ty: MT::Fun(Box::new(list.clone()), Box::new(list.clone())),
                body: Body::Prim("reverse".into()),
            },
            Func {
                name: "head".into(),
                arity: 1,
                locals: vec![list, state],
                ty: consumer,
                body: Body::Expr(Expr::Match(
                    Box::new(Expr::Local(0)),
                    vec![
                        (Pat::Construct(0, vec![]), Expr::Construct(0, vec![])),
                        (
                            Pat::Construct(1, vec![Pat::Bind(1), Pat::Wild]),
                            Expr::Construct(1, vec![Expr::Local(1)]),
                        ),
                    ],
                )),
            },
        ];
        program.main = Some(3);
        for (mode, spines) in [("old", 2), ("direct", 1), ("selected", 0)] {
            let mut current = program.clone();
            if mode == "old" {
                current.funcs[1].body =
                    Body::Expr(Expr::Call(9, vec![Expr::Call(8, vec![Expr::Local(0)])]));
            } else if mode == "selected" {
                fwp::fuse::fuse(&mut current);
                assert!(current
                    .funcs
                    .iter()
                    .any(|f| matches!(&f.body, Body::Prim(s) if s == "list._iterate-last")));
            }
            fwp::ir::check_locals(&current).unwrap();
            let code = fwp::cgen::generate(&current).unwrap();
            assert!(code.contains("#define FWP_UNWIND 1"));
            let code = code.replace(
                "int main(int argc, char **argv)",
                "int original_main(int argc, char **argv)",
            );
            let code = ownership_ledger::instrument_native(&code, 1024);
            // Keep generated callback owner scopes; replace only their yield primitive.
            let start = code.find("static V f5(V l0) {\n").unwrap();
            let end = start + code[start..].find("\n}").unwrap() + 2;
            let mut code = code;
            code.replace_range(
                start..end,
                "static V f5(V l0) { return iteration_checkpoint(l0); }",
            );
            let code = code.replacen(
                "typedef uint64_t V;",
                "typedef uint64_t V;\nstatic V iteration_checkpoint(V unit);",
                1,
            );
            let layouts: &[bool] = if name == "array" {
                &[false, true]
            } else {
                &[true]
            };
            for &packed in layouts {
                let code = if name == "array" {
                    let marker = if code.contains("#define FWP_PACKED_ARRAYS 1") {
                        "#define FWP_PACKED_ARRAYS 1"
                    } else {
                        "#define FWP_PACKED_ARRAYS 0"
                    };
                    assert_eq!(code.matches(marker).count(), 1);
                    code.replace(
                        marker,
                        &format!("#define FWP_PACKED_ARRAYS {}", u8::from(packed)),
                    )
                } else {
                    code.clone()
                };
                for reuse in [false, true] {
                    let emitted = format!(
                    "{}\n{code}\n#define ITERATION_SPINES {spines}\n#define ITERATION_ARRAY {}\n#define ITERATION_COUNT_SCALAR {}\nstatic int iteration_sliced;\n{construction}\n{}",
                    if reuse { "" } else { "#define FWP_NO_REUSE 1" },
                    u8::from(name == "array"),
                    u8::from(name == "scalar"),
                    include_str!("fixtures/final_iteration_ownership.c")
                );
                    for opt in ["-O1", "-O2"] {
                        let binary = directory.join("owners.exe");
                        fwp::cgen::compile_c(&emitted, &binary, opt).unwrap();
                        for (control, status) in [("complete", 0), ("missing-release", 90)] {
                            let observed = Command::new(&binary).arg(control).output().unwrap();
                            let label = format!(
                                "final-{name}-{mode}-packed-{packed}-reuse-{reuse}{opt}-{control}"
                            );
                            record_probe::save(
                                "iteration_consumers",
                                &label,
                                &emitted,
                                &binary,
                                &observed,
                            );
                            if observed.status.code() != Some(status) || !observed.stderr.is_empty()
                            {
                                failures.push(format!("{label}: {observed:?}"));
                            }
                        }
                    }
                }
            }
        }
    }
    assert!(failures.is_empty(), "{}", failures.join("\n"));
}

#[test]
fn last_keeps_the_selected_file_open_until_its_final_owner_is_released() {
    let file = MT::con("std::File");
    let list = MT::Con("std::List".into(), vec![file.clone()]);
    let option = MT::Con("std::Option".into(), vec![file]);
    let last = MT::Fun(Box::new(list.clone()), Box::new(option.clone()));
    let drop_list = MT::Fun(Box::new(list.clone()), Box::new(MT::unit()));
    let drop_result = MT::Fun(Box::new(option.clone()), Box::new(MT::unit()));
    let mut program = Program::default();
    program.shapes.insert(
        option.clone(),
        TypeShape::Adt(vec![
            ("None".into(), vec![]),
            ("Some".into(), vec![MT::con("std::File")]),
        ]),
    );
    program.funcs = vec![
        Func {
            name: "last".into(),
            arity: 1,
            locals: vec![list.clone()],
            ty: last.clone(),
            body: Body::Prim("last".into()),
        },
        Func {
            name: "drop-list".into(),
            arity: 1,
            locals: vec![list],
            ty: drop_list.clone(),
            body: Body::Expr(Expr::Const(Value::unit())),
        },
        Func {
            name: "main".into(),
            arity: 0,
            locals: vec![],
            ty: MT::Record(vec![
                ("0".into(), last),
                ("1".into(), drop_list),
                ("2".into(), drop_result.clone()),
            ]),
            body: Body::Expr(Expr::Record(vec![
                Expr::Func(0),
                Expr::Func(1),
                Expr::Func(3),
            ])),
        },
        Func {
            name: "drop-result".into(),
            arity: 1,
            locals: vec![option],
            ty: drop_result,
            body: Body::Expr(Expr::Const(Value::unit())),
        },
    ];
    program.main = Some(2);
    fwp::ir::check_locals(&program).unwrap();
    let code = fwp::cgen::generate(&program).unwrap();
    let code = code.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let code = ownership_ledger::instrument_native(&code, 128);
    let hooks = r#"
static int iteration_closes;
static int iteration_close(FILE *stream);
#ifdef _WIN32
#define _wfopen observe_wopen
#else
#define fopen observe_open
#endif
#define fclose iteration_close
"#;
    let probe = r#"
#undef fopen
#undef _wfopen
#undef fclose
static int iteration_close(FILE *stream) {
    if (stream == watched_stream) { watched_stream = NULL; iteration_closes++; }
    return fclose(stream);
}
int main(int argc, char **argv) {
    if (argc != 3) return 93;
    int missing = !strcmp(argv[2], "missing-release");
    if (!missing && strcmp(argv[2], "complete")) return 94;
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    size_t baseline = fwp_heap.live;
    for (int round = 0; round < 32; round++) {
        V path = fwp_rc_fresh(fwp_cstr(argv[1]));
        V handle = fwp_p_file_open(path, 1, NULL);
        fwp_rc_free_obj(path);
        V xs = fwp_rc_fresh(fwp_cons(handle, 0));
        if (f0(0) || ((fwp_file *)(uintptr_t)handle)->refs != 1) return 80;
        V result = f0(xs);
        if (!result || OBJ(result)->tag != 1 || OBJ(result)->f[0] != handle ||
            ((fwp_file *)(uintptr_t)handle)->refs != 2) return 81;
        fwp_fn_table[1].owned->drop_arguments(&xs, 0, 1);
        if (iteration_closes != round || !stream_is_open() ||
            ((fwp_file *)(uintptr_t)handle)->refs != 1) return 82;
        if (fputs("still open", ((fwp_file *)(uintptr_t)handle)->f) < 0) return 83;
        if (!missing) fwp_fn_table[3].owned->drop_arguments(&result, 0, 1);
        if (stream_is_open() || iteration_closes != round + 1 ||
            fwp_heap.live != baseline || owner_ledger_live || fwp_heap.rc_wide_len) return 90;
    }
    owner_ledger_finish();
    return 0;
}
"#;
    let emitted = format!(
        "{}\n{hooks}\n{code}\n{probe}",
        include_str!("fixtures/file_stream_observer.c")
    );
    let directory = fwp::cgen::TempDir::new("fwp-last-resource").unwrap();
    let path = directory.join("file.txt");
    for opt in ["-O1", "-O2"] {
        let binary = directory.join("resource.exe");
        fwp::cgen::compile_c(&emitted, &binary, opt).unwrap();
        for (control, status) in [("complete", 0), ("missing-release", 90)] {
            let observed = Command::new(&binary)
                .arg(&path)
                .arg(control)
                .output()
                .unwrap();
            record_probe::save(
                "iteration_consumers",
                &format!("last-file{opt}-{control}"),
                &emitted,
                &binary,
                &observed,
            );
            assert_eq!(
                observed.status.code(),
                Some(status),
                "{opt}/{control}: {observed:?}"
            );
            assert!(
                observed.stdout.is_empty() && observed.stderr.is_empty(),
                "{observed:?}"
            );
        }
    }
}

#[test]
fn final_values_preserve_aliases_effects_callback_order_and_failures() {
    let dir = fwp::cgen::TempDir::new("fwp-final-iteration").unwrap();
    let source = dir.join("final.fwp");
    std::fs::write(&source, include_str!("fixtures/final_iteration.fwp")).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = Command::new(compiler)
        .env("FWP_NO_OPT", "1")
        .args(["run", "--interp"])
        .arg(&source)
        .output()
        .unwrap();
    assert!(
        reference.status.success() && reference.stderr.is_empty(),
        "{reference:?}"
    );
    let interpreted = Command::new(compiler)
        .env_remove("FWP_NO_OPT")
        .args(["run", "--interp"])
        .arg(&source)
        .output()
        .unwrap();
    assert_eq!(interpreted.status.code(), reference.status.code());
    assert_eq!(interpreted.stdout, reference.stdout);
    assert_eq!(interpreted.stderr, reference.stderr);
    let cfile = dir.join("final.c");
    let built = Command::new(compiler)
        .env_remove("FWP_NO_OPT")
        .args(["build", "--memory", "dynamic", "--emit-c", "-O2"])
        .arg(&source)
        .arg("-o")
        .arg(&cfile)
        .output()
        .unwrap();
    assert!(built.status.success(), "{built:?}");
    let code = std::fs::read_to_string(cfile).unwrap();
    assert!(
        code.contains("/* list._iterate-last :"),
        "history removal was not exercised"
    );
    for opt in ["-O1", "-O2"] {
        let binary = dir.join(format!("final{opt}.exe"));
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();
        let observed = Command::new(&binary).output().unwrap();
        record_probe::save(
            "iteration_consumers",
            &format!("final-values{opt}"),
            &code,
            &binary,
            &observed,
        );
        assert_eq!(
            observed.status.code(),
            reference.status.code(),
            "{opt}: {observed:?}"
        );
        assert_eq!(observed.stdout, reference.stdout, "{opt}");
        assert_eq!(observed.stderr, reference.stderr, "{opt}");
    }
}

#[test]
fn final_iteration_checks_counts_after_inputs_and_before_callbacks() {
    let dir = fwp::cgen::TempDir::new("fwp-final-iteration-order").unwrap();
    for (index, body, message) in [
        (
            0,
            "0 | iterate 9223372036854775807 fail-step | last | echo",
            "iterate too large",
        ),
        (1, "0 | iterate 2 fail-step | last | echo", "callback ran"),
        (
            2,
            "0 | iterate 0 (make-step 0) | last | echo",
            "division by zero",
        ),
        (
            3,
            "(1 / 0) | iterate 9223372036854775807 fail-step | last | echo",
            "division by zero",
        ),
    ] {
        let source = dir.join(format!("order-{index}.fwp"));
        std::fs::write(&source, format!("fail-step : I64 -> I64\nfail-step = const \"callback ran\" | prim.trap\nmake-step : I64 -> I64 -> I64\nmake-step = fn n -> let amount = 1 / n in add amount\nmain = {body}\n")).unwrap();
        for raw in [true, false] {
            let mut command = Command::new(env!("CARGO_BIN_EXE_fwp"));
            command.args(["run", "--interp"]).arg(&source);
            if raw {
                command.env("FWP_NO_OPT", "1");
            } else {
                command.env_remove("FWP_NO_OPT");
            }
            let result = command.output().unwrap();
            assert_eq!(result.status.code(), Some(101), "{index}/{raw}: {result:?}");
            assert!(result.stdout.is_empty(), "{result:?}");
            assert_eq!(result.stderr, format!("fwp: trap: {message}\n").as_bytes());
        }
        let cfile = dir.join(format!("order-{index}.c"));
        let result = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env_remove("FWP_NO_OPT")
            .args(["build", "--memory", "dynamic", "--emit-c", "-O2"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile)
            .output()
            .unwrap();
        assert!(result.status.success(), "{result:?}");
        let code = std::fs::read_to_string(cfile).unwrap();
        for opt in ["-O1", "-O2"] {
            let binary = dir.join(format!("order-{index}{opt}.exe"));
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            let observed = Command::new(&binary).output().unwrap();
            record_probe::save(
                "iteration_consumers",
                &format!("final-order-{index}{opt}"),
                &code,
                &binary,
                &observed,
            );
            assert_eq!(
                observed.status.code(),
                Some(101),
                "{index}/{opt}: {observed:?}"
            );
            assert!(observed.stdout.is_empty(), "{observed:?}");
            assert_eq!(
                observed.stderr,
                format!("fwp: trap: {message}\n").as_bytes()
            );
        }
    }
}

#[test]
fn consumers_and_projections_match_the_raw_interpreter() {
    let root = Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/run");
    for name in ["iteration_consumers", "make_projections"] {
        let output = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(root.join(format!("{name}.fwp")))
            .output()
            .unwrap();
        assert!(output.status.success(), "{name}: {output:?}");
        assert!(output.stderr.is_empty(), "{name}: {output:?}");
        assert_eq!(
            output.stdout,
            std::fs::read(root.join(format!("{name}.out"))).unwrap(),
            "{name}"
        );
    }
}

#[test]
fn consumer_callbacks_cannot_hide_io() {
    for source in [
        "bad : Iterator[String] -> ()\nbad = iter.each print\n",
        "bad : Iterator[String] -> String\nbad = iter.fold (curry (.1 | tap print)) \"\"\n",
        "bad : Iterator[String] -> Option[String]\nbad = iter.find (tap print | string.length | eq 0)\n",
        "bad : List[String] -> String\nbad = fold-until (curry (.1 | tap print | Again)) \"\"\n",
        "bad : List[String] -> (List[String], String)\nbad = map-accum (curry (.1 | tap print | both id id)) \"\"\n",
    ] {
        let error = check_source("consumer-effects.fwp", source, None)
            .err()
            .expect("accepted unhandled IO");
        assert!(error.rendered.contains("IO"), "{}", error.rendered);
    }
}

#[test]
fn long_consumers_do_not_accumulate_stack_frames() {
    let dir = std::env::temp_dir().join(format!("fwp-iteration-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let source = dir.join("long.fwp");
    std::fs::write(
        &source,
        r#"
main = [
    0 | iter.count-from | iter.take 20000 | iter.fold add 0 | echo,
    0 | iter.count-from | iter.find (eq 20000) | echo,
    0 | iter.count-from | iter.take 20000 | run-state 0 (iter.each (const (add 1) | modify)) | echo,
    range 0 20000 | fold-until (add | flip compose Again) 0 | echo,
    range 0 20000 | map-accum (add | flip compose (both id id)) 0 | both (.0 | length) .1 | echo,
] | ignore
"#,
    )
    .unwrap();
    let expected = b"199990000\nSome 20000\n((), 20000)\n199990000\n(20000, 199990000)\n";
    for raw in [true, false] {
        let mut command = Command::new(env!("CARGO_BIN_EXE_fwp"));
        command.arg("run");
        if raw {
            command.arg("--interp").env("FWP_NO_OPT", "1");
        }
        let output = command.arg(&source).output().unwrap();
        assert!(output.status.success(), "raw={raw}: {output:?}");
        assert!(output.stderr.is_empty(), "raw={raw}: {output:?}");
        assert_eq!(output.stdout, expected, "raw={raw}");
    }
    std::fs::remove_dir_all(dir).unwrap();
}
