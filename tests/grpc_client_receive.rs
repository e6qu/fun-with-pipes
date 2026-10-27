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
    let (generated, _) = fwp::cgen::generate_library(&program, "grpc_client_receive", &[]).unwrap();
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
        (
            "fwp_p_channel_send_owned(ch, v, dec.ty->drop);",
            "observed_channel(ch,v);",
            1,
        ),
    ] {
        assert_eq!(method.matches(before).count(), count, "{before}");
        method = method.replacen(before, after, count);
    }
    let generated = format!(
        "{}static void decoded_drop(V);\n{}{}",
        &generated[..start],
        method,
        &generated[end..]
    );
    let finalizer = "static void g_stream_final(void *p) {";
    assert_eq!(generated.matches(finalizer).count(), 1);
    let generated = generated.replace(
        finalizer,
        &format!("{finalizer}\n    stream_finalizations++;"),
    );
    let hooks = r#"
#if defined(_WIN32) && !defined(_WIN32_WINNT)
#define _WIN32_WINNT 0x0a00
#endif
#include <stdlib.h>
#include <stdint.h>
static int stage,allocations,frees,cancelled,trapped,delivered,opens,stream_finalizations;
static int decoded_live;
static uintptr_t result,output_channel;
static void *owned[32],*connection,*stream,*retry_stream;
static void remember(void *);
static void observed_free(void *);
static void no_release(void *);
#define free(p) observed_free(p)
#define observed_open(output_,reused_) (*(output_)=connection,*(reused_)=stage==7&&opens==0,fwp_rc_dup(PTR(connection)),fwp_rc_dup(PTR(opens==0?stream:retry_stream)),(g_stream*)(opens++==0?stream:retry_stream))
#define observed_recv(connection_,stream_,deadline_,got_) do{g_recv(connection_,stream_,deadline_,got_);remember((got_)->m);remember((got_)->text);}while(0)
#define observed_decode(value_,why_) (stage==5?(fwp_trap("decode trap"),0):stage==4||stage==9?(*(why_)=strdup("malformed message"),remember(*(why_)),G_DEC_BAD):(*(value_)=fwp_rc_fresh(fwp_cstr("reply")),decoded_live++,G_DEC_OK))
#define observed_channel(channel_,value_) do{if(strcmp(STR(value_)->d,"reply"))_Exit(12);delivered++;if(stage>=12){fwp_p_channel_send_owned(channel_,value_,dec.ty->drop);}else{fwp_value_owner consumed={value_,dec.ty->drop};fwp_cleanup guard;fwp_value_protect(&consumed,&guard);if(stage==10)fwp_trap("channel trap");fwp_value_finish(&consumed,&guard);dec.ty->drop(value_);}}while(0)
"#;
    let fixture = r#"
