//! Served peer metadata lasts through child joins and releases without collection.
use fwp::ir::*;
use std::process::Command;
#[path = "support/c_instrument.rs"]
mod c_instrument;

#[test]
fn serving_peer_owner_survives_children_and_releases_at_completion() {
    fwp::cgen::set_native_options(fwp::cgen::NativeOptions {
        arc: false,
        ..Default::default()
    });
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
                name: "pooled".into(),
                arity: 1,
                locals: vec![MT::con("std::String")],
                ty: MT::Fun(
                    Box::new(MT::con("std::String")),
                    Box::new(MT::con("std::Bool")),
                ),
                body: Body::Prim("http2.pooled".into()),
            },
        ],
        exports: vec![("available".into(), 0)],
        ..Program::default()
    };
    let (generated, _) = fwp::cgen::generate_library(&program, "grpc_peer", &[]).unwrap();
    let subject = "j->sv.peer = c->ssl ? fwp_tls_peer_subject(c->ssl) : 0;";
    let handle = "    g_job *j = (g_job *)arg;\n    int code = -1;";
    let spawn = "    s->task = fwp_spawn_task(0, g_handle, j, g_parse_timeout(h2_get(&s->headers, \"grpc-timeout\")), 0);";
    for needle in [subject, handle, spawn] {
        assert_eq!(generated.matches(needle).count(), 1);
    }
    let generated = generated
        .replacen("} fwp_remote;", "} fwp_remote;\nstatic void peer_input_drop(V);\nstatic const fwp_remote peer_input_remote={.input_drop=peer_input_drop};", 1)
        .replacen(subject, "j->sv.peer = c->ssl ? observed_subject() : 0;", 1)
        .replacen(handle, "    g_job *j = (g_job *)arg;\n    if(!cancelled){fwp_spawn_task(0,peer_child,0,0,0);if(stage==5||stage==6)g_spawn_sender(j->c,j->s,0,&peer_input_remote);if(stage==1){fwp_cancel_tree(fwp_cur);fwp_check_cancel();}}\n    int code = -1;", 1)
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
        "    g_sender *x = (g_sender *)arg;\n    observed_sender = fwp_cur; while(x->serving->task) fwp_park(0,fwp_now_ns()+1); peer_child(0,cancelled); return;", 1);
    let generated = generated
        .replacen(
            "    g_job *j = (g_job *)fwp_mem_alloc(sizeof *j);",
            "    g_job *j = (g_job *)fwp_mem_alloc(sizeof *j);\n    observed_job=j;",
            1,
        )
        .replacen(
            "    j->sv.task = s->task;",
            "    j->sv.task = s->task;\n    observed_task=s->task;",
            1,
        );
    let disposal = "static void fwp_task_dispose(V value) {";
    assert_eq!(generated.matches(disposal).count(), 1);
    let generated = generated.replacen(disposal,
        "static void fwp_task_dispose(V value) { if((void *)(uintptr_t)value==observed_task)task_disposals++;", 1);
    let generated = c_instrument::calls(&generated, &[("fwp_mem_free", "observed_managed_free")]);
    // The token rewriter also sees function definitions. Keep the real allocator
    // available to cleanup callbacks and to the observation wrapper itself.
    let definition = "static void observed_managed_free(void *p) {";
    assert_eq!(generated.matches(definition).count(), 2);
    let generated = generated.replace(definition, "static void fwp_mem_free(void *p) {");
    let hooks = r#"
#if defined(_WIN32) && !defined(_WIN32_WINNT)
#define _WIN32_WINNT 0x0a00
#endif
#include <stdint.h>
#include <stdlib.h>
static int stage,peer_frees,children,job_frees,task_frees,task_disposals;
static void *peer_buffer,*observed_sender,*observed_job,*observed_task;
static void observed_managed_free(void *);
static char *observed_subject(void);
static void observed_free(void *);
static void peer_child(void *,int);
#define free(p) observed_free(p)
"#;
    let fixture = r#"
