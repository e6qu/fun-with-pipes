//! An fwp client module from an OpenAPI document (`fwp openapi --import`):
//! the document's schemas as fwp types and each operation as a function
//! that calls it with `lib/rest.fwp` (`rest.fetch` over `http.send`).
//!
//! * Component schemas become types: objects records, string enums whose
//!   values are constructor names variant types, `oneOf` with the
//!   discriminator `type` (the variants fwp writes) variant types with
//!   fields, and others aliases. Inline objects become records named
//!   after where they appear.
//! * Properties that are not fwp names get one (`user-id` for `user_id`)
//!   and a field comment `# json: user_id`, so that the typed JSON codec
//!   uses the original name. Properties that are not required, and
//!   nullable schemas, are `Option`s.
//! * Each operation is a function of the server's base URL, then its path
//!   parameters in order, then a record of its query parameters (if it
//!   has any), then its JSON body (if it has one). It returns the decoded
//!   JSON of the 2xx response (`()` without content), as an `Option` when
//!   the operation declares a "not found" 404, and raises
//!   `Error[RestError]` for other responses.
//!
//! Schemas outside this subset become `Json` values, with a warning;
//! operations with bodies other than JSON, or with required header and
//! cookie parameters, are left out, with a warning.

use std::collections::{BTreeMap, BTreeSet};
use std::fmt::Write as _;

use crate::json::Json;

pub struct Module {
    pub text: String,
    pub warnings: Vec<String>,
}

const KEYWORDS: &[&str] = &[
    "rec", "match", "trait", "impl", "where", "comptime", "import", "export", "macro", "quote",
    "resource", "foreign", "with", "type", "test", "make", "update",
];

/// Names the generated code uses, which an operation must not shadow.
const RESERVED_FUNCS: &[&str] = &["curry", "const", "id", "main", "builtin"];

/// Standard type names a schema must not shadow.
const RESERVED_TYPES: &[&str] = &[
    "Array",
    "Body",
    "Bool",
    "Bytes",
    "ClientRequest",
    "ClientResponse",
    "Duration",
    "Error",
    "HttpError",
    "IoError",
    "Json",
    "List",
    "Map",
    "Option",
    "Request",
    "Response",
    "RestError",
    "RestRequest",
    "RestTarget",
    "Result",
    "Route",
    "Set",
    "String",
    "Url",
];

/// A type in fwp syntax.
#[derive(Clone, Debug, PartialEq)]
enum Ty {
    Named(String),
    Prim(&'static str),
    List(Box<Ty>),
    Set(Box<Ty>),
    Map(Box<Ty>),
    Option(Box<Ty>),
    Tuple(Vec<Ty>),
}

impl Ty {
    fn spell(&self) -> String {
        match self {
            Ty::Named(n) => n.clone(),
            Ty::Prim(p) => p.to_string(),
            Ty::List(t) => format!("List[{}]", t.spell()),
            Ty::Set(t) => format!("Set[{}]", t.spell()),
            Ty::Map(t) => format!("Map[String, {}]", t.spell()),
            Ty::Option(t) => format!("Option[{}]", t.spell()),
            Ty::Tuple(ts) if ts.is_empty() => "()".into(),
            Ty::Tuple(ts) => format!(
                "({})",
                ts.iter().map(Ty::spell).collect::<Vec<_>>().join(", ")
            ),
        }
    }

