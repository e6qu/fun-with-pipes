//! Monomorphization: lowers type-checked bindings to IR functions, one per
//! concrete instantiation, resolving trait methods to impls statically.

use std::collections::HashMap;

use crate::ast::{self, ExprKind, NodeId, PatKind};
use crate::diag::{Diagnostic, Span};
use crate::env::*;
use crate::infer::{PipeMode, Typed};
use crate::ir::*;
use crate::types::*;
use crate::value::Value;

type Subst = HashMap<TV, MT>;
type MResult<T> = Result<T, Diagnostic>;

/// Which entry points to compile.
#[derive(Clone, Copy, Debug, Default)]
pub struct Roots {
    pub main: bool,
    pub tests: bool,
    pub exports: bool,
    /// Run the standard library's own tests.
    pub std_tests: bool,
}

pub struct Mono<'a> {
    env: &'a Env,
    typed: &'a Typed,
    pub prog: Program,
    instances: HashMap<(String, Vec<MT>), FuncId>,
    per_binding: HashMap<String, usize>,
    generated: HashMap<String, FuncId>,
    match_funcs: HashMap<(NodeId, Vec<(TV, MT)>), FuncId>,
    work: Vec<(FuncId, usize, Subst)>,
    match_work: Vec<(FuncId, NodeId, Subst)>,
    matches: HashMap<NodeId, &'a ast::Expr>,
}

/// Function-local builder state.
struct FB {
    nlocals: u32,
}

impl FB {
    fn local(&mut self) -> Local {
        self.nlocals += 1;
        self.nlocals - 1
    }
}

/// Combinators implemented as IR templates rather than primitives.
fn combinator(symbol: &str) -> Option<(u32, Expr)> {
    use Expr::*;
    let l = |i: u32| Local(i);
    let ap = |f: Expr, args: Vec<Expr>| Apply(Box::new(f), args);
    let field = |e: Expr, i: u32| Field(Box::new(e), i);
    Some(match symbol {
        "id" => (1, l(0)),
        "const" => (2, l(0)),
        "flip" => (3, ap(l(0), vec![l(2), l(1)])),
        "compose" => (3, ap(l(1), vec![ap(l(0), vec![l(2)])])),
        "apply" => (2, ap(l(1), vec![l(0)])),
        "fork" => (
            4,
            ap(l(0), vec![ap(l(1), vec![l(3)]), ap(l(2), vec![l(3)])]),
        ),
        "both" => (3, Record(vec![ap(l(0), vec![l(2)]), ap(l(1), vec![l(2)])])),
        "dup" => (1, Record(vec![l(0), l(0)])),
        "on" => (
            4,
            ap(l(0), vec![ap(l(1), vec![l(2)]), ap(l(1), vec![l(3)])]),
        ),
        "uncurry" => (2, ap(l(0), vec![field(l(1), 0), field(l(1), 1)])),
        "curry" => (3, ap(l(0), vec![Record(vec![l(1), l(2)])])),
        "swap" => (1, Record(vec![field(l(0), 1), field(l(0), 0)])),
        "first" => (
            2,
            Record(vec![ap(l(0), vec![field(l(1), 0)]), field(l(1), 1)]),
        ),
        "second" => (
            2,
            Record(vec![field(l(1), 0), ap(l(0), vec![field(l(1), 1)])]),
        ),
        "then2" => (4, ap(l(1), vec![ap(l(0), vec![l(2), l(3)])])),
        "curry3" => (4, ap(l(0), vec![Record(vec![l(1), l(2), l(3)])])),
        "uncurry3" => (
            2,
            ap(l(0), vec![field(l(1), 0), field(l(1), 1), field(l(1), 2)]),
        ),
        "tap" => (
            2,
            Match(Box::new(ap(l(0), vec![l(1)])), vec![(Pat::Wild, l(1))]),
        ),
        "if" => (
            4,
            Match(
                Box::new(ap(l(0), vec![l(3)])),
                vec![
                    (Pat::Construct(1, vec![]), ap(l(1), vec![l(3)])),
                    (Pat::Wild, ap(l(2), vec![l(3)])),
                ],
            ),
        ),
        _ => return None,
    })
}

fn spine_arity(table: &TypeTable, t: &Type) -> u32 {
    let mut n = 0;
    let mut t = table.resolve(t);
    while let Type::Fun(_, r, _) = t {
        n += 1;
        t = table.resolve(&r);
    }
    n
}

fn trits_value(ts: &[i8]) -> i64 {
    ts.iter().fold(0i64, |acc, t| acc * 3 + *t as i64)
}

