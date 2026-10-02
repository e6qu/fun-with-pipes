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
    /// A request header (`# header: X-Request-Id`).
    Header {
        name: String,
        required: bool,
    },
    /// Every value of a request header (a `List`).
    Headers(String),
    /// A cookie of the request (`# cookie: session`).
    Cookie {
        name: String,
        required: bool,
    },
    /// The whole request: a parameter of type `Request`.
    Request,
    /// What the verifier of an authenticated endpoint returned: a
    /// parameter of the principal's type.
    Principal,
}

/// Where a field of an options record is read.
#[derive(Clone, Debug, PartialEq)]
pub enum Place {
    Query,
    Header(String),
    Cookie(String),
}

/// A field of an options record: a query parameter.
#[derive(Clone, Debug, PartialEq)]
pub struct Field {
    /// The JSON name of the field, which is also the query parameter's.
    pub name: String,
    pub ty: MT,
    pub kind: FieldKind,
    pub doc: String,
    pub place: Place,
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
    /// `RestReply[T]`: the status and headers of the function's choosing,
    /// and `T` as the body (none for `()`).
    Reply(MT),
}

/// A security scheme of an endpoint (`# auth:`).
#[derive(Clone, Debug, PartialEq, Eq, PartialOrd, Ord)]
pub enum Auth {
    /// `Authorization: Bearer <token>`.
    Bearer,
    /// An API key in a header, query parameter or cookie (the place) of a
    /// name.
    ApiKey { place: String, name: String },
}

impl Auth {
    /// The name of the scheme in `components/securitySchemes`.
    pub fn scheme_name(&self) -> String {
        match self {
            Auth::Bearer => "bearerAuth".into(),
            Auth::ApiKey { name, .. } => {
                let clean: String = name
                    .chars()
                    .filter(|c| c.is_ascii_alphanumeric() || matches!(c, '-' | '_' | '.'))
                    .collect();
                format!("apiKey-{}", clean)
            }
        }
    }
}

/// Cross-origin requests the server allows (`# cors:`).
#[derive(Clone, Debug, PartialEq)]
pub struct Cors {
    /// Allowed origins (`*` for any).
    pub origins: Vec<String>,
}

/// The function that verifies credentials (`authenticate`), and the
/// type of what it returns (the principal).
#[derive(Clone, Debug)]
pub struct Verifier {
    pub function: String,
    pub principal: MT,
}

/// Everything a REST server is made of.
#[derive(Clone, Debug)]
pub struct Api {
    pub endpoints: Vec<Endpoint>,
    pub verifier: Option<Verifier>,
    pub cors: Option<Cors>,
}

/// The name of the function that verifies credentials.
pub const VERIFIER: &str = "authenticate";

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
    /// The other success statuses of a `RestReply` (`# status: 200, 201`).
    pub statuses: Vec<i64>,
    /// Headers a `RestReply` may set (`# response-header: Location ...`),
    /// with their descriptions.
    pub response_headers: Vec<(String, String)>,
    /// The security schemes, any of which grants access; empty for none.
    pub auth: Vec<Auth>,
    /// How long a call may take (an fwp duration literal: `5s`).
    pub timeout: Option<String>,
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
            Shape::Adt(_, vs) | Shape::Untagged(_, vs) => {
                vs.into_iter().flat_map(|(_, f)| f).collect()
            }
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
        Shape::Adt(_, vs) | Shape::Untagged(_, vs) => vs.into_iter().map(|(n, _)| n).collect(),
        _ => vec![],
    }
}

/// The endpoints of a program's exported functions.
pub fn endpoints(prog: &Program) -> Result<Vec<Endpoint>, String> {
    Ok(api(prog)?.endpoints)
}

