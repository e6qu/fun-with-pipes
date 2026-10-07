//! Prefix callbacks borrow; selected elements and returned tails own references.
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
        let p = std::env::temp_dir().join(format!("fwp-prefix-{}-{name}", std::process::id()));
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
fn prefix_and_suffix_aliases_under_collection() {
    let dir = Scratch::new("aliases");
    let src = dir.0.join("aliases.fwp");
    std::fs::write(
        &src,
        r#"
choose : I64 -> (String -> Bool)
choose = if (rem 2 | eq 0)
    (rem 3 | show | eq)
    (rem 4 | show | eq)
keep : String -> (List[String], List[String])
keep = eq | both (flip take-while ["input", "input", "b"])
    (flip drop-while ["input", "input", "b"])
has-text : (String -> String) -> Bool
has-text = apply "!" | string.length | gt 1
use-functions : List[String -> String] -> (List[String], List[String], List[String])
use-functions = make {
    0 = take-while has-text | map (apply "!"),
    1 = drop-while has-text | map (apply "?"),
    2 = map (apply "."),
}
stop : I64 -> Bool
stop = if (eq 0) (const False) (div 0 | gt 0)
main = [
    ["a", "héllo", "", "after"] | both (take-while (string.length | gt 0)) id | echo,
    ["a", "héllo", "", "after"] | both (drop-while (string.length | gt 0)) id | echo,
    ["a", "a", "b", "a"] | both (take-while (eq "a")) (drop-while (eq "a")) | echo,
    ["a", "", "c"] | map concat | use-functions | echo,
    ["0", "1", "2", "3"] | take-while (3 | choose) | echo,
    ["0", "1", "2", "3"] | drop-while (4 | choose) | echo,
    [] | take-while (eq "empty") | echo,
    [] | drop-while (eq "empty") | echo,
    ["a", "b"] | both (take-while (const True)) (drop-while (const True)) | echo,
    ["a", "b"] | both (take-while (const False)) (drop-while (const False)) | echo,
    "a b c" | words | drop-while (eq "a") | map (concat "suffix:") | echo,
    "a b c" | words | take-while (const True) | map (concat "prefix:") | echo,
    [0, 1] | take-while stop | echo,
    [0, 1] | drop-while stop | echo,
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
fn prefixes_and_suffixes_are_released_without_tracing() {
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
size = both choose (const "0 0 0 0 0 0 1" | words) | uncurry take-while | score
suffix : I64 -> I64
suffix = both choose (const "0 0 0 0 0 0 1" | words) | uncurry drop-while | score
step : (I64, I64) -> Step[(I64, I64), I64]
step = if (.0 | eq 0) (.1 | Stop)
    (make { 0 = .0 | sub 1, 1 = fork add .1 (.0 | fork add size suffix) } | Again)
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
    // Restore suffix sharing in generic, direct and captured specialization
    // paths; the generated HOF helpers return xs only for drop-while.
    assert!(shared.contains("fwp_rc_dup(xs);"));
    shared = shared.replace("fwp_rc_dup(xs);", "fwp_rc_share(xs);");
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
    eprintln!("prefix/suffix graph MiB freed by counts: {freed:?}");
    assert!(freed[1] > freed[0] + 0.3, "{freed:?}");
}
