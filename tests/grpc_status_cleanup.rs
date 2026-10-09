//! Final served status strings own their malloc storage through encoding and unwind.
use fwp::ir::*;
use std::process::Command;

#[test]
fn served_status_messages_release_after_encoding_and_on_cancellation() {
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
    let (generated, _) = fwp::cgen::generate_library(&program, "grpc_status").unwrap();
    let finish = "    g_finish(j->c, j->s, code, msg);";
    assert_eq!(generated.matches(finish).count(), 1);
    let generated = generated.replacen(finish,
        &format!("    if(stage==5&&!cancelled){{fwp_cancel_tree(fwp_cur);fwp_check_cancel();}}\n{finish}"), 1);
    let hooks = r#"
#include <stdlib.h>
#include <string.h>
static int stage,allocations,frees,fail_copy;
static void *messages[16];
static char *observed_strdup(const char *);
static void observed_free(void *);
static void no_free(void *);
#define strdup(p) observed_strdup(p)
#define free(p) observed_free(p)
"#;
    let fixture = r#"
#undef strdup
#undef free
static char *observed_strdup(const char *p){
 if(fail_copy){if(allocations!=1||frees||!messages[0])_Exit(33);return 0;}
 char *s=strdup(p);if(!s)_Exit(30);
 if(!strncmp(p,"unknown method",14)||!strcmp(p,"cancelled")||!strcmp(p,"deadline exceeded")||!strcmp(p,"explicit status")){
  if(allocations==16)_Exit(31);messages[allocations++]=s;
 }return s;
}
static void observed_free(void *p){
 if(p)for(int i=0;i<allocations;i++)if(messages[i]==p){messages[i]=0;frees++;break;}
 free(p);
}
static void no_free(void *p){(void)p;}
static jmp_buf failure;
static int recover(void){return 1;}
int main(int argc,char **argv){
 (void)argv;
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));fwp_tasks_init();
 g_server srv={0};srv.module="probe";g_conn *c=g_conn_new(-1,"local",&srv);
 if(argc>1){
  g_serving sv={0};g_ctx ctx={0};ctx.serving=&sv;sv.task=fwp_cur;
  sv.msg=observed_strdup("explicit status");fwp_cur->gctx=&ctx;fail_copy=1;
  g_fail_call(GRPC_INVALID_ARGUMENT,sv.msg);return 34;
 }
 for(stage=0;stage<6;stage++){
  allocations=frees=0;memset(messages,0,sizeof messages);c->out.len=0;
  g_stream *s=g_stream_new(c,(uint32_t)(1+2*stage));s->remote_end=1;
  g_job job={0};job.c=c;job.s=s;job.srv=&srv;job.sv.code=-1;
  if(stage==1){job.sv.code=GRPC_INVALID_ARGUMENT;job.sv.msg=observed_strdup("explicit status");}
  if(stage==2)fwp_cur->deadline=fwp_now_ns()-1;
  if(stage==3)s->reset=strdup("closed");
  if(stage==5){
   // Actual task cancellation unwinds the first final status then encodes cancellation.
   g_start_call(c,s);fwp_tasks_finish();if(!s->task->done)return 1;
  }else g_handle(&job,stage!=0);
  fwp_cur->deadline=0;
  int expected=stage==3?0:stage==5?2:1;
  if(allocations!=expected||frees!=expected||job.sv.msg||fwp_cleanups)return 2;
  if(stage!=3){
   const char *expected_text=stage==0?"unknown method ":stage==1?"explicit status":stage==2?"deadline exceeded":"cancelled";
   size_t n=strlen(expected_text);int found=0;
   for(size_t i=0;i+n<=c->out.len;i++)if(!memcmp(c->out.d+i,expected_text,n)){found=1;break;}
   if(!found)return 3;
  }
  FWP_KEEP_ALIVE(PTR(s));FWP_KEEP_ALIVE(PTR(c));
 }
 // Replacing cancellation status copies before dropping an aliased old message.
 allocations=frees=0;memset(messages,0,sizeof messages);stage=6;
 g_serving sv={0};g_ctx context={0};context.serving=&sv;sv.task=fwp_cur;sv.peer_users=2;
 sv.msg=observed_strdup("explicit status");fwp_cur->gctx=&context;
 for(int i=0;i<2;i++){
  fwp_cur->unwinding=1;fwp_trap_recover=recover;fwp_trap_jb=&failure;fwp_trap_cleanup=0;
  if(!setjmp(failure)){g_fail_call(GRPC_INVALID_ARGUMENT,sv.msg);return 4;}
  fwp_trap_recover=0;fwp_trap_jb=0;fwp_cur->cancelled=0;
  if(strcmp(sv.msg,"explicit status")||strcmp(fwp_trap_msg,"explicit status")||frees!=i+1)return 5;
 }
 fwp_cur->unwinding=0;fwp_cur->gctx=0;
 g_serving_peer_release(&sv);if(!sv.msg||frees!=2)return 6;
 g_serving_peer_release(&sv);if(sv.msg||frees!=3||allocations!=3)return 7;
 FWP_KEEP_ALIVE(PTR(c));fwp_lib_finish();return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("grpc-status-cleanup").unwrap();
    let exe = dir.join("probe");
    let release = "    fwp_tls_subject_free(msg);";
    assert_eq!(generated.matches(release).count(), 1);
    let omitted = generated.replacen(release, "    no_free(msg);", 1);
    let unwind = "fwp_cleanup_push(&message_cleanup, fwp_tls_subject_free, msg);";
    assert_eq!(generated.matches(unwind).count(), 1);
    let unwind_omitted = generated.replacen(
        unwind,
        "fwp_cleanup_push(&message_cleanup, no_free, msg);",
        1,
    );
    for opt in ["-O1", "-O2"] {
        for broken in [&omitted, &unwind_omitted] {
            fwp::cgen::compile_c(&format!("{hooks}\n{broken}\n{fixture}"), &exe, opt).unwrap();
            let out = Command::new(&exe).env("FWP_GC", "off").output().unwrap();
            assert_eq!(out.status.code(), Some(2), "omitted release: {out:?}");
        }
        fwp::cgen::compile_c(&format!("{hooks}\n{generated}\n{fixture}"), &exe, opt).unwrap();
        let out = Command::new(&exe)
            .arg("allocation-failure")
            .output()
            .unwrap();
        assert_eq!(out.status.code(), Some(102), "failed status copy: {out:?}");
        assert_eq!(out.stderr, b"fwp: out of memory\n");
        assert!(out.stdout.is_empty());
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
