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
