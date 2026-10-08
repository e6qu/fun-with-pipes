//! Peer metadata preparation releases certificate, BIO and copied subject owners.
use fwp::ir::*;
use std::process::Command;

#[test]
fn peer_subject_failures_and_copy_traps_release_temporary_owners() {
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
    let generated = generated.replace("    V v = fwp_cstr(s);", "    V v = subject_copy(s);");
    let hooks = r#"
#include <stdint.h>
#include <stdlib.h>
#include <openssl/ssl.h>
#include <openssl/x509.h>
static int armed,stage,cert_gets,cert_frees,bio_gets,bio_frees,buffer_frees;static void *buffer;
static X509 *observe_peer(SSL *ssl);
static void observe_cert_free(X509 *cert);
static BIO *observe_bio_new(const BIO_METHOD *method);
static int observe_bio_free(BIO *bio);
static void *observe_malloc(size_t n);
static void observe_free(void *p);
static long observe_print(BIO *bio,const X509_NAME *name,int indent,unsigned long flags);
static long observe_data(BIO *bio,char **p);
static uintptr_t subject_copy(const char *s);
static void subject_ignore(void *p);
#define SSL_get1_peer_certificate(s) observe_peer(s)
#define X509_free(p) observe_cert_free(p)
#define BIO_new(m) observe_bio_new(m)
#define BIO_free(p) observe_bio_free(p)
#define malloc(n) observe_malloc(n)
#define free(p) observe_free(p)
#define X509_NAME_print_ex(b,n,i,f) observe_print(b,n,i,f)
#undef BIO_get_mem_data
#define BIO_get_mem_data(b,p) observe_data(b,p)
"#;
    let fixture = r#"
#undef SSL_get1_peer_certificate
#undef X509_free
#undef BIO_new
#undef BIO_free
#undef malloc
#undef free
#undef X509_NAME_print_ex
#undef BIO_get_mem_data
static X509 *observe_peer(SSL *ssl){X509 *c=SSL_get1_peer_certificate(ssl);if(armed&&c)cert_gets++;return c;}
static void observe_cert_free(X509 *c){if(armed&&c)cert_frees++;X509_free(c);}
static BIO *observe_bio_new(const BIO_METHOD *m){if(armed&&stage==2)return 0;BIO *b=BIO_new(m);if(armed&&b)bio_gets++;return b;}
static int observe_bio_free(BIO *b){if(armed&&b)bio_frees++;return BIO_free(b);}
static void *observe_malloc(size_t n){if(armed&&stage==1)return 0;void *p=malloc(n);if(armed&&!buffer)buffer=p;return p;}
static void observe_free(void *p){if(armed&&p&&p==buffer)buffer_frees++;free(p);}
static long observe_print(BIO *b,const X509_NAME *n,int i,unsigned long f){if(armed&&stage==3)return -1;return X509_NAME_print_ex(b,n,i,f);}
static long observe_data(BIO *b,char **p){if(armed&&stage==4)return -1;return BIO_ctrl(b,BIO_CTRL_INFO,0,p);}
static uintptr_t subject_copy(const char *s){if(stage==5)fwp_trap("subject copy");return fwp_cstr(s);}
static void subject_ignore(void *p){(void)p;}
static jmp_buf failure;static int recover(void){return 1;}
static int probe(int argc,char **argv){
 if(argc!=3)return 30;fwp_lib_init();
 SSL_CTX *server_ctx=SSL_CTX_new(TLS_server_method()),*client_ctx=SSL_CTX_new(TLS_client_method());
 if(!server_ctx||!client_ctx||SSL_CTX_use_certificate_file(server_ctx,argv[1],SSL_FILETYPE_PEM)!=1||SSL_CTX_use_PrivateKey_file(server_ctx,argv[2],SSL_FILETYPE_PEM)!=1)return 31;
 SSL *server=SSL_new(server_ctx),*client=SSL_new(client_ctx);SSL_CTX_free(server_ctx);SSL_CTX_free(client_ctx);
 if(!server||!client)return 32;armed=1;cert_gets=0;if(fwp_tls_peer_subject(client)||cert_gets)return 41;armed=0;SSL_set_accept_state(server);SSL_set_connect_state(client);
 BIO *a=0,*b=0;if(!BIO_new_bio_pair(&a,0,&b,0))return 33;SSL_set_bio(server,a,a);SSL_set_bio(client,b,b);
 for(int i=0;i<20&&(!SSL_is_init_finished(server)||!SSL_is_init_finished(client));i++){
  int r=SSL_do_handshake(client);if(r!=1){int e=SSL_get_error(client,r);if(e!=SSL_ERROR_WANT_READ&&e!=SSL_ERROR_WANT_WRITE)return 34;}
  r=SSL_do_handshake(server);if(r!=1){int e=SSL_get_error(server,r);if(e!=SSL_ERROR_WANT_READ&&e!=SSL_ERROR_WANT_WRITE)return 35;}
 }
 if(!SSL_is_init_finished(client)||!SSL_is_init_finished(server))return 36;
 V conn=fwp_sock_new(-1,1);SOCK(conn)->tls=client;
 if(fwp_p_tls_peer_subject(fwp_sock_new(-1,1))!=FWP_NONE)return 37;
 V peer=fwp_sock_new(-1,1);SOCK(peer)->tls=server;if(fwp_p_tls_peer_subject(peer)!=FWP_NONE)return 42;SOCK(peer)->tls=0;
 for(stage=0;stage<=5;stage++){
  cert_gets=cert_frees=bio_gets=bio_frees=buffer_frees=0;buffer=0;armed=1;
  if(stage==5){fwp_trap_recover=recover;fwp_trap_jb=&failure;fwp_trap_cleanup=fwp_cleanups;
   if(!setjmp(failure)){(void)fwp_p_tls_peer_subject(conn);return 38;}fwp_trap_recover=0;fwp_trap_jb=0;
  }else{
   V result=fwp_p_tls_peer_subject(conn);
   if(stage==0){if(result==FWP_NONE||strcmp(STR(OBJ(result)->f[0])->d,"CN=localhost,O=fwp"))return 39;}
   else if(result!=FWP_NONE)return 40;
  }
  if(cert_gets!=1||cert_frees!=1)return 1;
  if(bio_gets!=(stage==2?0:1)||bio_frees!=bio_gets)return 2;
  if(buffer_frees!=(stage==0||stage==5?1:0))return 3;
  if(fwp_cleanups||ERR_peek_error())return 4;
  armed=0;
 }
 stage=0;char *retry=fwp_tls_peer_subject(client);if(!retry||strcmp(retry,"CN=localhost,O=fwp"))return 43;free(retry);
 SOCK(conn)->tls=0;SSL_free(client);SSL_free(server);return 0;
}
int main(int argc,char **argv){int status=probe(argc,argv);if(status)_Exit(status);return 0;}
"#;
    let dir = std::env::temp_dir().join(format!("fwp-tls-subject-{}", std::process::id()));
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
                &[],
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
                alpn: &[],
                cert: "",
                key: "",
            },
        )
        .unwrap();
        assert_eq!(client.peer_subject(), None);
        for _ in 0..100 {
            assert!(matches!(client.handshake(), Io::Done(_) | Io::Wait(_)));
            assert!(matches!(server.handshake(), Io::Done(_) | Io::Wait(_)));
            if client.handshaken() && server.handshaken() {
                break;
            }
        }
        assert!(client.handshaken() && server.handshaken());
        assert_eq!(client.peer_subject().as_deref(), Some("CN=localhost,O=fwp"));
        assert_eq!(client.peer_subject().as_deref(), Some("CN=localhost,O=fwp"));
        assert_eq!(server.peer_subject(), None);
    }
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
            "    X509_free(cert);",
            "    /* omit certificate release */",
            Some(1),
        ),
        (
            "    if (bio) BIO_free(bio);",
            "    /* omit BIO release */",
            Some(2),
        ),
        (
            "    fwp_cleanup_push(&cleanup, fwp_tls_subject_free, s);",
            "    fwp_cleanup_push(&cleanup, subject_ignore, s);",
            Some(3),
        ),
        (
            "            if (out) {\n                memcpy(out, p, (size_t)n);",
            "            if (1) {\n                memcpy(out, p, (size_t)n);",
            None,
        ),
    ] {
        assert!(generated.contains(needle), "missing control {needle}");
        let broken = generated.replacen(needle, replacement, 1);
        fwp::cgen::compile_c(&format!("{hooks}\n{broken}\n{fixture}"), &exe, "-O1").unwrap();
        let out = Command::new(&exe)
            .args([dir.join("cert.pem"), dir.join("key.pem")])
            .output()
            .unwrap();
        assert!(!out.status.success(), "control passed: {needle}");
        if let Some(code) = expected {
            assert_eq!(
                out.status.code(),
                Some(code),
                "{needle}: {}",
                String::from_utf8_lossy(&out.stderr)
            );
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}
