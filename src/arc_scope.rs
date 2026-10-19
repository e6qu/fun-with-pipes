//! Finite closure-flow proof for raw AD operations and typed State lifetimes.
//!
//! Function values are sets of (function, supplied-argument count). Captures and
//! call summaries join monotonically. Aggregate fields conservatively share a
//! set: this can reject ambiguous flows, but cannot hide a callable in a tuple,
//! list, returned closure or recursive function. No source names imply a proof.
use crate::ir::{Body, Expr, FuncId, Pat, Program, TypeShape, MT};
use crate::value::Value;
use std::collections::{BTreeMap, BTreeSet};

type Closure = (FuncId, usize);
type Targets = BTreeSet<Closure>;
type Context = (FuncId, u8);
const AD: u8 = 1;
const STATE: u8 = 2;

struct Proof<'a> {
    program: &'a Program,
    captures: BTreeMap<Closure, Vec<Targets>>,
    inputs: BTreeMap<Context, Vec<Targets>>,
    outputs: BTreeMap<Context, Targets>,
    callback_values: BTreeMap<Context, Targets>,
    changed: bool,
    validate: bool,
    state_values: Targets,
}

fn join(destination: &mut Targets, source: &Targets) -> bool {
    let before = destination.len();
    destination.extend(source.iter().copied());
    before != destination.len()
}

fn has_functions(program: &Program, ty: &MT, seen: &mut BTreeSet<MT>) -> bool {
    if !seen.insert(ty.clone()) {
        return false;
    }
    match ty {
        MT::Fun(..) => true,
        MT::Record(fields) => fields
            .iter()
            .any(|(_, field)| has_functions(program, field, seen)),
        MT::Con(name, args) => {
            name == "?"
                || args.iter().any(|arg| has_functions(program, arg, seen))
                || match program.shapes.get(ty) {
                    Some(TypeShape::Record(fields)) => fields
                        .iter()
                        .any(|(_, field)| has_functions(program, field, seen)),
                    Some(TypeShape::Adt(variants)) => variants.iter().any(|(_, fields)| {
                        fields
                            .iter()
                            .any(|field| has_functions(program, field, seen))
                    }),
                    _ => false,
                }
        }
        MT::Nat(_) => false,
    }
}

