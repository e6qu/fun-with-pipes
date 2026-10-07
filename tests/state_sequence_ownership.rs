//! Scan and iterate preserve owned earlier states while borrowing callbacks.
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
        let p =
            std::env::temp_dir().join(format!("fwp-state-sequence-{}-{name}", std::process::id()));
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
fn state_sequences_preserve_aliases_under_collection() {
    let dir = Scratch::new("aliases");
    let src = dir.0.join("aliases.fwp");
    std::fs::write(
        &src,
        r#"
trace-step : String -> String ! {IO}
trace-step = both echo id | .1 | concat "!"
trace-scan : String -> String -> String ! {IO}
trace-scan = const trace-step
main = [
    "a b c" | words | both (scan concat "start:") id | echo,
    "a b c" | words | scan const "unchanged" | map (concat "state:") | echo,
    "a b c" | words | scan (flip const) "first" | echo,
    "a b c" | words | scan trace-scan "trace:" | echo,
    [] | scan concat "empty" | echo,
    scan concat ("a b" | words | join "") [] | echo,
    iterate 1 id ("a b" | words | join "") | echo,
    "seed" | both (iterate 5 (concat "!")) id | echo,
    "seed" | iterate 5 id | map (concat "alias:") | echo,
    "seed" | iterate 3 trace-step | echo,
    "seed" | iterate 1 trace-step | echo,
    "seed" | iterate 0 trace-step | echo,
    "seed" | iterate -1 trace-step | echo,
    iterate 4 id (concat "capture:") | map (apply "!") | echo,
    scan (flip const) (concat "initial:") (["a", "b", "c"] | map concat) | map (apply "!") | echo,
    [1, 2, 3] | scan add 0 | echo,
    1 | iterate 4 (add 1) | echo,
] | ignore
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
    for opt in ["-O1", "-O2"] {
        for stack in ["0", "1"] {
            let exe = dir.0.join(format!("aliases{opt}-{stack}"));
            checked(
                Command::new(fwp)
                    .arg("build")
                    .arg(&src)
                    .args([opt, "-o"])
                    .arg(&exe)
                    .env("FWP_STACK", stack),
            );
            for poison in ["0", "1"] {
                let out = checked(
                    Command::new(&exe)
                        .env("FWP_GC_STRESS", "1")
                        .env("FWP_GC_VERIFY", "1")
                        .env("FWP_REUSE_VERIFY", poison),
                );
                assert_eq!(
                    out.stdout, reference.stdout,
                    "{opt}, stack {stack}, poison {poison}"
                );
            }
        }
    }
    for flag in ["FWP_REUSE", "FWP_FREE"] {
        let exe = dir.0.join(flag);
        checked(
            Command::new(fwp)
                .arg("build")
                .arg(&src)
                .args(["-O1", "-o"])
                .arg(&exe)
                .env(flag, "0"),
        );
        let out = checked(
            Command::new(&exe)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", "1"),
        );
        assert_eq!(out.stdout, reference.stdout, "{flag}=0");
    }
}

#[test]
fn state_sequences_are_released_without_tracing() {
    let dir = Scratch::new("counts");
    let src = dir.0.join("loop.fwp");
    std::fs::write(
        &src,
        r#"
score : List[String] -> I64
score = head | option.map string.length | option.unwrap-or 0
scan-size : I64 -> I64
scan-size = rem 4 | add 1 | flip take ("a b c d" | words) | scan concat "start:" | score
iterate-size : I64 -> I64
iterate-size = rem 4 | show | concat "seed:" | iterate 4 (concat "!") | score
step : (I64, I64) -> Step[(I64, I64), I64]
step = if (.0 | eq 0) (.1 | Stop)
    (make { 0 = .0 | sub 1, 1 = fork add .1 (.0 | fork add scan-size iterate-size) } | Again)
main = (10000, 0) | loop step | echo
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
    let emitted = dir.0.join("loop.c");
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&emitted)
            .env("FWP_STACK", "0"),
    );
    let owned = std::fs::read_to_string(&emitted).unwrap();
    // Restore result sharing only in the emitted monomorphic wrappers.
    // Scalar bits never become references in either version.
    let mut changed = 0;
    let shared = owned
        .lines()
        .map(|line| {
            if ["scan", "iterate"]
                .iter()
                .any(|name| line.contains(&format!("return fwp_p_{name}_owned(l")))
            {
                changed += 1;
                line.replacen("return ", "return fwp_rc_shared(", 1)
                    .replace(");", "));")
            } else {
                line.to_string()
            }
        })
        .collect::<Vec<_>>()
        .join("\n");
    assert!(changed == 2, "missing scan/iterate boundaries: {changed}");
    assert_ne!(shared, owned);
    let mut freed = Vec::new();
    for (name, code) in [("shared", &shared), ("owned", &owned)] {
        let exe = dir.0.join(name);
        fwp::cgen::compile_c(code, &exe, "-O1").unwrap();
        let out = checked(
            Command::new(&exe)
                .env("FWP_GC", "off")
                .env("FWP_GC_STATS", "1")
                .env("FWP_REUSE_VERIFY", "0"),
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
    eprintln!("state sequence graph MiB freed by counts: {freed:?}");
    assert!(freed[1] > freed[0] + 0.3, "{freed:?}");
}