pub fn int_value(mt: &MT, neg: bool, mag: u128) -> Option<Value> {
    let v: i128 = if neg {
        (mag as i128).wrapping_neg()
    } else {
        mag as i128
    };
    let name = match mt {
        MT::Con(n, a) if a.is_empty() => n.strip_prefix("std::")?,
        _ => return None,
    };
    Some(match name {
        "I8" => Value::I8(v as i8),
        "I16" => Value::I16(v as i16),
        "I32" => Value::I32(v as i32),
        "I64" | "ISize" => Value::I64(v as i64),
        "I128" => Value::I128(if neg { -(mag as i128) } else { mag as i128 }),
        "U8" => Value::U8(mag as u8),
        "U16" => Value::U16(mag as u16),
        "U32" => Value::U32(mag as u32),
        "U64" | "USize" => Value::U64(mag as u64),
        "U128" => Value::U128(mag),
        "F32" | "F16" | "BF16" => Value::F32(v as f32),
        "F64" | "F128" => Value::F64(v as f64),
        _ => return None,
    })
}

pub fn float_value(mt: &MT, x: f64) -> Option<Value> {
    match mt {
        MT::Con(n, _) => match n.as_str() {
            "std::F32" | "std::F16" | "std::BF16" => Some(Value::F32(x as f32)),
            "std::F64" | "std::F128" => Some(Value::F64(x)),
            _ => None,
        },
        _ => None,
    }
}

impl<'a> Mono<'a> {
    pub fn new(env: &'a Env, typed: &'a Typed) -> Self {
        Mono {
            env,
            typed,
            prog: Program::default(),
            instances: HashMap::new(),
            per_binding: HashMap::new(),
            generated: HashMap::new(),
            match_funcs: HashMap::new(),
            work: Vec::new(),
            match_work: Vec::new(),
            matches: index_matches(env),
        }
    }

    // ----- types ---------------------------------------------------------------

    fn mt(&self, t: &Type, s: &Subst) -> MT {
        let table = &self.env.table;
        match table.resolve(t) {
            Type::Var(v) => s.get(&v).cloned().unwrap_or(MT::unit()),
            Type::Con(n, args) => MT::Con(n, args.iter().map(|a| self.mt(a, s)).collect()),
            Type::App(h, args) => {
                let head = self.mt(&h, s);
                let mut rest: Vec<MT> = args.iter().map(|a| self.mt(a, s)).collect();
                match head {
                    MT::Con(n, mut a0) => {
                        a0.append(&mut rest);
                        MT::Con(n, a0)
                    }
                    other => other,
                }
            }
            Type::Fun(a, b, _) => MT::Fun(Box::new(self.mt(&a, s)), Box::new(self.mt(&b, s))),
            Type::Record(r) => {
                let r = table.flatten_row(&r);
                let mut fs: Vec<(String, MT)> = r
                    .fields
                    .iter()
                    .map(|(l, t)| (l.clone(), self.mt(t, s)))
                    .collect();
                if let Some(v) = r.tail {
                    if let Some(MT::Record(more)) = s.get(&v) {
                        fs.extend(more.iter().cloned());
                    }
                }
                MT::sort_fields(&mut fs);
                MT::Record(fs)
            }
            Type::Nat(n) => MT::Nat(n),
        }
    }

    fn node_mt(&self, id: NodeId, s: &Subst) -> MT {
        match self.typed.node_types.get(&id) {
            Some(t) => self.mt(t, s),
            None => MT::unit(),
        }
    }

    /// Record the shapes of named types reachable from `mt`.
    fn register_shapes(&mut self, mt: &MT) {
        match mt {
            MT::Fun(a, b) => {
                self.register_shapes(a);
                self.register_shapes(b);
            }
            MT::Record(fs) => {
                for (_, t) in fs {
                    self.register_shapes(t);
                }
            }
            MT::Nat(_) => {}
            MT::Con(n, args) => {
                if self.prog.shapes.contains_key(mt) {
                    return;
                }
                let Some(def) = self.env.types.get(n) else {
                    return;
                };
                let map: Subst = def
                    .params
                    .iter()
                    .cloned()
                    .zip(args.iter().cloned())
                    .collect();
                let shape = match &def.kind {
                    TypeDefKind::Adt { ctors } => TypeShape::Adt(
                        ctors
                            .iter()
                            .map(|c| {
                                let cd = &self.env.ctors[c];
                                let short = c.rsplit('.').next().unwrap().to_string();
                                (short, cd.fields.iter().map(|f| self.mt(f, &map)).collect())
                            })
                            .collect(),
                    ),
                    TypeDefKind::Record { .. } => {
                        let row = self
                            .env
                            .table
                            .expand_record(n, &args.iter().map(mt_to_type).collect::<Vec<_>>());
                        let fs = row
                            .map(|r| {
                                r.fields
                                    .iter()
                                    .map(|(l, t)| (l.clone(), self.mt(t, &map)))
                                    .collect()
                            })
                            .unwrap_or_default();
                        TypeShape::Record(fs)
                    }
                    _ => TypeShape::Opaque,
                };
                self.prog.shapes.insert(mt.clone(), shape.clone());
                for a in args {
                    self.register_shapes(a);
                }
                match shape {
                    TypeShape::Adt(vs) => {
                        for (_, fs) in vs {
                            for f in fs {
                                self.register_shapes(&f);
                            }
                        }
                    }
                    TypeShape::Record(fs) => {
                        for (_, f) in fs {
                            self.register_shapes(&f);
                        }
                    }
                    TypeShape::Opaque => {}
                }
            }
        }
    }

