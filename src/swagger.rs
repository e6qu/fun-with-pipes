//! Swagger 2.0 (OpenAPI 2) documents as OpenAPI 3.0 documents, for `fwp
//! openapi --import`, which reads OpenAPI 3.
//!
//! * `host`, `basePath` and `schemes` become `servers`;
//! * `definitions` become `components/schemas` (and `#/definitions/`
//!   references `#/components/schemas/` ones), `x-nullable` becomes
//!   `nullable`, a string `discriminator` an object, and `type: file` a
//!   binary string;
//! * parameters (and references to the document's `parameters`) keep their
//!   place, with their type in a `schema`; a `body` parameter becomes the
//!   `requestBody` with the media types of `consumes`, and `formData`
//!   parameters an object schema sent as a form, or as `multipart/form-data`
//!   when one is a file or `consumes` says so;
//! * responses (and references to the document's `responses`) get the
//!   media types of `produces` for their schema, and headers a `schema`;
//! * `securityDefinitions` become `components/securitySchemes`: `basic`
//!   HTTP authentication, API keys, and OAuth 2 flows.

use crate::json::Json;

const OPERATIONS: &[&str] = &["get", "put", "post", "delete", "options", "head", "patch"];

/// Whether a document is a Swagger document (of any version).
pub fn is_swagger(doc: &Json) -> bool {
    doc.get("swagger").is_some()
}

/// The OpenAPI 3.0 document of a Swagger 2.0 document.
pub fn to_openapi(doc: &Json) -> Result<Json, String> {
    let version = match doc.get("swagger") {
        Some(Json::Str(s)) => s.clone(),
        Some(v) => v.to_string(),
        None => return Err("not a Swagger document".into()),
    };
    if version != "2.0" {
        return Err(format!(
            "Swagger {} is not supported (Swagger 2.0 and OpenAPI 3.0 and 3.1 are)",
            version
        ));
    }
    let mut out: Vec<(String, Json)> = vec![("openapi".into(), Json::str("3.0.3"))];
    if let Some(info) = doc.get("info") {
        out.push(("info".into(), info.clone()));
    }
    if let Some(s) = servers(doc) {
        out.push(("servers".into(), s));
    }
    let mut paths = Vec::new();
    for (path, item) in doc.get("paths").map(Json::members).unwrap_or(&[]) {
        paths.push((path.clone(), path_item(doc, item)?));
    }
    out.push(("paths".into(), Json::Obj(paths)));
    let mut components = Vec::new();
    if let Some(Json::Obj(defs)) = doc.get("definitions") {
        components.push((
            "schemas".into(),
            Json::Obj(defs.iter().map(|(k, v)| (k.clone(), schema(v))).collect()),
        ));
    }
    if let Some(Json::Obj(sec)) = doc.get("securityDefinitions") {
        let schemes = sec
            .iter()
            .map(|(k, v)| (k.clone(), security_scheme(v)))
            .collect();
        components.push(("securitySchemes".into(), Json::Obj(schemes)));
    }
    if !components.is_empty() {
        out.push(("components".into(), Json::Obj(components)));
    }
    for k in ["security", "tags", "externalDocs"] {
        if let Some(v) = doc.get(k) {
            out.push((k.into(), v.clone()));
        }
    }
    Ok(Json::Obj(out))
}

fn servers(doc: &Json) -> Option<Json> {
    let base = doc.get("basePath").and_then(Json::as_str).unwrap_or("");
    let url = match doc.get("host").and_then(Json::as_str) {
        Some(h) => {
            let scheme = doc
                .get("schemes")
                .and_then(Json::as_array)
                .and_then(|s| s.first())
                .and_then(Json::as_str)
                .unwrap_or("http");
            format!("{}://{}{}", scheme, h, base)
        }
        None if !base.is_empty() => base.to_string(),
        None => return None,
    };
    Some(Json::Arr(vec![Json::obj(vec![("url", Json::Str(url))])]))
}

