//! Functions as command-line programs: what the arguments of an exported
//! function look like on a command line, and the help text, from its type
//! and doc comments. The interpreter (`src/exec.rs`) and the C runtime
//! (`runtime/fwp_rt_exec.c`) parse arguments with the same rules; the
//! texts (help, usage, defaults, completion scripts, the man page) are
//! computed here once for both.
//!
//! * A first parameter that is a record (other than a tuple or `Duration`)
//!   is an *options record*: its fields are flags, `--name value` or
//!   `--name=value`. `Bool` fields are switches (`--name`, `--no-name`),
//!   `Option[T]` fields are optional, `List[T]` fields repeatable, and
//!   other fields required unless the exported value `<fn>.defaults` or
//!   `defaults` (a record with some of the fields) gives them a default.
//! * A field comment `-c <NAME> text [env: VAR]` gives the flag a short
//!   form, a value name for the help and an environment variable that
//!   supplies the value when the flag is absent.
//! * The `#` comment block right above the `export` describes the command;
//!   a line `# args: NAME...` names its positional parameters, and a
//!   trailing `...` makes the last one (a `List`) take the remaining
//!   arguments; `# command: name` renames the command.
//! * Trailing positional parameters of type `Option[T]`, or with a default
//!   (a field of `<fn>.defaults` named like the argument), may be omitted.
//! * A value whose type is an enumeration (constructors without fields) is
//!   written as a constructor name, in any case, in kebab-case or not.
//! * A final `()` parameter is given implicitly.
//! * `--help`/`-h` print the help, `--version` the exported `version`,
//!   and the program's first argument `--completions SHELL` or `--man` a
//!   completion script or a man page (`src/cli_gen.rs`).
//! * A result `Outcome[T]` (lib/cli.fwp) is `T` written as usual, and the
//!   exit status.

use std::collections::{BTreeMap, BTreeSet};
use std::fmt::Write as _;

use crate::ast::{Decl, TypeBody};
use crate::ir::{FuncId, Program, TypeShape, MT};
use crate::value::{display, Value};

/// Documentation found in comments of the source files.
#[derive(Clone, Debug, Default)]
pub struct Docs {
    /// The leading comment block of the root file (when a blank line
    /// separates it from the first declaration).
    pub module: Vec<String>,
    /// Exported names: the comment block above the `export`.
    pub funcs: BTreeMap<String, FuncDoc>,
    /// Record types by unqualified name: their fields' comments.
    pub fields: BTreeMap<String, BTreeMap<String, FieldDoc>>,
    /// The `# grpc:` line of the module's comment (`src/rpc.rs`).
    pub grpc: Option<String>,
    /// The `# auth:`, `# cors:` and `# timeout:` lines of the module's
    /// comment, defaults of every REST endpoint (`src/rest.rs`).
    pub http: Vec<String>,
    /// Variant types whose comment has a line `json: untagged`: their
    /// JSON form is the value of a constructor alone (`src/jsontype.rs`).
    pub untagged: BTreeSet<String>,
    /// The `# expose:` line of the module's comment: the interfaces of
    /// every exported function without its own `# expose:`.
    pub expose: Option<Vec<String>>,
    /// Invalid `# expose:` lines, reported by the interfaces.
    pub expose_errors: Vec<String>,
}

#[derive(Clone, Debug, Default)]
pub struct FuncDoc {
    pub lines: Vec<String>,
    /// The names of `# args:`.
    pub args: Option<Vec<String>>,
    /// The name of `# command:`.
    pub command: Option<String>,
    /// The `# route:`, `# status:`, `# error:`, `# header:`, `# cookie:`,
    /// `# auth:`, `# timeout:`, `# response-header:`, `# accepts:` and
    /// `# produces:` lines of REST
    /// endpoints (`src/rest.rs`), without the `#`.
    pub http: Vec<String>,
    /// The gRPC name of `# grpc:` (`src/rpc.rs`).
    pub grpc: Option<String>,
    /// The interfaces of `# expose:` (`cli`, `rest`, `mcp`).
    pub expose: Option<Vec<String>>,
}

/// The interfaces an exported function can be exposed as.
pub const INTERFACES: &[&str] = &["cli", "rest", "mcp"];

/// The interfaces of an `# expose:` line, or what is wrong with it.
fn expose_line(text: &str) -> Result<Vec<String>, String> {
    let names: Vec<String> = text
        .split([' ', ','])
        .filter(|n| !n.is_empty())
        .map(str::to_string)
        .collect();
    if names.is_empty() {
        return Err(format!(
            "`# expose:` needs one or more of {}",
            INTERFACES.join(", ")
        ));
    }
    if let Some(n) = names.iter().find(|n| !INTERFACES.contains(&n.as_str())) {
        return Err(format!(
            "`# expose: {}`: unknown interface `{}` (expected {})",
            text.trim(),
            n,
            INTERFACES.join(", ")
        ));
    }
    Ok(names)
}

#[derive(Clone, Debug, Default, PartialEq)]
pub struct FieldDoc {
    pub doc: String,
    pub short: Option<char>,
    /// The value's name in the help: `<N>` in `-n <N>  how many`.
    pub placeholder: Option<String>,
    /// `[env: VAR]`: the variable that gives the value when the flag is
    /// absent.
    pub env: Option<String>,
    /// `[conflicts: a, b]`: options that cannot be given with this one.
    pub conflicts: Vec<String>,
    /// `[requires: a]`: options that must be given with this one.
    pub requires: Vec<String>,
    /// `json: name`: the field's name in JSON (typed JSON, REST).
    pub json: Option<String>,
    /// `header: X-Name`: a field of a REST options record read from this
    /// request header instead of the query.
    pub header: Option<String>,
    /// `cookie: name`: a field read from this cookie.
    pub cookie: Option<String>,
}

/// Comment lines of the module's description that configure its REST
/// server.
const MODULE_HTTP: &[&str] = &["auth:", "cors:", "timeout:"];

/// Comment lines of an exported function that configure its endpoint.
const FUNC_HTTP: &[&str] = &[
    "route:",
    "status:",
    "error:",
    "header:",
    "cookie:",
    "auth:",
    "timeout:",
    "response-header:",
    "accepts:",
    "produces:",
];

/// The text of a comment: without the `#`, one space and trailing space.
fn comment_text(c: &str) -> &str {
    let c = c.trim_start();
    let c = c.strip_prefix('#').unwrap_or(c);
    c.strip_prefix(' ').unwrap_or(c).trim_end()
}

/// A field comment: `-v`, `<NAME>` and `[env: VAR]`, then the text.
pub fn field_doc(text: &str) -> FieldDoc {
    let mut rest = text.trim();
    let mut d = FieldDoc::default();
    let mut cs = rest.chars();
    if let (Some('-'), Some(c)) = (cs.next(), cs.next()) {
        let after = cs.as_str();
        if c.is_ascii_alphabetic() && (after.is_empty() || after.starts_with([' ', ':', ','])) {
            d.short = Some(c);
            rest = after.trim_start_matches([':', ',']).trim_start();
        }
    }
    // a `--name` that repeats the long flag
    if let Some(r) = rest.strip_prefix("--") {
        if r.starts_with(|c: char| c.is_ascii_alphabetic()) {
            let end = r.find([' ', '=', ':']).unwrap_or(r.len());
            rest = r[end..].trim_start_matches(['=', ':']).trim_start();
        }
    }
    if let Some(r) = rest.strip_prefix('<') {
        if let Some(end) = r.find('>') {
            let name = &r[..end];
            if !name.is_empty() && !name.contains(char::is_whitespace) {
                d.placeholder = Some(name.to_string());
                rest = r[end + 1..].trim_start_matches([':', ',']).trim_start();
            }
        }
    }
    let mut doc = rest.to_string();
    let names = |v: Option<String>| -> Vec<String> {
        v.map(|v| {
            v.split([',', ' '])
                .map(|n| n.trim_start_matches('-').to_string())
                .filter(|n| !n.is_empty())
                .collect()
        })
        .unwrap_or_default()
    };
    // `json: name` (a line of its own, as `# json: type`)
    if let Some(n) = crate::jsontype::json_name(&doc).map(str::to_string) {
        doc = crate::jsontype::without_json_name(&doc);
        d.json = Some(n);
    }
    for (key, slot) in [("header", &mut d.header), ("cookie", &mut d.cookie)] {
        if let Some(n) = crate::jsontype::tagged(&doc, key).map(str::to_string) {
            doc = crate::jsontype::without_tag(&doc, key);
            *slot = Some(n);
        }
    }
    let mut take = |key: &str| -> Option<String> {
        let i = doc.find(&format!("[{}:", key))?;
        let j = doc[i..].find(']')?;
        let value = doc[i + key.len() + 2..i + j].trim().to_string();
        let before = doc[..i].trim_end();
        let after = doc[i + j + 1..].trim_start();
        doc = match (before.is_empty(), after.is_empty()) {
            (_, true) => before.to_string(),
            (true, false) => after.to_string(),
            (false, false) => format!("{} {}", before, after),
        };
        (!value.is_empty()).then_some(value)
    };
    d.env = take("env");
    d.conflicts = names(take("conflicts"));
    d.requires = names(take("requires"));
    d.doc = doc;
    d
}