#undef free
static void observed_free(void *p){if(p&&p==peer_buffer){if(stage==5&&observed_sender&&children<2)_Exit(39);peer_frees++;peer_buffer=0;}free(p);}
static void observed_managed_free(void *p){
 if(p&&p==observed_job){job_frees++;observed_job=0;}
 if(p&&p==observed_task){fwp_task *t=p;if(!t->done||t->stack||t->gctx)_Exit(38);task_frees++;observed_task=0;}
 fwp_mem_free(p);
}
static char *observed_subject(void){if(stage==3)return 0;peer_buffer=malloc(11);if(!peer_buffer)_Exit(30);memcpy(peer_buffer,"CN=runtime",11);return peer_buffer;}
static const fwp_desc peer_string_type={.kind=K_STR,.drop=fwp_rc_free_obj};
static const fwp_desc *const peer_fields[]={&peer_string_type};
static const fwp_desc *const *const peer_variants[]={NULL,peer_fields};
static const fwp_desc peer_option_type={.kind=K_ADT,.vfields=peer_variants};
static void peer_child(void *arg,int cancelled){
 (void)arg;(void)cancelled;
 if(peer_frees)_Exit(1);
 V subject=fwp_p_grpc_peer_subject(&peer_option_type);
 if(stage<3||stage>=5){if(subject==FWP_NONE||strcmp(STR(OBJ(subject)->f[0])->d,"CN=runtime"))_Exit(2);}
 else if(subject!=FWP_NONE)_Exit(3);
 if(subject){fwp_rc_free_obj(OBJ(subject)->f[0]);fwp_rc_free_obj(subject);}
 children++;
}
static void peer_input_drop(V value){if(value)_Exit(33);}
static jmp_buf failure;
static int recover(void){return 1;}
int main(void){
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));fwp_tasks_init();
 SSL_CTX *tls=SSL_CTX_new(TLS_client_method());if(!tls)_Exit(31);
 SSL *ssl=SSL_new(tls);SSL_CTX_free(tls);if(!ssl)_Exit(32);
 g_server srv={0};srv.module="probe";
 g_conn *c=g_conn_new(-1, "", "local",&srv);c->ssl=ssl;
 for(stage=0;stage<7;stage++){
  peer_buffer=observed_sender=observed_job=observed_task=0;peer_frees=children=job_frees=task_frees=task_disposals=0;c->ssl=stage==4?0:ssl;
  g_stream *s=g_stream_new(c,(uint32_t)(1+2*stage));s->remote_end=1;
  if(stage==2){
   fwp_trap_recover=recover;fwp_trap_jb=&failure;fwp_trap_cleanup=0;
   if(!setjmp(failure)){g_start_call(c,s);_Exit(4);}
   fwp_trap_recover=0;fwp_trap_jb=0;
   if(peer_frees!=1||job_frees!=1||task_frees||children||s->task||fwp_cleanups)_Exit(5);
   g_unlink(c,s);
  }else{
   g_start_call(c,s);if(peer_frees||job_frees||!s->task)_Exit(6);
   fwp_task *t=s->task;g_job *j=(g_job *)t->carg;
   if(t->done)_Exit(6);
   fwp_tasks_finish();
   if(stage==5){
    if(task_frees!=1||job_frees||s->task||j->sv.task||!j->sv.peer||j->sv.peer_users!=1||children!=1||peer_frees||!observed_sender)_Exit(8);
    int64_t deadline=fwp_now_ns()+10000000000LL;
    while(fwp_gc_tasks){if(fwp_now_ns()>=deadline)_Exit(34);fwp_park(0,fwp_now_ns()+1000000LL);fwp_free_zombie();}
    fwp_free_zombie();
    if(job_frees!=1||task_frees!=1||children!=2||peer_frees!=1)_Exit(9);
   }else if(job_frees!=1||task_frees!=1||s->task||children!=1||peer_frees!=((stage<3||stage==6)?1:0)||fwp_cleanups)_Exit(7);
  }
  FWP_KEEP_ALIVE(PTR(s));FWP_KEEP_ALIVE(PTR(c));
 }
 // Overflow fails before acquiring a sender owner or publishing a task.
 stage=7;peer_frees=job_frees=task_frees=task_disposals=0;observed_sender=observed_task=0;
 g_job *pending=fwp_mem_alloc(sizeof(*pending));observed_job=pending;
 g_serving *sv=&pending->sv;g_ctx context={0};
 sv->peer=observed_subject();sv->peer_users=SIZE_MAX;context.serving=sv;
 fwp_cur->gctx=&context;fwp_trap_recover=recover;fwp_trap_jb=&failure;fwp_trap_cleanup=0;
 if(!setjmp(failure)){g_spawn_sender(c,0,0,&peer_input_remote);_Exit(10);}
 fwp_trap_recover=0;fwp_trap_jb=0;fwp_cur->gctx=0;
 if(sv->peer_users!=SIZE_MAX||peer_frees||job_frees||fwp_cleanups)_Exit(11);
 sv->peer_users=1;g_serving_peer_release(sv);if(peer_frees!=1||job_frees!=1)_Exit(12);
 // A scope is a second owner of the task identity, but not of the finished job.
 stage=8;peer_frees=job_frees=task_frees=task_disposals=children=0;observed_sender=observed_job=observed_task=0;
 g_stream *scoped_stream=g_stream_new(c,17);scoped_stream->remote_end=1;
 fwp_scope scope={0};fwp_cur->scope=&scope;
 g_start_call(c,scoped_stream);fwp_task *scoped_task=scoped_stream->task;
 fwp_tasks_finish();
 if(task_frees||job_frees!=1||scoped_stream->task||children!=1||peer_frees!=1)_Exit(40);
 if(scope.n!=1||scope.tasks[0]!=scoped_task||!scoped_task->done||scoped_task->gctx)_Exit(41);
 fwp_scope_owner scope_owner={fwp_cur,&scope,fwp_handlers};
 fwp_scope_release(&scope_owner);
 // Reuse verification deliberately poisons counted storage without freeing it.
 if(task_disposals!=1||task_frees!=(fwp_reuse_verify?0:1)||fwp_cur->scope)_Exit(42);
 if(fwp_reuse_verify&&*(uint64_t *)scoped_task)_Exit(43);
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
    let job_omitted = generated.replacen("    observed_managed_free(job);", "    (void)sv;", 1);
    assert_ne!(job_omitted, generated);
    let task_omitted = generated.replacen(
        "    fwp_task_own_internal(s->task, fwp_cur->scope != NULL);",
        "",
        1,
    );
    assert_ne!(task_omitted, generated);
    let scope_omitted = generated.replacen("    if (scope_owner) {", "    if (0) {", 1);
    assert_ne!(scope_omitted, generated);
    for opt in ["-O1", "-O2"] {
        for (broken, codes) in [
            (&omitted, &[7][..]),
            (&early, &[1, 6][..]),
            (&sender_omitted, &[9][..]),
            (&job_omitted, &[7][..]),
            (&task_omitted, &[7][..]),
            (&scope_omitted, &[40][..]),
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
