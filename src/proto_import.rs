//! `fwp proto --import file.proto`: fwp types, codecs, clients and server
//! routes for the messages and services of a `.proto` file (docs/grpc.md).
//!
//! The parser covers the common subset of proto3 (and proto2 files that
//! keep to it): messages, nested messages and enums, `repeated`, `map`,
//! `oneof`, `optional`, services with unary and streaming methods, imports
//! from the same directory, and the well-known types `Empty`, `Timestamp`,
//! `Duration`, `Any` and the wrappers. Options, `reserved` and extensions
//! are skipped; groups are rejected.
//!
//! The generated module is plain fwp built on `lib/protobuf.fwp` and
//! `lib/grpc.fwp`, so both backends run it the same way:
//!
//! * a message `HelloRequest` is a record type with an encoder, a decoder,
//!   a default value and a codec (`hello-request.encode`, ...); an enum is
//!   a variant type of constructors `Color.Red`, ...; a `oneof` is an
//!   `Option` of a variant type; a message without fields is `()`;
//! * a method `SayHello` of service `Greeter` is a client function
//!   `greeter.say-hello : String -> HelloRequest -> HelloReply ! {Network,
//!   Error[GrpcError]}` (the address first), and a route builder
//!   `greeter.say-hello.route`; `greeter.routes` turns a record
//!   `GreeterServer` of implementations into routes for `grpc.serve`.

use std::collections::{BTreeMap, BTreeSet, HashMap};
use std::fmt::Write as _;
use std::path::{Path, PathBuf};

// ================================================================== lexing

#[derive(Clone, Debug, PartialEq)]
enum Tok {
    Ident(String),
    Int(i64),
    Float,
    Str(String),
    Sym(char),
}

struct Lexed {
    toks: Vec<(Tok, u32)>,
    /// Comment lines ending right before the token at that index.
    docs: HashMap<usize, Vec<String>>,
}

fn lex(src: &str, file: &str) -> Result<Lexed, String> {
    let b = src.as_bytes();
    let mut i = 0;
    let mut line = 1u32;
    let mut toks = Vec::new();
    let mut docs: HashMap<usize, Vec<String>> = HashMap::new();
    let mut pending: Vec<String> = Vec::new();
    let mut pending_line = 0u32;
    while i < b.len() {
        let c = b[i];
        if c == b'\n' {
            line += 1;
            i += 1;
            continue;
        }
        if c.is_ascii_whitespace() {
            i += 1;
            continue;
        }
        if c == b'/' && b.get(i + 1) == Some(&b'/') {
            let start = i + 2;
            while i < b.len() && b[i] != b'\n' {
                i += 1;
            }
            if pending_line + 1 < line {
                pending.clear();
            }
            pending.push(src[start..i].trim().to_string());
            pending_line = line;
            continue;
        }
        if c == b'/' && b.get(i + 1) == Some(&b'*') {
            i += 2;
            let start = i;
            while i + 1 < b.len() && !(b[i] == b'*' && b[i + 1] == b'/') {
                if b[i] == b'\n' {
                    line += 1;
                }
                i += 1;
            }
            let text = &src[start..i.min(src.len())];
            i += 2;
            pending.clear();
            for l in text.lines() {
                let l = l.trim().trim_start_matches('*').trim();
                if !l.is_empty() {
                    pending.push(l.to_string());
                }
            }
            pending_line = line;
            continue;
        }
        // a comment block documents the next token when it ends on the
        // line before it
        if !pending.is_empty() {
            if pending_line + 1 >= line {
                docs.insert(toks.len(), std::mem::take(&mut pending));
            } else {
                pending.clear();
            }
        }
        if c.is_ascii_alphabetic() || c == b'_' {
            let start = i;
            while i < b.len() && (b[i].is_ascii_alphanumeric() || b[i] == b'_') {
                i += 1;
            }
            toks.push((Tok::Ident(src[start..i].to_string()), line));
            continue;
        }
        if c.is_ascii_digit() {
            let start = i;
            while i < b.len()
                && (b[i].is_ascii_alphanumeric()
                    || b[i] == b'.'
                    || ((b[i] == b'+' || b[i] == b'-') && matches!(b[i - 1], b'e' | b'E')))
            {
                i += 1;
            }
            let t = &src[start..i];
            let v = if let Some(h) = t.strip_prefix("0x").or_else(|| t.strip_prefix("0X")) {
                i64::from_str_radix(h, 16).ok()
            } else if t.len() > 1 && t.starts_with('0') && t.bytes().all(|c| c.is_ascii_digit()) {
                i64::from_str_radix(&t[1..], 8).ok()
            } else {
                t.parse::<i64>().ok()
            };
            toks.push((v.map(Tok::Int).unwrap_or(Tok::Float), line));
            continue;
        }
        if c == b'"' || c == b'\'' {
            let q = c;
            i += 1;
            let mut s = Vec::new();
            while i < b.len() && b[i] != q {
                if b[i] == b'\\' && i + 1 < b.len() {
                    i += 1;
                    s.push(match b[i] {
                        b'n' => b'\n',
                        b't' => b'\t',
                        x => x,
                    });
                } else {
                    s.push(b[i]);
                }
                i += 1;
            }
            if i >= b.len() {
                return Err(format!("{}:{}: unterminated string", file, line));
            }
            i += 1;
            toks.push((Tok::Str(String::from_utf8_lossy(&s).into_owned()), line));
            continue;
        }
        if b"{}()[]<>;=,.:-+/".contains(&c) {
            toks.push((Tok::Sym(c as char), line));
            i += 1;
            continue;
        }
        return Err(format!(
            "{}:{}: unexpected character `{}`",
            file, line, c as char
        ));
    }
    Ok(Lexed { toks, docs })
}

// ================================================================= parsing

#[derive(Clone, Copy, Debug, PartialEq)]
enum Label {
    Singular,
    Optional,
    Repeated,
}

#[derive(Clone, Debug)]
enum FType {
    Named(String),
    Map(String, String),
}

