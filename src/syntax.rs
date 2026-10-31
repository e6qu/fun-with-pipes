//! Homoiconicity: conversion between the AST and `Syntax` values.
//!
//! * `quote e` lowers to IR that builds the `Syntax` value of `e`;
//!   `unquote!(s)` inside it splices the value of `s`.
//! * Macro arguments are converted to `Syntax` values, and macro results
//!   back to AST.
//!
//! Hygiene: a name in a quote that resolves in the quoting module is
//! emitted fully qualified (`::module::name`), so it keeps referring to the
//! same definition wherever the syntax is spliced. Free names (those that
//! do not resolve there) are left as written and resolve at the use site.

use crate::ast::*;
use crate::diag::{Diagnostic, Span};
use crate::ir::Expr as IR;
use crate::value::Value;

// Constructor tags, in declaration order (lib/prelude.fwp).
const S_NAME: u32 = 0;
const S_CTOR: u32 = 1;
const S_INT: u32 = 2;
const S_FLOAT: u32 = 3;
const S_STR: u32 = 4;
const S_SELECT: u32 = 5;
const S_APPLY: u32 = 6;
const S_PIPE: u32 = 7;
const S_UNIT: u32 = 8;
const S_TUPLE: u32 = 9;
const S_LIST: u32 = 10;
const S_RECORD: u32 = 11;
const S_MATCH: u32 = 12;
const S_COMPTIME: u32 = 13;
const S_OTHER: u32 = 14;
const S_MACRO: u32 = 15;
const S_FIELDS: u32 = 16;
const S_LET: u32 = 17;
const S_LAMBDA: u32 = 18;

const P_HOLE: u32 = 0;
const P_INT: u32 = 1;
const P_STR: u32 = 2;
const P_CTOR: u32 = 3;
const P_BARE: u32 = 4;
const P_TUPLE: u32 = 5;
const P_UNIT: u32 = 6;
const P_NAME: u32 = 7;
const P_RECORD: u32 = 8;
const P_IGNORE: u32 = 9;

fn s(x: &str) -> IR {
    IR::Const(Value::str(x))
}

fn list(items: Vec<IR>) -> IR {
    let mut acc = IR::Construct(0, vec![]);
    for x in items.into_iter().rev() {
        acc = IR::Construct(1, vec![x, acc]);
    }
    acc
}

/// How names are qualified and unquotes lowered while building syntax.
pub trait QuoteCtx {
    /// Name assigned to a binder introduced by this quote.
    fn local_name(&self, id: NodeId, name: &str) -> String;
    /// Qualified form of a value name (or the name itself if free).
    fn value_name(&self, n: &str) -> String;
    fn ctor_name(&self, n: &str) -> String;
    /// IR for the spliced expression of `unquote!(x)`.
    fn unquote(&mut self, x: &Expr) -> Result<IR, Diagnostic>;
}

/// Lower `quote e` (or a macro argument) to IR building a `Syntax` value.
pub fn quote(e: &Expr, cx: &mut dyn QuoteCtx) -> Result<IR, Diagnostic> {
    let mut renamed = e.clone();
    rename_binders(&mut renamed, &mut Vec::new(), &|id, n| cx.local_name(id, n));
    quote_inner(&renamed, cx)
}

