//! Admission proof for one invocation-owned recursive graph.
//!
//! This is preparation for A6 lowering. A successful plan is not a storage
//! transformation: internal link types, helper specialization and cleanup must
//! consume this proof together before the C backend can select region storage.

use std::collections::{BTreeMap, BTreeSet};

use crate::ir::{Body, Expr, FuncId, Program, TypeShape, MT};

#[derive(Debug, PartialEq, Eq)]
pub(super) struct Plan {
    pub root: FuncId,
    pub node: MT,
    /// Ordinary definitions remain available to independently owned callers.
    pub helpers: BTreeSet<FuncId>,
}

/// Reverse type edges make containment a finite reachability calculation. A
/// recursive nominal shape must not cache a temporary "not found" DFS answer.
struct Types {
    parents: BTreeMap<MT, BTreeSet<MT>>,
}

impl Types {
    fn new(prog: &Program) -> Self {
        let mut pending: Vec<_> = prog.shapes.keys().cloned().collect();
        for f in &prog.funcs {
            pending.push(f.ty.clone());
            pending.extend(f.locals.iter().cloned());
        }
        let mut parents = BTreeMap::<MT, BTreeSet<MT>>::new();
        let mut visited = BTreeSet::new();
        while let Some(ty) = pending.pop() {
            if !visited.insert(ty.clone()) {
                continue;
            }
            let mut children = match &ty {
                MT::Con(_, arguments) => arguments.clone(),
                MT::Record(fields) => fields.iter().map(|(_, t)| t.clone()).collect(),
                MT::Fun(input, output) => vec![(**input).clone(), (**output).clone()],
                MT::Nat(_) => vec![],
            };
            match prog.shapes.get(&ty) {
                Some(TypeShape::Adt(variants)) => {
                    children.extend(
                        variants
                            .iter()
                            .flat_map(|(_, fields)| fields.iter().cloned()),
                    );
                }
                Some(TypeShape::Record(fields)) => {
                    children.extend(fields.iter().map(|(_, t)| t.clone()));
                }
                Some(TypeShape::Opaque) | None => {}
            }
            for child in children {
                parents.entry(child.clone()).or_default().insert(ty.clone());
                pending.push(child);
            }
        }
        Self { parents }
    }

    fn containing(&self, node: &MT) -> BTreeSet<MT> {
        let mut pending = vec![node.clone()];
        let mut result = BTreeSet::new();
        while let Some(ty) = pending.pop() {
            if result.insert(ty.clone()) {
                if let Some(parents) = self.parents.get(&ty) {
                    pending.extend(parents.iter().cloned());
                }
            }
        }
        result
    }
}

/// No independently owned fields or finalizers are hidden in admitted nodes.
fn node_shape(prog: &Program, node: &MT) -> bool {
    let Some(TypeShape::Adt(variants)) = prog.shapes.get(node) else {
        return false;
    };
    let integer = MT::con("std::I64");
    let fields: Vec<_> = variants.iter().flat_map(|(_, fields)| fields).collect();
    fields.contains(&node) && fields.iter().all(|ty| *ty == node || **ty == integer)
}

/// Region links can be carried by local records. Other containers have runtime
/// operations and descriptors that this first representation does not specialize.
fn local_type(
    prog: &Program,
    node: &MT,
    containing: &BTreeSet<MT>,
    ty: &MT,
    visited: &mut BTreeSet<MT>,
) -> bool {
    if !containing.contains(ty) || ty == node || !visited.insert(ty.clone()) {
        return true;
    }
    crate::ir::record_fields(&prog.shapes, ty).is_some_and(|fields| {
        fields
            .iter()
            .all(|(_, ty)| local_type(prog, node, containing, ty, visited))
    })
}

