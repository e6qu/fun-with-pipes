//! REST endpoints from exported functions. `fwp build --rest` and
//! `fwp serve --rest` serve every exported function of a file as an HTTP
//! endpoint, as `fwp build --cli` makes each one a command:
//!
//! * The route is `POST /<command>` unless a doc comment line
//!   `# route: GET /items/{id}` gives another (GET, POST, PUT, PATCH or
//!   DELETE; `{name}` segments are path parameters).
//! * A record first parameter of a function with several parameters, or
//!   of a GET or DELETE route, is an *options record*: its fields are query
//!   parameters, as they are flags on a command line.
//! * The other parameters are named by `# args:` (else `arg1`, `arg2`,
//!   ... by position, and path parameters take the names of the route in
//!   order). A path parameter binds the parameter of its name; with a
//!   body (POST, PUT, PATCH) the last remaining parameter is the JSON
//!   body; the others are query parameters. `()` parameters are implicit.
//! * The result is the JSON body of a 200 (`# status: 201` gives another;
//!   `()` is a 204). `None` is a 404; an `Err` result or a raised
//!   `Error[E]` is `{"error": E}` with the status of `# error:` (`404`, or
//!   per variant: `NotFound 404, Invalid 422`), else the error's `status`
//!   field, else 500. Arguments that do not decode are a 400.
//!
//! The program is the user's file plus a generated `main` ([`ENTRY`])
//! that serves a router of `rest.endpoint`s (`lib/rest.fwp`), compiled
//! like any other program, so both backends serve the same endpoints. The
//! OpenAPI document (`src/openapi.rs`) is derived from the same
//! [`Endpoint`]s and served at `/openapi.json`.

use std::fmt::Write as _;
use std::path::Path;

use crate::driver::{Compilation, Failure};
use crate::ir::{Program, MT};
use crate::jsontype::{self, Shape};

/// The canonical name of the generated `main` of a REST server.
pub const ENTRY: &str = "main::fwp-rest-main";

/// Where an argument comes from (`RestSource` in `lib/rest.fwp`).
#[derive(Clone, Debug, PartialEq)]
pub enum Source {
    Path(String),
    Query {
        name: String,
        required: bool,
    },
    /// Every value of a repeated query parameter (a `List`).
    Queries(String),
    /// The fields of an options record, from the query string.
    Fields(Vec<Field>),
    Body {
        optional: bool,
    },
    Unit,
}

/// A field of an options record: a query parameter.
#[derive(Clone, Debug, PartialEq)]
pub struct Field {
    /// The JSON name of the field, which is also the query parameter's.
    pub name: String,
    pub ty: MT,
    pub kind: FieldKind,
    pub doc: String,
}

#[derive(Clone, Copy, Debug, PartialEq)]
pub enum FieldKind {
    Value = 0,
    Optional = 1,
    Repeated = 2,
    Switch = 3,
}

#[derive(Clone, Debug)]
pub struct Param {
    pub name: String,
    pub ty: MT,
    pub source: Source,
}

/// How the result of a function becomes a response.
#[derive(Clone, Debug, PartialEq)]
pub enum Outcome {
    Value,
    /// `Option[T]`: `None` is a 404.
    Option(MT),
    /// `Result[T, E]`: `Err` is an error response.
    Result(MT, MT),
    /// `()`: no body.
    Unit,
}

#[derive(Clone, Debug)]
pub struct Endpoint {
    /// The exported function.
    pub function: String,
    /// Its command name (`# command:`), the OpenAPI operation id.
    pub name: String,
    pub method: String,
    /// The path template: `/items/{id}`.
    pub path: String,
    pub params: Vec<Param>,
    pub result: MT,
    pub outcome: Outcome,
    /// The `Error[E]` effect.
    pub error: Option<MT>,
    pub status: i64,
    pub error_status: i64,
    /// Statuses of error variants.
    pub errors: Vec<(String, i64)>,
    /// The doc comment.
    pub doc: Vec<String>,
}

