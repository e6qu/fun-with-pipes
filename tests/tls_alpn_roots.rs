//! Borrowed TLS protocol bytes keep their Conn owner live through allocation.
use fwp::ir::*;
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
    // A real major trace at the copy boundary removes reliance on GC timing.
    let generated = generated.replace(
        "static V fwp_str_new(const char *s, size_t len) {",
        "static V fwp_str_new(const char *s, size_t len) { inspect_owner();",
    );
    let hooks = r#"
#include <openssl/ssl.h>
static SSL *watched_ssl;static int copy_active,released;
static void observe_ssl_free(SSL *ssl);
static void inspect_owner(void);
#define SSL_free(p) observe_ssl_free(p)
"#;
    let fixture = r#"
#undef SSL_free
static void observe_ssl_free(SSL *ssl){if(ssl==watched_ssl)released++;SSL_free(ssl);}
static void inspect_owner(void){
 if(!copy_active)return;copy_active=0;
 if(!fwp_gc.armed)exit(2);size_t before=fwp_gc.ncollect;
 fwp_gc.major_next=1;fwp_gc_collect();
 if(fwp_gc.ncollect<=before)exit(3);if(released)exit(1);
}
static __attribute__((noinline)) V protocol(void){
 V conn=fwp_sock_new(-1,1);SOCK(conn)->tls=watched_ssl;copy_active=1;
 return fwp_p_tls_alpn(conn);
}
static int probe(int argc,char **argv){
 if(argc!=3)return 30;fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));if(!fwp_gc.armed)return 31;
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
 if(copy_active||released||strcmp(STR(result)->d,"h2"))return 40;
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
        use fwp::tls::{ClientOpts, Io, Session};
        use std::os::fd::AsRawFd;
        use std::os::unix::net::UnixStream;
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
        fwp::cgen::compile_c(&format!("{hooks}\n{generated}\n{fixture}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let out = Command::new(&exe)
                .args([dir.join("cert.pem"), dir.join("key.pem")])
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
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
    let needle="    /* Protocol bytes live in SSL storage, outside the collector's heap. */\n    FWP_KEEP_ALIVE(c);";
    assert!(generated.contains(needle));
    let broken = generated.replacen(needle, "    /* omit borrowed protocol owner fence */", 1);
    fwp::cgen::compile_c(&format!("{hooks}\n{broken}\n{fixture}"), &exe, "-O1").unwrap();
    let out = Command::new(&exe)
        .args([dir.join("cert.pem"), dir.join("key.pem")])
        .output()
        .unwrap();
    assert_eq!(
        out.status.code(),
        Some(1),
        "{}",
        String::from_utf8_lossy(&out.stderr)
    );
    std::fs::remove_dir_all(dir).unwrap();
}