fn quote_inner(e: &Expr, cx: &mut dyn QuoteCtx) -> Result<IR, Diagnostic> {
    let c = |tag: u32, args: Vec<IR>| IR::Construct(tag, args);
    Ok(match &e.kind {
        ExprKind::Int {
            neg,
            mag,
            suffix: None,
        } if *mag <= i64::MAX as u128 => {
            let v = if *neg { -(*mag as i64) } else { *mag as i64 };
            c(S_INT, vec![IR::Const(Value::I64(v))])
        }
        ExprKind::Float {
            decimal,
            suffix: None,
        } => c(S_FLOAT, vec![s(decimal)]),
        ExprKind::Str(x) => c(S_STR, vec![s(x)]),
        ExprKind::Var(n) => c(S_NAME, vec![s(&cx.value_name(n))]),
        ExprKind::Ctor(n) => c(S_CTOR, vec![s(&cx.ctor_name(n))]),
        ExprKind::Selector(path) => c(S_SELECT, vec![list(path.iter().map(|p| s(p)).collect())]),
        ExprKind::App(f, args) | ExprKind::Operator(_, f, args) => {
            let fq = quote_inner(f, cx)?;
            let mut xs = Vec::new();
            for a in args {
                xs.push(quote_inner(a, cx)?);
            }
            c(S_APPLY, vec![fq, list(xs)])
        }
        ExprKind::Pipe(a, b) => c(S_PIPE, vec![quote_inner(a, cx)?, quote_inner(b, cx)?]),
        ExprKind::Unit => c(S_UNIT, vec![]),
        ExprKind::Tuple(items) | ExprKind::List(items) => {
            let mut xs = Vec::new();
            for a in items {
                xs.push(quote_inner(a, cx)?);
            }
            let tag = if matches!(e.kind, ExprKind::Tuple(_)) {
                S_TUPLE
            } else {
                S_LIST
            };
            c(tag, vec![list(xs)])
        }
        ExprKind::Record(fields) => {
            let mut xs = Vec::new();
            for (n, a) in fields {
                xs.push(IR::Record(vec![s(n), quote_inner(a, cx)?]));
            }
            c(S_RECORD, vec![list(xs)])
        }
        ExprKind::Let(p, v, b) => c(
            S_LET,
            vec![pattern(p, cx), quote_inner(v, cx)?, quote_inner(b, cx)?],
        ),
        ExprKind::Lambda(p, b) => c(S_LAMBDA, vec![pattern(p, cx), quote_inner(b, cx)?]),
        ExprKind::Match(arms) => {
            let mut xs = Vec::new();
            for arm in arms {
                xs.push(IR::Record(vec![
                    pattern(&arm.pat, cx),
                    quote_inner(&arm.body, cx)?,
                ]));
            }
            c(S_MATCH, vec![list(xs)])
        }
        ExprKind::Comptime(x) => c(S_COMPTIME, vec![quote_inner(x, cx)?]),
        ExprKind::MacroCall(n, args) if n == "unquote" => {
            if args.len() != 1 {
                return Err(Diagnostic::error(e.span, "`unquote!` takes one argument"));
            }
            match hole_index(e) {
                Some(i) => IR::Local(i),
                None => cx.unquote(&args[0])?,
            }
        }
        ExprKind::MacroCall(n, args) => {
            let mut xs = Vec::new();
            for a in args {
                xs.push(quote_inner(a, cx)?);
            }
            c(S_MACRO, vec![s(n), list(xs)])
        }
        ExprKind::With(fs)
        | ExprKind::Update(fs)
        | ExprKind::Make(_, fs)
        | ExprKind::NominalRecord(_, fs) => {
            let kind = match &e.kind {
                ExprKind::With(_) => "with".to_string(),
                ExprKind::Update(_) => "update".to_string(),
                ExprKind::Make(None, _) => "make".to_string(),
                ExprKind::Make(Some(t), _) => format!("make {}", t),
                ExprKind::NominalRecord(t, _) => format!("record {}", t),
                _ => unreachable!(),
            };
            let mut xs = Vec::new();
            for (n, a) in fs {
                xs.push(IR::Record(vec![s(n), quote_inner(a, cx)?]));
            }
            c(S_FIELDS, vec![s(&kind), list(xs)])
        }
        _ => c(S_OTHER, vec![s(&crate::pretty::expr(e))]),
    })
}

