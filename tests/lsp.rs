//! The language server: spawn `fwp lsp`, talk JSON-RPC over its stdio and
//! check diagnostics, hover, definition, symbols, formatting and
//! completion.

use std::io::{BufReader, Write};
use std::process::{Child, ChildStdin, ChildStdout, Command, Stdio};

use fwp::json::Json;
use fwp::lsp::{frame, path_to_uri, read_message};

struct Client {
    child: Child,
    stdin: ChildStdin,
    stdout: BufReader<ChildStdout>,
    next_id: u32,
    /// Notifications received while waiting for responses.
    notifications: Vec<Json>,
}

impl Client {
    fn start() -> Client {
        let mut child = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .arg("lsp")
            .stdin(Stdio::piped())
            .stdout(Stdio::piped())
            .spawn()
            .unwrap();
        let stdin = child.stdin.take().unwrap();
        let stdout = BufReader::new(child.stdout.take().unwrap());
        Client {
            child,
            stdin,
            stdout,
            next_id: 0,
            notifications: Vec::new(),
        }
    }

    fn send(&mut self, msg: Json) {
        self.stdin.write_all(frame(&msg).as_bytes()).unwrap();
        self.stdin.flush().unwrap();
    }

    fn notify(&mut self, method: &str, params: Json) {
        self.send(Json::obj(vec![
            ("jsonrpc", Json::str("2.0")),
            ("method", Json::str(method)),
            ("params", params),
        ]));
    }

    fn request(&mut self, method: &str, params: Json) -> Json {
        self.next_id += 1;
        let id = self.next_id;
        self.send(Json::obj(vec![
            ("jsonrpc", Json::str("2.0")),
            ("id", Json::Num(id as f64)),
            ("method", Json::str(method)),
            ("params", params),
        ]));
        loop {
            let msg = Json::parse(&read_message(&mut self.stdout).expect("response")).unwrap();
            if msg.get("id").and_then(Json::as_f64) == Some(id as f64) {
                assert!(msg.get("error").is_none(), "{}", msg);
                return msg.get("result").cloned().unwrap_or(Json::Null);
            }
            self.notifications.push(msg);
        }
    }

    /// The next diagnostics published for a document.
    fn diagnostics(&mut self, uri: &str) -> Vec<Json> {
        loop {
            if let Some(i) = self.notifications.iter().position(|n| {
                n.get("method").and_then(Json::as_str) == Some("textDocument/publishDiagnostics")
                    && n.at(&["params", "uri"]).and_then(Json::as_str) == Some(uri)
            }) {
                let n = self.notifications.remove(i);
                return n
                    .at(&["params", "diagnostics"])
                    .unwrap()
                    .as_array()
                    .unwrap()
                    .to_vec();
            }
            let msg = Json::parse(&read_message(&mut self.stdout).expect("notification")).unwrap();
            self.notifications.push(msg);
        }
    }
}

fn doc(uri: &str) -> Json {
    Json::obj(vec![("uri", Json::str(uri))])
}

fn at(uri: &str, line: u32, character: u32) -> Json {
    Json::obj(vec![
        ("textDocument", doc(uri)),
        (
            "position",
            Json::obj(vec![
                ("line", Json::Num(line as f64)),
                ("character", Json::Num(character as f64)),
            ]),
        ),
    ])
}

fn num(j: &Json, path: &[&str]) -> u32 {
    j.at(path).and_then(Json::as_f64).unwrap() as u32
}

const PROGRAM: &str = "\
# A program for the language server test.
double : I64 -> I64
double = mul 2

total = map double | sum | id

main = [1, 2, 3] | total | echo
";

