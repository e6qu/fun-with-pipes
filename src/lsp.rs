//! `fwp lsp`: a language server over stdio (JSON-RPC 2.0 with
//! `Content-Length` framing).
//!
//! Documents are synchronized in full. On every change the document is
//! type-checked (with its imports, read from disk) and linted, and the
//! diagnostics are published. Hover shows inferred types, definition jumps
//! to top-level and imported names (and to the standard library sources
//! when they are present next to the compiler), document symbols list the
//! declarations, formatting runs `fwp fmt`, and completion offers the
//! file's names and the standard library's with their types.

use std::collections::HashMap;
use std::io::{BufRead, Write};
use std::path::{Path, PathBuf};

use crate::ast::{Decl, Expr, ExprKind, Module};
use crate::diag::{Diagnostic, Level, Span};
use crate::driver::{check_source, show_scheme, Compilation};
use crate::env::Scope;
use crate::json::Json;
use crate::lexer::{lex, Tok, Token};
use crate::parser::parse_module_recover;

/// Serve requests from `input` until `exit`; returns the exit status (0
/// after a `shutdown` request, 1 otherwise).
pub fn serve(mut input: impl BufRead, output: impl Write) -> i32 {
    let mut server = Server {
        out: output,
        docs: HashMap::new(),
        shutdown: false,
        std_items: None,
    };
    while let Some(body) = read_message(&mut input) {
        let Ok(msg) = Json::parse(&body) else {
            server.send(error_response(Json::Null, -32700, "parse error"));
            continue;
        };
        if msg.get("method").and_then(Json::as_str) == Some("exit") {
            return if server.shutdown { 0 } else { 1 };
        }
        server.handle(&msg);
    }
    1
}

/// One framed message body, or `None` at the end of the input.
pub fn read_message(r: &mut impl BufRead) -> Option<String> {
    let mut len = None;
    loop {
        let mut line = String::new();
        if r.read_line(&mut line).ok()? == 0 {
            return None;
        }
        let line = line.trim_end();
        if line.is_empty() {
            if len.is_some() {
                break;
            }
            continue;
        }
        if let Some((k, v)) = line.split_once(':') {
            if k.eq_ignore_ascii_case("content-length") {
                len = v.trim().parse::<usize>().ok();
            }
        }
    }
    let mut buf = vec![0; len?];
    r.read_exact(&mut buf).ok()?;
    String::from_utf8(buf).ok()
}

/// Frame a message.
pub fn frame(msg: &Json) -> String {
    let body = msg.to_string();
    format!("Content-Length: {}\r\n\r\n{}", body.len(), body)
}

fn error_response(id: Json, code: i64, message: &str) -> Json {
    Json::obj(vec![
        ("jsonrpc", Json::str("2.0")),
        ("id", id),
        (
            "error",
            Json::obj(vec![
                ("code", Json::Num(code as f64)),
                ("message", Json::str(message)),
            ]),
        ),
    ])
}

struct Doc {
    text: String,
    path: PathBuf,
    /// The declarations that parsed (file id 0).
    module: Module,
    /// The type-checked program, when it has no errors.
    comp: Option<Compilation>,
}

struct Server<W: Write> {
    out: W,
    docs: HashMap<String, Doc>,
    shutdown: bool,
    /// Standard library completions: name and type.
    std_items: Option<Vec<(String, String)>>,
}

fn num(n: u32) -> Json {
    Json::Num(n as f64)
}

impl<W: Write> Server<W> {
    fn send(&mut self, msg: Json) {
        let _ = self.out.write_all(frame(&msg).as_bytes());
        let _ = self.out.flush();
    }

    fn notify(&mut self, method: &str, params: Json) {
        self.send(Json::obj(vec![
            ("jsonrpc", Json::str("2.0")),
            ("method", Json::str(method)),
            ("params", params),
        ]));
    }

