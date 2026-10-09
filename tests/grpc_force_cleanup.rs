//! Streaming cell receive ownership survives decoder/copy traps and transfers.
use fwp::ir::*;
use std::process::Command;

#[test]
fn forced_cells_release_received_storage_and_decoder_failure_text() {
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
    let (generated, _) = fwp::cgen::generate_library(&program, "grpc_force").unwrap();
    let decode = "g_decode(&src->dec, g.m->d, g.m->n, &x, &why)";
    assert_eq!(generated.matches(decode).count(), 2);
    let generated = generated.replace(decode, "observed_decode(&x, &why)");
    let copy = "last->memo = FWP_NONE;\n    V f[2] = {(V)(int64_t)code, fwp_cstr(text)};";
    assert_eq!(generated.matches(copy).count(), 1);
    let generated = generated.replacen(
        copy,
        "last->memo = FWP_NONE;\n    V f[2] = {(V)(int64_t)code, observed_copy(text)};",
        1,
    );
    let hooks = r#"
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
static int stage,allocations,frees;
static void *owned[16];
static char *observed_strdup(const char *);
static void observed_free(void *);
static void no_release(void *);
static int observed_decode(uintptr_t *,char **);
static uintptr_t observed_copy(const char *);
#define strdup(p) observed_strdup(p)
#define free(p) observed_free(p)
"#;
    let fixture = r#"
#undef strdup
#undef free
static void remember(void *p){if(!p||allocations==16)_Exit(30);owned[allocations++]=p;}
static char *observed_strdup(const char *p){char *copy=strdup(p);remember(copy);return copy;}
static void observed_free(void *p){if(p)for(int i=0;i<allocations;i++)if(owned[i]==p){owned[i]=0;frees++;break;}free(p);}
static void no_release(void *p){(void)p;}
static int observed_decode(uintptr_t *out,char **why){
 if(stage==8)fwp_trap("decode trap");
 if(stage==4||stage==5||stage==10){*why=observed_strdup("decode reason");return G_DEC_BAD;}
 *out=42;return stage==9?G_DEC_ERROR:G_DEC_OK;
}
static uintptr_t observed_copy(const char *p){if(stage==2||stage==10)fwp_trap("copy trap");return fwp_cstr(p);}
static jmp_buf failed;
static int recover(void){return 1;}
int main(void){
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));fwp_tasks_init();
 g_server srv={0};srv.module="probe";g_conn *c=g_conn_new(-1,"local",&srv);
 for(stage=0;stage<11;stage++){
  allocations=frees=0;memset(owned,0,sizeof owned);
  g_stream *s=g_stream_new(c,(uint32_t)(1+2*stage));
  g_incoming *src=fwp_mem_alloc(sizeof *src);src->c=c;src->s=s;src->what="probe";
  src->results=stage==2||stage==4||stage==7||stage==10;
  if(stage<3)s->bad=strdup("bad request");else if(stage==3)s->remote_end=1;
  else{g_msg *m=malloc(sizeof *m+1);if(!m)return 31;memset(m,0,sizeof *m);m->n=1;m->d[0]=42;remember(m);s->mhead=s->mtail=m;}
  g_cell *cell=fwp_mem_alloc(sizeof *cell);cell->src=src;
  g_failure failure={0};V error=0;const fwp_desc *desc=0;volatile int trapped=0;
  fwp_trap_recover=recover;fwp_trap_jb=&failed;fwp_trap_cleanup=0;
  if(!setjmp(failed)){
   V r=g_force(cell,stage==0||stage==9,&failure,&error,&desc);
   if(stage==1||stage==2||stage==5||stage==8||stage==10)return 2;
   if(stage==0){if(r||cell->forced||!failure.text||strcmp(failure.text,"bad request")||frees)return 3;observed_free(failure.text);}
   else if(stage==9){if(r||cell->forced||error!=42||desc)return 4;}
   else{
    if(!cell->forced||cell->memo!=r)return 5;
    if(stage==3){if(r!=FWP_NONE)return 6;}
    else{
     if(r==FWP_NONE)return 7;V value=OBJ(OBJ(r)->f[0])->f[0];
     if(stage==4){V text=OBJ(OBJ(value)->f[0])->f[1];if(strcmp(STR(text)->d,"bad response from probe: decode reason"))return 8;}
     else if((stage==7?OBJ(value)->f[0]:value)!=42)return 9;
    }
    int before=allocations;if(g_force(cell,0,&failure,&error,&desc)!=r||allocations!=before)return 10;
   }
  }else trapped=1;
  fwp_trap_recover=0;fwp_trap_jb=0;
  int expected=stage==4||stage==10?3:stage==5?2:1;
  if(allocations!=expected||frees!=expected||fwp_cleanups)return 1;
  if(trapped&&cell->forced)return 11;
  FWP_KEEP_ALIVE(PTR(cell));FWP_KEEP_ALIVE(PTR(src));FWP_KEEP_ALIVE(PTR(s));FWP_KEEP_ALIVE(PTR(c));
 }
 FWP_KEEP_ALIVE(PTR(c));fwp_lib_finish();return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("grpc-force-cleanup").unwrap();
    let exe = dir.join("probe");
    let receive = "fwp_cleanup_push(&received_cleanup, g_got_release, &g);";
    assert_eq!(generated.matches(receive).count(), 1);
    let receive_omitted = generated.replacen(
        receive,
        "fwp_cleanup_push(&received_cleanup, no_release, &g);",
        1,
    );
    let reason = "fwp_tls_subject_free(why);";
    assert_eq!(generated.matches(reason).count(), 3);
    let reason_omitted = generated.replace(reason, "no_release(why);");
    let text = "fwp_cleanup_push(&text_cleanup, fwp_tls_subject_free, t);";
    assert_eq!(generated.matches(text).count(), 1);
    let text_omitted =
        generated.replacen(text, "fwp_cleanup_push(&text_cleanup, no_release, t);", 1);
    for opt in ["-O1", "-O2"] {
        for broken in [&receive_omitted, &reason_omitted, &text_omitted] {
            fwp::cgen::compile_c(&format!("{hooks}\n{broken}\n{fixture}"), &exe, opt).unwrap();
            let out = Command::new(&exe).env("FWP_GC", "off").output().unwrap();
            assert_eq!(out.status.code(), Some(1), "omitted release: {out:?}");
        }
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