/// The verifier of credentials, if the program has one: `authenticate :
/// String -> Result[P, String]`, compiled by name (`Roots::names`) or
/// exported.
fn verifier(prog: &Program) -> Result<Option<Verifier>, String> {
    let canonical = format!("main::{}", VERIFIER);
    let fid = prog
        .named
        .iter()
        .find(|(n, _)| *n == canonical)
        .or_else(|| prog.exports.iter().find(|(n, _)| n == VERIFIER))
        .map(|(_, f)| *f);
    let Some(fid) = fid else {
        return Ok(None);
    };
    let f = &prog.funcs[fid];
    let bad = || {
        format!(
            "`{}` must have type `String -> Result[P, String]` (the credential, then the principal or why it is refused), not `{}`",
            VERIFIER, f.ty
        )
    };
    let (ps, result) = f.ty.params(1);
    if f.arity != 1 || ps.len() != 1 || *ps[0] != MT::con("std::String") {
        return Err(bad());
    }
    let principal = match result {
        MT::Con(n, args)
            if n == "std::Result" && args.len() == 2 && args[1] == MT::con("std::String") =>
        {
            args[0].clone()
        }
        _ => return Err(bad()),
    };
    check_json(&principal, prog).map_err(|e| format!("`{}`: {}", VERIFIER, e))?;
    Ok(Some(Verifier {
        function: VERIFIER.into(),
        principal,
    }))
}

/// A `# timeout:` value: an fwp duration literal.
fn parse_duration(s: &str) -> Option<String> {
    let s = s.trim();
    let digits = s.find(|c: char| !c.is_ascii_digit() && c != '.')?;
    let (n, unit) = s.split_at(digits);
    let ok = !n.is_empty()
        && n.parse::<f64>().is_ok_and(|x| x > 0.0)
        && matches!(unit, "ns" | "us" | "ms" | "s" | "min" | "h");
    ok.then(|| s.to_string())
}

/// A `# auth:` line: `bearer`, `api-key [header|query|cookie] name` or
/// `none` (`None`).
fn parse_auth(s: &str) -> Result<Option<Auth>, String> {
    let words: Vec<&str> = s.split_whitespace().collect();
    match words[..] {
        ["none"] => Ok(None),
        ["bearer"] => Ok(Some(Auth::Bearer)),
        ["api-key", name] => Ok(Some(Auth::ApiKey {
            place: "header".into(),
            name: name.to_string(),
        })),
        ["api-key", place, name] if matches!(place, "header" | "query" | "cookie") => {
            Ok(Some(Auth::ApiKey {
                place: place.into(),
                name: name.to_string(),
            }))
        }
        _ => {
            Err(format!(
            "invalid `# auth:{}` (it is `bearer`, `api-key [header|query|cookie] name` or `none`)",
            if s.is_empty() { String::new() } else { format!(" {}", s.trim()) }
        ))
        }
    }
}

/// The `# auth:` lines of a block: `None` when there are none.
fn auth_lines(lines: &[String]) -> Result<Option<Vec<Auth>>, String> {
    let mut out = None;
    for l in lines {
        if let Some(v) = l.strip_prefix("auth:") {
            let list: &mut Vec<Auth> = out.get_or_insert_with(Vec::new);
            if let Some(a) = parse_auth(v)? {
                if !list.contains(&a) {
                    list.push(a);
                }
            }
        }
    }
    Ok(out)
}

/// A header name: a token.
fn is_token(s: &str) -> bool {
    !s.is_empty()
        && s.chars()
            .all(|c| c.is_ascii_alphanumeric() || "!#$%&'*+-.^_`|~".contains(c))
}

