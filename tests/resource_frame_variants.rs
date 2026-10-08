//! Original resource variant holders preserve typed payloads without parent boxes.
use fwp::ir::*;
use std::process::Command;

#[test]
fn original_variant_frame_holders_do_not_force_heap_boxes() {
    let dir = fwp::cgen::TempDir::new("resource-frame-variants").unwrap();
    let data = dir.join("data");
    std::fs::write(&data, "contents").unwrap();
    let source = dir.join("probe.fwp");
    let stages = std::iter::repeat_n("file.read-all | .1", 20)
        .collect::<Vec<_>>()
        .join(" | ");
    std::fs::write(
        &source,
        format!(
            r#"
pack : File -> Option[File] ! {{FileIO, Error[IoError]}}
pack = {stages} | Some
close = match
    Some _ -> file.close
    None -> ()
main = "{}" | file.open | pack | close | const "closed" | echo
"#,
            data.display()
        ),
    )
    .unwrap();
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
    assert_eq!(reference.stdout, b"closed\n");
    let source_exe = dir.join("source");
    for opt in ["-O1", "-O2"] {
        let out = Command::new(fwp)
            .env("FWP_REUSE", "0")
            .env("FWP_FREE", "0")
            .arg("build")
            .arg(&source)
            .args([opt, "-o"])
            .arg(&source_exe)
            .output()
            .unwrap();
        assert!(
            out.status.success(),
            "{}",
            String::from_utf8_lossy(&out.stderr)
        );
        for gc in ["off", "on"] {
            for poison in ["0", "1"] {
                let out = Command::new(&source_exe)
                    .env("FWP_GC", gc)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison)
                    .output()
                    .unwrap();
                assert!(
                    out.status.success(),
                    "{}",
                    String::from_utf8_lossy(&out.stderr)
                );
                assert_eq!(out.stdout, reference.stdout);
                assert_eq!(out.stderr, reference.stderr);
            }
        }
    }
    let file = MT::con("std::File");
    let unit = MT::unit();
    let variant = MT::con("Probe");
    let program = Program {
        funcs: vec![
            Func {
                name: "main".into(),
                arity: 0,
                locals: vec![variant.clone(), file.clone()],
                ty: unit.clone(),
                body: Body::Expr(Expr::ResourceRegion {
                    parameters: vec![],
                    bindings: vec![0],
                    body: Box::new(Expr::Let(
                        0,
                        Box::new(Expr::Construct(
                            0,
                            vec![Expr::Call(
                                1,
                                vec![Expr::Const(fwp::value::Value::str(
                                    data.to_string_lossy().as_ref(),
                                ))],
                            )],
                        )),
                        Box::new(Expr::Match(
                            Box::new(Expr::Local(0)),
                            vec![
                                (
                                    Pat::Construct(0, vec![Pat::Bind(1)]),
                                    Expr::Call(2, vec![Expr::Local(1)]),
                                ),
                                (Pat::Construct(1, vec![]), Expr::Record(vec![])),
                            ],
                        )),
                    )),
                }),
            },
            Func {
                name: "file.open".into(),
                arity: 1,
                locals: vec![MT::con("std::String")],
                ty: MT::Fun(Box::new(MT::con("std::String")), Box::new(file.clone())),
                body: Body::Prim("file.open".into()),
            },
            Func {
                name: "file.close".into(),
                arity: 1,
                locals: vec![file.clone()],
                ty: MT::Fun(Box::new(file.clone()), Box::new(unit)),
                body: Body::Prim("file.close".into()),
            },
        ],
        main: Some(0),
        shapes: std::collections::BTreeMap::from([(
            variant,
            TypeShape::Adt(vec![("Held".into(), vec![file]), ("Empty".into(), vec![])]),
        )]),
        ..Program::default()
    };
    assert_eq!(fwp::interp::run_main(&program, vec![]).exit_code, 0);
    let exe = dir.join("probe");
    for mode in ["0", "1"] {
        unsafe {
            std::env::set_var("FWP_FRAME_FIELDS", mode);
        }
        let code = fwp::cgen::generate(&program).unwrap();
        unsafe {
            std::env::remove_var("FWP_FRAME_FIELDS");
        }
        let allocation = "static V fwp_data(uint32_t tag, uint32_t n, const V *f) {";
        assert_eq!(code.matches(allocation).count(), 1);
        let code = code
            .replace(
                "typedef uint64_t V;",
                "typedef uint64_t V;\nstatic int parent_boxes;",
            )
            .replace(
                allocation,
                &format!("{allocation}\n    if(tag==0&&n==1)parent_boxes++;"),
            )
            .replace(
                "return fwp_exit_code;",
                &format!(
                    "if(parent_boxes!={})return 33;return fwp_exit_code;",
                    if mode == "0" { 1 } else { 0 }
                ),
            );
        for opt in ["-O1", "-O2"] {
            fwp::cgen::compile_c(&code, &exe, opt).unwrap();
            for gc in ["off", "on"] {
                for poison in ["0", "1"] {
                    let out = Command::new(&exe)
                        .env("FWP_GC", gc)
                        .env("FWP_GC_STRESS", "1")
                        .env("FWP_GC_VERIFY", "1")
                        .env("FWP_REUSE_VERIFY", poison)
                        .output()
                        .unwrap();
                    assert!(
                        out.status.success(),
                        "mode={mode}, {opt}, gc={gc}, poison={poison}: {:?}: {}",
                        out.status.code(),
                        String::from_utf8_lossy(&out.stderr)
                    );
                }
            }
        }
    }
    // Dynamic nullary and scalar tags must not drop an inactive File payload.
    for selector in [0, 1] {
        let mut tagged = program.clone();
        let variant = tagged.funcs[0].locals[0].clone();
        let scalar = MT::con("std::I64");
        let TypeShape::Adt(constructors) = tagged.shapes.get_mut(&variant).unwrap() else {
            panic!()
        };
        constructors.push(("Scalar".into(), vec![scalar.clone()]));
        tagged.funcs.push(Func {
            name: "choose".into(),
            arity: 1,
            locals: vec![scalar.clone()],
            ty: MT::Fun(Box::new(scalar), Box::new(variant)),
            body: Body::Expr(Expr::Match(
                Box::new(Expr::Local(0)),
                vec![
                    (
                        Pat::Lit(fwp::value::Value::I64(0)),
                        Expr::Construct(1, vec![]),
                    ),
                    (
                        Pat::Wild,
                        Expr::Construct(2, vec![Expr::Const(fwp::value::Value::I64(-1))]),
                    ),
                ],
            )),
        });
        let Body::Expr(Expr::ResourceRegion { body, .. }) = &mut tagged.funcs[0].body else {
            panic!()
        };
        let Expr::Let(_, value, body) = &mut **body else {
            panic!()
        };
        **value = Expr::Call(3, vec![Expr::Const(fwp::value::Value::I64(selector))]);
        let Expr::Match(_, arms) = &mut **body else {
            panic!()
        };
        arms.push((Pat::Construct(2, vec![Pat::Wild]), Expr::Record(vec![])));
        assert_eq!(fwp::interp::run_main(&tagged, vec![]).exit_code, 0);
        let code = fwp::cgen::generate(&tagged).unwrap();
        assert!(code.contains("/* original resource variant */"));
        for opt in ["-O1", "-O2"] {
            fwp::cgen::compile_c(&code, &exe, opt).unwrap();
            for gc in ["off", "on"] {
                for poison in ["0", "1"] {
                    let out = Command::new(&exe)
                        .env("FWP_GC", gc)
                        .env("FWP_GC_STRESS", "1")
                        .env("FWP_GC_VERIFY", "1")
                        .env("FWP_REUSE_VERIFY", poison)
                        .output()
                        .unwrap();
                    assert!(
                        out.status.success(),
                        "selector={selector}, {opt}, gc={gc}, poison={poison}: {}",
                        String::from_utf8_lossy(&out.stderr)
                    );
                }
            }
        }
    }
    // One original binder may be a let on one path and a whole-pattern binding
    // on another. Its frame representation must work for both binding kinds.
    for selector in [0, 1] {
        let mut mixed = program.clone();
        let Body::Expr(Expr::ResourceRegion { body, bindings, .. }) = &mut mixed.funcs[0].body
        else {
            panic!()
        };
        bindings.push(1); // Also exercise typed V and variant cleanup slots together.
        let Expr::Let(_, value, matched) = &mut **body else {
            panic!()
        };
        let Expr::Match(_, arms) = &mut **matched else {
            panic!()
        };
        arms[0].1 = Expr::Record(vec![]); // Disposal without explicit file.close.
        let pattern_path = Expr::Match(value.clone(), vec![(Pat::Bind(0), (**matched).clone())]);
        **body = Expr::Match(
            Box::new(Expr::Const(fwp::value::Value::I64(selector))),
            vec![
                (Pat::Lit(fwp::value::Value::I64(0)), (**body).clone()),
                (Pat::Wild, pattern_path),
            ],
        );
        assert_eq!(fwp::interp::run_main(&mixed, vec![]).exit_code, 0);
        let counted = fwp::rc::insert(&mixed);
        let (_, locals) = counted[0].as_ref().unwrap();
        assert!(
            locals
                .iter()
                .filter(|ty| **ty == mixed.funcs[0].locals[0])
                .count()
                > 1,
            "bare nominal match scrutinee must keep its typed owner: {locals:?}"
        );
        let code = fwp::cgen::generate(&mixed).unwrap();
        let hooks = r#"
#include <stdio.h>
#include <sys/stat.h>
static FILE *binding_open(const char *,const char *);
static int binding_close(FILE *);
static int binding_fd, binding_closes;
#define fopen binding_open
#define fclose binding_close
"#;
        let audit = r#"
#undef fopen
#undef fclose
static FILE *binding_stream;
static FILE *binding_open(const char *p,const char *m){FILE *f=fopen(p,m);if(f){binding_stream=f;binding_fd=fileno(f);}return f;}
static int binding_close(FILE *f){if(f==binding_stream)binding_closes++;return fclose(f);}
"#;
        let code = code.replace("return fwp_exit_code;", "struct stat binding_status;if(binding_closes!=1||fstat(binding_fd,&binding_status)!=-1||errno!=EBADF)return 34;return fwp_exit_code;");
        let code = format!("{hooks}\n{code}\n{audit}");
        for opt in ["-O1", "-O2"] {
            fwp::cgen::compile_c(&code, &exe, opt).unwrap();
            for gc in ["off", "on"] {
                for poison in ["0", "1"] {
                    let out = Command::new(&exe)
                        .env("FWP_GC", gc)
                        .env("FWP_GC_STRESS", "1")
                        .env("FWP_GC_VERIFY", "1")
                        .env("FWP_REUSE_VERIFY", poison)
                        .output()
                        .unwrap();
                    assert!(
                        out.status.success(),
                        "binding selector={selector}, {opt}, gc={gc}, poison={poison}: {}",
                        String::from_utf8_lossy(&out.stderr)
                    );
                }
            }
        }
    }
    // A File retain succeeds before the String retain traps. Both the extra
    // reference and the incoming owned payload must be released exactly once.
    let mut fault_program = program.clone();
    let string = MT::con("std::String");
    let variant = fault_program.funcs[0].locals[0].clone();
    let TypeShape::Adt(constructors) = fault_program.shapes.get_mut(&variant).unwrap() else {
        panic!()
    };
    constructors[0].1.push(string.clone());
    fault_program.funcs[0].locals.push(string.clone());
    let Body::Expr(Expr::ResourceRegion { body, .. }) = &mut fault_program.funcs[0].body else {
        panic!()
    };
    let Expr::Let(_, value, body) = &mut **body else {
        panic!()
    };
    let Expr::Construct(_, fields) = &mut **value else {
        panic!()
    };
    fields.push(Expr::Call(
        3,
        vec![
            Expr::Const(fwp::value::Value::str("first")),
            Expr::Const(fwp::value::Value::str("second")),
        ],
    ));
    let Expr::Match(_, arms) = &mut **body else {
        panic!()
    };
    let Pat::Construct(_, fields) = &mut arms[0].0 else {
        panic!()
    };
    fields.push(Pat::Bind(2));
    fault_program.funcs.push(Func {
        name: "concat".into(),
        arity: 2,
        locals: vec![string.clone(), string.clone()],
        ty: MT::Fun(
            Box::new(string.clone()),
            Box::new(MT::Fun(Box::new(string.clone()), Box::new(string))),
        ),
        body: Body::Prim("concat".into()),
    });
    let code = fwp::cgen::generate(&fault_program).unwrap();
    let retain = "fwp_rc_dup(u->f[1]);";
    assert_eq!(code.matches(retain).count(), 1);
    let marker = code
        .lines()
        .find(|line| line.contains("/* original resource variant */"))
        .unwrap();
    let k = marker
        .split("fwp_vdup")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let code = code
        .replace(
            retain,
            &format!("watched_text=u->f[1];fwp_trap(\"injected variant retain failure\");{retain}"),
        )
        .replace(
            "typedef uint64_t V;",
            "typedef uint64_t V;\nstatic volatile V watched_text;",
        )
        .replace(
            "int main(int argc, char **argv)",
            "int program_main(int argc, char **argv)",
        );
    let omission = format!("fwp_vdrop{k}(&c->v0);");
    assert!(code.contains(&omission));
    let omitted = code.replace(&omission, "(void)c->v0;");
    let hooks = r#"
