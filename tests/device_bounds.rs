//! Array limits agree before allocation and preserve callback/argument trap order.
use std::path::PathBuf;
use std::process::{Command, Output};
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
fn device_output_limits_preserve_kernel_validation_order() {
    let directory = std::env::temp_dir().join(format!("fwp-device-size-{}", std::process::id()));
    std::fs::create_dir(&directory).unwrap();
    struct Scratch(PathBuf);
    impl Drop for Scratch {
        fn drop(&mut self) {
            let _ = std::fs::remove_dir_all(&self.0);
        }
    }
    let scratch = Scratch(directory);
    let prefix = "run-constant : I64 -> Array[F64]\nrun-constant = device.run 1 | apply ([1] | array.from-list) | apply ([2.5] | array.from-list) | apply []\nbad-code : I64 -> Array[F64]\nbad-code = device.run 1 | apply ([99] | array.from-list) | apply ([2.5] | array.from-list) | apply []\nbad-input : I64 -> Array[F64]\nbad-input = device.run 1 | apply ([0] | array.from-list) | apply ([] | array.from-list) | apply [([] | array.from-list)]\n";
    let cases = [
        (
            "output-overflow",
            "add 2305843009213693952 | run-constant",
            Some("array too large"),
            "",
        ),
        (
            "code-order",
            "add 2305843009213693952 | bad-code",
            Some("device: malformed kernel"),
            "",
        ),
        (
            "input-order",
            "add 2305843009213693952 | bad-input",
            Some("device: input 0 has 0 elements, the kernel 2305843009213693952"),
            "",
        ),
        ("negative", "sub 1 | run-constant", None, "0\n"),
        ("valid", "add 3 | run-constant", None, "3\n"),
    ];
    let fwp = env!("CARGO_BIN_EXE_fwp");
    for (label, expression, trap, stdout) in cases {
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
            assert_eq!(reference.stdout, stdout.as_bytes());
        }
        for opt in ["-O1", "-O2"] {
            for reuse in ["0", "1"] {
                let executable = scratch.0.join(format!("{label}{}-reuse{reuse}", &opt[1..]));
                let cfile = executable.with_extension("c");
                checked(
                    Command::new(fwp)
                        .env_remove("FWP_NO_OPT")
                        .env("FWP_REUSE", reuse)
                        .args(["build", opt, "--emit-c", "-o"])
                        .arg(&cfile)
                        .arg(&source),
                );
                checked(
                    Command::new(fwp)
                        .env_remove("FWP_NO_OPT")
                        .env("FWP_REUSE", reuse)
                        .args(["build", opt, "-o"])
                        .arg(&executable)
                        .arg(&source),
                );
                let output = Command::new(&executable)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", "1")
                    .output()
                    .unwrap();
                if let Some(destination) = std::env::var_os("FWP_DEVICE_BOUNDS_ARTIFACTS") {
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
fn device_allocations_are_bounded_and_cleanup_controls_detect_omissions() {
    let source = include_str!("../runtime/fwp_rt_kernel.c");
    let extract = |signature: &str| {
        let start = source.find(signature).unwrap();
        let end = start + source[start..].find("\n}").unwrap() + 2;
        source[start..end].to_string()
    };
    let device = extract("static V fwp_p_device_run(");
    let workspace = extract("static int fwp_kernel_workspace_fits(");
    let owner_type =
        "typedef struct { fwp_kernel kernel; V output; double *sums; } fwp_kernel_owner;";
    assert!(source.contains(owner_type));
    let owner = format!(
        "{owner_type}\n{}",
        extract("static void fwp_kernel_release(")
    );
    let condition = "count > (SIZE_MAX - sizeof(fwp_arr)) / sizeof(V)";
    let cleanup = "free((void *)owner->kernel.inputs);";
    assert_eq!(device.matches(condition).count(), 1);
    assert_eq!(owner.matches(cleanup).count(), 1);
    let directory = std::env::temp_dir().join(format!("fwp-device-bounds-{}", std::process::id()));
    std::fs::create_dir_all(&directory).unwrap();
    let artifacts = std::env::var_os("FWP_DEVICE_BOUNDS_ARTIFACTS")
        .map(PathBuf::from)
        .unwrap_or_else(|| directory.join("artifacts"));
    std::fs::create_dir_all(&artifacts).unwrap();
    for opt in ["-O1", "-O2"] {
        for (label, body, ownership, fits, expected) in [
            (
                "checked",
                device.clone(),
                owner.clone(),
                workspace.clone(),
                1,
            ),
            (
                "omit-count",
                device.replace(condition, "0"),
                owner.clone(),
                workspace.clone(),
                129,
            ),
            (
                "omit-cleanup",
                device.clone(),
                owner.replace(cleanup, ""),
                workspace.clone(),
                128,
            ),
            (
                "omit-workspace",
                device.clone(),
                owner.clone(),
                workspace.replace("depth <= SIZE_MAX / FWP_KCHUNK / sizeof(double)", "1"),
                133,
            ),
        ] {
            let name = format!("device-{label}{opt}");
            let cfile = artifacts.join(format!("{name}.c"));
            let executable = directory.join(&name);
            let probe = include_str!("fixtures/device_bounds_probe.c")
                .replace("/* OWNERS */", &ownership)
                .replace("/* WORKSPACE */", &fits)
                .replace("/* DEVICE_RUN */", &body);
            std::fs::write(&cfile, &probe).unwrap();
            checked(
                Command::new("clang")
                    .args([
                        "-std=c11",
                        opt,
                        "-fsanitize=address,undefined",
                        "-fno-sanitize-recover=all",
                    ])
                    .arg(&cfile)
                    .arg("-o")
                    .arg(&executable),
            );
            let output = Command::new(&executable).output().unwrap();
            std::fs::copy(&executable, artifacts.join(format!("{name}.bin"))).unwrap();
            std::fs::write(artifacts.join(format!("{name}.stdout")), &output.stdout).unwrap();
            std::fs::write(artifacts.join(format!("{name}.stderr")), &output.stderr).unwrap();
            std::fs::write(
                artifacts.join(format!("{name}.status")),
                format!("{}\n", output.status),
            )
            .unwrap();
            assert_eq!(
                output.status.code(),
                Some(expected),
                "{name}: {}",
                String::from_utf8_lossy(&output.stderr)
            );
        }
    }
    std::fs::remove_dir_all(directory).unwrap();
}