#undef free
static void remember(void *p){if(!p)return;if(allocations==32)_Exit(30);owned[allocations++]=p;}
static void observed_free(void *p){if(p)for(int i=0;i<allocations;i++)if(owned[i]==p){owned[i]=0;frees++;break;}free(p);}
static void no_release(void *p){(void)p;}
static void decoded_drop(V value){if(decoded_live<1||strcmp(STR(value)->d,"reply"))_Exit(22);if(fwp_rc_release_last(value)){decoded_live--;fwp_rc_free_obj(value);}}
static int decoded_sink(void *context,V value){(void)context;if(!fwp_rc_last(value)||strcmp(STR(value)->d,"reply"))_Exit(24);if(stage==15)fwp_trap("channel trap");return 1;}
static g_msg *message(void){g_msg *m=calloc(1,sizeof *m+1);if(!m)_Exit(31);m->n=1;m->d[0]=42;return m;}
static void call(void *arg,int stop){if(stop){cancelled++;return;}jmp_buf failed;jmp_buf *saved=fwp_cur->trap_jb;fwp_cleanup *saved_cleanup=fwp_cur->trap_cleanup;if(!setjmp(failed)){fwp_cur->trap_jb=&failed;fwp_cur->trap_cleanup=fwp_cleanups;V args[]={output_channel};result=fwp_remote_call(arg,args);}else trapped++;fwp_cur->trap_jb=saved;fwp_cur->trap_cleanup=saved_cleanup;}
int main(void){
 fwp_lib_init();fwp_heap_start();fwp_tasks_init();fwp_trap_recover=g_trap_recover;
 g_server srv={0};srv.module="probe";g_conn *c=g_conn_new(-1, "", "local",&srv);connection=c;fwp_rc_fresh(PTR(c)); /* fixture owner */
#ifdef PROBE_CLIENT_STREAM_OWNERS
 c->server=0; /* exercise client cancellation/reset, not server receive rules */
#endif
 for(stage=0;stage<17;stage++){
  decoded_live=0;stream_finalizations=0;allocations=frees=cancelled=trapped=delivered=opens=0;result=99;memset(owned,0,sizeof owned);c->out.len=0;
  g_stream *s=g_stream_new(c,(uint32_t)(1+4*stage));s->sent_headers=1;s->remote_end=stage!=6&&stage!=10&&stage!=11;stream=s;retry_stream=s;
  if(stage!=2&&stage!=3&&stage!=7){s->mhead=s->mtail=message();}
  if(stage==1){s->mhead->next=message();s->mtail=s->mhead->next;}
  if(stage==3)s->bad=strdup("transport failure");
  if(stage==7){s->remote_end=0;s->reset=strdup("reset");s->retry=1;g_stream *next=g_stream_new(c,(uint32_t)(3+4*stage));next->sent_headers=1;next->remote_end=1;next->mhead=next->mtail=message();retry_stream=next;}
  fwp_rc_fresh(PTR(s)); /* active list */
  if(retry_stream!=stream)fwp_rc_fresh(PTR(retry_stream));
#ifdef PROBE_CLIENT_STREAM_OWNERS
  h2_hdrs_add(&s->headers,"grpc-status",11,"0",1);
  if(retry_stream!=stream){g_stream *next=retry_stream;h2_hdrs_add(&next->headers,"grpc-status",11,"0",1);}
#else
  fwp_rc_dup(PTR(s)); /* fixture inspection after the call */
  if(retry_stream!=stream)fwp_rc_dup(PTR(retry_stream));
#endif
  output_channel=0;
  if(stage>=12){
   output_channel=fwp_p_channel_make_owned(1,decoded_drop);
   if(stage==13)fwp_p_channel_close(output_channel);
   if(stage==14){V initial=fwp_rc_fresh(fwp_cstr("reply"));decoded_live++;fwp_p_channel_send_owned(output_channel,initial,decoded_drop);}
   if(stage>=15){fwp_chan *ch=(void*)(uintptr_t)output_channel;ch->sink=decoded_sink;ch->owner.sink_drop=no_release;}
  }
  const fwp_desc response={.dup=fwp_rc_dup,.drop=decoded_drop};
  fwp_remote remote={0};remote.m.resp=&response;remote.env="FWP_CLIENT_RECEIVE_PROBE";remote.default_addr="local";remote.what="probe";remote.m.output=stage>=8?2:0;
  fwp_task *t=fwp_spawn_task(0,call,&remote,0,0);fwp_task_own_internal(t,1);
  if(stage==6||stage==11||stage==14){fwp_p_task_yield();if(t->done||allocations!=1||frees!=1)return 2;fwp_p_task_cancel(PTR(t));}
  fwp_await(t);
  int expected=stage==7?3:stage==0||stage==1||stage==4||stage==8||stage==9||stage==12||stage==13||stage==16?2:1;
  if(!t->done||allocations!=expected||frees!=expected||fwp_cleanups||cancelled!=(stage==6||stage==11||stage==14)||trapped!=(stage==1||stage==2||stage==3||stage==4||stage==5||stage==9||stage==10||stage==15)){fprintf(stderr,"receive stage %d: done=%d allocations=%d frees=%d expected=%d cancelled=%d trapped=%d live=%d cleanups=%d\n",stage,t->done,allocations,frees,expected,cancelled,trapped,decoded_live,fwp_cleanups!=0);return 1;}
  fwp_task_drop(PTR(t));
#ifdef PROBE_CLIENT_STREAM_OWNERS
  if(stream_finalizations!=(stage==7?2:1)||c->streams){fprintf(stderr,"stage %d: %d finalized, listed=%d\n",stage,stream_finalizations,c->streams!=0);return 20;}
#else
  if(stage==10&&(s->listed||!s->reset))_Exit(21);
#endif
  if(stage==0||stage==7){if(strcmp(STR(result)->d,"reply"))return 3;decoded_drop(result);}
  if(stage==12||stage==14){
   if(decoded_live!=1)return 23;
   fwp_chan *ch=(void*)(uintptr_t)output_channel;
   if(ch->len!=1||!fwp_rc_last(ch->buf[ch->head])||strcmp(STR(ch->buf[ch->head])->d,"reply"))return 24;
  }
  if(output_channel)fwp_channel_drop(output_channel);
  if(decoded_live)return 22;
  if(stage>=8&&delivered!=(stage==8||stage==10||stage==11||stage>=12))return 4;
  if(stage==8&&result!=FWP_UNIT)return 5;
  if(trapped){const char *expected_text=stage==1?"bad response from probe (local): more than one response message":stage==2?"bad response from probe (local): missing response message":stage==3?"service call probe (local) failed: transport failure":stage==5?"decode trap":stage==10||stage==15?"channel trap":"bad response from probe (local): malformed message";if(strcmp(fwp_trap_msg,expected_text))return 6;}
#ifndef PROBE_CLIENT_STREAM_OWNERS
  g_unlink(c,s);g_stream_drop(s);
  if(retry_stream!=stream){g_unlink(c,retry_stream);g_stream_drop(retry_stream);}
#endif
 }
 g_conn_drop(c);fwp_lib_finish();return 0;
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
    let abort = "fwp_cleanup_push(&channel_abort, g_call_reset, &call);";
    assert_eq!(generated.matches(abort).count(), 1);
    let missing_abort = generated.replace(
        abort,
        "fwp_cleanup_push(&channel_abort, no_release, &call);",
    );
    for opt in ["-O1", "-O2"] {
        let missing_queue_owner = generated.replace(
            "observed_channel(ch,v);",
            "if(stage>=12){delivered++;fwp_p_channel_send(ch,v);dec.ty->drop(v);}else{observed_channel(ch,v);}",
        );
        fwp::cgen::compile_c(
            &format!("{hooks}\n{missing_queue_owner}\n{fixture}"),
            &exe,
            opt,
        )
        .unwrap();
        let out = Command::new(&exe).output().unwrap();
        assert_eq!(
            out.status.code(),
            Some(23),
            "omitted response queue owner: {out:?}"
        );
        let missing_value_guard = generated.replace(
            "fwp_value_protect(&message, &message_cleanup);",
            "message.drop = NULL; /* omit consumed-message cleanup */",
        );
        fwp::cgen::compile_c(
            &format!("{hooks}\n{missing_value_guard}\n{fixture}"),
            &exe,
            opt,
        )
        .unwrap();
        let out = Command::new(&exe).output().unwrap();
        assert_eq!(
            out.status.code(),
            Some(23),
            "omitted pending message cleanup: {out:?}"
        );
        fwp::cgen::compile_c(&format!("{hooks}\n{missing_abort}\n{fixture}"), &exe, opt).unwrap();
        let out = Command::new(&exe).output().unwrap();
        assert_eq!(
            out.status.code(),
            Some(21),
            "omitted channel reset: {out:?}"
        );
        for broken in &controls {
            fwp::cgen::compile_c(&format!("{hooks}\n{broken}\n{fixture}"), &exe, opt).unwrap();
            let out = Command::new(&exe).output().unwrap();
            assert_eq!(out.status.code(), Some(1), "omitted cleanup: {out:?}");
        }
        let call_guard = "fwp_cleanup_push(&call_cleanup, g_call_release, &call);";
        assert_eq!(generated.matches(call_guard).count(), 1);
        let missing_call_guard = generated.replace(
            call_guard,
            "fwp_cleanup_push(&call_cleanup, no_release, &call);",
        );
        fwp::cgen::compile_c(
            &format!(
                "#define PROBE_CLIENT_STREAM_OWNERS 1\n{hooks}\n{missing_call_guard}\n{fixture}"
            ),
            &exe,
            opt,
        )
        .unwrap();
        let out = Command::new(&exe).output().unwrap();
        assert_eq!(out.status.code(), Some(20), "omitted call owner: {out:?}");
        for owned in [false, true] {
            let prefix = if owned {
                "#define PROBE_CLIENT_STREAM_OWNERS 1\n"
            } else {
                ""
            };
            fwp::cgen::compile_c(
                &format!("{prefix}{hooks}\n{generated}\n{fixture}"),
                &exe,
                opt,
            )
            .unwrap();

            let out = Command::new(&exe).output().unwrap();
            assert!(out.status.success(), "{opt}/owned={owned}: {out:?}");
        }
    }
}