fn pattern(p: &Pattern, cx: &mut dyn QuoteCtx) -> IR {
    let c = |tag: u32, args: Vec<IR>| IR::Construct(tag, args);
    match &p.kind {
        PatKind::Bind(n) => c(P_NAME, vec![s(n)]),
        PatKind::Ignore => c(P_IGNORE, vec![]),
        PatKind::Record(fs) => c(
            P_RECORD,
            vec![list(
                fs.iter()
                    .map(|(n, p)| IR::Record(vec![s(n), pattern(p, cx)]))
                    .collect(),
            )],
        ),
        PatKind::Hole => c(P_HOLE, vec![]),
        PatKind::Int { neg, mag } => {
            let v = if *neg { -(*mag as i64) } else { *mag as i64 };
            c(P_INT, vec![IR::Const(Value::I64(v))])
        }
        PatKind::Str(x) => c(P_STR, vec![s(x)]),
        PatKind::Ctor(n, None) => c(P_BARE, vec![s(&cx.ctor_name(n))]),
        PatKind::Ctor(n, Some(args)) => {
            let ps = args.iter().map(|a| pattern(a, cx)).collect();
            c(P_CTOR, vec![s(&cx.ctor_name(n)), list(ps)])
        }
        PatKind::Tuple(items) => {
            let ps = items.iter().map(|a| pattern(a, cx)).collect();
            c(P_TUPLE, vec![list(ps)])
        }
        PatKind::Unit => c(P_UNIT, vec![]),
    }
}

/// Positional hole index of `unquote!(N)`, if the argument is a literal.
pub fn hole_index(e: &Expr) -> Option<u32> {
    match &e.kind {
        ExprKind::MacroCall(n, args) if n == "unquote" && args.len() == 1 => match &args[0].kind {
            ExprKind::Int {
                neg: false,
                mag,
                suffix: None,
            } if *mag < 64 => Some(*mag as u32),
            _ => None,
        },
        _ => None,
    }
}

/// Number of positional holes (`unquote!(0)`, `unquote!(1)`, ...) in a
/// quote: the quote is then a function of that many syntax arguments.
pub fn hole_count(e: &Expr) -> u32 {
    let mut us = Vec::new();
    collect_unquote_calls(e, &mut us);
    us.iter()
        .filter_map(|u| hole_index(u))
        .map(|i| i + 1)
        .max()
        .unwrap_or(0)
}

fn collect_unquote_calls<'e>(e: &'e Expr, out: &mut Vec<&'e Expr>) {
    match &e.kind {
        ExprKind::MacroCall(n, _) if n == "unquote" => out.push(e),
        ExprKind::App(f, args) | ExprKind::Operator(_, f, args) => {
            collect_unquote_calls(f, out);
            args.iter().for_each(|a| collect_unquote_calls(a, out));
        }
        ExprKind::Pipe(a, b) => {
            collect_unquote_calls(a, out);
            collect_unquote_calls(b, out);
        }
        ExprKind::Tuple(xs) | ExprKind::List(xs) | ExprKind::MacroCall(_, xs) => {
            xs.iter().for_each(|a| collect_unquote_calls(a, out))
        }
        ExprKind::Record(fs)
        | ExprKind::NominalRecord(_, fs)
        | ExprKind::With(fs)
        | ExprKind::Make(_, fs)
        | ExprKind::Update(fs) => fs.iter().for_each(|(_, a)| collect_unquote_calls(a, out)),
        ExprKind::Match(arms) => arms
            .iter()
            .for_each(|a| collect_unquote_calls(&a.body, out)),
        ExprKind::Let(_, a, b) => {
            collect_unquote_calls(a, out);
            collect_unquote_calls(b, out);
        }
        ExprKind::Lambda(_, x) | ExprKind::Comptime(x) | ExprKind::Quote(x) => {
            collect_unquote_calls(x, out)
        }
        _ => {}
    }
}

/// Evaluate an IR tree built only from constants, constructors and records.
pub fn const_value(e: &IR) -> Option<Value> {
    Some(match e {
        IR::Const(v) => v.clone(),
        IR::Construct(tag, args) => {
            let mut vs = Vec::new();
            for a in args {
                vs.push(const_value(a)?);
            }
            Value::data(*tag, vs)
        }
        IR::Record(args) => {
            let mut vs = Vec::new();
            for a in args {
                vs.push(const_value(a)?);
            }
            Value::tuple(vs)
        }
        _ => return None,
    })
}

/// Quote context without hygiene (for macro arguments: names stay as the
/// user wrote them).
pub struct Plain;