    fn optional(self) -> Ty {
        match self {
            Ty::Option(_) => self,
            t => Ty::Option(Box::new(t)),
        }
    }
}

/// `getPetById`, `pet_id`, `Quote Order` as fwp names: `get-pet-by-id`.
fn kebab(s: &str) -> String {
    let mut out = String::new();
    let mut prev_lower = false;
    for c in s.chars() {
        if c.is_ascii_uppercase() {
            if prev_lower {
                out.push('-');
            }
            out.push(c.to_ascii_lowercase());
            prev_lower = false;
        } else if c.is_ascii_alphanumeric() {
            out.push(c);
            prev_lower = c.is_ascii_lowercase() || c.is_ascii_digit();
        } else {
            out.push('-');
            prev_lower = false;
        }
    }
    // a hyphen must be followed by a letter
    let mut joined = String::new();
    for (i, p) in out.split('-').filter(|p| !p.is_empty()).enumerate() {
        if i > 0 {
            joined.push(if p.starts_with(|c: char| c.is_ascii_digit()) {
                '_'
            } else {
                '-'
            });
        }
        joined.push_str(p);
    }
    if !joined.starts_with(|c: char| c.is_ascii_lowercase()) {
        joined = format!("x-{}", joined);
    }
    joined
}

/// Whether a name is an fwp name (of a field or a function) as it is.
fn is_fwp_name(s: &str) -> bool {
    let b = s.as_bytes();
    if b.is_empty() || !b[0].is_ascii_lowercase() || KEYWORDS.contains(&s) {
        return false;
    }
    b.iter().enumerate().all(|(i, &c)| {
        c.is_ascii_alphanumeric()
            || c == b'_'
            || (c == b'-' && b.get(i + 1).is_some_and(|n| n.is_ascii_alphabetic()))
    })
}

/// An fwp name for a field or a function.
fn fwp_name(s: &str) -> String {
    let mut n = if is_fwp_name(s) {
        s.to_string()
    } else {
        kebab(s)
    };
    if KEYWORDS.contains(&n.as_str()) {
        n.push_str("-field");
    }
    n
}

/// A type name: `pet-store.Order` is `PetStoreOrder`.
fn type_name(s: &str) -> String {
    let mut out = String::new();
    for part in s.split(|c: char| !c.is_ascii_alphanumeric()) {
        let mut cs = part.chars();
        if let Some(c) = cs.next() {
            out.push(c.to_ascii_uppercase());
            out.push_str(cs.as_str());
        }
    }
    if !out.starts_with(|c: char| c.is_ascii_uppercase()) {
        out = format!("T{}", out);
    }
    out
}

fn is_ctor_name(s: &str) -> bool {
    s.starts_with(|c: char| c.is_ascii_uppercase())
        && s.chars().all(|c| c.is_ascii_alphanumeric() || c == '_')
}

/// Comment lines, wrapped at 78 columns.
fn comment(out: &mut String, text: &str, indent: &str) {
    for l in text.lines() {
        let l = l.trim_end();
        if l.is_empty() {
            let _ = writeln!(out, "{}#", indent);
            continue;
        }
        let mut line = String::new();
        for w in l.split_whitespace() {
            if !line.is_empty() && indent.len() + 2 + line.len() + 1 + w.len() > 78 {
                let _ = writeln!(out, "{}# {}", indent, line);
                line.clear();
            }
            if !line.is_empty() {
                line.push(' ');
            }
            line.push_str(w);
        }
        let _ = writeln!(out, "{}# {}", indent, line);
    }
}

fn one_line(s: &str) -> String {
    s.split_whitespace().collect::<Vec<_>>().join(" ")
}

struct Gen<'a> {
    components: BTreeMap<String, &'a Json>,
    /// Component name to fwp type name, once defined (or being defined).
    defined: BTreeMap<String, String>,
    used_types: BTreeSet<String>,
    decls: Vec<String>,
    warnings: Vec<String>,
}

impl<'a> Gen<'a> {
    fn new_type_name(&mut self, base: &str) -> String {
        let mut base = type_name(base);
        if RESERVED_TYPES.contains(&base.as_str()) {
            base.push_str("Type");
        }
        let mut name = base.clone();
        let mut k = 2;
        while self.used_types.contains(&name) {
            name = format!("{}{}", base, k);
            k += 1;
        }
        self.used_types.insert(name.clone());
        name
    }

    fn warn(&mut self, at: &str, what: String) {
        let w = format!("{}: {}; it is a `Json` value", at, what);
        if !self.warnings.contains(&w) {
            self.warnings.push(w);
        }
    }

    fn reference(&mut self, r: &str, at: &str) -> Ty {
        let Some(name) = r.strip_prefix("#/components/schemas/") else {
            self.warn(
                at,
                format!("the reference `{}` is not to a component schema", r),
            );
            return Ty::Prim("Json");
        };
        if let Some(t) = self.defined.get(name) {
            return Ty::Named(t.clone());
        }
        let Some(schema) = self.components.get(name).copied() else {
            self.warn(at, format!("there is no component schema `{}`", name));
            return Ty::Prim("Json");
        };
        let tname = self.new_type_name(name);
        self.defined.insert(name.to_string(), tname.clone());
        self.define(&tname, schema, name);
        Ty::Named(tname)
    }

    /// Whether a schema allows `null`.
    fn nullable(s: &Json) -> bool {
        s.get("nullable") == Some(&Json::Bool(true))
            || matches!(s.get("type"), Some(Json::Arr(ts)) if ts.iter().any(|t| t.as_str() == Some("null")))
    }

