//! Moving an owned field out of a flattened record needs no temporary owner.
use fwp::ir::*;
use fwp::value::Value;
use std::process::Command;
fn program() -> Program {
    let text = MT::con("std::String");
    let number = MT::con("std::I64");
    let pair = MT::Record(vec![("0".into(), text.clone()), ("1".into(), text.clone())]);
    let unary = |result: MT| MT::Fun(Box::new(text.clone()), Box::new(result));
    let mut p = Program::default();
    p.funcs.push(Func {
        name: "repeat".into(),
        arity: 2,
        locals: vec![number.clone(), text.clone()],
        ty: MT::Fun(Box::new(number), Box::new(unary(text.clone()))),
        body: Body::Prim("string.repeat".into()),
    });
    p.funcs.push(Func {
        name: "make".into(),
        arity: 1,
        locals: vec![text.clone()],
        ty: unary(pair.clone()),
        body: Body::Expr(Expr::Record(vec![
            Expr::Call(0, vec![Expr::Const(Value::I64(2)), Expr::Local(0)]),
            Expr::Call(0, vec![Expr::Const(Value::I64(3)), Expr::Local(0)]),
        ])),
    });
    p.funcs.push(Func {
        name: "select".into(),
        arity: 1,
        locals: vec![text.clone()],
        ty: unary(text.clone()),
        body: Body::Expr(Expr::Field(
            Box::new(Expr::Call(1, vec![Expr::Local(0)])),
            0,
        )),
    });
    p.funcs.push(Func {
        name: "shared".into(),
        arity: 1,
        locals: vec![text.clone()],
        ty: unary(pair),
        body: Body::Expr(Expr::Record(vec![Expr::Local(0), Expr::Local(0)])),
    });
    p.funcs.push(Func {
        name: "select-shared".into(),
        arity: 1,
        locals: vec![text.clone()],
        ty: unary(text.clone()),
        body: Body::Expr(Expr::Field(
            Box::new(Expr::Call(3, vec![Expr::Local(0)])),
            0,
        )),
    });
    p.funcs.push(Func {
        name: "trap".into(),
        arity: 1,
        locals: vec![text.clone()],
        ty: unary(text.clone()),
        body: Body::Prim("prim.trap".into()),
    });
    p.funcs.push(Func {
        name: "fail-selected".into(),
        arity: 1,
        locals: vec![text.clone(), text.clone()],
        ty: unary(text.clone()),
        body: Body::Expr(Expr::Let(
            1,
            Box::new(Expr::Call(2, vec![Expr::Local(0)])),
            Box::new(Expr::Call(5, vec![Expr::Local(1)])),
        )),
    });
    // A reachable task operation enables the real unwind machinery used by
    // cancellation. The C probe invokes the selected functions directly.
    let unit = MT::Record(vec![]);
    p.funcs.push(Func {
        name: "yield".into(),
        arity: 1,
        locals: vec![unit.clone()],
        ty: MT::Fun(Box::new(unit.clone()), Box::new(unit.clone())),
        body: Body::Prim("task.yield".into()),
    });
    p.funcs.push(Func {
        name: "main".into(),
        arity: 0,
        locals: vec![],
        ty: MT::Record(
            (0..3)
                .map(|i| (i.to_string(), text.clone()))
                .chain([(String::from("3"), unit)])
                .collect(),
        ),
        body: Body::Expr(Expr::Record(
            [2, 4, 6]
                .into_iter()
                .map(|id| Expr::Call(id, vec![Expr::Const(Value::str("abc"))]))
                .chain([Expr::Call(7, vec![Expr::Const(Value::unit())])])
                .collect(),
        )),
    });
    p.main = Some(8);
    p
}
#[test]
fn moved_fields_preserve_aliases_siblings_and_failure_cleanup() {
    let p = program();
    fwp::ir::check_locals(&p).unwrap();
    for (id, expected) in [(2, "abcabc"), (4, "abc")] {
        let value = fwp::interp::Interp::new(&p, Box::new(Vec::new()))
            .unwrap()
            .call_root(id, vec![Value::str("abc")])
            .unwrap();
        assert_eq!(value, Value::str(expected));
    }
    assert!(fwp::interp::Interp::new(&p, Box::new(Vec::new()))
        .unwrap()
        .call_root(6, vec![Value::str("abc")])
        .is_err());
    let dir = fwp::cgen::TempDir::new("field-moves").unwrap();
    let binary = dir.join("probe.exe");
    for arc in [false, true] {
        fwp::cgen::set_native_options(fwp::cgen::NativeOptions {
            arc,
            ..Default::default()
        });
        let emitted = fwp::cgen::generate(&p).unwrap();
        fwp::cgen::set_native_options(Default::default());
        let code = emitted.replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic size_t move_retains;\n")
            .replace("static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) {",
                "static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) { move_retains++;")
            .replace("int main(int argc, char **argv)", "int original_main(int argc, char **argv)")
            + include_str!("fixtures/field_move_probe.c");
        let run = |stress: &str| {
            let mut cmd = Command::new(&binary);
            cmd.env_remove("FWP_GC")
                .env("FWP_GC_STRESS", stress)
                .env("FWP_GC_VERIFY", stress)
                .env("FWP_REUSE_VERIFY", stress);
            cmd
        };
        for opt in ["-O1", "-O2"] {
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            for stress in if arc { &["0"][..] } else { &["0", "1"][..] } {
                let output = run(stress).output().unwrap();
                assert!(
                    output.status.success(),
                    "arc={arc} {opt} stress={stress}: {output:?}"
                );
            }
        }
        let mut control = String::new();
        for line in code.lines() {
            control.push_str(line);
            control.push('\n');
            if let Some(rest) = line.trim().strip_prefix("/* move owned field */ ") {
                let local = rest.split(" = ").next().unwrap();
                control.push_str(&format!("fwp_rc_dup({local}); fwp_rc_drop({local});\n"));
            }
        }
        assert_ne!(control, code);
        fwp::cgen::compile_c(&control, &binary, "-O2").unwrap();
        assert_eq!(run("0").output().unwrap().status.code(), Some(198));
    }
}
