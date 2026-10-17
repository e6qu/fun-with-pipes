//! Receive buffers and client request streams release on completion and failure.
use fwp::ir::*;
use std::process::Command;

fn receive_runtime() -> String {
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
    generated
}

#[test]
fn library_unload_closes_idle_connections_before_draining_tasks() {
    let mut generated = receive_runtime();
    for (before, after) in [
        ("static void g_conn_final(void *p) {", "static void g_conn_final(void *p) { if(p==watched_connection)connection_finalized++;"),
        ("static void fwp_library_tasks_finish(void) {", "static void fwp_library_tasks_finish(void) { int64_t test_deadline=fwp_now_ns()+1000000000LL;"),
        ("        while (fwp_gc_tasks) {", "        while (fwp_gc_tasks) { if(fwp_now_ns()>=test_deadline)_Exit(209);"),
    ] {
        assert_eq!(generated.matches(before).count(), 1, "{before}");
        generated = generated.replacen(before, after, 1);
    }
    let fixture = r#"
int main(int argc,char **argv){
 if(argc!=2)return 201;int unpooled=atoi(argv[1]);
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));
 V listener=fwp_p_tcp_listen(fwp_cstr("127.0.0.1:0"),0);
 V address=fwp_p_local_addr(listener);char *error=0;
 g_conn *c=g_connect(STR(address)->d,0,&error);
 if(!c||error||g_pool!=c)return 202;watched_connection=c;
 // Allow reader and writer to enter their normal idle waits.
 fwp_p_task_sleep(fwp_record(1,(V[]){1000000}));
 int readers=0,writers=0;
 for(fwp_task *t=fwp_gc_tasks;t;t=t->gc_next){
  if(t->done||!t->unwinding)return 203;
  readers+=t->cfn==g_reader;writers+=t->cfn==g_writer;
 }
 if(readers!=1||writers!=1||c->refs!=2||c->dead)return 204;
 if(unpooled){g_pool=c->next_pool;c->next_pool=0;g_conn_drop(c);}
 g_conn_drop(c); // caller releases; only I/O and any pool owner remain
 FWP_KEEP_ALIVE(listener);
 fwp_lib_finish();
 if(connection_finalized!=1||g_pool||fwp_cur||fwp_gc_tasks||fwp_gc.ready)return 205;
 return 0;
}
"#;
    let hooks = "static void *watched_connection; static int connection_finalized;";
    let finish = "    g_connections_finish();";
    assert_eq!(generated.matches(finish).count(), 1);
    let broken = generated.replacen(finish, "    /* omitted connection shutdown */", 1);
    let dir = fwp::cgen::TempDir::new("grpc-library-unload").unwrap();
    let binary = dir.join("probe");
    for opt in ["-O1", "-O2"] {
        for (source, expected) in [(&broken, 209), (&generated, 0)] {
            fwp::cgen::compile_c(&format!("{hooks}\n{source}\n{fixture}"), &binary, opt).unwrap();
            for unpooled in ["0", "1"] {
                for gc in ["off", "on"] {
                    let out = Command::new(&binary)
                        .arg(unpooled)
                        .env("FWP_GC", gc)
                        .env("FWP_GC_STRESS", "1")
                        .env("FWP_GC_VERIFY", "1")
                        .env("FWP_REUSE_VERIFY", "1")
                        .output()
                        .unwrap();
                    assert_eq!(
                        out.status.code(),
                        Some(expected),
                        "{opt}/{unpooled}/{gc}: {out:?}"
                    );
                }
            }
        }
    }
}

