//! Escaping closures transfer captures by type and keep retained aliases valid.
use std::path::PathBuf;
use std::process::{Command, Output};

#[path = "support/allocation_report.rs"]
mod allocation_report;

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
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src),
    );
    for mode in ["arc", "tracing"] {
        let stress = if mode == "arc" { "0" } else { "1" };
        for opt in ["-O1", "-O2"] {
            for stack in ["0", "1"] {
                let exe = dir.0.join(format!("closures-{mode}{opt}-{stack}.exe"));
                checked(
                    Command::new(fwp)
                        .args(["build", "--gc", mode, "--memory", "dynamic"])
                        .arg(&src)
                        .args([opt, "-o"])
                        .arg(&exe)
                        .env("FWP_STACK", stack),
                );
                for verify in if mode == "arc" {
                    &["0"][..]
                } else {
                    &["0", "1"][..]
                } {
                    let native = checked(
                        Command::new(&exe)
                            .env("FWP_GC", if mode == "arc" { "off" } else { "on" })
                            .env("FWP_ALLOC_STATS", "0")
                            .env("FWP_GC_STRESS", stress)
                            .env("FWP_GC_VERIFY", stress)
                            .env("FWP_REUSE_VERIFY", verify),
                    );
                    assert_eq!(
                        native.stdout, reference.stdout,
                        "{mode} {opt} stack {stack} verification {verify}"
                    );
                    assert_eq!(native.stderr, reference.stderr);
                }
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
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src),
    );
    let mut freed = Vec::new();
    for free in ["0", "1"] {
        let exe = dir.0.join(format!("loop-{free}.exe"));
        checked(
            Command::new(fwp)
                .args(["build", "--memory", "dynamic"])
                .arg(&src)
                .args(["-O1", "-o"])
                .arg(&exe)
                .env("FWP_FREE", free)
                .env("FWP_STACK", "0"),
        );
        let out = checked(
            Command::new(&exe)
                .env("FWP_ALLOC_STATS", "1")
                .env("FWP_REUSE_VERIFY", "0"),
        );
        assert_eq!(out.stdout, reference.stdout);
        let stats = String::from_utf8_lossy(&out.stderr);

        freed.push(
            allocation_report::parse(&stats)
                .expect("allocation report")
                .released as f64
                / 1_048_576.0,
        );
    }
    assert!(
        freed[0] == 0.0 && freed[1] > 0.2,
        "closure bytes freed: {freed:?}"
    );
    eprintln!("closure MiB freed by counts: {} -> {}", freed[0], freed[1]);
    let cfile = dir.0.join("arc-counts.c");
    checked(
        Command::new(fwp)
            .args(["build", "--memory", "dynamic"])
            .arg(&src)
            .args(["--emit-c", "-O2", "-o"])
            .arg(&cfile)
            .env("FWP_STACK", "0"),
    );
    let emitted = std::fs::read_to_string(&cfile).unwrap();
    let release = "if (!duplicate) { fwp_rc_free_obj(v); }";
    assert!(emitted.contains(release));
    let missing = emitted.replace(release, "/* omit consumed closure storage release */");
    let probe = r#"
int main(int argc,char **argv){
 int result=original_main(argc,argv);if(result)return result;
 if(fwp_heap.live!=0||fwp_heap.rc_wide_len)return 90;
 return 0;
}
"#;
    for opt in ["-O1", "-O2"] {
        let exe = dir.0.join(format!("arc-counts{opt}.exe"));
        for (case, source, expected) in [("normal", &emitted, 0), ("missing-release", &missing, 90)]
        {
            let code = format!(
                "{}\n{probe}",
                source.replace(
                    "int main(int argc, char **argv)",
                    "int original_main(int argc, char **argv)"
                )
            );
            fwp::cgen::compile_c(&code, &exe, opt).unwrap();
            let output = Command::new(&exe)
                .env("FWP_ALLOC_STATS", "0")
                .env("FWP_GC_STRESS", "0")
                .env("FWP_GC_VERIFY", "0")
                .env("FWP_REUSE_VERIFY", "0")
                .output()
                .unwrap();
            record_probe::save(
                "closure_ownership",
                &format!("arc{opt}-{case}"),
                &code,
                &exe,
                &output,
            );
            assert_eq!(
                output.status.code(),
                Some(expected),
                "{opt} {case}: {output:?}"
            );
            assert_eq!(output.stdout, reference.stdout);
            assert!(output.stderr.is_empty(), "{output:?}");
        }
    }
}

#[test]
fn fixed_function_values_preserve_aliases_and_effect_order() {
    let dir = Scratch::new("fixed-functions");
    let source = PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("tests/run/static_functions.fwp");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let expected = include_str!("run/static_functions.out");
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    assert_eq!(reference.stdout, expected.as_bytes());
    for optimized in [false, true] {
        for mode in ["tracing", "arc"] {
            let cfile = dir.0.join(format!("fixed-{mode}-{optimized}.c"));
            let mut command = Command::new(fwp);
            command
                .args([
                    "build", "--gc", mode, "--memory", "dynamic", "--emit-c", "-O2", "-o",
                ])
                .arg(&cfile)
                .arg(&source)
                .env("FWP_STACK", "0");
            if !optimized {
                command.env("FWP_NO_OPT", "1");
            }
            checked(&mut command);
            let code = std::fs::read_to_string(&cfile).unwrap();
            assert!(
                code.contains("static fwp_clo fwp_static_function"),
                "no fixed function values emitted"
            );
            for opt in ["-O1", "-O2"] {
                let binary = dir.0.join(format!("fixed-{mode}-{optimized}{opt}.exe"));
                fwp::cgen::compile_c(&code, &binary, opt).unwrap();
                let stress = if mode == "tracing" { "1" } else { "0" };
                let result = checked(
                    Command::new(&binary)
                        .env("FWP_GC", if mode == "arc" { "off" } else { "on" })
                        .env("FWP_ALLOC_STATS", "0")
                        .env("FWP_GC_STRESS", stress)
                        .env("FWP_GC_VERIFY", stress)
                        .env("FWP_REUSE_VERIFY", stress),
                );
                assert_eq!(result.stdout, reference.stdout, "{mode}/{optimized}/{opt}");
            }
        }
    }
}
