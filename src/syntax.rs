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

const P_HOLE: u32 = 0;
const P_INT: u32 = 1;
const P_STR: u32 = 2;
const P_CTOR: u32 = 3;
const P_BARE: u32 = 4;
const P_TUPLE: u32 = 5;
const P_UNIT: u32 = 6;

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
    /// Qualified form of a value name (or the name itself if free).
    fn value_name(&self, n: &str) -> String;
    fn ctor_name(&self, n: &str) -> String;
    /// IR for the spliced expression of `unquote!(x)`.
    fn unquote(&mut self, x: &Expr) -> Result<IR, Diagnostic>;
}

/// Lower `quote e` (or a macro argument) to IR building a `Syntax` value.
pub fn quote(e: &Expr, cx: &mut dyn QuoteCtx) -> Result<IR, Diagnostic> {
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
            value,
            suffix: None,
        } => c(S_FLOAT, vec![IR::Const(Value::F64(*value))]),
        ExprKind::Str(x) => c(S_STR, vec![s(x)]),
        ExprKind::Var(n) => c(S_NAME, vec![s(&cx.value_name(n))]),
        ExprKind::Ctor(n) => c(S_CTOR, vec![s(&cx.ctor_name(n))]),
        ExprKind::Selector(path) => c(S_SELECT, vec![list(path.iter().map(|p| s(p)).collect())]),
        ExprKind::App(f, args) => {
            let fq = quote(f, cx)?;
            let mut xs = Vec::new();
            for a in args {
                xs.push(quote(a, cx)?);
            }
            c(S_APPLY, vec![fq, list(xs)])
        }
        ExprKind::Pipe(a, b) => c(S_PIPE, vec![quote(a, cx)?, quote(b, cx)?]),
        ExprKind::Unit => c(S_UNIT, vec![]),
        ExprKind::Tuple(items) | ExprKind::List(items) => {
            let mut xs = Vec::new();
            for a in items {
                xs.push(quote(a, cx)?);
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
                xs.push(IR::Record(vec![s(n), quote(a, cx)?]));
            }
            c(S_RECORD, vec![list(xs)])
        }
        ExprKind::Match(arms) => {
            let mut xs = Vec::new();
            for arm in arms {
                xs.push(IR::Record(vec![
                    pattern(&arm.pat, cx),
                    quote(&arm.body, cx)?,
                ]));
            }
            c(S_MATCH, vec![list(xs)])
        }
        ExprKind::Comptime(x) => c(S_COMPTIME, vec![quote(x, cx)?]),
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
                xs.push(quote(a, cx)?);
            }
            c(S_MACRO, vec![s(n), list(xs)])
        }
        _ => c(S_OTHER, vec![s(&crate::pretty::expr(e))]),
    })
}

fn pattern(p: &Pattern, cx: &mut dyn QuoteCtx) -> IR {
    let c = |tag: u32, args: Vec<IR>| IR::Construct(tag, args);
    match &p.kind {
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
        ExprKind::App(f, args) => {
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
        ExprKind::Comptime(x) | ExprKind::Quote(x) => collect_unquote_calls(x, out),
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
            S_FLOAT => match &fs[0] {
                Value::F64(x) => ExprKind::Float {
                    value: *x,
                    suffix: None,
                },
                _ => return Err("malformed SFloat".into()),
            },
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
                    let Value::Record(kv) = p else {
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
                    let Value::Record(kv) = p else {
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
            S_COMPTIME => ExprKind::Comptime(Box::new(self.expr(&fs[0])?)),
            S_MACRO => {
                let mut args = Vec::new();
                for a in fs[1].list_items() {
                    args.push(self.expr(&a)?);
                }
                ExprKind::MacroCall(Self::str_of(&fs[0])?, args)
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
        ExprKind::App(f, args) => {
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
    Builder { next_id, span }.expr(v)
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
        ExprKind::App(f, args) => {
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
        ExprKind::Match(arms) => arms.iter_mut().for_each(|a| {
            unqualify_pat(&mut a.pat);
            unqualify_expr(&mut a.body)
        }),
        ExprKind::Comptime(x) | ExprKind::Quote(x) => unqualify_expr(x),
        _ => {}
    }
}
