//! Encoded messages own scratch while flow-control waits suspend their task.
use fwp::ir::*;
use std::process::Command;

#[test]
fn encoded_messages_release_on_cancel_and_preserve_plain_and_gzip_frames() {
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
    let (generated, _) = fwp::cgen::generate_library(&program, "grpc_send").unwrap();
    let send = "int r = g_send_data(c, s, b.d, b.len, end);";
    assert_eq!(generated.matches(send).count(), 1);
    let generated = generated.replacen(
        send,
        "watched_buffer=b.d; int r = g_send_data(c, s, b.d, b.len, end);",
        1,
    );
    let hooks = r#"
#include <stdlib.h>
static int stage,buffer_frees,cancelled,result;
static void *watched_buffer;
static void observed_free(void *);
static void no_release(void *);
#define free(p) observed_free(p)
"#;
    let fixture = r#"
#undef free
static unsigned char payload[128];
static void observed_free(void *p){if(p&&p==watched_buffer){buffer_frees++;watched_buffer=0;}free(p);}
static void no_release(void *p){(void)p;}
static void sender(void *arg,int stop){if(stop){cancelled++;return;}g_job *j=arg;result=g_send_msg(j->c,j->s,payload,sizeof payload,0);}
static int check_frames(g_conn *c,int gzip){
 h2_buf encoded={0},plain={0};size_t off=0;
 while(off<c->out.len){
  if(c->out.len-off<9)return 11;const unsigned char *h=c->out.d+off;
  size_t n=((size_t)h[0]<<16)|((size_t)h[1]<<8)|h[2];
  if(h[3]!=H2_DATA||n>c->out.len-off-9)return 12;
  h2b_put(&encoded,h+9,n);off+=9+n;
 }
 if(encoded.len<5||encoded.d[0]!=gzip)return 13;
 const unsigned char *p=encoded.d;
 size_t n=((size_t)p[1]<<24)|((size_t)p[2]<<16)|((size_t)p[3]<<8)|p[4];
 if(n!=encoded.len-5)return 14;
 if(gzip){if(!h2_gunzip(p+5,n,&plain,sizeof payload))return 15;}
 else h2b_put(&plain,p+5,n);
 int ok=plain.len==sizeof payload&&!memcmp(plain.d,payload,sizeof payload);
 h2b_free(&encoded);h2b_free(&plain);return ok?0:16;
}
int main(void){
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));fwp_tasks_init();
 for(size_t i=0;i<sizeof payload;i++)payload[i]=(unsigned char)(17*i);
 g_server srv={0};srv.module="probe";g_conn *c=g_conn_new(-1,"local",&srv);
 for(int gzip=0;gzip<2;gzip++)for(stage=0;stage<6;stage++){
  watched_buffer=0;buffer_frees=cancelled=0;result=-1;c->out.len=0;
  c->conn_window=stage==1||stage==5?0:stage==2?7:65535;
  g_stream *s=g_stream_new(c,(uint32_t)(1+2*stage));s->sent_headers=1;s->gzip=gzip;
  if(stage==3)c->dead=strdup("closed");if(stage==4)s->reset=strdup("reset");
  g_job job={0};job.c=c;job.s=s;
  fwp_task *t=fwp_spawn_task(0,sender,&job,0,0);
  if(stage==1||stage==2||stage==5){
   fwp_p_task_yield();if(t->done||!watched_buffer||buffer_frees||result!=-1)return 2;
   if(stage==5){c->conn_window=s->window=65535;fwp_wake_all(&c->space_wl);}
   else fwp_p_task_cancel(PTR(t));
  }
  fwp_await(t);
  if(!t->done||buffer_frees!=1||watched_buffer||cancelled!=(stage==1||stage==2)||fwp_cleanups)return 1;
  if(stage==0||stage==5){if(result!=1)return 3;int error=check_frames(c,gzip);if(error)return error;}
  else if(stage==3||stage==4){if(result!=0)return 4;}
  free(c->dead);c->dead=0;
  FWP_KEEP_ALIVE(PTR(t));FWP_KEEP_ALIVE(PTR(s));FWP_KEEP_ALIVE(PTR(c));
 }
 FWP_KEEP_ALIVE(PTR(c));fwp_lib_finish();return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("grpc-send-cleanup").unwrap();
    let exe = dir.join("probe");
    let cleanup = "fwp_cleanup_push(&message_buffer, g_h2_buffer_release, &b);";
    assert_eq!(generated.matches(cleanup).count(), 1);
    let omitted = generated.replacen(
        cleanup,
        "fwp_cleanup_push(&message_buffer, no_release, &b);",
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
