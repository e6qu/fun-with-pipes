//! Typed specialization. A rejected candidate leaves the original program intact.
use std::borrow::Cow;

use super::*;

fn substitute(ty: &MT, names: &BTreeMap<MT, MT>) -> MT {
    if let Some(replacement) = names.get(ty) {
        return replacement.clone();
    }
    match ty {
        MT::Con(name, args) => MT::Con(
            name.clone(),
            args.iter().map(|t| substitute(t, names)).collect(),
        ),
        MT::Record(fields) => MT::Record(
            fields
                .iter()
                .map(|(n, t)| (n.clone(), substitute(t, names)))
                .collect(),
        ),
        MT::Fun(a, b) => MT::Fun(
            Box::new(substitute(a, names)),
            Box::new(substitute(b, names)),
        ),
        MT::Nat(_) => ty.clone(),
    }
}

fn context_type() -> MT {
    MT::Con("std::Ptr".into(), vec![MT::unit()])
}

fn with_context(ty: &MT, arity: usize) -> MT {
    let (parameters, result) = ty.params(arity);
    parameters.into_iter().rev().fold(
        MT::Fun(Box::new(context_type()), Box::new(result.clone())),
        |result, parameter| MT::Fun(Box::new(parameter.clone()), Box::new(result)),
    )
}

fn pattern(p: &Pat, arity: Local) -> Pat {
    match p {
        Pat::Bind(l) => Pat::Bind(*l + u32::from(*l >= arity)),
        Pat::Construct(tag, fields) => {
            Pat::Construct(*tag, fields.iter().map(|p| pattern(p, arity)).collect())
        }
        Pat::Record(fields) => Pat::Record(fields.iter().map(|p| pattern(p, arity)).collect()),
        _ => p.clone(),
    }
}

struct Rewrite<'a> {
    program: &'a Program,
    plan: &'a Plan,
    ids: &'a BTreeMap<FuncId, FuncId>,
    constructors: &'a BTreeMap<u32, FuncId>,
    containing: &'a BTreeSet<MT>,
    function: &'a Func,
}

impl Rewrite<'_> {
    fn known(&self, expr: &Expr) -> Option<MT> {
        crate::ir::type_of(
            &|id| &self.program.funcs[id].ty,
            &self.program.shapes,
            &self.function.locals,
            expr,
        )
    }

    fn expr(&self, expr: &Expr, expected: Option<&MT>) -> Option<Expr> {
        let arity = self.function.arity;
        let known = if expected.is_none() {
            self.known(expr)
        } else {
            None
        };
        let expected = expected.or(known.as_ref());
        let visit = |e, ty| self.expr(e, ty);
        Some(match expr {
            Expr::Local(l) => Expr::Local(*l + u32::from(*l >= arity)),
            // Constants have pre-existing storage. Do not relabel an owned
            // constant graph as a region link, including inside a mixed record.
            Expr::Const(_) if expected.is_some_and(|t| self.containing.contains(t)) => return None,
            Expr::Const(
                crate::value::Value::Data(_, fields) | crate::value::Value::Record(fields),
            ) if expected.is_none() && !fields.is_empty() => return None,
            Expr::Const(_) | Expr::Func(_) => expr.clone(),
            Expr::Call(id, args) => {
                let function = &self.program.funcs[*id];
                let (parameters, _) = function.ty.params(args.len());
                if parameters.len() != args.len() {
                    return None;
                }
                let mut args = args
                    .iter()
                    .zip(parameters)
                    .map(|(a, t)| visit(a, Some(t)))
                    .collect::<Option<Vec<_>>>()?;
                // Reentering the public root starts a new invocation owner.
                // Sharing this context across recursive root calls would retain
                // inner trees until the outermost call finished.
                let id = if let Some(new) = self.ids.get(id).filter(|_| *id != self.plan.root) {
                    args.push(Expr::Local(arity));
                    *new
                } else {
                    *id
                };
                Expr::Call(id, args)
            }
            Expr::Construct(tag, fields) => {
                let Some(TypeShape::Adt(variants)) =
                    expected.and_then(|t| self.program.shapes.get(t))
                else {
                    return fields.is_empty().then(|| expr.clone());
                };
                let (_, types) = variants.get(*tag as usize)?;
                if fields.len() != types.len() {
                    return None;
                }
                let mut fields = fields
                    .iter()
                    .zip(types)
                    .map(|(e, ty)| visit(e, Some(ty)))
                    .collect::<Option<Vec<_>>>()?;
                if expected == Some(&self.plan.node) && !fields.is_empty() {
                    fields.push(Expr::Local(arity));
                    Expr::Call(*self.constructors.get(tag)?, fields)
                } else {
                    Expr::Construct(*tag, fields)
                }
            }
            Expr::Record(fields) => {
                let types =
                    expected.and_then(|ty| crate::ir::record_fields(&self.program.shapes, ty))?;
                if fields.len() != types.len() {
                    return None;
                }
                Expr::Record(
                    fields
                        .iter()
                        .zip(types)
                        .map(|(e, (_, ty))| visit(e, Some(ty)))
                        .collect::<Option<Vec<_>>>()?,
                )
            }
            Expr::Let(local, value, body) => Expr::Let(
                *local + u32::from(*local >= arity),
                Box::new(visit(value, self.function.locals.get(*local as usize))?),
                Box::new(visit(body, expected)?),
            ),
            Expr::Match(value, arms) => Expr::Match(
                Box::new(visit(value, None)?),
                arms.iter()
                    .map(|(p, body)| Some((pattern(p, arity), visit(body, expected)?)))
                    .collect::<Option<Vec<_>>>()?,
            ),
            Expr::Field(value, index) => Expr::Field(Box::new(visit(value, None)?), *index),
            Expr::SetFields(value, fields) => {
                let types =
                    expected.and_then(|ty| crate::ir::record_fields(&self.program.shapes, ty))?;
                Expr::SetFields(
                    Box::new(visit(value, expected)?),
                    fields
                        .iter()
                        .map(|(index, e)| {
                            Some((*index, visit(e, Some(&types.get(*index as usize)?.1))?))
                        })
                        .collect::<Option<Vec<_>>>()?,
                )
            }
            Expr::Apply(..)
            | Expr::Trace(..)
            | Expr::BorrowGlobal(..)
            | Expr::ResourceRegion { .. }
            | Expr::Dup(..)
            | Expr::Drop(..) => return None,
        })
    }
}

