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
fn closure_aliases_and_captures_under_stress() {
    let dir = Scratch::new("aliases");
    let src = dir.0.join("leaves.fwp");
    std::fs::write(
        &src,
        r#"
choose : I64 -> (String -> String)
choose = if (rem 2 | eq 0)
    (rem 8 | add 1 | flip string.repeat "x" | concat)
    (rem 8 | add 1 | flip string.repeat "y" | flip concat)
checks : (String -> String) -> (String, String, String)
checks = make { 0 = apply "A", 1 = apply "B", 2 = apply "C" }
three : String -> String -> String -> String
three = curry3 (fork concat .0 (fork concat .1 .2))
choose-three : I64 -> (String -> String -> String)
choose-three = if (rem 2 | eq 0)
    (rem 8 | add 1 | flip string.repeat "m" | three)
    (rem 8 | add 1 | flip string.repeat "n" | flip three)
partial-checks : (String -> String -> String) -> (String, String, String)
partial-checks = make { 0 = apply "A" | checks | .0, 1 = apply "B" | checks | .1, 2 = apply "C" | apply "D" }
returns-input : String -> String -> String
returns-input = const
choose-identity : I64 -> (String -> String)
choose-identity = if (rem 2 | eq 0) (const returns-input | apply "kept") (const id)
keep : String -> (String -> String, String)
keep = both (if (string.length | rem 2 | eq 0) concat (flip concat)) id
use-kept : (String -> String, String) -> (String, String)
use-kept = both (.0 | apply "!") .1
main = [
    3 | choose | checks | echo,
    4 | choose | checks | echo,
    3 | choose-three | partial-checks | echo,
    4 | choose-three | partial-checks | echo,
    3 | choose-identity | apply (read-all () | concat "input") | echo,
    4 | choose-identity | apply (read-all () | concat "input") | echo,
    read-all () | concat "héllo" | keep | use-kept | echo,
] | ignore
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
    for opt in ["-O1", "-O2"] {
        for stack in ["0", "1"] {
            let exe = dir.0.join(format!("closures{opt}-{stack}"));
            checked(
                Command::new(fwp)
                    .arg("build")
                    .arg(&src)
                    .args([opt, "-o"])
                    .arg(&exe)
                    .env("FWP_STACK", stack),
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
                    "{opt}, stack {stack}, reuse verification {verify}"
                );
            }
        }
    }
}

#[test]
fn escaping_closures_are_released_by_counts() {
    let dir = Scratch::new("counts");
    let src = dir.0.join("leaf-loop.fwp");
    std::fs::write(
        &src,
        r#"
choose : I64 -> (String -> String)
choose = if (rem 2 | eq 0)
    (rem 64 | add 1 | flip string.repeat "x" | concat)
    (rem 64 | add 1 | flip string.repeat "y" | flip concat)
size : I64 -> I64
size = choose | apply "!" | string.length
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
                .env("FWP_FREE", free)
                .env("FWP_STACK", "0"),
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
        freed[0] == 0.0 && freed[1] > 0.2,
        "closure bytes freed: {freed:?}"
    );
    eprintln!("closure MiB freed by counts: {} -> {}", freed[0], freed[1]);
}
