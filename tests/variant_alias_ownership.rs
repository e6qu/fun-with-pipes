//! Nested returned aliases must transfer unboxed variant owners without boxing.
use fwp::ir::*;
use fwp::value::Value;
use std::process::Command;
fn fun(params: &[MT], result: MT) -> MT {
    params
        .iter()
        .rev()
        .fold(result, |b, a| MT::Fun(Box::new(a.clone()), Box::new(b)))
}
#[test]
fn returned_variant_aliases_transfer_fields_once() {
    let string = MT::con("std::String");
    let i64 = MT::con("std::I64");
    let outcome = MT::con("Outcome");
    let mut p = Program::default();
    p.shapes.insert(
        outcome.clone(),
        TypeShape::Adt(vec![
            (
                "Value".into(),
                vec![string.clone(), i64.clone(), string.clone()],
            ),
            ("Empty".into(), vec![]),
        ]),
    );
    p.funcs.push(Func {
        name: "maker".into(),
        arity: 2,
        locals: vec![string.clone(), string.clone()],
        ty: fun(&[string.clone(), string.clone()], outcome.clone()),
        body: Body::Expr(Expr::Construct(
            0,
            vec![Expr::Local(0), Expr::Const(Value::I64(17)), Expr::Local(1)],
        )),
    });
    let value = Expr::Let(
        3,
        Box::new(Expr::Call(0, vec![Expr::Local(0), Expr::Local(1)])),
        Box::new(Expr::Let(
            4,
            Box::new(Expr::Local(3)),
            Box::new(Expr::Local(4)),
        )),
    );
    let body = Expr::Let(
        5,
        Box::new(value),
        Box::new(Expr::Match(
            Box::new(Expr::Local(5)),
            vec![
                (
                    Pat::Construct(0, vec![Pat::Bind(6), Pat::Bind(7), Pat::Bind(8)]),
                    Expr::Call(2, vec![Expr::Local(6), Expr::Local(2)]),
                ),
                (
                    Pat::Construct(1, vec![]),
                    Expr::Const(Value::Str("empty".into())),
                ),
            ],
        )),
    );
    p.funcs.push(Func {
        name: "holder".into(),
        arity: 3,
        locals: vec![
            string.clone(),
            string.clone(),
            string.clone(),
            outcome.clone(),
            outcome.clone(),
            outcome,
            string.clone(),
            i64,
            string.clone(),
        ],
        ty: fun(
            &[string.clone(), string.clone(), string.clone()],
            string.clone(),
        ),
        body: Body::Expr(body),
    });
    p.funcs.push(Func {
        name: "concat".into(),
        arity: 2,
        locals: vec![string.clone(), string.clone()],
        ty: fun(&[string.clone(), string.clone()], string),
        body: Body::Prim("concat".into()),
    });
    p.funcs.push(Func {
        name: "main".into(),
        arity: 0,
        locals: vec![],
        ty: MT::con("std::String"),
        body: Body::Expr(Expr::Call(
            1,
            vec![
                Expr::Const(Value::Str("first".into())),
                Expr::Const(Value::Str("last".into())),
                Expr::Const(Value::Str("later".into())),
            ],
        )),
    });
    p.main = Some(3);
    fwp::ir::check_locals(&p).unwrap();
    let result = fwp::interp::Interp::new(&p, Box::new(Vec::new()))
        .call(
            1,
            vec![
                Value::Str("first".into()),
                Value::Str("last".into()),
                Value::Str("later".into()),
            ],
        )
        .unwrap();
    assert_eq!(result, Value::Str("laterfirst".into()));
    let emitted = fwp::cgen::generate(&p).unwrap();
    let start = emitted.find("/* holder :").unwrap();
    let end = start + emitted[start..].find("/* concat :").unwrap();
    let holder = &emitted[start..end];
    let dir = std::env::temp_dir().join(format!("fwp-variant-alias-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let exe = dir.join("probe");
    std::fs::write(dir.join("probe.c"), &emitted).unwrap();
    let runtime = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let probe = r#"
static int dead(V v) { return fwp_reuse_verify ? STR(v)->len==0 : *fwp_rc_slot(v)==0; }
int main(void) {
 fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
 for (int alias=0;alias<2;alias++) {
  V first=fwp_rc_fresh(fwp_str_new("first",5)),last=fwp_rc_fresh(fwp_str_new("last",4)),other=fwp_rc_fresh(fwp_str_new("later",5));
  if(alias) {fwp_rc_dup(first);fwp_rc_dup(last);fwp_rc_dup(other);}
  V result=f1(first,last,other);
  if (STR(result)->len!=10 || memcmp(STR(result)->d,"laterfirst",10)) return 1;
  if (alias) {if (*fwp_rc_slot(first)!=1 || *fwp_rc_slot(last)!=1 || *fwp_rc_slot(other)!=1) return 2;fwp_rc_free_obj(first);fwp_rc_free_obj(last);fwp_rc_free_obj(other);}
  else if(!dead(first)||!dead(last)||!dead(other)) return 3;
  fwp_rc_free_obj(result);
 }
 return 0;
}
"#;
    let transfer = holder
        .lines()
        .filter(|l| l.contains("fwp_u3") && l.contains(" = {"))
        .nth(1)
        .unwrap();
    let from = transfer
        .split(" = {")
        .nth(1)
        .unwrap()
        .split('.')
        .next()
        .unwrap();
    let drop_line = holder.lines().find(|l| l.contains("fwp_vdrop")).unwrap();
    let dup = drop_line
        .trim()
        .split('(')
        .next()
        .unwrap()
        .replace("vdrop", "vdup");
    let control = runtime.replacen(transfer, &format!("{dup}(&{from});\n{transfer}"), 1);
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{control}\n{probe}"), &exe, opt).unwrap();
        let old = Command::new(&exe)
            .env("FWP_REUSE_VERIFY", "1")
            .output()
            .unwrap();
        assert_eq!(
            old.status.code(),
            Some(3),
            "an extra alias retain must be detected"
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
                "code {:?}: {}\n{holder}",
                o.status.code(),
                String::from_utf8_lossy(&o.stderr)
            );
        }
    }
    assert!(
        !holder.contains("fwp_vbox"),
        "returned alias must remain unboxed: {holder}"
    );
    assert!(
        !holder.contains("fwp_vunbox"),
        "returned alias must not be boxed then unboxed: {holder}"
    );
    std::fs::remove_dir_all(dir).unwrap();
}

