//! Stack arguments release heap children while returned aliases retain their owners.
use std::path::PathBuf;
use std::process::{Command, Output};

#[path = "support/ownership_ledger.rs"]
mod ownership_ledger;
#[path = "support/record_probe.rs"]
mod record_probe;

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

const STACK_CASES: &[(&str, &str)] = &[
    (
        "variant",
        r#"
consume : Option[String] -> I64
consume = match
    None -> 0
    Some _ -> string.length | add 1 | mul 2 | sub 1 | rem 1000003
        | add 7 | mul 5 | rem 999983 | add 11 | mul 13 | rem 999983
        | add 1 | mul 2 | sub 1 | rem 1000003 | add 7 | mul 5
        | rem 999983 | add 11 | mul 13 | rem 999983
score : Option[String] -> I64
score = fork add consume (consume | mul 2 | rem 1009)
size : I64 -> I64
size = rem 64 | add 1 | flip string.repeat "x" | Some | score
"#,
    ),
    (
        "closure",
        r#"
rec twice : (String -> String) -> String -> String
twice = curry (fork apply (fork apply .1 .0) .0)
size : I64 -> I64
size = fork twice (rem 64 | add 1 | flip string.repeat "x" | concat) (const "!") | string.length
"#,
    ),
];

fn omit_stack_child_releases(current: &str) -> String {
    let mut retained = String::new();
    let mut skip = false;
    let mut releases = 0;
    for line in current.lines() {
        if skip {
            assert!(line.trim_start().starts_with("fwp_drop"), "{line}");
            retained.push_str("/* omitted stack child release */\n");
            skip = false;
            releases += 1;
            continue;
        }
        retained.push_str(line);
        retained.push('\n');
        skip = line.contains("/* stack argument child */");
    }
    assert!(
        releases > 0 && !skip,
        "stack child release was not generated"
    );
    retained
}

#[test]
fn stack_child_releases_are_checked_without_tracing_or_retained_storage() {
    let dir = Scratch::new("arc-stack-children");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    for (name, functions) in STACK_CASES {
        for rounds in [8, 1024] {
            let src = dir.0.join(format!("{name}-{rounds}.fwp"));
            std::fs::write(
                &src,
                format!(
                    r#"{functions}
step : (I64, I64) -> Step[(I64, I64), I64]
step = if (.0 | eq 0) (.1 | Stop)
    (make {{ 0 = .0 | sub 1, 1 = fork add .1 (.0 | size) }} | Again)
main = ({rounds}, 0) | loop step | echo
"#
                ),
            )
            .unwrap();
            let reference = checked(
                Command::new(fwp)
                    .env("FWP_NO_OPT", "1")
                    .args(["run", "--interp"])
                    .arg(&src),
            );
            for memory in ["dynamic", "static"] {
                let cfile = dir.0.join("stack.c");
                checked(
                    Command::new(fwp)
                        .env_remove("FWP_NO_OPT")
                        .env("FWP_STACK", "1")
                        .args(["build", "--gc", "arc", "--memory", memory, "--emit-c"])
                        .arg(&src)
                        .arg("-o")
                        .arg(&cfile),
                );
                let current = std::fs::read_to_string(&cfile).unwrap();
                let current = ownership_ledger::instrument_native(&current, 1 << 16);
                let observation = "    owner_ledger_finish();\n";
                assert_eq!(current.matches(observation).count(), 1);
                let current = current.replace(observation, &format!("{observation}    if (fwp_gc.ncollect || fwp_gc.enabled || fwp_gc.budget < fwp_gc.budget_given) owner_ledger_error(207, \"unreclaimed stack-child bytes\");\n"));
                let retained = omit_stack_child_releases(&current);
                for opt in ["-O1", "-O2"] {
                    for (case, code, status) in
                        [("normal", &current, 0), ("missing-child", &retained, 205)]
                    {
                        let label = format!("{name}-{memory}-{rounds}{opt}-{case}");
                        let exe = dir.0.join(format!("{label}.exe"));
                        fwp::cgen::compile_c(code, &exe, opt).unwrap();
                        let out = Command::new(&exe)
                            .env("FWP_GC", "off")
                            .env("FWP_GC_STATS", "0")
                            .env("FWP_GC_STRESS", "0")
                            .env("FWP_GC_VERIFY", "0")
                            .env("FWP_REUSE_VERIFY", "0")
                            .output()
                            .unwrap();
                        record_probe::save("stack_ownership", &label, code, &exe, &out);
                        assert_eq!(out.status.code(), Some(status), "{label}: {out:?}");
                        if status == 0 {
                            assert_eq!(out.stdout, reference.stdout, "{label}");
                            assert_eq!(out.stderr, reference.stderr, "{label}");
                        } else {
                            assert!(
                                String::from_utf8_lossy(&out.stderr)
                                    .contains("live allocations remain after ownership cleanup"),
                                "{label}: {out:?}"
                            );
                        }
                    }
                }
            }
        }
    }
}