#[derive(Clone, Debug)]
struct Field {
    name: String,
    number: i64,
    ty: FType,
    label: Label,
    oneof: Option<usize>,
    doc: Vec<String>,
}

#[derive(Clone, Debug, Default)]
struct Message {
    /// Full name without a leading dot: `pkg.Outer.Inner`.
    full: String,
    fields: Vec<Field>,
    oneofs: Vec<String>,
    doc: Vec<String>,
    package: String,
}

#[derive(Clone, Debug, Default)]
struct Enum {
    full: String,
    values: Vec<(String, i64)>,
    doc: Vec<String>,
    package: String,
}

#[derive(Clone, Debug)]
struct Method {
    name: String,
    input: String,
    output: String,
    client_streaming: bool,
    server_streaming: bool,
    doc: Vec<String>,
    /// The scope types are resolved in.
    scope: String,
}

#[derive(Clone, Debug)]
struct Service {
    name: String,
    package: String,
    methods: Vec<Method>,
    doc: Vec<String>,
}

#[derive(Default)]
struct Defs {
    messages: Vec<Message>,
    enums: Vec<Enum>,
    services: Vec<Service>,
}

struct Parser<'a> {
    toks: &'a [(Tok, u32)],
    docs: &'a HashMap<usize, Vec<String>>,
    pos: usize,
    file: &'a str,
    package: String,
}

const SCALARS: &[&str] = &[
    "double", "float", "int32", "int64", "uint32", "uint64", "sint32", "sint64", "fixed32",
    "fixed64", "sfixed32", "sfixed64", "bool", "string", "bytes",
];

impl<'a> Parser<'a> {
    fn err<T>(&self, msg: impl std::fmt::Display) -> Result<T, String> {
        let line = self
            .toks
            .get(self.pos)
            .or(self.toks.last())
            .map(|t| t.1)
            .unwrap_or(1);
        Err(format!("{}:{}: {}", self.file, line, msg))
    }

    fn peek(&self) -> Option<&Tok> {
        self.toks.get(self.pos).map(|t| &t.0)
    }

    fn peek_at(&self, k: usize) -> Option<&Tok> {
        self.toks.get(self.pos + k).map(|t| &t.0)
    }

    fn doc_at(&self, pos: usize) -> Vec<String> {
        self.docs.get(&pos).cloned().unwrap_or_default()
    }

    fn next(&mut self) -> Result<Tok, String> {
        match self.toks.get(self.pos) {
            Some((t, _)) => {
                self.pos += 1;
                Ok(t.clone())
            }
            None => self.err("unexpected end of file"),
        }
    }

    fn is_sym(&self, c: char) -> bool {
        self.peek() == Some(&Tok::Sym(c))
    }

    fn is_ident(&self, s: &str) -> bool {
        matches!(self.peek(), Some(Tok::Ident(x)) if x == s)
    }

    fn sym(&mut self, c: char) -> Result<(), String> {
        match self.next()? {
            Tok::Sym(x) if x == c => Ok(()),
            t => {
                self.pos -= 1;
                self.err(format!("expected `{}`, found {}", c, show(&t)))
            }
        }
    }

    fn ident(&mut self) -> Result<String, String> {
        match self.next()? {
            Tok::Ident(s) => Ok(s),
            t => {
                self.pos -= 1;
                self.err(format!("expected a name, found {}", show(&t)))
            }
        }
    }

    /// A possibly dotted name (`a.b.C`, `.a.B`).
    fn full_ident(&mut self) -> Result<String, String> {
        let mut s = String::new();
        if self.is_sym('.') {
            self.pos += 1;
            s.push('.');
        }
        s.push_str(&self.ident()?);
        while self.is_sym('.') {
            self.pos += 1;
            s.push('.');
            s.push_str(&self.ident()?);
        }
        Ok(s)
    }

    fn int(&mut self) -> Result<i64, String> {
        let neg = if self.is_sym('-') {
            self.pos += 1;
            true
        } else {
            false
        };
        match self.next()? {
            Tok::Int(v) => Ok(if neg { -v } else { v }),
            t => {
                self.pos -= 1;
                self.err(format!("expected a number, found {}", show(&t)))
            }
        }
    }

    fn string(&mut self) -> Result<String, String> {
        match self.next()? {
            Tok::Str(s) => Ok(s),
            t => {
                self.pos -= 1;
                self.err(format!("expected a string, found {}", show(&t)))
            }
        }
    }

    /// Skip to the end of a statement or block, over nested braces.
    fn skip_statement(&mut self) -> Result<(), String> {
        let mut depth = 0;
        loop {
            match self.next()? {
                Tok::Sym(';') if depth == 0 => return Ok(()),
                Tok::Sym('{') => depth += 1,
                Tok::Sym('}') => {
                    depth -= 1;
                    if depth == 0 {
                        if self.is_sym(';') {
                            self.pos += 1;
                        }
                        return Ok(());
                    }
                }
                _ => {}
            }
        }
    }

    /// Skip `[ ... ]` field options.
    fn skip_options(&mut self) -> Result<(), String> {
        if !self.is_sym('[') {
            return Ok(());
        }
        let mut depth = 0;
        loop {
            match self.next()? {
                Tok::Sym('[') => depth += 1,
                Tok::Sym(']') => {
                    depth -= 1;
                    if depth == 0 {
                        return Ok(());
                    }
                }
                _ => {}
            }
        }
    }

