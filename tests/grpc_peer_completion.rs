//! Served peer metadata lasts through child joins and releases without collection.
use fwp::ir::*;
use std::process::Command;

#[test]
fn serving_peer_owner_survives_children_and_releases_at_completion() {
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
    let (generated, _) = fwp::cgen::generate_library(&program, "grpc_peer").unwrap();
    let subject = "j->sv.peer = c->ssl ? fwp_tls_peer_subject(c->ssl) : 0;";
    let handle = "    g_job *j = (g_job *)arg;\n    int code = -1;";
    let spawn = "    s->task = fwp_spawn_task(0, g_handle, j, g_parse_timeout(h2_get(&s->headers, \"grpc-timeout\")), 0);";
    for needle in [subject, handle, spawn] {
        assert_eq!(generated.matches(needle).count(), 1);
    }
    let generated = generated
        .replacen(subject, "j->sv.peer = c->ssl ? observed_subject() : 0;", 1)
        .replacen(handle, "    g_job *j = (g_job *)arg;\n    if(!cancelled){fwp_spawn_task(0,peer_child,0,0,0);if(stage==5||stage==6)g_spawn_sender(j->c,j->s,0,0,0);if(stage==1){fwp_cancel_tree(fwp_cur);fwp_check_cancel();}}\n    int code = -1;", 1)
        .replacen(spawn, &format!("    if(stage==2)fwp_trap(\"call preparation\");\n{spawn}"), 1);
    let sender_spawn = "    fwp_task *t = fwp_spawn_task(0, g_send_all, x, 0, 1);";
    assert_eq!(generated.matches(sender_spawn).count(), 1);
    let generated = generated.replacen(
        sender_spawn,
        &format!(
            "    if(stage==6){{fwp_cancel_tree(fwp_cur);fwp_check_cancel();}}\n{sender_spawn}"
        ),
        1,
    );
    let sender = "    g_sender *x = (g_sender *)arg;\n    if (cancelled) return;";
    assert_eq!(generated.matches(sender).count(), 1);
    let generated = generated.replacen(sender,
        "    g_sender *x = (g_sender *)arg;\n    observed_sender = fwp_cur; while(!x->serving->task->done) fwp_park(0,fwp_now_ns()+1); peer_child(0,cancelled); return;", 1);
    let hooks = r#"
#include <stdint.h>
#include <stdlib.h>
static int stage,peer_frees,children;
static void *peer_buffer,*observed_sender;
static char *observed_subject(void);
static void observed_free(void *);
static void peer_child(void *,int);
#define free(p) observed_free(p)
"#;
    let fixture = r#"
#undef free
static void observed_free(void *p){if(p&&p==peer_buffer){peer_frees++;peer_buffer=0;}free(p);}
static char *observed_subject(void){if(stage==3)return 0;peer_buffer=malloc(11);if(!peer_buffer)_Exit(30);memcpy(peer_buffer,"CN=runtime",11);return peer_buffer;}
static void peer_child(void *arg,int cancelled){
 (void)arg;(void)cancelled;
 if(peer_frees)_Exit(1);
 V subject=fwp_p_grpc_peer_subject();
 if(stage<3||stage>=5){if(subject==FWP_NONE||strcmp(STR(OBJ(subject)->f[0])->d,"CN=runtime"))_Exit(2);}
 else if(subject!=FWP_NONE)_Exit(3);
 children++;
}
static jmp_buf failure;
static int recover(void){return 1;}
int main(void){
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));fwp_tasks_init();
 SSL_CTX *tls=SSL_CTX_new(TLS_client_method());if(!tls)return 31;
 SSL *ssl=SSL_new(tls);SSL_CTX_free(tls);if(!ssl)return 32;
 g_server srv={0};srv.module="probe";
 g_conn *c=g_conn_new(-1,"local",&srv);c->ssl=ssl;
 for(stage=0;stage<7;stage++){
  peer_buffer=observed_sender=0;peer_frees=children=0;c->ssl=stage==4?0:ssl;
  g_stream *s=g_stream_new(c,(uint32_t)(1+2*stage));s->remote_end=1;
  if(stage==2){
   fwp_trap_recover=recover;fwp_trap_jb=&failure;fwp_trap_cleanup=0;
   if(!setjmp(failure)){g_start_call(c,s);return 4;}
   fwp_trap_recover=0;fwp_trap_jb=0;
   if(peer_frees!=1||children||s->task||fwp_cleanups)return 5;
   g_unlink(c,s);
  }else{
   g_start_call(c,s);fwp_task *t=s->task;g_job *j=(g_job *)t->carg;
   if(peer_frees||t->done)return 6;
   fwp_tasks_finish();
   if(stage==5){
    if(!t->done||t->cfinish||!j->sv.peer||j->sv.peer_users!=1||children!=1||peer_frees||!observed_sender)return 8;
    fwp_await((fwp_task *)observed_sender);
    if(j->sv.peer||j->sv.peer_users||children!=2||peer_frees!=1)return 9;
   }else if(!t->done||t->cfinish||j->sv.peer||children!=1||peer_frees!=((stage<3||stage==6)?1:0)||fwp_cleanups)return 7;
   FWP_KEEP_ALIVE(PTR(t));
  }
  FWP_KEEP_ALIVE(PTR(s));FWP_KEEP_ALIVE(PTR(c));
 }
 // Overflow fails before acquiring a sender owner or publishing a task.
 g_serving sv={0};g_ctx context={0};stage=7;peer_frees=0;
 sv.peer=observed_subject();sv.peer_users=SIZE_MAX;context.serving=&sv;
 fwp_cur->gctx=&context;fwp_trap_recover=recover;fwp_trap_jb=&failure;fwp_trap_cleanup=0;
 if(!setjmp(failure)){g_spawn_sender(c,0,0,0,0);return 10;}
 fwp_trap_recover=0;fwp_trap_jb=0;fwp_cur->gctx=0;
 if(sv.peer_users!=SIZE_MAX||peer_frees||fwp_cleanups)return 11;
 sv.peer_users=1;g_serving_peer_release(&sv);if(sv.peer||peer_frees!=1)return 12;
 c->ssl=ssl;FWP_KEEP_ALIVE(PTR(c));fwp_lib_finish();return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("grpc-peer-completion").unwrap();
    let exe = dir.join("probe");
    let completion = "    s->task->cfinish = g_job_peer_finish;";
    assert_eq!(generated.matches(completion).count(), 1);
    let omitted = generated.replacen(completion, "", 1);
    let early = generated.replacen(completion, "    g_job_peer_finish(j);", 1);
    let sender_completion = "    t->cfinish = g_sender_peer_finish;";
    assert_eq!(generated.matches(sender_completion).count(), 1);
    let sender_omitted = generated.replacen(sender_completion, "", 1);
    for opt in ["-O1", "-O2"] {
        for (broken, codes) in [
            (&omitted, &[7][..]),
            (&early, &[1, 6][..]),
            (&sender_omitted, &[9][..]),
        ] {
            fwp::cgen::compile_c(&format!("{hooks}\n{broken}\n{fixture}"), &exe, opt).unwrap();
            let out = Command::new(&exe).env("FWP_GC", "off").output().unwrap();
            assert!(
                out.status.code().is_some_and(|code| codes.contains(&code)),
                "omitted/early release: {out:?}"
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
}
