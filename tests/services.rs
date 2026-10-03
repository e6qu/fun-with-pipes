//! Services: one program, built as a single executable or split into gRPC
//! services (docs/services.md).
//!
//! * The shop example and a program exchanging values of many types (with
//!   errors and traps) print the same output under `fwp run`, as one
//!   native executable, and split into services: native and interpreted
//!   servers, native and interpreted clients, in every combination.
//! * HPACK against the RFC 7541 Appendix C examples and the protobuf
//!   transcoder against golden bytes, in Rust and in C
//!   (`tests/services/h2_test.c` drives `runtime/fwp_rt_h2.c`).
//! * The generated `.proto` file (checked with `protoc` when installed).
//! * Interoperability with curl and Go's HTTP/2 stack when installed.

use std::io::{BufRead, BufReader, Write};
use std::path::{Path, PathBuf};
use std::process::{Child, Command, Stdio};
use std::sync::{Arc, Mutex};

use fwp::protobuf::{Msg, Node, Schema};

fn fwp() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_fwp"))
}

fn root() -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR"))
}

fn have(cmd: &str, arg: &str) -> bool {
    Command::new(cmd)
        .arg(arg)
        .stdout(Stdio::null())
        .stderr(Stdio::null())
        .status()
        .is_ok()
}

fn have_cc() -> bool {
    have(
        &std::env::var("CC").unwrap_or_else(|_| "cc".into()),
        "--version",
    )
}

fn scratch(name: &str) -> PathBuf {
    let d = std::env::temp_dir().join(format!("fwp-services-{}-{}", std::process::id(), name));
    let _ = std::fs::remove_dir_all(&d);
    std::fs::create_dir_all(&d).unwrap();
    d
}

fn render(o: &std::process::Output) -> String {
    let mut s = String::from_utf8_lossy(&o.stdout).to_string();
    if !o.stderr.is_empty() {
        s.push_str("--- stderr\n");
        s.push_str(&String::from_utf8_lossy(&o.stderr));
    }
    if let Some(c) = o.status.code().filter(|c| *c != 0) {
        s.push_str(&format!("--- exit {}\n", c));
    }
    s
}

/// A running service; killed when dropped.
struct Server {
    child: Child,
    addr: String,
    log: Arc<Mutex<String>>,
}

impl Drop for Server {
    fn drop(&mut self) {
        let _ = self.child.kill();
        let _ = self.child.wait();
    }
}

/// Start a service on a free port and wait for its "listening on" line.
// (the child is waited for when the `Server` is dropped)
#[allow(clippy::zombie_processes)]
fn start(mut cmd: Command) -> Server {
    cmd.arg("--listen")
        .arg("127.0.0.1:0")
        .stdout(Stdio::null())
        .stderr(Stdio::piped());
    let mut child = cmd.spawn().expect("start service");
    let mut err = BufReader::new(child.stderr.take().unwrap());
    let mut line = String::new();
    loop {
        line.clear();
        if err.read_line(&mut line).unwrap() == 0 {
            let _ = child.kill();
            panic!("service exited before listening");
        }
        if let Some(a) = line.trim().split("listening on ").nth(1) {
            let addr = a.to_string();
            // keep draining its stderr
            let log = Arc::new(Mutex::new(String::new()));
            let l = log.clone();
            std::thread::spawn(move || {
                let mut line = String::new();
                while err.read_line(&mut line).unwrap_or(0) > 0 {
                    l.lock().unwrap().push_str(&line);
                    line.clear();
                }
            });
            return Server { child, addr, log };
        }
    }
}

fn build_split(program: &Path, services: &[&str], dir: &Path) {
    let mut cmd = Command::new(fwp());
    cmd.arg("build").arg(program).arg("-O1").arg("-o").arg(dir);
    for s in services {
        cmd.arg("--service").arg(s);
    }
    let b = cmd.output().unwrap();
    assert!(b.status.success(), "{}", String::from_utf8_lossy(&b.stderr));
}

fn native_server(dir: &Path, module: &str, env: &[(String, String)]) -> Server {
    let mut c = Command::new(dir.join(module));
    c.envs(env.iter().cloned());
    start(c)
}

fn interp_server(
    program: &Path,
    module: &str,
    remote: &[&str],
    env: &[(String, String)],
) -> Server {
    let mut c = Command::new(fwp());
    c.args(["serve", "--interp"]);
    for r in remote {
        c.arg("--service").arg(r);
    }
    c.arg(program).arg(module).envs(env.iter().cloned());
    start(c)
}