#[test]
fn language_server() {
    let dir = std::env::temp_dir().join(format!("fwp-lsp-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let path = dir.join("main.fwp");
    std::fs::write(&path, PROGRAM).unwrap();
    let uri = path_to_uri(&path);
    let mut c = Client::start();

    let init = c.request(
        "initialize",
        Json::obj(vec![("capabilities", Json::obj(vec![]))]),
    );
    assert_eq!(
        init.at(&["capabilities", "hoverProvider"]),
        Some(&Json::Bool(true))
    );
    c.notify("initialized", Json::obj(vec![]));

    // a type error
    let broken = PROGRAM.replace("| echo", "| echoo");
    c.notify(
        "textDocument/didOpen",
        Json::obj(vec![(
            "textDocument",
            Json::obj(vec![
                ("uri", Json::str(&uri)),
                ("languageId", Json::str("fwp")),
                ("version", Json::Num(1.0)),
                ("text", Json::str(broken)),
            ]),
        )]),
    );
    let ds = c.diagnostics(&uri);
    let err = ds
        .iter()
        .find(|d| num(d, &["severity"]) == 1)
        .expect("an error");
    assert!(err
        .get("message")
        .and_then(Json::as_str)
        .unwrap()
        .contains("echoo"));
    assert_eq!(num(err, &["range", "start", "line"]), 6);
    assert_eq!(num(err, &["range", "start", "character"]), 27);

    // two syntax errors at once; the other declarations are still there
    let syntax = "double = mul 2 |\n\nhalve = (div 2\n\ntriple = mul 3\n";
    c.notify(
        "textDocument/didChange",
        Json::obj(vec![
            ("textDocument", doc(&uri)),
            (
                "contentChanges",
                Json::Arr(vec![Json::obj(vec![("text", Json::str(syntax))])]),
            ),
        ]),
    );
    let ds = c.diagnostics(&uri);
    assert_eq!(ds.len(), 2, "{:?}", ds);
    let symbols = c.request(
        "textDocument/documentSymbol",
        Json::obj(vec![("textDocument", doc(&uri))]),
    );
    let names: Vec<&str> = symbols
        .as_array()
        .unwrap()
        .iter()
        .map(|s| s.get("name").and_then(Json::as_str).unwrap())
        .collect();
    assert_eq!(names, ["triple"]);

    // the program: one lint warning
    c.notify(
        "textDocument/didChange",
        Json::obj(vec![
            ("textDocument", doc(&uri)),
            (
                "contentChanges",
                Json::Arr(vec![Json::obj(vec![("text", Json::str(PROGRAM))])]),
            ),
        ]),
    );
    let ds = c.diagnostics(&uri);
    assert_eq!(ds.len(), 1, "{:?}", ds);
    assert_eq!(
        ds[0].get("code").and_then(Json::as_str),
        Some("redundant-id")
    );
    assert_eq!(num(&ds[0], &["severity"]), 2);
    assert_eq!(num(&ds[0], &["range", "start", "line"]), 4);

    // hover: a top-level name, the binding being defined, a std name
    let h = c.request("textDocument/hover", at(&uri, 4, 13));
    let text = h.at(&["contents", "value"]).and_then(Json::as_str).unwrap();
    assert!(text.contains("double : I64 -> I64"), "{}", text);
    let h = c.request("textDocument/hover", at(&uri, 4, 1));
    let text = h.at(&["contents", "value"]).and_then(Json::as_str).unwrap();
    assert!(text.contains("total : List[I64] -> I64"), "{}", text);
    let h = c.request("textDocument/hover", at(&uri, 6, 28));
    let text = h.at(&["contents", "value"]).and_then(Json::as_str).unwrap();
    assert!(text.contains("echo : "), "{}", text);

    // a generic name: its scheme and its type at this use
    let h = c.request("textDocument/hover", at(&uri, 4, 22));
    let text = h.at(&["contents", "value"]).and_then(Json::as_str).unwrap();
    assert!(
        text.contains("sum : ") && text.contains("here: `List[I64] -> I64`"),
        "{}",
        text
    );

    // definition of `double` from its use
    let d = c.request("textDocument/definition", at(&uri, 4, 13));
    assert_eq!(d.get("uri").and_then(Json::as_str), Some(uri.as_str()));
    assert_eq!(num(&d, &["range", "start", "line"]), 2);
    assert_eq!(num(&d, &["range", "start", "character"]), 0);

    // references to `double`: its signature, its binding and its use
    let refs = |c: &mut Client, decl: bool| -> Vec<u32> {
        let mut params = at(&uri, 4, 13);
        if let Json::Obj(fs) = &mut params {
            fs.push((
                "context".into(),
                Json::obj(vec![("includeDeclaration", Json::Bool(decl))]),
            ));
        }
        let r = c.request("textDocument/references", params);
        r.as_array()
            .unwrap()
            .iter()
            .map(|l| num(l, &["range", "start", "line"]))
            .collect()
    };
    assert_eq!(refs(&mut c, true), [1, 2, 4]);
    assert_eq!(refs(&mut c, false), [4]);

    // rename `double`: every occurrence; not to a capitalized name, and not
    // a name of the standard library
    let rename = |c: &mut Client, line: u32, ch: u32, new: &str| -> Json {
        let mut params = at(&uri, line, ch);
        if let Json::Obj(fs) = &mut params {
            fs.push(("newName".into(), Json::str(new)));
        }
        c.request("textDocument/rename", params)
    };
    let edit = rename(&mut c, 4, 13, "twice");
    let edits = edit
        .at(&["changes", uri.as_str()])
        .and_then(Json::as_array)
        .unwrap();
    assert_eq!(edits.len(), 3, "{:?}", edit);
    assert!(edits
        .iter()
        .all(|e| e.get("newText").and_then(Json::as_str) == Some("twice")));
    assert_eq!(num(&edits[2], &["range", "start", "character"]), 12);
    assert_eq!(num(&edits[2], &["range", "end", "character"]), 18);
    assert_eq!(rename(&mut c, 4, 13, "Twice"), Json::Null);
    assert_eq!(rename(&mut c, 4, 22, "total2"), Json::Null);

    // definition of a name from an imported module
    std::fs::write(dir.join("geo.fwp"), "# areas\narea = uncurry mul | add 0\n").unwrap();
    let user = dir.join("user.fwp");
    let user_text = "import geo\n\nmain = (2, 3) | geo.area | echo\n";
    std::fs::write(&user, user_text).unwrap();
    let user_uri = path_to_uri(&user);
    c.notify(
        "textDocument/didOpen",
        Json::obj(vec![(
            "textDocument",
            Json::obj(vec![
                ("uri", Json::str(&user_uri)),
                ("languageId", Json::str("fwp")),
                ("version", Json::Num(1.0)),
                ("text", Json::str(user_text)),
            ]),
        )]),
    );
    assert_eq!(c.diagnostics(&user_uri), vec![]);
    let d = c.request("textDocument/definition", at(&user_uri, 2, 19));
    assert_eq!(
        d.get("uri").and_then(Json::as_str),
        Some(path_to_uri(&dir.join("geo.fwp")).as_str())
    );
    assert_eq!(num(&d, &["range", "start", "line"]), 1);

    // symbols
    let symbols = c.request(
        "textDocument/documentSymbol",
        Json::obj(vec![("textDocument", doc(&uri))]),
    );
    let names: Vec<&str> = symbols
        .as_array()
        .unwrap()
        .iter()
        .map(|s| s.get("name").and_then(Json::as_str).unwrap())
        .collect();
    assert_eq!(names, ["double", "total", "main"]);

    // completion: the file's names and the standard library's, with types
    let items = c.request("textDocument/completion", at(&uri, 6, 0));
    let items = items.as_array().unwrap();
    let detail = |label: &str| {
        items
            .iter()
            .find(|i| i.get("label").and_then(Json::as_str) == Some(label))
            .and_then(|i| i.get("detail"))
            .and_then(Json::as_str)
            .map(str::to_string)
    };
    assert_eq!(detail("double").as_deref(), Some("I64 -> I64"));
    assert!(detail("map").unwrap().contains("List[a]"));

    // formatting
    let messy = "main =   [1,2,3]|map (mul 2)  |echo\n";
    c.notify(
        "textDocument/didChange",
        Json::obj(vec![
            ("textDocument", doc(&uri)),
            (
                "contentChanges",
                Json::Arr(vec![Json::obj(vec![("text", Json::str(messy))])]),
            ),
        ]),
    );
    c.diagnostics(&uri);
    let edits = c.request(
        "textDocument/formatting",
        Json::obj(vec![
            ("textDocument", doc(&uri)),
            (
                "options",
                Json::obj(vec![
                    ("tabSize", Json::Num(4.0)),
                    ("insertSpaces", Json::Bool(true)),
                ]),
            ),
        ]),
    );
    let edits = edits.as_array().unwrap();
    assert_eq!(edits.len(), 1);
    assert_eq!(
        edits[0].get("newText").and_then(Json::as_str),
        Some("main = [1, 2, 3] | map (mul 2) | echo\n")
    );
    assert_eq!(num(&edits[0], &["range", "end", "line"]), 1);

    // shutdown and exit
    assert_eq!(c.request("shutdown", Json::Null), Json::Null);
    c.notify("exit", Json::Null);
    let status = c.child.wait().unwrap();
    assert_eq!(status.code(), Some(0));
    let _ = std::fs::remove_dir_all(&dir);
}
