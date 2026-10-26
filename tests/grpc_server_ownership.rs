//! Scheduler cancellation closes service listener and its TLS protocol owner.
use fwp::ir::*;
use std::process::Command;

#[test]
fn cancelling_grpc_server_releases_listener_and_preserves_accepted_owners() {
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
    let (generated, _header) = fwp::cgen::generate_library(&p, "resources", &[]).unwrap();
    let generated = generated
        .replace("    if (failed) return 1;", "    if (failed) return 1; watched_ctx=tls;if(tls){fwp_tls_server_owner *o=SSL_CTX_get_app_data(tls);watched_wire=o->alpn.w;watched_owner=o;}")
        .replace("fwp_socket_t fd = h2_listen(hostport, bound, sizeof bound);", "fwp_socket_t fd = h2_listen(hostport, bound, sizeof bound); watched_fd=fd;")
        .replace("    fwp_cleanup_push(&cleanup, g_listener_finish, &listener);", "    fwp_cleanup_push(&cleanup, g_listener_finish, &listener); if(fail_stage==1){fwp_cancel_tree(fwp_cur);fwp_check_cancel();}")
        .replace("    g_server *srv = (g_server *)fwp_mem_alloc(sizeof *srv);", "    if(fail_stage==2){fwp_cancel_tree(fwp_cur);fwp_check_cancel();} g_server *srv = (g_server *)fwp_mem_alloc(sizeof *srv);");
    let hooks = r#"
#if defined(_WIN32) && !defined(_WIN32_WINNT)
#define _WIN32_WINNT 0x0a00
#endif
#include <stdlib.h>
#include <stdint.h>
#include <openssl/ssl.h>
static SSL_CTX *watched_ctx;static void *watched_wire,*watched_owner;
static uintptr_t watched_fd;
static int contexts,wires,owners,cancelled,fail_stage,plain;
static void observe_ctx_free(SSL_CTX *ctx);
static void observe_free(void *p);
#define SSL_CTX_free(p) observe_ctx_free(p)
#define free(p) observe_free(p)
"#;
    let fixture = r#"
#undef SSL_CTX_free
#undef free
static void observe_ctx_free(SSL_CTX *ctx){if(ctx==watched_ctx)contexts++;SSL_CTX_free(ctx);}
static void observe_free(void *p){if(p){if(p==watched_wire)wires++;if(p==watched_owner)owners++;}free(p);}
/* Keep native socket handles at their platform width and verify closure with
 * the OS, independently of the cleanup instrumentation. */
static int listener_closed(void){
 int kind=0;socklen_t n=sizeof kind;
#ifdef _WIN32
 return getsockopt((SOCKET)watched_fd,SOL_SOCKET,SO_TYPE,(char *)&kind,&n)==SOCKET_ERROR && WSAGetLastError()==WSAENOTSOCK;
#else
 return getsockopt((int)watched_fd,SOL_SOCKET,SO_TYPE,&kind,&n)==-1 && errno==EBADF;
#endif
}
/* Use loopback TCP on every host; the TLS handshake below uses a BIO pair. */
static int connected_pair(fwp_socket_t pair[2]){
 fwp_socket_t listener=socket(AF_INET,SOCK_STREAM,0);
 if(listener==FWP_INVALID_SOCKET)return 0;
 struct sockaddr_in addr={0};addr.sin_family=AF_INET;addr.sin_addr.s_addr=htonl(INADDR_LOOPBACK);
 socklen_t n=sizeof addr;
 if(bind(listener,(struct sockaddr *)&addr,sizeof addr)||listen(listener,1)||getsockname(listener,(struct sockaddr *)&addr,&n)){fwp_socket_close(listener);return 0;}
 pair[1]=socket(AF_INET,SOCK_STREAM,0);
 if(pair[1]==FWP_INVALID_SOCKET){fwp_socket_close(listener);return 0;}
 if(connect(pair[1],(struct sockaddr *)&addr,sizeof addr)){fwp_socket_close(pair[1]);fwp_socket_close(listener);return 0;}
 pair[0]=accept(listener,0,0);fwp_socket_close(listener);
 if(pair[0]==FWP_INVALID_SOCKET){fwp_socket_close(pair[1]);return 0;}
 return 1;
}
static int handshake(SSL *server){
 SSL_CTX *ctx=SSL_CTX_new(TLS_client_method());if(!ctx)return 0;
 SSL *client=SSL_new(ctx);SSL_CTX_free(ctx);if(!client)return 0;
 SSL_set_connect_state(client);SSL_set_alpn_protos(client,(const unsigned char *)"\x02h2",3);
 BIO *a=0,*b=0;if(!BIO_new_bio_pair(&a,0,&b,0)){SSL_free(client);return 0;}
 SSL_set_bio(server,a,a);SSL_set_bio(client,b,b);
 for(int i=0;i<20&&(!SSL_is_init_finished(server)||!SSL_is_init_finished(client));i++){
  int r=SSL_do_handshake(client);if(r!=1){int e=SSL_get_error(client,r);if(e!=SSL_ERROR_WANT_READ&&e!=SSL_ERROR_WANT_WRITE){SSL_free(client);return 0;}}
  r=SSL_do_handshake(server);if(r!=1){int e=SSL_get_error(server,r);if(e!=SSL_ERROR_WANT_READ&&e!=SSL_ERROR_WANT_WRITE){SSL_free(client);return 0;}}
 }
 const unsigned char *protocol=0;unsigned n=0;SSL_get0_alpn_selected(server,&protocol,&n);
 int ok=SSL_is_init_finished(server)&&SSL_is_init_finished(client)&&n==2&&!memcmp(protocol,"h2",2);
 SSL_free(client);return ok;
}
static char *cert,*key;
static void server(void *arg,int stop){
 if(stop){cancelled++;return;}
 fwp_service service={0};service.module="probe";service.env="FWP_TEST_LISTEN";service.default_addr="127.0.0.1:0";
 char *args[]={"probe","--tls-cert",cert,"--tls-key",key};
 (void)fwp_serve(&service,plain?1:5,args);
}
int main(int argc,char **argv){
 if(argc!=3)return 30;cert=argv[1];key=argv[2];fwp_lib_init();
 for(int accepted=0;accepted<2;accepted++){
  contexts=wires=owners=cancelled=0;watched_fd=(uintptr_t)FWP_INVALID_SOCKET;watched_ctx=0;watched_wire=watched_owner=0;
  fwp_task *task=fwp_spawn_task(0,server,0,0,0);fwp_p_task_yield();
  if(watched_fd==(uintptr_t)FWP_INVALID_SOCKET||!watched_ctx||task->done)return 31;
  fwp_socket_t pair[2];SSL *session=0;if(accepted){if(!connected_pair(pair))return 32;session=fwp_tls_accepted(watched_ctx,pair[0]);if(!session)return 33;}
  fwp_p_task_cancel(PTR(task));fwp_await(task);
  if(!task->done||cancelled!=1||fwp_cleanups)return 34;
  if(!listener_closed())return 1;
  if(!accepted){if(contexts!=1||wires!=1||owners!=1)return 2;}
  else {
   if(contexts||wires||owners)return 3;
   if(!handshake(session))return 5;
   fwp_tls_dispose(session);fwp_socket_close(pair[0]);fwp_socket_close(pair[1]);
   if(contexts!=1||wires!=1||owners!=1)return 4;
  }
 }
 for(fail_stage=1;fail_stage<=2;fail_stage++){
  contexts=wires=owners=cancelled=0;watched_fd=(uintptr_t)FWP_INVALID_SOCKET;watched_ctx=0;watched_wire=watched_owner=0;
  fwp_task *task=fwp_spawn_task(0,server,0,0,0);fwp_await(task);
  if(!task->done||cancelled!=1||fwp_cleanups||contexts!=1||wires!=1||owners!=1)return 6;
  if(fail_stage==2&&(watched_fd==(uintptr_t)FWP_INVALID_SOCKET||!listener_closed()))return 7;
 }
 fail_stage=0;plain=1;contexts=wires=owners=cancelled=0;watched_fd=(uintptr_t)FWP_INVALID_SOCKET;watched_ctx=0;watched_wire=watched_owner=0;
 fwp_task *task=fwp_spawn_task(0,server,0,0,0);fwp_p_task_yield();
 if(watched_fd==(uintptr_t)FWP_INVALID_SOCKET||watched_ctx||task->done)return 8;
 fwp_p_task_cancel(PTR(task));fwp_await(task);
 if(cancelled!=1||fwp_cleanups||!listener_closed()||contexts||wires||owners)return 9;
 return 0;
}
"#;
    let dir = std::env::temp_dir().join(format!("fwp-grpc-server-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let openssl = std::env::var("FWP_OPENSSL_DIR")
        .map(|p| {
            if cfg!(windows) {
                format!("{p}/tools/openssl/openssl.exe")
            } else {
                format!("{p}/bin/openssl")
            }
        })
        .unwrap_or_else(|_| "openssl".into());
    let out = Command::new(openssl)
        .args([
            "req",
            "-x509",
            "-newkey",
            "rsa:2048",
            "-nodes",
            "-keyout",
            "key.pem",
            "-out",
            "cert.pem",
            "-days",
            "2",
            "-subj",
            "/CN=localhost",
        ])
        .current_dir(&dir)
        .output()
        .unwrap();
    assert!(
        out.status.success(),
        "{}",
        String::from_utf8_lossy(&out.stderr)
    );
    let exe = dir.join("probe");
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{hooks}\n{generated}\n{fixture}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let out = Command::new(&exe)
                .args([dir.join("cert.pem"), dir.join("key.pem")])
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
    for (needle, replacement, expected) in [
        (
            "    fwp_cleanup_push(&cleanup, g_listener_finish, &listener);",
            "    /* omit listener guard */",
            1,
        ),
        (
            "        owner->fd = FWP_INVALID_SOCKET;\n        fwp_fd_closing(fd);\n        fwp_socket_close(fd);",
            "        owner->fd = FWP_INVALID_SOCKET; /* omit listener close */",
            1,
        ),
        (
            "        fwp_tls_server_drop(ctx);",
            "        /* omit server context owner */",
            2,
        ),
    ] {
        assert!(generated.contains(needle), "missing control {needle}");
        let start = generated
            .find("static void g_listener_finish(void *p) {")
            .unwrap();
        let end = start + generated[start..].find("\n}\n").unwrap() + 3;
        let mut broken = generated.clone();
        if needle.contains("owner->fd") || needle.contains("fwp_tls_server_drop") {
            let listener = &generated[start..end];
            assert_eq!(listener.matches(needle).count(), 1);
            broken.replace_range(start..end, &listener.replacen(needle, replacement, 1));
        } else {
            assert_eq!(generated.matches(needle).count(), 1);
            broken = generated.replacen(needle, replacement, 1);
        }
        fwp::cgen::compile_c(&format!("{hooks}\n{broken}\n{fixture}"), &exe, "-O1").unwrap();
        let out = Command::new(&exe)
            .args([dir.join("cert.pem"), dir.join("key.pem")])
            .output()
            .unwrap();
        assert_eq!(
            out.status.code(),
            Some(expected),
            "control {needle}: {}",
            String::from_utf8_lossy(&out.stderr)
        );
    }
    std::fs::remove_dir_all(dir).unwrap();
}
