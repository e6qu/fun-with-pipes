//! The gRPC interface of fwp functions (docs/grpc.md): how parameters and
//! results map to request and response messages and to streams, method
//! paths and `# grpc:` annotations, the `.proto` file of a service, and the
//! file descriptor that server reflection returns.
//!
//! The rules are type-directed:
//!
//! | function | RPC |
//! |---|---|
//! | `A -> B -> R` | unary: request `{arg1, arg2}`, response `{value}` |
//! | `A -> Iterator[R]` | server streaming: one response per element |
//! | `A -> Channel[R] -> ()` | server streaming: one response per value sent |
//! | `Iterator[A] -> R` | client streaming: one request `{arg1}` per element |
//! | `Iterator[A] -> Iterator[R]`, `Iterator[A] -> Channel[R] -> ()` | bidirectional |
//!
//! A function with `Error[GrpcError]` reports failures as gRPC statuses;
//! another `Error[E]` is part of the response (`oneof result`).

use crate::ir::{Program, MT};
use crate::protobuf::{self, MethodSchema, Node, NodeId, Schema};

/// What a request carries.
#[derive(Clone, Debug, PartialEq)]
pub enum Input {
    /// One request message with these arguments.
    Args(Vec<MT>),
    /// A stream of request messages, each with one argument (`Iterator[T]`).
    Stream(MT),
}

/// What a response carries.
#[derive(Clone, Debug, PartialEq)]
pub enum Output {
    /// One response message.
    Value(MT),
    /// A stream of responses from a lazy `Iterator[T]` result.
    Iter(MT),
    /// A stream of responses from the values sent to a final
    /// `Channel[T]` parameter (the function returns `()`).
    Chan(MT),
}

#[derive(Clone, Debug, PartialEq)]
pub struct Shape {
    pub input: Input,
    pub output: Output,
    /// The function's error type is `GrpcError`: its errors are statuses.
    pub status_errors: bool,
    /// An `Iterator[Result[R, GrpcError]]` result: the messages are `R`s,
    /// and an `Err` ends the stream with its status (and a failed stream
    /// ends the caller's iterator with an `Err`). The element type.
    pub results: Option<MT>,
}

/// The standard library's `GrpcError` record.
pub fn grpc_error_type() -> MT {
    MT::con("std::GrpcError")
}

fn elem_of<'a>(mt: &'a MT, name: &str) -> Option<&'a MT> {
    match mt {
        MT::Con(n, args) if n == name && args.len() == 1 => Some(&args[0]),
        _ => None,
    }
}

/// The RPC shape of a function of type `ty` with `arity` parameters.
pub fn shape(ty: &MT, arity: usize, error: Option<&MT>) -> Shape {
    let (params, result) = ty.params(arity);
    let mut params: Vec<MT> = params.into_iter().cloned().collect();
    let mut output = Output::Value(result.clone());
    if let Some(c) = params.last().and_then(|p| elem_of(p, "std::Channel")) {
        if *result == MT::unit() {
            output = Output::Chan(c.clone());
            params.pop();
        }
    }
    let mut results = None;
    let iter = match &output {
        Output::Value(r) => elem_of(r, "std::Iterator").cloned(),
        _ => None,
    };
    if let Some(e) = iter {
        output = Output::Iter(e.clone());
        if let MT::Con(n, args) = &e {
            if n == "std::Result" && args.len() == 2 && args[1] == grpc_error_type() {
                output = Output::Iter(args[0].clone());
                results = Some(e.clone());
            }
        }
    }
    let input = match &params[..] {
        [p] => match elem_of(p, "std::Iterator") {
            Some(e) => Input::Stream(e.clone()),
            None => Input::Args(params.clone()),
        },
        _ => Input::Args(params),
    };
    Shape {
        input,
        output,
        status_errors: error == Some(&grpc_error_type()),
        results,
    }
}

impl Shape {
    pub fn client_streaming(&self) -> bool {
        matches!(self.input, Input::Stream(_))
    }

    pub fn server_streaming(&self) -> bool {
        !matches!(self.output, Output::Value(_))
    }