impl Docs {
    /// Documentation of the files of a compilation: the root file first,
    /// then the other user files (for the record types they declare).
    pub fn from_sources(sm: &crate::diag::SourceMap, root: u32) -> Docs {
        let mut d = Docs::default();
        if let Some(f) = sm.files.get(root as usize) {
            d.add(&f.text, true);
        }
        for (i, f) in sm.files.iter().enumerate() {
            if i as u32 != root && !f.name.starts_with("<std>") {
                d.add(&f.text, false);
            }
        }
        d
    }

    /// Collect the documentation of one file from its syntax tree and
    /// comments: the comment lines directly above a declaration (or a
    /// field) document it, as does a comment after a field on its line.
    pub fn add(&mut self, text: &str, root: bool) {
        let Ok((toks, comments)) = crate::lexer::lex_with_comments(text, 0) else {
            return;
        };
        let mut next = 0;
        let (m, _) = crate::parser::parse_module_recover(text, 0, &mut next);
        let code: BTreeSet<u32> = toks
            .iter()
            .filter(|t| t.tok != crate::lexer::Tok::Eof)
            .map(|t| t.span.line)
            .collect();
        // comments alone on their line, and comments after code
        let mut alone: BTreeMap<u32, String> = BTreeMap::new();
        let mut trailing: BTreeMap<u32, String> = BTreeMap::new();
        for c in &comments {
            let t = comment_text(&c.text).to_string();
            if code.contains(&c.line) {
                trailing.insert(c.line, t);
            } else {
                alone.insert(c.line, t);
            }
        }
        // the comment lines right above `line`, below `floor`
        let above = |line: u32, floor: u32| -> Vec<String> {
            let mut v = Vec::new();
            let mut l = line;
            while l > floor + 1 {
                match alone.get(&(l - 1)) {
                    Some(t) => v.push(t.clone()),
                    None => break,
                }
                l -= 1;
            }
            v.reverse();
            v
        };
        // the module description
        if root && alone.contains_key(&1) {
            let mut k = 1;
            let mut block = Vec::new();
            while let Some(t) = alone.get(&k) {
                block.push(t.clone());
                k += 1;
            }
            if !code.contains(&k) {
                if block.first().is_some_and(|l| l.starts_with('!')) {
                    block.remove(0); // a `#!` line
                }
                if let Some(i) = block.iter().position(|l| l.starts_with("grpc:")) {
                    self.grpc = Some(block.remove(i)["grpc:".len()..].trim().to_string());
                }
                if let Some(i) = block.iter().position(|l| l.starts_with("expose:")) {
                    match expose_line(&block.remove(i)["expose:".len()..]) {
                        Ok(v) => self.expose = Some(v),
                        Err(e) => self.expose_errors.push(e),
                    }
                }
                let (http, rest): (Vec<String>, Vec<String>) = block
                    .into_iter()
                    .partition(|l| MODULE_HTTP.iter().any(|p| l.starts_with(p)));
                self.http = http;
                block = rest;
                self.module = trim_blank(block);
            }
        }
        // (a module description is separated from the first declaration
        // by a blank line, which ends the block above it)
        let doc_of = |line: u32| above(line, 0);
        let mut exported: Vec<(String, Vec<String>)> = Vec::new();
        let mut other: BTreeMap<String, Vec<String>> = BTreeMap::new();
        for d in &m.decls {
            match d {
                Decl::Sig { sig, export: true } => {
                    exported.push((sig.name.clone(), doc_of(sig.span.line)))
                }
                Decl::Export { span, name } => exported.push((name.clone(), doc_of(span.line))),
                Decl::Sig { sig, export: false } => {
                    let b = doc_of(sig.span.line);
                    if !b.is_empty() {
                        other.entry(sig.name.clone()).or_insert(b);
                    }
                }
                Decl::Bind(b) => {
                    let block = doc_of(b.span.line);
                    if !block.is_empty() {
                        other.entry(b.name.clone()).or_insert(block);
                    }
                }
                Decl::Type(td) => {
                    if doc_of(td.span.line)
                        .iter()
                        .any(|l| l.trim() == "json: untagged")
                    {
                        self.untagged.insert(td.name.clone());
                    }
                    let TypeBody::Record(fs) = &td.body else {
                        continue;
                    };
                    let lines: Vec<u32> = fs.iter().map(|(_, t)| t.span.line).collect();
                    let mut fields = BTreeMap::new();
                    for (i, (name, t)) in fs.iter().enumerate() {
                        let line = t.span.line;
                        let alone_on_line = lines.iter().filter(|l| **l == line).count() == 1;
                        let floor = if i == 0 { td.span.line } else { lines[i - 1] };
                        let text = match trailing.get(&line) {
                            Some(c) if alone_on_line && line != td.span.line => c.clone(),
                            _ => above(line, floor).join(" "),
                        };
                        fields.insert(name.clone(), field_doc(text.trim()));
                    }
                    if !fields.is_empty() {
                        self.fields.entry(td.name.clone()).or_insert(fields);
                    }
                }
                _ => {}
            }
        }
        if !root {
            return;
        }
        for (name, mut block) in exported {
            if block.is_empty() {
                block = other.get(&name).cloned().unwrap_or_default();
            }
            let mut doc = FuncDoc::default();
            for t in block {
                if let Some(a) = t.strip_prefix("args:") {
                    doc.args = Some(a.split_whitespace().map(str::to_string).collect());
                } else if let Some(c) = t.strip_prefix("command:") {
                    doc.command = Some(c.trim().to_string());
                } else if FUNC_HTTP.iter().any(|p| t.starts_with(p)) {
                    doc.http.push(t);
                } else if let Some(g) = t.strip_prefix("grpc:") {
                    doc.grpc = Some(g.trim().to_string());
                } else if let Some(e) = t.strip_prefix("expose:") {
                    match expose_line(e) {
                        Ok(v) => doc.expose = Some(v),
                        Err(e) => self.expose_errors.push(format!("above `{}`: {}", name, e)),
                    }
                } else if !t.starts_with("fwp:allow") {
                    doc.lines.push(t);
                }
            }
            doc.lines = trim_blank(doc.lines);
            self.funcs.entry(name).or_insert(doc);
        }
    }

    /// Whether the exported `name` is exposed as `interface`: its `#
    /// expose:` line, else the module's.
    pub fn exposed(&self, name: &str, interface: &str) -> bool {
        let local = name.rsplit("::").next().unwrap_or(name);
        self.funcs
            .get(local)
            .and_then(|d| d.expose.as_ref())
            .or(self.expose.as_ref())
            .is_some_and(|v| v.iter().any(|i| i == interface))
    }

