//! Lexical names must preserve eager evaluation, ownership and pipe semantics.
use fwp::{driver::check_source, fmt, parser, pretty};
use std::process::Command;

#[path = "support/allocation_report.rs"]
mod allocation_report;

#[test]
fn syntax_round_trips_and_rejects_refutable_binders() {
    for expr in [
        "fn x -> let square = x * x in square + square",
        "fn (x, y) -> x + y",
        "fn { x, y = other } -> x + other",
        "let x = 3 in let x = x + 1 in { x }",
        "match { Some value -> value + 1, None -> 0 }",
        "match { (left, _) -> add left }",
        "3 | (fn x -> x + 1) | echo",
        "(let x = 3 in x + 1) * 2",
        "fn _ -> 7",
        "quote (fn x -> let y = unquote!(0) in x + y)",
        "fn extraordinarily-long-input-name -> let extraordinarily-long-result-name = extraordinarily-long-input-name * extraordinarily-long-input-name in extraordinarily-long-result-name + extraordinarily-long-result-name",
    ] {
        let source = format!("main = {expr}\n");
        let ast = parser::parse_expr_text(expr, 0, &mut 0).unwrap();
        let shown = format!("main = {}\n", pretty::expr(&ast));
        assert!(fmt::same_program(&source, &shown), "{source} -> {shown}");
        let formatted = fmt::format_source(&source).unwrap();
        assert!(fmt::same_program(&source, &formatted), "{source} -> {formatted}");
        assert_eq!(fmt::format_source(&formatted).unwrap(), formatted);
    }
    for source in [
        "fn Some x -> x",
        "let Some x = Some 1 in x",
        "fn (x, x) -> x",
        "let { x, x } = { x = 1 } in x",
        "let x = 1",
        "fn x x -> x",
        "match { Some (x, x) -> x, None -> 0 }",
    ] {
        assert!(
            parser::parse_expr_text(source, 0, &mut 0).is_err(),
            "{source}"
        );
    }
}

#[test]
fn local_scope_monomorphism_and_resource_rules_are_checked() {
    for source in [
        "main = (let x = 1 in x) + x\n",
        "main = let x = x in x\n",
        "main = let same = fn x -> x in (same 1, same True)\n",
        "main = quote (unquote!(64))\n",
        "main = quote (unquote!())\n",
        "main = quote (unquote!(0, 1))\n",
        "resource Token = builtin\nbad : Token -> (Token, Token)\nbad = fn x -> (x, x)\n",
        "resource Token = builtin\nbad : Token -> I64 -> Token\nbad = fn x -> fn _ -> x\n",
    ] {
        let checked = check_source("locals.fwp", source, None);
        assert!(checked.is_err(), "unexpected acceptance: {source}");
    }
    assert!(fwp::driver::compile_source(
        "locals.fwp",
        "main = let x = 1 in comptime x\n",
        fwp::mono::Roots {
            main: true,
            ..Default::default()
        }
    )
    .is_err());
    for pattern in [
        "PInt 1",
        "PHole",
        "PTuple [PName \"x\", PName \"x\"]",
        "PRecord [(\"x\", PName \"a\"), (\"x\", PName \"b\")]",
    ] {
        let source =
            format!("macro invalid = const (SLambda ({pattern}) (SInt 1))\nmain = invalid!(())\n");
        assert!(
            check_source("locals.fwp", &source, None).is_err(),
            "{source}"
        );
    }
}

