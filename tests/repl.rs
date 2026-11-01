//! A session must retain values rather than replaying earlier effects.
use fwp::repl::{incomplete, Session};
use std::io::Write;
use std::process::{Command, Stdio};

#[test]
fn cell_children_finish_using_that_cells_output_writers() {
    fwp::driver::with_big_stack(|| {
        let mut session = Session::new(std::env::current_dir().unwrap()).unwrap();
        session
            .submit(
                "worker : () -> () ! {IO}\nworker = const \"cell child\" | print | const \"cell error\" | eprint",
                &mut Vec::new(),
            )
            .unwrap();
        for _ in 0..3 {
            let mut output = Vec::new();
            let mut errors = Vec::new();
            session
                .submit_with_stderr("task.spawn worker | ignore", &mut output, &mut errors)
                .unwrap();
            assert_eq!(output, b"cell child\n");
            assert_eq!(errors, b"cell error\n");
        }
    });
}

#[test]
fn json_requires_explicit_commands_and_recovers_without_executing_them() {
    fwp::driver::with_big_stack(|| {
        let input = br#"{"source":"\"must not run\" | echo"}
{"command":"submit"}
{"command":"submit","source":"\"must not run\" | echo | const 1 | ad.tape"}
{"command":"submit","source":"6 * 7"}
"#;
        let mut output = Vec::new();
        fwp::repl::run_json(&input[..], &mut output, std::env::current_dir().unwrap()).unwrap();
        let replies: Vec<_> = std::str::from_utf8(&output)
            .unwrap()
            .lines()
            .map(|line| fwp::json::Json::parse(line).unwrap())
            .collect();
        assert_eq!(replies.len(), 4);
        for reply in &replies[..3] {
            assert!(reply.get("error").is_some(), "{reply}");
            assert_eq!(
                reply.get("stdout").and_then(fwp::json::Json::as_str),
                Some("")
            );
        }
        assert!(
            replies[2]
                .get("error")
                .and_then(fwp::json::Json::as_str)
                .is_some_and(|error| error.contains("outside an autodiff scope")),
            "{}",
            replies[2]
        );
        assert_eq!(
            replies[3]
                .at(&["result", "value"])
                .and_then(fwp::json::Json::as_str),
            Some("42")
        );
    });
}

#[test]
fn notebook_dependencies_exclude_local_bindings() {
    fwp::driver::with_big_stack(|| {
        let input = br#"{"command":"analyze","source":"let out1 = 4 in let x = out1 in x + x"}
{"command":"analyze","source":"calculate = fn x -> let y = x * x in y + scale"}
{"command":"analyze","source":"let x = x + 1 in x"}
"#;
        let mut output = Vec::new();
        fwp::repl::run_json(&input[..], &mut output, std::env::current_dir().unwrap()).unwrap();
        let replies: Vec<_> = std::str::from_utf8(&output)
            .unwrap()
            .lines()
            .map(|line| fwp::json::Json::parse(line).unwrap())
            .collect();
        assert_eq!(replies.len(), 3);
        for (reply, expected) in replies.iter().zip(["[]", "[\"scale\"]", "[\"x\"]"]) {
            assert!(reply.get("error").is_none(), "{reply}");
            assert_eq!(reply.at(&["result", "uses"]).unwrap().to_string(), expected);
        }
    });
}

#[test]
fn saved_lexical_closures_keep_their_code_and_captures() {
    fwp::driver::with_big_stack(|| {
        let mut session = Session::new(std::env::current_dir().unwrap()).unwrap();
        let mut output = Vec::new();
        session
            .submit(
                "make-closure : I64 -> I64 -> I64\nmake-closure = fn n -> fn x -> n + x",
                &mut output,
            )
            .unwrap();
        session.submit("make-closure 3", &mut output).unwrap();
        session
            .submit("make-closure = fn n -> fn x -> n * x", &mut output)
            .unwrap();
        assert_eq!(
            session
                .submit("let value = 4 in out2 value", &mut output)
                .unwrap()
                .value
                .as_deref(),
            Some("7")
        );
        assert_eq!(
            session
                .submit("make-closure 3 4", &mut output)
                .unwrap()
                .value
                .as_deref(),
            Some("12")
        );
        session
            .submit(
                "let amount = 2 | tap echo in make-closure amount",
                &mut output,
            )
            .unwrap();
        assert_eq!(output, b"2\n");
        for (source, expected) in [("out6 5", "10"), ("out6 6", "12")] {
            assert_eq!(
                session
                    .submit(source, &mut output)
                    .unwrap()
                    .value
                    .as_deref(),
                Some(expected)
            );
            assert_eq!(
                output, b"2\n",
                "captured computation must run only in cell 6"
            );
        }
    });
}

