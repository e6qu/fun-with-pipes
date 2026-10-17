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
            .call(0, vec![input()])
            .unwrap(),
        Value::str("kept")
    );
    assert!(fwp::interp::Interp::new(&p, Box::new(Vec::new()))
        .call(2, vec![input()])
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
}
