//! Cancellation unwinds pending TCP and TLS connection resources.
use fwp::ir::*;
use std::process::Command;

#[test]
fn cancelled_connect_and_handshake_release_completed_resource_owners() {
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
    let (generated, _header) = fwp::cgen::generate_library(&p, "resources").unwrap();
    let generated=generated
        .replace("            fwp_wait_fd(fd, 1, 0);", "            if(mode==1){phase=1;fwp_park(0,0);fwp_check_cancel();} fwp_wait_fd(fd,1,0);")
        .replace("    V result = fwp_sock_new(fd, 1);", "    if(mode==3){phase=1;fwp_park(0,0);fwp_check_cancel();} V result = fwp_sock_new(fd,1);")
        .replace("    unsigned alpn_n;", "    if(mode==4){phase=1;fwp_park(0,0);fwp_check_cancel();} unsigned alpn_n;");
    let hooks = r#"
#include <stdlib.h>
#include <sys/socket.h>
#include <netdb.h>
#include <openssl/ssl.h>
static int mode,phase,watched_fd=-1,res_freed,ssl_freed,cancelled;static struct addrinfo *watched_res;
static int observe_connect(int fd,const struct sockaddr *addr,socklen_t len);
static int observe_resolve(const char *host,const char *port,const struct addrinfo *hints,struct addrinfo **res);
static void observe_res_free(struct addrinfo *res);
static void observe_ssl_free(SSL *ssl);
static int observe_handshake(SSL *ssl);
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
static int observe_connect(int fd,const struct sockaddr *addr,socklen_t len){watched_fd=fd;int result=connect(fd,addr,len);if(mode==1&&(result==0||errno==EINPROGRESS)){errno=EINPROGRESS;return -1;}return result;}
static int observe_resolve(const char *host,const char *port,const struct addrinfo *hints,struct addrinfo **res){int result=getaddrinfo(host,port,hints,res);if(mode&&!result)watched_res=*res;return result;}
static void observe_res_free(struct addrinfo *res){if(mode&&res==watched_res)res_freed++;freeaddrinfo(res);}
static void observe_ssl_free(SSL *ssl){if(mode)ssl_freed++;SSL_free(ssl);}
static int observe_handshake(SSL *ssl){if(mode==2)phase=1;return SSL_do_handshake(ssl);}
static V target;
static void client(void *arg,int stop){
 if(stop){cancelled++;return;}
 if(mode==1||mode==3){(void)fwp_p_tcp_connect(target,0);return;}
 V empty=fwp_cstr("");
 (void)fwp_p_tls_connect(empty,FWP_TRUE,empty,0,empty,empty,target,0);
}
static int probe(void){
 fwp_lib_init();V tick=fwp_record(1,(V[]){1000000});
 for(int test=1;test<=4;test++){
  mode=0;V listener=fwp_p_tcp_listen(fwp_cstr("127.0.0.1:0"),0);target=fwp_p_local_addr(listener);
  mode=test;phase=res_freed=ssl_freed=cancelled=0;watched_fd=-1;watched_res=0;
  fwp_task *task=fwp_spawn_task(0,client,0,0,0);
  for(int i=0;i<30&&!phase;i++)fwp_p_task_sleep(tick);
  if(!phase||task->done||watched_fd<0)return 31;
  fwp_p_task_cancel(PTR(task));fwp_await(task);
  if(!task->done||cancelled!=1||fwp_cleanups)return 32;
  if(fcntl(watched_fd,F_GETFD)!=-1||errno!=EBADF)return 1;
  if(res_freed!=1)return 2;
  if(ssl_freed!=(mode==2?1:0))return 3;
  mode=0;fwp_p_tcp_stop(listener);
 }
 mode=0;V listener=fwp_p_tcp_listen(fwp_cstr("127.0.0.1:0"),0);target=fwp_p_local_addr(listener);
 mode=5;res_freed=ssl_freed=0;watched_res=0;V result=fwp_p_tcp_connect(target,0);
 if(fwp_cleanups||res_freed!=1||fcntl(SOCK(result)->fd,F_GETFD)==-1)return 4;
 fwp_p_sock_close(result);fwp_p_sock_close(result);mode=0;fwp_p_tcp_stop(listener);
 // Refusal also releases the resolver and failed descriptor before the error.
 mode=5;res_freed=0;watched_res=0;watched_fd=-1;
 fwp_handler h={0};h.prev=fwp_handlers;h.cleanup=fwp_cleanups;h.state_depth=fwp_state_len;fwp_handlers=&h;
 if(!setjmp(h.jb)){(void)fwp_p_tcp_connect(target,0);return 5;}
 fwp_handlers=h.prev;if(res_freed!=1||fwp_cleanups!=h.cleanup||watched_fd<0||fcntl(watched_fd,F_GETFD)!=-1||errno!=EBADF)return 6;
 mode=0;
 return 0;
}
int main(void){int status=probe();if(status)_Exit(status);return 0;}
"#;
    let dir = std::env::temp_dir().join(format!("fwp-connect-cleanup-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let exe = dir.join("probe");
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{hooks}\n{generated}\n{fixture}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let out = Command::new(&exe)
                .env("FWP_REUSE_VERIFY", poison)
                .output()
                .unwrap();
            assert!(
                out.status.success(),
                "{opt}, poison {poison}: {:?}: {}",
                out.status.code(),
                String::from_utf8_lossy(&out.stderr)
            );
        }
    }
    for (needle,replacement,expected) in [
        ("    fwp_cleanup_push(&cleanup, fwp_connect_finish, &owner);", "    /* omit pending connect guard */",1),
        ("    if (owner->addresses) { freeaddrinfo(owner->addresses); owner->addresses = 0; }", "    owner->addresses=0; /* omit resolver release */",2),
        ("    fwp_cleanup_push(&cleanup, fwp_tls_connect_drop, &c);", "    /* omit TLS connect owner */",1),
        ("if (SOCK(c)->kind == 1 && SOCK(c)->tls) { fwp_tls_free(SOCK(c)->tls); SOCK(c)->tls = 0; }", "if (0) { /* omit SSL release */ }",3),
    ] {
        assert!(generated.contains(needle),"missing control {needle}");
        let broken=generated.replacen(needle,replacement,1);
        fwp::cgen::compile_c(&format!("{hooks}\n{broken}\n{fixture}"),&exe,"-O1").unwrap();
        let out=Command::new(&exe).output().unwrap();
        assert_eq!(out.status.code(),Some(expected),"control {needle}: {}",String::from_utf8_lossy(&out.stderr));
    }
    std::fs::remove_dir_all(dir).unwrap();
}
