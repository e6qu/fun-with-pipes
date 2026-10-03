//! Macro expansion.
//!
//! `macro name = f` defines a macro: `f` is an ordinary function from
//! `Syntax` arguments to `Syntax`. An invocation `name!(a, b)` passes the
//! syntax of its arguments (unevaluated) and is replaced by the syntax the
//! macro returns. Expansion runs before type checking, in rounds: macros
//! and the code they depend on are compiled and run with the interpreter,
//! every invocation is expanded, and the process repeats until no
//! invocations remain (macros may expand to other macro calls).

use std::collections::{HashMap, HashSet};

use crate::ast::*;
use crate::diag::{Diagnostic, Span};
use crate::interp::{Ctl, Interp};
use crate::value::{display, Closure, Value};

pub type Modules = Vec<(String, HashSet<String>, Vec<Decl>)>;

const MAX_ROUNDS: usize = 32;

fn has_call(e: &Expr) -> bool {
    match &e.kind {
        ExprKind::MacroCall(n, args) => n != "unquote" || args.iter().any(has_call),
        ExprKind::App(f, args) => has_call(f) || args.iter().any(has_call),
        ExprKind::Pipe(a, b) => has_call(a) || has_call(b),
        ExprKind::Tuple(xs) | ExprKind::List(xs) => xs.iter().any(has_call),
        ExprKind::Record(fs)
        | ExprKind::NominalRecord(_, fs)
        | ExprKind::With(fs)
        | ExprKind::Make(_, fs)
        | ExprKind::Update(fs) => fs.iter().any(|(_, a)| has_call(a)),
        ExprKind::Match(arms) => arms.iter().any(|a| has_call(&a.body)),
        ExprKind::Comptime(x) => has_call(x),
        // inside a quote only unquoted parts are code
        ExprKind::Quote(x) => {
            let mut us = Vec::new();
            crate::infer::collect_unquotes(x, &mut us);
            us.into_iter().any(has_call)
        }
        _ => false,
    }
}

fn decl_bodies(d: &Decl) -> Vec<&Expr> {
    match d {
        Decl::Bind(b) | Decl::Macro(b) => vec![&b.body],
        Decl::Test { body, .. } => vec![body],
        Decl::Impl(i) => i.bindings.iter().map(|b| &b.body).collect(),
        Decl::Trait(t) => t.defaults.iter().map(|b| &b.body).collect(),
        _ => vec![],
    }
}

fn decl_bodies_mut(d: &mut Decl) -> Vec<&mut Expr> {
    match d {
        Decl::Bind(b) | Decl::Macro(b) => vec![&mut b.body],
        Decl::Test { body, .. } => vec![body],
        Decl::Impl(i) => i.bindings.iter_mut().map(|b| &mut b.body).collect(),
        Decl::Trait(t) => t.defaults.iter_mut().map(|b| &mut b.body).collect(),
        _ => vec![],
    }
}

fn names_in(e: &Expr, out: &mut HashSet<String>) {
    match &e.kind {
        ExprKind::Var(n) => {
            out.insert(n.clone());
        }
        ExprKind::App(f, args) => {
            names_in(f, out);
            args.iter().for_each(|a| names_in(a, out));
        }
        ExprKind::Pipe(a, b) => {
            names_in(a, out);
            names_in(b, out);
        }
        ExprKind::Tuple(xs) | ExprKind::List(xs) | ExprKind::MacroCall(_, xs) => {
            xs.iter().for_each(|a| names_in(a, out))
        }
        ExprKind::Record(fs)
        | ExprKind::NominalRecord(_, fs)
        | ExprKind::With(fs)
        | ExprKind::Make(_, fs)
        | ExprKind::Update(fs) => fs.iter().for_each(|(_, a)| names_in(a, out)),
        ExprKind::Match(arms) => arms.iter().for_each(|a| names_in(&a.body, out)),
        ExprKind::Comptime(x) | ExprKind::Quote(x) => names_in(x, out),
        _ => {}
    }
}

