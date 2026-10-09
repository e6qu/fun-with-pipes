//! Canonical serialization scratch is owned until transcoding or exceptional exit.
use fwp::ir::*;
use std::process::Command;

#[test]
fn canonical_encoding_scratch_releases_on_partial_and_transcoder_failure() {
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
    let (generated, _) = fwp::cgen::generate_library(&program, "grpc_canonical").unwrap();
    let mut generated = generated;
    for (before, after) in [
        (
            "fwp_encode(&canon, v, k->ty);",
            "observed_value(&canon, v, k->ty);",
        ),
        (
            "fwp_encode(&canon, vals[i], r->m.req[i]);",
            "observed_value(&canon, vals[i], r->m.req[i]);",
        ),
        (
            "pb_encode(k->schema, k->node, (const unsigned char *)canon.d, canon.len, out)",
            "observed_transcode(canon.d, canon.len, out)",
        ),
        (
            "pb_encode(r->m.schema, r->m.req_node, (const unsigned char *)canon.d, canon.len, out)",
            "observed_transcode(canon.d, canon.len, out)",
        ),
    ] {
        assert_eq!(generated.matches(before).count(), 1);
        generated = generated.replacen(before, after, 1);
    }
    let hooks = r#"
#include <stdlib.h>
static int stage,canonical_frees;
static void *watched_canon;
static void observed_free(void *);
static void no_release(void *);
#define free(p) observed_free(p)
#define observed_value(buffer_,value_,descriptor_) do { fwp_encode(buffer_,value_,descriptor_); watched_canon=(buffer_)->d; if(stage==2)fwp_trap("canonical encode trap"); } while(0)
#define observed_transcode(data_,length_,output_) (stage==1 ? h2_fail("transcode failure") : (h2b_put(output_,data_,length_),1))
"#;
    let fixture = r#"
#undef free
static void observed_free(void *p){if(p&&p==watched_canon){canonical_frees++;watched_canon=0;}free(p);}
static void no_release(void *p){(void)p;}
static int recover(void){return 1;}
static jmp_buf failed;
int main(void){
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));fwp_tasks_init();
 const fwp_desc descriptor={.kind=K_I64,.name="I64"};const fwp_desc *fields[]={&descriptor};
 g_codec codec={0};codec.ty=&descriptor;fwp_remote remote={0};remote.what="probe";remote.m.nreq=1;remote.m.req=fields;
 for(int kind=0;kind<3;kind++)for(stage=0;stage<3;stage++){
  canonical_frees=0;watched_canon=0;h2_buf out={0};volatile int trapped=0;
  fwp_trap_recover=recover;fwp_trap_jb=&failed;fwp_trap_cleanup=0;
  if(!setjmp(failed)){
   V value=42;if(kind==2)g_encode_request(&remote,&value,&out);else g_encode(&codec,value,kind==1,&out);
   if(stage)return 2;
   size_t offset=kind==1?1:0;if(out.len!=offset+8||(offset&&out.d[0])||out.d[offset]!=42)return 3;
   for(size_t i=offset+1;i<out.len;i++)if(out.d[i])return 4;
  }else trapped=1;
  fwp_trap_recover=0;fwp_trap_jb=0;
  if(canonical_frees!=1||watched_canon||fwp_cleanups||trapped!=(stage!=0))return 1;
  if(stage){const char *expected=stage==2?"canonical encode trap":kind==2?"cannot encode the arguments of probe: transcode failure":"cannot encode a message: transcode failure";if(strcmp(fwp_trap_msg,expected))return 5;}
  h2b_free(&out);
 }
 fwp_lib_finish();return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("grpc-canonical-encoding").unwrap();
    let exe = dir.join("probe");
    let cleanup = "fwp_cleanup_push(&canonical_cleanup, fwp_file_buffer_cleanup, &canon);";
    assert_eq!(generated.matches(cleanup).count(), 2);
    let omitted = generated.replace(
        cleanup,
        "fwp_cleanup_push(&canonical_cleanup, no_release, &canon);",
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
