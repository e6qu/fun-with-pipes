//! Child-process calls own their temporary storage and captured results.
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

fn retain_code(name: &str, code: &str) {
    if let Some(directory) = std::env::var_os("FWP_PROCESS_ARTIFACTS") {
        let directory = std::path::PathBuf::from(directory);
        std::fs::create_dir_all(&directory).unwrap();
        std::fs::write(directory.join(name), code).unwrap();
    }
}

#[test]
fn repeated_processes_match_raw_execution_and_release_captured_output() {
    let dir = fwp::cgen::TempDir::new("process-ownership").unwrap();
    let child = dir.join("child λ 目录.exe");
    fwp::cgen::compile_c(include_str!("fixtures/process_child.c"), &child, "-O1").unwrap();
    let source = dir.join("processes.fwp");
    let child_literal = format!("{:?}", child.to_string_lossy());
    let signal_cases = if cfg!(unix) {
        format!(
            r#"
    | tap (const [{child_literal}, "sigpipe"] | process.run | .status | echo)
    | tap (const [{child_literal}, "sigpipe"] | process.call | echo)"#
        )
    } else {
        String::new()
    };

    std::fs::write(
        &source,
        format!(
            r#"
errors : I64 -> () ! {{Process, IO}}
errors = const [[], ["no-such-program-fwp"], [{child_literal}, "bad\0argument"], ["bad\0program"]]
    | each (attempt process.run | match
        Ok _ -> const "unexpected success" | echo
        Err _ -> .kind | echo)
exercise : I64 -> () ! {{Process, IO, Error[IoError]}}
exercise = tap errors | const ()
{signal_cases}
    | tap (const [{child_literal}, "", "has space", "quote\"x", "back\\slash\\", "λ目录"]
        | process.run | echo)
    | tap (const [{child_literal}, "pump"] | process.run-input (string.repeat 200000 "x")
        | both .status (both (.stdout | string.length) (.stderr | string.length)) | echo)
    | tap (const [{child_literal}, "silent"] | process.run-input (string.repeat 200000 "x") | .status | echo)
    | tap (const [{child_literal}, "success"] | process.output | echo)
    | tap (const [{child_literal}, "failure"] | attempt process.output | match
        Ok _ -> const "unexpected success" | echo
        Err _ -> both .kind .message | echo)
    | const [{child_literal}, "silent"] | process.call | echo
main = range 0 32 | each exercise
"#
        ),
    )
    .unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    let text = String::from_utf8_lossy(&reference.stdout);
    assert_eq!(text.matches("spawn").count(), 32 * 4);
    assert_eq!(text.matches("65536").count(), 32 * 2);
    assert!(text.contains("λ目录"));
    assert_eq!(text.matches("expected failure").count(), 32);
    if cfg!(unix) {
        assert_eq!(text.lines().filter(|line| *line == "141").count(), 64);
    }

    let cfile = dir.join("processes.c");
    checked(
        Command::new(compiler)
            .args(["build", "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile),
    );
    let mut code = std::fs::read_to_string(cfile).unwrap();

    let start = code
        .find("static void *fwp_main_thread(void *arg) {")
        .unwrap();
    let (runtime, main) = code.split_at(start);
    assert_eq!(main.matches("    fwp_init_consts();\n").count(), 1);
    assert_eq!(
        main.matches("    /* Ownership observation point: before runtime teardown. */\n")
            .count(),
        1
    );
    let main = main.replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    size_t process_live_bytes = fwp_heap.live;\n")
                .replace("    /* Ownership observation point: before runtime teardown. */\n", "    /* Ownership observation point: before runtime teardown. */\n    if(fwp_heap.live > process_live_bytes) exit(232);\n");
    code = format!("{runtime}{main}");

    retain_code("repeated-counted.c", &code);
    let binary = dir.join("processes.exe");
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();

        let actual = checked(&mut Command::new(&binary));
        assert_eq!(actual.stdout, reference.stdout, "counted {opt}");
        assert_eq!(actual.stderr, reference.stderr, "counted {opt}");
    }
}

fn function_end(code: &str, start: usize) -> usize {
    let open = code[start..].find('{').unwrap() + start;
    let mut depth = 0;
    for (offset, byte) in code.as_bytes()[open..].iter().enumerate() {
        match byte {
            b'{' => depth += 1,
            b'}' => {
                depth -= 1;
                if depth == 0 {
                    return open + offset + 1;
                }
            }
            _ => {}
        }
    }
    panic!("unterminated process runtime function");
}

fn instrument(mut code: String) -> String {
    for (signature, declarations, before, after) in [
        (
            "static void fwp_process_finish(",
            "static void process_test_buf_release(void *);\n",
            "fwp_buf_release(",
            "process_test_buf_release(",
        ),
        (
            "static void fwp_win_process_finish(",
            "static void process_test_free_output(void *);\n",
            "free(process->output[i].data)",
            "process_test_free_output(process->output[i].data)",
        ),
        (
            "static DWORD WINAPI fwp_win_process_read(",
            "static void *process_test_realloc(void *,size_t);\n",
            "realloc(",
            "process_test_realloc(",
        ),
    ] {
        let start = code.find(signature).unwrap();
        let end = function_end(&code, start);
        let body = code[start..end].replace(before, after);
        assert_ne!(body, code[start..end]);
        code.replace_range(start..end, &format!("{declarations}{body}"));
    }
    let mut offset = 0;
    while let Some(found) = code[offset..].find("static V fwp_run_process(") {
        let start = offset + found;
        let end = function_end(&code, start);
        let body = code[start..end]
            .replace("fwp_str_lossy(", "process_test_string(")
            .replace("fwp_record(", "process_test_record(")
            .replace("fwp_win_process_finish", "process_test_finish")
            .replace("fwp_process_finish", "process_test_finish")
            .replace("buf_put(", "process_test_append(")
            .replace("poll(pollfds,", "process_test_poll(pollfds,")
            .replace("read(process.fds[", "process_test_read(process.fds[")
            .replace("waitpid(process.pid,", "process_test_wait(process.pid,");
        let declarations = "static V process_test_string(const char *,size_t);\nstatic V process_test_record(uint32_t,const V *);\nstatic void process_test_finish(void *);\n#ifndef _WIN32\nstatic void process_test_append(fwp_buf *,const void *,size_t);\nstatic int process_test_poll(struct pollfd *,nfds_t,int);\nstatic ssize_t process_test_read(int,void *,size_t);\nstatic pid_t process_test_wait(pid_t,int *,int);\n#endif\n";
        code.replace_range(start..end, &format!("{declarations}{body}"));
        offset = start + declarations.len() + body.len();
    }
    code
}

#[test]
fn process_failures_release_partial_results_buffers_handles_and_children() {
    let dir = fwp::cgen::TempDir::new("process-failures").unwrap();
    let child = dir.join("child.exe");
    fwp::cgen::compile_c(include_str!("fixtures/process_child.c"), &child, "-O1").unwrap();
    let source = dir.join("probe.fwp");
    let child_literal = format!("{:?}", child.to_string_lossy());
    std::fs::write(
        &source,
        format!(
            r#"
export exercise : I64 -> ProcessOutput ! {{Process, Error[IoError]}}
exercise = if (eq 1) (const ["no-such-program-fwp"] | process.run)
    (if (eq 2)
        (const [{child_literal}, "silent"] | process.run-input (string.repeat 200000 "x"))
        (const [{child_literal}, "pump"] | process.run-input (string.repeat 200000 "x")))
main = 0 | exercise | .status | echo
"#
        ),
    )
    .unwrap();

    let cfile = dir.join("probe.c");
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--fn", "exercise", "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
    let entry = emitted[emitted.find("/* exercise :").unwrap()..]
        .split("static V f")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let code = instrument(emitted.clone()).replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    ) + &include_str!("fixtures/process_ownership_probe.c")
        .replace("fEXERCISE", &format!("f{entry}"));
    retain_code("failures-counted.c", &code);
    let binary = dir.join("probe.exe");

    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();
        checked(&mut Command::new(&binary));
    }
    let uncounted = code.replace("fwp_rc_fresh(process_test_record(", "(process_test_record(");
    assert_ne!(uncounted, code);
    let unreleased = code
        .replace("process_test_buf_release(&process->out);", "(void)0;")
        .replace(
            "process_test_free_output(process->output[i].data);",
            "(void)0;",
        );
    assert_ne!(unreleased, code);
    // A worker may rebuild the outer record after detecting the uncounted
    // original as shared. Then the extra child counts expose the same bug.
    let mut controls = vec![(uncounted, &[234, 235][..]), (unreleased, &[233][..])];
    if cfg!(unix) {
        let signature =
            "static ssize_t fwp_process_write(int fd, const void *bytes, size_t size) {";
        let changed = code.replace(
            signature,
            &format!("{signature}\n    signal(SIGPIPE, SIG_IGN);"),
        );
        assert_ne!(changed, code);
        controls.push((changed, &[246]));
    }
    for (broken, expected) in controls {
        fwp::cgen::compile_c(&broken, &binary, "-O2").unwrap();
        let actual = Command::new(&binary).output().unwrap();
        assert!(
            actual
                .status
                .code()
                .is_some_and(|status| expected.contains(&status)),
            "counted, expected {expected:?}: {actual:?}"
        );
    }
}

