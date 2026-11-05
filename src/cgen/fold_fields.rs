//! Prove constant numeric seeds without evaluating arbitrary language code.
//! Only selected packed folds use the replacement; other cached uses keep
//! their ordinary initialization and owned representation.

use crate::ir::*;
use crate::value::Value;

use super::constant_values::Constants;


fn visit(expr: &mut Expr, constants: &mut Constants<'_>) {
    match expr {
        Expr::ResourceRegion { .. } => return,
        Expr::Call(_, args) | Expr::Construct(_, args) | Expr::Record(args) => {
            for arg in args {
                visit(arg, constants);
            }
        }
        Expr::Apply(target, args) => {
            visit(target, constants);
            for arg in args {
                visit(arg, constants);
            }
        }
        Expr::Let(_, value, body) => {
            visit(value, constants);
            visit(body, constants);
        }
        Expr::Match(value, arms) => {
            visit(value, constants);
            for (_, body) in arms {
                visit(body, constants);
            }
        }
        Expr::SetFields(value, fields) => {
            visit(value, constants);
            for (_, value) in fields {
                visit(value, constants);
            }
        }
        Expr::Field(body, _)
        | Expr::Trace(_, body)
        | Expr::Dup(_, body)
        | Expr::Drop(_, body)
        | Expr::BorrowGlobal(_, _, body) => visit(body, constants),
        Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => {}
    }
    let Expr::Call(id, args) = expr else { return };
    if !matches!(
        constants.program.funcs[*id].body,
        Body::PackedRecordFold { .. }
    ) || args.len() != 2
        || super::abi_of(constants.program, &constants.program.funcs[*id]).is_none()
    {
        return;
    }
    let Some(Value::Record(ref values)) = constants.expr(&args[0], &mut 256) else {
        return;
    };
    let fields = record_fields(
        &constants.program.shapes,
        &constants.program.funcs[*id].locals[0],
    )
    .expect("numeric packed-fold seed");
    if values.len() == fields.len() && fields.iter().all(|(_, ty)| super::scalar(ty).is_some()) {
        args[0] = Expr::Record(values.iter().cloned().map(Expr::Const).collect());
    }
}

pub(super) fn lower(program: &mut Program) {
    let source = program.clone();
    let mut constants = Constants::new(&source);
    for f in &mut program.funcs {
        if let Body::Expr(body) = &mut f.body {
            visit(body, &mut constants);
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn constants() -> Program {
        let scalar = MT::con("std::F64");
        let record = MT::Record(vec![
            ("value".into(), scalar.clone()),
            ("vertex".into(), MT::con("std::I64")),
        ]);
        Program {
            funcs: vec![
                Func {
                    name: "seed".into(),
                    arity: 0,
                    locals: vec![],
                    ty: record,
                    body: Body::Expr(Expr::Record(vec![
                        Expr::Func(1),
                        Expr::Const(Value::I64(-1)),
                    ])),
                },
                Func {
                    name: "zero".into(),
                    arity: 0,
                    locals: vec![],
                    ty: scalar.clone(),
                    body: Body::Expr(Expr::Call(2, vec![])),
                },
                Func {
                    name: "primitive".into(),
                    arity: 0,
                    locals: vec![],
                    ty: scalar,
                    body: Body::Prim("prim.zero".into()),
                },
            ],
            ..Program::default()
        }
    }

    #[test]
    fn concrete_zero_and_literal_bits_are_proved_without_running_user_code() {
        let p = constants();
        let mut proof = Constants::new(&p);
        let Some(Value::Record(ref fields)) = proof.entry(0, &mut 256) else {
            panic!("constant seed")
        };
        assert!(
            matches!(fields.as_ref(), [Value::F64(value), Value::I64(-1)] if value.to_bits() == 0)
        );
        for bits in [
            0_u64,
            1,
            0x8000000000000000,
            0x7ff8000000000042,
            0x7ff0000000000042,
        ] {
            let literal = Expr::Const(Value::F64(f64::from_bits(bits)));
            let Some(Value::F64(value)) = proof.expr(&literal, &mut 1) else {
                panic!("scalar bits")
            };
            assert_eq!(value.to_bits(), bits);
        }
    }

    #[test]
    fn effects_cycles_and_excessive_constant_work_do_not_qualify() {
        for case in 0..4 {
            let mut p = constants();
            match case {
                0 => p.funcs[2].body = Body::Prim("prim.trap".into()),
                1 => p.funcs[2].body = Body::Expr(Expr::Func(1)),
                2 => p.funcs[2].body = Body::Expr(Expr::Apply(Box::new(Expr::Func(1)), vec![])),
                3 => {}
                _ => unreachable!(),
            }
            let mut proof = Constants::new(&p);
            assert!(
                proof
                    .entry(0, &mut if case == 3 { 1 } else { 256 })
                    .is_none(),
                "case {case}"
            );
        }
    }
}