    /// The first invalid `# expose:` line, or a line configuring an
    /// interface the function is not exposed as.
    pub fn check_expose(&self) -> Result<(), String> {
        if let Some(e) = self.expose_errors.first() {
            return Err(e.clone());
        }
        for (name, d) in &self.funcs {
            let lines = [
                ("cli", d.command.as_ref().map(|c| format!("command: {}", c))),
                ("rest", d.http.first().cloned()),
            ];
            for (interface, line) in lines {
                if let Some(l) = line {
                    if !self.exposed(name, interface) {
                        return Err(format!(
                            "`# {}` above `{}`: `{}` is not exposed as {} (add `{}` to its `# expose:` line)",
                            l, name, name, interface, interface
                        ));
                    }
                }
            }
        }
        Ok(())
    }

    /// The field comments of a record type (by its name, without its
    /// module).
    pub fn fields_of(&self, ty: &MT) -> Option<&BTreeMap<String, FieldDoc>> {
        match ty {
            MT::Con(n, _) => {
                let bare = n.rsplit("::").next().unwrap_or(n);
                let bare = bare.rsplit('.').next().unwrap_or(bare);
                self.fields.get(bare)
            }
            _ => None,
        }
    }
}

fn trim_blank(mut v: Vec<String>) -> Vec<String> {
    while v.first().is_some_and(|l| l.trim().is_empty()) {
        v.remove(0);
    }
    while v.last().is_some_and(|l| l.trim().is_empty()) {
        v.pop();
    }
    v
}

/// The first sentence of a description.
pub fn summary(lines: &[String]) -> String {
    let mut para = String::new();
    for l in lines {
        if l.trim().is_empty() {
            break;
        }
        if !para.is_empty() {
            para.push(' ');
        }
        para.push_str(l.trim());
    }
    match para.find(". ") {
        Some(i) => para[..=i].to_string(),
        None => para,
    }
}

// ------------------------------------------------------------ enumerations

/// The constructors of an enumeration: a type whose constructors have no
/// fields (other than `Bool`), in kebab-case.
pub fn choices(mt: &MT, prog: &Program) -> Option<Vec<String>> {
    if *mt == MT::con("std::Bool") {
        return None;
    }
    match prog.shapes.get(mt) {
        Some(TypeShape::Adt(vs)) if !vs.is_empty() && vs.iter().all(|(_, f)| f.is_empty()) => {
            Some(vs.iter().map(|(n, _)| kebab(n)).collect())
        }
        _ => None,
    }
}

/// `JsonLines` is `json-lines`.
pub fn kebab(name: &str) -> String {
    let mut out = String::new();
    let mut prev_lower = false;
    for c in name.chars() {
        if c.is_ascii_uppercase() {
            if prev_lower {
                out.push('-');
            }
            out.push(c.to_ascii_lowercase());
            prev_lower = false;
        } else {
            out.push(c);
            prev_lower = c.is_ascii_lowercase() || c.is_ascii_digit();
        }
    }
    out
}

/// A name compared without case, `-` and `_`.
fn loose(s: &str) -> String {
    s.chars()
        .filter(|c| *c != '-' && *c != '_')
        .map(|c| c.to_ascii_lowercase())
        .collect()
}

/// Parse a value given on the command line (an argument, a flag's value,
/// an environment variable): the text format, except that an enumeration
/// is a constructor name in any case. The error is the message after
/// `option ...: ` or `argument ...: `.
pub fn parse_value(text: &str, ty: &MT, prog: &Program) -> Result<Value, String> {
    if let Some(cs) = choices(ty, prog) {
        let t = loose(text);
        return match cs.iter().position(|c| loose(c) == t && !t.is_empty()) {
            Some(i) => Ok(Value::data(i as u32, vec![])),
            None => Err(format!("`{}` is not one of {}", text, cs.join(", "))),
        };
    }
    crate::textio::parse(text, ty, prog).map_err(|_| format!("cannot parse `{}` as {}", text, ty))
}

/// How a value is shown in the help: as the text format shows it, with
/// the constructors of enumerations in kebab-case.
fn show_value(v: &Value, ty: &MT, prog: &Program) -> String {
    match (choices(ty, prog), v) {
        (Some(cs), Value::Data(t, _)) => cs[*t as usize].clone(),
        _ => display(v, ty, prog, false),
    }
}

// ------------------------------------------------------------------ flags

/// How a flag takes values.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum FlagKind {
    /// A `Bool` field: `--name`, `--no-name`.
    Switch = 0,
    /// A required field (unless it has a default): `--name value`.
    Single = 1,
    /// An `Option[T]` field.
    Optional = 2,
    /// A `List[T]` field: each occurrence adds a value.
    Repeated = 3,
}

#[derive(Clone, Debug)]
pub struct Flag {
    /// The field name, which is the long flag.
    pub name: String,
    /// The field's position in the record value.
    pub index: usize,
    pub short: Option<char>,
    pub kind: FlagKind,
    /// The type of the field.
    pub field_ty: MT,
    /// The type of one value on the command line.
    pub value_ty: MT,
    pub doc: String,
    /// The value's name in the help (`<N>`), by default its type.
    pub placeholder: String,
    /// The environment variable that gives the value when the flag is
    /// absent.
    pub env: Option<String>,
    /// The values of an enumeration, in kebab-case.
    pub choices: Option<Vec<String>>,
    /// The flags (their positions) that cannot be given with this one.
    pub conflicts: Vec<usize>,
    /// The flags (their positions) that must be given with this one.
    pub requires: Vec<usize>,
    /// The names of `conflicts` and `requires` as written (for errors).
    pub constraint_names: (Vec<String>, Vec<String>),
}

/// The fields of an options record, as flags in declaration order.
#[derive(Clone, Debug)]
pub struct Options {
    pub record: MT,
    pub nfields: usize,
    pub flags: Vec<Flag>,
}

fn con_arg(mt: &MT, name: &str) -> Option<MT> {
    match mt {
        MT::Con(n, a) if n == name => a.first().cloned(),
        _ => None,
    }
}

pub fn list_elem(mt: &MT) -> Option<MT> {
    con_arg(mt, "std::List")
}

pub fn option_elem(mt: &MT) -> Option<MT> {
    con_arg(mt, "std::Option")
}

/// The fields of a record type that can be an options record: a nominal
/// or structural record that is not a tuple, unit or `Duration`.
fn record_fields(mt: &MT, prog: &Program) -> Option<Vec<(String, MT)>> {
    let fs = match mt {
        MT::Record(fs) => fs.clone(),
        MT::Con(n, _) if n == "std::Duration" => return None,
        MT::Con(..) => match prog.shapes.get(mt) {
            Some(TypeShape::Record(fs)) => fs.clone(),
            _ => return None,
        },
        _ => return None,
    };
    let tuple = fs
        .iter()
        .any(|(l, _)| l.starts_with(|c: char| c.is_ascii_digit()));
    (!fs.is_empty() && !tuple).then_some(fs)
}

/// Notes after a flag's or argument's description, in parentheses.
fn notes_text(doc: &str, notes: &[String]) -> String {
    let mut text = doc.to_string();
    if !notes.is_empty() {
        if !text.is_empty() {
            text.push(' ');
        }
        let _ = write!(text, "({})", notes.join("; "));
    }
    text
}