fn body_calls(
    prog: &Program,
    containing: &BTreeSet<MT>,
    unknown: &BTreeSet<MT>,
    e: &Expr,
    calls: &mut BTreeSet<FuncId>,
) -> bool {
    let visit = |e, calls: &mut BTreeSet<FuncId>| body_calls(prog, containing, unknown, e, calls);
    match e {
        Expr::Local(_) | Expr::Const(_) => true,
        Expr::Func(id) => {
            !containing.contains(&prog.funcs[*id].ty) && !unknown.contains(&prog.funcs[*id].ty)
        }
        Expr::Call(id, arguments) => {
            let f = &prog.funcs[*id];
            // Partial application creates a closure, not a direct region call.
            if arguments.len() != f.arity as usize || unknown.contains(&f.ty) {
                return false;
            }
            if containing.contains(&f.ty) {
                // Zero-argument definitions are cached values. Their storage
                // belongs to the cache, not this invocation.
                if f.arity == 0 {
                    return false;
                }
                calls.insert(*id);
            }
            arguments.iter().all(|e| visit(e, calls))
        }
        Expr::Let(_, value, body) => visit(value, calls) && visit(body, calls),
        Expr::Match(value, arms) => {
            visit(value, calls) && arms.iter().all(|(_, body)| visit(body, calls))
        }
        Expr::Construct(_, fields) | Expr::Record(fields) => fields.iter().all(|e| visit(e, calls)),
        Expr::Field(value, _) => visit(value, calls),
        Expr::SetFields(value, fields) => {
            visit(value, calls) && fields.iter().all(|(_, e)| visit(e, calls))
        }
        // Analysis runs before ownership insertion and outside debugger mode.
        // Reject dynamic application even when its declared result is scalar;
        // it can close over a local link.
        Expr::Apply(..)
        | Expr::Trace(..)
        | Expr::BorrowGlobal(..)
        | Expr::ResourceRegion { .. }
        | Expr::Dup(..)
        | Expr::Drop(..) => false,
    }
}

