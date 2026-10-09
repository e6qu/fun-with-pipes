//! Immutable TLS options use one checked allocation with aligned header storage.
use fwp::ir::*;
use std::process::Command;

#[test]
fn tls_options_use_one_allocation_and_release_after_the_last_owner() {
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
    let (generated, _) = fwp::cgen::generate_library(&program, "grpc_packed").unwrap();
    assert!(generated.contains("#define FWP_GCTX_OWNERS 1"));
    let hooks = r#"
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
static int measuring,fail_allocation,calls,allocations,frees;
static size_t allocated_bytes;static void *watched[8];
static void *observe_malloc(size_t);
static void *observe_calloc(size_t,size_t);
static void *observe_realloc(void *,size_t);
static char *observe_strdup(const char *);
static void observe_free(void *);
#define malloc(n) observe_malloc(n)
#define calloc(n,s) observe_calloc(n,s)
#define realloc(p,n) observe_realloc(p,n)
#define strdup(s) observe_strdup(s)
#define free(p) observe_free(p)
"#;
    let fixture = r#"
#undef malloc
#undef calloc
#undef realloc
#undef strdup
#undef free
static void remember(void *p,size_t n){if(measuring){if(allocations==8)_Exit(9);watched[allocations++]=p;allocated_bytes+=n;}}
static void *observe_malloc(size_t n){if(measuring){calls++;if(fail_allocation){measuring=0;return 0;}}void *p=malloc(n);if(p)remember(p,n);return p;}
static void *observe_calloc(size_t n,size_t s){if(measuring)calls++;void *p=calloc(n,s);if(p)remember(p,n*s);return p;}
static void *observe_realloc(void *old,size_t n){if(measuring)calls++;void *p=realloc(old,n);if(p)remember(p,n);return p;}
static char *observe_strdup(const char *s){if(measuring)calls++;char *p=strdup(s);if(p)remember(p,strlen(s)+1);return p;}
static void observe_free(void *p){if(p)for(int i=0;i<allocations;i++)if(watched[i]==p){watched[i]=0;frees++;break;}free(p);}
int main(void){
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));fwp_tasks_init();fwp_trap_recover=g_trap_recover;
 jmp_buf failed;fwp_cur->trap_jb=&failed;fwp_cur->trap_cleanup=fwp_cleanups;
 measuring=fail_allocation=1;
 if(!setjmp(failed)){g_tls_new("ca",1,"name","cert","key");return 2;}
 if(calls!=1||allocations||frees||fwp_cleanups||strcmp(fwp_trap_msg,"cannot allocate TLS options"))return 3;
 fail_allocation=0;fwp_cur->trap_jb=0;
 for(int empty=0;empty<2;empty++){
  calls=allocations=frees=0;allocated_bytes=0;memset(watched,0,sizeof watched);
  char name[4097];memset(name,'x',4096);name[4096]=0;
  const char *ca=empty?"":"ca",*n=empty?"":name,*cert=empty?"":"cert",*key=empty?"":"key";
  size_t strings=strlen(ca)+strlen(n)+strlen(cert)+strlen(key);
  size_t bytes=sizeof(g_tls)+strings+4+1+4*sizeof(size_t)+strings;
  measuring=1;g_tls *tls=g_tls_new(ca,!empty,n,cert,key);measuring=0;
  if(calls!=1||allocations!=1||allocated_bytes!=bytes||((uintptr_t)tls)%_Alignof(g_tls))return 1;
  const char *parts[]={tls->ca,tls->name,tls->cert,tls->keyfile};const char *values[]={ca,n,cert,key};
  for(int i=0;i<4;i++)if(parts[i]<(char*)(tls+1)||parts[i]+strlen(parts[i])+1>(char*)tls+bytes||strcmp(parts[i],values[i]))return 4;
  if(tls->key<(char*)(tls+1)||tls->key+tls->key_len!=(char*)tls+bytes)return 5;
  if(!empty){name[0]='y';if(tls->name[0]!='x')return 6;}
  tls->users=1;g_ctx context={0};context.tls=tls;
  if(g_context_acquire(&context)!=&context||g_context_acquire(&context)!=&context||tls->users!=3)return 7;
  g_context_release(&context);g_context_release(&context);if(frees||tls->users!=1)return 8;
  g_tls_release(tls);if(frees!=1)return 1;
 }
 fwp_lib_finish();return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("grpc-packed-options").unwrap();
    let exe = dir.join("probe");
    for opt in ["-O1", "-O2"] {
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
