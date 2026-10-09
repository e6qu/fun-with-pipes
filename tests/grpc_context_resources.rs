//! Scoped TLS options have explicit dynamic-scope and inheriting-task owners.
use fwp::ir::*;
use std::process::Command;

#[test]
fn scoped_tls_options_release_after_callbacks_and_escaped_tasks() {
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
    let (generated, _) = fwp::cgen::generate_library(&program, "grpc_resources").unwrap();
    assert!(generated.contains("#define FWP_GCTX_OWNERS 1"));
    let mut generated = generated;
    let start = generated.find("static g_tls *g_tls_new(").unwrap();
    let end = start + generated[start..].find("\n/* the TLS options").unwrap();
    let constructor =
        generated[start..end].replace("    return t;", "    remember_tls(t); return t;");
    generated = format!(
        "{}{}{}",
        &generated[..start],
        constructor,
        &generated[end..]
    );
    let start = generated.find("static V g_with_ctx(").unwrap();
    let end = start
        + generated[start..]
            .find("\nstatic V fwp_p_grpc_with_metadata")
            .unwrap();
    let method = generated[start..end].replace(
        "V r = fwp_apply1(f, FWP_UNIT);",
        "V r = observed_callback(f);",
    );
    generated = format!("{}{}{}", &generated[..start], method, &generated[end..]);
    let prepare = "    fwp_scope *s = detached ? 0 : fwp_cur->scope;";
    assert_eq!(generated.matches(prepare).count(), 1);
    generated=generated.replacen(prepare,"    if(fail_spawn&&t->cfn==child){fail_spawn=0;fwp_trap(\"child prepare trap\");}\n    fwp_scope *s = detached ? 0 : fwp_cur->scope;",1);
    let hooks = r#"
#include <stdlib.h>
#include <stdint.h>
static int stage,frees,entered,cancelled,trapped,typed,scope_returned,fail_spawn;
static void *owned[1],*watched_tls,*spawned;
static void remember_tls(void *);
static void observed_free(void *);
static uintptr_t observed_callback(uintptr_t);
static void child(void *,int);
static void no_release(void *);
#define free(p) observed_free(p)
"#;
    let fixture = r#"
#undef free
static const fwp_desc string_descriptor={.kind=K_STR,.name="String"};
static void no_release(void *p){(void)p;}
static void remember_tls(void *p){g_tls *t=p;watched_tls=t;owned[0]=t;}
static void observed_free(void *p){if(p)for(int i=0;i<1;i++)if(owned[i]==p){owned[i]=0;frees++;break;}free(p);}
static void check_options(void){const g_tls *t=g_ctx_of()->tls;if(t!=watched_tls||strcmp(t->ca,"ca")||strcmp(t->name,"name")||strcmp(t->cert,"cert")||strcmp(t->keyfile,"key")||!t->insecure||frees)_Exit(10);}
static void overflow_restore(void *p){g_tls *t=p;if(t->users!=SIZE_MAX-1)_Exit(11);t->users=2;}
static void child(void *arg,int stop){
 if(stop){cancelled++;return;}
 check_options();if(!scope_returned)_Exit(12);
 if(stage==5){entered=1;fwp_park(0,0);fwp_check_cancel();check_options();}
 if(stage==8)fwp_cur->gctx=&g_empty_ctx;
}
static uintptr_t observed_callback(uintptr_t f){
 check_options();
 if(stage==1)fwp_fail(fwp_cstr("TLS typed failure"),&string_descriptor);
 if(stage==2)fwp_trap("TLS scope trap");
 if(stage==3){entered=1;fwp_park(0,0);fwp_check_cancel();_Exit(13);}
 if(stage==4||stage==5||stage==6||stage==7||stage==8){
  fwp_cleanup overflow_cleanup;if(stage==7){((g_tls*)watched_tls)->users=SIZE_MAX-1;fwp_cleanup_push(&overflow_cleanup,overflow_restore,watched_tls);}
  fail_spawn=stage==6;spawned=fwp_spawn_task(0,child,0,0,stage==5);
  if(stage==6||stage==7)_Exit(14);
 }
 return 42;
}
static void call(void *arg,int stop){
 if(stop){cancelled++;if(fwp_cur->gctx||frees!=1)_Exit(1);return;}
 jmp_buf failed;jmp_buf *saved=fwp_cur->trap_jb;fwp_cleanup *saved_cleanup=fwp_cur->trap_cleanup;
 fwp_handler handler={0};handler.prev=fwp_handlers;handler.cleanup=fwp_cleanups;handler.state_depth=fwp_state_len;fwp_handlers=&handler;
 if(!setjmp(failed)){
  if(!setjmp(handler.jb)){
   fwp_cur->trap_jb=&failed;fwp_cur->trap_cleanup=fwp_cleanups;
   if(fwp_p_grpc_with_tls(PTR(arg),0,0,1,2,3,4)!=42)_Exit(15);scope_returned=1;
   if(frees!=(stage==4||stage==5||stage==8?0:1))_Exit(1);
  }else{typed++;if(handler.desc!=&string_descriptor||strcmp(STR(handler.value)->d,"TLS typed failure"))_Exit(16);FWP_KEEP_ALIVE(handler.value);}
 }else{trapped++;const char *expected=stage==6?"child prepare trap":stage==7?"too many TLS option owners":"TLS scope trap";if(strcmp(fwp_trap_msg,expected))_Exit(17);}
 fwp_handlers=handler.prev;fwp_cur->trap_jb=saved;fwp_cur->trap_cleanup=saved_cleanup;
 if(fwp_cur->gctx||fwp_cleanups)_Exit(1);
}
int main(void){
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));fwp_tasks_init();fwp_trap_recover=g_trap_recover;
 for(stage=0;stage<9;stage++){
  frees=entered=cancelled=trapped=typed=scope_returned=fail_spawn=0;memset(owned,0,sizeof owned);watched_tls=spawned=0;
  V fields[5];fields[0]=fwp_some(fwp_cstr("ca"));fields[1]=FWP_TRUE;fields[2]=fwp_some(fwp_cstr("name"));fields[3]=fwp_some(fwp_cstr("cert"));fields[4]=fwp_some(fwp_cstr("key"));V options=fwp_record(5,fields);
  fwp_task *task=fwp_spawn_task(0,call,(void*)(uintptr_t)options,0,0);
  if(stage==3){fwp_p_task_yield();if(!entered||task->done||frees)return 2;fwp_p_task_cancel(PTR(task));}
  fwp_await(task);
  if(stage==5){if(frees||!spawned||!entered||((fwp_task*)spawned)->done)return 3;fwp_make_ready(spawned);fwp_await(spawned);}
  if(!task->done||frees!=1||fwp_cleanups||cancelled!=(stage==3)||typed!=(stage==1)||trapped!=(stage==2||stage==6||stage==7)||task->gctx_owner)return 1;
  FWP_KEEP_ALIVE(options);FWP_KEEP_ALIVE(PTR(task));FWP_KEEP_ALIVE(PTR(spawned));
 }
 // Read-once cache options retain their original cache lifetime.
 stage=9;frees=0;g_ctx context={0};context.tls=g_tls_new("ca",1,"name","cert","key");
 if(g_with_ctx(&context,0)!=42||frees||context.tls->users!=SIZE_MAX||g_context_acquire(&context))return 4;
 g_tls *cached=(g_tls*)context.tls;observed_free(cached);if(frees!=1)return 5;
 fwp_lib_finish();return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("grpc-context-resources").unwrap();
    let exe = dir.join("probe");
    let finish = "fwp_gctx_release(held);";
    assert_eq!(generated.matches(finish).count(), 1);
    let pending = "fwp_gctx_release(*held);";
    assert_eq!(generated.matches(pending).count(), 1);
    let scope = "if (owner->held) { g_context_release(owner->held); owner->held = 0; }";
    assert_eq!(generated.matches(scope).count(), 1);
    let controls = [
        generated.replacen(finish, "no_release(held);", 1),
        generated.replacen(pending, "no_release(*held);", 1),
        generated.replacen(
            scope,
            "if(owner->held){no_release(owner->held);owner->held=0;}",
            1,
        ),
    ];
    for opt in ["-O1", "-O2"] {
        for broken in &controls {
            fwp::cgen::compile_c(&format!("{hooks}\n{broken}\n{fixture}"), &exe, opt).unwrap();
            let out = Command::new(&exe).env("FWP_GC", "off").output().unwrap();
            assert_eq!(
                out.status.code(),
                Some(1),
                "omitted resource owner: {out:?}"
            );
        }
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
    let unit = MT::unit();
    let pure = Program {
        funcs: vec![Func {
            name: "yield".into(),
            arity: 1,
            locals: vec![unit.clone()],
            ty: MT::Fun(Box::new(unit.clone()), Box::new(unit)),
            body: Body::Prim("task.yield".into()),
        }],
        exports: vec![("yield".into(), 0)],
        ..Program::default()
    };
    let (plain, _) = fwp::cgen::generate_library(&pure, "plain_tasks").unwrap();
    assert!(!plain.contains("#define FWP_GCTX_OWNERS 1"));
    fwp::cgen::compile_c(
        &format!("{plain}\nint main(void){{fwp_lib_init();fwp_lib_finish();return 0;}}"),
        &exe,
        "-O2",
    )
    .unwrap();
    assert!(Command::new(&exe).status().unwrap().success());
}
