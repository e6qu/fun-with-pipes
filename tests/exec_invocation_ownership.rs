//! Executable calls borrow inputs and own complete results through output/error.
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

#[test]
fn executable_invocations_release_projected_results_and_raised_errors() {
    let dir = fwp::cgen::TempDir::new("fwp-exec-owners").unwrap();
    let source = dir.join("owners.fwp");
    std::fs::write(
        &source,
        r#"# expose: cli

export plain : String -> String
plain = id
export wrapped : String -> Outcome[Result[Option[List[String]], String]]
wrapped = fork Cons id (string.repeat 2 | singleton) | Some | Ok | outcome.exit 7
export rejected : String -> Outcome[Result[Option[List[String]], String]]
rejected = string.repeat 2 | Err | outcome.exit 9
export absent : String -> Outcome[Result[Option[List[String]], String]]
absent = const None | Ok | outcome.exit 3
export raised : String -> String ! {Error[String]}
raised = string.repeat 2 | fail
"#,
    )
    .unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let names = ["plain", "wrapped", "rejected", "absent", "raised"];
    let mut stdout = Vec::new();
    let mut stderr = Vec::new();
    for name in names {
        for _ in 0..2 {
            let output = Command::new(compiler)
                .env("FWP_NO_OPT", "1")
                .args(["exec", "--interp", "--cli"])
                .arg(&source)
                .args([name, "owned"])
                .output()
                .unwrap();
            let expected = match name {
                "plain" => 0,
                "wrapped" => 7,
                "absent" => 3,
                _ => 1,
            };
            assert_eq!(output.status.code(), Some(expected), "{name}: {output:?}");
            stdout.extend(output.stdout);
            stderr.extend(output.stderr);
            stderr.extend(format!("status:{}\n", output.status.code().unwrap()).bytes());
        }
    }
    let cfile = dir.join("owners.c");
    checked(
        Command::new(compiler)
            .args(["build", "--cli", "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile),
    );
    let code = std::fs::read_to_string(cfile).unwrap();
    let invoke = code
        .lines()
        .find(|line| line.contains("fwp_exit_code = fwp_exec_program("))
        .unwrap();
    let probe = r#"
    fwp_tasks_init();
    intptr_t baseline = fwp_gc.budget;
    const char *names[] = {"plain", "wrapped", "rejected", "absent", "raised"};
    for (size_t name = 0; name < 5; name++) {
        const fwp_exec_spec *spec = NULL;
        for (size_t i = 0; i < sizeof exec_cmds / sizeof *exec_cmds; i++)
            if (!strcmp(exec_cmds[i]->export_name, names[name])) spec = exec_cmds[i];
        if (!spec || !spec->callable || !fwp_fns[spec->callable->fn].owned) exit(190);
        V input;
        if (!fwp_parse_text("owned", 5, spec->params[0], &input)) exit(191);
        for (int repeat = 0; repeat < 2; repeat++) {
            int failed;
            V result = fwp_exec_call(spec, &input, 1, &failed);
            int status = failed ? 1 : fwp_emit_result(spec, result);
            if (status < 0) status = 1;
            fprintf(stderr, "status:%d\n", status);
            if (STR(input)->len != 5 || memcmp(STR(input)->d, "owned", 5)) exit(192);
        }
        spec->params[0]->drop(input);
    }
    if (getenv("FWP_INVOCATION_LEDGER") && (fwp_gc.ncollect || fwp_gc.budget < baseline)) {
        fprintf(stderr, "invocation bytes left: %ld\n", (long)(baseline - fwp_gc.budget));
        exit(193);
    }
"#;
    let measured = code.replace(invoke, probe);
    for opt in ["-O1", "-O2"] {
        let binary = dir.join(if cfg!(windows) {
            "owners.exe"
        } else {
            "owners"
        });
        fwp::cgen::compile_c(&measured, &binary, opt).unwrap();
        for stress in ["0", "1"] {
            let mut command = Command::new(&binary);
            command
                .env_remove("FWP_GC")
                .env_remove("FWP_OUT")
                .env("FWP_GC_STRESS", stress)
                .env("FWP_GC_VERIFY", stress)
                .env("FWP_REUSE_VERIFY", stress);
            if stress == "0" {
                command
                    .env("FWP_GC", "off")
                    .env("FWP_INVOCATION_LEDGER", "1");
            }
            let output = checked(&mut command);
            assert_eq!(output.stdout, stdout, "{opt} stress={stress}");
            assert_eq!(output.stderr, stderr, "{opt} stress={stress}");
        }
        // The complete wrapper must remain owned while projecting the payload.
        let begin = measured.find("static int fwp_emit_result(").unwrap();
        let end = begin + measured[begin..].find("\n}\n").unwrap() + 3;
        let needle = "fwp_cleanup_pop(&cleanup); fwp_value_release(&owner);";
        assert_eq!(measured[begin..end].matches(needle).count(), 1);
        let omitted = format!(
            "{}{}{}",
            &measured[..begin],
            measured[begin..end].replace(needle, "fwp_cleanup_pop(&cleanup);"),
            &measured[end..]
        );
        fwp::cgen::compile_c(&omitted, &binary, opt).unwrap();
        let output = Command::new(&binary)
            .env("FWP_GC", "off")
            .env("FWP_INVOCATION_LEDGER", "1")
            .env("FWP_GC_STRESS", "0")
            .env("FWP_GC_VERIFY", "0")
            .env("FWP_REUSE_VERIFY", "0")
            .output()
            .unwrap();
        assert_eq!(
            output.status.code(),
            Some(193),
            "omitted result release: {output:?}"
        );
    }
}