/// Prepare a complete candidate off to the side. Unknown constructor types or
/// constant graph storage reject the transformation before any program mutation.
fn specialize(
    program: &Program,
    plan: &Plan,
    containing: &BTreeSet<MT>,
    output: &mut Program,
    growth: usize,
) -> Option<usize> {
    let mut selected = plan.helpers.clone();
    selected.insert(plan.root);
    let mut pending = vec![plan.node.clone()];
    for id in &selected {
        pending.push(program.funcs[*id].ty.clone());
        pending.extend(program.funcs[*id].locals.iter().cloned());
    }
    let mut names = BTreeMap::new();
    let mut visited = BTreeSet::new();
    while let Some(ty) = pending.pop() {
        if !containing.contains(&ty) || !visited.insert(ty.clone()) {
            continue;
        }
        if program.shapes.contains_key(&ty) {
            names.insert(
                ty.clone(),
                MT::con(&format!("$region{}:{}", plan.root, names.len())),
            );
        }
        match &ty {
            MT::Con(_, args) => pending.extend(args.iter().cloned()),
            MT::Record(fields) => pending.extend(fields.iter().map(|(_, t)| t.clone())),
            MT::Fun(a, b) => {
                pending.push((**a).clone());
                pending.push((**b).clone());
            }
            MT::Nat(_) => {}
        }
        if let Some(TypeShape::Record(fields)) = program.shapes.get(&ty) {
            pending.extend(fields.iter().map(|(_, t)| t.clone()));
        }
    }
    let mut shapes = Vec::new();
    for (old, new) in &names {
        let shape = match program.shapes.get(old)? {
            TypeShape::Adt(variants) if old == &plan.node => TypeShape::RegionLink {
                owner: plan.root,
                variants: variants
                    .iter()
                    .map(|(n, fields)| {
                        (
                            n.clone(),
                            fields.iter().map(|t| substitute(t, &names)).collect(),
                        )
                    })
                    .collect(),
            },
            TypeShape::Record(fields) => TypeShape::Record(
                fields
                    .iter()
                    .map(|(n, t)| (n.clone(), substitute(t, &names)))
                    .collect(),
            ),
            // Unused containing containers need no specialized representation.
            _ => continue,
        };
        shapes.push((new.clone(), shape));
    }
    let start = output.funcs.len();
    let ids: BTreeMap<_, _> = selected
        .iter()
        .enumerate()
        .map(|(i, id)| (*id, start + i))
        .collect();
    let mut constructors = BTreeMap::new();
    let mut made = Vec::new();
    let Some(TypeShape::Adt(variants)) = program.shapes.get(&plan.node) else {
        return None;
    };
    for (tag, (_, fields)) in variants.iter().enumerate() {
        if fields.is_empty() {
            continue;
        }
        let mut locals: Vec<_> = fields.iter().map(|t| substitute(t, &names)).collect();
        locals.push(context_type());
        let ty = locals
            .iter()
            .rev()
            .fold(substitute(&plan.node, &names), |result, field| {
                MT::Fun(Box::new(field.clone()), Box::new(result))
            });
        constructors.insert(tag as u32, start + ids.len() + made.len());
        made.push(Func {
            name: format!("region {} constructor {tag}", plan.root),
            arity: locals.len() as u32,
            locals,
            ty,
            body: Body::RegionCtor(tag as u32),
        });
    }
    let mut functions = Vec::new();
    for id in &selected {
        let original = &program.funcs[*id];
        let mut function = original.clone();
        let body = match &original.body {
            Body::Expr(body) => Body::Expr(
                Rewrite {
                    program,
                    plan,
                    ids: &ids,
                    constructors: &constructors,
                    containing,
                    function: original,
                }
                .expr(body, Some(original.ty.after_args(original.arity as usize)))?,
            ),
            Body::Ctor(tag) => Body::RegionCtor(*tag),
            Body::Prim(symbol) => Body::Prim(symbol.clone()),
            _ => return None,
        };
        function.name = format!("{} [region {}]", original.name, plan.root);
        function.ty = with_context(&substitute(&original.ty, &names), original.arity as usize);
        function.locals = original
            .locals
            .iter()
            .map(|t| substitute(t, &names))
            .collect();
        function
            .locals
            .insert(original.arity as usize, context_type());
        function.arity += 1;
        function.body = body;
        functions.push(function);
    }
    functions.extend(made);
    // Keep context only on functions that allocate, or call a function that does.
    // Pure tree readers and never-returning failure primitives need no address.
    let mut needs = BTreeSet::new();
    for (offset, f) in functions.iter().enumerate() {
        if matches!(f.body, Body::RegionCtor(_)) {
            needs.insert(start + offset);
        }
    }
    let mut callers = BTreeMap::<FuncId, BTreeSet<FuncId>>::new();
    for (offset, f) in functions.iter().enumerate() {
        if let Body::Expr(body) = &f.body {
            inspect(body, |expr| {
                if let Expr::Call(id, _) = expr {
                    callers.entry(*id).or_default().insert(start + offset);
                }
            });
        }
    }
    let mut pending = needs.iter().copied().collect::<Vec<_>>();
    while let Some(callee) = pending.pop() {
        for caller in callers.get(&callee).into_iter().flatten() {
            if needs.insert(*caller) {
                pending.push(*caller);
            }
        }
    }
    let worker = ids[&plan.root];
    if !needs.contains(&worker) {
        return None;
    }
    for (offset, f) in functions.iter_mut().enumerate() {
        let context = f.arity - 1;
        let remove = !needs.contains(&(start + offset));
        if let Body::Expr(body) = &mut f.body {
            prune_context(body, start, &needs, context, remove);
        }
        if remove {
            let (parameters, result) = f.ty.params(f.arity as usize);
            f.ty = parameters[..parameters.len() - 1]
                .iter()
                .rev()
                .fold(result.clone(), |result, parameter| {
                    MT::Fun(Box::new((*parameter).clone()), Box::new(result))
                });
            f.locals.remove(context as usize);
            f.arity -= 1;
        }
    }
    // Context arguments and rewritten constructors can add expressions beyond
    // the admission estimate. Charge actual completed clones before publishing.
    let added = functions.iter().map(weight).sum::<usize>();
    if added > growth {
        return None;
    }
    output.shapes.extend(shapes);
    output.funcs.extend(functions);
    for (old, new) in ids {
        if program.self_tail.contains(&old) {
            output.self_tail.insert(new);
        }
    }
    let entry = &mut output.funcs[plan.root];
    entry.body = Body::RegionEntry { worker };
    entry.locals.truncate(entry.arity as usize);
    Some(added)
}