fn env_of(module: &str, s: &Server) -> (String, String) {
    (fwp::protobuf::env_var(module), s.addr.clone())
}

/// The output of `fwp run` and of a single native executable.
fn reference(program: &Path, dir: &Path) -> String {
    let run = Command::new(fwp())
        .args(["run", "--interp"])
        .arg(program)
        .output()
        .unwrap();
    let expected = render(&run);
    let exe = dir.join("single");
    let b = Command::new(fwp())
        .arg("build")
        .arg(program)
        .args(["-O1", "-o"])
        .arg(&exe)
        .output()
        .unwrap();
    assert!(b.status.success(), "{}", String::from_utf8_lossy(&b.stderr));
    let native = Command::new(&exe).output().unwrap();
    assert_eq!(render(&native), expected, "single native executable");
    expected
}

fn run_interp_client(program: &Path, remote: &[&str], env: &[(String, String)]) -> String {
    let mut c = Command::new(fwp());
    c.args(["run", "--interp"]);
    for r in remote {
        c.arg("--service").arg(r);
    }
    render(&c.arg(program).envs(env.iter().cloned()).output().unwrap())
}

fn run_native_client(dir: &Path, env: &[(String, String)]) -> String {
    render(
        &Command::new(dir.join("main"))
            .envs(env.iter().cloned())
            .output()
            .unwrap(),
    )
}

#[test]
fn shop_split_into_services() {
    if !have_cc() {
        return;
    }
    let program = root().join("examples/services/main.fwp");
    let dir = scratch("shop");
    let expected = reference(&program, &dir);
    assert!(expected.contains("Err (inventory.Shortage"), "{}", expected);
    build_split(&program, &["inventory", "pricing"], &dir);
    let all = ["inventory", "pricing"];

    // native services, native and interpreted clients
    let inv = native_server(&dir, "inventory", &[]);
    let pri = native_server(&dir, "pricing", &[env_of("inventory", &inv)]);
    let env = vec![env_of("inventory", &inv), env_of("pricing", &pri)];
    assert_eq!(run_native_client(&dir, &env), expected, "native services");
    assert_eq!(
        run_interp_client(&program, &all, &env),
        expected,
        "interpreted client, native services"
    );

    // interpreted services (pricing calling the native inventory)
    let iinv = interp_server(&program, "inventory", &[], &[]);
    let ipri = interp_server(
        &program,
        "pricing",
        &["inventory"],
        &[env_of("inventory", &inv)],
    );
    let env = vec![env_of("inventory", &iinv), env_of("pricing", &ipri)];
    assert_eq!(
        run_native_client(&dir, &env),
        expected,
        "native client, interpreted services"
    );
    assert_eq!(
        run_interp_client(&program, &all, &env),
        expected,
        "interpreted client and services"
    );

    // only inventory split out: pricing is linked into the main program
    let dir2 = scratch("shop-one");
    build_split(&program, &["inventory"], &dir2);
    assert!(!dir2.join("pricing").exists());
    assert_eq!(
        run_native_client(&dir2, &[env_of("inventory", &inv)]),
        expected
    );

    // a service that is not running: a clear trap
    let out = Command::new(dir.join("main"))
        .env("FWP_SERVICE_INVENTORY", "127.0.0.1:1")
        .env("FWP_SERVICE_PRICING", &pri.addr)
        .output()
        .unwrap();
    assert_eq!(out.status.code(), Some(101));
    let err = String::from_utf8_lossy(&out.stderr);
    assert!(
        err.contains("fwp: trap: service call inventory.item (127.0.0.1:1) failed: cannot connect to 127.0.0.1:1"),
        "{}",
        err
    );
    let interp = Command::new(fwp())
        .args(["run", "--interp", "--service", "inventory"])
        .arg(&program)
        .env("FWP_SERVICE_INVENTORY", "127.0.0.1:1")
        .output()
        .unwrap();
    assert_eq!(interp.status.code(), Some(101));
    assert_eq!(String::from_utf8_lossy(&interp.stderr), err);
}

