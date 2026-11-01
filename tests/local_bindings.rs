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
        "match { { x, y = _ } -> x }",
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
        "match { { x = 1 } -> 2 }",
        "match { Some (x, x) -> x, None -> 0 }",
    ] {
        assert!(
            parser::parse_expr_text(source, 0, &mut 0).is_err(),
            "{source}"
        );
    }
}

#[test]
fn protocol_metadata_uses_the_complete_function_type() {
    let source = r#"# expose: cli, rest, mcp

export shifted : I64 -> I64
shifted = let offset = 3 in add offset
# args: DIVISOR VALUE
export scaled : I64 -> I64 -> I64
scaled = fn divisor -> let coefficient = 10 / divisor in fn value -> coefficient * value
"#;
    let checked = check_source("protocol-stages.fwp", source, None)
        .unwrap_or_else(|error| panic!("{}", error.rendered));
    let mut program = fwp::mono::Mono::new(&checked.env, &checked.typed)
        .run(fwp::mono::Roots {
            exports: true,
            ..fwp::mono::Roots::default()
        })
        .unwrap();
    program.docs = fwp::cli::Docs::from_sources(&checked.sm, checked.root);
    let commands = fwp::cli::commands(&program, Some("stages")).unwrap();
    assert_eq!(
        commands
            .iter()
            .map(|command| (command.export.as_str(), command.params.len()))
            .collect::<Vec<_>>(),
        [("shifted", 1), ("scaled", 2)]
    );
    let endpoints = fwp::rest::endpoints(&program).unwrap();
    assert_eq!(
        endpoints
            .iter()
            .map(|endpoint| (endpoint.function.as_str(), endpoint.params.len()))
            .collect::<Vec<_>>(),
        [("shifted", 1), ("scaled", 2)]
    );
    let tools = fwp::mcp::tools(&program).unwrap();
    assert_eq!(
        tools
            .iter()
            .map(|tool| (tool.function.as_str(), tool.arity))
            .collect::<Vec<_>>(),
        [("shifted", 1), ("scaled", 2)]
    );
    let (code, header) =
        fwp::cgen::generate_library(&program, "stages", &["scaled".into()]).unwrap();
    assert!(header.contains("int64_t shifted(int64_t);"));
    assert!(header.contains("int64_t scaled(int64_t, int64_t);"));
    let code = format!(
        "{code}\n{}",
        r#"
int main(void) {
    if (shifted(2) != 5 || scaled(2, 3) != 15) return 1;
    struct fwp_callback_scaled *registration = fwp_register_scaled(2);
    int64_t result = 0;
    int ok = fwp_invoke_scaled(registration, 3, &result);
    fwp_release_callback_scaled(registration);
    return ok && result == 15 ? 0 : 2;
}
"#
    );
    let directory = fwp::cgen::TempDir::new("protocol-stages").unwrap();
    for optimization in ["-O1", "-O2"] {
        let binary = directory.join("stages.exe");
        fwp::cgen::compile_c(&code, &binary, optimization).unwrap();
        let output = Command::new(binary).output().unwrap();
        assert!(output.status.success(), "{optimization}: {output:?}");
    }
    let served = fwp::mono::Mono::new(&checked.env, &checked.typed)
        .run(fwp::mono::Roots {
            service: Some("main".into()),
            ..fwp::mono::Roots::default()
        })
        .unwrap();
    let methods = &served.service.as_ref().unwrap().methods;
    let mut output = Vec::new();
    let mut interpreter = fwp::interp::Interp::new(&served, Box::new(&mut output)).unwrap();
    for (method, args, expected) in [
        (&methods[0], vec![fwp::value::Value::I64(2)], 5),
        (
            &methods[1],
            vec![fwp::value::Value::I64(2), fwp::value::Value::I64(3)],
            15,
        ),
    ] {
        assert_eq!(served.funcs[method.func].arity as usize, args.len());
        assert_eq!(
            interpreter.call_root(method.func, args).unwrap(),
            fwp::value::Value::I64(expected)
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
        "use : (I64 -> I64) -> I64 ! {IO}\nuse = fn calculate -> calculate (1 | tap echo)\nmain = use (fn x -> let _ = x | echo in x) | echo\n",
        "bad : (I64 -> I64) -> I64\nbad = fn calculate -> calculate (1 | tap echo)\n",
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
    let mut failures = Vec::new();
    for (name, source, output, failure) in [
        (
            "values",
            std::fs::read_to_string(root.join("tests/fixtures/local_bindings.fwp")).unwrap(),
            "18\n18\n7\n13\n8\n0\n9\nhello!\n4\n42\n(2, 3)\n",
            None,
        ),
        (
            "curried-stage-trap",
            "make-checked : I64 -> I64 -> I64\nmake-checked = fn divisor -> let inverse = 10 / divisor in fn value -> inverse + value\nmain = let unused = make-checked 0 in 42 | echo\n".into(),
            "",
            Some("division by zero"),
        ),
        (
            "top-level-strict-function-value",
            "checked : I64 -> I64\nchecked = let inverse = 10 / 0 in fn value -> inverse + value\nmain = let unused = checked in 42 | echo\n".into(),
            "",
            Some("division by zero"),
        ),
        (
            "top-level-saturated-function-constructor",
            "make-checked : I64 -> I64 -> I64\nmake-checked = fn divisor -> let inverse = 10 / divisor in fn value -> inverse + value\nchecked = make-checked 0\nmain = let unused = checked in 42 | echo\n".into(),
            "",
            Some("division by zero"),
        ),
        (
            "top-level-piped-function-constructor",
            "make-checked : I64 -> I64 -> I64\nmake-checked = fn divisor -> let inverse = 10 / divisor in fn value -> inverse + value\nchecked = 0 | make-checked\nalias = checked\nmain = alias (1 | tap (const \"later\" | echo)) | echo\n".into(),
            "",
            Some("division by zero"),
        ),
        (
            "composed-function-stage",
            "make-checked : I64 -> I64 -> I64\nmake-checked = fn divisor -> let inverse = 10 / divisor in fn value -> inverse + value\ncomposed = id | make-checked\nmain = composed 0 (1 | tap (const \"later\" | echo)) | echo\n".into(),
            "",
            Some("division by zero"),
        ),
        (
            "match-stage-before-next-argument",
            "make-checked : I64 -> I64 -> I64\nmake-checked = match { divisor -> let inverse = 10 / divisor in fn value -> inverse + value }\nmain = make-checked 0 (1 | tap (const \"later\" | echo)) | echo\n".into(),
            "",
            Some("division by zero"),
        ),
        (
            "generic-primitive-function-result",
            "checked : I64 -> I64\nchecked = prim.trap \"constructor\"\nmain = checked (1 | tap (const \"later\" | echo)) | echo\n".into(),
            "",
            Some("constructor"),
        ),
        (
            "generic-primitive-alias-stage",
            "make-checked : String -> I64 -> I64\nmake-checked = prim.trap\nmain = make-checked \"constructor\" (1 | tap (const \"later\" | echo)) | echo\n".into(),
            "",
            Some("constructor"),
        ),
        (
            "generic-state-function-read",
            r#"read-function : () -> s ! {State[s]}
read-function = get
work : () -> I64 ! {State[(I64 -> I64)]}
work = fn _ ->
    let saved = read-function ()
    in let _ = put (add 100)
    in saved 1
main = run-state (add 1) work () | .0 | echo
"#.into(),
            "2\n",
            None,
        ),
        (
            "trait-method-constructor-stage",
            "trait Factory[T] = { create-function : T -> I64 -> I64 }\nimpl Factory[I64] = { create-function = fn divisor -> let inverse = 10 / divisor in fn value -> inverse + value }\nalias : I64 -> I64 -> I64\nalias = create-function\nmain = alias 0 (1 | tap (const \"later\" | echo)) | echo\n".into(),
            "",
            Some("division by zero"),
        ),
        (
            "record-owner-before-borrow",
            "main = let text = read-all () | concat \"held\" in (text, text, string.length text) | echo\n".into(),
            "(\"held\", \"held\", 4)\n",
            None,
        ),
        (
            "record-owner-before-failed-borrow",
            "main = let text = read-all () | concat \"held\" in (text, string.length text / 0) | echo\n".into(),
            "",
            Some("division by zero"),
        ),
        (
            "curried-stage-before-next-argument",
            "make-checked : I64 -> I64 -> I64\nmake-checked = fn divisor -> let inverse = 10 / divisor in fn value -> inverse + value\nmain = make-checked 0 (1 | tap (const \"later\" | echo)) | echo\n".into(),
            "",
            Some("division by zero"),
        ),
        (
            "aliased-curried-stage",
            "make-checked : I64 -> I64 -> I64\nmake-checked = fn divisor -> let inverse = 10 / divisor in fn value -> inverse + value\nalias : I64 -> I64 -> I64\nalias = make-checked\nmain = alias 0 (1 | tap (const \"later\" | echo)) | echo\n".into(),
            "",
            Some("division by zero"),
        ),
        (
            "unknown-curried-stage",
            "make-checked : I64 -> I64 -> I64\nmake-checked = fn divisor -> let inverse = 10 / divisor in fn value -> inverse + value\ncall-checked : (I64 -> I64 -> I64) -> I64 ! {IO}\ncall-checked = fn calculate -> calculate 0 (1 | tap (const \"later\" | echo))\nmain = call-checked make-checked | echo\n".into(),
            "",
            Some("division by zero"),
        ),
        (
            "named-stage-effects",
            "main = let values = range 0 3 in values | map (fn x -> let _ = x | echo in x + 1) | filter (fn x -> let _ = \"filter\" | echo in x > 1) | fold add 0 | echo\n".into(),
            "0\n1\n2\nfilter\nfilter\nfilter\n5\n",
            None,
        ),
        (
            "named-stage-alias",
            "main = let values = range 0 4 in let total = values | map (fn x -> x + 1) | filter (fn x -> x % 2 == 0) | fold add 0 in (values, total) | echo\n".into(),
            "([0, 1, 2, 3], 6)\n",
            None,
        ),
        (
            "named-stage-traps",
            "main = let values = range 0 3 in values | map (fn x -> x + 9223372036854775806) | filter (fn x -> x / 0 > 0) | fold add 0 | echo\n".into(),
            "",
            Some("overflow"),
        ),
        (
            "variant-pattern-controls",
            "choose : Option[(I64, I64)] -> I64\nchoose = match { Some (0, value) -> value, Some (left, right) -> left + right, None -> 0 }\nmain = [Some (2, 3) | choose, Some (0, 7) | choose, None | choose] | echo\n".into(),
            "[5, 7, 0]\n",
            None,
        ),
        (
            "variant-field-order",
            "main = Some (9223372036854775807 + 1, 1 / 0) | (match { Some (left, right) -> left + right, None -> 0 }) | echo\n".into(),
            "",
            Some("overflow"),
        ),
        (
            "curried-fold-order",
            "main = let base = 10 in [1, 2, 3] | fold (fn total -> fn value -> total * base + value) 0 | echo\n".into(),
            "123\n",
            None,
        ),
        (
            "record-discard",
            "main = { x = 3, y = 4 } | (match ({ x, y = _ }) -> x) | echo\n".into(),
            "3\n",
            None,
        ),
        (
            "shared-capture",
            "make-closure : String -> String -> String\nmake-closure = fn text -> fn suffix -> text | concat suffix\nmain = let original = read-all () | concat \"retained\" in let append = make-closure original in (append \"!\", original, append \"?\") | echo\n".into(),
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
        let checked = std::panic::catch_unwind(|| {
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
        });
        if checked.is_err() {
            failures.push(name);
        }
    }
    std::fs::remove_dir_all(directory).unwrap();
    assert!(failures.is_empty(), "failed lexical cases: {failures:?}");
}

#[test]
fn generated_clients_escape_language_keywords() {
    for keyword in ["fn", "let", "in"] {
        let document = format!(
            r##"{{"openapi":"3.0.0","info":{{"title":"keywords","version":"1"}},
            "paths":{{"/value":{{"get":{{"operationId":"{keyword}","responses":{{"200":{{"description":"value","content":{{"application/json":{{"schema":{{"$ref":"#/components/schemas/Record"}}}}}}}}}}}}}}}},
            "components":{{"schemas":{{"Record":{{"type":"object","properties":{{"{keyword}":{{"type":"integer"}}}},"required":["{keyword}"]}}}}}}
        }}"##
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
