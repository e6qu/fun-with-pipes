//! Replace an internal nested numeric-record parameter with its numeric leaves.
//! All uses and direct callers are checked before any signature changes. This
//! runs on the already-owned packed lowering result, before ownership insertion.
use std::collections::HashMap;

use crate::ir::*;
use crate::value::Value;

struct Shape {
    fields: Vec<MT>,
    leaves: Vec<(Vec<u32>, MT)>,
}

fn shape(program: &Program, function: &Func) -> Option<Shape> {
    if function.arity != 1 || !matches!(function.body, Body::Expr(_)) {
        return None;
    }
    let outer = record_fields(&program.shapes, &function.locals[0])?;
    if outer.is_empty() || outer.len() > super::MAX_UNBOXED {
        return None;
    }
    let mut leaves = Vec::new();
    let mut nested = false;
    for (index, (_, ty)) in outer.iter().enumerate() {
        if let Some(fields) = record_fields(&program.shapes, ty) {
            nested = true;
            if fields.is_empty() || fields.len() > super::MAX_UNBOXED {
                return None;
            }
            for (field, (_, ty)) in fields.iter().enumerate() {
                super::scalar(ty)?;
                leaves.push((vec![index as u32, field as u32], ty.clone()));
            }
        } else {
            super::scalar(ty)?;
            leaves.push((vec![index as u32], ty.clone()));
        }
        if leaves.len() > super::MAX_UNBOXED {
            return None;
        }
    }
    (nested && leaves.len() >= 2).then_some(Shape {
        fields: outer.iter().map(|(_, ty)| ty.clone()).collect(),
        leaves,
    })
}

fn walk(expr: &Expr, visit: &mut impl FnMut(&Expr)) {
    visit(expr);
    match expr {
        Expr::Call(_, xs) | Expr::Record(xs) | Expr::Construct(_, xs) => {
            xs.iter().for_each(|e| walk(e, visit));
        }
        Expr::Apply(f, xs) => {
            walk(f, visit);
            xs.iter().for_each(|e| walk(e, visit));
        }
        Expr::Let(_, a, b) => {
            walk(a, visit);
            walk(b, visit);
        }
        Expr::Match(value, arms) => {
            walk(value, visit);
            arms.iter().for_each(|(_, e)| walk(e, visit));
        }
        Expr::SetFields(base, fields) => {
            walk(base, visit);
            fields.iter().for_each(|(_, e)| walk(e, visit));
        }
        Expr::Field(e, _)
        | Expr::Trace(_, e)
        | Expr::Dup(_, e)
        | Expr::Drop(_, e)
        | Expr::BorrowGlobal(_, _, e)
        | Expr::ResourceRegion { body: e, .. } => walk(e, visit),
        Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => {}
    }
}

fn value_functions(value: &Value, visit: &mut impl FnMut(FuncId)) {
    match value {
        Value::Closure(c) => {
            visit(c.func);
            c.args.iter().for_each(|v| value_functions(v, visit));
        }
        Value::Data(_, xs) | Value::Record(xs) => {
            xs.iter().for_each(|v| value_functions(v, visit));
        }
        Value::Array(xs) => xs.iter().for_each(|v| value_functions(v, visit)),
        Value::Set(xs) => xs.iter().for_each(|v| value_functions(v, visit)),
        Value::Map(xs) => xs.iter().for_each(|(a, b)| {
            value_functions(a, visit);
            value_functions(b, visit);
        }),
        _ => {}
    }
}

fn pattern_functions(pattern: &Pat, visit: &mut impl FnMut(FuncId)) {
    match pattern {
        Pat::Lit(value) => value_functions(value, visit),
        Pat::Construct(_, fields) | Pat::Record(fields) => {
            fields.iter().for_each(|p| pattern_functions(p, visit));
        }
        Pat::Bind(_) | Pat::Wild => {}
    }
}

/// Two iterative graph traversals find strongly connected components. Unlike
/// a reachability search per candidate, each edge is inspected a fixed number
/// of times even for a long chain of functions.
fn recursive(graph: &[Vec<FuncId>]) -> Vec<bool> {
    let mut reverse = vec![Vec::new(); graph.len()];
    for (id, edges) in graph.iter().enumerate() {
        for next in edges {
            reverse[*next].push(id);
        }
    }
    let mut seen = vec![false; graph.len()];
    let mut order = Vec::new();
    for root in 0..graph.len() {
        let mut pending = vec![(root, false)];
        while let Some((id, finished)) = pending.pop() {
            if finished {
                order.push(id);
            } else if !seen[id] {
                seen[id] = true;
                pending.push((id, true));
                pending.extend(graph[id].iter().rev().map(|next| (*next, false)));
            }
        }
    }
    seen.fill(false);
    let mut result = vec![false; graph.len()];
    for root in order.into_iter().rev() {
        if seen[root] {
            continue;
        }
        let mut members = Vec::new();
        let mut pending = vec![root];
        while let Some(id) = pending.pop() {
            if !seen[id] {
                seen[id] = true;
                members.push(id);
                pending.extend(&reverse[id]);
            }
        }
        if members.len() > 1 || graph[root].contains(&root) {
            for id in members {
                result[id] = true;
            }
        }
    }
    result
}

