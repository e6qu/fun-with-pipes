//! Functions as command-line programs: what the arguments of an exported
//! function look like on a command line, and the help text, from its type
//! and doc comments. The interpreter (`src/exec.rs`) and the C runtime
//! (`runtime/fwp_rt_exec.c`) parse arguments with the same rules; the
//! texts (help, usage, defaults) are computed here once for both.
//!
//! * A first parameter that is a record (other than a tuple or `Duration`)
//!   is an *options record*: its fields are flags, `--name value` or
//!   `--name=value`. `Bool` fields are switches (`--name`, `--no-name`),
//!   `Option[T]` fields are optional, `List[T]` fields repeatable, and
//!   other fields required unless the exported value `<fn>.defaults` or
//!   `defaults` (a record with some of the fields) gives them a default.
//! * A field comment that starts with `-c` gives the flag a short form.
//! * The `#` comment block right above the `export` describes the command;
//!   a line `# args: NAME...` names its positional parameters, and a
//!   trailing `...` makes the last one (a `List`) take the remaining
//!   arguments; `# command: name` renames the command.
//! * A final `()` parameter is given implicitly.
//! * `--help`/`-h` print the help, `--version` the exported `version`.

use std::collections::BTreeMap;
use std::fmt::Write as _;

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
}

#[derive(Clone, Debug, Default)]
pub struct FuncDoc {
    pub lines: Vec<String>,
    /// The names of `# args:`.
    pub args: Option<Vec<String>>,
    /// The name of `# command:`.
    pub command: Option<String>,
}

#[derive(Clone, Debug, Default, PartialEq)]
pub struct FieldDoc {
    pub doc: String,
    pub short: Option<char>,
}

fn comment_text(line: &str) -> Option<&str> {
    let t = line.trim_start();
    let c = t.strip_prefix('#')?;
    Some(c.strip_prefix(' ').unwrap_or(c).trim_end())
}

fn is_ident_char(c: char) -> bool {
    c.is_ascii_alphanumeric() || c == '-' || c == '_' || c == '.'
}

