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
#[derive(Clone, Debug, Default)]
pub struct Roots {
    pub main: bool,
    pub tests: bool,
    pub exports: bool,
    /// Run the standard library's own tests.
    pub std_tests: bool,
    /// Bindings to compile by canonical name (used for macros).
    pub names: Vec<String>,
    /// Serve the exported functions of this module (`fwp serve`, the
    /// service executables of a split build).
    pub service: Option<String>,
    /// Modules deployed as separate services, with their default
    /// addresses. A call from another module to one of their exported
    /// functions becomes a remote call.
    pub remote: Vec<(String, String)>,
    /// A binding of the main module (canonical name) compiled as the
    /// program's entry point instead of `main` (the generated `main` of a
    /// REST server).
    pub entry: Option<String>,
}

/// The address a service listens on, and its clients call, when nothing
/// else is configured.
pub const DEFAULT_SERVICE_ADDR: &str = "127.0.0.1:50051";

pub struct Mono<'a> {
    env: &'a Env,
    typed: &'a Typed,
    pub prog: Program,
    instances: HashMap<(String, Vec<MT>), FuncId>,
    per_binding: HashMap<String, usize>,
    generated: HashMap<String, FuncId>,
    match_funcs: HashMap<(NodeId, Vec<(TV, MT)>), FuncId>,
    work: Vec<(FuncId, usize, Subst)>,
    match_work: Vec<(FuncId, NodeId, Subst, String)>,
    matches: HashMap<NodeId, &'a ast::Expr>,
    /// Module of the code being lowered (for hygienic quotes).
    cur_module: String,
    /// Functions whose bodies are being lowered right now.
    in_progress: std::collections::HashSet<FuncId>,
    /// Modules deployed as separate services (`Roots::remote`).
    remote: Vec<(String, String)>,
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

/// A binding's name within its module (`inventory::item` is `item`).
fn local_name(canon: &str) -> String {
    canon
        .split_once("::")
        .map(|(_, n)| n)
        .unwrap_or(canon)
        .to_string()
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

/// An integer literal at a primitive type, checked against its range (also
/// for literals in generic code, which are only known here).
fn checked_int_value(mt: &MT, neg: bool, mag: u128) -> Result<Option<Value>, String> {
    if let MT::Con(n, a) = mt {
        if let Some(name) = n.strip_prefix("std::") {
            let is_int = a.is_empty()
                && matches!(
                    name,
                    "I8" | "I16"
                        | "I32"
                        | "I64"
                        | "I128"
                        | "ISize"
                        | "U8"
                        | "U16"
                        | "U32"
                        | "U64"
                        | "U128"
                        | "USize"
                );
            if is_int {
                crate::infer::check_int_range(name, neg, mag)?;
            }
        }
    }
    Ok(int_value(mt, neg, mag))
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
        "I128" => Value::I128(v),
        "U8" => Value::U8(mag as u8),
        "U16" => Value::U16(mag as u16),
        "U32" => Value::U32(mag as u32),
        "U64" | "USize" => Value::U64(mag as u64),
        "U128" => Value::U128(mag),
        // from the magnitude, which may be 2^127 or more (one rounding)
        // (an integer zero has no sign)
        "F32" | "F16" | "BF16" => Value::F32(if neg && mag != 0 {
            -(mag as f32)
        } else {
            mag as f32
        }),
        "F64" | "F128" => Value::F64(if neg && mag != 0 {
            -(mag as f64)
        } else {
            mag as f64
        }),
        _ => return None,
    })
}

pub fn float_value(mt: &MT, x: f64, x32: f32) -> Option<Value> {
    match mt {
        MT::Con(n, _) => match n.as_str() {
            "std::F32" | "std::F16" | "std::BF16" => Some(Value::F32(x32)),
            "std::F64" | "std::F128" => Some(Value::F64(x)),
            _ => None,
        },
        _ => None,
    }
}

