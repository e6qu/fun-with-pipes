//! The maintained dirstat example composes filesystem and collection ownership.
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

#[test]
fn repeated_directory_reports_match_the_interpreter_and_release_storage() {
    let dir = fwp::cgen::TempDir::new("directory-report").unwrap();
    let root = dir.join("tree");
    std::fs::create_dir_all(root.join("nested")).unwrap();
    std::fs::create_dir(root.join(".hidden")).unwrap();
    for (path, bytes) in [
        ("first.rs", 7),
        ("nested/second.rs", 11),
        ("notes.txt", 5),
        ("nested/héllo.txt", 13),
        ("empty", 0),
        (".hidden/secret.rs", 17),
    ] {
        std::fs::write(root.join(path), vec![b'x'; bytes]).unwrap();
    }
    let source = dir.join("report.fwp");
    let empty_containers = r#"
empty-map : Map[String, String]
empty-map = map.empty
empty-set : Set[String]
empty-set = set.empty
empty-report : I64 -> () ! {IO}
empty-report = const () | tap (const empty-map
    | both (map.insert "key" "value" | map.values) map.size | echo)
    | tap (const empty-set | both (set.insert "value" | set.to-list) set.size | echo)
    | const empty-map | map.insert "key" "value" | map.remove "key"
    | both map.to-list map.size | echo
"#;
    let program = format!(
        "{}\n{empty_containers}\nreport : I64 -> () ! {{FileIO, IO, Error[IoError]}}\nreport = const \"tree\" | tap (dirstat {{top = 10, all = False, sort = Bytes}} | each echo) | tap (dirstat {{top = 10, all = True, sort = Files}} | each echo) | dirstat {{top = 2, all = True, sort = Name}} | each echo\nmain = range 0 64 | each (tap empty-report | report)\n",
        include_str!("../examples/cli/dirstat.fwp")
    );
    std::fs::write(&source, program).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(compiler)
            .current_dir(dir.join("."))
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    let text = String::from_utf8_lossy(&reference.stdout);
    assert_eq!(text.matches("extension").count(), 64 * 3);
    assert!(text.contains("rs") && text.contains("txt") && text.contains("(none)"));
    for mode in ["tracing", "arc"] {
        let cfile = dir.join("report.c");
        checked(
            Command::new(compiler)
                .args(["build", "--gc", mode, "--emit-c"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile),
        );
        let mut code = std::fs::read_to_string(cfile).unwrap();
        if mode == "arc" {
            let start = code
                .find("static void *fwp_main_thread(void *arg) {")
                .unwrap();
            let (runtime, main) = code.split_at(start);
            let measured = main.replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    intptr_t report_budget = fwp_gc.budget;\n")
                .replace("    fwp_cl_finish();\n", "    fwp_cl_finish();\n    if(fwp_gc.ncollect || fwp_gc.enabled || fwp_gc.budget < report_budget) exit(229);\n");
            code = format!("{runtime}{measured}");
        }
        let binary = dir.join("report.exe");
        for opt in ["-O1", "-O2"] {
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            let verify = if mode == "arc" { "0" } else { "1" };
            let actual = checked(
                Command::new(&binary)
                    .current_dir(dir.join("."))
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", verify)
                    .env("FWP_GC_VERIFY", verify)
                    .env("FWP_REUSE_VERIFY", verify),
            );
            assert_eq!(
                (&actual.stdout, &actual.stderr),
                (&reference.stdout, &reference.stderr),
                "{mode} {opt}"
            );
        }
    }
}