    // ----- functions -------------------------------------------------------------

    fn new_func(&mut self, name: String, arity: u32, ty: MT, body: Body) -> FuncId {
        self.register_shapes(&ty);
        self.prog.funcs.push(Func {
            name,
            arity,
            nlocals: arity,
            ty,
            body,
        });
        self.prog.funcs.len() - 1
    }

    fn binding_instance(&mut self, idx: usize, key: Vec<MT>, span: Span) -> MResult<FuncId> {
        let b = &self.env.bindings[idx];
        let k = (b.name.clone(), key.clone());
        if let Some(id) = self.instances.get(&k) {
            return Ok(*id);
        }
        let count = self.per_binding.entry(b.name.clone()).or_default();
        *count += 1;
        if *count > 500 {
            return Err(Diagnostic::error(
                span,
                format!(
                    "`{}` is instantiated at too many types (polymorphic recursion is not supported)",
                    display_name(&b.name)
                ),
            ));
        }
        let scheme = self.env.globals[&b.name].scheme.clone().unwrap();
        let s: Subst = b
            .mono_vars
            .iter()
            .cloned()
            .zip(key.iter().cloned())
            .collect();
        let ty = self.mt(&scheme.ty, &s);
        let arity = spine_arity(&self.env.table, &scheme.ty);
        let id = self.new_func(
            display_name(&b.name),
            arity,
            ty,
            Body::Expr(Expr::Const(Value::unit())),
        );
        self.instances.insert(k, id);
        self.work.push((id, idx, s));
        Ok(id)
    }

    fn foreign_instance(&mut self, canon: &str, symbol: &str, ty: MT) -> FuncId {
        let k = (format!("foreign:{}", canon), vec![ty.clone()]);
        if let Some(id) = self.instances.get(&k) {
            return *id;
        }
        let scheme = self.env.globals[canon].scheme.clone().unwrap();
        let arity = spine_arity(&self.env.table, &scheme.ty);
        let (arity, body) = match combinator(symbol) {
            Some((a, e)) => (a, Body::Expr(e)),
            None => (arity, Body::Prim(symbol.to_string())),
        };
        let id = self.new_func(symbol.to_string(), arity, ty, body);
        self.instances.insert(k, id);
        id
    }

    fn ctor_func(&mut self, canon: &str) -> FuncId {
        let k = (format!("ctor:{}", canon), vec![]);
        if let Some(id) = self.instances.get(&k) {
            return *id;
        }
        let cd = &self.env.ctors[canon];
        let arity = cd.fields.len() as u32;
        let tag = cd.tag as u32;
        let id = self.new_func(display_name(canon), arity, MT::unit(), Body::Ctor(tag));
        self.instances.insert(k, id);
        id
    }

    /// A generated helper function, memoized by key.
    fn generated(&mut self, key: String, arity: u32, body: Expr) -> FuncId {
        if let Some(id) = self.generated.get(&key) {
            return *id;
        }
        let id = self.new_func(key.clone(), arity, MT::unit(), Body::Expr(body));
        self.generated.insert(key, id);
        id
    }