    fn file(&mut self, defs: &mut Defs, imports: &mut Vec<String>) -> Result<(), String> {
        while let Some(t) = self.peek().cloned() {
            let doc = self.doc_at(self.pos);
            match t {
                Tok::Sym(';') => self.pos += 1,
                Tok::Ident(k) => match k.as_str() {
                    "syntax" | "edition" => {
                        self.pos += 1;
                        self.sym('=')?;
                        let v = self.string()?;
                        if k == "edition" || (v != "proto3" && v != "proto2") {
                            return self.err(format!("unsupported {} \"{}\"", k, v));
                        }
                        self.sym(';')?;
                    }
                    "package" => {
                        self.pos += 1;
                        self.package = self.full_ident()?;
                        self.sym(';')?;
                    }
                    "import" => {
                        self.pos += 1;
                        if self.is_ident("public") || self.is_ident("weak") {
                            self.pos += 1;
                        }
                        imports.push(self.string()?);
                        self.sym(';')?;
                    }
                    "option" | "extend" => self.skip_statement()?,
                    "message" => {
                        self.pos += 1;
                        let scope = self.package.clone();
                        self.message(&scope, doc, defs)?;
                    }
                    "enum" => {
                        self.pos += 1;
                        let scope = self.package.clone();
                        self.enum_def(&scope, doc, defs)?;
                    }
                    "service" => {
                        self.pos += 1;
                        self.service(doc, defs)?;
                    }
                    _ => return self.err(format!("unexpected `{}`", k)),
                },
                t => return self.err(format!("unexpected {}", show(&t))),
            }
        }
        Ok(())
    }

    fn qualify(scope: &str, name: &str) -> String {
        if scope.is_empty() {
            name.to_string()
        } else {
            format!("{}.{}", scope, name)
        }
    }

    fn message(&mut self, scope: &str, doc: Vec<String>, defs: &mut Defs) -> Result<(), String> {
        let name = self.ident()?;
        let full = Self::qualify(scope, &name);
        let mut m = Message {
            full: full.clone(),
            doc,
            package: self.package.clone(),
            ..Default::default()
        };
        self.sym('{')?;
        while !self.is_sym('}') {
            self.member(&full, &mut m, None, defs)?;
        }
        self.sym('}')?;
        defs.messages.push(m);
        Ok(())
    }

    /// A member of a message (or of a `oneof` when `oneof` is set).
    fn member(
        &mut self,
        scope: &str,
        m: &mut Message,
        oneof: Option<usize>,
        defs: &mut Defs,
    ) -> Result<(), String> {
        let doc = self.doc_at(self.pos);
        let Some(t) = self.peek().cloned() else {
            return self.err("unexpected end of file");
        };
        let k = match t {
            Tok::Sym(';') => {
                self.pos += 1;
                return Ok(());
            }
            Tok::Ident(k) => k,
            Tok::Sym('.') => String::new(),
            t => return self.err(format!("unexpected {}", show(&t))),
        };
        // `option` and the like, unless it is a field of a type of that name
        let keyword = !matches!(self.peek_at(1), Some(Tok::Sym('=')))
            && matches!(self.peek_at(1), Some(Tok::Ident(_)) | Some(Tok::Sym(_)));
        match k.as_str() {
            "option" | "reserved" | "extensions" | "extend" if keyword => {
                return self.skip_statement()
            }
            "message" if oneof.is_none() && keyword => {
                self.pos += 1;
                return self.message(scope, doc, defs);
            }
            "enum" if oneof.is_none() && keyword => {
                self.pos += 1;
                return self.enum_def(scope, doc, defs);
            }
            "oneof" if oneof.is_none() && keyword => {
                self.pos += 1;
                let name = self.ident()?;
                m.oneofs.push(name);
                let idx = m.oneofs.len() - 1;
                self.sym('{')?;
                while !self.is_sym('}') {
                    self.member(scope, m, Some(idx), defs)?;
                }
                self.sym('}')?;
                return Ok(());
            }
            "group" => return self.err("groups are not supported"),
            _ => {}
        }
        let mut label = Label::Singular;
        if oneof.is_none() && keyword {
            match k.as_str() {
                "repeated" => {
                    self.pos += 1;
                    label = Label::Repeated;
                }
                "optional" => {
                    self.pos += 1;
                    label = Label::Optional;
                }
                "required" => self.pos += 1,
                _ => {}
            }
        }
        let ty = if self.is_ident("map") && self.peek_at(1) == Some(&Tok::Sym('<')) {
            self.pos += 2;
            let k = self.full_ident()?;
            self.sym(',')?;
            let v = self.full_ident()?;
            self.sym('>')?;
            FType::Map(k, v)
        } else {
            if self.is_ident("group") {
                return self.err("groups are not supported");
            }
            FType::Named(self.full_ident()?)
        };
        let name = self.ident()?;
        self.sym('=')?;
        let number = self.int()?;
        self.skip_options()?;
        self.sym(';')?;
        if !(1..=536_870_911).contains(&number) {
            return self.err(format!("field `{}` has an invalid number {}", name, number));
        }
        if matches!(ty, FType::Map(..)) && label != Label::Singular {
            return self.err(format!(
                "map field `{}` cannot be repeated or optional",
                name
            ));
        }
        m.fields.push(Field {
            name,
            number,
            ty,
            label,
            oneof,
            doc,
        });
        Ok(())
    }

    fn enum_def(&mut self, scope: &str, doc: Vec<String>, defs: &mut Defs) -> Result<(), String> {
        let name = self.ident()?;
        let mut e = Enum {
            full: Self::qualify(scope, &name),
            doc,
            package: self.package.clone(),
            ..Default::default()
        };
        self.sym('{')?;
        while !self.is_sym('}') {
            if self.is_sym(';') {
                self.pos += 1;
                continue;
            }
            if (self.is_ident("option") || self.is_ident("reserved"))
                && self.peek_at(1) != Some(&Tok::Sym('='))
            {
                self.skip_statement()?;
                continue;
            }
            let v = self.ident()?;
            self.sym('=')?;
            let n = self.int()?;
            self.skip_options()?;
            self.sym(';')?;
            if !e.values.iter().any(|(_, x)| *x == n) {
                e.values.push((v, n));
            }
        }
        self.sym('}')?;
        if e.values.is_empty() {
            return self.err(format!("enum `{}` has no values", name));
        }
        defs.enums.push(e);
        Ok(())
    }

