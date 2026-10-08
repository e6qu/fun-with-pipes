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
    let generated = generated
        .replace("    if (failed) return 1;", "    if (failed) return 1; watched_ctx=tls;if(tls){fwp_tls_server_owner *o=SSL_CTX_get_app_data(tls);watched_wire=o->alpn.w;watched_owner=o;}")
        .replace("int fd = h2_listen(hostport, bound, sizeof bound);", "int fd = h2_listen(hostport, bound, sizeof bound); watched_fd=fd;")
        .replace("    fwp_cleanup_push(&cleanup, g_listener_finish, &listener);", "    fwp_cleanup_push(&cleanup, g_listener_finish, &listener); if(fail_stage==1){fwp_cancel_tree(fwp_cur);fwp_check_cancel();}")
        .replace("    g_server *srv = (g_server *)fwp_mem_alloc(sizeof *srv);", "    if(fail_stage==2){fwp_cancel_tree(fwp_cur);fwp_check_cancel();} g_server *srv = (g_server *)fwp_mem_alloc(sizeof *srv);");
    let hooks = r#"
#include <stdlib.h>
#include <openssl/ssl.h>
static SSL_CTX *watched_ctx;static void *watched_wire,*watched_owner;
static int watched_fd=-1,contexts,wires,owners,cancelled,fail_stage,plain;
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
  contexts=wires=owners=cancelled=0;watched_fd=-1;watched_ctx=0;watched_wire=watched_owner=0;
  fwp_task *task=fwp_spawn_task(0,server,0,0,0);fwp_p_task_yield();
  if(watched_fd<0||!watched_ctx||task->done)return 31;
  int pair[2];SSL *session=0;if(accepted){if(socketpair(AF_UNIX,SOCK_STREAM,0,pair))return 32;session=fwp_tls_accepted(watched_ctx,pair[0]);if(!session)return 33;}
  fwp_p_task_cancel(PTR(task));fwp_await(task);
  if(!task->done||cancelled!=1||fwp_cleanups)return 34;
  if(fcntl(watched_fd,F_GETFD)!=-1||errno!=EBADF)return 1;
  if(!accepted){if(contexts!=1||wires!=1||owners!=1)return 2;}
  else {
   if(contexts||wires||owners)return 3;
   if(!handshake(session))return 5;
   fwp_tls_dispose(session);close(pair[0]);close(pair[1]);
   if(contexts!=1||wires!=1||owners!=1)return 4;
  }
 }
 for(fail_stage=1;fail_stage<=2;fail_stage++){
  contexts=wires=owners=cancelled=0;watched_fd=-1;watched_ctx=0;watched_wire=watched_owner=0;
  fwp_task *task=fwp_spawn_task(0,server,0,0,0);fwp_await(task);
  if(!task->done||cancelled!=1||fwp_cleanups||contexts!=1||wires!=1||owners!=1)return 6;
  if(fail_stage==2&&(watched_fd<0||fcntl(watched_fd,F_GETFD)!=-1||errno!=EBADF))return 7;
 }
 fail_stage=0;plain=1;contexts=wires=owners=cancelled=0;watched_fd=-1;watched_ctx=0;watched_wire=watched_owner=0;
 fwp_task *task=fwp_spawn_task(0,server,0,0,0);fwp_p_task_yield();
 if(watched_fd<0||watched_ctx||task->done)return 8;
 fwp_p_task_cancel(PTR(task));fwp_await(task);
 if(cancelled!=1||fwp_cleanups||fcntl(watched_fd,F_GETFD)!=-1||errno!=EBADF||contexts||wires||owners)return 9;
 return 0;
}
"#;
    let dir = std::env::temp_dir().join(format!("fwp-grpc-server-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let openssl = std::env::var("FWP_OPENSSL_DIR")
        .map(|p| format!("{p}/bin/openssl"))
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
            "        owner->fd = -1;\n        fwp_fd_closing(fd);\n        close(fd);",
            "        owner->fd = -1; /* omit listener close */",
            1,
        ),
        (
            "        fwp_tls_server_drop(ctx);",
            "        /* omit server context owner */",
            2,
        ),
    ] {
        assert!(generated.contains(needle), "missing control {needle}");
        let broken = generated.replacen(needle, replacement, 1);
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
