//! Served responses and channel sends release buffers on failure and cancellation.
use fwp::ir::*;
use std::process::Command;

#[test]
fn served_buffers_release_on_decode_encode_traps_and_cancelled_send() {
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
    let generated = generated.replacen("} fwp_owned_fninfo;",
        "} fwp_owned_fninfo;\nstatic V probe_method_entry(V *a){(void)a;return 0;}\nstatic const fwp_owned_fninfo probe_method_types={.entry=probe_method_entry};\nstatic void probe_result_drop(V value){(void)value;}", 1);
    let start = generated.find("static int g_run_method(").unwrap();
    let end = start
        + generated[start..]
            .find("\nstatic void g_put_bytes")
            .unwrap();
    let mut method = generated[start..end].to_owned();
    for (before, after) in [
        ("const fwp_owned_fninfo *types = fwp_fns[m->fn].owned;", "const fwp_owned_fninfo *types = &probe_method_types;"),
        ("g_recv_one(j, &code, msg)", "observed_request()"),
        ("pb_decode(m->schema, m->req_node, req->d, req->n, &canon)", "observed_request_decode(&canon)"),
        ("fwp_decode(&rd, m->req[i], &args[na])", "observed_argument(&rd, m->req[i], &args[na])"),
        ("g_apply_user((uint32_t)m->fn, args, &values.result, &values.error, &values.error_type)", "observed_user(&values.result,&values.error,&values.error_type)"),
        ("g_cursor_next(&output.cursor, output.drop, &x)", "observed_next(&output.cursor.cur, &x)"),
        ("fwp_encode(&canon, values.error, m->error);", "fwp_encode(&canon, values.error, m->error); watched_canonical=canon.d; if(stage==3)fwp_trap(\"canonical trap\");"),
        ("pb_encode(m->schema, m->resp_node, (const unsigned char *)canon.d, canon.len, &b)", "observed_transcode(canon.d, canon.len, &b)"),
        ("g_encode(&enc, values.result, m->error != 0, &b);", "observed_response(&b);"),
        ("g_encode(&enc, x, m->error != 0, &b);", "observed_response(&b);"),
    ] {
        assert_eq!(method.matches(before).count(), 1, "{before}");
        method = method.replacen(before, after, 1);
    }
    let generated = format!("{}{}{}", &generated[..start], method, &generated[end..]);
    let reflect_start = generated.find("static int g_reflect(").unwrap();
    let reflect_end = reflect_start
        + generated[reflect_start..]
            .find("\n/* the task serving one call */")
            .unwrap();
    let mut reflect = generated[reflect_start..reflect_end].to_owned();
    for (before, after) in [
        (
            "g_recv(j->c, j->s, 0, &g);",
            "observed_reflection_receive(&g);",
        ),
        (
            "g_reflection_response(j->srv, g.m->d, g.m->n, &out);",
            "observed_response(&out);",
        ),
    ] {
        assert_eq!(reflect.matches(before).count(), 1, "{before}");
        reflect = reflect.replacen(before, after, 1);
    }
    let generated = format!(
        "{}{}{}",
        &generated[..reflect_start],
        reflect,
        &generated[reflect_end..]
    );
    let sink_encode = "g_encode(&k->enc, x, k->tag, &b);";
    assert_eq!(generated.matches(sink_encode).count(), 1);
    let generated = generated.replacen(sink_encode, "observed_response(&b);", 1);
    let send = "int r = g_send_data(c, s, b.d, b.len, end);";
    assert_eq!(generated.matches(send).count(), 1);
    let generated = generated.replacen(
        send,
        "watched_wire=b.d; int r = g_send_data(c, s, b.d, b.len, end);",
        1,
    );
    let hooks = r#"
#if defined(_WIN32) && !defined(_WIN32_WINNT)
#define _WIN32_WINNT 0x0a00
#endif
#include <stdlib.h>
#include <stdint.h>
static int stage,kind,response_frees,canonical_frees,wire_frees,cancelled,result,request_frees,reflection_reads;
static void *watched_response,*watched_canonical,*watched_wire,*watched_request;
static void observed_free(void *);
static void no_release(void *);
static int observed_next(uintptr_t *,uintptr_t *);
#define free(p) observed_free(p)
#define observed_reflection_receive(got_) do { memset(got_,0,sizeof *(got_)); if(reflection_reads++){(got_)->kind=G_END;}else{(got_)->kind=G_MSG;(got_)->m=calloc(1,sizeof(g_msg));watched_request=(got_)->m;} } while(0)
#define observed_request() ((g_msg*)calloc(1,sizeof(g_msg)))
#define observed_request_decode(buffer_) (stage==4?(h2b_put(buffer_,"request",7),watched_request=(buffer_)->d,1):1)
#define observed_argument(reader_,type_,out_) (stage==4?(fwp_trap("request decode trap"),0):fwp_decode(reader_,type_,out_))
#define observed_user(value_,error_,descriptor_) (*(value_)=0,*(error_)=42,*(descriptor_)=m->error,kind==2?1:0)
#define observed_response(buffer_) do { h2b_put(buffer_,"response",8); watched_response=(buffer_)->d; if(stage==2)fwp_trap("response trap"); } while(0)
#define observed_transcode(data_,length_,output_) (h2b_put(output_,data_,length_),watched_response=(output_)->d,stage==2?(fwp_trap("response trap"),0):1)
"#;
    let fixture = r#"
#undef free
static void observed_free(void *p){if(p&&p==watched_request){request_frees++;watched_request=0;}if(p&&p==watched_response){response_frees++;watched_response=0;}if(p&&p==watched_canonical){canonical_frees++;watched_canonical=0;}if(p&&p==watched_wire){wire_frees++;watched_wire=0;}free(p);}
static void no_release(void *p){(void)p;}
static int observed_next(uintptr_t *cur,uintptr_t *value){if(*cur)return 0;*cur=1;*value=42;return 1;}
static void serve(void *arg,int stop){if(stop){cancelled++;return;}jmp_buf trapped;jmp_buf *saved=fwp_cur->trap_jb;fwp_cleanup *saved_cleanup=fwp_cur->trap_cleanup;if(!setjmp(trapped)){fwp_cur->trap_jb=&trapped;fwp_cur->trap_cleanup=fwp_cleanups;if(kind==3){g_job *job=arg;g_sink sink={0};sink.c=job->c;sink.s=job->s;result=g_sink_send(&sink,42);}else{char *text=0;result=kind==4?g_reflect(arg,&text):g_run_method(arg,&text);if(text)_Exit(7);}}fwp_cur->trap_jb=saved;fwp_cur->trap_cleanup=saved_cleanup;}
int main(void){
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));fwp_tasks_init();fwp_trap_recover=g_trap_recover;
 g_server srv={0};srv.module="probe";g_conn *c=g_conn_new(-1,"local",&srv);
 const fwp_desc descriptor={.kind=K_I64,.name="I64"};
 /* Kinds: single response, response iterator, typed error, channel sender, reflection.
  * Stages: success, blocked-send cancellation, encoding trap, error-encoding
  * trap, request-decoding trap. Channel sends and reflection exercise the first three. */
 for(kind=0;kind<5;kind++)for(stage=0;stage<5;stage++){
  if(stage==3&&kind!=2)continue;
  if(kind>=3&&stage>=3)continue;
  watched_request=0;request_frees=0;reflection_reads=0;
  watched_response=watched_canonical=watched_wire=0;response_frees=canonical_frees=wire_frees=cancelled=0;result=-2;c->out.len=0;c->conn_window=stage==1?0:65535;
  g_stream *s=g_stream_new(c,(uint32_t)(1+2*(kind*5+stage)));s->sent_headers=1;
  const fwp_desc *request_fields[]={&descriptor};
  fwp_rpc method={0};method.result_drop=probe_result_drop;method.nreq=stage==4?1:0;method.req=request_fields;method.output=kind==1?1:0;method.resp=&descriptor;method.error=kind==2?&descriptor:0;
  g_route route={0};route.kind=G_ROUTE_METHOD;route.m=&method;g_job job={0};job.c=c;job.s=s;job.srv=&srv;job.route=&route;strcpy(job.what,"probe");
  fwp_task *t=fwp_spawn_task(0,serve,&job,0,0);
  if(stage==1){fwp_p_task_yield();if(t->done||!watched_response||!watched_wire||response_frees||wire_frees)return 2;fwp_p_task_cancel(PTR(t));}
  fwp_await(t);
  if(!t->done||response_frees!=(stage>=3?0:1)||canonical_frees!=(kind==2&&stage!=4?1:0)||wire_frees!=(stage<2?1:0)||watched_response||watched_canonical||watched_wire||cancelled!=(stage==1)||fwp_cleanups||watched_request||request_frees!=(stage==4||kind==4?1:0))return 1;
  if(stage==0){if(result!=(kind==3?1:-1))return 3;int found=0;const unsigned char errorbytes[]={1,42,0,0,0,0,0,0,0};const void *expected=kind==2?(const void*)errorbytes:(const void*)"response";size_t n=kind==2?9:8;for(size_t i=0;i+n<=c->out.len;i++)if(!memcmp(c->out.d+i,expected,n))found=1;if(!found)return 4;}
  if(stage==2&&strcmp(fwp_trap_msg,"response trap"))return 5;
  if(stage==3&&strcmp(fwp_trap_msg,"canonical trap"))return 6;
  if(stage==4&&strcmp(fwp_trap_msg,"request decode trap"))return 8;
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
    let request = "fwp_cleanup_push(&request_canonical, g_h2_buffer_release, &canon);";
    assert_eq!(generated.matches(request).count(), 1);
    let request_omitted = generated.replacen(
        request,
        "fwp_cleanup_push(&request_canonical, no_release, &canon);",
        1,
    );
    let sink = "fwp_cleanup_push(&sink_buffer, g_h2_buffer_release, &b);";
    assert_eq!(generated.matches(sink).count(), 1);
    let sink_omitted =
        generated.replacen(sink, "fwp_cleanup_push(&sink_buffer, no_release, &b);", 1);
    let reflection = "fwp_cleanup_push(&reflection_buffer, g_h2_buffer_release, &out);";
    assert_eq!(generated.matches(reflection).count(), 1);
    let reflection_omitted = generated.replacen(
        reflection,
        "fwp_cleanup_push(&reflection_buffer, no_release, &out);",
        1,
    );
    let received = "fwp_cleanup_push(&reflection_request, g_got_release, &g);";
    assert_eq!(generated.matches(received).count(), 1);
    let received_omitted = generated.replacen(
        received,
        "fwp_cleanup_push(&reflection_request, no_release, &g);",
        1,
    );
    for opt in ["-O1", "-O2"] {
        for broken in [
            &omitted,
            &canonical_omitted,
            &request_omitted,
            &sink_omitted,
            &reflection_omitted,
            &received_omitted,
        ] {
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

#[test]
fn served_values_release_on_partial_decode_aliases_errors_and_cancellation() {
    use fwp::value::Value;
    let unit = MT::unit();
    let string = MT::con("std::String");
    let integer = MT::con("std::I64");
    let method = MT::Fun(
        Box::new(string.clone()),
        Box::new(MT::Fun(Box::new(string.clone()), Box::new(string.clone()))),
    );
    let continuation = MT::Fun(Box::new(unit.clone()), Box::new(integer.clone()));
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
                ty: unit.clone(),
                body: Body::Prim("http2.connect".into()),
            },
            // Keep concrete owning entries for the methods and continuations.
            Func {
                name: "method-values".into(),
                arity: 0,
                locals: vec![method.clone(), continuation.clone(), continuation.clone()],
                ty: method.clone(),
                body: Body::Expr(Expr::Let(
                    0,
                    Box::new(Expr::Func(3)),
                    Box::new(Expr::Let(
                        1,
                        Box::new(Expr::Func(6)),
                        Box::new(Expr::Let(
                            2,
                            Box::new(Expr::Func(7)),
                            Box::new(Expr::Func(4)),
                        )),
                    )),
                )),
            },
            Func {
                name: "first".into(),
                arity: 2,
                locals: vec![string.clone(), string.clone()],
                ty: method.clone(),
                body: Body::Expr(Expr::Local(0)),
            },
            Func {
                name: "raise".into(),
                arity: 2,
                locals: vec![string.clone(), string.clone()],
                ty: method,
                body: Body::Expr(Expr::Call(5, vec![Expr::Local(0)])),
            },
            Func {
                name: "fail".into(),
                arity: 1,
                locals: vec![string.clone()],
                ty: MT::Fun(Box::new(string.clone()), Box::new(string)),
                body: Body::Prim("fail".into()),
            },
            Func {
                name: "end".into(),
                arity: 1,
                locals: vec![unit.clone()],
                ty: continuation.clone(),
                body: Body::Expr(Expr::Const(Value::I64(0))),
            },
            Func {
                name: "broken-next".into(),
                arity: 1,
                locals: vec![unit],
                ty: continuation,
                body: Body::Expr(Expr::Call(
                    8,
                    vec![Expr::Const(Value::I64(0)), Expr::Const(Value::I64(1))],
                )),
            },
            Func {
                name: "div".into(),
                arity: 2,
                locals: vec![integer.clone(), integer.clone()],
                ty: MT::Fun(
                    Box::new(integer.clone()),
                    Box::new(MT::Fun(Box::new(integer.clone()), Box::new(integer))),
                ),
                body: Body::Prim("prim.div".into()),
            },
        ],
        main: Some(2),
        exports: vec![("available".into(), 0)],
        ..Program::default()
    };
    let (generated, _) = fwp::cgen::generate_library(&program, "served_values").unwrap();
    let begin = generated.find("static int g_run_method(").unwrap();
    let end = begin
        + generated[begin..]
            .find("\nstatic void g_put_bytes")
            .unwrap();
    let mut method = generated[begin..end].to_owned();
    for (before, after) in [
        ("g_recv_one(j, &code, msg)", "owned_request()"),
        (
            "pb_decode(m->schema, m->req_node, req->d, req->n, &canon)",
            "1",
        ),
        (
            "fwp_decode(&rd, m->req[i], &args[na])",
            "owned_decode(&args[na])",
        ),
        (
            "g_encode(&enc, values.result, m->error != 0, &b);",
            "owned_response(values.result, &b);",
        ),
        (
            "g_encode(&enc, x, m->error != 0, &b);",
            "owned_response(x, &b);",
        ),
        (
            "pb_encode(m->schema, m->resp_node, (const unsigned char *)canon.d, canon.len, &b)",
            "owned_transcode(canon.d, canon.len, &b)",
        ),
    ] {
        assert_eq!(method.matches(before).count(), 1, "{before}");
        method = method.replacen(before, after, 1);
    }
    let declarations = "static g_msg *owned_request(void);\nstatic int owned_decode(V *);\nstatic void owned_response(V,h2_buf *);\nstatic int owned_transcode(const char *,size_t,h2_buf *);\n";
    let generated = format!(
        "{}{}{}{}",
        &generated[..begin],
        declarations,
        method,
        &generated[end..]
    );
    let fixture = include_str!("fixtures/grpc_served_values.c");
    let controls = [
        (
            "values->types->drop_arguments(values->args, 0, pending);",
            "(void)pending;",
            1,
            246,
        ),
        (
            "values->method->result_drop(result);",
            "(void)result;",
            0,
            246,
        ),
        ("values->error_type->drop(error);", "(void)error;", 5, 246),
        (
            "fwp_cleanup_push(&values_cleanup, g_method_values_release, &values);",
            "fwp_cleanup_push(&values_cleanup, owned_no_release, &values);",
            2,
            246,
        ),
        (
            "        g_input_release(&output);",
            "        /* omitted normal output release */",
            14,
            246,
        ),
        (
            "fwp_cleanup_push(&output_cleanup, g_input_release, &output);",
            "fwp_cleanup_push(&output_cleanup, owned_no_release, &output);",
            10,
            246,
        ),
        (
            "fwp_fns[fn].owned->entry(args)",
            "fwp_fns[fn].entry(args)",
            0,
            242, // Unowned dispatch loses the returned value's counted owner.
        ),
    ];
    let dir = fwp::cgen::TempDir::new("served-value-owners").unwrap();
    let exe = dir.join("probe");
    let declaration = "static void owned_no_release(void *);\n";
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{declaration}{generated}\n{fixture}"), &exe, opt).unwrap();
        for stage in [0, 1, 2, 3, 4, 5, 7, 8, 9, 10, 11, 12, 13, 14] {
            for gc in ["off", "on"] {
                for poison in ["0", "1"] {
                    let output = Command::new(&exe)
                        .arg(stage.to_string())
                        .env("FWP_GC", gc)
                        .env("FWP_GC_STRESS", "1")
                        .env("FWP_GC_VERIFY", "1")
                        .env("FWP_REUSE_VERIFY", poison)
                        .output()
                        .unwrap();
                    assert!(
                        output.status.success(),
                        "{opt}/{stage}/{gc}/{poison}: {output:?}"
                    );
                }
            }
        }
        for (before, after, stage, expected) in controls {
            assert_eq!(generated.matches(before).count(), 1, "{before}");
            let broken = generated.replacen(before, after, 1);
            fwp::cgen::compile_c(&format!("{declaration}{broken}\n{fixture}"), &exe, opt).unwrap();
            let output = Command::new(&exe)
                .arg(stage.to_string())
                .env("FWP_GC", "off")
                .env("FWP_REUSE_VERIFY", "0")
                .output()
                .unwrap();
            assert_eq!(output.status.code(), Some(expected), "{before}: {output:?}");
        }
    }
}