#[test]
fn received_requests_and_statuses_release_on_errors_and_cancelled_waits() {
    let generated = receive_runtime();
    let hooks = r#"
#if defined(_WIN32) && !defined(_WIN32_WINNT)
#define _WIN32_WINNT 0x0a00
#endif
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
    // Limit the fault injection to the receive owner's destructor. Other
    // message paths also free g->m after decoding and must remain intact.
    let release =
        "static void g_got_release(void *arg) {\n    g_got *g = (g_got *)arg;\n    free(g->m);";
    assert_eq!(generated.matches(release).count(), 1);
    let request_omitted = generated.replacen(
        release,
        &release.replace("free(g->m);", "no_release(g->m);"),
        1,
    );
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

#[test]
fn queued_message_allocation_failure_reports_out_of_memory() {
    let generated = receive_runtime();
    let allocation = "g_msg *m = (g_msg *)malloc(sizeof(g_msg) + mn + 1);";
    assert_eq!(generated.matches(allocation).count(), 1);
    let generated = generated.replace(
        allocation,
        "g_msg *m = (g_msg *)failed_message_allocation(sizeof(g_msg) + mn + 1);",
    );
    let hooks = "#include <stddef.h>\nstatic void *failed_message_allocation(size_t n) { (void)n; return NULL; }\n";
    let fixture = r#"
static int compress_test;
static void attempt(void *arg, int cancelled) {
    (void)arg; (void)cancelled;
    g_stream stream = {0};
    h2_buf payload = {0};
    int compressed = compress_test;
    if (compressed) {
        h2_hdrs_add(&stream.headers, "grpc-encoding", 13, "gzip", 4);
        h2_gzip((const unsigned char *)"message", 7, &payload);
    } else h2b_put(&payload, "message", 7);
    unsigned char header[5] = {(unsigned char)compressed,
        (unsigned char)(payload.len >> 24), (unsigned char)(payload.len >> 16),
        (unsigned char)(payload.len >> 8), (unsigned char)payload.len};
    h2b_put(&stream.data, header, sizeof header);
    h2b_put(&stream.data, payload.d, payload.len);
    g_split(&stream);
    _Exit(201); /* injected failure must terminate before queue publication */
}
int main(int argc, char **argv) {
    (void)argv; compress_test=argc>1;
    fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));fwp_tasks_init();
    fwp_task *task=fwp_spawn_task(0,attempt,0,0,0);fwp_await(task);
    return 201;
}
"#;
    let dir = fwp::cgen::TempDir::new("grpc-message-allocation").unwrap();
    let exe = dir.join("probe");
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{hooks}\n{generated}\n{fixture}"), &exe, opt).unwrap();
        for compressed in [false, true] {
            let mut command = Command::new(&exe);
            if compressed {
                command.arg("gzip");
            }
            let out = command.output().unwrap();
            assert_eq!(out.status.code(), Some(102), "{out:?}");
            assert!(out.stdout.is_empty());
            assert_eq!(
                String::from_utf8(out.stderr).unwrap().replace("\r\n", "\n"),
                "fwp: out of memory\n"
            );
        }
    }
}