    /// A schema's type, ignoring `null`.
    fn type_str(s: &Json) -> Option<&str> {
        match s.get("type") {
            Some(Json::Str(t)) => Some(t),
            Some(Json::Arr(ts)) => {
                let non_null: Vec<&str> = ts
                    .iter()
                    .filter_map(Json::as_str)
                    .filter(|t| *t != "null")
                    .collect();
                (non_null.len() == 1).then(|| non_null[0])
            }
            _ => None,
        }
    }

    /// The type of a schema; `hint` names inline types.
    fn ty(&mut self, s: &Json, hint: &str, at: &str) -> Ty {
        let t = self.ty_inner(s, hint, at, None);
        if Self::nullable(s) {
            t.optional()
        } else {
            t
        }
    }

    /// `name`: the name of the type being defined, which an enum, a
    /// variant type or a record takes instead of a new one.
    fn ty_inner(&mut self, s: &Json, hint: &str, at: &str, name: Option<&str>) -> Ty {
        if let Some(r) = s.get("$ref").and_then(Json::as_str) {
            return self.reference(r, at);
        }
        for key in ["anyOf", "oneOf"] {
            if let Some(alts) = s.get(key).and_then(Json::as_array) {
                let non_null: Vec<&Json> = alts
                    .iter()
                    .filter(|a| a.get("type").and_then(Json::as_str) != Some("null"))
                    .collect();
                if non_null.len() == 1 && non_null.len() < alts.len() {
                    return self.ty(non_null[0], hint, at).optional();
                }
                if key == "oneOf" {
                    if let Some(t) = self.union(s, hint, at, name) {
                        return t;
                    }
                }
                self.warn(at, format!("a `{}` that is not a variant type", key));
                return Ty::Prim("Json");
            }
        }
        if s.get("allOf").is_some() {
            self.warn(at, "`allOf` is not supported".into());
            return Ty::Prim("Json");
        }
        if let Some(Json::Arr(values)) = s.get("enum") {
            let names: Vec<&str> = values.iter().filter_map(Json::as_str).collect();
            if names.len() == values.len()
                && !names.is_empty()
                && names.iter().all(|n| is_ctor_name(n))
            {
                let tname = match name {
                    Some(n) => n.to_string(),
                    None => self.new_type_name(hint),
                };
                let mut d = String::new();
                describe(&mut d, s);
                let _ = writeln!(d, "{} =", tname);
                for n in names {
                    let _ = writeln!(d, "    | {}", n);
                }
                self.decls.push(d);
                return Ty::Named(tname);
            }
            if names.len() == values.len() {
                // values that are not constructor names are strings
                return Ty::Prim("String");
            }
            self.warn(at, "an enum of values other than strings".into());
            return Ty::Prim("Json");
        }
        match Self::type_str(s) {
            Some("string") => {
                let format = s.get("format").and_then(Json::as_str).unwrap_or("");
                Ty::Prim(match format {
                    "int128" => "I128",
                    "uint128" => "U128",
                    "byte" => "Bytes",
                    "duration" => "Duration",
                    _ if s.get("contentEncoding").and_then(Json::as_str) == Some("base64") => {
                        "Bytes"
                    }
                    _ => "String",
                })
            }
            Some("integer") => {
                let format = s.get("format").and_then(Json::as_str).unwrap_or("");
                let range = (
                    s.get("minimum").and_then(Json::as_f64),
                    s.get("maximum").and_then(Json::as_f64),
                );
                Ty::Prim(match range {
                    (Some(a), Some(b)) if a == -128.0 && b == 127.0 => "I8",
                    (Some(a), Some(b)) if a == -32768.0 && b == 32767.0 => "I16",
                    (Some(a), Some(b)) if a == 0.0 && b == 255.0 => "U8",
                    (Some(a), Some(b)) if a == 0.0 && b == 65535.0 => "U16",
                    (Some(a), Some(b)) if a == 0.0 && b == 4294967295.0 => "U32",
                    _ => match format {
                        "int32" => "I32",
                        "uint64" => "U64",
                        _ => "I64",
                    },
                })
            }
            Some("number") => {
                Ty::Prim(if s.get("format").and_then(Json::as_str) == Some("float") {
                    "F32"
                } else {
                    "F64"
                })
            }
            Some("boolean") => Ty::Prim("Bool"),
            Some("array") => {
                if let Some(items) = s.get("prefixItems").and_then(Json::as_array) {
                    let ts = items
                        .iter()
                        .enumerate()
                        .map(|(i, x)| self.ty(x, &format!("{}{}", hint, i), at))
                        .collect();
                    return Ty::Tuple(ts);
                }
                let item = match s.get("items") {
                    Some(x @ Json::Obj(_)) => self.ty(x, &format!("{}Item", hint), at),
                    _ => {
                        self.warn(at, "an array without `items`".into());
                        Ty::Prim("Json")
                    }
                };
                if s.get("uniqueItems") == Some(&Json::Bool(true)) {
                    Ty::Set(Box::new(item))
                } else {
                    Ty::List(Box::new(item))
                }
            }
            Some("object") | None if s.get("properties").is_some() => {
                let tname = match name {
                    Some(n) => n.to_string(),
                    None => self.new_type_name(hint),
                };
                self.record(&tname, s, at);
                Ty::Named(tname)
            }
            Some("object") => match s.get("additionalProperties") {
                Some(x @ Json::Obj(fs)) if !fs.is_empty() => {
                    Ty::Map(Box::new(self.ty(x, &format!("{}Value", hint), at)))
                }
                _ => Ty::Prim("Json"),
            },
            Some(other) => {
                self.warn(at, format!("the type `{}` is not supported", other));
                Ty::Prim("Json")
            }
            None => Ty::Prim("Json"),
        }
    }

