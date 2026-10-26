//! Explicit C registrations own captures through return, reentry and unwind.
use std::path::Path;
use std::process::{Command, Output};

#[path = "support/ownership_ledger.rs"]
mod ownership_ledger;

fn checked(command: &mut Command) -> Output {
    let result = command.output().unwrap();
    assert!(result.status.success(), "{command:?}: {result:?}");
    result
}

fn run(binary: &Path, mode: &str, rounds: &str) -> Command {
    let mut command = Command::new(binary);
    command
        .args([mode, rounds])
        .env_remove("FWP_GC")
        .env("FWP_REUSE_VERIFY", "0")
        .env("FWP_GC_VERIFY", "0")
        .env("FWP_GC_STRESS", "0");
    command
}

#[test]
fn retained_callbacks_release_captures_after_the_last_active_call() {
    let dir = fwp::cgen::TempDir::new("retained-callbacks").unwrap();
    let input = dir.join("callbacks.fwp");
    std::fs::write(&input, include_str!("fixtures/retained_callbacks.fwp")).unwrap();
    let cfile = dir.join("callbacks.c");
    let mut emit = Command::new(env!("CARGO_BIN_EXE_fwp"));
    emit.args(["build", "--staticlib", "--emit-c"]);
    for export in [
        "keep", "count", "second", "unary", "discard", "words", "inside", "failing", "blocked",
    ] {
        emit.args(["--c-callback", export]);
    }
    checked(emit.arg(&input).arg("-o").arg(&cfile));
    let source = std::fs::read_to_string(&cfile).unwrap();
    let header = std::fs::read_to_string(cfile.with_extension("h")).unwrap();
    assert!(source.contains("#define FWP_RETAINED_CALLBACKS 1"));
    let allocation = "static inline void *fwp_heap_alloc(size_t n, int kind) {";
    let observed = ownership_ledger::instrument_native(&source, 65536);
    assert_eq!(observed.matches(allocation).count(), 1);
    let observed = observed.replace(allocation, &format!("{allocation}\n    if (callback_fail_after && !--callback_fail_after) fwp_trap(\"callback allocation failure\");"));
    let source = format!(
        "static unsigned callback_fail_after;\n{observed}\n{}",
        include_str!("fixtures/retained_callbacks_probe.c")
    );
    // Compile a separate host against the actual generated header. An owned
    // result remains usable after releasing its registration, then is released.
    let host = format!(
        "{header}\n{}",
        r#"
#include <stdlib.h>
#include <string.h>
int callback_probe(int, unsigned);
int main(int argc, char **argv) {
    if (argc != 3) return 240;
    struct fwp_callback_keep *registration = fwp_register_keep("header ABI");
    const char *result = NULL;
    if (!fwp_invoke_keep(registration, &result)) return 240;
    fwp_release_callback_keep(registration);
    if (strcmp(result, "header ABI")) return 240;
    fwp_release_keep(result);
    return callback_probe(atoi(argv[1]), (unsigned)atoi(argv[2]));
}
"#
    );
    let library = dir.join("callbacks.a");
    let binary = dir.join("host.exe");
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_library(&source, &header, &library, opt, fwp::cgen::LibKind::Static)
            .unwrap();
        let links = fwp::ffi::links();
        fwp::ffi::set_links(vec![library.to_string_lossy().into_owned()]);
        let compiled = fwp::cgen::compile_c(&host, &binary, opt);
        fwp::ffi::set_links(links);
        compiled.unwrap();
        for rounds in ["8", "1024"] {
            checked(&mut run(&binary, "0", rounds));
        }
        for (mode, diagnostic) in [
            ("1", "callback library called from a different OS thread"),
            (
                "2",
                "release callback registrations before unloading the library",
            ),
        ] {
            let result = run(&binary, mode, "1").output().unwrap();
            assert!(!result.status.success());
            assert!(
                String::from_utf8_lossy(&result.stderr).contains(diagnostic),
                "{result:?}"
            );
        }
    }
    let loader_source = dir.join("loader.c");
    let loader = dir.join("loader.exe");
    std::fs::write(
        &loader_source,
        include_str!("fixtures/retained_callbacks_host.c"),
    )
    .unwrap();
    let cc = std::env::var("CC").unwrap_or_else(|_| "cc".into());
    let mut build_loader = Command::new(cc);
    build_loader
        .arg("-O2")
        .arg(&loader_source)
        .arg("-o")
        .arg(&loader);
    if cfg!(target_os = "linux") {
        build_loader.arg("-ldl");
    }
    checked(&mut build_loader);
    let shared = dir.join(format!(
        "callbacks.{}",
        fwp::cgen::shared_library_extension()
    ));
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_library(&source, &header, &shared, opt, fwp::cgen::LibKind::Shared)
            .unwrap();
        for rounds in ["8", "1024"] {
            checked(
                Command::new(&loader)
                    .arg(&shared)
                    .args(["0", rounds])
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0"),
            );
        }
        let result = Command::new(&loader)
            .arg(&shared)
            .args(["3", "1"])
            .env_remove("FWP_GC")
            .env("FWP_GC_STRESS", "0")
            .env("FWP_GC_VERIFY", "0")
            .env("FWP_REUSE_VERIFY", "0")
            .output()
            .unwrap();
        assert!(!result.status.success());
        assert!(
            String::from_utf8_lossy(&result.stderr)
                .contains("release callback registrations before unloading the library"),
            "{result:?}"
        );
    }
    // Each removed operation has a distinct observer. Early destruction is
    // detected by allocation identity before the test reads a stale capture.
    let drop_start = source.find("static void fwp_callback_drop_keep(").unwrap();
    let drop_end = source[drop_start..].find("\n}").unwrap() + drop_start;
    let mut missing_capture = source.clone();
    missing_capture.replace_range(
        drop_start..drop_end,
        "static void fwp_callback_drop_keep(fwp_callback_context *context) { (void)context;",
    );
    let entry = source.find("int fwp_invoke_keep(").unwrap();
    let leave = "fwp_cleanup_pop(&callback_cleanup); fwp_callback_leave(context);";
    let offset = entry + source[entry..].find(leave).unwrap();
    let mut missing_leave = source.clone();
    missing_leave.replace_range(
        offset..offset + leave.len(),
        "fwp_cleanup_pop(&callback_cleanup);",
    );
    let shutdown = source
        .find("static void fwp_library_tasks_finish(void) {")
        .unwrap();
    let release_root = shutdown
        + source[shutdown..]
            .find("        fwp_mem_free(fwp_root);")
            .unwrap();
    let mut missing_root = source.clone();
    missing_root.replace_range(
        release_root..release_root + "        fwp_mem_free(fwp_root);".len(),
        "",
    );
    for (name, broken, expected) in [
        ("capture", missing_capture, 241),
        (
            "active",
            source.replace("    if (context->active) return;", ""),
            242,
        ),
        ("leave", missing_leave, 243),
        (
            "context",
            source.replace("        fwp_mem_free(context);", ""),
            241,
        ),
        ("library-root", missing_root, 205),
    ] {
        assert_ne!(broken, source);
        let binary = dir.join(format!("broken-{name}.exe"));
        fwp::cgen::compile_c(
            &format!("{broken}\nint main(void) {{ return callback_probe(0, 8); }}"),
            &binary,
            "-O2",
        )
        .unwrap();
        let result = run(&binary, "0", "8").output().unwrap();
        assert_eq!(result.status.code(), Some(expected), "{name}: {result:?}");
    }
    if cfg!(target_os = "linux") {
        let missing_waiter = source.replace("        fwp_mem_free(waiter);", "");
        assert_ne!(missing_waiter, source);
        let binary = dir.join("missing-waiter.exe");
        fwp::cgen::compile_c(
            &format!("{missing_waiter}\nint main(void) {{ return callback_probe(0, 8); }}"),
            &binary,
            "-O2",
        )
        .unwrap();
        let result = run(&binary, "0", "8").output().unwrap();
        assert_eq!(result.status.code(), Some(205), "{result:?}");
    }
    // CLI admission rejects unsupported policies instead of changing them.
    for (flags, diagnostic) in [
        (
            vec!["--c-callback", "keep"],
            "requires --staticlib/--cdylib and --gc arc",
        ),
        (
            vec!["--staticlib", "--c-callback", "keep"],
            "requires --staticlib/--cdylib and --gc arc",
        ),
        (
            vec!["--staticlib", "--c-callback", "absent"],
            "unknown C callback export",
        ),
        (
            vec![
                "--staticlib",
                "--c-callback",
                "keep",
                "--c-callback",
                "keep",
            ],
            "duplicate or conflicting C callback symbol",
        ),
    ] {
        let result = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .arg("build")
            .arg("--emit-c")
            .args(flags)
            .arg(&input)
            .arg("-o")
            .arg(&cfile)
            .output()
            .unwrap();
        assert!(!result.status.success());
        assert!(
            String::from_utf8_lossy(&result.stderr).contains(diagnostic),
            "{result:?}"
        );
    }
}
