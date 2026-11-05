//! A tape pointer may survive scalar appends, but not registry growth,
//! retirement, reentry or a task switch. Prove the whole closed worker first.
use crate::ir::*;
use crate::value::Value;

#[derive(Clone, Copy)]
enum Fact {
    Unknown,
    Visiting,
    Rejected,
    Numeric(u8),
}

fn numeric_type(program: &Program, ty: &MT, budget: &mut usize) -> bool {
    let Some(left) = budget.checked_sub(1) else {
        return false;
    };
    *budget = left;
    super::scalar(ty).is_some()
        || super::record_fields(&program.shapes, ty).is_some_and(|fields| {
            fields
                .iter()
                .all(|(_, ty)| numeric_type(program, ty, budget))
        })
}

pub(super) fn scalar_push(function: &Func) -> bool {
    let (parameters, result) = function.ty.params(function.arity as usize);
    matches!(&function.body, Body::Prim(symbol) if symbol == "ad.push")
        && function.arity == 4
        && parameters
            == vec![
                &MT::con("std::I64"),
                &MT::con("std::F64"),
                &MT::con("std::I64"),
                &MT::con("std::F64"),
            ]
        && result == &MT::con("std::I64")
}

fn float_primitive(function: &Func) -> bool {
    let Body::Prim(symbol) = &function.body else {
        return false;
    };
    let arity = match symbol.as_str() {
        "prim.zero" | "prim.one" => 0,
        "prim.neg" | "float.convert" | "prim.from-float" => 1,
        "prim.add" | "prim.sub" | "prim.mul" | "prim.div" => 2,
        _ => return false,
    };
    let (parameters, result) = function.ty.params(arity);
    let float = |ty: &MT| {
        matches!(
            super::scalar(ty),
            Some(super::Scalar::F32 | super::Scalar::F64)
        )
    };
    function.arity as usize == arity
        && parameters.len() == arity
        && parameters.iter().all(|ty| float(ty))
        && float(result)
        && (symbol == "float.convert"
            || symbol == "prim.from-float"
            || parameters.iter().all(|ty| *ty == result))
}

struct Proof<'a> {
    program: &'a Program,
    facts: Vec<Fact>,
}

impl Proof<'_> {
    fn function(&mut self, id: FuncId, budget: &mut usize, depth: usize) -> Option<u8> {
        match *self.facts.get(id)? {
            Fact::Numeric(pushes) => return Some(pushes),
            Fact::Visiting | Fact::Rejected => return None,
            Fact::Unknown => {}
        }
        // Bound native compiler recursion independently of the expression budget.
        if depth >= 64 {
            return None;
        }
        self.facts[id] = Fact::Visiting;
        let program = self.program;
        let function = &program.funcs[id];
        let (parameters, result) = function.ty.params(function.arity as usize);
        let valid_types = parameters.len() == function.arity as usize
            && parameters
                .iter()
                .all(|ty| numeric_type(self.program, ty, &mut 32))
            && numeric_type(self.program, result, &mut 32);
        let answer = if !valid_types {
            None
        } else {
            match &function.body {
                Body::Prim(_) if scalar_push(function) || float_primitive(function) => Some(0),
                Body::Expr(body) => self.expression(id, body, budget, depth),
                _ => None,
            }
        };
        self.facts[id] = answer.map_or(Fact::Rejected, Fact::Numeric);
        answer
    }

    fn expression(
        &mut self,
        id: FuncId,
        body: &Expr,
        budget: &mut usize,
        depth: usize,
    ) -> Option<u8> {
        let mut work = vec![body];
        let mut pushes = 0_u8;
        while let Some(expr) = work.pop() {
            *budget = budget.checked_sub(1)?;
            match expr {
                Expr::Local(local) => {
                    let ty = self.program.funcs[id].locals.get(*local as usize)?;
                    if !numeric_type(self.program, ty, &mut 32) {
                        return None;
                    }
                }
                Expr::Const(
                    Value::I8(_)
                    | Value::I16(_)
                    | Value::I32(_)
                    | Value::I64(_)
                    | Value::U8(_)
                    | Value::U16(_)
                    | Value::U32(_)
                    | Value::U64(_)
                    | Value::F32(_)
                    | Value::F64(_),
                ) => {}
                Expr::Let(local, value, body) => {
                    let ty = self.program.funcs[id].locals.get(*local as usize)?;
                    if !numeric_type(self.program, ty, &mut 32) {
                        return None;
                    }
                    work.extend([&**body, &**value]);
                }
                Expr::Record(fields) => work.extend(fields),
                Expr::Field(value, _) => work.push(value),
                Expr::Call(callee, arguments) => {
                    let function = self.program.funcs.get(*callee)?;
                    if function.arity as usize != arguments.len() {
                        return None;
                    }
                    let direct_push = scalar_push(function);
                    self.function(*callee, budget, depth + 1)?;
                    pushes = (pushes + u8::from(direct_push)).min(2);
                    work.extend(arguments);
                }
                Expr::Func(callee) if self.program.funcs.get(*callee)?.arity == 0 => {
                    self.function(*callee, budget, depth + 1)?;
                }
                // Unknown calls, trace hooks and resource cleanup can reenter.
                // Keep branches and recursive workers outside this first proof.
                _ => return None,
            }
        }
        Some(pushes)
    }
}