/// Visit each expression once, including rejected forms when sizing a program.
fn inspect(expr: &Expr, mut visit: impl FnMut(&Expr)) -> usize {
    let mut pending = vec![expr];
    let mut count = 0;
    while let Some(expr) = pending.pop() {
        count += 1;
        visit(expr);
        match expr {
            Expr::Call(_, args) | Expr::Construct(_, args) | Expr::Record(args) => {
                pending.extend(args)
            }
            Expr::Apply(function, args) => {
                pending.push(function);
                pending.extend(args);
            }
            Expr::Let(_, a, b) => {
                pending.push(a);
                pending.push(b);
            }
            Expr::Match(a, arms) => {
                pending.push(a);
                pending.extend(arms.iter().map(|(_, b)| b));
            }
            Expr::Field(a, _)
            | Expr::Trace(_, a)
            | Expr::Dup(_, a)
            | Expr::Drop(_, a)
            | Expr::BorrowGlobal(_, _, a)
            | Expr::ResourceRegion { body: a, .. } => pending.push(a),
            Expr::SetFields(a, fields) => {
                pending.push(a);
                pending.extend(fields.iter().map(|(_, b)| b));
            }
            _ => {}
        }
    }
    count
}

pub(super) fn weight(function: &Func) -> usize {
    1 + function.locals.len()
        + match &function.body {
            Body::Expr(e) => inspect(e, |_| {}),
            _ => 1,
        }
}