impl QuoteCtx for Plain {
    fn local_name(&self, _id: NodeId, name: &str) -> String {
        name.to_string()
    }
    fn value_name(&self, n: &str) -> String {
        n.to_string()
    }
    fn ctor_name(&self, n: &str) -> String {
        n.to_string()
    }
    fn unquote(&mut self, x: &Expr) -> Result<IR, Diagnostic> {
        Err(Diagnostic::error(
            x.span,
            "`unquote!` can only be used inside `quote`",
        ))
    }
}

/// The `Syntax` value of an expression, names as written.
pub fn to_value(e: &Expr) -> Result<Value, Diagnostic> {
    let ir = quote(e, &mut Plain)?;
    const_value(&ir)
        .ok_or_else(|| Diagnostic::error(e.span, "`unquote!` can only be used inside `quote`"))
}

// --------------------------------------------------------------- back to AST

struct Builder<'a> {
    next_id: &'a mut NodeId,
    span: Span,
}

impl Builder<'_> {
    fn mk(&mut self, kind: ExprKind) -> Expr {
        let id = *self.next_id;
        *self.next_id += 1;
        Expr {
            id,
            span: self.span,
            kind,
        }
    }

    fn str_of(v: &Value) -> Result<String, String> {
        match v {
            Value::Str(x) => Ok(x.to_string()),
            _ => Err("malformed syntax value".into()),
        }
    }

    fn expr(&mut self, v: &Value) -> Result<Expr, String> {
        let Value::Data(tag, fs) = v else {
            return Err("malformed syntax value".into());
        };
        let kind = match *tag {
            S_NAME => ExprKind::Var(Self::str_of(&fs[0])?),
            S_CTOR => ExprKind::Ctor(Self::str_of(&fs[0])?),
            S_INT => match &fs[0] {
                Value::I64(x) => ExprKind::Int {
                    neg: *x < 0,
                    mag: x.unsigned_abs() as u128,
                    suffix: None,
                },
                _ => return Err("malformed SInt".into()),
            },
            S_FLOAT => {
                let decimal = Self::str_of(&fs[0])?;
                let expr = crate::parser::parse_expr_text(&decimal, self.span.file, self.next_id)
                    .map_err(|_| "SFloat needs an unsuffixed decimal float literal")?;
                match &expr.kind {
                    ExprKind::Float {
                        decimal: parsed,
                        suffix: None,
                    } if *parsed == decimal => expr.kind,
                    _ => return Err("SFloat needs an unsuffixed decimal float literal".into()),
                }
            }
            S_STR => ExprKind::Str(Self::str_of(&fs[0])?),
            S_SELECT => {
                let mut path = Vec::new();
                for p in fs[0].list_items() {
                    path.push(Self::str_of(&p)?);
                }
                if path.is_empty() {
                    return Err("empty selector".into());
                }
                ExprKind::Selector(path)
            }
            S_APPLY => {
                let f = self.expr(&fs[0])?;
                let mut args = Vec::new();
                for a in fs[1].list_items() {
                    args.push(self.expr(&a)?);
                }
                if args.is_empty() {
                    return Ok(f);
                }
                ExprKind::App(Box::new(f), args)
            }
            S_PIPE => ExprKind::Pipe(Box::new(self.expr(&fs[0])?), Box::new(self.expr(&fs[1])?)),
            S_UNIT => ExprKind::Unit,
            S_TUPLE | S_LIST => {
                let mut items = Vec::new();
                for a in fs[0].list_items() {
                    items.push(self.expr(&a)?);
                }
                if *tag == S_TUPLE {
                    match items.len() {
                        0 => ExprKind::Unit,
                        1 => return Ok(items.pop().unwrap()),
                        _ => ExprKind::Tuple(items),
                    }
                } else {
                    ExprKind::List(items)
                }
            }
            S_RECORD => {
                let mut fields = Vec::new();
                for p in fs[0].list_items() {
                    let Value::Record(kv) = &p else {
                        return Err("malformed record syntax".into());
                    };
                    fields.push((Self::str_of(&kv[0])?, self.expr(&kv[1])?));
                }
                if fields.is_empty() {
                    ExprKind::Unit
                } else {
                    ExprKind::Record(fields)
                }
            }
            S_MATCH => {
                let mut arms = Vec::new();
                for p in fs[0].list_items() {
                    let Value::Record(kv) = &p else {
                        return Err("malformed match syntax".into());
                    };
                    arms.push(Arm {
                        pat: self.pattern(&kv[0])?,
                        body: self.expr(&kv[1])?,
                    });
                }
                if arms.is_empty() {
                    return Err("`match` needs at least one arm".into());
                }
                ExprKind::Match(arms)
            }
            S_LET => ExprKind::Let(
                self.pattern(&fs[0])?,
                Box::new(self.expr(&fs[1])?),
                Box::new(self.expr(&fs[2])?),
            ),
            S_LAMBDA => ExprKind::Lambda(self.pattern(&fs[0])?, Box::new(self.expr(&fs[1])?)),
            S_COMPTIME => ExprKind::Comptime(Box::new(self.expr(&fs[0])?)),
            S_MACRO => {
                let mut args = Vec::new();
                for a in fs[1].list_items() {
                    args.push(self.expr(&a)?);
                }
                ExprKind::MacroCall(Self::str_of(&fs[0])?, args)
            }
            S_FIELDS => {
                let kind = Self::str_of(&fs[0])?;
                let mut fields = Vec::new();
                for p in fs[1].list_items() {
                    let Value::Record(kv) = &p else {
                        return Err("malformed field syntax".into());
                    };
                    fields.push((Self::str_of(&kv[0])?, self.expr(&kv[1])?));
                }
                match kind.split_once(' ') {
                    None if kind == "with" => ExprKind::With(fields),
                    None if kind == "update" => ExprKind::Update(fields),
                    None if kind == "make" => ExprKind::Make(None, fields),
                    Some(("make", t)) => ExprKind::Make(Some(t.to_string()), fields),
                    Some(("record", t)) => ExprKind::NominalRecord(t.to_string(), fields),
                    _ => return Err(format!("unknown record form `{}`", kind)),
                }
            }
            S_OTHER => {
                let text = Self::str_of(&fs[0])?;
                let mut e = crate::parser::parse_expr_text(&text, self.span.file, self.next_id)
                    .map_err(|d| {
                        format!("cannot parse spliced syntax `{}`: {}", text, d.message)
                    })?;
                set_span(&mut e, self.span);
                return Ok(e);
            }
            _ => return Err("malformed syntax value".into()),
        };
        Ok(self.mk(kind))
    }

    fn pattern(&mut self, v: &Value) -> Result<Pattern, String> {
        let Value::Data(tag, fs) = v else {
            return Err("malformed pattern".into());
        };
        let kind = match *tag {
            P_NAME => PatKind::Bind(Self::str_of(&fs[0])?),
            P_IGNORE => PatKind::Ignore,
            P_RECORD => {
                let mut fields = Vec::new();
                for field in fs[0].list_items() {
                    let Value::Record(pair) = field else {
                        return Err("malformed record pattern".into());
                    };
                    if pair.len() != 2 {
                        return Err("malformed record pattern".into());
                    }
                    fields.push((Self::str_of(&pair[0])?, self.pattern(&pair[1])?));
                }
                PatKind::Record(fields)
            }
            P_HOLE => PatKind::Hole,
            P_INT => match &fs[0] {
                Value::I64(x) => PatKind::Int {
                    neg: *x < 0,
                    mag: x.unsigned_abs() as u128,
                },
                _ => return Err("malformed PInt".into()),
            },
            P_STR => PatKind::Str(Self::str_of(&fs[0])?),
            P_BARE => PatKind::Ctor(Self::str_of(&fs[0])?, None),
            P_CTOR => {
                let mut args = Vec::new();
                for a in fs[1].list_items() {
                    args.push(self.pattern(&a)?);
                }
                PatKind::Ctor(Self::str_of(&fs[0])?, Some(args))
            }
            P_TUPLE => {
                let mut items = Vec::new();
                for a in fs[0].list_items() {
                    items.push(self.pattern(&a)?);
                }
                PatKind::Tuple(items)
            }
            P_UNIT => PatKind::Unit,
            _ => return Err("malformed pattern".into()),
        };
        let id = *self.next_id;
        *self.next_id += 1;
        Ok(Pattern {
            id,
            span: self.span,
            kind,
        })
    }
}

