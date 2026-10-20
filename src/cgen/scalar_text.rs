//! Eliminate immediately consumed integer text before ownership creates String
//! temporaries. Shared strings and unknown string producers keep their storage.

use super::int64_kind;
use crate::ir::*;
use crate::value::Value;
use std::collections::HashMap;

#[derive(Clone, Copy, PartialEq, Eq, Hash)]
enum Operation {
    PrintInteger(FuncId),
    IntegerLength(FuncId),
    LengthSum,
}

fn symbol(funcs: &[Func], id: FuncId) -> Option<&str> {
    match &funcs.get(id)?.body {
        Body::Prim(name) => Some(name),
        _ => None,
    }
}

/// Bound every eliminated string's character count. Only integer formatting,
/// literal text and their concatenations qualify; no unknown string allocation
/// or shared local is moved across its original uses.
fn length_bound(e: &Expr, funcs: &[Func]) -> Option<u64> {
    let bound = match e {
        Expr::Const(Value::Str(text)) => u64::try_from(text.chars().count()).ok()?,
        Expr::Let(_, _, body) => length_bound(body, funcs)?,
        Expr::Call(id, args) => match (symbol(funcs, *id)?, args.as_slice()) {
            ("show", [_]) => {
                int64_kind(funcs[*id].ty.params(1).0[0])?;
                20 // Includes the sign of I64::MIN and all digits of U64::MAX.
            }
            ("concat", [a, b]) => length_bound(a, funcs)?.checked_add(length_bound(b, funcs)?)?,
            _ => return None,
        },
        _ => return None,
    };
    (bound <= i64::MAX as u64).then_some(bound)
}

fn target(
    operation: Operation,
    funcs: &[Func],
    made: &mut Vec<Func>,
    targets: &mut HashMap<Operation, FuncId>,
) -> FuncId {
    *targets.entry(operation).or_insert_with(|| {
        let integer = MT::con("std::I64");
        if operation == Operation::LengthSum {
            if let Some(id) = funcs.iter().position(|function| {
                if function.arity != 2
                    || !matches!(&function.body, Body::Prim(name) if name == "add")
                {
                    return false;
                }
                let (parameters, result) = function.ty.params(2);
                parameters == [&integer, &integer] && result == &integer
            }) {
                return id;
            }
        }
        let (name, primitive, parameters, result) = match operation {
            Operation::PrintInteger(show) => (
                "print._integer",
                "print._integer",
                vec![funcs[show].ty.params(1).0[0].clone()],
                MT::unit(),
            ),
            Operation::IntegerLength(show) => (
                "string._integer-length",
                "string._integer-length",
                vec![funcs[show].ty.params(1).0[0].clone()],
                integer,
            ),
            Operation::LengthSum => (
                "add",
                "add",
                vec![integer.clone(), integer.clone()],
                integer,
            ),
        };
        let id = funcs.len() + made.len();
        let ty = parameters.iter().rev().fold(result, |result, parameter| {
            MT::Fun(Box::new(parameter.clone()), Box::new(result))
        });
        made.push(Func {
            name: name.into(),
            arity: parameters.len() as u32,
            locals: parameters,
            ty,
            body: Body::Prim(primitive.into()),
        });
        id
    })
}

fn length(
    e: Expr,
    funcs: &[Func],
    made: &mut Vec<Func>,
    targets: &mut HashMap<Operation, FuncId>,
) -> Expr {
    match e {
        Expr::Const(Value::Str(ref text)) => Expr::Const(Value::I64(text.chars().count() as i64)),
        Expr::Let(local, value, body) => {
            Expr::Let(local, value, Box::new(length(*body, funcs, made, targets)))
        }
        Expr::Call(id, args) => match symbol(funcs, id) {
            Some("show") => Expr::Call(
                target(Operation::IntegerLength(id), funcs, made, targets),
                args,
            ),
            Some("concat") => {
                // Keep the original argument order, including effects/traps in
                // integer-producing expressions. The added arithmetic is pure
                // and bounded, and still uses the ordinary checked add.
                let parts = args
                    .into_iter()
                    .map(|arg| length(arg, funcs, made, targets))
                    .collect();
                Expr::Call(target(Operation::LengthSum, funcs, made, targets), parts)
            }
            _ => unreachable!("length_bound checked each string producer"),
        },
        _ => unreachable!("length_bound checked each expression"),
    }
}

pub(super) fn lower(prog: &Program, direct_integer_output: bool) -> Program {
    fn rewrite(
        e: &mut Expr,
        funcs: &[Func],
        made: &mut Vec<Func>,
        targets: &mut HashMap<Operation, FuncId>,
        direct_integer_output: bool,
    ) {
        let mut visit = |e: &mut Expr| rewrite(e, funcs, made, targets, direct_integer_output);
        match e {
            Expr::Trace(_, body)
            | Expr::Dup(_, body)
            | Expr::Drop(_, body)
            | Expr::BorrowGlobal(_, _, body)
            | Expr::ResourceRegion { body, .. } => visit(body),
            Expr::Call(_, args) | Expr::Construct(_, args) | Expr::Record(args) => {
                args.iter_mut().for_each(visit);
            }
            Expr::Apply(function, args) => {
                visit(function);
                args.iter_mut().for_each(visit);
            }
            Expr::Field(record, _) => visit(record),
            Expr::SetFields(record, fields) => {
                visit(record);
                fields.iter_mut().for_each(|(_, value)| visit(value));
            }
            Expr::Let(_, value, body) => {
                visit(value);
                visit(body);
            }
            Expr::Match(value, arms) => {
                visit(value);
                arms.iter_mut().for_each(|(_, body)| visit(body));
            }
            Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => {}
        }
        let Expr::Call(consumer, args) = e else {
            return;
        };
        match (symbol(funcs, *consumer), args.as_mut_slice()) {
            (Some("string.length"), [value]) if length_bound(value, funcs).is_some() => {
                *e = length(
                    std::mem::replace(value, Expr::Const(Value::unit())),
                    funcs,
                    made,
                    targets,
                );
            }
            (Some("print"), [Expr::Call(show, values)]) if direct_integer_output => {
                if symbol(funcs, *show) != Some("show") || values.len() != 1 {
                    return;
                }
                if int64_kind(funcs[*show].ty.params(1).0[0]).is_none() {
                    return;
                }
                let print = target(Operation::PrintInteger(*show), funcs, made, targets);
                *e = Expr::Call(print, std::mem::take(values));
            }
            _ => {}
        }
    }
    let mut lowered = prog.clone();
    let mut made = Vec::new();
    let mut targets = HashMap::new();
    for function in &mut lowered.funcs {
        if let Body::Expr(body) = &mut function.body {
            rewrite(
                body,
                &prog.funcs,
                &mut made,
                &mut targets,
                direct_integer_output,
            );
        }
    }
    lowered.funcs.extend(made);
    lowered
}
