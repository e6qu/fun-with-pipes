//! Memoized values retain one cache owner and return owned results to callers.
use fwp::ir::*;
use fwp::value::Value;
use std::process::Command;

#[path = "support/record_probe.rs"]
mod record_probe;

#[test]
fn cached_values_keep_exact_owners_and_release_typed_children() {
    std::env::set_var("FWP_STACK", "0");
    fwp::cgen::set_static_memory(None);
    let string = MT::con("std::String");
    let i64 = MT::con("std::I64");
    let record = MT::Record(vec![
        ("0".into(), string.clone()),
        ("1".into(), string.clone()),
        ("2".into(), i64.clone()),
    ]);
    let p = Program {
        funcs: vec![
            Func {
                name: "cached".into(),
                arity: 0,
                locals: vec![],
                ty: string.clone(),
                body: Body::Expr(Expr::Call(
                    1,
                    vec![
                        Expr::Const(Value::I64(2)),
                        Expr::Const(Value::Str("input".into())),
                    ],
                )),
            },
            Func {
                name: "repeat".into(),
                arity: 2,
                locals: vec![i64.clone(), string.clone()],
                ty: MT::Fun(
                    Box::new(i64.clone()),
                    Box::new(MT::Fun(Box::new(string.clone()), Box::new(string.clone()))),
                ),
                body: Body::Prim("string.repeat".into()),
            },
            Func {
                name: "alias".into(),
                arity: 0,
                locals: vec![],
                ty: string.clone(),
                body: Body::Expr(Expr::Func(0)),
            },
            Func {
                name: "main".into(),
                arity: 0,
                locals: vec![],
                ty: record,
                body: Body::Expr(Expr::Record(vec![
                    Expr::Func(0),
                    Expr::Func(2),
                    Expr::Func(4),
                ])),
            },
            Func {
                name: "scalar".into(),
                arity: 0,
                locals: vec![],
                ty: i64,
                body: Body::Expr(Expr::Const(Value::I64(17))),
            },
        ],
        main: Some(3),
        ..Program::default()
    };
    fwp::ir::check_locals(&p).unwrap();
    let mut interp = fwp::interp::Interp::new(&p, Box::new(Vec::new())).unwrap();
    let a = interp.call_root(3, vec![]).unwrap();
    let b = interp.call_root(3, vec![]).unwrap();
    assert_eq!(a, b);
    assert_eq!(
        a,
        Value::Record(
            vec![
                Value::Str("inputinput".into()),
                Value::Str("inputinput".into()),
                Value::I64(17)
            ]
            .into()
        )
    );
    let dir = fwp::cgen::TempDir::new("caf-cache").unwrap();
    let exe = dir.join("probe.exe");
    for arc in [true, false] {
        let mode = if arc { "arc" } else { "tracing" };
        let stress = if arc { "0" } else { "1" };
        fwp::cgen::set_native_options(fwp::cgen::NativeOptions {
            arc,
            static_link: false,
            pgo: None,
            cross: None,
        });
        let emitted = fwp::cgen::generate(&p).unwrap();
        let runtime=emitted.replace("fwp_p_str_repeat(l0, l1)","observe_repeat(l0, l1)")
        .replacen("/* repeat :","static V observed; static int calls, fail_once, reenter; static V scalar_bits, reentrant_held; static V observe_repeat(V n,V s) { calls++; if(reenter){reenter=0;reentrant_held=caf0();} if(fail_once){fail_once=0;fwp_trap(\"initialization failed\");} V r=fwp_p_str_repeat(n,s);observed=r;return r; }\n/* repeat :",1)
        .replace("return (V)(int64_t)17LL;","return scalar_bits;")
        .replace("int main(int argc, char **argv)","int original_main(int argc, char **argv)");
        let probe = r#"
static jmp_buf overflow; static int recover(void){return 1;}
static int dead(V v){
#ifndef FWP_ARC_ONLY
 if(fwp_reuse_verify)return STR(v)->len==0;
#endif
 return *fwp_rc_slot(v)==0;
}
static int dead_record(V v){
#ifndef FWP_ARC_ONLY
 if(fwp_reuse_verify)return OBJ(v)->tag==0xdead;
#endif
 return *fwp_rc_slot(v)==0;
}
int main(void){
 fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
 intptr_t baseline=fwp_gc.budget;
 scalar_bits=fwp_rc_fresh(fwp_str_new("scalar",6));
 intptr_t round_baseline=fwp_gc.budget;
 for(int round=0;round<32;round++){
 calls=0;observed=0;reenter=0;reentrant_held=0;
 fail_once=1;fwp_trap_recover=recover;fwp_trap_jb=&overflow;fwp_trap_cleanup=fwp_cleanups;
 if(setjmp(overflow)==0){(void)caf0();return 10;}
 fwp_trap_recover=0;fwp_trap_jb=0;
 V retry=caf0();if(calls!=2||*fwp_rc_slot(retry)!=2)return 11;fwp_rc_drop(retry);
 V a=caf0(),b=caf0();if(calls!=2||a!=b||*fwp_rc_slot(a)!=3)return 1;
 fwp_rc_drop(a);fwp_rc_drop(b);if(*fwp_rc_slot(observed)!=1)return 2;
 V r=caf3();if(*fwp_rc_slot(r)!=2||*fwp_rc_slot(observed)!=4)return 3;
 if(OBJ(r)->f[0]!=observed||OBJ(r)->f[1]!=observed||OBJ(r)->f[2]!=scalar_bits)return 4;
 if(*fwp_rc_slot(scalar_bits)!=1)return 5;
 // Saturation is a recoverable retain failure; the committed cache stays live.
 uint8_t *slot=fwp_rc_slot(observed);*slot=254;fwp_rc_dup(observed);(*fwp_rc_wide_link(slot))->count=SIZE_MAX;
 fwp_cleanup *boundary=fwp_cleanups;
 fwp_trap_recover=recover;fwp_trap_jb=&overflow;fwp_trap_cleanup=boundary;
 if(setjmp(overflow)==0){(void)caf0();return 6;}
 fwp_trap_recover=0;fwp_trap_jb=0;
 if(fwp_cleanups!=boundary||calls!=2||(*fwp_rc_wide_link(slot))->count!=SIZE_MAX)return 7;
 fwp_rc_forget_slot(slot);*slot=4;
 fwp_rc_drop(r);
 if(*fwp_rc_slot(r)!=1||*fwp_rc_slot(observed)!=4)return 8;
 fwp_caf_finish();
 if(!dead(observed)||!dead_record(r)||*fwp_rc_slot(scalar_bits)!=1)return 9;
 fwp_caf_finish();
 reenter=1;V outer=caf0();V inner=reentrant_held;
 if(outer==inner||*fwp_rc_slot(outer)!=2||*fwp_rc_slot(inner)!=1)return 12;
 fwp_rc_free_obj(inner);fwp_rc_drop(outer);fwp_caf_finish();
 if(!dead(inner)||!dead(outer))return 13;
#ifdef FWP_ARC_ONLY
 if(fwp_gc.budget!=round_baseline||fwp_gc.rc_wide_len||fwp_gc.ncollect)return 90;
#endif
 }
 fwp_rc_free_obj(scalar_bits);
#ifdef FWP_ARC_ONLY
 if(fwp_gc.budget!=baseline||fwp_gc.rc_wide_len||fwp_gc.ncollect)return 90;
#endif
 return 0;
}
"#;
        let executable_probe = r#"static int dead(V v){
#ifndef FWP_ARC_ONLY
 if(fwp_reuse_verify)return STR(v)->len==0;
#endif
 return *fwp_rc_slot(v)==0;
}
int main(int argc,char **argv){int result=original_main(argc,argv);if(result)return result;
 if(!observed || !dead(observed))return 3;
 return 0;}
"#;
        let root_start = runtime.find("    V r = caf3();").unwrap();
        let root = &runtime[root_start..];
        let root_drop = root
            .split("    fwp_tasks_finish();\n    ")
            .nth(1)
            .unwrap()
            .split(';')
            .next()
            .unwrap();
        assert!(root_drop.starts_with("fwp_drop"));
        let missing_root = runtime.replacen(&format!("    {root_drop};"), "", 1);
        let caf0 = runtime.split("static V caf0(void) {").nth(1).unwrap();
        let previous_drop = caf0
            .split("(previous);")
            .next()
            .unwrap()
            .split_whitespace()
            .next_back()
            .unwrap();
        let missing_previous = runtime.replace(&format!("{previous_drop}(previous);"), "");
        let missing_return_owner = runtime.replace("fwp_rc_dup(fwp_caf_value0);", "");
        assert_ne!(missing_previous, runtime);
        assert_ne!(missing_return_owner, runtime);
        for opt in ["-O1", "-O2"] {
            for (case, code, expected) in [
                (
                    "missing-previous",
                    format!("{missing_previous}\n{probe}"),
                    12,
                ),
                (
                    "missing-return",
                    format!("{missing_return_owner}\n{probe}"),
                    11,
                ),
                (
                    "missing-finish",
                    format!(
                        "{runtime}\n{}",
                        probe.replace("fwp_caf_finish();", "(void)0;")
                    ),
                    9,
                ),
            ] {
                fwp::cgen::compile_c(&code, &exe, opt).unwrap();
                let output = Command::new(&exe)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STATS", "0")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", if mode == "arc" { "0" } else { "1" })
                    .output()
                    .unwrap();
                record_probe::save(
                    "caf_ownership",
                    &format!("{mode}{opt}-cache-{case}"),
                    &code,
                    &exe,
                    &output,
                );
                assert_eq!(
                    output.status.code(),
                    Some(expected),
                    "{mode} {opt} {case}: {output:?}"
                );
                assert!(output.stderr.is_empty(), "{output:?}");
            }
            let code = format!("{runtime}\n{probe}");
            fwp::cgen::compile_c(&code, &exe, opt).unwrap();
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
                    "caf_ownership",
                    &format!("{mode}{opt}-cache-normal-poison{poison}"),
                    &code,
                    &exe,
                    &output,
                );
                assert!(output.status.success(), "{mode} {opt}: {output:?}");
                assert_eq!(output.stdout, b"");
                assert!(output.stderr.is_empty(), "{output:?}");
            }
        }
        for opt in ["-O1", "-O2"] {
            {
                let (case, code, expected) = (
                    "missing-root",
                    format!("{missing_root}\n{executable_probe}"),
                    3,
                );
                fwp::cgen::compile_c(&code, &exe, opt).unwrap();
                let output = Command::new(&exe)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STATS", "0")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", if mode == "arc" { "0" } else { "1" })
                    .output()
                    .unwrap();
                record_probe::save(
                    "caf_ownership",
                    &format!("{mode}{opt}-root-{case}"),
                    &code,
                    &exe,
                    &output,
                );
                assert_eq!(
                    output.status.code(),
                    Some(expected),
                    "{mode} {opt} {case}: {output:?}"
                );
                assert!(output.stderr.is_empty(), "{output:?}");
            }
            let code = format!("{runtime}\n{executable_probe}");
            fwp::cgen::compile_c(&code, &exe, opt).unwrap();
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
                    "caf_ownership",
                    &format!("{mode}{opt}-root-normal-poison{poison}"),
                    &code,
                    &exe,
                    &output,
                );
                assert!(output.status.success(), "{mode} {opt}: {output:?}");
                assert_eq!(output.stdout, b"");
                assert!(output.stderr.is_empty(), "{output:?}");
            }
        }
        if arc {
            let missing = probe.replace("fwp_rc_free_obj(scalar_bits);", "");
            assert_ne!(missing, probe);
            for opt in ["-O1", "-O2"] {
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
                    "caf_ownership",
                    &format!("{mode}{opt}-cache-missing-release"),
                    &code,
                    &exe,
                    &output,
                );
                assert_eq!(output.status.code(), Some(90), "{output:?}");
            }
        }
    }
}

