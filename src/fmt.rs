//! `fwp fmt`: the source formatter.
//!
//! Declarations are printed from the syntax tree in a canonical layout:
//! 80 columns, 4-space indentation, long pipelines one stage per line with a
//! leading `|`, `match` arms on their own lines, long brackets one item per
//! line with trailing commas. Literals keep their original spelling.
//!
//! Comments are never lost: comments between declarations stay where they
//! are, and a declaration that contains a comment is kept as written (only
//! trailing whitespace is removed). Runs of blank lines become one.
//! Formatting is idempotent, and the result parses to the same syntax tree
//! as the input.

use crate::ast::*;
use crate::diag::{DResult, Span};
use crate::lexer::{lex_with_comments, Comment, Kw, Tok, Token};
use crate::parser::parse_module;

const WIDTH: usize = 80;
const INDENT: usize = 4;

/// Format a source text. Fails with the first syntax error.
pub fn format_source(text: &str) -> DResult<String> {
    let (toks, comments) = lex_with_comments(text, 0)?;
    let mut next_id = 0;
    let module = parse_module(text, 0, &mut next_id)?;
    let src = Source::new(text);
    let f = Fmt { src: &src };
    // each declaration owns the tokens from its first one to the next's
    let starts: Vec<usize> = module
        .decls
        .iter()
        .map(|d| {
            let line = d.span().line;
            toks.iter()
                .position(|t| t.bol && t.span.line == line)
                .unwrap_or(0)
        })
        .collect();
    let mut out = String::new();
    let mut prev_end = 0;
    for (i, d) in module.decls.iter().enumerate() {
        let first = &toks[starts[i]];
        let stop = starts.get(i + 1).copied().unwrap_or(toks.len() - 1);
        let start = first.span.line;
        let end = toks[starts[i]..stop]
            .iter()
            .map(|t| src.end_line(t))
            .max()
            .unwrap_or(start);
        gap(&mut out, &src, &comments, prev_end, Some(start));
        if comments.iter().any(|c| c.line >= start && c.line <= end) {
            for l in start..=end {
                out.push_str(src.line(l).trim_end());
                out.push('\n');
            }
        } else {
            out.push_str(&f.decl(d, first.tok == Tok::Keyword(Kw::Rec)));
            out.push('\n');
        }
        prev_end = end;
    }
    gap(&mut out, &src, &comments, prev_end, None);
    Ok(out)
}

/// Whether two source texts parse to the same syntax tree (node ids and
/// source positions aside).
pub fn same_program(a: &str, b: &str) -> bool {
    let (mut i, mut j) = (0, 0);
    match (parse_module(a, 0, &mut i), parse_module(b, 0, &mut j)) {
        (Ok(x), Ok(y)) => shape(&x) == shape(&y),
        _ => false,
    }
}

/// The debug form of a module without node ids and spans.
fn shape(m: &Module) -> String {
    let mut s = format!("{:?}", m);
    for (open, close) in [("id: ", ", "), ("span: Span {", "}, ")] {
        while let Some(at) = s.find(open) {
            let end = at + s[at..].find(close).unwrap() + close.len();
            s.replace_range(at..end, "");
        }
    }
    s
}

/// The comments between two declarations (or before the first, or after
/// the last), separated by single blank lines where the source had some.
fn gap(out: &mut String, src: &Source, comments: &[Comment], prev: u32, next: Option<u32>) {
    let mut last = prev;
    for c in comments
        .iter()
        .filter(|c| c.line > prev && next.is_none_or(|n| c.line < n))
    {
        if !out.is_empty() && src.blank_between(last, c.line) {
            out.push('\n');
        }
        out.push_str(&c.text);
        out.push('\n');
        last = c.line;
    }
    if let Some(n) = next {
        if !out.is_empty() && src.blank_between(last, n) {
            out.push('\n');
        }
    }
}

struct Source<'a> {
    text: &'a str,
    /// Byte offset of the start of each line.
    starts: Vec<usize>,
}

