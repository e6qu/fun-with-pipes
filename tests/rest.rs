//! REST endpoints from exported functions (`fwp serve --rest`,
//! `fwp build --rest`), OpenAPI documents (`fwp openapi`) and generated
//! clients (`fwp openapi --import`). The servers of `tests/rest/api.fwp`
//! and `examples/rest/books.fwp` run interpreted and natively and answer
//! the same requests with the same responses; the generated documents and
//! clients are compared with golden files (`FWP_BLESS=1` regenerates
//! them), and a client generated from a server's own document calls it.

use std::io::{BufRead, BufReader, Read, Write};
use std::net::TcpStream;
use std::path::{Path, PathBuf};
use std::process::{Child, Command, Stdio};
use std::time::Duration;

fn fwp() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_fwp"))
}

fn root() -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR"))
}

fn fixture(name: &str) -> PathBuf {
    root().join("tests/rest").join(name)
}

fn bless() -> bool {
    std::env::var("FWP_BLESS").is_ok()
}

fn have_cc() -> bool {
    Command::new(std::env::var("CC").unwrap_or_else(|_| "cc".into()))
        .arg("--version")
        .output()
        .is_ok()
}

fn temp_dir(name: &str) -> PathBuf {
    let d = std::env::temp_dir().join(format!("fwp-rest-{}-{}", name, std::process::id()));
    let _ = std::fs::remove_dir_all(&d);
    std::fs::create_dir_all(&d).unwrap();
    d
}

struct Server {
    child: Child,
    addr: String,
}

impl Drop for Server {
    fn drop(&mut self) {
        let _ = self.child.kill();
        let _ = self.child.wait();
    }
}

/// Start a server and read the address it listens on.
fn start(mut cmd: Command) -> Server {
    let mut child = cmd
        .stdout(Stdio::null())
        .stderr(Stdio::piped())
        .spawn()
        .expect("start server");
    let mut stderr = BufReader::new(child.stderr.take().unwrap());
    let mut line = String::new();
    stderr.read_line(&mut line).expect("read address");
    let addr = line
        .trim()
        .strip_prefix("fwp: rest listening on http://")
        .unwrap_or_else(|| panic!("unexpected first line: {:?}", line))
        .to_string();
    // keep draining stderr so that the server never blocks on it
    std::thread::spawn(move || {
        let mut rest = String::new();
        let _ = stderr.read_to_string(&mut rest);
    });
    Server { child, addr }
}

fn interpreted(file: &Path) -> Server {
    let mut cmd = Command::new(fwp());
    cmd.args(["serve", "--rest"])
        .arg(file)
        .args(["--listen", "127.0.0.1:0"]);
    start(cmd)
}

