//! Nested returned aliases must transfer unboxed variant owners without boxing.
use fwp::ir::*;
use fwp::value::Value;
use std::process::Command;

#[path = "support/ownership_ledger.rs"]
mod ownership_ledger;

#[path = "support/record_probe.rs"]
mod record_probe;

// Native generator options are process-wide. Each test resets them; an earlier
// failed test must not prevent the other case from reporting its own result.
static NATIVE_OPTIONS: std::sync::Mutex<()> = std::sync::Mutex::new(());
fn fun(params: &[MT], result: MT) -> MT {
    params
        .iter()
        .rev()
        .fold(result, |b, a| MT::Fun(Box::new(a.clone()), Box::new(b)))
}
#[test]
fn returned_variant_aliases_transfer_fields_once() {
    let _options = NATIVE_OPTIONS
        .lock()
        .unwrap_or_else(std::sync::PoisonError::into_inner);
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
            .unwrap()
            .call_root(
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
        let emitted = if arc {
            ownership_ledger::instrument_native(&emitted, 1 << 16)
        } else {
            emitted
        };
        let start = emitted.find("/* holder :").unwrap();
        let end = start + emitted[start..].find("/* concat :").unwrap();
        let holder = &emitted[start..end];
        let dir = std::env::temp_dir().join(format!("fwp-variant-alias-{}", std::process::id()));
        std::fs::create_dir_all(&dir).unwrap();
        let exe = dir.join("probe.exe");
        std::fs::write(dir.join("probe.c"), &emitted).unwrap();
        let runtime = emitted.replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        );
        let probe = r#"
static int dead(V v) {
#ifdef FWP_ARC_ONLY
 return !owner_ledger_slots[owner_ledger_find((uintptr_t)v)];
#else
 if(fwp_reuse_verify)return STR(v)->len==0;
 return *fwp_rc_slot(v)==0;
#endif
}
int main(void) {
 fwp_heap_start();fwp_fns=fwp_fn_table;fwp_init_consts();
 size_t baseline=fwp_heap.live;
 for(int round=0;round<32;round++){
 for (int alias=0;alias<2;alias++) {
  V first=fwp_rc_fresh(fwp_str_new("first",5)),last=fwp_rc_fresh(fwp_str_new("last",4)),other=fwp_rc_fresh(fwp_str_new("later",5));
  if(alias) {fwp_rc_dup(first);fwp_rc_dup(last);fwp_rc_dup(other);}
  V result=f1(first,last,other);
  if (STR(result)->len!=10 || memcmp(STR(result)->d,"laterfirst",10)) return 1;
  if (alias) {if (*fwp_rc_slot(first)!=1 || *fwp_rc_slot(last)!=1 || *fwp_rc_slot(other)!=1) return 2;fwp_rc_free_obj(first);fwp_rc_free_obj(last);fwp_rc_free_obj(other);}
  else if(!dead(first)||!dead(last)||!dead(other)) return 3;
  fwp_rc_free_obj(result);
 }
#ifdef FWP_ARC_ONLY
 if(fwp_heap.live!=baseline || fwp_heap.rc_wide_len || fwp_heap.ncollect)return 90;
 owner_ledger_finish();
#endif
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
                .env("FWP_GC", if arc { "off" } else { "on" })
                .env("FWP_GC_STATS", "0")
                .env("FWP_REUSE_VERIFY", stress)
                .output()
                .unwrap();
            record_probe::save(
                "variant_alias_ownership",
                &format!("{mode}{opt}-alias-extra-owner"),
                &format!("{control}\n{probe}"),
                &exe,
                &old,
            );
            assert_eq!(
                old.status.code(),
                Some(3),
                "an extra alias retain must be detected"
            );
            if arc {
                let missing = probe.replace("fwp_rc_free_obj(result);", "");
                assert_ne!(missing, probe);
                let code = format!("{runtime}\n{missing}");
                fwp::cgen::compile_c(&code, &exe, opt).unwrap();
                let missing_output = Command::new(&exe)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STATS", "0")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                record_probe::save(
                    "variant_alias_ownership",
                    &format!("{mode}{opt}-alias-missing-release"),
                    &code,
                    &exe,
                    &missing_output,
                );
                assert_eq!(
                    missing_output.status.code(),
                    Some(90),
                    "{mode} {opt}: {missing_output:?}"
                );
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
                    "variant_alias_ownership",
                    &format!("{mode}{opt}-alias-normal-poison{poison}"),
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
}

#[test]
fn source_aliases_across_yield_keep_pipe_behavior() {
    let dir = std::env::temp_dir().join(format!("fwp-variant-alias-source-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let src = dir.join("probe.fwp");
    let cfile = dir.join("probe.c");
    let exe = dir.join("probe.exe");
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
            let built = Command::new(fwp)
                .args(["build", "--gc", mode, "--memory", "dynamic"])
                .arg(&src)
                .args([opt, "-o"])
                .arg(&exe)
                .env("FWP_STACK", "0")
                .output()
                .unwrap();
            assert!(built.status.success(), "{mode} {opt}: {built:?}");
            let generated = Command::new(fwp)
                .args(["build", "--gc", mode, "--memory", "dynamic", "--emit-c"])
                .arg(&src)
                .args([opt, "-o"])
                .arg(&cfile)
                .env("FWP_STACK", "0")
                .output()
                .unwrap();
            assert!(generated.status.success(), "{mode} {opt}: {generated:?}");
            let program_code = std::fs::read_to_string(&cfile).unwrap();
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
                    "variant_alias_ownership",
                    &format!("{mode}{opt}-source-normal-poison{poison}"),
                    &program_code,
                    &exe,
                    &output,
                );
                assert!(output.stderr.is_empty(), "{mode} {opt}: {output:?}");
                assert!(
                    output.status.success(),
                    "{}",
                    String::from_utf8_lossy(&output.stderr)
                );
                assert_eq!(output.stdout, reference.stdout);
            }
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}

#[test]
fn matching_one_variant_payload_moves_its_owner_in_all_result_forms() {
    let _options = NATIVE_OPTIONS
        .lock()
        .unwrap_or_else(std::sync::PoisonError::into_inner);
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
        let text = MT::con("std::String");
        let outcome = MT::con("Single");
        let pair = MT::Record(vec![
            ("0".into(), text.clone()),
            ("1".into(), MT::con("std::I64")),
        ]);
        let mut program = Program::default();
        program.shapes.insert(
            outcome.clone(),
            TypeShape::Adt(vec![
                ("Value".into(), vec![text.clone()]),
                ("Empty".into(), vec![]),
            ]),
        );
        program.funcs.push(Func {
            name: "maker".into(),
            arity: 1,
            locals: vec![text.clone()],
            ty: fun(std::slice::from_ref(&text), outcome.clone()),
            body: Body::Expr(Expr::Construct(0, vec![Expr::Local(0)])),
        });
        for (name, result, selected, empty) in [
            (
                "value-holder",
                text.clone(),
                Expr::Local(2),
                Expr::Const(Value::str("empty")),
            ),
            (
                "record-holder",
                pair.clone(),
                Expr::Record(vec![Expr::Local(2), Expr::Const(Value::I64(17))]),
                Expr::Record(vec![
                    Expr::Const(Value::str("empty")),
                    Expr::Const(Value::I64(0)),
                ]),
            ),
            (
                "variant-holder",
                outcome.clone(),
                Expr::Construct(0, vec![Expr::Local(2)]),
                Expr::Construct(1, vec![]),
            ),
        ] {
            program.funcs.push(Func {
                name: name.into(),
                arity: 1,
                locals: vec![text.clone(), outcome.clone(), text.clone()],
                ty: fun(std::slice::from_ref(&text), result),
                body: Body::Expr(Expr::Let(
                    1,
                    Box::new(Expr::Call(0, vec![Expr::Local(0)])),
                    Box::new(Expr::Match(
                        Box::new(Expr::Local(1)),
                        vec![
                            (Pat::Construct(0, vec![Pat::Bind(2)]), selected),
                            (Pat::Construct(1, vec![]), empty),
                        ],
                    )),
                )),
            });
        }
        program.funcs.push(Func {
            name: "main".into(),
            arity: 0,
            locals: vec![],
            ty: MT::Record(vec![
                ("0".into(), text),
                ("1".into(), pair),
                ("2".into(), outcome),
            ]),
            // Keep every result form reachable in the emitted program. The C
            // probe calls these functions directly, but reachability starts here.
            body: Body::Expr(Expr::Record(
                (1..=3)
                    .map(|id| Expr::Call(id, vec![Expr::Const(Value::str("value"))]))
                    .collect(),
            )),
        });
        program.main = Some(4);
        fwp::ir::check_locals(&program).unwrap();
        let mut interpreter = fwp::interp::Interp::new(&program, Box::new(Vec::new())).unwrap();
        assert_eq!(
            interpreter.call_root(1, vec![Value::str("value")]).unwrap(),
            Value::str("value")
        );
        assert_eq!(
            interpreter.call_root(2, vec![Value::str("value")]).unwrap(),
            Value::Record(vec![Value::str("value"), Value::I64(17)].into())
        );
        assert_eq!(
            interpreter.call_root(3, vec![Value::str("value")]).unwrap(),
            Value::Data(0, vec![Value::str("value")].into())
        );
        let emitted = fwp::cgen::generate(&program).unwrap();
        let emitted = if arc {
            ownership_ledger::instrument_native(&emitted, 1 << 16)
        } else {
            emitted
        };
        let marker = "/* move matched variant payload */";
        assert_eq!(
            emitted.matches(marker).count(),
            3,
            "scalar, record and variant result generators must all transfer the field"
        );
        let runtime = emitted.replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        );
        let control = runtime.replace(
            marker,
            "fwp_rc_dup(l2); /* deliberately add a lost payload owner */",
        );
        let probe = r#"
static int dead(V v) {
#ifdef FWP_ARC_ONLY
 return !owner_ledger_slots[owner_ledger_find((uintptr_t)v)];
#else
 if(fwp_reuse_verify)return STR(v)->len==0;
 return *fwp_rc_slot(v)==0;
#endif
}
int main(void) {
 fwp_heap_start(); fwp_fns=fwp_fn_table; fwp_init_consts();
 size_t baseline=fwp_heap.live;
 for(int round=0;round<32;round++){
 for(int mode=0;mode<3;mode++) for(int alias=0;alias<2;alias++) {
  V value=fwp_rc_fresh(fwp_str_new("value",5));
  if(alias) fwp_rc_dup(value);
  V packed=mode==0?f1(value):mode==1?f2(value):f3(value);
  V result=mode==0?packed:OBJ(packed)->f[0];
  if(result!=value||STR(result)->len!=5||memcmp(STR(result)->d,"value",5))return 1;
  if(*fwp_rc_slot(result)!=1+alias)return 2;
  // Move the generic result's payload into this probe, then free its header.
  if(mode) fwp_rc_free_obj(packed);
  if(alias&&fwp_rc_release_last(value))return 3;
  if(!fwp_rc_release_last(result))return 4;
  fwp_rc_free_obj(result);
  if(!dead(result)||fwp_cleanups)return 5;
 }
#ifdef FWP_ARC_ONLY
 if(fwp_heap.live!=baseline || fwp_heap.rc_wide_len || fwp_heap.ncollect)return 90;
 owner_ledger_finish();
#endif
 }
 return 0;
}
"#;
        let dir = fwp::cgen::TempDir::new("variant-payload-move").unwrap();
        let exe = dir.join("probe.exe");
        for optimization in ["-O0", "-O2"] {
            fwp::cgen::compile_c(&format!("{control}\n{probe}"), &exe, optimization).unwrap();
            let negative = Command::new(&exe)
                .env("FWP_GC", if arc { "off" } else { "on" })
                .env("FWP_GC_STATS", "0")
                .env("FWP_GC_STRESS", stress)
                .env("FWP_GC_VERIFY", stress)
                .env("FWP_REUSE_VERIFY", stress)
                .output()
                .unwrap();
            record_probe::save(
                "variant_alias_ownership",
                &format!("{mode}{optimization}-payload-extra-owner"),
                &format!("{control}\n{probe}"),
                &exe,
                &negative,
            );
            assert_eq!(
                negative.status.code(),
                Some(2),
                "an extra payload owner must be detected: {negative:?}"
            );
            if arc {
                let missing = probe.replace("fwp_rc_free_obj(result);", "");
                assert_ne!(missing, probe);
                let code = format!("{runtime}\n{missing}");
                fwp::cgen::compile_c(&code, &exe, optimization).unwrap();
                let missing_output = Command::new(&exe)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STATS", "0")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                record_probe::save(
                    "variant_alias_ownership",
                    &format!("{mode}{optimization}-payload-missing-release"),
                    &code,
                    &exe,
                    &missing_output,
                );
                assert_eq!(
                    missing_output.status.code(),
                    Some(5),
                    "{mode} {optimization}: {missing_output:?}"
                );
            }
            fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &exe, optimization).unwrap();
            for poison in if arc { &["0"][..] } else { &["0", "1"][..] } {
                let actual = Command::new(&exe)
                    .env("FWP_GC", if arc { "off" } else { "on" })
                    .env("FWP_GC_STATS", "0")
                    .env("FWP_GC_STRESS", stress)
                    .env("FWP_GC_VERIFY", stress)
                    .env("FWP_REUSE_VERIFY", poison)
                    .output()
                    .unwrap();
                record_probe::save(
                    "variant_alias_ownership",
                    &format!("{mode}{optimization}-payload-normal-poison{poison}"),
                    &format!("{runtime}\n{probe}"),
                    &exe,
                    &actual,
                );
                assert!(
                    actual.stdout.is_empty() && actual.stderr.is_empty(),
                    "{mode} {optimization}: {actual:?}"
                );
                assert!(
                    actual.status.success(),
                    "{optimization}, poison {poison}: {actual:?}"
                );
            }
        }
    }
}