/// The effects an endpoint may perform: those of an HTTP handler.
const EFFECTS: &[&str] = &["IO", "FileIO", "Network", "Async", "Error"];

fn has_body(method: &str) -> bool {
    matches!(method, "POST" | "PUT" | "PATCH")
}

/// Types that can be a single query or path parameter.
pub fn is_scalar(mt: &MT, prog: &Program) -> bool {
    matches!(
        jsontype::shape(mt, prog),
        Shape::Int(_)
            | Shape::Wide(_)
            | Shape::F32
            | Shape::F64
            | Shape::TInt(_)
            | Shape::Trit
            | Shape::Str
            | Shape::Bool
            | Shape::Enum(..)
            | Shape::Duration
    )
}

/// Why values of a type cannot be JSON, if they cannot.
pub fn check_json(mt: &MT, prog: &Program) -> Result<(), String> {
    fn go(mt: &MT, prog: &Program, seen: &mut Vec<MT>) -> Result<(), String> {
        if seen.contains(mt) {
            return Ok(());
        }
        seen.push(mt.clone());
        let parts: Vec<MT> = match jsontype::shape(mt, prog) {
            Shape::Other => return Err(format!("values of type `{}` cannot be sent as JSON", mt)),
            Shape::Option(t) | Shape::List(t) | Shape::Array(t) | Shape::Set(t) => vec![t],
            Shape::Map(k, v) => vec![k, v],
            Shape::Tuple(ts) => ts,
            Shape::Record(_, fs, _, _) => fs.into_iter().map(|(_, t)| t).collect(),
            Shape::Adt(_, vs) => vs.into_iter().flat_map(|(_, f)| f).collect(),
            _ => vec![],
        };
        for t in &parts {
            go(t, prog, seen)?;
        }
        Ok(())
    }
    go(mt, prog, &mut Vec::new())
}

/// A route line: the method and the path template.
fn parse_route(s: &str) -> Result<(String, String), String> {
    let mut parts = s.split_whitespace();
    let (Some(m), Some(p), None) = (parts.next(), parts.next(), parts.next()) else {
        return Err(format!(
            "`# route:{}` must be a method and a path, as in `# route: GET /items/{{id}}`",
            s
        ));
    };
    let method = m.to_ascii_uppercase();
    if !matches!(method.as_str(), "GET" | "POST" | "PUT" | "PATCH" | "DELETE") {
        return Err(format!(
            "unknown method `{}` in `# route:` (GET, POST, PUT, PATCH or DELETE)",
            m
        ));
    }
    if !p.starts_with('/') {
        return Err(format!(
            "the path `{}` in `# route:` must start with `/`",
            p
        ));
    }
    for seg in p.split('/').filter(|s| !s.is_empty()) {
        let ok = match seg.strip_prefix('{').and_then(|s| s.strip_suffix('}')) {
            Some(v) => {
                !v.is_empty()
                    && v.chars()
                        .all(|c| c.is_ascii_alphanumeric() || c == '-' || c == '_')
            }
            None => !seg.contains(['{', '}', '?', '#', ':']),
        };
        if !ok {
            return Err(format!(
                "invalid segment `{}` in the path `{}`: a path parameter is a whole segment `{{name}}`",
                seg, p
            ));
        }
    }
    Ok((method, p.to_string()))
}

/// The path parameters of a template, in order.
pub fn path_vars(path: &str) -> Vec<String> {
    path.split('/')
        .filter_map(|s| s.strip_prefix('{').and_then(|s| s.strip_suffix('}')))
        .map(str::to_string)
        .collect()
}

fn parse_status(s: &str) -> Option<i64> {
    s.trim()
        .parse::<i64>()
        .ok()
        .filter(|n| (100..=599).contains(n))
}