    /// The arguments of one request message.
    pub fn request_params(&self) -> Vec<MT> {
        match &self.input {
            Input::Args(ps) => ps.clone(),
            Input::Stream(t) => vec![t.clone()],
        }
    }

    /// The value of one response message.
    pub fn response_type(&self) -> &MT {
        match &self.output {
            Output::Value(t) | Output::Iter(t) | Output::Chan(t) => t,
        }
    }

    /// The error type carried in response messages (none when errors are
    /// statuses).
    pub fn message_error<'a>(&self, error: Option<&'a MT>) -> Option<&'a MT> {
        if self.status_errors {
            None
        } else {
            error
        }
    }

    /// Every type that crosses the wire.
    pub fn wire_types(&self, error: Option<&MT>) -> Vec<MT> {
        let mut v = self.request_params();
        v.push(self.response_type().clone());
        v.extend(self.message_error(error).cloned());
        v
    }

    /// The element type for which a received stream becomes an iterator:
    /// a client stream for servers, an `Iterator` result for clients.
    pub fn iter_elem(&self, server: bool) -> Option<&MT> {
        match (server, &self.input, &self.output) {
            (true, Input::Stream(t), _) => Some(t),
            (false, _, Output::Iter(t)) => Some(self.results.as_ref().unwrap_or(t)),
            _ => None,
        }
    }
}

/// The request and response messages of a method.
pub fn method_schema(
    schema: &mut Schema,
    prog: &Program,
    method: &str,
    shape: &Shape,
    error: Option<&MT>,
) -> Result<MethodSchema, String> {
    schema.method(
        prog,
        method,
        &shape.request_params(),
        shape.response_type(),
        shape.message_error(error),
    )
}

// ------------------------------------------------------------------- paths

/// A gRPC method path split into package, service and method.
#[derive(Clone, Debug, PartialEq)]
pub struct Path {
    pub package: String,
    pub service: String,
    pub method: String,
}

impl Path {
    pub fn parse(p: &str) -> Option<Path> {
        let p = p.strip_prefix('/')?;
        let (full, method) = p.split_once('/')?;
        let (package, service) = match full.rsplit_once('.') {
            Some((a, b)) => (a.to_string(), b.to_string()),
            None => (String::new(), full.to_string()),
        };
        Some(Path {
            package,
            service,
            method: method.to_string(),
        })
    }

    /// `pkg.Service` (or `Service` without a package).
    pub fn full_service(&self) -> String {
        if self.package.is_empty() {
            self.service.clone()
        } else {
            format!("{}.{}", self.package, self.service)
        }
    }

    pub fn text(&self) -> String {
        format!("/{}/{}", self.full_service(), self.method)
    }
}

fn valid_ident(s: &str) -> bool {
    !s.is_empty()
        && s.chars().all(|c| c.is_ascii_alphanumeric() || c == '_')
        && !s.starts_with(|c: char| c.is_ascii_digit())
}

fn valid_full(s: &str) -> bool {
    s.split('.').all(valid_ident)
}

/// The default service of a program served with `--grpc`: the root
/// file's `# grpc: pkg.Service` header annotation, else `fwp.<Stem>`.
pub fn default_service(docs: &crate::cli::Docs, stem: &str) -> Result<(String, String), String> {
    match docs.grpc.clone() {
        Some(a) => {
            if !valid_full(&a) {
                return Err(format!(
                    "`# grpc: {}`: expected a service name such as `helloworld.Greeter`",
                    a
                ));
            }
            Ok(match a.rsplit_once('.') {
                Some((p, s)) => (p.to_string(), s.to_string()),
                None => (String::new(), a),
            })
        }
        None => Ok((protobuf::PACKAGE.to_string(), protobuf::service_name(stem))),
    }
}

