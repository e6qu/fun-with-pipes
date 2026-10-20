//! Infer caller-owned arguments for functions reached only by direct calls.
//!
//! This changes an internal calling convention, not source function types.
//! Returned/stored arguments, unknown calls, resource scopes, and recursive
//! functions retain their consuming convention.

use std::collections::{BTreeMap, BTreeSet, HashSet};

use crate::ir::*;
use crate::ownership::Argument;
use crate::value::Value;

fn value_functions(value: &Value, out: &mut BTreeSet<FuncId>) {
    match value {
        Value::Closure(c) => {
            out.insert(c.func);
            c.args.iter().for_each(|v| value_functions(v, out));
        }
        Value::Data(_, xs) | Value::Record(xs) => {
            xs.iter().for_each(|v| value_functions(v, out));
        }
        Value::Array(xs) => xs.iter().for_each(|v| value_functions(v, out)),
        Value::Set(xs) => xs.iter().for_each(|v| value_functions(v, out)),
        Value::Map(xs) => xs.iter().for_each(|(k, v)| {
            value_functions(k, out);
            value_functions(v, out);
        }),
        _ => {}
    }
}

fn references(e: &Expr, calls: &mut BTreeSet<FuncId>, values: &mut BTreeSet<FuncId>) {
    match e {
        Expr::Local(_) => {}
        Expr::Const(v) => value_functions(v, values),
        Expr::Func(id) => {
            values.insert(*id);
        }
        Expr::Call(id, args) => {
            calls.insert(*id);
            args.iter().for_each(|e| references(e, calls, values));
        }
        Expr::Record(xs) | Expr::Construct(_, xs) => {
            xs.iter().for_each(|e| references(e, calls, values));
        }
        Expr::Apply(f, xs) => {
            references(f, calls, values);
            xs.iter().for_each(|e| references(e, calls, values));
        }
        Expr::Let(_, a, b) => {
            references(a, calls, values);
            references(b, calls, values);
        }
        Expr::Match(s, arms) => {
            references(s, calls, values);
            arms.iter().for_each(|(_, e)| references(e, calls, values));
        }
        Expr::SetFields(base, fields) => {
            references(base, calls, values);
            fields
                .iter()
                .for_each(|(_, e)| references(e, calls, values));
        }
        Expr::BorrowGlobal(_, id, body) => {
            calls.insert(*id);
            references(body, calls, values);
        }
        Expr::Field(body, _)
        | Expr::Trace(_, body)
        | Expr::Dup(_, body)
        | Expr::Drop(_, body)
        | Expr::ResourceRegion { body, .. } => references(body, calls, values),
    }
}

fn recursive(id: FuncId, graph: &[BTreeSet<FuncId>]) -> bool {
    let mut pending: Vec<_> = graph[id].iter().copied().collect();
    let mut seen = BTreeSet::new();
    while let Some(next) = pending.pop() {
        if next == id {
            return true;
        }
        if seen.insert(next) {
            pending.extend(graph[next].iter().copied());
        }
    }
    false
}

/// A flat record may be passed as separate borrowed fields. Nested aggregate
/// reconstruction, function captures and resource-close lifetimes need their
/// own representation proof.
fn parameter_type(prog: &Program, ty: &MT) -> bool {
    fn leaf(prog: &Program, ty: &MT) -> bool {
        let plain = |ty| crate::tailrec::plain_data(&prog.shapes, ty, &mut HashSet::new());
        (plain(ty)
            || matches!(ty, MT::Con(name, args)
            if name == "std::Channel" && args.len() == 1 && plain(&args[0])))
            && record_fields(&prog.shapes, ty).is_none()
            && !matches!(prog.shapes.get(ty), Some(TypeShape::Adt(_)))
    }
    super::needs_rc(&prog.shapes, ty)
        && match record_fields(&prog.shapes, ty) {
            Some(fields) => {
                fields.iter().all(|(_, ty)| leaf(prog, ty))
                    && fields
                        .iter()
                        .any(|(_, ty)| super::needs_rc(&prog.shapes, ty))
            }
            None => leaf(prog, ty),
        }
}

type ReadPath = (Local, Vec<u32>);

fn read_path(e: &Expr) -> Option<ReadPath> {
    match e {
        Expr::Local(l) => Some((*l, vec![])),
        Expr::Field(base, field) => {
            let (local, mut fields) = read_path(base)?;
            fields.push(*field);
            Some((local, fields))
        }
        _ => None,
    }
}