    /// A `oneOf` of objects told apart by a `type` property with a
    /// `value`: a variant type (the variants with fields that fwp writes).
    fn union(&mut self, s: &Json, hint: &str, at: &str, name: Option<&str>) -> Option<Ty> {
        let disc = s.get("discriminator")?;
        if disc.get("propertyName").and_then(Json::as_str) != Some("type") {
            return None;
        }
        let mut ctors = Vec::new();
        for a in s.get("oneOf")?.as_array()? {
            let schema = match a.get("$ref").and_then(Json::as_str) {
                Some(r) => *self
                    .components
                    .get(r.strip_prefix("#/components/schemas/")?)?,
                None => a,
            };
            let props = schema.get("properties")?;
            let ctor = props.get("type")?.get("const")?.as_str()?.to_string();
            if !is_ctor_name(&ctor) {
                return None;
            }
            ctors.push((ctor, props.get("value").cloned()));
        }
        let tname = match name {
            Some(n) => n.to_string(),
            None => self.new_type_name(hint),
        };
        let mut lines = Vec::new();
        for (c, value) in ctors {
            let fields: Vec<Ty> = match &value {
                None => vec![],
                Some(v) => match v.get("prefixItems").and_then(Json::as_array) {
                    Some(items) if v.get("items") == Some(&Json::Bool(false)) => items
                        .iter()
                        .enumerate()
                        .map(|(i, x)| self.ty(x, &format!("{}{}{}", tname, c, i), at))
                        .collect(),
                    _ => vec![self.ty(v, &format!("{}{}", tname, c), at)],
                },
            };
            let mut line = format!("    | {}", c);
            for f in fields {
                let t = f.spell();
                if t.contains('[') || t.contains(' ') {
                    let _ = write!(line, " ({})", t);
                } else {
                    let _ = write!(line, " {}", t);
                }
            }
            lines.push(line);
        }
        let mut d = String::new();
        describe(&mut d, s);
        let _ = writeln!(d, "{} =", tname);
        for l in lines {
            let _ = writeln!(d, "{}", l);
        }
        self.decls.push(d);
        Some(Ty::Named(tname))
    }

    /// Define a named type from a component schema.
    fn define(&mut self, name: &str, s: &Json, component: &str) {
        let at = format!("schema `{}`", component);
        let t = self.ty_inner(s, name, &at, Some(name));
        if t != Ty::Named(name.to_string()) {
            // anything else is an alias
            let mut d = String::new();
            describe(&mut d, s);
            let _ = writeln!(d, "{} = {}", name, t.spell());
            self.decls.push(d);
        }
    }

