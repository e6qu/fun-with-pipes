//! Owned runtime text results include their fresh Option/List children.
use std::path::PathBuf;
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let out = command.output().unwrap();
    assert!(
        out.status.success(),
        "{command:?}: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    out
}
struct Scratch(PathBuf);
impl Scratch {
    fn new(name: &str) -> Self {
        let p = std::env::temp_dir().join(format!("fwp-text-{}-{name}", std::process::id()));
        std::fs::create_dir_all(&p).unwrap();
        Self(p)
    }
}
impl Drop for Scratch {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}

#[test]
fn nested_text_results_under_collection() {
    let dir = Scratch::new("aliases");
    let src = dir.0.join("leaves.fwp");
    std::fs::write(
        &src,
        r#"
checks = make {
    original = id,
    parts = split ",",
    characters = string.chars,
    lines = lines,
    words = words,
    roundtrip = string.to-bytes | string.from-bytes,
    first = string.split-once ",",
    missing = string.split-once "absent",
    valid = const [104u32, 233u32] | string.from-codepoints,
    invalid = const [1114112u32] | string.from-codepoints,
    bad-bytes = const [255u8] | bytes.from-list | string.from-bytes,
    points = string.codepoints,
    byte-values = string.to-bytes | bytes.to-list,
    byte = string.to-bytes | bytes.get 1,
    no-byte = string.to-bytes | bytes.get 1000,
    found = string.find "hé",
    no-match = string.find "absent",
    byte-match = string.to-bytes | bytes.find ("hé" | string.to-bytes),
    joined = split "," | join ":",
}
main = read-all () | concat " a,b hé\nc " | checks | echo
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
    for opt in ["-O1", "-O2"] {
        let exe = dir.0.join(format!("leaves{opt}"));
        checked(
            Command::new(fwp)
                .arg("build")
                .arg(&src)
                .args([opt, "-o"])
                .arg(&exe),
        );
        for verify in ["0", "1"] {
            let native = checked(
                Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", verify),
            );
            assert_eq!(
                native.stdout, reference.stdout,
                "{opt}, reuse verification {verify}"
            );
        }
    }
}

#[test]
fn nested_text_results_are_released_without_tracing() {
    let dir = Scratch::new("counts");
    let src = dir.0.join("leaf-loop.fwp");
    std::fs::write(
        &src,
        r#"
size : I64 -> I64
size = rem 7 | add 1 | flip string.repeat "a " | words | length
step : (I64, I64) -> Step[(I64, I64), I64]
step = if (.0 | eq 0) (.1 | Stop) (make { 0 = .0 | sub 1, 1 = fork add .1 (.0 | size) } | Again)
main = (10000, 0) | loop step | echo
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
    let mut freed = Vec::new();
    for free in ["0", "1"] {
        let exe = dir.0.join(format!("loop-{free}"));
        checked(
            Command::new(fwp)
                .arg("build")
                .arg(&src)
                .args(["-O1", "-o"])
                .arg(&exe)
                .env("FWP_FREE", free),
        );
        let out = checked(
            Command::new(&exe)
                .env("FWP_GC_STATS", "1")
                .env("FWP_REUSE_VERIFY", "0")
                .env("FWP_GC", "off"),
        );
        assert_eq!(out.stdout, reference.stdout);
        let stats = String::from_utf8_lossy(&out.stderr);
        assert!(stats.contains("fwp gc: 0 collections"), "{stats}");
        freed.push(
            stats
                .split(" MiB freed by counts")
                .next()
                .unwrap()
                .rsplit('(')
                .next()
                .unwrap()
                .parse::<f64>()
                .unwrap(),
        );
    }
    assert!(
        freed[0] == 0.0 && freed[1] > 0.5,
        "text tree bytes freed: {freed:?}"
    );
    eprintln!(
        "text tree MiB freed by counts: {} -> {}",
        freed[0], freed[1]
    );
}

#[test]
fn text_conversion_scratch_stays_bounded_without_tracing() {
    let dir = Scratch::new("scratch");
    let src = dir.0.join("scratch-loop.fwp");
    std::fs::write(
        &src,
        r#"
size : I64 -> I64
size = rem 64 | add 1 | flip string.repeat "x"
    | fork add (string.chars | length)
        (fork add (string.codepoints | length) (string.to-bytes | bytes.to-list | length))
step : (I64, I64) -> Step[(I64, I64), I64]
step = if (.0 | eq 0) (.1 | Stop) (make { 0 = .0 | sub 1, 1 = fork add .1 (.0 | size) } | Again)
main = (10000, 0) | loop step | echo
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let expected = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
    let cfile = dir.0.join("scratch-loop.c");
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let current = std::fs::read_to_string(&cfile).unwrap();
    // Restore only the previous temporary-buffer lifetime. All result
    // ownership, counting and compilation flags remain identical.
    let mut retained = current.clone();
    for function in ["fwp_p_chars", "fwp_p_codepoints", "fwp_p_bytes_to_list"] {
        let start = retained.find(&format!("static V {function}(")).unwrap();
        let end = start + retained[start..].find("\n}\n").unwrap() + 3;
        let body = &retained[start..end];
        assert!(body.contains("fwp_mem_free(a);"), "{function}");
        let body = body.replace("fwp_mem_free(a);", "/* previous retained scratch buffer */");
        retained.replace_range(start..end, &body);
    }
    let mut heaps = Vec::new();
    for (name, source) in [("retained", retained), ("released", current)] {
        let exe = dir.0.join(name);
        fwp::cgen::compile_c(&source, &exe, "-O1").unwrap();
        let out = checked(
            Command::new(&exe)
                .env("FWP_GC", "off")
                .env("FWP_GC_STATS", "1"),
        );
        assert_eq!(out.stdout, expected.stdout, "{name}");
        let stats = String::from_utf8_lossy(&out.stderr);
        assert!(stats.contains("fwp gc: 0 collections"), "{stats}");
        let heap: f64 = stats
            .split("heap ")
            .nth(1)
            .unwrap()
            .split_whitespace()
            .next()
            .unwrap()
            .parse()
            .unwrap();
        heaps.push(heap);
    }
    assert!(
        heaps[0] > heaps[1] * 1.5,
        "retained/released heaps: {heaps:?}"
    );
    eprintln!(
        "text conversion heap MiB without tracing: {} -> {}",
        heaps[0], heaps[1]
    );
}
