//! Known function aliases can call directly; constant evaluation stays ordered.
use fwp::ir::{Body, Expr, Func, Pat, Program, MT};
use fwp::value::Value;
use std::process::Command;

#[test]
fn repeated_known_function_aliases_become_direct_calls() {
    let text = MT::con("std::String");
    let integer = MT::con("std::I64");
    let callback = MT::Fun(Box::new(text.clone()), Box::new(integer.clone()));
    let mut program = Program {
        funcs: vec![
            Func {
                name: "length".into(),
                arity: 1,
                locals: vec![text.clone()],
                ty: callback.clone(),
                body: Body::Prim("string.length".into()),
            },
            Func {
                name: "measure-twice".into(),
                arity: 1,
                locals: vec![text.clone(), callback],
                ty: MT::Fun(
                    Box::new(text),
                    Box::new(MT::Record(vec![
                        ("0".into(), integer.clone()),
                        ("1".into(), integer),
                    ])),
                ),
                body: Body::Expr(Expr::Let(
                    1,
                    Box::new(Expr::Func(0)),
                    Box::new(Expr::Record(vec![
                        Expr::Apply(Box::new(Expr::Local(1)), vec![Expr::Local(0)]),
                        Expr::Apply(Box::new(Expr::Local(1)), vec![Expr::Local(0)]),
                    ])),
                )),
            },
        ],
        ..Program::default()
    };
    fwp::ir::check_locals(&program).unwrap();
    let input = vec![Value::str("aλ🙂")];
    let reference = fwp::interp::Interp::new(&program, Box::new(Vec::new()))
        .unwrap()
        .call_root(1, input.clone())
        .unwrap();
    fwp::opt::optimize(&mut program);
    fwp::ir::check_locals(&program).unwrap();
    let result = fwp::interp::Interp::new(&program, Box::new(Vec::new()))
        .unwrap()
        .call_root(1, input)
        .unwrap();
    assert_eq!(result, reference);
    let Body::Expr(Expr::Record(calls)) = &program.funcs[1].body else {
        panic!("known aliases should not require local function dispatch");
    };
    assert_eq!(calls.len(), 2);
    assert!(calls
        .iter()
        .all(|e| matches!(e, Expr::Call(0, args) if matches!(args.as_slice(), [Expr::Local(0)]))));
}

#[test]
fn matching_a_local_callback_record_exposes_the_direct_call() {
    let integer = MT::con("std::I64");
    let callback = MT::Fun(Box::new(integer.clone()), Box::new(integer.clone()));
    let record = MT::Record(vec![
        ("0".into(), callback.clone()),
        ("1".into(), integer.clone()),
    ]);
    let mut program = Program {
        funcs: vec![
            Func {
                name: "add".into(),
                arity: 2,
                locals: vec![integer.clone(), integer.clone()],
                ty: MT::Fun(Box::new(integer.clone()), Box::new(callback.clone())),
                body: Body::Prim("prim.add".into()),
            },
            Func {
                name: "matched-callback".into(),
                arity: 1,
                locals: vec![integer.clone(), callback.clone(), integer.clone(), record],
                ty: callback,
                body: Body::Expr(Expr::Let(
                    3,
                    Box::new(Expr::Record(vec![
                        Expr::Apply(Box::new(Expr::Func(0)), vec![Expr::Const(Value::I64(1))]),
                        Expr::Local(0),
                    ])),
                    Box::new(Expr::Match(
                        Box::new(Expr::Local(3)),
                        vec![(
                            Pat::Record(vec![Pat::Bind(1), Pat::Bind(2)]),
                            Expr::Apply(Box::new(Expr::Local(1)), vec![Expr::Local(2)]),
                        )],
                    )),
                )),
            },
        ],
        ..Program::default()
    };
    fwp::ir::check_locals(&program).unwrap();
    let reference = fwp::interp::Interp::new(&program, Box::new(Vec::new()))
        .unwrap()
        .call_root(1, vec![Value::I64(7)])
        .unwrap();
    fwp::opt::optimize(&mut program);
    fwp::ir::check_locals(&program).unwrap();
    let actual = fwp::interp::Interp::new(&program, Box::new(Vec::new()))
        .unwrap()
        .call_root(1, vec![Value::I64(7)])
        .unwrap();
    assert_eq!(actual, reference);
    assert_eq!(actual, Value::I64(8));
    assert!(
        matches!(&program.funcs[1].body, Body::Expr(Expr::Call(0, _))),
        "a known callback matched from a local tuple needs no runtime tuple or closure"
    );
}

