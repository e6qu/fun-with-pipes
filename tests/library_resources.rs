//! Actual unload closes library-owned handles without TLS shutdown traffic.
use fwp::ir::*;
use std::process::Command;

#[test]
fn unload_closes_owned_files_sessions_and_transferred_http2_handles() {
    for arc in [true, false] {
        fwp::cgen::set_native_options(fwp::cgen::NativeOptions {
            arc,
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
                // Include HTTP/2 through an actual primitive and its declared
                // signature, so ARC checks the same contract as source code.
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
        fwp::ir::check_locals(&p).unwrap();
        let (generated, header) = fwp::cgen::generate_library(&p, "resources", &[]).unwrap();
        let hooks = r#"
#if defined(_WIN32) && !defined(_WIN32_WINNT)
#define _WIN32_WINNT 0x0a00
#endif
#include <openssl/ssl.h>
static int *counts;static SSL_CTX *client_ctx;static void *client_name,*client_cache;static SSL_CTX *servers[2];static void *wires[2],*owners[2];
static void observe_ctx_free(SSL_CTX *ctx);
static void observe_ssl_free(SSL *ssl);
static int observe_shutdown(SSL *ssl);
static void observe_free(void *p);
#define SSL_CTX_free(p) observe_ctx_free(p)
#define SSL_free(p) observe_ssl_free(p)
#define SSL_shutdown(p) observe_shutdown(p)
#define free(p) observe_free(p)
"#;
        let fixture = r#"
#undef SSL_CTX_free
#undef SSL_free
#undef SSL_shutdown
#undef free
static void observe_ctx_free(SSL_CTX *ctx){if(counts){if(ctx==client_ctx)counts[0]++;for(int i=0;i<2;i++)if(ctx==servers[i])counts[5]++;}SSL_CTX_free(ctx);}
static void observe_ssl_free(SSL *ssl){if(counts)counts[1]++;SSL_free(ssl);}
static int observe_shutdown(SSL *ssl){if(counts)counts[2]++;return SSL_shutdown(ssl);}
static void observe_free(void *p){if(counts&&p){if(p==client_name)counts[3]++;if(p==client_cache)counts[4]++;for(int i=0;i<2;i++){if(p==wires[i])counts[6]++;if(p==owners[i])counts[7]++;}}free(p);}
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
/* Use real loopback sockets on all hosts; Windows has no socketpair. */
static void socket_pair(fwp_socket_t pair[2]) {
 fwp_socket_t listener=fwp_socket_open(AF_INET,SOCK_STREAM,0);
 struct sockaddr_in address={0};address.sin_family=AF_INET;address.sin_addr.s_addr=htonl(INADDR_LOOPBACK);
 socklen_t size=sizeof address;
 if(listener==FWP_INVALID_SOCKET||fwp_socket_bind(listener,(struct sockaddr *)&address,size)||fwp_socket_listen(listener,1)||getsockname(listener,(struct sockaddr *)&address,&size))abort();
 pair[0]=fwp_socket_open(AF_INET,SOCK_STREAM,0);
 if(pair[0]==FWP_INVALID_SOCKET||fwp_socket_connect(pair[0],(struct sockaddr *)&address,size))abort();
 pair[1]=fwp_socket_accept(listener,0,0);fwp_socket_close(listener);
 if(pair[1]==FWP_INVALID_SOCKET)abort();
}
#ifdef _WIN32
__declspec(dllexport)
#endif
void setup(uintptr_t *fds,int *observations,const char *path,const char *cert,const char *key){
 fwp_lib_init();counts=observations;
 V file=fwp_p_file_open(fwp_cstr(path),1,0);
#ifdef _WIN32
 fds[0]=(uintptr_t)_get_osfhandle(_fileno(((fwp_file *)(uintptr_t)file)->f));
#else
 fds[0]=(uintptr_t)fileno(((fwp_file *)(uintptr_t)file)->f);
#endif
 V closed=fwp_p_file_open(fwp_cstr(path),0,0);fwp_p_file_close(closed);fwp_p_file_close(closed);
 client_ctx=fwp_tls_client_ctx("",0);client_name=fwp_tls_clients[0].ca;client_cache=fwp_tls_clients;
 for(int i=1;i<=3;i++){
  fwp_socket_t pair[2];socket_pair(pair);fds[i]=pair[0];fds[i+3]=pair[1];
  V sock=fwp_sock_new(pair[0],1);
  if(i<=2){STREAM(sock)->tls=SSL_new(client_ctx);SSL_set_fd(STREAM(sock)->tls,pair[0]);}
  if(i==2){SSL *ssl=0;fwp_socket_t fd=w_take(sock,&ssl);g_conn *c=g_conn_new(fd, "", "localhost",0);c->ssl=ssl;}
 }
 for(int i=0;i<2;i++){
  unsigned char *wire=malloc(4);memcpy(wire,"\x02h2",4);wires[i]=wire;
  servers[i]=fwp_tls_server_ctx(cert,key,wire,3,"");if(!servers[i])abort();owners[i]=SSL_CTX_get_app_data(servers[i]);
  fwp_socket_t listener[2],session[2];socket_pair(listener);socket_pair(session);
  fds[7+i*2]=listener[0];fds[8+i*2]=session[0];fds[11+i*2]=listener[1];fds[12+i*2]=session[1];
  V l=fwp_sock_new(listener[0],0);STREAM(l)->tls=servers[i];
  V c=fwp_sock_new(session[0],1);STREAM(c)->tls=fwp_tls_accepted(servers[i],session[0]);if(!STREAM(c)->tls||!handshake(STREAM(c)->tls))abort();
  if(i==1)fwp_p_tcp_stop(l); // Accepted session is the last protocol owner.
 }
 // Explicit close must remain idempotent when finalization follows.
 fwp_socket_t pair[2];socket_pair(pair);
 V closed_sock=fwp_sock_new(pair[0],1);fwp_p_sock_close(closed_sock);fwp_p_sock_close(closed_sock);fwp_socket_close(pair[1]);
}
"#;
        let host = include_str!("fixtures/library_resources_host.c");
        let dir =
            std::env::temp_dir().join(format!("fwp-library-resources-{}", std::process::id()));
        std::fs::create_dir_all(&dir).unwrap();
        // The dependency prefix contains headers/libraries; the runner supplies its
        // OpenSSL command separately on PATH (including Windows).
        let openssl = "openssl";
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
        let lib = dir.join(format!(
            "libresources.{}",
            fwp::cgen::shared_library_extension()
        ));
        let exe = dir.join("host.exe");
        for opt in ["-O1", "-O2"] {
            fwp::cgen::compile_library(
                &format!("{hooks}\n{generated}\n{fixture}"),
                &header,
                &lib,
                opt,
                fwp::cgen::LibKind::Shared,
            )
            .unwrap();
            fwp::cgen::compile_c(host, &exe, opt).unwrap();
            for poison in if arc { &["0"][..] } else { &["0", "1"][..] } {
                let out = Command::new(&exe)
                    .args([
                        &lib,
                        &dir.join("data"),
                        &dir.join("cert.pem"),
                        &dir.join("key.pem"),
                    ])
                    .env_remove("FWP_GC")
                    .env("FWP_REUSE_VERIFY", poison)
                    .env("FWP_GC_STRESS", if arc { "0" } else { "1" })
                    .env("FWP_GC_VERIFY", if arc { "0" } else { "1" })
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
        // Each omission must be detected by the actual loader host.
        for (needle, replacement, expected) in [
        (
            "    fwp_gc_finalizer(h, fwp_file_final);",
            "    /* omit file ownership */",
            1,
        ),
        (
            "    fwp_gc_finalizer(s, fwp_sock_final);",
            "    /* omit socket ownership */",
            1,
        ),
        (
            "    if (c->fd != FWP_INVALID_SOCKET) { fwp_socket_close(c->fd); c->fd = FWP_INVALID_SOCKET; }",
            "    /* omit transferred fd */",
            1,
        ),
        (
            "        else fwp_tls_dispose(((fwp_stream *)s)->tls);",
            "        else (void)0; /* omit session */",
            2,
        ),
        (
            "        else fwp_tls_dispose(((fwp_stream *)s)->tls);",
            "        else fwp_tls_free(((fwp_stream *)s)->tls); /* implicit shutdown traffic */",
            2,
        ),
        (
            "    fwp_tls_clients_finish();",
            "    /* omit cached context owners */",
            2,
        ),
    ] {
        assert!(generated.contains(needle), "missing control {needle}");
        let broken = generated.replacen(needle, replacement, 1);
        fwp::cgen::compile_library(
            &format!("{hooks}\n{broken}\n{fixture}"),
            &header,
            &lib,
            "-O1",
            fwp::cgen::LibKind::Shared,
        )
        .unwrap();
        let out = Command::new(&exe)
            .args([
                &lib,
                &dir.join("data"),
                &dir.join("cert.pem"),
                &dir.join("key.pem"),
            ])
            .env_remove("FWP_GC").env("FWP_REUSE_VERIFY", "0")
            .env("FWP_GC_STRESS", if arc { "0" } else { "1" })
            .env("FWP_GC_VERIFY", if arc { "0" } else { "1" })
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
}
