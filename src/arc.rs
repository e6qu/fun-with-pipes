//! Eligibility for explicitly requested reference-counted execution.
//! Unproved mutable ownership and external lifetimes are rejected.
use crate::ir::{Body, Program, TypeShape, MT};
use crate::ownership::{Argument, Callback, ResultOwnership};
use std::collections::HashSet;

/// Producer contract for channel arguments supplied by an entry's caller.
#[derive(Clone, Copy, PartialEq, Eq)]
pub(crate) enum EntryChannels {
    Unknown,
    GrpcResponses,
}

/// Prove that a queue's payload cannot reach another channel of the same type.
/// `value_type` checks each reachable channel type independently, so every cycle
/// through a queue is rejected, including cycles inside a nested queue. Immutable
/// recursive types may repeat; `seen` bounds each search to the reachable type
/// graph. Function captures have a separate value-flow proof in arc_scope;
/// task computations/results use that proof too; streams still lack a contract.
fn channel_payload(
    prog: &Program,
    ty: &MT,
    channel: &MT,
    seen: &mut HashSet<MT>,
    path: &str,
) -> Result<(), String> {
    if ty == channel {
        return Err(format!(
            "{path}: a queue can lead back to channel type `{channel}`"
        ));
    }
    if !seen.insert(ty.clone()) {
        return Ok(());
    }
    match ty {
        MT::Fun(..) => Ok(()),
        MT::Nat(_) => Ok(()),
        MT::Record(fields) => {
            for (name, ty) in fields {
                channel_payload(prog, ty, channel, seen, &format!("{path}.{name}"))?;
            }
            Ok(())
        }
        MT::Con(name, args) => {
            let reason = match name.as_str() {
                "std::H2Stream" => Some("stream handler captures can retain the receiving channel"),
                _ => None,
            };
            if let Some(reason) = reason {
                return Err(format!("{path}: {reason}"));
            }
            for (i, ty) in args.iter().enumerate() {
                channel_payload(
                    prog,
                    ty,
                    channel,
                    seen,
                    &format!("{path}.{}[{i}]", name.trim_start_matches("std::")),
                )?;
            }
            match prog.shapes.get(ty) {
                Some(TypeShape::Record(fields)) => {
                    for (name, ty) in fields {
                        channel_payload(prog, ty, channel, seen, &format!("{path}.{name}"))?;
                    }
                }
                Some(TypeShape::Adt(variants)) => {
                    for (name, fields) in variants {
                        for (i, ty) in fields.iter().enumerate() {
                            channel_payload(
                                prog,
                                ty,
                                channel,
                                seen,
                                &format!("{path}.{name}[{i}]"),
                            )?;
                        }
                    }
                }
                _ => {}
            }
            Ok(())
        }
    }
}

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
                "std::Channel" => {
                    let [payload] = args.as_slice() else {
                        return Err(format!("channel type `{ty}` requires one payload type"));
                    };
                    return channel_payload(prog, payload, ty, &mut HashSet::new(), "payload").map_err(|path| format!(
                        "type `{ty}` has no tracing-free ownership contract: channel payloads cannot contain HTTP stream handles or recursive channel ownership\n  {path}\n  This is a missing cycle-freedom proof, not a demonstrated cycle. Keep callbacks and handles with an independent owner; queue data or non-owning IDs instead."
                    ));
                }
                "std::Bool" | "std::String" | "std::Bytes" | "std::File" | "std::UdpSocket"
                | "std::Conn" | "std::Listener" | "std::I8" | "std::I16" | "std::I32"
                | "std::I64" | "std::I128" | "std::ISize" | "std::U8" | "std::U16" | "std::U32"
                | "std::U64" | "std::U128" | "std::USize" | "std::F16" | "std::BF16"
                | "std::F32" | "std::F64" | "std::F128" | "std::TInt" | "std::Trit"
                | "std::Array" | "std::Map" | "std::Set" | "std::Task" | "std::GrpcCell"
                | "std::H2Stream" => return Ok(()),
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