impl Options {
    /// The flags of record type `mt`, if it is one.
    pub fn of(mt: &MT, prog: &Program) -> Option<Options> {
        let fs = record_fields(mt, prog)?;
        let docs = prog.docs.fields_of(mt);
        // declaration order for nominal records
        let order: Vec<String> = match mt {
            MT::Con(n, _) => prog
                .field_order
                .get(n)
                .cloned()
                .unwrap_or_else(|| fs.iter().map(|(l, _)| l.clone()).collect()),
            _ => fs.iter().map(|(l, _)| l.clone()).collect(),
        };
        let mut flags = Vec::new();
        for name in order {
            let Some(index) = fs.iter().position(|(l, _)| *l == name) else {
                continue;
            };
            let ty = fs[index].1.clone();
            let (kind, value_ty) = if ty == MT::con("std::Bool") {
                (FlagKind::Switch, ty.clone())
            } else if let Some(t) = option_elem(&ty) {
                (FlagKind::Optional, t)
            } else if let Some(t) = list_elem(&ty) {
                (FlagKind::Repeated, t)
            } else {
                (FlagKind::Single, ty.clone())
            };
            let d = docs.and_then(|d| d.get(&name)).cloned().unwrap_or_default();
            flags.push(Flag {
                name,
                index,
                short: d.short,
                kind,
                placeholder: d.placeholder.unwrap_or_else(|| value_ty.to_string()),
                choices: choices(&value_ty, prog),
                field_ty: ty,
                value_ty,
                doc: d.doc,
                env: d.env,
                conflicts: Vec::new(),
                requires: Vec::new(),
                constraint_names: (d.conflicts, d.requires),
            });
        }
        // the constraints between flags, by position
        let pos = |n: &String| flags.iter().position(|f: &Flag| f.name == *n);
        let resolved: Vec<(Vec<usize>, Vec<usize>)> = flags
            .iter()
            .map(|f| {
                (
                    f.constraint_names.0.iter().filter_map(pos).collect(),
                    f.constraint_names.1.iter().filter_map(pos).collect(),
                )
            })
            .collect();
        for (f, (c, r)) in flags.iter_mut().zip(resolved) {
            f.conflicts = c;
            f.requires = r;
        }
        Some(Options {
            record: mt.clone(),
            nfields: fs.len(),
            flags,
        })
    }

    /// The left column of a flag's help line.
    fn left(f: &Flag) -> String {
        let mut s = match f.short {
            Some(c) => format!("-{}, --{}", c, f.name),
            None => format!("    --{}", f.name),
        };
        if f.kind != FlagKind::Switch {
            let _ = write!(s, " <{}>", f.placeholder);
        }
        s
    }

    /// The notes of a flag in the help, from its default note (`None`:
    /// no default), with the environment variable or not.
    fn notes(f: &Flag, default: Option<&String>, env: bool) -> Vec<String> {
        let mut notes = Vec::new();
        if let Some(cs) = &f.choices {
            notes.push(format!("one of: {}", cs.join(", ")));
        }
        match (f.kind, default) {
            (FlagKind::Single, None) => notes.push("required".into()),
            (FlagKind::Repeated, None) => notes.push("repeatable".into()),
            (FlagKind::Repeated, Some(d)) => {
                notes.push("repeatable".into());
                notes.push(format!("default: {}", d));
            }
            (_, Some(d)) => notes.push(format!("default: {}", d)),
            _ => {}
        }
        if let Some(c) = constraint_notes(f) {
            notes.push(c);
        }
        if let (true, Some(v)) = (env, &f.env) {
            notes.push(format!("env: {}", v));
        }
        notes
    }

    /// Help lines for the flags: (left column, description) pairs.
    fn rows(&self, defaults: &[Option<String>], env: bool) -> Vec<(String, String)> {
        self.flags
            .iter()
            .zip(defaults)
            .map(|(f, d)| {
                (
                    Self::left(f),
                    notes_text(&f.doc, &Self::notes(f, d.as_ref(), env)),
                )
            })
            .collect()
    }

    /// The help text of a default value, or `None` when it goes without
    /// saying (`False`, `None`, `[]`).
    pub fn default_note(f: &Flag, v: &Value, prog: &Program) -> Option<String> {
        match f.kind {
            FlagKind::Switch if matches!(v, Value::Data(0, _)) => None,
            FlagKind::Optional => match v {
                Value::Data(1, fs) => Some(show_value(&fs[0], &f.value_ty, prog)),
                _ => None,
            },
            FlagKind::Repeated if v.list_items().is_empty() => None,
            _ => Some(show_value(v, &f.field_ty, prog)),
        }
    }
}

/// The help notes of `[requires: ...]` and `[conflicts: ...]`.
pub fn constraint_notes(f: &Flag) -> Option<String> {
    let mut notes = Vec::new();
    for (k, word) in [
        (&f.constraint_names.1, "requires"),
        (&f.constraint_names.0, "not with"),
    ] {
        if !k.is_empty() {
            let flags: Vec<String> = k.iter().map(|n| format!("--{}", n)).collect();
            notes.push(format!("{} {}", word, flags.join(", ")));
        }
    }
    (!notes.is_empty()).then(|| notes.join("; "))
}

/// Format rows as two aligned columns, indented by two spaces.
pub fn columns(rows: &[(String, String)]) -> String {
    let w = rows
        .iter()
        .map(|(l, _)| l.chars().count())
        .max()
        .unwrap_or(0);
    let mut out = String::new();
    for (l, r) in rows {
        if r.is_empty() {
            let _ = writeln!(out, "  {}", l);
        } else {
            let pad = w - l.chars().count();
            let _ = writeln!(out, "  {}{}  {}", l, " ".repeat(pad), r);
        }
    }
    out
}

// ------------------------------------------------------------ positionals

/// How a positional parameter takes its argument.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum PosKind {
    Required = 0,
    /// A trailing `Option[T]` parameter: `None` when absent.
    Optional = 1,
    /// A trailing parameter with a default.
    Defaulted = 2,
    /// The last parameter, a `List`, takes the remaining arguments
    /// (`# args: FILE...`).
    Variadic = 3,
}

#[derive(Clone, Debug)]
pub struct Positional {
    /// The name in the usage and help: from `# args:`, or `<Type>`.
    pub name: String,
    /// The parameter's type.
    pub ty: MT,
    /// The type of one argument (`T` of an optional `Option[T]` or of a
    /// variadic `List[T]`).
    pub value_ty: MT,
    pub kind: PosKind,
    /// The canonical text of the default, at `ty`.
    pub default: Option<String>,
    /// The default as the help shows it.
    pub default_note: Option<String>,
    /// The values of an enumeration, in kebab-case.
    pub choices: Option<Vec<String>>,
}

/// What an argument completes to in a shell: a file or a directory.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum PathKind {
    File,
    Dir,
}

/// A `String` value named `FILE`, `PATH` or `DIR` (or ending in `-file`,
/// `_path`...) is a path.
pub fn path_kind(name: &str, ty: &MT) -> Option<PathKind> {
    if *ty != MT::con("std::String") {
        return None;
    }
    let u = name.to_ascii_uppercase();
    let last = u.rsplit(['-', '_']).next().unwrap_or(&u);
    match last {
        "FILE" | "FILES" | "PATH" | "PATHS" | "FILENAME" => Some(PathKind::File),
        "DIR" | "DIRS" | "DIRECTORY" | "DIRECTORIES" => Some(PathKind::Dir),
        _ => None,
    }
}

// --------------------------------------------------------------- commands

/// How the result of a command is written.
#[derive(Clone, Debug)]
pub struct Output {
    /// `Outcome[T]`: the positions of `output` and `status` in the record.
    pub outcome: Option<(usize, usize)>,
    /// `Result[T, E]`: the error type `E`.
    pub error: Option<MT>,
    /// `Option[T]` (after unwrapping a `Result`): `None` writes nothing.
    pub option: bool,
    /// `List[T]` (after unwrapping): one record per element.
    pub list: bool,
    /// The type of one output record.
    pub elem: MT,
}

impl Output {
    pub fn of(result: &MT, prog: &Program) -> Output {
        let mut t = result.clone();
        let mut outcome = None;
        if let MT::Con(n, a) = &t {
            if n == "std::Outcome" && a.len() == 1 {
                if let Some(TypeShape::Record(fs)) = prog.shapes.get(&t) {
                    let o = fs.iter().position(|(l, _)| l == "output");
                    let s = fs.iter().position(|(l, _)| l == "status");
                    if let (Some(o), Some(s)) = (o, s) {
                        outcome = Some((o, s));
                        t = a[0].clone();
                    }
                }
            }
        }
        let error = match &t {
            MT::Con(n, a) if n == "std::Result" && a.len() == 2 => {
                let e = a[1].clone();
                t = a[0].clone();
                Some(e)
            }
            _ => None,
        };
        let option = match option_elem(&t) {
            Some(x) => {
                t = x;
                true
            }
            None => false,
        };
        let list = match list_elem(&t) {
            Some(x) => {
                t = x;
                true
            }
            None => false,
        };
        Output {
            outcome,
            error,
            option,
            list,
            elem: t,
        }
    }
}