/// A schema with its references and Swagger forms rewritten.
fn schema(s: &Json) -> Json {
    match s {
        Json::Obj(ms) => {
            let mut out: Vec<(String, Json)> = Vec::new();
            let mut file = false;
            for (k, v) in ms {
                let v = match (k.as_str(), v) {
                    ("$ref", Json::Str(r)) => Json::Str(reference(r)),
                    ("x-nullable", v) => {
                        out.push(("nullable".into(), v.clone()));
                        continue;
                    }
                    ("type", Json::Str(t)) if t == "file" => {
                        file = true;
                        Json::str("string")
                    }
                    ("discriminator", Json::Str(p)) => {
                        Json::obj(vec![("propertyName", Json::Str(p.clone()))])
                    }
                    // schemas by name
                    ("properties" | "definitions" | "patternProperties", Json::Obj(ps)) => {
                        Json::Obj(ps.iter().map(|(k, v)| (k.clone(), schema(v))).collect())
                    }
                    ("example" | "default" | "enum" | "x-example" | "required", v) => v.clone(),
                    (_, v) => schema(v),
                };
                out.push((k.clone(), v));
            }
            if file {
                out.push(("format".into(), Json::str("binary")));
            }
            Json::Obj(out)
        }
        Json::Arr(xs) => Json::Arr(xs.iter().map(schema).collect()),
        other => other.clone(),
    }
}

fn reference(r: &str) -> String {
    match r.strip_prefix("#/definitions/") {
        Some(n) => format!("#/components/schemas/{}", n),
        None => r.to_string(),
    }
}

/// Resolve a reference to the document's `parameters` or `responses`.
fn resolved<'a>(doc: &'a Json, v: &'a Json, kind: &str) -> Result<&'a Json, String> {
    match v.get("$ref").and_then(Json::as_str) {
        Some(r) => {
            let name = r
                .strip_prefix(&format!("#/{}/", kind))
                .ok_or_else(|| format!("unsupported reference `{}`", r))?;
            doc.at(&[kind, name])
                .ok_or_else(|| format!("there is no {} `{}`", kind.trim_end_matches('s'), r))
        }
        None => Ok(v),
    }
}

/// The schema of a parameter, a header or an item that is not in a body:
/// its type, format, items and constraints.
fn simple_schema(p: &Json) -> Json {
    let mut out: Vec<(String, Json)> = Vec::new();
    for (k, v) in p.members() {
        match k.as_str() {
            "type" if v.as_str() == Some("file") => {
                out.push(("type".into(), Json::str("string")));
                out.push(("format".into(), Json::str("binary")));
            }
            "items" => out.push((k.clone(), simple_schema(v))),
            "type" | "format" | "enum" | "default" | "minimum" | "maximum" | "exclusiveMinimum"
            | "exclusiveMaximum" | "minLength" | "maxLength" | "pattern" | "minItems"
            | "maxItems" | "uniqueItems" | "multipleOf" => out.push((k.clone(), v.clone())),
            "x-nullable" => out.push(("nullable".into(), v.clone())),
            _ => {}
        }
    }
    Json::Obj(out)
}

fn media_types(doc: &Json, op: &Json, key: &str) -> Vec<String> {
    op.get(key)
        .or_else(|| doc.get(key))
        .and_then(Json::as_array)
        .map(|a| {
            a.iter()
                .filter_map(Json::as_str)
                .map(str::to_string)
                .collect()
        })
        .filter(|v: &Vec<String>| !v.is_empty())
        .unwrap_or_else(|| vec!["application/json".into()])
}

fn path_item(doc: &Json, item: &Json) -> Result<Json, String> {
    let shared: Vec<&Json> = item
        .get("parameters")
        .and_then(Json::as_array)
        .map(|a| a.iter().collect())
        .unwrap_or_default();
    let mut out = Vec::new();
    for (k, v) in item.members() {
        if OPERATIONS.contains(&k.as_str()) {
            out.push((k.clone(), operation(doc, v, &shared)?));
        } else if k == "parameters" {
            let mut ps = Vec::new();
            for p in &shared {
                let p = resolved(doc, p, "parameters")?;
                if !matches!(
                    p.get("in").and_then(Json::as_str),
                    Some("body" | "formData")
                ) {
                    ps.push(parameter(p));
                }
            }
            out.push((k.clone(), Json::Arr(ps)));
        } else if k.starts_with("x-") || k == "summary" || k == "description" {
            out.push((k.clone(), v.clone()));
        }
    }
    Ok(Json::Obj(out))
}

