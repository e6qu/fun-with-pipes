//! Complete executable ownership, including early returns and streamed input.
use std::io::Write;
use std::process::{Command, Output, Stdio};

fn run(command: &mut Command, input: &[u8]) -> Output {
    let mut child = command
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .unwrap();
    if let Err(error) = child.stdin.take().unwrap().write_all(input) {
        assert_eq!(error.kind(), std::io::ErrorKind::BrokenPipe);
    }
    child.wait_with_output().unwrap()
}
fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

const SOURCE: &str = r#"# expose: cli

Level = | Low | High
Options = {
    title: String,
    tag: List[String],
    # a user [env: FWP_TEST_USER] [requires: password]
    user: Option[String],
    password: Option[String],
    # a level [env: FWP_TEST_LEVEL]
    level: Level,
}
export defaults : {title: String, tag: List[String], level: Level}
defaults = { title = "default", tag = ["a", "b"], level = Low }
export render : Options -> String -> String
render = curry (make { title = .0 | .title, tag = .0 | .tag, user = .0 | .user, word = .1 } | show)
export relay : String -> String -> String
relay = concat
export collect : List[String] -> List[String]
collect = id
# args: WORDS...
export rest : List[String] -> List[String]
rest = id
export ready : String
ready = "ready" | string.repeat 2
export scoped : String -> String
scoped = run-state "seed" (put | get) | .0
export raised : String -> String ! {Error[String]}
raised = string.repeat 2 | fail
export sized : {text: String, wide: I128} -> String
sized = .text
"#;

