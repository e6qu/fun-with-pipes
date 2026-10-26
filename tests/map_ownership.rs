//! Synchronous map owns list nodes and aliased callback results separately.
use std::path::PathBuf;
use std::process::{Command, Output};

#[path = "support/allocation_report.rs"]
mod allocation_report;

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
        let p = std::env::temp_dir().join(format!("fwp-map-{}-{name}", std::process::id()));
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
fn callback_input_capture_and_function_aliases_preserve_values() {
    let dir = Scratch::new("aliases");
    let src = dir.0.join("aliases.fwp");
    std::fs::write(
        &src,
        r#"
choose : I64 -> (String -> String)
choose = if (rem 2 | eq 0)
    (rem 8 | add 1 | flip string.repeat "x" | concat)
    (rem 8 | add 1 | flip string.repeat "y" | flip concat)
keep : String -> (List[String], String)
keep = both (const | flip map ["a", "b", "c"]) id
use-functions : List[String -> String] -> List[String]
use-functions = map (apply "!")
main = [
    ["a", "héllo", ""] | both (map id) id | echo,
    ["a", "b", "c"] | both (map (const "same")) id | echo,
    ["a", "b", "c"] | both (map concat | use-functions) id | echo,
    ["a", "b", "c"] | map (3 | choose) | echo,
    ["a", "b", "c"] | map (4 | choose) | echo,
    [1, 2, 3] | map (add 7) | echo,
    ["a", "b", "c"] | map (both id Some) | echo,
    [] | map (concat "empty") | echo,
    read-all () | concat "input" | keep | echo,
] | ignore
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(fwp)
            .args(["run", "--interp"])
            .arg(&src)
            .env("FWP_NO_OPT", "1"),
    );
    for opt in ["-O1", "-O2"] {
        for stack in ["0", "1"] {
            let exe = dir.0.join(format!("aliases{opt}-{stack}"));
            checked(
                Command::new(fwp)
                    .args(["build"])
                    .arg(&src)
                    .args([opt, "-o"])
                    .arg(&exe)
                    .env("FWP_STACK", stack),
            );

            let out = checked(&mut Command::new(&exe));
            assert_eq!(out.stdout, reference.stdout, "{opt}, stack {stack}");
        }
    }
}

#[test]
fn mapped_spines_and_aliases_are_released_without_tracing() {
    let dir = Scratch::new("counts");
    let src = dir.0.join("loop.fwp");
    std::fs::write(
        &src,
        r#"
choose : I64 -> (String -> String)
choose = if (rem 2 | eq 0)
    (rem 32 | add 1 | flip string.repeat "x" | concat)
    (rem 32 | add 1 | flip string.repeat "y" | flip concat)
score : List[String] -> I64
score = fork add length (head | option.map string.length | option.unwrap-or 0)
size : I64 -> I64
size = both (choose | flip map ["a", "b", "c"]) id | .0 | score
step : (I64, I64) -> Step[(I64, I64), I64]
step = if (.0 | eq 0) (.1 | Stop)
    (make { 0 = .0 | sub 1, 1 = fork add .1 (.0 | size) } | Again)
main = (10000, 0) | loop step | echo
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(fwp)
            .args(["run", "--interp"])
            .arg(&src)
            .env("FWP_NO_OPT", "1"),
    );
    let emitted = dir.0.join("loop.c");
    checked(
        Command::new(fwp)
            .args(["build"])
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&emitted)
            .env("FWP_STACK", "0"),
    );
    let owned = std::fs::read_to_string(&emitted).unwrap();
    let start = owned.find("static V fwp_map_finish_protected(").unwrap();
    let end = start + owned[start..].find("\n}\n").unwrap();
    let mut retained = owned.clone();
    retained.replace_range(
        start..end,
        &owned[start..end].replace("return result;", "fwp_rc_dup(result); return result;"),
    );
    assert_ne!(retained, owned, "missing extra result owner control");
    let mut freed = Vec::new();
    for (name, code) in [("retained", &retained), ("owned", &owned)] {
        let exe = dir.0.join(name);
        fwp::cgen::compile_c(code, &exe, "-O1").unwrap();
        let out = checked(Command::new(&exe).env("FWP_ALLOC_STATS", "1"));
        assert_eq!(out.stdout, reference.stdout);
        let stats = String::from_utf8_lossy(&out.stderr);

        let report = allocation_report::parse(&stats).expect("allocation report");
        if name == "owned" {
            assert_eq!(report.live, 0, "{name}: {report:?}");
        } else {
            assert!(
                report.live > 0,
                "ineffective retained-owner control: {name}: {report:?}"
            );
        }
        freed.push(report.released as f64 / 1_048_576.0);
    }
    eprintln!("mapped graph MiB freed by counts: {freed:?}");
    assert!(freed[1] > freed[0] + 1.0, "{freed:?}");
}
