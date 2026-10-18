//! Lower proved direct self recursion to the existing typed loop operation.
//!
//! No new runtime continuation, calling convention or source syntax is needed.
//! The ordinary loop backend handles moves, cleanup and scheduling safe points.
use crate::ir::*;
use std::collections::HashSet;

/// Immutable data can leave a frame without closing a resource or cancelling
/// an operation. Unknown captures and opaque handles need a stronger proof.
fn plain_data(shapes: &Shapes, ty: &MT, seen: &mut HashSet<MT>) -> bool {
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

fn state(args: Vec<Expr>) -> Expr {
    if args.len() == 1 {
        args.into_iter().next().unwrap()
    } else {
        Expr::Record(args)
    }
}

/// Only the last result changes. Argument expressions remain in their original
/// order, with fresh iteration locals; swaps cannot overwrite pending arguments.
fn step(e: &Expr, id: FuncId) -> Result<Expr, &'static str> {
    match e {
        Expr::Call(callee, args) if *callee == id => {
            if args.iter().any(|a| crate::opt::calls(a, id)) {
                return Err("a recursive call computes another call's argument");
            }
            Ok(Expr::Construct(0, vec![state(args.clone())]))
        }
        Expr::Let(l, value, body) if !crate::opt::calls(value, id) => {
            Ok(Expr::Let(*l, value.clone(), Box::new(step(body, id)?)))
        }
        Expr::Match(scrutinee, arms) if !crate::opt::calls(scrutinee, id) => Ok(Expr::Match(
            scrutinee.clone(),
            arms.iter()
                .map(|(pattern, body)| Ok((pattern.clone(), step(body, id)?)))
                .collect::<Result<_, &'static str>>()?,
        )),
        Expr::ResourceRegion { .. } if crate::opt::calls(e, id) => {
            Err("resource cleanup must run after the recursive call")
        }
        Expr::Trace(..) if crate::opt::calls(e, id) => {
            Err("source debugger frames must remain observable")
        }
        _ if crate::opt::calls(e, id) => {
            Err("a self reference escapes or has work remaining after its call")
        }
        _ => Ok(Expr::Construct(1, vec![e.clone()])),
    }
}

/// A function is transformed only when every self reference is a direct tail
/// call and its frame holds plain data. Other functions keep ordinary calls.
/// FWP_DUMP_IR explains the decision alongside the existing IR listing.
pub fn lower(prog: &mut Program) {
    let count = prog.funcs.len();
    for id in 0..count {
        let f = &prog.funcs[id];
        let Body::Expr(body) = &f.body else { continue };
        if !crate::opt::calls(body, id) {
            continue;
        }
        let candidate = step(body, id).and_then(|body| {
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
            Ok(body)
        });
        let body = match candidate {
            Ok(body) => body,
            Err(reason) => {
                if std::env::var_os("FWP_DUMP_IR").is_some() {
                    eprintln!("self-tail recursion {}: ordinary calls ({reason})", f.name);
                }
                continue;
            }
        };
        let arity = f.arity as usize;
        let (parameters, result) = f.ty.params(arity);
        let result = result.clone();
        let state_ty = if arity == 1 {
            parameters[0].clone()
        } else {
            MT::Record(
                parameters
                    .iter()
                    .enumerate()
                    .map(|(i, t)| (i.to_string(), (*t).clone()))
                    .collect(),
            )
        };
        let step_result = MT::Con("std::Step".into(), vec![state_ty.clone(), result.clone()]);
        prog.shapes.entry(step_result.clone()).or_insert_with(|| {
            TypeShape::Adt(vec![
                ("Again".into(), vec![state_ty.clone()]),
                ("Stop".into(), vec![result.clone()]),
            ])
        });
        let step_ty = MT::Fun(Box::new(state_ty.clone()), Box::new(step_result));
        let renamed: Vec<_> = (0..f.nlocals()).map(|l| Some(Expr::Local(l + 1))).collect();
        let mut body = crate::opt::substitute(&body, &renamed);
        for i in (0..arity).rev() {
            let field = if arity == 1 {
                Expr::Local(0)
            } else {
                Expr::Field(Box::new(Expr::Local(0)), i as u32)
            };
            body = Expr::Let(i as u32 + 1, Box::new(field), Box::new(body));
        }
        let mut locals = vec![state_ty.clone()];
        locals.extend(f.locals.clone());
        let name = format!("{}-self-tail-step", f.name);
        let (body, locals) = crate::opt::simplify(&prog.funcs, &prog.shapes, body, locals);
        let step_id = prog.funcs.len();
        prog.funcs.push(Func {
            name,
            arity: 1,
            locals,
            ty: step_ty.clone(),
            body: Body::Expr(body),
        });
        let loop_ty = MT::Fun(
            Box::new(step_ty),
            Box::new(MT::Fun(Box::new(state_ty), Box::new(result))),
        );
        let loop_id = match prog
            .funcs
            .iter()
            .position(|f| matches!(&f.body, Body::Prim(s) if s == "loop") && f.ty == loop_ty)
        {
            Some(id) => id,
            None => {
                let id = prog.funcs.len();
                prog.funcs.push(Func {
                    name: "loop".into(),
                    arity: 2,
                    locals: loop_ty.params(2).0.into_iter().cloned().collect(),
                    ty: loop_ty,
                    body: Body::Prim("loop".into()),
                });
                id
            }
        };
        let f = &mut prog.funcs[id];
        f.body = Body::Expr(Expr::Call(
            loop_id,
            vec![
                Expr::Func(step_id),
                state((0..f.arity).map(Expr::Local).collect()),
            ],
        ));
        f.locals.truncate(arity);
        if std::env::var_os("FWP_DUMP_IR").is_some() {
            eprintln!("self-tail recursion {}: typed loop", f.name);
        }
    }
}
