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
fn file_results_survive_scoped_callbacks_tasks_and_loop_variants() {
    let dir =
        Scratch(std::env::temp_dir().join(format!("fwp-file-boundaries-{}", std::process::id())));
    std::fs::create_dir_all(&dir.0).unwrap();
    let data = dir.0.join("data");
    std::fs::write(&data, "contents").unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    for (name, source) in [
        (
            "scoped",
            r#"open-other : File -> (File, File) ! {FileIO, Error[IoError]}
open-other = file.read-all | first (ignore | const "PATH" | file.open)
main = "PATH" | flip file.with open-other | file.read-all | second file.close | .0 | echo
"#,
        ),
        (
            "task",
            r#"load : () -> File ! {FileIO}
load = const "PATH" | attempt file.open | match
    Ok _ -> id
    Err _ -> const "open failed" | prim.trap
main = task.spawn load | task.await | match
    Some _ -> file.read-all | second file.close | .0 | echo
    None -> "cancelled" | echo
"#,
        ),
        (
            "loop",
            r#"step : () -> Step[(), File] ! {FileIO, Error[IoError]}
step = const "PATH" | file.open | Stop
step-other : () -> Step[(), File] ! {FileIO, Error[IoError]}
step-other = const "PATH" | file.open | file.read-all | .1 | Stop
choose : Bool -> (() -> Step[(), File] ! {FileIO, Error[IoError]})
choose = if id (const step) (const step-other)
main = () | loop (read-all () | string.length | eq 0 | choose) | file.read-all | second file.close | .0 | echo
"#,
        ),
    ] {
        let src = dir.0.join(format!("{name}.fwp"));
        std::fs::write(&src, source.replace("PATH", &data.to_string_lossy())).unwrap();
        let reference = checked(
            Command::new(fwp)
                .env("FWP_NO_OPT", "1")
                .args(["run", "--interp"])
                .arg(&src),
        );
        assert_eq!(reference.stdout, b"contents\n", "{name}");
        if name == "scoped" {
            let emitted = dir.0.join("scoped.c");
            checked(
                Command::new(fwp)
                    .args(["build"])
                    .arg(&src)
                    .args(["--emit-c", "-o"])
                    .arg(&emitted),
            );
            let c = std::fs::read_to_string(emitted).unwrap();
            let omitted = c.replace("if (dup_result) dup_result(result);", "(void)dup_result;");
            assert_ne!(c, omitted);
            let exe = dir.0.join("no-result-owner");
            for opt in ["-O1", "-O2"] {
                fwp::cgen::compile_c(
                    &format!("#define FWP_RESOURCE_NO_FREE 1\n{omitted}"),
                    &exe,
                    opt,
                )
                .unwrap();
                let out = Command::new(&exe).output().unwrap();
                assert_eq!(out.status.code(), Some(101));
                assert!(String::from_utf8_lossy(&out.stderr).contains("duplicate discarded file"));
            }
        }

        let emitted = dir.0.join(format!("{name}.c"));
        checked(
            Command::new(fwp)
                .args(["build"])
                .arg(&src)
                .args(["--emit-c", "-o"])
                .arg(&emitted),
        );
        let c = std::fs::read_to_string(emitted).unwrap();
        let observation = "    /* Ownership observation point: before runtime teardown. */\n";
        assert_eq!(c.matches(observation).count(), 1);
        let observed = c.replace(
            observation,
            &format!("{observation}    if(fwp_heap.live)exit(29);\n"),
        );
        let release = "    fwp_rc_resource_free_obj(h);";
        assert_eq!(observed.matches(release).count(), 1);
        let omitted = observed.replace(release, "    /* omit file header release */");
        for opt in ["-O1", "-O2"] {
            for (label, code, expected) in [
                ("reuse", observed.clone(), 0),
                ("copy", format!("#define FWP_NO_REUSE 1\n{observed}"), 0),
                ("missing-release", omitted.clone(), 29),
            ] {
                let exe = dir.0.join(format!("{name}{opt}-{label}"));
                fwp::cgen::compile_c(&code, &exe, opt).unwrap();
                let native = limit_descriptors(&mut Command::new(&exe), 32)
                    .output()
                    .unwrap();
                assert_eq!(
                    native.status.code(),
                    Some(expected),
                    "{name}{opt}-{label}: {native:?}"
                );
                assert_eq!(native.stdout, reference.stdout, "{name}{opt}-{label}");
                assert!(native.stderr.is_empty(), "{name}{opt}-{label}: {native:?}");
            }
        }
    }
}