    /// Resolve a trait method at concrete trait arguments.
    fn method_instance(
        &mut self,
        trait_name: &str,
        method: &str,
        targs: &[MT],
        own: &[MT],
        span: Span,
    ) -> MResult<FuncId> {
        for imp in &self.env.impls {
            if imp.trait_name != trait_name {
                continue;
            }
            let mut sub: Subst = HashMap::new();
            if imp
                .head
                .iter()
                .zip(targs)
                .all(|(h, t)| match_mt(&self.env.table, h, t, &imp.vars, &mut sub))
            {
                let idx = imp.methods[method];
                let mut key: Vec<MT> = imp
                    .vars
                    .iter()
                    .map(|v| sub.get(v).cloned().unwrap_or(MT::unit()))
                    .collect();
                key.extend(own.iter().cloned());
                return self.binding_instance(idx, key, span);
            }
        }
        let args: Vec<String> = targs.iter().map(|t| t.to_string()).collect();
        Err(Diagnostic::error(
            span,
            format!(
                "no implementation of `{}[{}]` (needed by `{}`)",
                display_name(trait_name),
                args.join(", "),
                display_name(method)
            ),
        ))
    }

    fn literal_via_trait(
        &mut self,
        trait_name: &str,
        method: &str,
        mt: &MT,
        arg: Value,
        span: Span,
    ) -> MResult<Expr> {
        let f = self.method_instance(trait_name, method, std::slice::from_ref(mt), &[], span)?;
        Ok(self.mk_apply(Expr::Func(f), vec![Expr::Const(arg)]))
    }

    // ----- application -----------------------------------------------------------

    pub fn mk_apply(&self, f: Expr, args: Vec<Expr>) -> Expr {
        if args.is_empty() {
            return f;
        }
        match f {
            Expr::Func(id) => {
                let func = &self.prog.funcs[id];
                let ar = func.arity as usize;
                if ar == 0 {
                    return Expr::Apply(Box::new(Expr::Func(id)), args);
                }
                if args.len() == ar {
                    if let Body::Ctor(tag) = func.body {
                        return Expr::Construct(tag, args);
                    }
                    Expr::Call(id, args)
                } else if args.len() > ar {
                    let mut args = args;
                    let rest = args.split_off(ar);
                    let call = self.mk_apply(Expr::Func(id), args);
                    self.mk_apply(call, rest)
                } else {
                    Expr::Apply(Box::new(Expr::Func(id)), args)
                }
            }
            Expr::Apply(g, mut a1) => {
                if let Expr::Func(id) = *g {
                    if (a1.len() as u32) < self.prog.funcs[id].arity {
                        a1.extend(args);
                        return self.mk_apply(Expr::Func(id), a1);
                    }
                }
                a1.extend(args);
                Expr::Apply(g, a1)
            }
            other => Expr::Apply(Box::new(other), args),
        }
    }

    // ----- driver ----------------------------------------------------------------

    pub fn run(mut self, roots: Roots) -> MResult<Program> {
        let env = self.env;
        for (i, b) in env.bindings.iter().enumerate() {
            if b.module != "main" && b.module != "std" {
                continue;
            }
            let root = if b.module == "std" {
                roots.std_tests && b.test_name.is_some()
            } else if b.name == "main::main" {
                roots.main
            } else if b.test_name.is_some() {
                roots.tests
            } else {
                roots.exports && env.globals[&b.name].exported
            };
            if !root {
                continue;
            }
            let scheme = env.globals[&b.name].scheme.clone().unwrap();
            if roots.exports
                && !scheme.vars.is_empty()
                && b.test_name.is_none()
                && b.name != "main::main"
            {
                return Err(Diagnostic::error(
                    b.span,
                    format!(
                        "exported `{}` must have a monomorphic type",
                        display_name(&b.name)
                    ),
                ));
            }
            let key = vec![MT::unit(); b.mono_vars.len()];
            let id = self.binding_instance(i, key, b.span)?;
            if b.name == "main::main" {
                self.prog.main = Some(id);
            } else if let Some(t) = &b.test_name {
                self.prog.tests.push((t.clone(), id));
            } else {
                self.prog.exports.push((display_name(&b.name), id));
            }
        }
        self.drain()?;
        Ok(self.prog)
    }

    fn drain(&mut self) -> MResult<()> {
        loop {
            if let Some((id, idx, s)) = self.work.pop() {
                let b = &self.env.bindings[idx];
                let arity = self.prog.funcs[id].arity;
                let mut fb = FB { nlocals: arity };
                let e = self.expr(&b.body, &s, &mut fb)?;
                let args = (0..arity).map(Expr::Local).collect();
                let body = self.mk_apply(e, args);
                let f = &mut self.prog.funcs[id];
                f.body = Body::Expr(body);
                f.nlocals = fb.nlocals;
                continue;
            }
            if let Some((id, node, s)) = self.match_work.pop() {
                self.lower_match(id, node, &s)?;
                continue;
            }
            return Ok(());
        }
    }

    // ----- expressions -----------------------------------------------------------

