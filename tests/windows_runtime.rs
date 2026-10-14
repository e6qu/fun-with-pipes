//! Actual generated programs on native Windows, compared with raw execution.
#![cfg(windows)]
use std::path::Path;
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let result = command.output().unwrap();
    assert!(result.status.success(), "{command:?}: {result:?}");
    result
}

fn compare(source: &Path, dir: &Path, expected_exit: i32) {
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let expected = Command::new(compiler)
        .env("FWP_NO_OPT", "1")
        .env("FWP_SEED", "42")
        .args(["run", "--interp"])
        .arg(source)
        .current_dir(dir)
        .output()
        .unwrap();
    assert_eq!(expected.status.code(), Some(expected_exit), "{expected:?}");
    for opt in ["-O1", "-O2"] {
        let binary = dir.join("generated.exe");
        checked(
            Command::new(compiler)
                .args(["build", opt])
                .arg(source)
                .arg("-o")
                .arg(&binary)
                .current_dir(dir),
        );
        for stress in ["0", "1"] {
            eprintln!("running {} {opt} stress={stress}", source.display());
            let actual = Command::new(&binary)
                .env("FWP_SEED", "42")
                .env("FWP_GC_STRESS", stress)
                .env("FWP_GC_VERIFY", stress)
                .env("FWP_REUSE_VERIFY", stress)
                .current_dir(dir)
                .output()
                .unwrap();
            if actual.status.code() != expected.status.code() {
                let cfile = dir.join("failure.c");
                checked(
                    Command::new(compiler)
                        .args(["build", "--emit-c"])
                        .arg(source)
                        .arg("-o")
                        .arg(&cfile),
                );
                let c = std::fs::read_to_string(&cfile).unwrap().replace(
                    "int ok = fwp_win_quote(command, &used, wide.text);",
                    "fprintf(stderr, \"quote: used=%zu units=%zu text=%ls\\n\", used, wcslen(wide.text), wide.text);\n        int ok = fwp_win_quote(command, &used, wide.text);",
                );
                let diagnostic = dir.join("failure.exe");
                fwp::cgen::compile_c(&c, &diagnostic, opt).unwrap();
                let output = Command::new(diagnostic)
                    .env("FWP_SEED", "42")
                    .env("FWP_GC_STRESS", stress)
                    .env("FWP_GC_VERIFY", stress)
                    .env("FWP_REUSE_VERIFY", stress)
                    .current_dir(dir)
                    .output()
                    .unwrap();
                eprintln!("diagnostic rerun: {output:?}");
            }
            assert_eq!(
                actual.status.code(),
                expected.status.code(),
                "{} {opt} stress={stress}: {actual:?}",
                source.display()
            );
            assert_eq!(
                actual.stdout,
                expected.stdout,
                "{} {opt} stress={stress}",
                source.display()
            );
            assert_eq!(
                actual.stderr,
                expected.stderr,
                "{} {opt} stress={stress}",
                source.display()
            );
        }
    }
}

#[test]
fn generated_numerics_tasks_and_unicode_files_match_raw_execution() {
    let dir = fwp::cgen::TempDir::new("windows-programs").unwrap();
    let root = Path::new(env!("CARGO_MANIFEST_DIR"));
    for name in ["numerics", "tasks_local", "tasks", "cli_fs"] {
        let text = std::fs::read_to_string(root.join(format!("tests/run/{name}.fwp"))).unwrap();
        let text = text.replace("cli_fs.tmp", "fwp-λ-目录");
        let source = dir.join(format!("{name}.fwp"));
        std::fs::write(&source, text).unwrap();
        compare(
            &source,
            dir.path(),
            if name == "numerics" { 101 } else { 0 },
        );
    }
}

#[test]
fn unicode_process_arguments_and_concurrent_binary_capture_match_raw_execution() {
    let dir = fwp::cgen::TempDir::new("windows-processes").unwrap();
    let helper = dir.join("child λ 目录.exe");
    fwp::cgen::compile_c(
        include_str!("fixtures/windows_process_child.c"),
        &helper,
        "-O1",
    )
    .unwrap();
    let source = dir.join("processes.fwp");
    let helper_literal = format!("{:?}", helper.to_string_lossy());
    std::fs::write(
        &source,
        format!(
            r#"
main = [
    [{helper_literal}, "", "has space", "quote\"x", "back\\slash\\", "λ目录"] | process.run | echo,
    [{helper_literal}, "pump"] | process.run-input (string.repeat 200000 "x")
        | both .status (both (.stdout | string.length) (.stderr | string.length)) | echo,
    [{helper_literal}, "call"] | process.call | echo,
    ["no-such-program-fwp"] | attempt process.run | echo,
    [] | attempt process.call | echo,
] | ignore
"#
        ),
    )
    .unwrap();
    compare(&source, dir.path(), 0);
}