    /// A record from an object schema.
    fn record(&mut self, name: &str, s: &Json, at: &str) {
        let required: Vec<&str> = s
            .get("required")
            .and_then(Json::as_array)
            .map(|r| r.iter().filter_map(Json::as_str).collect())
            .unwrap_or_default();
        let mut fields = String::new();
        let mut labels = BTreeSet::new();
        if let Some(Json::Obj(props)) = s.get("properties") {
            for (p, schema) in props {
                let mut t = self.ty(schema, &format!("{}{}", name, type_name(p)), at);
                if !required.contains(&p.as_str()) {
                    t = t.optional();
                }
                let mut label = fwp_name(p);
                while !labels.insert(label.clone()) {
                    label.push_str("-2");
                }
                if let Some(d) = schema.get("description").and_then(Json::as_str) {
                    comment(&mut fields, &one_line(d), "    ");
                }
                if label != *p {
                    let _ = writeln!(fields, "    # json: {}", p);
                }
                let _ = writeln!(fields, "    {}: {},", label, t.spell());
            }
        }
        let mut d = String::new();
        describe(&mut d, s);
        if fields.is_empty() {
            let _ = writeln!(d, "{} = {{}}", name);
        } else {
            let _ = write!(d, "{} = {{\n{}}}\n", name, fields);
        }
        self.decls.push(d);
    }
}

fn describe(out: &mut String, s: &Json) {
    if let Some(d) = s.get("description").and_then(Json::as_str) {
        comment(out, d, "");
    }
}

/// A client function: its name, parameters and the pieces of its call.
struct Operation {
    name: String,
    doc: String,
    method: String,
    path: String,
    /// Path parameters, in the order of the path.
    path_params: Vec<Ty>,
    /// The record of the query parameters.
    query: Option<String>,
    body: Option<Ty>,
    result: Ty,
    not_found: bool,
}

/// The JSON schema of the first successful response: `Some(None)` for a
/// response without JSON content.
fn success(op: &Json) -> Option<Option<&Json>> {
    let Some(Json::Obj(responses)) = op.get("responses") else {
        return None;
    };
    let mut ok: Vec<&(String, Json)> = responses
        .iter()
        .filter(|(k, _)| k.starts_with('2'))
        .collect();
    ok.sort_by_key(|(k, _)| k.clone());
    let (_, r) = ok.first()?;
    Some(r.at(&["content", "application/json", "schema"]))
}

/// Generate the client module of an OpenAPI document (JSON text).
pub fn client(text: &str) -> Result<Module, String> {
    let doc = Json::parse(text).map_err(|e| {
        format!(
            "not a JSON document ({}); YAML is not supported, convert it to JSON first",
            e
        )
    })?;
    let version = doc.get("openapi").and_then(Json::as_str).unwrap_or("");
    if !version.starts_with("3.") {
        return Err(match doc.get("swagger") {
            Some(_) => "Swagger 2.0 documents are not supported (OpenAPI 3.0 and 3.1 are)".into(),
            None => "not an OpenAPI 3 document (it has no `openapi: 3.x` member)".into(),
        });
    }
    let mut g = Gen {
        components: BTreeMap::new(),
        defined: BTreeMap::new(),
        used_types: BTreeSet::new(),
        decls: Vec::new(),
        warnings: Vec::new(),
    };
    if let Some(Json::Obj(cs)) = doc.at(&["components", "schemas"]) {
        for (k, v) in cs {
            g.components.insert(k.clone(), v);
        }
    }
    let mut ops: Vec<Operation> = Vec::new();
    let mut used_names = BTreeSet::new();
    if let Some(Json::Obj(paths)) = doc.get("paths") {
        for (path, item) in paths {
            let Json::Obj(methods) = item else { continue };
            let shared: Vec<Json> = item
                .get("parameters")
                .and_then(Json::as_array)
                .map(|a| a.to_vec())
                .unwrap_or_default();
            for (method, op) in methods {
                let m = method.to_ascii_uppercase();
                if !matches!(m.as_str(), "GET" | "POST" | "PUT" | "PATCH" | "DELETE") {
                    continue;
                }
                match operation(&mut g, &doc, path, &m, op, &shared, &mut used_names) {
                    Ok(o) => ops.push(o),
                    Err(e) => g
                        .warnings
                        .push(format!("{} {}: {}; it is left out", m, path, e)),
                }
            }
        }
    }
    let mut out = String::new();
    let title = doc
        .at(&["info", "title"])
        .and_then(Json::as_str)
        .unwrap_or("an API");
    let ver = doc
        .at(&["info", "version"])
        .and_then(Json::as_str)
        .unwrap_or("");
    let _ = writeln!(
        out,
        "# A client of `{}` {}, generated from its OpenAPI document by\n# `fwp openapi --import`.",
        title, ver
    );
    out.push_str(
        "#\n# Each function takes the server's base URL first (`http://host:port`),\n# then the path parameters, a record of the query parameters and the\n# body. A response other than a success raises `Error[RestError]`.\n\n",
    );
    for d in &g.decls {
        out.push_str(d);
        out.push('\n');
    }
    for o in &ops {
        out.push_str(&function_text(o));
        out.push('\n');
    }
    while out.ends_with("\n\n") {
        out.pop();
    }
    Ok(Module {
        text: out,
        warnings: g.warnings,
    })
}