    fn handle(&mut self, msg: &Json) {
        let method = msg.get("method").and_then(Json::as_str).unwrap_or("");
        let params = msg.get("params").cloned().unwrap_or(Json::Null);
        let id = msg.get("id").cloned();
        let result = match method {
            "initialize" => Some(capabilities()),
            "shutdown" => {
                self.shutdown = true;
                Some(Json::Null)
            }
            "textDocument/didOpen" => {
                let uri = params.at(&["textDocument", "uri"]).and_then(Json::as_str);
                let text = params.at(&["textDocument", "text"]).and_then(Json::as_str);
                if let (Some(uri), Some(text)) = (uri, text) {
                    self.update(uri.to_string(), text.to_string());
                }
                None
            }
            "textDocument/didChange" => {
                let uri = params.at(&["textDocument", "uri"]).and_then(Json::as_str);
                let text = params
                    .get("contentChanges")
                    .and_then(Json::as_array)
                    .and_then(|cs| cs.last())
                    .and_then(|c| c.get("text"))
                    .and_then(Json::as_str);
                if let (Some(uri), Some(text)) = (uri, text) {
                    self.update(uri.to_string(), text.to_string());
                }
                None
            }
            "textDocument/didClose" => {
                if let Some(uri) = params.at(&["textDocument", "uri"]).and_then(Json::as_str) {
                    self.docs.remove(uri);
                    self.publish(uri, vec![]);
                }
                None
            }
            "textDocument/hover"
            | "textDocument/definition"
            | "textDocument/references"
            | "textDocument/rename"
            | "textDocument/documentSymbol"
            | "textDocument/formatting"
            | "textDocument/completion" => {
                let uri = params
                    .at(&["textDocument", "uri"])
                    .and_then(Json::as_str)
                    .unwrap_or("");
                let pos = params.get("position").map(|p| {
                    let n = |k| p.get(k).and_then(Json::as_f64).unwrap_or(0.0) as u32;
                    (n("line"), n("character"))
                });
                Some(self.request(method, uri, pos, &params))
            }
            _ if id.is_some() && !method.starts_with("$/") => {
                self.send(error_response(id.unwrap(), -32601, "method not found"));
                return;
            }
            _ => None,
        };
        if let (Some(id), Some(result)) = (id, result) {
            self.send(Json::obj(vec![
                ("jsonrpc", Json::str("2.0")),
                ("id", id),
                ("result", result),
            ]));
        }
    }

    fn request(&mut self, method: &str, uri: &str, pos: Option<(u32, u32)>, params: &Json) -> Json {
        if method == "textDocument/completion" {
            return self.completion(uri);
        }
        let Some(doc) = self.docs.get(uri) else {
            return Json::Null;
        };
        let at = pos.map(|(l, c)| from_lsp(&doc.text, l, c));
        match method {
            "textDocument/hover" => at.and_then(|(l, c)| hover(doc, l, c)),
            "textDocument/definition" => at.and_then(|(l, c)| definition(doc, l, c)),
            "textDocument/references" => {
                let decl =
                    params.at(&["context", "includeDeclaration"]) != Some(&Json::Bool(false));
                at.map(|(l, c)| {
                    let uri = path_to_uri(&doc.path);
                    Json::Arr(
                        occurrences(doc, l, c, decl)
                            .into_iter()
                            .map(|sp| location_in(&uri, &doc.text, sp))
                            .collect(),
                    )
                })
            }
            "textDocument/rename" => {
                let new = params.get("newName").and_then(Json::as_str).unwrap_or("");
                at.and_then(|(l, c)| rename(doc, l, c, new))
            }
            "textDocument/documentSymbol" => Some(symbols(doc)),
            _ => formatting(doc),
        }
        .unwrap_or(Json::Null)
    }

