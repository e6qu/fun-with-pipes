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
            Expr::Dup(_, body) | Expr::Drop(_, body) | Expr::ResourceRegion { body, .. } => {
                self.expr(body, locals, scoped)?
            }
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
                        let value = self.apply(&args[0], &[self.state_values.clone()], scoped)?;
                        self.changed |= join(&mut self.state_values, &value);
                        Ok(Targets::new())
                    }
                }
            }
            Body::Prim(symbol)
                if matches!(symbol.as_str(), "ad.tape" | "ad.push" | "ad.backward") =>
            {
                if scoped & AD == 0 {
                    return Err(format!("--gc arc: primitive `{symbol}` has no tracing-free lifetime policy outside an autodiff scope"));
                }
                Ok(Targets::new())
            }
            Body::Prim(_) => {
                // Include callbacks inside containers (list.ap, for example),
                // not only primitives with a top-level callback argument.
                let mut result: Targets = args.iter().flatten().copied().collect();
                let functions = result.clone();
                for &(target, supplied) in &functions {
                    let count = self.program.funcs[target].arity as usize - supplied;
                    let values = vec![functions.clone(); count];
                    result.extend(self.apply(
                        &BTreeSet::from([(target, supplied)]),
                        &values,
                        scoped,
                    )?);
                }
                Ok(result)
            }
            Body::Ctor(_) => Ok(args.iter().flatten().copied().collect()),
            Body::ForeignC { .. } | Body::Remote(_) => Ok(Targets::new()),
        }
    }
}

pub(crate) fn check(program: &Program) -> Result<(), String> {
    if !program.funcs.iter().any(|f| matches!(&f.body, Body::Prim(s) if matches!(s.as_str(), "ad.tape" | "ad.push" | "ad.backward" | "run-state" | "get" | "put" | "modify"))) {
        return Ok(());
    }
    let mut proof = Proof {
        program,
        captures: BTreeMap::new(),
        inputs: BTreeMap::new(),
        outputs: BTreeMap::new(),
        changed: false,
        validate: false,
        state_values: Targets::new(),
    };
    let main = program
        .main
        .ok_or("--gc arc: scoped ownership requires a native main entry")?;
    proof.request(main, 0, &[]);
    loop {
        proof.changed = false;
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
    for ((id, scoped), args) in proof.inputs.clone() {
        proof.function(id, scoped, &args)?;
    }
    Ok(())
}