    fn service(&mut self, doc: Vec<String>, defs: &mut Defs) -> Result<(), String> {
        let name = self.ident()?;
        let mut s = Service {
            name,
            package: self.package.clone(),
            methods: Vec::new(),
            doc,
        };
        self.sym('{')?;
        while !self.is_sym('}') {
            if self.is_sym(';') {
                self.pos += 1;
                continue;
            }
            if self.is_ident("option") {
                self.skip_statement()?;
                continue;
            }
            let doc = self.doc_at(self.pos);
            if !self.is_ident("rpc") {
                return self.err("expected `rpc`");
            }
            self.pos += 1;
            let name = self.ident()?;
            let mut types = Vec::new();
            for i in 0..2 {
                if i == 1 {
                    if !self.is_ident("returns") {
                        return self.err("expected `returns`");
                    }
                    self.pos += 1;
                }
                self.sym('(')?;
                let stream = self.is_ident("stream") && self.peek_at(1) != Some(&Tok::Sym(')'));
                if stream {
                    self.pos += 1;
                }
                let t = self.full_ident()?;
                self.sym(')')?;
                types.push((t, stream));
            }
            if self.is_sym('{') {
                self.skip_statement()?;
            } else {
                self.sym(';')?;
            }
            s.methods.push(Method {
                name,
                input: types[0].0.clone(),
                client_streaming: types[0].1,
                output: types[1].0.clone(),
                server_streaming: types[1].1,
                doc,
                scope: self.package.clone(),
            });
        }
        self.sym('}')?;
        defs.services.push(s);
        Ok(())
    }
}

fn show(t: &Tok) -> String {
    match t {
        Tok::Ident(s) => format!("`{}`", s),
        Tok::Int(n) => format!("`{}`", n),
        Tok::Float => "a number".into(),
        Tok::Str(s) => format!("\"{}\"", s),
        Tok::Sym(c) => format!("`{}`", c),
    }
}

/// The well-known types, as built-in files.
fn builtin(path: &str) -> Option<&'static str> {
    Some(match path {
        "google/protobuf/empty.proto" => {
            "syntax = \"proto3\"; package google.protobuf; message Empty {}"
        }
        "google/protobuf/timestamp.proto" => {
            "syntax = \"proto3\"; package google.protobuf;
            message Timestamp { int64 seconds = 1; int32 nanos = 2; }"
        }
        "google/protobuf/duration.proto" => {
            "syntax = \"proto3\"; package google.protobuf;
            message Duration { int64 seconds = 1; int32 nanos = 2; }"
        }
        "google/protobuf/any.proto" => {
            "syntax = \"proto3\"; package google.protobuf;
            message Any { string type_url = 1; bytes value = 2; }"
        }
        "google/protobuf/wrappers.proto" => {
            "syntax = \"proto3\"; package google.protobuf;
            message DoubleValue { double value = 1; } message FloatValue { float value = 1; }
            message Int64Value { int64 value = 1; } message UInt64Value { uint64 value = 1; }
            message Int32Value { int32 value = 1; } message UInt32Value { uint32 value = 1; }
            message BoolValue { bool value = 1; } message StringValue { string value = 1; }
            message BytesValue { bytes value = 1; }"
        }
        _ => return None,
    })
}

/// Parse a file and its imports (from its directory, or built in).
fn load(path: &Path) -> Result<(Defs, String), String> {
    let mut defs = Defs::default();
    let mut seen = BTreeSet::new();
    let dir = path.parent().map(Path::to_path_buf).unwrap_or_default();
    let name = path
        .file_name()
        .map(|n| n.to_string_lossy().to_string())
        .unwrap_or_default();
    let mut work: Vec<(String, Option<PathBuf>)> = vec![(name, Some(path.to_path_buf()))];
    let mut main_package = None;
    while let Some((name, p)) = work.pop() {
        if !seen.insert(name.clone()) {
            continue;
        }
        let text = match (builtin(&name), p) {
            (Some(t), _) => t.to_string(),
            (None, Some(p)) => std::fs::read_to_string(&p)
                .map_err(|e| format!("cannot read {}: {}", p.display(), e))?,
            (None, None) => {
                // relative to the importing file's directory, or by its
                // file name there
                let p = dir.join(&name);
                let alt = Path::new(&name).file_name().map(|n| dir.join(n));
                match std::fs::read_to_string(&p) {
                    Ok(t) => t,
                    Err(e) => match alt.and_then(|a| std::fs::read_to_string(a).ok()) {
                        Some(t) => t,
                        None => {
                            return Err(format!(
                                "cannot read the import {} ({}): {}",
                                name,
                                p.display(),
                                e
                            ))
                        }
                    },
                }
            }
        };
        let lexed = lex(&text, &name)?;
        let mut p = Parser {
            toks: &lexed.toks,
            docs: &lexed.docs,
            pos: 0,
            file: &name,
            package: String::new(),
        };
        let mut imports = Vec::new();
        let mut file_defs = Defs::default();
        p.file(&mut file_defs, &mut imports)?;
        if main_package.is_none() {
            main_package = Some(p.package.clone());
        } else {
            // only the main file's services are generated
            file_defs.services.clear();
        }
        defs.messages.extend(file_defs.messages);
        defs.enums.extend(file_defs.enums);
        defs.services.extend(file_defs.services);
        for i in imports {
            work.push((i, None));
        }
    }
    Ok((defs, main_package.unwrap_or_default()))
}

// ============================================================== generation

fn camel(s: &str) -> String {
    let mut out = String::new();
    let mut up = true;
    for c in s.chars() {
        if c == '_' || c == '.' || c == '-' {
            up = true;
        } else if up {
            out.push(c.to_ascii_uppercase());
            up = false;
        } else {
            out.push(c);
        }
    }
    if out.is_empty() || out.starts_with(|c: char| c.is_ascii_digit()) {
        out.insert(0, 'X');
    }
    out
}

