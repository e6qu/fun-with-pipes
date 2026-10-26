//! Environment TLS cache owners are released after tasks and finalizers.
use fwp::ir::*;
use std::process::Command;

fn runtime() -> String {
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
    let (generated, _) = fwp::cgen::generate_library(&program, "grpc_environment", &[]).unwrap();
    assert!(generated.contains("#define FWP_GCTX_OWNERS 1"));
    generated
}

#[test]
fn environment_tls_cache_releases_after_task_and_finalizer_teardown() {
    let generated = runtime();
    let hooks = r#"
#if defined(_WIN32) && !defined(_WIN32_WINNT)
#define _WIN32_WINNT 0x0a00
#endif
#include <stdlib.h>
static void *owned[16];static int nowned,frees,entered,cancelled,finalized,order_error;
static const char *expected;
static void observe_free(void *);
#define free(p) observe_free(p)
"#;
    let fixture = r#"
#undef free
static void observe_free(void *p){if(p)for(int i=0;i<nowned;i++)if(owned[i]==p){owned[i]=0;frees++;break;}free(p);}
// Use each platform's environment API; empty values remove variables here.
static void set_environment(const char *name,const char *value){
#ifdef _WIN32
 if(_putenv_s(name,value))_Exit(10);
#else
 if(value[0]?setenv(name,value,1):unsetenv(name))_Exit(10);
#endif
}

static void observe_cache(void){
 nowned=0;for(g_env_options *k=g_env_options_known;k;k=k->next){
  if(k->var!=(char*)(k+1))_Exit(11);
  owned[nowned++]=k;
  if(k->tls){const g_tls *t=k->tls;owned[nowned++]=(void*)t;}
 }
}
static void finalizer(void *p){finalized++;if(frees||!g_env_options_known||strcmp(g_env_tls("FWP_SERVICE_CACHE")->ca,expected))order_error=1;}
static void blocked(void *p,int stop){
 const g_tls *tls=g_ctx_of()->tls;if(frees||!tls||strcmp(tls->ca,expected)||tls->users!=SIZE_MAX)_Exit(2);
 if(stop){cancelled++;return;}entered++;fwp_park(0,0);fwp_check_cancel();_Exit(3);
}
int main(void){
 const char *const suffixes[]={"CA","INSECURE","SERVER_NAME","CERT","KEY"};
 for(int i=0;i<5;i++){char name[100];snprintf(name,sizeof name,"FWP_SERVICE_EMPTY_%s",suffixes[i]);set_environment(name,"");snprintf(name,sizeof name,"FWP_SERVICE_CACHE_%s",suffixes[i]);set_environment(name,"");}
 set_environment("FWP_SERVICE_CACHE_CA","first");
 for(int round=0;round<2;round++){
  expected=round?"second":"first";frees=entered=cancelled=finalized=order_error=0;memset(owned,0,sizeof owned);
  fwp_lib_init();fwp_heap_start();fwp_tasks_init();
  const g_tls *tls=g_env_tls("FWP_SERVICE_CACHE");if(!tls||strcmp(tls->ca,expected)||tls->users!=SIZE_MAX)return 4;
  if(g_env_tls("FWP_SERVICE_EMPTY"))return 5;
  char long_variable[1025],long_ca[1040];memset(long_variable,'X',sizeof long_variable-1);long_variable[sizeof long_variable-1]=0;
  snprintf(long_ca,sizeof long_ca,"%s_CA",long_variable);set_environment(long_ca,"long-name-ca");
  const g_tls *long_options=g_env_tls(long_variable);
  if(!long_options||strcmp(long_options->ca,"long-name-ca"))return 12;
  set_environment(long_ca,"");
  if(g_env_tls(long_variable)!=long_options)return 13;
  observe_cache();if(nowned!=5)return 6;
  set_environment("FWP_SERVICE_CACHE_CA",round?"third":"second");
  if(g_env_tls("FWP_SERVICE_CACHE")!=tls||strcmp(tls->ca,expected)||frees)return 7;
  g_ctx context={0};context.tls=tls;g_ctx_of();fwp_cur->gctx=&context;
  fwp_task *task=fwp_spawn_task(0,blocked,0,0,1);fwp_cur->gctx=0;fwp_p_task_yield();
  if(!entered||task->done||frees)return 8;
  void *value=fwp_mem_alloc(16);fwp_heap_finalizer(value,finalizer);
  fwp_lib_finish();
  if(frees!=nowned||cancelled!=1||finalized!=1||order_error||g_env_options_known||g_pool||fwp_gctx_acquire||fwp_gctx_release||fwp_heap.ready)return 1;
  fwp_lib_finish();if(frees!=nowned)return 9;

 }
 set_environment("FWP_SERVICE_CACHE_CA","");return 0;
}
"#;
    let cleanup = "    g_environment_finish();";
    assert_eq!(generated.matches(cleanup).count(), 1);
    let broken = generated.replacen(cleanup, "    /* omitted environment cleanup */", 1);
    let dir = fwp::cgen::TempDir::new("grpc-environment-cache").unwrap();
    let exe = dir.join("probe");
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{hooks}\n{broken}\n{fixture}"), &exe, opt).unwrap();
        let out = Command::new(&exe).output().unwrap();
        assert_eq!(out.status.code(), Some(1), "omitted cache cleanup: {out:?}");
        fwp::cgen::compile_c(&format!("{hooks}\n{generated}\n{fixture}"), &exe, opt).unwrap();

        let out = Command::new(&exe).output().unwrap();
        assert!(out.status.success(), "{opt}: {out:?}");
    }
}

