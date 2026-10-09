//! Response capture outlives its callback when a task inherits the context.
use fwp::ir::*;
use std::process::Command;

#[test]
fn metadata_capture_releases_after_callbacks_and_escaped_tasks() {
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
    let (generated, _) = fwp::cgen::generate_library(&program, "grpc_capture").unwrap();
    assert!(generated.contains("#define FWP_GCTX_OWNERS 1"));
    let mut generated = generated;
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
    generated = generated.replacen(
        "    owner->users = 1;",
        "    owner->users = 1; remember_capture(owner);",
        1,
    );
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
    let prepare = "    fwp_scope *s = detached ? 0 : fwp_cur->scope;";
    assert_eq!(generated.matches(prepare).count(), 1);
    generated = generated.replacen(prepare, "    if(fail_spawn&&t->cfn==child){fail_spawn=0;fwp_trap(\"child prepare trap\");}\n    fwp_scope *s = detached ? 0 : fwp_cur->scope;", 1);
    let hooks = r#"
#include <stdlib.h>
#include <stdint.h>
static int stage,frees,entered,cancelled,trapped,typed,scope_returned,fail_spawn,nested;
static void *watched,*spawned;
static uintptr_t snapshot;
static void *tls_objects[6];static int tls_frees;
static void remember_tls(void *);
static void remember_capture(void *);
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
static void remember_capture(void *p){if(!nested)watched=p;}
static void remember_tls(void *p){g_tls *t=p;tls_objects[0]=t;tls_objects[1]=t->ca;tls_objects[2]=t->name;tls_objects[3]=t->cert;tls_objects[4]=t->keyfile;tls_objects[5]=t->key;}
static void observed_free(void *p){if(p&&p==watched){watched=0;frees++;}if(p)for(int i=0;i<6;i++)if(tls_objects[i]==p){tls_objects[i]=0;tls_frees++;break;}free(p);}
static void check_capture(void){g_ctx *ctx=g_ctx_of();if(!ctx->capture_owner||ctx->capture!=&ctx->capture_owner->headers||(!nested&&ctx->capture_owner!=watched)||frees)_Exit(10);}
static void overflow_restore(void *p){g_capture *cap=p;if(cap->users!=SIZE_MAX)_Exit(11);cap->users=2;}
static void child(void *arg,int stop){
 if(stop){cancelled++;return;}
 check_capture();if(!scope_returned)_Exit(12);
 if(stage==5){entered=1;fwp_park(0,0);fwp_check_cancel();check_capture();}
 h2_hdrs *cap=g_ctx_of()->capture;if(cap->n!=1||strcmp(cap->v[0].value,"before"))_Exit(13);
 h2_hdrs_add(cap,"x",1,"after",5);
 size_t n;V *items=fwp_list_items(OBJ(snapshot)->f[1],&n);
 if(n!=1||strcmp(STR(OBJ(items[0])->f[1])->d,"before"))_Exit(14);
 if(stage==8)fwp_cur->gctx=&g_empty_ctx;
}
static uintptr_t observed_callback(uintptr_t f){
 check_capture();
 if(nested){h2_hdrs_add(g_ctx_of()->capture,"x",1,"before",6);return 42;}
 if(stage==9){nested=1;V r=fwp_p_grpc_with_response_metadata(0);nested=0;if(OBJ(r)->f[0]!=42||g_ctx_of()->capture->n!=1)_Exit(15);return 42;}
 h2_hdrs_add(g_ctx_of()->capture,"x",1,"before",6);
 if(stage==1)fwp_fail(fwp_cstr("capture typed failure"),&string_descriptor);
 if(stage==2)fwp_trap("capture scope trap");
 if(stage==3){entered=1;fwp_park(0,0);fwp_check_cancel();_Exit(16);}
 if(stage==4||stage==5||stage==6||stage==7||stage==8){
  fwp_cleanup overflow_cleanup;if(stage==7){((g_capture*)watched)->users=SIZE_MAX;fwp_cleanup_push(&overflow_cleanup,overflow_restore,watched);}
  fail_spawn=stage==6;spawned=fwp_spawn_task(0,child,0,0,stage==5);
  if(stage==6||stage==7)_Exit(17);
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
   snapshot=fwp_p_grpc_with_response_metadata(0);scope_returned=1;
   size_t n;V *items=fwp_list_items(OBJ(snapshot)->f[1],&n);
   if(OBJ(snapshot)->f[0]!=42||n!=1||strcmp(STR(OBJ(items[0])->f[1])->d,"before"))_Exit(18);
   if(frees!=(stage==4||stage==5||stage==8?0:1))_Exit(1);
  }else{typed++;if(handler.desc!=&string_descriptor||strcmp(STR(handler.value)->d,"capture typed failure"))_Exit(19);FWP_KEEP_ALIVE(handler.value);}
 }else{trapped++;const char *expected=stage==6?"child prepare trap":stage==7?"too many metadata capture owners":"capture scope trap";if(strcmp(fwp_trap_msg,expected))_Exit(20);}
 fwp_handlers=handler.prev;fwp_cur->trap_jb=saved;fwp_cur->trap_cleanup=saved_cleanup;
 if(fwp_cur->gctx||fwp_cleanups)_Exit(1);
}
int main(void){
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));fwp_tasks_init();fwp_trap_recover=g_trap_recover;
 for(stage=0;stage<10;stage++){
  frees=entered=cancelled=trapped=typed=scope_returned=fail_spawn=nested=0;watched=spawned=0;snapshot=0;
  fwp_task *task=fwp_spawn_task(0,call,0,0,0);
  if(stage==3){fwp_p_task_yield();if(!entered||task->done||frees)return 2;fwp_p_task_cancel(PTR(task));}
  fwp_await(task);
  if(stage==5){if(frees||!spawned||!entered||((fwp_task*)spawned)->done)return 3;fwp_make_ready(spawned);fwp_await(spawned);}
  if(!task->done||frees!=1||fwp_cleanups||cancelled!=(stage==3)||typed!=(stage==1)||trapped!=(stage==2||stage==6||stage==7)||task->gctx_owner)return 1;
  FWP_KEEP_ALIVE(PTR(task));FWP_KEEP_ALIVE(PTR(spawned));FWP_KEEP_ALIVE(snapshot);
 }
 // Failure to acquire capture ownership must not partially retain TLS options.
 g_tls *tls=g_tls_new("",0,"","","");tls->users=1;
 g_capture cap={0};cap.users=SIZE_MAX;g_ctx context={0};context.tls=tls;context.capture_owner=&cap;
 jmp_buf failed;fwp_cur->trap_jb=&failed;fwp_cur->trap_cleanup=fwp_cleanups;
 if(!setjmp(failed)){g_context_acquire(&context);return 4;}
 if(tls->users!=1||cap.users!=SIZE_MAX||strcmp(fwp_trap_msg,"too many metadata capture owners"))return 5;
 g_tls_release(tls);if(tls_frees!=6)return 6;
 // Constructor ownership protects freshly copied TLS options when capture acquisition traps.
 tls_frees=0;V fields[5]={FWP_NONE,FWP_FALSE,FWP_NONE,FWP_NONE,FWP_NONE};V options=fwp_record(5,fields);
 context.tls=0;fwp_cur->gctx=&context;
 if(!setjmp(failed)){fwp_p_grpc_with_tls(options,0,0,1,2,3,4);return 7;}
 if(tls_frees!=6||cap.users!=SIZE_MAX||fwp_cleanups||strcmp(fwp_trap_msg,"too many metadata capture owners"))return 8;
 fwp_cur->gctx=0;fwp_cur->trap_jb=0;FWP_KEEP_ALIVE(options);
 fwp_lib_finish();return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("grpc-capture-resources").unwrap();
    let exe = dir.join("probe");
    let finish = "fwp_gctx_release(held);";
    let pending = "fwp_gctx_release(*held);";
    let scope = "if (owner->held) { g_context_release(owner->held); owner->held = 0; }";
    for needle in [finish, pending, scope] {
        assert_eq!(generated.matches(needle).count(), 1);
    }
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
            assert_eq!(out.status.code(), Some(1), "omitted capture owner: {out:?}");
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
