//! Consuming a boxed record can transfer its only counted field.
use fwp::ir::*;
use fwp::value::Value;
use std::process::Command;

fn program() -> Program {
    let text = MT::con("std::String");
    let pair = MT::Record(vec![
        ("0".into(), MT::con("std::I64")),
        ("1".into(), text.clone()),
    ]);
    let boxed = MT::con("test::Box");
    let unit = MT::unit();
    let arrow = |a, b| MT::Fun(Box::new(a), Box::new(b));
    let mut p = Program::default();
    p.shapes.insert(
        boxed.clone(),
        TypeShape::Adt(vec![("Box".into(), vec![pair.clone()])]),
    );
    p.funcs.push(Func {
        name: "select-boxed-field".into(),
        arity: 1,
        locals: vec![boxed.clone(), pair, text.clone()],
        ty: arrow(boxed.clone(), text.clone()),
        body: Body::Expr(Expr::Match(
            Box::new(Expr::Local(0)),
            vec![(
                Pat::Construct(0, vec![Pat::Bind(1)]),
                Expr::Let(
                    2,
                    Box::new(Expr::Field(Box::new(Expr::Local(1)), 1)),
                    Box::new(Expr::Local(2)),
                ),
            )],
        )),
    });
    p.funcs.push(Func {
        name: "trap".into(),
        arity: 1,
        locals: vec![text.clone()],
        ty: arrow(text.clone(), text.clone()),
        body: Body::Prim("prim.trap".into()),
    });
    p.funcs.push(Func {
        name: "fail-after-projection".into(),
        arity: 1,
        locals: vec![boxed.clone()],
        ty: arrow(boxed, text.clone()),
        body: Body::Expr(Expr::Call(1, vec![Expr::Call(0, vec![Expr::Local(0)])])),
    });
    p.funcs.push(Func {
        name: "yield".into(),
        arity: 1,
        locals: vec![unit.clone()],
        ty: arrow(unit.clone(), unit.clone()),
        body: Body::Prim("task.yield".into()),
    });
    let value = || {
        Expr::Construct(
            0,
            vec![Expr::Record(vec![
                Expr::Const(Value::I64(7)),
                Expr::Const(Value::str("kept")),
            ])],
        )
    };
    p.funcs.push(Func {
        name: "main".into(),
        arity: 0,
        locals: vec![],
        ty: MT::Record(vec![
            ("0".into(), text.clone()),
            ("1".into(), text),
            ("2".into(), unit),
            ("3".into(), p.funcs[0].ty.clone()),
        ]),
        body: Body::Expr(Expr::Record(vec![
            Expr::Call(0, vec![value()]),
            Expr::Call(2, vec![value()]),
            Expr::Call(3, vec![Expr::Const(Value::unit())]),
            Expr::Func(0), // retain typed argument-drop metadata for the alias probe
        ])),
    });
    p.main = Some(4);
    p
}

#[test]
fn boxed_projection_transfers_unique_fields_and_preserves_shared_values() {
    let p = program();
    fwp::ir::check_locals(&p).unwrap();
    let input = || {
        Value::Data(
            0,
            vec![Value::Record(
                vec![Value::I64(7), Value::str("kept")].into(),
            )]
            .into(),
        )
    };
    assert_eq!(
        fwp::interp::Interp::new(&p, Box::new(Vec::new()))
            .unwrap()
            .call_root(0, vec![input()])
            .unwrap(),
        Value::str("kept")
    );
    assert!(fwp::interp::Interp::new(&p, Box::new(Vec::new()))
        .unwrap()
        .call_root(2, vec![input()])
        .is_err());
    let dir = fwp::cgen::TempDir::new("boxed-projection").unwrap();
    let binary = dir.join("probe.exe");
    for arc in [false, true] {
        fwp::cgen::set_native_options(fwp::cgen::NativeOptions {
            arc,
            ..Default::default()
        });
        let generated = fwp::cgen::generate(&p).unwrap();
        fwp::cgen::set_native_options(Default::default());
        assert!(generated.contains("/* move sole boxed owner */"));
        let code = generated.replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic size_t projection_retains;")
            .replace("static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) {", "static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) { projection_retains++;")
            .replace("int main(int argc, char **argv)", "int original_main(int argc, char **argv)")
            + include_str!("fixtures/boxed_projection_ownership.c");
        let mut duplicated = String::new();
        let mut stolen = String::new();
        for line in code.lines() {
            if line.contains("/* move sole boxed owner */") {
                duplicated.push_str("if (0) { /* restore redundant retain */\n");
                stolen.push_str("if (1) { /* steal from shared record */\n");
            } else {
                duplicated.push_str(line);
                duplicated.push('\n');
                stolen.push_str(line);
                stolen.push('\n');
            }
        }
        for opt in ["-O1", "-O2"] {
            for broken in [&duplicated, &stolen] {
                fwp::cgen::compile_c(broken, &binary, opt).unwrap();
                let out = Command::new(&binary)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                assert_eq!(out.status.code(), Some(202), "broken projection: {out:?}");
            }
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            for stress in if arc { &["0"][..] } else { &["0", "1"][..] } {
                let out = Command::new(&binary)
                    .env("FWP_GC", if arc { "off" } else { "on" })
                    .env("FWP_GC_STRESS", stress)
                    .env("FWP_GC_VERIFY", stress)
                    .env("FWP_REUSE_VERIFY", stress)
                    .output()
                    .unwrap();
                assert!(
                    out.status.success(),
                    "arc={arc}/{opt}/stress={stress}: {out:?}"
                );
            }
        }
    }
    check_stack_array_projection();
}