/// An exported function as a command.
#[derive(Clone, Debug)]
pub struct Command {
    /// The name in messages: `grep`, or `tools grep` in a multi-command
    /// program.
    pub name: String,
    /// The exported name.
    pub export: String,
    /// The command's name: the exported name, or the name of a
    /// `# command:` line.
    pub command: String,
    pub fid: FuncId,
    pub params: Vec<MT>,
    pub result: MT,
    pub output: Output,
    /// The options record (the first parameter), if there is one.
    pub options: Option<Options>,
    /// Defaults of the flags (`<fn>.defaults`): the canonical text of
    /// each field's value, parsed at the field's type when it is used.
    pub defaults: Vec<Option<String>>,
    /// The help notes of the defaults (`None`: not shown).
    pub default_notes: Vec<Option<String>>,
    /// The function's only parameter is a record with a required field:
    /// with no arguments, or a first argument that does not start with
    /// `-`, the record comes from stdin or the argument as before.
    pub record_fallback: bool,
    /// The positional parameters.
    pub positional: Vec<Positional>,
    /// The positional parameters have names (`# args:`).
    pub named: bool,
    /// The last parameter is `()`, which is given implicitly.
    pub unit_last: bool,
    /// The description (the comment block above the `export`).
    pub doc: Vec<String>,
    pub summary: String,
    /// The usage text printed on usage errors.
    pub usage: String,
    pub help: String,
    pub version: Option<String>,
}

impl Command {
    /// The positions of the positional parameters among the parameters
    /// (after the options record, before a final `()`).
    pub fn pos_range(&self) -> std::ops::Range<usize> {
        self.options.is_some() as usize..self.params.len() - self.unit_last as usize
    }

    /// The number of positional parameters.
    pub fn npos(&self) -> usize {
        self.positional.len()
    }

    /// The last positional parameter takes the remaining arguments.
    pub fn variadic(&self) -> bool {
        self.positional
            .last()
            .is_some_and(|p| p.kind == PosKind::Variadic)
    }

    /// The number of required positional parameters (which come first).
    pub fn nrequired(&self) -> usize {
        self.positional
            .iter()
            .filter(|p| p.kind == PosKind::Required)
            .count()
    }

    /// The last positional parameter may come from stdin: it is required
    /// (no parameter is optional or variadic).
    pub fn stdin_last(&self) -> bool {
        self.npos() > 0 && self.nrequired() == self.npos()
    }

    /// The environment variables of the flags.
    pub fn env_vars(&self) -> Vec<(&Flag, &str)> {
        match &self.options {
            Some(o) => o
                .flags
                .iter()
                .filter_map(|f| f.env.as_deref().map(|e| (f, e)))
                .collect(),
            None => Vec::new(),
        }
    }
}

/// Evaluate an exported constant with the interpreter.
fn eval_const(prog: &Program, fid: FuncId) -> Result<Value, String> {
    let mut it = crate::interp::Interp::new(prog, Box::new(std::io::sink()));
    it.call(fid, vec![]).map_err(|e| match e {
        crate::interp::Ctl::Trap(m) => format!("trap: {}", m),
        _ => "it fails".to_string(),
    })
}

/// The exported `version : String`, if there is one.
pub fn version(prog: &Program) -> Result<Option<String>, String> {
    let Some((_, fid)) = prog.exports.iter().find(|(n, _)| n == "version") else {
        return Ok(None);
    };
    let f = &prog.funcs[*fid];
    if f.arity != 0 || f.ty != MT::con("std::String") {
        return Err("the exported `version` must be a `String`".into());
    }
    match &eval_const(prog, *fid)? {
        Value::Str(s) => Ok(Some(s.to_string())),
        _ => Err("the exported `version` must be a `String`".into()),
    }
}

/// The error of an interface no exported function is exposed as.
pub fn none_exposed(interface: &str, what: &str) -> String {
    format!(
        "no exported function is exposed as {}: add a comment line `# expose: {}` above the `export` (or to the file's leading comment, for every export)",
        what, interface
    )
}

/// Whether an exported name is a command (not `version`, `defaults` or
/// the defaults of a command).
pub fn is_command(name: &str) -> bool {
    name != "version" && name != "defaults" && !name.ends_with(".defaults")
}

/// The exported functions exposed as `cli` as commands; `prefix` is the
/// program name of a multi-command program.
pub fn commands(prog: &Program, prefix: Option<&str>) -> Result<Vec<Command>, String> {
    let version = version(prog)?;
    prog.docs.check_expose()?;
    let mut out = Vec::new();
    for (name, fid) in &prog.exports {
        if is_command(name) && prog.docs.exposed(name, "cli") {
            out.push(command(prog, *fid, name, prefix, version.clone())?);
        }
    }
    Ok(out)
}

/// The field of a defaults record that gives a positional argument its
/// default: the argument's name in lower case (`DIR` is `dir`).
fn arg_field(name: &str) -> String {
    name.to_ascii_lowercase().replace('_', "-")
}