/// Names a declaration defines (as written).
fn defines(d: &Decl) -> Option<&str> {
    match d {
        Decl::Bind(b) | Decl::Macro(b) => Some(&b.name),
        _ => None,
    }
}

pub(crate) fn macro_names(modules: &Modules) -> HashMap<String, String> {
    // source-visible name -> canonical; std macros are visible everywhere,
    // a module's own macros unqualified, imported ones as `module.name`
    let mut m = HashMap::new();
    for (module, _, decls) in modules {
        for d in decls {
            if let Decl::Macro(b) = d {
                m.insert(
                    format!("{}::{}", module, b.name),
                    format!("{}::{}", module, b.name),
                );
            }
        }
    }
    m
}

fn resolve_macro(
    all: &HashMap<String, String>,
    module: &str,
    imports: &HashSet<String>,
    name: &str,
) -> Option<String> {
    let local = format!("{}::{}", module, name);
    if all.contains_key(&local) {
        return Some(local);
    }
    if let Some((m, n)) = name.rsplit_once('.') {
        if imports.contains(m) {
            let q = format!("{}::{}", m, n);
            if all.contains_key(&q) {
                return Some(q);
            }
        }
    }
    let s = format!("std::{}", name);
    all.contains_key(&s).then_some(s)
}

/// Build the program used to run macros: macros become ordinary bindings,
/// and declarations that still contain macro calls (or depend on ones that
/// do, in any module) are left out.
fn phase_modules(modules: &Modules) -> Modules {
    // canonical names (`module::name`) of declarations left out
    let mut removed: HashSet<String> = HashSet::new();
    let mut keep: Vec<Vec<bool>> = modules
        .iter()
        .map(|(_, _, decls)| {
            decls
                .iter()
                .map(|d| !decl_bodies(d).into_iter().any(has_call))
                .collect()
        })
        .collect();
    for ((module, _, decls), ks) in modules.iter().zip(&keep) {
        for (d, k) in decls.iter().zip(ks) {
            if !*k {
                if let Some(n) = defines(d) {
                    removed.insert(format!("{}::{}", module, n));
                }
            }
        }
    }
    // a name as written in `module` refers to a removed declaration
    let refers_to_removed =
        |removed: &HashSet<String>, module: &str, imports: &HashSet<String>, n: &str| {
            if removed.contains(&format!("{}::{}", module, n))
                || removed.contains(&format!("std::{}", n))
            {
                return true;
            }
            match n.rsplit_once('.') {
                Some((m, x)) => imports.contains(m) && removed.contains(&format!("{}::{}", m, x)),
                None => false,
            }
        };
    loop {
        let mut changed = false;
        for (mi, (module, imports, decls)) in modules.iter().enumerate() {
            for (i, d) in decls.iter().enumerate() {
                if !keep[mi][i] {
                    continue;
                }
                let mut used = HashSet::new();
                decl_bodies(d)
                    .into_iter()
                    .for_each(|b| names_in(b, &mut used));
                if used
                    .iter()
                    .any(|n| refers_to_removed(&removed, module, imports, n))
                {
                    keep[mi][i] = false;
                    if let Some(n) = defines(d) {
                        removed.insert(format!("{}::{}", module, n));
                    }
                    changed = true;
                }
            }
        }
        if !changed {
            break;
        }
    }
    let mut out = Vec::new();
    for ((module, imports, decls), ks) in modules.iter().zip(&keep) {
        let gone = |n: &str| removed.contains(&format!("{}::{}", module, n));
        let mut kept = Vec::new();
        for (d, k) in decls.iter().zip(ks) {
            match d {
                // signatures and exports of removed bindings go too
                Decl::Sig { sig, .. } if gone(&sig.name) => {}
                Decl::Export { name, .. } if gone(name) => {}
                Decl::Macro(b) if *k => kept.push(Decl::Bind(b.clone())),
                _ if *k => kept.push(d.clone()),
                _ => {}
            }
        }
        out.push((module.clone(), imports.clone(), kept));
    }
    out
}

