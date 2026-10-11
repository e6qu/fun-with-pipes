//! Failed system compiler commands retain output and termination details.
#![cfg(unix)]

use std::os::unix::fs::PermissionsExt;
use std::path::{Path, PathBuf};
use std::process::{Command, Output};

struct Scratch(PathBuf);

impl Scratch {
    fn new(name: &str) -> Self {
        let path = std::env::temp_dir().join(format!(
            "fwp-compiler-diagnostics-{}-{name}",
            std::process::id()
        ));
        std::fs::create_dir(&path).unwrap();
        Self(path)
    }
}

impl Drop for Scratch {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}

fn invoke(path: &Path, interpreter: bool, compiler: Option<&Path>) -> Output {
    let mut command = Command::new(env!("CARGO_BIN_EXE_fwp"));
    if interpreter {
        command.args(["run", "--interp"]);
        command.env("FWP_NO_OPT", "1");
    } else {
        command.args(["build", "-O1", "-o"]);
        command.arg(path.with_extension("bin"));
    }
    command.arg(path);
    if let Some(compiler) = compiler {
        command.env("CC", compiler);
    }
    command.output().unwrap()
}

fn fake_compiler(dir: &Path, body: &str) -> PathBuf {
    let path = dir.join("controlled-cc");
    std::fs::write(&path, format!("#!/bin/sh\n{body}\n")).unwrap();
    std::fs::set_permissions(&path, std::fs::Permissions::from_mode(0o755)).unwrap();
    path
}

fn source(dir: &Path, interpreter: bool) -> PathBuf {
    let path = dir.join(if interpreter {
        "foreign.fwp"
    } else {
        "native.fwp"
    });
    let text = if interpreter {
        "foreign \"C\" c-abs : I32 -> I32 = \"abs\"\nmain = -7 | c-abs | echo\n"
    } else {
        "main = \"compiler-diagnostics\" | echo\n"
    };
    std::fs::write(&path, text).unwrap();
    path
}

#[test]
fn compiler_failure_preserves_stdout_stderr_and_status() {
    let dir = Scratch::new("output");
    for interpreter in [false, true] {
        let source = source(&dir.0, interpreter);
        for stderr in [false, true] {
            let body = if stderr {
                "printf '%s\\n' 'compiler stdout control' 'openssl/missing-header.h'\nprintf '%s\\n' 'compiler stderr control' >&2\nexit 37"
            } else {
                "printf '%s\\n' 'compiler stdout control' 'openssl/missing-header.h'\nexit 37"
            };
            let compiler = fake_compiler(&dir.0, body);
            let output = invoke(&source, interpreter, Some(&compiler));
            assert!(!output.status.success(), "compiler failure was accepted");
            let diagnostic = String::from_utf8_lossy(&output.stderr);
            assert!(
                diagnostic.contains("compiler stdout control"),
                "compiler stdout was discarded: {diagnostic}"
            );
            assert!(diagnostic.contains("exit status: 37"), "{diagnostic}");
            if stderr {
                assert!(
                    diagnostic.contains("compiler stderr control"),
                    "{diagnostic}"
                );
            }
            if !interpreter {
                assert!(
                    diagnostic.contains("OpenSSL 3"),
                    "stdout-only TLS hint was lost: {diagnostic}"
                );
            }
            assert!(
                diagnostic.contains(if interpreter {
                    "building the foreign function shim failed:"
                } else {
                    "C compiler failed:"
                }),
                "{diagnostic}"
            );
        }
    }
}

#[test]
fn compiler_signal_is_reported_and_successful_programs_still_run() {
    let dir = Scratch::new("signal");
    for interpreter in [false, true] {
        let source = source(&dir.0, interpreter);
        let compiler = fake_compiler(&dir.0, "kill -TERM $$");
        let output = invoke(&source, interpreter, Some(&compiler));
        assert!(!output.status.success(), "signalled compiler was accepted");
        let diagnostic = String::from_utf8_lossy(&output.stderr);
        assert!(diagnostic.contains("signal=Some(15)"), "{diagnostic}");
        let positive = invoke(&source, false, None);
        assert!(
            positive.status.success(),
            "{}",
            String::from_utf8_lossy(&positive.stderr)
        );
        let expected = if interpreter {
            b"7\n".as_slice()
        } else {
            b"compiler-diagnostics\n".as_slice()
        };
        let run = Command::new(source.with_extension("bin")).output().unwrap();
        assert!(run.status.success());
        assert_eq!(run.stdout, expected);
        let oracle = invoke(&source, true, None);
        assert!(oracle.status.success());
        assert_eq!(run.stdout, oracle.stdout);
    }
}