impl Proof<'_> {
    fn consume_iterator(
        &mut self,
        id: FuncId,
        scoped: u8,
        initial: &Targets,
    ) -> Result<(), String> {
        let key = (id, scoped);
        let mut steps = initial.clone();
        steps.extend(
            self.callback_values
                .get(&key)
                .into_iter()
                .flatten()
                .copied(),
        );
        for &(target, supplied) in &steps {
            let count = self.program.funcs[target].arity as usize - supplied;
            let next = self.apply(
                &BTreeSet::from([(target, supplied)]),
                &vec![Targets::new(); count],
                scoped,
            )?;
            // Later positions can introduce different continuations.
            self.changed |= join(self.callback_values.entry(key).or_default(), &next);
        }
        Ok(())
    }

    fn service_boundaries(&mut self, entries: &[FuncId]) -> Result<(), String> {
        let Some(service) = &self.program.service else {
            return Ok(());
        };
        for method in &service.methods {
            if !entries.contains(&method.func) {
                continue;
            }
            let function = &self.program.funcs[method.func];
            let shape =
                crate::rpc::shape(&function.ty, function.arity as usize, method.error.as_ref());
            if shape.client_streaming() {
                let iterator = method.iter_fn.ok_or_else(|| {
                    format!(
                        "--gc arc: served method `{}` has no received iterator constructor",
                        method.name
                    )
                })?;
                let input = self.apply(&BTreeSet::from([(iterator, 0)]), &[Targets::new()], 0)?;
                let mut args = vec![Targets::new(); function.arity as usize];
                args[0] = input;
                self.request(method.func, 0, &args);
            }
            if matches!(shape.output, crate::rpc::Output::Iter(_)) {
                let returned = self
                    .outputs
                    .get(&(method.func, 0))
                    .cloned()
                    .unwrap_or_default();
                // The runtime drains a result after the method has returned.
                // A method-local State/AD scope has already ended by then.
                self.consume_iterator(method.func, 0, &returned)?;
            }
        }
        Ok(())
    }

    fn request(&mut self, id: FuncId, scoped: u8, args: &[Targets]) -> Targets {
        let key = (id, scoped);
        if let std::collections::btree_map::Entry::Vacant(entry) = self.inputs.entry(key) {
            entry.insert(vec![Targets::new(); self.program.funcs[id].arity as usize]);
            self.changed = true;
        }
        for (slot, value) in self.inputs.get_mut(&key).unwrap().iter_mut().zip(args) {
            self.changed |= join(slot, value);
        }
        self.outputs.get(&key).cloned().unwrap_or_default()
    }

    fn partial(&mut self, id: FuncId, args: Vec<Targets>) -> Targets {
        let key = (id, args.len());
        let captured = self
            .captures
            .entry(key)
            .or_insert_with(|| vec![Targets::new(); args.len()]);
        for (slot, value) in captured.iter_mut().zip(&args) {
            self.changed |= join(slot, value);
        }
        BTreeSet::from([key])
    }

    fn apply(
        &mut self,
        functions: &Targets,
        args: &[Targets],
        scoped: u8,
    ) -> Result<Targets, String> {
        if self.validate && functions.is_empty() {
            return Err(
                "--gc arc: cannot prove the target of a call in a scoped ownership program".into(),
            );
        }
        let mut result = Targets::new();
        for &(id, supplied) in functions {
            let mut all = self
                .captures
                .get(&(id, supplied))
                .cloned()
                .unwrap_or_default();
            all.extend_from_slice(args);
            let arity = self.program.funcs[id].arity as usize;
            let value = if all.len() < arity {
                self.partial(id, all)
            } else {
                let returned = self.request(id, scoped, &all[..arity]);
                if all.len() == arity {
                    returned
                } else {
                    self.apply(&returned, &all[arity..], scoped)?
                }
            };
            join(&mut result, &value);
        }
        Ok(result)
    }

    fn constant(&mut self, value: &Value) -> Targets {
        match value {
            Value::Closure(closure) => {
                let args = closure.args.iter().map(|arg| self.constant(arg)).collect();
                self.partial(closure.func, args)
            }
            Value::Record(fields) | Value::Data(_, fields) => fields
                .iter()
                .flat_map(|field| self.constant(field))
                .collect(),
            Value::Array(fields) => fields
                .iter()
                .flat_map(|field| self.constant(field))
                .collect(),
            Value::Map(fields) => fields
                .iter()
                .flat_map(|(key, value)| {
                    let mut result = self.constant(key);
                    result.extend(self.constant(value));
                    result
                })
                .collect(),
            _ => Targets::new(),
        }
    }

    fn bind(pattern: &Pat, value: &Targets, locals: &mut [Targets]) {
        match pattern {
            Pat::Bind(local) => {
                locals[*local as usize] = value.clone();
            }
            Pat::Construct(_, fields) | Pat::Record(fields) => {
                for field in fields {
                    Self::bind(field, value, locals);
                }
            }
            Pat::Wild | Pat::Lit(_) => {}
        }
    }

    fn expr(&mut self, expr: &Expr, locals: &mut [Targets], scoped: u8) -> Result<Targets, String> {
        let result = match expr {
            Expr::Local(local) => locals[*local as usize].clone(),
            Expr::Const(value) => self.constant(value),
            Expr::Func(id) if self.program.funcs[*id].arity == 0 => self.request(*id, scoped, &[]),
            Expr::Func(id) => BTreeSet::from([(*id, 0)]),
            Expr::Call(id, args) => {
                let values = args
                    .iter()
                    .map(|arg| self.expr(arg, locals, scoped))
                    .collect::<Result<Vec<_>, _>>()?;
                self.request(*id, scoped, &values)
            }
            Expr::Apply(function, args) => {
                let function = self.expr(function, locals, scoped)?;
                let args = args
                    .iter()
                    .map(|arg| self.expr(arg, locals, scoped))
                    .collect::<Result<Vec<_>, _>>()?;
                self.apply(&function, &args, scoped)?
            }
            Expr::Record(fields) | Expr::Construct(_, fields) => {
                let mut result = Targets::new();
                for field in fields {
                    result.extend(self.expr(field, locals, scoped)?);
                }
                result
            }
            Expr::Field(value, _) => self.expr(value, locals, scoped)?,
            Expr::SetFields(value, fields) => {
                let mut result = self.expr(value, locals, scoped)?;
                for (_, field) in fields {
                    result.extend(self.expr(field, locals, scoped)?);
                }
                result
            }
            Expr::BorrowGlobal(local, global, body) => {
                locals[*local as usize] = self.request(*global, scoped, &[]);
                self.expr(body, locals, scoped)?
            }
            Expr::Let(local, value, body) => {
                locals[*local as usize] = self.expr(value, locals, scoped)?;
                self.expr(body, locals, scoped)?
            }
            Expr::Match(value, arms) => {
                let value = self.expr(value, locals, scoped)?;
                let mut result = Targets::new();
                for (pattern, body) in arms {
                    let mut branch = locals.to_vec();
                    Self::bind(pattern, &value, &mut branch);
                    result.extend(self.expr(body, &mut branch, scoped)?);
                }
                result
            }
            Expr::Trace(_, body)
            | Expr::Dup(_, body)
            | Expr::Drop(_, body)
            | Expr::ResourceRegion { body, .. } => self.expr(body, locals, scoped)?,
        };
        Ok(result)
    }

    fn function(&mut self, id: FuncId, scoped: u8, args: &[Targets]) -> Result<Targets, String> {
        let function = &self.program.funcs[id];
        match &function.body {
            Body::Expr(body) => {
                let mut locals = vec![Targets::new(); function.locals.len()];
                for (local, value) in locals.iter_mut().zip(args) {
                    *local = value.clone();
                }
                self.expr(body, &mut locals, scoped)
            }
            Body::Prim(symbol) if matches!(symbol.as_str(), "ad.scope" | "ad.scope2") => {
                self.apply(&args[0], &args[1..], scoped | AD)
            }
            Body::Prim(symbol) if matches!(symbol.as_str(), "task.spawn" | "task.within") => {
                // A child starts with independent State and AD stacks. Carry
                // callable captures, but never its parent's dynamic scopes.
                // Channel payloads exclude closures/tasks/streams, and raw
                // addresses remain excluded by ARC eligibility,
                // so no mutable back-edge can publish this task to its thunk.
                let callback = usize::from(symbol == "task.within");
                self.apply(&args[callback], &[Targets::new()], 0)
            }
            Body::Prim(symbol) if symbol == "http2.serve" => {
                // Request handlers run in new tasks, with independent State
                // and AD stacks, even while serve's caller has a live scope.
                self.apply(&args[3], &[Targets::new()], 0)
            }
            Body::Prim(symbol) if symbol == "run-state" => {
                // State cells are stack owners, never captured addresses. A
                // callback can return a closure, but that closure must execute
                // under a fresh State scope before it uses get/put/modify.
                self.changed |= join(&mut self.state_values, &args[0]);
                let mut result = self.apply(&args[1], &args[2..], scoped | STATE)?;
                result.extend(self.state_values.iter().copied());
                Ok(result)
            }
            Body::Prim(symbol) if matches!(symbol.as_str(), "get" | "put" | "modify") => {
                if scoped & STATE == 0 {
                    return Err(format!("--gc arc: primitive `{symbol}` has no tracing-free lifetime policy outside a State scope"));
                }
                match symbol.as_str() {
                    "get" => Ok(self.state_values.clone()),
                    "put" => {
                        self.changed |= join(&mut self.state_values, &args[0]);
                        Ok(Targets::new())
                    }
                    _ => {
                        let state = self.state_values.clone();
                        let value = self.apply(&args[0], std::slice::from_ref(&state), scoped)?;
                        self.changed |= join(&mut self.state_values, &value);
                        Ok(Targets::new())
                    }
                }
            }
            Body::Prim(symbol)
                if matches!(
                    symbol.as_str(),
                    "ad.tape"
                        | "ad.push"
                        | "ad.backward"
                        | "ad.tape-owned"
                        | "ad.push-owned"
                        | "ad.backward-owned"
                ) =>
            {
                if scoped & AD == 0 {
                    return Err(format!("--gc arc: primitive `{symbol}` has no tracing-free lifetime policy outside an autodiff scope"));
                }
                if symbol == "ad.tape-owned" {
                    // Stored scalar operations may execute during a later
                    // backward call. They inherit only the proved AD scope,
                    // never the creator's transient State context.
                    if self.validate && args[0].is_empty() {
                        return Err("--gc arc: cannot prove managed tape callbacks".into());
                    }
                    for &(target, supplied) in &args[0] {
                        let count = self.program.funcs[target].arity as usize - supplied;
                        self.apply(
                            &BTreeSet::from([(target, supplied)]),
                            &vec![Targets::new(); count],
                            AD,
                        )?;
                    }
                }
                Ok(Targets::new())
            }
            Body::Prim(symbol) => {
                // A closure carried in loop state or a collection is data until
                // an actual invocation reaches it. Invoking every such closure
                // here would incorrectly run scoped work in its caller's scope.
                let mut result: Targets = args.iter().flatten().copied().collect();
                let callback = if symbol == "list.ap" {
                    Some(0) // The first list contains the functions to apply.
                } else {
                    crate::ownership::primitive(symbol).and_then(|c| {
                        c.callback.map(|callback| match callback {
                            crate::ownership::Callback::Borrowed(i)
                            | crate::ownership::Callback::Retained(i)
                            | crate::ownership::Callback::Shared(i) => i,
                        })
                    })
                };
                let Some(callback) = callback else {
                    // Unknown runtime boundaries retain the conservative proof.
                    if crate::ownership::primitive(symbol).is_some() {
                        return Ok(result);
                    }
                    for &(target, supplied) in &result.clone() {
                        let count = self.program.funcs[target].arity as usize - supplied;
                        result.extend(self.apply(
                            &BTreeSet::from([(target, supplied)]),
                            &vec![result.clone(); count],
                            scoped,
                        )?);
                    }
                    return Ok(result);
                };
                let functions = args[callback].clone();
                let mut data: Targets = args
                    .iter()
                    .enumerate()
                    .filter(|(index, _)| *index != callback)
                    .flat_map(|(_, value)| value.iter().copied())
                    .collect();
                data.extend(
                    self.callback_values
                        .get(&(id, scoped))
                        .into_iter()
                        .flatten()
                        .copied(),
                );
                for &(target, supplied) in &functions {
                    let count = self.program.funcs[target].arity as usize - supplied;
                    let values = vec![data.clone(); count];
                    let returned =
                        self.apply(&BTreeSet::from([(target, supplied)]), &values, scoped)?;
                    // A fold/loop may feed a returned closure into a later
                    // iteration even if its eventual result contains none.
                    self.changed |= join(
                        self.callback_values.entry((id, scoped)).or_default(),
                        &returned,
                    );
                    result.extend(returned);
                }
                Ok(result)
            }
            Body::Ctor(_) => Ok(args.iter().flatten().copied().collect()),
            Body::ForeignC { .. } => {
                let (params, _) = crate::ffi::signature(self.program, function)?;
                for (index, ty) in params {
                    if matches!(ty, crate::ffi::CType::Callback { .. }) {
                        let mut count = 0;
                        let mut ty = &function.locals[index];
                        while let MT::Fun(_, result) = ty {
                            count += 1;
                            ty = result;
                        }
                        self.apply(&args[index], &vec![Targets::new(); count], scoped)?;
                    }
                }
                Ok(Targets::new())
            }
            Body::Remote(remote) => {
                let shape =
                    crate::rpc::shape(&function.ty, function.arity as usize, remote.error.as_ref());
                if shape.client_streaming() {
                    // A single-result call consumes input in its caller. A
                    // bidirectional call uses a detached sender with fresh
                    // State/AD stacks, just like an ordinary child task.
                    let sender_scope = if shape.server_streaming() { 0 } else { scoped };
                    self.consume_iterator(id, sender_scope, &args[0])?;
                }
                if let Some(iterator) = remote.iter_fn {
                    // The received iterator's constructor runs in the caller;
                    // its returned continuations are data until consumed.
                    self.apply(&BTreeSet::from([(iterator, 0)]), &[Targets::new()], scoped)
                } else {
                    Ok(Targets::new())
                }
            }
        }
    }
}