#[test]
fn failed_environment_tls_construction_releases_unpublished_storage() {
    let mut generated = runtime();
    for (before, after) in [
        (
            "g_env_options *k = (g_env_options *)malloc(sizeof *k + n + suffix_room);",
            "g_env_options *k = (g_env_options *)entry_allocation(sizeof *k + n + suffix_room);",
        ),
        (
            "g_tls *t = (g_tls *)malloc(total);",
            "g_tls *t = (g_tls *)option_allocation(total);",
        ),
    ] {
        assert_eq!(generated.matches(before).count(), 1);
        generated = generated.replacen(before, after, 1);
    }
    let hooks = r#"
#if defined(_WIN32) && !defined(_WIN32_WINNT)
#define _WIN32_WINNT 0x0a00
#endif
#include <stdlib.h>
static int failure_stage,entry_allocations,entry_frees,probe_error;
static void *pending_storage;
static void *entry_allocation(size_t);
static void *option_allocation(size_t);
static void observe_entry_free(void *);
static void omit_entry_free(void *);
#define free(p) observe_entry_free(p)
"#;
    let fixture = r#"
#undef free
static void *entry_allocation(size_t n){
 if(failure_stage==1)return NULL;
 void *p=malloc(n);if(p){entry_allocations++;pending_storage=p;}return p;
}
static void *option_allocation(size_t n){return failure_stage==2?NULL:malloc(n);}
static void observe_entry_free(void *p){if(p&&p==pending_storage){entry_frees++;pending_storage=NULL;}free(p);}
static void omit_entry_free(void *p){(void)p;}
static void construct(void *arg,int stop){
 if(stop)_Exit(210);
 for(failure_stage=1;failure_stage<=2;failure_stage++)for(int i=0;i<32;i++){
  jmp_buf failed;jmp_buf *saved=fwp_cur->trap_jb;fwp_cleanup *saved_cleanup=fwp_cur->trap_cleanup;
  if(!setjmp(failed)){
   fwp_cur->trap_jb=&failed;fwp_cur->trap_cleanup=fwp_cleanups;
   (void)g_env_tls("FWP_SERVICE_FAILURE");_Exit(211);
  }
  fwp_cur->trap_jb=saved;fwp_cur->trap_cleanup=saved_cleanup;
  if(g_env_options_known||fwp_cleanups||entry_allocations!=entry_frees||pending_storage){probe_error=202;return;}
  const char *expected=failure_stage==1?"cannot allocate service TLS cache entry":"cannot allocate TLS options";
  if(strcmp(fwp_trap_msg,expected)){probe_error=203;return;}
 }
 failure_stage=0;
 const g_tls *tls=g_env_tls("FWP_SERVICE_FAILURE");
 if(!tls||strcmp(tls->ca,"test-ca")||g_env_tls("FWP_SERVICE_FAILURE")!=tls||entry_allocations!=entry_frees+1)probe_error=204;
}
int main(void){
#ifdef _WIN32
 if(_putenv_s("FWP_SERVICE_FAILURE_CA","test-ca"))return 212;
#else
 if(setenv("FWP_SERVICE_FAILURE_CA","test-ca",1))return 212;
#endif
 fwp_lib_init();fwp_heap_start();fwp_tasks_init();fwp_trap_recover=g_trap_recover;
 fwp_task *task=fwp_spawn_task(0,construct,0,0,0);fwp_task_own_internal(task,1);fwp_await(task);fwp_task_drop(PTR(task));
 if(probe_error)return probe_error;
 if(fwp_cleanups||entry_allocations!=33||entry_frees!=32)return 205;
 fwp_lib_finish();
 if(g_env_options_known||pending_storage||entry_allocations!=entry_frees)return 206;
 return 0;
}
"#;
    let guard = "fwp_cleanup_push(&pending_entry, fwp_tls_subject_free, k);";
    assert_eq!(generated.matches(guard).count(), 1);
    let broken = generated.replacen(
        guard,
        "fwp_cleanup_push(&pending_entry, omit_entry_free, k);",
        1,
    );
    let dir = fwp::cgen::TempDir::new("grpc-environment-failure").unwrap();
    let exe = dir.join("probe");
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{hooks}\n{broken}\n{fixture}"), &exe, opt).unwrap();
        let out = Command::new(&exe).output().unwrap();
        assert_eq!(out.status.code(), Some(202), "omitted guard: {out:?}");
        fwp::cgen::compile_c(&format!("{hooks}\n{generated}\n{fixture}"), &exe, opt).unwrap();

        let out = Command::new(&exe).output().unwrap();
        assert!(out.status.success(), "{opt}: {out:?}");
    }
}