#[test]
fn arc_commands_reclaim_arguments_frames_defaults_and_errors() {
    let dir = fwp::cgen::TempDir::new("fwp-protocol-ownership").unwrap();
    let source = dir.join("owners.fwp");
    std::fs::write(&source, SOURCE).unwrap();
    let program = fwp::driver::compile_source(
        "owners.fwp",
        SOURCE,
        fwp::mono::Roots {
            exports: true,
            ..Default::default()
        },
    )
    .map_err(|error| error.rendered)
    .unwrap()
    .1;
    let string = fwp::ir::MT::con("std::String");
    let mut binary_input = fwp::proto::header(&string, &program);
    for text in ["one", "two", "three"] {
        let mut payload = Vec::new();
        fwp::proto::encode(
            &mut payload,
            &fwp::value::Value::str(text),
            &string,
            &program,
        );
        binary_input.extend(fwp::proto::frame(&payload));
    }
    let mut malformed = binary_input.clone();
    malformed.extend(fwp::proto::frame(&[10, b'x']));
    binary_input.extend(fwp::proto::end_frame());
    let wrong_type = fwp::proto::header(&fwp::ir::MT::con("std::Bool"), &program);
    let text_stream = (0..129).map(|i| format!("word-{i}\n")).collect::<String>();
    type Case<'a> = (Vec<&'a str>, Vec<u8>, bool, &'a str, &'a str);
    let cases: Vec<Case<'_>> = vec![
        (
            vec!["relay", "prefix-"],
            text_stream.into_bytes(),
            false,
            "",
            "",
        ),
        (
            vec!["collect"],
            b"one\ntwo\nthree\n".to_vec(),
            false,
            "",
            "",
        ),
        (vec!["rest", "one", "two", "three"], vec![], false, "", ""),
        (
            vec![
                "render",
                "--title=a",
                "--title=b",
                "--tag=x",
                "--tag=y",
                "word",
            ],
            vec![],
            false,
            "",
            "",
        ),
        (vec!["render", "--tag=x", "--bogus"], vec![], false, "", ""),
        (vec!["render", "--user=ann", "word"], vec![], false, "", ""),
        (
            vec!["render", "--password=secret", "word"],
            vec![],
            false,
            "ann-λ-雪-🙂",
            "high",
        ),
        (vec!["render", "word"], vec![], false, "", "nonsense"),
        (
            vec!["render", "--title=owned", "--help"],
            vec![],
            false,
            "",
            "",
        ),
        (vec!["--help"], vec![], false, "", ""),
        (
            vec!["--completions", "unknown-shell"],
            vec![],
            false,
            "",
            "",
        ),
        (vec!["no-such-command"], vec![], false, "", ""),
        (vec!["relay"], vec![], false, "", ""),
        (vec!["ready"], vec![], false, "", ""),
        (vec!["scoped", "scoped-value"], vec![], false, "", ""),
        (vec!["raised", "error-value"], vec![], false, "", ""),
        (
            vec!["sized"],
            b"{text = \"owned\", wide = bad}\n".to_vec(),
            false,
            "",
            "",
        ),
        (
            vec!["relay", "prefix-"],
            b"invalid-\xff\n".to_vec(),
            false,
            "",
            "",
        ),
        (
            vec!["relay", "prefix-"],
            binary_input.clone(),
            false,
            "",
            "",
        ),
        (vec!["collect"], binary_input, true, "", ""),
        (vec!["collect"], malformed, false, "", ""),
        (vec!["relay", "prefix-"], wrong_type, false, "", ""),
        (
            vec!["relay", "prefix-"],
            b"FWP1\x02\0short".to_vec(),
            false,
            "",
            "",
        ),
    ];
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let mut references = Vec::new();
    for (args, input, binary, user, level) in &cases {
        let output = run(
            Command::new(compiler)
                .env("FWP_NO_OPT", "1")
                .env("FWP_TRANSPORT", "stdio")
                .env("FWP_OUT", if *binary { "bin" } else { "text" })
                .env("FWP_TEST_USER", user)
                .env("FWP_TEST_LEVEL", level)
                .args(["exec", "--interp", "--cli"])
                .arg(&source)
                .args(args),
            input,
        );
        assert!(
            matches!(output.status.code(), Some(0..=3)),
            "{args:?}: {output:?}"
        );
        references.push(output);
    }
    let cfile = dir.join("owners.c");
    checked(
        Command::new(compiler)
            .args(["build", "--cli", "--gc", "arc", "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile),
    );
    let code = std::fs::read_to_string(cfile).unwrap();
    let start = code
        .find("static void *fwp_main_thread(void *arg) {")
        .unwrap();
    let (runtime, main) = code.split_at(start);
    let measured = format!("{runtime}{}", main
        .replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    fwp_tasks_init();\n    intptr_t protocol_budget=fwp_gc.budget_given;\n")
        .replace("    /* Ownership observation point: before runtime teardown. */\n", "    /* Ownership observation point: before runtime teardown. */\n    if(fwp_gc.ncollect || fwp_gc.enabled || fwp_gc.budget < protocol_budget) { fprintf(stderr,\"protocol bytes left: %ld\\n\",(long)(protocol_budget-fwp_gc.budget)); exit(193); }\n"));
    for opt in ["-O1", "-O2"] {
        let binary = dir.join(if cfg!(windows) {
            "owners.exe"
        } else {
            "owners"
        });
        fwp::cgen::compile_c(&measured, &binary, opt).unwrap();
        for ((args, input, binary_out, user, level), reference) in cases.iter().zip(&references) {
            let output = run(
                Command::new(&binary)
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .env("FWP_TRANSPORT", "stdio")
                    .env("FWP_OUT", if *binary_out { "bin" } else { "text" })
                    .env("FWP_TEST_USER", user)
                    .env("FWP_TEST_LEVEL", level)
                    .args(args),
                input,
            );
            assert_eq!(
                output.status.code(),
                reference.status.code(),
                "{opt} {args:?}: {output:?}"
            );
            assert_eq!(output.stdout, reference.stdout, "{opt} {args:?}");
            assert_eq!(output.stderr, reference.stderr, "{opt} {args:?}");
        }
        let release = "if (s->params[i]->drop) s->params[i]->drop(owner->args[i]);";
        assert_eq!(measured.matches(release).count(), 1);
        let omitted = measured.replace(release, "/* omit command argument release */");
        fwp::cgen::compile_c(&omitted, &binary, opt).unwrap();
        let output = run(
            Command::new(binary)
                .env_remove("FWP_GC")
                .env("FWP_GC_STRESS", "0")
                .env("FWP_GC_VERIFY", "0")
                .env("FWP_REUSE_VERIFY", "0")
                .env("FWP_OUT", "text")
                .args(["relay", "prefix-"]),
            b"input\n",
        );
        assert_eq!(
            output.status.code(),
            Some(193),
            "omitted argument release: {output:?}"
        );
    }
}

#[test]
fn arc_checks_each_exported_entry_for_unscoped_effects() {
    let dir = fwp::cgen::TempDir::new("fwp-cli-scopes").unwrap();
    for (name, source) in [
        (
            "state",
            "export unsafe : String -> String ! {State[String]}\nunsafe = ignore | get\n",
        ),
        (
            "tape",
            "export unsafe : I64 -> String\nunsafe = ad.tape | show\n",
        ),
    ] {
        let input = dir.join(format!("{name}.fwp"));
        std::fs::write(&input, format!("# expose: cli\n{source}")).unwrap();
        let output = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--cli", "--gc", "arc", "--emit-c"])
            .arg(&input)
            .arg("-o")
            .arg(dir.join("rejected.c"))
            .output()
            .unwrap();
        assert!(!output.status.success(), "{name}");
        let error = String::from_utf8_lossy(&output.stderr);
        assert!(
            error.contains("ownership:") && error.contains("scope"),
            "{name}: {error}"
        );
    }
}
