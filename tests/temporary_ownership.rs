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

#[test]
fn borrowed_constructor_temporaries_release_their_children() {
    let dir = Scratch::new("temporaries");
    let src = dir.0.join("temporary-loop.fwp");
    std::fs::write(
        &src,
        r#"
choose : I64 -> (String -> String)
choose = if (rem 2 | eq 0)
    (rem 64 | add 1 | flip string.repeat "x" | concat)
    (rem 64 | add 1 | flip string.repeat "y" | flip concat)
size : I64 -> I64
size = choose | singleton | length
step : (I64, I64) -> Step[(I64, I64), I64]
step = if (.0 | eq 0) (.1 | Stop)
    (make { 0 = .0 | sub 1, 1 = fork add .1 (.0 | size) } | Again)
main = (10000, 0) | loop step | echo
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
    let cfile = dir.0.join("temporaries.c");
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile)
            .env("FWP_STACK", "0"),
    );
    let current = std::fs::read_to_string(&cfile).unwrap();
    let start = current
        .find("/* List[String -> String] */\nstatic void fwp_drop")
        .expect("concrete list drop");
    let helper = current[start..]
        .lines()
        .nth(1)
        .unwrap()
        .strip_prefix("static void ")
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    // Restore only the old unknown temporary's outer count decrement.
    let pattern = format!("{helper}(l");
    assert!(current.contains(&pattern), "concrete temporary release");
    let unknown = current.replace(&pattern, "fwp_rc_drop(l");
    let mut freed = Vec::new();
    for (name, source) in [("unknown", unknown), ("typed", current)] {
        let exe = dir.0.join(name);
        fwp::cgen::compile_c(&source, &exe, "-O1").unwrap();
        let out = checked(
            Command::new(&exe)
                .env("FWP_GC", "off")
                .env("FWP_GC_STATS", "1"),
        );
        assert_eq!(out.stdout, reference.stdout);
        let stats = String::from_utf8_lossy(&out.stderr);
        assert!(stats.contains("fwp gc: 0 collections"), "{stats}");
        let count: f64 = stats
            .split(" MiB freed by counts")
            .next()
            .unwrap()
            .rsplit('(')
            .next()
            .unwrap()
            .parse()
            .unwrap();
        freed.push(count);
    }
    assert!(freed[1] > freed[0] + 0.3, "unknown/typed frees: {freed:?}");
    eprintln!(
        "temporary children MiB freed by counts: {} -> {}",
        freed[0], freed[1]
    );
}

#[test]
fn retained_children_survive_borrowed_constructor_cleanup() {
    let dir = Scratch::new("aliases");
    let src = dir.0.join("temporary-aliases.fwp");
    std::fs::write(
        &src,
        r#"
choose : I64 -> (String -> String)
choose = if (rem 2 | eq 0)
    (rem 8 | add 1 | flip string.repeat "x" | concat)
    (rem 8 | add 1 | flip string.repeat "y" | flip concat)
checks : (String -> String, List[String -> String]) -> (String, I64)
checks = both (.0 | apply "!") (.1 | length)
keep : (String -> String) -> (String -> String, List[String -> String])
keep = both id singleton
main = [
    3 | choose | keep | checks | echo,
    4 | choose | keep | checks | echo,
    ["copied" | concat "leaf"] | length | echo,
    Some ("optional" | concat "leaf") | option.is-some | echo,
] | ignore
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
    for opt in ["-O1", "-O2"] {
        let exe = dir.0.join(opt);
        checked(
            Command::new(fwp)
                .arg("build")
                .arg(&src)
                .args([opt, "-o"])
                .arg(&exe),
        );
        for poison in ["0", "1"] {
            let out = checked(
                Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison),
            );
            assert_eq!(out.stdout, reference.stdout, "{opt}, poison {poison}");
        }
    }
}