    #[allow(clippy::only_used_in_recursion)]
    fn expr(&mut self, e: &ast::Expr, s: &Subst, fb: &mut FB) -> MResult<Expr> {
        match &e.kind {
            ExprKind::Int { neg, mag, .. } => {
                let mt = self.node_mt(e.id, s);
                match int_value(&mt, *neg, *mag) {
                    Some(v) => Ok(Expr::Const(v)),
                    None => {
                        let v = Value::I64(if *neg {
                            (*mag as i64).wrapping_neg()
                        } else {
                            *mag as i64
                        });
                        self.literal_via_trait("std::FromInt", "std::from-int", &mt, v, e.span)
                    }
                }
            }
            ExprKind::Float { value, .. } => {
                let mt = self.node_mt(e.id, s);
                match float_value(&mt, *value) {
                    Some(v) => Ok(Expr::Const(v)),
                    None => self.literal_via_trait(
                        "std::FromFloat",
                        "std::from-float",
                        &mt,
                        Value::F64(*value),
                        e.span,
                    ),
                }
            }
            ExprKind::Str(x) => Ok(Expr::Const(Value::str(x))),
            ExprKind::Trits(ts) => Ok(Expr::Const(Value::TInt(trits_value(ts)))),
            ExprKind::Duration(ns) => Ok(Expr::Const(Value::tuple(vec![Value::I64(*ns as i64)]))),
            ExprKind::Var(_) => self.var(e, s),
            ExprKind::Ctor(_) => {
                let inst = &self.typed.insts[&e.id];
                let id = self.ctor_func(&inst.target.clone());
                if self.prog.funcs[id].arity == 0 {
                    if let Body::Ctor(tag) = self.prog.funcs[id].body {
                        return Ok(Expr::Construct(tag, vec![]));
                    }
                }
                Ok(Expr::Func(id))
            }
            ExprKind::Selector(path) => {
                let mt = self.node_mt(e.id, s);
                let mut cur = match &mt {
                    MT::Fun(a, _) => (**a).clone(),
                    _ => MT::unit(),
                };
                let mut idxs = Vec::new();
                for seg in path {
                    let idx = record_index(&self.prog, &cur, seg).ok_or_else(|| {
                        Diagnostic::error(
                            e.span,
                            format!("internal: no field `{}` in {}", seg, cur),
                        )
                    })?;
                    idxs.push(idx);
                    cur = field_type(&self.prog, &cur, idx);
                }
                let mut body = Expr::Local(0);
                for i in &idxs {
                    body = Expr::Field(Box::new(body), *i);
                }
                Ok(Expr::Func(self.generated(
                    format!("select{:?}", idxs),
                    1,
                    body,
                )))
            }
            ExprKind::App(f, args) => {
                let fe = self.expr(f, s, fb)?;
                let mut xs = Vec::new();
                for a in args {
                    xs.push(self.expr(a, s, fb)?);
                }
                Ok(self.mk_apply(fe, xs))
            }
            ExprKind::Pipe(l, r) => {
                let le = self.expr(l, s, fb)?;
                let re = self.expr(r, s, fb)?;
                match self.typed.pipe_modes.get(&e.id) {
                    Some(PipeMode::Compose) => {
                        let compose = self.generated(
                            "compose".into(),
                            3,
                            Expr::Apply(
                                Box::new(Expr::Local(1)),
                                vec![Expr::Apply(Box::new(Expr::Local(0)), vec![Expr::Local(2)])],
                            ),
                        );
                        Ok(self.mk_apply(Expr::Func(compose), vec![le, re]))
                    }
                    _ => Ok(self.mk_apply(re, vec![le])),
                }
            }
            ExprKind::Unit => Ok(Expr::Const(Value::unit())),
            ExprKind::Tuple(items) => {
                let mut xs = Vec::new();
                for i in items {
                    xs.push(self.expr(i, s, fb)?);
                }
                Ok(Expr::Record(xs))
            }
            ExprKind::List(items) => {
                let mut acc = Expr::Construct(0, vec![]);
                for i in items.iter().rev() {
                    let x = self.expr(i, s, fb)?;
                    acc = Expr::Construct(1, vec![x, acc]);
                }
                Ok(acc)
            }
            ExprKind::Record(fields) | ExprKind::NominalRecord(_, fields) => {
                let mut fs = Vec::new();
                for (n, x) in fields {
                    fs.push((n.clone(), self.expr(x, s, fb)?));
                }
                fs.sort_by(|a, b| label_cmp(&a.0, &b.0));
                Ok(Expr::Record(fs.into_iter().map(|(_, x)| x).collect()))
            }
            ExprKind::With(fields) => {
                let mt = self.node_mt(e.id, s);
                let rec = mt.as_fun().map(|(a, _)| a.clone()).unwrap_or(MT::unit());
                let k = fields.len() as u32;
                let mut idxs = Vec::new();
                let mut vals = Vec::new();
                for (n, x) in fields {
                    idxs.push(record_index(&self.prog, &rec, n).unwrap_or(0));
                    vals.push(self.expr(x, s, fb)?);
                }
                let body = Expr::SetFields(
                    Box::new(Expr::Local(k)),
                    idxs.iter()
                        .enumerate()
                        .map(|(i, idx)| (*idx, Expr::Local(i as u32)))
                        .collect(),
                );
                let f = self.generated(format!("with{:?}", idxs), k + 1, body);
                Ok(self.mk_apply(Expr::Func(f), vals))
            }
            ExprKind::Make(_, fields) => {
                let mt = self.node_mt(e.id, s);
                let out = mt.as_fun().map(|(_, b)| b.clone()).unwrap_or(MT::unit());
                let k = fields.len() as u32;
                let labels = record_labels(&self.prog, &out);
                let mut order = Vec::new();
                for l in &labels {
                    order.push(fields.iter().position(|(n, _)| n == l).unwrap_or(0) as u32);
                }
                let mut vals = Vec::new();
                for (_, x) in fields {
                    vals.push(self.expr(x, s, fb)?);
                }
                let body = Expr::Record(
                    order
                        .iter()
                        .map(|i| Expr::Apply(Box::new(Expr::Local(*i)), vec![Expr::Local(k)]))
                        .collect(),
                );
                let f = self.generated(format!("make{:?}", order), k + 1, body);
                Ok(self.mk_apply(Expr::Func(f), vals))
            }
            ExprKind::Update(fields) => {
                let mt = self.node_mt(e.id, s);
                let rec = mt.as_fun().map(|(a, _)| a.clone()).unwrap_or(MT::unit());
                let k = fields.len() as u32;
                let mut idxs = Vec::new();
                let mut vals = Vec::new();
                for (n, x) in fields {
                    idxs.push(record_index(&self.prog, &rec, n).unwrap_or(0));
                    vals.push(self.expr(x, s, fb)?);
                }
                let body = Expr::SetFields(
                    Box::new(Expr::Local(k)),
                    idxs.iter()
                        .enumerate()
                        .map(|(i, idx)| {
                            (
                                *idx,
                                Expr::Apply(
                                    Box::new(Expr::Local(i as u32)),
                                    vec![Expr::Field(Box::new(Expr::Local(k)), *idx)],
                                ),
                            )
                        })
                        .collect(),
                );
                let f = self.generated(format!("update{:?}", idxs), k + 1, body);
                Ok(self.mk_apply(Expr::Func(f), vals))
            }
            ExprKind::Match(_) => {
                let mut key: Vec<(TV, MT)> = s.iter().map(|(k, v)| (*k, v.clone())).collect();
                key.sort();
                if let Some(id) = self.match_funcs.get(&(e.id, key.clone())) {
                    return Ok(Expr::Func(*id));
                }
                let mt = self.node_mt(e.id, s);
                let id = self.new_func(
                    "match".into(),
                    1,
                    mt,
                    Body::Expr(Expr::Const(Value::unit())),
                );
                self.match_funcs.insert((e.id, key), id);
                self.match_work.push((id, e.id, s.clone()));
                Ok(Expr::Func(id))
            }
            ExprKind::Comptime(x) => self.expr(x, s, fb),
            ExprKind::Quote(_) | ExprKind::TypeOf(_) | ExprKind::MacroCall(..) => {
                Err(Diagnostic::error(
                    e.span,
                    "quotation, reflection and macros are not supported by this backend yet",
                ))
            }
        }
    }