/// The variant names of an error type, if it is a variant type.
fn variants(mt: &MT, prog: &Program) -> Vec<String> {
    match jsontype::shape(mt, prog) {
        Shape::Enum(_, ns) => ns,
        Shape::Adt(_, vs) => vs.into_iter().map(|(n, _)| n).collect(),
        _ => vec![],
    }
}

/// The endpoints of a program's exported functions.
pub fn endpoints(prog: &Program) -> Result<Vec<Endpoint>, String> {
    let mut out: Vec<Endpoint> = Vec::new();
    for (name, fid) in &prog.exports {
        let f = &prog.funcs[*fid];
        if !crate::cli::is_command(name) || f.arity == 0 {
            continue;
        }
        let ep = endpoint(prog, name, f.arity as usize, &f.ty)?;
        if ep.method == "GET" && ep.path == "/openapi.json" {
            return Err(format!(
                "`{}`: `GET /openapi.json` is the route of the OpenAPI document",
                name
            ));
        }
        if let Some(other) = out
            .iter()
            .find(|e| e.method == ep.method && route_key(&e.path) == route_key(&ep.path))
        {
            return Err(format!(
                "`{}` and `{}` have the same route `{} {}`",
                other.function, name, ep.method, ep.path
            ));
        }
        out.push(ep);
    }
    if out.is_empty() {
        return Err("the program exports no functions to serve".into());
    }
    Ok(out)
}

/// A path with its parameters' names erased.
fn route_key(p: &str) -> Vec<String> {
    p.split('/')
        .filter(|s| !s.is_empty())
        .map(|s| {
            if s.starts_with('{') {
                "{}".to_string()
            } else {
                s.to_string()
            }
        })
        .collect()
}

fn endpoint(prog: &Program, name: &str, arity: usize, ty: &MT) -> Result<Endpoint, String> {
    let doc = prog.docs.funcs.get(name).cloned().unwrap_or_default();
    let command = doc.command.clone().unwrap_or_else(|| name.to_string());
    let (error, labels) = prog.export_effects.get(name).cloned().unwrap_or_default();
    if let Some(l) = labels.iter().find(|l| !EFFECTS.contains(&l.as_str())) {
        return Err(format!(
            "`{}` performs `{}`, which REST endpoints cannot (they may perform {})",
            name,
            l,
            EFFECTS.join(", ")
        ));
    }
    let (ps, result) = ty.params(arity);
    let params: Vec<MT> = ps.into_iter().cloned().collect();
    for t in params.iter().chain([result]).chain(error.iter()) {
        check_json(t, prog).map_err(|e| format!("`{}` cannot be an endpoint: {}", name, e))?;
    }
    // annotations
    let (mut method, mut path) = ("POST".to_string(), format!("/{}", command));
    let mut status = None;
    let mut error_status = 500;
    let mut errors = Vec::new();
    for line in &doc.http {
        let (key, value) = line.split_once(':').unwrap_or((line, ""));
        let bad = |what: &str| format!("`{}`: invalid `# {}:` line `{}`", name, what, value.trim());
        match key {
            "route" => {
                (method, path) = parse_route(value).map_err(|e| format!("`{}`: {}", name, e))?
            }
            "status" => status = Some(parse_status(value).ok_or_else(|| bad("status"))?),
            _ => {
                for item in value.split(',').map(str::trim).filter(|s| !s.is_empty()) {
                    match item.split_whitespace().collect::<Vec<_>>()[..] {
                        [n] => error_status = parse_status(n).ok_or_else(|| bad("error"))?,
                        [v, n] => errors
                            .push((v.to_string(), parse_status(n).ok_or_else(|| bad("error"))?)),
                        _ => return Err(bad("error")),
                    }
                }
            }
        }
    }
    let outcome = match jsontype::shape(result, prog) {
        Shape::Option(t) => Outcome::Option(t),
        Shape::Unit => Outcome::Unit,
        _ => match result {
            MT::Con(n, args) if n == "std::Result" && args.len() == 2 => {
                Outcome::Result(args[0].clone(), args[1].clone())
            }
            _ => Outcome::Value,
        },
    };
    let mut known: Vec<String> = error.iter().flat_map(|e| variants(e, prog)).collect();
    if let Outcome::Result(_, e) = &outcome {
        known.extend(variants(e, prog));
    }
    if let Some((v, _)) = errors.iter().find(|(v, _)| !known.contains(v)) {
        return Err(format!(
            "`{}`: `# error:` names `{}`, which is not a variant of its error type",
            name, v
        ));
    }
    let status = status.unwrap_or(if outcome == Outcome::Unit { 204 } else { 200 });
    let params = sources(prog, name, &doc, &method, &path, &params)?;
    Ok(Endpoint {
        function: name.to_string(),
        name: command,
        method,
        path,
        params,
        result: result.clone(),
        outcome,
        error,
        status,
        error_status,
        errors,
        doc: doc.lines.clone(),
    })
}

