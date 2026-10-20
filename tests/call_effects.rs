//! Caller effects must not contaminate known pure function-valued arguments.
use fwp::driver::{check_source, signatures};
use fwp::ir::{Body, Expr, Func, Pat, Program, MT};
use fwp::value::{FileState, Value};
use std::cell::RefCell;
use std::path::Path;
use std::process::Command;
use std::rc::Rc;

const SOURCE: &str = r#"
has-text : (String -> String) -> Bool
has-text = apply "!" | string.length | gt 1
receive-fail : Channel[() -> String] -> () ! {Async, Error[String]}
receive-fail = channel.recv | option.map (apply () | tap (const "received failure" | fail)) | ignore
main = [
    "a b c" | words | map concat | find has-text | option.map (apply "!") | echo,
    option.map (apply "!") ("a b c" | words | map concat | find has-text) | echo,
    "a b c" | words | map concat | nth 1 | option.map (apply "!") | echo,
] | ignore
"#;

#[test]
fn comptime_rejects_runtime_handles_for_interpreted_and_native_programs() {
    let dir = fwp::cgen::TempDir::new("fwp-comptime-handle").unwrap();
    std::fs::write(dir.path().join("input.txt"), "compile-time text\n").unwrap();
    let source = dir.path().join("handle.fwp");
    let output = dir.path().join("handle.c");
    for expression in [
        r#"file.open "input.txt""#,
        r#"Some (file.open "input.txt")"#,
        r#"(1, file.open "input.txt")"#,
        r#"[file.open "input.txt"]"#,
        r#"[file.open "input.txt"] | array.from-list"#,
    ] {
        std::fs::write(
            &source,
            format!("saved = comptime ({expression})\nmain = saved | ignore\n"),
        )
        .unwrap();
        for native in [false, true] {
            let mut command = Command::new(env!("CARGO_BIN_EXE_fwp"));
            command.current_dir(dir.path());
            if native {
                command
                    .args(["build", "--emit-c"])
                    .arg(&source)
                    .arg("-o")
                    .arg(&output);
            } else {
                command.args(["run", "--interp"]).arg(&source);
            }
            let result = command.output().unwrap();
            let error = String::from_utf8_lossy(&result.stderr);
            assert!(!result.status.success(), "{expression}: native={native}");
            assert!(
                error.contains("`comptime` constant contains a runtime File handle"),
                "{expression}: native={native}: {error}"
            );
            assert!(error.contains("Return ordinary data"), "{error}");
            assert!(!output.exists());
        }
    }
}

#[test]
fn comptime_file_contents_survive_removing_the_compilation_input() {
    let dir = fwp::cgen::TempDir::new("fwp-comptime-data").unwrap();
    let input = dir.path().join("input.txt");
    let source = dir.path().join("data.fwp");
    let text = "compile-time text\n";
    std::fs::write(&input, text).unwrap();
    std::fs::write(
        &source,
        "text = comptime (file.read \"input.txt\")\nmain = text | print\n",
    )
    .unwrap();
    let interpreted = Command::new(env!("CARGO_BIN_EXE_fwp"))
        .current_dir(dir.path())
        .args(["run", "--interp"])
        .arg(&source)
        .output()
        .unwrap();
    assert!(
        interpreted.status.success(),
        "{}",
        String::from_utf8_lossy(&interpreted.stderr)
    );
    assert_eq!(interpreted.stdout, format!("{text}\n").as_bytes());
    for opt in ["-O0", "-O2"] {
        std::fs::write(&input, text).unwrap();
        let executable = dir
            .path()
            .join(format!("data{opt}{}", std::env::consts::EXE_SUFFIX));
        let built = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .current_dir(dir.path())
            .arg("build")
            .arg(&source)
            .args([opt, "-o"])
            .arg(&executable)
            .output()
            .unwrap();
        assert!(
            built.status.success(),
            "{}",
            String::from_utf8_lossy(&built.stderr)
        );
        std::fs::remove_file(&input).unwrap();
        let ran = Command::new(&executable)
            .current_dir(dir.path())
            .env("FWP_GC_STRESS", "1")
            .env("FWP_GC_VERIFY", "1")
            .output()
            .unwrap();
        assert!(
            ran.status.success(),
            "{}",
            String::from_utf8_lossy(&ran.stderr)
        );
        assert_eq!(ran.stdout, interpreted.stdout);
        assert_eq!(ran.stderr, interpreted.stderr);
    }
}

