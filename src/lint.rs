//! `fwp lint`: warnings about code that compiles but could be simpler or
//! is probably a mistake. Each rule has a short code; a comment
//! `# fwp:allow(code, ...)` directly above a declaration silences those
//! rules inside it.
//!
//! The rules look at the syntax tree of one file. The standard library's
//! names come from the type checker (a compilation of an empty program).

use std::collections::{HashMap, HashSet};
use std::sync::OnceLock;

use crate::ast::*;
use crate::diag::{Diagnostic, Span};
use crate::lexer::lex_with_comments;
use crate::parser::parse_module_recover;

/// The rules: code and description.
pub const RULES: &[(&str, &str)] = &[
    (
        "unused-binding",
        "a top-level binding that is not exported, not `main` and not used",
    ),
    ("redundant-id", "a `| id` stage, which does nothing"),
    (
        "map-fusion",
        "`map f | map g`, which is `map (f | g)` with one traversal",
    ),
    (
        "trivial-match",
        "a `match` whose only arm is `_ -> f`, which is just `f`",
    ),
    (
        "shadows-std",
        "a top-level definition with the name of a standard library function",
    ),
    ("missing-binding", "a signature without a binding"),
    (
        "filter-count",
        "`filter p | length`, which is `count p` without the list",
    ),
    (
        "filter-find",
        "`filter p | head`, which is `find p`, stopping at the first match",
    ),
    ("double-reverse", "`reverse | reverse`, which does nothing"),
    (
        "bool-if",
        "`if p (const True) (const False)`, which is `p` (and the other way round, `p | not`)",
    ),
];

/// A lint warning: its rule and the diagnostic (message ending in
/// `[code]`).
#[derive(Clone, Debug)]
pub struct Warning {
    pub code: &'static str,
    pub diag: Diagnostic,
}

/// The names the standard library defines (functions and constants).
pub fn std_names() -> &'static HashSet<String> {
    static NAMES: OnceLock<HashSet<String>> = OnceLock::new();
    NAMES.get_or_init(|| {
        let Ok(c) = crate::driver::check_source("<lint>", "", None) else {
            return HashSet::new();
        };
        c.env
            .globals
            .keys()
            .filter_map(|k| k.strip_prefix("std::"))
            .filter(|n| n.starts_with(|c: char| c.is_ascii_lowercase()))
            .filter(|n| !n.contains(['#', '[']))
            .map(str::to_string)
            .collect()
    })
}

/// Lint a source text (file id `file` in spans). Fails with the syntax
/// errors if it does not parse.
pub fn lint_source(text: &str, file: u32) -> Result<Vec<Warning>, Vec<Diagnostic>> {
    let mut next_id = 0;
    let (module, errors) = parse_module_recover(text, file, &mut next_id);
    if !errors.is_empty() {
        return Err(errors);
    }
    // the standard library's own files define its names
    let is_std = crate::driver::STD_SOURCES.iter().any(|(_, s)| *s == text);
    let mut out = lint_module(&module);
    out.retain(|w| !(is_std && w.code == "shadows-std"));
    let allowed = allowances(text, &module);
    out.retain(|w| {
        !allowed.iter().any(|(from, to, codes)| {
            (*from..=*to).contains(&w.diag.span.line) && codes.contains(w.code)
        })
    });
    out.sort_by_key(|w| (w.diag.span.line, w.diag.span.col));
    Ok(out)
}

fn warn(out: &mut Vec<Warning>, code: &'static str, span: Span, message: String) {
    out.push(Warning {
        code,
        diag: Diagnostic::warning(span, format!("{} [{}]", message, code)),
    });
}

/// The span from the start of `a` to the end of `b` when they are on one
/// line, else `a`.
fn cover(a: Span, b: Span) -> Span {
    if a.line == b.line && b.col >= a.col {
        Span {
            len: b.col + b.len - a.col,
            ..a
        }
    } else {
        a
    }
}

fn is_var(e: &Expr, name: &str) -> bool {
    matches!(&e.kind, ExprKind::Var(v) if v == name)
}

