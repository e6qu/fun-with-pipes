//! Served responses own buffers across encoding failures and cancelled sends.
use fwp::ir::*;
use std::process::Command;

#[test]
fn served_response_buffers_release_on_encode_trap_and_cancelled_send() {
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
    let (generated, _) = fwp::cgen::generate_library(&program, "grpc_response").unwrap();
    let start = generated.find("static int g_run_method(").unwrap();
    let end = start
        + generated[start..]
            .find("\nstatic void g_put_bytes")
            .unwrap();
    let mut method = generated[start..end].to_owned();
    for (before, after) in [
        ("g_recv_one(j, &code, msg)", "observed_request()"),
        ("pb_decode(m->schema, m->req_node, req->d, req->n, &canon)", "1"),
        ("g_apply_user(fwp_pap((uint32_t)m->fn, 0, 0), (uint32_t)na, args, &v, &err, &ed)", "observed_user(&v,&err,&ed)"),
        ("g_iter_next(&next, &x)", "observed_next(&next, &x)"),
        ("fwp_encode(&canon, err, m->error);", "fwp_encode(&canon, err, m->error); watched_canonical=canon.d; if(stage==3)fwp_trap(\"canonical trap\");"),
        ("pb_encode(m->schema, m->resp_node, (const unsigned char *)canon.d, canon.len, &b)", "observed_transcode(canon.d, canon.len, &b)"),
        ("g_encode(&enc, v, m->error != 0, &b);", "observed_response(&b);"),
        ("g_encode(&enc, x, m->error != 0, &b);", "observed_response(&b);"),
    ] {
        assert_eq!(method.matches(before).count(), 1, "{before}");
        method = method.replacen(before, after, 1);
    }
    let generated = format!("{}{}{}", &generated[..start], method, &generated[end..]);
    let send = "int r = g_send_data(c, s, b.d, b.len, end);";
    assert_eq!(generated.matches(send).count(), 1);
    let generated = generated.replacen(
        send,
        "watched_wire=b.d; int r = g_send_data(c, s, b.d, b.len, end);",
        1,
    );
    let hooks = r#"
#include <stdlib.h>
#include <stdint.h>
static int stage,kind,response_frees,canonical_frees,wire_frees,cancelled,result;
static void *watched_response,*watched_canonical,*watched_wire;
static void observed_free(void *);
static void no_release(void *);
static int observed_next(uintptr_t *,uintptr_t *);
#define free(p) observed_free(p)
#define observed_request() ((g_msg*)calloc(1,sizeof(g_msg)))
#define observed_user(value_,error_,descriptor_) (*(value_)=0,*(error_)=42,*(descriptor_)=m->error,kind==2?1:0)
#define observed_response(buffer_) do { h2b_put(buffer_,"response",8); watched_response=(buffer_)->d; if(stage==2)fwp_trap("response trap"); } while(0)
#define observed_transcode(data_,length_,output_) (h2b_put(output_,data_,length_),watched_response=(output_)->d,stage==2?(fwp_trap("response trap"),0):1)
"#;
    let fixture = r#"
#undef free
static void observed_free(void *p){if(p&&p==watched_response){response_frees++;watched_response=0;}if(p&&p==watched_canonical){canonical_frees++;watched_canonical=0;}if(p&&p==watched_wire){wire_frees++;watched_wire=0;}free(p);}
static void no_release(void *p){(void)p;}
static int observed_next(uintptr_t *cur,uintptr_t *value){if(*cur)return 0;*cur=1;*value=42;return 1;}
static void serve(void *arg,int stop){if(stop){cancelled++;return;}jmp_buf trapped;jmp_buf *saved=fwp_cur->trap_jb;fwp_cleanup *saved_cleanup=fwp_cur->trap_cleanup;if(!setjmp(trapped)){fwp_cur->trap_jb=&trapped;fwp_cur->trap_cleanup=fwp_cleanups;char *text=0;result=g_run_method(arg,&text);if(text)_Exit(7);}fwp_cur->trap_jb=saved;fwp_cur->trap_cleanup=saved_cleanup;}
int main(void){
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));fwp_tasks_init();fwp_trap_recover=g_trap_recover;
 g_server srv={0};srv.module="probe";g_conn *c=g_conn_new(-1,"local",&srv);
 const fwp_desc descriptor={.kind=K_I64,.name="I64"};
 for(kind=0;kind<3;kind++)for(stage=0;stage<(kind==2?4:3);stage++){
  watched_response=watched_canonical=watched_wire=0;response_frees=canonical_frees=wire_frees=cancelled=0;result=-2;c->out.len=0;c->conn_window=stage==1?0:65535;
  g_stream *s=g_stream_new(c,(uint32_t)(1+2*(kind*4+stage)));s->sent_headers=1;
  fwp_rpc method={0};method.output=kind==1?1:0;method.resp=&descriptor;method.error=kind==2?&descriptor:0;
  g_route route={0};route.kind=G_ROUTE_METHOD;route.m=&method;g_job job={0};job.c=c;job.s=s;job.srv=&srv;job.route=&route;strcpy(job.what,"probe");
  fwp_task *t=fwp_spawn_task(0,serve,&job,0,0);
  if(stage==1){fwp_p_task_yield();if(t->done||!watched_response||!watched_wire||response_frees||wire_frees)return 2;fwp_p_task_cancel(PTR(t));}
  fwp_await(t);
  if(!t->done||response_frees!=(stage==3?0:1)||canonical_frees!=(kind==2?1:0)||wire_frees!=(stage<2?1:0)||watched_response||watched_canonical||watched_wire||cancelled!=(stage==1)||fwp_cleanups)return 1;
  if(stage==0){if(result!=-1)return 3;int found=0;const unsigned char errorbytes[]={1,42,0,0,0,0,0,0,0};const void *expected=kind==2?(const void*)errorbytes:(const void*)"response";size_t n=kind==2?9:8;for(size_t i=0;i+n<=c->out.len;i++)if(!memcmp(c->out.d+i,expected,n))found=1;if(!found)return 4;}
  if(stage==2&&strcmp(fwp_trap_msg,"response trap"))return 5;
  if(stage==3&&strcmp(fwp_trap_msg,"canonical trap"))return 6;
  FWP_KEEP_ALIVE(PTR(t));FWP_KEEP_ALIVE(PTR(s));FWP_KEEP_ALIVE(PTR(c));
 }
 FWP_KEEP_ALIVE(PTR(c));fwp_lib_finish();return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("grpc-response-encoding").unwrap();
    let exe = dir.join("probe");
    let cleanup = "fwp_cleanup_push(&response_buffer, g_h2_buffer_release, &b);";
    assert_eq!(generated.matches(cleanup).count(), 4);
    let omitted = generated.replace(
        cleanup,
        "fwp_cleanup_push(&response_buffer, no_release, &b);",
    );
    let canonical = "fwp_cleanup_push(&error_canonical, fwp_file_buffer_cleanup, &canon);";
    assert_eq!(generated.matches(canonical).count(), 1);
    let canonical_omitted = generated.replacen(
        canonical,
        "fwp_cleanup_push(&error_canonical, no_release, &canon);",
        1,
    );
    for opt in ["-O1", "-O2"] {
        for broken in [&omitted, &canonical_omitted] {
            fwp::cgen::compile_c(&format!("{hooks}\n{broken}\n{fixture}"), &exe, opt).unwrap();
            let out = Command::new(&exe).env("FWP_GC", "off").output().unwrap();
            assert_eq!(out.status.code(), Some(1), "omitted cleanup: {out:?}");
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
