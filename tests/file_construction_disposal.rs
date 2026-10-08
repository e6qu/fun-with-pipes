//! Constructor unwind releases headers; failed registry growth preserves owners.
use fwp::ir::*;
use std::process::Command;

#[test]
fn constructor_failures_release_storage_and_preserve_finalizer_registry() {
    let unit = MT::Record(vec![]);
    let p = Program {
        funcs: vec![Func {
            name: "probe".into(),
            arity: 1,
            locals: vec![unit.clone()],
            ty: MT::Fun(Box::new(unit), Box::new(MT::con("std::I64"))),
            body: Body::Expr(Expr::Const(fwp::value::Value::I64(7))),
        }],
        exports: vec![("probe".into(), 0)],
        ..Program::default()
    };
    let (generated, _) = fwp::cgen::generate_library(&p, "construction_disposal").unwrap();
    let allocation = "realloc(fwp_gc.fins, cap * sizeof(gc_fin))";
    assert_eq!(generated.matches(allocation).count(), 1);
    let runtime = generated.replacen(
        allocation,
        "observe_registry_alloc(fwp_gc.fins, cap * sizeof(gc_fin))",
        1,
    );
    let hooks = "#include <stddef.h>\nstatic void *observe_registry_alloc(void *,size_t);\n";
    let fixture = r#"
#include <sys/stat.h>
static int fault, fds[64];static volatile V retained[64];
static void *observe_registry_alloc(void *p,size_t n){if(fault)return 0;return realloc(p,n);}
static jmp_buf recovery;
static int recover(void){return 1;}
static void audit_hard_exit(void){
 struct stat st;for(int i=0;i<64;i++)if(fstat(fds[i],&st)!=-1||errno!=EBADF)_Exit(41);
}
int main(void){
 if(HARD_EXIT&&atexit(audit_hard_exit))return 30;
 for(volatile int stage=HARD_EXIT?1:0;stage<2;stage++){
  memset((void *)retained,0,sizeof retained);fault=0;
  fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));
  int n=stage?64:0;
  for(int i=0;i<n;i++){FILE *f=tmpfile();if(!f)return 31;fds[i]=fileno(f);retained[i]=fwp_file_value(f,"retained");}
  gc_fin *old=fwp_gc.fins;size_t cap=fwp_gc.fins_cap;
  if(fwp_gc.nfins!=(size_t)n||cap!=(size_t)n)return 1;
  FILE *stream=tmpfile();if(!stream)return 32;int fd=fileno(stream);
  double freed=fwp_gc.freed;fault=1;
  if(!HARD_EXIT){fwp_trap_recover=recover;fwp_trap_jb=&recovery;fwp_trap_cleanup=0;}
  if(!setjmp(recovery)){fwp_file_value(stream,"failure");return 2;}
  fault=0;fwp_trap_recover=0;fwp_trap_jb=0;
  if(fwp_cleanups||fwp_gc.fins!=old||fwp_gc.fins_cap!=cap||fwp_gc.nfins!=(size_t)n)_Exit(3);
  struct stat st;if(fstat(fd,&st)!=-1||errno!=EBADF)return 4;
  int poison=getenv("FWP_REUSE_VERIFY")&&strcmp(getenv("FWP_REUSE_VERIFY"),"0");
  if(!DISABLED_FREE&&!poison&&fwp_gc.freed<=freed)return 5;
  if((DISABLED_FREE||poison)&&fwp_gc.freed!=freed)return 6;
  for(int i=0;i<n;i++)if(((fwp_file *)(uintptr_t)retained[i])->refs!=1||fstat(fds[i],&st)==-1)return 7;
  fwp_gc_finish();
  for(int i=0;i<n;i++)if(fstat(fds[i],&st)!=-1||errno!=EBADF)return 8;
 }
 return 0;
}
"#;
    let oom_start = runtime.find("static void fwp_gc_oom(void) {").unwrap();
    let oom_end = oom_start + runtime[oom_start..].find("\n}\n").unwrap() + 3;
    let mut recoverable = runtime.clone();
    recoverable.replace_range(
        oom_start..oom_end,
        "static void fwp_gc_oom(void) { fwp_trap(\"injected registry allocation failure\"); }\n",
    );
    let dir = fwp::cgen::TempDir::new("file-construction-disposal").unwrap();
    let exe = dir.join("probe");
    for opt in ["-O1", "-O2"] {
        for disabled in [false, true] {
            let prefix = if disabled {
                "#define FWP_RESOURCE_NO_FREE 1\n#define DISABLED_FREE 1\n"
            } else {
                "#define DISABLED_FREE 0\n"
            };
            fwp::cgen::compile_c(
                &format!("#define HARD_EXIT 0\n{prefix}\n{hooks}\n{recoverable}\n{fixture}"),
                &exe,
                opt,
            )
            .unwrap();
            for gc in ["off", "on"] {
                for poison in ["0", "1"] {
                    let out = Command::new(&exe)
                        .env("FWP_GC", gc)
                        .env("FWP_GC_STRESS", "1")
                        .env("FWP_GC_VERIFY", "1")
                        .env("FWP_REUSE_VERIFY", poison)
                        .output()
                        .unwrap();
                    assert!(
                        out.status.success(),
                        "{opt}, disabled={disabled}, gc={gc}, poison={poison}: {:?}: {}",
                        out.status.code(),
                        String::from_utf8_lossy(&out.stderr)
                    );
                }
            }
        }
        fwp::cgen::compile_c(
            &format!("#define HARD_EXIT 1\n#define DISABLED_FREE 0\n{hooks}\n{runtime}\n{fixture}"),
            &exe,
            opt,
        )
        .unwrap();
        let out = Command::new(&exe).env("FWP_GC", "off").output().unwrap();
        assert_eq!(
            out.status.code(),
            Some(102),
            "hard OOM preserves library finalizers: {}",
            String::from_utf8_lossy(&out.stderr)
        );
        // Publishing capacity before allocation violates registry rollback.
        let capacity = "size_t cap = fwp_gc.fins_cap ? fwp_gc.fins_cap * 2 : 64;";
        assert_eq!(recoverable.matches(capacity).count(), 1);
        let broken_capacity =
            recoverable.replacen(capacity, &format!("{capacity} fwp_gc.fins_cap = cap;"), 1);
        fwp::cgen::compile_c(&format!("#define HARD_EXIT 0\n#define DISABLED_FREE 0\n{hooks}\n{broken_capacity}\n{fixture}"), &exe, opt).unwrap();
        let out = Command::new(&exe)
            .env("FWP_GC", "off")
            .env("FWP_REUSE_VERIFY", "0")
            .output()
            .unwrap();
        assert_eq!(
            out.status.code(),
            Some(3),
            "premature capacity update must fail rollback"
        );
        // Restoring close-only construction leaks the temporary header.
        let start = recoverable
            .find("static V fwp_file_value(FILE *f, const char *path) {")
            .unwrap();
        let end = start + recoverable[start..].find("\n}\n").unwrap() + 3;
        let body = &recoverable[start..end];
        let broken = body.replacen("fwp_close_owned_scoped_file", "fwp_close_scoped_file", 1);
        assert_ne!(body, broken);
        let broken = recoverable.replacen(body, &broken, 1);
        fwp::cgen::compile_c(
            &format!("#define HARD_EXIT 0\n#define DISABLED_FREE 0\n{hooks}\n{broken}\n{fixture}"),
            &exe,
            opt,
        )
        .unwrap();
        let out = Command::new(&exe)
            .env("FWP_GC", "off")
            .env("FWP_REUSE_VERIFY", "0")
            .output()
            .unwrap();
        assert_eq!(
            out.status.code(),
            Some(5),
            "omitted constructor owner disposal must fail"
        );
    }
}
