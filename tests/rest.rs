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
    http_with(addr, method, target, &[], body)
}

/// `http` with request headers.
fn http_with(
    addr: &str,
    method: &str,
    target: &str,
    extra: &[(&str, &str)],
    body: Option<&str>,
) -> (u16, Vec<(String, String)>, String) {
    let mut conn = TcpStream::connect(addr).unwrap();
    conn.set_read_timeout(Some(Duration::from_secs(30)))
        .unwrap();
    let mut req = format!(
        "{} {} HTTP/1.1\r\nhost: test\r\nconnection: close\r\n",
        method, target
    );
    for (k, v) in extra {
        req.push_str(&format!("{}: {}\r\n", k, v));
    }
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
    let token = [("authorization", "Bearer clerk-token")];
    let (st, _, b) = http_with(
        a,
        "POST",
        "/quotes",
        &token,
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
        assert_eq!(
            http_with(a, "POST", "/quotes", &token, Some(body)).0,
            status,
            "{}",
            body
        );
    }
    // without a token, or from a browser page
    let (st, _, b) = http(a, "POST", "/quotes", Some(r#"{"lines":[]}"#));
    assert_eq!(
        (st, b.as_str()),
        (401, r#"{"error":"missing credentials"}"#)
    );
    let (st, h, _) = http_with(
        a,
        "OPTIONS",
        "/quotes",
        &[
            ("origin", "http://localhost:3000"),
            ("access-control-request-method", "POST"),
            (
                "access-control-request-headers",
                "authorization, content-type",
            ),
        ],
        None,
    );
    assert_eq!(st, 204);
    assert!(h
        .iter()
        .any(|(k, v)| k == "access-control-allow-headers" && v == "Content-Type, Authorization"));
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

/// A request to `tests/rest/secure.fwp`: method, target, headers, body;
/// the expected status, body, and headers the response must have.
type Case = (
    &'static str,
    &'static str,
    &'static [(&'static str, &'static str)],
    Option<&'static str>,
    u16,
    &'static str,
    &'static [(&'static str, &'static str)],
);

const SECURE: &[Case] = &[
    // authentication: bearer tokens and API keys, file-wide
    (
        "GET",
        "/me",
        &[],
        None,
        401,
        r#"{"error":"missing credentials"}"#,
        &[("www-authenticate", "Bearer")],
    ),
    (
        "GET",
        "/me",
        &[("authorization", "Bearer alice")],
        None,
        200,
        r#"{"name":"alice","admin":true}"#,
        &[],
    ),
    (
        "GET",
        "/me",
        &[("authorization", "bearer  bob ")],
        None,
        200,
        r#"{"name":"bob","admin":false}"#,
        &[],
    ),
    (
        "GET",
        "/me",
        &[("x-api-key", "bob")],
        None,
        200,
        r#"{"name":"bob","admin":false}"#,
        &[],
    ),
    (
        "GET",
        "/me",
        &[("authorization", "Bearer eve")],
        None,
        401,
        r#"{"error":"unknown token"}"#,
        &[],
    ),
    (
        "GET",
        "/me",
        &[("authorization", "Basic YWxpY2U6eA==")],
        None,
        401,
        r#"{"error":"missing credentials"}"#,
        &[],
    ),
    ("GET", "/health", &[], None, 200, r#""ok""#, &[]),
    // replies: statuses and headers of the function's choosing
    (
        "POST",
        "/items",
        &[("authorization", "Bearer alice")],
        Some(r#"{"id":7,"name":"x"}"#),
        201,
        r#"{"id":7,"name":"x"}"#,
        &[("location", "/items/7")],
    ),
    (
        "GET",
        "/items/1",
        &[],
        None,
        301,
        r#"{"id":2,"name":"moved"}"#,
        &[("location", "/items/2")],
    ),
    (
        "GET",
        "/items/3",
        &[],
        None,
        200,
        r#"{"id":3,"name":"thing"}"#,
        &[],
    ),
    (
        "DELETE",
        "/items/3",
        &[("authorization", "Bearer alice")],
        None,
        204,
        "",
        &[],
    ),
    (
        "DELETE",
        "/items/3",
        &[("x-api-key", "bob")],
        None,
        403,
        r#"{"error":{"status":403,"message":"admins only"}}"#,
        &[],
    ),
    // headers and cookies: options record fields and bound parameters
    (
        "GET",
        "/seen?limit=3",
        &[("x-trace-id", "t1"), ("cookie", "a=1; theme=\"dark\"")],
        None,
        200,
        r#""Seen {limit = Some 3, theme = Some \"dark\", trace = Some \"t1\"}""#,
        &[],
    ),
    (
        "GET",
        "/seen",
        &[],
        None,
        200,
        r#""Seen {limit = None, theme = None, trace = None}""#,
        &[],
    ),
    (
        "GET",
        "/hello",
        &[("X-Name", "Ann"), ("Cookie", "x=y;session=abc")],
        None,
        200,
        r#""hello Ann (abc)""#,
        &[],
    ),
    (
        "GET",
        "/hello",
        &[],
        None,
        400,
        r#"{"error":"missing header X-Name"}"#,
        &[],
    ),
    // the request itself
    (
        "GET",
        "/echo-request",
        &[("x-test", "yes")],
        None,
        200,
        r#""GET yes""#,
        &[],
    ),
    // a time limit
    (
        "GET",
        "/slow",
        &[],
        None,
        503,
        r#"{"error":"request timed out"}"#,
        &[],
    ),
    // CORS: a preflight request, and a request, from an allowed origin
    (
        "OPTIONS",
        "/items",
        &[
            ("origin", "https://app.example"),
            ("access-control-request-method", "POST"),
        ],
        None,
        204,
        "",
        &[
            ("access-control-allow-origin", "https://app.example"),
            ("access-control-allow-methods", "GET, POST, DELETE, HEAD"),
            (
                "access-control-allow-headers",
                "Content-Type, Authorization, X-API-Key, X-Trace-Id, X-Name",
            ),
            ("access-control-allow-credentials", "true"),
            ("access-control-max-age", "600"),
        ],
    ),
    (
        "GET",
        "/health",
        &[("origin", "https://app.example")],
        None,
        200,
        r#""ok""#,
        &[
            ("access-control-allow-origin", "https://app.example"),
            ("access-control-expose-headers", "Location"),
            ("vary", "origin"),
        ],
    ),
    // from other origins: no CORS headers, and no preflight answer
    (
        "OPTIONS",
        "/items",
        &[
            ("origin", "https://evil.example"),
            ("access-control-request-method", "POST"),
        ],
        None,
        405,
        r#"{"error":"method not allowed"}"#,
        &[],
    ),
];

fn exercise_secure(srv: &Server) {
    for (method, target, headers, body, status, expected, want) in SECURE {
        let (st, got_headers, got) = http_with(&srv.addr, method, target, headers, *body);
        assert_eq!(
            (st, got.as_str()),
            (*status, *expected),
            "{} {} {:?}",
            method,
            target,
            headers
        );
        for (k, v) in *want {
            assert!(
                got_headers.iter().any(|(gk, gv)| gk == k && gv == v),
                "{} {}: no `{}: {}` in {:?}",
                method,
                target,
                k,
                v,
                got_headers
            );
        }
        if headers.iter().all(|(k, _)| *k != "origin") {
            assert!(
                !got_headers
                    .iter()
                    .any(|(k, _)| k.starts_with("access-control-")),
                "{} {}: {:?}",
                method,
                target,
                got_headers
            );
        }
    }
    // the server's own errors are JSON too
    let mut conn = TcpStream::connect(&srv.addr).unwrap();
    conn.set_read_timeout(Some(Duration::from_secs(30)))
        .unwrap();
    conn.write_all(b"NONSENSE\r\n\r\n").unwrap();
    let mut raw = String::new();
    let _ = conn.read_to_string(&mut raw);
    assert!(raw.starts_with("HTTP/1.1 400"), "{}", raw);
    assert!(raw.contains("content-type: application/json"), "{}", raw);
    assert!(
        raw.ends_with(r#"{"error":"invalid request line"}"#),
        "{}",
        raw
    );
    // the page of the document
    let (st, headers, page) = http(&srv.addr, "GET", "/docs", None);
    assert_eq!(st, 200);
    assert!(headers
        .iter()
        .any(|(k, v)| k == "content-type" && v.starts_with("text/html")));
    assert!(page.starts_with("<!doctype html>"), "{}", page);
    assert!(page.contains("<code>/items/{id}</code>"), "{}", page);
    assert!(!page.contains("<script"), "{}", page);
}

#[test]
fn secure_interpreted() {
    exercise_secure(&interpreted(&fixture("secure.fwp")));
}

#[test]
fn secure_native() {
    if !have_cc() {
        eprintln!("skipping: no C compiler");
        return;
    }
    let dir = temp_dir("secure-native");
    exercise_secure(&native(&fixture("secure.fwp"), &dir));
    let _ = std::fs::remove_dir_all(dir);
}

/// `--cors` and `FWP_REST_CORS` replace the origins of `# cors:`.
#[test]
fn cors_from_the_command_line() {
    let mut cmd = Command::new(fwp());
    cmd.args(["serve", "--rest"])
        .arg(fixture("secure.fwp"))
        .args([
            "--listen",
            "127.0.0.1:0",
            "--cors",
            "https://a.example, https://b.example",
        ]);
    let srv = start(cmd);
    let allowed = |origin: &str| {
        http_with(&srv.addr, "GET", "/health", &[("origin", origin)], None)
            .1
            .iter()
            .any(|(k, v)| k == "access-control-allow-origin" && v == origin)
    };
    assert!(allowed("https://b.example"));
    assert!(!allowed("https://app.example"));
    drop(srv);
    let mut cmd = Command::new(fwp());
    cmd.args(["serve", "--rest"])
        .arg(fixture("api.fwp"))
        .args(["--listen", "127.0.0.1:0"])
        .env("FWP_REST_CORS", "*");
    let srv = start(cmd);
    let (_, headers, _) = http_with(
        &srv.addr,
        "GET",
        "/ping",
        &[("origin", "https://x.example")],
        None,
    );
    assert!(headers
        .iter()
        .any(|(k, v)| k == "access-control-allow-origin" && v == "https://x.example"));
    assert!(!headers
        .iter()
        .any(|(k, _)| k == "access-control-allow-credentials"));
}

#[test]
fn openapi_yaml() {
    let o = Command::new(fwp())
        .args(["openapi", "--yaml"])
        .arg(fixture("secure.fwp"))
        .output()
        .unwrap();
    assert!(o.status.success(), "{}", String::from_utf8_lossy(&o.stderr));
    let yaml = String::from_utf8(o.stdout).unwrap();
    golden(&fixture("secure.openapi.yaml"), &yaml);
    // a YAML reader, if one is installed, reads the JSON document
    let have = Command::new("python3")
        .args(["-c", "import yaml"])
        .output()
        .is_ok_and(|o| o.status.success());
    if have {
        let dir = temp_dir("yaml");
        std::fs::write(dir.join("doc.yaml"), &yaml).unwrap();
        std::fs::write(dir.join("doc.json"), openapi_text(&fixture("secure.fwp"))).unwrap();
        let o = Command::new("python3")
            .args([
                "-c",
                "import json, sys, yaml; assert yaml.safe_load(open(sys.argv[1])) == json.load(open(sys.argv[2]))",
            ])
            .arg(dir.join("doc.yaml"))
            .arg(dir.join("doc.json"))
            .output()
            .unwrap();
        assert!(o.status.success(), "{}", String::from_utf8_lossy(&o.stderr));
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
    golden(
        &fixture("secure.openapi.json"),
        &openapi_text(&fixture("secure.fwp")),
    );
    golden(
        &fixture("forms.openapi.json"),
        &openapi_text(&fixture("forms.fwp")),
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
                assert!(["path", "query", "header", "cookie"]
                    .contains(&p.get("in").and_then(J::str).unwrap()));
                assert!(p.get("schema").is_some());
            }
            let responses = op.get("responses").expect("responses");
            assert!(!responses.members().is_empty());
            for (code, r) in responses.members() {
                assert!(code == "default" || (code.len() == 3 && code.parse::<u16>().is_ok()));
                assert!(r.get("description").and_then(J::str).is_some());
            }
            if let Some(b) = op.get("requestBody") {
                let content = b.get("content").expect("content");
                assert!(!content.members().is_empty());
                for (_, c) in content.members() {
                    assert!(c.get("schema").is_some());
                }
            }
        }
    }
}

#[test]
fn openapi_structure() {
    for file in [
        fixture("api.fwp"),
        fixture("secure.fwp"),
        fixture("forms.fwp"),
        root().join("examples/rest/books.fwp"),
    ] {
        let doc = parse_json(&openapi_text(&file));
        check_document(&doc);
    }
    // an external validator, if one happens to be installed
    let validator = Command::new("openapi-spec-validator")
        .arg("--help")
        .output();
    if validator.is_ok_and(|o| o.status.success()) {
        for f in [
            "api.openapi.json",
            "books.openapi.json",
            "secure.openapi.json",
        ] {
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
        "POST /store/order: its request body is neither JSON (`application/json`), a form (`application/x-www-form-urlencoded`) nor `multipart/form-data`; it is left out",
        "POST /user/logout: its security scheme `basic` is not supported (bearer tokens and API keys are); it is left out",
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
            "{\"swagger\": \"1.2\"}",
            "Swagger 1.2 is not supported (Swagger 2.0 and OpenAPI 3.0 and 3.1 are)",
        ),
        (
            "openapi: 3.1.0\n  paths: {}\n",
            "not a JSON or YAML document (line 2",
        ),
        ("{\"info\": {}", "not a JSON document"),
        ("info: {}\n", "not an OpenAPI document"),
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

/// A client generated from the document of `tests/rest/secure.fwp` sends
/// tokens, headers and cookies, and reads replies.
#[test]
fn secure_client_round_trip() {
    let dir = temp_dir("secure-roundtrip");
    let srv = interpreted(&fixture("secure.fwp"));
    let (_, _, doc) = http(&srv.addr, "GET", "/openapi.json", None);
    std::fs::write(dir.join("doc.json"), &doc).unwrap();
    assert_eq!(
        import(&dir.join("doc.json"), &dir.join("secureclient.fwp")),
        ""
    );
    golden(
        &fixture("secureclient.fwp"),
        &std::fs::read_to_string(dir.join("secureclient.fwp")).unwrap(),
    );
    std::fs::copy(
        fixture("secureroundtrip.fwp"),
        dir.join("secureroundtrip.fwp"),
    )
    .unwrap();
    let run = Command::new(fwp())
        .arg("run")
        .arg(dir.join("secureroundtrip.fwp"))
        .env("FWP_TEST_BASE", format!("http://{}", srv.addr))
        .output()
        .unwrap();
    assert!(
        run.status.success(),
        "{}",
        String::from_utf8_lossy(&run.stderr)
    );
    let got = String::from_utf8_lossy(&run.stdout).into_owned();
    golden(&fixture("secureroundtrip.out"), &got);
    drop(srv);
    if have_cc() {
        let srv = native(&fixture("secure.fwp"), &dir);
        let exe = dir.join("secureroundtrip");
        let b = Command::new(fwp())
            .arg("build")
            .arg(dir.join("secureroundtrip.fwp"))
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
            "`GET /openapi.json` is a route of the server",
        ),
        (
            "# auth: bearer\nexport f : I64 -> I64\nf = id\n",
            "`f` needs authentication (`# auth:`), but the program has no `authenticate",
        ),
        (
            "# auth: basic\nexport f : I64 -> I64\nf = id\n",
            "invalid `# auth: basic`",
        ),
        (
            "U = { n: String }\nauthenticate : String -> Result[U, String]\nauthenticate = make U { n = id } | Ok\n# auth: bearer\nexport f : U -> I64\nf = const 1\n# route: GET /g\nexport g : U -> I64\ng = const 2\n",
            "`g` takes the principal (`U`) but needs no authentication",
        ),
        (
            "authenticate : String -> Option[I64]\nauthenticate = parse-int\n# auth: bearer\nexport f : I64 -> I64\nf = id\n",
            "`authenticate` must have type `String -> Result[P, String]`",
        ),
        (
            "# header: X-Id -> id\n# args: x\nexport f : I64 -> I64\nf = id\n",
            "the header `X-Id` of `f` binds `id`, which names no parameter (they are x)",
        ),
        (
            "# route: GET /f\n# cookie: c\nexport f : List[String] -> I64\nf = length\n",
            "the cookie `c` has type `List[String]`",
        ),
        (
            "# status: 200, 201\nexport f : I64 -> I64\nf = id\n",
            "only a `RestReply` result chooses its status",
        ),
        (
            "# timeout: soon\nexport f : I64 -> I64\nf = id\n",
            "invalid `# timeout:` line `soon`",
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

// ------------------------------------------- forms, files and formats

/// One request with raw headers and body: the status, the headers and the
/// body of the response.
fn http_raw(
    addr: &str,
    method: &str,
    target: &str,
    headers: &[(&str, &str)],
    body: &[u8],
) -> (u16, Vec<(String, String)>, String) {
    let mut conn = TcpStream::connect(addr).unwrap();
    conn.set_read_timeout(Some(Duration::from_secs(30)))
        .unwrap();
    let mut req = format!(
        "{} {} HTTP/1.1\r\nhost: test\r\nconnection: close\r\ncontent-length: {}\r\n",
        method,
        target,
        body.len()
    );
    for (k, v) in headers {
        req.push_str(&format!("{}: {}\r\n", k, v));
    }
    req.push_str("\r\n");
    let mut bytes = req.into_bytes();
    bytes.extend_from_slice(body);
    conn.write_all(&bytes).unwrap();
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
    (status, headers, rest.to_string())
}

/// A `multipart/form-data` body with the boundary `XyZ`: (name, file
/// name, content type, content) per part.
/// A part: its name, file name, content type and content.
type PartSpec<'a> = (&'a str, Option<&'a str>, Option<&'a str>, &'a [u8]);

fn multipart(parts: &[PartSpec]) -> Vec<u8> {
    let mut out = Vec::new();
    // a preamble, which is ignored
    out.extend_from_slice(b"preamble\r\n");
    for (name, file, ct, content) in parts {
        out.extend_from_slice(b"--XyZ\r\n");
        let mut d = format!("Content-Disposition: form-data; name=\"{}\"", name);
        if let Some(f) = file {
            d.push_str(&format!("; filename=\"{}\"", f));
        }
        out.extend_from_slice(d.as_bytes());
        out.extend_from_slice(b"\r\n");
        if let Some(c) = ct {
            out.extend_from_slice(format!("Content-Type: {}\r\n", c).as_bytes());
        }
        out.extend_from_slice(b"\r\n");
        out.extend_from_slice(content);
        out.extend_from_slice(b"\r\n");
    }
    out.extend_from_slice(b"--XyZ--\r\nepilogue");
    out
}

/// Requests to `tests/rest/forms.fwp`: the content type of the body,
/// the body, the Accept header, and the expected status, content type
/// and body.
/// A request: method, target, content type, body, Accept; then the
/// expected status, content type and body.
type FormCase = (
    &'static str,
    &'static str,
    Option<&'static str>,
    Vec<u8>,
    Option<&'static str>,
    u16,
    &'static str,
    &'static str,
);

fn forms_requests() -> Vec<FormCase> {
    let json = Some("application/json");
    let form = Some("application/x-www-form-urlencoded");
    let multi = Some("multipart/form-data; boundary=\"XyZ\"");
    vec![
        // a body as JSON, a form and multipart/form-data
        (
            "POST",
            "/profiles",
            json,
            br#"{"name":"ann","tags":["a"],"admin":true}"#.to_vec(),
            None,
            200,
            "application/json",
            r#"{"name":"ann","tags":["a"],"admin":true}"#,
        ),
        (
            "POST",
            "/profiles",
            form,
            b"name=b%C3%B6b&age=42&tags=x&tags=y+z&admin=on".to_vec(),
            None,
            200,
            "application/json",
            r#"{"name":"böb","age":42,"tags":["x","y z"],"admin":true}"#,
        ),
        // an empty optional field is absent, a missing switch false
        (
            "POST",
            "/profiles",
            form,
            b"name=c&age=".to_vec(),
            None,
            200,
            "application/json",
            r#"{"name":"c","tags":[],"admin":false}"#,
        ),
        (
            "POST",
            "/profiles",
            form,
            b"age=x".to_vec(),
            None,
            400,
            "application/json",
            r#"{"error":"$.name: required field is missing"}"#,
        ),
        (
            "POST",
            "/profiles",
            multi,
            multipart(&[
                ("name", None, None, b"dee"),
                ("tags", None, None, b"t1"),
                ("tags", None, None, b"t2"),
                ("admin", None, None, b"false"),
                (
                    "avatar",
                    Some("me.png"),
                    Some("image/png"),
                    &[137, 80, 78, 71, 13, 10, 0],
                ),
            ]),
            None,
            200,
            "application/json",
            r#"{"name":"dee","tags":["t1","t2"],"admin":false,"avatar":"me.png: 7 bytes"}"#,
        ),
        // a media type the endpoint does not accept
        (
            "POST",
            "/profiles",
            Some("text/plain"),
            b"name".to_vec(),
            None,
            415,
            "application/json",
            r#"{"error":"unsupported content type text/plain (it accepts application/json, application/x-www-form-urlencoded, multipart/form-data)"}"#,
        ),
        (
            "POST",
            "/files",
            json,
            b"{}".to_vec(),
            None,
            415,
            "application/json",
            r#"{"error":"unsupported content type application/json (it accepts multipart/form-data)"}"#,
        ),
        // files, with a boundary in the content and binary bytes
        (
            "POST",
            "/files",
            multi,
            multipart(&[
                ("title", None, None, b"t"),
                (
                    "files",
                    Some("a.txt"),
                    Some("text/plain"),
                    b"line\r\n-XyZ--XyZ\r\n",
                ),
                ("data", Some("d.bin"), None, b"raw"),
                (
                    "files",
                    Some("b.bin"),
                    Some("application/octet-stream"),
                    &[0, 255, 13, 10],
                ),
            ]),
            None,
            201,
            "application/json",
            r#"[{"filename":"a.txt","content-type":"text/plain","size":17,"text":"line\r\n-X"},{"filename":"b.bin","content-type":"application/octet-stream","size":4,"text":"?"},{"filename":"data","content-type":"","size":3,"text":"raw"}]"#,
        ),
        (
            "POST",
            "/files",
            Some("multipart/form-data"),
            b"x".to_vec(),
            None,
            400,
            "application/json",
            r#"{"error":"invalid multipart/form-data body"}"#,
        ),
        // a form of an enum and numbers
        (
            "PUT",
            "/shelves/7",
            form,
            b"kind=Poetry&size=3&label=odes".to_vec(),
            None,
            200,
            "application/json",
            r#"{"id":7,"kind":"Poetry","size":3,"label":"odes"}"#,
        ),
        (
            "PUT",
            "/shelves/7",
            form,
            b"kind=Poetry&size=x".to_vec(),
            None,
            400,
            "application/json",
            r#"{"error":"$.size: expected an integer, got \"x\""}"#,
        ),
        // responses as JSON, text or CSV
        (
            "GET",
            "/books",
            None,
            vec![],
            None,
            200,
            "application/json",
            r#"[{"id":1,"title":"Dune","price":9.5},{"id":2,"title":"Odes, \"selected\"","price":12.0,"note":"used"}]"#,
        ),
        (
            "GET",
            "/books",
            None,
            vec![],
            Some("text/csv"),
            200,
            "text/csv; charset=utf-8",
            "id,title,price,note\n1,Dune,9.5,\n2,\"Odes, \"\"selected\"\"\",12,used\n",
        ),
        (
            "GET",
            "/books",
            None,
            vec![],
            Some("application/json;q=0.4, text/*;q=0.5"),
            200,
            "text/plain; charset=utf-8",
            r#"[Book {id = 1, note = None, price = 9.5, title = "Dune"}, Book {id = 2, note = Some "used", price = 12.0, title = "Odes, \"selected\""}]"#,
        ),
        (
            "GET",
            "/books",
            None,
            vec![],
            Some("text/csv;q=0, image/png"),
            406,
            "application/json",
            r#"{"error":"not acceptable: the response is application/json, text/plain, text/csv"}"#,
        ),
        (
            "GET",
            "/books/2",
            None,
            vec![],
            None,
            200,
            "text/plain; charset=utf-8",
            r#"Book {id = 2, note = Some "used", price = 12.0, title = "Odes, \"selected\""}"#,
        ),
        (
            "GET",
            "/books/2",
            None,
            vec![],
            Some("*/*;q=0.1, application/json"),
            200,
            "application/json",
            r#"{"id":2,"title":"Odes, \"selected\"","price":12.0,"note":"used"}"#,
        ),
        // errors stay JSON
        (
            "GET",
            "/books/9",
            None,
            vec![],
            Some("text/plain"),
            404,
            "application/json",
            r#"{"error":"not found"}"#,
        ),
        (
            "GET",
            "/halves/3",
            None,
            vec![],
            Some("text/plain"),
            500,
            "application/json",
            r#"{"error":"odd"}"#,
        ),
        (
            "GET",
            "/halves/4",
            None,
            vec![],
            Some("text/plain"),
            200,
            "text/plain; charset=utf-8",
            "2",
        ),
        (
            "POST",
            "/notes",
            json,
            br#""hi""#.to_vec(),
            None,
            201,
            "text/plain; charset=utf-8",
            "hi!",
        ),
        (
            "POST",
            "/notes",
            json,
            br#""hi""#.to_vec(),
            Some("application/json"),
            201,
            "application/json",
            r#""hi!""#,
        ),
    ]
}

fn exercise_forms(srv: &Server) {
    for (method, target, ct, body, accept, status, rct, rbody) in forms_requests() {
        let mut headers = Vec::new();
        if let Some(c) = ct {
            headers.push(("content-type", c));
        }
        if let Some(a) = accept {
            headers.push(("accept", a));
        }
        let (st, hs, b) = http_raw(&srv.addr, method, target, &headers, &body);
        let what = format!("{} {} ({:?}, accept {:?})", method, target, ct, accept);
        assert_eq!((st, b.as_str()), (status, rbody), "{}", what);
        let got_ct = hs
            .iter()
            .find(|(k, _)| k == "content-type")
            .map(|(_, v)| v.as_str());
        assert_eq!(got_ct, Some(rct), "{}", what);
        if target == "/notes" {
            assert!(hs.iter().any(|(k, v)| k == "location" && v == "/notes/1"));
        }
    }
    // with curl's forms, when it is installed
    if Command::new("curl").arg("--version").output().is_ok() {
        let dir = temp_dir(&format!("curl-{}", srv.addr.replace([':', '.'], "-")));
        std::fs::write(dir.join("a b.txt"), "curl file\n").unwrap();
        let url = format!("http://{}", srv.addr);
        let curl = |args: &[&str]| {
            let o = Command::new("curl")
                .args(["-s", "--max-time", "30"])
                .args(args)
                .current_dir(&dir)
                .output()
                .unwrap();
            String::from_utf8_lossy(&o.stdout).into_owned()
        };
        assert_eq!(
            curl(&[
                "-F",
                "name=eve",
                "-F",
                "tags=1",
                "-F",
                "avatar=@a b.txt;type=text/plain",
                &format!("{}/profiles", url)
            ]),
            r#"{"name":"eve","tags":["1"],"admin":false,"avatar":"a b.txt: 10 bytes"}"#
        );
        assert_eq!(
            curl(&[
                "-d",
                "name=fay",
                "--data-urlencode",
                "tags=a&b",
                &format!("{}/profiles", url)
            ]),
            r#"{"name":"fay","tags":["a&b"],"admin":false}"#
        );
        assert_eq!(
            curl(&[
                "-F",
                "title=x",
                "-F",
                "files=@a b.txt",
                "-F",
                "files=@a b.txt;filename=c.txt",
                &format!("{}/files", url)
            ]),
            r#"[{"filename":"a b.txt","content-type":"text/plain","size":10,"text":"curl fil"},{"filename":"c.txt","content-type":"text/plain","size":10,"text":"curl fil"}]"#
        );
        assert_eq!(
            curl(&["-H", "accept: text/csv", &format!("{}/books", url)]),
            "id,title,price,note\n1,Dune,9.5,\n2,\"Odes, \"\"selected\"\"\",12,used\n"
        );
        let _ = std::fs::remove_dir_all(dir);
    }
}

/// A native server with the collector running at every 16th allocation.
fn native_stressed(file: &Path, dir: &Path) -> Server {
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
    cmd.args(["--listen", "127.0.0.1:0"])
        .env("FWP_GC_STRESS", "16");
    start(cmd)
}

#[test]
fn forms_and_formats_interpreted() {
    exercise_forms(&interpreted(&fixture("forms.fwp")));
}

#[test]
fn forms_and_formats_native() {
    if !have_cc() {
        eprintln!("skipping: no C compiler");
        return;
    }
    let dir = temp_dir("forms-native");
    exercise_forms(&native_stressed(&fixture("forms.fwp"), &dir));
    let _ = std::fs::remove_dir_all(dir);
}

/// The document lists the media types of bodies and responses.
#[test]
fn openapi_media_types() {
    let doc = parse_json(&openapi_text(&fixture("forms.fwp")));
    let op = |path: &str, method: &str| {
        doc.get("paths")
            .and_then(|p| p.get(path))
            .and_then(|p| p.get(method))
            .cloned()
            .unwrap_or(J::Null)
    };
    let keys = |j: Option<&J>| -> Vec<String> {
        j.map(|j| j.members().iter().map(|(k, _)| k.clone()).collect())
            .unwrap_or_default()
    };
    let profile = op("/profiles", "post");
    let content = profile.get("requestBody").and_then(|b| b.get("content"));
    assert_eq!(
        keys(content),
        [
            "application/json",
            "application/x-www-form-urlencoded",
            "multipart/form-data"
        ]
    );
    let multi = content
        .and_then(|c| c.get("multipart/form-data"))
        .and_then(|c| c.get("schema"))
        .and_then(|s| s.get("properties"))
        .and_then(|p| p.get("avatar"))
        .cloned();
    assert_eq!(
        multi,
        Some(J::Obj(vec![
            ("type".into(), J::Str("string".into())),
            ("format".into(), J::Str("binary".into())),
        ]))
    );
    assert!(keys(profile.get("responses")).contains(&"415".to_string()));
    let books = op("/books", "get");
    let ok = books
        .get("responses")
        .and_then(|r| r.get("200"))
        .and_then(|r| r.get("content"));
    assert_eq!(keys(ok), ["application/json", "text/plain", "text/csv"]);
    assert!(keys(books.get("responses")).contains(&"406".to_string()));
    // endpoints without `# accepts:` and `# produces:` are JSON only
    let api = parse_json(&openapi_text(&fixture("api.fwp")));
    let text = format!("{:?}", api);
    for m in ["multipart/form-data", "text/plain", "\"415\"", "\"406\""] {
        assert!(!text.contains(m), "{}", m);
    }
}

/// Endpoints whose annotations do not fit their types are rejected.
#[test]
fn media_type_errors() {
    let dir = temp_dir("media-errors");
    for (src, msg) in [
        (
            "# route: GET /x\n# accepts: form\nexport x : I64 -> I64\nx = id\n",
            "`x`: `# accepts:` needs a request body",
        ),
        (
            "# accepts: form\nexport x : List[I64] -> I64\nx = length\n",
            "`x`: a form body must be a record, not `List[I64]`",
        ),
        (
            "R = { a: List[List[I64]] }\n# accepts: multipart\nexport x : R -> I64\nx = const 1\n",
            "`x`: the field `a` of its form body has type `List[List[I64]]`",
        ),
        (
            "# accepts: xml\nexport x : I64 -> I64\nx = id\n",
            "unknown media type `xml` in `# accepts:`",
        ),
        (
            "# produces: text\nexport x : I64 -> ()\nx = const ()\n",
            "`x`: `# produces:` needs a result with a body",
        ),
        (
            "# produces: csv\nexport x : I64 -> List[I64]\nx = singleton\n",
            "`x`: `# produces: csv` needs a list of records",
        ),
    ] {
        let f = dir.join("bad.fwp");
        std::fs::write(&f, src).unwrap();
        let o = Command::new(fwp()).arg("openapi").arg(&f).output().unwrap();
        assert!(!o.status.success(), "{}", src);
        let err = String::from_utf8_lossy(&o.stderr);
        assert!(err.contains(msg), "{}\n---\n{}", src, err);
    }
    let _ = std::fs::remove_dir_all(dir);
}

/// Run a client program against a server, interpreted, then natively
/// against a native server: both print the same.
fn client_runs(server: &Path, client_dir: &Path, program: &str, golden_out: &Path) {
    let srv = interpreted(server);
    let run = Command::new(fwp())
        .arg("run")
        .arg(client_dir.join(program))
        .env("FWP_TEST_BASE", format!("http://{}", srv.addr))
        .output()
        .unwrap();
    assert!(
        run.status.success(),
        "{}",
        String::from_utf8_lossy(&run.stderr)
    );
    let got = String::from_utf8_lossy(&run.stdout).into_owned();
    golden(golden_out, &got);
    drop(srv);
    if have_cc() {
        let srv = native_stressed(server, client_dir);
        let exe = client_dir.join("client");
        let b = Command::new(fwp())
            .arg("build")
            .arg(client_dir.join(program))
            .args(["-O1", "-o"])
            .arg(&exe)
            .output()
            .unwrap();
        assert!(b.status.success(), "{}", String::from_utf8_lossy(&b.stderr));
        let run = Command::new(&exe)
            .env("FWP_TEST_BASE", format!("http://{}", srv.addr))
            .env("FWP_GC_STRESS", "16")
            .output()
            .unwrap();
        assert!(run.status.success());
        assert_eq!(String::from_utf8_lossy(&run.stdout), got);
    }
}

/// A client generated from the document of forms.fwp sends JSON, forms
/// and files, and reads JSON, text and CSV.
#[test]
fn forms_client_round_trip() {
    let dir = temp_dir("forms-roundtrip");
    let doc = dir.join("forms.json");
    std::fs::write(&doc, openapi_text(&fixture("forms.fwp"))).unwrap();
    assert_eq!(import(&doc, &dir.join("formsclient.fwp")), "");
    golden(
        &fixture("formsclient.fwp"),
        &std::fs::read_to_string(dir.join("formsclient.fwp")).unwrap(),
    );
    std::fs::copy(
        fixture("formsroundtrip.fwp"),
        dir.join("formsroundtrip.fwp"),
    )
    .unwrap();
    client_runs(
        &fixture("forms.fwp"),
        &dir,
        "formsroundtrip.fwp",
        &fixture("formsroundtrip.out"),
    );
    let _ = std::fs::remove_dir_all(dir);
}

/// YAML documents: the YAML of the petstore makes the client of its JSON,
/// and the YAML that `fwp openapi --yaml` prints makes the client of its
/// JSON.
#[test]
fn yaml_documents() {
    let dir = temp_dir("yaml");
    let out = dir.join("petstore.fwp");
    let warnings = import(&fixture("petstore.yaml"), &out);
    assert_eq!(
        std::fs::read_to_string(&out).unwrap(),
        std::fs::read_to_string(fixture("petstore.fwp")).unwrap()
    );
    assert_eq!(warnings.lines().count(), 2, "{}", warnings);
    for file in [
        fixture("api.fwp"),
        fixture("forms.fwp"),
        fixture("secure.fwp"),
    ] {
        let yaml = Command::new(fwp())
            .args(["openapi", "--yaml"])
            .arg(&file)
            .output()
            .unwrap();
        assert!(yaml.status.success());
        std::fs::write(dir.join("doc.yaml"), &yaml.stdout).unwrap();
        std::fs::write(dir.join("doc.json"), openapi_text(&file)).unwrap();
        import(&dir.join("doc.yaml"), &dir.join("from-yaml.fwp"));
        import(&dir.join("doc.json"), &dir.join("from-json.fwp"));
        assert_eq!(
            std::fs::read_to_string(dir.join("from-yaml.fwp")).unwrap(),
            std::fs::read_to_string(dir.join("from-json.fwp")).unwrap(),
            "{}",
            file.display()
        );
    }
    let _ = std::fs::remove_dir_all(dir);
}

/// Swagger 2.0 documents: the petstore's client type-checks, and a client
/// of a Swagger document in YAML calls forms.fwp, interpreted and native.
#[test]
fn swagger_documents() {
    let dir = temp_dir("swagger");
    let out = dir.join("petstore.fwp");
    let warnings = import(&fixture("petstore-swagger.json"), &out);
    golden(
        &fixture("petstore-swagger.fwp"),
        &std::fs::read_to_string(&out).unwrap(),
    );
    assert!(
        warnings.contains("GET /user/logout: its security scheme `basic` is not supported"),
        "{}",
        warnings
    );
    std::fs::write(dir.join("main.fwp"), "import petstore\n\nmain = ()\n").unwrap();
    let o = Command::new(fwp())
        .arg("check")
        .arg(dir.join("main.fwp"))
        .output()
        .unwrap();
    assert!(o.status.success(), "{}", String::from_utf8_lossy(&o.stderr));
    assert_eq!(
        import(
            &fixture("forms.swagger.yaml"),
            &dir.join("swaggerclient.fwp")
        ),
        ""
    );
    golden(
        &fixture("swaggerclient.fwp"),
        &std::fs::read_to_string(dir.join("swaggerclient.fwp")).unwrap(),
    );
    std::fs::copy(
        fixture("swaggerroundtrip.fwp"),
        dir.join("swaggerroundtrip.fwp"),
    )
    .unwrap();
    client_runs(
        &fixture("forms.fwp"),
        &dir,
        "swaggerroundtrip.fwp",
        &fixture("swaggerroundtrip.out"),
    );
    let _ = std::fs::remove_dir_all(dir);
}

/// examples/rest/uploads.fwp: files in, a summary out; a form; CSV.
#[test]
fn uploads_example() {
    let srv = interpreted(&root().join("examples/rest/uploads.fwp"));
    let body = multipart(&[
        ("title", None, None, b"notes"),
        ("files", Some("a.txt"), Some("text/plain"), b"one\ntwo\n"),
        ("tags", None, None, b"x"),
    ]);
    let (st, _, b) = http_raw(
        &srv.addr,
        "POST",
        "/uploads",
        &[("content-type", "multipart/form-data; boundary=XyZ")],
        &body,
    );
    assert_eq!(st, 201);
    assert_eq!(
        b,
        r#"{"title":"notes","tags":["x"],"files":[{"filename":"a.txt","content-type":"text/plain","size":8,"lines":2,"checksum":688}]}"#
    );
    let (st, hs, b) = http_raw(
        &srv.addr,
        "POST",
        "/guestbook",
        &[
            ("content-type", "application/x-www-form-urlencoded"),
            ("accept", "text/plain"),
        ],
        b"name=Ada&message=hi&stars=4",
    );
    assert_eq!(
        (st, b.as_str()),
        (
            201,
            r#"Entry {message = "hi", name = "Ada", stars = Some 4}"#
        )
    );
    assert!(hs
        .iter()
        .any(|(k, v)| k == "content-type" && v.starts_with("text/plain")));
    let (st, _, b) = http_raw(
        &srv.addr,
        "GET",
        "/guestbook",
        &[("accept", "text/csv")],
        b"",
    );
    assert_eq!(st, 200);
    assert_eq!(
        b,
        "name,message,stars\nAda,hello,5\nAlan,\"a, b, \"\"c\"\"\",\n"
    );
}