#[test]
fn c_generation_rejects_runtime_handles_even_in_hand_built_ir() {
    let file = Value::File(Rc::new(RefCell::new(FileState {
        path: "closed-test-file".into(),
        file: None,
    })));
    for body in [
        Expr::Const(Value::tuple(vec![file.clone()])),
        Expr::Match(
            Box::new(Expr::Const(Value::unit())),
            vec![(Pat::Lit(file), Expr::Const(Value::unit()))],
        ),
    ] {
        let program = Program {
            main: Some(0),
            funcs: vec![Func {
                name: "main".into(),
                arity: 0,
                locals: vec![],
                ty: MT::unit(),
                body: Body::Expr(body),
            }],
            ..Program::default()
        };
        let error = fwp::cgen::generate(&program).unwrap_err();
        assert!(
            error.contains("constant contains a runtime File handle"),
            "{error}"
        );
    }
}

#[test]
fn pure_function_values_in_io_pipes_and_applications() {
    let checked = check_source("pure-callbacks.fwp", SOURCE, None)
        .unwrap_or_else(|e| panic!("{}", e.rendered));
    let types = signatures(&checked);
    assert!(
        types.contains("has-text : (String -> String) -> Bool"),
        "{types}"
    );
    assert!(types.contains("main : ()"), "{types}");
}

#[test]
fn effectful_callbacks_still_require_their_effects() {
    for source in [
        "bad : String -> ()\nbad = print\n",
        "bad : List[String] -> List[()]\nbad = map print\n",
        "bad : Option[String] -> Option[()]\nbad = option.map print\n",
    ] {
        let error = check_source("missing-effects.fwp", source, None)
            .err()
            .unwrap_or_else(|| panic!("accepted missing effects: {source}"));
        assert!(error.rendered.contains("IO"), "{}", error.rendered);
    }
}

#[test]
fn call_related_effect_and_size_snapshots_stay_stable() {
    let root = Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/check");
    let mut paths: Vec<_> = std::fs::read_dir(&root)
        .unwrap()
        .map(|e| e.unwrap().path())
        .filter(|p| {
            p.extension().is_some_and(|e| e == "fwp") && {
                let name = p.file_stem().unwrap().to_string_lossy();
                [
                    "effect",
                    "handler",
                    "abstract",
                    "size",
                    "comptime",
                    "resource_capture",
                ]
                .iter()
                .any(|part| name.contains(part))
            }
        })
        .collect();
    paths.sort();
    assert!(paths.len() >= 4);
    for path in paths {
        let source = std::fs::read_to_string(&path).unwrap();
        let name = format!("check/{}", path.file_name().unwrap().to_string_lossy());
        let got = match check_source(&name, &source, path.parent()) {
            Ok(c) => format!("{}{}", c.render_warnings(), signatures(&c)),
            Err(f) => f
                .rendered
                .replace(concat!(env!("CARGO_MANIFEST_DIR"), "/tests/"), ""),
        };
        let want = std::fs::read_to_string(path.with_extension("out")).unwrap();
        assert_eq!(got, want, "{}", path.display());
    }
}