#[test]
fn values_errors_and_traps_cross_the_wire() {
    if !have_cc() {
        return;
    }
    let program = root().join("tests/services/codec/main.fwp");
    let dir = scratch("codec");
    let expected = reference(&program, &dir);
    assert!(expected.contains("--- exit 101"), "{}", expected);
    build_split(&program, &["codec"], &dir);
    let native = native_server(&dir, "codec", &[]);
    let env = vec![env_of("codec", &native)];
    assert_eq!(run_native_client(&dir, &env), expected);
    assert_eq!(run_interp_client(&program, &["codec"], &env), expected);
    let interp = interp_server(&program, "codec", &[], &[]);
    let env = vec![env_of("codec", &interp)];
    assert_eq!(run_native_client(&dir, &env), expected);
    assert_eq!(run_interp_client(&program, &["codec"], &env), expected);
    // the servers survived the traps and logged them
    std::thread::sleep(std::time::Duration::from_millis(200));
    for s in [&native, &interp] {
        let log = s.log.lock().unwrap().clone();
        assert_eq!(
            log.matches("fwp: trap: arithmetic overflow in I64 (in codec.bump)")
                .count(),
            2,
            "{}",
            log
        );
    }
}

// ---------------------------------------------------------------- HPACK

/// RFC 7541 Appendix C: header blocks decoded in sequence by one decoder
/// (with the given table size), the headers and the table size after each.
type Vector = (
    usize,
    &'static [(&'static str, &'static [(&'static str, &'static str)], usize)],
);

const REQ1: &[(&str, &str)] = &[
    (":method", "GET"),
    (":scheme", "http"),
    (":path", "/"),
    (":authority", "www.example.com"),
];
const REQ2: &[(&str, &str)] = &[
    (":method", "GET"),
    (":scheme", "http"),
    (":path", "/"),
    (":authority", "www.example.com"),
    ("cache-control", "no-cache"),
];
const REQ3: &[(&str, &str)] = &[
    (":method", "GET"),
    (":scheme", "https"),
    (":path", "/index.html"),
    (":authority", "www.example.com"),
    ("custom-key", "custom-value"),
];
const RESP1: &[(&str, &str)] = &[
    (":status", "302"),
    ("cache-control", "private"),
    ("date", "Mon, 21 Oct 2013 20:13:21 GMT"),
    ("location", "https://www.example.com"),
];
const RESP2: &[(&str, &str)] = &[
    (":status", "307"),
    ("cache-control", "private"),
    ("date", "Mon, 21 Oct 2013 20:13:21 GMT"),
    ("location", "https://www.example.com"),
];
const RESP3: &[(&str, &str)] = &[
    (":status", "200"),
    ("cache-control", "private"),
    ("date", "Mon, 21 Oct 2013 20:13:22 GMT"),
    ("location", "https://www.example.com"),
    ("content-encoding", "gzip"),
    (
        "set-cookie",
        "foo=ASDJKHQKBZXOQWEOPIUAXQWEOIU; max-age=3600; version=1",
    ),
];

const VECTORS: &[Vector] = &[
    // C.2: one field each
    (
        4096,
        &[(
            "400a637573746f6d2d6b65790d637573746f6d2d686561646572",
            &[("custom-key", "custom-header")],
            55,
        )],
    ),
    (
        4096,
        &[("040c2f73616d706c652f70617468", &[(":path", "/sample/path")], 0)],
    ),
    (
        4096,
        &[("100870617373776f726406736563726574", &[("password", "secret")], 0)],
    ),
    (4096, &[("82", &[(":method", "GET")], 0)]),
    // C.3: requests without Huffman coding
    (
        4096,
        &[
            ("828684410f7777772e6578616d706c652e636f6d", REQ1, 57),
            ("828684be58086e6f2d6361636865", REQ2, 110),
            (
                "828785bf400a637573746f6d2d6b65790c637573746f6d2d76616c7565",
                REQ3,
                164,
            ),
        ],
    ),
    // C.4: requests with Huffman coding
    (
        4096,
        &[
            ("828684418cf1e3c2e5f23a6ba0ab90f4ff", REQ1, 57),
            ("828684be5886a8eb10649cbf", REQ2, 110),
            ("828785bf408825a849e95ba97d7f8925a849e95bb8e8b4bf", REQ3, 164),
        ],
    ),
    // C.5: responses without Huffman coding, with evictions
    (
        256,
        &[
            ("4803333032580770726976617465611d4d6f6e2c203231204f637420323031332032303a31333a323120474d546e1768747470733a2f2f7777772e6578616d706c652e636f6d", RESP1, 222),
            ("4803333037c1c0bf", RESP2, 222),
            ("88c1611d4d6f6e2c203231204f637420323031332032303a31333a323220474d54c05a04677a69707738666f6f3d4153444a4b48514b425a584f5157454f50495541585157454f49553b206d61782d6167653d333630303b2076657273696f6e3d31", RESP3, 215),
        ],
    ),
    // C.6: responses with Huffman coding, with evictions
    (
        256,
        &[
            ("488264025885aec3771a4b6196d07abe941054d444a8200595040b8166e082a62d1bff6e919d29ad171863c78f0b97c8e9ae82ae43d3", RESP1, 222),
            ("4883640effc1c0bf", RESP2, 222),
            ("88c16196d07abe941054d444a8200595040b8166e084a62d1bffc05a839bd9ab77ad94e7821dd7f2e6c7b335dfdfcd5b3960d5af27087f3672c1ab270fb5291f9587316065c003ed4ee5b1063d5007", RESP3, 215),
        ],
    ),
];

