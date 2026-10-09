//! Dequeued server requests and copied receive statuses have exceptional owners.
use fwp::ir::*;
use std::process::Command;

#[test]
fn received_requests_and_statuses_release_on_errors_and_cancelled_waits() {
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
    let (generated, _) = fwp::cgen::generate_library(&program, "grpc_receive").unwrap();
    let hooks = r#"
#include <stdlib.h>
#include <string.h>
static int stage,allocations,frees,cancelled;
static void *owned[16];
static char *observed_strdup(const char *);
static void observed_free(void *);
static void no_release(void *);
#define strdup(p) observed_strdup(p)
#define free(p) observed_free(p)
"#;
    let fixture = r#"
#undef strdup
#undef free
static void remember(void *p){if(!p||allocations==16)_Exit(30);owned[allocations++]=p;}
static char *observed_strdup(const char *p){char *copy=strdup(p);remember(copy);return copy;}
static void observed_free(void *p){if(p)for(int i=0;i<allocations;i++)if(owned[i]==p){owned[i]=0;frees++;break;}free(p);}
static void no_release(void *p){(void)p;}
static g_msg *message(void){g_msg *m=malloc(sizeof *m+3);if(!m)_Exit(31);memset(m,0,sizeof *m);m->n=3;m->d[0]=0;m->d[1]=255;m->d[2]=128;remember(m);return m;}
static void receive(void *arg,int stop){
 if(stop){cancelled++;return;}
 g_job *j=arg;int code=0;char *text=0;
 if(stage==7){if(g_reflect(j,&text)!=-1||text)_Exit(2);return;}
 g_msg *m=g_recv_one(j,&code,&text);
 if(stage==5||stage==6)_Exit(3);
 if(stage==0){if(!m||m->n!=3||m->d[0]||m->d[1]!=255||m->d[2]!=128||text)_Exit(4);observed_free(m);}
 else{
  const char *expected=stage==1?"expected one request message":stage==2?"missing request message":"bad request";
  if(m||code!=GRPC_INVALID_ARGUMENT||!text||strcmp(text,expected))_Exit(5);
  observed_free(text);
 }
}
int main(void){
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));fwp_tasks_init();
 g_server srv={0};srv.module="probe";g_conn *c=g_conn_new(-1,"local",&srv);
 for(stage=0;stage<8;stage++){
  allocations=frees=cancelled=0;memset(owned,0,sizeof owned);
  g_stream *s=g_stream_new(c,(uint32_t)(1+2*stage));s->remote_end=stage==0||stage==2||stage==7;
  if(stage==0||stage==1||stage==4||stage==5||stage==6){s->mhead=s->mtail=message();}
  if(stage==1){s->mhead->next=message();s->mtail=s->mhead->next;}
  if(stage==3||stage==4)s->bad=strdup("bad request");
  if(stage==6)s->reset=strdup("reset");
  g_job job={0};job.c=c;job.s=s;job.srv=&srv;
  fwp_task *t=fwp_spawn_task(0,receive,&job,0,0);
  if(stage==5){fwp_p_task_yield();if(t->done||frees||s->mhead)_Exit(6);fwp_p_task_cancel(PTR(t));}
  fwp_await(t);
  int expected=stage==0?2:stage==1?3:stage==2?2:stage==3?1:stage==4?2:stage==5?1:stage==6?2:1;
  if(!t->done||allocations!=expected||frees!=expected||cancelled!=(stage==5||stage==6)||fwp_cleanups)return 1;
  FWP_KEEP_ALIVE(PTR(t));FWP_KEEP_ALIVE(PTR(s));FWP_KEEP_ALIVE(PTR(c));
 }
 FWP_KEEP_ALIVE(PTR(c));fwp_lib_finish();return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("grpc-receive-cleanup").unwrap();
    let exe = dir.join("probe");
    let first = "fwp_cleanup_push(&first_cleanup, g_got_release, &g);";
    assert_eq!(generated.matches(first).count(), 1);
    let unwind_omitted = generated.replacen(
        first,
        "fwp_cleanup_push(&first_cleanup, no_release, &g);",
        1,
    );
    let release = "    free(g->m);";
    assert_eq!(generated.matches(release).count(), 1);
    let request_omitted = generated.replacen(release, "    no_release(g->m);", 1);
    let reflection = "if (g.kind == G_END) { free(g.text); return -1; }";
    assert_eq!(generated.matches(reflection).count(), 1);
    let reflection_omitted = generated.replacen(reflection, "if (g.kind == G_END) return -1;", 1);
    for opt in ["-O1", "-O2"] {
        for broken in [&unwind_omitted, &request_omitted, &reflection_omitted] {
            fwp::cgen::compile_c(&format!("{hooks}\n{broken}\n{fixture}"), &exe, opt).unwrap();
            let out = Command::new(&exe).env("FWP_GC", "off").output().unwrap();
            assert_eq!(out.status.code(), Some(1), "omitted release: {out:?}");
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
}
