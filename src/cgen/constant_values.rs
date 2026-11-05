//! Bounded proof of numeric constants, without executing user code.
//! Aggregate proofs serve only the existing packed-fold seed boundary.

use std::collections::HashMap;

use crate::ir::*;
use crate::value::Value;

pub(super) struct Constants<'a> {
    program: &'a Program,
    entries: HashMap<FuncId, Option<Value>>,
}

impl<'a> Constants<'a> {
    pub(super) fn new(program: &'a Program) -> Self {
        Self {
            program,
            entries: HashMap::new(),
        }
    }

    pub(super) fn entry(&mut self, id: FuncId, budget: &mut usize) -> Option<Value> {
        if let Some(value) = self.entries.get(&id) {
            return value.clone();
        }
        // Mark before descending: a recursive cached value cannot prove itself.
        self.entries.insert(id, None);
        let program = self.program;
        let function = program.funcs.get(id)?;
        if function.arity != 0 {
            return None;
        }
        let value = match &function.body {
            Body::Expr(body) => self.expr(body, budget),
            Body::Prim(symbol)
                if matches!(symbol.as_str(), "prim.zero" | "prim.one")
                    && super::scalar(&function.ty).is_some() =>
            {
                crate::interp::from_i128(&function.ty, i128::from(symbol == "prim.one")).ok()
            }
            _ => None,
        };
        // Check every scalar entry, not just the outer alias. Record seeds
        // retain their existing separately checked packed-fold field boundary.
        let value = value.filter(|value| {
            matches!(value, Value::Record(_))
                || exact_scalar(&function.ty, value)
                || matches!((&function.ty, value),
                    (MT::Con(name, args), Value::I64(_)) if name == "std::ISize" && args.is_empty())
                || matches!((&function.ty, value),
                    (MT::Con(name, args), Value::U64(_)) if name == "std::USize" && args.is_empty())
        });
        self.entries.insert(id, value.clone());
        value
    }

    pub(super) fn expr(&mut self, expr: &Expr, budget: &mut usize) -> Option<Value> {
        *budget = budget.checked_sub(1)?;
        match expr {
            Expr::Const(
                value @ (Value::I8(_)
                | Value::I16(_)
                | Value::I32(_)
                | Value::I64(_)
                | Value::U8(_)
                | Value::U16(_)
                | Value::U32(_)
                | Value::U64(_)
                | Value::F32(_)
                | Value::F64(_)),
            ) => Some(value.clone()),
            Expr::Record(fields) if fields.len() <= super::MAX_UNBOXED => {
                let values = fields
                    .iter()
                    .map(|field| self.expr(field, budget))
                    .collect::<Option<Vec<_>>>()?;
                Some(Value::Record(values.into()))
            }
            Expr::Func(id) => self.entry(*id, budget),
            Expr::Call(id, args) if args.is_empty() => self.entry(*id, budget),
            _ => None,
        }
    }
}

/// General replacements require the exact immediate scalar type. Pointer-width
/// aliases, owned numbers and aggregates stay outside this transformation.
fn exact_scalar(ty: &MT, value: &Value) -> bool {
    let MT::Con(name, args) = ty else {
        return false;
    };
    args.is_empty()
        && matches!(
            (name.as_str(), value),
            ("std::I8", Value::I8(_))
                | ("std::I16", Value::I16(_))
                | ("std::I32", Value::I32(_))
                | ("std::I64", Value::I64(_))
                | ("std::U8", Value::U8(_))
                | ("std::U16", Value::U16(_))
                | ("std::U32", Value::U32(_))
                | ("std::U64", Value::U64(_))
                | ("std::F32", Value::F32(_))
                | ("std::F64", Value::F64(_))
        )
}