/// The server's configuration from the module's comment, and its
/// endpoints.
pub fn api(prog: &Program) -> Result<Api, String> {
    let verifier = verifier(prog)?;
    let module = &prog.docs.http;
    let default_auth = auth_lines(module)?.unwrap_or_default();
    let mut default_timeout = None;
    let mut cors = None;
    for l in module {
        if let Some(v) = l.strip_prefix("timeout:") {
            default_timeout = Some(
                parse_duration(v)
                    .ok_or_else(|| format!("invalid `# timeout:{}` (a duration, as `5s`)", v))?,
            );
        } else if let Some(v) = l.strip_prefix("cors:") {
            let origins: Vec<String> = v
                .split([' ', ','])
                .filter(|o| !o.is_empty())
                .map(str::to_string)
                .collect();
            if origins.is_empty() {
                return Err("`# cors:` needs the allowed origins (or `*`)".into());
            }
            cors = Some(Cors { origins });
        }
    }
    let mut out: Vec<Endpoint> = Vec::new();
    for (name, fid) in &prog.exports {
        let f = &prog.funcs[*fid];
        if !crate::cli::is_command(name) || f.arity == 0 {
            continue;
        }
        if name == VERIFIER && verifier.is_some() {
            continue;
        }
        let mut ep = endpoint(prog, name, f.arity as usize, &f.ty, verifier.as_ref())?;
        if ep.auth.is_empty() && !has_auth_line(prog, name) {
            ep.auth = default_auth.clone();
        }
        if ep.timeout.is_none() {
            ep.timeout = default_timeout.clone();
        }
        if !ep.auth.is_empty() && verifier.is_none() {
            return Err(format!(
                "`{}` needs authentication (`# auth:`), but the program has no `{} : String -> Result[P, String]` to verify credentials",
                name, VERIFIER
            ));
        }
        if ep.auth.is_empty() && ep.params.iter().any(|p| p.source == Source::Principal) {
            return Err(format!(
                "`{}` takes the principal (`{}`) but needs no authentication (`# auth:`)",
                name,
                verifier
                    .as_ref()
                    .map(|v| v.principal.to_string())
                    .unwrap_or_default()
            ));
        }
        for (method, path) in [("GET", "/openapi.json"), ("GET", "/docs")] {
            if ep.method == method && ep.path == path {
                return Err(format!(
                    "`{}`: `{} {}` is a route of the server (the OpenAPI document and its page)",
                    name, method, path
                ));
            }
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
    Ok(Api {
        endpoints: out,
        verifier,
        cors,
    })
}

fn has_auth_line(prog: &Program, name: &str) -> bool {
    prog.docs
        .funcs
        .get(name)
        .is_some_and(|d| d.http.iter().any(|l| l.starts_with("auth:")))
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

/// A `# header:` or `# cookie:` line: the name, and the parameter it
/// binds if it names one (`X-Request-Id -> request-id`).
fn binding(value: &str) -> (String, Option<String>) {
    match value.split_once("->") {
        Some((h, p)) => (h.trim().to_string(), Some(p.trim().to_ascii_lowercase())),
        None => (value.trim().to_string(), None),
    }
}

fn endpoint(
    prog: &Program,
    name: &str,
    arity: usize,
    ty: &MT,
    verifier: Option<&Verifier>,
) -> Result<Endpoint, String> {
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
    let mut statuses: Vec<i64> = Vec::new();
    let mut error_status = 500;
    let mut errors = Vec::new();
    let mut headers: Vec<(String, Option<String>, bool)> = Vec::new();
    let mut response_headers = Vec::new();
    let mut timeout = None;
    for line in &doc.http {
        let (key, value) = line.split_once(':').unwrap_or((line, ""));
        let bad = |what: &str| format!("`{}`: invalid `# {}:` line `{}`", name, what, value.trim());
        match key {
            "route" => {
                (method, path) = parse_route(value).map_err(|e| format!("`{}`: {}", name, e))?
            }
            "status" => {
                for v in value.split([',', ' ']).filter(|v| !v.is_empty()) {
                    statuses.push(parse_status(v).ok_or_else(|| bad("status"))?);
                }
                if statuses.is_empty() {
                    return Err(bad("status"));
                }
            }
            "header" | "cookie" => {
                let (h, p) = binding(value);
                if !is_token(&h) {
                    return Err(bad(key));
                }
                headers.push((h, p, key == "cookie"));
            }
            "response-header" => {
                let v = value.trim();
                let (h, d) = v.split_once(' ').unwrap_or((v, ""));
                if !is_token(h) {
                    return Err(bad(key));
                }
                response_headers.push((h.to_string(), d.trim().to_string()));
            }
            "timeout" => timeout = Some(parse_duration(value).ok_or_else(|| bad("timeout"))?),
            "auth" => {}
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
    let auth = auth_lines(&doc.http)
        .map_err(|e| format!("`{}`: {}", name, e))?
        .unwrap_or_default();
    let outcome = match jsontype::shape(result, prog) {
        Shape::Option(t) => Outcome::Option(t),
        Shape::Unit => Outcome::Unit,
        _ => match result {
            MT::Con(n, args) if n == "std::Result" && args.len() == 2 => {
                Outcome::Result(args[0].clone(), args[1].clone())
            }
            MT::Con(n, args) if n == "std::RestReply" && args.len() == 1 => {
                Outcome::Reply(args[0].clone())
            }
            _ => Outcome::Value,
        },
    };
    if statuses.len() > 1 && !matches!(outcome, Outcome::Reply(_)) {
        return Err(format!(
            "`{}`: `# status:` gives several statuses, but only a `RestReply` result chooses its status",
            name
        ));
    }
    if !response_headers.is_empty() && !matches!(outcome, Outcome::Reply(_)) {
        return Err(format!(
            "`{}`: `# response-header:` needs a `RestReply` result, which sets headers",
            name
        ));
    }
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
    let empty = match &outcome {
        Outcome::Unit => true,
        Outcome::Reply(t) => matches!(jsontype::shape(t, prog), Shape::Unit),
        _ => false,
    };
    let status = statuses
        .first()
        .copied()
        .unwrap_or(if empty { 204 } else { 200 });
    let ctx = Ctx {
        prog,
        name,
        doc: &doc,
        method: &method,
        path: &path,
        headers: &headers,
        principal: verifier.map(|v| &v.principal),
    };
    let params = sources(&ctx, &params)?;
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
        statuses: statuses.iter().skip(1).copied().collect(),
        response_headers,
        auth,
        timeout,
    })
}

fn plural(n: usize, what: &str) -> String {
    format!("{} {}{}", n, what, if n == 1 { "" } else { "s" })
}

/// What the sources of an endpoint's parameters depend on.
struct Ctx<'a> {
    prog: &'a Program,
    name: &'a str,
    doc: &'a crate::cli::FuncDoc,
    method: &'a str,
    path: &'a str,
    /// `# header:` and `# cookie:` lines: the name, the parameter, and
    /// whether it is a cookie.
    headers: &'a [(String, Option<String>, bool)],
    principal: Option<&'a MT>,
}

/// The kind of a scalar parameter type: a value, an `Option` or a `List`
/// of scalars, or none of them.
fn scalar_kind(t: &MT, prog: &Program) -> Option<FieldKind> {
    match jsontype::shape(t, prog) {
        Shape::Bool => Some(FieldKind::Switch),
        Shape::Option(e) if is_scalar(&e, prog) => Some(FieldKind::Optional),
        Shape::List(e) if is_scalar(&e, prog) => Some(FieldKind::Repeated),
        _ if is_scalar(t, prog) => Some(FieldKind::Value),
        _ => None,
    }
}

/// Where each parameter of a function comes from.
fn sources(cx: &Ctx, params: &[MT]) -> Result<Vec<Param>, String> {
    let (prog, name, doc, method, path) = (cx.prog, cx.name, cx.doc, cx.method, cx.path);
    let n = params.len();
    let mut src: Vec<Option<Source>> = vec![None; n];
    let mut names: Vec<String> = (1..=n).map(|i| format!("arg{}", i)).collect();
    for (i, t) in params.iter().enumerate() {
        if matches!(jsontype::shape(t, prog), Shape::Unit) {
            src[i] = Some(Source::Unit);
        } else if *t == MT::con("std::Request") {
            src[i] = Some(Source::Request);
            names[i] = "request".into();
        } else if cx.principal == Some(t) && !t.to_string().starts_with("std::") {
            src[i] = Some(Source::Principal);
            names[i] = "principal".into();
        }
    }
    // the options record: its fields are query parameters (or headers
    // and cookies)
    let context = |s: &Option<Source>| matches!(s, Some(Source::Request | Source::Principal));
    let ordinary: Vec<usize> = (0..n).filter(|i| !context(&src[*i])).collect();
    let first = ordinary.first().copied().filter(|i| src[*i].is_none());
    if let Some(Shape::Record(_, fs, order, json)) =
        first.map(|i| jsontype::shape(&params[i], prog))
    {
        let first = first.unwrap();
        if ordinary.len() >= 2 || !has_body(method) {
            let docs = jsontype::field_docs(prog, &params[first]);
            let mut fields = Vec::new();
            for i in order {
                let (l, t) = &fs[i];
                let fdoc = docs.and_then(|d| d.get(l));
                let place = match (
                    fdoc.and_then(|d| d.header.clone()),
                    fdoc.and_then(|d| d.cookie.clone()),
                ) {
                    (Some(h), _) => Place::Header(h),
                    (None, Some(c)) => Place::Cookie(c),
                    _ => Place::Query,
                };
                let what = match place {
                    Place::Query => "a query parameter",
                    Place::Header(_) => "a header",
                    Place::Cookie(_) => "a cookie",
                };
                let kind = match scalar_kind(t, prog) {
                    Some(FieldKind::Repeated) if matches!(place, Place::Cookie(_)) => None,
                    k => k,
                };
                let Some(kind) = kind else {
                    return Err(format!(
                        "`{}`: the field `{}` of its options record is {}, but it has type `{}` (they are numbers, strings, `Bool`, enums, `Duration`, or `Option` or `List` of them)",
                        name, l, what, t
                    ));
                };
                let doc = fdoc
                    .map(|d| jsontype::without_json_name(&d.doc))
                    .unwrap_or_default();
                fields.push(Field {
                    name: json[i].clone(),
                    ty: t.clone(),
                    kind,
                    doc,
                    place,
                });
            }
            src[first] = Some(Source::Fields(fields));
            names[first] = "query".into();
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
    // the parameter each header and cookie binds
    let bound: Vec<String> = cx
        .headers
        .iter()
        .map(|(h, p, _)| p.clone().unwrap_or_else(|| h.to_ascii_lowercase()))
        .collect();
    if doc.args.is_none() {
        // path parameters, then headers and cookies, name the positional
        // parameters in order
        let wanted = vars.len() + bound.len();
        if wanted > positional.len() {
            return Err(format!(
                "the route of `{}` has {}{}, but the function has {} to take them",
                name,
                plural(vars.len(), "path parameter"),
                if bound.is_empty() {
                    String::new()
                } else {
                    format!(" and {}", plural(bound.len(), "header or cookie"))
                },
                plural(positional.len(), "parameter"),
            ));
        }
        for (i, v) in positional.iter().zip(vars.iter().chain(&bound)) {
            names[*i] = v.clone();
        }
    }
    let listed = |names: &[String]| {
        positional
            .iter()
            .map(|i| names[*i].clone())
            .collect::<Vec<_>>()
            .join(", ")
    };
    let find = |v: &str, src: &[Option<Source>], names: &[String]| -> Option<usize> {
        positional
            .iter()
            .copied()
            .find(|i| names[*i] == v && src[*i].is_none())
    };
    for v in &vars {
        let Some(i) = find(v, &src, &names) else {
            return Err(format!(
                "`{{{}}}` in the route of `{}` names no parameter (they are {})",
                v,
                name,
                listed(&names)
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
    for ((h, _, cookie), p) in cx.headers.iter().zip(&bound) {
        let what = if *cookie { "cookie" } else { "header" };
        let Some(i) = find(p, &src, &names) else {
            return Err(format!(
                "the {} `{}` of `{}` binds `{}`, which names no parameter (they are {})",
                what,
                h,
                name,
                p,
                listed(&names)
            ));
        };
        let t = &params[i];
        let s = match (scalar_kind(t, prog), cookie) {
            (Some(FieldKind::Optional), false) => Source::Header {
                name: h.clone(),
                required: false,
            },
            (Some(FieldKind::Optional), true) => Source::Cookie {
                name: h.clone(),
                required: false,
            },
            (Some(FieldKind::Repeated), false) => Source::Headers(h.clone()),
            (Some(FieldKind::Value) | Some(FieldKind::Switch), false) => Source::Header {
                name: h.clone(),
                required: true,
            },
            (Some(FieldKind::Value) | Some(FieldKind::Switch), true) => Source::Cookie {
                name: h.clone(),
                required: true,
            },
            _ => {
                return Err(format!(
                    "`{}`: the {} `{}` has type `{}` ({}s are numbers, strings, `Bool`, enums, `Duration`, or `Option`{} of them)",
                    name,
                    what,
                    h,
                    t,
                    what,
                    if *cookie { "s" } else { "s or `List`s" }
                ))
            }
        };
        src[i] = Some(s);
        names[i] = h.clone();
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
        src[i] = Some(match scalar_kind(t, prog) {
            Some(FieldKind::Optional) => Source::Query {
                name: names[i].clone(),
                required: false,
            },
            Some(FieldKind::Repeated) => Source::Queries(names[i].clone()),
            Some(_) => Source::Query {
                name: names[i].clone(),
                required: true,
            },
            None => {
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
        Source::Fields(fs) if fs.iter().all(|f| f.place == Place::Query) => format!(
            "RestSource.Fields [{}]",
            fs.iter()
                .map(|f| format!("({}, {})", fwp_string(&f.name), f.kind as u8))
                .collect::<Vec<_>>()
                .join(", ")
        ),
        Source::Fields(fs) => format!(
            "RestSource.Options [{}]",
            fs.iter()
                .map(|f| format!(
                    "RestField {{ name = {}, kind = {}, place = {} }}",
                    fwp_string(&f.name),
                    f.kind as u8,
                    match &f.place {
                        Place::Query => "RestPlace.Query".to_string(),
                        Place::Header(h) => format!("(RestPlace.Header {})", fwp_string(h)),
                        Place::Cookie(c) => format!("(RestPlace.Cookie {})", fwp_string(c)),
                    }
                ))
                .collect::<Vec<_>>()
                .join(", ")
        ),
        Source::Body { optional } => format!("RestSource.Body {}", flag(*optional)),
        Source::Unit => "RestSource.Unit".into(),
        Source::Header { name, required } => {
            format!("RestSource.Header {} {}", fwp_string(name), flag(*required))
        }
        Source::Headers(n) => format!("RestSource.Headers {}", fwp_string(n)),
        Source::Cookie { name, required } => {
            format!("RestSource.Cookie {} {}", fwp_string(name), flag(*required))
        }
        Source::Request => "RestSource.Request".into(),
        Source::Principal => "RestSource.Principal".into(),
    }
}

fn auth_expr(a: &Auth) -> String {
    match a {
        Auth::Bearer => "RestAuth.Bearer".into(),
        Auth::ApiKey { place, name } => {
            format!("RestAuth.ApiKey {} {}", fwp_string(place), fwp_string(name))
        }
    }
}

fn strings(v: &[String]) -> String {
    format!(
        "[{}]",
        v.iter()
            .map(|s| fwp_string(s))
            .collect::<Vec<_>>()
            .join(", ")
    )
}

/// The CORS policy of an API: the origins of `# cors:` (none without
/// it), the methods of its routes, and the headers its endpoints read and
/// set.
pub fn cors_policy(api: &Api) -> (Vec<String>, Vec<String>, Vec<String>, Vec<String>) {
    let origins = api
        .cors
        .as_ref()
        .map(|c| c.origins.clone())
        .unwrap_or_default();
    let mut methods: Vec<String> = Vec::new();
    let mut headers: Vec<String> = vec!["Content-Type".into()];
    let mut expose: Vec<String> = Vec::new();
    let add = |v: &mut Vec<String>, s: &str| {
        if !v.iter().any(|x| x.eq_ignore_ascii_case(s)) {
            v.push(s.to_string());
        }
    };
    for e in &api.endpoints {
        add(&mut methods, &e.method);
        for a in &e.auth {
            match a {
                Auth::Bearer => add(&mut headers, "Authorization"),
                Auth::ApiKey { place, name } if place == "header" => add(&mut headers, name),
                _ => {}
            }
        }
        for p in &e.params {
            match &p.source {
                Source::Header { name, .. } | Source::Headers(name) => add(&mut headers, name),
                Source::Fields(fs) => {
                    for f in fs {
                        if let Place::Header(h) = &f.place {
                            add(&mut headers, h);
                        }
                    }
                }
                _ => {}
            }
        }
        for (h, _) in &e.response_headers {
            add(&mut expose, h);
        }
    }
    if methods.iter().any(|m| m == "GET") {
        add(&mut methods, "HEAD");
    }
    (origins, methods, headers, expose)
}

/// The generated declarations of a REST server: its `main`, serving the
/// endpoints, the OpenAPI document and its page.
pub fn server_source(api: &Api, openapi: &str, docs: &str) -> String {
    let eps = &api.endpoints;
    let mut out = String::from("# generated by fwp for `--rest` (src/rest.rs)\n\n");
    let max = eps.iter().map(|e| e.params.len()).max().unwrap_or(0);
    for n in 4..=max {
        // `fwp-rest-uncurryN f (x1, ..., xN)` is `f x1 ... xN`: the tuple
        // as `(x1, (x2, ..., xN))`, then `uncurry` and the helper of N - 1
        let vars: Vec<String> = (1..=n).map(|i| format!("a{}", i)).collect();
        let rest: Vec<String> = (1..n).map(|i| format!("{} = .{}", i - 1, i)).collect();
        let prev = if n == 4 {
            "uncurry3".to_string()
        } else {
            format!("fwp-rest-uncurry{}", n - 1)
        };
        let _ = writeln!(
            out,
            "fwp-rest-uncurry{n} : ({arrows}r ! e) -> ({tuple}) -> r ! e\nfwp-rest-uncurry{n} =\n    flip compose {prev}\n    | uncurry\n    | compose (make {{ 0 = .0, 1 = make {{ {rest} }} }})\n",
            n = n,
            arrows = vars.iter().map(|v| format!("{} -> ", v)).collect::<String>(),
            tuple = vars.join(", "),
            prev = prev,
            rest = rest.join(", "),
        );
    }
    let (origins, methods, headers, expose) = cors_policy(api);
    out.push_str("fwp-rest-main =\n    rest.serve RestApi {\n        openapi = ");
    out.push_str(&fwp_string(openapi));
    out.push_str(",\n        docs = ");
    out.push_str(&fwp_string(docs));
    let _ = write!(
        out,
        ",\n        cors = RestCors {{ origins = {}, methods = {}, headers = {}, expose = {}, max-age = 600 }},\n        routes = [\n",
        strings(&origins),
        strings(&methods),
        strings(&headers),
        strings(&expose)
    );
    for e in eps {
        let wrapper = match &e.outcome {
            Outcome::Option(_) => "rest.endpoint-option",
            Outcome::Result(..) => "rest.endpoint-result",
            Outcome::Reply(MT::Record(fs)) if fs.is_empty() => "rest.endpoint-reply-empty",
            Outcome::Reply(_) => "rest.endpoint-reply",
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
        let _ = write!(
            out,
            "            {} (RestRoute {{ method = {}, path = {}, sources = [{}], status = {}, error-status = {}, errors = [{}] }}) {}",
            wrapper,
            fwp_string(&e.method),
            fwp_string(&e.path),
            sources.join(", "),
            e.status,
            e.error_status,
            errors.join(", "),
            f
        );
        if let Some(t) = &e.timeout {
            let _ = write!(out, " | rest.within {}", t);
        }
        if !e.auth.is_empty() {
            let v = api.verifier.as_ref().expect("a verifier");
            let _ = write!(
                out,
                " | rest.secured {} [{}]",
                v.function,
                e.auth.iter().map(auth_expr).collect::<Vec<_>>().join(", ")
            );
        }
        out.push_str(",\n");
    }
    out.push_str("        ],\n    }\n");
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
pub fn describe(path: &Path) -> Result<(Compilation, Program, Api, crate::json::Json), Failure> {
    // the verifier is compiled by name: it need not be exported
    let mut roots = crate::mono::Roots {
        exports: true,
        ..Default::default()
    };
    if let Ok(text) = std::fs::read_to_string(path) {
        if text.contains("auth:") {
            roots.names.push(format!("main::{}", VERIFIER));
        }
    }
    let (c, prog) = crate::driver::compile_file(path, roots)?;
    let api = api(&prog).map_err(failure)?;
    let doc = crate::openapi::document(&prog, &api, &title(path)).map_err(failure)?;
    Ok((c, prog, api, doc))
}

/// Compile a file as a REST server: a program whose `main` serves its
/// exported functions and its OpenAPI document. The warnings are those
/// of the user's file.
pub fn compile(path: &Path) -> Result<(Compilation, Program), Failure> {
    let (c, _, api, doc) = describe(path)?;
    let text = std::fs::read_to_string(path).map_err(|e| failure(e.to_string()))?;
    let extra = server_source(&api, &doc.pretty(), &crate::openapi::docs_page(&doc));
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