/// One exported function as a command.
pub fn command(
    prog: &Program,
    fid: FuncId,
    export: &str,
    prefix: Option<&str>,
    version: Option<String>,
) -> Result<Command, String> {
    let f = &prog.funcs[fid];
    let n = f.arity as usize;
    let (params, result) = f.ty.params(n);
    let params: Vec<MT> = params.into_iter().cloned().collect();
    let result = result.clone();
    let doc = prog.docs.funcs.get(export).cloned().unwrap_or_default();
    let command = doc.command.clone().unwrap_or_else(|| export.to_string());
    let name = match prefix {
        Some(p) => format!("{} {}", p, command),
        None => command.clone(),
    };
    let options = params.first().and_then(|p| Options::of(p, prog));
    if let Some(o) = &options {
        for f in &o.flags {
            for (names, word) in [
                (&f.constraint_names.0, "conflicts"),
                (&f.constraint_names.1, "requires"),
            ] {
                if let Some(n) = names
                    .iter()
                    .find(|n| !o.flags.iter().any(|g| g.name == **n))
                {
                    return Err(format!(
                        "`[{}: {}]` of the option `--{}`: `{}` has no option `--{}`",
                        word, n, f.name, o.record, n
                    ));
                }
            }
        }
    }
    let first = options.is_some() as usize;
    let unit_last = n > first && params[n - 1] == MT::unit();
    let pos_types = &params[first..n - unit_last as usize];
    let npos = pos_types.len();
    // the names of the positional parameters
    let (names, variadic) = match &doc.args {
        Some(names) => {
            if names.len() != npos {
                return Err(format!(
                    "the `# args:` line of `{}` names {} argument{}, but it has {}",
                    export,
                    names.len(),
                    if names.len() == 1 { "" } else { "s" },
                    npos
                ));
            }
            let mut names = names.clone();
            let mut variadic = false;
            if let Some(last) = names.last_mut() {
                if let Some(s) = last.strip_suffix("...") {
                    if list_elem(&pos_types[npos - 1]).is_none() {
                        return Err(format!(
                            "`{}...` in the `# args:` line of `{}` needs a `List` parameter",
                            s, export
                        ));
                    }
                    *last = s.to_string();
                    variadic = true;
                }
            }
            (Some(names), variadic)
        }
        None => (None, false),
    };
    // defaults: the program's `defaults` (the fields this command has),
    // then the command's own
    let nflags = options.as_ref().map_or(0, |o| o.flags.len());
    let mut defaults: Vec<Option<String>> = vec![None; nflags];
    let mut notes: Vec<Option<String>> = vec![None; nflags];
    let mut pos_defaults: Vec<Option<(String, String)>> = vec![None; npos];
    for (dname, partial) in [
        ("defaults".to_string(), true),
        (format!("{}.defaults", export), false),
    ] {
        let Some((_, did)) = prog.exports.iter().find(|(n, _)| *n == dname) else {
            continue;
        };
        let dty = prog.funcs[*did].ty.clone();
        let fs = record_fields(&dty, prog)
            .filter(|_| prog.funcs[*did].arity == 0)
            .ok_or_else(|| format!("`{}` must be a record", dname))?;
        let v = eval_const(prog, *did).map_err(|e| format!("`{}`: {}", dname, e))?;
        let Value::Record(vals) = &v else {
            return Err(format!("`{}` must be a record", dname));
        };
        for (i, (l, t)) in fs.iter().enumerate() {
            let flag = options
                .as_ref()
                .and_then(|o| o.flags.iter().position(|f| f.name == *l));
            if let (Some(k), Some(o)) = (flag, &options) {
                let fl = &o.flags[k];
                if *t != fl.field_ty {
                    return Err(format!(
                        "`{}`: the field `{}` is a `{}`, but the option `--{}` is a `{}`",
                        dname, l, t, l, fl.field_ty
                    ));
                }
                defaults[k] = Some(display(&vals[i], t, prog, true));
                notes[k] = Options::default_note(fl, &vals[i], prog);
                continue;
            }
            // the program's `defaults` are for options only
            let arg = names
                .as_ref()
                .filter(|_| !partial)
                .and_then(|ns| ns.iter().position(|a| arg_field(a) == *l));
            if let Some(j) = arg {
                if *t != pos_types[j] {
                    return Err(format!(
                        "`{}`: the field `{}` is a `{}`, but the argument `{}` is a `{}`",
                        dname,
                        l,
                        t,
                        names.as_ref().map_or("", |ns| &ns[j]),
                        pos_types[j]
                    ));
                }
                let note = match (variadic && j + 1 == npos, list_elem(t)) {
                    (true, Some(e)) => vals[i]
                        .list_items()
                        .iter()
                        .map(|x| show_value(x, &e, prog))
                        .collect::<Vec<_>>()
                        .join(" "),
                    _ => show_value(&vals[i], t, prog),
                };
                pos_defaults[j] = Some((display(&vals[i], t, prog, true), note));
                continue;
            }
            if !partial {
                return Err(format!(
                    "`{}` has a field `{}`, which is neither an option nor an argument of `{}`",
                    dname, l, export
                ));
            }
        }
    }
    // trailing `Option` or defaulted parameters are optional
    let fixed = npos - variadic as usize;
    let mut opt_from = fixed;
    while opt_from > 0
        && (pos_defaults[opt_from - 1].is_some() || option_elem(&pos_types[opt_from - 1]).is_some())
    {
        opt_from -= 1;
    }
    let mut positional = Vec::new();
    for (j, t) in pos_types.iter().enumerate() {
        let (kind, value_ty) = if variadic && j + 1 == npos {
            (PosKind::Variadic, list_elem(t).unwrap_or_else(MT::unit))
        } else if j >= opt_from && pos_defaults[j].is_some() {
            (PosKind::Defaulted, t.clone())
        } else if j >= opt_from {
            (PosKind::Optional, option_elem(t).unwrap_or_else(MT::unit))
        } else {
            (PosKind::Required, t.clone())
        };
        if kind == PosKind::Required && pos_defaults[j].is_some() {
            let ns = names.as_deref().unwrap_or(&[]);
            let later = (j + 1..fixed)
                .find(|k| pos_defaults[*k].is_none() && option_elem(&pos_types[*k]).is_none())
                .unwrap_or(j);
            return Err(format!(
                "the argument `{}` of `{}` has a default, but `{}` after it is required",
                ns.get(j).map_or("", |s| s),
                export,
                ns.get(later).map_or("", |s| s),
            ));
        }
        positional.push(Positional {
            name: match &names {
                Some(ns) => ns[j].clone(),
                None => format!("<{}>", value_ty),
            },
            ty: t.clone(),
            choices: choices(&value_ty, prog),
            value_ty,
            kind,
            default: pos_defaults[j].as_ref().map(|d| d.0.clone()),
            default_note: pos_defaults[j].as_ref().map(|d| d.1.clone()),
        });
    }
    let required = options.as_ref().is_some_and(|o| {
        o.flags
            .iter()
            .zip(&defaults)
            .any(|(f, d)| f.kind == FlagKind::Single && d.is_none())
    });
    let record_fallback = options.is_some() && n == 1 && required;
    let mut c = Command {
        name,
        export: export.to_string(),
        command,
        fid,
        params,
        output: Output::of(&result, prog),
        result,
        options,
        defaults,
        default_notes: notes,
        record_fallback,
        positional,
        named: doc.args.is_some(),
        unit_last,
        summary: summary(&doc.lines),
        doc: doc.lines.clone(),
        usage: String::new(),
        help: String::new(),
        version,
    };
    c.usage = usage_text(&c);
    c.help = help_text(&c);
    Ok(c)
}

/// The usage line without `usage: `.
pub fn synopsis(c: &Command) -> String {
    let mut s = c.name.clone();
    if c.options.is_some() {
        s.push_str(" [options]");
    }
    for p in &c.positional {
        let _ = match p.kind {
            PosKind::Required => write!(s, " {}", p.name),
            PosKind::Optional | PosKind::Defaulted => write!(s, " [{}]", p.name),
            PosKind::Variadic => write!(s, " [{}...]", p.name),
        };
    }
    s
}

fn usage_text(c: &Command) -> String {
    let mut s = format!("usage: {}", synopsis(c));
    if c.stdin_last() {
        s.push_str("\n  (the last argument may instead be given as records on stdin)");
    }
    s
}

/// The help rows of the positional parameters.
pub fn argument_rows(c: &Command) -> Vec<(String, String)> {
    let n = c.positional.len();
    c.positional
        .iter()
        .enumerate()
        .map(|(i, p)| {
            let last = i + 1 == n;
            // the type, unless it is the name already (`<I64>`)
            let mut parts = Vec::new();
            if c.named {
                parts.push(p.value_ty.to_string());
            }
            if let Some(cs) = &p.choices {
                parts.push(format!("one of: {}", cs.join(", ")));
            }
            match p.kind {
                PosKind::Variadic => parts.push("any number".into()),
                PosKind::Optional => parts.push("optional".into()),
                _ => {}
            }
            if let Some(d) = &p.default_note {
                parts.push(format!("default: {}", d));
            }
            if last && c.stdin_last() {
                parts.push(if list_elem(&p.ty).is_some() {
                    "or all lines of standard input".into()
                } else {
                    "or one per line of standard input".into()
                });
            }
            let left = if p.kind == PosKind::Variadic {
                format!("{}...", p.name)
            } else {
                p.name.clone()
            };
            (left, parts.join(", "))
        })
        .collect()
}

/// The rows of the flags `--help` and `--version` that a command has.
pub fn builtin_rows(c: &Command) -> Vec<(String, String)> {
    let mut rows = Vec::new();
    let short_h = c
        .options
        .as_ref()
        .is_some_and(|o| o.flags.iter().any(|f| f.short == Some('h')));
    if !has_flag(c, "help") {
        rows.push((
            if short_h { "    --help" } else { "-h, --help" }.to_string(),
            "show this help".into(),
        ));
    }
    if c.version.is_some() && !has_flag(c, "version") {
        rows.push(("    --version".into(), "show the version".into()));
    }
    rows
}

/// Whether the options record has a field named `n`.
pub fn has_flag(c: &Command, n: &str) -> bool {
    c.options
        .as_ref()
        .is_some_and(|o| o.flags.iter().any(|f| f.name == n))
}

/// The help rows of the flags of a command.
pub fn flag_rows(c: &Command) -> Vec<(String, String)> {
    match &c.options {
        Some(o) => o.rows(&c.default_notes, true),
        None => Vec::new(),
    }
}

