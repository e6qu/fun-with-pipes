//! Native buffered writes must have the interpreter's immediate visibility.
use fwp::ir::*;
use std::process::{Command, Output};

#[path = "support/record_probe.rs"]
mod record_probe;
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
#[test]
fn write_is_visible_before_the_owning_frame_closes_its_file() {
    let dir = fwp::cgen::TempDir::new("file-visible").unwrap();
    let src = dir.join("visible.fwp");
    std::fs::write(
        &src,
        r#"observe : File -> String ! {FileIO, Error[IoError]}
observe = file.write "visible" | ignore | const "data" | file.read
main = "data" | file.create | observe | echo
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(fwp)
            .current_dir(dir.path())
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src),
    );
    assert_eq!(reference.stdout, b"visible\n");
    for opt in ["-O1", "-O2"] {
        let exe = dir.join("visible.exe");
        checked(
            Command::new(fwp)
                .current_dir(dir.path())
                .args(["build"])
                .arg(&src)
                .args([opt, "-o"])
                .arg(&exe),
        );

        let out = checked(Command::new(&exe).current_dir(dir.path()));
        assert_eq!(out.stdout, reference.stdout);
    }
}

#[test]
fn flush_failures_are_write_errors_and_preserve_the_borrowed_handle() {
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
#ifdef _WIN32
#ifndef _WIN32_WINNT
#define _WIN32_WINNT 0x0a00
#endif
#endif
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
static int observe_close(FILE *f){if(f==watched){watched=NULL;closes++;}return fclose(f);}
int main(void){
 fwp_heap_start();
 for(mode=0;mode<3;mode++){
  watched=fopen("probe-data","w+b");if(!watched)return 30;
  handle=fwp_file_value(watched,"probe");writes=flushes=closes=0;
  fwp_handler h;h.prev=fwp_handlers;h.state_depth=fwp_state_len;h.cleanup=fwp_cleanups;fwp_handlers=&h;
  int failed=0;
  if(setjmp(h.jb))failed=1;else{if(fwp_p_file_write(fwp_cstr("data"),handle,0)!=handle)return 1;}
  fwp_handlers=h.prev;
  if(!!failed!=!!mode)return 2;
  if(writes!=1||flushes!=(mode==1?0:1)||closes||fwp_cleanups||((fwp_file *)(uintptr_t)handle)->f!=watched)return 3;
  if(failed){
   V error=h.value;int wanted=mode==1?ENOSPC:EIO;
   if(strcmp(STR(OBJ(error)->f[0])->d,"write")||strcmp(STR(OBJ(error)->f[1])->d,strerror(wanted)))return 4;
  }else{
   char bytes[4];
#ifdef _WIN32
   HANDLE file=(HANDLE)_get_osfhandle(_fileno(watched));
   LARGE_INTEGER start;start.QuadPart=0;DWORD count=0;
   if(!SetFilePointerEx(file,start,NULL,FILE_BEGIN)||!ReadFile(file,bytes,4,&count,NULL)||count!=4)return 5;
#else
   if(pread(fileno(watched),bytes,4,0)!=4)return 5;
#endif
   if(memcmp(bytes,"data",4))return 5;
  }
  fwp_p_file_close(handle);if(closes!=1)return 6;
  writes=flushes=0;if(fwp_p_file_write(fwp_cstr("closed"),handle,0)!=handle||writes||flushes||closes!=1)return 7;
 }
 return 0;
}
"#;
    let without_flush = generated.replace(" || fflush(f->f) != 0", "");
    assert_ne!(without_flush, generated);
    let dir = fwp::cgen::TempDir::new("file-flush").unwrap();
    let exe = dir.join("probe.exe");
    for opt in ["-O1", "-O2"] {
        for (name, code, status) in [
            ("missing-flush", &without_flush, 3),
            ("healthy", &generated, 0),
        ] {
            let program = format!("{hooks}\n{code}\n{fixture}");
            fwp::cgen::compile_c(&program, &exe, opt).unwrap();
            let out = Command::new(&exe).current_dir(dir.path()).output().unwrap();
            record_probe::save(
                "file-write-visibility",
                &format!("{name}{opt}"),
                &program,
                &exe,
                &out,
            );
            assert_eq!(out.status.code(), Some(status), "{name} {opt}: {out:?}");
            assert!(out.stdout.is_empty() && out.stderr.is_empty(), "{out:?}");
        }
    }
}
