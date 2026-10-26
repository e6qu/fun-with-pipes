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
    let (generated, _) = fwp::cgen::generate_library(&program, "grpc_canonical", &[]).unwrap();
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
#ifdef _WIN32
#ifndef _WIN32_WINNT
#define _WIN32_WINNT 0x0a00
#endif
#endif
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
 fwp_lib_init();fwp_heap_start();fwp_tasks_init();
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
        let out = Command::new(&exe).output().unwrap();
        assert_eq!(out.status.code(), Some(1), "omitted cleanup: {out:?}");
        fwp::cgen::compile_c(&format!("{hooks}\n{generated}\n{fixture}"), &exe, opt).unwrap();

        let out = Command::new(&exe).output().unwrap();
        assert!(out.status.success(), "{opt}: {out:?}");
    }
}

#[test]
fn canonical_decoding_scratch_releases_on_malformed_values_and_allocation_traps() {
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
    let (mut generated, _) = fwp::cgen::generate_library(&program, "grpc_decode", &[]).unwrap();
    for (before, after) in [
        (
            "pb_decode(k->schema, k->node, msg, n, &canon)",
            "observed_decode(k->schema, k->node, msg, n, &canon)",
        ),
        (
            "static inline void *fwp_heap_alloc(size_t n, int kind) {",
            "static inline void *fwp_heap_alloc(size_t n, int kind) { if(decode_fail && kind) fwp_trap(\"decode allocation failure\");",
        ),
    ] {
        assert_eq!(generated.matches(before).count(), 1, "{before}");
        generated = generated.replacen(before, after, 1);
    }
    let hooks = r#"
#ifdef _WIN32
#ifndef _WIN32_WINNT
#define _WIN32_WINNT 0x0a00
#endif
#endif
#include <stdlib.h>
static void *decode_buffer;
static int decode_frees,decode_fail,decode_result;
static void decode_free(void *);
static void no_decode_release(void *);
#define free(p) decode_free(p)
#define observed_decode(s,node,msg,n,out) (decode_result=pb_decode(s,node,msg,n,out),decode_buffer=(out)->d,decode_result)
"#;
    let fixture = r#"
#undef free
static void decode_free(void *p){if(p && p==decode_buffer){decode_frees++;decode_buffer=0;}free(p);}
static void no_decode_release(void *p){(void)p;}
static int decode_recover(void){return 1;}
static jmp_buf decode_jump;
int main(void){
 fwp_lib_init();fwp_heap_start();fwp_tasks_init();
 const fwp_desc text={.kind=K_STR,.name="String"};
 const int plain[]={PB_MSG,1,1,4,PB_STR},tagged[]={PB_ONEOF,2,4,4,PB_STR};
 const int partial[]={PB_MSG,2,1,6,2,6,PB_STR},bytes[]={PB_MSG,1,1,4,PB_BYTES},empty[]={PB_MSG,0};
 const unsigned char good[]={10,3,'a','b','c'},error[]={18,3,'a','b','c'};
 const unsigned char bad_wire[]={10,3,'a','b','c',16,1},bad_utf8[]={10,1,255};
 for(int kind=0;kind<6;kind++)for(int failure=0;failure<(kind<3?2:1);failure++){
  g_codec codec={0};codec.ty=&text;codec.error=(kind==1||kind==2||kind==5)?&text:0;
  codec.schema=kind==0?plain:kind<3?tagged:kind==3?partial:kind==4?bytes:empty;
  const unsigned char *input=kind==2?error:kind==3?bad_wire:kind==4?bad_utf8:good;
  size_t size=kind==3?sizeof bad_wire:kind==4?sizeof bad_utf8:kind==5?0:sizeof good;
  decode_buffer=0;decode_frees=0;decode_fail=failure;volatile int trapped=0;
  fwp_trap_recover=decode_recover;fwp_trap_jb=&decode_jump;fwp_trap_cleanup=0;
  if(!setjmp(decode_jump)){
   V result=0;char *why=0;int status=g_decode(&codec,input,size,&result,&why);
   if(failure)_Exit(43);
   if(kind<3){
    if(status!=(kind==2?G_DEC_ERROR:G_DEC_OK)||why||STR(result)->len!=3||memcmp(STR(result)->d,"abc",3))_Exit(44);
    fwp_rc_free_obj(result);
   }else{
    if(status!=G_DEC_BAD||!why||strcmp(why,"malformed message"))_Exit(45);
    free(why);
   }
  }else trapped=1;
  decode_fail=0;fwp_trap_recover=0;fwp_trap_jb=0;
  if(decode_frees!=(kind==5?0:1)||decode_buffer||fwp_cleanups)_Exit(42);
  if(trapped!=failure||(trapped&&strcmp(fwp_trap_msg,"decode allocation failure")))_Exit(46);
 }
 fwp_lib_finish();return 0;
}
"#;
    let cleanup = "fwp_cleanup_push(&decoded_canonical, g_h2_buffer_release, &canon);";
    assert_eq!(generated.matches(cleanup).count(), 1);
    let broken = generated.replacen(
        cleanup,
        "fwp_cleanup_push(&decoded_canonical, no_decode_release, &canon);",
        1,
    );
    let dir = fwp::cgen::TempDir::new("grpc-canonical-decoding").unwrap();
    let exe = dir.join("probe.exe");
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{hooks}\n{broken}\n{fixture}"), &exe, opt).unwrap();
        let out = Command::new(&exe).output().unwrap();
        assert_eq!(out.status.code(), Some(42), "omitted cleanup: {out:?}");
        fwp::cgen::compile_c(&format!("{hooks}\n{generated}\n{fixture}"), &exe, opt).unwrap();

        let out = Command::new(&exe).output().unwrap();
        assert!(out.status.success(), "{opt}: {out:?}");
    }
}
