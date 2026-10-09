//! Copied client failure text is released after raising a trap or typed error.
use fwp::ir::*;
use std::process::Command;

#[test]
fn client_failure_text_releases_after_traps_and_typed_errors() {
    let unit = MT::unit();
    let program = Program {
        funcs: vec![
            Func {
                name: "available".into(),
                arity: 1,
                locals: vec![unit.clone()],
                ty: MT::Fun(Box::new(unit.clone()), Box::new(MT::con("std::Bool"))),
                body: Body::Prim("tls.available".into()),
            },
            Func {
                name: "web".into(),
                arity: 0,
                locals: vec![],
                ty: unit,
                body: Body::Prim("http2.connect".into()),
            },
        ],
        exports: vec![("available".into(), 0)],
        ..Program::default()
    };
    let (generated, _) = fwp::cgen::generate_library(&program, "grpc_client_failure").unwrap();
    let hooks = r#"
#include <stdlib.h>
static void *watched_text;
static int text_frees;
static void observed_free(void *);
static void no_release(void *);
#define free(p) observed_free(p)
"#;
    let fixture = r#"
#undef free
static void observed_free(void *p){if(p&&p==watched_text){text_frees++;watched_text=0;}free(p);}
static void no_release(void *p){(void)p;}
static int recover(void){return 1;}
static jmp_buf failed;
/* The error path writes the handler after setjmp; keep it nonautomatic. */
static fwp_handler handler;
int main(void){
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));
 const fwp_desc integer={.kind=K_I64,.name="I64"},string={.kind=K_STR,.name="String"};
 const fwp_desc *fields[]={&integer,&string};const fwp_desc error={.kind=K_RECORD,.name="GrpcError",.n=2,.fields=fields};
 fwp_remote remote={0};remote.what="probe";remote.m.grpc_error=&error;
 for(int kind=0;kind<5;kind++){
  text_frees=0;const char *message=kind==1?"trap: decoder trap":kind==2||kind==4?"denied":"transport failure";
  int code=kind==1?GRPC_INTERNAL:kind==2||kind==4?7:-1;
  watched_text=strdup(message);if(!watched_text)return 9;
  remote.m.status_errors=kind>=3;memset(&handler,0,sizeof handler);handler.cleanup=fwp_cleanups;handler.state_depth=fwp_state_len;
  if(kind>=3)fwp_handlers=&handler;
  fwp_trap_recover=recover;fwp_trap_jb=&failed;fwp_trap_cleanup=0;
  if(!setjmp(failed)){
   if(!setjmp(handler.jb)){g_stub_fail(&remote,"local",code,watched_text);return 2;}
   if(kind<3||handler.desc!=&error||(int64_t)OBJ(handler.value)->f[0]!=(code<0?GRPC_UNAVAILABLE:code)||strcmp(STR(OBJ(handler.value)->f[1])->d,message))return 3;
   FWP_KEEP_ALIVE(handler.value);
  }else{
   if(kind>=3)return 4;
   const char *expected=kind==1?"decoder trap":kind==2?"service call probe (local) failed: gRPC status 7: denied":"service call probe (local) failed: transport failure";
   if(strcmp(fwp_trap_msg,expected))return 5;
  }
  fwp_handlers=0;fwp_trap_recover=0;fwp_trap_jb=0;
  if(text_frees!=1||watched_text||fwp_cleanups)return 1;
 }
 fwp_lib_finish();return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("grpc-client-failure-text").unwrap();
    let exe = dir.join("probe");
    let cleanup = "fwp_cleanup_push(&failure_text, fwp_tls_subject_free, text);";
    assert_eq!(generated.matches(cleanup).count(), 1);
    let omitted = generated.replacen(
        cleanup,
        "fwp_cleanup_push(&failure_text, no_release, text);",
        1,
    );
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{hooks}\n{omitted}\n{fixture}"), &exe, opt).unwrap();
        let out = Command::new(&exe).env("FWP_GC", "off").output().unwrap();
        assert_eq!(out.status.code(), Some(1), "omitted cleanup: {out:?}");
        fwp::cgen::compile_c(&format!("{hooks}\n{generated}\n{fixture}"), &exe, opt).unwrap();
        for gc in ["off", "on"] {
            for poison in ["0", "1"] {
                let out = Command::new(&exe)
                    .env("FWP_GC", gc)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison)
                    .output()
                    .unwrap();
                assert!(out.status.success(), "{opt}/{gc}/{poison}: {out:?}");
            }
        }
    }
}
