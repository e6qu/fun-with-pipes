//! Immediate integer printing and character counting avoid temporary strings.
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
fn integer_text_lengths_preserve_widths_unicode_sharing_and_effect_order() {
    let dir = fwp::cgen::TempDir::new("integer-text-lengths").unwrap();
    let input = dir.join("main.fwp");
    let mut source = String::new();
    // Exercise both sides of every decimal-width transition, including negative
    // values. Unsigned magnitudes must handle I64::MIN without signed negation.
    let mut signed = vec![i64::MIN, i64::MAX, -1, 0, 1];
    for exponent in 1..=18 {
        let power = 10_i64.pow(exponent);
        for value in [power - 1, power, power + 1] {
            signed.extend([value, -value]);
        }
    }
    let signed_input = signed.iter().map(|x| format!("{x}\n")).collect::<String>();
    let signed_output = signed
        .iter()
        .map(|x| format!("{}\n", x.to_string().len() + 2))
        .collect::<String>();
    let mut unsigned = vec![0, 1, u64::MAX];
    for exponent in 1..=19 {
        let power = 10_u64.pow(exponent);
        unsigned.extend([power - 1, power, power + 1]);
    }
    let unsigned_input = unsigned
        .iter()
        .map(|x| format!("{x}\n"))
        .collect::<String>();
    let unsigned_output = unsigned
        .iter()
        .map(|x| format!("{}\n", x.to_string().len() + 2))
        .collect::<String>();
    let widths: [(&str, &str, &[u8]); 7] = [
        ("signed", "I64", signed_input.as_bytes()),
        ("unsigned", "U64", unsigned_input.as_bytes()),
        ("small", "I8", b"-128\n0\n127\n"),
        ("byte", "U8", b"0\n255\n"),
        ("word", "I32", b"-2147483648\n2147483647\n"),
        ("wide", "I128", b"-123456789012345678901234567890\n"),
        ("decimal", "F64", b"-1.25\n0.0\n"),
    ];
    for (name, ty, _) in widths {
        source.push_str(&format!(
            "# expose: cli\nexport {name} : {ty} -> I64\n{name} = show | concat \"é🙂\" | string.length\n"
        ));
    }
    source.push_str(
        r#"
# expose: cli
export shared : I64 -> (String, I64)
shared = show | both id string.length
# expose: cli
export effects : I64 -> I64 ! {IO}
effects = fork concat (tap echo | show) (add 1 | tap echo | show) | string.length
# expose: cli
export trap : I64 -> I64 ! {IO}
trap = fork concat (tap echo | div 0 | show) (add 1 | tap echo | show) | string.length
"#,
    );
    std::fs::write(&input, source).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let cases: Vec<_> = widths
        .iter()
        .map(|(name, _, input)| (*name, *input, 0))
        .chain([
            ("shared", b"-12\n0\n".as_slice(), 0),
            ("effects", b"7\n".as_slice(), 0),
            ("trap", b"7\n".as_slice(), 101),
        ])
        .collect();
    let references: Vec<_> = cases
        .iter()
        .map(|(name, data, status)| {
            let raw = run(
                Command::new(compiler)
                    .env("FWP_NO_OPT", "1")
                    .env("FWP_OUT", "bin")
                    .env("FWP_TRANSPORT", "stdio")
                    .args(["exec", "--interp", "--cli"])
                    .arg(&input)
                    .arg(name),
                data,
            );
            assert_eq!(raw.status.code(), Some(*status), "{name}: {raw:?}");
            if *name == "signed" {
                assert_eq!(raw.stdout, signed_output.as_bytes());
            } else if *name == "unsigned" {
                assert_eq!(raw.stdout, unsigned_output.as_bytes());
            }
            raw
        })
        .collect();
    for memory in ["arc", "tracing"] {
        let cfile = dir.join("main.c");
        checked(
            Command::new(compiler)
                .env_remove("FWP_NO_OPT")
                .args(["build", "--cli", "--gc", memory, "--emit-c"])
                .arg(&input)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(cfile).unwrap();
        assert!(code.contains("/* string._integer-length :"), "{code}");
        for opt in ["-O0", "-O2"] {
            let binary = dir.join("length.exe");
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            let stress = if memory == "arc" { "0" } else { "1" };
            for ((name, data, _), raw) in cases.iter().zip(&references) {
                let native = run(
                    Command::new(&binary)
                        .arg(name)
                        .env("FWP_OUT", "bin")
                        .env("FWP_TRANSPORT", "stdio")
                        .env_remove("FWP_GC")
                        .env("FWP_GC_STRESS", stress)
                        .env("FWP_GC_VERIFY", stress)
                        .env("FWP_REUSE_VERIFY", stress),
                    data,
                );
                assert_eq!(
                    (&native.stdout, &native.stderr, native.status.code()),
                    (&raw.stdout, &raw.stderr, raw.status.code()),
                    "{name}/{memory}/{opt}"
                );
            }
            if let Some(root) = std::env::var_os("FWP_INTEGER_LENGTH_ARTIFACTS") {
                let root = std::path::Path::new(&root);
                std::fs::create_dir_all(root).unwrap();
                let label = format!("semantics-{memory}{opt}");
                std::fs::write(root.join(format!("{label}.c")), &code).unwrap();
                std::fs::copy(&binary, root.join(format!("{label}.exe"))).unwrap();
            }
        }
    }
}

#[test]
fn immediately_measured_integer_text_needs_no_leaf_allocations() {
    let dir = fwp::cgen::TempDir::new("integer-text-length-counts").unwrap();
    let input = dir.join("main.fwp");
    let source = r#"
line : I64 -> I64
line = fork concat show (mul 3 | show) | concat "é🙂" | string.length
main = range 0 4096 | map line | sum | echo
"#;
    std::fs::write(&input, source).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let raw = checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input),
    );
    for memory in ["arc", "tracing"] {
        let cfile = dir.join("main.c");
        checked(
            Command::new(compiler)
                .env_remove("FWP_NO_OPT")
                .args(["build", "--gc", memory, "--emit-c"])
                .arg(&input)
                .arg("-o")
                .arg(&cfile),
        );
        let original = std::fs::read_to_string(cfile).unwrap();
        assert!(original.contains("/* string._integer-length :"));
        let prototype = "static void *fwp_alloc_leaf(size_t n);";
        assert_eq!(original.matches(prototype).count(), 1);
        let mut code = original.replace(
            prototype,
            &format!("static int length_tracking;\nstatic size_t length_allocations;\n{prototype}"),
        );
        for marker in [
            "static void *fwp_alloc_leaf(size_t n) {",
            "static inline void *fwp_alloc_leaf(size_t n) {",
        ] {
            assert_eq!(code.matches(marker).count(), 1);
            code = code.replace(
                marker,
                &format!("{marker} if(length_tracking) length_allocations++;"),
            );
        }
        let main_start = code
            .find("static void *fwp_main_thread(void *arg) {")
            .unwrap();
        let (runtime, main) = code.split_at(main_start);
        assert_eq!(main.matches("    fwp_init_consts();\n").count(), 1);
        assert_eq!(main.matches("    fwp_cl_finish();\n").count(), 1);
        let code = format!(
            "{runtime}{}",
            main.replace(
                "    fwp_init_consts();\n",
                "    fwp_init_consts();\n    length_tracking = 1;\n"
            )
            .replace(
                "    fwp_cl_finish();\n",
                "    fwp_cl_finish();\n    if(length_allocations) exit(247);\n"
            )
        );
        let marker = "return (V)fwp_i64_chars((int64_t)l0);";
        assert_eq!(code.matches(marker).count(), 1);
        let bad = code.replace(marker, &format!("(void)fwp_alloc_leaf(16); {marker}"));
        for opt in ["-O0", "-O2"] {
            let binary = dir.join("counts.exe");
            for (candidate, status) in [(&code, 0), (&bad, 247)] {
                fwp::cgen::compile_c(candidate, &binary, opt).unwrap();
                let result = Command::new(&binary)
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                assert_eq!(
                    result.status.code(),
                    Some(status),
                    "{memory}/{opt}: {result:?}"
                );
                assert_eq!(result.stdout, raw.stdout, "{memory}/{opt}");
                if status == 0 {
                    assert_eq!(result.stderr, raw.stderr, "{memory}/{opt}");
                }
                if let Some(root) = std::env::var_os("FWP_INTEGER_LENGTH_ARTIFACTS") {
                    let root = std::path::Path::new(&root);
                    std::fs::create_dir_all(root).unwrap();
                    let label = format!("allocation-check-{memory}{opt}-exit-{status}");
                    std::fs::write(root.join(format!("{label}.c")), candidate).unwrap();
                    std::fs::copy(&binary, root.join(format!("{label}.exe"))).unwrap();
                    std::fs::write(root.join(format!("{label}.stdout")), &result.stdout).unwrap();
                    std::fs::write(root.join(format!("{label}.stderr")), &result.stderr).unwrap();
                }
            }
        }
    }
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
        "# expose: cli\nexport number : I64 -> I64 ! {IO}\nnumber = tap echo\n",
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
