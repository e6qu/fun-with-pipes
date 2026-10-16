//! Maintained applications compose text-file ownership without a collector.
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

#[test]
fn maintained_text_tools_release_repeated_and_retained_results() {
    let dir = fwp::cgen::TempDir::new("text-file-tools").unwrap();
    let root = dir.path();
    std::fs::write(root.join("first.txt"), "Apple pie\nbanana\n世界\n").unwrap();
    std::fs::write(root.join("second.txt"), "apple\nhéllo\n世界\n").unwrap();
    for (name, library, main) in [
        (
            "todo",
            include_str!("../examples/cli/todo.fwp"),
            include_str!("fixtures/todo_repeated.fwp"),
        ),
        (
            "grep",
            include_str!("../examples/cli/grep.fwp"),
            include_str!("fixtures/grep_repeated.fwp"),
        ),
    ] {
        let source = root.join(format!("{name}.fwp"));
        std::fs::write(&source, format!("{library}\n{main}")).unwrap();
        let reference = checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .current_dir(root)
                .env("FWP_NO_OPT", "1")
                .args(["run", "--interp"])
                .arg(&source),
        );
        let stdout = String::from_utf8_lossy(&reference.stdout);
        if name == "todo" {
            assert_eq!(stdout.matches("added\n").count(), 128);
            assert!(stdout.contains("[x] buy héllo") && stdout.contains("[ ] write 世界"));
        } else {
            assert_eq!(stdout.matches("first.txt:1:Apple pie").count(), 64);
            assert_eq!(stdout.matches("second.txt:1:apple").count(), 64);
        }
        let optimized = checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .current_dir(root)
                .env_remove("FWP_NO_OPT")
                .args(["run", "--interp"])
                .arg(&source),
        );
        assert_eq!(
            (&optimized.stdout, &optimized.stderr),
            (&reference.stdout, &reference.stderr)
        );
        for gc in ["tracing", "arc"] {
            let cfile = root.join("tool.c");
            checked(
                Command::new(env!("CARGO_BIN_EXE_fwp"))
                    .env_remove("FWP_NO_OPT")
                    .args(["build", "--gc", gc, "--emit-c"])
                    .arg(&source)
                    .arg("-o")
                    .arg(&cfile),
            );
            let mut code = std::fs::read_to_string(cfile).unwrap();
            if gc == "arc" {
                let start = code
                    .find("static void *fwp_main_thread(void *arg) {")
                    .unwrap();
                let (runtime, main) = code.split_at(start);
                assert_eq!(main.matches("    fwp_init_consts();\n").count(), 1);
                assert_eq!(main.matches("    fwp_cl_finish();\n").count(), 1);
                let measured = main.replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    intptr_t text_budget = fwp_gc.budget;\n")
                    .replace("    fwp_cl_finish();\n", "    fwp_cl_finish();\n    if(fwp_gc.enabled || fwp_gc.ncollect || fwp_gc.budget < text_budget) exit(239);\n");
                code = format!("{runtime}{measured}");
            }
            let binary = root.join("tool.exe");
            for opt in ["-O1", "-O2"] {
                fwp::cgen::compile_c(&code, &binary, opt).unwrap();
                let verify = if gc == "arc" { "0" } else { "1" };
                let actual = checked(
                    Command::new(&binary)
                        .current_dir(root)
                        .env_remove("FWP_GC")
                        .env("FWP_GC_STRESS", verify)
                        .env("FWP_GC_VERIFY", verify)
                        .env("FWP_REUSE_VERIFY", verify),
                );
                assert_eq!(
                    (&actual.stdout, &actual.stderr),
                    (&reference.stdout, &reference.stderr),
                    "{name} {gc} {opt}"
                );
                assert!(!root.join("tasks.txt").exists());
                assert_eq!(
                    std::fs::read_to_string(root.join("first.txt")).unwrap(),
                    "Apple pie\nbanana\n世界\n"
                );
            }
        }
    }
}

#[test]
fn maintained_text_command_lines_match_raw_interpretation() {
    use std::io::Write;
    use std::process::Stdio;
    let dir = fwp::cgen::TempDir::new("text-command-lines").unwrap();
    let root = dir.path();
    std::fs::write(root.join("input.txt"), "Apple pie\nbanana\n世界\n").unwrap();
    for (name, library, cases) in [
        (
            "todo",
            include_str!("../examples/cli/todo.fwp"),
            vec![
                (vec!["add", "buy", "héllo"], "", "added\n", 0),
                (vec!["done", "1"], "", "item 1 is done\n", 0),
                (vec!["list"], "", "  1. [x] buy héllo\n", 0),
                (vec!["clear"], "", "cleared\n", 0),
                (vec!["list"], "", "", 0),
            ],
        ),
        (
            "grep",
            include_str!("../examples/cli/grep.fwp"),
            vec![
                (vec!["-in", "apple", "input.txt"], "", "1:Apple pie\n", 0),
                (vec!["-vc", "a"], "a\nhéllo\n世界\n", "2\n", 0),
                (vec!["-c", "missing", "input.txt"], "", "0\n", 1),
                (vec!["世界", "input.txt"], "", "世界\n", 0),
            ],
        ),
    ] {
        let source = root.join(format!("{name}.fwp"));
        std::fs::write(&source, library).unwrap();
        for mode in ["interp", "tracing", "arc"] {
            let todo = root.join("todo.txt");
            if todo.exists() {
                std::fs::remove_file(&todo).unwrap();
            }
            let executable = root.join(format!("{name}{}", std::env::consts::EXE_SUFFIX));
            if mode != "interp" {
                let mut build = Command::new(env!("CARGO_BIN_EXE_fwp"));
                build.args(["build", "--gc", mode, "-O2"]).arg(&source);
                if name == "todo" {
                    build.arg("--cli");
                } else {
                    build.args(["--fn", "grep"]);
                }
                checked(build.arg("-o").arg(&executable));
            }
            for (arguments, input, expected, status) in &cases {
                let mut command = if mode == "interp" {
                    let mut c = Command::new(env!("CARGO_BIN_EXE_fwp"));
                    c.args(["exec", "--interp"]).env("FWP_NO_OPT", "1");
                    if name == "todo" {
                        c.arg("--cli").arg(&source);
                    } else {
                        c.arg(&source).arg("grep");
                    }
                    c
                } else {
                    Command::new(&executable)
                };
                let verify = if mode == "tracing" { "1" } else { "0" };
                let mut child = command
                    .args(arguments)
                    .current_dir(root)
                    .env_remove("TODO_FILE")
                    .env_remove("FWP_GC")
                    .env_remove("FWP_OUT")
                    .env("FWP_GC_STRESS", verify)
                    .env("FWP_GC_VERIFY", verify)
                    .env("FWP_REUSE_VERIFY", verify)
                    .stdin(Stdio::piped())
                    .stdout(Stdio::piped())
                    .stderr(Stdio::piped())
                    .spawn()
                    .unwrap();
                child
                    .stdin
                    .take()
                    .unwrap()
                    .write_all(input.as_bytes())
                    .unwrap();
                let result = child.wait_with_output().unwrap();
                assert_eq!(
                    result.status.code(),
                    Some(*status),
                    "{name} {mode}: {result:?}"
                );
                assert_eq!(result.stdout, expected.as_bytes(), "{name} {mode}");
                assert!(result.stderr.is_empty(), "{name} {mode}: {result:?}");
            }
        }
    }
}