#[test]
fn source_aliases_across_yield_keep_pipe_behavior() {
    let dir = std::env::temp_dir().join(format!("fwp-variant-alias-source-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let src = dir.join("probe.fwp");
    let cfile = dir.join("probe.c");
    let exe = dir.join("probe");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(&src,r#"Outcome = | Value String I64 String | Empty
rec maker : I64 -> String -> String -> Outcome
maker = curry3 (if (.0 | eq 0) (make { 0 = .1, 1 = const 17, 2 = .2 } | uncurry3 Value) (make { 0 = .0 | sub 1, 1 = .1, 2 = .2 } | uncurry3 maker))
holder : String -> String -> String -> String ! {Async}
holder = curry3 (fork concat
    (make { 0 = const 0, 1 = .0, 2 = .1 } | uncurry3 maker | tap (const () | task.yield) | match
        Value _ _ _ -> curry3 (fork concat .0 .2)
        Empty -> "empty")
    .2)
other : String -> String -> String -> String ! {Async}
other = curry3 (const "other")
choose : Bool -> (String -> String -> String -> String ! {Async})
choose = if id (const holder) (const other)
main = "later" | choose (read-all () | string.length | eq 0) "first" "last" | echo
"#).unwrap();
    let reference = Command::new(fwp)
        .args(["run", "--interp"])
        .arg(&src)
        .output()
        .unwrap();
    assert!(reference.status.success());
    let output = Command::new(fwp)
        .arg("build")
        .arg(&src)
        .args(["--emit-c", "-o"])
        .arg(&cfile)
        .env("FWP_STACK", "0")
        .output()
        .unwrap();
    assert!(
        output.status.success(),
        "{}",
        String::from_utf8_lossy(&output.stderr)
    );
    let emitted = std::fs::read_to_string(&cfile).unwrap();
    let start = emitted.find("/* holder :").unwrap();
    let body = &emitted[start..];
    let end = body.find("/* other :").unwrap();
    let body = &body[..end];
    assert!(body.contains("fwp_u3"));
    assert!(
        !body.contains("fwp_vbox") && !body.contains("fwp_vunbox"),
        "source alias should remain unboxed: {body}"
    );
    for opt in ["-O1", "-O2"] {
        let output = Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args([opt, "-o"])
            .arg(&exe)
            .env("FWP_STACK", "0")
            .output()
            .unwrap();
        assert!(
            output.status.success(),
            "{}",
            String::from_utf8_lossy(&output.stderr)
        );
        for poison in ["0", "1"] {
            let output = Command::new(&exe)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", poison)
                .output()
                .unwrap();
            assert!(
                output.status.success(),
                "{}",
                String::from_utf8_lossy(&output.stderr)
            );
            assert_eq!(output.stdout, reference.stdout);
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}