    fn var(&mut self, e: &ast::Expr, s: &Subst) -> MResult<Expr> {
        let inst = self.typed.insts[&e.id].clone();
        let types: Vec<MT> = inst.types.iter().map(|t| self.mt(t, s)).collect();
        let g = &self.env.globals[&inst.target];
        match &g.kind {
            GlobalKind::Binding(idx) => {
                let idx = *idx;
                let key = if inst.types.is_empty() {
                    // reference within a recursive group: same type variables
                    self.env.bindings[idx]
                        .mono_vars
                        .iter()
                        .map(|v| self.mt(&Type::Var(*v), s))
                        .collect()
                } else {
                    types
                };
                Ok(Expr::Func(self.binding_instance(idx, key, e.span)?))
            }
            GlobalKind::Foreign { symbol, .. } => {
                let mt = self.node_mt(e.id, s);
                let id = self.foreign_instance(&inst.target, symbol, mt);
                if self.prog.funcs[id].arity == 0 {
                    return Ok(Expr::Call(id, vec![]));
                }
                Ok(Expr::Func(id))
            }
            GlobalKind::Method { trait_name } => {
                let ntrait = self.env.traits[trait_name].params.len();
                let (targs, own) = types.split_at(ntrait.min(types.len()));
                let id = self.method_instance(trait_name, &inst.target, targs, own, e.span)?;
                Ok(Expr::Func(id))
            }
        }
    }

