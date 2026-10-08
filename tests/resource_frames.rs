//! Original resource frames survive inlining and preserve returned aliases.
#![cfg(any(target_os = "linux", target_os = "macos"))]
use std::os::unix::process::CommandExt;
use std::path::PathBuf;
use std::process::{Command, Output};
fn checked(command: &mut Command) -> Output {
    let out = command.output().unwrap();
    assert!(
        out.status.success(),
        "{command:?}: {}: {}",
        out.status,
        String::from_utf8_lossy(&out.stderr)
    );
    out
}
fn limit_descriptors(command: &mut Command, bound: u64) -> &mut Command {
    #[repr(C)]
    struct Limit {
        current: u64,
        maximum: u64,
    }
    unsafe extern "C" {
        fn setrlimit(resource: i32, limit: *const Limit) -> i32;
    }
    #[cfg(target_os = "macos")]
    const NOFILE: i32 = 8;
    #[cfg(not(target_os = "macos"))]
    const NOFILE: i32 = 7;
    // Only the program child changes its descriptor bound. Its compiler,
    // the test process and the user's session retain their own limits.
    unsafe {
        command.pre_exec(move || {
            if setrlimit(
                NOFILE,
                &Limit {
                    current: bound,
                    maximum: bound,
                },
            ) != 0
            {
                return Err(std::io::Error::last_os_error());
            }
            Ok(())
        });
    }
    command
}
struct Scratch(PathBuf);
impl Drop for Scratch {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}
#[test]
fn parameter_owner_stays_live_until_its_original_frame_exits() {
    let dir =
        Scratch(std::env::temp_dir().join(format!("fwp-file-parameter-{}", std::process::id())));
    std::fs::create_dir_all(&dir.0).unwrap();
    let data = dir.0.join("data");
    std::fs::write(&data, "contents").unwrap();
    let src = dir.0.join("parameter.fwp");
    std::fs::write(
        &src,
        format!(
            r#"reopen : File -> () ! {{FileIO, Error[IoError]}}
reopen = ignore | const "{}" | file.open | file.close
main = "{}" | file.open | reopen
"#,
            data.display(),
            data.display()
        ),
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = limit_descriptors(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src),
        4,
    )
    .output()
    .unwrap();
    assert_eq!(
        reference.status.code(),
        Some(1),
        "{}",
        String::from_utf8_lossy(&reference.stderr)
    );
    assert!(String::from_utf8_lossy(&reference.stderr).contains("Too many open files"));
    let optimized = limit_descriptors(Command::new(fwp).args(["run", "--interp"]).arg(&src), 4)
        .output()
        .unwrap();
    assert_eq!(optimized.status.code(), reference.status.code());
    assert_eq!(optimized.stdout, reference.stdout);
    assert_eq!(optimized.stderr, reference.stderr);
    for opt in ["-O1", "-O2"] {
        let exe = dir.0.join(opt);
        checked(
            Command::new(fwp)
                .arg("build")
                .arg(&src)
                .args([opt, "-o"])
                .arg(&exe),
        );
        let native = limit_descriptors(Command::new(&exe).env("FWP_GC", "off"), 4)
            .output()
            .unwrap();
        assert_eq!(native.status.code(), reference.status.code());
        assert_eq!(native.stdout, reference.stdout);
        assert_eq!(native.stderr, reference.stderr);
    }
}

#[test]
fn inlined_helper_frames_release_original_locals_before_the_next_call() {
    let dir = Scratch(std::env::temp_dir().join(format!("fwp-file-helper-{}", std::process::id())));
    std::fs::create_dir_all(&dir.0).unwrap();
    let data = dir.0.join("data");
    std::fs::write(&data, "contents").unwrap();
    let src = dir.0.join("helper.fwp");
    std::fs::write(
        &src,
        format!(
            r#"discard : () -> () ! {{FileIO, Error[IoError]}}
discard = const "{}" | file.open | ignore
main = [discard (), discard ()] | ignore | const "closed" | print
"#,
            data.display()
        ),
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(limit_descriptors(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src),
        4,
    ));
    assert_eq!(reference.stdout, b"closed\n");
    let optimized = checked(limit_descriptors(
        Command::new(fwp).args(["run", "--interp"]).arg(&src),
        4,
    ));
    assert_eq!(optimized.stdout, reference.stdout);
    for opt in ["-O1", "-O2"] {
        for flags in ["0", "1"] {
            let exe = dir.0.join(format!("helper{opt}-{flags}"));
            checked(
                Command::new(fwp)
                    .arg("build")
                    .arg(&src)
                    .args([opt, "-o"])
                    .arg(&exe)
                    .env("FWP_REUSE", flags)
                    .env("FWP_FREE", flags),
            );
            let native = checked(limit_descriptors(
                Command::new(&exe).env("FWP_GC", "off"),
                4,
            ));
            assert_eq!(native.stdout, reference.stdout);
        }
    }
}

#[test]
fn resource_frame_results_and_handled_errors_keep_their_file_aliases() {
    let dir = Scratch(
        std::env::temp_dir().join(format!("fwp-file-frame-results-{}", std::process::id())),
    );
    std::fs::create_dir_all(&dir.0).unwrap();
    let data = dir.0.join("data");
    std::fs::write(&data, "contents").unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    for (name, body) in [
        (
            "results",
            r#"through : File -> File
through = id
box : File -> {file: File}
box = make {file = id}
main = "PATH" | file.open | through | box | .file | file.read-all | second file.close | .0 | echo
"#,
        ),
        (
            "error",
            r#"give-error : File -> () ! {Error[File]}
give-error = fail
main = "PATH" | file.open | attempt give-error | match
    Ok _ -> const "unexpected" | echo
    Err _ -> file.read-all | second file.close | .0 | echo
"#,
        ),
    ] {
        let src = dir.0.join(format!("{name}.fwp"));
        std::fs::write(&src, body.replace("PATH", &data.to_string_lossy())).unwrap();
        let reference = checked(limit_descriptors(
            Command::new(fwp)
                .env("FWP_NO_OPT", "1")
                .args(["run", "--interp"])
                .arg(&src),
            4,
        ));
        assert_eq!(reference.stdout, b"contents\n");
        let optimized = checked(limit_descriptors(
            Command::new(fwp).args(["run", "--interp"]).arg(&src),
            4,
        ));
        assert_eq!(optimized.stdout, reference.stdout);
        for opt in ["-O1", "-O2"] {
            let exe = dir.0.join("probe");
            checked(
                Command::new(fwp)
                    .arg("build")
                    .arg(&src)
                    .args([opt, "-o"])
                    .arg(&exe),
            );
            for poison in ["0", "1"] {
                let native = checked(limit_descriptors(
                    Command::new(&exe)
                        .env("FWP_GC_STRESS", "1")
                        .env("FWP_GC_VERIFY", "1")
                        .env("FWP_REUSE_VERIFY", poison),
                    4,
                ));
                assert_eq!(native.stdout, reference.stdout);
            }
        }
    }
}