#[test]
fn inferred_pure_callbacks_agree_with_native_execution() {
    let dir = std::env::temp_dir().join(format!("fwp-call-effects-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let source = dir.join("pure.fwp");
    std::fs::write(&source, SOURCE).unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = Command::new(fwp)
        .env("FWP_NO_OPT", "1")
        .args(["run", "--interp"])
        .arg(&source)
        .output()
        .unwrap();
    assert!(
        reference.status.success(),
        "{}",
        String::from_utf8_lossy(&reference.stderr)
    );
    for opt in ["-O1", "-O2"] {
        let exe = dir.join(format!("pure{opt}"));
        let built = Command::new(fwp)
            .arg("build")
            .arg(&source)
            .args([opt, "-o"])
            .arg(&exe)
            .output()
            .unwrap();
        assert!(
            built.status.success(),
            "{}",
            String::from_utf8_lossy(&built.stderr)
        );
        let got = Command::new(&exe)
            .env("FWP_GC_STRESS", "1")
            .env("FWP_GC_VERIFY", "1")
            .output()
            .unwrap();
        assert!(
            got.status.success(),
            "{}",
            String::from_utf8_lossy(&got.stderr)
        );
        assert_eq!(got.stdout, reference.stdout, "{opt}");
        assert_eq!(got.stderr, reference.stderr, "{opt}");
    }
    std::fs::remove_dir_all(dir).unwrap();
}

#[test]
fn state_function_values_preserve_callback_effects_in_pipes_and_applications() {
    for source in [
        r#"read : () -> String ! {State[(String -> String)]}
read = get | apply "!"
"#,
        r#"read : () -> String ! {State[(String -> String)]}
read = match
    () -> apply "!" (get ())
"#,
        r#"read : () -> String ! {State[(String -> String ! {IO})], IO}
read = get | apply "!"
"#,
        r#"read : () -> String ! {State[(String -> String ! {IO})], IO}
read = match
    () -> apply "!" (get ())
"#,
    ] {
        check_source("stored-function-effects.fwp", source, None)
            .unwrap_or_else(|error| panic!("{}", error.rendered));
    }
    for body in [
        r#"get | apply "!""#,
        r#"match
    () -> apply "!" (get ())"#,
    ] {
        let source =
            format!("bad : () -> String ! {{State[(String -> String ! {{IO}})]}}\nbad = {body}\n");
        let error = check_source("missing-stored-function-effects.fwp", &source, None)
            .err()
            .unwrap_or_else(|| panic!("accepted a callback without its IO effect"));
        assert!(
            error.rendered.contains("effect `IO` is not allowed"),
            "{}",
            error.rendered
        );
    }
}

#[test]
fn higher_order_callback_rows_allow_known_effect_weakening() {
    for source in [
        r#"
pass-fn : (I64 -> I64 ! {Async | e}) -> (I64, I64) ! {Async | e}
pass-fn = both (task.deadline 1h | apply 2) (apply 3)
main = pass-fn (add 40) | echo
"#,
        r#"
pass-pure : (I64 -> I64) -> (I64, I64) ! {Async}
pass-pure = both (task.deadline 1h | apply 2) (apply 3)
main = pass-pure (add 40) | echo
"#,
        r#"
pass-io : (String -> String ! {IO | e}) -> (String, String) ! {Async, IO | e}
pass-io = both (task.deadline 1h | apply "a") (apply "b")
main = ()
"#,
    ] {
        check_source("higher-order-rows.fwp", source, None)
            .unwrap_or_else(|error| panic!("{}", error.rendered));
    }
}

#[test]
fn weakening_callback_rows_preserves_required_async_and_io() {
    for (source, required) in [
        (
            r#"
bad : (I64 -> I64 ! e) -> (I64, I64) ! e
bad = both (task.deadline 1h | apply 2) (apply 3)
main = ()
"#,
            "Async",
        ),
        (
            r#"
bad : (String -> String ! {IO}) -> (String, String) ! {Async}
bad = both (task.deadline 1h | apply "a") (apply "b")
main = ()
"#,
            "IO",
        ),
    ] {
        match check_source("missing-callback-effects.fwp", source, None) {
            Ok(_) => panic!("missing {required} accepted"),
            Err(error) => assert!(error.rendered.contains(required), "{}", error.rendered),
        }
    }
}

#[test]
fn argument_mismatch_reports_the_value_without_permitted_effects() {
    let source =
        "consume : (I64 -> I64 ! {IO}) -> ()\nconsume = ignore\nmain = consume string.length\n";
    match check_source("argument-type.fwp", source, None) {
        Ok(_) => panic!("incompatible callback input accepted"),
        Err(error) => {
            assert!(
                error.rendered.contains("found `String -> I64"),
                "{}",
                error.rendered
            );
            assert!(
                !error.rendered.contains("found `String -> I64 ! {IO"),
                "{}",
                error.rendered
            );
        }
    }
}

#[test]
fn later_stages_do_not_change_stored_callback_effects() {
    for source in [
        "call : (() -> String) -> () ! {IO}\ncall = apply () | print\n",
        "call : Option[() -> String] -> () ! {IO}\ncall = option.map (apply ()) | echo\n",
        "call : Channel[() -> String] -> () ! {Async, IO}\ncall = channel.recv | option.map (apply ()) | echo\n",
        "call : (() -> String) -> String ! {Error[String]}\ncall = apply () | if (eq \"bad\") fail id\n",
    ] {
        check_source("later-callback-effects.fwp", source, None)
            .unwrap_or_else(|error| panic!("{}", error.rendered));
    }
    for source in [
        "bad : (() -> String ! {IO}) -> String\nbad = apply () | id\n",
        "bad : (() -> String ! {IO}) -> String ! {Error[String]}\nbad = apply () | if (eq \"bad\") fail id\n",
    ] {
        let error = check_source("missing-callback-io.fwp", source, None)
            .err()
            .unwrap_or_else(|| panic!("accepted missing callback IO"));
        assert!(error.rendered.contains("IO"), "{}", error.rendered);
    }
}
