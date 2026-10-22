//! Fold transfers its accumulator while borrowing list elements and callbacks.
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
        let p = std::env::temp_dir().join(format!("fwp-fold-{}-{name}", std::process::id()));
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
fn accumulator_input_and_capture_aliases_under_collection() {
    let dir = Scratch::new("aliases");
    let src = dir.0.join("aliases.fwp");
    std::fs::write(
        &src,
        r#"
choose : I64 -> (String -> String -> String)
choose = if (rem 2 | eq 0)
    (const concat)
    (const (flip concat))
three : String -> String -> String -> String
three = curry3 (fork concat .0 (fork concat .1 .2))
keep : String -> (String, String)
keep = both (flip (fold concat) ["a", "b"]) id
function-step : (String -> String) -> String -> (String -> String)
function-step = curry (fork const .0 .1)
use-functions : List[String] -> (String, String)
use-functions = fold function-step (concat "kept") | both (apply "!") (apply "?")
main = [
    ["a", "b", "c"] | both (fold concat "seed") id | echo,
    ["a", "b", "c"] | both (fold const "seed") id | echo,
    ["a", "b", "c"] | both (fold (flip const) "seed") id | echo,
    ["a", "b", "c"] | fold (3 | choose) "seed" | echo,
    ["a", "b", "c"] | fold (4 | choose) "seed" | echo,
    ["a", "b"] | fold (three "prefix") "seed" | echo,
    [] | fold concat "empty" | echo,
    [1, 2, 3] | fold add 7 | echo,
    ["a", "b"] | use-functions | echo,
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
fn folded_accumulators_are_released_without_tracing() {
    let dir = Scratch::new("counts");
    let src = dir.0.join("loop.fwp");
    std::fs::write(
        &src,
        r#"
choose : I64 -> (String -> String -> String)
choose = if (rem 2 | eq 0)
    (const concat)
    (const (flip concat))
size : I64 -> I64
size = choose | flip fold "seed" | apply ["a", "b", "c"] | string.length
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
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&emitted)
            .env("FWP_STACK", "0"),
    );
    let owned = std::fs::read_to_string(emitted).unwrap();
    let start = owned.find("static V fwp_p_fold_own(").unwrap();
    let end = start + owned[start..].find("\n}\n").unwrap();
    let mut shared = owned.clone();
    shared.replace_range(
        start..end,
        &owned[start..end].replace(
            "z = fwp_apply_borrowed_prefix(f, 2, args, 1);",
            "z = fwp_rc_shared(fwp_apply_borrowed_prefix(f, 2, args, 1));",
        ),
    );
    // Captured HOFs also transfer accumulators through the owned entry.
    shared = shared
        .lines()
        .map(|line| {
            let trimmed = line.trim();
            if let Some(call) = trimmed
                .strip_prefix("z = ")
                .and_then(|s| s.strip_suffix(';'))
            {
                if call.starts_with("fwp_owned_entry") || call.starts_with("fwp_borrowed_fold") {
                    let indent = &line[..line.len() - line.trim_start().len()];
                    return format!("{indent}z = fwp_rc_shared({call});");
                }
            }
            line.to_string()
        })
        .collect::<Vec<_>>()
        .join("\n");
    assert_ne!(
        shared, owned,
        "old callback result-sharing boundary was not restored"
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
    eprintln!("fold MiB freed by counts: {freed:?}");
    assert!(freed[1] > freed[0] + 0.3, "{freed:?}");
}

#[test]
fn known_fold_callbacks_borrow_captures_and_elements_without_retain_traffic() {
    let dir = Scratch::new("borrowed-parameters");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    for (fold, ty, body) in [
        (
            "fold",
            "String -> I64 -> String -> I64",
            "if (fork eq .0 .2) (.1 | add 1) .1",
        ),
        (
            "fold-right",
            "String -> String -> I64 -> I64",
            "if (fork eq .0 .1) (.2 | add 1) .2",
        ),
    ] {
        let source = dir.0.join(format!("{fold}.fwp"));
        // Heap strings prevent literal constants from hiding reference traffic.
        // The callback only compares its capture/element and updates an integer.
        std::fs::write(&source, format!(r#"step : {ty}
step = curry3 ({body})
count : String -> List[String] -> I64
count = step | flip {fold} 0
main = (read-all () | concat "needle!", ["needle", "skip"] | map (concat "!")) | uncurry count | echo
"#)).unwrap();
        let reference = checked(
            Command::new(fwp)
                .args(["run", "--interp"])
                .arg(&source)
                .env("FWP_NO_OPT", "1"),
        );
        assert_eq!(reference.stdout, b"1\n");
        for stack in ["0", "1"] {
            let cfile = dir.0.join(format!("{fold}-{stack}.c"));
            checked(
                Command::new(fwp)
                    .arg("build")
                    .arg(&source)
                    .args(["--emit-c", "-o"])
                    .arg(&cfile)
                    .env("FWP_STACK", stack),
            );
            let emitted = std::fs::read_to_string(cfile).unwrap();
            assert_eq!(
                emitted.contains("/* direct callback captures without a closure */"),
                stack == "1",
                "{fold}/{stack}: callback representation"
            );
            let helpers: Vec<_> = emitted
                .lines()
                .filter_map(|line| {
                    line.strip_prefix("static V fwp_borrowed_fold")
                        .filter(|line| line.ends_with('{'))
                        .map(|line| line.split('(').next().unwrap())
                })
                .collect();
            assert!(
                !helpers.is_empty(),
                "{fold}: no callback body with borrowed parameters"
            );
            let retain = "static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) {";
            assert_eq!(emitted.matches(retain).count(), 1);
            let runtime = emitted
                .replace(
                    retain,
                    &format!("{retain}\n        if (probe_active) probe_retains++;"),
                )
                .replace(
                    "int main(int argc, char **argv)",
                    "int original_main(int argc, char **argv)",
                );
            for broken in [false, true] {
                let mut runtime = runtime.clone();
                for id in &helpers {
                    let call = format!("z = fwp_borrowed_fold{id}(args);");
                    assert_eq!(runtime.matches(&call).count(), 1);
                    let extra = if broken {
                        "fwp_rc_dup(args[0]); fwp_rc_drop(args[0]);"
                    } else {
                        ""
                    };
                    runtime = runtime.replace(&call, &format!("probe_retains=0; probe_active=1; {extra} {call} probe_active=0; if(probe_retains)_Exit(88); probe_calls++;"));
                }
                let code = format!("static unsigned probe_active,probe_retains,probe_calls;\n{runtime}\nint main(int argc,char **argv){{int status=original_main(argc,argv);if(!status && probe_calls!=2)return 89;return status;}}\n");
                for opt in ["-O1", "-O2"] {
                    let exe = dir
                        .0
                        .join(format!("borrowed-{fold}-{stack}-{broken}{opt}.exe"));
                    fwp::cgen::compile_c(&code, &exe, opt).unwrap();
                    let artifacts =
                        std::env::var_os("FWP_CALLBACK_CAPTURE_ARTIFACTS").map(PathBuf::from);
                    let stem = format!("{fold}-{stack}-{broken}{opt}");
                    if let Some(path) = &artifacts {
                        std::fs::create_dir_all(path).unwrap();
                        std::fs::write(path.join(format!("{stem}.c")), &code).unwrap();
                        std::fs::copy(&exe, path.join(format!("{stem}.exe"))).unwrap();
                    }
                    for gc in ["off", "on"] {
                        for poison in ["0", "1"] {
                            let output = Command::new(&exe)
                                .env("FWP_GC", gc)
                                .env("FWP_GC_STRESS", "1")
                                .env("FWP_GC_VERIFY", "1")
                                .env("FWP_REUSE_VERIFY", poison)
                                .output()
                                .unwrap();
                            assert_eq!(
                                output.status.code(),
                                Some(if broken { 88 } else { 0 }),
                                "{fold}/{stack}/{opt}/{gc}/{poison}/broken={broken}: {output:?}"
                            );
                            if !broken {
                                assert_eq!(output.stdout, reference.stdout);
                            }
                            if let Some(path) = &artifacts {
                                let observation = format!("{stem}-{gc}-{poison}");
                                std::fs::write(
                                    path.join(format!("{observation}.stdout")),
                                    &output.stdout,
                                )
                                .unwrap();
                                std::fs::write(
                                    path.join(format!("{observation}.stderr")),
                                    &output.stderr,
                                )
                                .unwrap();
                                std::fs::write(
                                    path.join(format!("{observation}.status")),
                                    format!("{:?}\n", output.status.code()),
                                )
                                .unwrap();
                            }
                        }
                    }
                }
            }
        }
    }
}
