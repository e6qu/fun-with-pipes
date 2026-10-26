//! Borrowed HTTP/2 bytes remain valid until their stream owner is released.
use std::process::Command;

#[path = "support/http2_values.rs"]
mod http2_values;

#[test]
fn body_copy_retains_its_stream_until_the_result_is_owned() {
    let generated = http2_values::generated();
    let boundary = "static V fwp_str_new(const char *s, size_t len) {";
    let finalizer = "static void g_stream_final(void *p) {";
    assert_eq!(generated.matches(boundary).count(), 1);
    assert_eq!(generated.matches(finalizer).count(), 1);
    let generated = generated
        .replace(boundary, &format!("{boundary} inspect_owner();"))
        .replace(
            finalizer,
            &format!("{finalizer} if(((g_stream *)p)->data.d==watched_body)released++;"),
        );
    let hooks = r#"
#include <stdint.h>
static unsigned char *watched_body;
static uintptr_t watched_call;
static int copy_active,released;
static void inspect_owner(void);
"#;
    let fixture = r#"
static void inspect_owner(void){
 if(!copy_active)return;copy_active=0;
 /* The fault stops here, before fwp_str_new reads the borrowed bytes. */
 if(PROBE_RELEASE_BEFORE_COPY)g_call_drop((V)watched_call);
 if(released)_Exit(1);
}
static V body(void){
 g_conn *conn=g_conn_new(-1, "", "local",0);fwp_rc_fresh(PTR(conn));
 g_stream *stream=g_stream_new(conn,1);fwp_rc_fresh(PTR(stream));
 static const unsigned char bytes[]={0,255,192,128,10};
 h2b_put(&stream->data,bytes,sizeof bytes);stream->remote_end=1;
 watched_body=stream->data.d;
 V call=g_call_value(conn,stream);
 /* Transfer the creator/list owners: the call now owns both objects. */
 g_unlink(conn,stream);g_conn_drop(conn);
 watched_call=(uintptr_t)call;copy_active=1;
 struct {uint32_t tag,n;V f[1];} duration={0,1,{0}};
 V result=fwp_p_http2_body(64,PTR(&duration),call,BODY_TYPE);
 g_call_drop(call);watched_call=0;
 return result;
}
static int probe(void){
 fwp_lib_init();size_t baseline=fwp_heap.live;
 V result=body();
 static const unsigned char bytes[]={0,255,192,128,10};
 if(copy_active||released!=1||OBJ(result)->tag||OBJ(result)->n!=1)return 4;
 V payload=OBJ(result)->f[0];
 if(STR(payload)->len!=sizeof bytes||memcmp(STR(payload)->d,bytes,sizeof bytes))return 5;
 BODY_TYPE->drop(result);
 if(fwp_heap.live!=baseline)return 7;
 fwp_lib_finish();if(released!=1)return 6;
 return 0;
}
int main(void){int status=probe();if(status)_Exit(status);return 0;}
"#;
    let dir = fwp::cgen::TempDir::new("http2-body-lifetime").unwrap();
    let exe = dir.join("probe");
    for opt in ["-O1", "-O2"] {
        for premature_release in [false, true] {
            let code = format!(
                "#define PROBE_RELEASE_BEFORE_COPY {}\n{hooks}\n{generated}\n{fixture}",
                usize::from(premature_release)
            );
            fwp::cgen::compile_c(&code, &exe, opt).unwrap();
            let out = Command::new(&exe).output().unwrap();
            assert_eq!(
                out.status.code(),
                Some(if premature_release { 1 } else { 0 }),
                "{opt}: {out:?}"
            );
            assert!(out.stdout.is_empty() && out.stderr.is_empty(), "{out:?}");
        }
    }
}
