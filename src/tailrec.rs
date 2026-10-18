//! Prove which direct self calls can reuse their execution frame.
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

/// Check tail positions without hiding the original expressions from native
/// record/variant and wide-number representation selection.
fn tail(e: &Expr, id: FuncId) -> Result<(), &'static str> {
    match e {
        Expr::Call(callee, args) if *callee == id => {
            if args.iter().any(|a| crate::opt::calls(a, id)) {
                return Err("a recursive call computes another call's argument");
            }
            Ok(())
        }
        Expr::Let(_, value, body) if !crate::opt::calls(value, id) => tail(body, id),
        Expr::Match(scrutinee, arms) if !crate::opt::calls(scrutinee, id) => {
            for (_, body) in arms {
                tail(body, id)?;
            }
            Ok(())
        }
        Expr::ResourceRegion { .. } if crate::opt::calls(e, id) => {
            Err("resource cleanup must run after the recursive call")
        }
        Expr::Trace(..) if crate::opt::calls(e, id) => {
            Err("source debugger frames must remain observable")
        }
        _ if crate::opt::calls(e, id) => {
            Err("a self reference escapes or has work remaining after its call")
        }
        _ => Ok(()),
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
        let candidate = tail(body, id).and_then(|()| {
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