/// Expand every macro invocation in `modules`. Macro declarations become
/// ordinary bindings in the result.
pub fn expand(
    mut modules: Modules,
    next_id: &mut NodeId,
    sm: &crate::diag::SourceMap,
) -> Result<Modules, Vec<Diagnostic>> {
    let macros = macro_names(&modules);
    for round in 0..MAX_ROUNDS {
        let pending = modules
            .iter()
            .any(|(_, _, ds)| ds.iter().any(|d| decl_bodies(d).into_iter().any(has_call)));
        if !pending {
            break;
        }
        if round + 1 == MAX_ROUNDS {
            return Err(vec![Diagnostic::error(
                Span::DUMMY,
                "macro expansion did not finish after 32 rounds (recursive macros?)",
            )]);
        }
        // compile and run the macros
        let phase = phase_modules(&modules);
        let mut env = crate::env::Env {
            next_node_id: *next_id,
            macros: macros.values().cloned().collect(),
            ..Default::default()
        };
        env.collect(phase);
        let mut typed = crate::infer::Typed::default();
        if env.errors.is_empty() {
            crate::infer::check_program(&mut env, &mut typed);
        }
        if !env.errors.is_empty() {
            return Err(env.errors);
        }
        let roots = crate::mono::Roots {
            names: macros.values().cloned().collect(),
            ..Default::default()
        };
        let prog = crate::mono::lower(&env, &typed, roots).map_err(|d| vec![d])?;
        let funcs: HashMap<String, usize> = prog.named.iter().cloned().collect();
        let mut errors = Vec::new();
        for (module, imports, decls) in modules.iter_mut() {
            for d in decls.iter_mut() {
                for body in decl_bodies_mut(d) {
                    let mut ex = Expander {
                        macros: &macros,
                        module,
                        imports,
                        prog: &prog,
                        funcs: &funcs,
                        next_id,
                        errors: &mut errors,
                    };
                    ex.expr(body);
                }
            }
        }
        if !errors.is_empty() {
            return Err(errors);
        }
        let _ = sm;
    }
    // macros are ordinary functions from here on
    for (_, _, decls) in modules.iter_mut() {
        for d in decls.iter_mut() {
            if let Decl::Macro(b) = d {
                *d = Decl::Bind(b.clone());
            }
        }
    }
    Ok(modules)
}

struct Expander<'a> {
    macros: &'a HashMap<String, String>,
    module: &'a str,
    imports: &'a HashSet<String>,
    prog: &'a crate::ir::Program,
    funcs: &'a HashMap<String, usize>,
    next_id: &'a mut NodeId,
    errors: &'a mut Vec<Diagnostic>,
}