impl<'a> Source<'a> {
    fn new(text: &'a str) -> Self {
        let mut starts = vec![0];
        starts.extend(text.match_indices('\n').map(|(i, _)| i + 1));
        Source { text, starts }
    }

    fn line(&self, l: u32) -> &'a str {
        let Some(&s) = self.starts.get((l as usize).wrapping_sub(1)) else {
            return "";
        };
        let rest = &self.text[s..];
        rest.split('\n').next().unwrap_or("")
    }

    fn blank_between(&self, a: u32, b: u32) -> bool {
        (a + 1..b).any(|l| self.line(l).trim().is_empty())
    }

    /// The source text of a token: one line, or a string literal (which
    /// may span lines).
    fn spelling(&self, sp: Span) -> Option<&'a str> {
        let line = self.line(sp.line);
        let off = line
            .char_indices()
            .nth(sp.col.checked_sub(1)? as usize)
            .map(|(i, _)| i)?;
        let start = self.starts[sp.line as usize - 1] + off;
        let rest = &self.text[start..];
        if rest.starts_with('"') {
            let mut escaped = false;
            for (i, c) in rest.char_indices().skip(1) {
                match c {
                    _ if escaped => escaped = false,
                    '\\' => escaped = true,
                    '"' => return Some(&rest[..=i]),
                    _ => {}
                }
            }
            return None;
        }
        let end = rest
            .char_indices()
            .nth(sp.len as usize)
            .map_or(rest.len(), |(i, _)| i);
        let s = &rest[..end];
        (!s.contains('\n')).then_some(s)
    }

    fn end_line(&self, t: &Token) -> u32 {
        match &t.tok {
            Tok::Str(_) => {
                let n = self.spelling(t.span).map_or(0, |s| s.matches('\n').count());
                t.span.line + n as u32
            }
            _ => t.span.line,
        }
    }
}

fn width(s: &str) -> usize {
    s.chars().count()
}

fn pad(n: usize) -> String {
    " ".repeat(n)
}

/// Whether the first line of `s`, starting at column `col`, fits.
fn first_fits(s: &str, col: usize) -> bool {
    col + width(s.lines().next().unwrap_or("")) <= WIDTH
}

/// Whether a one-line text fits at column `col`.
fn fits(s: &str, col: usize) -> bool {
    !s.contains('\n') && col + width(s) <= WIDTH
}

/// `a | b | c` as `[a, b, c]` (pipes associate to the left).
fn stages(e: &Expr) -> Vec<&Expr> {
    match &e.kind {
        ExprKind::Pipe(a, b) => {
            let mut v = stages(a);
            v.push(b);
            v
        }
        _ => vec![e],
    }
}

fn params(ps: &[String]) -> String {
    if ps.is_empty() {
        String::new()
    } else {
        format!("[{}]", ps.join(", "))
    }
}

fn tys(ts: &[TypeExpr]) -> String {
    ts.iter()
        .map(crate::pretty::ty)
        .collect::<Vec<_>>()
        .join(", ")
}

fn constraints(cs: &[Constraint]) -> String {
    cs.iter()
        .map(|c| format!("{}[{}]", c.trait_name, tys(&c.args)))
        .collect::<Vec<_>>()
        .join(", ")
}

fn where_clause(cs: &[Constraint]) -> String {
    if cs.is_empty() {
        String::new()
    } else {
        format!(" where {}", constraints(cs))
    }
}

struct Fmt<'a> {
    src: &'a Source<'a>,
}