/// `map f`: the function mapped.
fn map_of(e: &Expr) -> Option<&Expr> {
    match &e.kind {
        ExprKind::App(f, args) if is_var(f, "map") && args.len() == 1 => Some(&args[0]),
        _ => None,
    }
}

/// `name x`: the argument of a one-argument application of `name`.
fn app1<'e>(e: &'e Expr, name: &str) -> Option<&'e Expr> {
    match &e.kind {
        ExprKind::App(f, args) if is_var(f, name) && args.len() == 1 => Some(&args[0]),
        _ => None,
    }
}

/// `const C`, for a constructor `C`.
fn is_const_ctor(e: &Expr, ctor: &str) -> bool {
    matches!(app1(e, "const"), Some(a) if matches!(&a.kind, ExprKind::Ctor(c) if c == ctor))
}

/// The last stage of a pipeline.
fn last_stage(e: &Expr) -> &Expr {
    match &e.kind {
        ExprKind::Pipe(_, b) => b,
        _ => e,
    }
}

pub fn lint_module(m: &Module) -> Vec<Warning> {
    let mut out = Vec::new();
    let bound: HashMap<&str, Span> = m
        .decls
        .iter()
        .filter_map(|d| match d {
            Decl::Bind(b) => Some((b.name.as_str(), b.span)),
            Decl::Foreign { name, span, .. } => Some((name.as_str(), *span)),
            _ => None,
        })
        .collect();
    let std = std_names();

    // expression rules
    for d in &m.decls {
        if matches!(d, Decl::Macro(_)) {
            continue;
        }
        for body in d.bodies() {
            body.walk(&mut |e| match &e.kind {
                ExprKind::Pipe(a, b) => {
                    if is_var(b, "id") && !bound.contains_key("id") {
                        warn(
                            &mut out,
                            "redundant-id",
                            cover(e.span, b.span),
                            "this `| id` stage does nothing; remove it".into(),
                        );
                    }
                    let prev = last_stage(a);
                    if let Some(p) = app1(prev, "filter").filter(|_| !bound.contains_key("filter")) {
                        let p = as_argument(crate::pretty::expr(p));
                        if is_var(b, "length") && !bound.contains_key("count") {
                            warn(
                                &mut out,
                                "filter-count",
                                cover(prev.span, b.span),
                                format!("this builds a list to count it; use `count {}`", p),
                            );
                        }
                        if is_var(b, "head") && !bound.contains_key("find") {
                            warn(
                                &mut out,
                                "filter-find",
                                cover(prev.span, b.span),
                                format!(
                                    "this filters the whole list for its first element; use `find {}`",
                                    p
                                ),
                            );
                        }
                    }
                    if is_var(prev, "reverse") && is_var(b, "reverse") && !bound.contains_key("reverse")
                    {
                        warn(
                            &mut out,
                            "double-reverse",
                            cover(prev.span, b.span),
                            "reversing twice does nothing; remove both".into(),
                        );
                    }
                    if !bound.contains_key("map") {
                        if let (Some(f), Some(g)) = (map_of(last_stage(a)), map_of(b)) {
                            let f = crate::pretty::expr(f);
                            let g = crate::pretty::expr(g);
                            warn(
                                &mut out,
                                "map-fusion",
                                cover(e.span, b.span),
                                format!(
                                    "`map {f} | map {g}` traverses twice; use `map ({f} | {g})`",
                                    f = paren_free(&f),
                                    g = paren_free(&g)
                                ),
                            );
                        }
                    }
                }
                ExprKind::App(f, args)
                    if is_var(f, "if") && args.len() == 3 && !bound.contains_key("if") =>
                {
                    let shown = crate::pretty::expr(&args[0]);
                    let p = paren_free(&shown);
                    let fix = if is_const_ctor(&args[1], "True") && is_const_ctor(&args[2], "False") {
                        Some(format!("`{}`", p))
                    } else if is_const_ctor(&args[1], "False") && is_const_ctor(&args[2], "True") {
                        Some(format!("`{} | not`", p))
                    } else {
                        None
                    };
                    if let Some(fix) = fix {
                        warn(
                            &mut out,
                            "bool-if",
                            e.span,
                            format!("this `if` gives its condition's own answer; use {}", fix),
                        );
                    }
                }
                ExprKind::Match(arms)
                    if arms.len() == 1 && matches!(arms[0].pat.kind, PatKind::Hole) =>
                {
                    warn(
                        &mut out,
                        "trivial-match",
                        Span { len: 5, ..e.span },
                        "a `match` with a single `_` arm is just its body".into(),
                    );
                }
                _ => {}
            });
        }
    }

    // top-level rules
    let exported: HashSet<&str> = m
        .decls
        .iter()
        .filter_map(|d| match d {
            Decl::Export { name, .. } => Some(name.as_str()),
            Decl::Sig { sig, export: true } => Some(sig.name.as_str()),
            _ => None,
        })
        .collect();
    let is_program = bound.contains_key("main") || !exported.is_empty();
    for d in &m.decls {
        match d {
            Decl::Bind(b) => {
                if std.contains(&b.name) {
                    warn(
                        &mut out,
                        "shadows-std",
                        b.span,
                        format!(
                            "`{}` hides the standard library function of the same name",
                            b.name
                        ),
                    );
                }
                let private = b.name != "main"
                    && !exported.contains(b.name.as_str())
                    && !b.name.starts_with('_');
                if is_program && private && !used_elsewhere(m, &b.name) {
                    warn(
                        &mut out,
                        "unused-binding",
                        b.span,
                        format!("`{}` is never used", b.name),
                    );
                }
            }
            Decl::Sig { sig, .. } if !bound.contains_key(sig.name.as_str()) => {
                warn(
                    &mut out,
                    "missing-binding",
                    sig.span,
                    format!("`{}` has a signature but no binding", sig.name),
                );
            }
            _ => {}
        }
    }
    out
}