fn native(file: &Path, dir: &Path) -> Server {
    let exe = dir.join("server");
    let out = Command::new(fwp())
        .arg("build")
        .arg(file)
        .args(["--rest", "-O1", "-o"])
        .arg(&exe)
        .output()
        .unwrap();
    assert!(
        out.status.success(),
        "build failed: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    let mut cmd = Command::new(exe);
    cmd.args(["--listen", "127.0.0.1:0"]);
    start(cmd)
}

/// One request on its own connection: the status, the headers and the
/// body of the response.
fn http(
    addr: &str,
    method: &str,
    target: &str,
    body: Option<&str>,
) -> (u16, Vec<(String, String)>, String) {
    let mut conn = TcpStream::connect(addr).unwrap();
    conn.set_read_timeout(Some(Duration::from_secs(30)))
        .unwrap();
    let mut req = format!(
        "{} {} HTTP/1.1\r\nhost: test\r\nconnection: close\r\n",
        method, target
    );
    if let Some(b) = body {
        req.push_str(&format!(
            "content-type: application/json\r\ncontent-length: {}\r\n",
            b.len()
        ));
    }
    req.push_str("\r\n");
    req.push_str(body.unwrap_or(""));
    conn.write_all(req.as_bytes()).unwrap();
    let mut raw = Vec::new();
    conn.read_to_end(&mut raw).unwrap();
    let text = String::from_utf8_lossy(&raw).into_owned();
    let (head, rest) = text.split_once("\r\n\r\n").expect("a response head");
    let mut lines = head.split("\r\n");
    let status: u16 = lines
        .next()
        .and_then(|l| l.split(' ').nth(1))
        .and_then(|s| s.parse().ok())
        .expect("a status");
    let headers: Vec<(String, String)> = lines
        .filter_map(|l| l.split_once(':'))
        .map(|(k, v)| (k.trim().to_ascii_lowercase(), v.trim().to_string()))
        .collect();
    let len = headers
        .iter()
        .find(|(k, _)| k == "content-length")
        .and_then(|(_, v)| v.parse().ok())
        .unwrap_or(rest.len());
    (status, headers, rest[..len.min(rest.len())].to_string())
}

/// Requests to `tests/rest/api.fwp` and their expected responses.
const API: &[(&str, &str, Option<&str>, u16, &str)] = &[
    // the default route, a record body
    (
        "POST",
        "/echo-item",
        Some(r#"{"id":1,"name":"x","price":2,"tags":[]}"#),
        200,
        r#"{"id":1,"name":"x","price":2.0,"tags":[]}"#,
    ),
    // a path parameter and an Option result
    (
        "GET",
        "/items/5",
        None,
        200,
        r#"{"id":5,"name":"item 5","price":7.5,"tags":["a"]}"#,
    ),
    ("GET", "/items/500", None, 404, r#"{"error":"not found"}"#),
    (
        "GET",
        "/items/x",
        None,
        400,
        r#"{"error":"path.id: expected an integer, got \"x\""}"#,
    ),
    ("HEAD", "/items/5", None, 200, ""),
    // an options record from the query: a switch, a repeated field, an
    // optional and a required one
    (
        "GET",
        "/items?prefix=p&tag=a&tag=b&desc&limit=3",
        None,
        200,
        r#""Listing {desc = True, limit = Some 3, prefix = \"p\", tag = [\"a\", \"b\"]}""#,
    ),
    (
        "GET",
        "/items?prefix=a%20b&desc=false",
        None,
        200,
        r#""Listing {desc = False, limit = None, prefix = \"a b\", tag = []}""#,
    ),
    (
        "GET",
        "/items?tag=a",
        None,
        400,
        r#"{"error":"query.prefix: required field is missing"}"#,
    ),
    (
        "GET",
        "/items?prefix=p&limit=x",
        None,
        400,
        r#"{"error":"query.limit: expected an integer, got \"x\""}"#,
    ),
    // `# args:` names: a path parameter and an optional query parameter
    (
        "GET",
        "/search/hello%20world?limit=4",
        None,
        200,
        r#""(\"hello world\", Some 4)""#,
    ),
    ("GET", "/search/x", None, 200, r#""(\"x\", None)""#),
    // a path parameter and a body, with `# status: 201`
    (
        "PUT",
        "/items/7",
        Some(r#"{"id":0,"name":"n","price":1,"tags":["t"],"note":"z"}"#),
        201,
        r#"{"id":7,"name":"n","price":1.0,"tags":["t"],"note":"z"}"#,
    ),
    (
        "PUT",
        "/items/7",
        Some(r#"{"id":0,"name":"n","price":"1","tags":[3]}"#),
        400,
        r#"{"error":"$.tags[0]: expected a string, got 3"}"#,
    ),
    // errors with statuses by variant, and `()` as 204
    (
        "DELETE",
        "/items/1",
        None,
        404,
        r#"{"error":{"type":"Missing","value":1}}"#,
    ),
    (
        "DELETE",
        "/items/2",
        None,
        422,
        r#"{"error":{"type":"Invalid","value":{"field":"id","reason":"protected"}}}"#,
    ),
    ("DELETE", "/items/3", None, 204, ""),
    // a Result: Err without a status is a 500
    ("POST", "/check", Some(r#""bob""#), 200, r#""bob!""#),
    (
        "POST",
        "/check",
        Some(r#""""#),
        500,
        r#"{"error":{"type":"Invalid","value":{"field":"name","reason":"empty"}}}"#,
    ),
    // `# command:` names the route; variants in a body
    (
        "POST",
        "/area",
        Some(r#"{"type":"Rect","value":[2,3]}"#),
        200,
        "6.0",
    ),
    ("POST", "/area", Some(r#""Dot""#), 200, "0.0"),
    (
        "POST",
        "/area",
        Some(r#"{"type":"Square"}"#),
        400,
        r#"{"error":"$.type: expected one of \"Circle\", \"Rect\", \"Dot\", got \"Square\""}"#,
    ),
    // an error with its own status
    (
        "POST",
        "/teapot",
        Some(r#""short and stout""#),
        418,
        r#"{"error":{"status":418,"message":"short and stout"}}"#,
    ),
    // four parameters: path, path, query, body
    ("POST", "/sum/10/20?c=5", Some("[1,2,3]"), 200, "41"),
    (
        "POST",
        "/sum/10/20",
        Some("[1]"),
        400,
        r#"{"error":"missing query parameter c"}"#,
    ),
    // values beyond JSON's doubles, bytes, durations, a renamed field
    (
        "POST",
        "/big",
        Some(
            r#"{"n":9223372036854775807,"u":18446744073709551615,"wide":"-170141183460469231731687303715884105728","data":"Zm9v","timeout":"1.5s","type":"k"}"#,
        ),
        200,
        r#"{"n":9223372036854775807,"u":18446744073709551615,"wide":"-170141183460469231731687303715884105728","data":"Zm9v","timeout":"1500ms","type":"k"}"#,
    ),
    (
        "POST",
        "/big",
        Some(r#"{"type":"t","wide":"1","u":-1,"timeout":"1s","data":"","n":1}"#),
        400,
        r#"{"error":"$.u: -1 is out of range for U64"}"#,
    ),
    // `()` parameters
    ("GET", "/ping", None, 200, r#""pong""#),
    ("GET", "/tags", None, 200, r#"["a","b"]"#),
    // an optional body
    ("POST", "/maybe", None, 200, "-1"),
    ("POST", "/maybe", Some("5"), 200, "5"),
    (
        "POST",
        "/maybe",
        Some("5 6"),
        400,
        r#"{"error":"invalid JSON in the request body: trailing characters at byte 2"}"#,
    ),
    (
        "POST",
        "/echo-item",
        None,
        400,
        r#"{"error":"missing request body"}"#,
    ),
    // the router
    (
        "GET",
        "/check",
        None,
        405,
        r#"{"error":"method not allowed"}"#,
    ),
    (
        "GET",
        "/nothing/here",
        None,
        404,
        r#"{"error":"not found"}"#,
    ),
];

fn exercise_api(srv: &Server) {
    for (method, target, body, status, expected) in API {
        let (st, headers, got) = http(&srv.addr, method, target, *body);
        assert_eq!(
            (st, got.as_str()),
            (*status, *expected),
            "{} {} {:?}",
            method,
            target,
            body
        );
        if st != 204 && *method != "HEAD" {
            assert!(
                headers
                    .iter()
                    .any(|(k, v)| k == "content-type" && v == "application/json"),
                "{} {}: {:?}",
                method,
                target,
                headers
            );
        }
    }
    // the OpenAPI document is what `fwp openapi` prints
    let (st, _, doc) = http(&srv.addr, "GET", "/openapi.json", None);
    assert_eq!(st, 200);
    assert_eq!(doc, openapi_text(&fixture("api.fwp")));
}

fn openapi_text(file: &Path) -> String {
    let out = Command::new(fwp())
        .arg("openapi")
        .arg(file)
        .output()
        .unwrap();
    assert!(
        out.status.success(),
        "fwp openapi: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    String::from_utf8(out.stdout).unwrap()
}

#[test]
fn api_interpreted() {
    exercise_api(&interpreted(&fixture("api.fwp")));
}

#[test]
fn api_native() {
    if !have_cc() {
        eprintln!("skipping: no C compiler");
        return;
    }
    let dir = temp_dir("api-native");
    exercise_api(&native(&fixture("api.fwp"), &dir));
    let _ = std::fs::remove_dir_all(dir);
}

fn exercise_books(srv: &Server) {
    let a = &srv.addr;
    let (st, _, b) = http(a, "GET", "/books?tag=classic&max-price=30", None);
    assert_eq!(st, 200);
    assert!(
        b.starts_with(r#"[{"id":3,"title":"Gödel, Escher, Bach""#),
        "{}",
        b
    );
    let (st, _, b) = http(a, "GET", "/books?in-stock&author=Friedman", None);
    assert_eq!((st, b.as_str()), (200, "[]"));
    let (st, _, b) = http(
        a,
        "POST",
        "/quotes",
        Some(r#"{"lines":[{"book":1,"quantity":2},{"book":3,"quantity":1}],"coupon":"FWP10"}"#),
    );
    assert_eq!(st, 200);
    assert!(b.ends_with(r#""discount":0.1,"total":100.8}"#), "{}", b);
    for (body, status) in [
        (r#"{"lines":[{"book":2,"quantity":2}]}"#, 409),
        (r#"{"lines":[{"book":7,"quantity":1}]}"#, 404),
        (r#"{"lines":[],"coupon":"x"}"#, 422),
        (r#"{"lines":[{"book":"one"}]}"#, 400),
    ] {
        assert_eq!(http(a, "POST", "/quotes", Some(body)).0, status, "{}", body);
    }
    assert_eq!(http(a, "GET", "/health", None).2, r#""ok""#);
    let (st, _, doc) = http(a, "GET", "/openapi.json", None);
    assert_eq!(st, 200);
    assert_eq!(doc, openapi_text(&root().join("examples/rest/books.fwp")));
}

#[test]
fn books_example() {
    let file = root().join("examples/rest/books.fwp");
    exercise_books(&interpreted(&file));
    if have_cc() {
        let dir = temp_dir("books-native");
        exercise_books(&native(&file, &dir));
        let _ = std::fs::remove_dir_all(dir);
    }
}

fn golden(path: &Path, actual: &str) {
    if bless() {
        std::fs::write(path, actual).unwrap();
        return;
    }
    let expected = std::fs::read_to_string(path)
        .unwrap_or_else(|_| panic!("missing {} (run with FWP_BLESS=1)", path.display()));
    assert!(
        expected == actual,
        "{} differs (FWP_BLESS=1 regenerates it); got:\n{}",
        path.display(),
        actual
    );
}

#[test]
fn openapi_golden() {
    golden(
        &fixture("api.openapi.json"),
        &openapi_text(&fixture("api.fwp")),
    );
    golden(
        &fixture("books.openapi.json"),
        &openapi_text(&root().join("examples/rest/books.fwp")),
    );
}

// --------------------------------------------------------- the documents

/// A minimal JSON reader for the structural checks.
#[derive(Debug, Clone, PartialEq)]
enum J {
    Null,
    Bool(bool),
    Num(f64),
    Str(String),
    Arr(Vec<J>),
    Obj(Vec<(String, J)>),
}

impl J {
    fn get(&self, k: &str) -> Option<&J> {
        match self {
            J::Obj(fs) => fs.iter().find(|(n, _)| n == k).map(|(_, v)| v),
            _ => None,
        }
    }
    fn members(&self) -> &[(String, J)] {
        match self {
            J::Obj(fs) => fs,
            _ => &[],
        }
    }
    fn str(&self) -> Option<&str> {
        match self {
            J::Str(s) => Some(s),
            _ => None,
        }
    }
}

fn parse_json(s: &str) -> J {
    fn ws(b: &[u8], i: &mut usize) {
        while *i < b.len() && b[*i].is_ascii_whitespace() {
            *i += 1;
        }
    }
    fn string(b: &[u8], i: &mut usize) -> String {
        *i += 1;
        let mut out = Vec::new();
        while b[*i] != b'"' {
            if b[*i] == b'\\' {
                *i += 1;
                match b[*i] {
                    b'n' => out.push(b'\n'),
                    b't' => out.push(b'\t'),
                    b'u' => {
                        let h = std::str::from_utf8(&b[*i + 1..*i + 5]).unwrap();
                        let c = char::from_u32(u32::from_str_radix(h, 16).unwrap()).unwrap();
                        out.extend(c.to_string().bytes());
                        *i += 4;
                    }
                    c => out.push(c),
                }
            } else {
                out.push(b[*i]);
            }
            *i += 1;
        }
        *i += 1;
        String::from_utf8(out).unwrap()
    }
    fn value(b: &[u8], i: &mut usize) -> J {
        ws(b, i);
        match b[*i] {
            b'{' => {
                *i += 1;
                let mut fs = Vec::new();
                loop {
                    ws(b, i);
                    if b[*i] == b'}' {
                        *i += 1;
                        return J::Obj(fs);
                    }
                    if b[*i] == b',' {
                        *i += 1;
                        ws(b, i);
                    }
                    let k = string(b, i);
                    ws(b, i);
                    *i += 1; // ':'
                    fs.push((k, value(b, i)));
                }
            }
            b'[' => {
                *i += 1;
                let mut xs = Vec::new();
                loop {
                    ws(b, i);
                    if b[*i] == b']' {
                        *i += 1;
                        return J::Arr(xs);
                    }
                    if b[*i] == b',' {
                        *i += 1;
                    }
                    xs.push(value(b, i));
                }
            }
            b'"' => J::Str(string(b, i)),
            b't' => {
                *i += 4;
                J::Bool(true)
            }
            b'f' => {
                *i += 5;
                J::Bool(false)
            }
            b'n' => {
                *i += 4;
                J::Null
            }
            _ => {
                let st = *i;
                while *i < b.len() && (b[*i].is_ascii_digit() || b"+-.eE".contains(&b[*i])) {
                    *i += 1;
                }
                J::Num(std::str::from_utf8(&b[st..*i]).unwrap().parse().unwrap())
            }
        }
    }
    let mut i = 0;
    value(s.as_bytes(), &mut i)
}

/// Structural checks of an OpenAPI 3.1 document: every reference
/// resolves, operation ids are unique, path parameters are declared,
/// every operation has responses with descriptions, and so on.
fn check_document(doc: &J) {
    assert_eq!(doc.get("openapi").and_then(J::str), Some("3.1.0"));
    let info = doc.get("info").expect("info");
    assert!(info.get("title").and_then(J::str).is_some());
    assert!(info.get("version").and_then(J::str).is_some());
    let schemas = doc
        .get("components")
        .and_then(|c| c.get("schemas"))
        .expect("components.schemas");
    fn refs(j: &J, out: &mut Vec<String>) {
        match j {
            J::Obj(fs) => {
                for (k, v) in fs {
                    if k == "$ref" {
                        out.push(v.str().unwrap().to_string());
                    } else {
                        refs(v, out);
                    }
                }
            }
            J::Arr(xs) => xs.iter().for_each(|x| refs(x, out)),
            _ => {}
        }
    }
    let mut all = Vec::new();
    refs(doc, &mut all);
    for r in &all {
        let name = r
            .strip_prefix("#/components/schemas/")
            .unwrap_or_else(|| panic!("reference outside components: {}", r));
        assert!(schemas.get(name).is_some(), "dangling reference {}", r);
    }
    // discriminator mappings point at components too
    for (name, s) in schemas.members() {
        assert!(
            name.chars()
                .all(|c| c.is_ascii_alphanumeric() || ".-_".contains(c)),
            "component name {}",
            name
        );
        if let Some(m) = s.get("discriminator").and_then(|d| d.get("mapping")) {
            for (_, target) in m.members() {
                let t = target.str().unwrap();
                assert!(schemas
                    .get(t.trim_start_matches("#/components/schemas/"))
                    .is_some());
            }
        }
    }
    let mut ids = Vec::new();
    for (path, item) in doc.get("paths").unwrap().members() {
        assert!(path.starts_with('/'));
        let vars: Vec<&str> = path
            .split('/')
            .filter_map(|s| s.strip_prefix('{').and_then(|s| s.strip_suffix('}')))
            .collect();
        for (method, op) in item.members() {
            assert!(["get", "put", "post", "delete", "patch"].contains(&method.as_str()));
            let id = op.get("operationId").and_then(J::str).expect("operationId");
            assert!(
                !ids.contains(&id.to_string()),
                "duplicate operationId {}",
                id
            );
            ids.push(id.to_string());
            let params: Vec<&J> = match op.get("parameters") {
                Some(J::Arr(ps)) => ps.iter().collect(),
                _ => vec![],
            };
            for v in &vars {
                assert!(
                    params
                        .iter()
                        .any(|p| p.get("in").and_then(J::str) == Some("path")
                            && p.get("name").and_then(J::str) == Some(v)
                            && p.get("required") == Some(&J::Bool(true))),
                    "{} {}: path parameter {} is not declared",
                    method,
                    path,
                    v
                );
            }
            for p in &params {
                assert!(["path", "query"].contains(&p.get("in").and_then(J::str).unwrap()));
                assert!(p.get("schema").is_some());
            }
            let responses = op.get("responses").expect("responses");
            assert!(!responses.members().is_empty());
            for (code, r) in responses.members() {
                assert!(code == "default" || (code.len() == 3 && code.parse::<u16>().is_ok()));
                assert!(r.get("description").and_then(J::str).is_some());
            }
            if let Some(b) = op.get("requestBody") {
                assert!(b
                    .get("content")
                    .and_then(|c| c.get("application/json"))
                    .and_then(|c| c.get("schema"))
                    .is_some());
            }
        }
    }
}

#[test]
fn openapi_structure() {
    for file in [fixture("api.fwp"), root().join("examples/rest/books.fwp")] {
        let doc = parse_json(&openapi_text(&file));
        check_document(&doc);
    }
    // an external validator, if one happens to be installed
    let validator = Command::new("openapi-spec-validator")
        .arg("--help")
        .output();
    if validator.is_ok_and(|o| o.status.success()) {
        for f in ["api.openapi.json", "books.openapi.json"] {
            let out = Command::new("openapi-spec-validator")
                .arg(fixture(f))
                .output()
                .unwrap();
            assert!(
                out.status.success(),
                "{}: {}{}",
                f,
                String::from_utf8_lossy(&out.stdout),
                String::from_utf8_lossy(&out.stderr)
            );
        }
    }
}

/// The responses of the API validate against the schemas of its document
/// (with Python's `jsonschema`, if it is installed).
#[test]
fn responses_match_schemas() {
    let have = Command::new("python3")
        .args(["-c", "import jsonschema, referencing"])
        .output()
        .is_ok_and(|o| o.status.success());
    if !have {
        eprintln!("skipping: no python3 with jsonschema");
        return;
    }
    let srv = interpreted(&fixture("api.fwp"));
    let dir = temp_dir("schemas");
    let mut cases = String::from("[");
    for (method, target, body, status, _) in API {
        if *method == "HEAD" || target.starts_with("/nothing") || (*status == 405) {
            continue;
        }
        let (st, _, got) = http(&srv.addr, method, target, *body);
        if st == 204 {
            continue;
        }
        let path = target.split('?').next().unwrap();
        // the template of the path
        let template = API_TEMPLATES
            .iter()
            .find(|(m, re)| m.eq_ignore_ascii_case(method) && matches_template(re, path))
            .map(|(_, t)| *t)
            .unwrap_or_else(|| panic!("no template for {}", path));
        if cases.len() > 1 {
            cases.push(',');
        }
        cases.push_str(&format!(
            "[{:?},{:?},{:?},{}]",
            template,
            method.to_ascii_lowercase(),
            st.to_string(),
            got
        ));
    }
    cases.push(']');
    std::fs::write(dir.join("cases.json"), &cases).unwrap();
    std::fs::write(dir.join("doc.json"), openapi_text(&fixture("api.fwp"))).unwrap();
    let script = r##"
import json, sys
from jsonschema import Draft202012Validator
doc = json.load(open(sys.argv[1]))
cases = json.load(open(sys.argv[2]))
def esc(s): return s.replace("~", "~0").replace("/", "~1").replace("{", "%7B").replace("}", "%7D")
for path, method, status, body in cases:
    if status not in doc["paths"][path][method]["responses"]:
        status = "default"
    schema = dict(doc)
    schema["$ref"] = "#/paths/" + esc(path) + "/" + method + "/responses/" + status + "/content/application~1json/schema"
    Draft202012Validator(schema).validate(body)
print(len(cases))
"##;
    let out = Command::new("python3")
        .args(["-c", script])
        .arg(dir.join("doc.json"))
        .arg(dir.join("cases.json"))
        .output()
        .unwrap();
    assert!(
        out.status.success(),
        "{}",
        String::from_utf8_lossy(&out.stderr)
    );
    let _ = std::fs::remove_dir_all(dir);
}

const API_TEMPLATES: &[(&str, &str)] = &[
    ("post", "/echo-item"),
    ("get", "/items/{id}"),
    ("put", "/items/{id}"),
    ("delete", "/items/{id}"),
    ("get", "/items"),
    ("get", "/search/{term}"),
    ("post", "/check"),
    ("post", "/area"),
    ("post", "/teapot"),
    ("post", "/sum/{a}/{b}"),
    ("post", "/big"),
    ("get", "/ping"),
    ("get", "/tags"),
    ("post", "/maybe"),
];

fn matches_template(template: &str, path: &str) -> bool {
    let t: Vec<&str> = template.split('/').collect();
    let p: Vec<&str> = path.split('/').collect();
    t.len() == p.len() && t.iter().zip(&p).all(|(a, b)| a.starts_with('{') || a == b)
}

// ------------------------------------------------------------- clients

fn import(spec: &Path, out: &Path) -> String {
    let o = Command::new(fwp())
        .args(["openapi", "--import"])
        .arg(spec)
        .arg("-o")
        .arg(out)
        .output()
        .unwrap();
    assert!(o.status.success(), "{}", String::from_utf8_lossy(&o.stderr));
    String::from_utf8(o.stderr).unwrap()
}

#[test]
fn client_golden() {
    let dir = temp_dir("client");
    // from the documents as `fwp openapi` prints them now
    let api_doc = dir.join("api.json");
    std::fs::write(&api_doc, openapi_text(&fixture("api.fwp"))).unwrap();
    let books_doc = dir.join("books.json");
    std::fs::write(
        &books_doc,
        openapi_text(&root().join("examples/rest/books.fwp")),
    )
    .unwrap();
    let out = dir.join("apiclient.fwp");
    let warnings = import(&api_doc, &out);
    assert_eq!(warnings, "");
    golden(
        &fixture("apiclient.fwp"),
        &std::fs::read_to_string(&out).unwrap(),
    );
    // the client of the example, from the example's document
    let out = dir.join("bookclient.fwp");
    assert_eq!(import(&books_doc, &out), "");
    golden(
        &root().join("examples/rest/bookclient.fwp"),
        &std::fs::read_to_string(&out).unwrap(),
    );
    let out = dir.join("petstore.fwp");
    let warnings = import(&fixture("petstore.json"), &out);
    golden(
        &fixture("petstore.fwp"),
        &std::fs::read_to_string(&out).unwrap(),
    );
    let spec = fixture("petstore.json").display().to_string();
    let expected: String = [
        "GET /pet/{petId}: the header parameter `X-Trace` is left out",
        "DELETE /pet/{petId}: the required header parameter `api_key` is not supported; it is left out",
        "POST /store/order: its request body is not JSON (`application/json`); it is left out",
        "schema `Session`: `allOf` is not supported; it is a `Json` value",
        "schema `Session`: a `oneOf` that is not a variant type; it is a `Json` value",
    ]
    .iter()
    .map(|l| format!("fwp openapi: {}: {}\n", spec, l))
    .collect();
    assert_eq!(warnings, expected);
    // the generated module type-checks
    std::fs::write(dir.join("main.fwp"), "import petstore\n\nmain = ()\n").unwrap();
    let o = Command::new(fwp())
        .arg("check")
        .arg(dir.join("main.fwp"))
        .output()
        .unwrap();
    assert!(o.status.success(), "{}", String::from_utf8_lossy(&o.stderr));
    let _ = std::fs::remove_dir_all(dir);
}

#[test]
fn import_errors() {
    let dir = temp_dir("import-errors");
    for (text, msg) in [
        (
            "{\"swagger\": \"2.0\"}",
            "Swagger 2.0 documents are not supported",
        ),
        ("openapi: 3.1.0\n", "YAML is not supported"),
        ("{\"info\": {}}", "not an OpenAPI 3 document"),
    ] {
        let f = dir.join("spec.json");
        std::fs::write(&f, text).unwrap();
        let o = Command::new(fwp())
            .args(["openapi", "--import"])
            .arg(&f)
            .output()
            .unwrap();
        assert_eq!(o.status.code(), Some(1));
        let err = String::from_utf8_lossy(&o.stderr);
        assert!(err.contains(msg), "{}", err);
    }
    let _ = std::fs::remove_dir_all(dir);
}

/// A client generated from a server's own document calls it: the
/// interpreted client against the interpreted server, the native client
/// against the native server.
#[test]
fn client_round_trip() {
    let expected = std::fs::read_to_string(fixture("roundtrip.out")).unwrap_or_default();
    let dir = temp_dir("roundtrip");
    // the client, generated from the document the server serves
    let srv = interpreted(&fixture("api.fwp"));
    let (_, _, doc) = http(&srv.addr, "GET", "/openapi.json", None);
    std::fs::write(dir.join("doc.json"), &doc).unwrap();
    import(&dir.join("doc.json"), &dir.join("apiclient.fwp"));
    assert_eq!(
        std::fs::read_to_string(dir.join("apiclient.fwp")).unwrap(),
        std::fs::read_to_string(fixture("apiclient.fwp")).unwrap()
    );
    std::fs::copy(fixture("roundtrip.fwp"), dir.join("roundtrip.fwp")).unwrap();
    let run = Command::new(fwp())
        .arg("run")
        .arg(dir.join("roundtrip.fwp"))
        .env("FWP_TEST_BASE", format!("http://{}", srv.addr))
        .output()
        .unwrap();
    let got = String::from_utf8_lossy(&run.stdout).into_owned();
    assert!(
        run.status.success(),
        "{}",
        String::from_utf8_lossy(&run.stderr)
    );
    if bless() {
        std::fs::write(fixture("roundtrip.out"), &got).unwrap();
    } else {
        assert_eq!(got, expected);
    }
    drop(srv);
    if have_cc() {
        let srv = native(&fixture("api.fwp"), &dir);
        let exe = dir.join("roundtrip");
        let b = Command::new(fwp())
            .arg("build")
            .arg(dir.join("roundtrip.fwp"))
            .args(["-O1", "-o"])
            .arg(&exe)
            .output()
            .unwrap();
        assert!(b.status.success(), "{}", String::from_utf8_lossy(&b.stderr));
        let run = Command::new(&exe)
            .env("FWP_TEST_BASE", format!("http://{}", srv.addr))
            .output()
            .unwrap();
        assert!(run.status.success());
        assert_eq!(String::from_utf8_lossy(&run.stdout), got);
    }
    let _ = std::fs::remove_dir_all(dir);
}

// ------------------------------------------------------------- errors

#[test]
fn endpoint_errors() {
    let dir = temp_dir("errors");
    let cases: &[(&str, &str)] = &[
        (
            "# route: FETCH /x\nexport f : I64 -> I64\nf = id\n",
            "unknown method `FETCH` in `# route:`",
        ),
        (
            "# route: GET items\nexport f : I64 -> I64\nf = id\n",
            "the path `items` in `# route:` must start with `/`",
        ),
        (
            "# route: GET /items/x{id}\nexport f : I64 -> I64\nf = id\n",
            "invalid segment `x{id}`",
        ),
        (
            "export f : () -> U64 ! {Random}\nf = random.u64\n",
            "`f` performs `Random`, which REST endpoints cannot",
        ),
        (
            "export f : (I64 -> I64) -> I64\nf = apply 1\n",
            "values of type `I64 -> I64` cannot be sent as JSON",
        ),
        (
            "# route: GET /a\nexport f : I64 -> I64\nf = id\n# route: GET /a\nexport g : I64 -> I64\ng = id\n",
            "`f` and `g` have the same route `GET /a`",
        ),
        (
            "# route: GET /a/{x}\nexport f : I64 -> (I64, I64) -> I64\nf = curry .0\n",
            "the parameter `arg2` is a query parameter of `GET /a/{x}`",
        ),
        (
            "# route: GET /a/{id}\n# args: x\nexport f : I64 -> I64\nf = id\n",
            "`{id}` in the route of `f` names no parameter (they are x)",
        ),
        (
            "# error: Gone 410\nexport f : I64 -> I64 ! {Error[String]}\nf = id\n",
            "`# error:` names `Gone`, which is not a variant of its error type",
        ),
        (
            "# status: 99\nexport f : I64 -> I64\nf = id\n",
            "invalid `# status:` line `99`",
        ),
        ("f : I64 -> I64\nf = id\n", "the program exports no functions to serve"),
        (
            "# route: GET /openapi.json\nexport f : () -> I64\nf = const 1\n",
            "`GET /openapi.json` is the route of the OpenAPI document",
        ),
    ];
    for (i, (src, msg)) in cases.iter().enumerate() {
        let f = dir.join(format!("e{}.fwp", i));
        std::fs::write(&f, src).unwrap();
        for cmd in [&["openapi"][..], &["build", "--rest", "--emit-c"][..]] {
            let o = Command::new(fwp())
                .args(cmd)
                .arg(&f)
                .current_dir(&dir)
                .output()
                .unwrap();
            let err = String::from_utf8_lossy(&o.stderr);
            assert_eq!(o.status.code(), Some(1), "{}: {}", src, err);
            assert!(
                err.contains(msg),
                "{}\nexpected: {}\ngot: {}",
                src,
                msg,
                err
            );
        }
    }
    // WebAssembly has no sockets
    let f = fixture("api.fwp");
    let o = Command::new(fwp())
        .arg("build")
        .arg(&f)
        .args(["--rest", "--target", "wasm32-wasi"])
        .output()
        .unwrap();
    assert_eq!(o.status.code(), Some(2));
    assert!(String::from_utf8_lossy(&o.stderr).contains("WebAssembly targets have no sockets"));
    let _ = std::fs::remove_dir_all(dir);
}

/// The annotations of REST endpoints are not part of a command's help.
#[test]
fn cli_help_without_routes() {
    let o = Command::new(fwp())
        .args(["exec", "--cli"])
        .arg(root().join("examples/rest/books.fwp"))
        .args(["help", "quote-order"])
        .output()
        .unwrap();
    let help = String::from_utf8_lossy(&o.stdout);
    assert!(o.status.success(), "{}", String::from_utf8_lossy(&o.stderr));
    assert!(help.contains("Quote an order"), "{}", help);
    assert!(
        !help.contains("route:") && !help.contains("error:"),
        "{}",
        help
    );
    let o = Command::new(fwp())
        .args(["exec", "--cli"])
        .arg(root().join("examples/rest/books.fwp"))
        .args(["book", "3"])
        .output()
        .unwrap();
    assert!(String::from_utf8_lossy(&o.stdout).contains("Gödel, Escher, Bach"));
}

#[test]
fn server_command_line() {
    // --help and --openapi need no socket
    let o = Command::new(fwp())
        .args(["serve", "--rest"])
        .arg(fixture("api.fwp"))
        .arg("--openapi")
        .output()
        .unwrap();
    assert!(o.status.success());
    assert_eq!(
        String::from_utf8_lossy(&o.stdout),
        openapi_text(&fixture("api.fwp"))
    );
    let o = Command::new(fwp())
        .args(["serve", "--rest"])
        .arg(fixture("api.fwp"))
        .arg("--bogus")
        .output()
        .unwrap();
    assert_eq!(o.status.code(), Some(2));
    assert!(String::from_utf8_lossy(&o.stderr).contains("unknown option `--bogus`"));
}