#[test]
fn ignored_constant_in_a_matched_tuple_still_evaluates() {
    let integer = MT::con("std::I64");
    let record = MT::Record(vec![
        ("0".into(), integer.clone()),
        ("1".into(), integer.clone()),
    ]);
    let mut program = Program {
        funcs: vec![
            Func {
                name: "div".into(),
                arity: 2,
                locals: vec![integer.clone(), integer.clone()],
                ty: MT::Fun(
                    Box::new(integer.clone()),
                    Box::new(MT::Fun(
                        Box::new(integer.clone()),
                        Box::new(integer.clone()),
                    )),
                ),
                body: Body::Prim("prim.div".into()),
            },
            Func {
                name: "bad".into(),
                arity: 0,
                locals: vec![],
                ty: integer.clone(),
                body: Body::Expr(Expr::Call(
                    0,
                    vec![Expr::Const(Value::I64(0)), Expr::Const(Value::I64(1))],
                )),
            },
            Func {
                name: "discard".into(),
                arity: 1,
                locals: vec![integer.clone(), record],
                ty: MT::Fun(Box::new(integer.clone()), Box::new(integer)),
                body: Body::Expr(Expr::Let(
                    1,
                    Box::new(Expr::Record(vec![Expr::Func(1), Expr::Local(0)])),
                    Box::new(Expr::Match(
                        Box::new(Expr::Local(1)),
                        vec![(
                            Pat::Record(vec![Pat::Wild, Pat::Wild]),
                            Expr::Const(Value::I64(17)),
                        )],
                    )),
                )),
            },
        ],
        ..Program::default()
    };
    fwp::ir::check_locals(&program).unwrap();
    let reference = fwp::interp::Interp::new(&program, Box::new(Vec::new()))
        .unwrap()
        .call_root(2, vec![Value::I64(7)]);
    assert!(
        matches!(&reference, Err(fwp::interp::Ctl::Trap(message)) if message.contains("division by zero"))
    );
    fwp::opt::optimize(&mut program);
    fwp::ir::check_locals(&program).unwrap();
    let actual = fwp::interp::Interp::new(&program, Box::new(Vec::new()))
        .unwrap()
        .call_root(2, vec![Value::I64(7)]);
    assert_eq!(format!("{actual:?}"), format!("{reference:?}"));
}

