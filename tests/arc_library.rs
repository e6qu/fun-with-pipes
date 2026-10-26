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
    assert!(std::fs::read_to_string(cfile.with_extension("h"))
        .unwrap()
        .contains("void fwp_release_twin(struct fwp_c_Words result);"));
    let header = std::fs::read_to_string(cfile.with_extension("h")).unwrap();
    assert!(source.contains("#define FWP_ARC_ONLY 1"));
    let needle = "    fwp_tape_finish();\n    fwp_gc_finish();";
    assert_eq!(source.matches(needle).count(), 1);
    let box_entry = "static V fwp_data(uint32_t tag, uint32_t n, const V *f) {";
    assert_eq!(source.matches(box_entry).count(), 1);
    let source = source.replace(box_entry, &format!("{box_entry} fwp_library_test_boxes++;"));
    let source = format!(
        "static unsigned long long fwp_library_test_retains, fwp_library_fail_value, fwp_library_test_boxes;\nstatic unsigned fwp_library_fail_seen;\nstatic void fwp_test_finished(void);\n{}\n{}",
        source.replace(
            needle,
            "    fwp_tape_finish();\n    fwp_test_finished();\n    fwp_gc_finish();"
        ).replace("static inline void fwp_rc_dup(V v) {", "static inline void fwp_rc_dup(V v) { fwp_library_test_retains++; if (fwp_library_fail_value && v == fwp_library_fail_value && ++fwp_library_fail_seen == 2) fwp_trap(\"second result retain failed\");"),
        include_str!("fixtures/arc_library_probe.c")
    );
    let artifacts = std::env::var_os("FWP_LIBRARY_RESULT_ARTIFACTS").map(std::path::PathBuf::from);
    if let Some(path) = &artifacts {
        std::fs::create_dir_all(path).unwrap();
        std::fs::write(path.join("library.c"), &source).unwrap();
        std::fs::write(path.join("library.h"), &header).unwrap();
        std::fs::write(
            path.join("program.fwp"),
            include_str!("fixtures/arc_library.fwp"),
        )
        .unwrap();
        std::fs::write(path.join("reference.stdout"), &reference.stdout).unwrap();
        std::fs::write(
            path.join("dynamic-host.c"),
            include_str!("fixtures/arc_library_host.c"),
        )
        .unwrap();
        std::fs::write(
            path.join("static-host.c"),
            "int fwp_test_probe(void); int main(void) { return fwp_test_probe(); }\n",
        )
        .unwrap();
    }
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
            if let Some(path) = &artifacts {
                let stem = format!("library-{opt}-{}", if shared { "shared" } else { "static" });
                std::fs::copy(
                    &library,
                    path.join(format!(
                        "{stem}.{}",
                        library.extension().unwrap().to_string_lossy()
                    )),
                )
                .unwrap();
                std::fs::write(path.join(format!("{stem}.symbols.txt")), &symbols.stdout).unwrap();
            }
            let symbols = String::from_utf8_lossy(&symbols.stdout);
            for symbol in [
                "fwp_release_keep_text",
                "fwp_release_twin",
                "fwp_release_shared",
            ] {
                assert!(
                    symbols.contains(symbol),
                    "missing public result release {symbol}"
                );
            }
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
                if let Some(path) = &artifacts {
                    let stem = format!("{opt}-{shared}-{cache}");
                    std::fs::write(path.join(format!("{stem}.stdout")), &output.stdout).unwrap();
                    std::fs::write(path.join(format!("{stem}.stderr")), &output.stderr).unwrap();
                    std::fs::copy(&report, path.join(format!("{stem}.memory.txt"))).unwrap();
                }
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
    // Controls must catch lost box/host owners and redundant count traffic.
    for (name, broken, expected) in [
        (
            "box",
            source.replace("owner.value = result; fwp_value_release(&owner);", ""),
            186,
        ),
        (
            "host",
            source.replace("fwp_release_keep_text(held);", ""),
            186,
        ),
        (
            "extra-box",
            source.replace("/* move C result fields */", "V fwp_test_extra = fwp_rc_fresh(fwp_record(1, (V[]){0})); fwp_rc_free_obj(fwp_test_extra);"),
            205,
        ),
        (
            "extra-counts",
            source.replace(
                "/* move C result fields */",
                "fwp_rc_dup(result.f1); fwp_rc_drop(result.f1); /* force redundant retains */",
            ),
            202,
        ),
    ] {
        assert_ne!(broken, source);
        let binary = dir.path().join(format!("broken-{name}.exe"));
        let broken_source = format!("{broken}\nint main(void) {{ return fwp_test_probe(); }}");
        fwp::cgen::compile_c(&broken_source, &binary, "-O2").unwrap();
        let output = run(
            &binary,
            &dir.path().join(format!("broken-{name}-report")),
            "1",
        )
        .output()
        .unwrap();
        if let Some(path) = &artifacts {
            std::fs::copy(&binary, path.join(format!("broken-{name}.exe"))).unwrap();
            std::fs::write(path.join(format!("broken-{name}.c")), &broken_source).unwrap();
            std::fs::write(
                path.join(format!("broken-{name}.status")),
                format!("{:?}\n", output.status.code()),
            )
            .unwrap();
            std::fs::write(path.join(format!("broken-{name}.stderr")), &output.stderr).unwrap();
        }
        assert_eq!(
            output.status.code(),
            Some(expected),
            "{name}: {}",
            String::from_utf8_lossy(&output.stderr)
        );
    }
}

#[test]
fn library_checks_every_export_and_rejects_escaping_storage() {
    let dir = fwp::cgen::TempDir::new("arc-library-reject").unwrap();
    for (name, source, diagnostic) in [
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
            assert!(error.contains("ownership:") && error.contains(diagnostic), "{name}: {error}");
        }
    }
}