/// Expressions are printed by three families of functions, each given the
/// indentation of the line the expression starts on (`indent`) and the
/// column where it starts (`col`):
///
/// - `flat*`: the one-line form, if there is one;
/// - `hug*`: a form whose first line continues the current line and
///   whose last line closes at `indent` (`f (` ... `)`, `[` ... `]`,
///   `match` and its arms);
/// - `expr`/`app`/`atom`: the best form, broken over lines if needed.
///
/// Continuation lines are indented past `indent` (only closing brackets,
/// inside which layout is suspended, come back to it), so the offside rule
/// reads the result as one expression.
impl Fmt<'_> {
    // ----- declarations

    fn decl(&self, d: &Decl, rec_kw: bool) -> String {
        let rec = if rec_kw { "rec " } else { "" };
        match d {
            Decl::Import { module, .. } => format!("import {}", module),
            Decl::Export { name, .. } => format!("export {}", name),
            Decl::Sig { sig, export } => {
                format!(
                    "{}{}{}",
                    if *export { "export " } else { "" },
                    rec,
                    self.sig(sig)
                )
            }
            Decl::Bind(b) => self.rhs(&format!("{}{} =", rec, b.name), &b.body, 0),
            Decl::Macro(b) => self.rhs(&format!("macro {} =", b.name), &b.body, 0),
            Decl::Type(t) => self.type_decl(t),
            Decl::Trait(t) => {
                let mut s = format!("trait {}{}", t.name, params(&t.params));
                if !t.supers.is_empty() {
                    s.push_str(" : ");
                    s.push_str(&constraints(&t.supers));
                }
                let mut items: Vec<String> = Vec::new();
                for m in &t.methods {
                    items.push(self.sig(m));
                    items.extend(
                        t.defaults
                            .iter()
                            .filter(|b| b.name == m.name)
                            .map(|b| self.binding(b, INDENT)),
                    );
                }
                items.extend(
                    t.defaults
                        .iter()
                        .filter(|b| !t.methods.iter().any(|m| m.name == b.name))
                        .map(|b| self.binding(b, INDENT)),
                );
                s + &block(&items)
            }
            Decl::Impl(i) => {
                let head = format!(
                    "impl {}[{}]{}",
                    i.trait_name,
                    tys(&i.args),
                    where_clause(&i.constraints)
                );
                let items: Vec<String> =
                    i.bindings.iter().map(|b| self.binding(b, INDENT)).collect();
                head + &block(&items)
            }
            Decl::Foreign {
                abi,
                name,
                symbol,
                variadic,
                ty,
                constraints: cs,
                ..
            } => {
                let mut s = format!(
                    "foreign {} {} : {}{}",
                    crate::value::escape_str(abi),
                    name,
                    crate::pretty::ty(ty),
                    where_clause(cs)
                );
                if symbol != name {
                    s.push_str(&format!(" = {}", crate::value::escape_str(symbol)));
                }
                if let Some(n) = variadic {
                    s.push_str(&format!(" variadic {}", n));
                }
                s
            }
            Decl::Test { name, body, .. } => {
                let head = format!("test {} =", crate::value::escape_str(name));
                self.rhs(&head, body, 0)
            }
        }
    }

    fn sig(&self, s: &Sig) -> String {
        format!(
            "{} : {}{}",
            s.name,
            crate::pretty::ty(&s.ty),
            where_clause(&s.constraints)
        )
    }

    fn binding(&self, b: &Binding, indent: usize) -> String {
        let head = format!("{}{} =", if b.rec { "rec " } else { "" }, b.name);
        self.rhs(&head, &b.body, indent)
    }

    fn type_decl(&self, t: &TypeDecl) -> String {
        let prefix = if t.repr_c {
            "repr(C) "
        } else if t.resource {
            "resource "
        } else {
            ""
        };
        let head = format!("{}{}{} =", prefix, t.name, params(&t.params));
        match &t.body {
            TypeBody::Variants(vs) => {
                let mut s = head;
                for v in vs {
                    s.push_str(&format!("\n{}| {}", pad(INDENT), v.name));
                    for f in &v.fields {
                        s.push(' ');
                        s.push_str(&match f.kind {
                            TypeKind::Fun(..) => format!("({})", crate::pretty::ty(f)),
                            _ => crate::pretty::ty(f),
                        });
                    }
                }
                s
            }
            TypeBody::Record(fs) if fs.is_empty() => format!("{} {{}}", head),
            TypeBody::Record(fs) => {
                let items: Vec<String> = fs
                    .iter()
                    .map(|(n, t)| format!("{}: {}", n, crate::pretty::ty(t)))
                    .collect();
                let flat = format!("{} {{ {} }}", head, items.join(", "));
                if fits(&flat, 0) {
                    return flat;
                }
                let mut s = format!("{} {{\n", head);
                for i in items {
                    s.push_str(&format!("{}{},\n", pad(INDENT), i));
                }
                s.push('}');
                s
            }
            TypeBody::Alias(ty) => format!("{} {}", head, crate::pretty::ty(ty)),
            TypeBody::Opaque => format!("{} builtin", head),
        }
    }

    /// `head expr`: on one line when it fits; else a `match` starts on the
    /// head line; else the expression goes on the next line when it fits
    /// there; else it starts on the head line when it can (`f (` ... `)`,
    /// `[` ... `]`); else it is broken on the following lines.
    fn rhs(&self, head: &str, e: &Expr, indent: usize) -> String {
        let col = indent + width(head) + 1;
        let next = indent + INDENT;
        if let Some(f) = self.flat(e).filter(|f| fits(f, col)) {
            return format!("{} {}", head, f);
        }
        let ends_in_match = match &e.kind {
            ExprKind::Match(_) => true,
            ExprKind::Pipe(_, last) => matches!(last.kind, ExprKind::Match(_)),
            _ => false,
        };
        if ends_in_match {
            if let Some(s) = self.hug(e, indent, col).filter(|s| first_fits(s, col)) {
                return format!("{} {}", head, s);
            }
        }
        if let Some(f) = self.flat(e).filter(|f| fits(f, next)) {
            return format!("{}\n{}{}", head, pad(next), f);
        }
        if let Some(s) = self.hug(e, indent, col).filter(|s| first_fits(s, col)) {
            return format!("{} {}", head, s);
        }
        format!("{}\n{}{}", head, pad(next), self.expr(e, next, next))
    }

    // ----- one-line forms

    fn flat(&self, e: &Expr) -> Option<String> {
        match &e.kind {
            ExprKind::Pipe(..) => {
                let st = stages(e);
                let mut parts = vec![self.flat_app(st[0])?];
                for s in &st[1..] {
                    parts.push(self.flat_stage(s)?);
                }
                Some(parts.join(" | "))
            }
            ExprKind::Comptime(x) => Some(format!("comptime {}", self.flat_atom(x)?)),
            _ => self.flat_app(e),
        }
    }

    /// A pipe stage after the first: there `comptime` takes an application.
    fn flat_stage(&self, e: &Expr) -> Option<String> {
        match &e.kind {
            ExprKind::Comptime(x) => Some(format!("comptime {}", self.flat_app(x)?)),
            _ => self.flat_app(e),
        }
    }

    fn flat_app(&self, e: &Expr) -> Option<String> {
        match &e.kind {
            ExprKind::App(f, args) => {
                let mut s = self.flat_atom(f)?;
                for i in 0..args.len() {
                    s.push(' ');
                    s.push_str(&self.flat_arg(args, i, f)?);
                }
                Some(s)
            }
            _ => self.flat_atom(e),
        }
    }

    /// Argument `i` of an application of `f`, on one line.
    fn flat_arg(&self, args: &[Expr], i: usize, f: &Expr) -> Option<String> {
        let a = self.flat_atom(&args[i])?;
        Some(if arg_parens(args, i, f) {
            format!("({})", a)
        } else {
            a
        })
    }

    fn flat_list(&self, xs: &[Expr]) -> Option<String> {
        let parts: Option<Vec<String>> = xs.iter().map(|x| self.flat(x)).collect();
        Some(parts?.join(", "))
    }

    fn flat_atom(&self, e: &Expr) -> Option<String> {
        Some(match &e.kind {
            ExprKind::Int { .. }
            | ExprKind::Float { .. }
            | ExprKind::Str(_)
            | ExprKind::Trits(_)
            | ExprKind::Duration(_) => {
                let s = self.literal(e);
                if s.contains('\n') {
                    return None;
                }
                s
            }
            ExprKind::Var(v) => v.clone(),
            ExprKind::Ctor(c) => c.clone(),
            ExprKind::Selector(p) => format!(".{}", p.join(".")),
            ExprKind::App(..) | ExprKind::Pipe(..) | ExprKind::Comptime(_) => {
                format!("({})", self.flat(e)?)
            }
            ExprKind::Unit => "()".into(),
            ExprKind::Tuple(xs) if xs.len() == 1 => format!("({},)", self.flat(&xs[0])?),
            ExprKind::Tuple(xs) => format!("({})", self.flat_list(xs)?),
            ExprKind::List(xs) => format!("[{}]", self.flat_list(xs)?),
            ExprKind::MacroCall(n, xs) => format!("{}!({})", n, self.flat_list(xs)?),
            ExprKind::Match(_) => return None,
            ExprKind::Quote(x) => format!("quote {}", self.flat_atom(x)?),
            ExprKind::TypeOf(t) => format!("type[{}]", crate::pretty::ty(t)),
            _ => {
                let (open, fs) = fields_of(e)?;
                if fs.is_empty() {
                    return Some(format!("{}}}", open));
                }
                let parts: Option<Vec<String>> = fs
                    .iter()
                    .map(|(n, x)| Some(format!("{} = {}", n, self.flat(x)?)))
                    .collect();
                format!("{} {} }}", open, parts?.join(", "))
            }
        })
    }

    /// A literal keeps its source spelling.
    fn literal(&self, e: &Expr) -> String {
        match self.src.spelling(e.span) {
            Some(s) => s.to_string(),
            None => crate::pretty::atom(e),
        }
    }

    // ----- hugging forms: the first line continues the current one, the
    // last closes at `indent`

    fn hug(&self, e: &Expr, indent: usize, col: usize) -> Option<String> {
        match &e.kind {
            ExprKind::Match(arms) => Some(self.arms(arms, indent)),
            ExprKind::Comptime(x) => {
                Some(format!("comptime {}", self.hug_atom(x, indent, col + 9)?))
            }
            ExprKind::Pipe(..) => {
                let st = stages(e);
                let (last, init) = st.split_last()?;
                // `a | b | match` and the arms
                if let ExprKind::Match(arms) = &last.kind {
                    let prefix: Option<Vec<String>> = init
                        .iter()
                        .enumerate()
                        .map(|(i, s)| {
                            if i == 0 {
                                self.flat_app(s)
                            } else {
                                self.flat_stage(s)
                            }
                        })
                        .collect();
                    if let Some(p) = prefix {
                        return Some(format!("{} | {}", p.join(" | "), self.arms(arms, indent)));
                    }
                }
                // `[` ... `] | f | g` when the bracket must break anyway
                if !is_bracket(st[0]) || self.flat_atom(st[0]).is_some_and(|f| fits(&f, col)) {
                    return None;
                }
                let head = self.hug_atom(st[0], indent, col)?;
                let mut rest = String::new();
                for s in &st[1..] {
                    rest.push_str(" | ");
                    rest.push_str(&self.flat_stage(s)?);
                }
                let last_line = head.rsplit('\n').next().unwrap_or("");
                fits(&format!("{}{}", last_line, rest), 0).then(|| head + &rest)
            }
            ExprKind::App(f, args) => {
                // `f a (` ... `)` when `f` and the other arguments are simple
                let n = args.len() - 1;
                let mut line = self.flat_atom(f)?;
                for i in 0..n {
                    let a = self.flat_arg(args, i, f).filter(|a| !a.contains(' '))?;
                    line.push(' ');
                    line.push_str(&a);
                }
                line.push(' ');
                let at = col + width(&line);
                if let Some(a) = self.flat_arg(args, n, f).filter(|a| fits(a, at)) {
                    return Some(line + &a);
                }
                let last = if arg_parens(args, n, f) {
                    format!("({})", self.hug_atom(&args[n], indent, at + 1)?)
                } else {
                    self.hug_atom(&args[n], indent, at)?
                };
                Some(line + &last)
            }
            _ => self.hug_atom(e, indent, col),
        }
    }

    fn hug_atom(&self, e: &Expr, indent: usize, col: usize) -> Option<String> {
        match &e.kind {
            ExprKind::Match(arms) => Some(format!("({})", self.arms(arms, indent))),
            ExprKind::App(_, args) => {
                // nested hugs only for a closing bracket or `match`
                let last = args.last()?;
                let inner = (is_bracket(last) || matches!(last.kind, ExprKind::Match(_)))
                    .then(|| self.hug(e, indent, col + 1))
                    .flatten();
                Some(format!(
                    "({})",
                    inner.unwrap_or_else(|| self.app_lines(e, indent, col + 1))
                ))
            }
            ExprKind::Pipe(..) => {
                if let Some(h) = self.hug(e, indent, col + 1) {
                    return Some(format!("({})", h));
                }
                // `(f a` and the other stages, when the first stage fits or
                // is an application
                let first = stages(e)[0];
                let ok = matches!(first.kind, ExprKind::App(..))
                    || self.flat_app(first).is_some_and(|f| fits(&f, col + 1));
                ok.then(|| format!("({})", self.expr(e, indent + INDENT, col + 1)))
            }
            ExprKind::Comptime(_) => Some(format!("({})", self.hug(e, indent, col + 1)?)),
            ExprKind::Tuple(xs) if !xs.is_empty() => Some(self.items("(", ")", xs, indent)),
            ExprKind::List(xs) if !xs.is_empty() => Some(self.items("[", "]", xs, indent)),
            ExprKind::MacroCall(n, xs) if !xs.is_empty() => {
                Some(self.items(&format!("{}!(", n), ")", xs, indent))
            }
            _ => {
                let (open, fs) = fields_of(e)?;
                if fs.is_empty() {
                    return None;
                }
                let mut s = open;
                for (n, x) in fs {
                    s.push('\n');
                    s.push_str(&pad(indent + INDENT));
                    s.push_str(&self.rhs(&format!("{} =", n), x, indent + INDENT));
                    s.push(',');
                }
                Some(format!("{}\n{}}}", s, pad(indent)))
            }
        }
    }

    /// Bracketed items, one per line with trailing commas.
    fn items(&self, open: &str, close: &str, xs: &[Expr], indent: usize) -> String {
        let mut s = String::from(open);
        for x in xs {
            s.push('\n');
            s.push_str(&pad(indent + INDENT));
            s.push_str(&self.expr(x, indent + INDENT, indent + INDENT));
            s.push(',');
        }
        format!("{}\n{}{}", s, pad(indent), close)
    }

    /// `match` and its arms, one per line, indented past `indent`.
    fn arms(&self, arms: &[Arm], indent: usize) -> String {
        let mut s = String::from("match");
        for a in arms {
            let head = format!("{} ->", self.pattern(&a.pat, false));
            s.push('\n');
            s.push_str(&pad(indent + INDENT));
            s.push_str(&self.rhs(&head, &a.body, indent + INDENT));
        }
        s
    }

    fn pattern(&self, p: &Pattern, atom: bool) -> String {
        match &p.kind {
            PatKind::Hole => "_".into(),
            PatKind::Int { .. } | PatKind::Str(_) => match self.src.spelling(p.span) {
                Some(s) => s.to_string(),
                None => crate::pretty::pattern(p),
            },
            PatKind::Ctor(n, None) => n.clone(),
            PatKind::Ctor(n, Some(args)) => {
                let mut s = n.clone();
                for a in args {
                    s.push(' ');
                    s.push_str(&self.pattern(a, true));
                }
                if atom {
                    format!("({})", s)
                } else {
                    s
                }
            }
            PatKind::Tuple(ps) if ps.len() == 1 => format!("({},)", self.pattern(&ps[0], false)),
            PatKind::Tuple(ps) => {
                let ps: Vec<String> = ps.iter().map(|p| self.pattern(p, false)).collect();
                format!("({})", ps.join(", "))
            }
            PatKind::Unit => "()".into(),
        }
    }

    // ----- best forms

    fn expr(&self, e: &Expr, indent: usize, col: usize) -> String {
        if let Some(f) = self.flat(e).filter(|f| fits(f, col)) {
            return f;
        }
        if let Some(s) = self.hug(e, indent, col).filter(|s| first_fits(s, col)) {
            return s;
        }
        match &e.kind {
            ExprKind::Pipe(..) => {
                let st = stages(e);
                let mut s = self.app(st[0], indent, col);
                for (i, stage) in st.iter().enumerate().skip(1) {
                    s.push_str(&format!("\n{}| ", pad(indent)));
                    s.push_str(&match &stage.kind {
                        ExprKind::Comptime(x) => {
                            format!("comptime {}", self.app(x, indent, indent + 11))
                        }
                        // a bare `match` takes the rest of the pipe
                        ExprKind::Match(arms) if i + 1 == st.len() => self.arms(arms, indent),
                        _ => self.app(stage, indent, indent + 2),
                    });
                }
                s
            }
            ExprKind::Comptime(x) => format!("comptime {}", self.atom(x, indent, col + 9)),
            _ => self.app(e, indent, col),
        }
    }

    /// An application: on one line, or one argument per line when they all
    /// fit so, or hugging its last argument, or one argument per line.
    fn app(&self, e: &Expr, indent: usize, col: usize) -> String {
        if let Some(f) = self.flat_app(e).filter(|f| fits(f, col)) {
            return f;
        }
        let ExprKind::App(f, args) = &e.kind else {
            return self.atom(e, indent, col);
        };
        let lines_flat = (0..args.len()).all(|i| {
            self.flat_arg(args, i, f)
                .is_some_and(|a| fits(&a, indent + INDENT))
        });
        let last = args.last().unwrap();
        if !(lines_flat && !is_bracket(last) && !matches!(last.kind, ExprKind::Match(_))) {
            if let Some(s) = self.hug(e, indent, col).filter(|s| first_fits(s, col)) {
                return s;
            }
        }
        self.app_lines(e, indent, col)
    }

    /// An application with one argument per line.
    fn app_lines(&self, e: &Expr, indent: usize, col: usize) -> String {
        let ExprKind::App(f, args) = &e.kind else {
            return self.atom(e, indent, col);
        };
        let mut s = self.atom(f, indent, col);
        for i in 0..args.len() {
            s.push('\n');
            s.push_str(&pad(indent + INDENT));
            s.push_str(&self.arg(args, i, f, indent + INDENT, indent + INDENT));
        }
        s
    }

    fn arg(&self, args: &[Expr], i: usize, f: &Expr, indent: usize, col: usize) -> String {
        if arg_parens(args, i, f) {
            format!("({})", self.atom(&args[i], indent, col + 1))
        } else {
            self.atom(&args[i], indent, col)
        }
    }

    fn atom(&self, e: &Expr, indent: usize, col: usize) -> String {
        if let Some(f) = self.flat_atom(e).filter(|f| fits(f, col)) {
            return f;
        }
        if let Some(s) = self.hug_atom(e, indent, col).filter(|s| first_fits(s, col)) {
            return s;
        }
        match &e.kind {
            ExprKind::App(..) => format!("({})", self.app(e, indent, col + 1)),
            ExprKind::Pipe(..) | ExprKind::Comptime(_) => {
                format!("({})", self.expr(e, indent + INDENT, col + 1))
            }
            ExprKind::Quote(x) => format!("quote {}", self.atom(x, indent, col + 6)),
            _ => self
                .hug_atom(e, indent, col)
                .or_else(|| self.flat_atom(e))
                .unwrap_or_else(|| self.literal(e)),
        }
    }
}