fn unhex(s: &str) -> Vec<u8> {
    (0..s.len())
        .step_by(2)
        .map(|i| u8::from_str_radix(&s[i..i + 2], 16).unwrap())
        .collect()
}

fn hex(b: &[u8]) -> String {
    b.iter().map(|x| format!("{:02x}", x)).collect()
}

/// What `h2_test.c` prints for the vectors.
fn expected_hpack_text() -> String {
    let mut out = String::new();
    for (_, blocks) in VECTORS {
        for (_, hs, size) in blocks.iter() {
            for (n, v) in hs.iter() {
                out.push_str(&format!("{}: {}\n", n, v));
            }
            out.push_str(&format!("size {}\n", size));
        }
    }
    out
}

#[test]
fn hpack_rfc7541_examples() {
    use fwp::h2::hpack;
    for (limit, blocks) in VECTORS {
        let mut d = hpack::Decoder::new(*limit);
        for (block, want, size) in blocks.iter() {
            let got = d.decode(&unhex(block)).unwrap();
            let want: Vec<(String, String)> = want
                .iter()
                .map(|(n, v)| (n.to_string(), v.to_string()))
                .collect();
            assert_eq!(got, want, "{}", block);
            assert_eq!(d.dynamic().1, *size, "table size after {}", block);
        }
    }
    // C.1: integers
    let mut b = Vec::new();
    hpack::put_int(&mut b, 0, 5, 10);
    hpack::put_int(&mut b, 0, 5, 1337);
    hpack::put_int(&mut b, 0, 8, 42);
    assert_eq!(b, [0x0a, 0x1f, 0x9a, 0x0a, 0x2a]);
    // the encoder's literals decode back, long values included
    let long = "x".repeat(300);
    let hs = [(":status", "200"), ("grpc-message", long.as_str())];
    let got = hpack::Decoder::default()
        .decode(&hpack::encode(&hs))
        .unwrap();
    assert_eq!(got[1].1, long);
    // malformed input
    assert!(hpack::huffman_decode(&[0xff, 0xff, 0xff, 0xff]).is_err());
    assert!(hpack::Decoder::default().decode(&[0xbe]).is_err());
}

/// Run `tests/services/h2_test.c` on a script; `None` without a C compiler.
fn c_harness(script: &str) -> Option<String> {
    if !have_cc() {
        return None;
    }
    static BUILT: std::sync::OnceLock<PathBuf> = std::sync::OnceLock::new();
    let exe = BUILT.get_or_init(|| {
        let exe = std::env::temp_dir().join(format!("fwp-h2-test-{}", std::process::id()));
        let cc = std::env::var("CC").unwrap_or_else(|_| "cc".into());
        let out = Command::new(cc)
            .args(["-std=gnu11", "-O1", "-w", "-o"])
            .arg(&exe)
            .arg(root().join("tests/services/h2_test.c"))
            .output()
            .unwrap();
        assert!(
            out.status.success(),
            "{}",
            String::from_utf8_lossy(&out.stderr)
        );
        exe
    });
    let mut child = Command::new(exe)
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .spawn()
        .unwrap();
    child
        .stdin
        .take()
        .unwrap()
        .write_all(script.as_bytes())
        .unwrap();
    let out = child.wait_with_output().unwrap();
    Some(String::from_utf8_lossy(&out.stdout).into_owned())
}

#[test]
fn hpack_rfc7541_examples_in_c() {
    let mut script = String::new();
    for (limit, blocks) in VECTORS {
        script.push_str(&format!("reset {}\n", limit));
        for (block, _, _) in blocks.iter() {
            script.push_str(&format!("hpack {}\n", block));
        }
    }
    if let Some(got) = c_harness(&script) {
        assert_eq!(got, expected_hpack_text());
    }
}

// ------------------------------------------------------------- protobuf