pub(super) fn select(program: &Program, ticks: bool) -> Vec<bool> {
    if ticks {
        return vec![false; program.funcs.len()];
    }
    let mut proof = Proof {
        program,
        facts: vec![Fact::Unknown; program.funcs.len()],
    };
    (0..program.funcs.len())
        .map(|id| {
            proof
                .function(id, &mut 4096, 0)
                .is_some_and(|pushes| pushes >= 2)
        })
        .collect()
}

#[cfg(test)]
mod tests {
    use super::*;

    fn function(parameters: Vec<MT>, result: MT, body: Body) -> Func {
        let ty = parameters.iter().rev().fold(result, |result, parameter| {
            MT::Fun(Box::new(parameter.clone()), Box::new(result))
        });
        Func {
            name: "recording-control".into(),
            arity: parameters.len() as u32,
            ty,
            locals: parameters,
            body,
        }
    }

    fn program() -> Program {
        let i = MT::con("std::I64");
        let f = MT::con("std::F64");
        let push = function(
            vec![i.clone(), f.clone(), i.clone(), f.clone()],
            i.clone(),
            Body::Prim("ad.push".into()),
        );
        let call = |parent| {
            Expr::Call(
                0,
                vec![
                    Expr::Local(parent),
                    Expr::Local(1),
                    Expr::Local(0),
                    Expr::Local(1),
                ],
            )
        };
        let mut worker = function(
            vec![i.clone(), f],
            i.clone(),
            Body::Expr(Expr::Let(2, Box::new(call(0)), Box::new(call(2)))),
        );
        worker.locals.push(i);
        Program {
            funcs: vec![push, worker],
            ..Program::default()
        }
    }

    #[test]
    fn repeated_scalar_pushes_select_only_without_task_entry_ticks() {
        let p = program();
        assert_eq!(select(&p, false), vec![false, true]);
        assert_eq!(select(&p, true), vec![false, false]);
        let mut p = p;
        let Body::Expr(Expr::Let(_, _, body)) = p.funcs[1].body.clone() else {
            unreachable!()
        };
        p.funcs[1].body = Body::Expr(*body);
        assert_eq!(select(&p, false), vec![false, false]);
    }

    #[test]
    fn numeric_callees_are_proved_but_do_not_add_direct_recording_sites() {
        let mut p = program();
        let f = MT::con("std::F64");
        p.funcs.push(function(
            vec![f.clone()],
            f.clone(),
            Body::Prim("prim.neg".into()),
        ));
        p.funcs.push(function(
            vec![f.clone()],
            f,
            Body::Expr(Expr::Call(2, vec![Expr::Local(0)])),
        ));
        let Body::Expr(body) = p.funcs[1].body.clone() else {
            unreachable!()
        };
        p.funcs[1].body = Body::Expr(Expr::Let(
            1,
            Box::new(Expr::Call(3, vec![Expr::Local(1)])),
            Box::new(body),
        ));
        assert_eq!(select(&p, false), vec![false, true, false, false]);
        let i = MT::con("std::I64");
        p.funcs.push(function(
            vec![i.clone(), MT::con("std::F64")],
            i,
            Body::Expr(Expr::Call(1, vec![Expr::Local(0), Expr::Local(1)])),
        ));
        assert!(!select(&p, false)[4]);
    }