fn plain_read(expr: &Expr, depth: usize) -> bool {
    match expr {
        Expr::Local(_) => true,
        Expr::Field(base, _) if depth < 2 => plain_read(base, depth + 1),
        _ => false,
    }
}

fn read_type<'a>(expr: &Expr, locals: &'a [MT], shapes: &'a Shapes) -> Option<&'a MT> {
    match expr {
        Expr::Local(local) => locals.get(*local as usize),
        Expr::Field(base, field) => record_fields(shapes, read_type(base, locals, shapes)?)?
            .get(*field as usize)
            .map(|(_, ty)| ty),
        _ => None,
    }
}

/// Keep computed inputs intact. Bindings may hold ordinary data, including
/// the Option returned by checked array reads. Reject possible resource owners;
/// each complete input keeps its original scope before numeric fields are read.
fn numeric_input(expr: &Expr, expected: &MT, locals: &[MT], shapes: &Shapes) -> bool {
    if plain_read(expr, 0) {
        return read_type(expr, locals, shapes) == Some(expected);
    }
    match expr {
        Expr::Let(local, _, body)
            if locals.get(*local as usize).is_some_and(|ty| {
                !crate::resource::may_hold_resource(shapes, ty)
                    && !crate::resource::contains_channel(shapes, ty)
            }) =>
        {
            numeric_input(body, expected, locals, shapes)
        }
        Expr::Record(values) => record_fields(shapes, expected).is_some_and(|fields| {
            fields.len() == values.len()
                && fields.iter().zip(values).all(|((_, ty), value)| {
                    super::scalar(ty).is_some()
                        && plain_read(value, 0)
                        && read_type(value, locals, shapes) == Some(ty)
                })
        }),
        _ => false,
    }
}

fn argument(expr: &Expr, shape: &Shape, locals: &[MT], shapes: &Shapes) -> bool {
    let Expr::Record(fields) = expr else {
        return false;
    };
    fields.len() == shape.fields.len()
        && fields
            .iter()
            .zip(&shape.fields)
            .all(|(value, expected)| numeric_input(value, expected, locals, shapes))
}

fn path(expr: &Expr, aliases: &HashMap<Local, Vec<u32>>, depth: usize) -> Option<Vec<u32>> {
    if depth > 2 {
        return None;
    }
    match expr {
        Expr::Local(local) => aliases.get(local).cloned(),
        Expr::Field(base, field) => {
            let mut prefix = path(base, aliases, depth + 1)?;
            prefix.push(*field);
            (prefix.len() <= 2).then_some(prefix)
        }
        _ => None,
    }
}

/// The analysis and rewrite use the same lexical traversal. The first pass
/// changes no expression; the second runs only after every caller also passes.
fn expression(
    expr: &mut Expr,
    shape: &Shape,
    aliases: &mut HashMap<Local, Vec<u32>>,
    rewrite: bool,
    visits: &mut usize,
) -> bool {
    *visits += 1;
    if let Some(path) = path(expr, aliases, 0) {
        let Some(index) = shape.leaves.iter().position(|(leaf, _)| leaf == &path) else {
            return false;
        };
        if rewrite {
            *expr = Expr::Field(Box::new(Expr::Local(0)), index as u32);
        }
        return true;
    }
    if let Expr::Let(local, value, body) = expr {
        if let Some(prefix) = path(value, aliases, 0) {
            if shape
                .leaves
                .iter()
                .any(|(leaf, _)| leaf.len() > prefix.len() && leaf.starts_with(&prefix))
            {
                let local = *local;
                let previous = aliases.insert(local, prefix);
                let valid = expression(body, shape, aliases, rewrite, visits);
                if let Some(previous) = previous {
                    aliases.insert(local, previous);
                } else {
                    aliases.remove(&local);
                }
                if rewrite {
                    *expr = std::mem::replace(&mut **body, Expr::Local(0));
                }
                return valid;
            }
        }
    }
    let mut visit = |e: &mut Expr| expression(e, shape, aliases, rewrite, visits);
    match expr {
        Expr::Local(local) => !aliases.contains_key(local),
        Expr::Const(_) | Expr::Func(_) => true,
        Expr::Call(_, xs) | Expr::Record(xs) | Expr::Construct(_, xs) => xs.iter_mut().all(visit),
        Expr::Apply(f, xs) => visit(f) && xs.iter_mut().all(visit),
        Expr::Let(_, a, b) => visit(a) && visit(b),
        Expr::Match(value, arms) => visit(value) && arms.iter_mut().all(|(_, e)| visit(e)),
        Expr::Field(base, _) => visit(base),
        Expr::Trace(..)
        | Expr::ResourceRegion { .. }
        | Expr::SetFields(..)
        | Expr::Dup(..)
        | Expr::Drop(..)
        | Expr::BorrowGlobal(..) => false,
    }
}

