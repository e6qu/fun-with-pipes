//! Actual loader unload releases library regions and drains suspended tasks.
use fwp::ir::*;
use fwp::value::Value;
use std::process::Command;

const SNAPSHOT: &str = r#"
struct snapshot {
 void *heap, *meta, *stacks[3], *wide, *fins, *marks, *metrics, *name;
 size_t heap_bytes, meta_bytes, stack_bytes;
 int read_fd, poll_fd, entered, completed, cancelled, finalized, order_error;
 int wide_freed, fins_freed, marks_freed, metrics_freed, name_freed, static_exit, key_deleted, finished;
};
"#;

#[test]
fn loader_unload_drains_tasks_restores_signals_and_releases_regions() {
    let string = MT::con("std::String");
    let int = MT::con("std::I64");
    let p = Program {
        funcs: vec![
            Func {
                name: "cached".into(),
                arity: 0,
                locals: vec![],
                ty: string.clone(),
                body: Body::Expr(Expr::Call(
                    1,
                    vec![
                        Expr::Const(Value::I64(2)),
                        Expr::Const(Value::Str("heap".into())),
                    ],
                )),
            },
            Func {
                name: "repeat".into(),
                arity: 2,
                locals: vec![int.clone(), string.clone()],
                ty: MT::Fun(
                    Box::new(int),
                    Box::new(MT::Fun(Box::new(string.clone()), Box::new(string))),
                ),
                body: Body::Prim("string.repeat".into()),
            },
        ],
        exports: vec![("cached".into(), 0)],
        ..Program::default()
    };
    let (generated, header) = fwp::cgen::generate_library(&p, "unload").unwrap();
    let observed=generated
        .replace("static void fwp_gc_init(void) {", "static char *test_reservation; static size_t test_reserved_bytes;\nstatic void fwp_gc_init(void) {")
        .replace("char *r = (char *)fwp_gc_reserve(&bytes);", "char *r = (char *)fwp_gc_reserve(&bytes); test_reservation=r;test_reserved_bytes=bytes+GC_CHUNK;")
        .replace("    fwp_closure_drop_finish();\n", "    fwp_closure_drop_finish(); observe_finished();\n");
    let hooks = r#"
static struct snapshot *observed;
static void observe_free(void *p);
static int observe_key_delete(pthread_key_t key);
static void observe_finished(void);
#define pthread_key_delete(k) observe_key_delete(k)
#define free(p) observe_free(p)
"#;
    let fixture = r#"
#undef free
#undef pthread_key_delete
static int observe_key_delete(pthread_key_t key) {
 if(observed)observed->key_deleted++;return pthread_key_delete(key);
}
static void observe_finished(void) {
 if(!observed)return;
 observed->finished++;
 if(observed->wide_freed!=1||observed->fins_freed!=1||observed->marks_freed!=1||
    observed->metrics_freed!=1||observed->name_freed!=1||observed->key_deleted!=1||
    fwp_gc.ready||fwp_gc.reservation||fwp_closure_drop_key_ready)observed->order_error=1;
 if(observed->static_exit)puts(observed->order_error?"bad cleanup":"finished");
}
static void observe_free(void *p) {
 if(observed&&p) {
  if(p==observed->wide)observed->wide_freed++;
  if(p==observed->fins)observed->fins_freed++;
  if(p==observed->marks)observed->marks_freed++;
  if(p==observed->metrics)observed->metrics_freed++;
  if(p==observed->name)observed->name_freed++;
 }
 free(p);
}
static void blocked(void *arg,int cancelled) {
 struct snapshot *s=arg;
 if(cancelled){s->cancelled++;return;}
 s->entered++;fwp_check_cancel();(void)fwp_wait_fd(s->read_fd,0,0);
 s->order_error=1;
}
static void completed(void *arg,int cancelled) {
 struct snapshot *s=arg;if(cancelled)s->order_error=1;else s->completed++;
}
static void finalize(void *p) {
 if(*(uint64_t *)p!=0x12345678)observed->order_error=1;
 if(observed->entered!=2||observed->completed!=1||observed->cancelled!=2)observed->order_error=1;
#ifdef FWP_LIBRARY
 if(fwp_root||fwp_gc_tasks||fwp_stack_pool_n||fwp_caf_state0||fwp_lib_ready)observed->order_error=1;
 fwp_lib_finish(); /* Reentrant finish must not repeat finalization. */
#endif
 observed->finalized++;
 if(observed->static_exit)puts(observed->order_error?"bad finalization":"finalized");
}
void setup(struct snapshot *s) {
 fwp_lib_init();observed=s;
 s->heap=test_reservation;s->heap_bytes=test_reserved_bytes;
 s->meta=fwp_gc.meta;s->meta_bytes=fwp_gc.meta_bytes;
 V wide=fwp_rc_fresh(fwp_str_new("wide",4));
 for(int i=0;i<256;i++)fwp_rc_dup(wide);
 s->wide=*fwp_rc_wide_link(fwp_rc_slot(wide));
 fwp_gc.mstack=malloc(8*sizeof(gc_range));fwp_gc.mcap=8;s->marks=fwp_gc.mstack;
 uint64_t *marker=fwp_mem_alloc(sizeof(uint64_t));*marker=0x12345678;
 fwp_gc_finalizer(marker,finalize);s->fins=fwp_gc.fins;
 fwp_metric *metric=fwp_metric_get("probe",5,"gauge");s->metrics=fwp_metrics;s->name=metric->name;
 (void)fwp_p_shutdown_requested();
 fwp_task *child=fwp_spawn_task(0,blocked,s,0,0);
 fwp_task *detached=fwp_spawn_task(0,blocked,s,0,1);
 s->stacks[0]=child->stack;s->stacks[1]=detached->stack;s->stack_bytes=child->stack_size;
 (void)fwp_p_task_yield();
 fwp_task *done=fwp_spawn_task(0,completed,s,0,0);s->stacks[2]=done->stack;
 (void)fwp_await(done);s->poll_fd=fwp_epfd;
 if(s->entered!=2||s->completed!=1||s->cancelled||!fwp_stack_pool_n||fwp_gc.armed||fwp_gc.ncollect)s->order_error=1;
}
"#;
    let library_source = format!(
        "#include <stdlib.h>\n#include <pthread.h>\n{SNAPSHOT}\n{hooks}\n{observed}\n{fixture}"
    );
    let host = r#"
#include <dlfcn.h>
#include <signal.h>
#include <sys/mman.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <stdio.h>
#include <string.h>
#ifdef __APPLE__
#include <mach/mach.h>
#include <mach/mach_vm.h>
#endif
static void before(int sig,siginfo_t *info,void *arg){(void)sig;(void)info;(void)arg;}
static void after(int sig){(void)sig;}
static int unmapped(void *p,size_t bytes) {
 if(!p||!bytes)return 0;
#ifdef __APPLE__
 mach_vm_address_t address=(mach_vm_address_t)p;mach_vm_size_t length=0;
 vm_region_basic_info_data_64_t info;mach_msg_type_number_t count=VM_REGION_BASIC_INFO_COUNT_64;
 mach_port_t object=MACH_PORT_NULL;
 kern_return_t result=mach_vm_region(mach_task_self(),&address,&length,VM_REGION_BASIC_INFO_64,(vm_region_info_t)&info,&count,&object);
 if(object!=MACH_PORT_NULL)mach_port_deallocate(mach_task_self(),object);
 return result==KERN_INVALID_ADDRESS||(result==KERN_SUCCESS&&address>=(mach_vm_address_t)p+bytes);
#else
 unsigned char page;size_t n=(size_t)sysconf(_SC_PAGESIZE);
 return mincore(p,n,&page)==-1&&errno==ENOMEM&&
        mincore((char *)p+bytes-n,n,&page)==-1&&errno==ENOMEM;
#endif
}
int main(int argc,char **argv) {
 if(argc!=2)return 30;
 for(int i=0;i<3;i++) {
  int pipes[2];if(pipe(pipes))return 31;
  struct sigaction prior={0}, old_int, old_term, current;
  prior.sa_sigaction=before;prior.sa_flags=SA_SIGINFO|SA_RESTART;
  sigemptyset(&prior.sa_mask);sigaddset(&prior.sa_mask,SIGUSR1);
  sigaction(SIGINT,&prior,0);sigaction(SIGTERM,&prior,0);
  sigaction(SIGINT,0,&old_int);sigaction(SIGTERM,0,&old_term);
  void *lib=dlopen(argv[1],RTLD_NOW|RTLD_LOCAL);if(!lib){fprintf(stderr,"%s\n",dlerror());return 32;}
  const char *(*cached)(void)=dlsym(lib,"cached");
  void (*setup)(struct snapshot *)=dlsym(lib,"setup");
  if(!cached||!setup||strcmp(cached(),"heapheap"))return 33;
  static struct snapshot s;memset(&s,0,sizeof s);s.read_fd=pipes[0];setup(&s);
  if(s.order_error||strcmp(cached(),"heapheap"))return 34;
  if(i==1){struct sigaction replacement={0};replacement.sa_handler=after;sigemptyset(&replacement.sa_mask);sigaction(SIGTERM,&replacement,0);}
  if(dlclose(lib))return 35;
  if(!unmapped(s.heap,s.heap_bytes)||!unmapped(s.meta,s.meta_bytes)){fprintf(stderr,"unload: final=%d cancelled=%d order=%d wide=%d heap=%d meta=%d\n",s.finalized,s.cancelled,s.order_error,s.wide_freed,unmapped(s.heap,s.heap_bytes),unmapped(s.meta,s.meta_bytes));return 1;}
  for(int j=0;j<3;j++)if(!unmapped(s.stacks[j],s.stack_bytes))return 2;
  if(s.finalized!=1||s.cancelled!=2)return 3;
  if(s.order_error)return s.key_deleted!=1||s.wide_freed!=1?4:3;
  if(s.wide_freed!=1||s.fins_freed!=1||s.marks_freed!=1||s.metrics_freed!=1||s.name_freed!=1||s.key_deleted!=1||s.finished!=1)return 4;
  sigaction(SIGINT,0,&current);
  if(current.sa_sigaction!=old_int.sa_sigaction||current.sa_flags!=old_int.sa_flags||!sigismember(&current.sa_mask,SIGUSR1))return 5;
  sigaction(SIGTERM,0,&current);
  if(i==1){if(current.sa_handler!=after)return 6;}
  else if(current.sa_sigaction!=old_term.sa_sigaction||current.sa_flags!=old_term.sa_flags||!sigismember(&current.sa_mask,SIGUSR1))return 6;
  if(s.poll_fd>=0&&(fcntl(s.poll_fd,F_GETFD)!=-1||errno!=EBADF))return 7;
  if(fcntl(pipes[0],F_GETFD)==-1)return 8;
  close(pipes[0]);close(pipes[1]);
 }
 return 0;
}
"#;
    let dir = std::env::temp_dir().join(format!("fwp-library-unload-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let exe = dir.join("host");
    let lib = dir.join(format!(
        "libunload.{}",
        fwp::cgen::shared_library_extension()
    ));
    let host_source = format!("#include <stddef.h>\n{SNAPSHOT}\n{host}");
    let static_host = format!(
        r#"
#include <stddef.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>
{SNAPSHOT}
extern const char *cached(void);
extern void setup(struct snapshot *);
static struct snapshot s;
int main(void) {{
 int pipes[2];if(pipe(pipes))return 31;
 if(strcmp(cached(),"heapheap"))return 33;
 s.read_fd=pipes[0];setup(&s);s.static_exit=1;
 if(s.order_error)return 34;
 puts("main");return 0;
}}
"#
    );
    let controls=[
        ("if (fwp_gc.reservation) munmap(fwp_gc.reservation, fwp_gc.reservation_bytes);", "/* missing heap unmap */",1),
        ("while (fwp_stack_pool_n) munmap(fwp_stack_pool[--fwp_stack_pool_n], FWP_NATIVE_TASK_STACK);", "fwp_stack_pool_n = 0; /* leaked stacks */",2),
        ("    fwp_caf_finish();", "    /* missing cache cleanup */",3),
        ("            free(entry);", "            /* missing wide-count cleanup */",4),
        ("sigaction(SIGINT, &fwp_prior_sigint, 0);", "(void)0; /* missing signal restoration */",5),
        ("pthread_key_delete(fwp_closure_drop_key);", "/* missing key deletion */",4),
    ];
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_library(
            &library_source,
            &header,
            &lib,
            opt,
            fwp::cgen::LibKind::Shared,
        )
        .unwrap();
        fwp::cgen::compile_c(&host_source, &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let out = Command::new(&exe)
                .arg(&lib)
                .env("FWP_REUSE_VERIFY", poison)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .output()
                .unwrap();
            assert!(
                out.status.success(),
                "{opt}, poison {poison}: {:?}: {}",
                out.status.code(),
                String::from_utf8_lossy(&out.stderr)
            );
        }
        let archive = dir.join("libunload.a");
        fwp::cgen::compile_library(
            &library_source,
            &header,
            &archive,
            opt,
            fwp::cgen::LibKind::Static,
        )
        .unwrap();
        let previous = fwp::ffi::links();
        fwp::ffi::set_links(vec![archive.to_string_lossy().into_owned()]);
        let result = fwp::cgen::compile_c(&static_host, &dir.join("static-host"), opt);
        fwp::ffi::set_links(previous);
        result.unwrap();
        for poison in ["0", "1"] {
            let out = Command::new(dir.join("static-host"))
                .env("FWP_REUSE_VERIFY", poison)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .output()
                .unwrap();
            assert!(
                out.status.success(),
                "static {opt}: {}",
                String::from_utf8_lossy(&out.stderr)
            );
            assert_eq!(
                String::from_utf8_lossy(&out.stdout),
                "main\nfinalized\nfinished\n"
            );
        }
        for (needle, replacement, expected) in controls {
            assert!(
                library_source.contains(needle),
                "missing negative control {needle}"
            );
            let broken = library_source.replacen(needle, replacement, 1);
            fwp::cgen::compile_library(&broken, &header, &lib, opt, fwp::cgen::LibKind::Shared)
                .unwrap();
            let out = Command::new(&exe).arg(&lib).output().unwrap();
            assert_eq!(
                out.status.code(),
                Some(expected),
                "{opt}, control {needle}: {}",
                String::from_utf8_lossy(&out.stderr)
            );
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}
