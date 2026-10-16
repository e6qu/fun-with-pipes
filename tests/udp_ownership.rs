//! UDP owners preserve aliases, captured sockets, cancellation and original scopes.
#![cfg(any(target_os = "linux", target_os = "macos", target_os = "windows"))]
use std::process::{Command, Output};
fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}
fn emitted(source: &str, arc: bool, dir: &fwp::cgen::TempDir) -> String {
    let input = dir.join("main.fwp");
    let cfile = dir.join("main.c");
    std::fs::write(&input, source).unwrap();
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args([
                "build",
                "--gc",
                if arc { "arc" } else { "tracing" },
                "--emit-c",
            ])
            .arg(input)
            .arg("-o")
            .arg(&cfile),
    );
    std::fs::read_to_string(cfile).unwrap()
}

#[test]
fn udp_results_preserve_values_aliases_and_release_storage() {
    let dir = fwp::cgen::TempDir::new("udp-ownership").unwrap();
    let source = include_str!("fixtures/udp_ownership.fwp");
    let input = dir.join("main.fwp");
    std::fs::write(&input, source).unwrap();
    let raw = checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["run", "--interp"])
            .env("FWP_NO_OPT", "1")
            .arg(&input),
    );
    assert_eq!(
        raw.stdout,
        b"rebound\nFalse\nholder released\n\nping\nNone\n"
    );
    let optimized = checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["run", "--interp"])
            .env_remove("FWP_NO_OPT")
            .arg(&input),
    );
    assert_eq!(
        (&raw.stdout, &raw.stderr),
        (&optimized.stdout, &optimized.stderr)
    );
    let retained = dir.join("retained.c");
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--emit-c"])
            .env("FWP_FREE", "0")
            .arg(&input)
            .arg("-o")
            .arg(&retained),
    );
    let retained = std::fs::read_to_string(retained).unwrap();
    for opt in ["-O1", "-O2"] {
        let binary = dir.join("retained.exe");
        fwp::cgen::compile_c(&retained, &binary, opt).unwrap();
        let output = checked(Command::new(binary).env("FWP_GC", "off"));
        assert_eq!(output.stdout, raw.stdout);
        assert_eq!(output.stderr, raw.stderr);
    }
    for arc in [false, true] {
        let code = emitted(source, arc, &dir);
        for opt in ["-O1", "-O2"] {
            let binary = dir.join("udp.exe");
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            let native = checked(
                Command::new(&binary)
                    .env("FWP_GC_STRESS", if arc { "0" } else { "1" })
                    .env("FWP_GC_VERIFY", if arc { "0" } else { "1" })
                    .env("FWP_REUSE_VERIFY", if arc { "0" } else { "1" }),
            );
            assert_eq!((&native.stdout, &native.stderr), (&raw.stdout, &raw.stderr));
            let start = code
                .find("static void *fwp_main_thread(void *arg) {")
                .unwrap();
            let end = start + code[start..].find("\n}\n").unwrap() + 3;
            let body = code[start..end]
                .replace(
                    "    fwp_init_consts();\n",
                    "    fwp_init_consts();\n    fwp_tasks_init();\n    intptr_t udp_budget=fwp_gc.budget;\n",
                )
                .replace(
                    "    fwp_cl_finish();\n",
                    "    fwp_cl_finish();\n    if(fwp_gc.budget<udp_budget) exit(248);\n",
                );
            let mut measured = code.clone();
            measured.replace_range(start..end, &body);
            fwp::cgen::compile_c(&measured, &binary, opt).unwrap();
            let native = checked(
                Command::new(&binary)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0"),
            );
            assert_eq!(native.stdout, raw.stdout);
        }
    }
}