fn callers(expr: &mut Expr, selected: &[Option<Shape>], locals: &mut Vec<MT>, visits: &mut usize) {
    *visits += 1;
    match expr {
        Expr::Call(id, xs) => {
            for x in xs.iter_mut() {
                callers(x, selected, locals, visits);
            }
            if let Some(shape) = &selected[*id] {
                let Expr::Record(fields) = &mut xs[0] else {
                    unreachable!()
                };
                let mut bindings = Vec::new();
                for (value, ty) in fields.iter_mut().zip(&shape.fields) {
                    if !plain_read(value, 0) {
                        // Keep the entire computation in its original lexical
                        // scope. Fresh names prevent capture between arguments.
                        let local = locals.len() as Local;
                        locals.push(ty.clone());
                        bindings.push((local, std::mem::replace(value, Expr::Local(local))));
                    }
                }
                xs[0] = Expr::Record(
                    shape
                        .leaves
                        .iter()
                        .map(|(path, _)| {
                            let mut value = fields[path[0] as usize].clone();
                            for field in &path[1..] {
                                value = Expr::Field(Box::new(value), *field);
                            }
                            value
                        })
                        .collect(),
                );
                if !bindings.is_empty() {
                    let mut body = std::mem::replace(expr, Expr::Local(0));
                    for (local, value) in bindings.into_iter().rev() {
                        body = Expr::Let(local, Box::new(value), Box::new(body));
                    }
                    *expr = body;
                }
            }
        }
        Expr::Record(xs) | Expr::Construct(_, xs) => xs
            .iter_mut()
            .for_each(|e| callers(e, selected, locals, visits)),
        Expr::Apply(f, xs) => {
            callers(f, selected, locals, visits);
            xs.iter_mut()
                .for_each(|e| callers(e, selected, locals, visits));
        }
        Expr::Let(_, a, b) => {
            callers(a, selected, locals, visits);
            callers(b, selected, locals, visits);
        }
        Expr::Match(value, arms) => {
            callers(value, selected, locals, visits);
            arms.iter_mut()
                .for_each(|(_, e)| callers(e, selected, locals, visits));
        }
        Expr::SetFields(base, fields) => {
            callers(base, selected, locals, visits);
            fields
                .iter_mut()
                .for_each(|(_, e)| callers(e, selected, locals, visits));
        }
        Expr::Field(e, _)
        | Expr::Trace(_, e)
        | Expr::Dup(_, e)
        | Expr::Drop(_, e)
        | Expr::BorrowGlobal(_, _, e)
        | Expr::ResourceRegion { body: e, .. } => callers(e, selected, locals, visits),
        Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => {}
    }
}