/// A schema by hand: `Top { flag: Bool = 3, id: I64 = 1, name: String = 2,
/// ratio: F64 = 4, nums: List[I64] = 5, inner: Option[Inner] = 6, choice:
/// I64 | String = 7, words: List[String] = 8 }` with `Inner { a: I64 = 1 }`
/// (fields listed in canonical order).
fn golden_schema() -> (Schema, usize) {
    let mut s = Schema::default();
    let msg = |name: &str, fields: Vec<(u32, &str, usize)>| {
        Node::Msg(Msg {
            name: name.into(),
            fields: fields
                .into_iter()
                .map(|(n, f, c)| (n, f.to_string(), c))
                .collect(),
            map_entry: false,
            parent: None,
        })
    };
    s.nodes = vec![
        Node::SInt(8),                   // 0
        Node::Str,                       // 1
        Node::Bool,                      // 2
        Node::F64,                       // 3
        Node::List(0),                   // 4
        msg("Inner", vec![(1, "a", 0)]), // 5
        Node::Opt(5),                    // 6
        Node::OneOf {
            name: "Choice".into(),
            group: "value".into(),
            alts: vec![("x".into(), 0), ("y".into(), 1)],
        }, // 7
        Node::List(1),                   // 8
        msg(
            "Top",
            vec![
                (3, "flag", 2),
                (1, "id", 0),
                (2, "name", 1),
                (4, "ratio", 3),
                (5, "nums", 4),
                (6, "inner", 6),
                (7, "choice", 7),
                (8, "words", 8),
            ],
        ), // 9
    ];
    (s, 9)
}

fn le64(x: i64) -> String {
    hex(&x.to_le_bytes())
}

/// Canonical bytes of the golden value: flag True, id -2, name "hi", ratio
/// 1.5, nums [1, -1, 150], inner Some {a = 5}, choice y "ok", words ["a", ""].
fn golden_canonical() -> String {
    format!(
        "01{}026869{}03{}{}{}01{}01026f6b02016100",
        le64(-2),
        hex(&1.5f64.to_le_bytes()),
        le64(1),
        le64(-1),
        le64(150),
        le64(5)
    )
}

const GOLDEN_PB: &str =
    "0803 12026869 1801 21000000000000f83f 2a040201ac02 3202080a 3a0412026f6b 420161 4200";

#[test]
fn protobuf_golden_bytes() {
    let (s, top) = golden_schema();
    let canon = unhex(&golden_canonical());
    let pb = GOLDEN_PB.replace(' ', "");
    assert_eq!(hex(&s.encode(top, &canon).unwrap()), pb);
    assert_eq!(hex(&s.decode(top, &unhex(&pb)).unwrap()), hex(&canon));
    // other encoders' choices decode to the same value: fields out of
    // order, `nums` not packed, an unknown field, a repeated scalar
    let alt = "420161 1801 087f 0803 12026869 21000000000000f83f 2802 2801 28ac02 3202080a 3a0412026f6b 4200 a80601";
    assert_eq!(
        hex(&s.decode(top, &unhex(&alt.replace(' ', ""))).unwrap()),
        hex(&canon)
    );
    // defaults for absent fields; a oneof must be set
    let minimal = s.decode(top, &unhex("3a020802")).unwrap();
    let defaults = [
        "00".to_string(),            // flag
        le64(0),                     // id
        "00".into(),                 // name
        hex(&0f64.to_le_bytes()),    // ratio
        "00".into(),                 // nums
        "00".into(),                 // inner: None
        "00".to_string() + &le64(1), // choice: x 1
        "00".into(),                 // words
    ];
    assert_eq!(hex(&minimal), defaults.concat());
    assert!(s.decode(top, &[]).is_err());
    // out of range, wrong wire types, truncation
    let mut i8s = Schema::default();
    i8s.nodes = vec![
        Node::SInt(1),
        Node::Msg(Msg {
            name: "M".into(),
            fields: vec![(1, "v".into(), 0)],
            map_entry: false,
            parent: None,
        }),
    ];
    assert_eq!(hex(&i8s.decode(1, &unhex("08fe01")).unwrap()), "7f");
    assert!(i8s.decode(1, &unhex("088002")).is_err());
    assert!(i8s.decode(1, &unhex("0d00000000")).is_err());
    assert!(i8s.decode(1, &unhex("08")).is_err());

    // the C transcoder agrees
    let (flat, offs) = s.flatten();
    let sc: Vec<String> = flat.iter().map(|x| x.to_string()).collect();
    let sc = sc.join(",");
    let (iflat, ioffs) = i8s.flatten();
    let ic: Vec<String> = iflat.iter().map(|x| x.to_string()).collect();
    let ic = ic.join(",");
    let script = format!(
        "enc {s} {t} {canon}\ndec {s} {t} {pb}\ndec {s} {t} {alt}\ndec {s} {t} 3a020802\ndec {s} {t} \ndec {i} {m} 08fe01\ndec {i} {m} 088002\n",
        s = sc,
        t = offs[top],
        canon = hex(&canon),
        pb = pb,
        alt = alt.replace(' ', ""),
        i = ic,
        m = ioffs[1],
    );
    if let Some(got) = c_harness(&script) {
        let lines: Vec<&str> = got.lines().collect();
        assert_eq!(lines[0], pb, "C encoder");
        assert_eq!(lines[1], hex(&canon));
        assert_eq!(lines[2], hex(&canon));
        assert_eq!(lines[3], hex(&minimal));
        assert!(lines[4].starts_with("error"), "{}", lines[4]);
        assert_eq!(lines[5], "7f");
        assert!(lines[6].starts_with("error"), "{}", lines[6]);
    }
}

