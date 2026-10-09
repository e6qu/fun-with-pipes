//! Environment TLS cache owners are released after tasks and finalizers.
use fwp::ir::*;
use std::process::Command;

#[test]
fn environment_tls_cache_releases_after_task_and_finalizer_teardown() {
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
    let (generated, _) = fwp::cgen::generate_library(&program, "grpc_environment").unwrap();
    assert!(generated.contains("#define FWP_GCTX_OWNERS 1"));
    let hooks = r#"
#include <stdlib.h>
static void *owned[16];static int nowned,frees,entered,cancelled,finalized,order_error;
static const char *expected;
static void observe_free(void *);
#define free(p) observe_free(p)
"#;
    let fixture = r#"
#undef free
static void observe_free(void *p){if(p)for(int i=0;i<nowned;i++)if(owned[i]==p){owned[i]=0;frees++;break;}free(p);}
static void observe_cache(void){
 nowned=0;for(g_env_options *k=g_env_options_known;k;k=k->next){
  owned[nowned++]=k;owned[nowned++]=(void*)k->var;
  if(k->tls){const g_tls *t=k->tls;owned[nowned++]=(void*)t;owned[nowned++]=t->ca;owned[nowned++]=t->name;owned[nowned++]=t->cert;owned[nowned++]=t->keyfile;owned[nowned++]=t->key;}
 }
}
static void finalizer(void *p){finalized++;if(frees||!g_env_options_known||strcmp(g_env_tls("FWP_SERVICE_CACHE")->ca,expected))order_error=1;}
static void blocked(void *p,int stop){
 const g_tls *tls=g_ctx_of()->tls;if(frees||!tls||strcmp(tls->ca,expected)||tls->users!=SIZE_MAX)_Exit(2);
 if(stop){cancelled++;return;}entered++;fwp_park(0,0);fwp_check_cancel();_Exit(3);
}
int main(void){
 const char *const suffixes[]={"CA","INSECURE","SERVER_NAME","CERT","KEY"};
 for(int i=0;i<5;i++){char name[100];snprintf(name,sizeof name,"FWP_SERVICE_EMPTY_%s",suffixes[i]);unsetenv(name);snprintf(name,sizeof name,"FWP_SERVICE_CACHE_%s",suffixes[i]);unsetenv(name);}
 setenv("FWP_SERVICE_CACHE_CA","first",1);
 for(int round=0;round<2;round++){
  expected=round?"second":"first";frees=entered=cancelled=finalized=order_error=0;memset(owned,0,sizeof owned);
  fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));fwp_tasks_init();
  const g_tls *tls=g_env_tls("FWP_SERVICE_CACHE");if(!tls||strcmp(tls->ca,expected)||tls->users!=SIZE_MAX)return 4;
  if(g_env_tls("FWP_SERVICE_EMPTY"))return 5;
  observe_cache();if(nowned!=10)return 6;
  setenv("FWP_SERVICE_CACHE_CA",round?"third":"second",1);
  if(g_env_tls("FWP_SERVICE_CACHE")!=tls||strcmp(tls->ca,expected)||frees)return 7;
  g_ctx context={0};context.tls=tls;g_ctx_of();fwp_cur->gctx=&context;
  fwp_task *task=fwp_spawn_task(0,blocked,0,0,1);fwp_cur->gctx=0;fwp_p_task_yield();
  if(!entered||task->done||frees)return 8;
  void *value=fwp_mem_alloc(16);fwp_gc_finalizer(value,finalizer);
  fwp_lib_finish();
  if(frees!=nowned||cancelled!=1||finalized!=1||order_error||g_env_options_known||g_pool||fwp_gctx_acquire||fwp_gctx_release||fwp_gc.ready)return 1;
  fwp_lib_finish();if(frees!=nowned)return 9;
  FWP_KEEP_ALIVE(value);
 }
 unsetenv("FWP_SERVICE_CACHE_CA");return 0;
}
"#;
    let cleanup = "    g_environment_finish();";
    assert_eq!(generated.matches(cleanup).count(), 1);
    let broken = generated.replacen(cleanup, "    /* omitted environment cleanup */", 1);
    let dir = fwp::cgen::TempDir::new("grpc-environment-cache").unwrap();
    let exe = dir.join("probe");
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{hooks}\n{broken}\n{fixture}"), &exe, opt).unwrap();
        let out = Command::new(&exe).env("FWP_GC", "off").output().unwrap();
        assert_eq!(out.status.code(), Some(1), "omitted cache cleanup: {out:?}");
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
