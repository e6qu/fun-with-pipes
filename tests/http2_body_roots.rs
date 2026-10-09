//! Borrowed HTTP/2 body storage keeps its stream owner live during copying.
use fwp::ir::*;
use std::process::Command;

#[test]
fn body_copy_keeps_the_stream_alive_through_major_collection() {
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
    let (generated, _) = fwp::cgen::generate_library(&program, "body_roots").unwrap();
    let generated = generated
        .replace(
            "static V fwp_str_new(const char *s, size_t len) {",
            "static __attribute__((always_inline)) inline V fwp_str_new(const char *s, size_t len) { clear_dead_registers(); inspect_owner();",
        )
        .replace(
            "static void g_stream_final(void *p) {",
            "static void g_stream_final(void *p) { if(((g_stream *)p)->data.d==watched_body)released++;",
        );
    let hooks = r#"
static unsigned char *watched_body;
static int copy_active,released;
static void inspect_owner(void);
/* Remove stale conservative register roots at the copy boundary. A real live
 * owner is spilled across this clobber because its post-copy fence still uses it.
 * Force this test hook inline so a separate callee cannot save stale roots.
 * Keep frame/stack and platform-reserved registers intact. */
#if defined(__x86_64__)
#define clear_dead_registers() __asm__ volatile("xor %%ebx,%%ebx; xor %%r12d,%%r12d; xor %%r13d,%%r13d; xor %%r14d,%%r14d; xor %%r15d,%%r15d" : : : "rbx","r12","r13","r14","r15","memory")
#elif defined(__aarch64__)
#define clear_dead_registers() __asm__ volatile("mov x19,xzr; mov x20,xzr; mov x21,xzr; mov x22,xzr; mov x23,xzr; mov x24,xzr; mov x25,xzr; mov x26,xzr; mov x27,xzr; mov x28,xzr" : : : "x19","x20","x21","x22","x23","x24","x25","x26","x27","x28","memory")
#else
#define clear_dead_registers() ((void)0)
#endif
"#;
    let fixture = r#"
static void inspect_owner(void){
 if(!copy_active)return;copy_active=0;
 if(!fwp_gc.armed)_Exit(2);size_t before=fwp_gc.ncollect;
 fwp_gc.major_next=1;fwp_gc_collect();
 if(fwp_gc.ncollect<=before)_Exit(3);if(released)_Exit(1);
}
/* Keep construction-only owner pointers out of the active copying frame. */
static __attribute__((noinline)) V make_call(void){
 g_conn *conn=g_conn_new(-1,"local",0);
 g_stream *stream=g_stream_new(conn,1);
 static const unsigned char bytes[]={0,255,192,128,10};
 h2b_put(&stream->data,bytes,sizeof bytes);stream->remote_end=1;
 watched_body=stream->data.d;
 return g_call_value(conn,stream,1,0);
}
static __attribute__((noinline)) void clear_dead_stack(void){
 volatile uintptr_t scratch[256];for(size_t i=0;i<256;i++)scratch[i]=0;
}
static __attribute__((noinline)) V body(void){
 V call=make_call();clear_dead_stack();copy_active=1;
 struct {uint32_t tag,n;V f[1];} duration={0,1,{0}};
 return fwp_p_http2_body(64,PTR(&duration),call);
}
static int probe(void){
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));
 if(!fwp_gc.armed)return 30;
 V result=body();
 static const unsigned char bytes[]={0,255,192,128,10};
 if(copy_active||released||OBJ(result)->tag||OBJ(result)->n!=1)return 4;
 V payload=OBJ(result)->f[0];
 if(STR(payload)->len!=sizeof bytes||memcmp(STR(payload)->d,bytes,sizeof bytes))return 5;
 fwp_lib_finish();if(released!=1)return 6;
 return 0;
}
int main(void){int status=probe();if(status)_Exit(status);return 0;}
"#;
    let dir = fwp::cgen::TempDir::new("http2-body-roots").unwrap();
    let exe = dir.join("probe");
    let needle = "    /* Body bytes belong to the stream's malloc buffer, not the GC heap. */\n            FWP_KEEP_ALIVE(call);";
    assert_eq!(generated.matches(needle).count(), 1);
    let broken = generated.replacen(needle, "    /* omit borrowed stream owner fence */", 1);
    for opt in ["-O1", "-O2"] {
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
    fwp::cgen::compile_c(&format!("{hooks}\n{broken}\n{fixture}"), &exe, "-O2").unwrap();
    std::fs::copy(&exe, "/tmp/fwp-http2-owner-omitted").unwrap();
    let out = Command::new(&exe).output().unwrap();
    assert_eq!(out.status.code(), Some(1), "omitted owner: {out:?}");
}