/// The path of an exported function served with `--grpc`: its
/// `# grpc: Method`, `# grpc: Service/Method` or `# grpc:
/// pkg.Service/Method` annotation, else the default service and the
/// function's name in CamelCase.
pub fn function_path(
    docs: &crate::cli::Docs,
    default: &(String, String),
    function: &str,
) -> Result<String, String> {
    let local = function.rsplit("::").next().unwrap_or(function);
    let mut path = Path {
        package: default.0.clone(),
        service: default.1.clone(),
        method: protobuf::method_name(local),
    };
    if let Some(a) = docs.funcs.get(local).and_then(|d| d.grpc.clone()) {
        let bad = || {
            format!(
                "`# grpc: {}` above `{}`: expected `Method`, `Service/Method` or `package.Service/Method`",
                a, local
            )
        };
        match a.split_once('/') {
            None => {
                if !valid_ident(&a) {
                    return Err(bad());
                }
                path.method = a.clone();
            }
            Some((svc, m)) => {
                if !valid_ident(m) || !valid_full(svc) {
                    return Err(bad());
                }
                path.method = m.to_string();
                match svc.rsplit_once('.') {
                    Some((p, s)) => {
                        path.package = p.to_string();
                        path.service = s.to_string();
                    }
                    None => path.service = svc.to_string(),
                }
            }
        }
    }
    Ok(path.text())
}

/// Serve the root file's exported functions (`--grpc`): the service is
/// named after the file (or its annotation).
pub fn name_main_service(prog: &mut Program, stem: &str) -> Result<(), String> {
    let Some(svc) = prog.service.as_mut() else {
        return Err("no service".into());
    };
    svc.module = stem.to_string();
    svc.root = true;
    check_paths(prog)
}

/// Give served functions and client stubs the paths of their modules'
/// `# grpc:` annotations: a header line `# grpc: package.Service` in a
/// module's leading comment, and `# grpc: Method`, `# grpc:
/// Service/Method` or `# grpc: package.Service/Method` above an export.
pub fn annotate(
    prog: &mut Program,
    c: &crate::driver::Compilation,
) -> Result<(), crate::diag::Diagnostic> {
    use std::collections::HashMap;
    let mut modules: Vec<String> = Vec::new();
    if let Some(s) = &prog.service {
        modules.push(s.module.clone());
    }
    for f in &prog.funcs {
        if let crate::ir::Body::Remote(r) = &f.body {
            modules.push(r.module.clone());
        }
    }
    let mut info: HashMap<String, (crate::cli::Docs, (String, String))> = HashMap::new();
    for m in modules {
        if info.contains_key(&m) {
            continue;
        }
        let Some(b) = c.env.bindings.iter().find(|b| b.module == m) else {
            continue;
        };
        let file = b.span.file;
        let Some(src) = c.sm.files.get(file as usize) else {
            continue;
        };
        let mut docs = crate::cli::Docs::default();
        docs.add(&src.text, true);
        let name = if m == "main" {
            std::path::Path::new(&src.name)
                .file_stem()
                .map(|s| s.to_string_lossy().to_string())
                .unwrap_or_else(|| m.clone())
        } else {
            m.clone()
        };
        let default = default_service(&docs, &name).map_err(|e| {
            crate::diag::Diagnostic::error(
                crate::diag::Span {
                    file,
                    line: 1,
                    col: 1,
                    len: 1,
                },
                e,
            )
        })?;
        info.insert(m, (docs, default));
    }
    let err = |e: String| crate::diag::Diagnostic::error(crate::diag::Span::default(), e);
    if let Some(svc) = prog.service.as_mut() {
        if let Some((docs, default)) = info.get(&svc.module) {
            for m in &mut svc.methods {
                m.path = function_path(docs, default, &m.name).map_err(err)?;
            }
        }
    }
    for f in &mut prog.funcs {
        if let crate::ir::Body::Remote(r) = &mut f.body {
            if let Some((docs, default)) = info.get(&r.module) {
                r.path = function_path(docs, default, &r.method).map_err(err)?;
            }
        }
    }
    Ok(())
}

/// Methods of a service must have distinct paths.
pub fn check_paths(prog: &Program) -> Result<(), String> {
    let Some(svc) = &prog.service else {
        return Ok(());
    };
    for (i, a) in svc.methods.iter().enumerate() {
        for b in &svc.methods[..i] {
            if a.path == b.path {
                return Err(format!(
                    "`{}` and `{}` have the same gRPC method `{}`",
                    b.name, a.name, a.path
                ));
            }
        }
    }
    Ok(())
}