    fn lower_match(&mut self, id: FuncId, node: NodeId, s: &Subst) -> MResult<()> {
        let e = self.matches[&node];
        let ExprKind::Match(arms) = &e.kind else {
            unreachable!()
        };
        let mt = self.node_mt(node, s);
        let scrut = mt.as_fun().map(|(a, _)| a.clone()).unwrap_or(MT::unit());
        let mut fb = FB { nlocals: 1 };
        let mut out = Vec::new();
        for arm in arms {
            let mut holes = Vec::new();
            let pat = self.pattern(&arm.pat, &scrut, &mut fb, &mut holes)?;
            let body = self.expr(&arm.body, s, &mut fb)?;
            let body = self.mk_apply(body, holes.into_iter().map(Expr::Local).collect());
            out.push((pat, body));
        }
        let f = &mut self.prog.funcs[id];
        f.body = Body::Expr(Expr::Match(Box::new(Expr::Local(0)), out));
        f.nlocals = fb.nlocals;
        Ok(())
    }

    fn pattern(
        &mut self,
        p: &ast::Pattern,
        mt: &MT,
        fb: &mut FB,
        holes: &mut Vec<Local>,
    ) -> MResult<Pat> {
        match &p.kind {
            PatKind::Hole => {
                let l = fb.local();
                holes.push(l);
                Ok(Pat::Bind(l))
            }
            PatKind::Int { neg, mag } => match int_value(mt, *neg, *mag) {
                Some(v) => Ok(Pat::Lit(v)),
                None => Err(Diagnostic::error(
                    p.span,
                    format!(
                        "integer patterns need a primitive numeric type, not `{}`",
                        mt
                    ),
                )),
            },
            PatKind::Str(x) => Ok(Pat::Lit(Value::str(x))),
            PatKind::Unit => Ok(Pat::Wild),
            PatKind::Tuple(items) => {
                let mut ps = Vec::new();
                for (i, item) in items.iter().enumerate() {
                    let ft = field_type(&self.prog, mt, i as u32);
                    ps.push(self.pattern(item, &ft, fb, holes)?);
                }
                Ok(Pat::Record(ps))
            }
            PatKind::Ctor(name, args) => {
                let canon = self.resolve_pattern_ctor(p, name)?;
                let cd = &self.env.ctors[&canon];
                let tag = cd.tag as u32;
                let def = &self.env.types[&cd.type_name];
                let targs = match mt {
                    MT::Con(_, a) => a.clone(),
                    _ => vec![],
                };
                let map: Subst = def.params.iter().cloned().zip(targs).collect();
                let ftypes: Vec<MT> = cd.fields.iter().map(|f| self.mt(f, &map)).collect();
                let mut ps = Vec::new();
                match args {
                    None => {
                        for _ in &ftypes {
                            let l = fb.local();
                            holes.push(l);
                            ps.push(Pat::Bind(l));
                        }
                    }
                    Some(args) => {
                        for (a, ft) in args.iter().zip(&ftypes) {
                            ps.push(self.pattern(a, ft, fb, holes)?);
                        }
                    }
                }
                Ok(Pat::Construct(tag, ps))
            }
        }
    }

    fn resolve_pattern_ctor(&self, p: &ast::Pattern, name: &str) -> MResult<String> {
        self.typed
            .pattern_ctors
            .get(&(p.span.file, p.span.line, p.span.col))
            .cloned()
            .ok_or_else(|| Diagnostic::error(p.span, format!("unknown constructor `{}`", name)))
    }
}

fn mt_to_type(mt: &MT) -> Type {
    match mt {
        MT::Con(n, args) => Type::Con(n.clone(), args.iter().map(mt_to_type).collect()),
        MT::Fun(a, b) => Type::fun(mt_to_type(a), mt_to_type(b), Row::empty()),
        MT::Record(fs) => Type::Record(Row::closed(
            fs.iter().map(|(l, t)| (l.clone(), mt_to_type(t))).collect(),
        )),
        MT::Nat(n) => Type::Nat(*n),
    }
}