#[test]
fn source_cafs_initialize_once_and_release_after_tasks_finish() {
    let dir = std::env::temp_dir().join(format!("fwp-caf-source-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let src = dir.join("probe.fwp");
    let cfile = dir.join("probe.c");
    let exe = dir.join("probe.exe");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(
        &src,
        r#"cached = "input" | string.repeat 2
main = [cached | echo, cached | echo] | ignore
"#,
    )
    .unwrap();
    let reference = Command::new(fwp)
        .env("FWP_NO_OPT", "1")
        .args(["run", "--interp"])
        .arg(&src)
        .output()
        .unwrap();
    assert!(
        reference.status.success(),
        "{}",
        String::from_utf8_lossy(&reference.stderr)
    );
    assert_eq!(reference.stdout, b"inputinput\ninputinput\n");
    for mode in ["arc", "tracing"] {
        let stress = if mode == "arc" { "0" } else { "1" };
        let build = Command::new(fwp)
            .args(["build", "--gc", mode, "--memory", "dynamic"])
            .arg(&src)
            .args(["--emit-c", "-O2", "-o"])
            .arg(&cfile)
            .env("FWP_STACK", "0")
            .output()
            .unwrap();
        assert!(
            build.status.success(),
            "{}",
            String::from_utf8_lossy(&build.stderr)
        );
        let emitted = std::fs::read_to_string(&cfile).unwrap();
        let runtime=emitted.replace("fwp_p_str_repeat(l0, l1)","observe_repeat(l0, l1)")
        .replacen("/* string.repeat :","static volatile V observed; static int evaluations; static V observe_repeat(V n,V s){evaluations++;V r=fwp_p_str_repeat(n,s);observed=r;return r;}\n/* string.repeat :",1)
        .replace("int main(int argc, char **argv)","int original_main(int argc, char **argv)");
        assert!(runtime.contains("static volatile V observed"));
        let probe = r#"static int dead(V v){
#ifndef FWP_ARC_ONLY
 if(fwp_reuse_verify)return STR(v)->len==0;
#endif
 return *fwp_rc_slot(v)==0;
}
int main(int argc,char **argv){
 int result=original_main(argc,argv);
 if(result)return result;
 if(evaluations!=1)return 4;
 if(!observed || !dead(observed))return 3;
#ifdef FWP_ARC_ONLY
 /* budget is remaining allowance; zero live charge restores its initial value. */
 if(fwp_gc.budget!=fwp_gc.budget_given||fwp_gc.rc_wide_len||fwp_gc.ncollect)return 90;
#endif
 return 0;
}
"#;
        for opt in ["-O1", "-O2"] {
            {
                let (case, code, expected) = (
                    "missing-finish",
                    format!("{}\n{probe}", runtime.replace("    fwp_caf_finish();", "")),
                    3,
                );
                fwp::cgen::compile_c(&code, &exe, opt).unwrap();
                let output = Command::new(&exe)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STATS", "0")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", if mode == "arc" { "0" } else { "1" })
                    .output()
                    .unwrap();
                record_probe::save(
                    "caf_ownership",
                    &format!("{mode}{opt}-source-{case}"),
                    &code,
                    &exe,
                    &output,
                );
                assert_eq!(
                    output.status.code(),
                    Some(expected),
                    "{mode} {opt} {case}: {output:?}"
                );
                assert!(output.stderr.is_empty(), "{output:?}");
            }
            let code = format!("{runtime}\n{probe}");
            fwp::cgen::compile_c(&code, &exe, opt).unwrap();
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
                    "caf_ownership",
                    &format!("{mode}{opt}-source-normal-poison{poison}"),
                    &code,
                    &exe,
                    &output,
                );
                assert!(output.status.success(), "{mode} {opt}: {output:?}");
                assert_eq!(output.stdout, reference.stdout);
                assert!(output.stderr.is_empty(), "{output:?}");
            }
        }
        for opt in ["-O1", "-O2"] {
            let build = Command::new(fwp)
                .args(["build", "--gc", mode, "--memory", "dynamic"])
                .arg(&src)
                .args([opt, "-o"])
                .arg(&exe)
                .env("FWP_STACK", "0")
                .output()
                .unwrap();
            assert!(build.status.success(), "{build:?}");
            let native = Command::new(&exe)
                .env("FWP_GC", if mode == "arc" { "off" } else { "on" })
                .env("FWP_GC_STATS", "0")
                .env("FWP_GC_STRESS", stress)
                .env("FWP_GC_VERIFY", stress)
                .env("FWP_REUSE_VERIFY", stress)
                .output()
                .unwrap();
            assert!(native.status.success(), "{native:?}");
            assert_eq!(native.stdout, reference.stdout);
            assert_eq!(native.stderr, reference.stderr);
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}

