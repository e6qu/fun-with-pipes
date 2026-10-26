//! Borrowed TLS protocol bytes keep their Conn owner live through allocation.
use fwp::ir::*;
#[cfg(unix)]
use fwp::tls::{ClientOpts, Io, Session};
#[cfg(unix)]
use std::os::fd::AsRawFd;
#[cfg(unix)]
use std::os::unix::net::UnixStream;
use std::process::Command;

#[test]
fn alpn_string_allocation_keeps_the_owning_session_live() {
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
    // Observe the real TLS session at the borrowed-byte copy boundary.
    let generated = generated.replace(
        "static V fwp_str_new(const char *s, size_t len) {",
        "static V fwp_str_new(const char *s, size_t len) { inspect_owner();",
    );
    let hooks = r#"
#include <openssl/ssl.h>
#include <stdint.h>
static SSL *watched_ssl;static int copy_active,released;
static uintptr_t watched_connection;
static void observe_ssl_free(SSL *ssl);
static void inspect_owner(void);
#define SSL_free(p) observe_ssl_free(p)
"#;
    let fixture = r#"
#undef SSL_free
static void observe_ssl_free(SSL *ssl){if(ssl==watched_ssl)released++;SSL_free(ssl);}
static void inspect_owner(void){
 if(!copy_active)return;copy_active=0;
 /* A broken owner is released before any borrowed byte is read. */
 if(PROBE_RELEASE_BEFORE_COPY)fwp_sock_drop((V)watched_connection);
 if(released)exit(1);
}
static __attribute__((noinline)) V protocol(void){
 V conn=fwp_sock_new(-1,1);STREAM(conn)->tls=watched_ssl;
 watched_connection=(uintptr_t)conn;copy_active=1;
 V result=fwp_rc_fresh(fwp_p_tls_alpn(conn));
 fwp_sock_drop(conn);watched_connection=0;
 return result;
}
static int probe(int argc,char **argv){
 if(argc!=3)return 30;fwp_lib_init();size_t baseline=fwp_heap.live;
 unsigned char *wire=malloc(4);if(!wire)return 32;memcpy(wire,"\x02h2",4);
 SSL_CTX *ctx=fwp_tls_server_ctx(argv[1],argv[2],wire,3,"");if(!ctx)return 33;
 SSL *server=(SSL *)fwp_tls_accepted(ctx,-1);fwp_tls_server_drop(ctx);
 SSL_CTX *client_ctx=SSL_CTX_new(TLS_client_method());if(!client_ctx)return 34;
 SSL *client=SSL_new(client_ctx);SSL_CTX_free(client_ctx);if(!server||!client)return 35;
 SSL_set_connect_state(client);SSL_set_alpn_protos(client,(const unsigned char *)"\x02h2",3);
 BIO *a=0,*b=0;if(!BIO_new_bio_pair(&a,0,&b,0))return 36;SSL_set_bio(server,a,a);SSL_set_bio(client,b,b);ERR_clear_error();
 for(int i=0;i<20&&(!SSL_is_init_finished(server)||!SSL_is_init_finished(client));i++){
  int r=SSL_do_handshake(client);if(r!=1){int e=SSL_get_error(client,r);if(e!=SSL_ERROR_WANT_READ&&e!=SSL_ERROR_WANT_WRITE)return 37;}
  r=SSL_do_handshake(server);if(r!=1){int e=SSL_get_error(server,r);if(e!=SSL_ERROR_WANT_READ&&e!=SSL_ERROR_WANT_WRITE)return 38;}
 }
 if(!SSL_is_init_finished(client)||!SSL_is_init_finished(server))return 39;
 watched_ssl=client;V result=protocol();
 if(copy_active||released!=1||strcmp(STR(result)->d,"h2"))return 40;
 fwp_rc_free_obj(result);if(fwp_heap.live!=baseline)return 42;
 fwp_tls_dispose(server);fwp_lib_finish();if(released!=1)return 41;
 return 0;
}
int main(int argc,char **argv){int status=probe(argc,argv);if(status)_Exit(status);return 0;}
"#;
    let dir = std::env::temp_dir().join(format!("fwp-tls-alpn-root-{}", std::process::id()));
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
            "/O=fwp/CN=localhost",
        ])
        .current_dir(&dir)
        .output()
        .unwrap();
    assert!(
        out.status.success(),
        "{}",
        String::from_utf8_lossy(&out.stderr)
    );
    #[cfg(unix)]
    {
        let (a, b) = UnixStream::pair().unwrap();
        a.set_nonblocking(true).unwrap();
        b.set_nonblocking(true).unwrap();
        let ctx = std::rc::Rc::new(
            fwp::tls::server_ctx(
                dir.join("cert.pem").to_str().unwrap(),
                dir.join("key.pem").to_str().unwrap(),
                &["h2".into()],
                "",
            )
            .unwrap(),
        );
        let mut server = Session::server(&ctx, a.as_raw_fd()).unwrap();
        let mut client = Session::client(
            b.as_raw_fd(),
            &ClientOpts {
                ca: "",
                verify: false,
                name: "",
                alpn: &["h2".into()],
                cert: "",
                key: "",
            },
        )
        .unwrap();
        assert_eq!(client.alpn(), "");
        for _ in 0..100 {
            assert!(matches!(client.handshake(), Io::Done(_) | Io::Wait(_)));
            assert!(matches!(server.handshake(), Io::Done(_) | Io::Wait(_)));
            if client.handshaken() && server.handshaken() {
                break;
            }
        }
        assert!(client.handshaken() && server.handshaken());
        assert_eq!(client.alpn().as_str(), "h2");
        assert_eq!(client.alpn().as_str(), "h2");
        assert_eq!(server.alpn(), "h2");
    }
    let exe = dir.join("probe");
    for opt in ["-O1", "-O2"] {
        for premature_release in [false, true] {
            let code = format!(
                "#define PROBE_RELEASE_BEFORE_COPY {}\n{hooks}\n{generated}\n{fixture}",
                usize::from(premature_release)
            );
            fwp::cgen::compile_c(&code, &exe, opt).unwrap();
            let out = Command::new(&exe)
                .args([dir.join("cert.pem"), dir.join("key.pem")])
                .output()
                .unwrap();
            assert_eq!(
                out.status.code(),
                Some(if premature_release { 1 } else { 0 }),
                "{opt}: {out:?}"
            );
            assert!(out.stdout.is_empty() && out.stderr.is_empty(), "{out:?}");
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}
