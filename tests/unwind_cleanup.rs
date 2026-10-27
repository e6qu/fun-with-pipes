//! Typed cleanup runs before failure/trap/cancellation invalidates stack frames.
use std::path::PathBuf;
use std::process::{Command, Output};

#[path = "support/ownership_ledger.rs"]
mod ownership_ledger;
#[path = "support/record_probe.rs"]
mod record_probe;

fn checked(command: &mut Command) -> Output {
    let out = command.output().unwrap();
    assert!(
        out.status.success(),
        "{command:?}: status {:?}: {}",
        out.status.code(),
        String::from_utf8_lossy(&out.stderr)
    );
    out
}
struct Scratch(PathBuf);
impl Scratch {
    fn new(name: &str) -> Self {
        let p = std::env::temp_dir().join(format!("fwp-unwind-{}-{name}", std::process::id()));
        std::fs::create_dir_all(&p).unwrap();
        Self(p)
    }
}
impl Drop for Scratch {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}

#[test]
fn scoped_file_handlers_match_interpreter() {
    let dir = Scratch::new("agreement");
    let src = dir.0.join("file.fwp");
    let data = dir.0.join("data.txt");
    let missing = dir.0.join("missing/data.txt");
    std::fs::write(&data, "scoped file contents").unwrap();
    std::fs::write(
        &src,
        format!(
            r#"
main = [
    "{}" | attempt (flip file.with file.read-all) | echo,
    "{}" | attempt (flip file.with file.read-all) | echo,
    "{}" | file.create | file.write "created" | file.close,
    "{}" | file.open | file.read-all | second file.close | .0 | echo,
] | ignore
"#,
            data.display().to_string().replace('\\', "\\\\"),
            missing.display().to_string().replace('\\', "\\\\"),
            dir.0
                .join("direct.txt")
                .display()
                .to_string()
                .replace('\\', "\\\\"),
            dir.0
                .join("direct.txt")
                .display()
                .to_string()
                .replace('\\', "\\\\")
        ),
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src),
    );
    assert!(reference
        .stdout
        .starts_with(b"Ok \"scoped file contents\"\nErr "));

    for opt in ["-O1", "-O2"] {
        let exe = dir.0.join(format!("{opt}.exe"));
        checked(
            Command::new(fwp)
                .args(["build"])
                .arg(&src)
                .args([opt, "-o"])
                .arg(&exe),
        );

        let out = checked(&mut Command::new(&exe));
        assert_eq!(out.stdout, reference.stdout, "{opt}");
    }
}

#[test]
fn owned_unwind_releases_values_files_and_tasks_without_tracing() {
    let dir = Scratch::new("owned-unwind");
    let src = dir.0.join("probe.fwp");
    let cfile = dir.0.join("probe.c");
    std::fs::write(&src, "main = task.yield () | echo\n").unwrap();
    for memory in ["dynamic", "static"] {
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .args(["build", "--memory", memory, "--emit-c"])
                .arg(&src)
                .arg("-o")
                .arg(&cfile),
        );
        let emitted = std::fs::read_to_string(&cfile).unwrap();
        let runtime = ownership_ledger::instrument_native(&emitted, 65536).replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        );
        let source = format!("{runtime}\n{}", include_str!("fixtures/owned_unwind.c"));
        let file = dir.0.join("scoped.txt");
        for opt in ["-O1", "-O2"] {
            let binary = dir.0.join(format!("{memory}{opt}.exe"));
            fwp::cgen::compile_c(&source, &binary, opt).unwrap();
            for rounds in ["8", "1024"] {
                let result = Command::new(&binary)
                    .arg(&file)
                    .arg(rounds)
                    .output()
                    .unwrap();
                let label = format!("{memory}{opt}-{rounds}");
                record_probe::save("unwind_cleanup", &label, &source, &binary, &result);
                assert!(result.status.success(), "{label}: {result:?}");
            }
        }
        for (name, broken, expected) in [
            (
                "value",
                source.replace("    fwp_rc_free_obj(owner->value);", ""),
                231,
            ),
            (
                "unwind",
                source.replace(
                    "    fwp_cleanup_unwind(fwp_handlers->cleanup);",
                    "    fwp_cleanups = fwp_handlers->cleanup; /* omit releases */",
                ),
                232,
            ),
            (
                "close",
                source.replace(
                    "static V fwp_p_file_close(V h) {",
                    "static V fwp_p_file_close(V h) { return FWP_UNIT;",
                ),
                235,
            ),
            (
                "file-storage",
                source.replace("    fwp_file_drop(handle);", ""),
                236,
            ),
        ] {
            assert_ne!(broken, source, "{name}");
            let binary = dir.0.join(format!("{memory}-{name}.exe"));
            fwp::cgen::compile_c(&broken, &binary, "-O2").unwrap();
            let result = Command::new(&binary).arg(&file).arg("8").output().unwrap();
            record_probe::save(
                "unwind_cleanup",
                &format!("{memory}-{name}"),
                &broken,
                &binary,
                &result,
            );
            assert_eq!(
                result.status.code(),
                Some(expected),
                "{memory}/{name}: {result:?}"
            );
        }
    }
}
