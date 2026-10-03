//! Standalone function executables: each scenario runs with the interpreter
//! (`fwp exec`) and with a native build (`fwp build --fn`), and both must
//! produce exactly the expected output.

use std::collections::HashMap;
use std::path::{Path, PathBuf};
use std::process::{Command, Stdio};

fn fwp() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_fwp"))
}

fn tools() -> PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/exec/tools.fwp")
}

fn have_cc() -> bool {
    Command::new(std::env::var("CC").unwrap_or_else(|_| "cc".into()))
        .arg("--version")
        .output()
        .is_ok()
}

/// How to run a function: interpreter or a native executable.
#[derive(Clone)]
enum Runner {
    Interp,
    Native(HashMap<String, PathBuf>),
}

fn command(r: &Runner, func: &str) -> Command {
    match r {
        Runner::Interp => {
            let mut c = Command::new(fwp());
            c.arg("exec").arg(tools()).arg(func);
            c
        }
        Runner::Native(exes) => Command::new(&exes[func]),
    }
}

/// Run `func args` with stdin; returns (stdout bytes, stderr, exit code).
fn run(
    r: &Runner,
    func: &str,
    args: &[&str],
    stdin: &[u8],
    binary_out: bool,
) -> (Vec<u8>, String, i32) {
    use std::io::Write;
    let mut c = command(r, func);
    c.args(args)
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped());
    if binary_out {
        c.env("FWP_OUT", "bin");
    } else {
        c.env_remove("FWP_OUT");
    }
    let mut child = c.spawn().unwrap();
    child.stdin.take().unwrap().write_all(stdin).unwrap();
    let out = child.wait_with_output().unwrap();
    (
        out.stdout,
        String::from_utf8_lossy(&out.stderr).to_string(),
        out.status.code().unwrap_or(-1),
    )
}

fn text(r: &Runner, func: &str, args: &[&str], stdin: &str) -> String {
    let (out, err, code) = run(r, func, args, stdin.as_bytes(), false);
    format!("{}{}code={}", String::from_utf8_lossy(&out), err, code)
}

/// `producer | consumer` through the binary protocol.
fn piped(
    p: &Runner,
    c: &Runner,
    prod: (&str, &[&str]),
    cons: (&str, &[&str]),
    stdin: &str,
) -> String {
    let (bytes, err, code) = run(p, prod.0, prod.1, stdin.as_bytes(), true);
    assert_eq!(code, 0, "producer failed: {}", err);
    let (out, err, code) = run(c, cons.0, cons.1, &bytes, false);
    format!("{}{}code={}", String::from_utf8_lossy(&out), err, code)
}

fn check(r: &Runner) {
    let cases: Vec<(&str, &[&str], &str, &str)> = vec![
        ("normalize", &[], "  Hello\n WORLD \n", "hello\nworld\ncode=0"),
        ("scale", &["3", "14"], "", "42\ncode=0"),
        ("scale", &["10"], "1\n2\n3\n", "10\n20\n30\ncode=0"),
        ("total", &[], "1\n2\n3\n", "6\ncode=0"),
        ("total", &[], "", "0\ncode=0"),
        ("words-of", &[], "a b c\n", "a\nb\nc\ncode=0"),
        ("norm", &["{x = 3.0, y = 4.0}"], "", "5.0\ncode=0"),
        ("area", &["Rect 2.0 4.5"], "", "9.0\ncode=0"),
        ("area", &[], "Circle 1.0\nRect 1.0 2.0\n", "3.0\n2.0\ncode=0"),
        ("pairs", &["2"], "", "(0, \"x\")\n(1, \"x\")\ncode=0"),
        ("shout", &[], "hi\n", "HI\ncode=0"),
        ("halve", &["8"], "", "4\ncode=0"),
        ("halve", &[], "6\n0\n4\n", "3\nhalve: zero\ncode=1"),
        ("safe-div", &["0", "1"], "", "fwp: trap: division by zero\ncode=101"),
        ("scale", &["x"], "", "scale: argument 1: cannot parse `x` as I64\ncode=2"),
        (
            "scale",
            &["1", "2", "3"],
            "",
            "usage: scale <I64> <I64>\n  (the last argument may instead be given as records on stdin)\ncode=2",
        ),
        ("total", &[], "1\nx\n", "total: cannot parse input `x` as I64\ncode=3"),
        ("later", &["90min"], "", "90min\ncode=0"),
        ("later", &["9223372036854775807ns"], "", "9223372036854775807ns\ncode=0"),
        (
            "later",
            &[],
            "9223372036854775808ns\n",
            "later: cannot parse input `9223372036854775808ns` as Duration\ncode=3",
        ),
        (
            "later",
            &[],
            "3000000000h\n",
            "later: cannot parse input `3000000000h` as Duration\ncode=3",
        ),
        (
            "later",
            &[],
            "99999999999999999999999s\n",
            "later: cannot parse input `99999999999999999999999s` as Duration\ncode=3",
        ),
        ("flag", &[], "true\nFalse\n", "False\nTrue\ncode=0"),
        (
            "flag",
            &["TRUE"],
            "",
            "flag: argument 1: cannot parse `TRUE` as Bool\ncode=2",
        ),
    ];
    for (func, args, stdin, want) in cases {
        let got = text(r, func, args, stdin);
        assert_eq!(got, want, "{} {:?} <<< {:?}", func, args, stdin);
    }
}

