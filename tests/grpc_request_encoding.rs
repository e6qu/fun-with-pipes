//! A detached sender owns its encoded request across encoding traps and sends.
use fwp::ir::*;
use std::process::Command;

#[test]
fn request_encoding_buffer_releases_on_encode_trap_and_cancelled_send() {
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
    let (generated, _) = fwp::cgen::generate_library(&program, "grpc_request").unwrap();
    let encode = "g_encode_request(x->r, &v, &req);";
    let next = "if (!g_iter_next(&cur, &v)) {";
    let send = "int r = g_send_data(c, s, b.d, b.len, end);";
    for needle in [encode, next, send] {
        assert_eq!(generated.matches(needle).count(), 1);
    }
    let generated = generated
        .replacen(encode, "observed_request(&req);", 1)
        .replacen(next, "if (!observed_next(&cur, &v)) {", 1)
        .replacen(
            send,
            "wire_buffer=b.d; int r = g_send_data(c, s, b.d, b.len, end);",
            1,
        );
    let hooks = r#"
#include <stdlib.h>
#include <stdint.h>
static int stage,request_frees,wire_frees;
static void *watched_request,*wire_buffer;
static void observed_free(void *);
static void no_release(void *);
static int observed_next(uintptr_t *,uintptr_t *);
#define free(p) observed_free(p)
#define observed_request(buffer_) do { h2b_put(buffer_,"request",7); watched_request=(buffer_)->d; if(stage==2)fwp_trap("encode trap"); } while(0)
"#;
    let fixture = r#"
#undef free
static void observed_free(void *p){if(p&&p==watched_request){request_frees++;watched_request=0;}if(p&&p==wire_buffer){wire_frees++;wire_buffer=0;}free(p);}
static void no_release(void *p){(void)p;}
static int observed_next(uintptr_t *cur,uintptr_t *value){if(*cur)return 0;*cur=1;*value=42;return 1;}
int main(void){
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));fwp_tasks_init();fwp_trap_recover=g_trap_recover;
 g_server srv={0};srv.module="probe";g_conn *c=g_conn_new(-1,"local",&srv);fwp_remote remote={0};
 for(stage=0;stage<3;stage++){
  watched_request=wire_buffer=0;request_frees=wire_frees=0;c->out.len=0;c->conn_window=stage==1?0:65535;
  g_stream *s=g_stream_new(c,(uint32_t)(1+2*stage));s->sent_headers=1;
  g_sender *x=fwp_alloc(sizeof *x);x->c=c;x->s=s;x->r=&remote;
  fwp_task *t=fwp_spawn_task(0,g_send_all,x,0,1);
  if(stage==1){fwp_p_task_yield();if(t->done||!watched_request||!wire_buffer||request_frees||wire_frees)return 2;fwp_p_task_cancel(PTR(t));}
  fwp_await(t);
  if(!t->done||request_frees!=1||watched_request||wire_buffer||wire_frees!=(stage==2?0:1)||fwp_cleanups)return 1;
  if(stage==0){if(!s->local_end||s->reset)return 3;int found=0;for(size_t i=0;i+7<=c->out.len;i++)if(!memcmp(c->out.d+i,"request",7))found=1;if(!found)return 4;}
  if(stage==2&&(!s->reset||strcmp(s->reset,"trap: encode trap")))return 5;
  FWP_KEEP_ALIVE(PTR(t));FWP_KEEP_ALIVE(PTR(x));FWP_KEEP_ALIVE(PTR(s));FWP_KEEP_ALIVE(PTR(c));
 }
 FWP_KEEP_ALIVE(PTR(c));fwp_lib_finish();return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("grpc-request-encoding").unwrap();
    let exe = dir.join("probe");
    let cleanup = "fwp_cleanup_push(&request_buffer, g_h2_buffer_release, &req);";
    assert_eq!(generated.matches(cleanup).count(), 1);
    let omitted = generated.replacen(
        cleanup,
        "fwp_cleanup_push(&request_buffer, no_release, &req);",
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
