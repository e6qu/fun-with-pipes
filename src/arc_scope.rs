//! Finite closure-flow proof for queued captures, raw AD and typed State lifetimes.
//!
//! Origins identify functions with their supplied arguments and known data-queue
//! and task producers. Unknown sources stay explicit, including task computations
//! and results that can hide a callback owner. Captures and
//! call summaries join monotonically. Aggregate fields conservatively share a
//! set: this can reject ambiguous flows, but cannot hide a callable in a tuple,
//! list, returned closure or recursive function. No source names imply a proof.
use crate::arc::EntryChannels;
use crate::ir::{Body, Expr, FuncId, Pat, Program, TypeShape, MT};
use crate::value::Value;
use std::collections::{BTreeMap, BTreeSet};

#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord)]
enum Origin {
    Function(FuncId, usize),
    UnknownFunction,
    Queue(FuncId),
    GrpcSender(FuncId),
    UnknownQueue,
    Task(FuncId),
    UnknownTask,
}

impl Origin {
    fn callable(self) -> bool {
        matches!(self, Self::Function(..) | Self::UnknownFunction)
    }

    fn task(self) -> bool {
        matches!(self, Self::Task(_) | Self::UnknownTask)
    }

    fn queue(self) -> bool {
        matches!(
            self,
            Self::Queue(_) | Self::GrpcSender(_) | Self::UnknownQueue
        )
    }
}
type Targets = BTreeSet<Origin>;
type Context = (FuncId, u8);
const AD: u8 = 1;
const STATE: u8 = 2;

struct Proof<'a> {
    program: &'a Program,
    captures: BTreeMap<Origin, Vec<Targets>>,
    inputs: BTreeMap<Context, Vec<Targets>>,
    outputs: BTreeMap<Context, Targets>,
    callback_values: BTreeMap<Context, Targets>,
    channel_values: BTreeMap<MT, Targets>,
    task_thunks: BTreeMap<FuncId, Targets>,
    task_results: BTreeMap<FuncId, Targets>,
    changed: bool,
    validate: bool,
    state_values: Targets,
    error_values: Targets,
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

fn has_function_channels(program: &Program, ty: &MT, seen: &mut BTreeSet<MT>) -> bool {
    if !seen.insert(ty.clone()) {
        return false;
    }
    match ty {
        MT::Fun(a, b) => {
            has_function_channels(program, a, seen) || has_function_channels(program, b, seen)
        }
        MT::Record(fields) => fields
            .iter()
            .any(|(_, field)| has_function_channels(program, field, seen)),
        MT::Con(name, args) => {
            (name == "std::Channel"
                && args
                    .iter()
                    .any(|arg| has_functions(program, arg, &mut BTreeSet::new())))
                || args
                    .iter()
                    .any(|arg| has_function_channels(program, arg, seen))
                || match program.shapes.get(ty) {
                    Some(TypeShape::Record(fields)) => fields
                        .iter()
                        .any(|(_, field)| has_function_channels(program, field, seen)),
                    Some(TypeShape::Adt(variants)) => variants.iter().any(|(_, fields)| {
                        fields
                            .iter()
                            .any(|field| has_function_channels(program, field, seen))
                    }),
                    _ => false,
                }
        }
        MT::Nat(_) => false,
    }
}

// Function captures have their own origin sets. An arrow's argument/result
// types do not mean that the function value itself contains a channel owner.
fn has_channels(program: &Program, ty: &MT, seen: &mut BTreeSet<MT>) -> bool {
    if !seen.insert(ty.clone()) {
        return false;
    }
    match ty {
        MT::Fun(..) | MT::Nat(_) => false,
        MT::Record(fields) => fields.iter().any(|(_, ty)| has_channels(program, ty, seen)),
        MT::Con(name, args) => {
            name == "std::Channel"
                || name == "?"
                || args.iter().any(|ty| has_channels(program, ty, seen))
                || match program.shapes.get(ty) {
                    Some(TypeShape::Record(fields)) => {
                        fields.iter().any(|(_, ty)| has_channels(program, ty, seen))
                    }
                    Some(TypeShape::Adt(variants)) => variants
                        .iter()
                        .any(|(_, fields)| fields.iter().any(|ty| has_channels(program, ty, seen))),
                    _ => false,
                }
        }
    }
}

// Function captures have their own origin sets. An arrow's argument/result
// types do not mean that the function value itself contains a task owner.
fn has_tasks(program: &Program, ty: &MT, seen: &mut BTreeSet<MT>) -> bool {
    if !seen.insert(ty.clone()) {
        return false;
    }
    match ty {
        MT::Fun(..) | MT::Nat(_) => false,
        MT::Record(fields) => fields.iter().any(|(_, ty)| has_tasks(program, ty, seen)),
        MT::Con(name, args) => {
            name == "std::Task"
                || name == "?"
                || args.iter().any(|ty| has_tasks(program, ty, seen))
                || match program.shapes.get(ty) {
                    Some(TypeShape::Record(fields)) => {
                        fields.iter().any(|(_, ty)| has_tasks(program, ty, seen))
                    }
                    Some(TypeShape::Adt(variants)) => variants
                        .iter()
                        .any(|(_, fields)| fields.iter().any(|ty| has_tasks(program, ty, seen))),
                    _ => false,
                }
        }
    }
}

/// Socket handles cannot own a queue or callback; final release closes their
/// descriptor. Follow immutable containers' fields. Data channels also need the
/// producer/payload proof below. File captures violate source-level linear use;
/// other mutable owners still need lifetime proofs.
fn queued_capture_type(program: &Program, ty: &MT, seen: &mut BTreeSet<MT>) -> Result<(), String> {
    if !seen.insert(ty.clone()) {
        return Ok(());
    }
    match ty {
        MT::Fun(..) | MT::Nat(_) => Ok(()),
        MT::Record(fields) => {
            for (_, field) in fields {
                queued_capture_type(program, field, seen)?;
            }
            Ok(())
        }
        MT::Con(name, args) => {
            if matches!(
                name.as_str(),
                "?" | "std::H2Stream" | "std::GrpcCell" | "std::File"
            ) {
                return Err(format!(
                    "--gc arc: cannot prove a queued function's captured `{ty}` owner; queue immutable data or keep this owner outside the callback"
                ));
            }
            if name == "std::Task" && args.len() != 1 {
                return Err(format!("--gc arc: cannot prove a queued function's captured `{ty}` without its result type"));
            }
            if name == "std::Channel" {
                let [payload] = args.as_slice() else {
                    return Err(format!(
                        "--gc arc: captured `{ty}` requires a channel payload type"
                    ));
                };
                if has_functions(program, payload, &mut BTreeSet::new()) {
                    return Err(format!("--gc arc: cannot prove a queued function's captured function-bearing channel `{ty}`"));
                }
            }
            for arg in args {
                queued_capture_type(program, arg, seen)?;
            }
            match program.shapes.get(ty) {
                Some(TypeShape::Record(fields)) => {
                    for (_, field) in fields {
                        queued_capture_type(program, field, seen)?;
                    }
                }
                Some(TypeShape::Adt(variants)) => {
                    for (_, fields) in variants {
                        for field in fields {
                            queued_capture_type(program, field, seen)?;
                        }
                    }
                }
                _ => {}
            }
            Ok(())
        }
    }
}