pub(crate) fn check(
    prog: &Program,
    entries: &[crate::ir::FuncId],
    entry_channels: EntryChannels,
) -> Result<(), String> {
    if let Some(name) = prog.unchecked_native_declarations.first() {
        return Err(format!(
            "--gc arc: native declaration `{name}` has no checked ownership signature"
        ));
    }
    crate::arc_scope::check(prog, entries, entry_channels)?;
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
                // Check the actual C ABI: scoped borrows and copied results
                // cannot publish managed pointers after this call returns.
                // Raw pointers and callbacks returning managed C addresses
                // still lack a checked retention policy.
                if params.iter().all(|(_, ty)| crate::ffi::scoped_argument(ty))
                    && crate::ffi::copied_result(&result)
                {
                    continue;
                }
                return Err(reject(
                    "foreign boundary has no checked ownership contract for escaping pointers or callbacks"
                        .into(),
                ));
            }
            Body::Remote(remote) => {
                let shape = crate::rpc::shape(&f.ty, f.arity as usize, remote.error.as_ref());
                // Messages contain encoded data, never managed pointers or
                // callable captures. Input continuations and returned iterator
                // scopes were checked above; typed runtime owners cover the
                // request, connection, cursor and detached sender lifetimes.
                for ty in shape.wire_types(remote.error.as_ref()) {
                    crate::protobuf::check_encodable(prog, &ty).map_err(reject)?;
                }
                continue;
            }
            Body::Prim(symbol) => symbol.as_str(),
        };
        // Child tasks get fresh dynamic scopes (proved above). Channel payloads
        // cannot hold handles/captures that publish a mutable back-edge. Raw
        // addresses still have no checked pointee lifetime.
        if symbol.starts_with("mem.") || symbol.starts_with("ptr.") {
            return Err(reject(format!(
                "primitive `{symbol}` has no tracing-free lifetime policy"
            )));
        }
        let (args, result) = f.ty.params(f.arity as usize);
        if let Some(contract) = crate::ownership::primitive(symbol) {
            if matches!(
                contract.callback,
                Some(Callback::Shared(_) | Callback::Retained(_))
            ) && !matches!(symbol, "task.spawn" | "task.within" | "http2.serve")
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
        return Err(reject(format!(
            "primitive `{symbol}` has no tracing-free ownership contract"
        )));
    }
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;

    fn channel(payload: MT) -> MT {
        MT::Con("std::Channel".into(), vec![payload])
    }

    #[test]
    fn nested_queues_and_recursive_immutable_containers_are_acyclic() {
        let mut prog = Program::default();
        let tree = MT::con("Tree");
        prog.shapes.insert(
            tree.clone(),
            TypeShape::Adt(vec![
                ("Leaf".into(), vec![channel(MT::con("std::String"))]),
                ("Branch".into(), vec![tree.clone(), tree.clone()]),
            ]),
        );
        for payload in [MT::con("std::String"), tree] {
            let mut ty = payload;
            for _ in 0..8 {
                ty = channel(ty);
                value_type(&prog, &ty, &mut HashSet::new()).unwrap();
            }
        }
    }

    #[test]
    fn recursive_queue_edges_are_rejected_even_through_an_earlier_sibling() {
        let mut prog = Program::default();
        let a = MT::con("A");
        let b = MT::con("B");
        let c = MT::con("C");
        // A -> B -> A is immutable. The later A -> Channel[C] -> C -> B
        // edge makes a queue cycle. A global "already safe" cache during a
        // single traversal would incorrectly accept the second visit to B.
        prog.shapes.insert(
            a.clone(),
            TypeShape::Record(vec![
                ("first".into(), b.clone()),
                ("queue".into(), channel(c.clone())),
            ]),
        );
        prog.shapes
            .insert(b.clone(), TypeShape::Record(vec![("a".into(), a.clone())]));
        prog.shapes
            .insert(c.clone(), TypeShape::Record(vec![("b".into(), b)]));
        for root in [a, channel(c.clone()), channel(channel(c))] {
            let error = value_type(&prog, &root, &mut HashSet::new()).unwrap_err();
            assert!(
                error.contains("a queue can lead back to channel type"),
                "{error}"
            );
            assert!(error.contains("missing cycle-freedom proof"), "{error}");
        }
    }

    #[test]
    fn nested_queues_defer_task_owners_to_flow_but_reject_stream_captures() {
        let prog = Program::default();
        let task = MT::Con("std::Task".into(), vec![MT::con("std::String")]);
        value_type(&prog, &channel(channel(task)), &mut HashSet::new()).unwrap();
        let ty = channel(channel(MT::con("std::H2Stream")));
        let error = value_type(&prog, &ty, &mut HashSet::new()).unwrap_err();
        assert!(
            error.contains("captures can retain the receiving channel"),
            "{error}"
        );
    }
}