/// Return the number of visited expression nodes for deterministic scaling tests.
pub(super) fn lower(program: &mut Program, entries: &[FuncId]) -> usize {
    let mut selected: Vec<_> = program.funcs.iter().map(|f| shape(program, f)).collect();
    if selected.iter().all(Option::is_none) {
        return 0;
    }
    let mut blocked = vec![false; program.funcs.len()];
    let mut called = vec![false; program.funcs.len()];
    let mut graph = vec![Vec::new(); program.funcs.len()];
    let mut visits = 0;
    for (caller, function) in program.funcs.iter().enumerate() {
        match &function.body {
            Body::Expr(body) => walk(body, &mut |e| {
                visits += 1;
                match e {
                    Expr::Call(id, args) => {
                        graph[caller].push(*id);
                        called[*id] = true;
                        if let Some(shape) = &selected[*id] {
                            blocked[*id] |= args.len() != 1
                                || !argument(&args[0], shape, &function.locals, &program.shapes);
                        }
                    }
                    Expr::Func(id) | Expr::BorrowGlobal(_, id, _) => {
                        blocked[*id] = true;
                        graph[caller].push(*id);
                    }
                    Expr::Const(value) => value_functions(value, &mut |id| {
                        blocked[id] = true;
                        graph[caller].push(id);
                    }),
                    Expr::Match(_, arms) => {
                        for (pattern, _) in arms {
                            pattern_functions(pattern, &mut |id| {
                                blocked[id] = true;
                                graph[caller].push(id);
                            });
                        }
                    }
                    _ => {}
                }
            }),
            Body::RegionEntry { worker } => {
                blocked[*worker] = true;
                graph[caller].push(*worker);
            }
            Body::DirectAdScope { callback }
            | Body::PackedRecordMap { callback }
            | Body::PackedRecordFold { callback }
            | Body::ScalarBufferMap { callback }
            | Body::ScalarBufferZip { callback, .. }
            | Body::OwnedScalarArrayMap { callback }
            | Body::OwnedScalarBufferZip { callback, .. }
            | Body::RangeZip { callback, .. }
            | Body::PackedRecordRangeZip { callback, .. }
            | Body::PackedRecordPairs { callback, .. } => {
                blocked[*callback] = true;
                graph[caller].push(*callback);
            }
            Body::Remote(remote) => {
                if let Some(id) = remote.iter_fn {
                    blocked[id] = true;
                    graph[caller].push(id);
                }
            }
            _ => {}
        }
    }
    for id in program
        .exports
        .iter()
        .chain(&program.named)
        .chain(&program.tests)
        .map(|(_, id)| *id)
        .chain(program.cached_values.iter().copied())
        .chain(entries.iter().copied())
        .chain(program.main)
        .chain(Some(0))
    {
        if let Some(blocked) = blocked.get_mut(id) {
            *blocked = true;
        }
    }
    if let Some(service) = &program.service {
        for method in &service.methods {
            blocked[method.func] = true;
            if let Some(id) = method.iter_fn {
                blocked[id] = true;
            }
        }
    }
    let recursive = recursive(&graph);
    for (id, candidate) in selected.iter_mut().enumerate() {
        if blocked[id] || !called[id] || recursive[id] {
            *candidate = None;
            continue;
        }
        if let (Some(shape), Body::Expr(body)) = (candidate.as_ref(), &mut program.funcs[id].body) {
            if !expression(
                body,
                shape,
                &mut HashMap::from([(0, vec![])]),
                false,
                &mut visits,
            ) {
                *candidate = None;
            }
        }
    }
    for (id, shape) in selected.iter().enumerate() {
        if let Some(shape) = shape {
            let function = &mut program.funcs[id];
            let Body::Expr(body) = &mut function.body else {
                unreachable!()
            };
            assert!(expression(
                body,
                shape,
                &mut HashMap::from([(0, vec![])]),
                true,
                &mut visits
            ));
            let parameter = MT::Record(
                shape
                    .leaves
                    .iter()
                    .enumerate()
                    .map(|(i, (_, ty))| (i.to_string(), ty.clone()))
                    .collect(),
            );
            let MT::Fun(input, _) = &mut function.ty else {
                unreachable!()
            };
            **input = parameter.clone();
            function.locals[0] = parameter;
        }
    }
    if selected.iter().any(Option::is_some) {
        for function in &mut program.funcs {
            if let Body::Expr(body) = &mut function.body {
                callers(body, &selected, &mut function.locals, &mut visits);
            }
        }
    }
    visits
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::rc::Rc;

    use crate::value::Closure;

    fn tuple(fields: Vec<MT>) -> MT {
        MT::Record(
            fields
                .into_iter()
                .enumerate()
                .map(|(i, ty)| (i.to_string(), ty))
                .collect(),
        )
    }

    fn arrow(input: MT, output: MT) -> MT {
        MT::Fun(Box::new(input), Box::new(output))
    }

    fn example() -> Program {
        let number = MT::con("std::I64");
        let pair = tuple(vec![number.clone(), number.clone()]);
        let nested = tuple(vec![pair.clone(), pair.clone()]);
        Program {
            funcs: vec![
                Func {
                    name: "forward".into(),
                    arity: 2,
                    locals: vec![pair.clone(), pair.clone()],
                    ty: arrow(pair.clone(), arrow(pair.clone(), number.clone())),
                    body: Body::Expr(Expr::Call(
                        1,
                        vec![Expr::Record(vec![Expr::Local(0), Expr::Local(1)])],
                    )),
                },
                Func {
                    name: "leaf".into(),
                    arity: 1,
                    locals: vec![nested.clone(), pair],
                    ty: arrow(nested, number),
                    body: Body::Expr(Expr::Let(
                        1,
                        Box::new(Expr::Field(Box::new(Expr::Local(0)), 0)),
                        Box::new(Expr::Field(Box::new(Expr::Local(1)), 1)),
                    )),
                },
            ],
            main: Some(0),
            ..Program::default()
        }
    }

    fn computed_example() -> Program {
        let mut program = example();
        let number = MT::con("std::I64");
        let result = tuple(vec![number.clone(); 4]);
        let pair = program.funcs[0].locals[0].clone();
        program.funcs[0].ty = arrow(pair.clone(), arrow(pair, result.clone()));
        program.funcs[0].locals.extend([number.clone(), number]);
        program.funcs[0].body = Body::Expr(Expr::Call(
            1,
            vec![Expr::Record(
                (0..2)
                    .map(|index| {
                        Expr::Let(
                            index + 2,
                            Box::new(Expr::Const(Value::I64(7 + index as i64))),
                            Box::new(Expr::Record(vec![
                                Expr::Local(index + 2),
                                Expr::Field(Box::new(Expr::Local(index)), 1),
                            ])),
                        )
                    })
                    .collect(),
            )],
        ));
        program.funcs[1].ty = arrow(program.funcs[1].locals[0].clone(), result);
        program.funcs[1].body = Body::Expr(Expr::Record(
            (0..2)
                .flat_map(|outer| {
                    (0..2).map(move |inner| {
                        Expr::Field(
                            Box::new(Expr::Field(Box::new(Expr::Local(0)), outer)),
                            inner,
                        )
                    })
                })
                .collect(),
        ));
        program
    }

    #[test]
    fn computed_inputs_keep_their_values_bindings_and_shared_arguments() {
        let original = computed_example();
        crate::ir::check_locals(&original).unwrap();
        let mut program = original.clone();
        lower(&mut program, &[]);
        crate::ir::check_locals(&program).unwrap();
        assert_eq!(
            program.funcs.len(),
            original.funcs.len(),
            "no worker cloning"
        );
        assert_eq!(
            program.funcs[0].locals.len(),
            6,
            "one fresh name per computed input"
        );
        assert_eq!(
            record_fields(&program.shapes, &program.funcs[1].locals[0])
                .unwrap()
                .len(),
            4
        );
        for value in [-11, 0, 57] {
            let shared = Value::Record(vec![Value::I64(2), Value::I64(value)].into());
            let expected = Value::Record(
                vec![
                    Value::I64(7),
                    Value::I64(value),
                    Value::I64(8),
                    Value::I64(value),
                ]
                .into(),
            );
            for variant in [&original, &program] {
                let mut interpreter =
                    crate::interp::Interp::new(variant, Box::new(std::io::sink())).unwrap();
                assert_eq!(
                    interpreter
                        .call_root(0, vec![shared.clone(), shared.clone()])
                        .unwrap(),
                    expected
                );
            }
            assert_eq!(
                shared,
                Value::Record(vec![Value::I64(2), Value::I64(value)].into())
            );
        }
    }

    #[test]
    fn computed_data_bindings_keep_the_original_input_scope() {
        let mut original = computed_example();
        let pair = original.funcs[0].locals[0].clone();
        original.funcs[0].locals.push(pair);
        let Body::Expr(Expr::Call(_, arguments)) = &mut original.funcs[0].body else {
            unreachable!()
        };
        let Expr::Record(fields) = &mut arguments[0] else {
            unreachable!()
        };
        let Expr::Let(_, value, _) = &mut fields[0] else {
            unreachable!()
        };
        **value = Expr::Field(Box::new(Expr::Local(4)), 0);
        fields[0] = Expr::Let(
            4,
            Box::new(Expr::Record(vec![
                Expr::Const(Value::I64(7)),
                Expr::Const(Value::I64(9)),
            ])),
            Box::new(fields[0].clone()),
        );
        crate::ir::check_locals(&original).unwrap();
        let mut program = original.clone();
        lower(&mut program, &[]);
        crate::ir::check_locals(&program).unwrap();
        assert_eq!(
            record_fields(&program.shapes, &program.funcs[1].locals[0])
                .unwrap()
                .len(),
            4
        );
        let Body::Expr(Expr::Let(_, value, _)) = &program.funcs[0].body else {
            panic!("computed input must retain its own binding")
        };
        assert!(matches!(&**value, Expr::Let(4, _, _)));
        let input = Value::Record(vec![Value::I64(2), Value::I64(11)].into());
        for variant in [&original, &program] {
            let mut interpreter =
                crate::interp::Interp::new(variant, Box::new(std::io::sink())).unwrap();
            assert_eq!(
                interpreter
                    .call_root(0, vec![input.clone(), input.clone()])
                    .unwrap(),
                Value::Record(
                    vec![Value::I64(7), Value::I64(11), Value::I64(8), Value::I64(11),].into(),
                )
            );
        }
        for ty in [
            MT::con("std::File"),
            MT::Con("std::Channel".into(), vec![MT::con("std::I64")]),
            arrow(MT::con("std::I64"), MT::con("std::I64")),
        ] {
            let mut rejected = computed_example();
            rejected.funcs[0].locals.push(ty.clone());
            rejected.funcs.push(Func {
                name: "owner".into(),
                arity: 0,
                locals: vec![],
                ty,
                body: Body::Prim("test.owner".into()),
            });
            let Body::Expr(Expr::Call(_, arguments)) = &mut rejected.funcs[0].body else {
                unreachable!()
            };
            let Expr::Record(fields) = &mut arguments[0] else {
                unreachable!()
            };
            fields[0] = Expr::Let(
                4,
                Box::new(Expr::Call(2, vec![])),
                Box::new(fields[0].clone()),
            );
            crate::ir::check_locals(&rejected).unwrap();
            let before = rejected.funcs[1].ty.clone();
            lower(&mut rejected, &[]);
            assert_eq!(rejected.funcs[1].ty, before);
        }
    }

    #[test]
    fn known_array_workers_expose_checked_numeric_edge_inputs() {
        crate::driver::with_big_stack(|| {
            let source = format!(
                "{}\n{}\nmain = [-1.2, 1.0, -1.2] | array.from-list | local-gradient edge | array.to-list | echo\n",
                include_str!("../../tests/fixtures/descent_local_ad.fwp"),
                include_str!("../../tests/fixtures/structured_ad_objectives.fwp"),
            );
            let (_, mut program) = crate::driver::compile_source(
                "array-numeric-worker.fwp",
                &source,
                crate::mono::Roots {
                    main: true,
                    ..Default::default()
                },
            )
            .unwrap_or_else(|failure| panic!("{}", failure.rendered));
            let edges: Vec<_> = program
                .funcs
                .iter()
                .enumerate()
                .filter(|(_, function)| function.name == "edge")
                .map(|(id, _)| id)
                .collect();
            assert!(!edges.is_empty());
            for &edge in &edges {
                let expected = shape(&program, &program.funcs[edge]).unwrap();
                let mut direct_calls = 0;
                for function in &program.funcs {
                    if let Body::Expr(body) = &function.body {
                        walk(body, &mut |expression| match expression {
                            Expr::Call(id, args) if *id == edge => {
                                direct_calls += 1;
                                assert!(
                                    args.len() == 1
                                        && argument(
                                            &args[0],
                                            &expected,
                                            &function.locals,
                                            &program.shapes
                                        ),
                                    "numeric argument rejected in {}: {args:?}",
                                    function.name
                                );
                            }
                            Expr::Func(id) if *id == edge => {
                                panic!("edge still escapes in {}", function.name)
                            }
                            _ => {}
                        });
                    }
                }
                assert!(direct_calls > 0);
            }
            lower(&mut program, &[]);
            crate::ir::check_locals(&program).unwrap();
            for edge in edges {
                let fields =
                    record_fields(&program.shapes, &program.funcs[edge].locals[0]).unwrap();
                assert_eq!(fields.len(), 4);
                assert!(fields
                    .iter()
                    .all(|(_, ty)| super::super::scalar(ty).is_some()));
            }
        });
    }

    #[test]
    fn computed_inputs_preserve_left_to_right_traps() {
        let mut original = computed_example();
        original.funcs.push(Func {
            name: "fail".into(),
            arity: 1,
            locals: vec![MT::con("std::String")],
            ty: arrow(MT::con("std::String"), MT::con("std::I64")),
            body: Body::Prim("prim.trap".into()),
        });
        let Body::Expr(Expr::Call(_, args)) = &mut original.funcs[0].body else {
            unreachable!()
        };
        let Expr::Record(fields) = &mut args[0] else {
            unreachable!()
        };
        for (value, message) in fields.iter_mut().zip(["first input", "second input"]) {
            let Expr::Let(_, prefix, _) = value else {
                unreachable!()
            };
            **prefix = Expr::Call(2, vec![Expr::Const(Value::Str(message.into()))]);
        }
        let mut program = original.clone();
        lower(&mut program, &[]);
        crate::ir::check_locals(&program).unwrap();
        for variant in [&original, &program] {
            let mut interpreter =
                crate::interp::Interp::new(variant, Box::new(std::io::sink())).unwrap();
            let pair = Value::Record(vec![Value::I64(1), Value::I64(2)].into());
            let error = interpreter
                .call_root(0, vec![pair.clone(), pair])
                .unwrap_err();
            assert_eq!(format!("{error:?}"), "Trap(\"first input\")");
        }
    }

    #[test]
    fn source_fixture_reaches_internal_numeric_parameter_lowering() {
        crate::driver::with_big_stack(|| {
            let source = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
                .join("tests/fixtures/numeric_callback_inputs.fwp");
            let (_, mut program) = crate::driver::compile_file(
                &source,
                crate::mono::Roots {
                    main: true,
                    ..Default::default()
                },
            )
            .unwrap_or_else(|failure| panic!("{}", failure.rendered));
            let candidates: Vec<_> = program
                .funcs
                .iter()
                .enumerate()
                .filter(|(_, function)| shape(&program, function).is_some())
                .map(|(id, function)| (id, function.ty.clone()))
                .collect();
            assert!(
                !candidates.is_empty(),
                "fixture must keep a nested internal call"
            );
            lower(&mut program, &[]);
            assert!(
                candidates
                    .iter()
                    .any(|(id, ty)| program.funcs[*id].ty != *ty),
                "fixture must reach numeric parameter rewriting: {program:#?}"
            );
            crate::ir::check_locals(&program).unwrap();
        });
    }

    #[test]
    fn numeric_aliases_and_all_direct_callers_change_together() {
        let mut program = example();
        crate::ir::check_locals(&program).unwrap();
        let mut second = program.funcs[0].clone();
        second.name = "second-forwarder".into();
        program.funcs.push(second);
        lower(&mut program, &[]);
        crate::ir::check_locals(&program).unwrap();
        assert_eq!(
            record_fields(&program.shapes, &program.funcs[1].locals[0])
                .unwrap()
                .len(),
            4
        );
        assert!(
            matches!(&program.funcs[1].body, Body::Expr(Expr::Field(base, 1)) if matches!(**base, Expr::Local(0)))
        );
        for id in [0, 2] {
            let Body::Expr(Expr::Call(1, args)) = &program.funcs[id].body else {
                panic!("direct caller")
            };
            let Expr::Record(fields) = &args[0] else {
                panic!("numeric argument")
            };
            assert_eq!(fields.len(), 4);
            assert!(matches!(&fields[3], Expr::Field(base, 1) if matches!(**base, Expr::Local(1))));
            assert_eq!(
                super::super::abi_of(&program, &program.funcs[id])
                    .unwrap()
                    .params,
                vec![Some(2), Some(2)]
            );
        }
    }

    #[test]
    fn exported_dynamic_and_nonliteral_callers_keep_their_signatures() {
        for mode in 0..7 {
            let mut program = example();
            match mode {
                0 => program.exports.push(("leaf".into(), 1)),
                1 => program.funcs.push(Func {
                    name: "function-value".into(),
                    arity: 0,
                    locals: vec![],
                    ty: program.funcs[1].ty.clone(),
                    body: Body::Expr(Expr::Func(1)),
                }),
                2 => {
                    let nested = program.funcs[1].locals[0].clone();
                    program.funcs[0] = Func {
                        name: "whole".into(),
                        arity: 1,
                        locals: vec![nested.clone()],
                        ty: arrow(nested, MT::con("std::I64")),
                        body: Body::Expr(Expr::Call(1, vec![Expr::Local(0)])),
                    };
                }
                3 => {
                    program.named.push(("leaf".into(), 1));
                }
                4 => {}
                5 | 6 => {
                    let value = Value::Closure(Rc::new(Closure {
                        func: 1,
                        args: vec![],
                    }));
                    let body = if mode == 5 {
                        Expr::Const(value)
                    } else {
                        Expr::Match(
                            Box::new(Expr::Local(0)),
                            vec![(Pat::Lit(value), Expr::Const(Value::I64(0)))],
                        )
                    };
                    program.funcs.push(Func {
                        name: "constant-function".into(),
                        arity: if mode == 5 { 0 } else { 1 },
                        locals: if mode == 5 {
                            vec![]
                        } else {
                            vec![program.funcs[1].ty.clone()]
                        },
                        ty: if mode == 5 {
                            program.funcs[1].ty.clone()
                        } else {
                            arrow(program.funcs[1].ty.clone(), MT::con("std::I64"))
                        },
                        body: Body::Expr(body),
                    });
                }
                _ => unreachable!(),
            }
            crate::ir::check_locals(&program).unwrap();
            let original = program.funcs[1].ty.clone();
            lower(&mut program, if mode == 4 { &[1] } else { &[] });
            assert_eq!(program.funcs[1].ty, original);
            crate::ir::check_locals(&program).unwrap();
        }
    }

    #[test]
    fn measured_local_edge_uses_numeric_arguments() {
        crate::driver::with_big_stack(|| {
            let source = format!(
                "{}\nmain = [-1.2, 1.0, -1.2] | array.from-list | local-descend | array.to-list | echo\n",
                include_str!("../../tests/fixtures/descent_local_ad.fwp")
            );
            let (_, mut program) = crate::driver::compile_source(
                "local-numeric-worker.fwp",
                &source,
                crate::mono::Roots {
                    main: true,
                    ..Default::default()
                },
            )
            .unwrap_or_else(|failure| panic!("{}", failure.rendered));
            let edges: Vec<_> = program
                .funcs
                .iter()
                .enumerate()
                .filter(|(_, f)| f.name.contains("local-edge"))
                .filter_map(|(id, f)| shape(&program, f).map(|shape| (id, shape)))
                .collect();
            assert!(
                !edges.is_empty(),
                "retain the measured edge before native lowering"
            );
            for (id, shape) in &edges {
                for function in &program.funcs {
                    if let Body::Expr(body) = &function.body {
                        walk(body, &mut |e| match e {
                            Expr::Call(target, args) if target == id => {
                                eprintln!(
                                    "edge {id} direct caller {} eligible={}: {args:?}",
                                    function.name,
                                    args.len() == 1
                                        && argument(
                                            &args[0],
                                            shape,
                                            &function.locals,
                                            &program.shapes
                                        )
                                );
                            }
                            Expr::Func(target) if target == id => {
                                eprintln!("edge {id} function value in {}", function.name);
                            }
                            _ => {}
                        });
                    }
                }
            }
            lower(&mut program, &[]);
            crate::ir::check_locals(&program).unwrap();
            assert!(
                program.funcs.iter().any(|f| f.name.contains("local-edge")
                    && record_fields(&program.shapes, &f.locals[0]).is_some_and(|fields| fields
                        .len()
                        == 4
                        && fields
                            .iter()
                            .all(|(_, ty)| super::super::scalar(ty).is_some()))),
                "the measured edge needs four numeric fields"
            );
        });
    }

    #[test]
    fn whole_values_escape_but_repeated_numeric_reads_do_not() {
        let program = example();
        let shape = shape(&program, &program.funcs[1]).unwrap();
        let leaf = Expr::Field(Box::new(Expr::Field(Box::new(Expr::Local(0)), 1)), 0);
        for mut expr in [
            Expr::Local(0),
            Expr::Field(Box::new(Expr::Local(0)), 1),
            Expr::Record(vec![Expr::Local(0)]),
            Expr::Apply(Box::new(Expr::Func(2)), vec![Expr::Local(0)]),
        ] {
            assert!(!expression(
                &mut expr,
                &shape,
                &mut HashMap::from([(0, vec![])]),
                false,
                &mut 0
            ));
        }
        let mut expr = Expr::Record(vec![leaf.clone(), leaf]);
        assert!(expression(
            &mut expr,
            &shape,
            &mut HashMap::from([(0, vec![])]),
            true,
            &mut 0
        ));
        let Expr::Record(fields) = expr else {
            unreachable!()
        };
        assert!(fields
            .iter()
            .all(|e| matches!(e, Expr::Field(base, 2) if matches!(**base, Expr::Local(0)))));
    }

    #[test]
    fn shape_depth_width_and_effectful_arguments_are_excluded() {
        let number = MT::con("std::I64");
        let pair = tuple(vec![number.clone(), number.clone()]);
        for parameter in [
            tuple(vec![pair.clone(), MT::con("std::String")]),
            tuple(vec![pair.clone(), MT::con("std::F128")]),
            tuple(vec![tuple(vec![pair.clone()]), pair.clone()]),
            tuple(vec![pair.clone(), MT::unit()]),
            tuple(vec![pair.clone(); 5]),
        ] {
            let mut program = example();
            program.funcs[1].locals[0] = parameter.clone();
            program.funcs[1].ty = arrow(parameter, number.clone());
            assert!(shape(&program, &program.funcs[1]).is_none());
        }
        let program = example();
        let shape = shape(&program, &program.funcs[1]).unwrap();
        assert!(!argument(
            &Expr::Record(vec![Expr::Call(2, vec![]), Expr::Local(1)]),
            &shape,
            &program.funcs[0].locals,
            &program.shapes,
        ));
        let mut resource = Expr::ResourceRegion {
            parameters: vec![],
            bindings: vec![],
            body: Box::new(Expr::Field(
                Box::new(Expr::Field(Box::new(Expr::Local(0)), 0)),
                1,
            )),
        };
        assert!(!expression(
            &mut resource,
            &shape,
            &mut HashMap::from([(0, vec![])]),
            false,
            &mut 0
        ));
    }

    #[test]
    fn only_cycle_members_are_recursive_and_analysis_scales_linearly() {
        assert_eq!(
            recursive(&[vec![1], vec![2], vec![1], vec![3], vec![0], vec![]]),
            vec![false, true, true, true, false, false]
        );
        let mut counts = Vec::new();
        for count in [32, 128, 512] {
            let sample = example();
            let mut program = Program::default();
            program.funcs.push(Func {
                name: "root".into(),
                arity: 0,
                locals: vec![],
                ty: MT::unit(),
                body: Body::Expr(Expr::Record(vec![])),
            });
            for _ in 0..count {
                let callee = program.funcs.len();
                program.funcs.push(sample.funcs[1].clone());
                let mut caller = sample.funcs[0].clone();
                let Body::Expr(Expr::Call(id, _)) = &mut caller.body else {
                    unreachable!()
                };
                *id = callee;
                program.funcs.push(caller);
            }
            let visits = lower(&mut program, &[]);
            crate::ir::check_locals(&program).unwrap();
            assert!(visits <= 40 * count + 8, "{count}: {visits}");
            counts.push(visits);
        }
        assert_eq!(counts[2] - counts[1], 4 * (counts[1] - counts[0]));
    }
}