/// Brackets and records: they break into one item per line.
fn is_bracket(e: &Expr) -> bool {
    match &e.kind {
        ExprKind::Tuple(xs) | ExprKind::List(xs) | ExprKind::MacroCall(_, xs) => !xs.is_empty(),
        _ => fields_of(e).is_some_and(|(_, fs)| !fs.is_empty()),
    }
}

/// Arguments that need parentheses: `make`, `with` and `update` forms
/// (for readability), and a record right after a constructor (`C { .. }`
/// would be a nominal record).
fn arg_parens(args: &[Expr], i: usize, f: &Expr) -> bool {
    let prev = if i == 0 { f } else { &args[i - 1] };
    match &args[i].kind {
        ExprKind::Make(..) | ExprKind::With(_) | ExprKind::Update(_) => true,
        ExprKind::Record(_) => matches!(prev.kind, ExprKind::Ctor(_)),
        _ => false,
    }
}

/// The opening text and fields of a record-like expression.
fn fields_of(e: &Expr) -> Option<(String, &[(String, Expr)])> {
    Some(match &e.kind {
        ExprKind::Record(fs) => ("{".into(), fs),
        ExprKind::NominalRecord(n, fs) => (format!("{} {{", n), fs),
        ExprKind::With(fs) => ("with {".into(), fs),
        ExprKind::Make(None, fs) => ("make {".into(), fs),
        ExprKind::Make(Some(n), fs) => (format!("make {} {{", n), fs),
        ExprKind::Update(fs) => ("update {".into(), fs),
        _ => return None,
    })
}