#[test]
fn ignored_caf_arguments_still_trap_in_evaluation_order() {
    let dir = std::env::temp_dir().join(format!("fwp-inline-caf-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let src = dir.join("probe.fwp");
    let exe = dir.join("probe");
    let cases=[
        "bad : I64\nbad = 1 | div 0\ndiscard : I64 -> I64\ndiscard = const 17\nmain = bad | discard | echo\n",
        "bad : I64\nbad = 1 | div 0\nlater : I64\nlater = 9223372036854775807 | add 1\ndiscard : I64 -> I64\ndiscard = const later\nmain = bad | discard | echo\n",
        "bad : String\nbad = 1 | div 0 | show\ndiscard : String -> I64\ndiscard = const 17\nmain = bad | discard | echo\n",
        "bad : I64\nbad = 1 | div 0\ndiscard : (I64, Bool) -> I64\ndiscard = match\n    (_, True) -> const 17\n    (_, False) -> const 19\nmain = (bad, True) | discard | echo\n",
        "bad : I64\nbad = 1 | div 0\nlater : I64\nlater = 9223372036854775807 | add 1\ndiscard : (I64, I64) -> I64\ndiscard = match (_, _) -> const (const 17)\nmain = (bad, later) | discard | echo\n",
    ];
    for (case, text) in cases.iter().enumerate() {
        std::fs::write(&src, text).unwrap();
        let reference = Command::new(fwp)
            .args(["run", "--interp"])
            .arg(&src)
            .env("FWP_NO_OPT", "1")
            .output()
            .unwrap();
        assert_eq!(
            reference.status.code(),
            Some(101),
            "case {case}: {}",
            String::from_utf8_lossy(&reference.stderr)
        );
        let optimized = Command::new(fwp)
            .args(["run", "--interp"])
            .arg(&src)
            .output()
            .unwrap();
        assert_eq!(
            optimized.status.code(),
            reference.status.code(),
            "optimized interpreter, case {case}"
        );
        assert_eq!(optimized.stdout, reference.stdout);
        assert_eq!(optimized.stderr, reference.stderr);
        for opt in ["-O1", "-O2"] {
            let build = Command::new(fwp)
                .args(["build"])
                .arg(&src)
                .args([opt, "-o"])
                .arg(&exe)
                .output()
                .unwrap();
            assert!(
                build.status.success(),
                "{}",
                String::from_utf8_lossy(&build.stderr)
            );
            for poison in ["0", "1"] {
                let native = Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison)
                    .output()
                    .unwrap();
                assert_eq!(
                    native.status.code(),
                    reference.status.code(),
                    "case {case}, {opt}, poison {poison}: {}",
                    String::from_utf8_lossy(&native.stdout)
                );
                assert_eq!(native.stdout, reference.stdout, "case {case}");
                assert_eq!(native.stderr, reference.stderr, "case {case}");
            }
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}

#[test]
fn unused_counted_caf_argument_evaluates_and_releases_its_temporary() {
    let dir = std::env::temp_dir().join(format!("fwp-inline-caf-owner-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let src = dir.join("probe.fwp");
    let cfile = dir.join("probe.c");
    let exe = dir.join("probe");
    std::fs::write(&src,"cached = \"input\" | string.repeat 2\ndiscard : String -> I64\ndiscard = const 17\nmain = cached | discard | echo\n").unwrap();
    let reference = Command::new(fwp)
        .args(["run", "--interp"])
        .arg(&src)
        .env("FWP_NO_OPT", "1")
        .output()
        .unwrap();
    assert!(reference.status.success());
    assert_eq!(reference.stdout, b"17\n");
    let build = Command::new(fwp)
        .args(["build"])
        .arg(&src)
        .args(["--emit-c", "-o"])
        .arg(&cfile)
        .output()
        .unwrap();
    assert!(
        build.status.success(),
        "{}",
        String::from_utf8_lossy(&build.stderr)
    );
    let emitted = std::fs::read_to_string(&cfile).unwrap();
    assert!(
        emitted.contains("/* string.repeat :"),
        "the CAF must still be evaluated"
    );
    let runtime=emitted.replace("fwp_p_str_repeat(l0, l1)","observe_repeat(l0, l1)")
        .replacen("/* ---- program ---- */","static volatile V observed; static int calls, before_count; static V observe_repeat(V n,V s){calls++;V r=fwp_p_str_repeat(n,s);observed=r;return r;}\n/* ---- program ---- */",1)
        .replace("static void fwp_caf_finish(void) {","static void fwp_caf_finish(void) { before_count=observed?*fwp_rc_slot(observed):0;")
        .replace("int main(int argc, char **argv)","int original_main(int argc, char **argv)");
    let probe = r#"
int main(int argc,char **argv){int result=original_main(argc,argv);if(result)return result;
 if(calls!=1)return 2;if(before_count!=1)return 4;
 if(!observed||!(fwp_reuse_verify?STR(observed)->len==0:*fwp_rc_slot(observed)==0))return 3;
 return 0;}
"#;
    let start = runtime.find("/* main :").unwrap();
    let end = start + runtime[start..].find("\n}\n").unwrap() + 3;
    let body = &runtime[start..end];
    let at = body
        .find("fwp_drop")
        .expect("unused CAF argument must be released");
    let stop = at + body[at..].find(';').unwrap() + 1;
    let control_body = body.replacen(&body[at..stop], "", 1);
    let control = runtime.replacen(body, &control_body, 1);
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{control}\n{probe}"), &exe, opt).unwrap();
        let old = Command::new(&exe)
            .env("FWP_REUSE_VERIFY", "1")
            .output()
            .unwrap();
        assert_eq!(
            old.status.code(),
            Some(4),
            "missing argument release must leave an extra owner"
        );
        fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let o = Command::new(&exe)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", poison)
                .output()
                .unwrap();
            assert!(
                o.status.success(),
                "code {:?}: {}\n{body}",
                o.status.code(),
                String::from_utf8_lossy(&o.stderr)
            );
            assert_eq!(o.stdout, reference.stdout);
            assert_eq!(o.stderr, reference.stderr);
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}

#[test]
fn matched_record_fields_preserve_effects_and_callback_results() {
    let dir = std::env::temp_dir().join(format!("fwp-matched-fields-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let src = dir.join("probe.fwp");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(
        &src,
        r#"
measure : (String -> I64, Option[String]) -> I64
measure = match
    (_, Some _) -> id
    (_, None) -> const 0
text : Bool -> Option[String]
text = if id (const "x" | string.repeat 4 | Some) (const None)
measured : Bool -> I64
measured = both (const (string.length | add 1)) text | measure
left : I64 -> I64 ! {IO}
left = tap (const "left" | echo) | add 1
right : I64 -> I64 ! {IO}
right = tap (const "right" | echo) | mul 2
pick : (I64, I64) -> I64
pick = match (_, _) -> const
main = [
    True | measured | echo,
    False | measured | echo,
    3 | both left right | pick | echo,
]
"#,
    )
    .unwrap();
    let reference = Command::new(fwp)
        .args(["run", "--interp"])
        .arg(&src)
        .env("FWP_NO_OPT", "1")
        .output()
        .unwrap();
    assert!(reference.status.success(), "{reference:?}");
    assert_eq!(reference.stdout, b"5\n0\nleft\nright\n4\n");
    let optimized = Command::new(fwp)
        .args(["run", "--interp"])
        .arg(&src)
        .output()
        .unwrap();
    assert!(optimized.status.success(), "{optimized:?}");
    assert_eq!(optimized.stdout, reference.stdout);
    assert_eq!(optimized.stderr, reference.stderr);
    let mut failures = Vec::new();
    for memory in ["arc", "tracing"] {
        for optimization in ["-O0", "-O2"] {
            let exe = dir.join(format!("probe-{memory}{optimization}.exe"));
            let build = Command::new(fwp)
                .arg("build")
                .arg(&src)
                .args(["--gc", memory, optimization, "-o"])
                .arg(&exe)
                .output()
                .unwrap();
            if !build.status.success() {
                failures.push(format!("build {memory}, {optimization}: {build:?}"));
                continue;
            }
            let stress = if memory == "tracing" { "1" } else { "0" };
            let native = Command::new(&exe)
                .env_remove("FWP_GC")
                .env("FWP_GC_STRESS", stress)
                .env("FWP_GC_VERIFY", stress)
                .env("FWP_REUSE_VERIFY", stress)
                .output()
                .unwrap();
            if !native.status.success()
                || native.stdout != reference.stdout
                || native.stderr != reference.stderr
            {
                failures.push(format!("run {memory}, {optimization}: {native:?}"));
            }
        }
    }
    assert!(failures.is_empty(), "{}", failures.join("\n"));
    std::fs::remove_dir_all(dir).unwrap();
}