#[test]
fn owned_client_streams_release_after_readers_and_senders_finish() {
    let mut generated = receive_runtime();
    let finalizer = "static void g_stream_final(void *p) {";
    assert_eq!(generated.matches(finalizer).count(), 1);
    generated = generated.replace(
        finalizer,
        &format!("{finalizer}\n    probe_stream_finals++;"),
    );
    let spawn = "    fwp_task *t = fwp_spawn_task(0, g_send_all, x, 0, 1);";
    assert_eq!(generated.matches(spawn).count(), 1);
    generated = generated.replace(spawn, &format!("    if(probe_spawn_fail) fwp_trap(\"test spawn preparation\");\n{spawn}\n    probe_sender=t;"));
    let hooks = r#"
#if defined(_WIN32) && !defined(_WIN32_WINNT)
#define _WIN32_WINNT 0x0a00
#endif
#include <stdlib.h>
#include <stddef.h>
static int probe_stream_finals,probe_message_frees,probe_spawn_fail;
static void *probe_message,*probe_sender;
static void observed_message_free(void *);
#define free(p) observed_message_free(p)
"#;
    let fixture = include_str!("fixtures/grpc_client_stream_ownership.c");
    let code = format!("{hooks}\n{generated}\n{fixture}");
    let source_connection =
        "    g_stream_reader_release(c, s);\n    g_conn_drop(c);\n#ifndef FWP_RESOURCE_NO_FREE";
    let sender_connection = "    x->c = 0;\n    g_conn_drop(c);";
    let connection_finalizer = "    fwp_gc_forget_finalizer(c);\n    g_conn_final(c);";
    let connection_storage = "    g_conn_final(c);\n    fwp_rc_resource_free_arr(PTR(c));";
    for marker in [
        source_connection,
        sender_connection,
        connection_finalizer,
        connection_storage,
    ] {
        assert_eq!(code.matches(marker).count(), 1, "{marker}");
    }

    let list_release =
        "    g_stream_drop(s); /* the active-list owner, when this is an owned client stream */";
    let source_release = "    source->s = 0;\n    g_stream_reader_release(c, s);";
    let sender_release = "    x->s = 0;\n    g_stream_drop(s);";
    let finalizer_release = "    fwp_gc_forget_finalizer(s);\n    g_stream_final(s);";
    for marker in [
        list_release,
        source_release,
        sender_release,
        finalizer_release,
    ] {
        assert_eq!(code.matches(marker).count(), 1, "{marker}");
    }
    let controls = [
        (
            code.replace(
                source_connection,
                "    g_stream_reader_release(c, s);\n#ifndef FWP_RESOURCE_NO_FREE",
            ),
            "0",
            221,
        ),
        (code.replace(sender_connection, "    x->c = 0;"), "6", 221),
        (
            code.replace(connection_finalizer, "    g_conn_final(c);"),
            "0",
            222,
        ),
        (
            code.replace(connection_storage, "    g_conn_final(c);"),
            "0",
            223,
        ),
        (code.replace(list_release, "    (void)s;"), "0", 212),
        (
            code.replace(source_release, "    source->s = 0; (void)c; (void)s;"),
            "0",
            211,
        ),
        (code.replace(sender_release, "    x->s = 0;"), "6", 212),
        (
            code.replace(finalizer_release, "    g_stream_final(s);"),
            "0",
            215,
        ),
    ];
    let dir = fwp::cgen::TempDir::new("grpc-client-stream-owners").unwrap();
    for opt in ["-O1", "-O2"] {
        let binary = dir.join("streams.exe");
        for (broken, mode, expected) in &controls {
            fwp::cgen::compile_c(broken, &binary, opt).unwrap();
            let out = Command::new(&binary)
                .arg(mode)
                .env("FWP_GC", "off")
                .env("FWP_GC_STRESS", "0")
                .env("FWP_GC_VERIFY", "0")
                .env("FWP_REUSE_VERIFY", "0")
                .output()
                .unwrap();
            assert_eq!(out.status.code(), Some(*expected), "{opt}/{mode}: {out:?}");
        }
        for no_free in [false, true] {
            let prefix = if no_free {
                "#define FWP_RESOURCE_NO_FREE 1\n"
            } else {
                ""
            };
            fwp::cgen::compile_c(&format!("{prefix}{code}"), &binary, opt).unwrap();
            let mut layout = Vec::new();
            for mode in 0..11 {
                for stress in [false, true] {
                    let out = Command::new(&binary)
                        .arg(mode.to_string())
                        .env("FWP_GC", if stress { "on" } else { "off" })
                        .env("FWP_GC_STRESS", if stress { "1" } else { "0" })
                        .env("FWP_GC_VERIFY", "1")
                        .env("FWP_REUSE_VERIFY", if stress { "1" } else { "0" })
                        .output()
                        .unwrap();
                    assert!(
                        out.status.success(),
                        "{opt}/{mode}/no-free={no_free}/stress={stress}: {out:?}"
                    );
                    if mode == 0 && !stress {
                        layout = out.stdout;
                    }
                }
            }
            if let Some(path) = std::env::var_os("FWP_REPEATED_CLIENT_ARTIFACTS") {
                let path = std::path::PathBuf::from(path).join("stream-owners");
                std::fs::create_dir_all(&path).unwrap();
                std::fs::write(
                    path.join(format!("layout{opt}-no-free-{no_free}.tsv")),
                    &layout,
                )
                .unwrap();
                std::fs::write(
                    path.join(format!("streams-no-free-{no_free}.c")),
                    format!("{prefix}{code}"),
                )
                .unwrap();
                std::fs::copy(
                    &binary,
                    path.join(format!("streams{opt}-no-free-{no_free}.exe")),
                )
                .unwrap();
            }
        }
    }
}

