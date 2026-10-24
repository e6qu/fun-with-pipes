//! Match elimination must preserve nominal types of effectful discarded fields.
use fwp::ir::*;
use fwp::value::Value;
use std::process::Command;

#[path = "support/record_probe.rs"]
mod record_probe;
#[test]
fn discarded_effectful_constructor_fields_keep_their_nominal_types() {
    std::env::set_var("FWP_STACK", "0");
    fwp::cgen::set_static_memory(None);
    for arc in [true, false] {
        let mode = if arc { "arc" } else { "tracing" };
        let stress = if arc { "0" } else { "1" };

        fwp::cgen::set_native_options(fwp::cgen::NativeOptions {
            arc,
            static_link: false,
            pgo: None,
            cross: None,
        });
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
            TypeShape::Adt(vec![("Wrap".into(), vec![inner.clone(), i64.clone()])]),
        );
        p.funcs.push(Func {
            name: "discard".into(),
            arity: 1,
            locals: vec![string.clone(), outer.clone(), i64.clone()],
            ty: MT::Fun(Box::new(string.clone()), Box::new(i64.clone())),
            body: Body::Expr(Expr::Let(
                1,
                Box::new(Expr::Construct(
                    0,
                    vec![
                        Expr::Construct(
                            0,
                            vec![Expr::Call(
                                1,
                                vec![Expr::Const(Value::I64(2)), Expr::Local(0)],
                            )],
                        ),
                        Expr::Const(Value::I64(17)),
                    ],
                )),
                Box::new(Expr::Match(
                    Box::new(Expr::Local(1)),
                    vec![(
                        Pat::Construct(0, vec![Pat::Wild, Pat::Bind(2)]),
                        Expr::Local(2),
                    )],
                )),
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
            name: "main".into(),
            arity: 0,
            locals: vec![],
            ty: MT::con("std::I64"),
            body: Body::Expr(Expr::Call(0, vec![Expr::Const(Value::Str("input".into()))])),
        });
        p.main = Some(2);
        fwp::ir::check_locals(&p).unwrap();
        let reference = fwp::interp::Interp::new(&p, Box::new(Vec::new()))
            .unwrap()
            .call_root(0, vec![Value::Str("input".into())])
            .unwrap();
        assert_eq!(reference, Value::I64(17));
        fwp::opt::optimize(&mut p);
        fwp::ir::check_locals(&p).unwrap();
        let rc = fwp::rc::insert(&p);
        let (_, locals) = rc[0].as_ref().unwrap();
        assert!(
            locals.contains(&inner),
            "optimized match must keep the effectful Inner owner: {locals:?}"
        );
        assert!(
            !locals.contains(&MT::con("?")),
            "discarded constructor context must not become unknown: {locals:?}"
        );
        let result = fwp::interp::Interp::new(&p, Box::new(Vec::new()))
            .unwrap()
            .call_root(0, vec![Value::Str("input".into())])
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
            !body.contains("fwp_data(0, 2"),
            "the matched outer value should be eliminated: {body}"
        );
        let runtime=emitted.replace("fwp_p_str_repeat(l0, l1)","observe_repeat(l0, l1)")
 .replacen("/* repeat :","static V observed; static V observe_repeat(V n,V s) { V r=fwp_p_str_repeat(n,s);observed=r;return r; }\n/* repeat :",1)
 .replace("int main(int argc, char **argv)","int original_main(int argc, char **argv)");
        let probe = r#"
static int dead(V v) {
#ifndef FWP_ARC_ONLY
 if(fwp_reuse_verify)return STR(v)->len==0;
#endif
 return *fwp_rc_slot(v)==0;
}
int main(void) {
 fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
 intptr_t baseline=fwp_gc.budget;
 for(int round=0;round<32;round++){
 for(int alias=0;alias<2;alias++) {
  V input=fwp_rc_fresh(fwp_str_new("input",5));if(alias)fwp_rc_dup(input);observed=0;
  if(f0(input)!=17) return 1;
  if(!observed || !dead(observed)) return 3;
  if(alias){if(*fwp_rc_slot(input)!=1 || STR(input)->len!=5)return 4;fwp_rc_free_obj(input);}
  else if(!dead(input))return 5;
 }
#ifdef FWP_ARC_ONLY
 if(fwp_gc.budget!=baseline || fwp_gc.rc_wide_len || fwp_gc.ncollect)return 90;
#endif
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
        let control = if arc {
            let error =
                fwp::cgen::generate(&erased).expect_err("ARC must reject erased ownership types");
            assert!(error.contains("--gc arc"), "{error}");
            None
        } else {
            Some(fwp::cgen::generate(&erased).unwrap()
 .replace("fwp_p_str_repeat(l0, l1)","observe_repeat(l0, l1)")
 .replacen("/* repeat :","static V observed; static V observe_repeat(V n,V s) { V r=fwp_p_str_repeat(n,s);observed=r;return r; }\n/* repeat :",1)
 .replace("int main(int argc, char **argv)","int original_main(int argc, char **argv)"))
        };
        let dir = std::env::temp_dir().join(format!("fwp-match-context-{}", std::process::id()));
        std::fs::create_dir_all(&dir).unwrap();
        let exe = dir.join("probe.exe");
        std::fs::write(dir.join("probe.c"), &emitted).unwrap();
        for opt in ["-O1", "-O2"] {
            if let Some(control) = &control {
                fwp::cgen::compile_c(&format!("{control}\n{probe}"), &exe, opt).unwrap();
                let old = Command::new(&exe)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STATS", "0")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "1")
                    .output()
                    .unwrap();
                record_probe::save(
                    "match_context_ownership",
                    &format!("{mode}{opt}-ir-erased-type"),
                    &format!("{control}\n{probe}"),
                    &exe,
                    &old,
                );
                assert_eq!(
                    old.status.code(),
                    Some(3),
                    "erasing the discarded field type must expose its child leak"
                );
            }
            if arc {
                let missing = probe.replace("fwp_rc_free_obj(input);", "");
                assert_ne!(missing, probe);
                let code = format!("{runtime}\n{missing}");
                fwp::cgen::compile_c(&code, &exe, opt).unwrap();
                let old = Command::new(&exe)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STATS", "0")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                record_probe::save(
                    "match_context_ownership",
                    &format!("{mode}{opt}-ir-missing-release"),
                    &code,
                    &exe,
                    &old,
                );
                assert_eq!(old.status.code(), Some(90), "{mode} {opt}: {old:?}");
            }
            fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &exe, opt).unwrap();
            for poison in if arc { &["0"][..] } else { &["0", "1"][..] } {
                let o = Command::new(&exe)
                    .env("FWP_GC", if arc { "off" } else { "on" })
                    .env("FWP_GC_STATS", "0")
                    .env("FWP_GC_STRESS", stress)
                    .env("FWP_GC_VERIFY", stress)
                    .env("FWP_REUSE_VERIFY", poison)
                    .output()
                    .unwrap();
                record_probe::save(
                    "match_context_ownership",
                    &format!("{mode}{opt}-ir-normal-poison{poison}"),
                    &format!("{runtime}\n{probe}"),
                    &exe,
                    &o,
                );
                assert!(
                    o.stdout.is_empty() && o.stderr.is_empty(),
                    "{mode} {opt}: {o:?}"
                );
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
}

#[test]
fn source_discarded_nested_fields_release_children() {
    let dir = std::env::temp_dir().join(format!("fwp-match-context-source-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let src = dir.join("probe.fwp");
    let cfile = dir.join("probe.c");
    let exe = dir.join("probe.exe");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(
        &src,
        r#"Inner = | Leaf String
Outer = | Wrap Inner I64
discard : String -> I64
discard = make { 0 = string.repeat 2 | Leaf, 1 = const 17 } | uncurry Wrap | match
    Wrap _ _ -> curry .1
other : String -> I64
other = const 18
choose : Bool -> (String -> I64)
choose = if id (const discard) (const other)
main = "input" | choose (read-all () | string.length | eq 0) | echo
"#,
    )
    .unwrap();
    let reference = Command::new(fwp)
        .env("FWP_NO_OPT", "1")
        .args(["run", "--interp"])
        .arg(&src)
        .output()
        .unwrap();
    assert!(reference.status.success());
    for mode in ["arc", "tracing"] {
        let stress = if mode == "arc" { "0" } else { "1" };
        let output = Command::new(fwp)
            .args(["build", "--gc", mode, "--memory", "dynamic"])
            .arg(&src)
            .args(["--emit-c", "-O2", "-o"])
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
            !body.contains("fwp_data(0, 2"),
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
static int dead(V v) {
#ifndef FWP_ARC_ONLY
 if(fwp_reuse_verify)return STR(v)->len==0;
#endif
 return *fwp_rc_slot(v)==0;
}
int main(void) {
 fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
 intptr_t baseline=fwp_gc.budget;
 for(int round=0;round<32;round++){
 for(int alias=0;alias<2;alias++){V input=fwp_rc_fresh(fwp_str_new("input",5));if(alias)fwp_rc_dup(input);observed=0;
 if(fFUNCTION(input)!=17)return 1;if(!observed||!dead(observed))return 3;
 if(alias){if(*fwp_rc_slot(input)!=1||STR(input)->len!=5)return 4;fwp_rc_free_obj(input);}else if(!dead(input))return 5;}
#ifdef FWP_ARC_ONLY
 if(fwp_gc.budget!=baseline || fwp_gc.rc_wide_len || fwp_gc.ncollect)return 90;
#endif
 }
 return 0;
}
"#.replace("FUNCTION",id);
        for opt in ["-O1", "-O2"] {
            if mode == "arc" {
                let missing = probe.replace("fwp_rc_free_obj(input);", "");
                assert_ne!(missing, probe);
                let code = format!("{runtime}\n{missing}");
                fwp::cgen::compile_c(&code, &exe, opt).unwrap();
                let output = Command::new(&exe)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STATS", "0")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                record_probe::save(
                    "match_context_ownership",
                    &format!("{mode}{opt}-source-missing-release"),
                    &code,
                    &exe,
                    &output,
                );
                assert_eq!(output.status.code(), Some(90), "{mode} {opt}: {output:?}");
            }
            fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &exe, opt).unwrap();
            for poison in if mode == "arc" {
                &["0"][..]
            } else {
                &["0", "1"][..]
            } {
                let output = Command::new(&exe)
                    .env("FWP_GC", if mode == "arc" { "off" } else { "on" })
                    .env("FWP_GC_STATS", "0")
                    .env("FWP_GC_STRESS", stress)
                    .env("FWP_GC_VERIFY", stress)
                    .env("FWP_REUSE_VERIFY", poison)
                    .output()
                    .unwrap();
                record_probe::save(
                    "match_context_ownership",
                    &format!("{mode}{opt}-source-normal-poison{poison}"),
                    &format!("{runtime}\n{probe}"),
                    &exe,
                    &output,
                );
                assert!(
                    output.stdout.is_empty() && output.stderr.is_empty(),
                    "{mode} {opt}: {output:?}"
                );
                assert!(
                    output.status.success(),
                    "code {:?}: {}",
                    output.status.code(),
                    String::from_utf8_lossy(&output.stderr)
                );
            }
            let output = Command::new(fwp)
                .args(["build", "--gc", mode, "--memory", "dynamic"])
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
                .env("FWP_GC", if mode == "arc" { "off" } else { "on" })
                .env("FWP_GC_STATS", "0")
                .env("FWP_GC_STRESS", stress)
                .env("FWP_GC_VERIFY", stress)
                .env("FWP_REUSE_VERIFY", stress)
                .output()
                .unwrap();
            assert!(output.status.success());
            assert_eq!(output.stdout, reference.stdout);
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}