#include <stdio.h>
static FILE *observed_open(const char *,const char *);
static int observed_close(FILE *);
#define fopen observed_open
#define fclose observed_close
"#;
    let fixture = r#"
#undef fopen
#undef fclose
#include <sys/stat.h>
static int fd, closes;static FILE *stream;
static FILE *observed_open(const char *p,const char *m){FILE *f=fopen(p,m);if(f){stream=f;fd=fileno(f);}return f;}
static int observed_close(FILE *f){if(f==stream)closes++;return fclose(f);}
static int recover(void){return 1;}
int main(void){
 fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_prog_out=stdout;fwp_init_consts();
 jmp_buf recovery;fwp_trap_jb=&recovery;fwp_trap_recover=recover;fwp_trap_cleanup=0;
 if(!setjmp(recovery)){f0();return 1;}
 fwp_trap_jb=0;fwp_trap_recover=0;
 struct stat status;if(fwp_cleanups||closes!=1||fstat(fd,&status)!=-1||errno!=EBADF)return 2;
 uint8_t *slot=fwp_rc_slot(watched_text);
 if(fwp_reuse_verify){if(STR(watched_text)->len||STR(watched_text)->d[0])return 3;}
 else if(!slot||*slot)return 3;
 return 0;
}
"#;
    for opt in ["-O1", "-O2"] {
        for (code, expected) in [(&code, 0), (&omitted, 2)] {
            fwp::cgen::compile_c(&format!("{hooks}\n{code}\n{fixture}"), &exe, opt).unwrap();
            for poison in ["0", "1"] {
                let out = Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison)
                    .output()
                    .unwrap();
                assert_eq!(
                    out.status.code(),
                    Some(expected),
                    "{opt}, poison={poison}: {}",
                    String::from_utf8_lossy(&out.stderr)
                );
            }
        }
    }
}
