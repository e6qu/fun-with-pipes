//! Printing an immediately shown integer preserves output without a heap string.
use std::io::Write;
use std::process::{Command, Output, Stdio};

fn checked(command: &mut Command) -> Output {
    let result = command.output().unwrap();
    assert!(result.status.success(), "{command:?}: {result:?}");
    result
}

fn run(command: &mut Command, input: &[u8]) -> Output {
    let mut child = command
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .unwrap();
    child.stdin.take().unwrap().write_all(input).unwrap();
    child.wait_with_output().unwrap()
}

#[test]
fn integer_output_preserves_widths_shared_strings_and_trap_order() {
    let dir = fwp::cgen::TempDir::new("integer-output").unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    for (name, source, status) in [
        ("widths", include_str!("fixtures/integer_output.fwp"), 0),
        (
            "shared",
            "main = 12345 | show | both print (string.length | echo) | ignore\n",
            0,
        ),
        (
            "trap",
            "main = [7 | echo, 1 | div 0 | echo, 8 | echo] | ignore\n",
            101,
        ),
    ] {
        let input = dir.join("main.fwp");
        std::fs::write(&input, source).unwrap();
        let raw = Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input)
            .output()
            .unwrap();
        assert_eq!(raw.status.code(), Some(status), "{name}: {raw:?}");
        if name == "shared" {
            assert_eq!(raw.stdout, b"12345\n5\n");
        }
        if name == "trap" {
            assert_eq!(raw.stdout, b"7\n");
        }
        for direct in ["0", "1"] {
            for memory in ["arc", "tracing"] {
                let cfile = dir.join("main.c");
                checked(
                    Command::new(compiler)
                        .env_remove("FWP_NO_OPT")
                        .env("FWP_DIRECT_INTEGER_PRINT", direct)
                        .args(["build", "--gc", memory, "--emit-c"])
                        .arg(&input)
                        .arg("-o")
                        .arg(&cfile),
                );
                let code = std::fs::read_to_string(&cfile).unwrap();
                assert_eq!(
                    code.matches("fwp_print_integer(").count() > 1,
                    direct == "1",
                    "{name}/{memory}/{direct}"
                );
                for opt in ["-O0", "-O2"] {
                    let binary = dir.join("main.exe");
                    fwp::cgen::compile_c(&code, &binary, opt).unwrap();
                    let stress = if memory == "arc" { "0" } else { "1" };
                    let actual = Command::new(&binary)
                        .env_remove("FWP_GC")
                        .env("FWP_GC_STRESS", stress)
                        .env("FWP_GC_VERIFY", stress)
                        .env("FWP_REUSE_VERIFY", stress)
                        .output()
                        .unwrap();
                    assert_eq!(
                        (&actual.stdout, &actual.stderr, actual.status.code()),
                        (&raw.stdout, &raw.stderr, raw.status.code()),
                        "{name}/{memory}/{direct}/{opt}"
                    );
                    if let Some(root) = std::env::var_os("FWP_INTEGER_OUTPUT_ARTIFACTS") {
                        let root = std::path::Path::new(&root);
                        std::fs::create_dir_all(root).unwrap();
                        let label = format!("{name}-{memory}-{direct}{opt}");
                        std::fs::write(root.join(format!("{label}.c")), &code).unwrap();
                        std::fs::copy(&binary, root.join(format!("{label}.exe"))).unwrap();
                    }
                }
            }
        }
    }
}