fn plural(n: usize, what: &str) -> String {
    format!("{} {}{}", n, what, if n == 1 { "" } else { "s" })
}

/// Where each parameter of a function comes from.
fn sources(
    prog: &Program,
    name: &str,
    doc: &crate::cli::FuncDoc,
    method: &str,
    path: &str,
    params: &[MT],
) -> Result<Vec<Param>, String> {
    let n = params.len();
    let mut src: Vec<Option<Source>> = vec![None; n];
    let mut names: Vec<String> = (1..=n).map(|i| format!("arg{}", i)).collect();
    for (i, t) in params.iter().enumerate() {
        if matches!(jsontype::shape(t, prog), Shape::Unit) {
            src[i] = Some(Source::Unit);
        }
    }
    // the options record: its fields are query parameters
    if let Some(Shape::Record(_, fs, order, json)) =
        params.first().map(|t| jsontype::shape(t, prog))
    {
        if n >= 2 || !has_body(method) {
            let docs = prog.docs.fields_of(&params[0]);
            let mut fields = Vec::new();
            for i in order {
                let (l, t) = &fs[i];
                let kind = match jsontype::shape(t, prog) {
                    Shape::Bool => FieldKind::Switch,
                    Shape::Option(e) if is_scalar(&e, prog) => FieldKind::Optional,
                    Shape::List(e) if is_scalar(&e, prog) => FieldKind::Repeated,
                    _ if is_scalar(t, prog) => FieldKind::Value,
                    _ => {
                        return Err(format!(
                            "`{}`: the field `{}` of its options record is a query parameter, but it has type `{}` (query parameters are numbers, strings, `Bool`, enums, `Duration`, or `Option` or `List` of them)",
                            name, l, t
                        ))
                    }
                };
                let doc = docs
                    .and_then(|d| d.get(l))
                    .map(|d| jsontype::without_json_name(&d.doc))
                    .unwrap_or_default();
                fields.push(Field {
                    name: json[i].clone(),
                    ty: t.clone(),
                    kind,
                    doc,
                });
            }
            src[0] = Some(Source::Fields(fields));
            names[0] = "query".into();
        }
    }
    let positional: Vec<usize> = (0..n).filter(|i| src[*i].is_none()).collect();
    if let Some(args) = &doc.args {
        if args.len() != positional.len() {
            return Err(format!(
                "the `# args:` line of `{}` names {}, but it has {}",
                name,
                plural(args.len(), "parameter"),
                positional.len()
            ));
        }
        for (i, a) in positional.iter().zip(args) {
            names[*i] = a.trim_end_matches("...").to_ascii_lowercase();
        }
    }
    let vars = path_vars(path);
    if doc.args.is_none() {
        // path parameters name the positional parameters in order
        if vars.len() > positional.len() {
            return Err(format!(
                "the route of `{}` has {}, but the function has {} to take them",
                name,
                plural(vars.len(), "path parameter"),
                plural(positional.len(), "parameter"),
            ));
        }
        for (i, v) in positional.iter().zip(&vars) {
            names[*i] = v.clone();
        }
    }
    for v in &vars {
        let Some(&i) = positional
            .iter()
            .find(|i| names[**i] == *v && src[**i].is_none())
        else {
            return Err(format!(
                "`{{{}}}` in the route of `{}` names no parameter (they are {})",
                v,
                name,
                positional
                    .iter()
                    .map(|i| names[*i].clone())
                    .collect::<Vec<_>>()
                    .join(", ")
            ));
        };
        if !is_scalar(&params[i], prog) {
            return Err(format!(
                "`{}`: the path parameter `{}` has type `{}` (path parameters are numbers, strings, `Bool`, enums or `Duration`)",
                name, v, params[i]
            ));
        }
        src[i] = Some(Source::Path(v.clone()));
    }
    let rest: Vec<usize> = (0..n).filter(|i| src[*i].is_none()).collect();
    for (k, &i) in rest.iter().enumerate() {
        let t = &params[i];
        if has_body(method) && k + 1 == rest.len() {
            let optional = matches!(jsontype::shape(t, prog), Shape::Option(_));
            src[i] = Some(Source::Body { optional });
            names[i] = "body".into();
            continue;
        }
        src[i] = Some(match jsontype::shape(t, prog) {
            Shape::Option(e) if is_scalar(&e, prog) => Source::Query {
                name: names[i].clone(),
                required: false,
            },
            Shape::List(e) if is_scalar(&e, prog) => Source::Queries(names[i].clone()),
            _ if is_scalar(t, prog) => Source::Query {
                name: names[i].clone(),
                required: true,
            },
            _ => {
                return Err(format!(
                    "`{}`: the parameter `{}` is a query parameter of `{} {}`, but it has type `{}` (query parameters are numbers, strings, `Bool`, enums, `Duration`, or `Option` or `List` of them; a body needs POST, PUT or PATCH)",
                    name, names[i], method, path, t
                ))
            }
        });
    }
    Ok(params
        .iter()
        .zip(src)
        .zip(names)
        .map(|((t, s), name)| Param {
            name,
            ty: t.clone(),
            source: s.unwrap(),
        })
        .collect())
}

