//! Console input and argument copies own their temporary and returned storage.
use std::io::Write;
use std::process::{Command, Output, Stdio};
fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}
fn input(command: &mut Command, bytes: &[u8]) -> Output {
    let mut child = command
        .env("FWP_ENV_COPY", "copied")
        .env("FWP_ENV_EMPTY", "")
        .env("COLUMNS", "113")
        .env_remove("FWP_ENV_ABSENT")
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .unwrap();
    child.stdin.take().unwrap().write_all(bytes).unwrap();
    child.wait_with_output().unwrap()
}
#[test]
fn console_input_matches_raw_interpretation() {
    let dir = fwp::cgen::TempDir::new("console-ownership").unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let bytes = b"first\r\n\nlast\r\ninvalid \xff\n0\n1\n2\n3\n4\n5\n6\n7\n8\n9\nend\r";
    for (name, body) in [
        ("all", "read-all () | echo"),
        ("line", "[read-line (), read-line (), read-line ()] | echo"),
        ("lines", "read-lines () | echo"),
        (
            "secret",
            "[term.read-secret (), term.read-secret (), term.read-secret ()] | echo",
        ),
        (
            "tty",
            "[-2147483648, -1, 0, 1, 2, 3, 2147483647] | map term.is-tty | echo",
        ),
        ("width", "term.width () | echo"),
        ("fold", "0 | fold-lines (curry (.0 | add 1)) | echo"),
        ("args", "args () | echo"),
        (
            "environment",
            r#"[env.get "FWP_ENV_COPY", env.get "FWP_ENV_EMPTY", env.get "FWP_ENV_ABSENT", env.get "FWP_ENV_COPY\0suffix"] | echo"#,
        ),
    ] {
        let source = dir.join(&format!("{name}.fwp"));
        eprintln!("console input {name}: main = {body}");
        std::fs::write(&source, format!("main = {body}\n")).unwrap();
        let all_cases = [bytes.as_slice(), b"", b"\n", b"last\r", b"a\0b\n"];
        let cases = if matches!(name, "args" | "environment" | "tty" | "width") {
            &all_cases[1..2]
        } else {
            &all_cases[..]
        };
        let arguments = ["first", "héllo", ""];
        let expected: Vec<_> = cases
            .iter()
            .map(|bytes| {
                let reference = input(
                    Command::new(compiler)
                        .env("FWP_NO_OPT", "1")
                        .args(["run", "--interp"])
                        .arg(&source)
                        .args(arguments),
                    bytes,
                );
                assert!(reference.status.success(), "{name}: {reference:?}");
                reference
            })
            .collect();
        for gc in ["tracing", "arc"] {
            let cfile = dir.join("console.c");
            checked(
                Command::new(compiler)
                    .env_remove("FWP_NO_OPT")
                    .args(["build", "--gc", gc, "--emit-c"])
                    .arg(&source)
                    .arg("-o")
                    .arg(&cfile),
            );
            let code = std::fs::read_to_string(&cfile).unwrap();
            let binary = dir.join("console.exe");
            for optimization in ["-O1", "-O2"] {
                fwp::cgen::compile_c(&code, &binary, optimization).unwrap();
                let verify = if gc == "arc" { "0" } else { "1" };
                for (bytes, reference) in cases.iter().zip(&expected) {
                    let actual = input(
                        Command::new(&binary)
                            .args(arguments)
                            .env_remove("FWP_GC")
                            .env("FWP_GC_STRESS", verify)
                            .env("FWP_GC_VERIFY", verify)
                            .env("FWP_REUSE_VERIFY", verify),
                        bytes,
                    );
                    assert_eq!(
                        (actual.status.code(), actual.stdout, actual.stderr),
                        (
                            reference.status.code(),
                            reference.stdout.clone(),
                            reference.stderr.clone()
                        ),
                        "{name} {gc} {optimization}"
                    );
                }
            }
        }
    }
}