#[test]
fn immediate_integer_output_does_not_allocate_a_string() {
    let dir = fwp::cgen::TempDir::new("integer-output-counts").unwrap();
    let input = dir.join("main.fwp");
    std::fs::write(&input, "main = args () | length | add 17 | echo\n").unwrap();
    for direct in ["0", "1"] {
        for memory in ["arc", "tracing"] {
            let cfile = dir.join("main.c");
            checked(
                Command::new(env!("CARGO_BIN_EXE_fwp"))
                    .env("FWP_DIRECT_INTEGER_PRINT", direct)
                    .args(["build", "--gc", memory, "--emit-c"])
                    .arg(&input)
                    .arg("-o")
                    .arg(&cfile),
            );
            let original = std::fs::read_to_string(cfile).unwrap();
            let marker = "static V fwp_str_new(const char *s, size_t len) {";
            assert_eq!(original.matches(marker).count(), 1);
            let start = original
                .find("static void *fwp_main_thread(void *arg) {")
                .unwrap();
            let (runtime, main) = original.split_at(start);
            let expected = if direct == "1" { 0 } else { 1 };
            let code = format!("{}{}", runtime.replace(marker, &format!("static int output_tracking, output_strings;\n{marker}\nif(output_tracking) output_strings++;")),
                main.replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    output_tracking = 1;\n")
                    .replace("    fwp_cl_finish();\n", &format!("    fwp_cl_finish();\n    if(output_strings != {expected}) exit(247);\n")));
            assert!(code.contains("output_tracking = 1;") && code.contains("exit(247)"));
            for opt in ["-O0", "-O2"] {
                let binary = dir.join("count.exe");
                fwp::cgen::compile_c(&code, &binary, opt).unwrap();
                let stress = if memory == "arc" { "0" } else { "1" };
                let mut command = Command::new(&binary);
                command
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", stress)
                    .env("FWP_GC_VERIFY", stress)
                    .env("FWP_REUSE_VERIFY", stress);
                assert_eq!(checked(&mut command).stdout, b"17\n");
                if direct == "1" {
                    let bad = code.replace("static V fwp_print_integer(V value, int is_signed) {", "static V fwp_print_integer(V value, int is_signed) {\n(void)fwp_str_new(\"unexpected\", 10);");
                    assert_ne!(bad, code);
                    fwp::cgen::compile_c(&bad, &binary, opt).unwrap();
                    let result = command.output().unwrap();
                    assert_eq!(
                        result.status.code(),
                        Some(247),
                        "{memory}/{opt}: {result:?}"
                    );
                }
            }
        }
    }
}

#[test]
fn integer_print_keeps_binary_protocol_output_on_its_own_stream() {
    let dir = fwp::cgen::TempDir::new("integer-output-protocol").unwrap();
    let input = dir.join("main.fwp");
    std::fs::write(
        &input,
        "export number : I64 -> I64 ! {IO}\nnumber = tap echo\n",
    )
    .unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let raw = run(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .env("FWP_OUT", "bin")
            .env("FWP_TRANSPORT", "stdio")
            .args(["exec", "--interp", "--cli"])
            .arg(&input)
            .arg("number"),
        b"17\n-18\n",
    );
    assert!(raw.status.success(), "{raw:?}");
    assert_eq!(raw.stderr, b"17\n-18\n");
    for memory in ["arc", "tracing"] {
        let cfile = dir.join("main.c");
        checked(
            Command::new(compiler)
                .env("FWP_DIRECT_INTEGER_PRINT", "1")
                .args(["build", "--cli", "--gc", memory, "--emit-c"])
                .arg(&input)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(cfile).unwrap();
        assert!(code.matches("fwp_print_integer(").count() > 1);
        for opt in ["-O0", "-O2"] {
            let binary = dir.join("protocol.exe");
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            let stress = if memory == "arc" { "0" } else { "1" };
            let result = run(
                Command::new(&binary)
                    .arg("number")
                    .env("FWP_OUT", "bin")
                    .env("FWP_TRANSPORT", "stdio")
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", stress)
                    .env("FWP_GC_VERIFY", stress)
                    .env("FWP_REUSE_VERIFY", stress),
                b"17\n-18\n",
            );
            assert_eq!(
                (&result.stdout, &result.stderr, result.status.code()),
                (&raw.stdout, &raw.stderr, raw.status.code()),
                "{memory}/{opt}"
            );
        }
    }
}