// ---------------------------------------------------------------- the server

/// An fwp string literal.
pub fn fwp_string(s: &str) -> String {
    let mut out = String::from("\"");
    for c in s.chars() {
        match c {
            '\\' => out.push_str("\\\\"),
            '"' => out.push_str("\\\""),
            '\n' => out.push_str("\\n"),
            '\t' => out.push_str("\\t"),
            '\r' => out.push_str("\\r"),
            c if (c as u32) < 0x20 || c as u32 == 0x7f => {
                let _ = write!(out, "\\u{{{:x}}}", c as u32);
            }
            c => out.push(c),
        }
    }
    out.push('"');
    out
}

fn source_expr(s: &Source) -> String {
    let flag = |b: bool| if b { "True" } else { "False" };
    match s {
        Source::Path(n) => format!("RestSource.Path {}", fwp_string(n)),
        Source::Query { name, required } => {
            format!("RestSource.Query {} {}", fwp_string(name), flag(*required))
        }
        Source::Queries(n) => format!("RestSource.Queries {}", fwp_string(n)),
        Source::Fields(fs) => format!(
            "RestSource.Fields [{}]",
            fs.iter()
                .map(|f| format!("({}, {})", fwp_string(&f.name), f.kind as u8))
                .collect::<Vec<_>>()
                .join(", ")
        ),
        Source::Body { optional } => format!("RestSource.Body {}", flag(*optional)),
        Source::Unit => "RestSource.Unit".into(),
    }
}

