//! Background connection startup owns reserved references until task publication.
use fwp::ir::*;
use std::process::Command;

#[test]
fn grpc_connection_startup_releases_failed_task_reservations() {
    let unit = MT::Record(vec![]);
    let p = Program {
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
    let (generated, _) = fwp::cgen::generate_library(&p, "grpc_startup").unwrap();
    let mut generated = generated;
    for (before,after) in [
        ("g_conn *c = g_conn_new(fd, given, 0);","g_conn *c = g_conn_new(fd, given, 0);pending=c;"),
        ("startup.reader = fwp_spawn_task(0, g_reader, c, 0, 1);","if(stage==0)fwp_trap(\"reader spawn trap\"); startup.reader=fwp_spawn_task(0,g_reader,c,0,1);started_reader=startup.reader;"),
        ("startup.writer = fwp_spawn_task(0, g_writer, c, 0, 1);","if(stage==1)fwp_trap(\"writer spawn trap\"); startup.writer=fwp_spawn_task(0,g_writer,c,0,1);started_writer=startup.writer;"),
    ]{assert_eq!(generated.matches(before).count(),1);generated=generated.replacen(before,after,1);}
    let hooks = r#"
#include <stdlib.h>
static int stage,trapped;
static void *pending,*started_reader,*started_writer;
static void no_release(void *);
static void observed_free(void *);
#define free(p) observed_free(p)
"#;
    let fixture = r#"
#undef free
static void no_release(void *p){(void)p;}
static void observed_free(void *p){if(p==g_connect_start_failed)_Exit(8);free(p);}
static char target[300];static g_conn *result;
static void client(void *arg,int stop){if(stop)_Exit(30);jmp_buf failed;jmp_buf *saved=fwp_cur->trap_jb;fwp_cleanup *saved_cleanup=fwp_cur->trap_cleanup;if(!setjmp(failed)){fwp_cur->trap_jb=&failed;fwp_cur->trap_cleanup=fwp_cleanups;char *error=0;result=g_connect(target,0,&error);if(error)_Exit(31);}else trapped++;fwp_cur->trap_jb=saved;fwp_cur->trap_cleanup=saved_cleanup;}
int main(void){
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));fwp_trap_recover=g_trap_recover;
 for(stage=0;stage<3;stage++){
  V listener=fwp_p_tcp_listen(fwp_cstr("127.0.0.1:0"),0);V address=fwp_p_local_addr(listener);snprintf(target,sizeof target,"%s",STR(address)->d);
  pending=started_reader=started_writer=0;trapped=0;result=0;
  fwp_task *task=fwp_spawn_task(0,client,0,0,0);fwp_await(task);g_conn *c=pending;
  if(!task->done||!c||fwp_cleanups||trapped!=(stage<2))return 2;
  if(stage==0){if(result||g_pool||started_reader||started_writer||c->fd!=-1||c->refs!=0)return 1;if(strcmp(fwp_trap_msg,"reader spawn trap"))return 3;}
  if(stage==1){if(result||g_pool||!started_reader||started_writer||c->refs!=(((fwp_task*)started_reader)->done?0:1)||c->dead!=g_connect_start_failed)return 1;if(strcmp(fwp_trap_msg,"writer spawn trap"))return 4;fwp_await(started_reader);}
  if(stage==2){if(result!=c||g_pool!=c||!started_reader||!started_writer||c->refs!=2||c->dead||fcntl(c->fd,F_GETFD)==-1)return 1;g_conn_dead(c,"finished");fwp_await(started_reader);fwp_await(started_writer);}
  if(c->refs!=0||c->fd!=-1||g_pool||fwp_cleanups)return 1;
  fwp_gc_forget_finalizer(c);g_conn_final(c);
  fwp_p_tcp_stop(listener);FWP_KEEP_ALIVE(listener);FWP_KEEP_ALIVE(PTR(task));FWP_KEEP_ALIVE(PTR(c));
 }
 fwp_lib_finish();return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("grpc-connect-startup").unwrap();
    let exe = dir.join("probe");
    let reserve = "fwp_cleanup_push(&reserved_ref, g_connect_ref_release, c);";
    let startup = "fwp_cleanup_push(&startup_cleanup, g_connect_start_abort, &startup);";
    let marker = "if (c->dead != g_connect_start_failed) free(c->dead);";
    assert_eq!(generated.matches(reserve).count(), 2);
    assert_eq!(generated.matches(startup).count(), 1);
    assert_eq!(generated.matches(marker).count(), 1);
    let controls = [
        (
            generated.replace(reserve, "fwp_cleanup_push(&reserved_ref,no_release,c);"),
            1,
        ),
        (
            generated.replacen(
                startup,
                "fwp_cleanup_push(&startup_cleanup,no_release,&startup);",
                1,
            ),
            1,
        ),
        (generated.replacen(marker, "free(c->dead);", 1), 8),
    ];
    for opt in ["-O1", "-O2"] {
        for (broken, expected) in &controls {
            fwp::cgen::compile_c(&format!("{hooks}\n{broken}\n{fixture}"), &exe, opt).unwrap();
            let out = Command::new(&exe).env("FWP_GC", "off").output().unwrap();
            assert_eq!(
                out.status.code(),
                Some(*expected),
                "omitted cleanup: {out:?}"
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
