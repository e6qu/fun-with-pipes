//! Infix notation must preserve arithmetic, operand order and formatting.
use fwp::{ast::ExprKind, fmt, parser, pretty};
use std::process::Command;

#[test]
fn precedence_and_application() {
    for (source, expected) in [
        ("2 + 3 * 4", "2 + 3 * 4"),
        ("(2 + 3) * 4", "(2 + 3) * 4"),
        ("20 - 6 - 2", "20 - 6 - 2"),
        ("20 - (6 - 2)", "20 - (6 - 2)"),
        ("24 / 3 * 2", "24 / 3 * 2"),
        ("24 / (3 * 2)", "24 / (3 * 2)"),
        ("add 1 2 * 3 | echo", "add 1 2 * 3 | echo"),
        ("(3 | add 1) * 2", "(3 | add 1) * 2"),
        ("1+2*3", "1 + 2 * 3"),
        ("10-3", "10 - 3"),
        ("10 - -3", "10 - -3"),
        ("-(2 + 3) * 4", "-(2 + 3) * 4"),
        ("f (-x)", "f (-(x))"),
        ("add -1", "add -1"),
        ("count-long", "count-long"),
    ] {
        let expr = parser::parse_expr_text(source, 0, &mut 0).unwrap();
        assert_eq!(pretty::expr(&expr), expected, "{source}");
        let program = format!("main = {source}\n");
        let formatted = fmt::format_source(&program).unwrap();
        assert!(fmt::same_program(&program, &formatted), "{formatted}");
        assert_eq!(fmt::format_source(&formatted).unwrap(), formatted);
    }
    let expr = parser::parse_expr_text("2 + 3 * 4", 0, &mut 0).unwrap();
    let ExprKind::Arithmetic(_, _, args) = expr.kind else {
        panic!("expected addition");
    };
    assert!(matches!(args[1].kind, ExprKind::Arithmetic(..)));
    for source in ["1 +", "1 / * 2", "* 2", "1 + | echo"] {
        assert!(
            parser::parse_expr_text(source, 0, &mut 0).is_err(),
            "{source}"
        );
    }
}

#[test]
fn arithmetic_layout_quotes_and_type_sizes_round_trip() {
    for source in [
        "value = 2\n    + 3 * 4\nnext = 5\n",
        "macro twice = quote (unquote!(0) * 2)\nmain = twice!(2 + 3) | echo\n",
        "f : Vector[I64, 2 + 3 * 4] -> I64\nf = vector.length\n",
        "f = match\n    True -> const (2 + 3 * 4)\n    False -> const (20 - (6 - 2))\n",
        "x = { first = 2 + 3, second = [4 * 5, 6 - 2] }\n",
        "x = (1111111111111111 + 2222222222222222) * (3333333333333333 - 4444444444444444) | echo\n",
        "x = 2 + # keep this explanation\n    3 * 4\n",
    ] {
        let formatted = fmt::format_source(source).unwrap();
        assert!(fmt::same_program(source, &formatted), "{formatted}");
        assert_eq!(fmt::format_source(&formatted).unwrap(), formatted);
    }
    assert!(parser::parse_module("x = 2\n+ 3\n", 0, &mut 0).is_err());
}

#[test]
fn raw_interpreter_and_native_agree() {
    let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"));
    let dir = std::env::temp_dir().join(format!("fwp-infix-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    for (name, source, expected) in [
        (
            "arithmetic",
            std::fs::read_to_string(root.join("tests/run/infix.fwp")).unwrap(),
            Some(std::fs::read(root.join("tests/run/infix.out")).unwrap()),
        ),
        (
            "trap-order",
            "main = (9223372036854775807 + 1) + (1 / 0) | echo\n".into(),
            None,
        ),
    ] {
        let path = dir.join(format!("{name}.fwp"));
        std::fs::write(&path, source).unwrap();
        let reference = Command::new(compiler)
            .args(["run", "--interp"])
            .arg(&path)
            .env("FWP_NO_OPT", "1")
            .output()
            .unwrap();
        if let Some(expected) = expected {
            assert!(reference.status.success(), "{:?}", reference);
            assert_eq!(reference.stdout, expected);
            assert!(reference.stderr.is_empty());
        } else {
            assert!(!reference.status.success());
            assert!(String::from_utf8_lossy(&reference.stderr).contains("overflow"));
        }
        for opt in ["-O0", "-O1", "-O2"] {
            let exe = dir.join(format!("{name}{opt}{}", std::env::consts::EXE_SUFFIX));
            let build = Command::new(compiler)
                .args(["build", opt, "--gc", "arc"])
                .arg(&path)
                .arg("-o")
                .arg(&exe)
                .output()
                .unwrap();
            assert!(build.status.success(), "{:?}", build);
            let native = Command::new(&exe).output().unwrap();
            assert_eq!(
                native.status.code(),
                reference.status.code(),
                "{name} {opt}"
            );
            assert_eq!(native.stdout, reference.stdout, "{name} {opt}");
            assert_eq!(native.stderr, reference.stderr, "{name} {opt}");
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}