impl Proof<'_> {
    fn queue_type(&self, origin: Origin) -> Option<&MT> {
        match origin {
            Origin::Queue(id) => {
                let function = &self.program.funcs[id];
                Some(function.ty.params(function.arity as usize).1)
            }
            Origin::GrpcSender(id) => {
                let function = &self.program.funcs[id];
                function
                    .ty
                    .params(function.arity as usize)
                    .0
                    .last()
                    .copied()
            }
            _ => None,
        }
    }

    fn captured_queues(&self, values: &Targets, seen: &mut BTreeSet<Origin>) -> Result<(), String> {
        if values.contains(&Origin::UnknownQueue) {
            return Err("--gc arc: cannot prove the producer of a queued function's captured channel; use a data queue from channel.make or a proved gRPC response channel".into());
        }
        for origin in values {
            let Some(channel) = self.queue_type(*origin) else {
                continue;
            };
            if !seen.insert(*origin) {
                continue;
            }
            queued_capture_type(self.program, channel, &mut BTreeSet::new())?;
            // Nested queues can contain native/unknown owners even when their
            // own allocation is known. Follow the joined values ever sent to
            // each payload type; the independent type proof rejects cycles.
            if let Some(payloads) = self.channel_values.get(channel) {
                self.captured_queues(payloads, seen)?;
            }
        }
        Ok(())
    }

    fn queued_targets(&self, targets: &Targets, seen: &mut BTreeSet<Origin>) -> Result<(), String> {
        for &closure in targets.iter().filter(|origin| origin.callable()) {
            let Origin::Function(id, supplied) = closure else {
                return Err("--gc arc: cannot prove the source of a queued function".into());
            };
            if !seen.insert(closure) || supplied == 0 {
                continue;
            }
            let captures = self
                .captures
                .get(&closure)
                .filter(|args| args.len() == supplied)
                .ok_or_else(|| {
                    "--gc arc: missing captured values for a queued function".to_string()
                })?;
            let types = self.program.funcs[id].ty.params(supplied).0;
            for (ty, value) in types.iter().zip(captures) {
                self.queued_value(ty, value, seen)?;
            }
        }
        Ok(())
    }

    fn queued_value(
        &self,
        ty: &MT,
        value: &Targets,
        seen: &mut BTreeSet<Origin>,
    ) -> Result<(), String> {
        queued_capture_type(self.program, ty, &mut BTreeSet::new())?;
        if has_channels(self.program, ty, &mut BTreeSet::new()) {
            if matches!(ty, MT::Con(name, _) if name == "std::Channel")
                && !value.iter().any(|origin| origin.queue())
            {
                return Err(
                    "--gc arc: cannot prove a queued function's captured channel producer".into(),
                );
            }
            self.captured_queues(value, &mut BTreeSet::new())?;
        }
        if matches!(ty, MT::Fun(..)) && value.is_empty() {
            return Err(
                "--gc arc: cannot prove a queued function's captured function source".into(),
            );
        }
        if has_functions(self.program, ty, &mut BTreeSet::new()) {
            self.queued_targets(value, seen)?;
        }
        if has_tasks(self.program, ty, &mut BTreeSet::new()) {
            if matches!(ty, MT::Con(name, _) if name == "std::Task")
                && !value.iter().any(|origin| origin.task())
            {
                return Err(
                    "--gc arc: cannot prove a queued function's captured task producer".into(),
                );
            }
            self.captured_tasks(value, seen)?;
        }
        Ok(())
    }

    fn captured_tasks(&self, values: &Targets, seen: &mut BTreeSet<Origin>) -> Result<(), String> {
        for &origin in values.iter().filter(|origin| origin.task()) {
            let Origin::Task(id) = origin else {
                return Err("--gc arc: cannot prove a queued function's captured task producer; keep unknown task owners outside the callback".into());
            };
            if !seen.insert(origin) {
                continue;
            }
            let thunks = self
                .task_thunks
                .get(&id)
                .ok_or("--gc arc: missing captured task computation")?;
            if thunks.is_empty() {
                return Err("--gc arc: cannot prove a captured task's computation".into());
            }
            // A task retains its computation until it starts, and its result
            // after completion. Both can hide an owner of the receiving queue.
            // Its inherited gRPC settings own only metadata/TLS byte storage;
            // scheduler links and the serving context are borrowed, not owners.
            self.queued_targets(thunks, seen)?;
            let MT::Con(name, args) = self.program.funcs[id]
                .ty
                .params(self.program.funcs[id].arity as usize)
                .1
            else {
                return Err("--gc arc: captured task producer has no task result".into());
            };
            let [result_type] = args.as_slice() else {
                return Err("--gc arc: captured task producer has no result type".into());
            };
            if name != "std::Task" {
                return Err("--gc arc: captured task producer has no task result".into());
            }
            let results = self
                .task_results
                .get(&id)
                .ok_or("--gc arc: missing captured task result flow")?;
            self.queued_value(result_type, results, seen)?;
        }
        Ok(())
    }

    // Captures are fixed before a task is published, but its result is assigned
    // later. Any ownership cycle between tasks must include a result edge.
    // Follow every such edge through closure captures and other task owners.
    // Repeated spawn sites may merge distinct tasks: rejection means a missing
    // proof, not that every execution necessarily creates a cycle.
    fn task_result_owners(
        &self,
        task: FuncId,
        values: &Targets,
        seen: &mut BTreeSet<Origin>,
    ) -> Result<(), String> {
        for &origin in values {
            if origin == Origin::Task(task) {
                return Err("--gc arc: cannot prove an acyclic task result; its ownership flow can return to the producing task".into());
            }
            if !seen.insert(origin) {
                continue;
            }
            match origin {
                Origin::Function(_, supplied) if supplied > 0 => {
                    let captures = self
                        .captures
                        .get(&origin)
                        .ok_or("--gc arc: missing task result function captures")?;
                    for capture in captures {
                        self.task_result_owners(task, capture, seen)?;
                    }
                }
                Origin::Task(other) => {
                    for owners in [self.task_thunks.get(&other), self.task_results.get(&other)] {
                        self.task_result_owners(
                            task,
                            owners.ok_or("--gc arc: missing task owner flow")?,
                            seen,
                        )?;
                    }
                }
                Origin::UnknownTask | Origin::UnknownFunction => {
                    return Err(
                        "--gc arc: cannot prove the owners of an unknown task result".into(),
                    );
                }
                Origin::Queue(_) | Origin::GrpcSender(_) => {
                    if let Some(ty) = self.queue_type(origin) {
                        if let Some(payloads) = self.channel_values.get(ty) {
                            self.task_result_owners(task, payloads, seen)?;
                        }
                    }
                }
                // External function-bearing channels are rejected at entry;
                // data payload types cannot contain task owners or cycles.
                Origin::UnknownQueue | Origin::Function(..) => {}
            }
        }
        Ok(())
    }

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
        for &closure in steps.iter().filter(|origin| origin.callable()) {
            let Origin::Function(target, supplied) = closure else {
                if self.validate {
                    return Err(
                        "--gc arc: cannot prove a received iterator's function target".into(),
                    );
                }
                continue;
            };
            let count = self.program.funcs[target].arity as usize - supplied;
            let next = self.apply(
                &BTreeSet::from([closure]),
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
                let input = self.apply(
                    &BTreeSet::from([Origin::Function(iterator, 0)]),
                    &[Targets::new()],
                    0,
                )?;
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
        let key = Origin::Function(id, args.len());
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
        // An empty origin set contributes no call edge: for example, mapping
        // over an empty collection never supplies a function-valued element.
        // Unproved runtime/foreign inputs carry Unknown explicitly and are
        // rejected below, even when joined with known targets.
        let mut result = Targets::new();
        for &closure in functions.iter().filter(|origin| origin.callable()) {
            let Origin::Function(id, _) = closure else {
                if self.validate {
                    return Err(
                        "--gc arc: cannot prove the target of a call in an ownership program"
                            .into(),
                    );
                }
                result.insert(Origin::UnknownFunction);
                continue;
            };
            let mut all = self.captures.get(&closure).cloned().unwrap_or_default();
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
            Value::Set(fields) => fields
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
            Value::Native(value) if matches!(value.as_ref(), crate::sched::Native::Chan(_)) => {
                Targets::from([Origin::UnknownQueue])
            }
            Value::Native(value) if matches!(value.as_ref(), crate::sched::Native::Task(_)) => {
                Targets::from([Origin::UnknownTask])
            }
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

    /// Aggregate fields share origins. A checked type rules out unrelated
    /// queue/function fields, but never proves an unknown origin of its own kind.
    fn refine_origins(&self, values: &mut Targets, ty: &MT) {
        if matches!(ty, MT::Con(name, _) if name == "std::Task") {
            values.retain(|origin| match origin {
                Origin::Task(id) => crate::ir::same_type(
                    &self.program.shapes,
                    self.program.funcs[*id]
                        .ty
                        .params(self.program.funcs[*id].arity as usize)
                        .1,
                    ty,
                ),
                _ => true,
            });
        } else if !has_tasks(self.program, ty, &mut BTreeSet::new()) {
            values.retain(|origin| !origin.task());
        }
        if matches!(ty, MT::Con(name, _) if name == "std::Channel") {
            values.retain(|origin| match origin {
                Origin::Queue(_) | Origin::GrpcSender(_) => self
                    .queue_type(*origin)
                    .is_some_and(|source| crate::ir::same_type(&self.program.shapes, source, ty)),
                _ => true,
            });
            return;
        }
        if values.iter().any(|origin| origin.queue())
            && !has_channels(self.program, ty, &mut BTreeSet::new())
        {
            values.retain(|origin| !origin.queue());
        }
        if !matches!(ty, MT::Fun(..)) {
            return;
        }
        values.retain(|closure| match closure {
            Origin::Queue(_)
            | Origin::GrpcSender(_)
            | Origin::UnknownQueue
            | Origin::Task(_)
            | Origin::UnknownTask => false,
            Origin::UnknownFunction => true,
            Origin::Function(id, supplied) => crate::ir::same_type(
                &self.program.shapes,
                self.program.funcs[*id].ty.params(*supplied).1,
                ty,
            ),
        });
    }

    fn expr(
        &mut self,
        expr: &Expr,
        locals: &mut [Targets],
        local_types: &[MT],
        scoped: u8,
    ) -> Result<Targets, String> {
        let mut result = match expr {
            Expr::Local(local) => locals[*local as usize].clone(),
            Expr::Const(value) => self.constant(value),
            Expr::Func(id) if self.program.funcs[*id].arity == 0 => self.request(*id, scoped, &[]),
            Expr::Func(id) => BTreeSet::from([Origin::Function(*id, 0)]),
            Expr::Call(id, args) => {
                let values = args
                    .iter()
                    .map(|arg| self.expr(arg, locals, local_types, scoped))
                    .collect::<Result<Vec<_>, _>>()?;
                self.request(*id, scoped, &values)
            }
            Expr::Apply(function, args) => {
                let function = self.expr(function, locals, local_types, scoped)?;
                let args = args
                    .iter()
                    .map(|arg| self.expr(arg, locals, local_types, scoped))
                    .collect::<Result<Vec<_>, _>>()?;
                self.apply(&function, &args, scoped)?
            }
            Expr::Record(fields) | Expr::Construct(_, fields) => {
                let mut result = Targets::new();
                for field in fields {
                    result.extend(self.expr(field, locals, local_types, scoped)?);
                }
                result
            }
            Expr::Field(value, _) => self.expr(value, locals, local_types, scoped)?,
            Expr::SetFields(value, fields) => {
                let mut result = self.expr(value, locals, local_types, scoped)?;
                for (_, field) in fields {
                    result.extend(self.expr(field, locals, local_types, scoped)?);
                }
                result
            }
            Expr::BorrowGlobal(local, global, body) => {
                locals[*local as usize] = self.request(*global, scoped, &[]);
                self.expr(body, locals, local_types, scoped)?
            }
            Expr::Let(local, value, body) => {
                locals[*local as usize] = self.expr(value, locals, local_types, scoped)?;
                self.expr(body, locals, local_types, scoped)?
            }
            Expr::Match(value, arms) => {
                let value = self.expr(value, locals, local_types, scoped)?;
                let mut result = Targets::new();
                for (pattern, body) in arms {
                    let mut branch = locals.to_vec();
                    Self::bind(pattern, &value, &mut branch);
                    result.extend(self.expr(body, &mut branch, local_types, scoped)?);
                }
                result
            }
            Expr::Trace(_, body)
            | Expr::Dup(_, body)
            | Expr::Drop(_, body)
            | Expr::ResourceRegion { body, .. } => self.expr(body, locals, local_types, scoped)?,
        };
        if let Some(ty) = crate::ir::type_of(
            &|id| &self.program.funcs[id].ty,
            &self.program.shapes,
            local_types,
            expr,
        ) {
            self.refine_origins(&mut result, &ty);
        }
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
                self.expr(body, &mut locals, &function.locals, scoped)
            }
            Body::Prim(symbol) if matches!(symbol.as_str(), "ad.scope" | "ad.scope2") => {
                self.apply(&args[0], &args[1..], scoped | AD)
            }
            Body::Prim(symbol) if symbol == "task.spawn" => {
                // Fresh tasks have independent State/AD stacks. Keep their
                // hidden owners separate from the values later returned by await.
                self.changed |= join(self.task_thunks.entry(id).or_default(), &args[0]);
                let result = self.apply(&args[0], &[Targets::new()], 0)?;
                self.changed |= join(self.task_results.entry(id).or_default(), &result);
                Ok(Targets::from([Origin::Task(id)]))
            }
            Body::Prim(symbol) if symbol == "task.within" => {
                self.apply(&args[1], &[Targets::new()], 0)
            }
            Body::Prim(symbol) if symbol == "task.await" => {
                let mut result = Targets::new();
                for origin in &args[0] {
                    match origin {
                        Origin::Task(producer) => {
                            result.extend(
                                self.task_results
                                    .get(producer)
                                    .into_iter()
                                    .flatten()
                                    .copied(),
                            );
                        }
                        Origin::UnknownTask => {
                            let ty = function.ty.params(function.arity as usize).1;
                            if has_functions(self.program, ty, &mut BTreeSet::new()) {
                                result.insert(Origin::UnknownFunction);
                            }
                            if has_channels(self.program, ty, &mut BTreeSet::new()) {
                                result.insert(Origin::UnknownQueue);
                            }
                            if has_tasks(self.program, ty, &mut BTreeSet::new()) {
                                result.insert(Origin::UnknownTask);
                            }
                        }
                        _ => {}
                    }
                }
                Ok(result)
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
            Body::Prim(symbol) if symbol == "channel.send" => {
                let channel = function.ty.params(function.arity as usize).0[0].clone();
                let payload = function.ty.params(function.arity as usize).0[1];
                if self.validate && has_functions(self.program, payload, &mut BTreeSet::new()) {
                    if matches!(payload, MT::Fun(..)) && args[1].is_empty() {
                        return Err("--gc arc: cannot prove the source of a queued function".into());
                    }
                    self.queued_targets(&args[1], &mut BTreeSet::new())?;
                }
                self.changed |= join(self.channel_values.entry(channel).or_default(), &args[1]);
                Ok(Targets::new())
            }
            Body::Prim(symbol)
                if matches!(symbol.as_str(), "channel.recv" | "channel.recv-for") =>
            {
                let index = usize::from(symbol == "channel.recv-for");
                let channel = function.ty.params(function.arity as usize).0[index];
                let mut values = self
                    .channel_values
                    .get(channel)
                    .cloned()
                    .unwrap_or_default();
                values.extend(args[index].iter().copied());
                Ok(values)
            }
            Body::Prim(symbol) if symbol == "channel.make" => {
                Ok(Targets::from([Origin::Queue(id)]))
            }
            Body::Prim(symbol) if symbol == "channel.close" => Ok(Targets::new()),
            Body::Prim(symbol) if symbol == "fail" => {
                self.changed |= join(&mut self.error_values, &args[0]);
                Ok(Targets::new())
            }
            Body::Prim(symbol) if symbol == "attempt" => {
                let mut result = self.apply(&args[0], &args[1..], scoped)?;
                result.extend(self.error_values.iter().copied());
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
                    for &closure in args[0].iter().filter(|origin| origin.callable()) {
                        let Origin::Function(target, supplied) = closure else {
                            if self.validate {
                                return Err("--gc arc: cannot prove managed tape callbacks".into());
                            }
                            continue;
                        };
                        let count = self.program.funcs[target].arity as usize - supplied;
                        self.apply(&BTreeSet::from([closure]), &vec![Targets::new(); count], AD)?;
                    }
                }
                Ok(Targets::new())
            }
            Body::Prim(symbol) => {
                // A closure carried in loop state or a collection is data until
                // an actual invocation reaches it. Invoking every such closure
                // here would incorrectly run scoped work in its caller's scope.
                let mut result: Targets = args.iter().flatten().copied().collect();
                let contract = crate::ownership::primitive(symbol);
                let returns_functions = has_functions(
                    self.program,
                    function.ty.params(function.arity as usize).1,
                    &mut BTreeSet::new(),
                );
                if returns_functions {
                    match contract {
                        Some(c)
                            if matches!(
                                c.result,
                                crate::ownership::ResultOwnership::Static
                                    | crate::ownership::ResultOwnership::Never
                            ) =>
                        {
                            result.clear()
                        }
                        Some(c)
                            if !c.aliases.is_empty()
                                || c.callback.is_some()
                                || symbol == "list.ap" => {}
                        // The ownership contract identifies input aliases and
                        // callback-produced values. A fresh runtime producer
                        // with neither source needs its own function model.
                        _ => {
                            result.insert(Origin::UnknownFunction);
                        }
                    }
                }
                let returns_channels = has_channels(
                    self.program,
                    function.ty.params(function.arity as usize).1,
                    &mut BTreeSet::new(),
                );
                if returns_channels {
                    match contract {
                        Some(c)
                            if matches!(
                                c.result,
                                crate::ownership::ResultOwnership::Static
                                    | crate::ownership::ResultOwnership::Never
                            ) =>
                        {
                            result.clear()
                        }
                        Some(c) if !c.aliases.is_empty() || c.callback.is_some() => {}
                        _ => {
                            result.insert(Origin::UnknownQueue);
                        }
                    }
                }
                if has_tasks(
                    self.program,
                    function.ty.params(function.arity as usize).1,
                    &mut BTreeSet::new(),
                ) {
                    match contract {
                        Some(c)
                            if matches!(
                                c.result,
                                crate::ownership::ResultOwnership::Static
                                    | crate::ownership::ResultOwnership::Never
                            ) =>
                        {
                            result.clear()
                        }
                        Some(c) if !c.aliases.is_empty() || c.callback.is_some() => {}
                        _ => {
                            result.insert(Origin::UnknownTask);
                        }
                    }
                }
                let callback = if symbol == "list.ap" {
                    Some(0) // The first list contains the functions to apply.
                } else {
                    contract.and_then(|c| {
                        c.callback.map(|callback| match callback {
                            crate::ownership::Callback::Borrowed(i)
                            | crate::ownership::Callback::Retained(i)
                            | crate::ownership::Callback::Shared(i) => i,
                        })
                    })
                };
                let Some(callback) = callback else {
                    // Unknown runtime boundaries retain the conservative proof.
                    if contract.is_some() {
                        return Ok(result);
                    }
                    for &closure in result.clone().iter().filter(|origin| origin.callable()) {
                        let Origin::Function(target, supplied) = closure else {
                            if self.validate {
                                return Err(
                                    "--gc arc: cannot prove a runtime callback target".into()
                                );
                            }
                            continue;
                        };
                        let count = self.program.funcs[target].arity as usize - supplied;
                        result.extend(self.apply(
                            &BTreeSet::from([closure]),
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
                for &closure in functions.iter().filter(|origin| origin.callable()) {
                    let Origin::Function(target, supplied) = closure else {
                        if self.validate {
                            return Err("--gc arc: cannot prove a primitive callback target".into());
                        }
                        result.insert(Origin::UnknownFunction);
                        continue;
                    };
                    let count = self.program.funcs[target].arity as usize - supplied;
                    let values = vec![data.clone(); count];
                    let returned = self.apply(&BTreeSet::from([closure]), &values, scoped)?;
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
                let result_type = function.ty.params(function.arity as usize).1;
                let mut result = if has_functions(self.program, result_type, &mut BTreeSet::new()) {
                    Targets::from([Origin::UnknownFunction])
                } else {
                    Targets::new()
                };
                if has_channels(self.program, result_type, &mut BTreeSet::new()) {
                    result.insert(Origin::UnknownQueue);
                }
                if has_tasks(self.program, result_type, &mut BTreeSet::new()) {
                    result.insert(Origin::UnknownTask);
                }
                Ok(result)
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
                    self.apply(
                        &BTreeSet::from([Origin::Function(iterator, 0)]),
                        &[Targets::new()],
                        scoped,
                    )
                } else {
                    Ok(Targets::new())
                }
            }
        }
    }
}

pub(crate) fn check(
    program: &Program,
    entries: &[FuncId],
    entry_channels: EntryChannels,
) -> Result<(), String> {
    let queued_functions = program.funcs.iter().any(|function| {
        let mut seen = BTreeSet::new();
        has_function_channels(program, &function.ty, &mut seen)
            || function
                .locals
                .iter()
                .any(|ty| has_function_channels(program, ty, &mut seen))
    });
    if !queued_functions && !program.funcs.iter().any(|f| matches!(&f.body, Body::Prim(s) if matches!(s.as_str(), "task.spawn" | "ad.tape" | "ad.push" | "ad.backward" | "ad.tape-owned" | "ad.push-owned" | "ad.backward-owned" | "run-state" | "get" | "put" | "modify"))) {
        return Ok(());
    }
    let mut proof = Proof {
        program,
        captures: BTreeMap::new(),
        inputs: BTreeMap::new(),
        outputs: BTreeMap::new(),
        callback_values: BTreeMap::new(),
        channel_values: BTreeMap::new(),
        task_thunks: BTreeMap::new(),
        task_results: BTreeMap::new(),
        changed: false,
        validate: false,
        state_values: Targets::new(),
        error_values: Targets::new(),
    };
    for &entry in entries {
        // Wire inputs have no language closures. An external function-valued
        // input remains unknown, even if joined with a known function later.
        // Served input iterators have an explicit runtime constructor below.
        let received_iterator = program.service.as_ref().is_some_and(|service| {
            service
                .methods
                .iter()
                .any(|method| method.func == entry && method.iter_fn.is_some())
        });
        let function = &program.funcs[entry];
        let grpc_response = if entry_channels == EntryChannels::GrpcResponses {
            let method = program
                .service
                .as_ref()
                .and_then(|service| service.methods.iter().find(|method| method.func == entry))
                .ok_or("--gc arc: gRPC entry has no served method contract")?;
            matches!(
                crate::rpc::shape(&function.ty, function.arity as usize, method.error.as_ref())
                    .output,
                crate::rpc::Output::Chan(_)
            )
        } else {
            false
        };
        for ty in function.ty.params(function.arity as usize).0 {
            if has_function_channels(program, ty, &mut BTreeSet::new()) {
                return Err(
                    "--gc arc: external function-bearing channels have no proved queue ownership"
                        .into(),
                );
            }
        }
        let args: Vec<_> = function
            .ty
            .params(function.arity as usize)
            .0
            .iter()
            .enumerate()
            .map(|(index, ty)| {
                let mut origins = if !(received_iterator && index == 0)
                    && has_functions(program, ty, &mut BTreeSet::new())
                {
                    Targets::from([Origin::UnknownFunction])
                } else {
                    Targets::new()
                };
                if has_channels(program, ty, &mut BTreeSet::new()) {
                    // Only the service emitter supplies this native producer.
                    // g_run_method uses g_sink_value with an uncaptured codec;
                    // its gRPC transport owns bytes, not language callbacks.
                    // A matching signature or service metadata alone is not
                    // a producer contract for arbitrary external arguments.
                    origins.insert(if grpc_response && index + 1 == function.arity as usize {
                        Origin::GrpcSender(entry)
                    } else {
                        Origin::UnknownQueue
                    });
                }
                if has_tasks(program, ty, &mut BTreeSet::new()) {
                    origins.insert(Origin::UnknownTask);
                }
                origins
            })
            .collect();
        proof.request(entry, 0, &args);
    }
    loop {
        proof.changed = false;
        proof.service_boundaries(entries)?;
        for ((id, scoped), args) in proof.inputs.clone() {
            let mut result = proof.function(id, scoped, &args).map_err(|error| {
                format!("{error}\n  while checking `{}`", program.funcs[id].name)
            })?;
            let function = &program.funcs[id];
            let result_type = function.ty.params(function.arity as usize).1;
            if !has_functions(program, result_type, &mut BTreeSet::new()) {
                result.retain(|origin| !origin.callable());
            }
            proof.refine_origins(&mut result, result_type);
            proof.changed |= join(proof.outputs.entry((id, scoped)).or_default(), &result);
        }
        if !proof.changed {
            break;
        }
    }
    proof.validate = true;
    proof.service_boundaries(entries)?;
    for ((id, scoped), args) in proof.inputs.clone() {
        proof
            .function(id, scoped, &args)
            .map_err(|error| format!("{error}\n  while checking `{}`", program.funcs[id].name))?;
    }
    for (&task, results) in &proof.task_results {
        proof.task_result_owners(task, results, &mut BTreeSet::new())?;
    }
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::ir::{Func, ServedFn, ServiceDef};

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
        assert!(check(&state_program(true), &[0], EntryChannels::Unknown).is_ok());
        assert!(check(&state_program(false), &[0], EntryChannels::Unknown)
            .unwrap_err()
            .contains("tracing-free lifetime policy"));
    }

    #[test]
    fn queued_functions_use_the_receivers_scope() {
        // Sending get does not call it or retain a scope. The receiver must
        // establish its own State handler before invoking the queued function.
        for scoped in [false, true] {
            let mut program = state_program(scoped);
            let unit = MT::unit();
            let string = MT::con("std::String");
            let getter = arrow(unit.clone(), string.clone());
            let channel = MT::Con("std::Channel".into(), vec![getter.clone()]);
            let option = MT::Con("std::Option".into(), vec![getter.clone()]);
            let boolean = MT::con("std::Bool");
            let integer = MT::con("std::I64");
            let reader = arrow(channel.clone(), string.clone());
            let pair = MT::Record(vec![
                ("0".into(), string.clone()),
                ("1".into(), string.clone()),
            ]);
            program.funcs.extend([
                Func {
                    name: "queue".into(),
                    arity: 1,
                    locals: vec![integer.clone()],
                    ty: arrow(integer, channel.clone()),
                    body: Body::Prim("channel.make".into()),
                },
                Func {
                    name: "send".into(),
                    arity: 2,
                    locals: vec![channel.clone(), getter.clone()],
                    ty: arrow(channel.clone(), arrow(getter, boolean.clone())),
                    body: Body::Prim("channel.send".into()),
                },
                Func {
                    name: "receive".into(),
                    arity: 1,
                    locals: vec![channel.clone()],
                    ty: arrow(channel.clone(), option),
                    body: Body::Prim("channel.recv".into()),
                },
                Func {
                    name: "call-received".into(),
                    arity: 1,
                    locals: vec![channel.clone()],
                    ty: reader.clone(),
                    body: Body::Expr(Expr::Apply(
                        Box::new(Expr::Field(
                            Box::new(Expr::Call(5, vec![Expr::Local(0)])),
                            0,
                        )),
                        vec![Expr::Const(Value::unit())],
                    )),
                },
            ]);
            program.funcs[2].locals = vec![string.clone(), reader.clone(), channel.clone()];
            program.funcs[2].ty = arrow(string, arrow(reader, arrow(channel.clone(), pair)));
            program.funcs[0].locals = vec![channel, boolean];
            program.funcs[0].body = Body::Expr(Expr::Let(
                0,
                Box::new(Expr::Call(3, vec![Expr::Const(Value::I64(1))])),
                Box::new(Expr::Let(
                    1,
                    Box::new(Expr::Call(4, vec![Expr::Local(0), Expr::Func(1)])),
                    Box::new(if scoped {
                        Expr::Call(
                            2,
                            vec![
                                Expr::Const(Value::str("receiver")),
                                Expr::Func(6),
                                Expr::Local(0),
                            ],
                        )
                    } else {
                        Expr::Call(6, vec![Expr::Local(0)])
                    }),
                )),
            ));
            if scoped {
                check(&program, &[0], EntryChannels::Unknown).unwrap();
            } else {
                assert!(check(&program, &[0], EntryChannels::Unknown)
                    .unwrap_err()
                    .contains("outside a State scope"));
            }
        }
    }

    #[test]
    fn joining_a_known_target_does_not_hide_an_unknown_function() {
        let program = state_program(true);
        let mut proof = Proof {
            program: &program,
            captures: BTreeMap::new(),
            inputs: BTreeMap::new(),
            outputs: BTreeMap::new(),
            callback_values: BTreeMap::new(),
            channel_values: BTreeMap::new(),
            task_thunks: BTreeMap::new(),
            task_results: BTreeMap::new(),
            changed: false,
            validate: true,
            state_values: Targets::new(),
            error_values: Targets::new(),
        };
        let mut functions = Targets::from([Origin::Function(1, 0)]);
        assert!(proof
            .apply(&Targets::new(), &[Targets::new()], STATE)
            .unwrap()
            .is_empty());
        assert!(join(
            &mut functions,
            &Targets::from([Origin::UnknownFunction])
        ));
        functions.insert(Origin::Function(2, 0));
        proof.refine_origins(&mut functions, &program.funcs[1].ty);
        assert_eq!(
            functions,
            Targets::from([Origin::Function(1, 0), Origin::UnknownFunction])
        );
        assert!(proof
            .apply(&functions, &[Targets::new()], STATE)
            .unwrap_err()
            .contains("cannot prove the target"));
        assert!(proof
            .queued_targets(&functions, &mut BTreeSet::new())
            .unwrap_err()
            .contains("cannot prove the source"));
    }

    #[test]
    fn nonreturning_primitives_do_not_produce_unknown_functions() {
        for symbol in ["prim.trap", "exit", "unmodeled-function-producer"] {
            let mut program = state_program(true);
            let input = if symbol == "exit" {
                Value::I64(1)
            } else {
                Value::str("stopped")
            };
            let input_type = if symbol == "exit" {
                MT::con("std::I64")
            } else {
                MT::con("std::String")
            };
            program.funcs.push(Func {
                name: symbol.into(),
                arity: 1,
                locals: vec![input_type.clone()],
                ty: arrow(input_type, program.funcs[1].ty.clone()),
                body: Body::Prim(symbol.into()),
            });
            program.funcs[0].body = Body::Expr(Expr::Apply(
                Box::new(Expr::Call(3, vec![Expr::Const(input)])),
                vec![Expr::Const(Value::unit())],
            ));
            let result = check(&program, &[0], EntryChannels::Unknown);
            if symbol == "unmodeled-function-producer" {
                assert!(result.unwrap_err().contains("cannot prove"));
            } else {
                result.unwrap();
            }
        }
    }

    #[test]
    fn queued_capture_proof_follows_nested_function_owners() {
        for captured_type in [
            MT::con("std::String"),
            MT::con("std::UdpSocket"),
            MT::con("std::Listener"),
            MT::con("std::Conn"),
            MT::con("std::File"),
            MT::con("std::Task"),
            MT::con("std::H2Stream"),
            MT::con("std::GrpcCell"),
            MT::Con("std::Channel".into(), vec![MT::con("std::String")]),
        ] {
            let mut program = state_program(true);
            let getter = program.funcs[1].ty.clone();
            let unit = MT::unit();
            program.funcs.extend([
                Func {
                    name: "capture-value".into(),
                    arity: 2,
                    locals: vec![captured_type.clone(), unit.clone()],
                    ty: arrow(captured_type.clone(), getter.clone()),
                    body: Body::Expr(Expr::Const(Value::str("result"))),
                },
                Func {
                    name: "capture-function".into(),
                    arity: 2,
                    locals: vec![getter.clone(), unit],
                    ty: arrow(getter.clone(), getter),
                    body: Body::Expr(Expr::Apply(Box::new(Expr::Local(0)), vec![Expr::Local(1)])),
                },
            ]);
            let mut proof = Proof {
                program: &program,
                captures: BTreeMap::new(),
                inputs: BTreeMap::new(),
                outputs: BTreeMap::new(),
                callback_values: BTreeMap::new(),
                channel_values: BTreeMap::new(),
                task_thunks: BTreeMap::new(),
                task_results: BTreeMap::new(),
                changed: false,
                validate: true,
                state_values: Targets::new(),
                error_values: Targets::new(),
            };
            let captured = proof.partial(3, vec![Targets::new()]);
            let nested = proof.partial(4, vec![captured.clone()]);
            for value in [captured, nested] {
                let checked = proof.queued_targets(&value, &mut BTreeSet::new());
                if matches!(&captured_type, MT::Con(name, _) if matches!(name.as_str(),
                    "std::String" | "std::UdpSocket" | "std::Listener" | "std::Conn"))
                {
                    checked.unwrap();
                } else {
                    assert!(checked
                        .unwrap_err()
                        .contains("cannot prove a queued function's captured"));
                }
            }
        }
    }

    #[test]
    fn queued_task_captures_follow_the_computation_and_unknown_inputs() {
        let unit = MT::unit();
        let text = MT::con("std::String");
        let boolean = MT::con("std::Bool");
        let callback = arrow(unit.clone(), text.clone());
        let task = MT::Con("std::Task".into(), vec![text.clone()]);
        let queue = MT::Con("std::Channel".into(), vec![callback.clone()]);
        let make_queue = Expr::Call(1, vec![Expr::Const(Value::I64(1))]);
        let safe_task = Expr::Call(2, vec![Expr::Func(3)]);
        let capture = |task| Expr::Apply(Box::new(Expr::Func(4)), vec![task]);
        let mut program = Program {
            main: Some(0),
            funcs: vec![
                Func {
                    name: "main".into(),
                    arity: 0,
                    locals: vec![queue.clone()],
                    ty: boolean.clone(),
                    body: Body::Expr(Expr::Call(5, vec![make_queue.clone(), capture(safe_task)])),
                },
                Func {
                    name: "make".into(),
                    arity: 1,
                    locals: vec![MT::con("std::I64")],
                    ty: arrow(MT::con("std::I64"), queue.clone()),
                    body: Body::Prim("channel.make".into()),
                },
                Func {
                    name: "spawn".into(),
                    arity: 1,
                    locals: vec![callback.clone()],
                    ty: arrow(callback.clone(), task.clone()),
                    body: Body::Prim("task.spawn".into()),
                },
                Func {
                    name: "work".into(),
                    arity: 1,
                    locals: vec![unit.clone()],
                    ty: callback.clone(),
                    body: Body::Expr(Expr::Const(Value::str("done"))),
                },
                Func {
                    name: "retain-task".into(),
                    arity: 2,
                    locals: vec![task.clone(), unit.clone()],
                    ty: arrow(task.clone(), callback.clone()),
                    body: Body::Expr(Expr::Const(Value::str("retained"))),
                },
                Func {
                    name: "send".into(),
                    arity: 2,
                    locals: vec![queue.clone(), callback.clone()],
                    ty: arrow(queue.clone(), arrow(callback.clone(), boolean.clone())),
                    body: Body::Prim("channel.send".into()),
                },
                Func {
                    name: "retain-function-queue".into(),
                    arity: 2,
                    locals: vec![queue.clone(), unit],
                    ty: arrow(queue.clone(), callback),
                    body: Body::Expr(Expr::Const(Value::str("hidden back edge"))),
                },
            ],
            ..Program::default()
        };
        check(&program, &[0], EntryChannels::Unknown).unwrap();
        let task_with_queue = Expr::Call(
            2,
            vec![Expr::Apply(Box::new(Expr::Func(6)), vec![Expr::Local(0)])],
        );
        program.funcs[0].body = Body::Expr(Expr::Let(
            0,
            Box::new(make_queue.clone()),
            Box::new(Expr::Call(
                5,
                vec![Expr::Local(0), capture(task_with_queue)],
            )),
        ));
        assert!(check(&program, &[0], EntryChannels::Unknown)
            .unwrap_err()
            .contains("function-bearing channel"));

        // The same Task[String] type does not prove an external task's thunk.
        program.funcs[0].arity = 1;
        program.funcs[0].locals = vec![task.clone()];
        program.funcs[0].ty = arrow(task, boolean);
        program.funcs[0].body =
            Body::Expr(Expr::Call(5, vec![make_queue, capture(Expr::Local(0))]));
        assert!(check(&program, &[0], EntryChannels::Unknown)
            .unwrap_err()
            .contains("captured task producer"));

        // A zero-capture computation can return a closure with hidden owners.
        // Inspect that result too, even when the outer callback never awaits it.
        let callback = program.funcs[3].ty.clone();
        let returned_task = MT::Con("std::Task".into(), vec![callback.clone()]);
        let producer = arrow(MT::unit(), callback.clone());
        program.funcs[2].locals = vec![producer.clone()];
        program.funcs[2].ty = arrow(producer.clone(), returned_task.clone());
        program.funcs[3].ty = producer;
        program.funcs[3].body = Body::Expr(Expr::Apply(
            Box::new(Expr::Func(6)),
            vec![Expr::Call(1, vec![Expr::Const(Value::I64(1))])],
        ));
        program.funcs[4].locals[0] = returned_task.clone();
        program.funcs[4].ty = arrow(returned_task, callback);
        program.funcs[0].arity = 0;
        program.funcs[0].locals.clear();
        program.funcs[0].ty = MT::con("std::Bool");
        program.funcs[0].body = Body::Expr(Expr::Call(
            5,
            vec![
                Expr::Call(1, vec![Expr::Const(Value::I64(1))]),
                capture(Expr::Call(2, vec![Expr::Func(3)])),
            ],
        ));
        assert!(check(&program, &[0], EntryChannels::Unknown)
            .unwrap_err()
            .contains("function-bearing channel"));
    }

    #[test]
    fn a_task_result_cannot_own_its_producer_through_a_returned_function() {
        let callback = arrow(MT::unit(), MT::unit());
        let record = MT::Record(vec![("read".into(), callback.clone())]);
        let task = MT::Con("std::Task".into(), vec![record.clone()]);
        let work = arrow(MT::unit(), record.clone());
        let mut program = Program {
            main: Some(0),
            funcs: vec![
                Func {
                    name: "main".into(),
                    arity: 0,
                    locals: vec![],
                    ty: task.clone(),
                    body: Body::Expr(Expr::Call(1, vec![Expr::Func(2)])),
                },
                Func {
                    name: "spawn".into(),
                    arity: 1,
                    locals: vec![work.clone()],
                    ty: arrow(work.clone(), task.clone()),
                    body: Body::Prim("task.spawn".into()),
                },
                Func {
                    name: "work".into(),
                    arity: 1,
                    locals: vec![MT::unit()],
                    ty: work,
                    body: Body::Expr(Expr::Record(vec![Expr::Apply(
                        Box::new(Expr::Func(3)),
                        vec![Expr::Func(0)],
                    )])),
                },
                Func {
                    name: "keep-task".into(),
                    arity: 2,
                    locals: vec![task.clone(), MT::unit()],
                    ty: arrow(task, callback),
                    body: Body::Expr(Expr::Const(Value::unit())),
                },
            ],
            ..Program::default()
        };
        assert!(check(&program, &[0], EntryChannels::Unknown)
            .unwrap_err()
            .contains("acyclic task result"));
        // A callback without that owner is valid, even with the same result type.
        program.funcs[2].body = Body::Expr(Expr::Record(vec![Expr::Func(4)]));
        program.funcs.push(Func {
            name: "empty".into(),
            arity: 1,
            locals: vec![MT::unit()],
            ty: arrow(MT::unit(), MT::unit()),
            body: Body::Expr(Expr::Const(Value::unit())),
        });
        check(&program, &[0], EntryChannels::Unknown).unwrap();
    }

    #[test]
    fn awaiting_a_task_preserves_returned_function_scope_requirements() {
        let mut program = state_program(false);
        let getter = program.funcs[1].ty.clone();
        let task = MT::Con("std::Task".into(), vec![getter.clone()]);
        let option = MT::Con("std::Option".into(), vec![getter.clone()]);
        let producer = arrow(MT::unit(), getter.clone());
        program.funcs.extend([
            Func {
                name: "return-getter".into(),
                arity: 1,
                locals: vec![MT::unit()],
                ty: producer.clone(),
                body: Body::Expr(Expr::Func(1)),
            },
            Func {
                name: "spawn".into(),
                arity: 1,
                locals: vec![producer.clone()],
                ty: arrow(producer, task.clone()),
                body: Body::Prim("task.spawn".into()),
            },
            Func {
                name: "await".into(),
                arity: 1,
                locals: vec![task.clone()],
                ty: arrow(task, option),
                body: Body::Prim("task.await".into()),
            },
        ]);
        program.funcs[0].locals = vec![getter];
        program.funcs[0].body = Body::Expr(Expr::Match(
            Box::new(Expr::Call(5, vec![Expr::Call(4, vec![Expr::Func(3)])])),
            vec![
                (
                    Pat::Construct(1, vec![Pat::Bind(0)]),
                    Expr::Apply(Box::new(Expr::Local(0)), vec![Expr::Const(Value::unit())]),
                ),
                (
                    Pat::Construct(0, vec![]),
                    Expr::Const(Value::str("cancelled")),
                ),
            ],
        ));
        assert!(check(&program, &[0], EntryChannels::Unknown)
            .unwrap_err()
            .contains("outside a State scope"));
    }

    #[test]
    fn queued_socket_containers_do_not_hide_mutable_owners() {
        let tree = MT::con("SocketTree");
        for socket in ["std::UdpSocket", "std::Listener", "std::Conn"] {
            let mut program = Program::default();
            program.shapes.insert(
                tree.clone(),
                TypeShape::Adt(vec![
                    ("Branch".into(), vec![tree.clone()]),
                    ("Handle".into(), vec![MT::con(socket)]),
                ]),
            );
            let handles = MT::Con("std::List".into(), vec![tree.clone()]);
            queued_capture_type(&program, &handles, &mut BTreeSet::new()).unwrap();
            for owner in [
                "std::File",
                "std::Task",
                "std::Channel",
                "std::H2Stream",
                "std::GrpcCell",
                "?",
            ] {
                let mixed = MT::Record(vec![
                    ("handles".into(), handles.clone()),
                    ("owner".into(), MT::con(owner)),
                ]);
                let error = queued_capture_type(&program, &mixed, &mut BTreeSet::new())
                    .expect_err("a safe socket field must not hide another owner");
                assert!(error.contains(owner.trim_start_matches("std::")), "{error}");
            }
        }
    }

    #[test]
    fn queued_data_captures_require_known_producers_and_nested_owners() {
        let unit = MT::unit();
        let leaf = MT::Con("std::Channel".into(), vec![MT::con("std::String")]);
        let nested = MT::Con("std::Channel".into(), vec![leaf.clone()]);
        let callback = arrow(unit.clone(), unit.clone());
        let callbacks = MT::Con("std::Channel".into(), vec![callback.clone()]);
        let list = MT::Con("std::List".into(), vec![leaf.clone()]);
        let mut program = Program::default();
        for ty in [leaf.clone(), nested.clone(), callbacks.clone()] {
            program.funcs.push(Func {
                name: "make-data-queue".into(),
                arity: 1,
                locals: vec![MT::con("std::I64")],
                ty: arrow(MT::con("std::I64"), ty),
                body: Body::Prim("channel.make".into()),
            });
        }
        for ty in [leaf.clone(), nested.clone(), callbacks, list] {
            program.funcs.push(Func {
                name: "capture-queue".into(),
                arity: 2,
                locals: vec![ty.clone(), unit.clone()],
                ty: arrow(ty, callback.clone()),
                body: Body::Expr(Expr::Const(Value::unit())),
            });
        }
        program.funcs.push(Func {
            name: "unmodeled-queue-producer".into(),
            arity: 1,
            locals: vec![unit.clone()],
            ty: arrow(unit, leaf.clone()),
            body: Body::Prim("unmodeled-queue-producer".into()),
        });
        let callback_queue = MT::Con("std::Channel".into(), vec![callback.clone()]);
        program.funcs.push(Func {
            name: "send-callback".into(),
            arity: 2,
            locals: vec![callback_queue.clone(), callback.clone()],
            ty: arrow(callback_queue, arrow(callback, MT::con("std::Bool"))),
            body: Body::Prim("channel.send".into()),
        });
        program.funcs.push(Func {
            name: "entry".into(),
            arity: 0,
            locals: vec![],
            ty: MT::con("std::Bool"),
            body: Body::Expr(Expr::Call(
                8,
                vec![
                    Expr::Call(2, vec![Expr::Const(Value::I64(1))]),
                    Expr::Apply(
                        Box::new(Expr::Func(3)),
                        vec![Expr::Call(0, vec![Expr::Const(Value::I64(1))])],
                    ),
                ],
            )),
        });
        // Exercise the fixed-point summaries as well as the direct operations
        // below: a non-function result must preserve its channel producer.
        check(&program, &[9], EntryChannels::Unknown).unwrap();
        let mut proof = Proof {
            program: &program,
            captures: BTreeMap::new(),
            inputs: BTreeMap::new(),
            outputs: BTreeMap::new(),
            callback_values: BTreeMap::new(),
            channel_values: BTreeMap::new(),
            task_thunks: BTreeMap::new(),
            task_results: BTreeMap::new(),
            changed: false,
            validate: true,
            state_values: Targets::new(),
            error_values: Targets::new(),
        };
        let queue = proof.function(0, 0, &[Targets::new()]).unwrap();
        assert_eq!(queue, Targets::from([Origin::Queue(0)]));
        let captured = proof.partial(3, vec![queue.clone()]);
        proof
            .queued_targets(&captured, &mut BTreeSet::new())
            .unwrap();
        let outer = proof.function(1, 0, &[Targets::new()]).unwrap();
        proof.channel_values.insert(nested.clone(), queue.clone());
        let captured_outer = proof.partial(4, vec![outer.clone()]);
        proof
            .queued_targets(&captured_outer, &mut BTreeSet::new())
            .unwrap();

        // Empty immutable containers contain no channel owner to invent.
        let empty = proof.partial(6, vec![Targets::new()]);
        proof.queued_targets(&empty, &mut BTreeSet::new()).unwrap();
        let contained = proof.partial(6, vec![queue.clone()]);
        proof
            .queued_targets(&contained, &mut BTreeSet::new())
            .unwrap();

        let function_queue = proof.function(2, 0, &[Targets::new()]).unwrap();
        let captured_functions = proof.partial(5, vec![function_queue]);
        assert!(proof
            .queued_targets(&captured_functions, &mut BTreeSet::new())
            .unwrap_err()
            .contains("function-bearing channel"));

        let unknown = proof.function(7, 0, &[Targets::new()]).unwrap();
        assert_eq!(unknown, Targets::from([Origin::UnknownQueue]));
        let mut mixed = queue.clone();
        mixed.extend(unknown);
        proof.channel_values.insert(nested, mixed.clone());
        assert!(proof
            .queued_targets(&captured_outer, &mut BTreeSet::new())
            .unwrap_err()
            .contains("cannot prove the producer"));
        let captured_unknown = proof.partial(3, vec![mixed]);
        assert!(proof
            .queued_targets(&captured_unknown, &mut BTreeSet::new())
            .unwrap_err()
            .contains("cannot prove the producer"));

        // A neighboring field's queue is not the origin of this channel type.
        let mut fields = outer;
        fields.extend(queue);
        proof.refine_origins(&mut fields, &leaf);
        assert_eq!(fields, Targets::from([Origin::Queue(0)]));
        fields.insert(Origin::UnknownQueue);
        proof.refine_origins(&mut fields, &leaf);
        assert!(fields.contains(&Origin::UnknownQueue));
        proof.refine_origins(&mut fields, &MT::con("std::String"));
        assert!(fields.is_empty());
    }

    #[test]
    fn grpc_response_captures_require_the_actual_service_entry_contract() {
        let unit = MT::unit();
        let integer = MT::con("std::I64");
        let boolean = MT::con("std::Bool");
        let channel = MT::Con("std::Channel".into(), vec![MT::con("std::String")]);
        let callback = arrow(unit.clone(), unit.clone());
        let events = MT::Con("std::Channel".into(), vec![callback.clone()]);
        let captured = |queue| Expr::Apply(Box::new(Expr::Func(1)), vec![queue]);
        let send = |queue| {
            Expr::Let(
                2,
                Box::new(Expr::Call(
                    2,
                    vec![
                        Expr::Call(0, vec![Expr::Const(Value::I64(1))]),
                        captured(queue),
                    ],
                )),
                Box::new(Expr::Const(Value::unit())),
            )
        };
        let mut program = Program {
            funcs: vec![
                Func {
                    name: "events".into(),
                    arity: 1,
                    locals: vec![integer.clone()],
                    ty: arrow(integer.clone(), events.clone()),
                    body: Body::Prim("channel.make".into()),
                },
                Func {
                    name: "capture-response".into(),
                    arity: 2,
                    locals: vec![channel.clone(), unit.clone()],
                    ty: arrow(channel.clone(), callback.clone()),
                    body: Body::Expr(Expr::Const(Value::unit())),
                },
                Func {
                    name: "send-event".into(),
                    arity: 2,
                    locals: vec![events.clone(), callback.clone()],
                    ty: arrow(events, arrow(callback, boolean.clone())),
                    body: Body::Prim("channel.send".into()),
                },
                Func {
                    name: "serve".into(),
                    arity: 2,
                    locals: vec![integer.clone(), channel.clone(), boolean],
                    ty: arrow(integer, arrow(channel.clone(), unit)),
                    body: Body::Expr(send(Expr::Local(1))),
                },
            ],
            service: Some(ServiceDef {
                module: "responses".into(),
                default_addr: String::new(),
                methods: vec![ServedFn {
                    name: "serve".into(),
                    func: 3,
                    error: None,
                    path: "/responses/Serve".into(),
                    iter_fn: None,
                }],
            }),
            ..Program::default()
        };
        // The same type and service metadata do not make an external queue a
        // gRPC sender. Only the emitter that creates that sender may attest it.
        assert!(check(&program, &[3], EntryChannels::Unknown)
            .unwrap_err()
            .contains("cannot prove the producer"));
        check(&program, &[3], EntryChannels::GrpcResponses).unwrap();

        // A native sender does not make another argument's owner known.
        program.funcs[3].locals[0] = channel.clone();
        program.funcs[3].ty = arrow(channel.clone(), arrow(channel, MT::unit()));
        program.funcs[3].body = Body::Expr(send(Expr::Local(0)));
        assert!(check(&program, &[3], EntryChannels::GrpcResponses)
            .unwrap_err()
            .contains("cannot prove the producer"));

        program.service.as_mut().unwrap().methods.clear();
        assert!(check(&program, &[3], EntryChannels::GrpcResponses)
            .unwrap_err()
            .contains("no served method contract"));
    }

    #[test]
    fn runtime_function_producers_and_external_queues_need_known_sources() {
        let mut program = state_program(true);
        let getter = program.funcs[1].ty.clone();
        let unit = MT::unit();
        program.funcs.push(Func {
            name: "unmodeled-function-producer".into(),
            arity: 1,
            locals: vec![unit.clone()],
            ty: arrow(unit, getter.clone()),
            body: Body::Prim("unmodeled-function-producer".into()),
        });
        let mut proof = Proof {
            program: &program,
            captures: BTreeMap::new(),
            inputs: BTreeMap::new(),
            outputs: BTreeMap::new(),
            callback_values: BTreeMap::new(),
            channel_values: BTreeMap::new(),
            task_thunks: BTreeMap::new(),
            task_results: BTreeMap::new(),
            changed: false,
            validate: false,
            state_values: Targets::new(),
            error_values: Targets::new(),
        };
        let produced = proof.function(3, STATE, &[Targets::new()]).unwrap();
        assert!(produced.contains(&Origin::UnknownFunction));
        assert!(proof
            .queued_targets(&produced, &mut BTreeSet::new())
            .is_err());
        let channel = MT::Con("std::Channel".into(), vec![getter]);
        program.funcs.push(Func {
            name: "external-queue".into(),
            arity: 1,
            locals: vec![channel.clone()],
            ty: arrow(channel.clone(), channel),
            body: Body::Expr(Expr::Local(0)),
        });
        assert!(check(&program, &[4], EntryChannels::Unknown)
            .unwrap_err()
            .contains("external function-bearing channels"));
    }

    #[test]
    fn caught_error_payloads_keep_their_function_targets() {
        let mut program = state_program(false);
        let unit = MT::unit();
        let getter = program.funcs[1].ty.clone();
        let thunk = arrow(unit.clone(), unit.clone());
        let result = MT::Con("std::Result".into(), vec![unit.clone(), getter.clone()]);
        program.funcs.extend([
            Func {
                name: "fail-with-function".into(),
                arity: 1,
                locals: vec![getter.clone()],
                ty: arrow(getter.clone(), unit.clone()),
                body: Body::Prim("fail".into()),
            },
            Func {
                name: "throw-getter".into(),
                arity: 1,
                locals: vec![unit.clone()],
                ty: thunk.clone(),
                body: Body::Expr(Expr::Call(3, vec![Expr::Func(1)])),
            },
            Func {
                name: "catch-function".into(),
                arity: 2,
                locals: vec![thunk.clone(), unit.clone()],
                ty: arrow(thunk, arrow(unit, result)),
                body: Body::Prim("attempt".into()),
            },
        ]);
        program.funcs[0].locals = vec![getter];
        program.funcs[0].body = Body::Expr(Expr::Match(
            Box::new(Expr::Call(
                5,
                vec![Expr::Func(4), Expr::Const(Value::unit())],
            )),
            vec![
                (
                    Pat::Construct(1, vec![Pat::Bind(0)]),
                    Expr::Apply(Box::new(Expr::Local(0)), vec![Expr::Const(Value::unit())]),
                ),
                (Pat::Wild, Expr::Const(Value::str("unused success branch"))),
            ],
        ));
        assert!(check(&program, &[0], EntryChannels::Unknown)
            .unwrap_err()
            .contains("outside a State scope"));
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
                check(&p, &[0], EntryChannels::Unknown)
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
                let checked = check(&p, &[0], EntryChannels::Unknown);
                if bidirectional {
                    assert!(checked.unwrap_err().contains("outside a State scope"));
                } else {
                    checked.unwrap();
                }
                // A synchronous sender outside a handler is unsafe too.
                assert!(check(&p, &[5], EntryChannels::Unknown)
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
                    check(&p, &[0], EntryChannels::Unknown).unwrap();
                    check(&p, &[5], EntryChannels::Unknown).unwrap();
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
            check(&p, &[5], EntryChannels::Unknown).unwrap();
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
            assert!(check(&p, &[5], EntryChannels::Unknown)
                .unwrap_err()
                .contains("outside a State scope"));
            let mut inner = p.funcs[4].clone();
            inner.name = "step-with-local-state".into();
            p.funcs.push(inner);
            p.funcs[4].body = Body::Expr(local_state(7));
            check(&p, &[5], EntryChannels::Unknown).unwrap();

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
            assert!(check(&p, &[5], EntryChannels::Unknown)
                .unwrap_err()
                .contains("no received iterator constructor"));
            p.service.as_mut().unwrap().methods[0].iter_fn = Some(8);
            check(&p, &[5], EntryChannels::Unknown).unwrap();
            p.funcs[4].body = p.funcs[7].body.clone();
            assert!(check(&p, &[5], EntryChannels::Unknown)
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
        assert!(check(&p, &[0], EntryChannels::Unknown)
            .unwrap_err()
            .contains("tracing-free lifetime policy"));
    }

    #[test]
    fn every_entry_starts_without_a_dynamic_scope() {
        let p = state_program(true);
        assert!(check(&p, &[0], EntryChannels::Unknown).is_ok());
        assert!(check(&p, &[0, 1], EntryChannels::Unknown)
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
        assert!(check(&p, &[0], EntryChannels::Unknown).is_ok());
        // The same closure is still rejected when actually called unscoped.
        p.funcs[0].ty = MT::con("std::String");
        p.funcs[0].body = Body::Expr(Expr::Apply(
            Box::new(carry),
            vec![Expr::Const(Value::unit())],
        ));
        assert!(check(&p, &[0], EntryChannels::Unknown)
            .unwrap_err()
            .contains("outside a State scope"));
    }
}
