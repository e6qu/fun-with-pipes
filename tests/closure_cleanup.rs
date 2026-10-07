//! Escaping closures transfer captures by type and keep retained aliases valid.
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
        let p = std::env::temp_dir().join(format!("fwp-closure-{}-{name}", std::process::id()));
        std::fs::create_dir_all(&p).unwrap();
        Self(p)
    }
}
impl Drop for Scratch {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}

#[cfg(unix)]
#[test]
fn deep_capture_cleanup_uses_bounded_c_stack() {
    use std::os::unix::process::ExitStatusExt;
    for branching in [false, true] {
        let dir = Scratch::new("deep");
        let src = dir.0.join("deep.fwp");
        std::fs::write(
            &src,
            r#"
hold : (I64 -> I64) -> I64 -> I64
hold = curry (fork add (.0 | apply 0) .1)
step : (I64, I64 -> I64) -> Step[(I64, I64 -> I64), I64 -> I64]
step = if (.0 | eq 0) (.1 | Stop)
    (make { 0 = .0 | sub 1, 1 = .1 | hold } | Again)
discard : (I64 -> I64) -> I64
discard = const 1
main = discard (loop step (8000, add 1)) | echo
"#,
        )
        .unwrap();
        if branching {
            let source = std::fs::read_to_string(&src).unwrap()
            .replace("hold : (I64 -> I64) -> I64 -> I64\nhold = curry (fork add (.0 | apply 0) .1)",
                "hold : (I64 -> I64) -> (I64 -> I64) -> I64 -> I64\nhold = curry3 (fork add (.0 | apply 0) (fork add (.1 | apply 0) .2))")
            .replace("1 = .1 | hold", "1 = fork hold (.0 | add) .1");
            std::fs::write(&src, source).unwrap();
        }
        let fwp = env!("CARGO_BIN_EXE_fwp");
        let reference = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
        let cfile = dir.0.join("deep.c");
        checked(
            Command::new(fwp)
                .arg("build")
                .arg(&src)
                .args(["--emit-c", "-o"])
                .arg(&cfile)
                .env("FWP_STACK", "0"),
        );
        let current = std::fs::read_to_string(&cfile).unwrap();
        assert!(current.contains("static size_t fwp_main_stack = (size_t)1 << 30;"));
        let current = current.replace(
            "static size_t fwp_main_stack = (size_t)1 << 30;",
            "static size_t fwp_main_stack = (size_t)256 << 10;",
        );
        let start = current.find("static void fwp_closure_drop(V f) {").unwrap();
        let end = start + current[start..].find("\nstatic V fwp_apply_owned").unwrap();
        let mut recursive = current.clone();
        recursive.replace_range(
            start..end,
            r#"static void fwp_closure_drop(V f) {
    uint8_t *count = fwp_rc_slot(f);
    if (!count || !*count) return;
    if (*count > 1) { (*count)--; return; }
    const fwp_owned_fninfo *owned = fwp_fns[CLO(f)->fn].owned;
    if (!owned) fwp_trap("internal: owned closure without capture types");
    owned->captures(f, 0);
}
"#,
        );
        for (name, source) in [("recursive", recursive), ("bounded", current)] {
            let exe = dir.0.join(name);
            fwp::cgen::compile_c(&source, &exe, "-O0").unwrap();
            let out = Command::new("sh")
                .args(["-c", "ulimit -s 256; exec \"$1\"", "closure-stack"])
                .arg(&exe)
                .env("FWP_GC", "off")
                .env("FWP_GC_STATS", "1")
                .output()
                .unwrap();
            if name == "recursive" {
                assert!(
                    !out.status.success()
                        && (matches!(out.status.signal(), Some(7 | 10 | 11))
                            || out.stderr == b"fwp: trap: stack overflow\n"),
                    "recursive baseline did not exhaust the small stack: {:?}, {}",
                    out.status,
                    String::from_utf8_lossy(&out.stderr)
                );
            } else {
                assert!(
                    out.status.success(),
                    "{}",
                    String::from_utf8_lossy(&out.stderr)
                );
                assert_eq!(out.stdout, reference.stdout);
                let stats = String::from_utf8_lossy(&out.stderr);
                assert!(stats.contains("fwp gc: 0 collections"), "{stats}");
                let freed: f64 = stats
                    .split(" MiB freed by counts")
                    .next()
                    .unwrap()
                    .rsplit('(')
                    .next()
                    .unwrap()
                    .parse()
                    .unwrap();
                assert!(freed > if branching { 0.25 } else { 0.05 }, "{stats}");
            }
        }
    }
}
