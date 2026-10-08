//! Native buffered writes must have the interpreter's immediate visibility.
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
fn write_is_visible_before_the_owning_frame_closes_its_file() {
    let dir =
        Scratch(std::env::temp_dir().join(format!("fwp-file-visible-{}", std::process::id())));
    std::fs::create_dir_all(&dir.0).unwrap();
    let src = dir.0.join("visible.fwp");
    let data = dir.0.join("data");
    std::fs::write(
        &src,
        format!(
            r#"observe : File -> String ! {{FileIO, Error[IoError]}}
observe = file.write "visible" | ignore | const "{}" | file.read
main = "{}" | file.create | observe | echo
"#,
            data.display(),
            data.display()
        ),
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src),
    );
    assert_eq!(reference.stdout, b"visible\n");
    for opt in ["-O1", "-O2"] {
        let exe = dir.0.join(opt);
        checked(
            Command::new(fwp)
                .arg("build")
                .arg(&src)
                .args([opt, "-o"])
                .arg(&exe),
        );
        for poison in ["0", "1"] {
            let out = checked(
                Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison),
            );
            assert_eq!(out.stdout, reference.stdout);
        }
    }
}

#[test]
fn flush_failures_are_write_errors_and_preserve_the_borrowed_handle() {
    use fwp::ir::*;
    let p = Program {
        funcs: vec![Func {
            name: "probe".into(),
            arity: 0,
            locals: vec![],
            ty: MT::con("std::I64"),
            body: Body::Expr(Expr::Const(fwp::value::Value::I64(7))),
        }],
        main: Some(0),
        ..Program::default()
    };
    let generated = fwp::cgen::generate(&p).unwrap().replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let hooks = r#"
#include <stdio.h>
static FILE *watched;
static int mode,writes,flushes,closes;
static size_t observe_write(const void *,size_t,size_t,FILE *);
static int observe_flush(FILE *);
static int observe_close(FILE *);
#define fwrite observe_write
#define fflush observe_flush
#define fclose observe_close
"#;
    let fixture = r#"
#undef fwrite
#undef fflush
#undef fclose
static volatile V handle;
static size_t observe_write(const void *p,size_t size,size_t n,FILE *f){
 if(f==watched){writes++;if(mode==1){errno=ENOSPC;return 0;}}return fwrite(p,size,n,f);
}
static int observe_flush(FILE *f){if(f==watched){flushes++;if(mode==2){errno=EIO;return EOF;}}return fflush(f);}
static int observe_close(FILE *f){if(f==watched)closes++;return fclose(f);}
int main(void){
 fwp_gc_start(__builtin_frame_address(0));
 for(mode=0;mode<3;mode++){
  watched=tmpfile();if(!watched)return 30;
  handle=fwp_file_value(watched,"probe");writes=flushes=closes=0;
  fwp_handler h;h.prev=fwp_handlers;h.state_depth=fwp_state_len;h.cleanup=fwp_cleanups;fwp_handlers=&h;
  int failed=setjmp(h.jb);
  if(!failed){if(fwp_p_file_write(fwp_cstr("data"),handle,0)!=handle)return 1;}
  fwp_handlers=h.prev;
  if(!!failed!=!!mode)return 2;
  if(writes!=1||flushes!=(mode==1?0:1)||closes||fwp_cleanups||((fwp_file *)(uintptr_t)handle)->f!=watched)return 3;
  if(failed){
   V error=h.value;int wanted=mode==1?ENOSPC:EIO;
   if(strcmp(STR(OBJ(error)->f[0])->d,"write")||strcmp(STR(OBJ(error)->f[1])->d,strerror(wanted)))return 4;
  }else{
   char bytes[4];if(pread(fileno(watched),bytes,4,0)!=4||memcmp(bytes,"data",4))return 5;
  }
  fwp_p_file_close(handle);if(closes!=1)return 6;
  writes=flushes=0;if(fwp_p_file_write(fwp_cstr("closed"),handle,0)!=handle||writes||flushes||closes!=1)return 7;
 }
 return 0;
}
"#;
    let without_flush = generated.replace(" || fflush(f->f) != 0", "");
    assert_ne!(without_flush, generated);
    let dir = Scratch(std::env::temp_dir().join(format!("fwp-file-flush-{}", std::process::id())));
    std::fs::create_dir_all(&dir.0).unwrap();
    let exe = dir.0.join("probe");
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{hooks}\n{without_flush}\n{fixture}"), &exe, opt).unwrap();
        let old = Command::new(&exe)
            .env("FWP_GC_STRESS", "1")
            .env("FWP_GC_VERIFY", "1")
            .env("FWP_REUSE_VERIFY", "1")
            .output()
            .unwrap();
        assert_eq!(
            old.status.code(),
            Some(3),
            "omitted write flush must be detected"
        );
        fwp::cgen::compile_c(&format!("{hooks}\n{generated}\n{fixture}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            checked(
                Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison),
            );
        }
    }
}