fn set_span(e: &mut Expr, span: Span) {
    e.span = span;
    match &mut e.kind {
        ExprKind::App(f, args) | ExprKind::Operator(_, f, args) => {
            set_span(f, span);
            args.iter_mut().for_each(|a| set_span(a, span));
        }
        ExprKind::Pipe(a, b) => {
            set_span(a, span);
            set_span(b, span);
        }
        ExprKind::Tuple(xs) | ExprKind::List(xs) | ExprKind::MacroCall(_, xs) => {
            xs.iter_mut().for_each(|a| set_span(a, span))
        }
        ExprKind::Record(fs)
        | ExprKind::NominalRecord(_, fs)
        | ExprKind::With(fs)
        | ExprKind::Make(_, fs)
        | ExprKind::Update(fs) => fs.iter_mut().for_each(|(_, a)| set_span(a, span)),
        ExprKind::Let(p, v, b) => {
            p.span = span;
            set_span(v, span);
            set_span(b, span);
        }
        ExprKind::Lambda(p, b) => {
            p.span = span;
            set_span(b, span);
        }
        ExprKind::Match(arms) => arms.iter_mut().for_each(|a| {
            a.pat.span = span;
            set_span(&mut a.body, span)
        }),
        ExprKind::Comptime(x) | ExprKind::Quote(x) => set_span(x, span),
        _ => {}
    }
}