fn visit_children(e: &Expr, mut visit: impl FnMut(&Expr)) {
    match e {
        Expr::Call(_, xs) | Expr::Record(xs) | Expr::Construct(_, xs) => xs.iter().for_each(visit),
        Expr::Apply(f, xs) => {
            visit(f);
            xs.iter().for_each(visit);
        }
        Expr::Let(_, a, b) => {
            visit(a);
            visit(b);
        }
        Expr::Match(value, arms) => {
            visit(value);
            arms.iter().for_each(|(_, e)| visit(e));
        }
        Expr::SetFields(base, fields) => {
            visit(base);
            fields.iter().for_each(|(_, e)| visit(e));
        }
        Expr::Field(body, _)
        | Expr::Trace(_, body)
        | Expr::Dup(_, body)
        | Expr::Drop(_, body)
        | Expr::BorrowGlobal(_, _, body)
        | Expr::ResourceRegion { body, .. } => visit(body),
        Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => {}
    }
}

fn reads(e: &Expr, out: &mut BTreeSet<ReadPath>) {
    if let Some(path) = read_path(e) {
        out.insert(path);
    } else {
        visit_children(e, |child| reads(child, out));
    }
}

/// Borrow only when every caller keeps the same counted value past the call.
/// Otherwise borrowing could prolong a plain input's lifetime beyond its last
/// callee use and raise peak memory. For channels this also preserves observable
/// destruction of a native sink's hidden context. Reading another tuple field
/// later is insufficient after field splitting.
fn continuing_owners(prog: &Program, live: &[bool]) -> Vec<Vec<bool>> {
    fn retained(prog: &Program, ty: &MT, arg: &Expr, after: &BTreeSet<ReadPath>) -> bool {
        if !super::needs_rc(&prog.shapes, ty) {
            return true;
        }
        if let Some(fields) = record_fields(&prog.shapes, ty) {
            return fields.iter().enumerate().all(|(index, (_, ty))| {
                // Candidate records are flat. Nested records never qualify.
                if record_fields(&prog.shapes, ty).is_some() {
                    return false;
                }
                if let Expr::Record(values) = arg {
                    values
                        .get(index)
                        .is_some_and(|value| retained(prog, ty, value, after))
                } else {
                    retained(
                        prog,
                        ty,
                        &Expr::Field(Box::new(arg.clone()), index as u32),
                        after,
                    )
                }
            });
        }
        read_path(arg).is_some_and(|(local, fields)| {
            after
                .iter()
                .any(|(l, prefix)| *l == local && fields.starts_with(prefix))
        })
    }
    fn visit(prog: &Program, e: &Expr, after: &BTreeSet<ReadPath>, kept: &mut [Vec<bool>]) {
        match e {
            Expr::Let(_, value, body) => {
                let mut continuation = after.clone();
                reads(body, &mut continuation);
                visit(prog, value, &continuation, kept);
                visit(prog, body, after, kept);
            }
            Expr::Match(value, arms) => {
                let mut continuation = after.clone();
                for (_, body) in arms {
                    reads(body, &mut continuation);
                    visit(prog, body, after, kept);
                }
                visit(prog, value, &continuation, kept);
            }
            Expr::Call(id, args) => {
                for (j, (arg, ty)) in args
                    .iter()
                    .zip(prog.funcs[*id].ty.params(args.len()).0)
                    .enumerate()
                {
                    kept[*id][j] &= retained(prog, ty, arg, after);
                }
                for arg in args {
                    visit(prog, arg, &BTreeSet::new(), kept);
                }
            }
            _ => {
                visit_children(e, |child| visit(prog, child, after, kept));
            }
        }
    }
    let mut kept: Vec<_> = prog
        .funcs
        .iter()
        .map(|f| vec![true; f.arity as usize])
        .collect();
    for (_, f) in prog.funcs.iter().enumerate().filter(|(id, _)| live[*id]) {
        if let Body::Expr(body) = &f.body {
            visit(prog, body, &BTreeSet::new(), &mut kept);
        }
    }
    kept
}

fn derived(e: &Expr, aliases: &BTreeSet<Local>) -> bool {
    match e {
        Expr::Local(l) => aliases.contains(l),
        Expr::Field(base, _) => derived(base, aliases),
        _ => false,
    }
}

