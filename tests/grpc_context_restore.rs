//! Dynamic gRPC context is restored on normal, typed, trap and cancellation paths.
use fwp::ir::*;
use std::process::Command;

#[test]
fn grpc_context_restores_on_nested_failures_and_cancelled_callbacks() {
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
    let (generated, _) = fwp::cgen::generate_library(&program, "grpc_context").unwrap();
    let start = generated.find("static V g_with_ctx(").unwrap();
    let end = start
        + generated[start..]
            .find("\nstatic V fwp_p_grpc_with_metadata")
            .unwrap();
    let mut method = generated[start..end].to_owned();
    let callback = "V r = fwp_apply1(f, FWP_UNIT);";
    assert_eq!(method.matches(callback).count(), 1);
    method = method.replacen(callback, "V r = observed_callback(f);", 1);
    let generated = format!("{}{}{}", &generated[..start], method, &generated[end..]);
    let hooks = r#"
#include <stdint.h>
static int stage,depth,entered,cancelled,typed,trapped;
static void *prior_context,*inner_context,*nested_context;
static uintptr_t observed_callback(uintptr_t);
static void no_restore(void *);
"#;
    let fixture = r#"
static const fwp_desc string_descriptor={.kind=K_STR,.name="String"};
static void no_restore(void *p){(void)p;}
static uintptr_t observed_callback(uintptr_t f){
 if(g_ctx_of()!=(depth?nested_context:inner_context))_Exit(10);
 if((stage==4||stage==5)&&!depth){depth=1;return g_with_ctx(nested_context,f);}
 if(stage==1||stage==5)fwp_fail(fwp_cstr("typed failure"),&string_descriptor);
 if(stage==2||stage==4)fwp_trap("context trap");
 if(stage==3){entered=1;fwp_park(0,0);fwp_check_cancel();_Exit(11);}
 return 42;
}
static void call(void *arg,int stop){
 if(stop){cancelled++;if(fwp_cur->gctx!=prior_context)_Exit(1);return;}
 jmp_buf failed;jmp_buf *saved=fwp_cur->trap_jb;fwp_cleanup *saved_cleanup=fwp_cur->trap_cleanup;
 fwp_handler handler={0};handler.prev=fwp_handlers;handler.cleanup=fwp_cleanups;handler.state_depth=fwp_state_len;fwp_handlers=&handler;
 if(!setjmp(failed)){
  if(!setjmp(handler.jb)){
   fwp_cur->trap_jb=&failed;fwp_cur->trap_cleanup=fwp_cleanups;
   if(g_with_ctx(inner_context,0)!=42||stage)_Exit(12);
  }else{typed++;if(handler.desc!=&string_descriptor||strcmp(STR(handler.value)->d,"typed failure"))_Exit(13);FWP_KEEP_ALIVE(handler.value);}
 }else{trapped++;if(strcmp(fwp_trap_msg,"context trap"))_Exit(14);}
 fwp_handlers=handler.prev;fwp_cur->trap_jb=saved;fwp_cur->trap_cleanup=saved_cleanup;
 if(fwp_cur->gctx!=prior_context||fwp_cleanups)_Exit(1);
}
int main(void){
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));fwp_tasks_init();fwp_trap_recover=g_trap_recover;
 g_ctx before={0},inside={0},nested={0};before.deadline=1;inside.deadline=2;nested.deadline=3;
 prior_context=&before;inner_context=&inside;nested_context=&nested;fwp_cur->gctx=&before;
 for(stage=0;stage<6;stage++){
  depth=entered=cancelled=typed=trapped=0;fwp_task *task=fwp_spawn_task(0,call,0,0,0);
  if(stage==3){fwp_p_task_yield();if(!entered||task->done||task->gctx!=inner_context)return 2;fwp_p_task_cancel(PTR(task));}
  fwp_await(task);
  if(!task->done||task->gctx!=prior_context||fwp_cur->gctx!=prior_context||cancelled!=(stage==3)||typed!=(stage==1||stage==5)||trapped!=(stage==2||stage==4)||fwp_cleanups)return 1;
  FWP_KEEP_ALIVE(PTR(task));
 }
 fwp_cur->gctx=0;fwp_lib_finish();return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("grpc-context-restore").unwrap();
    let exe = dir.join("probe");
    let cleanup = "fwp_cleanup_push(&context_cleanup, g_context_restore, &owner);";
    assert_eq!(generated.matches(cleanup).count(), 1);
    let omitted = generated.replacen(
        cleanup,
        "fwp_cleanup_push(&context_cleanup,no_restore,&owner);",
        1,
    );
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{hooks}\n{omitted}\n{fixture}"), &exe, opt).unwrap();
        let out = Command::new(&exe).env("FWP_GC", "off").output().unwrap();
        assert_eq!(
            out.status.code(),
            Some(1),
            "omitted context restore: {out:?}"
        );
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