    fn update(&mut self, uri: String, text: String) {
        let path = uri_to_path(&uri);
        let mut next_id = 0;
        let (module, _) = parse_module_recover(&text, 0, &mut next_id);
        let name = path.to_string_lossy().to_string();
        let mut diags: Vec<(Diagnostic, Option<&str>)> = Vec::new();
        let mut elsewhere = Vec::new();
        let comp = match check_source(&name, &text, path.parent()) {
            Ok(c) => {
                diags.extend(
                    c.warnings
                        .iter()
                        .filter(|w| w.span.file == c.root)
                        .map(|w| (w.clone(), None)),
                );
                Some(c)
            }
            Err(f) => {
                for d in &f.diagnostics {
                    if d.span.file == f.root {
                        diags.push((d.clone(), None));
                    } else if d.level == Level::Error {
                        // an error in an imported file: shown at the top
                        let file = f.sm.get(d.span.file).map_or("", |s| s.name.as_str());
                        let mut d = d.clone();
                        d.message =
                            format!("{}:{}:{}: {}", file, d.span.line, d.span.col, d.message);
                        d.span = Span {
                            file: 0,
                            line: 1,
                            col: 1,
                            len: 1,
                        };
                        elsewhere.push(d);
                    }
                }
                None
            }
        };
        let lints = crate::lint::lint_source(&text, 0).unwrap_or_default();
        for w in &lints {
            // the compiler reports a missing binding as an error already
            let dup = diags.iter().any(|(d, _)| {
                d.level == Level::Error
                    && d.span.line == w.diag.span.line
                    && d.span.col == w.diag.span.col
            });
            if !dup {
                diags.push((w.diag.clone(), Some(w.code)));
            }
        }
        let mut list: Vec<Json> = diags
            .iter()
            .map(|(d, code)| diagnostic(&text, d, *code))
            .collect();
        list.extend(elsewhere.iter().map(|d| diagnostic(&text, d, None)));
        self.docs.insert(
            uri.clone(),
            Doc {
                text,
                path,
                module,
                comp,
            },
        );
        self.publish(&uri, list);
    }

    fn publish(&mut self, uri: &str, diagnostics: Vec<Json>) {
        self.notify(
            "textDocument/publishDiagnostics",
            Json::obj(vec![
                ("uri", Json::str(uri)),
                ("diagnostics", Json::Arr(diagnostics)),
            ]),
        );
    }

    fn completion(&mut self, uri: &str) -> Json {
        if self.std_items.is_none() {
            let items = match self.docs.get(uri).and_then(|d| d.comp.as_ref()) {
                Some(c) => std_items(c),
                None => check_source("<lsp>", "", None)
                    .map(|c| std_items(&c))
                    .unwrap_or_default(),
            };
            self.std_items = Some(items);
        }
        let mut items = Vec::new();
        if let Some(doc) = self.docs.get(uri) {
            for d in &doc.module.decls {
                let name = match d {
                    Decl::Bind(b) => &b.name,
                    Decl::Foreign { name, .. } => name,
                    _ => continue,
                };
                items.push(completion_item(
                    name,
                    &type_of_name(doc, name).unwrap_or_default(),
                ));
            }
        }
        for (name, ty) in self.std_items.as_deref().unwrap_or_default() {
            items.push(completion_item(name, ty));
        }
        Json::Arr(items)
    }
}

fn capabilities() -> Json {
    Json::obj(vec![
        (
            "capabilities",
            Json::obj(vec![
                ("textDocumentSync", Json::Num(1.0)),
                ("hoverProvider", Json::Bool(true)),
                ("definitionProvider", Json::Bool(true)),
                ("referencesProvider", Json::Bool(true)),
                ("renameProvider", Json::Bool(true)),
                ("documentSymbolProvider", Json::Bool(true)),
                ("documentFormattingProvider", Json::Bool(true)),
                ("completionProvider", Json::obj(vec![])),
            ]),
        ),
        (
            "serverInfo",
            Json::obj(vec![
                ("name", Json::str("fwp")),
                ("version", Json::str(env!("CARGO_PKG_VERSION"))),
            ]),
        ),
    ])
}

fn completion_item(name: &str, ty: &str) -> Json {
    let mut fields = vec![("label", Json::str(name)), ("kind", Json::Num(3.0))];
    if !ty.is_empty() {
        fields.push(("detail", Json::str(ty)));
    }
    Json::obj(fields)
}

