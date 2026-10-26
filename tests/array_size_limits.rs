//! Array limits agree before allocation and preserve callback/argument trap order.
use std::path::PathBuf;
use std::process::{Command, Output};

#[test]
fn packed_array_constructor_preserves_the_checked_count_boundary() {
    let directory = std::env::temp_dir().join(format!("fwp-packed-size-{}", std::process::id()));
    std::fs::create_dir(&directory).unwrap();
    let source = include_str!("../runtime/fwp_rt.c");
    let start = source
        .find("static V fwp_array_new_packed(size_t n, const fwp_desc *elem) {")
        .unwrap();
    let end = start + source[start..].find("\n}").unwrap() + 2;
    let constructor = &source[start..end];
    let condition = "n > (SIZE_MAX - sizeof(fwp_arr)) / sizeof(V)";
    let wide_condition = "n > (SIZE_MAX - sizeof(fwp_arr)) / fwp_array_stride(elem)";
    assert_eq!(constructor.matches(condition).count(), 1);
    for opt in ["-O1", "-O2"] {
        for (label, code) in [
            ("checked", constructor.to_string()),
            ("omitted", constructor.replace(condition, "0")),
            ("omitted-wide", constructor.replace(wide_condition, "0")),
        ] {
            let cfile = directory.join(format!("{label}{}.c", &opt[1..]));
            let executable = cfile.with_extension("bin");
            let probe = include_str!("fixtures/packed_array_size_probe.c")
                .replace("/* ARRAY_CONSTRUCTOR */", &code);
            std::fs::write(&cfile, &probe).unwrap();
            checked(
                Command::new(std::env::var_os("CC").unwrap_or_else(|| "cc".into()))
                    .args(["-std=c11", opt, "-fsanitize=address,undefined"])
                    .arg(&cfile)
                    .arg("-o")
                    .arg(&executable),
            );
            for width in [1, 2, 4, 8, 16] {
                let output = Command::new(&executable)
                    .arg(width.to_string())
                    .output()
                    .unwrap();
                let expected = if label == "checked"
                    || (label == "omitted" && width == 16)
                    || (label == "omitted-wide" && width != 16)
                {
                    1
                } else if width >= 8 {
                    129
                } else {
                    130
                };
                assert_eq!(
                    output.status.code(),
                    Some(expected),
                    "{label} {opt} width={width}: {}",
                    String::from_utf8_lossy(&output.stderr)
                );
            }
        }
    }
    std::fs::remove_dir_all(directory).unwrap();
}
fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(
        output.status.success(),
        "{command:?}: {}",
        String::from_utf8_lossy(&output.stderr)
    );
    output
}
#[test]
fn array_size_limits_agree_with_raw_interpreter_and_generic_wrappers() {
    let directory = std::env::temp_dir().join(format!("fwp-array-size-{}", std::process::id()));
    std::fs::create_dir(&directory).unwrap();
    struct Scratch(PathBuf);
    impl Drop for Scratch {
        fn drop(&mut self) {
            let _ = std::fs::remove_dir_all(&self.0);
        }
    }
    let scratch = Scratch(directory);
    let prefix = "make-array : I64 -> Array[I64]\nmake-array = flip array.make 0\ngenerate-array : I64 -> Array[I64]\ngenerate-array = flip array.generate (const \"callback control\" | prim.trap)\nbad-argument : I64 -> Array[I64]\nbad-argument = fork array.make id (const \"argument control\" | prim.trap)\n";
    let cases = [
        (
            "make-overflow",
            "add 2305843009213693952 | make-array",
            Some("array too large"),
        ),
        (
            "generate-overflow",
            "add 2305843009213693952 | generate-array",
            Some("array too large"),
        ),
        (
            "argument-order",
            "add 2305843009213693952 | bad-argument",
            Some("argument control"),
        ),
        ("negative-make", "sub 1 | make-array", None),
        ("negative-generate", "sub 1 | generate-array", None),
    ];
    let fwp = env!("CARGO_BIN_EXE_fwp");
    for (label, expression, trap) in cases {
        let source = scratch.0.join(format!("{label}.fwp"));
        std::fs::write(
            &source,
            format!(
                "{prefix}main = read-all () | string.length | {expression} | array.length | echo\n"
            ),
        )
        .unwrap();
        let reference = Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source)
            .output()
            .unwrap();
        assert_eq!(
            reference.status.code(),
            Some(if trap.is_some() { 101 } else { 0 }),
            "{label}: {}",
            String::from_utf8_lossy(&reference.stderr)
        );
        if let Some(trap) = trap {
            assert_eq!(reference.stderr, format!("fwp: trap: {trap}\n").as_bytes());
        } else {
            assert_eq!(reference.stdout, b"0\n");
        }
        for opt in ["-O1", "-O2"] {
            for reuse in ["0", "1"] {
                let executable = scratch
                    .0
                    .join(format!("{label}{}-reuse{reuse}", &opt[1..]))
                    .with_extension(std::env::consts::EXE_EXTENSION);
                let cfile = executable.with_extension("c");
                checked(
                    Command::new(fwp)
                        .env_remove("FWP_NO_OPT")
                        .args(["build", opt, "--emit-c", "-o"])
                        .arg(&cfile)
                        .arg(&source),
                );
                let mut code = std::fs::read_to_string(&cfile).unwrap();
                if reuse == "0" {
                    code.insert_str(0, "#define FWP_NO_REUSE 1\n");
                }
                std::fs::write(&cfile, &code).unwrap();
                fwp::cgen::compile_c(&code, &executable, opt).unwrap();
                let output = Command::new(&executable).output().unwrap();
                if let Some(destination) = std::env::var_os("FWP_ARRAY_SIZE_ARTIFACTS") {
                    let destination = PathBuf::from(destination);
                    std::fs::create_dir_all(&destination).unwrap();
                    let prefix = destination.join(executable.file_name().unwrap());
                    std::fs::copy(&source, prefix.with_extension("fwp")).unwrap();
                    std::fs::copy(&cfile, prefix.with_extension("c")).unwrap();
                    std::fs::copy(&executable, prefix.with_extension("bin")).unwrap();
                    std::fs::write(prefix.with_extension("stdout"), &output.stdout).unwrap();
                    std::fs::write(prefix.with_extension("stderr"), &output.stderr).unwrap();
                    std::fs::write(
                        prefix.with_extension("status"),
                        format!("{}\n", output.status),
                    )
                    .unwrap();
                }
                assert_eq!(
                    output.status.code(),
                    reference.status.code(),
                    "{label} {opt} reuse{reuse}"
                );
                assert_eq!(
                    output.stdout, reference.stdout,
                    "{label} {opt} reuse{reuse}"
                );
                assert_eq!(
                    output.stderr, reference.stderr,
                    "{label} {opt} reuse{reuse}"
                );
            }
        }
    }
}
#[test]
fn generic_array_constructor_checks_before_multiplication() {
    let directory =
        std::env::temp_dir().join(format!("fwp-array-constructor-{}", std::process::id()));
    std::fs::create_dir(&directory).unwrap();
    let source = include_str!("../runtime/fwp_rt.c");
    let start = source.find("static V fwp_arr_new(size_t n) {").unwrap();
    let end = start + source[start..].find("\n}").unwrap() + 2;
    let constructor = &source[start..end];
    let condition = "n > (SIZE_MAX - sizeof(fwp_arr)) / sizeof(V)";
    assert_eq!(constructor.matches(condition).count(), 1);
    for opt in ["-O1", "-O2"] {
        for (label, code, expected) in [
            ("checked", constructor.to_string(), 1),
            ("omitted", constructor.replace(condition, "0"), 129),
        ] {
            let cfile = directory.join(format!("{label}{}.c", &opt[1..]));
            let executable = cfile.with_extension("bin");
            let probe = include_str!("fixtures/array_size_probe.c")
                .replace("/* ARRAY_CONSTRUCTOR */", &code);
            std::fs::write(&cfile, &probe).unwrap();
            checked(
                Command::new(std::env::var_os("CC").unwrap_or_else(|| "cc".into()))
                    .args(["-std=c11", opt, "-fsanitize=address,undefined"])
                    .arg(&cfile)
                    .arg("-o")
                    .arg(&executable),
            );
            let output = Command::new(&executable).output().unwrap();
            if let Some(destination) = std::env::var_os("FWP_ARRAY_SIZE_ARTIFACTS") {
                let destination = PathBuf::from(destination);
                std::fs::create_dir_all(&destination).unwrap();
                let prefix = destination.join(format!("constructor-{label}{}", &opt[1..]));
                std::fs::write(prefix.with_extension("c"), &probe).unwrap();
                std::fs::copy(&executable, prefix.with_extension("bin")).unwrap();
                std::fs::write(prefix.with_extension("stdout"), &output.stdout).unwrap();
                std::fs::write(prefix.with_extension("stderr"), &output.stderr).unwrap();
                std::fs::write(
                    prefix.with_extension("status"),
                    format!("{}\n", output.status),
                )
                .unwrap();
            }
            assert_eq!(
                output.status.code(),
                Some(expected),
                "{label} {opt}: {}",
                String::from_utf8_lossy(&output.stderr)
            );
        }
    }
    std::fs::remove_dir_all(directory).unwrap();
}
#[test]
fn non_tracing_allocation_preserves_size_zeroing_alignment_and_failure() {
    let directory = std::env::temp_dir().join(format!("fwp-wasm-size-{}", std::process::id()));
    std::fs::create_dir(&directory).unwrap();
    let source = include_str!("../runtime/fwp_rt_heap.c");
    let start = source.find("static void *fwp_alloc(size_t n) {").unwrap();
    let end = source[start..]
        .find("static void *fwp_alloc_leaf(")
        .unwrap()
        + start;
    let allocator = &source[start..end];
    assert_eq!(allocator.matches("n ? n : 1").count(), 1);
    assert_eq!(allocator.matches("if (!p)").count(), 1);
    let variants = [
        ("checked", allocator.to_string(), 102),
        ("omit-empty", allocator.replace("n ? n : 1", "n"), 131),
        ("omit-failure", allocator.replace("if (!p)", "if (0)"), 128),
    ];
    for opt in ["-O1", "-O2"] {
        for (label, code, expected) in &variants {
            let cfile = directory.join(format!("{label}{}.c", &opt[1..]));
            let executable = cfile.with_extension("bin");
            let probe =
                include_str!("fixtures/wasm_size_probe.c").replace("/* WASM_ALLOCATOR */", code);
            std::fs::write(&cfile, &probe).unwrap();
            checked(
                Command::new(std::env::var_os("CC").unwrap_or_else(|| "cc".into()))
                    .args(["-std=c11", opt, "-fsanitize=address,undefined"])
                    .arg(&cfile)
                    .arg("-o")
                    .arg(&executable),
            );
            let output = Command::new(&executable).output().unwrap();
            if let Some(destination) = std::env::var_os("FWP_ARRAY_SIZE_ARTIFACTS") {
                let destination = PathBuf::from(destination);
                std::fs::create_dir_all(&destination).unwrap();
                let prefix = destination.join(format!("wasm-allocation-{label}{}", &opt[1..]));
                std::fs::write(prefix.with_extension("c"), &probe).unwrap();
                std::fs::copy(&executable, prefix.with_extension("bin")).unwrap();
                std::fs::write(prefix.with_extension("stdout"), &output.stdout).unwrap();
                std::fs::write(prefix.with_extension("stderr"), &output.stderr).unwrap();
                std::fs::write(
                    prefix.with_extension("status"),
                    format!("{}\n", output.status),
                )
                .unwrap();
            }
            assert_eq!(
                output.status.code(),
                Some(*expected),
                "{label} {opt}: {}",
                String::from_utf8_lossy(&output.stderr)
            );
        }
    }
    std::fs::remove_dir_all(directory).unwrap();
}