fn uses_only_borrows(
    prog: &Program,
    contracts: &BTreeMap<FuncId, Vec<Local>>,
    locals: &[MT],
    e: &Expr,
    aliases: &BTreeSet<Local>,
    borrow: bool,
) -> bool {
    if derived(e, aliases) {
        return borrow
            || type_of(&|id| &prog.funcs[id].ty, &prog.shapes, locals, e)
                .is_some_and(|ty| !super::needs_rc(&prog.shapes, &ty));
    }
    let owned = |e| uses_only_borrows(prog, contracts, locals, e, aliases, false);
    match e {
        Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => true,
        Expr::Call(id, args) => args.iter().enumerate().all(|(j, e)| {
            let borrowed = match &prog.funcs[*id].body {
                Body::Prim(symbol) => crate::ownership::primitive(symbol)
                    .is_some_and(|c| c.argument(j) == Argument::Borrow),
                Body::Expr(_) => contracts
                    .get(id)
                    .is_some_and(|ps| ps.contains(&(j as Local))),
                _ => false,
            };
            uses_only_borrows(prog, contracts, locals, e, aliases, borrowed)
        }),
        Expr::Let(l, value, body) if derived(value, aliases) => {
            // Only plain aliases/field views are delayed. They cannot trap,
            // allocate or release a resource when their owner is kept alive.
            let mut aliases = aliases.clone();
            aliases.insert(*l);
            uses_only_borrows(prog, contracts, locals, body, &aliases, borrow)
        }
        Expr::Let(_, value, body) => {
            owned(value) && uses_only_borrows(prog, contracts, locals, body, aliases, borrow)
        }
        Expr::Match(scrutinee, arms) => {
            // Pattern aliases require a separate lifetime proof. Matches on
            // independent values are fine, including a primitive's owned result.
            owned(scrutinee)
                && arms.iter().all(|(_, body)| {
                    uses_only_borrows(prog, contracts, locals, body, aliases, borrow)
                })
        }
        Expr::Record(xs) | Expr::Construct(_, xs) => xs.iter().all(owned),
        Expr::Apply(f, xs) => owned(f) && xs.iter().all(owned),
        Expr::Field(base, _) => owned(base),
        Expr::SetFields(base, fields) => owned(base) && fields.iter().all(|(_, e)| owned(e)),
        Expr::Trace(..)
        | Expr::ResourceRegion { .. }
        | Expr::Dup(..)
        | Expr::Drop(..)
        | Expr::BorrowGlobal(..) => false,
    }
}

