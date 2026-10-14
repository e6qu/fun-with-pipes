//! Eligibility for explicitly requested native reference-counted execution.
//! Mutable runtime graphs and unmodeled external owners require tracing.
use crate::ir::{Body, Program, TypeShape, MT};
use crate::ownership::{Argument, Callback, ResultOwnership};
use std::collections::HashSet;

fn value_type(prog: &Program, ty: &MT, seen: &mut HashSet<MT>) -> Result<(), String> {
    if !seen.insert(ty.clone()) {
        return Ok(());
    }
    match ty {
        MT::Nat(_) => Ok(()),
        MT::Fun(a, b) => {
            value_type(prog, a, seen)?;
            value_type(prog, b, seen)
        }
        MT::Record(fields) => {
            for (_, field) in fields {
                value_type(prog, field, seen)?;
            }
            Ok(())
        }
        MT::Con(name, args) => {
            for arg in args {
                value_type(prog, arg, seen)?;
            }
            match name.as_str() {
                "std::Bool" | "std::String" | "std::Bytes" | "std::File" | "std::I8"
                | "std::I16" | "std::I32" | "std::I64" | "std::I128" | "std::ISize" | "std::U8"
                | "std::U16" | "std::U32" | "std::U64" | "std::U128" | "std::USize"
                | "std::F16" | "std::BF16" | "std::F32" | "std::F64" | "std::F128"
                | "std::TInt" | "std::Trit" | "std::Array" | "std::Map" | "std::Set"
                | "std::Task" => return Ok(()),
                _ => {}
            }
            match prog.shapes.get(ty) {
                Some(TypeShape::Record(fields)) => {
                    for (_, field) in fields {
                        value_type(prog, field, seen)?;
                    }
                }
                Some(TypeShape::Adt(variants)) => {
                    for (_, fields) in variants {
                        for field in fields {
                            value_type(prog, field, seen)?;
                        }
                    }
                }
                _ => {
                    return Err(format!(
                        "type `{ty}` has no tracing-free ownership contract"
                    ))
                }
            }
            Ok(())
        }
    }
}

pub(crate) fn check(prog: &Program) -> Result<(), String> {
    if let Some(name) = prog.unchecked_native_declarations.first() {
        return Err(format!(
            "--gc arc: native declaration `{name}` has no checked ownership signature"
        ));
    }
    crate::arc_scope::check(prog)?;
    let mut seen = HashSet::new();
    for f in &prog.funcs {
        let reject = |reason: String| format!("--gc arc: `{}`: {reason}", f.name);
        value_type(prog, &f.ty, &mut seen).map_err(reject)?;
        for ty in &f.locals {
            value_type(prog, ty, &mut seen).map_err(reject)?;
        }
        let symbol = match &f.body {
            Body::Expr(_) | Body::Ctor(_) => continue,
            Body::ForeignC { .. } => {
                let (params, result) = crate::ffi::signature(prog, f).map_err(reject)?;
                // Scalar C values carry no language owners or callable
                // addresses. The foreign function may retain their bits, but
                // cannot thereby extend a managed value's lifetime. Use the
                // actual ABI classification, not just `needs_rc`: raw pointers
                // are uncounted too, yet can hide managed owners.
                let scalar = crate::ffi::by_value;
                if params.iter().all(|(_, ty)| scalar(ty)) && scalar(&result) {
                    continue;
                }
                return Err(reject(
                    "foreign boundary has no checked ownership contract for non-scalar values"
                        .into(),
                ));
            }
            Body::Remote(_) => {
                return Err(reject("remote boundaries require tracing".into()));
            }
            Body::Prim(symbol) => symbol.as_str(),
        };
        // Child tasks get fresh dynamic scopes (proved above); their immutable
        // captures can only refer to already-created handles. Channels and raw
        // addresses can publish a mutable back-edge and remain excluded.
        if symbol.starts_with("channel.")
            || symbol.starts_with("mem.")
            || symbol.starts_with("ptr.")
        {
            return Err(reject(format!(
                "primitive `{symbol}` has no tracing-free lifetime policy"
            )));
        }
        let (args, result) = f.ty.params(f.arity as usize);
        if let Some(contract) = crate::ownership::primitive(symbol) {
            if matches!(
                contract.callback,
                Some(Callback::Shared(_) | Callback::Retained(_))
            ) && !matches!(symbol, "task.spawn" | "task.within")
            {
                return Err(reject(format!(
                    "primitive `{symbol}` retains an unproved callback graph"
                )));
            }
            for (index, arg) in args.iter().enumerate() {
                if contract.argument(index) == Argument::Share
                    && crate::rc::needs_rc(&prog.shapes, arg)
                {
                    return Err(reject(format!(
                        "primitive `{symbol}` shares argument {index}"
                    )));
                }
            }
            if matches!(contract.result, ResultOwnership::Shared)
                && crate::rc::needs_rc(&prog.shapes, result)
            {
                return Err(reject(format!(
                    "primitive `{symbol}` returns an uncounted owner"
                )));
            }
            continue;
        }
        // Concrete word-sized arithmetic emits no managed allocation. Wider
        // boxed numerics need their own counted-result contract before admission.
        let arithmetic = matches!(
            symbol,
            "trit.from-sign"
                | "trit.to-int"
                | "tint.to-int"
                | "prim.add"
                | "prim.sub"
                | "prim.mul"
                | "prim.div"
                | "prim.rem"
                | "prim.neg"
                | "prim.zero"
                | "prim.one"
                | "prim.from-int"
                | "prim.from-float"
                | "int.to-float"
                | "float.convert"
                | "sqrt"
                | "exp"
                | "ln"
                | "sin"
                | "cos"
                | "tan"
                | "floor"
                | "ceil"
                | "round"
                | "pow"
                | "abs"
        );
        if arithmetic
            && !crate::rc::needs_rc(&prog.shapes, result)
            && args
                .iter()
                .all(|arg| !crate::rc::needs_rc(&prog.shapes, arg))
        {
            continue;
        }
        return Err(reject(format!(
            "primitive `{symbol}` has no tracing-free ownership contract"
        )));
    }
    Ok(())
}
