//! Last File owners unlink finalizers before returning unshared storage.
use fwp::ir::*;
use std::process::Command;

#[test]
fn file_storage_disposal_removes_finalizers_before_reuse() {
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
    let (generated, _) = fwp::cgen::generate_library(&p, "file_disposal").unwrap();
    let fixture = r#"
#include <sys/stat.h>
static volatile V root, retained;
int main(void){
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));
 FILE *keep=tmpfile();if(!keep)return 22;int keep_fd=fileno(keep);
 retained=fwp_file_value(keep,"retained");
 int poison=getenv("FWP_REUSE_VERIFY")&&strcmp(getenv("FWP_REUSE_VERIFY"),"0");
 for(int shared=0;shared<2;shared++)for(int k=0;k<64;k++){
  FILE *stream=tmpfile();if(!stream)return 20;int fd=fileno(stream);
  root=fwp_file_value(stream,"x");fwp_file *h=(fwp_file *)(uintptr_t)root;
  if(fwp_gc.nfins!=2)return 1;
  if(shared)fwp_rc_share(root);
  for(int i=0;i<300;i++)fwp_file_dup(root);
  for(int i=0;i<300;i++)fwp_file_drop(root);
  if(h->refs!=1||fwp_gc.nfins!=2)return 2;
  double before=fwp_gc.freed;V old=root;
  fwp_file_drop(root);root=0;
  struct stat status;if(fstat(fd,&status)!=-1||errno!=EBADF)return 3;
  if(fwp_gc.nfins!=1)_Exit(4); /* Stop before a stale atexit finalizer runs. */
  if(shared||DISABLED_FREE||poison){
   if(fwp_gc.freed!=before||h->refs||h->f)return 5;
   if(poison&&!shared&&!DISABLED_FREE&&h->path[0])return 6;
  }else{
   if(fwp_gc.freed<=before)return 7;
   /* Reuse with tracing disabled: no intervening heap allocation. */
   if(!strcmp(getenv("FWP_GC"),"off")){
    void *fresh=fwp_alloc_leaf(sizeof(fwp_file)+2);
    if(fresh!=(void *)(uintptr_t)old)return 8;
    memset(fresh,0,sizeof(fwp_file)+2);
   }
  }
 }
 /* Finalization must close a genuinely retained stream, not a reclaimed one. */
 FILE *stream=tmpfile();if(!stream)return 21;int fd=fileno(stream);
 root=fwp_file_value(stream,"live");if(fwp_gc.nfins!=2)return 9;
 fwp_gc_finish();root=retained=0;
 struct stat status;if(fstat(fd,&status)!=-1||errno!=EBADF)return 10;
 if(fstat(keep_fd,&status)!=-1||errno!=EBADF)return 11;
 return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("file-storage-disposal").unwrap();
    let exe = dir.join("probe");
    for opt in ["-O1", "-O2"] {
        for disabled in [false, true] {
            let prefix = if disabled {
                "#define FWP_RESOURCE_NO_FREE 1\n#define DISABLED_FREE 1\n"
            } else {
                "#define DISABLED_FREE 0\n"
            };
            fwp::cgen::compile_c(&format!("{prefix}\n{generated}\n{fixture}"), &exe, opt).unwrap();
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
        for (needle, replacement, expected) in [
            (
                "    fwp_gc_forget_finalizer(file);",
                "    /* omit finalizer removal */",
                4,
            ),
            (
                "    fwp_mem_free(file);",
                "    /* omit storage disposal */",
                7,
            ),
        ] {
            assert_eq!(generated.matches(needle).count(), 1);
            let broken = generated.replacen(needle, replacement, 1);
            fwp::cgen::compile_c(
                &format!("#define DISABLED_FREE 0\n{broken}\n{fixture}"),
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
                Some(expected),
                "{needle}: {}",
                String::from_utf8_lossy(&out.stderr)
            );
        }
    }
}
