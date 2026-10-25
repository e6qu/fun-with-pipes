//! Background connection startup owns reserved references until task publication.
use fwp::ir::*;
use std::process::Command;

#[test]
fn grpc_connection_startup_releases_failed_task_reservations() {
    fwp::cgen::set_native_options(fwp::cgen::NativeOptions {
        arc: false,
        ..Default::default()
    });
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
    let (generated, _) = fwp::cgen::generate_library(&p, "grpc_startup", &[]).unwrap();
    let mut generated = generated;
    for (before,after) in [
        ("static void g_conn_final(void *p) {", "static void g_conn_final(void *p) { if(p==pending)finalized++;"),
        ("g_conn *c = g_conn_new(fd, \"\", given, 0);","g_conn *c = g_conn_new(fd, \"\", given, 0);pending=c;"),
        ("startup.reader = fwp_spawn_task(0, g_reader, c, 0, 1);","if(stage==0)fwp_trap(\"reader spawn trap\"); startup.reader=fwp_spawn_task(0,g_reader,c,0,1);started_reader=startup.reader;"),
        ("startup.writer = fwp_spawn_task(0, g_writer, c, 0, 1);","if(stage==1)fwp_trap(\"writer spawn trap\"); startup.writer=fwp_spawn_task(0,g_writer,c,0,1);started_writer=startup.writer;"),
    ]{assert_eq!(generated.matches(before).count(),1);generated=generated.replacen(before,after,1);}
    let hooks = r#"
#if defined(_WIN32) && !defined(_WIN32_WINNT)
#define _WIN32_WINNT 0x0a00
#endif
#include <stdlib.h>
static int stage,trapped,finalized,wait_probe_active;
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
static int wait_entered,wait_finished,wait_cancelled;
static int64_t wait_until;
static void check_current_wait_released(void){
#ifndef __linux__
 for(fwp_poll_wait *w=fwp_poll_waits;w;w=w->next)if(w->task==fwp_cur)_Exit(43);
#endif
}
static void wait_socket(void *arg,int cancelled){
 if(cancelled){check_current_wait_released();wait_cancelled++;return;}
 wait_entered++;
 int ready=fwp_wait_fd(*(fwp_socket_t *)arg,0,wait_until);
 check_current_wait_released(); /* detect a stale node before its task stack is freed */
 if(ready!=(wait_until==0))_Exit(41);
 wait_finished++;
}
static void check_wait_lifetimes(void){
 wait_probe_active=1;
 for(int mode=0;mode<4;mode++){
  V listener=fwp_p_tcp_listen(fwp_cstr("127.0.0.1:0"),0);
  fwp_socket_t fd=SOCK(listener)->fd;
  wait_entered=wait_finished=wait_cancelled=0;
  wait_until=mode==0?fwp_now_ns()+100000000LL:0;
  int64_t deadline=mode==3?fwp_now_ns()+100000000LL:0;
  fwp_task *first=fwp_spawn_task(0,wait_socket,&fd,deadline,0);
  fwp_task *second=fwp_spawn_task(0,wait_socket,&fd,deadline,0);
  while(wait_entered!=2)fwp_p_task_yield();
  if(mode==1){fwp_cancel_tree(first);fwp_cancel_tree(second);}
  if(mode==2)fwp_fd_closing(fd); /* both parked readers must wake */
  int64_t drain=fwp_now_ns()+5000000000LL;
  while(!first->done||!second->done){
   if(fwp_now_ns()>=drain)_Exit(44);
   fwp_park(0,fwp_now_ns()+1000000LL);fwp_free_zombie();
  }
  fwp_await(first);fwp_await(second);fwp_free_zombie();
  int cancelled=mode==1||mode==3;
  if(wait_finished!=(cancelled?0:2)||wait_cancelled!=(cancelled?2:0)||fwp_cleanups)_Exit(42);
#ifndef __linux__
  if(fwp_poll_waits)_Exit(43);
#endif
  fwp_p_tcp_stop(listener);FWP_KEEP_ALIVE(listener);
 }
}
int main(void){
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));fwp_trap_recover=g_trap_recover;
 for(stage=0;stage<3;stage++){
  V listener=fwp_p_tcp_listen(fwp_cstr("127.0.0.1:0"),0);V address=fwp_p_local_addr(listener);snprintf(target,sizeof target,"%s",STR(address)->d);
  pending=started_reader=started_writer=0;trapped=finalized=0;result=0;
  fwp_task *task=fwp_spawn_task(0,client,0,0,0);fwp_await(task);g_conn *c=pending;
  if(!task->done||!c||fwp_cleanups||trapped!=(stage<2))return 2;
  if(stage==0){if(result||g_pool||started_reader||started_writer)return 1;if(strcmp(fwp_trap_msg,"reader spawn trap"))return 3;}
  if(stage==1){if(result||g_pool||!started_reader||started_writer)return 1;if(strcmp(fwp_trap_msg,"writer spawn trap"))return 4;}
  if(stage==2){int kind=0;socklen_t n=sizeof kind;if(result!=c||g_pool!=c||!started_reader||!started_writer||c->refs!=2||c->dead||getsockopt(c->fd,SOL_SOCKET,SO_TYPE,(char *)&kind,&n))return 1;g_conn_dead(c,"finished");}
  // A ready root would prevent the scheduler from polling the closed socket.
  // Park briefly so its reader wakes naturally; never await a freed I/O handle.
  int64_t drain_deadline=fwp_now_ns()+10000000000LL;
  while(fwp_gc_tasks){
   if(fwp_now_ns()>=drain_deadline){fprintf(stderr,"startup drain timed out at stage %d\n",stage);return 9;}
   fwp_park(0,fwp_now_ns()+1000000LL);fwp_free_zombie();
  }fwp_free_zombie();
  if(stage==2){if(c->refs||c->fd!=FWP_INVALID_SOCKET||finalized)return 1;g_conn_drop(c);result=0;}
  if(finalized!=1||g_pool||fwp_cleanups)return 1;
  fwp_p_tcp_stop(listener);FWP_KEEP_ALIVE(listener);FWP_KEEP_ALIVE(PTR(task));
 }
 check_wait_lifetimes();fwp_lib_finish();return 0;
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
    let mut controls = vec![
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
    if cfg!(windows) {
        let wake =
            "    fwp_fd_closing(c->fd); /* wake I/O before shutdown, including polling hosts */";
        assert_eq!(generated.matches(wake).count(), 1);
        // Without the explicit wake, WSAPoll leaves the local reader parked.
        controls.push((generated.replacen(wake, "", 1), 9));
    }
    if !cfg!(target_os = "linux") {
        let unlink =
            "    fwp_poll_wait_remove(&wait); /* unlink before fwp_check_cancel can unwind */";
        assert_eq!(generated.matches(unlink).count(), 1);
        controls.push((
            generated.replacen(
                unlink,
                "    if(!wait_probe_active) fwp_poll_wait_remove(&wait);",
                1,
            ),
            43,
        ));
    }
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