/// The standard library's names and types.
fn std_items(c: &Compilation) -> Vec<(String, String)> {
    let mut items: Vec<(String, String)> = c
        .env
        .globals
        .iter()
        .filter_map(|(k, g)| {
            let n = k.strip_prefix("std::")?;
            let public = n.starts_with(|c: char| c.is_ascii_lowercase()) && !n.contains(['#', '[']);
            public.then(|| {
                let ty = g.scheme.as_ref().map(|s| show_scheme(&c.env, s));
                (n.to_string(), ty.unwrap_or_default())
            })
        })
        .collect();
    items.sort();
    items
}

// ----- positions

/// LSP position (0-based line, UTF-16 offset) to 1-based line and column
/// in characters.
fn from_lsp(text: &str, line: u32, character: u32) -> (u32, u32) {
    let l = text.split('\n').nth(line as usize).unwrap_or("");
    let mut units = 0;
    let mut col = 1;
    for ch in l.chars() {
        if units >= character {
            break;
        }
        units += ch.len_utf16() as u32;
        col += 1;
    }
    (line + 1, col)
}

/// 1-based line and character column to an LSP position.
fn to_lsp(text: &str, line: u32, col: u32) -> Json {
    let l = text
        .split('\n')
        .nth(line.saturating_sub(1) as usize)
        .unwrap_or("");
    let units: usize = l
        .chars()
        .take(col.saturating_sub(1) as usize)
        .map(char::len_utf16)
        .sum();
    Json::obj(vec![
        ("line", num(line.saturating_sub(1))),
        ("character", Json::Num(units as f64)),
    ])
}

fn range(text: &str, sp: Span) -> Json {
    Json::obj(vec![
        ("start", to_lsp(text, sp.line, sp.col)),
        ("end", to_lsp(text, sp.line, sp.col + sp.len.max(1))),
    ])
}

fn diagnostic(text: &str, d: &Diagnostic, code: Option<&str>) -> Json {
    let mut message = d.message.clone();
    if let Some(c) = code {
        message = message
            .strip_suffix(&format!(" [{}]", c))
            .unwrap_or(&message)
            .to_string();
    }
    for n in &d.notes {
        message.push_str("\nnote: ");
        message.push_str(n);
    }
    let mut fields = vec![
        ("range", range(text, d.span)),
        (
            "severity",
            Json::Num(if d.level == Level::Error { 1.0 } else { 2.0 }),
        ),
        ("source", Json::str("fwp")),
        ("message", Json::str(message)),
    ];
    if let Some(c) = code {
        fields.push(("code", Json::str(c)));
    }
    Json::obj(fields)
}

// ----- URIs

pub fn uri_to_path(uri: &str) -> PathBuf {
    let raw = uri.strip_prefix("file://").unwrap_or(uri);
    let bytes = raw.as_bytes();
    let mut out = Vec::new();
    let mut i = 0;
    while i < bytes.len() {
        if bytes[i] == b'%' && i + 2 < bytes.len() {
            if let Ok(b) = u8::from_str_radix(&raw[i + 1..i + 3], 16) {
                out.push(b);
                i += 3;
                continue;
            }
        }
        out.push(bytes[i]);
        i += 1;
    }
    PathBuf::from(String::from_utf8_lossy(&out).into_owned())
}

pub fn path_to_uri(path: &Path) -> String {
    let abs = std::fs::canonicalize(path).unwrap_or_else(|_| path.to_path_buf());
    let mut out = String::from("file://");
    for b in abs.to_string_lossy().bytes() {
        if b.is_ascii_alphanumeric() || b"/-._~".contains(&b) {
            out.push(b as char);
        } else {
            out.push_str(&format!("%{:02X}", b));
        }
    }
    out
}

// ----- queries

/// The token under a position.
fn token_at(text: &str, line: u32, col: u32) -> Option<Token> {
    let toks = lex(text, 0).ok()?;
    toks.into_iter()
        .find(|t| t.span.line == line && t.span.col <= col && col < t.span.col + t.span.len.max(1))
}