impl Expander<'_> {
    /// Expand outermost invocations (their arguments are passed as syntax).
    fn expr(&mut self, e: &mut Expr) {
        if let ExprKind::MacroCall(name, args) = &e.kind {
            if name != "unquote" {
                match self.invoke(name, args, e.span) {
                    Ok(new) => *e = new,
                    Err(d) => self.errors.push(d),
                }
                return;
            }
        }
        match &mut e.kind {
            ExprKind::App(f, args) => {
                self.expr(f);
                args.iter_mut().for_each(|a| self.expr(a));
            }
            ExprKind::Pipe(a, b) => {
                self.expr(a);
                self.expr(b);
            }
            ExprKind::Tuple(xs) | ExprKind::List(xs) | ExprKind::MacroCall(_, xs) => {
                xs.iter_mut().for_each(|a| self.expr(a))
            }
            ExprKind::Record(fs)
            | ExprKind::NominalRecord(_, fs)
            | ExprKind::With(fs)
            | ExprKind::Make(_, fs)
            | ExprKind::Update(fs) => fs.iter_mut().for_each(|(_, a)| self.expr(a)),
            ExprKind::Match(arms) => arms.iter_mut().for_each(|a| self.expr(&mut a.body)),
            ExprKind::Comptime(x) => self.expr(x),
            ExprKind::Quote(x) => self.in_quote(x),
            _ => {}
        }
    }

    fn in_quote(&mut self, e: &mut Expr) {
        if let ExprKind::MacroCall(n, args) = &mut e.kind {
            if n == "unquote" {
                args.iter_mut().for_each(|a| self.expr(a));
                return;
            }
        }
        match &mut e.kind {
            ExprKind::App(f, args) => {
                self.in_quote(f);
                args.iter_mut().for_each(|a| self.in_quote(a));
            }
            ExprKind::Pipe(a, b) => {
                self.in_quote(a);
                self.in_quote(b);
            }
            ExprKind::Tuple(xs) | ExprKind::List(xs) | ExprKind::MacroCall(_, xs) => {
                xs.iter_mut().for_each(|a| self.in_quote(a))
            }
            ExprKind::Record(fs)
            | ExprKind::NominalRecord(_, fs)
            | ExprKind::With(fs)
            | ExprKind::Make(_, fs)
            | ExprKind::Update(fs) => fs.iter_mut().for_each(|(_, a)| self.in_quote(a)),
            ExprKind::Match(arms) => arms.iter_mut().for_each(|a| self.in_quote(&mut a.body)),
            ExprKind::Comptime(x) | ExprKind::Quote(x) => self.in_quote(x),
            _ => {}
        }
    }

    fn invoke(&mut self, name: &str, args: &[Expr], span: Span) -> Result<Expr, Diagnostic> {
        let Some(canon) = resolve_macro(self.macros, self.module, self.imports, name) else {
            return Err(Diagnostic::error(span, format!("unknown macro `{}`", name)));
        };
        let Some(&fid) = self.funcs.get(&canon) else {
            return Err(Diagnostic::error(
                span,
                format!("macro `{}` could not be compiled", name),
            ));
        };
        let func = &self.prog.funcs[fid];
        let arity = func.arity as usize;
        let syntax = crate::ir::MT::con("std::Syntax");
        let (params, result) = func.ty.params(arity);
        if params.iter().any(|p| **p != syntax) || *result != syntax {
            return Err(Diagnostic::error(
                span,
                format!(
                    "macro `{}` must be a function from `Syntax` arguments to `Syntax`, but has type `{}`",
                    name, func.ty
                ),
            ));
        }
        if arity != args.len() {
            return Err(Diagnostic::error(
                span,
                format!(
                    "macro `{}` takes {} argument(s), but {} were given",
                    name,
                    arity,
                    args.len()
                ),
            ));
        }
        let mut vals = Vec::new();
        for a in args {
            vals.push(crate::syntax::to_value(a)?);
        }
        let mut it = Interp::new(self.prog, Box::new(std::io::stderr()));
        let r = if arity == 0 {
            it.call(fid, vec![])
        } else {
            let f = Value::Closure(std::rc::Rc::new(Closure {
                func: fid,
                args: vec![],
            }));
            it.apply(f, vals)
        };
        let v = r.map_err(|c| {
            let msg = match c {
                Ctl::Fail(v, t) => display(&v, &t, self.prog, true),
                Ctl::Trap(m) => format!("trap: {}", m),
                Ctl::Exit(c) => format!("exit {}", c),
                Ctl::Cancelled => "cancelled".to_string(),
            };
            Diagnostic::error(span, format!("macro `{}` failed: {}", name, msg))
        })?;
        crate::syntax::from_value(&v, span, self.next_id).map_err(|m| {
            Diagnostic::error(
                span,
                format!("macro `{}` produced invalid syntax: {}", name, m),
            )
        })
    }
}