fn help_text(c: &Command) -> String {
    let mut s = format!("usage: {}\n", synopsis(c));
    if !c.doc.is_empty() {
        s.push('\n');
        for l in &c.doc {
            s.push_str(l);
            s.push('\n');
        }
    }
    if !c.positional.is_empty() {
        s.push_str("\narguments:\n");
        s.push_str(&columns(&argument_rows(c)));
    }
    let mut rows = flag_rows(c);
    rows.extend(builtin_rows(c));
    s.push_str("\noptions:\n");
    s.push_str(&columns(&rows));
    s
}

/// The rows of the options of a multi-command program.
pub fn program_option_rows(cmds: &[Command]) -> Vec<(String, String)> {
    let mut opts = vec![("-h, --help".to_string(), "show this help".to_string())];
    if cmds.first().is_some_and(|c| c.version.is_some()) {
        opts.push(("    --version".into(), "show the version".into()));
    }
    opts.push((
        "    --completions <SHELL>".into(),
        "print a completion script for bash, zsh or fish".into(),
    ));
    opts.push(("    --man".into(), "print a man page".into()));
    opts
}

/// The help of a multi-command program.
pub fn program_help(name: &str, cmds: &[Command], prog: &Program) -> String {
    let mut s = format!("usage: {} <command> [arguments...]\n", name);
    if !prog.docs.module.is_empty() {
        s.push('\n');
        for l in &prog.docs.module {
            s.push_str(l);
            s.push('\n');
        }
    }
    let mut rows: Vec<(String, String)> = cmds
        .iter()
        .map(|c| (c.command.clone(), c.summary.clone()))
        .collect();
    if !cmds.iter().any(|c| c.command == "help") {
        rows.push(("help".into(), "show the help of a command".into()));
    }
    s.push_str("\ncommands:\n");
    s.push_str(&columns(&rows));
    s.push_str("\noptions:\n");
    s.push_str(&columns(&program_option_rows(cmds)));
    let _ = write!(
        s,
        "\nRun `{} help <command>` for the arguments of a command.\n",
        name
    );
    s
}

/// The usage line of a multi-command program.
pub fn program_usage(name: &str) -> String {
    format!(
        "usage: {} <command> [arguments...]\n  (`{} help` lists the commands)",
        name, name
    )
}

// ---------------------------------------------------------------- parsing

/// The result of parsing a command line.
pub enum Parsed {
    /// Field values by flag (`None`: not given) and positional arguments.
    Args(Vec<FlagValue>, Vec<String>),
    Help,
    Version,
}

#[derive(Clone, Debug)]
pub enum FlagValue {
    Unset,
    One(Value),
    Many(Vec<Value>),
}

/// Whether an argument that starts with `-` is a number (a positional).
fn is_number(a: &str) -> bool {
    a.len() > 1 && a[1..].starts_with(|c: char| c.is_ascii_digit() || c == '.')
}

/// Parse a command line: flags (when `flags` is given) and positional
/// arguments. With `special`, `--help`, `-h` and (when `version`)
/// `--version` are recognized unless a flag has that name. Errors are
/// messages without the program name.
pub fn parse_args(
    flags: Option<&[Flag]>,
    argv: &[String],
    special: bool,
    version: bool,
    prog: &Program,
) -> Result<Parsed, String> {
    let empty: &[Flag] = &[];
    let fl = flags.unwrap_or(empty);
    let by_name = |n: &str| fl.iter().position(|f| f.name == n);
    let mut vals = vec![FlagValue::Unset; fl.len()];
    let mut pos = Vec::new();
    let mut done = false;
    let mut i = 0;
    let set = |vals: &mut Vec<FlagValue>, k: usize, text: &str| -> Result<(), String> {
        let f = &fl[k];
        let v = parse_value(text, &f.value_ty, prog)
            .map_err(|m| format!("option `--{}`: {}", f.name, m))?;
        match (f.kind, &mut vals[k]) {
            (FlagKind::Repeated, FlagValue::Many(xs)) => xs.push(v),
            (FlagKind::Repeated, slot) => *slot = FlagValue::Many(vec![v]),
            (_, slot) => *slot = FlagValue::One(v),
        }
        Ok(())
    };
    while i < argv.len() {
        let a = &argv[i];
        i += 1;
        if done || a == "-" || !a.starts_with('-') || is_number(a) {
            pos.push(a.clone());
            continue;
        }
        if a == "--" {
            done = true;
            continue;
        }
        if let Some(body) = a.strip_prefix("--") {
            let (name, inline) = match body.split_once('=') {
                Some((n, v)) => (n, Some(v)),
                None => (body, None),
            };
            if special && inline.is_none() && by_name(name).is_none() {
                if name == "help" {
                    return Ok(Parsed::Help);
                }
                if name == "version" && version {
                    return Ok(Parsed::Version);
                }
            }
            if flags.is_none() {
                pos.push(a.clone());
                continue;
            }
            let k = match by_name(name) {
                Some(k) => k,
                None => {
                    let neg = name
                        .strip_prefix("no-")
                        .and_then(by_name)
                        .filter(|k| fl[*k].kind == FlagKind::Switch);
                    match (neg, inline) {
                        (Some(k), None) => {
                            vals[k] = FlagValue::One(Value::data(0, vec![]));
                            continue;
                        }
                        _ => return Err(format!("unknown option `--{}`", name)),
                    }
                }
            };
            if fl[k].kind == FlagKind::Switch {
                set(&mut vals, k, inline.unwrap_or("true"))?;
                continue;
            }
            let text = match inline {
                Some(t) => t.to_string(),
                None => match argv.get(i) {
                    Some(t) => {
                        i += 1;
                        t.clone()
                    }
                    None => return Err(format!("option `--{}` needs a value", name)),
                },
            };
            set(&mut vals, k, &text)?;
            continue;
        }
        // short flags: `-v`, `-iv`, `-n 5`, `-n5`
        let by_short = |c: char| fl.iter().position(|f| f.short == Some(c));
        if special && a == "-h" && by_short('h').is_none() {
            return Ok(Parsed::Help);
        }
        if flags.is_none() {
            pos.push(a.clone());
            continue;
        }
        let chars: Vec<char> = a[1..].chars().collect();
        let mut j = 0;
        while j < chars.len() {
            let c = chars[j];
            j += 1;
            let Some(k) = by_short(c) else {
                return Err(format!("unknown option `-{}`", c));
            };
            if fl[k].kind == FlagKind::Switch {
                set(&mut vals, k, "true")?;
                continue;
            }
            let text = if j < chars.len() {
                let t: String = chars[j..].iter().collect();
                j = chars.len();
                t
            } else {
                match argv.get(i) {
                    Some(t) => {
                        i += 1;
                        t.clone()
                    }
                    None => return Err(format!("option `--{}` needs a value", fl[k].name)),
                }
            };
            set(&mut vals, k, &text)?;
        }
    }
    Ok(Parsed::Args(vals, pos))
}

/// The value of a flag from its environment variable: `None` when the
/// variable is unset or empty. A switch also takes `1` and `0`.
pub fn env_value(f: &Flag, text: &str, prog: &Program) -> Result<Option<Value>, String> {
    if text.is_empty() {
        return Ok(None);
    }
    let var = f.env.as_deref().unwrap_or("");
    let text = match (f.kind, text) {
        (FlagKind::Switch, "1") => "true",
        (FlagKind::Switch, "0") => "false",
        _ => text,
    };
    let v = parse_value(text, &f.value_ty, prog)
        .map_err(|m| format!("environment variable `{}`: {}", var, m))?;
    Ok(Some(match f.kind {
        FlagKind::Optional => Value::data(1, vec![v]),
        FlagKind::Repeated => Value::list(vec![v]),
        _ => v,
    }))
}

