//! gRPC connection preparation owns resolver/socket/TLS resources until transfer.
use fwp::ir::*;
use std::process::Command;

#[test]
fn grpc_connect_and_handshake_release_pending_resources_on_cancellation() {
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
    let (generated, _) = fwp::cgen::generate_library(&p, "grpc_connect").unwrap();
    let start = generated.find("static g_conn *g_connect(").unwrap();
    let end = start
        + generated[start..]
            .find("\nstatic void g_timeout_header")
            .unwrap();
    let mut method = generated[start..end].to_owned();
    for (before,after) in [
        ("            fwp_wait_fd(fd, 1, 0);","            if(mode==1){phase=1;fwp_park(0,0);fwp_check_cancel();} fwp_wait_fd(fd,1,0);"),
        ("    g_conn *c = g_conn_new(fd, given, 0);","    if(mode==3){phase=1;fwp_park(0,0);fwp_check_cancel();} g_conn *c = g_conn_new(fd,given,0);"),
        ("fwp_spawn_task(0, g_reader, c, 0, 1);","backgrounds++;"),
        ("fwp_spawn_task(0, g_writer, c, 0, 1);","backgrounds++;"),
    ]{assert_eq!(method.matches(before).count(),1);method=method.replacen(before,after,1);}
    let generated = format!("{}{}{}", &generated[..start], method, &generated[end..]);
    let hooks = r#"
#include <stdlib.h>
#include <sys/socket.h>
#include <netdb.h>
#include <openssl/ssl.h>
static int mode,phase,watched_fd=-1,res_freed,ssl_freed,cancelled,backgrounds;
static struct addrinfo *watched_res;
static int observe_connect(int,const struct sockaddr *,socklen_t);
static int observe_resolve(const char *,const char *,const struct addrinfo *,struct addrinfo **);
static void observe_res_free(struct addrinfo *);
static void observe_ssl_free(SSL *);
static int observe_handshake(SSL *);
static void no_release(void *);
#define connect(f,a,n) observe_connect(f,a,n)
#define getaddrinfo(h,p,i,r) observe_resolve(h,p,i,r)
#define freeaddrinfo(r) observe_res_free(r)
#define SSL_free(p) observe_ssl_free(p)
#define SSL_do_handshake(p) observe_handshake(p)
"#;
    let fixture = r#"
#undef connect
#undef getaddrinfo
#undef freeaddrinfo
#undef SSL_free
#undef SSL_do_handshake
static int observe_connect(int fd,const struct sockaddr *a,socklen_t n){watched_fd=fd;int result=connect(fd,a,n);if(mode==1&&(result==0||errno==EINPROGRESS)){errno=EINPROGRESS;return -1;}return result;}
static int observe_resolve(const char *h,const char *p,const struct addrinfo *i,struct addrinfo **r){int result=getaddrinfo(h,p,i,r);if(mode&&!result)watched_res=*r;return result;}
static void observe_res_free(struct addrinfo *r){if(mode&&r==watched_res){res_freed++;watched_res=0;}freeaddrinfo(r);}
static void observe_ssl_free(SSL *s){if(mode)ssl_freed++;SSL_free(s);}
static int observe_handshake(SSL *s){if(mode==2)phase=1;return SSL_do_handshake(s);}
static void no_release(void *p){(void)p;}
static char target[300];static g_conn *result;
static void client(void *arg,int stop){if(stop){cancelled++;return;}char *error=0;result=g_connect(target,0,&error);if(error)_Exit(33);}
int main(void){
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));V tick=fwp_record(1,(V[]){1000000});
 for(int test=1;test<=3;test++){
  mode=0;V listener=fwp_p_tcp_listen(fwp_cstr("127.0.0.1:0"),0);V address=fwp_p_local_addr(listener);
  snprintf(target,sizeof target,"%s%s",test==2?"https://":"",STR(address)->d);
  mode=test;phase=res_freed=ssl_freed=cancelled=backgrounds=0;watched_fd=-1;watched_res=0;result=0;
  fwp_task *task=fwp_spawn_task(0,client,0,0,0);
  for(int i=0;i<30&&!phase;i++)fwp_p_task_sleep(tick);
  if(!phase||task->done||watched_fd<0)return 31;
  fwp_p_task_cancel(PTR(task));fwp_await(task);
  if(!task->done||cancelled!=1||result||backgrounds||fwp_cleanups)return 32;
  if(fcntl(watched_fd,F_GETFD)!=-1||errno!=EBADF)return 1;
  if(res_freed!=1)return 2;if(ssl_freed!=(mode==2?1:0))return 3;
  mode=0;fwp_p_tcp_stop(listener);FWP_KEEP_ALIVE(listener);FWP_KEEP_ALIVE(tick);
 }
 mode=0;V listener=fwp_p_tcp_listen(fwp_cstr("127.0.0.1:0"),0);V address=fwp_p_local_addr(listener);snprintf(target,sizeof target,"%s",STR(address)->d);
 mode=4;res_freed=ssl_freed=backgrounds=0;watched_res=0;char *error=0;g_conn *c=g_connect(target,0,&error);
 if(!c||error||c->refs!=2||backgrounds!=2||res_freed!=1||ssl_freed||fwp_cleanups||fcntl(c->fd,F_GETFD)==-1)return 4;
 int fd=c->fd;g_conn_release(c);if(c->fd!=fd||fcntl(fd,F_GETFD)==-1)return 5;
 g_conn_release(c);if(c->fd!=-1||fcntl(fd,F_GETFD)!=-1||errno!=EBADF)return 6;
 g_pool=0;mode=0;fwp_p_tcp_stop(listener);
 mode=4;res_freed=ssl_freed=backgrounds=0;watched_res=0;watched_fd=-1;
 c=g_connect(target,0,&error);if(c||!error||strncmp(error,"cannot connect to ",18)||res_freed!=1||ssl_freed||backgrounds||fwp_cleanups||watched_fd<0||fcntl(watched_fd,F_GETFD)!=-1||errno!=EBADF)return 7;free(error);
 mode=0;FWP_KEEP_ALIVE(listener);FWP_KEEP_ALIVE(tick);fwp_lib_finish();return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("grpc-connect-cleanup").unwrap();
    let exe = dir.join("probe");
    let pending = "fwp_cleanup_push(&connect_cleanup, fwp_connect_finish, &owner);";
    let tls = "fwp_cleanup_push(&ssl_cleanup, g_connect_ssl_release, &ssl);";
    assert_eq!(generated.matches(pending).count(), 1);
    assert_eq!(generated.matches(tls).count(), 1);
    for opt in ["-O1", "-O2"] {
        for (needle, replacement, expected) in [
            (
                pending,
                "fwp_cleanup_push(&connect_cleanup,no_release,&owner);",
                1,
            ),
            (tls, "fwp_cleanup_push(&ssl_cleanup,no_release,&ssl);", 3),
        ] {
            let broken = generated.replacen(needle, replacement, 1);
            fwp::cgen::compile_c(&format!("{hooks}\n{broken}\n{fixture}"), &exe, opt).unwrap();
            let out = Command::new(&exe).output().unwrap();
            assert_eq!(
                out.status.code(),
                Some(expected),
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