/// kebab-case of a CamelCase or snake_case name: `HTTPRequest` is
/// `http-request`, `user_name` is `user-name`.
fn kebab(s: &str) -> String {
    let cs: Vec<char> = s.chars().collect();
    let mut out = String::new();
    for (i, &c) in cs.iter().enumerate() {
        if c == '_' || c == '.' || c == '-' {
            if !out.is_empty() && !out.ends_with('-') {
                out.push('-');
            }
            continue;
        }
        if c.is_ascii_uppercase() && i > 0 {
            let prev = cs[i - 1];
            let next_lower = cs.get(i + 1).is_some_and(|n| n.is_ascii_lowercase());
            if (prev.is_ascii_lowercase()
                || prev.is_ascii_digit()
                || (prev.is_ascii_uppercase() && next_lower))
                && !out.ends_with('-')
                && !out.is_empty()
            {
                out.push('-');
            }
        }
        out.push(c.to_ascii_lowercase());
    }
    let out = out.trim_matches('-').to_string();
    if out.is_empty() || !out.starts_with(|c: char| c.is_ascii_lowercase()) {
        format!("x-{}", out)
    } else {
        out
    }
}

const KEYWORDS: &[&str] = &[
    "rec", "match", "trait", "impl", "where", "comptime", "import", "export", "macro", "quote",
    "resource", "foreign", "with", "type", "test", "make", "update",
];

/// The fwp name of a field.
fn field_name(s: &str) -> String {
    let k = kebab(s);
    if KEYWORDS.contains(&k.as_str()) {
        format!("{}-field", k)
    } else {
        k
    }
}

#[derive(Clone)]
enum Def {
    Msg,
    Enum(usize),
}

/// A field of a generated record: name, type, writer, reader, default
/// and comments.
struct Col {
    name: String,
    ty: String,
    writer: String,
    reader: String,
    default: String,
    doc: Vec<String>,
}

struct Gen {
    defs: Defs,
    package: String,
    by_full: BTreeMap<String, Def>,
    /// fwp type names by full name.
    names: BTreeMap<String, String>,
    /// Singular message fields that must be `Option`s (recursion).
    boxed: BTreeSet<(String, String)>,
    out: String,
}

const EMPTY: &str = "google.protobuf.Empty";

const EFFECTS: &str = "{Async, IO, Network, FileIO, Error[GrpcError]}";

impl Gen {
    fn resolve(&self, name: &str, scope: &str) -> Result<String, String> {
        if let Some(n) = name.strip_prefix('.') {
            return if self.by_full.contains_key(n) {
                Ok(n.to_string())
            } else {
                Err(format!("unknown type `{}`", name))
            };
        }
        let mut s = scope.to_string();
        loop {
            let cand = if s.is_empty() {
                name.to_string()
            } else {
                format!("{}.{}", s, name)
            };
            if self.by_full.contains_key(&cand) {
                return Ok(cand);
            }
            if s.is_empty() {
                return Err(format!("unknown type `{}` (in `{}`)", name, scope));
            }
            s = match s.rsplit_once('.') {
                Some((a, _)) => a.to_string(),
                None => String::new(),
            };
        }
    }

    /// The prefix of a type's functions: `hello-request` for `HelloRequest`.
    fn prefix(&self, full: &str) -> String {
        kebab(&self.names[full])
    }

    /// The fwp type and codec of a scalar or named type.
    fn codec(&self, ty: &str, scope: &str) -> Result<(String, String), String> {
        if SCALARS.contains(&ty) {
            let fwp = match ty {
                "double" => "F64",
                "float" => "F32",
                "int32" | "sint32" | "sfixed32" => "I32",
                "int64" | "sint64" | "sfixed64" => "I64",
                "uint32" | "fixed32" => "U32",
                "uint64" | "fixed64" => "U64",
                "bool" => "Bool",
                "string" => "String",
                _ => "Bytes",
            };
            return Ok((fwp.into(), format!("pb.{}", ty)));
        }
        let full = self.resolve(ty, scope)?;
        if full == EMPTY {
            return Ok(("()".into(), "pb.empty".into()));
        }
        Ok((
            self.names[&full].clone(),
            format!("{}.codec", self.prefix(&full)),
        ))
    }

    fn default_of(&self, ty: &str, scope: &str) -> Result<String, String> {
        if SCALARS.contains(&ty) {
            return Ok(match ty {
                "double" | "float" => "0.0".into(),
                "bool" => "False".into(),
                "string" => "\"\"".into(),
                "bytes" => "bytes.from-list []".into(),
                _ => "0".into(),
            });
        }
        let full = self.resolve(ty, scope)?;
        if full == EMPTY {
            return Ok("()".into());
        }
        Ok(match &self.by_full[&full] {
            Def::Enum(i) => self.ctor(&full, &self.defs.enums[*i].values[0].0),
            Def::Msg => format!("{}.default", self.prefix(&full)),
        })
    }

    /// The constructor of an enum value: `Color.Red` for `COLOR_RED` (or
    /// `RED`) of `Color`.
    fn ctor(&self, enum_full: &str, value: &str) -> String {
        let tname = &self.names[enum_full];
        let base = enum_full.rsplit('.').next().unwrap_or(enum_full);
        let prefix = format!("{}_", kebab(base).replace('-', "_").to_ascii_uppercase());
        let v = value
            .strip_prefix(&prefix)
            .filter(|r| !r.is_empty() && !r.starts_with(|c: char| c.is_ascii_digit()))
            .unwrap_or(value);
        let c = if v
            .chars()
            .all(|c| c.is_ascii_uppercase() || c.is_ascii_digit() || c == '_')
        {
            camel(&v.to_ascii_lowercase())
        } else {
            camel(v)
        };
        format!("{}.{}", tname, c)
    }

    fn comment(&mut self, doc: &[String]) {
        for l in doc {
            let l = l.trim();
            if l.is_empty() {
                self.out.push_str("#\n");
            } else {
                let _ = writeln!(self.out, "# {}", l);
            }
        }
    }