/// The main module's expression nodes (leaves) at a span.
fn node_at(c: &Compilation, sp: Span) -> Option<(crate::ast::NodeId, Span)> {
    let mut found = None;
    for b in c.env.bindings.iter().filter(|b| b.module == "main") {
        b.body.walk(&mut |e: &Expr| {
            let leaf = matches!(
                e.kind,
                ExprKind::Var(_) | ExprKind::Ctor(_) | ExprKind::Selector(_)
            );
            if leaf && e.span.file == c.root && e.span.line == sp.line && e.span.col == sp.col {
                found = Some((e.id, e.span));
            }
        });
    }
    found
}

/// The type of an expression node, if inference recorded one.
fn node_type(c: &Compilation, sp: Span) -> Option<String> {
    let (id, _) = node_at(c, sp)?;
    let t = c.typed.node_types.get(&id)?;
    let t = c.env.table.zonk(t);
    let mut p = crate::types::Printer::new(&c.env.table);
    p.prepare(&[&t]);
    Some(p.show(&t))
}

/// The type of a top-level name of the document: inferred, or from its
/// signature when the program does not type-check.
fn type_of_name(doc: &Doc, name: &str) -> Option<String> {
    if let Some(c) = &doc.comp {
        let canon = c.env.resolve_value(
            &Scope {
                module: "main".into(),
            },
            name,
        )?;
        return c.env.globals[&canon]
            .scheme
            .as_ref()
            .map(|s| show_scheme(&c.env, s));
    }
    doc.module.decls.iter().find_map(|d| match d {
        Decl::Sig { sig, .. } if sig.name == name => Some(crate::pretty::ty(&sig.ty)),
        Decl::Foreign { name: n, ty, .. } if n == name => Some(crate::pretty::ty(ty)),
        _ => None,
    })
}

fn hover(doc: &Doc, line: u32, col: u32) -> Option<Json> {
    let tok = token_at(&doc.text, line, col)?;
    let local = doc.comp.as_ref().and_then(|c| node_type(c, tok.span));
    let text = match &tok.tok {
        Tok::Ident(name) => {
            let shown = crate::types::display_name(name);
            match (type_of_name(doc, name), local) {
                (Some(g), Some(l)) if g != l => {
                    format!("```fwp\n{} : {}\n```\nhere: `{}`", shown, g, l)
                }
                (Some(g), _) => format!("```fwp\n{} : {}\n```", shown, g),
                (None, Some(l)) => format!("```fwp\n{} : {}\n```", shown, l),
                (None, None) => return None,
            }
        }
        Tok::Upper(name) => {
            let c = doc.comp.as_ref()?;
            let scope = Scope {
                module: "main".into(),
            };
            if let Ok(ctor) = c.env.resolve_ctor(&scope, name) {
                let s = show_scheme(&c.env, &c.env.ctors.get(&ctor)?.scheme);
                format!("```fwp\n{} : {}\n```", name, s)
            } else {
                let t = c.env.resolve_type(&scope, name)?;
                format!("```fwp\ntype {}\n```", crate::types::display_name(&t))
            }
        }
        _ => format!("```fwp\n{}\n```", local?),
    };
    Some(Json::obj(vec![
        (
            "contents",
            Json::obj(vec![
                ("kind", Json::str("markdown")),
                ("value", Json::str(text)),
            ]),
        ),
        ("range", range(&doc.text, tok.span)),
    ]))
}

/// The location of a span in a file of a compilation.
fn location(c: &Compilation, sp: Span, doc: &Doc) -> Option<Json> {
    if sp.file == c.root {
        return Some(location_in(&path_to_uri(&doc.path), &doc.text, sp));
    }
    let file = c.sm.get(sp.file)?;
    let path = match file.name.strip_prefix("<std>/") {
        // the standard library's sources, when they are next to the compiler
        Some(n) => Path::new(env!("CARGO_MANIFEST_DIR")).join("lib").join(n),
        None => PathBuf::from(&file.name),
    };
    if !path.exists() {
        return None;
    }
    Some(location_in(&path_to_uri(&path), &file.text, sp))
}

fn location_in(uri: &str, text: &str, sp: Span) -> Json {
    Json::obj(vec![("uri", Json::str(uri)), ("range", range(text, sp))])
}