/// The body of a trait or impl: ` =` and one item per line, or ` = {}`.
fn block(items: &[String]) -> String {
    if items.is_empty() {
        return " = {}".into();
    }
    let mut s = String::from(" =");
    for i in items {
        s.push('\n');
        s.push_str(&pad(INDENT));
        s.push_str(i);
    }
    s
}

#[cfg(test)]
mod tests {
    use super::*;

    fn fmt(s: &str) -> String {
        let out = format_source(s).unwrap();
        assert!(same_program(s, &out), "changed the program:\n{}", out);
        assert_eq!(format_source(&out).unwrap(), out, "not idempotent");
        out
    }

    #[test]
    fn layout() {
        assert_eq!(
            fmt("x =   [1,2 ,3]|map(add 1)\n"),
            "x = [1, 2, 3] | map (add 1)\n"
        );
        assert_eq!(
            fmt("f = match\n  Some -> id\n  None -> const 0\n"),
            "f = match\n    Some -> id\n    None -> const 0\n"
        );
        let long = "main = () | read-all | words | map lower | frequencies | map.to-list | take 5 | each print\n";
        assert_eq!(
            fmt(long),
            "main =\n    ()\n    | read-all\n    | words\n    | map lower\n    | frequencies\n    | map.to-list\n    | take 5\n    | each print\n"
        );
    }