fn stack_array_program() -> Program {
    let array = MT::Con("std::Array".into(), vec![MT::con("std::F64")]);
    let pair = MT::Record(vec![
        ("0".into(), array.clone()),
        ("1".into(), MT::con("std::I64")),
    ]);
    let unit = MT::unit();
    let arrow = |a, b| MT::Fun(Box::new(a), Box::new(b));
    let mut p = Program::default();
    p.funcs.push(Func {
        name: "stack-array-field".into(),
        arity: 1,
        locals: vec![array.clone(), pair.clone(), MT::con("std::U64")],
        ty: arrow(array.clone(), array.clone()),
        body: Body::Expr(Expr::Let(
            1,
            Box::new(Expr::Record(vec![
                Expr::Local(0),
                Expr::Const(Value::I64(7)),
            ])),
            Box::new(Expr::Let(
                2,
                Box::new(Expr::Call(1, vec![Expr::Local(1)])),
                Box::new(Expr::Field(Box::new(Expr::Local(1)), 0)),
            )),
        )),
    });
    // hash reads the complete record without retaining it. This keeps the
    // record's C stack layout, instead of splitting it into scalar locals.
    p.funcs.push(Func {
        name: "hash".into(),
        arity: 1,
        locals: vec![pair.clone()],
        ty: arrow(pair, MT::con("std::U64")),
        body: Body::Prim("hash".into()),
    });
    p.funcs.push(Func {
        name: "trap".into(),
        arity: 1,
        locals: vec![MT::con("std::String")],
        ty: arrow(MT::con("std::String"), unit.clone()),
        body: Body::Prim("prim.trap".into()),
    });
    let after_projection = |id, argument| {
        Body::Expr(Expr::Let(
            1,
            Box::new(Expr::Call(0, vec![Expr::Local(0)])),
            Box::new(Expr::Let(
                2,
                Box::new(Expr::Call(id, vec![argument])),
                Box::new(Expr::Local(1)),
            )),
        ))
    };
    p.funcs.push(Func {
        name: "fail-after-array-move".into(),
        arity: 1,
        locals: vec![array.clone(), array.clone(), unit.clone()],
        ty: arrow(array.clone(), array.clone()),
        body: after_projection(2, Expr::Const(Value::str("stack array move"))),
    });
    p.funcs.push(Func {
        name: "yield".into(),
        arity: 1,
        locals: vec![unit.clone()],
        ty: arrow(unit.clone(), unit.clone()),
        body: Body::Prim("task.yield".into()),
    });
    p.funcs.push(Func {
        name: "cancel-after-array-move".into(),
        arity: 1,
        locals: vec![array.clone(), array.clone(), unit],
        ty: arrow(array.clone(), array.clone()),
        body: after_projection(4, Expr::Const(Value::unit())),
    });
    let input = || {
        Expr::Const(Value::Array(
            vec![Value::F64(1.25), Value::F64(-2.5)].into(),
        ))
    };
    p.funcs.push(Func {
        name: "main".into(),
        arity: 0,
        locals: vec![],
        ty: MT::Record(vec![
            ("0".into(), array.clone()),
            ("1".into(), array.clone()),
            ("2".into(), array),
            ("3".into(), p.funcs[0].ty.clone()),
        ]),
        body: Body::Expr(Expr::Record(vec![
            Expr::Call(0, vec![input()]),
            Expr::Call(3, vec![input()]),
            Expr::Call(5, vec![input()]),
            Expr::Func(0),
        ])),
    });
    p.main = Some(6);
    p
}

