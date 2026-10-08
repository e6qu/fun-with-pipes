//! ALPN packing skips invalid names without GC scratch or unchecked malloc.
use fwp::ir::*;
use std::process::Command;

#[test]
fn alpn_preparation_bounds_storage_and_closes_connection_on_failure() {
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
    let expected =
        fwp::tls::alpn_wire(&["h2".into(), "".into(), "a".repeat(256), "http/1.1".into()]);
    assert_eq!(expected, b"\x02h2\x08http/1.1");
    let generated = generated
        .replacen(
            "    unsigned alpn_n;",
            "    watched_connect_fd=SOCK(c)->fd; unsigned alpn_n;",
            1,
        )
        .replace(
            "    V *a = (V *)fwp_alloc((*n + 1) * sizeof(V));",
            "    wire_scratch++; V *a = (V *)fwp_alloc((*n + 1) * sizeof(V));",
        );
    let hooks = r#"
#include <stdlib.h>
#include <openssl/ssl.h>
static int watch_wire,fail_wire,wire_scratch,contexts,watched_connect_fd=-1;static size_t wire_bytes;
static void *observe_malloc(size_t n);
static SSL_CTX *observe_ctx_new(const SSL_METHOD *method);
#define malloc(n) observe_malloc(n)
#define SSL_CTX_new(m) observe_ctx_new(m)
"#;
    let fixture = r#"
#undef malloc
#undef SSL_CTX_new
static void *observe_malloc(size_t n){if(watch_wire){wire_bytes=n;return fail_wire?0:malloc(n);}return malloc(n);}
static SSL_CTX *observe_ctx_new(const SSL_METHOD *method){contexts++;return SSL_CTX_new(method);}
static int probe(void){
 fwp_lib_init();
 V protos=fwp_list_from((V[]){fwp_cstr("h2")},1);
 unsigned n=99;watch_wire=fail_wire=1;
 unsigned char *wire=fwp_alpn_wire(protos,&n);watch_wire=fail_wire=0;
 if(wire||n||strcmp(fwp_tls_err,"cannot allocate TLS protocol list"))return 1;
 char invalid[257];memset(invalid,'a',256);invalid[256]=0;
 protos=fwp_list_from((V[]){fwp_cstr("h2"),fwp_cstr(""),fwp_cstr(invalid),fwp_cstr("http/1.1")},4);
 wire_scratch=0;watch_wire=1;wire=fwp_alpn_wire(protos,&n);watch_wire=0;
 if(!wire||n!=12||wire_bytes!=13||memcmp(wire,"\x02h2\x08http/1.1",12)||wire_scratch)return 2;free(wire);
 watch_wire=1;wire=fwp_alpn_wire(0,&n);watch_wire=0;
 if(!wire||n||wire_bytes!=1)return 3;free(wire);
 // Listen must reject allocation failure before creating a TLS context.
 fwp_handler h={0};h.prev=fwp_handlers;h.cleanup=fwp_cleanups;h.state_depth=fwp_state_len;fwp_handlers=&h;
 V empty=fwp_cstr("");V address=fwp_cstr("127.0.0.1:0");
 watch_wire=fail_wire=1;contexts=0;
 if(!setjmp(h.jb)){(void)fwp_p_tls_listen(empty,empty,protos,empty,address,0);return 4;}
 fwp_handlers=h.prev;watch_wire=fail_wire=0;if(contexts||fwp_cleanups!=h.cleanup)return 5;
 V listener=fwp_p_tcp_listen(address,0);V target=fwp_p_local_addr(listener);
 h.prev=fwp_handlers;h.cleanup=fwp_cleanups;h.state_depth=fwp_state_len;fwp_handlers=&h;
 watch_wire=fail_wire=1;contexts=0;
 if(!setjmp(h.jb)){(void)fwp_p_tls_connect(empty,FWP_TRUE,empty,protos,empty,empty,target,0);return 6;}
 fwp_handlers=h.prev;watch_wire=fail_wire=0;
 if(contexts||watched_connect_fd<0||fcntl(watched_connect_fd,F_GETFD)!=-1||errno!=EBADF||fwp_cleanups!=h.cleanup)return 7;
 fwp_p_tcp_stop(listener);
 return 0;
}
int main(void){int status=probe();if(status)_Exit(status);return 0;}
"#;
    let dir = std::env::temp_dir().join(format!("fwp-tls-wire-{}", std::process::id()));
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
    for (needle, replacement, expected) in [
        (
            "    if (!w) {\n        snprintf(fwp_tls_err",
            "    if (0) { /* omit allocation guard */\n        snprintf(fwp_tls_err",
            None,
        ),
        (
            "        if (l == 0 || l > 255) continue;",
            "        /* count invalid names */",
            Some(2),
        ),
        (
            "        fwp_p_sock_close(c);\n        return fwp_io_error(\"tls\", fwp_tls_err, err);",
            "        return fwp_io_error(\"tls\", fwp_tls_err, err);",
            Some(7),
        ),
    ] {
        assert!(generated.contains(needle), "missing control {needle}");
        let broken = generated.replacen(needle, replacement, 1);
        fwp::cgen::compile_c(&format!("{hooks}\n{broken}\n{fixture}"), &exe, "-O1").unwrap();
        let out = Command::new(&exe).output().unwrap();
        assert!(!out.status.success());
        assert_eq!(
            out.status.code(),
            expected,
            "control {needle}: {}",
            String::from_utf8_lossy(&out.stderr)
        );
    }
    // Exercise the length boundary without allocating gigabytes locally.
    let restricted =
        generated.replace("const size_t limit = UINT_MAX;", "const size_t limit = 8u;");
    let boundary = r#"
#undef malloc
#undef SSL_CTX_new
static void *observe_malloc(size_t n){if(watch_wire)wire_bytes=n;return malloc(n);}
static SSL_CTX *observe_ctx_new(const SSL_METHOD *m){return SSL_CTX_new(m);}
int main(void){fwp_lib_init();V protos=fwp_list_from((V[]){fwp_cstr("h2"),fwp_cstr("http/1.1")},2);unsigned n=99;watch_wire=1;unsigned char *w=fwp_alpn_wire(protos,&n);return w||n||wire_bytes||strcmp(fwp_tls_err,"TLS protocol list is too large");}
"#;
    fwp::cgen::compile_c(&format!("{hooks}\n{restricted}\n{boundary}"), &exe, "-O1").unwrap();
    assert!(Command::new(&exe).status().unwrap().success());
    std::fs::remove_dir_all(dir).unwrap();
}
