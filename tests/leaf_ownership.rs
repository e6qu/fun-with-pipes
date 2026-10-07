//! Leaf ownership: aliases must remain valid and short-lived copy results
//! should be released by counts while preserving pipe evaluation order.
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
        let p = std::env::temp_dir().join(format!("fwp-leaf-{}-{name}", std::process::id()));
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
fn leaf_aliases_and_copy_results_under_stress() {
    let dir = Scratch::new("aliases");
    let src = dir.0.join("leaves.fwp");
    std::fs::write(
        &src,
        r#"
checks : String -> (I64, I64, I64, I64, Bool, Bool, I64, I64, I64, I64)
checks = make {
    0 = string.length,
    1 = string.to-bytes | bytes.length,
    2 = pad-left 0 "x" | string.length,
    3 = replace "" "x" | string.length,
    4 = both id (pad-right 0 "x") | uncurry eq,
    5 = both (concat "x") id | fork eq .0 (.1 | concat "x"),
    6 = lower | string.to-bytes | bytes.slice 0 2 | bytes.length,
    7 = string.slice 1 2 | string.length,
    8 = string.reverse | string.length,
    9 = string.to-bytes | bytes.append ("!" | string.to-bytes) | bytes.length,
}
main = read-all () | concat "héllo" | trim | checks | echo
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
fn copied_leaves_are_released_by_counts() {
    let dir = Scratch::new("counts");
    let src = dir.0.join("leaf-loop.fwp");
    std::fs::write(
        &src,
        r#"
size : I64 -> I64
size = rem 64 | flip string.repeat "x" | trim | string.to-bytes | bytes.length
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
        freed[0] == 0.0 && freed[1] > 0.2,
        "leaf bytes freed: {freed:?}"
    );
    eprintln!("leaf MiB freed by counts: {} -> {}", freed[0], freed[1]);
}