fn operation(
    g: &mut Gen,
    doc: &Json,
    path: &str,
    method: &str,
    op: &Json,
    shared: &[Json],
    used: &mut BTreeSet<String>,
) -> Result<Operation, String> {
    let id = op
        .get("operationId")
        .and_then(Json::as_str)
        .map(str::to_string)
        .unwrap_or_else(|| format!("{} {}", method.to_ascii_lowercase(), path));
    let mut name = fwp_name(&id);
    if RESERVED_FUNCS.contains(&name.as_str()) {
        name.push_str("-op");
    }
    let base = name.clone();
    let mut k = 2;
    while used.contains(&name) {
        name = format!("{}-{}", base, k);
        k += 1;
    }
    used.insert(name.clone());
    let at = format!("operation `{}`", id);
    let mut doc_text = String::new();
    for key in ["summary", "description"] {
        if let Some(t) = op.get(key).and_then(Json::as_str) {
            if !one_line(&doc_text).contains(&one_line(t)) {
                if !doc_text.is_empty() {
                    doc_text.push_str("\n\n");
                }
                doc_text.push_str(t.trim());
            }
        }
    }
    // the operation's parameters, then those of the path that it does not
    // override
    let mut params: Vec<Json> = op
        .get("parameters")
        .and_then(Json::as_array)
        .map(|a| a.to_vec())
        .unwrap_or_default();
    let key = |p: &Json| (p.get("name").cloned(), p.get("in").cloned());
    for p in shared {
        if !params.iter().any(|q| key(q) == key(p)) {
            params.push(p.clone());
        }
    }
    let params: Vec<Json> = params
        .into_iter()
        .map(|p| {
            match p
                .get("$ref")
                .and_then(Json::as_str)
                .and_then(|r| r.strip_prefix("#/components/parameters/"))
                .and_then(|n| doc.at(&["components", "parameters", n]))
            {
                Some(q) => q.clone(),
                None => p,
            }
        })
        .collect();
    let str_of = |p: &Json, k: &str| p.get(k).and_then(Json::as_str).unwrap_or("").to_string();
    let mut path_params = Vec::new();
    for var in crate::rest::path_vars(path) {
        let p = params
            .iter()
            .find(|p| str_of(p, "in") == "path" && str_of(p, "name") == var)
            .ok_or_else(|| format!("the path parameter `{}` is not declared", var))?;
        let schema = p.get("schema").cloned().unwrap_or(Json::Obj(vec![]));
        let hint = format!("{}{}", type_name(&name), type_name(&var));
        path_params.push(g.ty(&schema, &hint, &at));
    }
    let mut fields = String::new();
    let mut labels = BTreeSet::new();
    for p in &params {
        let (place, pname) = (str_of(p, "in"), str_of(p, "name"));
        let required = p.get("required") == Some(&Json::Bool(true));
        match place.as_str() {
            "query" => {
                let schema = p.get("schema").cloned().unwrap_or(Json::Obj(vec![]));
                let hint = format!("{}{}", type_name(&name), type_name(&pname));
                let mut t = g.ty(&schema, &hint, &at);
                if !required && !matches!(t, Ty::List(_)) {
                    t = t.optional();
                }
                let mut label = fwp_name(&pname);
                while !labels.insert(label.clone()) {
                    label.push_str("-2");
                }
                if let Some(d) = p.get("description").and_then(Json::as_str) {
                    comment(&mut fields, &one_line(d), "    ");
                }
                if label != pname {
                    let _ = writeln!(fields, "    # json: {}", pname);
                }
                let _ = writeln!(fields, "    {}: {},", label, t.spell());
            }
            "path" => {}
            _ if required => {
                return Err(format!(
                    "the required {} parameter `{}` is not supported",
                    place, pname
                ))
            }
            _ => g.warnings.push(format!(
                "{} {}: the {} parameter `{}` is left out",
                method, path, place, pname
            )),
        }
    }
    let query = if fields.is_empty() {
        None
    } else {
        let qname = g.new_type_name(&format!("{}Query", type_name(&name)));
        g.decls.push(format!(
            "# the query parameters of `{}`\n{} = {{\n{}}}\n",
            name, qname, fields
        ));
        Some(qname)
    };
    let body = match op.get("requestBody") {
        None => None,
        Some(b) => {
            let b = match b.get("$ref").and_then(Json::as_str) {
                Some(r) => r
                    .strip_prefix("#/components/requestBodies/")
                    .and_then(|n| doc.at(&["components", "requestBodies", n]))
                    .ok_or_else(|| format!("there is no request body `{}`", r))?,
                None => b,
            };
            let schema = b
                .at(&["content", "application/json", "schema"])
                .ok_or("its request body is not JSON (`application/json`)")?;
            let t = g.ty(schema, &format!("{}Body", type_name(&name)), &at);
            Some(if b.get("required") == Some(&Json::Bool(true)) {
                t
            } else {
                t.optional()
            })
        }
    };
    let result = match success(op) {
        None => return Err("it has no success (2xx) response".into()),
        Some(None) => Ty::Tuple(vec![]),
        Some(Some(s)) => g.ty(s, &format!("{}Result", type_name(&name)), &at),
    };
    let not_found = op
        .at(&["responses", "404", "description"])
        .and_then(Json::as_str)
        .is_some_and(|d| d.to_ascii_lowercase().contains("not found"));
    Ok(Operation {
        name,
        doc: doc_text,
        method: method.to_string(),
        path: path.to_string(),
        path_params,
        query,
        body,
        result,
        not_found,
    })
}

