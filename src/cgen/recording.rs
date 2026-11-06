//! A tape pointer may survive scalar appends, but not registry growth,
//! retirement, reentry or a task switch. Prove the whole closed worker first.
use crate::ir::*;
use crate::value::Value;

/// An ordinary call starts an independent state; it never borrows across a
/// caller whose complete lifetime proof is unknown. This C initializer has no
/// allocation, validation or observable effect of its own.
pub(super) const FRESH: &str = "&(fwp_ad_recording){-1, NULL}";

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(super) enum Mode {
    None,
    Local,
    Forward,
}

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
    if function.arity != 4 || !matches!(&function.body, Body::Prim(symbol) if symbol == "ad.push") {
        return false;
    }
    let mut ty = &function.ty;
    for expected in ["std::I64", "std::F64", "std::I64", "std::F64"] {
        let MT::Fun(parameter, result) = ty else {
            return false;
        };
        if !matches!(&**parameter, MT::Con(name, args) if name == expected && args.is_empty()) {
            return false;
        }
        ty = result;
    }
    matches!(ty, MT::Con(name, args) if name == "std::I64" && args.is_empty())
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
    scopes: bool,
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
        if function.arity > 4096 {
            self.facts[id] = Fact::Rejected;
            return None;
        }
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
                    if budget.saturating_sub(work.len()) < 2 {
                        return None;
                    }
                    work.extend([&**body, &**value]);
                }
                Expr::Record(fields) => {
                    if fields.len() > budget.saturating_sub(work.len()) {
                        return None;
                    }
                    work.extend(fields);
                }
                Expr::Field(value, _) => work.push(value),
                Expr::Call(callee, arguments) => {
                    let function = self.program.funcs.get(*callee)?;
                    if function.arity as usize != arguments.len() {
                        return None;
                    }
                    let direct_push = scalar_push(function);
                    let nested = self.function(*callee, budget, depth + 1)?;
                    if arguments.len() > budget.saturating_sub(work.len()) {
                        return None;
                    }
                    let added = if self.scopes && !direct_push {
                        nested
                    } else {
                        u8::from(direct_push)
                    };
                    pushes = (pushes + added).min(2);
                    work.extend(arguments);
                }
                Expr::Func(callee) if self.program.funcs.get(*callee)?.arity == 0 => {
                    let nested = self.function(*callee, budget, depth + 1)?;
                    if self.scopes {
                        pushes = (pushes + nested).min(2);
                    }
                }
                // Unknown calls, trace hooks and resource cleanup can reenter.
                // Keep branches and recursive workers outside this first proof.
                _ => return None,
            }
        }
        Some(pushes)
    }
}

pub(super) fn select(program: &Program, ticks: bool, scopes: bool) -> Vec<Mode> {
    if ticks {
        return vec![Mode::None; program.funcs.len()];
    }
    let mut proof = Proof {
        program,
        facts: vec![Fact::Unknown; program.funcs.len()],
        scopes,
    };
    if !scopes {
        return (0..program.funcs.len())
            .map(|id| match proof.function(id, &mut 4096, 0) {
                Some(2..) => Mode::Local,
                _ => Mode::None,
            })
            .collect();
    }
    let mut pending = Vec::new();
    for id in 0..program.funcs.len() {
        if matches!(proof.function(id, &mut 4096, 0), Some(2..)) {
            pending.push(id);
        }
        match &program.funcs[id].body {
            Body::PackedRecordPairs { callback, .. } | Body::PackedRecordFold { callback } => {
                pending.push(*callback);
            }
            _ => {}
        }
    }
    // A standalone single append cannot reuse a lookup. Only repeated workers
    // and the selected loops start scopes; their numeric callees borrow them.
    let mut modes = vec![Mode::None; program.funcs.len()];
    while let Some(id) = pending.pop() {
        if !matches!(proof.facts.get(id), Some(Fact::Numeric(1..))) || modes[id] == Mode::Forward {
            continue;
        }
        modes[id] = Mode::Forward;
        let Body::Expr(body) = &program.funcs[id].body else {
            unreachable!("only expression bodies have recording sites")
        };
        let mut work = vec![body];
        while let Some(expr) = work.pop() {
            match expr {
                Expr::Call(callee, arguments) => {
                    pending.push(*callee);
                    work.extend(arguments);
                }
                Expr::Func(callee) => pending.push(*callee),
                Expr::Let(_, value, body) => work.extend([&**value, &**body]),
                Expr::Record(fields) => work.extend(fields),
                Expr::Field(value, _) => work.push(value),
                _ => {}
            }
        }
    }
    modes
}

#[cfg(test)]
mod tests {
    use super::*;

    fn select(program: &Program, ticks: bool) -> Vec<bool> {
        super::select(program, ticks, false)
            .into_iter()
            .map(|mode| mode != Mode::None)
            .collect()
    }

