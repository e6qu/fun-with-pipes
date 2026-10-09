//! Client request buffers have owners during encoding and cancellable sends.
use fwp::ir::*;
use std::process::Command;

#[test]
fn client_request_buffers_release_on_encode_trap_and_cancelled_send() {
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
    let (generated, _) = fwp::cgen::generate_library(&program, "grpc_client_request").unwrap();
    let mut generated = generated;
    for (before, after, count) in [
        (
            "g_open_tls(addr, r->m.path, r->m.fingerprint, &c, &reused, &err, g_env_tls(r->env))",
            "observed_open(&c)",
            1,
        ),
        (
            "g_encode_request(r, args, &req);",
            "observed_request(&req);",
            1,
        ),
        (
            "g_encode_request(r, &x, &req);",
            "observed_request(&req);",
            1,
        ),
        (
            "while (g_iter_next(&cur, &x)) {",
            "while (observed_next(&cur, &x)) {",
            1,
        ),
        (
            "g_recv(c, s, deadline, &first);",
            "observed_end(&first);",
            1,
        ),
        (
            "int r = g_send_data(c, s, b.d, b.len, end);",
            "watched_wire=b.d; int r = g_send_data(c, s, b.d, b.len, end);",
            1,
        ),
    ] {
        assert_eq!(generated.matches(before).count(), count, "{before}");
        generated = generated.replacen(before, after, count);
    }
    let hooks = r#"
#include <stdlib.h>
#include <stdint.h>
static int stage,request_frees,wire_frees,cancelled,trapped;
static void *watched_request,*watched_wire,*connection,*stream;
static void observed_free(void *);
static void no_release(void *);
static int observed_next(uintptr_t *,uintptr_t *);
#define free(p) observed_free(p)
#define observed_open(output_) (*(output_)=connection,(g_stream*)stream)
#define observed_end(output_) do { (output_)->kind=G_END;(output_)->code=0; } while(0)
#define observed_request(buffer_) do { h2b_put(buffer_,"request",7); watched_request=(buffer_)->d; if(stage==2)fwp_trap("client encode trap"); } while(0)
"#;
    let fixture = r#"
#undef free
static void observed_free(void *p){if(p&&p==watched_request){request_frees++;watched_request=0;}if(p&&p==watched_wire){wire_frees++;watched_wire=0;}free(p);}
static void no_release(void *p){(void)p;}
static int observed_next(uintptr_t *cur,uintptr_t *value){if(*cur)return 0;*cur=1;*value=42;return 1;}
static void call(void *arg,int stop){if(stop){cancelled++;return;}jmp_buf failed;jmp_buf *saved=fwp_cur->trap_jb;fwp_cleanup *saved_cleanup=fwp_cur->trap_cleanup;if(!setjmp(failed)){fwp_cur->trap_jb=&failed;fwp_cur->trap_cleanup=fwp_cleanups;V args[]={0};fwp_remote_call(arg,args);_Exit(7);}else trapped++;fwp_cur->trap_jb=saved;fwp_cur->trap_cleanup=saved_cleanup;}
int main(void){
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));fwp_tasks_init();fwp_trap_recover=g_trap_recover;
 g_server srv={0};srv.module="probe";g_conn *c=g_conn_new(-1,"local",&srv);connection=c;
 for(int kind=0;kind<2;kind++)for(stage=0;stage<3;stage++){
  watched_request=watched_wire=0;request_frees=wire_frees=cancelled=trapped=0;c->out.len=0;c->conn_window=stage==1?0:65535;
  g_stream *s=g_stream_new(c,(uint32_t)(1+2*(kind*3+stage)));s->sent_headers=1;stream=s;
  fwp_remote remote={0};remote.env="FWP_CLIENT_REQUEST_PROBE";remote.default_addr="local";remote.what="probe";remote.m.input=kind;
  fwp_task *t=fwp_spawn_task(0,call,&remote,0,0);
  if(stage==1){fwp_p_task_yield();if(t->done||!watched_request||!watched_wire||request_frees||wire_frees)return 2;fwp_p_task_cancel(PTR(t));}
  fwp_await(t);
  if(!t->done||request_frees!=1||watched_request||watched_wire||wire_frees!=(stage==2?0:1)||cancelled!=(stage==1)||trapped!=(stage!=1)||fwp_cleanups)return 1;
  if(stage==0){if(!s->local_end)return 3;int found=0;for(size_t i=0;i+7<=c->out.len;i++)if(!memcmp(c->out.d+i,"request",7))found=1;if(!found)return 4;if(strcmp(fwp_trap_msg,"bad response from probe (local): missing response message"))return 5;}
  if(stage==2&&strcmp(fwp_trap_msg,"client encode trap"))return 6;
  FWP_KEEP_ALIVE(PTR(t));FWP_KEEP_ALIVE(PTR(s));FWP_KEEP_ALIVE(PTR(c));
 }
 FWP_KEEP_ALIVE(PTR(c));fwp_lib_finish();return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("grpc-client-requests").unwrap();
    let exe = dir.join("probe");
    let cleanup = "fwp_cleanup_push(&client_request, g_h2_buffer_release, &req);";
    assert_eq!(generated.matches(cleanup).count(), 2);
    let omitted = generated.replace(
        cleanup,
        "fwp_cleanup_push(&client_request, no_release, &req);",
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
