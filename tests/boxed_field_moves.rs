//! Unique boxed arguments transfer typed fields; shared parents retain them.
use fwp::ir::*;
use fwp::value::Value;
use std::process::Command;

fn program() -> Program {
    let text = MT::con("std::String");
    let unit = MT::unit();
    let pair = MT::Record(vec![
        ("0".into(), text.clone()),
        ("1".into(), text.clone()),
        ("2".into(), MT::con("std::I64")),
        ("3".into(), MT::con("std::I128")),
    ]);
    let arrow = |a: MT, b: MT| MT::Fun(Box::new(a), Box::new(b));
    let factory = arrow(unit.clone(), pair.clone());
    let mut p = Program::default();
    p.funcs.push(Func {
        name: "select".into(),
        arity: 1,
        locals: vec![pair.clone()],
        ty: arrow(pair.clone(), text.clone()),
        body: Body::Expr(Expr::Field(Box::new(Expr::Local(0)), 0)),
    });
    p.funcs.push(Func {
        name: "entry".into(),
        arity: 1,
        locals: vec![factory.clone()],
        ty: arrow(factory.clone(), text.clone()),
        body: Body::Expr(Expr::Call(
            0,
            vec![Expr::Apply(
                Box::new(Expr::Local(0)),
                vec![Expr::Const(Value::unit())],
            )],
        )),
    });
    p.funcs.push(Func {
        name: "factory".into(),
        arity: 1,
        locals: vec![unit.clone()],
        ty: factory.clone(),
        body: Body::Expr(Expr::Record(vec![
            Expr::Const(Value::str("first")),
            Expr::Const(Value::str("last")),
            Expr::Const(Value::I64(7)),
            Expr::Const(Value::I128(123)),
        ])),
    });
    p.funcs.push(Func {
        name: "yield".into(),
        arity: 1,
        locals: vec![unit.clone()],
        ty: arrow(unit.clone(), unit.clone()),
        body: Body::Prim("task.yield".into()),
    });
    p.funcs.push(Func {
        name: "trap".into(),
        arity: 1,
        locals: vec![text.clone()],
        ty: arrow(text.clone(), text.clone()),
        body: Body::Prim("prim.trap".into()),
    });
    p.funcs.push(Func {
        name: "fail-after-transfer".into(),
        arity: 1,
        locals: vec![factory.clone()],
        ty: arrow(factory, text.clone()),
        body: Body::Expr(Expr::Call(4, vec![Expr::Call(1, vec![Expr::Local(0)])])),
    });
    p.funcs.push(Func {
        name: "main".into(),
        arity: 0,
        locals: vec![],
        ty: MT::Record(vec![
            ("0".into(), text.clone()),
            ("1".into(), text),
            ("2".into(), unit),
        ]),
        body: Body::Expr(Expr::Record(vec![
            Expr::Call(1, vec![Expr::Func(2)]),
            Expr::Call(5, vec![Expr::Func(2)]),
            Expr::Call(3, vec![Expr::Const(Value::unit())]),
        ])),
    });
    p.main = Some(6);
    p
}

#[test]
fn boxed_transfers_preserve_shared_parents_wide_values_and_cleanup() {
    let p = program();
    fwp::ir::check_locals(&p).unwrap();
    // The same raw expressions return "first" before the deliberate trap.
    let mut raw = p.clone();
    raw.funcs[6].ty = MT::con("std::String");
    raw.funcs[6].body = Body::Expr(Expr::Call(1, vec![Expr::Func(2)]));
    let value = fwp::interp::Interp::new(&raw, Box::new(Vec::new()))
        .unwrap()
        .call(6, vec![])
        .unwrap();
    assert_eq!(value, Value::str("first"));
    raw.funcs[6].body = Body::Expr(Expr::Call(5, vec![Expr::Func(2)]));
    assert!(fwp::interp::Interp::new(&raw, Box::new(Vec::new()))
        .unwrap()
        .call(6, vec![])
        .is_err());
    let dir = fwp::cgen::TempDir::new("boxed-field-moves").unwrap();
    let binary = dir.join("probe.exe");
    for arc in [false, true] {
        fwp::cgen::set_native_options(fwp::cgen::NativeOptions {
            arc,
            ..Default::default()
        });
        let emitted = fwp::cgen::generate(&p).unwrap();
        fwp::cgen::set_native_options(Default::default());
        let code = emitted.replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic size_t conversion_retains;")
            .replace("static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) {", "static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) { conversion_retains++;")
            .replace("int main(int argc, char **argv)", "int original_main(int argc, char **argv)")
            + include_str!("fixtures/boxed_field_move_probe.c");
        assert!(code.contains("conversion_retains++;"));
        for opt in ["-O1", "-O2"] {
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            for stress in if arc { &["0"][..] } else { &["0", "1"][..] } {
                let output = Command::new(&binary)
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", stress)
                    .env("FWP_GC_VERIFY", stress)
                    .env("FWP_REUSE_VERIFY", stress)
                    .output()
                    .unwrap();
                assert!(
                    output.status.success(),
                    "arc={arc} {opt} stress={stress}: {output:?}"
                );
            }
        }
        // Force the old retain/drop conversion; the count assertion must fail.
        let control = code
            .lines()
            .map(|line| {
                if line.contains("/* move boxed fields */") {
                    format!("{} = 0;", line.split(" = ").next().unwrap())
                } else {
                    line.to_owned()
                }
            })
            .collect::<Vec<_>>()
            .join("\n");
        assert!(code.contains("/* move boxed fields */"));
        fwp::cgen::compile_c(&control, &binary, "-O2").unwrap();
        let output = Command::new(&binary)
            .env_remove("FWP_GC")
            .env("FWP_GC_STRESS", "0")
            .env("FWP_GC_VERIFY", "0")
            .env("FWP_REUSE_VERIFY", "0")
            .output()
            .unwrap();
        assert_eq!(output.status.code(), Some(214), "{output:?}");
    }
}