/// A parameter in a path, query, header or cookie.
fn parameter(p: &Json) -> Json {
    let mut out: Vec<(String, Json)> = Vec::new();
    for k in [
        "name",
        "in",
        "description",
        "required",
        "deprecated",
        "allowEmptyValue",
    ] {
        if let Some(v) = p.get(k) {
            out.push((k.into(), v.clone()));
        }
    }
    if p.get("in").and_then(Json::as_str) == Some("path") && p.get("required").is_none() {
        out.push(("required".into(), Json::Bool(true)));
    }
    match p.get("collectionFormat").and_then(Json::as_str) {
        Some("multi") => out.push(("explode".into(), Json::Bool(true))),
        Some("csv") => out.push(("explode".into(), Json::Bool(false))),
        Some("ssv") => out.push(("style".into(), Json::str("spaceDelimited"))),
        Some("pipes") => out.push(("style".into(), Json::str("pipeDelimited"))),
        _ => {}
    }
    out.push(("schema".into(), simple_schema(p)));
    Json::Obj(out)
}

fn operation(doc: &Json, op: &Json, shared: &[&Json]) -> Result<Json, String> {
    let mut params: Vec<&Json> = Vec::new();
    for p in op.get("parameters").and_then(Json::as_array).unwrap_or(&[]) {
        params.push(resolved(doc, p, "parameters")?);
    }
    let key = |p: &Json| (p.get("name").cloned(), p.get("in").cloned());
    // the path's body and form parameters (its others stay on the path)
    for p in shared {
        let p = resolved(doc, p, "parameters")?;
        let body = matches!(
            p.get("in").and_then(Json::as_str),
            Some("body" | "formData")
        );
        if body && !params.iter().any(|q| key(q) == key(p)) {
            params.push(p);
        }
    }
    let consumes = media_types(doc, op, "consumes");
    let produces = media_types(doc, op, "produces");
    let mut out: Vec<(String, Json)> = Vec::new();
    for k in [
        "tags",
        "summary",
        "description",
        "externalDocs",
        "operationId",
        "deprecated",
    ] {
        if let Some(v) = op.get(k) {
            out.push((k.into(), v.clone()));
        }
    }
    let mut ps = Vec::new();
    let mut body = None;
    let mut form: Vec<(String, Json)> = Vec::new();
    let mut form_required = Vec::new();
    let mut file = false;
    for p in params {
        match p.get("in").and_then(Json::as_str) {
            Some("body") => {
                let s = schema(p.get("schema").unwrap_or(&Json::Obj(vec![])));
                let mut content: Vec<(String, Json)> = consumes
                    .iter()
                    .filter(|c| !is_form(c))
                    .map(|c| (c.clone(), Json::obj(vec![("schema", s.clone())])))
                    .collect();
                if content.is_empty() {
                    content.push(("application/json".into(), Json::obj(vec![("schema", s)])));
                }
                let mut b = Vec::new();
                if let Some(d) = p.get("description") {
                    b.push(("description".to_string(), d.clone()));
                }
                b.push(("content".into(), Json::Obj(content)));
                if p.get("required") == Some(&Json::Bool(true)) {
                    b.push(("required".into(), Json::Bool(true)));
                }
                body = Some(Json::Obj(b));
            }
            Some("formData") => {
                let name = p
                    .get("name")
                    .and_then(Json::as_str)
                    .unwrap_or("")
                    .to_string();
                file |= p.get("type").and_then(Json::as_str) == Some("file");
                let mut s = simple_schema(p);
                if let (Json::Obj(ms), Some(d)) = (&mut s, p.get("description")) {
                    ms.push(("description".into(), d.clone()));
                }
                if p.get("required") == Some(&Json::Bool(true)) {
                    form_required.push(Json::Str(name.clone()));
                }
                form.push((name, s));
            }
            _ => ps.push(parameter(p)),
        }
    }
    if !ps.is_empty() {
        out.push(("parameters".into(), Json::Arr(ps)));
    }
    if body.is_none() && !form.is_empty() {
        let any_required = !form_required.is_empty();
        let mut s = vec![
            ("type".to_string(), Json::str("object")),
            ("properties".into(), Json::Obj(form)),
        ];
        if any_required {
            s.push(("required".into(), Json::Arr(form_required)));
        }
        let s = Json::Obj(s);
        let mut types: Vec<String> = consumes.iter().filter(|c| is_form(c)).cloned().collect();
        if types.is_empty() || (file && !types.iter().any(|t| t.starts_with("multipart/"))) {
            types = vec![if file {
                "multipart/form-data".into()
            } else {
                "application/x-www-form-urlencoded".into()
            }];
        }
        let content = types
            .into_iter()
            .map(|t| (t, Json::obj(vec![("schema", s.clone())])))
            .collect();
        let mut b = vec![("content".to_string(), Json::Obj(content))];
        if any_required {
            b.push(("required".into(), Json::Bool(true)));
        }
        body = Some(Json::Obj(b));
    }
    if let Some(b) = body {
        out.push(("requestBody".into(), b));
    }
    let mut responses = Vec::new();
    for (code, r) in op.get("responses").map(Json::members).unwrap_or(&[]) {
        let r = resolved(doc, r, "responses")?;
        let mut o: Vec<(String, Json)> = vec![(
            "description".into(),
            r.get("description").cloned().unwrap_or(Json::str("")),
        )];
        if let Some(Json::Obj(hs)) = r.get("headers") {
            let headers = hs
                .iter()
                .map(|(k, h)| {
                    let mut m = Vec::new();
                    if let Some(d) = h.get("description") {
                        m.push(("description".to_string(), d.clone()));
                    }
                    m.push(("schema".into(), simple_schema(h)));
                    (k.clone(), Json::Obj(m))
                })
                .collect();
            o.push(("headers".into(), Json::Obj(headers)));
        }
        if let Some(s) = r.get("schema") {
            let s = schema(s);
            let content = produces
                .iter()
                .map(|t| (t.clone(), Json::obj(vec![("schema", s.clone())])))
                .collect();
            o.push(("content".into(), Json::Obj(content)));
        }
        responses.push((code.clone(), Json::Obj(o)));
    }
    out.push(("responses".into(), Json::Obj(responses)));
    if let Some(s) = op.get("security") {
        out.push(("security".into(), s.clone()));
    }
    Ok(Json::Obj(out))
}

