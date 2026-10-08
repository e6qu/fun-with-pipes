//! Real OpenSSL owners survive listener stop and raw HTTP/2 session transfer.
use fwp::ir::*;
use std::process::Command;

#[test]
fn listener_stop_releases_context_after_accepted_sessions_finish() {
    let unit = MT::Record(vec![]);
    let program = Program {
        funcs: vec![
            Func {
                name: "available".into(),
                arity: 1,
                locals: vec![unit.clone()],
                ty: MT::Fun(Box::new(unit.clone()), Box::new(MT::con("std::Bool"))),
                body: Body::Prim("tls.available".into()),
            },
            // Include the existing HTTP/2 raw-session transfer boundary.
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
    let (generated, _) = fwp::cgen::generate_library(&program, "tls_owners").unwrap();
    let hooks = r#"
#include <stdlib.h>
#include <openssl/ssl.h>
static SSL_CTX *watched_ctx;static void *watched_wire,*watched_owner,*last_malloc;
static int ctx_freed,wire_freed,owner_freed,watch_protocol,fail_owner,fail_app_data;
static SSL_CTX *observe_ctx_new(const SSL_METHOD *method);
static int observe_app_data(SSL_CTX *ctx,void *owner);
static void observe_ctx_free(SSL_CTX *ctx);
static void observe_free(void *p);
static void *observe_malloc(size_t n);
#define SSL_CTX_free(p) observe_ctx_free(p)
#define SSL_CTX_new(m) observe_ctx_new(m)
#undef SSL_CTX_set_app_data
#define SSL_CTX_set_app_data(c,p) observe_app_data(c,p)
#define free(p) observe_free(p)
#define malloc(n) observe_malloc(n)
"#;
    let fixture = r#"
#undef SSL_CTX_free
#undef SSL_CTX_new
#undef SSL_CTX_set_app_data
#undef free
#undef malloc
static void observe_ctx_free(SSL_CTX *ctx){if(ctx==watched_ctx)ctx_freed++;SSL_CTX_free(ctx);}
static void observe_free(void *p){if(p&&p==watched_wire)wire_freed++;if(p&&p==watched_owner)owner_freed++;free(p);}
static void *observe_malloc(size_t n){
 if(watch_protocol==2&&fail_owner){watch_protocol=0;last_malloc=0;return 0;}
 last_malloc=malloc(n);
 if(watch_protocol==1){watched_wire=last_malloc;watch_protocol=2;}
 else if(watch_protocol==2){watched_owner=last_malloc;watch_protocol=0;}
 return last_malloc;
}
static SSL_CTX *observe_ctx_new(const SSL_METHOD *method){watched_ctx=SSL_CTX_new(method);return watched_ctx;}
static int observe_app_data(SSL_CTX *ctx,void *owner){return fail_app_data?0:SSL_CTX_set_ex_data(ctx,0,owner);}
static int alive(void){return !ctx_freed&&!wire_freed&&!owner_freed;}
static int released(void){return ctx_freed==1&&wire_freed==1&&owner_freed==1;}
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
int main(int argc,char **argv){
 if(argc!=3)return 30;fwp_lib_init();fwp_tasks_init();
 for(int sessions=0;sessions<=3;sessions++){
  ctx_freed=wire_freed=owner_freed=0;
  unsigned char *wire=malloc(4);memcpy(wire,"\x02h2",4);watched_wire=wire;
  SSL_CTX *ctx=fwp_tls_server_ctx(argv[1],argv[2],wire,3,"");if(!ctx)return 31;
  watched_ctx=ctx;watched_owner=last_malloc;
  int listener[2];if(socketpair(AF_UNIX,SOCK_STREAM,0,listener))return 32;
  V l=fwp_sock_new(listener[0],0);SOCK(l)->tls=ctx;
  V conns[3]={0};SSL *transferred=0;int peers[3]={0};
  for(int i=0;i<sessions;i++){
   int pair[2];if(socketpair(AF_UNIX,SOCK_STREAM,0,pair))return 33;
   conns[i]=fwp_sock_new(pair[0],1);peers[i]=pair[1];
   SOCK(conns[i])->tls=fwp_tls_accepted(ctx,pair[0]);if(!SOCK(conns[i])->tls)return 34;
  }
  int transferred_fd=-1;if(sessions==3)transferred_fd=w_take(conns[2],&transferred);
  fwp_p_tcp_stop(l);fwp_p_tcp_stop(l);close(listener[1]);
  if(!sessions){if(!released())return 1;continue;}
  if(!alive())return 2;
  // The first handshake selects ALPN after the listener owner is gone.
  for(int i=0;i<sessions;i++){
   SSL *ssl=i==2&&transferred?transferred:(SSL *)SOCK(conns[i])->tls;
   if(!handshake(ssl))return 3;
   if(i==2&&transferred){fwp_tls_free(transferred);close(transferred_fd);}
   else {fwp_p_sock_close(conns[i]);fwp_p_sock_close(conns[i]);}
   close(peers[i]);if(i+1<sessions&&!alive())return 4;
  }
  if(!released())return 5;
 }
 // Real first/later OpenSSL failures and listener bind/resolve failure.
 for(int mode=0;mode<6;mode++){
  watched_ctx=0;watched_wire=watched_owner=0;ctx_freed=wire_freed=owner_freed=0;
  watch_protocol=1;fail_owner=mode==3;fail_app_data=mode==2;
  V cert=fwp_cstr(mode==0?"bad.pem":argv[1]);V key=fwp_cstr(argv[2]);
  V ca=fwp_cstr(mode==1?"bad.pem":"");V protocols=fwp_list_from((V[]){fwp_cstr("h2")},1);
  V addr=fwp_cstr(mode==4?"invalid":"127.0.0.1:0");V occupied=0;
  if(mode==5){occupied=fwp_p_tcp_listen(addr,0);addr=fwp_p_local_addr(occupied);}
  fwp_handler h;memset(&h,0,sizeof h);h.prev=fwp_handlers;h.cleanup=fwp_cleanups;h.state_depth=fwp_state_len;fwp_handlers=&h;
  if(!setjmp(h.jb)){(void)fwp_p_tls_listen(cert,key,protocols,ca,addr,0);return 10;}
  fwp_handlers=h.prev;if(occupied)fwp_p_tcp_stop(occupied);
  if(ctx_freed!=1||wire_freed!=1||owner_freed!=(mode==2||mode>=4?1:0)||fwp_cleanups!=h.cleanup)return 11+mode;
 }
 return 0;
}
"#;
    let dir = std::env::temp_dir().join(format!("fwp-tls-listener-{}", std::process::id()));
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
    std::fs::write(dir.join("bad.pem"), "not a PEM certificate\n").unwrap();
    let exe = dir.join("probe");
    let controls = [
        (
            "fwp_tls_server_drop(SOCK(l)->tls);",
            "/* missing listener release */",
            1,
        ),
        (
            "    owner->refs++;",
            "    /* missing accepted-session owner */",
            2,
        ),
        (
            "    if (server) fwp_tls_server_drop(ctx);",
            "    /* missing session context release */",
            5,
        ),
        (
            "    fwp_cleanup_push(&cleanup, fwp_tls_server_drop, ctx);",
            "    /* missing listen failure guard */",
            15,
        ),
        (
            "    free(owner->alpn.w);",
            "    /* missing ALPN wire release */",
            1,
        ),
        (
            "    free(owner);",
            "    /* missing ALPN owner release */",
            1,
        ),
    ];
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{hooks}\n{generated}\n{fixture}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let out = Command::new(&exe)
                .current_dir(&dir)
                .args([dir.join("cert.pem"), dir.join("key.pem")])
                .env("FWP_REUSE_VERIFY", poison)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .output()
                .unwrap();
            assert!(
                out.status.success(),
                "{opt}, poison {poison}: {:?}: {}",
                out.status.code(),
                String::from_utf8_lossy(&out.stderr)
            );
        }
        for (needle, replacement, expected) in controls {
            assert!(generated.contains(needle), "missing control {needle}");
            let broken = generated.replacen(needle, replacement, 1);
            fwp::cgen::compile_c(&format!("{hooks}\n{broken}\n{fixture}"), &exe, opt).unwrap();
            let out = Command::new(&exe)
                .current_dir(&dir)
                .args([dir.join("cert.pem"), dir.join("key.pem")])
                .output()
                .unwrap();
            assert_eq!(
                out.status.code(),
                Some(expected),
                "{opt}, control {needle}: {}",
                String::from_utf8_lossy(&out.stderr)
            );
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}