pub(crate) fn check(program: &Program, entries: &[FuncId]) -> Result<(), String> {
    if !program.funcs.iter().any(|f| matches!(&f.body, Body::Prim(s) if matches!(s.as_str(), "ad.tape" | "ad.push" | "ad.backward" | "ad.tape-owned" | "ad.push-owned" | "ad.backward-owned" | "run-state" | "get" | "put" | "modify"))) {
        return Ok(());
    }
    let mut proof = Proof {
        program,
        captures: BTreeMap::new(),
        inputs: BTreeMap::new(),
        outputs: BTreeMap::new(),
        callback_values: BTreeMap::new(),
        changed: false,
        validate: false,
        state_values: Targets::new(),
    };
    for &entry in entries {
        // Protocol inputs contain no known language closures. Any attempted
        // dynamic callback call through an input remains an unproved target.
        proof.request(entry, 0, &[]);
    }
    loop {
        proof.changed = false;
        proof.service_boundaries(entries)?;
        for ((id, scoped), args) in proof.inputs.clone() {
            let mut result = proof.function(id, scoped, &args)?;
            let function = &program.funcs[id];
            if !has_functions(
                program,
                function.ty.params(function.arity as usize).1,
                &mut BTreeSet::new(),
            ) {
                result.clear();
            }
            proof.changed |= join(proof.outputs.entry((id, scoped)).or_default(), &result);
        }
        if !proof.changed {
            break;
        }
    }
    proof.validate = true;
    proof.service_boundaries(entries)?;
    for ((id, scoped), args) in proof.inputs.clone() {
        proof.function(id, scoped, &args)?;
    }
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::ir::Func;

    fn arrow(a: MT, b: MT) -> MT {
        MT::Fun(Box::new(a), Box::new(b))
    }
    fn state_program(scoped: bool) -> Program {
        let unit = MT::unit();
        let string = MT::con("std::String");
        let getter = arrow(unit.clone(), string.clone());
        let pair = MT::Record(vec![
            ("0".into(), string.clone()),
            ("1".into(), string.clone()),
        ]);
        let handler = Expr::Call(
            2,
            vec![
                Expr::Const(Value::str("initial")),
                Expr::Func(1),
                Expr::Const(Value::unit()),
            ],
        );
        Program {
            main: Some(0),
            funcs: vec![
                Func {
                    name: "main".into(),
                    arity: 0,
                    locals: vec![],
                    ty: if scoped { pair.clone() } else { string.clone() },
                    body: Body::Expr(if scoped {
                        handler
                    } else {
                        Expr::Call(1, vec![Expr::Const(Value::unit())])
                    }),
                },
                Func {
                    name: "get".into(),
                    arity: 1,
                    locals: vec![unit.clone()],
                    ty: getter.clone(),
                    body: Body::Prim("get".into()),
                },
                Func {
                    name: "run-state".into(),
                    arity: 3,
                    locals: vec![string.clone(), getter.clone(), unit.clone()],
                    ty: arrow(string, arrow(getter, arrow(unit, pair))),
                    body: Body::Prim("run-state".into()),
                },
            ],
            ..Program::default()
        }
    }

    #[test]
    fn state_primitive_needs_a_proven_handler_context() {
        assert!(check(&state_program(true), &[0]).is_ok());
        assert!(check(&state_program(false), &[0])
            .unwrap_err()
            .contains("tracing-free lifetime policy"));
    }

    #[test]
    fn asynchronous_callbacks_do_not_inherit_dynamic_scopes() {
        // Check the lowered graph directly: the public effect checker already
        // excludes a bare State callback from spawn's closed effect signature.
        // The ownership proof must independently protect that invariant.
        for symbol in ["task.spawn", "task.within", "http2.serve"] {
            let mut p = state_program(true);
            let unit = MT::unit();
            let getter = p.funcs[1].ty.clone();
            let string = MT::con("std::String");
            let task = MT::Con("std::Task".into(), vec![string.clone()]);
            let mut args = vec![Expr::Func(1)];
            let mut locals = vec![getter.clone()];
            let mut ty = arrow(getter.clone(), task.clone());
            if symbol == "task.within" {
                args.insert(0, Expr::Const(Value::unit()));
                locals.insert(0, unit.clone());
                ty = arrow(unit.clone(), ty);
            }
            if symbol == "http2.serve" {
                // Scope checking is independent of the transport arguments.
                ty = arrow(getter, arrow(unit.clone(), task.clone()));
                for _ in 0..3 {
                    args.insert(0, Expr::Const(Value::unit()));
                    locals.insert(0, unit.clone());
                    ty = arrow(unit.clone(), ty);
                }
                args.push(Expr::Const(Value::unit()));
                locals.push(unit.clone());
            }
            p.funcs.push(Func {
                name: symbol.into(),
                arity: args.len() as u32,
                locals,
                ty,
                body: Body::Prim(symbol.into()),
            });
            p.funcs.push(Func {
                name: "spawn-in-parent-state".into(),
                arity: 1,
                locals: vec![unit.clone()],
                ty: arrow(unit.clone(), task.clone()),
                body: Body::Expr(Expr::Call(3, args)),
            });
            let pair = MT::Record(vec![
                ("0".into(), task.clone()),
                ("1".into(), string.clone()),
            ]);
            p.funcs[2].ty = arrow(
                string,
                arrow(arrow(unit.clone(), task), arrow(unit, pair.clone())),
            );
            p.funcs[0].ty = pair;
            let Body::Expr(Expr::Call(_, args)) = &mut p.funcs[0].body else {
                unreachable!()
            };
            args[1] = Expr::Func(4);
            assert!(
                check(&p, &[0])
                    .unwrap_err()
                    .contains("outside a State scope"),
                "{symbol}"
            );
        }
    }

    #[test]
    fn remote_input_continuations_use_the_actual_sender_scope() {
        for bidirectional in [false, true] {
            for delayed_get in [false, true] {
                let mut p = state_program(true);
                let unit = MT::unit();
                let string = MT::con("std::String");
                let iter = MT::Con("std::Iterator".into(), vec![string.clone()]);
                let step = arrow(unit.clone(), iter.clone());
                p.shapes.insert(
                    iter.clone(),
                    TypeShape::Adt(vec![
                        ("Done".into(), vec![]),
                        ("Next".into(), vec![string.clone(), step.clone()]),
                    ]),
                );
                let result = if bidirectional {
                    iter.clone()
                } else {
                    string.clone()
                };
                let handler = arrow(unit.clone(), result.clone());
                let pair = MT::Record(vec![
                    ("0".into(), result.clone()),
                    ("1".into(), string.clone()),
                ]);
                p.funcs.extend([
                    Func {
                        name: "input-step-using-state".into(),
                        arity: 1,
                        locals: vec![unit.clone(), string.clone()],
                        ty: step.clone(),
                        body: Body::Expr(Expr::Let(
                            1,
                            Box::new(Expr::Call(1, vec![Expr::Local(0)])),
                            Box::new(Expr::Construct(0, vec![])),
                        )),
                    },
                    Func {
                        name: "remote-consumer".into(),
                        arity: 1,
                        locals: vec![iter.clone()],
                        ty: arrow(iter.clone(), result),
                        body: Body::Remote(Box::new(crate::ir::RemoteFn {
                            module: "service".into(),
                            method: "consume".into(),
                            path: "/service/Consume".into(),
                            error: None,
                            default_addr: String::new(),
                            iter_fn: bidirectional.then_some(6),
                        })),
                    },
                    Func {
                        name: "call-within-state".into(),
                        arity: 1,
                        locals: vec![unit.clone()],
                        ty: handler.clone(),
                        body: Body::Expr(Expr::Call(
                            4,
                            vec![Expr::Construct(
                                1,
                                vec![
                                    Expr::Const(Value::str("head")),
                                    Expr::Func(if delayed_get { 7 } else { 3 }),
                                ],
                            )],
                        )),
                    },
                    Func {
                        name: "received-iterator".into(),
                        arity: 1,
                        locals: vec![MT::Con("std::GrpcCell".into(), vec![string.clone()])],
                        ty: arrow(
                            MT::Con("std::GrpcCell".into(), vec![string.clone()]),
                            iter.clone(),
                        ),
                        body: Body::Expr(Expr::Construct(0, vec![])),
                    },
                    Func {
                        name: "later-input-step".into(),
                        arity: 1,
                        locals: vec![unit.clone()],
                        ty: step,
                        body: Body::Expr(Expr::Construct(
                            1,
                            vec![Expr::Const(Value::str("later")), Expr::Func(3)],
                        )),
                    },
                ]);
                p.funcs[2].locals = vec![string.clone(), handler.clone(), unit.clone()];
                p.funcs[2].ty = arrow(string, arrow(handler, arrow(unit, pair.clone())));
                p.funcs[0].ty = pair;
                let Body::Expr(Expr::Call(_, args)) = &mut p.funcs[0].body else {
                    unreachable!()
                };
                args[1] = Expr::Func(5);
                let checked = check(&p, &[0]);
                if bidirectional {
                    assert!(checked.unwrap_err().contains("outside a State scope"));
                } else {
                    checked.unwrap();
                }
                // A synchronous sender outside a handler is unsafe too.
                assert!(check(&p, &[5])
                    .unwrap_err()
                    .contains("outside a State scope"));
                if bidirectional {
                    // A detached producer may establish its own handler.
                    let mut inner = p.funcs[3].clone();
                    inner.name = "input-step-with-local-state".into();
                    p.funcs.push(inner);
                    p.funcs[3].body = Body::Expr(Expr::Field(
                        Box::new(Expr::Call(
                            2,
                            vec![
                                Expr::Const(Value::str("sender-local")),
                                Expr::Func(8),
                                Expr::Const(Value::unit()),
                            ],
                        )),
                        0,
                    ));
                    check(&p, &[0]).unwrap();
                    check(&p, &[5]).unwrap();
                }
            }
        }
    }

    #[test]
    fn served_iterators_do_not_extend_method_scopes() {
        for delayed_get in [false, true] {
            let mut p = state_program(true);
            let unit = MT::unit();
            let string = MT::con("std::String");
            let iter = MT::Con("std::Iterator".into(), vec![string.clone()]);
            let step = arrow(unit.clone(), iter.clone());
            p.shapes.insert(
                iter.clone(),
                TypeShape::Adt(vec![
                    ("Done".into(), vec![]),
                    ("Next".into(), vec![string.clone(), step.clone()]),
                ]),
            );
            let local_state = |callback| {
                Expr::Field(
                    Box::new(Expr::Call(
                        2,
                        vec![
                            Expr::Const(Value::str("local")),
                            Expr::Func(callback),
                            Expr::Const(Value::unit()),
                        ],
                    )),
                    0,
                )
            };
            p.funcs.extend([
                Func {
                    name: "return-an-iterator".into(),
                    arity: 1,
                    locals: vec![unit.clone()],
                    ty: step.clone(),
                    body: Body::Expr(Expr::Construct(
                        1,
                        vec![
                            Expr::Const(Value::str("head")),
                            Expr::Func(if delayed_get { 6 } else { 4 }),
                        ],
                    )),
                },
                Func {
                    name: "iterator-step-using-state".into(),
                    arity: 1,
                    locals: vec![unit.clone(), string.clone()],
                    ty: step.clone(),
                    body: Body::Expr(Expr::Let(
                        1,
                        Box::new(Expr::Call(1, vec![Expr::Local(0)])),
                        Box::new(Expr::Construct(0, vec![])),
                    )),
                },
                Func {
                    name: "served-method".into(),
                    arity: 1,
                    locals: vec![unit.clone()],
                    ty: step.clone(),
                    body: Body::Expr(local_state(3)),
                },
                Func {
                    name: "later-result-step".into(),
                    arity: 1,
                    locals: vec![unit.clone()],
                    ty: step.clone(),
                    body: Body::Expr(Expr::Construct(
                        1,
                        vec![Expr::Const(Value::str("later")), Expr::Func(4)],
                    )),
                },
            ]);
            let pair = MT::Record(vec![
                ("0".into(), iter.clone()),
                ("1".into(), string.clone()),
            ]);
            p.funcs[2].locals = vec![string.clone(), step.clone(), unit.clone()];
            p.funcs[2].ty = arrow(string.clone(), arrow(step, arrow(unit.clone(), pair)));
            p.funcs[0].ty = iter.clone();
            p.funcs[0].body = Body::Expr(Expr::Call(5, vec![Expr::Const(Value::unit())]));
            // Returning the closure alone does not invoke it. Serving this
            // result adds the runtime's later consumption outside the handler.
            check(&p, &[5]).unwrap();
            p.service = Some(crate::ir::ServiceDef {
                module: "service".into(),
                default_addr: String::new(),
                methods: vec![crate::ir::ServedFn {
                    name: "values".into(),
                    func: 5,
                    error: None,
                    path: "/service/Values".into(),
                    iter_fn: None,
                }],
            });
            assert!(check(&p, &[5])
                .unwrap_err()
                .contains("outside a State scope"));
            let mut inner = p.funcs[4].clone();
            inner.name = "step-with-local-state".into();
            p.funcs.push(inner);
            p.funcs[4].body = Body::Expr(local_state(7));
            check(&p, &[5]).unwrap();

            // Received iterator constructors must seed the method's argument
            // flow too: an identity method forwards the known continuation.
            p.funcs[5].locals = vec![iter.clone()];
            p.funcs[5].ty = arrow(iter.clone(), iter.clone());
            p.funcs[5].body = Body::Expr(Expr::Local(0));
            let cell = MT::Con("std::GrpcCell".into(), vec![string]);
            p.funcs.push(Func {
                name: "received-position".into(),
                arity: 1,
                locals: vec![cell.clone()],
                ty: arrow(cell, iter),
                body: Body::Expr(Expr::Construct(
                    1,
                    vec![Expr::Const(Value::str("received")), Expr::Func(4)],
                )),
            });
            assert!(check(&p, &[5])
                .unwrap_err()
                .contains("no received iterator constructor"));
            p.service.as_mut().unwrap().methods[0].iter_fn = Some(8);
            check(&p, &[5]).unwrap();
            p.funcs[4].body = p.funcs[7].body.clone();
            assert!(check(&p, &[5])
                .unwrap_err()
                .contains("outside a State scope"));
        }
    }

    #[test]
    fn returning_a_getter_does_not_extend_the_handler_lifetime() {
        let mut p = state_program(true);
        let getter = p.funcs[1].ty.clone();
        let unit = MT::unit();
        let callback = arrow(unit.clone(), getter.clone());
        let pair = MT::Record(vec![
            ("0".into(), getter.clone()),
            ("1".into(), MT::con("std::String")),
        ]);
        p.funcs.push(Func {
            name: "return-getter".into(),
            arity: 1,
            locals: vec![unit.clone()],
            ty: callback.clone(),
            body: Body::Expr(Expr::Func(1)),
        });
        p.funcs[2].ty = arrow(
            MT::con("std::String"),
            arrow(callback.clone(), arrow(unit.clone(), pair)),
        );
        p.funcs[2].locals[1] = callback;
        p.funcs[0].ty = MT::con("std::String");
        p.funcs[0].body = Body::Expr(Expr::Apply(
            Box::new(Expr::Field(
                Box::new(Expr::Call(
                    2,
                    vec![
                        Expr::Const(Value::str("initial")),
                        Expr::Func(3),
                        Expr::Const(Value::unit()),
                    ],
                )),
                0,
            )),
            vec![Expr::Const(Value::unit())],
        ));
        assert!(check(&p, &[0])
            .unwrap_err()
            .contains("tracing-free lifetime policy"));
    }

    #[test]
    fn every_entry_starts_without_a_dynamic_scope() {
        let p = state_program(true);
        assert!(check(&p, &[0]).is_ok());
        assert!(check(&p, &[0, 1])
            .unwrap_err()
            .contains("outside a State scope"));
    }

    #[test]
    fn loop_can_carry_a_callback_without_executing_it() {
        let mut p = state_program(false);
        let getter = p.funcs[1].ty.clone();
        let step = MT::Con("std::Step".into(), vec![getter.clone(), getter.clone()]);
        let callback = arrow(getter.clone(), step.clone());
        p.shapes.insert(
            step.clone(),
            TypeShape::Adt(vec![
                ("Again".into(), vec![getter.clone()]),
                ("Stop".into(), vec![getter.clone()]),
            ]),
        );
        p.funcs.push(Func {
            name: "carry".into(),
            arity: 1,
            locals: vec![getter.clone()],
            ty: callback.clone(),
            body: Body::Expr(Expr::Construct(1, vec![Expr::Local(0)])),
        });
        p.funcs.push(Func {
            name: "loop".into(),
            arity: 2,
            locals: vec![callback.clone(), getter.clone()],
            ty: arrow(callback, arrow(getter.clone(), getter.clone())),
            body: Body::Prim("loop".into()),
        });
        let carry = Expr::Call(4, vec![Expr::Func(3), Expr::Func(1)]);
        p.funcs[0].ty = getter;
        p.funcs[0].body = Body::Expr(carry.clone());
        assert!(check(&p, &[0]).is_ok());
        // The same closure is still rejected when actually called unscoped.
        p.funcs[0].ty = MT::con("std::String");
        p.funcs[0].body = Body::Expr(Expr::Apply(
            Box::new(carry),
            vec![Expr::Const(Value::unit())],
        ));
        assert!(check(&p, &[0])
            .unwrap_err()
            .contains("outside a State scope"));
    }
}