// ------------------------------------------------------------- the .proto

/// A method for `.proto` generation and reflection.
pub struct MethodText {
    pub path: Path,
    pub schema: MethodSchema,
    pub client_streaming: bool,
    pub server_streaming: bool,
}

/// The methods of a program's service, with their schemas in `schema`.
pub fn service_methods(prog: &Program, schema: &mut Schema) -> Result<Vec<MethodText>, String> {
    let svc = prog.service.as_ref().ok_or("no service")?;
    let mut out = Vec::new();
    for m in &svc.methods {
        let f = &prog.funcs[m.func];
        let sh = shape(&f.ty, f.arity as usize, m.error.as_ref());
        let path = Path::parse(&m.path).ok_or_else(|| format!("bad path {}", m.path))?;
        let ms = method_schema(schema, prog, &path.method, &sh, m.error.as_ref())?;
        out.push(MethodText {
            path,
            schema: ms,
            client_streaming: sh.client_streaming(),
            server_streaming: sh.server_streaming(),
        });
    }
    Ok(out)
}

/// The single package of a set of methods.
pub fn package_of(methods: &[MethodText]) -> Result<String, String> {
    let mut pkg: Option<&str> = None;
    for m in methods {
        match pkg {
            Some(p) if p != m.path.package => {
                return Err(format!(
                    "the methods are in different protobuf packages (`{}` and `{}`); a .proto file has one",
                    p, m.path.package
                ))
            }
            _ => pkg = Some(&m.path.package),
        }
    }
    Ok(pkg.unwrap_or(protobuf::PACKAGE).to_string())
}

/// The `.proto` file of a set of methods sharing a schema.
pub fn proto_file(schema: &Schema, methods: &[MethodText], source: &str) -> Result<String, String> {
    let package = package_of(methods)?;
    let mut out = format!(
        "// Generated by `fwp proto` from {}.\n// fwp services: gRPC over HTTP/2; see docs/services.md for the mapping.\n\nsyntax = \"proto3\";\n",
        source
    );
    if !package.is_empty() {
        out.push_str(&format!("\npackage {};\n", package));
    }
    let mut roots = Vec::new();
    let mut services: Vec<&str> = Vec::new();
    for m in methods {
        if !services.contains(&m.path.service.as_str()) {
            services.push(&m.path.service);
        }
    }
    for s in services {
        out.push_str(&format!("\nservice {} {{\n", s));
        for m in methods.iter().filter(|m| m.path.service == s) {
            out.push_str(&format!(
                "  rpc {}({}{}) returns ({}{});\n",
                m.path.method,
                if m.client_streaming { "stream " } else { "" },
                schema.type_ref(m.schema.request),
                if m.server_streaming { "stream " } else { "" },
                schema.type_ref(m.schema.response)
            ));
            roots.push(m.schema.request);
            roots.push(m.schema.response);
        }
        out.push_str("}\n");
    }
    out.push_str(&schema.messages_text(&roots));
    Ok(out)
}

// -------------------------------------------------------------- reflection

pub(crate) fn put_key(out: &mut Vec<u8>, num: u32, wire: u8) {
    protobuf::varint(out, ((num as u64) << 3) | wire as u64);
}

pub(crate) fn put_str(out: &mut Vec<u8>, num: u32, s: &str) {
    put_bytes(out, num, s.as_bytes());
}

pub(crate) fn put_bytes(out: &mut Vec<u8>, num: u32, b: &[u8]) {
    put_key(out, num, 2);
    protobuf::varint(out, b.len() as u64);
    out.extend_from_slice(b);
}

pub(crate) fn put_int(out: &mut Vec<u8>, num: u32, x: u64) {
    put_key(out, num, 0);
    protobuf::varint(out, x);
}