fn replace(expr: &mut Expr, values: &[Option<Value>]) {
    let entry = match expr {
        Expr::Func(id) => Some(*id),
        Expr::Call(id, args) if args.is_empty() => Some(*id),
        _ => None,
    };
    if let Some(value) = entry.and_then(|id| values.get(id)).and_then(Option::as_ref) {
        *expr = Expr::Const(value.clone());
        return;
    }
    match expr {
        Expr::ResourceRegion { .. } | Expr::Trace(_, _) => {}
        Expr::Call(_, args) | Expr::Construct(_, args) | Expr::Record(args) => {
            for arg in args {
                replace(arg, values);
            }
        }
        Expr::Apply(target, args) => {
            replace(target, values);
            for arg in args {
                replace(arg, values);
            }
        }
        Expr::Let(_, value, body) => {
            replace(value, values);
            replace(body, values);
        }
        Expr::Match(value, arms) => {
            replace(value, values);
            for (_, body) in arms {
                replace(body, values);
            }
        }
        Expr::SetFields(value, fields) => {
            replace(value, values);
            for (_, field) in fields {
                replace(field, values);
            }
        }
        Expr::Field(body, _)
        | Expr::Dup(_, body)
        | Expr::Drop(_, body)
        | Expr::BorrowGlobal(_, _, body) => replace(body, values),
        Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => {}
    }
}

/// Prove from immutable input, then replace uses without copying the program.
/// Return the same proofs for root/export cache entries emitted by the backend.
pub(super) fn lower(program: &mut Program) -> Vec<Option<Value>> {
    let mut proof = Constants::new(program);
    let values: Vec<_> = program
        .funcs
        .iter()
        .enumerate()
        .map(|(id, function)| {
            if function.arity != 0 || super::scalar(&function.ty).is_none() {
                return None;
            }
            proof
                .entry(id, &mut 256)
                .filter(|value| exact_scalar(&function.ty, value))
        })
        .collect();
    for function in &mut program.funcs {
        if let Body::Expr(body) = &mut function.body {
            replace(body, &values);
        }
    }
    values
}

#[cfg(test)]
mod tests {
    use super::*;

    fn function(ty: &str, body: Body) -> Func {
        Func {
            name: "constant".into(),
            arity: 0,
            locals: vec![],
            ty: MT::con(ty),
            body,
        }
    }

    #[test]
    fn exact_constants_and_aliases_replace_reads_without_cache_owners() {
        for (ty, value) in [
            ("std::I8", Value::I8(i8::MIN)),
            ("std::I16", Value::I16(i16::MAX)),
            ("std::I32", Value::I32(i32::MIN)),
            ("std::I64", Value::I64(i64::MIN)),
            ("std::U8", Value::U8(u8::MAX)),
            ("std::U16", Value::U16(u16::MAX)),
            ("std::U32", Value::U32(u32::MAX)),
            ("std::U64", Value::U64(u64::MAX)),
            ("std::F32", Value::F32(-0.0)),
            ("std::F64", Value::F64(-0.0)),
        ] {
            let mut program = Program {
                funcs: vec![
                    function(ty, Body::Expr(Expr::Func(1))),
                    function(ty, Body::Expr(Expr::Call(2, vec![]))),
                    function(ty, Body::Expr(Expr::Const(value.clone()))),
                ],
                ..Program::default()
            };
            let values = lower(&mut program);
            assert!(values.iter().all(|v| v.as_ref() == Some(&value)));
            assert!(program
                .funcs
                .iter()
                .all(|f| matches!(f.body, Body::Expr(Expr::Const(_)))));
        }
    }

