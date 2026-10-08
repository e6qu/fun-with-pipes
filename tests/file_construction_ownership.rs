//! A newly opened stream is owned through handle/path construction and traps.
use fwp::ir::*;
use std::path::PathBuf;
use std::process::{Command, Output};
fn checked(command: &mut Command) -> Output {
    let out = command.output().unwrap();
    assert!(
        out.status.success(),
        "{command:?}: {}: {}",
        out.status,
        String::from_utf8_lossy(&out.stderr)
    );
    out
}
struct Scratch(PathBuf);
impl Drop for Scratch {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}
#[test]
fn construction_failures_close_streams_once_and_clear_finalized_handles() {
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
    let (generated, _) = fwp::cgen::generate_library(&p, "file_owner").unwrap();
    let hooks = r#"
#include <stdio.h>
#include <stdint.h>
static int fault, closes, watched_fd, callbacks;
static uintptr_t watched_stream;
static void *observed_handle;
static FILE *observe_open(const char *, const char *);
static int observe_close(FILE *);
#define fopen observe_open
#define fclose observe_close
"#;
    let fixture = r#"
#undef fopen
#undef fclose
#include <fcntl.h>
static FILE *observe_open(const char *path,const char *mode) {
 FILE *f=fopen(path,mode);if(f){watched_stream=(uintptr_t)f;watched_fd=fileno(f);}return f;
}
static int observe_close(FILE *f) {if((uintptr_t)f==watched_stream)closes++;return fclose(f);}
static jmp_buf construction_failure;
static int recover_construction(void){return 1;}
static V file_callback(V *a){callbacks++;if(fault==4)fwp_trap("file callback failure");return fwp_tuple2(7,a[0]);}
static const fwp_fninfo callbacks_table[]={{1,file_callback,"file callback",0}};
static fwp_clo callback={0,0};
int main(int argc,char **argv){
 if(argc!=2)return 30;fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));if(!fwp_gc.armed)return 31;
 fwp_fns=callbacks_table;
 for(volatile int create=0;create<2;create++)for(volatile int scoped=0;scoped<2;scoped++)for(volatile int mode=0;mode<(scoped?5:4);mode++){
  // A traced fixture explicitly roots the path and any failed handle.
  fault=0;closes=0;watched_fd=-1;watched_stream=0;observed_handle=0;callbacks=0;fwp_fns=callbacks_table;
  V path=fwp_cstr(argv[1]);fault=mode;
  fwp_trap_recover=recover_construction;fwp_trap_jb=&construction_failure;fwp_trap_cleanup=0;
  if(!setjmp(construction_failure)){
   V result=scoped?fwp_p_file_with(path,PTR(&callback),0):fwp_p_file_open(path,create,0);
   if(mode)return 1;
   if(scoped){if(result!=7||callbacks!=1)return 6;}
   else {if(closes)return 7;fwp_p_file_close(result);fwp_p_file_close(result);}
  }else if(!mode)return 8;
  fault=0;fwp_trap_recover=0;fwp_trap_jb=0;fwp_handlers=0;
  if(fwp_cleanups||closes!=1||watched_fd<0||fcntl(watched_fd,F_GETFD)!=-1||errno!=EBADF)return 2;
  // Inspect the header only while storage was retained by poison mode.
  if(observed_handle&&getenv("FWP_REUSE_VERIFY")&&strcmp(getenv("FWP_REUSE_VERIFY"),"0")&&((fwp_file *)observed_handle)->f)_Exit(3);
  if(mode&&mode<4&&callbacks)return 4;
  if(mode==4&&callbacks!=1)return 5;
  // A failed but registered handle must not close the stream again.
  fwp_gc_finish();if(closes!=1)return 9;
  fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));
 }
 fwp_gc_finish();return 0;
}
"#;
    let start = generated
        .find("static V fwp_file_value(FILE *f, const char *path) {")
        .unwrap();
    let end = start + generated[start..].find("\n}\n").unwrap() + 3;
    let value = &generated[start..end];
    let injected = value.replace("    fwp_file *h = (fwp_file *)fwp_alloc_leaf(sizeof(fwp_file) + len + 1);",
        "    if(fault==1)fwp_trap(\"file handle allocation\");\n    fwp_file *h = (fwp_file *)fwp_alloc_leaf(sizeof(fwp_file) + len + 1); observed_handle=h;")
        .replace("    memcpy(h->path, path, len + 1);",
            "    if(fault==2)fwp_trap(\"file path initialization\");\n    memcpy(h->path, path, len + 1);")
        .replace("    fwp_gc_finalizer(h, fwp_file_final);",
            "    if(fault==3)fwp_trap(\"file finalizer registration\");\n    fwp_gc_finalizer(h, fwp_file_final);");
    assert_ne!(value, injected);
    let runtime = generated.replacen(value, &injected, 1);
    let dir =
        Scratch(std::env::temp_dir().join(format!("fwp-file-construction-{}", std::process::id())));
    std::fs::create_dir_all(&dir.0).unwrap();
    let exe = dir.0.join("probe");
    let no_scope = injected
        .replace(
            "fwp_cleanup_push(&cleanup, fwp_close_owned_scoped_file, &file);",
            "(void)cleanup;",
        )
        .replace("fwp_cleanup_pop(&cleanup);", "(void)file;");
    let raw_only = injected.replace(
        "file.handle = PTR(h);",
        "/* omit managed handle transfer */",
    );
    assert_ne!(no_scope, injected);
    assert_ne!(raw_only, injected);
    for opt in ["-O1", "-O2"] {
        for (control, expected) in [(&no_scope, 2), (&raw_only, 3)] {
            let broken = generated.replacen(value, control, 1);
            fwp::cgen::compile_c(&format!("{hooks}\n{broken}\n{fixture}"), &exe, opt).unwrap();
            std::fs::write(dir.0.join("data"), "").unwrap();
            let out = Command::new(&exe)
                .arg(dir.0.join("data"))
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", "1")
                .output()
                .unwrap();
            assert_eq!(
                out.status.code(),
                Some(expected),
                "missing constructor ownership must be detected: {}",
                String::from_utf8_lossy(&out.stderr)
            );
        }
        std::fs::write(dir.0.join("data"), "").unwrap();
        fwp::cgen::compile_c(&format!("{hooks}\n{runtime}\n{fixture}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            checked(
                Command::new(&exe)
                    .arg(dir.0.join("data"))
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison),
            );
        }
    }
}