#[test]
fn tools_reject_missing_execution_settings_before_starting() {
    for args in [
        vec!["repl"],
        vec!["repl", "--stream", "--history", "must-not-create-history"],
        vec!["notebook"],
        vec!["notebook", "--python", "--port", "0"],
        vec!["disassemble", "does-not-exist"],
    ] {
        let output = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(&args)
            .output()
            .unwrap();
        assert_eq!(output.status.code(), Some(2), "{args:?}: {output:?}");
        assert!(output.stdout.is_empty(), "{args:?}: {output:?}");
    }
}

#[test]
fn session_preserves_values_redefinition_and_recovers_from_errors() {
    fwp::driver::with_big_stack(|| {
        let mut session = Session::new(std::env::current_dir().unwrap()).unwrap();
        let mut output = Vec::new();
        session.submit("value = 7", &mut output).unwrap();
        assert!(output.is_empty(), "top-level values are lazy");
        assert_eq!(
            session
                .submit("(value | tap (const \"once\" | echo)) + 1", &mut output)
                .unwrap()
                .value
                .as_deref(),
            Some("8")
        );
        assert_eq!(
            session
                .submit("out2 + 1", &mut output)
                .unwrap()
                .value
                .as_deref(),
            Some("9")
        );
        assert_eq!(String::from_utf8(output.clone()).unwrap(), "once\n");
        assert_eq!(
            session
                .submit("out2 + it", &mut output)
                .unwrap()
                .value
                .as_deref(),
            Some("17")
        );
        session.submit("value = 20", &mut output).unwrap();
        assert_eq!(
            session
                .submit("value", &mut output)
                .unwrap()
                .value
                .as_deref(),
            Some("20")
        );
        assert_eq!(
            session
                .submit("out2", &mut output)
                .unwrap()
                .value
                .as_deref(),
            Some("8")
        );
        assert!(session.submit("value = missing-name", &mut output).is_err());
        assert!(session
            .submit("1 / 0", &mut output)
            .unwrap_err()
            .contains("zero"));
        assert_eq!(
            session
                .submit("value + 1", &mut output)
                .unwrap()
                .value
                .as_deref(),
            Some("21")
        );
        assert_eq!(session.type_of("value == 20").unwrap(), "Bool");
        assert!(session.names.contains(&"hypot".into()));
        assert!(session.submit("it = 0", &mut output).is_err());
        assert!(session.submit("out2 : I64", &mut output).is_err());
        session
            .submit("value = \"changed type\"", &mut output)
            .unwrap();
        assert_eq!(
            session
                .submit("out2 + 1", &mut output)
                .unwrap()
                .value
                .as_deref(),
            Some("9")
        );
        assert_eq!(session.type_of("value").unwrap(), "String");
        let resource = session
            .submit("\"must-not-create\" | file.create", &mut output)
            .unwrap_err();
        assert!(resource.contains("REPL results are reusable"), "{resource}");
    });
}

#[test]
fn closures_containers_imports_and_named_types_survive_later_cells() {
    fwp::driver::with_big_stack(|| {
        let dir = fwp::cgen::TempDir::new("repl-imports").unwrap();
        std::fs::write(
            dir.join("numbers.fwp"),
            "export increment : I64 -> I64\nincrement = add 1\n",
        )
        .unwrap();
        let mut session = Session::new(dir.join(".")).unwrap();
        let mut output = Vec::new();
        session.submit("import numbers", &mut output).unwrap();
        assert_eq!(
            session
                .submit("41 | numbers.increment", &mut output)
                .unwrap()
                .value
                .as_deref(),
            Some("42")
        );
        session
            .submit("Pair = { left: I64, right: I64 }", &mut output)
            .unwrap();
        session
            .submit("pair = Pair { left = 1, right = 2 }", &mut output)
            .unwrap();
        assert_eq!(
            session
                .submit("pair | .right", &mut output)
                .unwrap()
                .value
                .as_deref(),
            Some("2")
        );
        assert!(session
            .submit("Pair = { text: String }", &mut output)
            .unwrap_err()
            .contains(":reset"));
        // Function-containing data is cached. Its function IDs must continue to
        // refer to the old program even after several unrelated cells are linked.
        session
            .submit(
                "callbacks : List[I64 -> I64]\ncallbacks = [add 3, mul 2]",
                &mut output,
            )
            .unwrap();
        session.submit("callbacks | length", &mut output).unwrap();
        session.submit("100 + 23", &mut output).unwrap();
        assert_eq!(
            session
                .submit("callbacks | map (apply 5)", &mut output)
                .unwrap()
                .value
                .as_deref(),
            Some("[8, 10]")
        );
        assert_eq!(
            session
                .submit(
                    "{ first = pair, second = callbacks } | .first | .left",
                    &mut output
                )
                .unwrap()
                .value
                .as_deref(),
            Some("1")
        );
    });
}