#[test]
fn proto_file_of_the_shop() {
    let out = Command::new(fwp())
        .arg("proto")
        .arg(root().join("examples/services/main.fwp"))
        .output()
        .unwrap();
    assert!(
        out.status.success(),
        "{}",
        String::from_utf8_lossy(&out.stderr)
    );
    let text = String::from_utf8(out.stdout).unwrap();
    let golden = root().join("tests/services/shop.proto");
    if std::env::var("FWP_BLESS").is_ok() {
        std::fs::write(&golden, &text).unwrap();
    }
    assert_eq!(text, std::fs::read_to_string(&golden).unwrap());
    // one service at a time
    let one = Command::new(fwp())
        .args(["proto", "--service", "inventory"])
        .arg(root().join("examples/services/main.fwp"))
        .output()
        .unwrap();
    let one = String::from_utf8(one.stdout).unwrap();
    assert!(one.contains("service Inventory {") && !one.contains("service Pricing"));
    if have("protoc", "--version") {
        let dir = scratch("protoc");
        std::fs::write(dir.join("shop.proto"), &text).unwrap();
        let p = Command::new("protoc")
            .arg("--proto_path")
            .arg(&dir)
            .arg("--descriptor_set_out")
            .arg(dir.join("shop.pb"))
            .arg("shop.proto")
            .output()
            .unwrap();
        assert!(p.status.success(), "{}", String::from_utf8_lossy(&p.stderr));
    }
}

#[test]
fn split_build_rejects_bad_interfaces() {
    let dir = scratch("bad");
    std::fs::write(
        dir.join("lib.fwp"),
        "export at-one : (I64 -> I64) -> I64\nat-one = apply 1\n",
    )
    .unwrap();
    std::fs::write(
        dir.join("main.fwp"),
        "import lib\nmain = lib.at-one (add 1) | echo\n",
    )
    .unwrap();
    let ok = Command::new(fwp())
        .args(["run", "--interp"])
        .arg(dir.join("main.fwp"))
        .output()
        .unwrap();
    assert!(
        ok.status.success(),
        "{}",
        String::from_utf8_lossy(&ok.stderr)
    );
    let bad = Command::new(fwp())
        .args(["run", "--interp", "--service", "lib"])
        .arg(dir.join("main.fwp"))
        .output()
        .unwrap();
    assert!(!bad.status.success());
    let err = String::from_utf8_lossy(&bad.stderr);
    assert!(
        err.contains("`at-one` is served by module `lib`, but values of type `I64 -> I64` cannot be sent to a service"),
        "{}",
        err
    );
}

// --------------------------------------------------------- interoperability

fn curl_grpc(addr: &str, path: &str, body: &[u8], extra: &[&str]) -> (String, Vec<u8>) {
    let dir = scratch("curl");
    std::fs::write(dir.join("req"), body).unwrap();
    let mut c = Command::new("curl");
    c.args(["-s", "--http2-prior-knowledge"]);
    if !extra.iter().any(|h| h.starts_with("content-type")) {
        c.args(["-H", "content-type: application/grpc"]);
    }
    for h in extra {
        c.args(["-H", h]);
    }
    let out = c
        .arg("--data-binary")
        .arg(format!("@{}", dir.join("req").display()))
        .arg("-D")
        .arg(dir.join("headers"))
        .arg("-o")
        .arg(dir.join("resp"))
        .arg(format!("http://{}{}", addr, path))
        .output()
        .unwrap();
    assert!(
        out.status.success(),
        "curl: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    (
        std::fs::read_to_string(dir.join("headers")).unwrap(),
        std::fs::read(dir.join("resp")).unwrap_or_default(),
    )
}