fn definition(doc: &Doc, line: u32, col: u32) -> Option<Json> {
    let tok = token_at(&doc.text, line, col)?;
    let (name, upper) = match &tok.tok {
        Tok::Ident(n) => (n.clone(), false),
        Tok::Upper(n) => (n.clone(), true),
        _ => return None,
    };
    if let Some(c) = &doc.comp {
        let scope = Scope {
            module: "main".into(),
        };
        let span = if upper {
            let ty = match c.env.resolve_ctor(&scope, &name) {
                Ok(ctor) => c.env.ctors.get(&ctor).map(|d| d.type_name.clone()),
                Err(_) => c.env.resolve_type(&scope, &name),
            }?;
            c.env.types.get(&ty)?.span
        } else {
            let canon = c.env.resolve_value(&scope, &name)?;
            c.env.globals.get(&canon)?.span
        };
        return location(c, span, doc);
    }
    // without types: the file's own declarations
    let sp = doc.module.decls.iter().find_map(|d| match d {
        Decl::Bind(b) if b.name == name => Some(b.span),
        Decl::Foreign { name: n, span, .. } if *n == name => Some(*span),
        Decl::Type(t) if t.name == name => Some(t.span),
        Decl::Type(t) => match &t.body {
            crate::ast::TypeBody::Variants(vs) => {
                vs.iter().find(|v| v.name == name).map(|_| t.span)
            }
            _ => None,
        },
        _ => None,
    })?;
    Some(location_in(&path_to_uri(&doc.path), &doc.text, sp))
}

/// The names a document declares: bindings, signatures, foreign
/// functions, types and their constructors, with the line of each.
fn declared(doc: &Doc) -> Vec<(String, u32)> {
    let mut out = Vec::new();
    for d in &doc.module.decls {
        let line = d.span().line;
        match d {
            Decl::Bind(b) => out.push((b.name.clone(), line)),
            Decl::Sig { sig, .. } => out.push((sig.name.clone(), line)),
            Decl::Foreign { name, .. } => out.push((name.clone(), line)),
            Decl::Type(t) => {
                out.push((t.name.clone(), line));
                if let crate::ast::TypeBody::Variants(vs) = &t.body {
                    out.extend(vs.iter().map(|v| (v.name.clone(), line)));
                }
            }
            _ => {}
        }
    }
    out
}

/// The spans of the name under a position, everywhere in the document
/// (top-level names have no local shadows); with `decl`, also where it is
/// declared (the first occurrence on a line that declares it).
fn occurrences(doc: &Doc, line: u32, col: u32, decl: bool) -> Vec<Span> {
    let Some(tok) = token_at(&doc.text, line, col) else {
        return vec![];
    };
    let name = match &tok.tok {
        Tok::Ident(n) | Tok::Upper(n) => n.clone(),
        _ => return vec![],
    };
    let decl_lines: Vec<u32> = declared(doc)
        .into_iter()
        .filter(|(n, _)| *n == name)
        .map(|(_, l)| l)
        .collect();
    let mut out = Vec::new();
    let mut seen_lines = Vec::new();
    for t in lex(&doc.text, 0).unwrap_or_default() {
        if !matches!(&t.tok, Tok::Ident(n) | Tok::Upper(n) if *n == name) {
            continue;
        }
        let declaring = decl_lines.contains(&t.span.line) && !seen_lines.contains(&t.span.line);
        if declaring {
            seen_lines.push(t.span.line);
        }
        if decl || !declaring {
            out.push(t.span);
        }
    }
    out
}

