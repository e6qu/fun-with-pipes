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
    // GCC and Clang on x86-64 can leave dead call/stream pointers in callee-saved
    // registers. Isolate construction and clear those stale roots in the
    // copying frame; a live post-copy owner fence forces a surviving spill.
    let clear_stale_roots = cfg!(target_arch = "x86_64");
    let generated = if clear_stale_roots {
        let primitive = "static V fwp_p_http2_body(V max, V timeout, V call) {";
        assert_eq!(generated.matches(primitive).count(), 1);
        // This fixture always copies a completed stream. Select its known
        // path so Clang does not spill the owner for an unreachable wait loop.
        let completed = "        if (s->remote_end) {\n            V b = fwp_str_new((const char *)s->data.d, s->data.len);";
        assert_eq!(generated.matches(completed).count(), 1);
        generated
            .replacen(
                primitive,
                "static __attribute__((always_inline)) inline V fwp_p_http2_body(V max, V timeout, V call) {",
                1,
            )
            .replacen(
                completed,
                &completed.replacen("if (s->remote_end)", "if (1)", 1),
                1,
            )
    } else {
        generated
    };
    let boundary = if clear_stale_roots {
        "static __attribute__((always_inline)) inline V fwp_str_new(const char *s, size_t len) { clear_dead_registers(); inspect_owner();"
    } else {
        "static V fwp_str_new(const char *s, size_t len) { inspect_owner();"
    };
    let generated = generated
        .replace(
            "static V fwp_str_new(const char *s, size_t len) {",
            boundary,
        )
        .replace(
            "static void g_stream_final(void *p) {",
            "static void g_stream_final(void *p) { if(((g_stream *)p)->data.d==watched_body)released++;",
        );
    let hooks = r#"
static unsigned char *watched_body;
static int copy_active,released;
static void inspect_owner(void);
#if defined(__x86_64__)
#define clear_dead_registers() __asm__ volatile("xor %%ebx,%%ebx; xor %%r12d,%%r12d; xor %%r13d,%%r13d; xor %%r14d,%%r14d; xor %%r15d,%%r15d" : : : "rbx","r12","r13","r14","r15","memory")
#endif
"#;
    let fixture = r#"
static void inspect_owner(void){
 if(!copy_active)return;copy_active=0;
 if(!fwp_gc.armed)_Exit(2);size_t before=fwp_gc.ncollect;
 fwp_gc.major_next=1;fwp_gc_collect();
 if(fwp_gc.ncollect<=before)_Exit(3);if(released)_Exit(1);
}
static __attribute__((noinline)) V body(void){
 g_conn *conn=g_conn_new(-1,"local",0);
 g_stream *stream=g_stream_new(conn,1);
 static const unsigned char bytes[]={0,255,192,128,10};
 h2b_put(&stream->data,bytes,sizeof bytes);stream->remote_end=1;
 watched_body=stream->data.d;
 V call=g_call_value(conn,stream,1,0);copy_active=1;
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
    let fixture = if clear_stale_roots {
        fixture
            .replace(
                "static __attribute__((noinline)) V body(void){",
                "static __attribute__((noinline)) V make_call(void){",
            )
            .replace(
                " V call=g_call_value(conn,stream,1,0);copy_active=1;",
                r#"
 return g_call_value(conn,stream,1,0);
}
static __attribute__((noinline)) void clear_dead_stack(void){
 volatile uintptr_t scratch[256];for(size_t i=0;i<256;i++)scratch[i]=0;
}
static __attribute__((noinline)) V body(void){
 /* Reserve rbp for the actual frame rather than an uncleared heap pointer. */
 __asm__ volatile("" : : "r"(__builtin_frame_address(0)) : "memory");
 V call=make_call();clear_dead_stack();copy_active=1;
"#,
            )
    } else {
        fixture.to_owned()
    };
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
    if let Ok(path) = std::env::var("FWP_HTTP2_C_DIAGNOSTIC") {
        std::fs::write(path, format!("{hooks}\n{broken}\n{fixture}")).unwrap();
    }
    fwp::cgen::compile_c(&format!("{hooks}\n{broken}\n{fixture}"), &exe, "-O2").unwrap();
    let out = Command::new(&exe).output().unwrap();
    assert_eq!(out.status.code(), Some(1), "omitted owner: {out:?}");
}