/// The selector of argument `i` of `n` in the nested pairs that `curry`
/// applied `n - 1` times passes: `(((a0, a1), a2), a3)`.
fn arg(i: usize, n: usize) -> String {
    if n == 1 {
        return "id".into();
    }
    let mut parts = vec![".0"; if i == 0 { n - 1 } else { n - 1 - i }];
    if i > 0 {
        parts.push(".1");
    }
    parts.join(" | ")
}

fn function_text(o: &Operation) -> String {
    let mut out = String::new();
    if !o.doc.is_empty() {
        comment(&mut out, &o.doc, "");
    }
    let _ = writeln!(out, "# {} {}", o.method, o.path);
    let mut params = vec!["String".to_string()];
    params.extend(o.path_params.iter().map(Ty::spell));
    if let Some(q) = &o.query {
        params.push(q.clone());
    }
    if let Some(b) = &o.body {
        params.push(b.spell());
    }
    let n = params.len();
    let result = if o.not_found {
        Ty::Option(Box::new(o.result.clone())).spell()
    } else {
        o.result.spell()
    };
    let _ = writeln!(
        out,
        "{} : {} -> {} ! {{Async, Network, Error[RestError]}}",
        o.name,
        params.join(" -> "),
        result
    );
    let texts: Vec<String> = (0..o.path_params.len())
        .map(|i| format!("{} | rest.param-text", arg(i + 1, n)))
        .collect();
    let query = match &o.query {
        Some(_) => format!("{} | rest.query-pairs", arg(1 + o.path_params.len(), n)),
        None => "const []".into(),
    };
    let body = match &o.body {
        Some(Ty::Option(_)) => format!("{} | option.map json.write", arg(n - 1, n)),
        Some(_) => format!("{} | json.write | Some", arg(n - 1, n)),
        None => "const None".into(),
    };
    let fetch = if o.not_found {
        "rest.fetch-option"
    } else {
        "rest.fetch"
    };
    let mut expr = format!(
        "make RestRequest {{\n    method = const {},\n    url = make RestTarget {{\n        base = {},\n        path = const {},\n        params = rest.texts [{}],\n        query = {},\n    }} | rest.url,\n    body = {},\n}} | {}",
        crate::rest::fwp_string(&o.method),
        arg(0, n),
        crate::rest::fwp_string(&o.path),
        texts.join(", "),
        query,
        body,
        fetch
    );
    for _ in 1..n {
        expr = format!("curry ({})", expr);
    }
    let _ = writeln!(out, "{} =\n    {}", o.name, expr.replace('\n', "\n    "));
    out
}