/// The fully qualified name of every message node.
fn full_names(schema: &Schema, package: &str) -> Vec<String> {
    let prefix = if package.is_empty() {
        String::new()
    } else {
        format!(".{}", package)
    };
    let mut names = vec![String::new(); schema.nodes.len()];
    fn name_of(schema: &Schema, id: NodeId, prefix: &str, names: &mut Vec<String>) -> String {
        if !names[id].is_empty() {
            return names[id].clone();
        }
        let n = match &schema.nodes[id] {
            Node::Msg(m) => match m.parent {
                Some(p) => format!("{}.{}", name_of(schema, p, prefix, names), m.name),
                None => format!("{}.{}", prefix, m.name),
            },
            Node::OneOf { name, .. } => format!("{}.{}", prefix, name),
            _ => String::new(),
        };
        names[id] = n.clone();
        n
    }
    for id in 0..schema.nodes.len() {
        name_of(schema, id, &prefix, &mut names);
    }
    names
}

/// A `FieldDescriptorProto`.
fn field_desc(
    schema: &Schema,
    names: &[String],
    num: u32,
    name: &str,
    id: NodeId,
    oneof: Option<usize>,
    synthetic: bool,
) -> Vec<u8> {
    let mut f = Vec::new();
    put_str(&mut f, 1, name);
    put_int(&mut f, 3, num as u64);
    let (label, inner) = match schema.nodes[id] {
        Node::List(c) => (3, c),
        Node::Opt(c) => (1, c),
        _ => (1, id),
    };
    put_int(&mut f, 4, label);
    let ty = match &schema.nodes[inner] {
        Node::Bool => 8,
        Node::SInt(8) => 18,
        Node::SInt(_) => 17,
        Node::UInt(8) => 4,
        Node::UInt(_) => 13,
        Node::F32 => 2,
        Node::F64 => 1,
        Node::Str => 9,
        Node::Bytes | Node::Int128 => 12,
        Node::Msg(_) | Node::OneOf { .. } => 11,
        Node::List(_) | Node::Opt(_) => 12,
    };
    put_int(&mut f, 5, ty);
    if ty == 11 {
        put_str(&mut f, 6, &names[inner]);
    }
    if let Some(i) = oneof {
        put_int(&mut f, 9, i as u64);
    }
    put_str(&mut f, 10, &json_name(name));
    if synthetic {
        put_int(&mut f, 17, 1);
    }
    f
}

/// protoc's `json_name`: lowerCamelCase of the field name.
pub(crate) fn json_name(s: &str) -> String {
    let mut out = String::new();
    let mut up = false;
    for c in s.chars() {
        if c == '_' {
            up = true;
        } else if up {
            out.push(c.to_ascii_uppercase());
            up = false;
        } else {
            out.push(c);
        }
    }
    out
}

/// A `DescriptorProto` for a message node.
fn message_desc(schema: &Schema, names: &[String], id: NodeId) -> Vec<u8> {
    let mut d = Vec::new();
    match &schema.nodes[id] {
        Node::Msg(m) => {
            put_str(&mut d, 1, &m.name);
            let mut fs = m.fields.clone();
            fs.sort_by_key(|f| f.0);
            let mut synthetic = Vec::new();
            for (num, name, c) in &fs {
                let opt = matches!(schema.nodes[*c], Node::Opt(_));
                let idx = opt.then(|| {
                    synthetic.push(format!("_{}", name));
                    synthetic.len() - 1
                });
                put_bytes(
                    &mut d,
                    2,
                    &field_desc(schema, names, *num, name, *c, idx, opt),
                );
            }
            for s in synthetic {
                let mut o = Vec::new();
                put_str(&mut o, 1, &s);
                put_bytes(&mut d, 8, &o);
            }
        }
        Node::OneOf { name, group, alts } => {
            put_str(&mut d, 1, name);
            for (i, (aname, c)) in alts.iter().enumerate() {
                put_bytes(
                    &mut d,
                    2,
                    &field_desc(schema, names, i as u32 + 1, aname, *c, Some(0), false),
                );
            }
            for (i, n) in schema.nodes.iter().enumerate() {
                if matches!(n, Node::Msg(m) if m.parent == Some(id)) {
                    put_bytes(&mut d, 3, &message_desc(schema, names, i));
                }
            }
            let mut o = Vec::new();
            put_str(&mut o, 1, group);
            put_bytes(&mut d, 8, &o);
        }
        _ => {}
    }
    d
}