/// Every occurrence of a name the document declares, renamed to `new`
/// (a name of the same kind: lowercase for values, capitalized for types
/// and constructors). Uses in other files are not renamed.
fn rename(doc: &Doc, line: u32, col: u32, new: &str) -> Option<Json> {
    let tok = token_at(&doc.text, line, col)?;
    let name = match &tok.tok {
        Tok::Ident(n) | Tok::Upper(n) => n.clone(),
        _ => return None,
    };
    if !declared(doc).iter().any(|(n, _)| *n == name) {
        return None;
    }
    let same_kind = match lex(new, 0).ok()?.as_slice() {
        [t, end] if matches!(end.tok, Tok::Eof) => matches!(
            (&t.tok, &tok.tok),
            (Tok::Ident(_), Tok::Ident(_)) | (Tok::Upper(_), Tok::Upper(_))
        ),
        _ => false,
    };
    if !same_kind {
        return None;
    }
    let edits: Vec<Json> = occurrences(doc, line, col, true)
        .into_iter()
        .map(|sp| {
            Json::obj(vec![
                ("range", range(&doc.text, sp)),
                ("newText", Json::str(new)),
            ])
        })
        .collect();
    Some(Json::obj(vec![(
        "changes",
        Json::obj(vec![(path_to_uri(&doc.path).as_str(), Json::Arr(edits))]),
    )]))
}

fn symbols(doc: &Doc) -> Json {
    let toks = lex(&doc.text, 0).unwrap_or_default();
    let decls = &doc.module.decls;
    let starts: Vec<usize> = decls
        .iter()
        .map(|d| {
            let line = d.span().line;
            toks.iter()
                .position(|t| t.bol && t.span.line == line)
                .unwrap_or(0)
        })
        .collect();
    let mut out = Vec::new();
    for (i, d) in decls.iter().enumerate() {
        let (name, kind, sel) = match d {
            Decl::Bind(b) => (b.name.clone(), 12, b.span),
            Decl::Macro(b) => (format!("{}!", b.name), 12, b.span),
            Decl::Foreign { name, span, .. } => (name.clone(), 12, *span),
            Decl::Type(t) => {
                let kind = match t.body {
                    crate::ast::TypeBody::Variants(_) => 10,
                    _ => 23,
                };
                (t.name.clone(), kind, t.span)
            }
            Decl::Trait(t) => (t.name.clone(), 11, t.span),
            Decl::Impl(im) => (
                format!(
                    "impl {}[{}]",
                    im.trait_name,
                    im.args
                        .iter()
                        .map(crate::pretty::ty)
                        .collect::<Vec<_>>()
                        .join(", ")
                ),
                5,
                im.span,
            ),
            Decl::Test { name, span, .. } => (format!("test {:?}", name), 6, *span),
            Decl::Import { module, span } => (module.clone(), 2, *span),
            // signatures and exports belong to their bindings
            Decl::Sig { sig, .. }
                if !decls
                    .iter()
                    .any(|b| matches!(b, Decl::Bind(b) if b.name == sig.name)) =>
            {
                (sig.name.clone(), 12, sig.span)
            }
            _ => continue,
        };
        // from the declaration's first token to its last one
        let stop = starts
            .get(i + 1)
            .copied()
            .unwrap_or(toks.len().saturating_sub(1));
        let first = toks.get(starts[i]).map_or(sel, |t| t.span);
        let last = toks[..stop.min(toks.len())]
            .iter()
            .rev()
            .find(|t| t.tok != Tok::Eof)
            .map_or(sel, |t| t.span);
        let full = Json::obj(vec![
            ("start", to_lsp(&doc.text, first.line, first.col)),
            ("end", to_lsp(&doc.text, last.line, last.col + last.len)),
        ]);
        out.push(Json::obj(vec![
            ("name", Json::str(name)),
            ("kind", Json::Num(kind as f64)),
            ("range", full),
            ("selectionRange", range(&doc.text, sel)),
        ]));
    }
    Json::Arr(out)
}

fn formatting(doc: &Doc) -> Option<Json> {
    let formatted = crate::fmt::format_source(&doc.text).ok()?;
    if formatted == doc.text {
        return Some(Json::Arr(vec![]));
    }
    let lines: Vec<&str> = doc.text.split('\n').collect();
    let last = lines.len() as u32;
    let end_col = lines.last().map_or(0, |l| l.chars().count() as u32) + 1;
    Some(Json::Arr(vec![Json::obj(vec![
        (
            "range",
            Json::obj(vec![
                ("start", to_lsp(&doc.text, 1, 1)),
                ("end", to_lsp(&doc.text, last, end_col)),
            ]),
        ),
        ("newText", Json::str(formatted)),
    ])]))
}
