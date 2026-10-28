//! Prove which direct self calls can reuse their execution frame.
use crate::ir::*;
use std::collections::HashSet;

mod pairs;

/// Lower eligible scalar mutual pairs before proving frame reuse. Kept separate
/// from `analyze` so tests can compare the same typed IR with ordinary calls.
pub fn lower_pairs(prog: &mut Program) {
    pairs::lower(prog);
}

/// Values whose release cannot close a resource or cancel an operation.
/// Weak handles own expiration metadata, not the target or its payload.
/// Unknown captures and other opaque handles need a stronger proof.
pub(crate) fn plain_data(shapes: &Shapes, ty: &MT, seen: &mut HashSet<MT>) -> bool {
    if !seen.insert(ty.clone()) {
        return true;
    }
    match ty {
        MT::Fun(..) => false,
        MT::Nat(_) => true,
        MT::Record(fields) => fields.iter().all(|(_, t)| plain_data(shapes, t, seen)),
        // Inspect this before the type arguments: WeakChannel[Task[a]] owns
        // neither a task nor the channel that carries it. Both runtimes release
        // only metadata here. An upgrade's strong owner remains ineligible.
        MT::Con(name, args) if name == "std::WeakChannel" => args.len() == 1,
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

// Inlining leaves unused type-table slots behind. They own no runtime value.
// Inspect every remaining read and binding (including unused bound values),
// while the caller separately checks all parameters, even unused parameters.
fn plain_frame(e: &Expr, safe: &[bool]) -> bool {
    fn pattern(p: &Pat, safe: &[bool]) -> bool {
        match p {
            Pat::Bind(l) => safe[*l as usize],
            Pat::Construct(_, ps) | Pat::Record(ps) => ps.iter().all(|p| pattern(p, safe)),
            Pat::Wild | Pat::Lit(_) => true,
        }
    }
    let visit = |e| plain_frame(e, safe);
    match e {
        Expr::Local(l) => safe[*l as usize],
        Expr::Let(l, a, b) => safe[*l as usize] && visit(a) && visit(b),
        Expr::ResourceRegion {
            parameters,
            bindings,
            body,
        } => parameters.iter().chain(bindings).all(|l| safe[*l as usize]) && visit(body),
        Expr::Dup(l, b) | Expr::Drop(l, b) | Expr::BorrowGlobal(l, _, b) => {
            safe[*l as usize] && visit(b)
        }
        Expr::Trace(_, b) | Expr::Field(b, _) => visit(b),
        Expr::Call(_, args) | Expr::Construct(_, args) | Expr::Record(args) => {
            args.iter().all(visit)
        }
        Expr::Apply(f, args) => visit(f) && args.iter().all(visit),
        Expr::SetFields(base, fields) => {
            visit(base) && fields.iter().all(|(_, value)| visit(value))
        }
        Expr::Match(value, arms) => {
            visit(value) && arms.iter().all(|(p, body)| pattern(p, safe) && visit(body))
        }
        Expr::Const(_) | Expr::Func(_) => true,
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
            let safe: Vec<bool> = f
                .locals
                .iter()
                .map(|t| plain_data(&prog.shapes, t, &mut HashSet::new()))
                .collect();
            if !safe[..f.arity as usize].iter().all(|safe| *safe) || !plain_frame(body, &safe) {
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
    fn weak_metadata_can_leave_a_frame_but_its_target_owners_cannot() {
        let integer = MT::con("std::I64");
        let callback = MT::Fun(Box::new(integer.clone()), Box::new(integer.clone()));
        for payload in [
            integer.clone(),
            callback,
            MT::con("std::File"),
            MT::Con("std::Task".into(), vec![integer]),
        ] {
            let weak = MT::Con("std::WeakChannel".into(), vec![payload.clone()]);
            let strong = MT::Con("std::Channel".into(), vec![payload]);
            for ty in [weak.clone(), MT::Record(vec![("link".into(), weak)])] {
                let mut program = Program::default();
                program.funcs.push(Func {
                    name: "carry".into(),
                    arity: 1,
                    locals: vec![ty.clone()],
                    ty: MT::Fun(Box::new(ty.clone()), Box::new(ty)),
                    body: Body::Expr(Expr::Call(0, vec![Expr::Local(0)])),
                });
                analyze(&mut program);
                assert!(program.self_tail.contains(&0));
                // A strong value created by upgrade still prevents reuse,
                // even when the recursive argument itself is only weak.
                program.funcs[0].locals.push(strong.clone());
                // A leftover type-table entry is not an allocated owner.
                analyze(&mut program);
                assert!(program.self_tail.contains(&0));
                let input = program.funcs[0].locals[0].clone();
                program.funcs.push(Func {
                    name: "new-owner".into(),
                    arity: 1,
                    ty: MT::Fun(Box::new(input.clone()), Box::new(strong.clone())),
                    locals: vec![input],
                    body: Body::Prim("fixture-owner".into()),
                });
                let body = Expr::Let(
                    1,
                    Box::new(Expr::Call(1, vec![Expr::Local(0)])),
                    Box::new(Expr::Call(0, vec![Expr::Local(0)])),
                );
                program.funcs[0].body = Body::Expr(body);
                crate::ir::check_locals(&program).unwrap();
                analyze(&mut program);
                assert!(program.self_tail.is_empty());
            }
        }
        assert!(!plain_data(
            &Shapes::new(),
            &MT::Con("std::WeakChannel".into(), vec![]),
            &mut HashSet::new(),
        ));
    }

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