fn prune_pattern(p: &mut Pat, context: Local) {
    match p {
        Pat::Bind(l) => {
            assert_ne!(*l, context);
            *l -= u32::from(*l > context);
        }
        Pat::Construct(_, fields) | Pat::Record(fields) => {
            fields.iter_mut().for_each(|p| prune_pattern(p, context))
        }
        _ => {}
    }
}

fn prune_context(
    expr: &mut Expr,
    start: FuncId,
    needs: &BTreeSet<FuncId>,
    context: Local,
    remove: bool,
) {
    let local = |l: &mut Local| {
        if remove {
            assert_ne!(*l, context);
            *l -= u32::from(*l > context);
        }
    };
    match expr {
        Expr::Local(l) => local(l),
        Expr::Call(id, args) => {
            if *id >= start && !needs.contains(id) {
                args.pop();
            }
            for arg in args {
                prune_context(arg, start, needs, context, remove);
            }
        }
        Expr::Construct(_, args) | Expr::Record(args) => {
            for arg in args {
                prune_context(arg, start, needs, context, remove);
            }
        }
        Expr::Let(l, value, body) => {
            local(l);
            prune_context(value, start, needs, context, remove);
            prune_context(body, start, needs, context, remove);
        }
        Expr::Match(value, arms) => {
            prune_context(value, start, needs, context, remove);
            for (p, body) in arms {
                if remove {
                    prune_pattern(p, context);
                }
                prune_context(body, start, needs, context, remove);
            }
        }
        Expr::Field(value, _) => prune_context(value, start, needs, context, remove),
        Expr::SetFields(value, fields) => {
            prune_context(value, start, needs, context, remove);
            for (_, value) in fields {
                prune_context(value, start, needs, context, remove);
            }
        }
        _ => {}
    }
}

/// Analysis gets eight units per original expression/local/type edge; helper
/// bodies consume that budget as they are visited. Added code gets at most twice
/// the original program's expression/local weight. These are optimization limits,
/// not language limits: an unselected invocation keeps its ordinary owners.
pub(in crate::cgen) fn lower(program: &Program) -> Cow<'_, Program> {
    let mut output = Cow::Borrowed(program);
    let nodes: Vec<_> = program
        .shapes
        .keys()
        .filter(|node| node_shape(program, node))
        .collect();
    if nodes.is_empty() {
        return output;
    }
    let types = Types::new(program);
    let type_weight =
        1 + types.parents.len() + types.parents.values().map(BTreeSet::len).sum::<usize>();
    let unknown = types.containing(&MT::con("?"));
    let weights: Vec<_> = program.funcs.iter().map(weight).collect();
    let original_weight = weights.iter().sum::<usize>();
    let mut growth = original_weight.saturating_mul(2);
    let mut budget = (original_weight + type_weight).saturating_mul(8);
    for node in nodes {
        let Some(left) = budget.checked_sub(type_weight) else {
            break;
        };
        budget = left;
        let containing = types.containing(node);
        for (root, function) in program.funcs.iter().enumerate() {
            let Some(left) = budget.checked_sub(1 + function.locals.len()) else {
                return output;
            };
            budget = left;
            if matches!(output.funcs[root].body, Body::RegionEntry { .. }) {
                continue;
            }
            if let Some(plan) =
                prove_cached(program, root, node, &containing, &unknown, &mut budget)
            {
                let Some(TypeShape::Adt(variants)) = program.shapes.get(node) else {
                    unreachable!()
                };
                let constructors: usize = variants
                    .iter()
                    .filter(|(_, fields)| !fields.is_empty())
                    .map(|(_, fields)| fields.len() + 3)
                    .sum();
                let cost = weights[root]
                    + 1
                    + plan
                        .helpers
                        .iter()
                        .map(|id| weights[*id] + 1)
                        .sum::<usize>()
                    + constructors;
                if cost > growth {
                    continue;
                }
                let Some(left) = budget.checked_sub(cost.saturating_mul(4) + type_weight) else {
                    return output;
                };
                budget = left;
                if let Some(added) =
                    specialize(program, &plan, &containing, output.to_mut(), growth)
                {
                    growth -= added;
                }
            }
        }
    }
    output
}