fn native() -> Runner {
    let dir = std::env::temp_dir().join(format!("fwp-exec-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let mut exes = HashMap::new();
    for f in [
        "normalize",
        "scale",
        "total",
        "words-of",
        "norm",
        "area",
        "pairs",
        "shout",
        "halve",
        "safe-div",
        "later",
        "flag",
        "lines",
    ] {
        let exe = dir.join(f);
        let out = Command::new(fwp())
            .args(["build"])
            .arg(tools())
            .args(["--fn", f, "-O1", "-o"])
            .arg(&exe)
            .output()
            .unwrap();
        assert!(
            out.status.success(),
            "build {}: {}",
            f,
            String::from_utf8_lossy(&out.stderr)
        );
        exes.insert(f.to_string(), exe);
    }
    Runner::Native(exes)
}

#[test]
fn executables_behave_identically() {
    check(&Runner::Interp);
    if !have_cc() {
        return;
    }
    let n = native();
    check(&n);
    // binary protocol between every combination of backends
    for (p, c) in [
        (Runner::Interp, Runner::Interp),
        (n.clone(), n.clone()),
        (Runner::Interp, n.clone()),
        (n.clone(), Runner::Interp),
    ] {
        assert_eq!(
            piped(&p, &c, ("scale", &["10"]), ("total", &[]), "1\n2\n3\n"),
            "60\ncode=0"
        );
        assert_eq!(
            piped(&p, &c, ("normalize", &[]), ("total", &[]), "a\n"),
            "total: input type mismatch: expected `I64`, got `String`\ncode=3"
        );
        assert_eq!(
            piped(&p, &c, ("words-of", &[]), ("normalize", &[]), "To Be\n"),
            "to\nbe\ncode=0"
        );
    }
    // identical bytes on the wire
    let a = run(&Runner::Interp, "pairs", &["3"], b"", true).0;
    let b = run(&n, "pairs", &["3"], b"", true).0;
    assert_eq!(a, b);
    // malformed and invalid input is rejected identically
    for (func, stdin, want) in malformed_inputs() {
        for r in [&Runner::Interp, &n] {
            let (out, err, code) = run(r, func, &[], &stdin, false);
            let got = format!("{}{}code={}", String::from_utf8_lossy(&out), err, code);
            assert_eq!(got, want, "{} <<< {:?}", func, stdin);
        }
    }
}

fn leb(mut x: u64) -> Vec<u8> {
    let mut out = Vec::new();
    loop {
        let b = (x & 0x7f) as u8;
        x >>= 7;
        if x == 0 {
            out.push(b);
            return out;
        }
        out.push(b | 0x80);
    }
}

fn frame(payload: &[u8]) -> Vec<u8> {
    let mut out = vec![1u8];
    out.extend_from_slice(&(payload.len() as u32).to_le_bytes());
    out.extend_from_slice(payload);
    out
}

/// Binary streams with corrupt lengths and text with invalid UTF-8.
fn malformed_inputs() -> Vec<(&'static str, Vec<u8>, String)> {
    let header = run(&Runner::Interp, "normalize", &["x"], b"", true).0;
    let header = header[..header.len() - 7 - 5].to_vec(); // minus the "x" frame and the end
    let stream = |payload: &[u8]| [header.clone(), frame(payload), vec![0; 5]].concat();
    let bad = |what: &str| format!("normalize: {}\ncode=3", what);
    let mut huge = vec![0xffu8; 9];
    huge.push(0x01);
    let mut overlong = vec![0xffu8; 9];
    overlong.push(0x7f);
    vec![
        (
            "normalize",
            stream(&[leb(2), b"Hi".to_vec()].concat()),
            "hi\ncode=0".into(),
        ),
        ("normalize", stream(&huge), bad("malformed value")),
        ("normalize", stream(&overlong), bad("malformed value")),
        ("normalize", stream(&[1, 0xff]), bad("malformed value")),
        (
            "normalize",
            [header.clone(), vec![1, 2]].concat(),
            bad("truncated frame"),
        ),
        (
            "normalize",
            [b"FWP1\x01".to_vec(), leb(0), vec![0; 16], huge.clone()].concat(),
            bad("bad header"),
        ),
        (
            "normalize",
            [b"FWP1\x01".to_vec(), leb(1), leb(1 << 40)].concat(),
            bad("bad header"),
        ),
        (
            "normalize",
            [b"FWP1\x01".to_vec(), leb(1)].concat(),
            bad("truncated header"),
        ),
        // a switch to another transport that nobody asked for
        (
            "normalize",
            [header.clone(), vec![2, 1, 0, 0, 0, 1], vec![0; 5]].concat(),
            bad("bad switch frame"),
        ),
        // invalid UTF-8 in text records becomes U+FFFD
        (
            "normalize",
            b"A\xffB\xe2\x82\n".to_vec(),
            "a\u{fffd}b\u{fffd}\ncode=0".into(),
        ),
    ]
}

#[test]
fn fwp_pipe_connects_stages() {
    use std::io::Write;
    let spec = format!("{t}:scale 10 | {t}:total", t = tools().display());
    let mut child = Command::new(fwp())
        .arg("pipe")
        .arg(&spec)
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .spawn()
        .unwrap();
    child.stdin.take().unwrap().write_all(b"1\n2\n3\n").unwrap();
    let out = child.wait_with_output().unwrap();
    assert_eq!(String::from_utf8_lossy(&out.stdout), "60\n");
}

/// `producer | consumer` connected by a pipe, each with its environment;
/// the consumer's (stdout, stderr, exit code).
fn pipeline(
    p: &Runner,
    c: &Runner,
    prod: (&str, &[&str]),
    cons: (&str, &[&str]),
    penv: &[(&str, &str)],
    cenv: &[(&str, &str)],
) -> (Vec<u8>, String, i32) {
    let mut pc = command(p, prod.0);
    pc.args(prod.1)
        .env("FWP_OUT", "bin")
        .envs(penv.iter().copied())
        .stdin(Stdio::null())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped());
    let mut producer = pc.spawn().unwrap();
    let mut cc = command(c, cons.0);
    cc.args(cons.1)
        .env_remove("FWP_OUT")
        .envs(cenv.iter().copied())
        .stdin(Stdio::from(producer.stdout.take().unwrap()))
        .stdout(Stdio::piped())
        .stderr(Stdio::piped());
    let out = cc.output().unwrap();
    let pout = producer.wait_with_output().unwrap();
    assert!(
        pout.status.success(),
        "producer: {}",
        String::from_utf8_lossy(&pout.stderr)
    );
    (
        out.stdout,
        String::from_utf8_lossy(&out.stderr).to_string(),
        out.status.code().unwrap_or(-1),
    )
}

/// The stream moves from the stdout pipe to a Unix domain socket or to
/// shared memory when both sides can (Linux), between every combination
/// of backends, with byte-identical results; and it stays on the pipe when
/// the consumer declines or cannot ask.
#[test]
fn transports_switch_and_fall_back() {
    if !cfg!(target_os = "linux") {
        return;
    }
    let n = if have_cc() { Some(native()) } else { None };
    let mut runners = vec![(Runner::Interp, Runner::Interp)];
    if let Some(n) = &n {
        runners.push((n.clone(), n.clone()));
        runners.push((Runner::Interp, n.clone()));
        runners.push((n.clone(), Runner::Interp));
    }
    // about 1.5 MB: more than the ring holds, so it wraps around
    let count = "10000";
    let off = [("FWP_TRANSPORT", "stdio")];
    let lines = ("lines", &[count][..]);
    let (want, _, _) = pipeline(
        &Runner::Interp,
        &Runner::Interp,
        lines,
        ("normalize", &[]),
        &off,
        &off,
    );
    let want = String::from_utf8(want).unwrap();
    assert_eq!(want.lines().count(), 10000);
    let wait = ("FWP_TRANSPORT_WAIT", "20000");
    let report = ("FWP_TRANSPORT_REPORT", "1");
    for (p, c) in &runners {
        for (transport, name) in [("shm", "SHM_V1"), ("uds", "UDS_V1"), ("stdio", "")] {
            let t = std::time::Instant::now();
            let (out, err, code) = pipeline(
                p,
                c,
                ("lines", &[count]),
                ("normalize", &[]),
                &[wait],
                &[("FWP_TRANSPORT", transport), report],
            );
            assert_eq!(code, 0, "{}", err);
            assert!(
                String::from_utf8_lossy(&out) == want,
                "{} differs",
                transport
            );
            if name.is_empty() {
                // declining releases the waiting producer at once
                assert_eq!(err, "");
                assert!(t.elapsed() < std::time::Duration::from_secs(15));
            } else {
                assert_eq!(err, format!("fwp: input continues on {}\n", name));
            }
        }
    }
    // a producer that does not offer (FWP_TRANSPORT=stdio), or offers
    // without waiting: the same results
    for (p, c) in &runners {
        for penv in [&[("FWP_TRANSPORT", "stdio")][..], &[]] {
            let (out, err, code) =
                pipeline(p, c, ("lines", &[count]), ("normalize", &[]), penv, &[]);
            assert_eq!(code, 0, "{}", err);
            assert!(String::from_utf8_lossy(&out) == want);
        }
    }
    // a reader that is not an fwp program gets the stream on the pipe,
    // byte for byte as without transports
    for r in std::iter::once(Runner::Interp).chain(n.clone()) {
        let mut pc = command(&r, "lines");
        let plain = pc
            .arg("300")
            .env("FWP_OUT", "bin")
            .env("FWP_TRANSPORT", "stdio")
            .output()
            .unwrap()
            .stdout;
        let mut pc = command(&r, "lines");
        let offered = pc
            .arg("300")
            .env("FWP_OUT", "bin")
            .env("FWP_TRANSPORT_WAIT", "100")
            .output()
            .unwrap()
            .stdout;
        assert_eq!(plain, offered);
    }
    // `fwp pipe` switches between its stages
    use std::io::Write;
    let spec = format!("{t}:lines 2000 | {t}:normalize", t = tools().display());
    let mut child = Command::new(fwp())
        .arg("pipe")
        .arg(&spec)
        .env("FWP_TRANSPORT_REPORT", "1")
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .unwrap();
    child.stdin.take().unwrap().write_all(b"").unwrap();
    let out = child.wait_with_output().unwrap();
    let (want, _, _) = pipeline(
        &Runner::Interp,
        &Runner::Interp,
        ("lines", &["2000"]),
        ("normalize", &[]),
        &off,
        &off,
    );
    let want = String::from_utf8(want).unwrap();
    assert!(String::from_utf8_lossy(&out.stdout) == want);
    assert_eq!(
        String::from_utf8_lossy(&out.stderr),
        "fwp: input continues on SHM_V1\n"
    );
}