/// Check one explicit root/type pair. Selection policy and clone budgets belong
/// to lowering; this proof never searches arbitrary call contexts or promotes a
/// link to an independently owned value at runtime.
pub(super) fn prove(prog: &Program, root: FuncId, node: &MT) -> Option<Plan> {
    if prog.self_tail.contains(&root) || !node_shape(prog, node) {
        return None;
    }
    let types = Types::new(prog);
    let containing = types.containing(node);
    let unknown = types.containing(&MT::con("?"));
    let f = prog.funcs.get(root)?;
    if containing.contains(&f.ty) || !f.locals.iter().any(|ty| containing.contains(ty)) {
        return None;
    }
    let mut pending = BTreeSet::from([root]);
    let mut helpers = BTreeSet::new();
    while let Some(id) = pending.pop_first() {
        if !helpers.insert(id) {
            continue;
        }
        let f = &prog.funcs[id];
        let (parameters, result) = f.ty.params(f.arity as usize);
        if parameters.len() != f.arity as usize || unknown.contains(&f.ty) {
            return None;
        }
        let mut visited = BTreeSet::new();
        if parameters
            .into_iter()
            .chain([result])
            .chain(f.locals.iter())
            .any(|ty| {
                unknown.contains(ty) || !local_type(prog, node, &containing, ty, &mut visited)
            })
        {
            return None;
        }
        match &f.body {
            Body::Expr(body) => {
                if !body_calls(prog, &containing, &unknown, body, &mut pending) {
                    return None;
                }
            }
            Body::Ctor(_) if result == node => {}
            // `fail` never returns. Its String owner keeps the ordinary runtime
            // contract; no region link is passed to the primitive.
            Body::Prim(symbol)
                if symbol == "fail"
                    && f.arity == 1
                    && f.locals.first() == Some(&MT::con("std::String")) => {}
            Body::Ctor(_) | Body::Prim(_) | Body::ForeignC { .. } | Body::Remote(_) => {
                return None;
            }
        }
    }
    helpers.remove(&root);
    Some(Plan {
        root,
        node: node.clone(),
        helpers,
    })
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::ir::Func;
    use crate::value::Value;

    fn arrow(input: MT, output: MT) -> MT {
        MT::Fun(Box::new(input), Box::new(output))
    }

    fn program() -> (Program, MT) {
        let node = MT::con("Tree");
        let integer = MT::con("std::I64");
        let tree_builder = Func {
            name: "build".into(),
            arity: 1,
            locals: vec![integer.clone()],
            ty: arrow(integer.clone(), node.clone()),
            body: Body::Ctor(0),
        };
        let reader = Func {
            name: "read".into(),
            arity: 1,
            locals: vec![node.clone()],
            ty: arrow(node.clone(), integer.clone()),
            body: Body::Expr(Expr::Const(Value::I64(0))),
        };
        let root = Func {
            name: "root".into(),
            arity: 1,
            locals: vec![integer.clone(), node.clone()],
            ty: arrow(integer.clone(), integer.clone()),
            body: Body::Expr(Expr::Let(
                1,
                Box::new(Expr::Call(1, vec![Expr::Local(0)])),
                Box::new(Expr::Call(2, vec![Expr::Local(1)])),
            )),
        };
        let mut prog = Program {
            funcs: vec![root, tree_builder, reader],
            ..Default::default()
        };
        prog.shapes.insert(
            node.clone(),
            TypeShape::Adt(vec![
                ("Number".into(), vec![integer]),
                ("Pair".into(), vec![node.clone(), node.clone()]),
            ]),
        );
        (prog, node)
    }

    #[test]
    fn recursive_calls_have_one_finite_helper_set() {
        let (mut prog, node) = program();
        prog.funcs[2].body = Body::Expr(Expr::Call(2, vec![Expr::Local(0)]));
        let plan = prove(&prog, 0, &node).unwrap();
        assert_eq!(plan.helpers, BTreeSet::from([1, 2]));
        // Returning a tree remains legal, but cannot be this region's owner.
        assert!(prove(&prog, 1, &node).is_none());
        // Nor may an invocation treat its caller's tree as its own region.
        assert!(prove(&prog, 2, &node).is_none());
    }

    #[test]
    fn records_can_mix_links_with_ordinary_string_owners() {
        let (mut prog, node) = program();
        prog.funcs[0].locals.push(MT::Record(vec![
            ("0".into(), node.clone()),
            (
                "1".into(),
                MT::Con("std::List".into(), vec![MT::con("std::String")]),
            ),
        ]));
        assert!(prove(&prog, 0, &node).is_some());
        prog.funcs[0]
            .locals
            .push(MT::Con("std::List".into(), vec![node.clone()]));
        assert!(prove(&prog, 0, &node).is_none());
    }

    #[test]
    fn owned_node_fields_and_unknown_types_prevent_selection() {
        let (prog, node) = program();
        for field in [MT::con("std::String"), MT::con("std::File"), MT::con("?")] {
            let mut p = prog.clone();
            let Some(TypeShape::Adt(variants)) = p.shapes.get_mut(&node) else {
                unreachable!()
            };
            variants.push(("Owner".into(), vec![field]));
            assert!(prove(&p, 0, &node).is_none());
        }
        let mut p = prog;
        p.funcs[2].locals.push(MT::con("?"));
        assert!(prove(&p, 0, &node).is_none());
    }

    #[test]
    fn function_values_and_partial_calls_cannot_hide_a_link() {
        let (prog, node) = program();
        for expression in [
            Expr::Func(2),
            Expr::Call(2, vec![]),
            Expr::Apply(Box::new(Expr::Func(2)), vec![Expr::Local(0)]),
        ] {
            let mut p = prog.clone();
            p.funcs[2].body = Body::Expr(expression);
            assert!(prove(&p, 0, &node).is_none());
        }
    }

    #[test]
    fn runtime_and_foreign_calls_cannot_receive_links() {
        let (prog, node) = program();
        for body in [
            Body::Prim("channel.send".into()),
            Body::Prim("ignore".into()),
            Body::ForeignC {
                symbol: "external".into(),
                variadic: None,
            },
        ] {
            let mut p = prog.clone();
            p.funcs[2].body = body;
            assert!(prove(&p, 0, &node).is_none());
        }
    }

    #[test]
    fn type_containment_is_independent_of_recursive_visit_order() {
        let (mut prog, node) = program();
        let a = MT::con("A");
        let b = MT::con("B");
        prog.shapes.insert(
            a.clone(),
            TypeShape::Record(vec![
                ("back".into(), b.clone()),
                ("tree".into(), node.clone()),
            ]),
        );
        prog.shapes.insert(
            b.clone(),
            TypeShape::Record(vec![("back".into(), a.clone())]),
        );
        let containing = Types::new(&prog).containing(&node);
        assert!(containing.contains(&a) && containing.contains(&b));
        prog.funcs[0].ty = arrow(MT::con("std::I64"), b);
        assert!(prove(&prog, 0, &node).is_none());
    }
    #[test]
    fn cached_graphs_and_self_tail_roots_keep_ordinary_lifetimes() {
        let (mut prog, node) = program();
        prog.funcs[1].arity = 0;
        prog.funcs[1].locals.clear();
        prog.funcs[1].ty = node.clone();
        prog.funcs[1].body = Body::Expr(Expr::Construct(0, vec![Expr::Const(Value::I64(7))]));
        prog.funcs[0].body = Body::Expr(Expr::Let(
            1,
            Box::new(Expr::Call(1, vec![])),
            Box::new(Expr::Call(2, vec![Expr::Local(1)])),
        ));
        assert!(prove(&prog, 0, &node).is_none());
        let (mut prog, node) = program();
        prog.self_tail.insert(0);
        assert!(prove(&prog, 0, &node).is_none());
    }
}
