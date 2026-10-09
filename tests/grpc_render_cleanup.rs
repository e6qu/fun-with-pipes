//! Rendering a streamed error releases its scratch buffer before trap recovery.
use fwp::ir::*;
use std::process::Command;

#[test]
fn streamed_error_rendering_releases_partial_and_complete_scratch() {
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
    let (generated, _) = fwp::cgen::generate_library(&program, "grpc_render").unwrap();
    let decode = "g_decode(&src->dec, g.m->d, g.m->n, &x, &why)";
    assert_eq!(generated.matches(decode).count(), 2);
    let generated = generated.replace(decode, "observed_decode(&x, &why)");
    let write = "fwp_write(&b, x, src->dec.error, 1);";
    assert_eq!(generated.matches(write).count(), 1);
    let generated = generated.replacen(write, "observed_write(&b, x, src->dec.error);", 1);
    let hooks = r#"
#include <stdlib.h>
#include <stdint.h>
static int stage,buffer_frees;
static void *rendered;
static int observed_decode(uintptr_t *,char **);
static void observed_free(void *);
static void no_release(void *);
#define free(p) observed_free(p)
#define observed_write(buffer_,value_,descriptor_) do { fwp_write(buffer_,value_,descriptor_,1); rendered=(buffer_)->d; if(stage)fwp_trap("render trap"); } while(0)
"#;
    let fixture = r#"
#undef free
static void observed_free(void *p){if(p&&p==rendered){buffer_frees++;rendered=0;}free(p);}
static void no_release(void *p){(void)p;}
static int observed_decode(uintptr_t *out,char **why){*out=42;*why=0;return G_DEC_ERROR;}
static int recover(void){return 1;}
static jmp_buf failed;
int main(void){
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));fwp_tasks_init();
 g_server srv={0};srv.module="probe";g_conn *c=g_conn_new(-1,"local",&srv);
 const fwp_desc descriptor={.kind=K_I64,.name="I64"};
 for(stage=0;stage<2;stage++){
  rendered=0;buffer_frees=0;
  g_stream *s=g_stream_new(c,(uint32_t)(1+2*stage));
  g_msg *m=malloc(sizeof *m+1);if(!m)return 30;memset(m,0,sizeof *m);m->n=1;m->d[0]=42;s->mhead=s->mtail=m;
  g_incoming *src=fwp_mem_alloc(sizeof *src);src->c=c;src->s=s;src->what="probe";src->dec.error=&descriptor;
  g_cell *cell=fwp_mem_alloc(sizeof *cell);cell->src=src;g_failure failure={0};V error=0;const fwp_desc *desc=0;
  fwp_trap_recover=recover;fwp_trap_jb=&failed;fwp_trap_cleanup=0;
  if(!setjmp(failed)){g_force(cell,0,&failure,&error,&desc);return 2;}
  fwp_trap_recover=0;fwp_trap_jb=0;
  if(buffer_frees!=1||rendered||fwp_cleanups||cell->forced)return 1;
  if(strcmp(fwp_trap_msg,stage?"render trap":"service call probe failed: error: 42"))return 3;
  FWP_KEEP_ALIVE(PTR(cell));FWP_KEEP_ALIVE(PTR(src));FWP_KEEP_ALIVE(PTR(s));FWP_KEEP_ALIVE(PTR(c));
 }
 FWP_KEEP_ALIVE(PTR(c));fwp_lib_finish();return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("grpc-render-cleanup").unwrap();
    let exe = dir.join("probe");
    let cleanup = "fwp_cleanup_push(&error_buffer, fwp_file_buffer_cleanup, &b);";
    assert_eq!(generated.matches(cleanup).count(), 1);
    let omitted = generated.replacen(
        cleanup,
        "fwp_cleanup_push(&error_buffer, no_release, &b);",
        1,
    );
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{hooks}\n{omitted}\n{fixture}"), &exe, opt).unwrap();
        let out = Command::new(&exe).env("FWP_GC", "off").output().unwrap();
        assert_eq!(out.status.code(), Some(1), "omitted cleanup: {out:?}");
        fwp::cgen::compile_c(&format!("{hooks}\n{generated}\n{fixture}"), &exe, opt).unwrap();
        for gc in ["off", "on"] {
            for poison in ["0", "1"] {
                let out = Command::new(&exe)
                    .env("FWP_GC", gc)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison)
                    .output()
                    .unwrap();
                assert!(out.status.success(), "{opt}/{gc}/{poison}: {out:?}");
            }
        }
    }
}
