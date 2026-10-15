//! Checked C library calls reclaim owners before return, failure and unload.
use std::path::Path;
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(
        output.status.success(),
        "{command:?}: {:?}: {}{}",
        output.status.code(),
        String::from_utf8_lossy(&output.stdout),
        String::from_utf8_lossy(&output.stderr)
    );
    output
}

fn run(binary: &Path, report: &Path, cache: &str) -> Command {
    let mut command = Command::new(binary);
    command
        .env_remove("FWP_GC")
        .env("FWP_GC_STRESS", "0")
        .env("FWP_GC_VERIFY", "0")
        .env("FWP_REUSE_VERIFY", "0")
        .env("FWP_AD_WORKSPACE", cache)
        .env("FWP_ARC_LIBRARY_REPORT", report);
    command
}

#[test]
fn copied_library_values_match_interpreter_and_reclaim_storage() {
    let dir = fwp::cgen::TempDir::new("arc-library").unwrap();
    let input = dir.path().join("library.fwp");
    std::fs::write(&input, include_str!("fixtures/arc_library.fwp")).unwrap();
    let reference = checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input),
    );
    let cfile = dir.path().join("library.c");
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env("FWP_STACK", "0")
            .args(["build", "--gc", "arc", "--staticlib", "--emit-c"])
            .arg(&input)
            .arg("-o")
            .arg(&cfile),
    );
    let source = std::fs::read_to_string(&cfile).unwrap();
    let header = std::fs::read_to_string(cfile.with_extension("h")).unwrap();
    assert!(source.contains("#define FWP_ARC_ONLY 1"));
    let needle = "    fwp_tape_finish();\n    fwp_gc_finish();";
    assert_eq!(source.matches(needle).count(), 1);
    let source = format!(
        "static void fwp_test_finished(void);\n{}\n{}",
        source.replace(
            needle,
            "    fwp_tape_finish();\n    fwp_test_finished();\n    fwp_gc_finish();"
        ),
        include_str!("fixtures/arc_library_probe.c")
    );
    let cc = std::env::var("CC").unwrap_or_else(|_| "cc".into());
    let host = dir.path().join("host.c");
    let loader = dir.path().join("loader.exe");
    std::fs::write(&host, include_str!("fixtures/arc_library_host.c")).unwrap();
    let mut build_host = Command::new(&cc);
    build_host.arg(&host).arg("-o").arg(&loader);
    if cfg!(target_os = "linux") {
        build_host.arg("-ldl");
    }
    checked(&mut build_host);
    std::fs::write(
        &host,
        "int fwp_test_probe(void); int main(void) { return fwp_test_probe(); }\n",
    )
    .unwrap();
    for opt in ["-O1", "-O2"] {
        for kind in [fwp::cgen::LibKind::Static, fwp::cgen::LibKind::Shared] {
            let shared = matches!(kind, fwp::cgen::LibKind::Shared);
            let library = dir.path().join(if shared {
                format!("library.{}", fwp::cgen::shared_library_extension())
            } else {
                "library.a".into()
            });
            fwp::cgen::compile_library(&source, &header, &library, opt, kind).unwrap();
            let symbols = checked(Command::new("nm").arg(&library));
            let symbols = String::from_utf8_lossy(&symbols.stdout);
            for symbol in ["fwp_gc_scan", "fwp_gc_mark_all", "fwp_gc_sweep"] {
                assert!(
                    !symbols.contains(symbol),
                    "{symbol} retained in ARC library"
                );
            }
            let binary = if shared {
                loader.clone()
            } else {
                let binary = dir.path().join("static-host.exe");
                let mut link = Command::new(&cc);
                link.arg(&host).arg(&library).arg("-lm");
                if cfg!(windows) {
                    link.args(["-lws2_32", "-lshell32"]);
                } else {
                    link.arg("-lpthread");
                }
                checked(link.arg("-o").arg(&binary));
                binary
            };
            for cache in ["0", "1"] {
                let report = dir.path().join(format!("report-{opt}-{shared}-{cache}"));
                let mut command = run(&binary, &report, cache);
                if shared {
                    command.arg(&library).arg(&report);
                }
                let output = checked(&mut command);
                assert_eq!(
                    output.stdout,
                    reference.stdout.repeat(if shared { 3 } else { 1 })
                );
                assert_eq!(
                    std::fs::read_to_string(&report).unwrap(),
                    "0 0\n".repeat(if shared { 3 } else { 1 })
                );
            }
        }
    }
    // Prove that the memory check catches an omitted result release. The
    // scalar C record is copied before its counted language box is released.
    let broken = source.replace("owner.value = result; fwp_value_release(&owner);", "");
    assert_ne!(broken, source);
    let binary = dir.path().join("missing-release.exe");
    fwp::cgen::compile_c(
        &format!("{broken}\nint main(void) {{ return fwp_test_probe(); }}"),
        &binary,
        "-O2",
    )
    .unwrap();
    let output = run(&binary, &dir.path().join("broken-report"), "1")
        .output()
        .unwrap();
    assert_eq!(
        output.status.code(),
        Some(186),
        "{}",
        String::from_utf8_lossy(&output.stderr)
    );
}

#[test]
fn library_checks_every_export_and_rejects_escaping_storage() {
    let dir = fwp::cgen::TempDir::new("arc-library-reject").unwrap();
    for (name, source, diagnostic) in [
        ("string", "export text : String -> String\ntext = id\n", "pointer-free result"),
        ("record-string", "repr(C) Text = { text: String }\nexport text : Text -> Text\ntext = id\n", "pointer-free result"),
        ("pointer", "export pointer : Ptr[I64] -> I64\npointer = const 1\n", "copied C inputs"),
        ("tape", "export good : I64 -> I64\ngood = ad.scope ad.tape\nexport bad : I64 -> I64\nbad = ad.tape\n", "outside an autodiff scope"),
        ("state", "export good : () -> I64\ngood = run-state 0 get | .0\nexport bad : () -> I64 ! {State[I64]}\nbad = get\n", "outside a State scope"),
    ] {
        let input = dir.path().join(format!("{name}.fwp"));
        std::fs::write(&input, source).unwrap();
        for kind in ["--staticlib", "--cdylib"] {
            let output = Command::new(env!("CARGO_BIN_EXE_fwp"))
                .args(["build", "--gc=arc", kind, "--emit-c"])
                .arg(&input).arg("-o").arg(dir.path().join("rejected.c"))
                .output().unwrap();
            assert!(!output.status.success(), "{name} admitted");
            let error = String::from_utf8_lossy(&output.stderr);
            assert!(error.contains("--gc arc") && error.contains(diagnostic), "{name}: {error}");
        }
    }
}