    fn rejected(program: &Program, id: FuncId) {
        for scopes in [false, true] {
            assert_eq!(super::select(program, false, scopes)[id], Mode::None);
        }
    }

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
    fn nested_single_append_calls_forward_only_with_scopes_enabled() {
        let mut p = program();
        let Body::Expr(Expr::Let(_, first, _)) = p.funcs[1].body.clone() else {
            unreachable!()
        };
        p.funcs[1].body = Body::Expr(*first);
        for callee in [1, 2, 1] {
            p.funcs.push(function(
                vec![MT::con("std::I64"), MT::con("std::F64")],
                MT::con("std::I64"),
                Body::Expr(Expr::Call(callee, vec![Expr::Local(0), Expr::Local(1)])),
            ));
        }
        assert_eq!(super::select(&p, false, false), vec![Mode::None; 5]);
        assert_eq!(super::select(&p, false, true), vec![Mode::None; 5]);
        let call = |id| Expr::Call(id, vec![Expr::Local(0), Expr::Local(1)]);
        p.funcs.push(function(
            vec![MT::con("std::I64"), MT::con("std::F64")],
            MT::con("std::I64"),
            Body::Expr(Expr::Let(0, Box::new(call(3)), Box::new(call(4)))),
        ));
        assert_eq!(super::select(&p, false, false), vec![Mode::None; 6]);
        assert_eq!(
            super::select(&p, false, true),
            vec![
                Mode::None,
                Mode::Forward,
                Mode::Forward,
                Mode::Forward,
                Mode::Forward,
                Mode::Forward
            ]
        );
        assert_eq!(super::select(&p, true, true), vec![Mode::None; 6]);
    }

    #[test]
    fn zero_argument_numeric_calls_are_proved_without_changing_cache_semantics() {
        let mut p = program();
        p.funcs.push(function(
            vec![],
            MT::con("std::I64"),
            Body::Expr(Expr::Call(
                0,
                vec![
                    Expr::Const(Value::I64(-1)),
                    Expr::Const(Value::F64(0.5)),
                    Expr::Const(Value::I64(-1)),
                    Expr::Const(Value::F64(0.5)),
                ],
            )),
        ));
        p.funcs.push(function(
            vec![],
            MT::con("std::I64"),
            Body::Expr(Expr::Func(2)),
        ));
        assert_eq!(
            super::select(&p, false, false),
            vec![Mode::None, Mode::Local, Mode::None, Mode::None]
        );
        assert_eq!(
            super::select(&p, false, true),
            vec![Mode::None, Mode::Forward, Mode::None, Mode::None]
        );
        let mut repeated = function(
            vec![],
            MT::con("std::I64"),
            Body::Expr(Expr::Let(
                0,
                Box::new(Expr::Func(3)),
                Box::new(Expr::Func(3)),
            )),
        );
        repeated.locals.push(MT::con("std::I64"));
        p.funcs.push(repeated);
        assert_eq!(
            super::select(&p, false, true),
            vec![
                Mode::None,
                Mode::Forward,
                Mode::Forward,
                Mode::Forward,
                Mode::Forward
            ]
        );
    }

    #[test]
    fn only_selected_loops_seed_single_append_callbacks() {
        for body in [
            Body::PackedRecordPairs {
                callback: 1,
                tail_slot: 0,
            },
            Body::PackedRecordFold { callback: 1 },
        ] {
            let mut p = program();
            let Body::Expr(Expr::Let(_, first, _)) = p.funcs[1].body.clone() else {
                unreachable!()
            };
            p.funcs[1].body = Body::Expr(*first);
            p.funcs.push(function(vec![], MT::con("std::I64"), body));
            assert_eq!(super::select(&p, false, false), vec![Mode::None; 3]);
            assert_eq!(
                super::select(&p, false, true),
                vec![Mode::None, Mode::Forward, Mode::None]
            );
            assert_eq!(super::select(&p, true, true), vec![Mode::None; 3]);
            p.funcs[2].body = Body::PackedRecordMap { callback: 1 };
            assert_eq!(super::select(&p, false, true), vec![Mode::None; 3]);
            p.funcs[2].body = Body::PackedRecordFold { callback: 100 };
            assert_eq!(super::select(&p, false, true), vec![Mode::None; 3]);
        }
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
        for id in 2..66 {
            p.funcs.push(function(
                vec![MT::con("std::I64")],
                MT::con("std::I64"),
                Body::Expr(Expr::Call(id + 1, vec![Expr::Local(0)])),
            ));
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
        rejected(&p, 1);
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
            rejected(&p, 1);
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
            rejected(&p, 1);
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
        rejected(&p, 1);
        let mut p = program();
        p.funcs[0].ty = MT::con("std::I64");
        rejected(&p, 1);
    }
}