#[test]
fn trapping_caf_evaluation_releases_caller_owners() {
    let dir = std::env::temp_dir().join(format!("fwp-caf-trap-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let src = dir.join("probe.fwp");
    let cfile = dir.join("probe.c");
    let exe = dir.join("probe.exe");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(
        &src,
        r#"cached = 1 | div 0 | show
holder : String -> String
holder = fork concat id (const cached)
other : String -> String
other = string.repeat 2
choose : Bool -> (String -> String)
choose = if id (const holder) (const other)
main = [task.yield (), "input" | choose (read-all () | string.length | eq 0) | echo] | ignore
"#,
    )
    .unwrap();
    let reference = Command::new(fwp)
        .env("FWP_NO_OPT", "1")
        .args(["run", "--interp"])
        .arg(&src)
        .output()
        .unwrap();
    assert!(!reference.status.success());
    for mode in ["arc", "tracing"] {
        let stress = if mode == "arc" { "0" } else { "1" };
        let build = Command::new(fwp)
            .args(["build", "--gc", mode, "--memory", "dynamic"])
            .arg(&src)
            .args(["--emit-c", "-O2", "-o"])
            .arg(&cfile)
            .env("FWP_STACK", "0")
            .output()
            .unwrap();
        assert!(
            build.status.success(),
            "{}",
            String::from_utf8_lossy(&build.stderr)
        );
        let emitted = std::fs::read_to_string(&cfile).unwrap();
        let start = emitted.find("/* holder :").unwrap();
        let end = start + emitted[start..].find("\n}\n").unwrap() + 3;
        let body = &emitted[start..end];
        let id = body
            .split("static V f")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap();
        let runtime = emitted.replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        );
        let probe = r#"
static int dead(V v){
#ifndef FWP_ARC_ONLY
 if(fwp_reuse_verify)return STR(v)->len==0;
#endif
 return *fwp_rc_slot(v)==0;
}
static jmp_buf trapped; static int recover(void){return 1;}
int main(void){
 fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
 intptr_t baseline=fwp_gc.budget;
 for(int round=0;round<32;round++){
 for(int alias=0;alias<2;alias++){
  V input=fwp_rc_fresh(fwp_str_new("input",5));if(alias)fwp_rc_dup(input);
  fwp_trap_recover=recover;fwp_trap_jb=&trapped;fwp_trap_cleanup=0;
  if(setjmp(trapped)==0){fFUNCTION(input);return 1;}
  fwp_trap_recover=0;fwp_trap_jb=0;
  if(fwp_cleanups)return 2;
  if(alias){if(*fwp_rc_slot(input)!=1||STR(input)->len!=5)return 3;fwp_rc_free_obj(input);}
  else if(!dead(input))return 4;
 }
 fwp_caf_finish();
#ifdef FWP_ARC_ONLY
 if(fwp_gc.budget!=baseline||fwp_gc.rc_wide_len||fwp_gc.ncollect)return 90;
#endif
 }
 return 0;
}
"#
        .replace("FUNCTION", id);
        let caf = body.find(" = caf").unwrap();
        let point = body[..caf]
            .rfind("fwp_cleanup_push(")
            .expect("CAF evaluation must protect the caller");
        let stop = point + body[point..].find(';').unwrap() + 1;
        let push = &body[point..stop];
        let node = push.split('&').nth(1).unwrap().split(',').next().unwrap();
        let control_body =
            body.replacen(push, "", 1)
                .replacen(&format!("fwp_cleanup_pop(&{node});"), "", 1);
        let control = runtime.replacen(body, &control_body, 1);
        for opt in ["-O1", "-O2"] {
            {
                let (case, code, expected) = ("missing-scope", format!("{control}\n{probe}"), 4);
                fwp::cgen::compile_c(&code, &exe, opt).unwrap();
                let output = Command::new(&exe)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STATS", "0")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", if mode == "arc" { "0" } else { "1" })
                    .output()
                    .unwrap();
                record_probe::save(
                    "caf_ownership",
                    &format!("{mode}{opt}-trap-{case}"),
                    &code,
                    &exe,
                    &output,
                );
                assert_eq!(
                    output.status.code(),
                    Some(expected),
                    "{mode} {opt} {case}: {output:?}"
                );
                assert!(output.stderr.is_empty(), "{output:?}");
            }
            let code = format!("{runtime}\n{probe}");
            fwp::cgen::compile_c(&code, &exe, opt).unwrap();
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
                    "caf_ownership",
                    &format!("{mode}{opt}-trap-normal-poison{poison}"),
                    &code,
                    &exe,
                    &output,
                );
                assert!(output.status.success(), "{mode} {opt}: {output:?}");
                assert_eq!(output.stdout, b"");
                assert!(output.stderr.is_empty(), "{output:?}");
            }
        }
        for opt in ["-O1", "-O2"] {
            let build = Command::new(fwp)
                .args(["build", "--gc", mode, "--memory", "dynamic"])
                .arg(&src)
                .args([opt, "-o"])
                .arg(&exe)
                .env("FWP_STACK", "0")
                .output()
                .unwrap();
            assert!(build.status.success(), "{build:?}");
            let native = Command::new(&exe)
                .env("FWP_GC", if mode == "arc" { "off" } else { "on" })
                .env("FWP_GC_STATS", "0")
                .env("FWP_GC_STRESS", stress)
                .env("FWP_GC_VERIFY", stress)
                .env("FWP_REUSE_VERIFY", stress)
                .output()
                .unwrap();
            assert_eq!(native.status.code(), reference.status.code());
            assert_eq!(native.stdout, reference.stdout);
            assert_eq!(native.stderr, reference.stderr);
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}
