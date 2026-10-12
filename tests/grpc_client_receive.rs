//! Client receives own messages/status copies across retry, decode and cancellation.
use fwp::ir::*;
use std::process::Command;

#[test]
fn client_received_buffers_release_on_retry_errors_and_cancelled_waits() {
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
    let (generated, _) = fwp::cgen::generate_library(&program, "grpc_client_receive").unwrap();
    let start = generated.find("static V fwp_remote_call(").unwrap();
    let end = start + generated[start..].find("\n/*").unwrap();
    let mut method = generated[start..end].to_owned();
    for (before, after, count) in [
        (
            "g_open_tls(addr, r->m.path, r->m.fingerprint, &c, &reused, &err, g_env_tls(r->env))",
            "observed_open(&c,&reused)",
            1,
        ),
        (
            "g_encode_request(r, args, &req);",
            "h2b_put(&req,\"request\",7);",
            1,
        ),
        (
            "g_encode_request(r, &x, &req);",
            "h2b_put(&req,\"request\",7);",
            1,
        ),
        (
            "g_recv(c, s, deadline, &first);",
            "observed_recv(c,s,deadline,&first);",
            1,
        ),
        (
            "g_recv(c, s, deadline, &g);",
            "observed_recv(c,s,deadline,&g);",
            2,
        ),
        (
            "g_decode(&dec, first.m->d, first.m->n, &v, &why)",
            "observed_decode(&v,&why)",
            1,
        ),
        (
            "g_decode(&dec, g.m->d, g.m->n, &v, &why)",
            "observed_decode(&v,&why)",
            1,
        ),
        ("fwp_p_channel_send(ch, v);", "observed_channel(ch,v);", 1),
    ] {
        assert_eq!(method.matches(before).count(), count, "{before}");
        method = method.replacen(before, after, count);
    }
    let generated = format!("{}{}{}", &generated[..start], method, &generated[end..]);
    let hooks = r#"
#include <stdlib.h>
#include <stdint.h>
static int stage,allocations,frees,cancelled,trapped,delivered,opens;
static uintptr_t result;
static void *owned[32],*connection,*stream,*retry_stream;
static void remember(void *);
static void observed_free(void *);
static void no_release(void *);
#define free(p) observed_free(p)
#define observed_open(output_,reused_) (*(output_)=connection,*(reused_)=stage==7&&opens==0,(g_stream*)(opens++==0?stream:retry_stream))
#define observed_recv(connection_,stream_,deadline_,got_) do{g_recv(connection_,stream_,deadline_,got_);remember((got_)->m);remember((got_)->text);}while(0)
#define observed_decode(value_,why_) (stage==5?(fwp_trap("decode trap"),0):stage==4||stage==9?(*(why_)=strdup("malformed message"),remember(*(why_)),G_DEC_BAD):(*(value_)=42,G_DEC_OK))
#define observed_channel(channel_,value_) do{if((value_)!=42)_Exit(12);delivered++;if(stage==10)fwp_trap("channel trap");}while(0)
"#;
    let fixture = r#"
#undef free
static void remember(void *p){if(!p)return;if(allocations==32)_Exit(30);owned[allocations++]=p;}
static void observed_free(void *p){if(p)for(int i=0;i<allocations;i++)if(owned[i]==p){owned[i]=0;frees++;break;}free(p);}
static void no_release(void *p){(void)p;}
static g_msg *message(void){g_msg *m=calloc(1,sizeof *m+1);if(!m)_Exit(31);m->n=1;m->d[0]=42;return m;}
static void call(void *arg,int stop){if(stop){cancelled++;return;}jmp_buf failed;jmp_buf *saved=fwp_cur->trap_jb;fwp_cleanup *saved_cleanup=fwp_cur->trap_cleanup;if(!setjmp(failed)){fwp_cur->trap_jb=&failed;fwp_cur->trap_cleanup=fwp_cleanups;V args[]={0};result=fwp_remote_call(arg,args);}else trapped++;fwp_cur->trap_jb=saved;fwp_cur->trap_cleanup=saved_cleanup;}
int main(void){
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));fwp_tasks_init();fwp_trap_recover=g_trap_recover;
 g_server srv={0};srv.module="probe";g_conn *c=g_conn_new(-1,"local",&srv);connection=c;
 for(stage=0;stage<12;stage++){
  allocations=frees=cancelled=trapped=delivered=opens=0;result=99;memset(owned,0,sizeof owned);c->out.len=0;
  g_stream *s=g_stream_new(c,(uint32_t)(1+4*stage));s->sent_headers=1;s->remote_end=stage!=6&&stage!=11;stream=s;retry_stream=s;
  if(stage!=2&&stage!=3&&stage!=7){s->mhead=s->mtail=message();}
  if(stage==1){s->mhead->next=message();s->mtail=s->mhead->next;}
  if(stage==3)s->bad=strdup("transport failure");
  if(stage==7){s->remote_end=0;s->reset=strdup("reset");s->retry=1;g_stream *next=g_stream_new(c,(uint32_t)(3+4*stage));next->sent_headers=1;next->remote_end=1;next->mhead=next->mtail=message();retry_stream=next;}
  fwp_remote remote={0};remote.env="FWP_CLIENT_RECEIVE_PROBE";remote.default_addr="local";remote.what="probe";remote.m.output=stage>=8?2:0;
  fwp_task *t=fwp_spawn_task(0,call,&remote,0,0);
  if(stage==6||stage==11){fwp_p_task_yield();if(t->done||allocations!=1||frees!=1)return 2;fwp_p_task_cancel(PTR(t));}
  fwp_await(t);
  int expected=stage==7?3:stage==0||stage==1||stage==4||stage==8||stage==9?2:1;
  if(!t->done||allocations!=expected||frees!=expected||fwp_cleanups||cancelled!=(stage==6||stage==11)||trapped!=(stage==1||stage==2||stage==3||stage==4||stage==5||stage==9||stage==10))return 1;
  if(stage==0||stage==7){if(result!=42)return 3;}
  if(stage>=8&&delivered!=(stage==8||stage==10||stage==11))return 4;
  if(stage==8&&result!=FWP_UNIT)return 5;
  if(trapped){const char *expected_text=stage==1?"bad response from probe (local): more than one response message":stage==2?"bad response from probe (local): missing response message":stage==3?"service call probe (local) failed: transport failure":stage==5?"decode trap":stage==10?"channel trap":"bad response from probe (local): malformed message";if(strcmp(fwp_trap_msg,expected_text))return 6;}
  FWP_KEEP_ALIVE(PTR(t));FWP_KEEP_ALIVE(PTR(s));FWP_KEEP_ALIVE(PTR(c));FWP_KEEP_ALIVE(PTR(retry_stream));
 }
 FWP_KEEP_ALIVE(PTR(c));fwp_lib_finish();return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("grpc-client-receive").unwrap();
    let exe = dir.join("probe");
    let first = "fwp_cleanup_push(&first_received, g_got_release, &first);";
    let receive = "fwp_cleanup_push(&received, g_got_release, &g);";
    let decode = "fwp_cleanup_push(&decode_text, fwp_tls_subject_free, why);";
    for (needle, count) in [(first, 1), (receive, 2), (decode, 2)] {
        assert_eq!(generated.matches(needle).count(), count);
    }
    let controls = [
        generated.replace(
            first,
            "fwp_cleanup_push(&first_received, no_release, &first);",
        ),
        generated.replace(receive, "fwp_cleanup_push(&received, no_release, &g);"),
        generated.replace(decode, "fwp_cleanup_push(&decode_text, no_release, why);"),
    ];
    for opt in ["-O1", "-O2"] {
        for broken in &controls {
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