    #[test]
    fn primitive_values_and_float_payloads_are_exact() {
        for ty in ["std::I8", "std::U64", "std::F32", "std::F64"] {
            for primitive in ["prim.zero", "prim.one"] {
                let mut program = Program {
                    funcs: vec![function(ty, Body::Prim(primitive.into()))],
                    ..Program::default()
                };
                let expected =
                    crate::interp::from_i128(&MT::con(ty), i128::from(primitive == "prim.one"))
                        .unwrap();
                assert_eq!(lower(&mut program), vec![Some(expected)]);
            }
        }
        for bits in [
            0_u64,
            1,
            0x8000000000000000,
            0x7ff8000000000042,
            0x7ff0000000000042,
        ] {
            let mut program = Program {
                funcs: vec![
                    function("std::F64", Body::Expr(Expr::Func(1))),
                    function(
                        "std::F64",
                        Body::Expr(Expr::Const(Value::F64(f64::from_bits(bits)))),
                    ),
                ],
                ..Program::default()
            };
            let values = lower(&mut program);
            assert!(matches!(values[0], Some(Value::F64(v)) if v.to_bits() == bits));
            assert!(
                matches!(program.funcs[0].body, Body::Expr(Expr::Const(Value::F64(v))) if v.to_bits() == bits)
            );
        }
        for bits in [0_u32, 1, 0x80000000, 0x7fc00042, 0x7f800042] {
            let mut program = Program {
                funcs: vec![function(
                    "std::F32",
                    Body::Expr(Expr::Const(Value::F32(f32::from_bits(bits)))),
                )],
                ..Program::default()
            };
            assert!(matches!(lower(&mut program)[0], Some(Value::F32(v)) if v.to_bits() == bits));
        }
    }

    #[test]
    fn cycles_type_mismatches_wide_values_and_observable_bodies_are_not_constants() {
        for body in [
            Body::Expr(Expr::Func(0)),
            Body::Prim("prim.trap".into()),
            Body::Expr(Expr::Const(Value::F64(1.0))),
            Body::Expr(Expr::Const(Value::I128(1))),
            Body::Expr(Expr::Record(vec![Expr::Const(Value::I64(1))])),
            Body::Expr(Expr::Apply(Box::new(Expr::Func(0)), vec![])),
            Body::Expr(Expr::ResourceRegion {
                parameters: vec![],
                bindings: vec![],
                body: Box::new(Expr::Const(Value::I64(1))),
            }),
            Body::Expr(Expr::Trace(
                SourcePoint {
                    names: vec![],
                    span: crate::diag::Span::DUMMY,
                    ty: MT::con("std::I64"),
                },
                Box::new(Expr::Const(Value::I64(1))),
            )),
        ] {
            let mut program = Program {
                funcs: vec![function("std::I64", body)],
                ..Program::default()
            };
            assert!(lower(&mut program)[0].is_none());
        }
        let mut program = Program {
            funcs: vec![
                function("std::I64", Body::Expr(Expr::Func(1))),
                function("std::F64", Body::Expr(Expr::Const(Value::I64(7)))),
            ],
            ..Program::default()
        };
        assert!(lower(&mut program).iter().all(Option::is_none));
        for (ty, value) in [("std::ISize", Value::I64(1)), ("std::USize", Value::U64(1))] {
            let mut program = Program {
                funcs: vec![function(ty, Body::Expr(Expr::Const(value)))],
                ..Program::default()
            };
            assert!(lower(&mut program)[0].is_none());
        }
    }

    #[test]
    fn analysis_stops_at_its_budget_and_does_not_rewrite_resource_or_trace_bodies() {
        let mut program = Program {
            funcs: (0..257)
                .map(|id| {
                    function(
                        "std::I64",
                        Body::Expr(if id == 256 {
                            Expr::Const(Value::I64(7))
                        } else {
                            Expr::Func(id + 1)
                        }),
                    )
                })
                .collect(),
            ..Program::default()
        };
        assert!(lower(&mut program)[0].is_none());
        let values = vec![Some(Value::I64(7))];
        for mut expression in [
            Expr::ResourceRegion {
                parameters: vec![],
                bindings: vec![],
                body: Box::new(Expr::Func(0)),
            },
            Expr::Trace(
                SourcePoint {
                    names: vec![],
                    span: crate::diag::Span::DUMMY,
                    ty: MT::con("std::I64"),
                },
                Box::new(Expr::Func(0)),
            ),
        ] {
            replace(&mut expression, &values);
            let body = match expression {
                Expr::ResourceRegion { body, .. } | Expr::Trace(_, body) => body,
                _ => unreachable!(),
            };
            assert!(matches!(*body, Expr::Func(0)));
        }
    }
}