pub(crate) fn infer(
    prog: &Program,
    owned_entries: &[bool],
    live: &[bool],
) -> BTreeMap<FuncId, Vec<Local>> {
    assert_eq!(owned_entries.len(), prog.funcs.len());
    assert_eq!(live.len(), prog.funcs.len());
    let mut graph = vec![BTreeSet::new(); prog.funcs.len()];
    let mut values = BTreeSet::new();
    values.extend(prog.main);
    values.extend(prog.tests.iter().map(|(_, id)| *id));
    values.extend(prog.exports.iter().map(|(_, id)| *id));
    values.extend(prog.named.iter().map(|(_, id)| *id));
    if let Some(service) = &prog.service {
        for method in &service.methods {
            values.insert(method.func);
            values.extend(method.iter_fn);
        }
    }
    for (id, f) in prog.funcs.iter().enumerate().filter(|(id, _)| live[*id]) {
        match &f.body {
            Body::Expr(body) => references(body, &mut graph[id], &mut values),
            Body::Remote(remote) => values.extend(remote.iter_fn),
            _ => {}
        }
    }
    let candidates: Vec<_> = prog
        .funcs
        .iter()
        .enumerate()
        .filter(|(id, f)| {
            live[*id]
                && f.arity > 0
                && !values.contains(id)
                && !owned_entries[*id]
                && !recursive(*id, &graph)
        })
        .filter_map(|(id, f)| match &f.body {
            Body::Expr(body) => Some((id, f, body)),
            _ => None,
        })
        .collect();
    let mut contracts: BTreeMap<FuncId, Vec<Local>> = BTreeMap::new();
    let noescape = crate::escape::params(prog);
    let kept = continuing_owners(prog, live);
    // Start with known primitive borrows. A direct caller can qualify after
    // its callee has a proof; cycles never supply their own justification.
    loop {
        let mut changed = false;
        for &(id, f, body) in &candidates {
            for local in 0..f.arity {
                if contracts.get(&id).is_some_and(|ps| ps.contains(&local))
                    || !parameter_type(prog, &f.locals[local as usize])
                    || !kept[id][local as usize]
                    || (record_fields(&prog.shapes, &f.locals[local as usize]).is_some()
                        && !noescape[id][local as usize])
                {
                    continue;
                }
                if uses_only_borrows(
                    prog,
                    &contracts,
                    &f.locals,
                    body,
                    &BTreeSet::from([local]),
                    false,
                ) {
                    contracts.entry(id).or_default().push(local);
                    changed = true;
                }
            }
        }
        if !changed {
            return contracts;
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn program(body: Expr, input: MT) -> Program {
        let integer = MT::con("std::I64");
        let mut p = Program::default();
        p.funcs.push(Func {
            name: "read".into(),
            arity: 1,
            locals: vec![input.clone(), MT::con("std::String")],
            ty: MT::Fun(Box::new(input), Box::new(integer.clone())),
            body: Body::Expr(body),
        });
        p.funcs.push(Func {
            name: "length".into(),
            arity: 1,
            locals: vec![MT::con("std::String")],
            ty: MT::Fun(Box::new(MT::con("std::String")), Box::new(integer)),
            body: Body::Prim("string.length".into()),
        });
        p
    }

    #[test]
    fn borrowed_reads_share_one_contract_with_insertion_and_verification() {
        let mut p = program(Expr::Call(1, vec![Expr::Local(0)]), MT::con("std::String"));
        p.borrowed_parameters = infer(&p, &[false, true], &[true, true]);
        assert_eq!(p.borrowed_parameters, BTreeMap::from([(0, vec![0])]));
        assert!(!super::super::consumes_arg(&p, 0, 0));
        let (body, locals) = super::super::insert(&p)[0].clone().unwrap();
        assert!(matches!(body, Expr::Call(1, _)), "{body:?}");
        super::super::ownership_liveness(&p, &p.funcs[0], &body, &locals, &[0]).unwrap();
        let broken = Expr::Drop(0, Box::new(body));
        assert!(super::super::ownership_liveness(&p, &p.funcs[0], &broken, &locals, &[0]).is_err());
    }

    #[test]
    fn a_borrowed_record_field_needs_no_independent_owner() {
        let field = Expr::Field(Box::new(Expr::Local(0)), 0);
        let mut p = program(
            Expr::Let(
                1,
                Box::new(field),
                Box::new(Expr::Call(1, vec![Expr::Local(1)])),
            ),
            MT::Record(vec![("0".into(), MT::con("std::String"))]),
        );
        p.borrowed_parameters = infer(&p, &[false, true], &[true, true]);
        assert_eq!(p.borrowed_parameters, BTreeMap::from([(0, vec![0])]));
        let (body, locals) = super::super::insert(&p)[0].clone().unwrap();
        let Expr::Let(_, _, tail) = &body else {
            panic!("{body:?}")
        };
        assert!(matches!(**tail, Expr::Call(1, _)), "{body:?}");
        super::super::ownership_liveness(&p, &p.funcs[0], &body, &locals, &[0]).unwrap();

        let scalar = program(
            Expr::Field(Box::new(Expr::Local(0)), 0),
            MT::Record(vec![("0".into(), MT::con("std::I64"))]),
        );
        assert!(
            infer(&scalar, &[false, true], &[true, false]).is_empty(),
            "scalar-only fields need no borrowed owner or prolonged record lifetime"
        );
    }

    #[test]
    fn direct_call_chain_requires_each_callees_proof() {
        let mut p = program(
            Expr::Let(
                2,
                Box::new(Expr::Call(2, vec![Expr::Local(0)])),
                Box::new(Expr::Call(1, vec![Expr::Local(0)])),
            ),
            MT::con("std::String"),
        );
        p.funcs[0].locals.push(MT::con("std::I64"));
        let mut callee = p.funcs[0].clone();
        callee.body = Body::Expr(Expr::Call(1, vec![Expr::Local(0)]));
        p.funcs.push(callee);
        assert_eq!(
            infer(&p, &[false, true, false], &[true, true, true]),
            BTreeMap::from([(0, vec![0]), (2, vec![0])])
        );
        p.funcs[2].body = Body::Expr(Expr::Local(0));
        p.funcs[2].ty = MT::Fun(
            Box::new(MT::con("std::String")),
            Box::new(MT::con("std::String")),
        );
        p.funcs[0].locals[2] = MT::con("std::String");
        assert!(infer(&p, &[false, true, false], &[true, true, true]).is_empty());
    }

    #[test]
    fn returned_stored_dynamic_and_recursive_arguments_keep_owned_entries() {
        for body in [
            Expr::Local(0),
            Expr::Record(vec![Expr::Local(0)]),
            Expr::Construct(0, vec![Expr::Local(0)]),
            Expr::Apply(Box::new(Expr::Func(1)), vec![Expr::Local(0)]),
            Expr::Call(0, vec![Expr::Local(0)]),
            Expr::ResourceRegion {
                parameters: vec![0],
                bindings: vec![],
                body: Box::new(Expr::Call(1, vec![Expr::Local(0)])),
            },
        ] {
            let p = program(body, MT::con("std::String"));
            assert!(infer(&p, &[false, true], &[true, true]).is_empty());
        }
        let mut p = program(Expr::Call(1, vec![Expr::Local(0)]), MT::con("std::String"));
        p.funcs[1].body = Body::Expr(Expr::Call(0, vec![Expr::Local(0)]));
        assert!(
            infer(&p, &[false, false], &[true, true]).is_empty(),
            "mutual recursion"
        );
    }

    #[test]
    fn exports_and_function_values_keep_owned_entries() {
        let original = program(Expr::Call(1, vec![Expr::Local(0)]), MT::con("std::String"));
        let mut p = original.clone();
        p.exports.push(("read".into(), 0));
        assert!(infer(&p, &[false, true], &[true, true]).is_empty());
        let mut p = original.clone();
        p.funcs[1].body = Body::Expr(Expr::Func(0));
        assert!(infer(&p, &[false, true], &[true, true]).is_empty());
        assert!(
            infer(&original, &[true, true], &[true, true]).is_empty(),
            "no direct worker"
        );
    }

    #[test]
    fn unreachable_function_values_do_not_change_live_call_contracts() {
        let mut p = program(Expr::Call(1, vec![Expr::Local(0)]), MT::con("std::String"));
        let mut dead = p.funcs[0].clone();
        dead.body = Body::Expr(Expr::Func(0));
        p.funcs.push(dead);
        assert!(infer(&p, &[false, true, true], &[true, true, true]).is_empty());
        assert_eq!(
            infer(&p, &[false, true, true], &[true, true, false]),
            BTreeMap::from([(0, vec![0])])
        );
    }

    #[test]
    fn borrowed_primitive_does_not_prove_a_record_cannot_escape() {
        let tuple = MT::Record(vec![("0".into(), MT::con("std::String"))]);
        let mut p = program(Expr::Call(1, vec![Expr::Local(0)]), tuple.clone());
        p.funcs[1].locals = vec![tuple.clone()];
        p.funcs[1].ty = MT::Fun(Box::new(tuple.clone()), Box::new(tuple));
        p.funcs[1].body = Body::Prim("get".into());
        assert!(infer(&p, &[false, true], &[true, true]).is_empty());
    }

    #[test]
    fn borrows_require_that_same_field_after_every_call() {
        for (input, symbol, output) in [
            (MT::con("std::String"), "string.length", MT::con("std::I64")),
            (
                MT::Con("std::Channel".into(), vec![MT::con("std::String")]),
                "channel.close",
                MT::unit(),
            ),
        ] {
            let pair = MT::Record(vec![
                ("0".into(), input.clone()),
                ("1".into(), MT::con("std::I64")),
            ]);
            for (later, result, expected) in [
                (
                    Expr::Field(Box::new(Expr::Local(0)), 0),
                    input.clone(),
                    true,
                ),
                (Expr::Local(0), pair.clone(), true),
                (
                    Expr::Field(Box::new(Expr::Local(0)), 1),
                    MT::con("std::I64"),
                    false,
                ),
                (Expr::Const(Value::unit()), MT::unit(), false),
            ] {
                let mut p = program(Expr::Call(1, vec![Expr::Local(0)]), input.clone());
                p.funcs[0].ty = MT::Fun(Box::new(input.clone()), Box::new(output.clone()));
                p.funcs[1].locals = vec![input.clone()];
                p.funcs[1].ty = p.funcs[0].ty.clone();
                p.funcs[1].body = Body::Prim(symbol.into());
                p.funcs.push(Func {
                    name: "caller".into(),
                    arity: 1,
                    locals: vec![pair.clone(), output.clone()],
                    ty: MT::Fun(Box::new(pair.clone()), Box::new(result)),
                    body: Body::Expr(Expr::Let(
                        1,
                        Box::new(Expr::Call(
                            0,
                            vec![Expr::Field(Box::new(Expr::Local(0)), 0)],
                        )),
                        Box::new(later),
                    )),
                });
                let contracts = infer(&p, &[false, true, true], &[true, true, true]);
                assert_eq!(contracts.contains_key(&0), expected, "{p:?}");
            }
        }
    }
}
