//! Escape analysis: which values a function only reads while it runs.
//!
//! A parameter does not escape when the function's body reads it only
//! through its fields, matches on it, copies it with fields replaced
//! (`SetFields`, which builds a new object), counts its references, or
//! passes it to a parameter of another function that does not escape
//! either. Anything else lets it escape: returning it, storing it in a
//! constructor, record or closure, handing it to a primitive, a C
//! function or a function value. A parameter passed on to the function
//! itself lives in a caller's frame, so it may; a value the function
//! builds may not go to the function itself, as a call of itself in tail
//! position is compiled as a jump, which reuses the frame that holds it.
//!
//! The C backend allocates a record or variant that does not escape on
//! the stack (`src/cgen.rs`): its fields are on the stack the collector
//! scans, and the runtime counts no references of a value off its heap.

use crate::ir::{Body, Expr, FuncId, Local, Pat, Program};

/// For each function, whether each parameter escapes (`false`: it does
/// not). Functions that are not expressions let every parameter escape.
pub fn params(prog: &Program) -> Vec<Vec<bool>> {
    let mut noesc: Vec<Vec<bool>> = prog
        .funcs
        .iter()
        .map(|f| vec![matches!(f.body, Body::Expr(_)); f.arity as usize])
        .collect();
    // the greatest fixed point: parameters escape only when shown to
    loop {
        let mut changed = false;
        for (id, f) in prog.funcs.iter().enumerate() {
            let Body::Expr(body) = &f.body else {
                continue;
            };
            for p in 0..f.arity as usize {
                if noesc[id][p] && escapes(body, p as Local, &noesc, None) {
                    noesc[id][p] = false;
                    changed = true;
                }
            }
        }
        if !changed {
            return noesc;
        }
    }
}

/// Whether the value of local `x` may outlive the evaluation of `e`, given
/// which parameters of each function do not escape. With `me`, `x` is in
/// the frame of function `me` (built there), and passing it to `me`
/// itself lets it escape.
pub fn escapes(e: &Expr, x: Local, noesc: &[Vec<bool>], me: Option<FuncId>) -> bool {
    let is_x = |e: &Expr| matches!(bare(e), Expr::Local(y) if *y == x);
    let go = |e: &Expr| escapes(e, x, noesc, me);
    match e {
        Expr::Local(y) => *y == x,
        Expr::Const(_) | Expr::Func(_) => false,
        Expr::Call(g, args) => args.iter().enumerate().any(|(j, a)| {
            if is_x(a) {
                Some(*g) == me || !noesc[*g].get(j).copied().unwrap_or(false)
            } else {
                go(a)
            }
        }),
        Expr::Apply(f, args) => go(f) || args.iter().any(go),
        Expr::Construct(_, args) | Expr::Record(args) => args.iter().any(go),
        Expr::Field(r, _) => !is_x(r) && go(r),
        Expr::SetFields(r, sets) => (!is_x(r) && go(r)) || sets.iter().any(|(_, s)| go(s)),
        Expr::Let(y, v, b) => {
            if is_x(v) {
                // `y` is another name for the value
                go(b) || escapes(b, *y, noesc, me)
            } else {
                go(v) || go(b)
            }
        }
        Expr::Match(s, arms) => {
            let scrut = if is_x(s) {
                arms.iter().any(|(p, b)| match p {
                    Pat::Bind(y) => escapes(b, *y, noesc, me),
                    _ => false,
                })
            } else {
                go(s)
            };
            scrut || arms.iter().any(|(_, b)| go(b))
        }
        Expr::Dup(_, b) | Expr::Drop(_, b) => go(b),
    }
}

/// `e` without the reference counts around it.
fn bare(mut e: &Expr) -> &Expr {
    while let Expr::Dup(_, b) | Expr::Drop(_, b) = e {
        e = b;
    }
    e
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::ir::{Func, MT};

    fn func(arity: u32, body: Expr) -> Func {
        Func {
            name: "f".into(),
            arity,
            locals: vec![MT::unit(); 8],
            ty: MT::unit(),
            body: Body::Expr(body),
        }
    }

    fn prog(funcs: Vec<Func>) -> Program {
        Program {
            funcs,
            ..Default::default()
        }
    }

    fn l(x: Local) -> Expr {
        Expr::Local(x)
    }

    #[test]
    fn reading_fields_does_not_escape() {
        let p = prog(vec![func(1, Expr::Field(Box::new(l(0)), 1))]);
        assert_eq!(params(&p), vec![vec![true]]);
    }

    #[test]
    fn returning_or_storing_escapes() {
        let p = prog(vec![
            func(1, l(0)),
            func(1, Expr::Record(vec![l(0)])),
            func(1, Expr::Let(1, Box::new(l(0)), Box::new(l(1)))),
        ]);
        assert_eq!(params(&p), vec![vec![false], vec![false], vec![false]]);
    }

    #[test]
    fn passing_on_follows_the_callee() {
        let p = prog(vec![
            func(1, Expr::Call(1, vec![l(0)])),
            func(1, Expr::Field(Box::new(l(0)), 0)),
            func(1, Expr::Call(3, vec![l(0)])),
            func(1, l(0)),
            // a parameter passed on to the function itself: in a caller's
            // frame
            func(1, Expr::Field(Box::new(Expr::Call(4, vec![l(0)])), 0)),
        ]);
        let n = params(&p);
        assert_eq!(n[0], vec![true]);
        assert_eq!(n[2], vec![false]);
        assert_eq!(n[4], vec![true]);
        // a value built in function 4 does not go to function 4
        let call = Expr::Call(4, vec![l(1)]);
        assert!(escapes(&call, 1, &n, Some(4)));
        assert!(!escapes(&call, 1, &n, Some(0)));
    }

    #[test]
    fn counts_around_an_argument_are_seen_through() {
        let dup = Expr::Dup(0, Box::new(l(0)));
        let p = prog(vec![
            func(1, Expr::Call(1, vec![dup.clone(), l(0)])),
            func(2, Expr::Field(Box::new(l(0)), 0)),
            func(1, Expr::Call(3, vec![dup])),
            func(1, Expr::Record(vec![l(0)])),
        ]);
        let n = params(&p);
        // f1 only reads its first parameter and ignores its second
        assert_eq!(n[0], vec![true]);
        // f3 stores its parameter in a record
        assert_eq!(n[2], vec![false]);
    }

    #[test]
    fn match_aliases_are_followed() {
        let arms = |b: Expr| vec![(Pat::Bind(1), b)];
        let p = prog(vec![
            func(
                1,
                Expr::Match(Box::new(l(0)), arms(Expr::Field(Box::new(l(1)), 0))),
            ),
            func(1, Expr::Match(Box::new(l(0)), arms(l(1)))),
        ]);
        assert_eq!(params(&p), vec![vec![true], vec![false]]);
    }
}