/// Match an impl head (with impl variables) against a concrete type.
fn match_mt(table: &TypeTable, pat: &Type, target: &MT, vars: &[TV], sub: &mut Subst) -> bool {
    match table.resolve(pat) {
        Type::Var(v) if vars.contains(&v) => match sub.get(&v) {
            Some(prev) => prev == target,
            None => {
                sub.insert(v, target.clone());
                true
            }
        },
        Type::Var(_) => false,
        Type::Con(n, args) => match target {
            MT::Con(m, targs) if n == *m && args.len() == targs.len() => args
                .iter()
                .zip(targs)
                .all(|(a, t)| match_mt(table, a, t, vars, sub)),
            _ => false,
        },
        Type::App(h, args) => match target {
            MT::Con(m, targs) if targs.len() >= args.len() => {
                let k = targs.len() - args.len();
                match_mt(
                    table,
                    &h,
                    &MT::Con(m.clone(), targs[..k].to_vec()),
                    vars,
                    sub,
                ) && args
                    .iter()
                    .zip(&targs[k..])
                    .all(|(a, t)| match_mt(table, a, t, vars, sub))
            }
            _ => false,
        },
        Type::Fun(a, b, _) => match target {
            MT::Fun(ta, tb) => {
                match_mt(table, &a, ta, vars, sub) && match_mt(table, &b, tb, vars, sub)
            }
            _ => false,
        },
        Type::Record(r) => match target {
            MT::Record(fs) => {
                let r = table.flatten_row(&r);
                r.fields.len() == fs.len()
                    && r.fields
                        .iter()
                        .zip(fs)
                        .all(|((l1, a), (l2, t))| l1 == l2 && match_mt(table, a, t, vars, sub))
            }
            _ => false,
        },
        Type::Nat(n) => matches!(target, MT::Nat(m) if n == *m),
    }
}

/// Field labels of a record type (structural or nominal).
fn record_labels(prog: &Program, mt: &MT) -> Vec<String> {
    match mt {
        MT::Record(fs) => fs.iter().map(|(l, _)| l.clone()).collect(),
        MT::Con(..) => match prog.shapes.get(mt) {
            Some(TypeShape::Record(fs)) => fs.iter().map(|(l, _)| l.clone()).collect(),
            _ => vec![],
        },
        _ => vec![],
    }
}

fn record_index(prog: &Program, mt: &MT, label: &str) -> Option<u32> {
    record_labels(prog, mt)
        .iter()
        .position(|l| l == label)
        .map(|i| i as u32)
}

fn field_type(prog: &Program, mt: &MT, idx: u32) -> MT {
    match mt {
        MT::Record(fs) => fs
            .get(idx as usize)
            .map(|f| f.1.clone())
            .unwrap_or(MT::unit()),
        MT::Con(..) => match prog.shapes.get(mt) {
            Some(TypeShape::Record(fs)) => fs
                .get(idx as usize)
                .map(|f| f.1.clone())
                .unwrap_or(MT::unit()),
            _ => MT::unit(),
        },
        _ => MT::unit(),
    }
}

/// Index all `match` nodes of the program by id.
fn index_matches(env: &Env) -> HashMap<NodeId, &ast::Expr> {
    fn go<'e>(e: &'e ast::Expr, out: &mut HashMap<NodeId, &'e ast::Expr>) {
        match &e.kind {
            ExprKind::App(f, args) => {
                go(f, out);
                args.iter().for_each(|a| go(a, out));
            }
            ExprKind::Pipe(a, b) => {
                go(a, out);
                go(b, out);
            }
            ExprKind::Tuple(xs) | ExprKind::List(xs) | ExprKind::MacroCall(_, xs) => {
                xs.iter().for_each(|a| go(a, out))
            }
            ExprKind::Record(fs)
            | ExprKind::NominalRecord(_, fs)
            | ExprKind::With(fs)
            | ExprKind::Make(_, fs)
            | ExprKind::Update(fs) => fs.iter().for_each(|(_, a)| go(a, out)),
            ExprKind::Match(arms) => {
                out.insert(e.id, e);
                arms.iter().for_each(|a| go(&a.body, out));
            }
            ExprKind::Comptime(x) | ExprKind::Quote(x) => go(x, out),
            _ => {}
        }
    }
    let mut out = HashMap::new();
    for b in &env.bindings {
        go(&b.body, &mut out);
    }
    out
}

/// Lower a checked program to IR.
pub fn lower(env: &Env, typed: &Typed, roots: Roots) -> MResult<Program> {
    Mono::new(env, typed).run(roots)
}
