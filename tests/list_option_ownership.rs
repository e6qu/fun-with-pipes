//! Optional list aliases own their outer node and typed selected reference.
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
        let p = std::env::temp_dir().join(format!("fwp-list-option-{}-{name}", std::process::id()));
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
fn optional_element_aliases_and_predicates_under_collection() {
    let dir = Scratch::new("aliases");
    let src = dir.0.join("aliases.fwp");
    std::fs::write(
        &src,
        r#"
choose : I64 -> (String -> Bool)
choose = if (rem 2 | eq 0)
    (rem 3 | show | eq)
    (rem 4 | show | eq)
has-text : (String -> String) -> Bool
has-text = apply "!" | string.length | gt 1
use-functions : List[String -> String] -> (Option[String], Option[String], List[String])
use-functions = make {
    0 = nth 1 | option.map (apply "!"),
    1 = find has-text | option.map (apply "?"),
    2 = map (apply ":"),
}
selected-found : List[String -> String] -> Option[String]
selected-found = find has-text | option.map (apply "!")
selected-nth : List[String -> String] -> Option[String]
selected-nth = nth 1 | option.map (apply "!")
stop : I64 -> Bool
stop = if (eq 0) (const True) (div 0 | gt 0)
main = [
    ["a", "héllo", "", "after"] | both (nth 1) id | echo,
    ["a", "héllo", "", "after"] | both (find (string.length | gt 1)) id | echo,
    "a b c" | words | nth 1 | option.map (concat "nth:") | echo,
    "a b c" | words | find (eq "b") | option.map (concat "find:") | echo,
    "a b c" | words | find (const True) | echo,
    "a b c" | words | find (const False) | echo,
    "a b c" | words | index-of "b" | echo,
    "a b c" | words | index-of "absent" | echo,
    ["a", "", "c"] | map concat | use-functions | echo,
    "a b c" | words | map concat | selected-nth | echo,
    "a b c" | words | map concat | selected-found | echo,
    ["0", "1", "2", "3"] | find (3 | choose) | echo,
    ["0", "1", "2", "3"] | find (4 | choose) | echo,
    [1, 2, 3] | nth 1 | echo,
    [1, 2, 3] | find (gt 1) | echo,
    [1, 2, 3] | index-of 2 | echo,
    ["a", "b"] | nth -1 | echo,
    ["a", "b"] | nth 20 | echo,
    ["a", "b"] | nth 0 | echo,
    [] | nth 1 | echo,
    [] | find (eq "empty") | echo,
    [] | index-of "empty" | echo,
    [0, 1] | find stop | echo,
] | ignore
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src),
    );
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
fn optional_aliases_are_released_without_tracing() {
    let dir = Scratch::new("counts");
    let src = dir.0.join("loop.fwp");
    std::fs::write(
        &src,
        r#"
choose : I64 -> (String -> Bool)
choose = if (rem 2 | eq 0)
    (rem 3 | show | eq)
    (rem 4 | show | eq)
size : I64 -> I64
size = rem 6 | flip nth ("0 1 2 3 4 5" | words) | option.map string.length | option.unwrap-or 0
found : I64 -> I64
found = both choose (const "0 1 2 3 4 5" | words) | uncurry find | option.map string.length | option.unwrap-or 0
index : I64 -> I64
index = rem 6 | show | flip index-of ("0 1 2 3 4 5" | words) | option.unwrap-or 0
step : (I64, I64) -> Step[(I64, I64), I64]
step = if (.0 | eq 0) (.1 | Stop)
    (make { 0 = .0 | sub 1, 1 = fork add .1 (.0 | fork add size (fork add found index)) } | Again)
main = (10000, 0) | loop step | echo
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src),
    );
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
    // Restore sharing only on executed Option-returning boundaries, including
    // captured/direct find helpers; keep all typed argument behavior identical.
    let mut changed = 0;
    let shared = owned
        .lines()
        .map(|line| {
            if line.contains("return result;")
                && (line.contains("V result = fwp_rc_fresh(fwp_p_nth(")
                    || line.contains("V result = fwp_rc_fresh(fwp_p_index_of(")
                    || line.contains("V result = fwp_rc_fresh(fwp_p_find_borrowed("))
            {
                changed += 1;
                line.replace("return result;", "return fwp_rc_shared(result);")
            } else if line.contains("result = fwp_rc_fresh(fwp_some(element));") {
                changed += 1;
                line.replace(
                    "result = fwp_rc_fresh(fwp_some(element));",
                    "result = fwp_rc_shared(fwp_rc_fresh(fwp_some(element)));",
                )
            } else {
                line.to_string()
            }
        })
        .collect::<Vec<_>>()
        .join("\n");
    assert!(
        changed >= 3,
        "missing optional-result boundaries: {changed}"
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
    eprintln!("optional alias graph MiB freed by counts: {freed:?}");
    assert!(freed[1] > freed[0] + 0.3, "{freed:?}");
}
