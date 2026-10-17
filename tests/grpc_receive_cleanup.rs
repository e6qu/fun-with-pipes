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
    let list_release =
        "    g_stream_drop(s); /* the active-list owner, when this is an owned client stream */";
    let source_release = "    g_stream_reader_release(c, s);";
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
        (code.replace(list_release, "    (void)s;"), "0", 212),
        (
            code.replace(source_release, "    (void)c; (void)s;"),
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
            for mode in 0..10 {
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
