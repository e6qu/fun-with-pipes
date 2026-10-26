//! Borrowed HTTP/2 body storage keeps its stream owner live during copying.
#[path = "support/http2_values.rs"]
mod http2_values;
use std::process::Command;

#[test]
fn body_copy_keeps_the_stream_alive_through_major_collection() {
    let generated = http2_values::generated();
    // GCC and Clang can leave dead call/stream pointers in callee-saved
    // registers. Isolate construction and clear those stale roots in the
    // copying frame; a live post-copy owner fence forces a surviving spill.
    let clear_stale_roots = cfg!(any(target_arch = "x86_64", target_arch = "aarch64"));
    let generated = if clear_stale_roots {
        let primitive =
            "static V fwp_p_http2_body(V max, V timeout, V call, const fwp_desc *type) {";
        assert_eq!(generated.matches(primitive).count(), 1);
        // This fixture always copies a completed stream. Select its known
        // path so Clang does not spill the owner for an unreachable wait loop.
        let completed = "        if (s->remote_end) {\n            fwp_decode_fields result;";
        assert_eq!(generated.matches(completed).count(), 1);
        generated
            .replacen(
                primitive,
                "static __attribute__((always_inline)) inline V fwp_p_http2_body(V max, V timeout, V call, const fwp_desc *type) {",
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
        "static __attribute__((always_inline)) inline V fwp_str_new(const char *s, size_t len) { clear_dead_registers(); clear_dead_stack(); inspect_owner();"
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
#if defined(__x86_64__) || defined(__aarch64__)
static void clear_dead_stack(void);
#endif
#if defined(__x86_64__)
#define clear_dead_registers() __asm__ volatile("xor %%ebx,%%ebx; xor %%r12d,%%r12d; xor %%r13d,%%r13d; xor %%r14d,%%r14d; xor %%r15d,%%r15d" : : : "rbx","r12","r13","r14","r15","memory")
#elif defined(__aarch64__)
/* x18 is reserved on Darwin; x29 remains the frame pointer. */
#define clear_dead_registers() __asm__ volatile("mov x19,xzr; mov x20,xzr; mov x21,xzr; mov x22,xzr; mov x23,xzr; mov x24,xzr; mov x25,xzr; mov x26,xzr; mov x27,xzr; mov x28,xzr" : : : "x19","x20","x21","x22","x23","x24","x25","x26","x27","x28","memory")
#endif
"#;
    let fixture = r#"
static void inspect_owner(void){
 if(!copy_active)return;copy_active=0;
 if(!fwp_heap.armed)_Exit(2);size_t before=fwp_heap.ncollect;
 fwp_heap.major_next=1;fwp_heap_collect();
 if(fwp_heap.ncollect<=before)_Exit(3);if(released)_Exit(1);
}
static __attribute__((noinline)) V body(void){
 g_conn *conn=g_conn_new(-1, "", "local",0);
 g_stream *stream=g_stream_new(conn,1);
 static const unsigned char bytes[]={0,255,192,128,10};
 h2b_put(&stream->data,bytes,sizeof bytes);stream->remote_end=1;
 watched_body=stream->data.d;
 V call=g_call_value(conn,stream);copy_active=1;
 struct {uint32_t tag,n;V f[1];} duration={0,1,{0}};
 return fwp_p_http2_body(64,PTR(&duration),call,BODY_TYPE);
}
static int probe(void){
 fwp_lib_init();fwp_heap_start();
 if(!fwp_heap.armed)return 30;
 V result=body();
 static const unsigned char bytes[]={0,255,192,128,10};
 if(copy_active||released||OBJ(result)->tag||OBJ(result)->n!=1)return 4;
 V payload=OBJ(result)->f[0];
 if(STR(payload)->len!=sizeof bytes||memcmp(STR(payload)->d,bytes,sizeof bytes))return 5;
 BODY_TYPE->drop(result);
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
                " V call=g_call_value(conn,stream);copy_active=1;",
                r#"
 return g_call_value(conn,stream);
}
static __attribute__((noinline)) void clear_dead_stack(void){
 volatile uintptr_t scratch[256];for(size_t i=0;i<256;i++)scratch[i]=0;
}
static __attribute__((noinline)) V body(void){
 /* Reserve the frame pointer for the actual frame, not a stale heap root. */
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
    fwp::cgen::compile_c(&format!("{hooks}\n{broken}\n{fixture}"), &exe, "-O2").unwrap();
    let out = Command::new(&exe).output().unwrap();
    assert_eq!(out.status.code(), Some(1), "omitted owner: {out:?}");
}
