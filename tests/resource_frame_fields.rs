//! Original resource frames retain typed fields without boxing field-only locals.
#![cfg(any(target_os = "linux", target_os = "macos"))]
use std::process::{Command, Output};
fn checked(command: &mut Command) -> Output {
    let out = command.output().unwrap();
    assert!(
        out.status.success(),
        "{command:?}: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    out
}
#[test]
fn original_record_holders_preserve_files_without_heap_boxes() {
    let dir = fwp::cgen::TempDir::new("fwp-resource-frame-fields").unwrap();
    let data = dir.join("data");
    std::fs::write(&data, "contents").unwrap();
    let src = dir.join("probe.fwp");
    let stages = std::iter::repeat_n("file.read-all | .1", 20)
        .collect::<Vec<_>>()
        .join(" | ");
    std::fs::write(
        &src,
        format!(
            r#"
pack : File -> {{file: File}} ! {{FileIO, Error[IoError]}}
pack = {stages} | make {{file = id}}
main = "{}" | file.open | pack | .file | file.close | const "closed" | echo
"#,
            data.display()
        ),
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src),
    );
    assert_eq!(reference.stdout, b"closed\n");
    let exe = dir.join("probe");
    for opt in ["-O1", "-O2"] {
        checked(
            Command::new(fwp)
                .arg("build")
                .arg(&src)
                .args([opt, "-o"])
                .arg(&exe),
        );
        let out = checked(
            Command::new(&exe)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", "1"),
        );
        assert_eq!(out.stdout, reference.stdout);
        assert_eq!(out.stderr, reference.stderr);
    }
    use fwp::ir::*;
    let file = MT::con("std::File");
    let unit = MT::unit();
    let record = MT::Record(vec![("file".into(), file.clone())]);
    let program = Program {
        funcs: vec![
            Func {
                name: "main".into(),
                arity: 0,
                locals: vec![record, unit.clone()],
                ty: unit.clone(),
                body: Body::Expr(Expr::ResourceRegion {
                    parameters: vec![],
                    bindings: vec![0],
                    body: Box::new(Expr::Let(
                        0,
                        Box::new(Expr::Record(vec![Expr::Call(
                            1,
                            vec![Expr::Const(fwp::value::Value::str(
                                data.to_string_lossy().as_ref(),
                            ))],
                        )])),
                        Box::new(Expr::Let(
                            1,
                            Box::new(Expr::Call(
                                2,
                                vec![Expr::Field(Box::new(Expr::Local(0)), 0)],
                            )),
                            Box::new(Expr::Local(1)),
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
                ty: MT::Fun(Box::new(file), Box::new(unit)),
                body: Body::Prim("file.close".into()),
            },
        ],
        main: Some(0),
        ..Program::default()
    };
    assert_eq!(fwp::interp::run_main(&program, vec![]).exit_code, 0);
    for mode in ["0", "1"] {
        // Only this test process uses the compiler setting; local tests run serially.
        unsafe {
            std::env::set_var("FWP_FRAME_FIELDS", mode);
        }
        let code = fwp::cgen::generate(&program).unwrap();
        unsafe {
            std::env::remove_var("FWP_FRAME_FIELDS");
        }
        let allocation = "static V fwp_record(uint32_t n, const V *f) {";
        assert_eq!(code.matches(allocation).count(), 1);
        let code = code
            .replace(
                "typedef uint64_t V;",
                "typedef uint64_t V;\nstatic int one_field_boxes;",
            )
            .replace(
                allocation,
                &format!("{allocation}\n    if(n==1)one_field_boxes++;"),
            )
            .replace(
                "return fwp_exit_code;",
                if mode == "0" {
                    "fprintf(stderr,\"one-field boxes: %d\\n\",one_field_boxes);if(one_field_boxes!=1)return 32;return fwp_exit_code;"
                } else {
                    "fprintf(stderr,\"one-field boxes: %d\\n\",one_field_boxes);if(one_field_boxes!=0)return 33;return fwp_exit_code;"
                },
            );
        for opt in ["-O1", "-O2"] {
            fwp::cgen::compile_c(&code, &exe, opt).unwrap();
            for gc in ["on", "off"] {
                for poison in ["0", "1"] {
                    let out = checked(
                        Command::new(&exe)
                            .env("FWP_GC", gc)
                            .env("FWP_GC_STRESS", "1")
                            .env("FWP_GC_VERIFY", "1")
                            .env("FWP_REUSE_VERIFY", poison),
                    );
                    assert!(out.stdout.is_empty());
                    eprintln!(
                        "mode {mode}, {opt}, GC {gc}, poison {poison}: {}",
                        String::from_utf8_lossy(&out.stderr)
                    );
                }
            }
        }
    }
    let mut fault_program = program.clone();
    let string = MT::con("std::String");
    fault_program.funcs[0].locals[0] = MT::Record(vec![
        ("file".into(), MT::con("std::File")),
        ("text".into(), string.clone()),
    ]);
    let Body::Expr(Expr::ResourceRegion { body, .. }) = &mut fault_program.funcs[0].body else {
        panic!()
    };
    let Expr::Let(_, value, _) = &mut **body else {
        panic!()
    };
    let Expr::Record(fields) = &mut **value else {
        panic!()
    };
    fields.push(Expr::Call(
        3,
        vec![
            Expr::Const(fwp::value::Value::str("first")),
            Expr::Const(fwp::value::Value::str("second")),
        ],
    ));
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
    let retain = code
        .lines()
        .find(|line| line.contains("/* original resource field */") && line.contains("fwp_rc_dup("))
        .unwrap();
    let text = retain
        .split("fwp_rc_dup(")
        .nth(1)
        .unwrap()
        .split(')')
        .next()
        .unwrap();
    let code = code
        .replace(
            retain,
            &format!("watched_text={text};fwp_trap(\"injected field retain failure\");{retain}"),
        )
        .replace(
            "typedef uint64_t V;",
            "typedef uint64_t V;\nstatic volatile V watched_text;",
        )
        .replace(
            "int main(int argc, char **argv)",
            "int program_main(int argc, char **argv)",
        );
    let file_drop = code
        .lines()
        .find(|line| line.contains(" { fwp_file_drop(v); }"))
        .unwrap()
        .split("static void ")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let omitted = code.replace(&format!("{file_drop}(c->v0);"), "(void)c->v0;");
    assert_ne!(omitted, code);
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
static int fd, closes;
static FILE *stream;
static FILE *observed_open(const char *p,const char *m){FILE *f=fopen(p,m);if(f){stream=f;fd=fileno(f);}return f;}
static int observed_close(FILE *f){if(f==stream)closes++;return fclose(f);}
static int recover(void){return 1;}
int main(void){
 fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_prog_out=stdout;fwp_init_consts();
 jmp_buf recovery;fwp_trap_jb=&recovery;fwp_trap_recover=recover;fwp_trap_cleanup=0;
 int failed=setjmp(recovery);if(!failed){f0();return 1;}
 fwp_trap_jb=0;fwp_trap_recover=0;
 struct stat status;if(fwp_cleanups||closes!=1||fstat(fd,&status)!=-1||errno!=EBADF)return 2;
 uint8_t *slot=fwp_rc_slot(watched_text);
 if(fwp_reuse_verify){if(STR(watched_text)->len||STR(watched_text)->d[0])return 3;}
 else if(!slot||*slot)return 3;
 return 0;
}
"#;
    for opt in ["-O1", "-O2"] {
        for (code, expected) in [(&omitted, 2), (&code, 0)] {
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
                    "{opt}, poison {poison}: {}",
                    String::from_utf8_lossy(&out.stderr)
                );
            }
        }
    }
}