/// Build the options record from parsed flag values, environment
/// variables (`env` looks one up) and defaults (the canonical text of
/// each default, or for `cli.parse` the values).
pub fn build_record(
    o: &Options,
    vals: Vec<FlagValue>,
    defaults: &[Option<Value>],
    env: &dyn Fn(&str) -> Option<String>,
    prog: &Program,
) -> Result<Value, String> {
    let mut fields = vec![Value::unit(); o.nfields];
    let mut present = vec![false; o.flags.len()];
    for (k, (f, v)) in o.flags.iter().zip(vals).enumerate() {
        let from_env = match (&v, &f.env) {
            (FlagValue::Unset, Some(var)) => match env(var) {
                Some(t) => env_value(f, &t, prog)?,
                None => None,
            },
            _ => None,
        };
        present[k] = !matches!(v, FlagValue::Unset) || from_env.is_some();
        fields[f.index] = match v {
            FlagValue::One(x) if f.kind == FlagKind::Optional => Value::data(1, vec![x]),
            FlagValue::One(x) => x,
            FlagValue::Many(xs) => Value::list(xs),
            FlagValue::Unset => match (from_env, &defaults[k], f.kind) {
                (Some(e), _, _) => e,
                (None, Some(d), _) => d.clone(),
                (None, None, FlagKind::Switch) | (None, None, FlagKind::Optional) => {
                    Value::data(0, vec![])
                }
                (None, None, FlagKind::Repeated) => Value::list(vec![]),
                (None, None, FlagKind::Single) => {
                    return Err(format!("missing option `--{}`", f.name));
                }
            },
        };
    }
    check_constraints(o, &present)?;
    Ok(Value::Record(fields.into()))
}

/// `[conflicts: ...]` and `[requires: ...]` of the flags that are given
/// (`present`: on the command line or by their environment variable).
fn check_constraints(o: &Options, present: &[bool]) -> Result<(), String> {
    for (k, f) in o.flags.iter().enumerate() {
        if !present[k] {
            continue;
        }
        if let Some(c) = f.conflicts.iter().find(|c| present[**c]) {
            return Err(format!(
                "option `--{}` cannot be used with `--{}`",
                f.name, o.flags[*c].name
            ));
        }
        if let Some(r) = f.requires.iter().find(|r| !present[**r]) {
            return Err(format!(
                "option `--{}` needs `--{}`",
                f.name, o.flags[*r].name
            ));
        }
    }
    Ok(())
}

/// The defaults of a command as values.
pub fn default_values(c: &Command, prog: &Program) -> Vec<Option<Value>> {
    let Some(o) = &c.options else {
        return Vec::new();
    };
    o.flags
        .iter()
        .zip(&c.defaults)
        .map(|(f, d)| {
            d.as_ref()
                .and_then(|t| crate::textio::parse(t, &f.field_ty, prog).ok())
        })
        .collect()
}

/// Why positional arguments do not fit a command.
pub enum ArgError {
    /// The wrong number of arguments: the usage.
    Usage,
    /// An argument that does not parse (the message).
    Value(String),
}

/// The values of the positional parameters from the arguments, and
/// whether the last one comes from standard input (it is then missing).
pub fn bind_positional(
    c: &Command,
    args: &[String],
    prog: &Program,
) -> Result<(Vec<Value>, bool), ArgError> {
    let ps = &c.positional;
    let k = args.len();
    let nreq = c.nrequired();
    let nfixed = ps.len() - c.variadic() as usize;
    let from_stdin = k < nreq;
    if (from_stdin && !(c.stdin_last() && k + 1 == nreq)) || (!c.variadic() && k > nfixed) {
        return Err(ArgError::Usage);
    }
    let parse = |i: usize, t: &MT| {
        parse_value(&args[i], t, prog)
            .map_err(|m| ArgError::Value(format!("argument {}: {}", i + 1, m)))
    };
    let default = |p: &Positional| {
        p.default
            .as_ref()
            .and_then(|d| crate::textio::parse(d, &p.ty, prog).ok())
    };
    let mut vals = Vec::new();
    let mut i = 0;
    for p in ps {
        match p.kind {
            PosKind::Required if i < k => {
                vals.push(parse(i, &p.value_ty)?);
                i += 1;
            }
            PosKind::Required => break,
            PosKind::Optional | PosKind::Defaulted if i < k => {
                let v = parse(i, &p.value_ty)?;
                vals.push(if p.kind == PosKind::Optional {
                    Value::data(1, vec![v])
                } else {
                    v
                });
                i += 1;
            }
            PosKind::Optional => vals.push(Value::data(0, vec![])),
            PosKind::Defaulted => vals.push(default(p).unwrap_or_else(Value::unit)),
            PosKind::Variadic => {
                let mut rest = Vec::new();
                while i < k {
                    rest.push(parse(i, &p.value_ty)?);
                    i += 1;
                }
                vals.push(match default(p) {
                    Some(d) if rest.is_empty() => d,
                    _ => Value::list(rest),
                });
            }
        }
    }
    Ok((vals, from_stdin))
}

/// `cli.parse`: the options record `T` (with `defaults` for every field)
/// and the positional arguments, or an error message.
pub fn parse_with(
    mt: &MT,
    defaults: &Value,
    argv: &[String],
    prog: &Program,
) -> Result<(Value, Vec<String>), String> {
    let Some(o) = Options::of(mt, prog) else {
        return Err(format!("`{}` is not a record of options", mt));
    };
    let Value::Record(dv) = defaults else {
        return Err(format!("`{}` is not a record of options", mt));
    };
    let ds: Vec<Option<Value>> = o.flags.iter().map(|f| Some(dv[f.index].clone())).collect();
    match parse_args(Some(&o.flags), argv, false, false, prog)? {
        Parsed::Args(vals, pos) => Ok((build_record(&o, vals, &ds, &|_| None, prog)?, pos)),
        _ => unreachable!("help and version are not recognized"),
    }
}

/// `cli.help`: the help lines of the flags of `T`, with the defaults of
/// `defaults`.
pub fn options_help(mt: &MT, defaults: &Value, prog: &Program) -> String {
    let Some(o) = Options::of(mt, prog) else {
        return String::new();
    };
    let Value::Record(dv) = defaults else {
        return String::new();
    };
    let notes: Vec<Option<String>> = o
        .flags
        .iter()
        .map(|f| Options::default_note(f, &dv[f.index], prog))
        .collect();
    columns(&o.rows(&notes, false))
}

/// For the C runtime: each flag's help line up to its description: the
/// left column (indented) and the padding before the description.
pub fn help_lefts(o: &Options) -> Vec<(String, String)> {
    let lefts: Vec<String> = o.flags.iter().map(Options::left).collect();
    let w = lefts.iter().map(|l| l.chars().count()).max().unwrap_or(0);
    lefts
        .iter()
        .map(|l| (format!("  {}", l), " ".repeat(w - l.chars().count() + 2)))
        .collect()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn field_comments() {
        let d = field_doc("-n, --count <N>  how many [env: COUNT]");
        assert_eq!(d.short, Some('n'));
        assert_eq!(d.placeholder.as_deref(), Some("N"));
        assert_eq!(d.env.as_deref(), Some("COUNT"));
        assert_eq!(d.doc, "how many");
        let d = field_doc("<FILE> where [requires: a, --b] to write [conflicts: c]");
        assert_eq!(d.short, None);
        assert_eq!(d.placeholder.as_deref(), Some("FILE"));
        assert_eq!(d.doc, "where to write");
        assert_eq!(d.requires, vec!["a", "b"]);
        assert_eq!(d.conflicts, vec!["c"]);
        let d = field_doc("-v  say more");
        assert_eq!((d.short, d.doc.as_str()), (Some('v'), "say more"));
        // not annotations
        let d = field_doc("-1 is a number, <not a name>");
        assert_eq!((d.short, d.placeholder), (None, None));
    }

    #[test]
    fn names() {
        assert_eq!(kebab("JsonLines"), "json-lines");
        assert_eq!(kebab("Http2"), "http2");
        assert_eq!(loose("CSV_lines"), loose("csv-lines"));
        let s = MT::con("std::String");
        assert_eq!(path_kind("FILE", &s), Some(PathKind::File));
        assert_eq!(path_kind("config-file", &s), Some(PathKind::File));
        assert_eq!(path_kind("DIR", &s), Some(PathKind::Dir));
        assert_eq!(path_kind("NAME", &s), None);
        assert_eq!(path_kind("FILE", &MT::con("std::I64")), None);
    }
}
