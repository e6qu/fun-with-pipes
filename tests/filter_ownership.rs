//! Synchronous filter owns selected input references and new list nodes.
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
        let p = std::env::temp_dir().join(format!("fwp-filter-{}-{name}", std::process::id()));
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
fn selected_input_and_function_aliases_under_collection() {
    let dir = Scratch::new("aliases");
    let src = dir.0.join("aliases.fwp");
    std::fs::write(
        &src,
        r#"
choose : I64 -> (String -> Bool)
choose = if (rem 2 | eq 0)
    (rem 3 | show | eq)
    (rem 4 | show | eq)
keep : String -> (List[String], String)
keep = both (eq | flip filter ["a", "b", "input"]) id
has-text : (String -> String) -> Bool
has-text = apply "!" | string.length | gt 1
use-functions : List[String -> String] -> (List[String], List[String])
use-functions = both (filter has-text | map (apply "!")) (map (apply "?"))
main = [
    ["a", "héllo", ""] | both (filter (string.length | gt 0)) id | echo,
    ["a", "b", "a"] | both (filter (eq "a")) id | echo,
    ["a", "b", "c"] | map concat | use-functions | echo,
    ["0", "1", "2", "3"] | filter (3 | choose) | echo,
    ["0", "1", "2", "3"] | filter (4 | choose) | echo,
    [1, 2, 3] | filter (gt 1) | echo,
    [] | filter (eq "empty") | echo,
    ["a", "b"] | filter (const False) | echo,
    read-all () | concat "input" | keep | echo,
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
}

#[test]
fn filtered_spines_and_aliases_are_released_without_tracing() {
    let dir = Scratch::new("counts");
    let src = dir.0.join("loop.fwp");
    std::fs::write(
        &src,
        r#"
choose : I64 -> (String -> Bool)
choose = if (rem 2 | eq 0)
    (rem 3 | show | eq)
    (rem 4 | show | eq)
score : List[String] -> I64
score = fork add length (head | option.map string.length | option.unwrap-or 0)
size : I64 -> I64
size = both choose (const "0 1 2 3 4 5" | words) | uncurry filter | score
step : (I64, I64) -> Step[(I64, I64), I64]
step = if (.0 | eq 0) (.1 | Stop)
    (make { 0 = .0 | sub 1, 1 = fork add .1 (.0 | size) } | Again)
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
    let start = owned.find("static V fwp_map_finish_protected(").unwrap();
    let end = start + owned[start..].find("\n}\n").unwrap();
    let mut shared = owned.clone();
    shared.replace_range(
        start..end,
        &owned[start..end].replace("return result;", "return fwp_rc_shared(result);"),
    );
    assert_ne!(
        shared, owned,
        "previous shared-result boundary was not restored"
    );
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
    eprintln!("filtered graph MiB freed by counts: {freed:?}");
    assert!(freed[1] > freed[0] + 0.3, "{freed:?}");
}