    #[test]
    fn spelling_and_ambiguities() {
        assert_eq!(
            fmt("x = [0xff, 1_000, 2s, 0t+-, \"a\\u{48}\"]\n"),
            "x = [0xff, 1_000, 2s, 0t+-, \"a\\u{48}\"]\n"
        );
        assert_eq!(fmt("x = (1,) | f\n"), "x = (1,) | f\n");
        assert_eq!(
            fmt("f = match\n    (_,) -> id\n"),
            "f = match\n    (_,) -> id\n"
        );
        assert_eq!(fmt("x = Some ({ a = 1 })\n"), "x = Some ({ a = 1 })\n");
        assert_eq!(
            fmt("x = curry (make P { a = .0 })\n"),
            "x = curry (make P { a = .0 })\n"
        );
        assert_eq!(
            fmt("rec f : I64 -> I64\nf = id\n"),
            "rec f : I64 -> I64\nf = id\n"
        );
    }

    #[test]
    fn comments_and_blank_lines() {
        let src = "\n\n# head\n\n\n\nx = 1   \n# between\ny = f # trailing\n    | g\n\n\n# tail\n";
        assert_eq!(
            fmt(src),
            "# head\n\nx = 1\n# between\ny = f # trailing\n    | g\n\n# tail\n"
        );
        assert!(!same_program("x = 1\n", "x = 2\n"));
    }
}