/// The generated declarations of a REST server: its `main`, serving the
/// endpoints and the OpenAPI document.
pub fn server_source(eps: &[Endpoint], openapi: &str) -> String {
    let mut out = String::from("# generated by fwp for `--rest` (src/rest.rs)\n\n");
    let mut arities: Vec<usize> = eps
        .iter()
        .map(|e| e.params.len())
        .filter(|n| *n > 3)
        .collect();
    arities.sort();
    arities.dedup();
    for n in arities {
        // `fwp-rest-uncurryN f (x1, ..., xN)` is `f x1 ... xN`
        let vars: Vec<String> = (1..=n).map(|i| format!("a{}", i)).collect();
        let mut body = ".0".to_string();
        for i in 0..n {
            body = format!("fork apply (.1 | .{}) ({})", i, body);
        }
        let _ = writeln!(
            out,
            "fwp-rest-uncurry{n} : ({arrows}r ! e) -> ({tuple}) -> r ! e\nfwp-rest-uncurry{n} = curry ({body})\n",
            n = n,
            arrows = vars.iter().map(|v| format!("{} -> ", v)).collect::<String>(),
            tuple = vars.join(", "),
            body = body,
        );
    }
    out.push_str("fwp-rest-main =\n    rest.main\n        ");
    out.push_str(&fwp_string(openapi));
    out.push_str("\n        [\n");
    for e in eps {
        let wrapper = match e.outcome {
            Outcome::Option(_) => "rest.endpoint-option",
            Outcome::Result(..) => "rest.endpoint-result",
            _ => "rest.endpoint",
        };
        let f = match e.params.len() {
            1 => e.function.clone(),
            2 => format!("(uncurry {})", e.function),
            3 => format!("(uncurry3 {})", e.function),
            n => format!("(fwp-rest-uncurry{} {})", n, e.function),
        };
        let errors: Vec<String> = e
            .errors
            .iter()
            .map(|(v, s)| format!("({}, {})", fwp_string(v), s))
            .collect();
        let sources: Vec<String> = e.params.iter().map(|p| source_expr(&p.source)).collect();
        let _ = writeln!(
            out,
            "            {} (RestRoute {{ method = {}, path = {}, sources = [{}], status = {}, error-status = {}, errors = [{}] }}) {},",
            wrapper,
            fwp_string(&e.method),
            fwp_string(&e.path),
            sources.join(", "),
            e.status,
            e.error_status,
            errors.join(", "),
            f
        );
    }
    out.push_str("        ]\n");
    out
}

/// The program's file name without `.fwp`: the title of its API.
pub fn title(path: &Path) -> String {
    path.file_stem()
        .map(|s| s.to_string_lossy().to_string())
        .unwrap_or_else(|| "api".into())
}

fn failure(msg: String) -> Failure {
    Failure {
        rendered: format!("error: {}\n", msg),
        diagnostics: vec![],
        sm: Default::default(),
        root: u32::MAX,
    }
}

/// The endpoints and the OpenAPI document (pretty JSON) of a file.
pub fn describe(path: &Path) -> Result<(Compilation, Program, Vec<Endpoint>, String), Failure> {
    let roots = crate::mono::Roots {
        exports: true,
        ..Default::default()
    };
    let (c, prog) = crate::driver::compile_file(path, roots)?;
    let eps = endpoints(&prog).map_err(failure)?;
    let doc = crate::openapi::document(&prog, &eps, &title(path)).map_err(failure)?;
    Ok((c, prog, eps, doc.pretty()))
}

/// Compile a file as a REST server: a program whose `main` serves its
/// exported functions and its OpenAPI document. The warnings are those
/// of the user's file.
pub fn compile(path: &Path) -> Result<(Compilation, Program), Failure> {
    let (c, _, eps, spec) = describe(path)?;
    let text = std::fs::read_to_string(path).map_err(|e| failure(e.to_string()))?;
    let extra = server_source(&eps, &spec);
    let c2 = crate::driver::check_source_with(
        &path.to_string_lossy(),
        &text,
        path.parent(),
        Some(("<rest server>", &extra)),
    )?;
    let roots = crate::mono::Roots {
        entry: Some(ENTRY.to_string()),
        ..Default::default()
    };
    let (_, prog) = crate::driver::lower(c2, roots)?;
    Ok((c, prog))
}
