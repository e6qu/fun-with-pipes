//! Prove which direct self calls can reuse their execution frame.
use crate::ir::*;
use std::collections::HashSet;

/// Immutable data can leave a frame without closing a resource or cancelling
/// an operation. Unknown captures and opaque handles need a stronger proof.
pub(crate) fn plain_data(shapes: &Shapes, ty: &MT, seen: &mut HashSet<MT>) -> bool {
    if !seen.insert(ty.clone()) {
        return true;
    }
    match ty {
        MT::Fun(..) => false,
        MT::Nat(_) => true,
        MT::Record(fields) => fields.iter().all(|(_, t)| plain_data(shapes, t, seen)),
        MT::Con(name, args) => {
            if !args.iter().all(|t| plain_data(shapes, t, seen)) {
                return false;
            }
            match name.as_str() {
                "std::Bool" | "std::String" | "std::Bytes" | "std::I8" | "std::I16"
                | "std::I32" | "std::I64" | "std::I128" | "std::ISize" | "std::U8" | "std::U16"
                | "std::U32" | "std::U64" | "std::U128" | "std::USize" | "std::F16"
                | "std::BF16" | "std::F32" | "std::F64" | "std::F128" | "std::TInt"
                | "std::Trit" | "std::Array" | "std::Map" | "std::Set" => true,
                _ => match shapes.get(ty) {
                    Some(TypeShape::Record(fields)) => {
                        fields.iter().all(|(_, t)| plain_data(shapes, t, seen))
                    }
                    Some(TypeShape::Adt(variants)) => variants
                        .iter()
                        .all(|(_, fields)| fields.iter().all(|t| plain_data(shapes, t, seen))),
                    _ => false,
                },
            }
        }
    }
}

/// Find direct self calls in tail positions without changing the expressions.
/// Calls that compute an argument, binding, scrutinee or returned calculation
/// keep ordinary frames. Both backends follow only these outer tail positions.
fn tail(e: &Expr, id: FuncId) -> Result<bool, &'static str> {
    match e {
        Expr::Call(callee, _) if *callee == id => Ok(true),
        Expr::Let(_, _, body) => tail(body, id),
        Expr::Match(_, arms) => {
            let mut found = false;
            for (_, body) in arms {
                found |= tail(body, id)?;
            }
            Ok(found)
        }
        Expr::ResourceRegion { .. } if crate::opt::calls(e, id) => {
            Err("resource cleanup must run after the recursive call")
        }
        Expr::Trace(..) if crate::opt::calls(e, id) => {
            Err("source debugger frames must remain observable")
        }
        _ => Ok(false),
    }
}

/// Both backends consume this proof. Keep the source-shaped IR so native
/// representation analysis can still pass records and variants as direct fields.
pub fn analyze(prog: &mut Program) {
    prog.self_tail.clear();
    for (id, f) in prog.funcs.iter().enumerate() {
        let Body::Expr(body) = &f.body else { continue };
        if !crate::opt::calls(body, id) {
            continue;
        }
        let candidate = tail(body, id).and_then(|found| {
            if !found {
                return Err("no direct self call returns without further work");
            }
            if f.arity == 0 {
                return Err("a cached value needs its initialization frame");
            }
            if !f
                .locals
                .iter()
                .all(|t| plain_data(&prog.shapes, t, &mut HashSet::new()))
            {
                return Err("the frame may own a resource, task, channel or unknown capture");
            }
            Ok(())
        });
        match candidate {
            Ok(()) => {
                prog.self_tail.insert(id);
                if std::env::var_os("FWP_DUMP_IR").is_some() {
                    eprintln!("self-tail recursion {}: frame loop", f.name);
                }
            }
            Err(reason) => {
                if std::env::var_os("FWP_DUMP_IR").is_some() {
                    eprintln!("self-tail recursion {}: ordinary calls ({reason})", f.name);
                }
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn mixed_calls_preserve_ordinary_argument_binding_and_scrutinee_calls() {
        let call = Expr::Call(0, vec![Expr::Local(0)]);
        for body in [
            Expr::Call(0, vec![call.clone()]),
            Expr::Let(1, Box::new(call.clone()), Box::new(call.clone())),
            Expr::Match(Box::new(call.clone()), vec![(Pat::Wild, call.clone())]),
            Expr::Match(
                Box::new(Expr::Local(0)),
                vec![
                    (
                        Pat::Lit(crate::value::Value::I64(0)),
                        Expr::Call(1, vec![call.clone()]),
                    ),
                    (Pat::Wild, call.clone()),
                ],
            ),
        ] {
            assert_eq!(tail(&body, 0), Ok(true));
        }
        assert_eq!(tail(&Expr::Call(1, vec![call.clone()]), 0), Ok(false));
        assert_eq!(tail(&Expr::Record(vec![call]), 0), Ok(false));
    }

    #[test]
    fn one_safe_branch_cannot_discard_another_branches_cleanup_or_trace() {
        let call = Expr::Call(0, vec![Expr::Local(0)]);
        for guarded in [
            Expr::ResourceRegion {
                parameters: vec![0],
                bindings: vec![],
                body: Box::new(call.clone()),
            },
            Expr::Trace(
                crate::ir::SourcePoint {
                    span: crate::diag::Span::DUMMY,
                    ty: MT::con("std::I64"),
                },
                Box::new(call.clone()),
            ),
        ] {
            let body = Expr::Match(
                Box::new(Expr::Local(0)),
                vec![
                    (Pat::Lit(crate::value::Value::I64(0)), call.clone()),
                    (Pat::Wild, guarded),
                ],
            );
            assert!(tail(&body, 0).is_err());
        }
    }
}