/// `(f)` printed by the pretty printer, without its outer parentheses.
/// An expression written as an argument: in parentheses unless it is
/// one word.
fn as_argument(s: String) -> String {
    if s.contains(' ') && !(s.starts_with('(') && s.ends_with(')')) {
        format!("({})", s)
    } else {
        s
    }
}

fn paren_free(s: &str) -> &str {
    s.strip_prefix('(')
        .and_then(|s| s.strip_suffix(')'))
        .filter(|s| !s.contains(['(', ')']))
        .unwrap_or(s)
}

/// Whether a name is referred to outside its own binding.
fn used_elsewhere(m: &Module, name: &str) -> bool {
    m.decls.iter().any(|d| {
        if matches!(d, Decl::Bind(b) if b.name == name) {
            return false;
        }
        d.bodies().iter().any(|body| {
            let mut found = false;
            body.walk(&mut |e| found |= is_var(e, name));
            found
        })
    })
}

/// Line ranges of declarations preceded by `# fwp:allow(...)` comments,
/// and the codes allowed in each.
fn allowances(text: &str, m: &Module) -> Vec<(u32, u32, HashSet<String>)> {
    let Ok((_, comments)) = lex_with_comments(text, 0) else {
        return vec![];
    };
    // a binding belongs to the signature right before it
    let mut starts: Vec<u32> = m
        .decls
        .iter()
        .enumerate()
        .filter(|(i, d)| match (d, i.checked_sub(1).map(|j| &m.decls[j])) {
            (Decl::Bind(b), Some(Decl::Sig { sig, .. })) => sig.name != b.name,
            _ => true,
        })
        .map(|(_, d)| d.span().line)
        .collect();
    starts.sort();
    starts.dedup();
    let mut out = Vec::new();
    for (i, &start) in starts.iter().enumerate() {
        let end = starts.get(i + 1).map_or(u32::MAX, |n| n - 1);
        // the block of comment lines right above the declaration
        let mut codes = HashSet::new();
        let mut line = start;
        while let Some(c) = comments.iter().find(|c| c.line + 1 == line && c.col == 1) {
            if let Some(rest) = c
                .text
                .trim_start_matches('#')
                .trim()
                .strip_prefix("fwp:allow(")
            {
                let list = rest.split(')').next().unwrap_or("");
                codes.extend(list.split(',').map(|s| s.trim().to_string()));
            }
            line = c.line;
        }
        if !codes.is_empty() {
            out.push((start, end, codes));
        }
    }
    out
}
