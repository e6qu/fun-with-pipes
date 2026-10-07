//! Plain list copies own typed element references and retain borrowed suffixes.
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
        let p = std::env::temp_dir().join(format!("fwp-list-copy-{}-{name}", std::process::id()));
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
fn copied_spines_and_suffix_aliases_under_collection() {
    let dir = Scratch::new("aliases");
    let src = dir.0.join("aliases.fwp");
    std::fs::write(
        &src,
        r#"
views : List[String] -> (List[String], List[String], List[String], List[String], List[String])
views = make { 0 = reverse, 1 = take 2, 2 = drop 2, 3 = append ["tail"], 4 = id }
use-functions : List[String -> String] -> (List[String], List[String], List[String], List[String])
use-functions = make {
    0 = reverse | map (apply "!"),
    1 = take 2 | append [concat "tail"] | map (apply "?"),
    2 = drop 1 | map (apply "."),
    3 = map (apply ":"),
}
main = [
    ["a", "héllo", "", "after"] | views | echo,
    "a b c" | words | reverse | map (concat "rev:") | echo,
    "a b c" | words | take 2 | map (concat "take:") | echo,
    "a b c" | words | drop 2 | map (concat "drop:") | echo,
    "a b c" | words | append ("d e" | words) | map (concat "append:") | echo,
    ["a", "", "c"] | map concat | use-functions | echo,
    ["a b", "", "c d"] | map words | both flatten id | echo,
    ["a b", "c d"] | map words | flatten | map (concat "flat:") | echo,
    ["a b", "", "c"] | map (words | map concat) | flatten | map (apply "!") | echo,
    [1, 2, 3] | both reverse (take 2) | echo,
    ["a", "b"] | both (take -1) (drop -1) | echo,
    ["a", "b"] | both (take 20) (drop 20) | echo,
    ["a", "b"] | both (take 0) (drop 0) | echo,
    [] | append ["tail"] | echo,
    ["a", "b"] | append [] | echo,
    [] | reverse | echo,
    [] | take 1 | echo,
    [] | drop 1 | echo,
    [[], []] | flatten | echo,
    [] | flatten | echo,
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
fn list_copies_and_suffixes_are_released_without_tracing() {
    let dir = Scratch::new("counts");
    let src = dir.0.join("loop.fwp");
    std::fs::write(
        &src,
        r#"
score : List[String] -> I64
score = fork add length (head | option.map string.length | option.unwrap-or 0)
size : I64 -> I64
size = rem 4 | add 1 | flip take ("a b c d e f" | words) | reverse | append ("g h" | words) | drop 1 | score
flat : I64 -> I64
flat = rem 3 | add 1 | flip take ["a b c", "d e", "f"] | map words | flatten | score
step : (I64, I64) -> Step[(I64, I64), I64]
step = if (.0 | eq 0) (.1 | Stop)
    (make { 0 = .0 | sub 1, 1 = fork add .1 (.0 | fork add size flat) } | Again)
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
            if ["reverse", "take", "append", "flatten"]
                .iter()
                .any(|name| line.contains(&format!("V result = fwp_p_{name}_copied(l")))
            {
                changed += 1;
                line.replace("return result;", "return fwp_rc_shared(result);")
            } else if line.contains("return fwp_p_drop_owned(l0, l1);") {
                changed += 1;
                line.replace(
                    "return fwp_p_drop_owned(l0, l1);",
                    "return fwp_rc_shared(fwp_p_drop_owned(l0, l1));",
                )
            } else {
                line.to_string()
            }
        })
        .collect::<Vec<_>>()
        .join("\n");
    assert!(
        changed >= 5,
        "missing copied-spine or suffix boundaries: {changed}"
    );
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
    eprintln!("list copy/suffix graph MiB freed by counts: {freed:?}");
    assert!(freed[1] > freed[0] + 0.3, "{freed:?}");
}