/// A field comment `-v  text`: the short flag and the text.
fn short_flag(doc: &str) -> FieldDoc {
    let mut cs = doc.chars();
    if let (Some('-'), Some(c)) = (cs.next(), cs.next()) {
        let rest = cs.as_str();
        if c.is_ascii_alphabetic() && (rest.is_empty() || rest.starts_with([' ', ':', ','])) {
            let rest = rest.trim_start_matches([':', ',']).trim();
            return FieldDoc {
                doc: rest.to_string(),
                short: Some(c),
            };
        }
    }
    FieldDoc {
        doc: doc.to_string(),
        short: None,
    }
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

    /// Collect the documentation of one file.
    pub fn add(&mut self, text: &str, root: bool) {
        let lines: Vec<&str> = text.lines().collect();
        // the module description
        if root {
            let mut i = 0;
            let mut block = Vec::new();
            while i < lines.len() && lines[i].starts_with('#') {
                if let Some(t) = comment_text(lines[i]) {
                    block.push(t.to_string());
                }
                i += 1;
            }
            if !block.is_empty() && (i >= lines.len() || lines[i].trim().is_empty()) {
                if block.first().is_some_and(|l| l.starts_with('!')) {
                    block.remove(0); // a `#!` line
                }
                self.module = trim_blank(block);
            }
        }
        for (i, l) in lines.iter().enumerate() {
            // `export name ...` (a signature or a bare export)
            if let Some(rest) = l.strip_prefix("export ") {
                let name: String = rest.chars().take_while(|c| is_ident_char(*c)).collect();
                if name.is_empty() || !root {
                    continue;
                }
                let mut j = i;
                let mut block = Vec::new();
                while j > 0 && lines[j - 1].starts_with('#') {
                    j -= 1;
                    block.push(comment_text(lines[j]).unwrap_or("").to_string());
                }
                block.reverse();
                // a comment block that starts the file and is followed by a
                // blank line describes the module, not this export
                let mut doc = FuncDoc::default();
                for t in block {
                    if let Some(a) = t.strip_prefix("args:") {
                        doc.args = Some(a.split_whitespace().map(str::to_string).collect());
                    } else if let Some(c) = t.strip_prefix("command:") {
                        doc.command = Some(c.trim().to_string());
                    } else if !t.starts_with("fwp:allow") {
                        doc.lines.push(t);
                    }
                }
                doc.lines = trim_blank(doc.lines);
                self.funcs.entry(name).or_insert(doc);
                continue;
            }
            // `Name = {` or `Name[T] = {`, possibly `repr(C) Name = {`
            let decl = l.strip_prefix("repr(C) ").unwrap_or(l);
            if !decl.starts_with(|c: char| c.is_ascii_uppercase()) {
                continue;
            }
            let name: String = decl.chars().take_while(|c| is_ident_char(*c)).collect();
            let Some(eq) = decl.find('=') else {
                continue;
            };
            if decl[..eq].contains(':') || !decl[eq + 1..].trim_start().starts_with('{') {
                continue;
            }
            let mut fields = BTreeMap::new();
            let mut pending: Vec<String> = Vec::new();
            let mut body: Vec<&str> = vec![&decl[eq + 1..]];
            body.extend(
                lines[i + 1..]
                    .iter()
                    .take_while(|l| l.is_empty() || l.starts_with([' ', '\t', '}']))
                    .copied(),
            );
            for b in body {
                let t = b.trim().trim_start_matches('{').trim();
                if let Some(c) = comment_text(t) {
                    pending.push(c.to_string());
                    continue;
                }
                let field: String = t.chars().take_while(|c| is_ident_char(*c)).collect();
                if !field.is_empty() && t[field.len()..].trim_start().starts_with(':') {
                    // a trailing comment on the field's line
                    let trailing = t.find('#').and_then(|k| comment_text(&t[k..]));
                    let text = match trailing {
                        Some(c) => c.to_string(),
                        None => pending.join(" "),
                    };
                    fields.insert(field, short_flag(text.trim()));
                }
                pending.clear();
                if t.contains('}') {
                    break;
                }
            }
            if !fields.is_empty() {
                self.fields.entry(name).or_insert(fields);
            }
        }
    }

    /// The field comments of a record type (by its canonical name).
    pub fn fields_of(&self, ty: &MT) -> Option<&BTreeMap<String, FieldDoc>> {
        match ty {
            MT::Con(n, _) => self.fields.get(&MT::short_name(n)),
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
fn summary(lines: &[String]) -> String {
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
            } else if let Some(t) = con_arg(&ty, "std::Option") {
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
                field_ty: ty,
                value_ty,
                doc: d.doc,
            });
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
            let _ = write!(s, " <{}>", f.value_ty);
        }
        s
    }

    /// Help lines for the flags: (left column, description) pairs.
    fn rows(&self, defaults: &[Option<String>]) -> Vec<(String, String)> {
        self.flags
            .iter()
            .zip(defaults)
            .map(|(f, d)| {
                let note = match (f.kind, d) {
                    (FlagKind::Single, None) => "(required)".to_string(),
                    (FlagKind::Repeated, None) => "(repeatable)".to_string(),
                    (FlagKind::Repeated, Some(d)) => format!("(repeatable; default: {})", d),
                    (_, Some(d)) => format!("(default: {})", d),
                    _ => String::new(),
                };
                let mut text = f.doc.clone();
                if !note.is_empty() {
                    if !text.is_empty() {
                        text.push(' ');
                    }
                    text.push_str(&note);
                }
                (Self::left(f), text)
            })
            .collect()
    }

    /// The help text of a default value, or `None` when it goes without
    /// saying (`False`, `None`, `[]`).
    pub fn default_note(kind: FlagKind, v: &Value, ty: &MT, prog: &Program) -> Option<String> {
        match kind {
            FlagKind::Switch if matches!(v, Value::Data(0, _)) => None,
            FlagKind::Optional => match v {
                Value::Data(1, fs) => {
                    Some(display(&fs[0], &con_arg(ty, "std::Option")?, prog, false))
                }
                _ => None,
            },
            FlagKind::Repeated if v.list_items().is_empty() => None,
            _ => Some(display(v, ty, prog, false)),
        }
    }
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

// --------------------------------------------------------------- commands

