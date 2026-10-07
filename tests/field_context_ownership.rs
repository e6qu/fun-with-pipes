//! Inlined record projections must preserve checked field ownership types.
use fwp::ir::*;
use fwp::value::Value;
use std::process::Command;
#[test]
fn inlined_projection_releases_discarded_nested_children() {
    let string = MT::con("std::String");
    let i64 = MT::con("std::I64");
    let inner = MT::con("Inner");
    let outer = MT::con("Outer");
    let mut p = Program::default();
    p.shapes.insert(
        inner.clone(),
        TypeShape::Adt(vec![("Leaf".into(), vec![string.clone()])]),
    );
    p.shapes.insert(
        outer.clone(),
        TypeShape::Record(vec![
            ("child".into(), inner.clone()),
            ("number".into(), i64.clone()),
        ]),
    );
    p.funcs.push(Func {
        name: "discard".into(),
        arity: 1,
        locals: vec![string.clone()],
        ty: MT::Fun(Box::new(string.clone()), Box::new(i64.clone())),
        body: Body::Expr(Expr::Field(
            Box::new(Expr::Call(2, vec![Expr::Local(0)])),
            1,
        )),
    });
    p.funcs.push(Func {
        name: "repeat".into(),
        arity: 2,
        locals: vec![i64.clone(), string.clone()],
        ty: MT::Fun(
            Box::new(i64),
            Box::new(MT::Fun(Box::new(string.clone()), Box::new(string))),
        ),
        body: Body::Prim("string.repeat".into()),
    });
    p.funcs.push(Func {
        name: "make".into(),
        arity: 1,
        locals: vec![MT::con("std::String")],
        ty: MT::Fun(Box::new(MT::con("std::String")), Box::new(outer.clone())),
        body: Body::Expr(Expr::Record(vec![
            Expr::Construct(
                0,
                vec![Expr::Call(
                    1,
                    vec![Expr::Const(Value::I64(2)), Expr::Local(0)],
                )],
            ),
            Expr::Const(Value::I64(17)),
        ])),
    });
    p.funcs.push(Func {
        name: "main".into(),
        arity: 0,
        locals: vec![],
        ty: MT::con("std::I64"),
        body: Body::Expr(Expr::Call(0, vec![Expr::Const(Value::Str("input".into()))])),
    });
    p.main = Some(3);
    fwp::ir::check_locals(&p).unwrap();
    let reference = fwp::interp::Interp::new(&p, Box::new(Vec::new()))
        .call(0, vec![Value::Str("input".into())])
        .unwrap();
    assert_eq!(reference, Value::I64(17));
    fwp::opt::optimize(&mut p);
    fwp::ir::check_locals(&p).unwrap();
    let rc = fwp::rc::insert(&p);
    let (_, locals) = rc[0].as_ref().unwrap();
    assert!(
        locals.contains(&inner),
        "inlined projection must keep the effectful Inner owner: {locals:?}"
    );
    assert!(
        !locals.contains(&MT::con("?")),
        "record projection context must not become unknown: {locals:?}"
    );
    let result = fwp::interp::Interp::new(&p, Box::new(Vec::new()))
        .call(0, vec![Value::Str("input".into())])
        .unwrap();
    assert_eq!(result, reference);
    // Keep the tested function reachable without re-running inlining on its entry.
    p.funcs.push(Func {
        name: "entry".into(),
        arity: 0,
        locals: vec![],
        ty: MT::con("std::I64"),
        body: Body::Expr(Expr::Call(0, vec![Expr::Const(Value::Str("input".into()))])),
    });
    p.main = Some(p.funcs.len() - 1);
    let emitted = fwp::cgen::generate(&p).unwrap();
    let start = emitted.find("/* discard :").unwrap();
    let end = start + emitted[start..].find("/* repeat :").unwrap();
    let body = &emitted[start..end];
    assert!(
        !body.contains("fwp_record(2"),
        "the projected outer value should be eliminated: {body}"
    );
    let runtime=emitted.replace("fwp_p_str_repeat(l0, l1)","observe_repeat(l0, l1)")
 .replacen("/* repeat :","static V observed; static V observe_repeat(V n,V s) { V r=fwp_p_str_repeat(n,s);observed=r;return r; }\n/* repeat :",1)
 .replace("int main(int argc, char **argv)","int original_main(int argc, char **argv)");
    let probe = r#"
static int dead(V v) { return fwp_reuse_verify ? STR(v)->len==0 : *fwp_rc_slot(v)==0; }
int main(void) {
 fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
 for(int alias=0;alias<2;alias++) {
  V input=fwp_rc_fresh(fwp_str_new("input",5));if(alias)fwp_rc_dup(input);observed=0;
  if(f0(input)!=17) return 1;
  if(!observed || !dead(observed)) return 3;
  if(alias){if(*fwp_rc_slot(input)!=1 || STR(input)->len!=5)return 4;fwp_rc_free_obj(input);}
  else if(!dead(input))return 5;
 }
 return 0;
}
"#;
    let mut erased = p.clone();
    for ty in &mut erased.funcs[0].locals {
        if *ty == inner {
            *ty = MT::con("?");
        }
    }
    let control=fwp::cgen::generate(&erased).unwrap()
 .replace("fwp_p_str_repeat(l0, l1)","observe_repeat(l0, l1)")
 .replacen("/* repeat :","static V observed; static V observe_repeat(V n,V s) { V r=fwp_p_str_repeat(n,s);observed=r;return r; }\n/* repeat :",1)
 .replace("int main(int argc, char **argv)","int original_main(int argc, char **argv)");
    let dir = std::env::temp_dir().join(format!("fwp-field-context-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let exe = dir.join("probe");
    std::fs::write(dir.join("probe.c"), &emitted).unwrap();
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{control}\n{probe}"), &exe, opt).unwrap();
        let old = Command::new(&exe)
            .env("FWP_REUSE_VERIFY", "1")
            .output()
            .unwrap();
        assert_eq!(
            old.status.code(),
            Some(3),
            "erasing the discarded field type must expose its child leak"
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
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}

#[test]
fn source_record_projection_releases_discarded_children() {
    let dir = std::env::temp_dir().join(format!("fwp-field-context-source-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let src = dir.join("probe.fwp");
    let cfile = dir.join("probe.c");
    let exe = dir.join("probe");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(
        &src,
        r#"Inner = | Leaf String
Outer = { child : Inner, number : I64 }
discard : String -> I64
make-outer : String -> Outer
make-outer = make { child = string.repeat 2 | Leaf, number = const 17 }
discard = make-outer | .number
other : String -> I64
other = const 18
choose : Bool -> (String -> I64)
choose = if id (const discard) (const other)
main = "input" | choose (read-all () | string.length | eq 0) | echo
"#,
    )
    .unwrap();
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
    let start = emitted.find("/* discard :").unwrap();
    let end = start + emitted[start..].find("/* other :").unwrap();
    let body = &emitted[start..end];
    assert!(
        !body.contains("fwp_record(2"),
        "outer construction should not allocate: {body}"
    );
    let id = body
        .split("static V f")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let runtime=emitted.replace("fwp_p_str_repeat(l0, l1)","observe_repeat(l0, l1)")
 .replacen("/* string.repeat :","static V observed; static V observe_repeat(V n,V s) { V r=fwp_p_str_repeat(n,s);observed=r;return r; }\n/* string.repeat :",1)
 .replace("int main(int argc, char **argv)","int original_main(int argc, char **argv)");
    let probe=r#"
static int dead(V v) {return fwp_reuse_verify?STR(v)->len==0:*fwp_rc_slot(v)==0;}
int main(void) {
 fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
 for(int alias=0;alias<2;alias++){V input=fwp_rc_fresh(fwp_str_new("input",5));if(alias)fwp_rc_dup(input);observed=0;
 if(fFUNCTION(input)!=17)return 1;if(!observed||!dead(observed))return 3;
 if(alias){if(*fwp_rc_slot(input)!=1||STR(input)->len!=5)return 4;fwp_rc_free_obj(input);}else if(!dead(input))return 5;}
 return 0;
}
"#.replace("FUNCTION",id);
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let output = Command::new(&exe)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", poison)
                .output()
                .unwrap();
            assert!(
                output.status.success(),
                "code {:?}: {}",
                output.status.code(),
                String::from_utf8_lossy(&output.stderr)
            );
        }
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
        let output = Command::new(&exe)
            .env("FWP_GC_STRESS", "1")
            .env("FWP_GC_VERIFY", "1")
            .env("FWP_REUSE_VERIFY", "1")
            .output()
            .unwrap();
        assert!(output.status.success());
        assert_eq!(output.stdout, reference.stdout);
    }
    std::fs::remove_dir_all(dir).unwrap();
}
