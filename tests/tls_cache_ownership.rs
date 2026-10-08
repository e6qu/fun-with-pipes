//! TLS cache failures preserve prior owners and release completed preparation.
use fwp::ir::*;
use std::process::Command;

#[test]
fn tls_cache_allocation_failures_release_partial_owners_and_allow_retry() {
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
    let hooks = r#"
#include <stdlib.h>
#include <string.h>
#include <openssl/ssl.h>
static int fail_stage,created,released,names_freed;static void *watched_name;
static SSL_CTX *observe_ctx_new(const SSL_METHOD *method);
static void observe_ctx_free(SSL_CTX *ctx);
static void *observe_realloc(void *p,size_t n);
static char *observe_strdup(const char *s);
static void observe_free(void *p);
#define SSL_CTX_new(m) observe_ctx_new(m)
#define SSL_CTX_free(p) observe_ctx_free(p)
#define realloc(p,n) observe_realloc(p,n)
#define strdup(s) observe_strdup(s)
#define free(p) observe_free(p)
"#;
    let fixture = r#"
#undef SSL_CTX_new
#undef SSL_CTX_free
#undef realloc
#undef strdup
#undef free
static SSL_CTX *observe_ctx_new(const SSL_METHOD *method){SSL_CTX *ctx=SSL_CTX_new(method);if(ctx)created++;return ctx;}
static void observe_ctx_free(SSL_CTX *ctx){if(ctx)released++;SSL_CTX_free(ctx);}
static void *observe_realloc(void *p,size_t n){return fail_stage==1?0:realloc(p,n);}
static char *observe_strdup(const char *s){if(fail_stage==2)return 0;char *p=strdup(s);if(fail_stage)watched_name=p;return p;}
static void observe_free(void *p){if(p&&p==watched_name)names_freed++;free(p);}
static int probe(int argc,char **argv){
 if(argc!=3)return 30;fwp_lib_init();
 for(int seed=0;seed<2;seed++)for(int stage=1;stage<=2;stage++){
  created=released=names_freed=0;watched_name=0;fail_stage=0;
  SSL_CTX *first=seed?fwp_tls_client_ctx("",0):0;
  if(seed&&!first)return 31;
  fwp_tls_client *cache=fwp_tls_clients;
  fail_stage=stage;SSL_CTX *failed=fwp_tls_client_ctx(seed?argv[1]:"",0);fail_stage=0;
  if(failed||fwp_tls_nclients!=(size_t)seed||fwp_tls_clients!=cache||released!=1||created!=seed+1)return 1;
  if(strcmp(fwp_tls_err,"cannot allocate TLS client context cache"))return 8;
  if(names_freed!=(stage==1?1:0))return 2;
  if(seed&&(fwp_tls_client_ctx("",0)!=first||strcmp(fwp_tls_clients[0].ca,"")))return 3;
  watched_name=0;
  SSL_CTX *retry=fwp_tls_client_ctx(seed?argv[1]:"",0);if(!retry||fwp_tls_nclients!=(size_t)seed+1)return 4;
  if(fwp_tls_client_ctx(seed?argv[1]:"",0)!=retry)return 5;
  fwp_tls_clients_finish();fwp_tls_clients_finish();if(created!=released||fwp_tls_nclients||fwp_tls_clients)return 6;
 }
 created=released=0;fail_stage=2;int failed=0;
 SSL_CTX *ctx=g_server_tls(argv[1],argv[2],"",&failed);fail_stage=0;
 if(ctx||!failed||created||released)return 7;
 return 0;
}
int main(int argc,char **argv){int status=probe(argc,argv);if(status)_Exit(status);return 0;}
"#;
    let dir = std::env::temp_dir().join(format!("fwp-tls-cache-{}", std::process::id()));
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
            "allocation_failed:\n    SSL_CTX_free(ctx);",
            "allocation_failed:\n    /* omit partial context release */",
            1,
        ),
        (
            "    if (!clients) { free(name); goto allocation_failed; }",
            "    if (!clients) { goto allocation_failed; }",
            2,
        ),
        (
            "    if (!name) goto allocation_failed;",
            "    /* publish incomplete name */",
            1,
        ),
        (
            "    if (!clients) { free(name); goto allocation_failed; }",
            "    if (!clients) { fwp_tls_clients=0; free(name); goto allocation_failed; }",
            1,
        ),
        (
            "    if (!alpn) {\n        fprintf(stderr, \"fwp serve:",
            "    if (0) { /* omit protocol allocation guard */\n        fprintf(stderr, \"fwp serve:",
            7,
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