#[test]
fn changed_import_layout_cannot_reinterpret_stored_values() {
    fwp::driver::with_big_stack(|| {
        let dir = fwp::cgen::TempDir::new("repl-layout").unwrap();
        let path = dir.join("boxes.fwp");
        let original = "Box = { value: I64 }\nexport boxed : Box\nboxed = Box { value = 7 }\n";
        std::fs::write(&path, original).unwrap();
        let mut session = Session::new(dir.join(".")).unwrap();
        let mut output = Vec::new();
        session.submit("import boxes", &mut output).unwrap();
        session.submit("boxes.boxed", &mut output).unwrap();
        std::fs::write(
            &path,
            "Box = { value: String }\nexport boxed : Box\nboxed = Box { value = \"new\" }\n",
        )
        .unwrap();
        let error = session.submit("out2 | .value", &mut output).unwrap_err();
        assert!(error.contains(":reset"), "{error}");
        std::fs::write(&path, original).unwrap();
        assert_eq!(
            session
                .submit("out2 | .value", &mut output)
                .unwrap()
                .value
                .as_deref(),
            Some("7")
        );
    });
}

#[test]
fn multiline_and_scripted_terminal_commands() {
    for input in [
        "2 +",
        "1 ==",
        "value =",
        "f = match",
        "fn",
        "fn x ->",
        "let x = 3",
        "let x = 3 in",
        "let x = let y = 3 in y",
        "[1,",
        "assert!(True",
        "(2 + 3",
        "f =\n    add 1",
    ] {
        assert!(incomplete(input), "{input}");
    }
    for input in [
        "2 + 3",
        "fn x -> x + 1",
        "let x = 3 in x + x",
        "let x = let y = 3 in y in x",
        "[1, 2]",
        "assert!(True)",
        "f =\n    add 1\n",
        "[)",
        "\"[\"",
        "2 # (",
    ] {
        assert!(!incomplete(input), "{input}");
    }
    let mut child = Command::new(env!("CARGO_BIN_EXE_fwp"))
        .args(["repl", "--stream"])
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .unwrap();
    child.stdin.take().unwrap().write_all(b":paste\ndouble =\n    mul 2\n:end\n21 | double\n:type 1 == 2\n:time 2 + 3\n1 / 0\n6 * 7\n:names\n:history\n:reset\n2 + 3\n:quit\n").unwrap();
    let result = child.wait_with_output().unwrap();
    assert!(result.status.success(), "{result:?}");
    let output = std::str::from_utf8(&result.stdout).unwrap();
    assert!(output.contains("Out[2]: 42"), "{output}");
    assert!(output.contains("Bool\n"), "{output}");
    assert!(output.contains("interpreted evaluation:"), "{output}");
    assert!(
        output.contains("trap:") && output.contains("Out[5]: 42"),
        "{output}"
    );
    assert!(output.contains("Session reset."), "{output}");
    assert!(
        !output.contains('\u{1b}'),
        "scripted input must not contain terminal escapes"
    );
    assert!(result.stderr.is_empty(), "{result:?}");
}

#[test]
fn session_keeps_tail_recursion_proofs_when_function_ids_change() {
    fwp::driver::with_big_stack(|| {
        let mut session = Session::new(std::env::current_dir().unwrap()).unwrap();
        let mut output = Vec::new();
        session.submit("seed = 42", &mut output).unwrap();
        session.submit("seed | echo", &mut output).unwrap();
        session
            .submit(
                "rec down : I64 -> I64\ndown = if (eq 0) id (sub 1 | down)",
                &mut output,
            )
            .unwrap();
        for _ in 0..2 {
            assert_eq!(
                session
                    .submit("200000 | down", &mut output)
                    .unwrap()
                    .value
                    .as_deref(),
                Some("0")
            );
        }
        session
            .submit(
                "rec mixed : I64 -> I64\nmixed = match\n    0 -> 0\n    1 -> 0 | mixed | add 1\n    _ -> sub 1 | mixed",
                &mut output,
            )
            .unwrap();
        for _ in 0..2 {
            assert_eq!(
                session
                    .submit("200000 | mixed", &mut output)
                    .unwrap()
                    .value
                    .as_deref(),
                Some("1")
            );
        }
        assert_eq!(output, b"42\n");
    });
}

#[test]
fn sets_keep_their_type_and_contents_across_session_updates() {
    fwp::driver::with_big_stack(|| {
        let mut session = Session::new(std::env::current_dir().unwrap()).unwrap();
        let mut output = Vec::new();
        session
            .submit(
                "keys = comptime ([\"b\", \"a\", \"b\"] | set.from-list)",
                &mut output,
            )
            .unwrap();
        session
            .submit("change = set.insert \"c\" | set.remove \"a\"", &mut output)
            .unwrap();
        for _ in 0..3 {
            assert_eq!(
                session
                    .submit("keys | both id change", &mut output)
                    .unwrap()
                    .value
                    .as_deref(),
                Some("(set{\"a\", \"b\"}, set{\"b\", \"c\"})")
            );
        }
        assert!(output.is_empty());
    });
}
