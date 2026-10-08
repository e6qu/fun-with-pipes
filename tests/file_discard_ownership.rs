//! Affine resource discard must agree without relying on a collection.
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
fn discarded_files_close_before_the_next_iteration_without_collection() {
    let dir =
        Scratch(std::env::temp_dir().join(format!("fwp-file-discard-{}", std::process::id())));
    std::fs::create_dir_all(&dir.0).unwrap();
    let data = dir.0.join("data");
    std::fs::write(&data, "contents").unwrap();
    let src = dir.0.join("discard.fwp");
    std::fs::write(
        &src,
        format!(
            r#"step : (I64, String) -> Step[(I64, String), ()] ! {{FileIO, Error[IoError]}}
step = if (.0 | eq 0) (const () | Stop)
    (both (.1 | file.open | ignore) (make {{0 = .0 | sub 1, 1 = .1}}) | .1 | Again)
main = (64, "{}") | loop step | const "discarded" | print
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
        32,
    ));
    assert_eq!(reference.stdout, b"discarded\n");
    for opt in ["-O1", "-O2"] {
        for reuse in ["0", "1"] {
            for free in ["0", "1"] {
                let exe = dir.0.join(format!("{opt}-{reuse}-{free}"));
                checked(
                    Command::new(fwp)
                        .arg("build")
                        .arg(&src)
                        .args([opt, "-o"])
                        .arg(&exe)
                        .env("FWP_REUSE", reuse)
                        .env("FWP_FREE", free),
                );
                for gc in ["off", "on"] {
                    for poison in ["0", "1"] {
                        let native = checked(limit_descriptors(
                            Command::new(&exe)
                                .env("FWP_GC", gc)
                                .env("FWP_GC_STRESS", "1")
                                .env("FWP_GC_VERIFY", "1")
                                .env("FWP_REUSE_VERIFY", poison),
                            32,
                        ));
                        assert_eq!(native.stdout, reference.stdout);
                    }
                }
            }
        }
    }
    let emitted = dir.0.join("discard.c");
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&emitted),
    );
    let c = std::fs::read_to_string(emitted).unwrap();
    let mut omitted = String::new();
    let mut removed = 0;
    for line in c.lines() {
        if line.contains("/* original resource frame */") {
            let (pop, _) = line.split_once("; fwp_owner_release").unwrap();
            omitted.push_str(pop);
            omitted.push_str(";\n");
            removed += 1;
        } else {
            omitted.push_str(line);
            omitted.push('\n');
        }
    }
    assert!(removed > 0);
    for opt in ["-O1", "-O2"] {
        let exe = dir.0.join("no-frame-drop");
        fwp::cgen::compile_c(&omitted, &exe, opt).unwrap();
        let out = limit_descriptors(Command::new(&exe).env("FWP_GC", "off"), 32)
            .output()
            .unwrap();
        assert_eq!(out.status.code(), Some(1));
        assert!(String::from_utf8_lossy(&out.stderr).contains("Too many open files"));
    }
}
