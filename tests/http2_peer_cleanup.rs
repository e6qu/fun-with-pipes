//! HTTP/2 request metadata owns its temporary peer subject through allocating copies.
use fwp::ir::*;
use std::process::Command;

#[test]
fn peer_subject_copy_and_option_failures_release_temporary_storage() {
    let unit = MT::unit();
    let program = Program {
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
    let (generated, _) = fwp::cgen::generate_library(&program, "peer_cleanup").unwrap();
    let subject = "char *peer = k->c->ssl ? fwp_tls_peer_subject(k->c->ssl) : 0;";
    let copy = "pv = fwp_some(fwp_cstr(peer));";
    assert_eq!(generated.matches(subject).count(), 1);
    assert_eq!(generated.matches(copy).count(), 1);
    let generated = generated
        .replacen(
            subject,
            "char *peer = k->c->ssl ? metadata_subject() : 0;",
            1,
        )
        .replacen(copy, "pv = metadata_option(metadata_copy(peer));", 1);
    let hooks = r#"
#include <stdint.h>
#include <stdlib.h>
static int stage,subject_calls,buffer_frees;
static void *buffer;
static char *metadata_subject(void);
static uintptr_t metadata_copy(const char *);
static uintptr_t metadata_option(uintptr_t);
static void metadata_free(void *);
static void metadata_no_free(void *);
#define free(p) metadata_free(p)
"#;
    let fixture = r#"
#undef free
static void metadata_free(void *p){if(p&&p==buffer){buffer_frees++;buffer=0;}free(p);}
static void metadata_no_free(void *p){(void)p;}
static char *metadata_subject(void){subject_calls++;if(stage==3)return 0;buffer=malloc(11);if(!buffer)_Exit(30);memcpy(buffer,"CN=runtime",11);return buffer;}
static uintptr_t metadata_copy(const char *p){if(stage==1)fwp_trap("metadata string copy");return fwp_cstr(p);}
static uintptr_t metadata_option(uintptr_t p){if(stage==2)fwp_trap("metadata option allocation");return fwp_some(p);}
static int recover(void){return 1;}
static jmp_buf failure;
static int probe(void){
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));
 SSL_CTX *ctx=SSL_CTX_new(TLS_client_method());if(!ctx)return 31;
 SSL *ssl=SSL_new(ctx);SSL_CTX_free(ctx);if(!ssl)return 32;
 g_conn *c=g_conn_new(-1,"local",0);c->ssl=ssl;
 g_stream *s=g_stream_new(c,1);V call=g_call_value(c,s,1,0);
 for(stage=0;stage<5;stage++){
  buffer=0;buffer_frees=subject_calls=0;
  c->ssl=stage==4?0:ssl;
  fwp_trap_recover=recover;fwp_trap_jb=&failure;fwp_trap_cleanup=0;
  if(!setjmp(failure)){
   V result=fwp_p_http2_request(call);
   if(stage==1||stage==2)return 4;
   if(OBJ(result)->n!=5)return 5;
   V subject=OBJ(result)->f[4];
   if(stage==0){if(subject==FWP_NONE||strcmp(STR(OBJ(subject)->f[0])->d,"CN=runtime"))return 6;}
   else if(subject!=FWP_NONE)return 7;
  }else if(stage!=1&&stage!=2)return 8;
  fwp_trap_recover=0;fwp_trap_jb=0;
  if(buffer_frees!=(stage<3?1:0)){fprintf(stderr,"stage %d frees %d expected %d\n",stage,buffer_frees,stage<3?1:0);return 1;}
  if(subject_calls!=(stage==4?0:1)||fwp_cleanups){fprintf(stderr,"stage %d calls %d cleanup %p\n",stage,subject_calls,(void *)fwp_cleanups);return 2;}
 }
 c->ssl=ssl;FWP_KEEP_ALIVE(call);fwp_lib_finish();return 0;
}
int main(void){int status=probe();if(status)_Exit(status);return 0;}
"#;
    let dir = fwp::cgen::TempDir::new("http2-peer-cleanup").unwrap();
    let exe = dir.join("probe");
    let needle = "fwp_cleanup_push(&peer_cleanup, fwp_tls_subject_free, peer);";
    assert_eq!(generated.matches(needle).count(), 1);
    let broken = generated.replacen(
        needle,
        "fwp_cleanup_push(&peer_cleanup, metadata_no_free, peer);",
        1,
    );
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{hooks}\n{broken}\n{fixture}"), &exe, opt).unwrap();
        let out = Command::new(&exe).output().unwrap();
        assert_eq!(out.status.code(), Some(1), "omitted cleanup: {out:?}");
        fwp::cgen::compile_c(&format!("{hooks}\n{generated}\n{fixture}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let out = Command::new(&exe)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", poison)
                .output()
                .unwrap();
            assert!(out.status.success(), "{opt}/{poison}: {out:?}");
        }
    }
}