#[test]
fn curl_calls_the_services() {
    if !have_cc() || !have("curl", "--version") {
        return;
    }
    let program = root().join("examples/services/main.fwp");
    let dir = scratch("curl-shop");
    build_split(&program, &["inventory"], &dir);
    let native = native_server(&dir, "inventory", &[]);
    let interp = interp_server(&program, "inventory", &[], &[]);
    // `item "pear"`: Some (Item {sku = "pear", name = "Pear", stock = 3})
    let req = unhex("00000000060a0470656172");
    let want = "00000000100a0e0a04706561721204506561721806";
    for s in [&native, &interp] {
        let (h, body) = curl_grpc(&s.addr, "/fwp.Inventory/Item", &req, &[]);
        assert!(h.contains("grpc-status: 0"), "{}", h);
        assert_eq!(hex(&body), want);
        let (h, _) = curl_grpc(&s.addr, "/fwp.Inventory/Missing", &req, &[]);
        assert!(h.contains("grpc-status: 12"), "{}", h);
        let (h, _) = curl_grpc(
            &s.addr,
            "/fwp.Inventory/Item",
            &req,
            &["fwp-fingerprint: 00"],
        );
        assert!(h.contains("grpc-status: 9"), "{}", h);
        assert!(h.contains("interface mismatch"), "{}", h);
        let (h, _) = curl_grpc(
            &s.addr,
            "/fwp.Inventory/Item",
            &unhex("0000000002ffff"),
            &[],
        );
        assert!(h.contains("grpc-status: 3"), "{}", h);
        let (h, _) = curl_grpc(
            &s.addr,
            "/fwp.Inventory/Item",
            &req,
            &["content-type: text/plain"],
        );
        assert!(h.starts_with("HTTP/2 415"), "{}", h);
    }
}

#[test]
fn go_http2_interoperates() {
    if !have_cc() || !have("go", "version") {
        return;
    }
    let dir = scratch("go");
    let go = dir.join("interop");
    let b = Command::new("go")
        .arg("build")
        .arg("-o")
        .arg(&go)
        .arg(root().join("tests/services/interop.go"))
        .output()
        .unwrap();
    if !b.status.success() {
        // an older Go without unencrypted HTTP/2 support
        eprintln!("skipping: {}", String::from_utf8_lossy(&b.stderr));
        return;
    }
    // a Go server for `echo`, called by native and interpreted fwp clients
    let mut server = Command::new(&go)
        .arg("server")
        .stdout(Stdio::piped())
        .stderr(Stdio::null())
        .spawn()
        .unwrap();
    let mut line = String::new();
    BufReader::new(server.stdout.take().unwrap())
        .read_line(&mut line)
        .unwrap();
    let addr = line.trim().to_string();
    let program = root().join("tests/services/echo/main.fwp");
    let expected = reference(&program, &dir);
    build_split(&program, &["echo"], &dir);
    let env = vec![("FWP_SERVICE_ECHO".to_string(), addr)];
    let native = run_native_client(&dir, &env);
    let interp = run_interp_client(&program, &["echo"], &env);
    let _ = server.kill();
    let _ = server.wait();
    assert_eq!(native, expected);
    assert_eq!(interp, expected);
    // a Go client calling fwp servers
    let shop = root().join("examples/services/main.fwp");
    let sdir = scratch("go-shop");
    build_split(&shop, &["inventory"], &sdir);
    let ns = native_server(&sdir, "inventory", &[]);
    let is = interp_server(&shop, "inventory", &[], &[]);
    for s in [&ns, &is] {
        let out = Command::new(&go)
            .args(["client", &s.addr, "/fwp.Inventory/Item", "0a0470656172"])
            .output()
            .unwrap();
        let line = "HTTP/2.0 0 00000000100a0e0a04706561721204506561721806\n";
        assert_eq!(String::from_utf8_lossy(&out.stdout), line.repeat(2));
    }
}

// ------------------------------------------------- streams and flow control

/// A raw HTTP/2 connection for driving a server frame by frame.
struct Raw {
    sock: std::net::TcpStream,
    buf: Vec<u8>,
}

impl Raw {
    fn connect(addr: &str, settings: &[u8]) -> Raw {
        use fwp::h2::*;
        let mut sock = std::net::TcpStream::connect(addr).unwrap();
        sock.set_read_timeout(Some(std::time::Duration::from_secs(10)))
            .unwrap();
        let mut hello = PREFACE.to_vec();
        hello.extend(frame(SETTINGS, 0, 0, settings));
        sock.write_all(&hello).unwrap();
        Raw {
            sock,
            buf: Vec::new(),
        }
    }