/// How the result of a command is written.
#[derive(Clone, Debug)]
pub struct Output {
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
    pub fn of(result: &MT) -> Output {
        let mut t = result.clone();
        let error = match &t {
            MT::Con(n, a) if n == "std::Result" && a.len() == 2 => {
                let e = a[1].clone();
                t = a[0].clone();
                Some(e)
            }
            _ => None,
        };
        let option = match con_arg(&t, "std::Option") {
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
    /// The function's only parameter is a record with a required field:
    /// with no arguments, or a first argument that does not start with
    /// `-`, the record comes from stdin or the argument as before.
    pub record_fallback: bool,
    /// Display names of the positional parameters.
    pub positional: Vec<String>,
    /// The last positional parameter takes the remaining arguments.
    pub variadic: bool,
    /// The positional parameters have names (`# args:`).
    pub named: bool,
    /// The last parameter is `()`, which is given implicitly.
    pub unit_last: bool,
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
        self.pos_range().len()
    }

    /// The last positional parameter may come from stdin.
    pub fn stdin_last(&self) -> bool {
        !self.variadic && self.npos() > 0
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

/// Whether an exported name is a command (not `version`, `defaults` or
/// the defaults of a command).
pub fn is_command(name: &str) -> bool {
    name != "version" && name != "defaults" && !name.ends_with(".defaults")
}

/// The exported functions of a program as commands; `prefix` is the
/// program name of a multi-command program.
pub fn commands(prog: &Program, prefix: Option<&str>) -> Result<Vec<Command>, String> {
    let version = version(prog)?;
    let mut out = Vec::new();
    for (name, fid) in &prog.exports {
        if is_command(name) {
            out.push(command(prog, *fid, name, prefix, version.clone())?);
        }
    }
    Ok(out)
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
    // defaults
    let mut defaults = Vec::new();
    let mut notes = Vec::new();
    if let Some(o) = &options {
        defaults = vec![None; o.flags.len()];
        notes = vec![None; o.flags.len()];
        // the program's `defaults` (the fields this record has), then the
        // command's own
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
                let Some(k) = o.flags.iter().position(|f| f.name == *l) else {
                    if partial {
                        continue;
                    }
                    return Err(format!(
                        "`{}` has a field `{}`, which `{}` does not have",
                        dname, l, o.record
                    ));
                };
                let fl = &o.flags[k];
                if *t != fl.field_ty {
                    return Err(format!(
                        "`{}`: the field `{}` is a `{}`, but the option `--{}` is a `{}`",
                        dname, l, t, l, fl.field_ty
                    ));
                }
                defaults[k] = Some(display(&vals[i], t, prog, true));
                notes[k] = Options::default_note(fl.kind, &vals[i], t, prog);
            }
        }
    }
    let required = options.as_ref().is_some_and(|o| {
        o.flags
            .iter()
            .zip(&defaults)
            .any(|(f, d)| f.kind == FlagKind::Single && d.is_none())
    });
    let record_fallback = options.is_some() && n == 1 && required;
    let first = options.is_some() as usize;
    let unit_last = n > first && params[n - 1] == MT::unit();
    let pos_types = &params[first..n - unit_last as usize];
    let npos = pos_types.len();
    let (positional, variadic) = match &doc.args {
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
            (names, variadic)
        }
        None => (
            pos_types.iter().map(|t| format!("<{}>", t)).collect(),
            false,
        ),
    };
    let mut c = Command {
        name,
        export: export.to_string(),
        command,
        fid,
        params,
        output: Output::of(&result),
        result,
        options,
        defaults,
        record_fallback,
        positional,
        variadic,
        named: doc.args.is_some(),
        unit_last,
        summary: summary(&doc.lines),
        usage: String::new(),
        help: String::new(),
        version,
    };
    c.usage = usage_text(&c);
    c.help = help_text(&c, &doc.lines, &notes);
    Ok(c)
}

fn usage_line(c: &Command) -> String {
    let mut s = format!("usage: {}", c.name);
    if c.options.is_some() {
        s.push_str(" [options]");
    }
    for (i, p) in c.positional.iter().enumerate() {
        if c.variadic && i + 1 == c.positional.len() {
            let _ = write!(s, " [{}...]", p);
        } else {
            let _ = write!(s, " {}", p);
        }
    }
    s
}