/// The serialized `FileDescriptorProto` of a service, for server
/// reflection: the same messages and services as `fwp proto` prints (map
/// fields are written as their `repeated` entry messages, which have the
/// same encoding).
pub fn file_descriptor(
    schema: &Schema,
    methods: &[MethodText],
    file: &str,
) -> Result<Vec<u8>, String> {
    let package = package_of(methods)?;
    let names = full_names(schema, &package);
    let mut out = Vec::new();
    put_str(&mut out, 1, file);
    if !package.is_empty() {
        put_str(&mut out, 2, &package);
    }
    let mut roots = Vec::new();
    for m in methods {
        roots.push(m.schema.request);
        roots.push(m.schema.response);
    }
    let seen = schema.reachable(&roots);
    for (id, n) in schema.nodes.iter().enumerate() {
        let top = match n {
            Node::Msg(m) => m.parent.is_none(),
            Node::OneOf { .. } => true,
            _ => false,
        };
        if seen[id] && top {
            put_bytes(&mut out, 4, &message_desc(schema, &names, id));
        }
    }
    let mut services: Vec<&str> = Vec::new();
    for m in methods {
        if !services.contains(&m.path.service.as_str()) {
            services.push(&m.path.service);
        }
    }
    for s in services {
        let mut sd = Vec::new();
        put_str(&mut sd, 1, s);
        for m in methods.iter().filter(|m| m.path.service == s) {
            let mut md = Vec::new();
            put_str(&mut md, 1, &m.path.method);
            put_str(&mut md, 2, &names[m.schema.request]);
            put_str(&mut md, 3, &names[m.schema.response]);
            if m.client_streaming {
                put_int(&mut md, 5, 1);
            }
            if m.server_streaming {
                put_int(&mut md, 6, 1);
            }
            put_bytes(&mut sd, 2, &md);
        }
        put_bytes(&mut out, 6, &sd);
    }
    put_str(&mut out, 12, "proto3");
    Ok(out)
}

/// The file of the health checking service (`grpc.health.v1.Health`).
pub const HEALTH_FILE: &str = "grpc/health/v1/health.proto";

/// The serialized `FileDescriptorProto` of the health checking service.
pub fn health_descriptor() -> Vec<u8> {
    let field = |name: &str, num: u64, ty: u64, type_name: Option<&str>| {
        let mut f = Vec::new();
        put_str(&mut f, 1, name);
        put_int(&mut f, 3, num);
        put_int(&mut f, 4, 1);
        put_int(&mut f, 5, ty);
        if let Some(t) = type_name {
            put_str(&mut f, 6, t);
        }
        put_str(&mut f, 10, name);
        f
    };
    let mut out = Vec::new();
    put_str(&mut out, 1, HEALTH_FILE);
    put_str(&mut out, 2, "grpc.health.v1");
    let mut req = Vec::new();
    put_str(&mut req, 1, "HealthCheckRequest");
    put_bytes(&mut req, 2, &field("service", 1, 9, None));
    put_bytes(&mut out, 4, &req);
    let mut resp = Vec::new();
    put_str(&mut resp, 1, "HealthCheckResponse");
    put_bytes(
        &mut resp,
        2,
        &field(
            "status",
            1,
            14,
            Some(".grpc.health.v1.HealthCheckResponse.ServingStatus"),
        ),
    );
    let mut e = Vec::new();
    put_str(&mut e, 1, "ServingStatus");
    for (i, v) in ["UNKNOWN", "SERVING", "NOT_SERVING", "SERVICE_UNKNOWN"]
        .iter()
        .enumerate()
    {
        let mut ev = Vec::new();
        put_str(&mut ev, 1, v);
        put_int(&mut ev, 2, i as u64);
        put_bytes(&mut e, 2, &ev);
    }
    put_bytes(&mut resp, 4, &e);
    put_bytes(&mut out, 4, &resp);
    let mut svc = Vec::new();
    put_str(&mut svc, 1, "Health");
    for (name, stream) in [("Check", false), ("Watch", true)] {
        let mut m = Vec::new();
        put_str(&mut m, 1, name);
        put_str(&mut m, 2, ".grpc.health.v1.HealthCheckRequest");
        put_str(&mut m, 3, ".grpc.health.v1.HealthCheckResponse");
        if stream {
            put_int(&mut m, 6, 1);
        }
        put_bytes(&mut svc, 2, &m);
    }
    put_bytes(&mut out, 6, &svc);
    put_str(&mut out, 12, "proto3");
    out
}

