//! OpenAPI 3.1 documents: generated from the REST endpoints of a program
//! (`fwp openapi`, `/openapi.json`), and read to generate an fwp client
//! module (`fwp openapi --import`, in `src/openapi_import.rs`).
//!
//! Schemas follow the typed JSON of `src/jsontype.rs`: nominal records,
//! enums and variant types are components (`#/components/schemas/Item`);
//! a variant type is a `oneOf` of its constructors with the discriminator
//! `type`; `Option` fields are not required, other `Option`s are
//! `anyOf [T, null]`; integers have the formats `int32`, `int64` (and
//! `uint64`, and strings for `int128`), floats `float` and `double`.

use std::collections::{BTreeMap, BTreeSet};

use crate::ir::{Program, MT};
use crate::json::Json;
use crate::jsontype::{self, Shape};
use crate::rest::{Endpoint, FieldKind, Outcome, Source};

fn num(x: i64) -> Json {
    Json::Num(x as f64)
}

fn obj(fields: Vec<(&str, Json)>) -> Json {
    Json::obj(fields)
}

fn ty(t: &str) -> Json {
    obj(vec![("type", Json::str(t))])
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

/// Paragraphs of comment lines as Markdown text.
fn description(lines: &[String]) -> String {
    lines
        .iter()
        .map(|l| l.trim_end())
        .collect::<Vec<_>>()
        .join("\n")
        .trim()
        .to_string()
}

struct Gen<'p> {
    prog: &'p Program,
    names: BTreeMap<MT, String>,
    used: BTreeSet<String>,
    schemas: Vec<(String, Json)>,
}

/// The name of a type in component names: `Item`, `ResultI64String`.
fn base_name(mt: &MT) -> String {
    match mt {
        MT::Con(n, args) => {
            let mut s = MT::short_name(n);
            for a in args {
                s.push_str(&base_name(a));
            }
            s.chars()
                .filter(|c| c.is_ascii_alphanumeric() || matches!(c, '.' | '_' | '-'))
                .collect()
        }
        MT::Record(fs) if fs.is_empty() => "Unit".into(),
        MT::Record(fs) if jsontype::is_tuple(fs) => {
            let mut s = String::from("Tuple");
            for (_, t) in fs {
                s.push_str(&base_name(t));
            }
            s
        }
        MT::Record(_) => "Record".into(),
        MT::Nat(n) => n.to_string(),
        MT::Fun(..) => "Function".into(),
    }
}