impl<'a> Mono<'a> {
    pub fn new(env: &'a Env, typed: &'a Typed) -> Self {
        let mut prog = Program::default();
        for (name, td) in &env.types {
            if let crate::env::TypeDefKind::Record { fields } = &td.kind {
                if td.repr_c {
                    prog.repr_c.insert(name.clone(), fields.clone());
                }
                prog.field_order.insert(name.clone(), fields.clone());
            }
        }
        Mono {
            env,
            typed,
            prog,
            instances: HashMap::new(),
            per_binding: HashMap::new(),
            generated: HashMap::new(),
            match_funcs: HashMap::new(),
            work: Vec::new(),
            match_work: Vec::new(),
            matches: index_matches(env),
            cur_module: "main".into(),
            in_progress: Default::default(),
            remote: Vec::new(),
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
        // the error a primitive raises (`IoError`) is displayed and
        // encoded by its shape
        if let Some(e) = self.error_effect(&scheme.ty) {
            if matches!(&e, MT::Con(_, args) if args.is_empty()) {
                self.register_shapes(&e);
            }
        }
        let id = self.new_func(symbol.to_string(), arity, ty, body);
        self.instances.insert(k, id);
        id
    }

    /// A `foreign "C"` function at a monomorphic type.
    fn c_instance(&mut self, canon: &str, symbol: &str, variadic: Option<u32>, ty: MT) -> FuncId {
        let k = (format!("cforeign:{}", canon), vec![ty.clone()]);
        if let Some(id) = self.instances.get(&k) {
            return *id;
        }
        self.register_shapes(&ty);
        let scheme = self.env.globals[canon].scheme.clone().unwrap();
        let arity = spine_arity(&self.env.table, &scheme.ty);
        let body = Body::ForeignC {
            symbol: symbol.to_string(),
            variadic,
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
        self.remote = roots.remote.clone();
        for (m, _) in &roots.remote {
            if !env.modules.contains_key(m) || m == "main" || m == "std" {
                return Err(Diagnostic::error(
                    Span::default(),
                    format!("`{}` is not an imported module", m),
                ));
            }
        }
        if let Some(module) = &roots.service {
            self.service_roots(module)?;
        }
        for name in &roots.names {
            if let Some(GlobalKind::Binding(i)) = env.globals.get(name).map(|g| &g.kind) {
                let b = &env.bindings[*i];
                // macros are functions of syntax: free type variables are
                // syntax too
                let key = vec![MT::con("std::Syntax"); b.mono_vars.len()];
                let id = self.binding_instance(*i, key, b.span)?;
                self.prog.named.push((name.clone(), id));
            }
        }
        for (i, b) in env.bindings.iter().enumerate() {
            if b.module != "main" && b.module != "std" {
                continue;
            }
            let root = if b.module == "std" {
                roots.std_tests && b.test_name.is_some()
            } else if roots.entry.as_deref() == Some(b.name.as_str()) {
                true
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
            let is_entry = roots.entry.as_deref() == Some(b.name.as_str());
            if roots.exports
                && !scheme.vars.is_empty()
                && b.test_name.is_none()
                && b.name != "main::main"
                && !is_entry
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
            if b.name == "main::main" || is_entry {
                self.prog.main = Some(id);
            } else if let Some(t) = &b.test_name {
                self.prog.tests.push((t.clone(), id));
            } else {
                let error = self.error_effect(&scheme.ty);
                if let Some(e) = &error {
                    self.register_shapes(e);
                }
                let labels = self.effect_labels(&scheme.ty);
                self.prog
                    .export_effects
                    .insert(display_name(&b.name), (error, labels));
                self.prog.exports.push((display_name(&b.name), id));
            }
        }
        self.drain()?;
        Ok(self.prog)
    }

    /// The `Error[E]` type of a function's final arrow, if any.
    fn error_effect(&self, t: &Type) -> Option<MT> {
        let table = &self.env.table;
        let mut t = table.resolve(t);
        let mut last = None;
        while let Type::Fun(_, r, row) = t {
            last = Some(row);
            t = table.resolve(&r);
        }
        let row = table.flatten_row(&last?);
        row.fields
            .iter()
            .find(|(l, _)| l == "Error" || l.ends_with("::Error"))
            .map(|(_, t)| self.mt(t, &Subst::new()))
    }

    /// The effects of a function's final arrow, by name (`IO`, `Error`).
    fn effect_labels(&self, t: &Type) -> Vec<String> {
        let table = &self.env.table;
        let mut t = table.resolve(t);
        let mut last = None;
        while let Type::Fun(_, r, row) = t {
            last = Some(row);
            t = table.resolve(&r);
        }
        let Some(row) = last else {
            return vec![];
        };
        table
            .flatten_row(&row)
            .fields
            .iter()
            .map(|(l, _)| display_name(l))
            .collect()
    }

    fn default_addr(&self, module: &str) -> String {
        self.remote
            .iter()
            .find(|(m, _)| m == module)
            .map(|(_, a)| a.clone())
            .unwrap_or_else(|| DEFAULT_SERVICE_ADDR.to_string())
    }

    /// The scheme of an exported binding served by its module, checked to
    /// be callable remotely: monomorphic, a function, and made of types
    /// that can be encoded. `None` for constants, which stay local.
    fn service_signature(&mut self, idx: usize) -> MResult<Option<(MT, u32, Option<MT>)>> {
        let b = &self.env.bindings[idx];
        let scheme = self.env.globals[&b.name].scheme.clone().unwrap();
        let arity = spine_arity(&self.env.table, &scheme.ty);
        if arity == 0 {
            return Ok(None);
        }
        let name = local_name(&b.name);
        if !scheme.vars.is_empty() || !scheme.preds.is_empty() {
            return Err(Diagnostic::error(
                b.span,
                format!(
                    "`{}` is served by module `{}` and must have a monomorphic type",
                    name, b.module
                ),
            ));
        }
        let ty = self.mt(&scheme.ty, &Subst::new());
        let error = self.error_effect(&scheme.ty);
        self.register_shapes(&ty);
        if let Some(e) = &error {
            self.register_shapes(e);
        }
        let shape = crate::rpc::shape(&ty, arity as usize, error.as_ref());
        for t in shape.wire_types(error.as_ref()) {
            if let Err(m) = crate::protobuf::check_encodable(&self.prog, &t) {
                return Err(Diagnostic::error(
                    b.span,
                    format!("`{}` is served by module `{}`, but {}", name, b.module, m),
                ));
            }
        }
        Ok(Some((ty, arity, error)))
    }

    /// `std::grpc._iter` at element type `t`: received messages as a lazy
    /// `Iterator[t]`.
    fn grpc_iter(&mut self, t: &MT, span: Span) -> MResult<FuncId> {
        let Some(GlobalKind::Binding(i)) = self.env.globals.get("std::grpc._iter").map(|g| &g.kind)
        else {
            return Err(Diagnostic::error(span, "internal: `grpc._iter` is missing"));
        };
        let i = *i;
        let n = self.env.bindings[i].mono_vars.len();
        let saved = std::mem::replace(&mut self.cur_module, "std".to_string());
        let r = self.binding_instance(i, vec![t.clone(); n], span);
        self.cur_module = saved;
        r
    }

    /// Root the exported functions of a module served as a service.
    fn service_roots(&mut self, module: &str) -> MResult<()> {
        if !self.env.modules.contains_key(module) || module == "std" {
            return Err(Diagnostic::error(
                Span::default(),
                format!("`{}` is not an imported module", module),
            ));
        }
        let mut def = crate::ir::ServiceDef {
            module: module.to_string(),
            methods: Vec::new(),
            default_addr: self.default_addr(module),
            root: false,
        };
        let env = self.env;
        for (i, b) in env.bindings.iter().enumerate() {
            if b.module != module || b.test_name.is_some() || !env.globals[&b.name].exported {
                continue;
            }
            let Some((ty, arity, error)) = self.service_signature(i)? else {
                continue;
            };
            let saved = std::mem::replace(&mut self.cur_module, module.to_string());
            let id = self.binding_instance(i, vec![MT::unit(); b.mono_vars.len()], b.span);
            self.cur_module = saved;
            let shape = crate::rpc::shape(&ty, arity as usize, error.as_ref());
            let iter_fn = match shape.iter_elem(true) {
                Some(t) => Some(self.grpc_iter(t, b.span)?),
                None => None,
            };
            let name = local_name(&b.name);
            def.methods.push(crate::ir::ServedFn {
                path: crate::protobuf::path(module, &name),
                name,
                func: id?,
                error,
                iter_fn,
            });
        }
        if def.methods.is_empty() {
            return Err(Diagnostic::error(
                Span::default(),
                format!("module `{}` exports no functions to serve", module),
            ));
        }
        self.prog.service = Some(def);
        Ok(())
    }

    /// A call from another module to an exported function of a module
    /// deployed as a separate service becomes a client stub.
    fn remote_stub(&mut self, idx: usize) -> MResult<Option<FuncId>> {
        let b = &self.env.bindings[idx];
        if b.module == self.cur_module
            || b.test_name.is_some()
            || !self.env.globals[&b.name].exported
            || !self.remote.iter().any(|(m, _)| *m == b.module)
        {
            return Ok(None);
        }
        let key = (format!("remote:{}", b.name), vec![]);
        if let Some(id) = self.instances.get(&key) {
            return Ok(Some(*id));
        }
        let (module, name) = (b.module.clone(), display_name(&b.name));
        let method = local_name(&b.name);
        let Some((ty, arity, error)) = self.service_signature(idx)? else {
            return Ok(None);
        };
        let shape = crate::rpc::shape(&ty, arity as usize, error.as_ref());
        let iter_fn = match shape.iter_elem(false) {
            Some(t) => Some(self.grpc_iter(t, b.span)?),
            None => None,
        };
        let body = Body::Remote(Box::new(crate::ir::RemoteFn {
            default_addr: self.default_addr(&module),
            path: crate::protobuf::path(&module, &method),
            module,
            method,
            error,
            iter_fn,
        }));
        let id = self.new_func(name, arity, ty, body);
        self.instances.insert(key, id);
        Ok(Some(id))
    }

    fn drain(&mut self) -> MResult<()> {
        loop {
            if let Some((id, idx, s)) = self.work.pop() {
                let b = &self.env.bindings[idx];
                let saved = std::mem::replace(&mut self.cur_module, b.module.clone());
                self.in_progress.insert(id);
                let arity = self.prog.funcs[id].arity;
                let mut fb = FB { nlocals: arity };
                let e = self.expr(&b.body, &s, &mut fb)?;
                let args = (0..arity).map(Expr::Local).collect();
                let body = self.mk_apply(e, args);
                let f = &mut self.prog.funcs[id];
                f.body = Body::Expr(body);
                f.nlocals = fb.nlocals;
                self.in_progress.remove(&id);
                self.cur_module = saved;
                continue;
            }
            if let Some((id, node, s, module)) = self.match_work.pop() {
                let saved = std::mem::replace(&mut self.cur_module, module);
                self.in_progress.insert(id);
                self.lower_match(id, node, &s)?;
                self.in_progress.remove(&id);
                self.cur_module = saved;
                continue;
            }
            return Ok(());
        }
    }

    /// Evaluate `x` at compile time and return its value as a constant.
    fn comptime(&mut self, e: &ast::Expr, x: &ast::Expr, s: &Subst) -> MResult<Expr> {
        let mt = self.node_mt(e.id, s);
        let mut fb = FB { nlocals: 0 };
        let body = self.expr(x, s, &mut fb)?;
        let tmp = self.new_func("comptime".into(), 0, mt, Body::Expr(body));
        self.prog.funcs[tmp].nlocals = fb.nlocals;
        self.drain()?;
        // the expression must not depend on code that is still being lowered
        let mut seen = std::collections::HashSet::new();
        let mut stack = vec![tmp];
        while let Some(f) = stack.pop() {
            if !seen.insert(f) {
                continue;
            }
            if self.in_progress.contains(&f) {
                return Err(Diagnostic::error(
                    e.span,
                    format!(
                        "`comptime` expression depends on `{}`, which is still being compiled",
                        self.prog.funcs[f].name
                    ),
                ));
            }
            if let Body::Expr(b) = &self.prog.funcs[f].body {
                funcs_in(b, &mut stack);
            }
        }
        let result = {
            let mut it = crate::interp::Interp::new(&self.prog, Box::new(std::io::stderr()));
            let r = it.call(tmp, vec![]);
            r.map_err(|c| match c {
                crate::interp::Ctl::Fail(v, t) => format!(
                    "`comptime` evaluation failed: {}",
                    crate::value::display(&v, &t, &self.prog, true)
                ),
                crate::interp::Ctl::Trap(m) => format!("`comptime` evaluation trapped: {}", m),
                crate::interp::Ctl::Exit(c) => format!("`comptime` evaluation exited with {}", c),
                crate::interp::Ctl::Cancelled => "`comptime` evaluation was cancelled".to_string(),
            })
        };
        match result {
            Ok(v) => Ok(Expr::Const(v)),
            Err(m) => Err(Diagnostic::error(e.span, m)),
        }
    }

    /// `TypeInfo` value describing a concrete type.
    fn type_info(&mut self, mt: &MT) -> Value {
        self.register_shapes(mt);
        let strs = |xs: Vec<String>| Value::list(xs.iter().map(|x| Value::str(x)).collect());
        let (name, args) = match mt {
            MT::Con(n, a) => (MT::short_name(n), a.iter().map(|t| t.to_string()).collect()),
            MT::Fun(..) => ("fn".to_string(), vec![]),
            other => (other.to_string(), vec![]),
        };
        // TypeShape: ShapePrim | ShapeFunction | ShapeTuple | ShapeRecord | ShapeVariants
        let shape = match mt {
            MT::Fun(..) => Value::nullary(1),
            MT::Record(fs)
                if fs.len() > 1 && fs.iter().enumerate().all(|(i, (l, _))| *l == i.to_string()) =>
            {
                Value::data(
                    2,
                    vec![strs(fs.iter().map(|(_, t)| t.to_string()).collect())],
                )
            }
            MT::Record(fs) => Value::data(3, vec![field_infos(fs)]),
            MT::Con(..) => match self.prog.shapes.get(mt).cloned() {
                Some(TypeShape::Record(fs)) => Value::data(3, vec![field_infos(&fs)]),
                Some(TypeShape::Adt(vs)) => Value::data(
                    4,
                    vec![Value::list(
                        vs.iter()
                            .map(|(n, fs)| {
                                // VariantInfo fields in label order: fields, name
                                Value::tuple(vec![
                                    strs(fs.iter().map(|t| t.to_string()).collect()),
                                    Value::str(n),
                                ])
                            })
                            .collect(),
                    )],
                ),
                _ => Value::nullary(0),
            },
            MT::Nat(_) => Value::nullary(0),
        };
        // TypeInfo fields in label order: args, name, shape
        Value::tuple(vec![strs(args), Value::str(&name), shape])
    }

    // ----- expressions -----------------------------------------------------------

    #[allow(clippy::only_used_in_recursion)]
    fn expr(&mut self, e: &ast::Expr, s: &Subst, fb: &mut FB) -> MResult<Expr> {
        match &e.kind {
            ExprKind::Int { neg, mag, .. } => {
                let mt = self.node_mt(e.id, s);
                match checked_int_value(&mt, *neg, *mag)
                    .map_err(|m| Diagnostic::error(e.span, m))?
                {
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
            ExprKind::Float { value, value32, .. } => {
                let mt = self.node_mt(e.id, s);
                match float_value(&mt, *value, *value32) {
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
                    self.register_shapes(&cur);
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
                self.register_shapes(&rec);
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
                self.register_shapes(&out);
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
                self.register_shapes(&rec);
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
                self.match_work
                    .push((id, e.id, s.clone(), self.cur_module.clone()));
                Ok(Expr::Func(id))
            }
            ExprKind::Comptime(x) => self.comptime(e, x, s),
            ExprKind::Quote(x) => {
                let holes = crate::syntax::hole_count(x);
                if holes == 0 {
                    let mut cx = QuoteCx { mono: self, s, fb };
                    return crate::syntax::quote(x, &mut cx);
                }
                // a syntax template: a function of its positional holes
                let mut tfb = FB { nlocals: holes };
                let body = {
                    let mut cx = QuoteCx {
                        mono: self,
                        s,
                        fb: &mut tfb,
                    };
                    crate::syntax::quote(x, &mut cx)?
                };
                let mt = self.node_mt(e.id, s);
                let id = self.new_func("quote".into(), holes, mt, Body::Expr(body));
                self.prog.funcs[id].nlocals = tfb.nlocals;
                Ok(Expr::Func(id))
            }
            ExprKind::TypeOf(_) => {
                let t = self
                    .typed
                    .reflected
                    .get(&e.id)
                    .cloned()
                    .unwrap_or(Type::unit());
                let mt = self.mt(&t, s);
                Ok(Expr::Const(self.type_info(&mt)))
            }
            ExprKind::MacroCall(name, _) => Err(Diagnostic::error(
                e.span,
                format!("unknown macro `{}`", name),
            )),
        }
    }

    fn var(&mut self, e: &ast::Expr, s: &Subst) -> MResult<Expr> {
        // type-level naturals can reach `TInt` through generic code
        if let Some(w) = crate::value::too_wide_tint(&self.node_mt(e.id, s)) {
            return Err(Diagnostic::error(e.span, crate::value::tint_width_error(w)));
        }
        let inst = self.typed.insts[&e.id].clone();
        let types: Vec<MT> = inst.types.iter().map(|t| self.mt(t, s)).collect();
        let g = &self.env.globals[&inst.target];
        match &g.kind {
            GlobalKind::Binding(idx) => {
                let idx = *idx;
                if let Some(id) = self.remote_stub(idx).map_err(|mut d| {
                    d.span = e.span;
                    d
                })? {
                    return Ok(Expr::Func(id));
                }
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
            GlobalKind::Foreign {
                symbol,
                abi,
                variadic,
            } => {
                let mt = self.node_mt(e.id, s);
                let id = if abi == "C" {
                    self.c_instance(&inst.target, symbol, *variadic, mt)
                } else {
                    self.foreign_instance(&inst.target, symbol, mt)
                };
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
            PatKind::Int { neg, mag } => {
                match checked_int_value(mt, *neg, *mag).map_err(|m| Diagnostic::error(p.span, m))? {
                    Some(v) => Ok(Pat::Lit(v)),
                    None => Err(Diagnostic::error(
                        p.span,
                        format!(
                            "integer patterns need a primitive numeric type, not `{}`",
                            mt
                        ),
                    )),
                }
            }
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
            .get(&p.id)
            .cloned()
            .ok_or_else(|| Diagnostic::error(p.span, format!("unknown constructor `{}`", name)))
    }
}

/// Hygienic quoting in the module being lowered.
struct QuoteCx<'m, 'a, 's, 'f> {
    mono: &'m mut Mono<'a>,
    s: &'s Subst,
    fb: &'f mut FB,
}

impl crate::syntax::QuoteCtx for QuoteCx<'_, '_, '_, '_> {
    fn value_name(&self, n: &str) -> String {
        let scope = Scope {
            module: self.mono.cur_module.clone(),
        };
        match self.mono.env.resolve_value(&scope, n) {
            Some(c) => format!("::{}", c),
            None => n.to_string(),
        }
    }

    fn ctor_name(&self, n: &str) -> String {
        let scope = Scope {
            module: self.mono.cur_module.clone(),
        };
        match self.mono.env.resolve_ctor(&scope, n) {
            Ok(c) => format!("::{}", c),
            Err(_) => n.to_string(),
        }
    }

    fn unquote(&mut self, x: &ast::Expr) -> Result<Expr, Diagnostic> {
        self.mono.expr(x, self.s, self.fb)
    }
}

fn field_infos(fs: &[(String, MT)]) -> Value {
    // FieldInfo fields in label order: name, ty
    Value::list(
        fs.iter()
            .map(|(l, t)| Value::tuple(vec![Value::str(l), Value::str(&t.to_string())]))
            .collect(),
    )
}

/// Functions referenced by an expression.
fn funcs_in(e: &Expr, out: &mut Vec<FuncId>) {
    match e {
        Expr::Func(f) => out.push(*f),
        Expr::Call(f, a) => {
            out.push(*f);
            a.iter().for_each(|x| funcs_in(x, out));
        }
        Expr::Apply(f, a) => {
            funcs_in(f, out);
            a.iter().for_each(|x| funcs_in(x, out));
        }
        Expr::Construct(_, a) | Expr::Record(a) => a.iter().for_each(|x| funcs_in(x, out)),
        Expr::Field(r, _) => funcs_in(r, out),
        Expr::SetFields(r, s) => {
            funcs_in(r, out);
            s.iter().for_each(|(_, x)| funcs_in(x, out));
        }
        Expr::Let(_, v, b) => {
            funcs_in(v, out);
            funcs_in(b, out);
        }
        Expr::Match(sc, arms) => {
            funcs_in(sc, out);
            arms.iter().for_each(|(_, b)| funcs_in(b, out));
        }
        Expr::Local(_) | Expr::Const(_) => {}
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

/// Lower a checked program to optimized IR.
pub fn lower(env: &Env, typed: &Typed, roots: Roots) -> MResult<Program> {
    let mut prog = Mono::new(env, typed).run(roots)?;
    if std::env::var("FWP_NO_OPT").is_err() {
        crate::opt::optimize(&mut prog);
        crate::opt::specialize_hofs(&mut prog);
        crate::fuse::fuse(&mut prog);
    }
    if std::env::var_os("FWP_DUMP_IR").is_some() {
        for (i, f) in prog.funcs.iter().enumerate() {
            if !f.name.starts_with("std") || f.name.contains("-fn") {
                eprintln!("f{} {} : {} = {:?}", i, f.name, f.ty, f.body);
            }
        }
    }
    Ok(prog)
}