    fn send(&mut self, b: &[u8]) {
        self.sock.write_all(b).unwrap();
    }

    fn next(&mut self) -> fwp::h2::Frame {
        use std::io::Read;
        loop {
            if let Some((f, n)) = fwp::h2::parse_frame(&self.buf).unwrap() {
                self.buf.drain(..n);
                return f;
            }
            let mut b = [0u8; 4096];
            let n = self.sock.read(&mut b).unwrap();
            assert!(n > 0, "connection closed");
            self.buf.extend_from_slice(&b[..n]);
        }
    }

    fn request(&mut self, stream: u32, path: &str) {
        use fwp::h2::*;
        let block = hpack::encode(&[
            (":method", "POST"),
            (":scheme", "http"),
            (":path", path),
            (":authority", "x"),
            ("content-type", "application/grpc"),
        ]);
        self.send(&frame(HEADERS, END_HEADERS, stream, &block));
    }
}

#[test]
fn concurrent_streams_and_flow_control() {
    use fwp::h2::*;
    if !have_cc() {
        return;
    }
    let program = root().join("examples/services/main.fwp");
    let dir = scratch("streams");
    build_split(&program, &["inventory"], &dir);
    let native = native_server(&dir, "inventory", &[]);
    let interp = interp_server(&program, "inventory", &[], &[]);
    let pear = grpc_frame(&unhex("0a0470656172"));
    let apple = grpc_frame(&unhex("0a056170706c65"));
    for s in [&native, &interp] {
        // three streams, interleaved and completed out of order, with the
        // request bodies split across frames
        let mut c = Raw::connect(&s.addr, &[]);
        c.request(1, "/fwp.Inventory/Item");
        c.request(3, "/fwp.Inventory/Item");
        c.request(5, "/fwp.Inventory/Item");
        c.send(&frame(DATA, 0, 3, &apple[..4]));
        c.send(&frame(DATA, END_STREAM, 5, &pear));
        c.send(&frame(PING, 0, 0, b"12345678"));
        c.send(&frame(DATA, END_STREAM, 3, &apple[4..]));
        c.send(&frame(DATA, END_STREAM, 1, &pear));
        let mut dec = hpack::Decoder::default();
        let mut bodies: std::collections::BTreeMap<u32, Vec<u8>> = Default::default();
        let mut done = Vec::new();
        let mut pinged = false;
        while done.len() < 3 {
            let f = c.next();
            match f.ty {
                DATA => bodies.entry(f.stream).or_default().extend(&f.payload),
                HEADERS => {
                    let hs = dec.decode(&f.payload).unwrap();
                    if f.flags & END_STREAM != 0 {
                        assert!(hs.contains(&("grpc-status".into(), "0".into())), "{:?}", hs);
                        done.push(f.stream);
                    }
                }
                PING => {
                    assert_eq!(f.flags, ACK);
                    assert_eq!(f.payload, b"12345678");
                    pinged = true;
                }
                _ => {}
            }
        }
        assert!(pinged);
        done.sort();
        assert_eq!(done, [1, 3, 5]);
        let pear_item = "00000000100a0e0a04706561721204506561721806";
        assert_eq!(hex(&bodies[&1]), pear_item);
        assert_eq!(hex(&bodies[&5]), pear_item);
        assert!(hex(&bodies[&3]).contains(&hex(b"Apple")));

        // the server keeps within a 7-byte stream window until we open it
        let mut c = Raw::connect(&s.addr, &[0, 4, 0, 0, 0, 7]);
        c.request(1, "/fwp.Inventory/Item");
        c.send(&frame(DATA, END_STREAM, 1, &pear));
        let mut body = Vec::new();
        let mut opened = false;
        loop {
            let f = c.next();
            if f.ty == DATA {
                body.extend(&f.payload);
                assert!(body.len() <= if opened { 21 } else { 7 }, "window exceeded");
                if body.len() == 7 && !opened {
                    std::thread::sleep(std::time::Duration::from_millis(100));
                    opened = true;
                    c.send(&frame(WINDOW_UPDATE, 0, 1, &100u32.to_be_bytes()));
                }
            }
            if f.ty == HEADERS && f.flags & END_STREAM != 0 {
                break;
            }
        }
        assert_eq!(hex(&body), pear_item);
    }
}