impl Gen<'_> {
    fn reference(name: &str) -> Json {
        obj(vec![(
            "$ref",
            Json::str(format!("#/components/schemas/{}", name)),
        )])
    }

    fn unique(&mut self, base: String) -> String {
        let mut name = base.clone();
        let mut k = 2;
        while self.used.contains(&name) {
            name = format!("{}{}", base, k);
            k += 1;
        }
        self.used.insert(name.clone());
        name
    }

    /// A component for a named type: its `$ref`.
    fn component(&mut self, mt: &MT) -> Json {
        if let Some(n) = self.names.get(mt) {
            return Self::reference(n);
        }
        let name = self.unique(base_name(mt));
        self.names.insert(mt.clone(), name.clone());
        let at = self.schemas.len();
        self.schemas.push((name.clone(), Json::Null));
        let schema = match jsontype::shape(mt, self.prog) {
            Shape::Record(_, fs, order, json) => self.object(mt, &fs, &order, &json),
            Shape::Enum(_, ns) => obj(vec![
                ("type", Json::str("string")),
                ("enum", Json::Arr(ns.into_iter().map(Json::Str).collect())),
            ]),
            Shape::Adt(_, vs) => {
                let mut refs = Vec::new();
                let mut mapping = Vec::new();
                for (c, fts) in &vs {
                    let vname = self.unique(format!("{}.{}", name, c));
                    let mut props = vec![("type".to_string(), obj(vec![("const", Json::str(c))]))];
                    let mut required = vec![Json::str("type")];
                    match fts.len() {
                        0 => {}
                        1 => {
                            props.push(("value".into(), self.schema(&fts[0])));
                            required.push(Json::str("value"));
                        }
                        _ => {
                            props.push(("value".into(), self.tuple(fts)));
                            required.push(Json::str("value"));
                        }
                    }
                    self.schemas.push((
                        vname.clone(),
                        obj(vec![
                            ("type", Json::str("object")),
                            ("properties", Json::Obj(props)),
                            ("required", Json::Arr(required)),
                        ]),
                    ));
                    mapping.push((
                        c.clone(),
                        Json::str(format!("#/components/schemas/{}", vname)),
                    ));
                    refs.push(Self::reference(&vname));
                }
                obj(vec![
                    ("oneOf", Json::Arr(refs)),
                    (
                        "discriminator",
                        obj(vec![
                            ("propertyName", Json::str("type")),
                            ("mapping", Json::Obj(mapping)),
                        ]),
                    ),
                ])
            }
            _ => self.schema(mt),
        };
        self.schemas[at].1 = schema;
        Self::reference(&name)
    }

    fn object(&mut self, mt: &MT, fs: &[(String, MT)], order: &[usize], json: &[String]) -> Json {
        let docs = jsontype::field_docs(self.prog, mt).cloned();
        let mut props = Vec::new();
        let mut required = Vec::new();
        for &i in order {
            let (l, t) = &fs[i];
            let mut s = match jsontype::shape(t, self.prog) {
                Shape::Option(inner) => self.optional(&inner),
                _ => {
                    required.push(Json::str(&json[i]));
                    self.schema(t)
                }
            };
            let doc = docs
                .as_ref()
                .and_then(|d| d.get(l))
                .map(|d| jsontype::without_json_name(&d.doc))
                .unwrap_or_default();
            if !doc.is_empty() {
                if let Json::Obj(kv) = &mut s {
                    kv.push(("description".into(), Json::str(doc)));
                }
            }
            props.push((json[i].clone(), s));
        }
        let mut out = vec![
            ("type", Json::str("object")),
            ("properties", Json::Obj(props)),
        ];
        if !required.is_empty() {
            out.push(("required", Json::Arr(required)));
        }
        obj(out)
    }

    /// The schema of the value of `Some` (an `Option` inside an `Option`
    /// is a one-element array).
    fn optional(&mut self, inner: &MT) -> Json {
        match jsontype::shape(inner, self.prog) {
            Shape::Option(_) => obj(vec![
                ("type", Json::str("array")),
                ("items", self.schema(inner)),
                ("minItems", num(1)),
                ("maxItems", num(1)),
            ]),
            _ => self.schema(inner),
        }
    }

    fn tuple(&mut self, ts: &[MT]) -> Json {
        let items: Vec<Json> = ts.iter().map(|t| self.schema(t)).collect();
        obj(vec![
            ("type", Json::str("array")),
            ("prefixItems", Json::Arr(items)),
            ("items", Json::Bool(false)),
            ("minItems", num(ts.len() as i64)),
            ("maxItems", num(ts.len() as i64)),
        ])
    }

    fn int(format: &str, range: Option<(i64, i64)>) -> Json {
        let mut f = vec![
            ("type", Json::str("integer")),
            ("format", Json::str(format)),
        ];
        if let Some((lo, hi)) = range {
            f.push(("minimum", num(lo)));
            f.push(("maximum", num(hi)));
        }
        obj(f)
    }

    fn schema(&mut self, mt: &MT) -> Json {
        match jsontype::shape(mt, self.prog) {
            Shape::Int(n) => match n.as_str() {
                "I8" => Self::int("int32", Some((-128, 127))),
                "I16" => Self::int("int32", Some((-32768, 32767))),
                "I32" => Self::int("int32", None),
                "U8" => Self::int("int32", Some((0, 255))),
                "U16" => Self::int("int32", Some((0, 65535))),
                "U32" => Self::int("int64", Some((0, 4294967295))),
                "U64" | "USize" => obj(vec![
                    ("type", Json::str("integer")),
                    ("format", Json::str("uint64")),
                    ("minimum", num(0)),
                ]),
                _ => Self::int("int64", None),
            },
            Shape::Wide(n) => obj(vec![
                ("type", Json::str("string")),
                (
                    "format",
                    Json::str(if n == "I128" { "int128" } else { "uint128" }),
                ),
                (
                    "pattern",
                    Json::str(if n == "I128" {
                        "^-?[0-9]+$"
                    } else {
                        "^[0-9]+$"
                    }),
                ),
            ]),
            Shape::F32 => obj(vec![
                ("type", Json::str("number")),
                ("format", Json::str("float")),
            ]),
            Shape::F64 => obj(vec![
                ("type", Json::str("number")),
                ("format", Json::str("double")),
            ]),
            Shape::TInt(w) => {
                let max = (3i128.pow(w.min(40) as u32) - 1) / 2;
                obj(vec![
                    ("type", Json::str("integer")),
                    ("minimum", Json::Num(-(max as f64))),
                    ("maximum", Json::Num(max as f64)),
                ])
            }
            Shape::Trit => Self::int("int32", Some((-1, 1))),
            Shape::Str => ty("string"),
            Shape::Bytes => obj(vec![
                ("type", Json::str("string")),
                ("format", Json::str("byte")),
                ("contentEncoding", Json::str("base64")),
            ]),
            Shape::Duration => obj(vec![
                ("type", Json::str("string")),
                ("format", Json::str("duration")),
                (
                    "pattern",
                    Json::str("^-?[0-9]+(\\.[0-9]+)?(ns|us|ms|s|min|h)$"),
                ),
                ("examples", Json::Arr(vec![Json::str("1500ms")])),
            ]),
            Shape::Bool => ty("boolean"),
            Shape::Json => obj(vec![]),
            Shape::Unit => ty("object"),
            Shape::Option(t) => obj(vec![(
                "anyOf",
                Json::Arr(vec![self.optional(&t), ty("null")]),
            )]),
            Shape::List(t) | Shape::Array(t) => obj(vec![
                ("type", Json::str("array")),
                ("items", self.schema(&t)),
            ]),
            Shape::Set(t) => obj(vec![
                ("type", Json::str("array")),
                ("items", self.schema(&t)),
                ("uniqueItems", Json::Bool(true)),
            ]),
            Shape::Map(k, v) => {
                if matches!(jsontype::shape(&k, self.prog), Shape::Str) {
                    obj(vec![
                        ("type", Json::str("object")),
                        ("additionalProperties", self.schema(&v)),
                    ])
                } else {
                    obj(vec![
                        ("type", Json::str("array")),
                        ("items", self.tuple(&[k, v])),
                    ])
                }
            }
            Shape::Tuple(ts) => self.tuple(&ts),
            Shape::Record(None, fs, order, json) => self.object(mt, &fs, &order, &json),
            Shape::Record(Some(_), ..) | Shape::Enum(..) | Shape::Adt(..) => self.component(mt),
            Shape::Other => obj(vec![]),
        }
    }

    fn error_object(&mut self, e: Json) -> Json {
        obj(vec![
            ("type", Json::str("object")),
            ("properties", Json::Obj(vec![("error".into(), e)])),
            ("required", Json::Arr(vec![Json::str("error")])),
        ])
    }

    fn content(schema: Json) -> Json {
        obj(vec![("application/json", obj(vec![("schema", schema)]))])
    }

    fn response(description: &str, schema: Option<Json>) -> Json {
        let mut r = vec![("description", Json::str(description))];
        if let Some(s) = schema {
            r.push(("content", Self::content(s)));
        }
        obj(r)
    }

    fn parameter(
        &mut self,
        name: &str,
        place: &str,
        required: bool,
        schema: Json,
        doc: &str,
    ) -> Json {
        let mut p = vec![
            ("name", Json::str(name)),
            ("in", Json::str(place)),
            ("required", Json::Bool(required)),
            ("schema", schema),
        ];
        if !doc.is_empty() {
            p.push(("description", Json::str(doc)));
        }
        obj(p)
    }

    fn operation(&mut self, e: &Endpoint) -> Json {
        let mut op = vec![("operationId", Json::str(&e.name))];
        let sum = summary(&e.doc);
        if !sum.is_empty() {
            op.push(("summary", Json::str(&sum)));
        }
        let desc = description(&e.doc);
        if !desc.is_empty() && desc.split_whitespace().collect::<Vec<_>>().join(" ") != sum {
            op.push(("description", Json::str(desc)));
        }
        let mut params = Vec::new();
        let mut body = None;
        for p in &e.params {
            match &p.source {
                Source::Path(n) => {
                    let s = self.schema(&p.ty);
                    params.push(self.parameter(n, "path", true, s, ""));
                }
                Source::Query { name, required } => {
                    let s = match jsontype::shape(&p.ty, self.prog) {
                        Shape::Option(t) => self.schema(&t),
                        _ => self.schema(&p.ty),
                    };
                    params.push(self.parameter(name, "query", *required, s, ""));
                }
                Source::Queries(n) => {
                    let s = self.schema(&p.ty);
                    params.push(self.parameter(n, "query", false, s, ""));
                }
                Source::Fields(fs) => {
                    for f in fs {
                        let (required, s) = match f.kind {
                            FieldKind::Value => (true, self.schema(&f.ty)),
                            FieldKind::Optional => match jsontype::shape(&f.ty, self.prog) {
                                Shape::Option(t) => (false, self.schema(&t)),
                                _ => (false, self.schema(&f.ty)),
                            },
                            FieldKind::Repeated | FieldKind::Switch => (false, self.schema(&f.ty)),
                        };
                        params.push(self.parameter(&f.name, "query", required, s, &f.doc));
                    }
                }
                Source::Body { optional } => {
                    let s = match jsontype::shape(&p.ty, self.prog) {
                        Shape::Option(t) if *optional => self.optional(&t),
                        _ => self.schema(&p.ty),
                    };
                    body = Some(obj(vec![
                        ("required", Json::Bool(!optional)),
                        ("content", Self::content(s)),
                    ]));
                }
                Source::Unit => {}
            }
        }
        if !params.is_empty() {
            op.push(("parameters", Json::Arr(params)));
        }
        if let Some(b) = body {
            op.push(("requestBody", b));
        }
        // responses
        let mut responses: Vec<(String, Json)> = Vec::new();
        let ok = match &e.outcome {
            Outcome::Option(t) => Some(self.optional(t)),
            Outcome::Result(t, _) => Some(self.schema(t)),
            Outcome::Unit => None,
            Outcome::Value => Some(self.schema(&e.result)),
        };
        let ok = if e.status == 204 { None } else { ok };
        let reason = crate::openapi::reason(e.status);
        responses.push((e.status.to_string(), Self::response(reason, ok)));
        let error_ref = self.error_message();
        if e.params.iter().any(|p| !matches!(p.source, Source::Unit)) {
            responses.push((
                "400".into(),
                Self::response("invalid arguments", Some(error_ref.clone())),
            ));
        }
        if matches!(e.outcome, Outcome::Option(_)) {
            responses.push((
                "404".into(),
                Self::response("not found", Some(error_ref.clone())),
            ));
        }
        let mut etypes: Vec<MT> = e.error.iter().cloned().collect();
        if let Outcome::Result(_, x) = &e.outcome {
            if !etypes.contains(x) {
                etypes.push(x.clone());
            }
        }
        if !etypes.is_empty() {
            let schemas: Vec<Json> = etypes.iter().map(|t| self.schema(t)).collect();
            let s = if schemas.len() == 1 {
                schemas.into_iter().next().unwrap()
            } else {
                obj(vec![("anyOf", Json::Arr(schemas))])
            };
            let s = self.error_object(s);
            let mut statuses: Vec<i64> = e.errors.iter().map(|(_, s)| *s).collect();
            // the default status, unless every variant has its own
            let all_mapped = etypes.iter().all(|t| {
                let vs = match jsontype::shape(t, self.prog) {
                    Shape::Enum(_, ns) => ns,
                    Shape::Adt(_, vs) => vs.into_iter().map(|(n, _)| n).collect(),
                    _ => vec![],
                };
                !vs.is_empty() && vs.iter().all(|v| e.errors.iter().any(|(n, _)| n == v))
            });
            if !all_mapped {
                statuses.push(e.error_status);
            }
            statuses.sort();
            statuses.dedup();
            for st in statuses {
                let key = st.to_string();
                if responses.iter().any(|(k, _)| *k == key) {
                    continue;
                }
                responses.push((key, Self::response("error", Some(s.clone()))));
            }
            if etypes.iter().any(|t| self.has_status_field(t)) {
                responses.push((
                    "default".into(),
                    Self::response("error with its own status", Some(s)),
                ));
            }
        }
        responses.sort_by_key(|(k, _)| k.clone());
        op.push(("responses", Json::Obj(responses)));
        obj(op)
    }

    fn has_status_field(&self, t: &MT) -> bool {
        match jsontype::shape(t, self.prog) {
            Shape::Record(_, _, _, json) => json.iter().any(|n| n == "status"),
            _ => false,
        }
    }

    /// The component of `{"error": "message"}`.
    fn error_message(&mut self) -> Json {
        if !self.schemas.iter().any(|(n, _)| n == "Error") {
            self.schemas.push((
                "Error".into(),
                obj(vec![
                    ("type", Json::str("object")),
                    (
                        "properties",
                        Json::Obj(vec![("error".into(), ty("string"))]),
                    ),
                    ("required", Json::Arr(vec![Json::str("error")])),
                ]),
            ));
        }
        Self::reference("Error")
    }
}

