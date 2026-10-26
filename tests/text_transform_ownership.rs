//! Unchanged strings transfer ownership; changed results preserve other aliases.
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

fn wrapper(code: &str, call: &str) -> String {
    let call = format!("V result = {call};");
    assert_eq!(code.matches(&call).count(), 1, "{call}");
    let at = code.find(&call).unwrap();
    let start = code[..at].rfind("static V f").unwrap() + "static V ".len();
    code[start..].split('(').next().unwrap().to_string()
}

#[test]
fn text_transformations_preserve_aliases_and_consumed_owners() {
    let dir = fwp::cgen::TempDir::new("text-transform").unwrap();
    let source = dir.join("text.fwp");
    std::fs::write(
        &source,
        include_str!("fixtures/text_transform_ownership.fwp"),
    )
    .unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let inputs = ["", "123 λ", " AbC, λ. ", "abc abc", "\tMiXeD\r\n"];
    let references: Vec<_> = inputs
        .iter()
        .map(|input| {
            let raw = checked(
                Command::new(compiler)
                    .env("FWP_NO_OPT", "1")
                    .env("FWP_TEXT_INPUT", input)
                    .args(["run", "--interp"])
                    .arg(&source),
            );
            let optimized = checked(
                Command::new(compiler)
                    .env_remove("FWP_NO_OPT")
                    .env("FWP_TEXT_INPUT", input)
                    .args(["run", "--interp"])
                    .arg(&source),
            );
            assert_eq!(
                (&raw.stdout, &raw.stderr),
                (&optimized.stdout, &optimized.stderr)
            );
            assert!(!raw.stdout.is_empty() && raw.stderr.is_empty());
            raw
        })
        .collect();
    for mode in ["arc", "tracing"] {
        let cfile = dir.join("text.c");
        checked(
            Command::new(compiler)
                .env_remove("FWP_NO_OPT")
                .args(["build", "--gc", mode, "--emit-c", "-O2"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(&cfile).unwrap();
        let calls = [
            ("TEXT_LOWER", "fwp_p_case(l0, 0)"),
            ("TEXT_UPPER", "fwp_p_case(l0, 1)"),
            ("TEXT_TRIM", "fwp_p_trim_impl(l0, 1, 1)"),
            ("TEXT_START", "fwp_p_trim_impl(l0, 1, 0)"),
            ("TEXT_END", "fwp_p_trim_impl(l0, 0, 1)"),
            ("TEXT_REPLACE", "fwp_p_replace(l0, l1, l2)"),
        ];
        let mut definitions = String::new();
        for (name, call) in calls {
            definitions.push_str(&format!("#define {name} {}\n", wrapper(&code, call)));
        }
        let lower = code
            .lines()
            .find(|line| line.contains("V result = fwp_p_case(l0, 0);"))
            .unwrap();
        let drop = lower
            .split("fwp_value_owner owner = {l0, ")
            .nth(1)
            .unwrap()
            .split('}')
            .next()
            .unwrap();
        definitions.push_str(&format!("#define TEXT_DROP {drop}\n"));
        let mut probe = code.replace("#define FWP_UNWIND 0", "#define FWP_UNWIND 1")
            .replace("int main(int argc, char **argv)", "int original_main(int argc, char **argv)")
            .replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic int text_force_trap;\nstatic uint64_t text_allocations;\nstatic void fwp_check_cancel(void);");
        for signature in [
            "static V fwp_p_case(V s, int upper) {",
            "static V fwp_p_trim_impl(V s, int start, int end) {",
            "static V fwp_p_replace(V from, V to, V s) {",
        ] {
            assert_eq!(probe.matches(signature).count(), 1);
            probe = probe.replace(
                signature,
                &format!("{signature}\n    if(text_force_trap==1)fwp_trap(\"text copy control\");\n    if(text_force_trap==2)fwp_check_cancel();"),
            );
        }
        let allocation = "static inline void *fwp_heap_alloc(size_t n, int kind) {";
        assert_eq!(probe.matches(allocation).count(), 1);
        probe = probe.replace(
            allocation,
            &format!("{allocation}\n    if(kind!=0)text_allocations++;"),
        );
        probe += &format!(
            "\n{definitions}\n{}",
            include_str!("fixtures/text_transform_probe.c")
        );
        let guard = "fwp_value_protect(&owner, &cleanup); V result = fwp_p_case(l0, 0);";
        assert_eq!(probe.matches(guard).count(), 1);
        let unprotected = probe.replace(guard, "if(!text_force_trap)fwp_value_protect(&owner, &cleanup); V result = fwp_p_case(l0, 0);");
        let unprotected_cancel = probe.replace(guard, "if(text_force_trap!=2)fwp_value_protect(&owner, &cleanup); V result = fwp_p_case(l0, 0);");
        for opt in ["-O0", "-O2"] {
            let binary = dir.join("text.exe");
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            for (input, reference) in inputs.iter().zip(&references) {
                let stress = if mode == "arc" { "0" } else { "1" };
                let actual = checked(
                    Command::new(&binary)
                        .env("FWP_TEXT_INPUT", input)
                        .env_remove("FWP_GC")
                        .env("FWP_GC_STRESS", stress)
                        .env("FWP_GC_VERIFY", stress)
                        .env("FWP_REUSE_VERIFY", stress),
                );
                assert_eq!(
                    (&actual.stdout, &actual.stderr),
                    (&reference.stdout, &reference.stderr),
                    "{mode} {opt} {input}"
                );
            }
            for (label, measured, status) in [
                ("protected", &probe, 0),
                ("missing-owner", &unprotected, 235),
                ("missing-cancel-owner", &unprotected_cancel, 235),
            ] {
                fwp::cgen::compile_c(measured, &binary, opt).unwrap();
                let actual = Command::new(&binary)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                assert_eq!(
                    actual.status.code(),
                    Some(status),
                    "{mode} {opt} {label}: {actual:?}"
                );
                assert!(actual.stderr.is_empty(), "{actual:?}");
                if status == 0 {
                    assert_eq!(
                        std::str::from_utf8(&actual.stdout)
                            .unwrap()
                            .lines()
                            .collect::<Vec<_>>(),
                        ["text owners transfer, preserve aliases and release on failure"]
                    );
                }
                if let Some(destination) = std::env::var_os("FWP_TEXT_TRANSFORM_ARTIFACTS") {
                    let destination = std::path::PathBuf::from(destination);
                    std::fs::create_dir_all(&destination).unwrap();
                    let stem = format!("{mode}-{}-{label}", &opt[1..]);
                    std::fs::write(destination.join(format!("{stem}.c")), measured).unwrap();
                    std::fs::copy(&binary, destination.join(format!("{stem}.bin"))).unwrap();
                    std::fs::write(destination.join(format!("{stem}.stdout")), actual.stdout)
                        .unwrap();
                }
            }
        }
    }
}

#[test]
fn large_counts_keep_small_results_without_wrapping_or_empty_repeat_work() {
    let dir = fwp::cgen::TempDir::new("count-boundaries").unwrap();
    let source = dir.join("counts.fwp");
    std::fs::write(&source, include_str!("fixtures/count_boundaries.fwp")).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    assert!(!reference.stdout.is_empty() && reference.stderr.is_empty());
    let optimized = checked(
        Command::new(compiler)
            .env_remove("FWP_NO_OPT")
            .args(["run", "--interp"])
            .arg(&source),
    );
    assert_eq!(
        (&optimized.stdout, &optimized.stderr),
        (&reference.stdout, &reference.stderr)
    );
    for mode in ["arc", "tracing"] {
        let cfile = dir.join("counts.c");
        checked(
            Command::new(compiler)
                .env_remove("FWP_NO_OPT")
                .args(["build", "--gc", mode, "--emit-c"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(cfile).unwrap();
        for opt in ["-O0", "-O2"] {
            let binary = dir.join("counts.exe");
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            let stress = if mode == "arc" { "0" } else { "1" };
            let actual = checked(
                Command::new(&binary)
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", stress)
                    .env("FWP_GC_VERIFY", stress)
                    .env("FWP_REUSE_VERIFY", stress),
            );
            assert_eq!(
                (&actual.stdout, &actual.stderr),
                (&reference.stdout, &reference.stderr),
                "{mode} {opt}"
            );
        }
    }
}

#[test]
fn string_size_checks_precede_allocation_and_empty_repeat_does_no_work() {
    let dir = fwp::cgen::TempDir::new("string-sizes").unwrap();
    let function = |source: &str, signature: &str| {
        let start = source.find(signature).unwrap();
        let end = start + source[start..].find("\n}").unwrap() + 2;
        source[start..end].to_string()
    };
    let code = include_str!("fixtures/string_size_probe.c")
        .replace(
            "/* STRING_CONSTRUCTOR */",
            &function(include_str!("../runtime/fwp_rt.c"), "static V fwp_str_new("),
        )
        .replace(
            "/* CONCAT */",
            &function(
                include_str!("../runtime/fwp_rt_prims.c"),
                "static V fwp_p_concat(",
            ),
        )
        .replace(
            "/* REPEAT */",
            &function(
                include_str!("../runtime/fwp_rt_prims.c"),
                "static V fwp_p_str_repeat(",
            ),
        );
    let missing_sizes = code
        .replace("len > SIZE_MAX - sizeof(fwp_str) - 1", "0")
        .replace(
            "STR(s)->len > limit || STR(t)->len > limit - STR(s)->len",
            "0",
        );
    let missing_empty = code.replace("if (!k || !STR(s)->len) return fwp_str_new(\"\", 0);", "");
    assert_ne!(missing_sizes, code);
    assert_ne!(missing_empty, code);
    for opt in ["-O0", "-O2"] {
        for (label, measured) in [
            ("checked", &code),
            ("missing-size", &missing_sizes),
            ("missing-empty", &missing_empty),
        ] {
            let source = dir.join("sizes.c");
            let binary = dir.join("sizes.exe");
            std::fs::write(&source, measured).unwrap();
            checked(
                Command::new(std::env::var_os("CC").unwrap_or_else(|| "cc".into()))
                    .args(["-std=c11", opt])
                    .arg(&source)
                    .arg("-o")
                    .arg(&binary),
            );
            if let Some(path) = std::env::var_os("FWP_TEXT_TRANSFORM_ARTIFACTS") {
                let path = std::path::PathBuf::from(path);
                std::fs::create_dir_all(&path).unwrap();
                let stem = format!("string-size-{label}{opt}");
                std::fs::write(path.join(format!("{stem}.c")), measured).unwrap();
                std::fs::copy(&binary, path.join(format!("{stem}.bin"))).unwrap();
            }
            for case in 0..6 {
                let expected = if case < 3 && label != "missing-size" {
                    125
                } else if case == 5 && label == "missing-empty" {
                    127
                } else {
                    126
                };
                let output = Command::new(&binary)
                    .arg(case.to_string())
                    .output()
                    .unwrap();
                assert_eq!(
                    output.status.code(),
                    Some(expected),
                    "{label} {opt} {case}: {output:?}"
                );
                assert!(output.stdout.is_empty() && output.stderr.is_empty());
            }
        }
    }
}