fn check_stack_array_projection() {
    let p = stack_array_program();
    fwp::ir::check_locals(&p).unwrap();
    let input = Value::Array(vec![Value::F64(1.25), Value::F64(-2.5)].into());
    assert_eq!(
        fwp::interp::Interp::new(&p, Box::new(Vec::new()))
            .unwrap()
            .call_root(0, vec![input.clone()])
            .unwrap(),
        input
    );
    assert!(fwp::interp::Interp::new(&p, Box::new(Vec::new()))
        .unwrap()
        .call_root(3, vec![input])
        .is_err());
    let dir = fwp::cgen::TempDir::new("stack-array-projection").unwrap();
    for arc in [false, true] {
        fwp::cgen::set_native_options(fwp::cgen::NativeOptions {
            arc,
            ..Default::default()
        });
        let generated = fwp::cgen::generate(&p).unwrap();
        fwp::cgen::set_native_options(Default::default());
        assert!(generated.contains("/* move stack array owner */"));
        let count_site = "static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) {";
        assert!(generated.contains(count_site));
        let code = generated.replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic size_t stack_array_retains;\nstatic int stack_array_cancel;")
            .replace(count_site, &(count_site.to_string() + " stack_array_retains++;"))
            .replace("static V fwp_p_task_yield(void) {", "static V fwp_p_task_yield(void) { if (stack_array_cancel) fwp_cur->cancelled = 1;")
            .replace("int main(int argc, char **argv)", "int original_main(int argc, char **argv)")
            + include_str!("fixtures/stack_array_projection.c");
        let mut counted = String::new();
        for line in code.lines() {
            counted.push_str(line);
            counted.push('\n');
            if let Some(rest) = line.trim().strip_prefix("/* move stack array owner */ ") {
                let local = rest.split(" = ").next().unwrap();
                counted.push_str(&format!("fwp_rc_dup({local}); fwp_rc_drop({local});\n"));
            }
        }
        let missing_release =
            code.replace("stack_array_drop(result);", "/* omitted result release */");
        assert_ne!(counted, code);
        assert_ne!(missing_release, code);
        for opt in ["-O0", "-O2"] {
            for (label, source, status) in [
                ("moved", &code, 0),
                ("extra-retain", &counted, 201),
                ("missing-release", &missing_release, 204),
            ] {
                let binary = dir.join("array.exe");
                fwp::cgen::compile_c(source, &binary, opt).unwrap();
                for stress in if !arc && label == "moved" {
                    &["0", "1"][..]
                } else {
                    &["0"][..]
                } {
                    let output = Command::new(&binary)
                        .env_remove("FWP_GC")
                        .env("FWP_GC_STRESS", stress)
                        .env("FWP_GC_VERIFY", stress)
                        .env("FWP_REUSE_VERIFY", stress)
                        .output()
                        .unwrap();
                    assert_eq!(
                        output.status.code(),
                        Some(status),
                        "arc={arc} {opt} {label} stress={stress}: {output:?}"
                    );
                    if let Some(destination) = std::env::var_os("FWP_STACK_ARRAY_ARTIFACTS") {
                        let destination = std::path::PathBuf::from(destination);
                        std::fs::create_dir_all(&destination).unwrap();
                        let name = format!(
                            "{}-{opt}-{label}-{stress}",
                            if arc { "arc" } else { "tracing" }
                        );
                        std::fs::write(destination.join(format!("{name}.c")), source).unwrap();
                        std::fs::copy(&binary, destination.join(format!("{name}.exe"))).unwrap();
                        std::fs::write(destination.join(format!("{name}.stdout")), &output.stdout)
                            .unwrap();
                        std::fs::write(destination.join(format!("{name}.stderr")), &output.stderr)
                            .unwrap();
                        std::fs::write(
                            destination.join(format!("{name}.status")),
                            format!("{status}\n"),
                        )
                        .unwrap();
                    }
                }
            }
        }
    }
}
