//! Caught I/O errors own their strings and release partial construction.
use std::process::{Command, Output};
fn checked(command: &mut Command) -> Output {
    let result = command.output().unwrap();
    assert!(result.status.success(), "{command:?}: {result:?}");
    result
}
#[test]
fn repeated_errors_and_failed_error_construction_release_storage() {
    let dir = fwp::cgen::TempDir::new("io-error-ownership").unwrap();
    let source = dir.join("error.fwp");
    std::fs::write(&source, "export exercise : () -> () ! {FileIO}\nexercise = const \"missing\\0suffix\" | attempt (file.open | file.close) | ignore\nmain = exercise ()\n")
    .unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    for mode in ["tracing", "arc"] {
        let cfile = dir.join("error.c");
        checked(
            Command::new(compiler)
                .args(["build", "--gc", mode, "--fn", "exercise", "--emit-c"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile),
        );
        let mut code = std::fs::read_to_string(cfile).unwrap();
        let entry = code[code.find("/* exercise :").unwrap()..]
            .split("static V f")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap()
            .to_string();
        let start = code.find("static V fwp_io_error(").unwrap();
        let end = start + code[start..].find("\n}\n").unwrap() + 3;
        let body = code[start..end]
            .replace("fwp_cstr(", "io_string(")
            .replace("fwp_record(", "io_record(");
        code.replace_range(
            start..end,
            &format!(
                "static V io_string(const char *);\nstatic V io_record(size_t,const V *);\n{body}"
            ),
        );
        code = code.replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        );
        code.push_str(
            &include_str!("fixtures/io_error_ownership_probe.c")
                .replace("fEXERCISE", &format!("f{entry}")),
        );
        let binary = dir.join("probe.exe");
        let run = |binary: &std::path::Path| {
            let mut command = Command::new(binary);
            command
                .env_remove("FWP_GC")
                .env("FWP_GC_STRESS", "0")
                .env("FWP_GC_VERIFY", if mode == "arc" { "0" } else { "1" })
                .env("FWP_REUSE_VERIFY", "0");
            command
        };
        for opt in ["-O1", "-O2"] {
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            checked(&mut run(&binary));
        }
        let uncounted = code.replace(
            "V error = fwp_rc_fresh(io_record(2, fields));",
            "V error = io_record(2, fields);",
        );
        let unprotected = code
            .replace(
                "fwp_value_protect(&key, &key_cleanup);",
                "(void)key_cleanup;",
            )
            .replace("(void)fwp_value_finish(&key, &key_cleanup);", "(void)key;");
        for (broken, status) in [(uncounted, 231), (unprotected, 235)] {
            assert_ne!(broken, code);
            fwp::cgen::compile_c(&broken, &binary, "-O2").unwrap();
            let result = run(&binary).output().unwrap();
            assert_eq!(result.status.code(), Some(status), "{mode}: {result:?}");
        }
    }
}
