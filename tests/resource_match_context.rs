//! Nominal match payload disposal agrees with raw source lifetimes.
#![cfg(any(target_os = "linux", target_os = "macos"))]
use std::os::unix::process::CommandExt;
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

#[test]
fn nested_nominal_match_discard_preserves_source_resource_lifetimes() {
    let dir = fwp::cgen::TempDir::new("nominal-resource-context").unwrap();
    let data = dir.join("data");
    std::fs::write(&data, "contents").unwrap();
    let source = dir.join("probe.fwp");
    std::fs::write(
        &source,
        format!(
            r#"
Inner = | Held File
Outer = | Wrap Inner I64
discard : File -> I64
discard = Held | flip Wrap 17 | match
    Wrap _ _ -> curry .1
step : (I64, String) -> Step[(I64, String), ()] ! {{FileIO, Error[IoError]}}
step = if (.0 | eq 0) (const () | Stop)
    (both (.1 | file.open | discard | ignore) (make {{0 = .0 | sub 1, 1 = .1}}) | .1 | Again)
main = (64, "{}") | loop step | const "discarded" | echo
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
            .arg(&source),
        32,
    ));
    assert_eq!(reference.stdout, b"discarded\n");
    let exe = dir.join("probe");
    for unoptimized in [false, true] {
        for opt in ["-O1", "-O2"] {
            for copy in [false, true] {
                let cfile = exe.with_extension("c");
                let mut build = Command::new(fwp);
                build
                    .args(["build", "--emit-c"])
                    .arg(&source)
                    .args([opt, "-o"])
                    .arg(&cfile);
                if unoptimized {
                    build.env("FWP_NO_OPT", "1");
                } else {
                    build.env_remove("FWP_NO_OPT");
                }
                checked(&mut build);
                let mut code = std::fs::read_to_string(cfile).unwrap();
                if copy {
                    code.insert_str(0, "#define FWP_NO_REUSE 1\n");
                }
                fwp::cgen::compile_c(&code, &exe, opt).unwrap();

                let got = checked(limit_descriptors(&mut Command::new(&exe), 32));
                assert_eq!(got.stdout, reference.stdout);
                assert_eq!(got.stderr, reference.stderr);
            }
        }
    }
}