/// What reflection needs: the descriptor, the file name, the package and
/// the full service names.
#[derive(Clone, Debug, Default)]
pub struct Reflection {
    pub file: String,
    pub descriptor: Vec<u8>,
    pub package: String,
    pub services: Vec<String>,
}

/// Reflection data of a program's service.
pub fn reflection(prog: &Program) -> Result<Reflection, String> {
    let mut schema = Schema::default();
    let methods = service_methods(prog, &mut schema)?;
    let svc = prog.service.as_ref().ok_or("no service")?;
    let file = format!("{}.proto", svc.module.replace('.', "_"));
    let descriptor = file_descriptor(&schema, &methods, &file)?;
    let mut services = Vec::new();
    for m in &methods {
        let s = m.path.full_service();
        if !services.contains(&s) {
            services.push(s);
        }
    }
    Ok(Reflection {
        file,
        descriptor,
        package: package_of(&methods)?,
        services,
    })
}

// ---------------------------------------------------------------- statuses

/// The names of the gRPC status codes.
pub const CODES: [&str; 17] = [
    "OK",
    "CANCELLED",
    "UNKNOWN",
    "INVALID_ARGUMENT",
    "DEADLINE_EXCEEDED",
    "NOT_FOUND",
    "ALREADY_EXISTS",
    "PERMISSION_DENIED",
    "RESOURCE_EXHAUSTED",
    "FAILED_PRECONDITION",
    "ABORTED",
    "OUT_OF_RANGE",
    "UNIMPLEMENTED",
    "INTERNAL",
    "UNAVAILABLE",
    "DATA_LOSS",
    "UNAUTHENTICATED",
];

/// The value of a `grpc-timeout` header for a duration.
pub fn timeout_header(d: std::time::Duration) -> String {
    let ms = d.as_millis();
    if ms < 100_000_000 {
        format!("{}m", ms.max(1))
    } else {
        format!("{}S", (d.as_secs()).min(99_999_999))
    }
}

/// A `grpc-timeout` header as nanoseconds.
pub fn parse_timeout(s: &str) -> Option<u64> {
    let s = s.trim();
    if s.len() < 2 || s.len() > 9 {
        return None;
    }
    let (digits, unit) = s.split_at(s.len() - 1);
    if !digits.bytes().all(|c| c.is_ascii_digit()) {
        return None;
    }
    let n: u64 = digits.parse().ok()?;
    let scale: u64 = match unit {
        "H" => 3_600_000_000_000,
        "M" => 60_000_000_000,
        "S" => 1_000_000_000,
        "m" => 1_000_000,
        "u" => 1_000,
        "n" => 1,
        _ => return None,
    };
    Some(n.saturating_mul(scale))
}

#[cfg(test)]
mod tests {
    /// `grpc._health-file` in lib/grpc.fwp holds the descriptor of the
    /// health checking service.
    #[test]
    fn health_file_matches() {
        let lib = include_str!("../lib/grpc.fwp");
        let start = lib.find("grpc._health-file =").expect("grpc._health-file");
        let rest = &lib[start..];
        let open = rest.find("grpc.base64-bytes").expect("base64 text") + 17;
        let open = open + rest[open..].find('"').unwrap() + 1;
        let close = open + rest[open..].find('"').unwrap();
        let bytes = crate::jsontype::unbase64(&rest[open..close]).unwrap_or_default();
        let want = super::health_descriptor();
        if bytes != want {
            panic!(
                "update grpc._health-file in lib/grpc.fwp: {}",
                crate::jsontype::base64(&want)
            );
        }
    }
}