/// Convert a `Syntax` value back to an expression (with fresh node ids and
/// the given span).
pub fn from_value(v: &Value, span: Span, next_id: &mut NodeId) -> Result<Expr, String> {
    let mut e = Builder { next_id, span }.expr(v)?;
    rename_binders(&mut e, &mut Vec::new(), &|id, name| {
        if name.starts_with("::local::") {
            format!("::local::{id}::{}", name.rsplit("::").next().unwrap())
        } else {
            name.to_string()
        }
    });
    Ok(e)
}

/// Source text of a `Syntax` value, with qualified names shown plainly.
pub fn show(v: &Value) -> String {
    let mut next = 0;
    match from_value(v, Span::DUMMY, &mut next) {
        Ok(mut e) => {
            unqualify_expr(&mut e);
            crate::pretty::expr(&e)
        }
        Err(e) => format!("<{}>", e),
    }
}

/// `::std::map` -> `map`, `::geo::area` -> `geo.area`.
pub fn unqualify(name: &str) -> String {
    if name.starts_with("::local::") {
        return format!(
            "_quoted_{}",
            name.strip_prefix("::local::").unwrap().replace("::", "_")
        );
    }
    let Some(abs) = name.strip_prefix("::") else {
        return name.to_string();
    };
    match abs.split_once("::") {
        Some(("std", n)) | Some(("main", n)) => n.to_string(),
        Some((m, n)) => format!("{}.{}", m, n),
        None => abs.to_string(),
    }
}

fn unqualify_pat(p: &mut Pattern) {
    match &mut p.kind {
        PatKind::Bind(n) => *n = unqualify(n),
        PatKind::Record(fs) => {
            for (_, p) in fs {
                unqualify_pat(p);
            }
        }
        PatKind::Ctor(n, args) => {
            *n = unqualify(n);
            if let Some(args) = args {
                args.iter_mut().for_each(unqualify_pat);
            }
        }
        PatKind::Tuple(items) => items.iter_mut().for_each(unqualify_pat),
        _ => {}
    }
}

