//! Move string-list inputs into known, uncaptured callbacks before RC insertion.
//! String leaves have no resource-close effects. Other map calls keep their
//! existing ownership contract; no surface primitive or conversion is added.

use crate::ir::*;
use std::collections::HashMap;

pub(super) fn lower(prog: &Program) -> Program {
    fn visit(
        e: &mut Expr,
        funcs: &[Func],
        made: &mut Vec<Func>,
        targets: &mut HashMap<FuncId, FuncId>,
    ) {
        match e {
            Expr::Trace(_, body)
            | Expr::Dup(_, body)
            | Expr::Drop(_, body)
            | Expr::BorrowGlobal(_, _, body)
            | Expr::ResourceRegion { body, .. } => visit(body, funcs, made, targets),
            Expr::Call(_, args) | Expr::Construct(_, args) | Expr::Record(args) => {
                for arg in args {
                    visit(arg, funcs, made, targets);
                }
            }
            Expr::Apply(function, args) => {
                visit(function, funcs, made, targets);
                for arg in args {
                    visit(arg, funcs, made, targets);
                }
            }
            Expr::Field(record, _) => visit(record, funcs, made, targets),
            Expr::SetFields(record, fields) => {
                visit(record, funcs, made, targets);
                for (_, field) in fields {
                    visit(field, funcs, made, targets);
                }
            }
            Expr::Let(_, value, body) => {
                visit(value, funcs, made, targets);
                visit(body, funcs, made, targets);
            }
            Expr::Match(value, arms) => {
                visit(value, funcs, made, targets);
                for (_, body) in arms {
                    visit(body, funcs, made, targets);
                }
            }
            Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => {}
        }
        let Expr::Call(id, args) = e else {
            return;
        };
        if !matches!(&funcs[*id].body, Body::Prim(name) if name == "map") {
            return;
        }
        let [Expr::Func(callback), _] = args.as_slice() else {
            return;
        };
        let function = &funcs[*callback];
        let text = MT::con("std::String");
        if function.arity != 1 || !matches!(function.body, Body::Expr(_) | Body::Prim(_)) {
            return;
        }
        let (params, result) = function.ty.params(1);
        if params != [&text] || result != &text {
            return;
        }
        let list = MT::Con("std::List".into(), vec![text]);
        let (params, result) = funcs[*id].ty.params(2);
        if funcs[*id].arity != 2 || params[1] != &list || result != &list {
            return;
        }
        *id = *targets.entry(*id).or_insert_with(|| {
            let mut specialized = funcs[*id].clone();
            specialized.name = "list._map-strings".into();
            specialized.body = Body::Prim("list._map-strings".into());
            let new_id = funcs.len() + made.len();
            made.push(specialized);
            new_id
        });
    }
    let mut result = prog.clone();
    let mut made = Vec::new();
    let mut targets = HashMap::new();
    for function in &mut result.funcs {
        if let Body::Expr(body) = &mut function.body {
            visit(body, &prog.funcs, &mut made, &mut targets);
        }
    }
    result.funcs.extend(made);
    result
}