#[test]
fn fatal_runtime_allocations_report_errors_from_task_stacks() {
    let mut generated = receive_runtime();
    for (before, after) in [
        (
            "realloc(b->d, c)",
            "(failure_kind == 0 ? NULL : realloc(b->d, c))",
        ),
        (
            "realloc(h->v, cap * sizeof(h2_hdr))",
            "(failure_kind == 1 ? NULL : realloc(h->v, cap * sizeof(h2_hdr)))",
        ),
        (
            "copy.name = (char *)malloc(nl + 1);",
            "copy.name = failure_kind == 2 ? NULL : (char *)malloc(nl + 1);",
        ),
        (
            "copy.value = (char *)malloc(vl + 1);",
            "copy.value = failure_kind == 3 ? NULL : (char *)malloc(vl + 1);",
        ),
        (
            "char *copy = strdup(text);",
            "char *copy = failure_kind == 4 || failure_kind >= 15 ? NULL : strdup(text);",
        ),
        (
            "unsigned char *alpn = (unsigned char *)strdup(\"\\x02h2\");",
            "unsigned char *alpn = failure_kind == 18 ? NULL : (unsigned char *)strdup(\"\\x02h2\");",
        ),
    ] {
        assert_eq!(generated.matches(before).count(), 1, "{before}");
        generated = generated.replace(before, after);
    }
    for (before, after) in [
        ("realloc(b->d, cap)", "(failure_kind == 9 ? NULL : realloc(b->d, cap))"),
        ("static void *fwp_k_malloc(size_t n) {\n    void *p = malloc(n ? n : 1);", "static void *fwp_k_malloc(size_t n) {\n    void *p = failure_kind == 10 ? NULL : malloc(n ? n : 1);"),
        ("realloc(fwp_tapes, (size_t)cap * sizeof(fwp_tape))", "(failure_kind == 11 ? NULL : realloc(fwp_tapes, (size_t)cap * sizeof(fwp_tape)))"),
        ("realloc(t->pa, (size_t)cap * (2 * sizeof(int32_t)))", "(failure_kind == 12 ? NULL : realloc(t->pa, (size_t)cap * (2 * sizeof(int32_t))))"),
        ("realloc(t->da, (size_t)cap * (2 * sizeof(double)))", "(failure_kind == 13 ? NULL : realloc(t->da, (size_t)cap * (2 * sizeof(double))))"),
        ("calloc((size_t)capacity, sizeof(double))", "(failure_kind == 14 ? NULL : calloc((size_t)capacity, sizeof(double)))"),
    ] {
        assert_eq!(generated.matches(before).count(), 1, "{before}");
        generated = generated.replace(before, after);
    }
    let fixture = r#"
static void attempt_transport(void *arg,int cancelled){
 (void)arg;(void)cancelled;
 h2_buf buffer={0};h2_hdrs headers={0};
 if(failure_kind==0)h2b_reserve(&buffer,1);
 else if(failure_kind<4)h2_hdrs_add(&headers,"name",4,"value",5);
 else if(failure_kind==4){
  g_serving serving={0};g_ctx context={0};context.serving=&serving;
  fwp_cur->gctx=&context;g_fail_call(GRPC_INTERNAL,"failure");
 }else if(failure_kind==5){buffer.len=SIZE_MAX;h2b_reserve(&buffer,1);}
 else if(failure_kind==6)h2_hdrs_add(&headers,"name",SIZE_MAX,"value",5);
 else if(failure_kind==7)fwp_gc_alloc_big(((size_t)1<<62)+1,2);
 else if(failure_kind==8){fwp_buf b={0};b.len=SIZE_MAX;buf_grow(&b,1);}
 else if(failure_kind==9){fwp_buf b={0};buf_grow(&b,1);}
 else if(failure_kind==10)fwp_k_malloc(1);
 else if(failure_kind==11)fwp_ad_tape_new(1,NULL);
 else if(failure_kind==12||failure_kind==13){fwp_tape tape={0};fwp_tape_reserve(&tape,1);}
 else if(failure_kind==14){V base=fwp_ad_tape_new(1,NULL);V empty=fwp_array_new_packed(0,NULL);fwp_p_ad_backward(base,empty,empty);}
 else if(failure_kind==15){g_conn connection={0};connection.fd=FWP_INVALID_SOCKET;g_conn_dead(&connection,"closed");}
 else if(failure_kind==16){g_stream stream={0};g_set_reset(&stream,"reset");}
 else g_strdupf("formatted %s","failure");
 _Exit(201);
}
int main(int argc,char **argv){
 if(argc!=2)return 202;failure_kind=atoi(argv[1]);
 if(failure_kind==18){
  int failed=0;
  SSL_CTX *context=g_server_tls("unused-cert","unused-key","",&failed);
  return context==NULL&&failed==1?0:203;
 }
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));fwp_tasks_init();
 fputs("before fatal allocation\n",stdout);
 fwp_task *task=fwp_spawn_task(0,attempt_transport,0,0,0);fwp_await(task);
 return 201;
}
"#;
    let dir = fwp::cgen::TempDir::new("grpc-fatal-transport").unwrap();
    let binary = dir.join("probe");
    for opt in ["-O1", "-O2"] {
        let code = format!("static int failure_kind = -1;\n{generated}\n{fixture}");
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();
        let recoverable = Command::new(&binary).arg("18").output().unwrap();
        assert!(recoverable.status.success(), "{opt}: {recoverable:?}");
        assert!(recoverable.stdout.is_empty());
        assert_eq!(
            String::from_utf8(recoverable.stderr)
                .unwrap()
                .replace("\r\n", "\n"),
            "fwp serve: cannot allocate TLS protocol list\n"
        );
        for kind in 0..18 {
            let out = Command::new(&binary)
                .arg(kind.to_string())
                .output()
                .unwrap();
            assert_eq!(out.status.code(), Some(102), "{opt}/{kind}: {out:?}");
            assert_eq!(
                String::from_utf8(out.stdout).unwrap().replace("\r\n", "\n"),
                "before fatal allocation\n"
            );
            let expected = match kind {
                5 => "fwp: HTTP/2 buffer too large\n",
                6 => "fwp: HTTP/2 headers too large\n",
                _ => "fwp: out of memory\n",
            };
            assert_eq!(
                String::from_utf8(out.stderr).unwrap().replace("\r\n", "\n"),
                expected
            );
        }
    }
}