#[test]
fn temporary_stack_arguments_release_owned_children() {
    let dir = Scratch::new("stack-children");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    for (name, functions) in STACK_CASES {
        let src = dir.0.join(format!("{name}.fwp"));
        std::fs::write(
            &src,
            format!(
                r#"{functions}
step : (I64, I64) -> Step[(I64, I64), I64]
step = if (.0 | eq 0) (.1 | Stop)
    (make {{ 0 = .0 | sub 1, 1 = fork add .1 (.0 | size) }} | Again)
main = (10000, 0) | loop step | echo
"#
            ),
        )
        .unwrap();
        let expected = checked(
            Command::new(fwp)
                .env("FWP_NO_OPT", "1")
                .args(["run", "--interp"])
                .arg(&src),
        );
        let cfile = dir.0.join(format!("{name}.c"));
        checked(
            Command::new(fwp)
                .args(["build", "--gc", "tracing"])
                .arg(&src)
                .args(["--emit-c", "-o"])
                .arg(&cfile),
        );
        let current = std::fs::read_to_string(&cfile).unwrap();
        let retained = omit_stack_child_releases(&current);
        let mut freed = Vec::new();
        for (label, source) in [("retained", retained), ("released", current)] {
            let exe = dir.0.join(format!("{name}-{label}.exe"));
            fwp::cgen::compile_c(&source, &exe, "-O1").unwrap();
            let out = checked(
                Command::new(&exe)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STATS", "1"),
            );
            assert_eq!(out.stdout, expected.stdout);
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
            freed[1] > freed[0] + 0.2,
            "{name}: retained/released frees {freed:?}"
        );
        eprintln!(
            "{name} stack child MiB freed by counts: {} -> {}",
            freed[0], freed[1]
        );
    }
}

#[test]
fn stack_children_and_returned_aliases_under_collection() {
    let dir = Scratch::new("stack-aliases");
    let src = dir.0.join("aliases.fwp");
    std::fs::write(
        &src,
        r#"
rec extract : Option[String] -> String
extract = match
    None -> "empty"
    Some _ -> if (string.length | eq 0) (const None | extract) id
rec pair : (String -> String) -> String -> (String, String)
pair = curry (make { 0 = fork apply .1 .0, 1 = .0 | apply "!" })
rec optional : (String -> String) -> String -> Option[String]
optional = curry (fork apply .1 .0 | Some)
use-twice : String -> (String, String)
use-twice = concat | both (apply "A") (apply "B")
main = [
    read-all () | concat "héllo" | both (Some | extract) id | echo,
    pair (read-all () | concat "P" | concat) "X" | both (.0 | string.length) .1 | echo,
    optional (read-all () | concat "Q" | concat) "Y" | option.unwrap-or "missing" | echo,
    read-all () | concat "local" | use-twice | echo,
] | ignore
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let expected = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src),
    );
    for memory in ["arc", "tracing"] {
        let cfile = dir.0.join(format!("{memory}.c"));
        checked(
            Command::new(fwp)
                .env_remove("FWP_NO_OPT")
                .env("FWP_STACK", "1")
                .args(["build", "--gc", memory, "--memory", "dynamic", "--emit-c"])
                .arg(&src)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(&cfile).unwrap();
        let code = if memory == "arc" {
            ownership_ledger::instrument_native(&code, 1 << 16)
        } else {
            code
        };
        for opt in ["-O1", "-O2"] {
            let exe = dir.0.join(format!("{memory}{opt}.exe"));
            fwp::cgen::compile_c(&code, &exe, opt).unwrap();
            for poison in if memory == "arc" {
                &["0"][..]
            } else {
                &["0", "1"][..]
            } {
                let stress = if memory == "arc" { "0" } else { "1" };
                let out = Command::new(&exe)
                    .env("FWP_GC", if memory == "arc" { "off" } else { "on" })
                    .env("FWP_GC_STATS", "0")
                    .env("FWP_GC_STRESS", stress)
                    .env("FWP_GC_VERIFY", stress)
                    .env("FWP_REUSE_VERIFY", poison)
                    .output()
                    .unwrap();
                let label = format!("aliases-{memory}{opt}-poison{poison}");
                record_probe::save("stack_ownership", &label, &code, &exe, &out);
                assert!(out.status.success(), "{label}: {out:?}");
                assert_eq!(out.stdout, expected.stdout, "{label}");
                assert_eq!(out.stderr, expected.stderr, "{label}");
            }
        }
    }
}