    fn enum_def(&mut self, i: usize) {
        let e = self.defs.enums[i].clone();
        let t = self.names[&e.full].clone();
        let p = kebab(&t);
        self.comment(&e.doc);
        let _ = writeln!(self.out, "{} =", t);
        let mut seen = BTreeSet::new();
        let mut values = Vec::new();
        for (v, n) in &e.values {
            let mut c = self.ctor(&e.full, v);
            while !seen.insert(c.clone()) {
                c.push('X');
            }
            let _ = writeln!(self.out, "    | {}", c);
            values.push((c, *n));
        }
        let o = &mut self.out;
        let _ = writeln!(o, "\n{}.from-int : I64 -> {}", p, t);
        let _ = writeln!(o, "{}.from-int = match", p);
        for (c, n) in values.iter().skip(1) {
            let _ = writeln!(o, "    {} -> {}", n, c);
        }
        let _ = writeln!(o, "    _ -> const {}", values[0].0);
        let _ = writeln!(o, "\n{}.to-int : {} -> I64", p, t);
        let _ = writeln!(o, "{}.to-int = match", p);
        for (c, n) in &values {
            let _ = writeln!(o, "    {} -> {}", c, n);
        }
        let _ = writeln!(o, "\n{}.codec : PbCodec[{}]", p, t);
        let _ = writeln!(
            o,
            "{p}.codec = pb.enum {p}.from-int {p}.to-int {}\n",
            values[0].0,
            p = p
        );
    }

    fn columns(&self, m: &Message, oneof_types: &[String]) -> Result<Vec<Col>, String> {
        let scope = m.full.clone();
        let mut cols = Vec::new();
        let mut names = BTreeSet::new();
        let mut done_oneofs = BTreeSet::new();
        for f in &m.fields {
            if let Some(oi) = f.oneof {
                if !done_oneofs.insert(oi) {
                    continue;
                }
                let ot = &oneof_types[oi];
                let mut name = field_name(&m.oneofs[oi]);
                while !names.insert(name.clone()) {
                    name.push_str("-x");
                }
                let mut readers = Vec::new();
                for g in m.fields.iter().filter(|g| g.oneof == Some(oi)) {
                    let FType::Named(ty) = &g.ty else { continue };
                    let (fwp, codec) = self.codec(ty, &scope)?;
                    let ctor = format!("{}.{}", ot, camel(&g.name));
                    let make = if fwp == "()" {
                        format!("const {}", ctor)
                    } else {
                        ctor
                    };
                    readers.push(format!(
                        "pb.get-optional {} {} | option.map {}",
                        g.number, codec, make
                    ));
                }
                cols.push(Col {
                    writer: format!(".{} | pb.oneof {}.fields", name, kebab(ot)),
                    name,
                    ty: format!("Option[{}]", ot),
                    reader: format!("pb.first-of [{}]", readers.join(", ")),
                    default: "None".into(),
                    doc: Vec::new(),
                });
                continue;
            }
            let mut name = field_name(&f.name);
            while !names.insert(name.clone()) {
                name.push_str("-x");
            }
            let n = f.number;
            let col = match &f.ty {
                FType::Map(k, v) => {
                    let (kt, kc) = self.codec(k, &scope)?;
                    let (vt, vc) = self.codec(v, &scope)?;
                    Col {
                        ty: format!("Map[{}, {}]", kt, vt),
                        writer: format!(".{} | pb.map {} {} {}", name, n, kc, vc),
                        reader: format!("pb.get-map {} {} {}", n, kc, vc),
                        default: "map.empty".into(),
                        doc: f.doc.clone(),
                        name,
                    }
                }
                FType::Named(ty) => {
                    let (ft, c) = self.codec(ty, &scope)?;
                    let boxed = self.boxed.contains(&(m.full.clone(), f.name.clone()));
                    let (ty, writer, reader, default) = match (f.label, boxed) {
                        (Label::Repeated, _) => (
                            format!("List[{}]", ft),
                            format!(".{} | pb.repeated {} {}", name, n, c),
                            format!("pb.get-repeated {} {}", n, c),
                            "[]".to_string(),
                        ),
                        (Label::Optional, _) | (_, true) => (
                            format!("Option[{}]", ft),
                            format!(".{} | pb.optional {} {}", name, n, c),
                            format!("pb.get-optional {} {}", n, c),
                            "None".to_string(),
                        ),
                        _ => (
                            ft,
                            format!(".{} | pb.field {} {}", name, n, c),
                            format!("pb.get {} {}", n, c),
                            self.default_of(ty, &scope)?,
                        ),
                    };
                    Col {
                        name,
                        ty,
                        writer,
                        reader,
                        default,
                        doc: f.doc.clone(),
                    }
                }
            };
            cols.push(col);
        }
        Ok(cols)
    }

