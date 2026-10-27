//! Prove that a local allocation has one owner until its explicit destruction.
//!
//! This consumes verified ownership IR. It does not infer that an arbitrary
//! nonescaping value is unique: temporary aliases, Dup, consuming calls and
//! unknown boundaries all retain their counted representation.

use crate::ir::{Body, Expr, FuncId, Local, Program};
use crate::ownership::{self, Argument};

/// A nonescaping borrowed call cannot create an independent owner of its input.
/// The nonescape table and ownership calling convention are both required.
fn borrows(prog: &Program, noescape: &[Vec<bool>], id: FuncId, index: usize) -> bool {
    noescape[id].get(index) == Some(&true)
        && match &prog.funcs[id].body {
            Body::Prim(symbol) => ownership::primitive(symbol)
                .is_some_and(|contract| contract.argument(index) == Argument::Borrow),
            Body::Expr(_) => prog
                .borrowed_parameters
                .get(&id)
                .is_some_and(|parameters| parameters.contains(&(index as Local))),
            _ => false,
        }
}

/// Every normal path must release the local exactly once. Sequential expression
/// evaluation and independent match arms preserve that owner's live/dead state.
/// Failure cleanup is supplied separately by the verified call-liveness map.
pub(crate) fn local_lifetime(
    prog: &Program,
    noescape: &[Vec<bool>],
    body: &Expr,
    local: Local,
) -> bool {
    fn visit(
        prog: &Program,
        noescape: &[Vec<bool>],
        e: &Expr,
        local: Local,
        live: bool,
    ) -> Option<bool> {
        let next = |e, live| visit(prog, noescape, e, local, live);
        match e {
            Expr::Local(value) if *value == local => None,
            Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => Some(live),
            Expr::Call(id, arguments) => {
                let mut live = live;
                let mut borrowed_argument = false;
                for (index, argument) in arguments.iter().enumerate() {
                    if matches!(argument, Expr::Local(value) if *value == local) {
                        borrowed_argument = true;
                        if !live || !borrows(prog, noescape, *id, index) {
                            return None;
                        }
                    } else {
                        live = next(argument, live)?;
                    }
                }
                if borrowed_argument && !live {
                    return None;
                }
                Some(live)
            }
            Expr::Let(binding, value, body) => {
                if *binding == local {
                    return None;
                }
                next(body, next(value, live)?)
            }
            Expr::Match(value, arms) => {
                let live = next(value, live)?;
                let mut result = None;
                for (_, body) in arms {
                    let after = next(body, live)?;
                    if result.is_some_and(|previous| previous != after) {
                        return None;
                    }
                    result = Some(after);
                }
                result
            }
            Expr::Dup(value, _) if *value == local => None,
            Expr::Drop(value, body) if *value == local => {
                live.then_some(())?;
                next(body, false)
            }
            Expr::Dup(_, body) | Expr::Drop(_, body) | Expr::Trace(_, body) => next(body, live),
            Expr::BorrowGlobal(binding, _, body) if *binding != local => next(body, live),
            Expr::BorrowGlobal(..) | Expr::ResourceRegion { .. } => None,
            Expr::Record(values) | Expr::Construct(_, values) => values
                .iter()
                .try_fold(live, |live, value| next(value, live)),
            Expr::Apply(function, arguments) => arguments
                .iter()
                .try_fold(next(function, live)?, |live, value| next(value, live)),
            Expr::Field(value, _) => next(value, live),
            Expr::SetFields(value, fields) => fields
                .iter()
                .try_fold(next(value, live)?, |live, (_, value)| next(value, live)),
        }
    }
    visit(prog, noescape, body, local, true) == Some(false)
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::ir::{Func, Pat, MT};
    use crate::value::Value;

    fn unit() -> Expr {
        Expr::Const(Value::unit())
    }

    fn release(body: Expr) -> Expr {
        Expr::Drop(0, Box::new(body))
    }

    fn read() -> Expr {
        Expr::Call(0, vec![Expr::Local(0)])
    }

    fn program() -> Program {
        Program {
            funcs: vec![Func {
                name: "array.length".into(),
                arity: 1,
                locals: vec![MT::unit()],
                ty: MT::unit(),
                body: Body::Prim("array.length".into()),
            }],
            ..Default::default()
        }
    }

    fn accepted(body: Expr) -> bool {
        local_lifetime(&program(), &[vec![true]], &body, 0)
    }

    #[test]
    fn reads_then_one_release_on_each_branch() {
        let body = Expr::Let(
            1,
            Box::new(read()),
            Box::new(Expr::Match(
                Box::new(unit()),
                vec![
                    (Pat::Bind(2), release(unit())),
                    (Pat::Bind(3), release(unit())),
                ],
            )),
        );
        assert!(accepted(body));
        assert!(!accepted(Expr::Match(
            Box::new(unit()),
            vec![(Pat::Bind(2), release(unit())), (Pat::Bind(3), unit()),]
        )));
    }

    #[test]
    fn rejects_aliases_capture_return_and_count_changes() {
        for body in [
            Expr::Local(0),
            Expr::Let(1, Box::new(Expr::Local(0)), Box::new(release(unit()))),
            Expr::Record(vec![Expr::Local(0)]),
            Expr::Apply(Box::new(Expr::Func(0)), vec![Expr::Local(0)]),
            Expr::Dup(0, Box::new(release(unit()))),
            release(release(unit())),
            release(read()),
        ] {
            assert!(!accepted(body));
        }
    }

    #[test]
    fn a_borrow_must_survive_later_argument_evaluation() {
        let mut prog = program();
        prog.funcs[0].body = Body::Expr(unit());
        prog.funcs[0].arity = 2;
        prog.borrowed_parameters.insert(0, vec![0]);
        let body = Expr::Call(0, vec![Expr::Local(0), release(unit())]);
        assert!(!local_lifetime(&prog, &[vec![true, false]], &body, 0));
    }

    #[test]
    fn nonescape_and_borrow_are_separate_requirements() {
        let body = Expr::Let(1, Box::new(read()), Box::new(release(unit())));
        let mut prog = program();
        assert!(!local_lifetime(&prog, &[vec![false]], &body, 0));
        prog.funcs[0].body = Body::Expr(unit());
        assert!(!local_lifetime(&prog, &[vec![true]], &body, 0));
        prog.borrowed_parameters.insert(0, vec![0]);
        assert!(local_lifetime(&prog, &[vec![true]], &body, 0));
    }
}