/// The reason phrase of a status.
pub fn reason(status: i64) -> &'static str {
    match status {
        200 => "OK",
        201 => "Created",
        202 => "Accepted",
        204 => "No Content",
        _ => "success",
    }
}

/// The OpenAPI document of a program's endpoints.
pub fn document(prog: &Program, eps: &[Endpoint], title: &str) -> Result<Json, String> {
    let mut g = Gen {
        prog,
        names: BTreeMap::new(),
        used: BTreeSet::new(),
        schemas: Vec::new(),
    };
    // the generic error message first, so that types named `Error` get
    // another name
    g.used.insert("Error".into());
    let mut paths: Vec<(String, Json)> = Vec::new();
    for e in eps {
        let op = g.operation(e);
        let method = e.method.to_ascii_lowercase();
        match paths.iter_mut().find(|(p, _)| *p == e.path) {
            Some((_, Json::Obj(ms))) => ms.push((method, op)),
            _ => paths.push((e.path.clone(), Json::Obj(vec![(method, op)]))),
        }
    }
    let version = crate::cli::version(prog)?.unwrap_or_else(|| "0.1.0".into());
    let mut info = vec![("title", Json::str(title)), ("version", Json::str(version))];
    let desc = description(&prog.docs.module);
    if !desc.is_empty() {
        info.push(("description", Json::str(desc)));
    }
    let mut schemas = g.schemas;
    if let Some(i) = schemas.iter().position(|(n, _)| n == "Error") {
        let e = schemas.remove(i);
        schemas.push(e);
    }
    Ok(obj(vec![
        ("openapi", Json::str("3.1.0")),
        ("info", obj(info)),
        ("paths", Json::Obj(paths)),
        ("components", obj(vec![("schemas", Json::Obj(schemas))])),
    ]))
}