#[test]
fn maintained_shell_function_runs_as_a_child_without_retaining_results() {
    let dir = fwp::cgen::TempDir::new("process-shell-tool").unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let child = dir.join("normalize.exe");
    let source = dir.join("shell-parent.fwp");
    let child_literal = format!("{:?}", child.to_string_lossy());
    std::fs::write(
        &source,
        format!(
            r#"
normalize : I64 -> ProcessOutput ! {{Process, Error[IoError]}}
normalize = const [{child_literal}] | process.run-input "  Hello\n WORLD \n"
main = range 0 64 | map normalize
    | tap (each (both .status .stderr | echo))
    | map .stdout | each echo
"#
        ),
    )
    .unwrap();

    checked(
        Command::new(compiler)
            .args(["build", "--fn", "normalize"])
            .arg(std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("examples/shell/tools.fwp"))
            .arg("-o")
            .arg(&child),
    );
    let reference = checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .env_remove("FWP_OUT")
            .args(["run", "--interp"])
            .arg(&source),
    );
    let text = String::from_utf8_lossy(&reference.stdout);
    assert_eq!(text.matches("hello").count(), 64);
    assert_eq!(text.matches("world").count(), 64);
    let cfile = dir.join("parent.c");
    checked(
        Command::new(compiler)
            .args(["build", "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile),
    );
    let mut code = std::fs::read_to_string(cfile).unwrap();

    let start = code
        .find("static void *fwp_main_thread(void *arg) {")
        .unwrap();
    let (runtime, main) = code.split_at(start);
    assert_eq!(main.matches("    fwp_init_consts();\n").count(), 1);
    assert_eq!(
        main.matches("    /* Ownership observation point: before runtime teardown. */\n")
            .count(),
        1
    );
    let main = main.replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    size_t process_live_bytes = fwp_heap.live;\n")
                .replace("    /* Ownership observation point: before runtime teardown. */\n", "    /* Ownership observation point: before runtime teardown. */\n    if(fwp_heap.live > process_live_bytes) exit(232);\n");
    code = format!("{runtime}{main}");

    retain_code("shell-parent-counted.c", &code);
    let binary = dir.join("parent.exe");
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();

        let actual = checked(Command::new(&binary).env_remove("FWP_OUT"));
        assert_eq!(actual.stdout, reference.stdout, "counted {opt}");
        assert_eq!(actual.stderr, reference.stderr, "counted {opt}");
    }
}