    #[test]
    fn type_and_call_depth_limits_reject_exhaustion() {
        let p = program();
        let narrow = MT::Record(
            (0..31)
                .map(|n| (n.to_string(), MT::con("std::I64")))
                .collect(),
        );
        assert!(numeric_type(&p, &narrow, &mut 32));
        let wide = MT::Record(vec![("0".into(), narrow)]);
        assert!(!numeric_type(&p, &wide, &mut 32));
        let mut p = p;
        let mut id = 2;
        for _ in 0..64 {
            p.funcs.push(function(
                vec![MT::con("std::I64")],
                MT::con("std::I64"),
                Body::Expr(Expr::Call(id + 1, vec![Expr::Local(0)])),
            ));
            id += 1;
        }
        p.funcs.push(function(
            vec![MT::con("std::I64")],
            MT::con("std::I64"),
            Body::Expr(Expr::Local(0)),
        ));
        let Body::Expr(body) = p.funcs[1].body.clone() else {
            unreachable!()
        };
        p.funcs[1].body = Body::Expr(Expr::Let(
            2,
            Box::new(Expr::Call(2, vec![Expr::Local(0)])),
            Box::new(body),
        ));
        assert!(!select(&p, false)[1]);
    }

    #[test]
    fn transitive_tape_lifecycle_unknown_calls_and_recovery_reject_the_worker() {
        for symbol in [
            "ad.tape",
            "ad.backward",
            "ad.push-owned",
            "attempt",
            "task.yield",
            "foreign-call",
        ] {
            let mut p = program();
            p.funcs.push(function(
                vec![MT::con("std::I64")],
                MT::con("std::I64"),
                Body::Prim(symbol.into()),
            ));
            p.funcs.push(function(
                vec![MT::con("std::I64")],
                MT::con("std::I64"),
                Body::Expr(Expr::Call(2, vec![Expr::Local(0)])),
            ));
            let Body::Expr(body) = p.funcs[1].body.clone() else {
                unreachable!()
            };
            p.funcs[1].body = Body::Expr(Expr::Let(
                2,
                Box::new(Expr::Call(3, vec![Expr::Local(0)])),
                Box::new(body),
            ));
            assert!(!select(&p, false)[1], "{symbol}");
        }
    }

    #[test]
    fn traces_resources_recursion_and_wide_weights_cannot_keep_a_tape_pointer() {
        for kind in 0..5 {
            let mut p = program();
            let Body::Expr(body) = p.funcs[1].body.clone() else {
                unreachable!()
            };
            p.funcs[1].body = Body::Expr(match kind {
                0 => Expr::Trace(
                    SourcePoint {
                        names: vec![],
                        span: crate::diag::Span::DUMMY,
                        ty: MT::con("std::I64"),
                    },
                    Box::new(body),
                ),
                1 => Expr::ResourceRegion {
                    parameters: vec![],
                    bindings: vec![],
                    body: Box::new(body),
                },
                2 => Expr::Let(
                    2,
                    Box::new(Expr::Call(1, vec![Expr::Local(0), Expr::Local(1)])),
                    Box::new(body),
                ),
                3 => Expr::Let(
                    2,
                    Box::new(Expr::Apply(Box::new(Expr::Func(0)), vec![])),
                    Box::new(body),
                ),
                _ => {
                    p.funcs[1].locals[1] = MT::con("std::F128");
                    body
                }
            });
            assert!(!select(&p, false)[1], "{kind}");
        }
    }

    #[test]
    fn expression_budget_stops_large_proofs_and_type_checks_reject_mismatches() {
        let mut p = program();
        let Body::Expr(mut body) = p.funcs[1].body.clone() else {
            unreachable!()
        };
        for _ in 0..4096 {
            body = Expr::Let(2, Box::new(Expr::Const(Value::I64(0))), Box::new(body));
        }
        p.funcs[1].body = Body::Expr(body);
        assert!(!select(&p, false)[1]);
        let mut p = program();
        p.funcs[0].ty = MT::con("std::I64");
        assert!(!select(&p, false)[1]);
    }
}