    fn message_def(&mut self, i: usize) -> Result<(), String> {
        let m = self.defs.messages[i].clone();
        let t = self.names[&m.full].clone();
        let p = kebab(&t);
        let scope = m.full.clone();
        // the variant types of `oneof`s
        let mut oneof_types = Vec::new();
        for (oi, o) in m.oneofs.iter().enumerate() {
            let ot = format!("{}{}", t, camel(o));
            let mut lines = Vec::new();
            for f in m.fields.iter().filter(|f| f.oneof == Some(oi)) {
                let FType::Named(ty) = &f.ty else { continue };
                let (fwp, _) = self.codec(ty, &scope)?;
                let arg = if fwp == "()" {
                    String::new()
                } else {
                    format!(" {}", fwp)
                };
                lines.push(format!("    | {}.{}{}", ot, camel(&f.name), arg));
            }
            if lines.is_empty() {
                return Err(format!("`oneof {}` of `{}` has no fields", o, m.full));
            }
            let _ = writeln!(self.out, "# the `oneof {}` of {}\n{} =", o, t, ot);
            for l in lines {
                let _ = writeln!(self.out, "{}", l);
            }
            self.out.push('\n');
            oneof_types.push(ot);
        }
        self.comment(&m.doc);
        let o = &mut self.out;
        if m.fields.is_empty() {
            let _ = writeln!(o, "{} = ()\n", t);
            let _ = writeln!(o, "{}.default : {}\n{}.default = ()\n", p, t, p);
            let _ = writeln!(
                o,
                "{}.encode : {} -> Bytes\n{}.encode = const (bytes.from-list [])\n",
                p, t, p
            );
            let _ = writeln!(
                o,
                "{}.decode : Bytes -> {} ! {{Error[GrpcError]}}\n{}.decode = pb.decode | const ()\n",
                p, t, p
            );
            let _ = writeln!(o, "{}.codec : PbCodec[{}]\n{}.codec = pb.empty\n", p, t, p);
            return Ok(());
        }
        let cols = self.columns(&m, &oneof_types)?;
        let o = &mut self.out;
        let _ = writeln!(o, "{} = {{", t);
        for c in &cols {
            for l in &c.doc {
                let _ = writeln!(o, "    # {}", l.trim());
            }
            let _ = writeln!(o, "    {}: {},", c.name, c.ty);
        }
        o.push_str("}\n\n");
        // the writers of `oneof`s
        for (oi, ot) in oneof_types.iter().enumerate() {
            let _ = writeln!(self.out, "{}.fields : {} -> List[PbField]", kebab(ot), ot);
            let _ = writeln!(self.out, "{}.fields = match", kebab(ot));
            for g in m.fields.iter().filter(|g| g.oneof == Some(oi)) {
                let FType::Named(ty) = &g.ty else { continue };
                let (fwp, codec) = self.codec(ty, &scope)?;
                let o = &mut self.out;
                if fwp == "()" {
                    let _ = writeln!(
                        o,
                        "    {}.{} -> pb.always {} {} ()",
                        ot,
                        camel(&g.name),
                        g.number,
                        codec
                    );
                } else {
                    let _ = writeln!(
                        o,
                        "    {}.{} _ -> pb.always {} {}",
                        ot,
                        camel(&g.name),
                        g.number,
                        codec
                    );
                }
            }
            self.out.push('\n');
        }
        let o = &mut self.out;
        let _ = writeln!(o, "{}.default : {}\n{}.default = {} {{", p, t, p, t);
        for c in &cols {
            let _ = writeln!(o, "    {} = {},", c.name, c.default);
        }
        o.push_str("}\n\n");
        let _ = writeln!(
            o,
            "rec {}.encode : {} -> Bytes\n{}.encode = pb.encode [",
            p, t, p
        );
        for c in &cols {
            let _ = writeln!(o, "    {},", c.writer);
        }
        o.push_str("]\n\n");
        let _ = writeln!(
            o,
            "rec {}.decode : Bytes -> {} ! {{Error[GrpcError]}}\n{}.decode = pb.decode | make {} {{",
            p, t, p, t
        );
        for c in &cols {
            let _ = writeln!(o, "    {} = {},", c.name, c.reader);
        }
        o.push_str("}\n\n");
        let _ = writeln!(
            o,
            "rec {p}.codec : PbCodec[{t}]\n{p}.codec = pb.message {p}.encode {p}.decode {p}.default\n",
            p = p,
            t = t
        );
        Ok(())
    }

    /// The type, encoder and decoder of a method's message.
    fn coders(&self, ty: &str, scope: &str) -> Result<(String, String, String), String> {
        let full = self.resolve(ty, scope)?;
        if !matches!(self.by_full.get(&full), Some(Def::Msg)) {
            return Err(format!("`{}` is not a message", ty));
        }
        if full == EMPTY {
            return Ok((
                "()".into(),
                "(const (bytes.from-list []))".into(),
                "(pb.decode | const ())".into(),
            ));
        }
        let p = self.prefix(&full);
        Ok((
            self.names[&full].clone(),
            format!("{}.encode", p),
            format!("{}.decode", p),
        ))
    }

    fn service_def(&mut self, s: &Service) -> Result<(), String> {
        let sp = kebab(&s.name);
        let full = if s.package.is_empty() {
            s.name.clone()
        } else {
            format!("{}.{}", s.package, s.name)
        };
        let _ = writeln!(self.out, "# ---- service {}\n", full);
        let server_t = format!("{}Server", camel(&s.name));
        let mut fields = Vec::new();
        let mut routes = Vec::new();
        for m in &s.methods {
            let (it, enc, in_dec) = self.coders(&m.input, &m.scope)?;
            let (ot, out_enc, dec) = self.coders(&m.output, &m.scope)?;
            let mp = format!("{}.{}", sp, kebab(&m.name));
            let path = format!("/{}/{}", full, m.name);
            let (client_t, client_f, impl_t, handler) =
                match (m.client_streaming, m.server_streaming) {
                    (false, false) => (
                        format!("String -> {} -> {} ! {{Network, Error[GrpcError]}}", it, ot),
                        "grpc.unary",
                        format!("{} -> {} ! {}", it, ot, EFFECTS),
                        "grpc.unary-handler",
                    ),
                    (false, true) => (
                        format!(
                            "String -> {} -> Channel[{}] -> () ! {{Async, Network, Error[GrpcError]}}",
                            it, ot
                        ),
                        "grpc.server-streaming",
                        format!("{} -> Channel[{}] -> () ! {}", it, ot, EFFECTS),
                        "grpc.server-streaming-handler",
                    ),
                    (true, false) => (
                        format!(
                            "String -> Iterator[{}] -> {} ! {{Network, Error[GrpcError]}}",
                            it, ot
                        ),
                        "grpc.client-streaming",
                        format!("Iterator[{}] -> {} ! {}", it, ot, EFFECTS),
                        "grpc.client-streaming-handler",
                    ),
                    (true, true) => (
                        format!(
                            "String -> Iterator[{}] -> Channel[{}] -> () ! {{Async, Network, Error[GrpcError]}}",
                            it, ot
                        ),
                        "grpc.bidi-streaming",
                        format!("Iterator[{}] -> Channel[{}] -> () ! {}", it, ot, EFFECTS),
                        "grpc.bidi-streaming-handler",
                    ),
                };
            let shape = format!(
                "rpc {}({}{}) returns ({}{})",
                m.name,
                if m.client_streaming { "stream " } else { "" },
                m.input.trim_start_matches('.'),
                if m.server_streaming { "stream " } else { "" },
                m.output.trim_start_matches('.')
            );
            self.comment(&m.doc);
            let o = &mut self.out;
            let _ = writeln!(o, "# {}: a call to the service at an address", shape);
            let _ = writeln!(o, "{} : {}", mp, client_t);
            let _ = writeln!(o, "{} = {} {} {} {:?}\n", mp, client_f, enc, dec, path);
            let _ = writeln!(o, "# the route serving `{}` with a function", m.name);
            let _ = writeln!(o, "{}.route : ({}) -> GrpcRoute", mp, impl_t);
            let _ = writeln!(
                o,
                "{}.route = {} {} {} | grpc.route {:?}\n",
                mp, handler, in_dec, out_enc, path
            );
            let fname = kebab(&m.name);
            fields.push(format!("    {}: {},", fname, impl_t));
            routes.push(format!("(.{} | {}.route)", fname, mp));
        }
        self.comment(&s.doc);
        let o = &mut self.out;
        let _ = writeln!(o, "# implementations of the methods of {}", full);
        let _ = writeln!(o, "{} = {{", server_t);
        for f in &fields {
            let _ = writeln!(o, "{}", f);
        }
        o.push_str("}\n\n");
        let _ = writeln!(
            o,
            "# the routes of {}: `impl | {}.routes | grpc.serve address`",
            full, sp
        );
        let _ = writeln!(o, "{}.routes : {} -> List[GrpcRoute]", sp, server_t);
        let mut e = "const Nil".to_string();
        for r in routes.iter().rev() {
            e = format!("fork Cons {} ({})", r, e);
        }
        let _ = writeln!(o, "{}.routes = {}\n", sp, e);
        Ok(())
    }
}