fn unqualify_expr(e: &mut Expr) {
    match &mut e.kind {
        ExprKind::Var(n) | ExprKind::Ctor(n) => *n = unqualify(n),
        ExprKind::App(f, args) | ExprKind::Operator(_, f, args) => {
            unqualify_expr(f);
            args.iter_mut().for_each(unqualify_expr);
        }
        ExprKind::Pipe(a, b) => {
            unqualify_expr(a);
            unqualify_expr(b);
        }
        ExprKind::Tuple(xs) | ExprKind::List(xs) | ExprKind::MacroCall(_, xs) => {
            xs.iter_mut().for_each(unqualify_expr)
        }
        ExprKind::Record(fs)
        | ExprKind::NominalRecord(_, fs)
        | ExprKind::With(fs)
        | ExprKind::Make(_, fs)
        | ExprKind::Update(fs) => fs.iter_mut().for_each(|(_, a)| unqualify_expr(a)),
        ExprKind::Let(p, a, b) => {
            unqualify_pat(p);
            unqualify_expr(a);
            unqualify_expr(b);
        }
        ExprKind::Lambda(p, b) => {
            unqualify_pat(p);
            unqualify_expr(b);
        }
        ExprKind::Match(arms) => arms.iter_mut().for_each(|a| {
            unqualify_pat(&mut a.pat);
            unqualify_expr(&mut a.body)
        }),
        ExprKind::Comptime(x) | ExprKind::Quote(x) => unqualify_expr(x),
        _ => {}
    }
}

/// Rename introduced binders and their lexical uses, never syntax spliced by an
/// unquote. Absolute local names cannot capture an ordinary caller identifier.
fn rename_binders(
    e: &mut Expr,
    names: &mut Vec<(String, String)>,
    rename: &dyn Fn(NodeId, &str) -> String,
) {
    fn bind(
        p: &mut Pattern,
        names: &mut Vec<(String, String)>,
        rename: &dyn Fn(NodeId, &str) -> String,
    ) {
        match &mut p.kind {
            PatKind::Bind(n) => {
                let new = rename(p.id, n);
                names.push((n.clone(), new.clone()));
                *n = new;
            }
            PatKind::Tuple(ps) | PatKind::Ctor(_, Some(ps)) => {
                for p in ps {
                    bind(p, names, rename);
                }
            }
            PatKind::Record(fs) => {
                for (_, p) in fs {
                    bind(p, names, rename);
                }
            }
            _ => {}
        }
    }
    match &mut e.kind {
        ExprKind::Var(n) => {
            if let Some((_, new)) = names.iter().rev().find(|(old, _)| old == n) {
                *n = new.clone();
            }
        }
        ExprKind::MacroCall(n, _) if n == "unquote" => {}
        ExprKind::Let(p, v, b) => {
            rename_binders(v, names, rename);
            let saved = names.len();
            bind(p, names, rename);
            rename_binders(b, names, rename);
            names.truncate(saved);
        }
        ExprKind::Lambda(p, b) => {
            let saved = names.len();
            bind(p, names, rename);
            rename_binders(b, names, rename);
            names.truncate(saved);
        }
        ExprKind::Match(arms) => {
            for a in arms {
                let saved = names.len();
                bind(&mut a.pat, names, rename);
                rename_binders(&mut a.body, names, rename);
                names.truncate(saved);
            }
        }
        ExprKind::App(f, xs) | ExprKind::Operator(_, f, xs) => {
            rename_binders(f, names, rename);
            for x in xs {
                rename_binders(x, names, rename);
            }
        }
        ExprKind::Pipe(a, b) => {
            rename_binders(a, names, rename);
            rename_binders(b, names, rename);
        }
        ExprKind::Tuple(xs) | ExprKind::List(xs) | ExprKind::MacroCall(_, xs) => {
            for x in xs {
                rename_binders(x, names, rename);
            }
        }
        ExprKind::Record(fs)
        | ExprKind::NominalRecord(_, fs)
        | ExprKind::With(fs)
        | ExprKind::Make(_, fs)
        | ExprKind::Update(fs) => {
            for (_, x) in fs {
                rename_binders(x, names, rename);
            }
        }
        ExprKind::Comptime(x) | ExprKind::Quote(x) => rename_binders(x, names, rename),
        _ => {}
    }
}