#[test]
fn named_tacit_captures_and_macros_agree_across_backends() {
    let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"));
    let directory = std::env::temp_dir().join(format!("fwp-locals-{}", std::process::id()));
    std::fs::create_dir_all(&directory).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    for (name, source, output, failure) in [
        (
            "values",
            std::fs::read_to_string(root.join("tests/fixtures/local_bindings.fwp")).unwrap(),
            "18\n18\n7\n13\n8\n0\n9\nhello!\n4\n42\n(2, 3)\n",
            None,
        ),
        (
            "shared-capture",
            "make : String -> String -> String\nmake = fn text -> fn suffix -> text | concat suffix\nmain = let original = read-all () | concat \"retained\" in let append = make original in (append \"!\", original, append \"?\") | echo\n".into(),
            "(\"retained!\", \"retained\", \"retained?\")\n",
            None,
        ),
        (
            "capture-error",
            r#"work : () -> I64 ! {IO, Error[String]}
work = fn _ ->
    let text = read-all () | concat "stop"
    in let append = fn suffix -> text | concat suffix
    in fail (append "!")
main = attempt work () | echo
"#.into(),
            "Err \"stop!\"\n",
            None,
        ),
        (
            "capture-cancel",
            r#"worker : Channel[()] -> () -> String ! {Async, IO}
worker = fn ready -> fn _ ->
    let text = read-all () | concat "held"
    in let append = fn suffix -> text | concat suffix
    in let _ = channel.send ready ()
    in loop (fn saved -> let _ = task.yield () in Again saved) append | apply "!"
main = task.scope (fn _ ->
    let ready = channel.make 0
    in let running = task.spawn (worker ready)
    in let _ = channel.recv ready
    in let _ = task.cancel running
    in task.await running | echo)
"#.into(),
            "None\n",
            None,
        ),
        (
            "template-order",
            r#"part : () -> Syntax ! {IO}
part = fn _ -> let _ = "captured" | echo in quote 2
main = let template = quote (unquote!(part ()), unquote!(0))
    in let _ = "constructed" | echo
    in let _ = template (quote 3) | syntax.show | echo
    in template (quote 4) | syntax.show | echo
"#.into(),
            "captured\nconstructed\n(2, 3)\n(2, 4)\n",
            None,
        ),
        (
            "nested-quotes",
            r#"macro make-template = const (quote (quote (unquote!(0))))
macro make-identity = const (quote (fn value -> quote (unquote!(value))))
main = let identity = make-identity!(())
    in let template = make-template!(())
    in let _ = identity (quote 7) | syntax.show | echo
    in template (quote 8) | syntax.show | echo
"#.into(),
            "7\n8\n",
            None,
        ),
        (
            "shadow-sized-builtins",
            "main = let vector = length in let matrix = length in (vector [1, 2], [[3, 4]] | matrix) | echo\n".into(),
            "(2, 1)\n",
            None,
        ),
        (
            "order",
            "main = let x = (\"first\" | echo) in let y = (\"second\" | echo) in ()\n".into(),
            "first\nsecond\n",
            None,
        ),
        (
            "failure",
            "main = let x = (9223372036854775807 + 1) in let y = (1 / 0) in x + y | echo\n".into(),
            "",
            Some("overflow"),
        ),
    ] {
        let path = directory.join(format!("{name}.fwp"));
        std::fs::write(&path, source).unwrap();
        let reference = Command::new(compiler)
            .args(["run", "--interp"])
            .arg(&path)
            .env("FWP_NO_OPT", "1")
            .output()
            .unwrap();
        assert_eq!(
            String::from_utf8_lossy(&reference.stdout),
            output,
            "{reference:?}"
        );
        if let Some(message) = failure {
            assert!(!reference.status.success(), "{reference:?}");
            assert!(
                String::from_utf8_lossy(&reference.stderr).contains(message),
                "{reference:?}"
            );
        } else {
            assert!(reference.status.success(), "{reference:?}");
            assert!(reference.stderr.is_empty(), "{reference:?}");
        }
        for opt in ["-O1", "-O2"] {
            let executable = directory.join(format!("{name}{opt}{}", std::env::consts::EXE_SUFFIX));
            let build = Command::new(compiler)
                .args(["build", opt])
                .arg(&path)
                .arg("-o")
                .arg(&executable)
                .output()
                .unwrap();
            assert!(build.status.success(), "{build:?}");
            let native = Command::new(&executable).output().unwrap();
            assert_eq!(
                native.status.code(),
                reference.status.code(),
                "{name} {opt}"
            );
            assert_eq!(native.stdout, reference.stdout, "{name} {opt}");
            assert_eq!(native.stderr, reference.stderr, "{name} {opt}");
            if failure.is_none() {
                let counted = Command::new(&executable).env("FWP_ALLOC_STATS", "1").output().unwrap();
                assert!(counted.status.success(), "{counted:?}");
                assert_eq!(counted.stdout, reference.stdout);
                let report = allocation_report::parse(&String::from_utf8_lossy(&counted.stderr)).unwrap();
                assert_eq!(report.live, 0, "{name} {opt}: {report:?}");
                assert_eq!(report.allocated, report.released, "{name} {opt}: {report:?}");
            }
        }
    }
    std::fs::remove_dir_all(directory).unwrap();
}

#[test]
fn generated_clients_escape_language_keywords() {
    for keyword in ["fn", "let", "in"] {
        let document = format!(
            r#"{{"openapi":"3.0.0","info":{{"title":"keywords","version":"1"}},
            "paths":{{"/value":{{"get":{{"operationId":"{keyword}","responses":{{"204":{{"description":"empty"}}}}}}}}}},
            "components":{{"schemas":{{"Record":{{"type":"object","properties":{{"{keyword}":{{"type":"integer"}}}},"required":["{keyword}"]}}}}}}
        }}"#
        );
        let generated = fwp::openapi_import::client(&document).unwrap();
        assert!(
            generated.text.contains(&format!("{keyword}-op")),
            "{}",
            generated.text
        );
        assert!(
            generated.text.contains(&format!("{keyword}-field")),
            "{}",
            generated.text
        );
        if let Err(error) = check_source("client.fwp", &generated.text, None) {
            panic!("{}\n{}", generated.text, error.rendered);
        }
    }
}