/// The fwp module for a `.proto` file.
pub fn generate(path: &Path) -> Result<String, String> {
    let (defs, package) = load(path)?;
    let mut g = Gen {
        defs,
        package,
        by_full: BTreeMap::new(),
        names: BTreeMap::new(),
        boxed: BTreeSet::new(),
        out: String::new(),
    };
    for m in g.defs.messages.iter() {
        g.by_full.insert(m.full.clone(), Def::Msg);
    }
    for (i, e) in g.defs.enums.iter().enumerate() {
        g.by_full.insert(e.full.clone(), Def::Enum(i));
    }
    // fwp names: relative to the main package, else prefixed with the
    // package's last part
    let mut used: BTreeSet<String> = ["Duration", "Option", "List", "Result", "Map", "Set"]
        .iter()
        .map(|s| s.to_string())
        .collect();
    let fulls: Vec<(String, String)> = g
        .defs
        .messages
        .iter()
        .map(|m| (m.full.clone(), m.package.clone()))
        .chain(
            g.defs
                .enums
                .iter()
                .map(|e| (e.full.clone(), e.package.clone())),
        )
        .collect();
    for (full, pkg) in &fulls {
        let rel = if pkg.is_empty() {
            full.clone()
        } else {
            full[pkg.len() + 1..].to_string()
        };
        let mut base = camel(&rel);
        if *pkg != g.package {
            base = format!("{}{}", camel(pkg.rsplit('.').next().unwrap_or("")), base);
        }
        let mut name = base.clone();
        let mut i = 2;
        while !used.insert(name.clone()) {
            name = format!("{}{}", base, i);
            i += 1;
        }
        g.names.insert(full.clone(), name);
    }
    // recursion through singular message fields: such fields are Options
    let mut edges: BTreeMap<String, Vec<(String, String)>> = BTreeMap::new();
    for m in &g.defs.messages {
        for f in &m.fields {
            if f.label != Label::Singular || f.oneof.is_some() {
                continue;
            }
            if let FType::Named(t) = &f.ty {
                if SCALARS.contains(&t.as_str()) {
                    continue;
                }
                let full = g.resolve(t, &m.full)?;
                if matches!(g.by_full.get(&full), Some(Def::Msg)) {
                    edges
                        .entry(m.full.clone())
                        .or_default()
                        .push((full, f.name.clone()));
                }
            }
        }
    }
    let reaches = |from: &str, to: &str| -> bool {
        let mut stack = vec![from.to_string()];
        let mut seen = BTreeSet::new();
        while let Some(x) = stack.pop() {
            if x == to {
                return true;
            }
            if !seen.insert(x.clone()) {
                continue;
            }
            for (y, _) in edges.get(&x).into_iter().flatten() {
                stack.push(y.clone());
            }
        }
        false
    };
    for (from, es) in &edges {
        for (to, field) in es {
            if reaches(to, from) {
                g.boxed.insert((from.clone(), field.clone()));
            }
        }
    }
    let file = path
        .file_name()
        .map(|n| n.to_string_lossy().to_string())
        .unwrap_or_default();
    let _ = writeln!(
        g.out,
        "# Generated by `fwp proto --import {}`: types, codecs, clients and\n# server routes{}. Do not edit; see docs/grpc.md.\n",
        file,
        if g.package.is_empty() {
            String::new()
        } else {
            format!(" for package {}", g.package)
        }
    );
    for i in 0..g.defs.enums.len() {
        g.enum_def(i);
    }
    let mut order: Vec<usize> = (0..g.defs.messages.len()).collect();
    order.sort_by_key(|i| g.defs.messages[*i].full.clone());
    for i in order {
        if g.defs.messages[i].full != EMPTY {
            g.message_def(i)?;
        }
    }
    let services = std::mem::take(&mut g.defs.services);
    for s in &services {
        g.service_def(s)?;
    }
    let text = g.out.trim_end().to_string() + "\n";
    crate::fmt::format_source(&text).map_err(|d| {
        format!(
            "internal: the generated module does not parse: {}\n{}",
            d.message, text
        )
    })
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn names() {
        assert_eq!(kebab("HelloRequest"), "hello-request");
        assert_eq!(kebab("HTTPRequest"), "http-request");
        assert_eq!(kebab("user_name"), "user-name");
        assert_eq!(kebab("SayHello"), "say-hello");
        assert_eq!(field_name("type"), "type-field");
        assert_eq!(camel("route_guide"), "RouteGuide");
    }
}