#[test]
fn console_builders_release_each_partial_result_and_completed_copy() {
    let dir = fwp::cgen::TempDir::new("console-cleanup").unwrap();
    let source = dir.join("console.fwp");
    std::fs::write(&source, "main = [task.yield (), echo \"probe\"] | ignore\n").unwrap();
    let input = dir.join("input");
    std::fs::write(
        &input,
        b"first\r\n\ninvalid \xff\n0\n1\n2\n3\n4\n5\n6\n7\n8\n9\nend\r",
    )
    .unwrap();
    for gc in ["tracing", "arc"] {
        let cfile = dir.join("console.c");
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .args(["build", "--gc", gc, "--emit-c"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile),
        );
        let mut code = std::fs::read_to_string(cfile).unwrap();
        code=code.replace("static void buf_grow(","static void *console_heap_resize(void *,size_t);static void console_heap_free(void *);\nstatic void buf_grow(")
            .replace("realloc(b->d, cap)","console_heap_resize(b->d, cap)")
            .replace("free(b->d);","console_heap_free(b->d);")
            .replace("free(b.d);","console_heap_free(b.d);")
            .replace("free(((fwp_buf *)arg)->d);","console_heap_free(((fwp_buf *)arg)->d);");
        let declarations="static V console_string(const char *,size_t);static V console_lossy(const char *,size_t);static V console_some(V);static V console_cons(V,V);static V console_node(V,size_t,const V *);static void *console_resize(void *,size_t,size_t);\n";
        code = code.replace(
            "static V fwp_lines_of(",
            &format!("{declarations}static V fwp_lines_of("),
        );
        for (start, end) in [
            ("static V fwp_lines_of(", "static V fwp_p_words("),
            ("static V fwp_read_stdin_all(", "static V fwp_p_env_get("),
            ("static V fwp_p_env_get(", "static int64_t fwp_now_ns("),
        ] {
            let a = code.find(start).unwrap();
            let b = a + code[a..].find(end).unwrap();
            let body = code[a..b]
                .replace("fwp_str_new(", "console_string(")
                .replace("fwp_str_lossy(", "console_lossy(")
                .replace("fwp_some(", "console_some(")
                .replace("fwp_cons(", "console_cons(")
                .replace("fwp_mem_realloc(", "console_resize(");
            code.replace_range(a..b, &body);
        }
        // The shared list builder is defined before console declarations.
        code = code.replace(
            "static V fwp_map_finish_protected(",
            "static V console_node(V,size_t,const V *);\nstatic V fwp_map_finish_protected(",
        );
        code = code.replace(
            "V node = fwp_rc_fresh(fwp_data(1, 2, fields));",
            "V node = fwp_rc_fresh(console_node(1, 2, fields));",
        );
        code = code.replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        );
        code.push_str(include_str!("fixtures/console_ownership_probe.c"));
        let binary = dir.join("probe.exe");
        for optimization in ["-O1", "-O2"] {
            fwp::cgen::compile_c(&code, &binary, optimization).unwrap();
            for collect in if gc == "arc" {
                &["0"][..]
            } else {
                &["0", "1"][..]
            } {
                checked(
                    Command::new(&binary)
                        .arg(&input)
                        .env_remove("FWP_GC")
                        .env("FWP_GC_STRESS", "0")
                        .env("FWP_GC_VERIFY", if gc == "arc" { "0" } else { "1" })
                        .env("FWP_REUSE_VERIFY", "0")
                        .env("FWP_CONSOLE_COLLECTION", collect),
                );
            }
        }
        for (release, replacement, status) in [
            (
                "fwp_rc_free_obj(fwp_value_finish(&input, &cleanup));",
                "(void)fwp_value_finish(&input, &cleanup);",
                205,
            ),
            (
                "    console_heap_free(b.d);\n    return r;",
                "    return r;",
                211,
            ),
        ] {
            assert_eq!(code.matches(release).count(), 1);
            fwp::cgen::compile_c(&code.replace(release, replacement), &binary, "-O2").unwrap();
            let omitted = Command::new(&binary)
                .arg(&input)
                .env_remove("FWP_GC")
                .env("FWP_GC_STRESS", "0")
                .env("FWP_GC_VERIFY", "0")
                .env("FWP_REUSE_VERIFY", "0")
                .env("FWP_CONSOLE_COLLECTION", "0")
                .output()
                .unwrap();
            assert_eq!(omitted.status.code(), Some(status), "{omitted:?}");
        }
    }
}
