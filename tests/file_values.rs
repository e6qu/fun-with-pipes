//! Filesystem values preserve behavior and release owned results without tracing.
use std::process::{Command, Output};
use std::time::{Duration, SystemTime};
fn checked(command: &mut Command) -> Output {
    let result = command.output().unwrap();
    assert!(result.status.success(), "{command:?}: {result:?}");
    result
}
#[test]
fn filesystem_values_match_raw_interpretation() {
    let dir = fwp::cgen::TempDir::new("file-values").unwrap();
    let root = dir.join(".");
    std::fs::write(root.join("input"), vec![255; 70000]).unwrap();
    std::fs::write(root.join("empty"), []).unwrap();
    std::fs::create_dir_all(root.join("tree/nested")).unwrap();
    std::fs::write(root.join("tree/a"), "abc").unwrap();
    std::fs::write(root.join("tree/nested/héllo"), "hello").unwrap();
    std::fs::write(root.join("tree/nested/empty"), []).unwrap();
    for (name, time) in [
        ("old", SystemTime::UNIX_EPOCH - Duration::from_secs(1)),
        (
            "future",
            SystemTime::UNIX_EPOCH + Duration::from_secs(13_569_465_600),
        ),
    ] {
        let file = std::fs::File::create(root.join(name)).unwrap();
        file.set_modified(time).unwrap();
    }
    let source = dir.join("values.fwp");
    std::fs::write(&source, include_str!("fixtures/file_values.fwp")).unwrap();
    let expected = checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .current_dir(&root)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    for gc in ["tracing", "arc"] {
        let cfile = dir.join("values.c");
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .env_remove("FWP_NO_OPT")
                .args(["build", "--gc", gc, "--emit-c"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(cfile).unwrap();
        let code = if gc == "arc" {
            let start = code
                .find("static void *fwp_main_thread(void *arg) {")
                .unwrap();
            let (runtime, main) = code.split_at(start);
            assert_eq!(main.matches("    fwp_init_consts();\n").count(), 1);
            assert_eq!(
                main.matches("    /* Ownership observation point: before runtime teardown. */\n")
                    .count(),
                1
            );
            let measured = main.replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    size_t file_live_bytes = fwp_heap.live;\n")
                .replace("    /* Ownership observation point: before runtime teardown. */\n", "    /* Ownership observation point: before runtime teardown. */\n    if (fwp_heap.live > file_live_bytes) exit(195);\n");
            format!("{runtime}{measured}")
        } else {
            code
        };
        let binary = dir.join("values.exe");
        for opt in ["-O1", "-O2"] {
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            let verify = if gc == "arc" { "0" } else { "1" };
            let actual = checked(
                Command::new(&binary)
                    .current_dir(&root)
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", verify)
                    .env("FWP_GC_VERIFY", verify)
                    .env("FWP_REUSE_VERIFY", verify),
            );
            assert_eq!(
                (&actual.stdout, &actual.stderr),
                (&expected.stdout, &expected.stderr),
                "{gc} {opt}: native stdout={} stderr={}; interpreter stdout={} stderr={}",
                String::from_utf8_lossy(&actual.stdout),
                String::from_utf8_lossy(&actual.stderr),
                String::from_utf8_lossy(&expected.stdout),
                String::from_utf8_lossy(&expected.stderr)
            );
            assert!(!root.join("made").exists());
            assert_eq!(std::fs::read(root.join("input")).unwrap(), vec![255; 70000]);
        }
        if gc == "arc" {
            let owned = code
                .lines()
                .find(|line| line.contains("return fwp_rc_fresh(fwp_p_file_read("))
                .expect("text reads have an owning result");
            let unowned = owned.replace("return fwp_rc_fresh(", "return ");
            let unowned = unowned.strip_suffix(");").unwrap().to_string() + ";";
            let broken = code.replace(owned, &unowned);
            fwp::cgen::compile_c(&broken, &binary, "-O2").unwrap();
            let result = Command::new(&binary)
                .current_dir(&root)
                .env_remove("FWP_GC")
                .env("FWP_GC_STRESS", "0")
                .env("FWP_GC_VERIFY", "0")
                .env("FWP_REUSE_VERIFY", "0")
                .output()
                .unwrap();
            assert_eq!(
                result.status.code(),
                Some(195),
                "missing text owner: {result:?}"
            );
        }
    }
}
fn instrument(mut code: String) -> String {
    let start = "static void fwp_file_buffer_cleanup(";
    let a = code.find(start).unwrap();
    let b = a + code[a..].find("\n}\n").unwrap() + 3;
    let body = code[a..b].replace("free(", "file_buffer_free(");
    assert_ne!(body, code[a..b]);
    code.replace_range(a..b, &body);
    code = code.replace(
        start,
        &format!("static void file_buffer_free(void *);\n{start}"),
    );
    let start = "static V fwp_p_file_info(";
    let mut offset = 0;
    while let Some(found) = code[offset..].find(start) {
        let a = offset + found;
        let b = a + code[a..].find("\n}\n").unwrap() + 3;
        let body = code[a..b]
            .replace("fwp_duration(", "file_duration(")
            .replace("fwp_record(", "file_record(");
        code.replace_range(a..b, &body);
        offset = a + body.len();
    }
    code = code
        .replace(
            start,
            &format!(
                "static V file_duration(int64_t);static V file_record(size_t,const V *);\n{start}"
            ),
        )
        .replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        );
    for start in [
        "static V fwp_p_file_append(",
        "static V fwp_p_file_write_bytes(",
        "static V fwp_p_file_write_new(",
    ] {
        let a = code.find(start).unwrap();
        let b = a + code[a..].find("\n}\n").unwrap() + 3;
        let body = code[a..b]
            .replace("fwrite(", "file_write_probe(")
            .replace("fclose(", "file_close_probe(");
        code.replace_range(a..b, &body);
    }
    code=code.replace("static V fwp_p_file_write_new(","static size_t file_write_probe(const void *,size_t,size_t,FILE *);static int file_close_probe(FILE *);\nstatic V fwp_p_file_write_new(");
    code.push_str(include_str!("fixtures/file_values_probe.c"));
    code
}
#[test]
fn metadata_and_file_values_release_complete_and_partial_storage() {
    let dir = fwp::cgen::TempDir::new("file-value-cleanup").unwrap();
    let input = dir.join("input");
    std::fs::write(&input, vec![255; 70000]).unwrap();
    let source = dir.join("probe.fwp");
    std::fs::write(&source, "main = [task.yield (), echo \"probe\"] | ignore\n").unwrap();
    for gc in ["tracing", "arc"] {
        let cfile = dir.join("probe.c");
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .args(["build", "--gc", gc, "--emit-c"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile),
        );
        let code = instrument(std::fs::read_to_string(cfile).unwrap());
        let binary = dir.join("probe.exe");
        let run = |collect: &str| {
            let mut cmd = Command::new(&binary);
            cmd.arg(&input)
                .arg(dir.join("output"))
                .env_remove("FWP_GC")
                .env("FWP_GC_STRESS", "0")
                .env("FWP_GC_VERIFY", if gc == "arc" { "0" } else { "1" })
                .env("FWP_REUSE_VERIFY", "0")
                .env("FWP_FILE_COLLECTION", collect);
            cmd
        };
        for opt in ["-O1", "-O2"] {
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            for collect in if gc == "arc" {
                &["0"][..]
            } else {
                &["0", "1"][..]
            } {
                checked(&mut run(collect));
            }
        }
        let missing_count = code.replace(
            "V result = fwp_rc_fresh(file_record(3, fields));",
            "V result = file_record(3, fields);",
        );
        let mut unprotected = code.clone();
        for name in ["modified", "time"] {
            unprotected = unprotected
                .replace(
                    &format!("fwp_value_protect(&{name}, &cleanup);"),
                    "(void)cleanup;",
                )
                .replace(
                    &format!("(void)fwp_value_finish(&{name}, &cleanup);"),
                    &format!("(void){name};"),
                );
        }
        for (broken, status) in [
            (missing_count, 182),
            (unprotected, 189),
            (code.replace("errno = error;", "(void)error;"), 192),
            (code.replace("file_buffer_free(b->d);", "(void)b->d;"), 199),
        ] {
            assert_ne!(broken, code);
            fwp::cgen::compile_c(&broken, &binary, "-O2").unwrap();
            assert_eq!(run("0").output().unwrap().status.code(), Some(status));
        }
    }
}