fn is_form(t: &str) -> bool {
    t.starts_with("application/x-www-form-urlencoded") || t.starts_with("multipart/form-data")
}

fn security_scheme(s: &Json) -> Json {
    let g = |k: &str| s.get(k).cloned();
    let mut out: Vec<(String, Json)> = Vec::new();
    match s.get("type").and_then(Json::as_str) {
        Some("basic") => {
            out.push(("type".into(), Json::str("http")));
            out.push(("scheme".into(), Json::str("basic")));
        }
        Some("apiKey") => {
            out.push(("type".into(), Json::str("apiKey")));
            for k in ["name", "in"] {
                if let Some(v) = g(k) {
                    out.push((k.into(), v));
                }
            }
        }
        Some("oauth2") => {
            out.push(("type".into(), Json::str("oauth2")));
            let flow = match s.get("flow").and_then(Json::as_str) {
                Some("implicit") => "implicit",
                Some("password") => "password",
                Some("application") => "clientCredentials",
                _ => "authorizationCode",
            };
            let mut f = Vec::new();
            for k in ["authorizationUrl", "tokenUrl"] {
                if let Some(v) = g(k) {
                    f.push((k.to_string(), v));
                }
            }
            f.push(("scopes".into(), g("scopes").unwrap_or(Json::Obj(vec![]))));
            out.push((
                "flows".into(),
                Json::Obj(vec![(flow.to_string(), Json::Obj(f))]),
            ));
        }
        _ => return s.clone(),
    }
    if let Some(d) = g("description") {
        out.push(("description".into(), d));
    }
    Json::Obj(out)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn converts_a_document() {
        let doc = Json::parse(
            r##"{"swagger":"2.0","info":{"title":"t","version":"1"},"host":"api.example","basePath":"/v2","schemes":["https"],
            "consumes":["application/json"],"produces":["application/json"],
            "parameters":{"Limit":{"name":"limit","in":"query","type":"integer","format":"int32"}},
            "paths":{"/pets/{id}":{"parameters":[{"name":"id","in":"path","required":true,"type":"integer"}],
              "post":{"operationId":"upload","consumes":["multipart/form-data"],"parameters":[
                {"name":"file","in":"formData","type":"file","required":true},{"name":"note","in":"formData","type":"string"},{"$ref":"#/parameters/Limit"}],
                "responses":{"200":{"description":"ok","schema":{"$ref":"#/definitions/Pet"},"headers":{"X-Rate":{"type":"integer"}}}}},
              "put":{"parameters":[{"name":"body","in":"body","required":true,"schema":{"$ref":"#/definitions/Pet"}}],"responses":{"204":{"description":"done"}},"security":[{"key":[]}]}}},
            "definitions":{"Pet":{"type":"object","required":["kids"],"properties":{"tag":{"type":"string","x-nullable":true},"kids":{"type":"array","items":{"$ref":"#/definitions/Pet"}}}}},
            "securityDefinitions":{"key":{"type":"apiKey","name":"X-Key","in":"header"},"basic":{"type":"basic"},"oauth":{"type":"oauth2","flow":"application","tokenUrl":"https://t"}}}"##,
        )
        .unwrap();
        let o = to_openapi(&doc).unwrap();
        let at = |p: &[&str]| o.at(p).cloned().unwrap_or(Json::Null).to_string();
        assert_eq!(at(&["servers"]), r#"[{"url":"https://api.example/v2"}]"#);
        let post = |k: &str| at(&["paths", "/pets/{id}", "post", k]);
        assert_eq!(
            post("requestBody"),
            r#"{"content":{"multipart/form-data":{"schema":{"type":"object","properties":{"file":{"type":"string","format":"binary"},"note":{"type":"string"}},"required":["file"]}}},"required":true}"#
        );
        assert_eq!(
            post("parameters"),
            r#"[{"name":"limit","in":"query","schema":{"type":"integer","format":"int32"}}]"#
        );
        assert_eq!(
            post("responses"),
            r##"{"200":{"description":"ok","headers":{"X-Rate":{"schema":{"type":"integer"}}},"content":{"application/json":{"schema":{"$ref":"#/components/schemas/Pet"}}}}}"##
        );
        assert_eq!(
            at(&["paths", "/pets/{id}", "parameters"]),
            r#"[{"name":"id","in":"path","required":true,"schema":{"type":"integer"}}]"#
        );
        assert_eq!(
            at(&["paths", "/pets/{id}", "put", "requestBody"]),
            r##"{"content":{"application/json":{"schema":{"$ref":"#/components/schemas/Pet"}}},"required":true}"##
        );
        assert_eq!(
            at(&["components", "schemas", "Pet"]),
            r##"{"type":"object","required":["kids"],"properties":{"tag":{"type":"string","nullable":true},"kids":{"type":"array","items":{"$ref":"#/components/schemas/Pet"}}}}"##
        );
        assert_eq!(
            at(&["components", "securitySchemes"]),
            r#"{"key":{"type":"apiKey","name":"X-Key","in":"header"},"basic":{"type":"http","scheme":"basic"},"oauth":{"type":"oauth2","flows":{"clientCredentials":{"tokenUrl":"https://t","scopes":{}}}}}"#
        );
        assert!(to_openapi(&Json::parse(r#"{"swagger":"1.2"}"#).unwrap()).is_err());
    }
}