fn usage_text(c: &Command) -> String {
    let mut s = usage_line(c);
    if c.stdin_last() {
        s.push_str("\n  (the last argument may instead be given as records on stdin)");
    }
    s
}

fn help_text(c: &Command, doc: &[String], notes: &[Option<String>]) -> String {
    let mut s = usage_line(c);
    s.push('\n');
    if !doc.is_empty() {
        s.push('\n');
        for l in doc {
            s.push_str(l);
            s.push('\n');
        }
    }
    let pos_types = &c.params[c.pos_range()];
    if !pos_types.is_empty() {
        let rows: Vec<(String, String)> = c
            .positional
            .iter()
            .zip(pos_types)
            .enumerate()
            .map(|(i, (p, t))| {
                let last = i + 1 == pos_types.len();
                // the type, unless it is the name already (`<I64>`)
                let mut text = match (c.named, last && c.variadic) {
                    (false, _) => String::new(),
                    (true, true) => list_elem(t).unwrap_or(MT::unit()).to_string(),
                    (true, false) => t.to_string(),
                };
                let note = if last && c.variadic {
                    "any number"
                } else if last && list_elem(t).is_some() {
                    "or all lines of standard input"
                } else if last {
                    "or one per line of standard input"
                } else {
                    ""
                };
                if !note.is_empty() {
                    if !text.is_empty() {
                        text.push_str(", ");
                    }
                    text.push_str(note);
                }
                let left = if last && c.variadic {
                    format!("{}...", p)
                } else {
                    p.clone()
                };
                (left, text)
            })
            .collect();
        s.push_str("\narguments:\n");
        s.push_str(&columns(&rows));
    }
    let mut rows = match &c.options {
        Some(o) => o.rows(notes),
        None => Vec::new(),
    };
    let short_h = c
        .options
        .as_ref()
        .is_some_and(|o| o.flags.iter().any(|f| f.short == Some('h')));
    let has = |n: &str| {
        c.options
            .as_ref()
            .is_some_and(|o| o.flags.iter().any(|f| f.name == n))
    };
    if !has("help") {
        rows.push((
            if short_h { "    --help" } else { "-h, --help" }.to_string(),
            "show this help".into(),
        ));
    }
    if c.version.is_some() && !has("version") {
        rows.push(("    --version".into(), "show the version".into()));
    }
    s.push_str("\noptions:\n");
    s.push_str(&columns(&rows));
    s
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
    let mut opts = vec![("-h, --help".to_string(), "show this help".to_string())];
    if cmds.first().is_some_and(|c| c.version.is_some()) {
        opts.push(("    --version".into(), "show the version".into()));
    }
    s.push_str("\noptions:\n");
    s.push_str(&columns(&opts));
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
        let v = crate::textio::parse(text, &f.value_ty, prog).map_err(|_| {
            format!(
                "option `--{}`: cannot parse `{}` as {}",
                f.name, text, f.value_ty
            )
        })?;
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

/// Build the options record from parsed flag values and defaults (the
/// canonical text of each default, or for `cli.parse` the values).
pub fn build_record(
    o: &Options,
    vals: Vec<FlagValue>,
    defaults: &[Option<Value>],
) -> Result<Value, String> {
    let mut fields = vec![Value::unit(); o.nfields];
    for (k, (f, v)) in o.flags.iter().zip(vals).enumerate() {
        fields[f.index] = match v {
            FlagValue::One(x) if f.kind == FlagKind::Optional => Value::data(1, vec![x]),
            FlagValue::One(x) => x,
            FlagValue::Many(xs) => Value::list(xs),
            FlagValue::Unset => match (&defaults[k], f.kind) {
                (Some(d), _) => d.clone(),
                (None, FlagKind::Switch) | (None, FlagKind::Optional) => Value::data(0, vec![]),
                (None, FlagKind::Repeated) => Value::list(vec![]),
                (None, FlagKind::Single) => {
                    return Err(format!("missing option `--{}`", f.name));
                }
            },
        };
    }
    Ok(Value::Record(fields.into()))
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
        Parsed::Args(vals, pos) => Ok((build_record(&o, vals, &ds)?, pos)),
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
        .map(|f| Options::default_note(f.kind, &dv[f.index], &f.field_ty, prog))
        .collect();
    columns(&o.rows(&notes))
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
