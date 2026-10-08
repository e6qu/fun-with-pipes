//! File reads report the same errors as the unoptimized interpreter.
#![cfg(any(target_os = "linux", target_os = "macos"))]
use std::process::Command;
#[test]
fn read_failures_and_invalid_utf8_match_the_original_interpreter() {
    let dir = std::env::temp_dir().join(format!("fwp-file-errors-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let invalid = dir.join("invalid");
    std::fs::write(&invalid, [0xff]).unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    for (case, path) in [("directory", dir.clone()), ("invalid", invalid)] {
        for handle in [false, true] {
            let src = dir.join(format!("{case}-{handle}.fwp"));
            let pipe = if handle {
                "file.open | file.read-all | second file.close | .0"
            } else {
                "file.read"
            };
            std::fs::write(
                &src,
                format!("main = \"{}\" | {pipe} | echo\n", path.display()),
            )
            .unwrap();
            let reference = Command::new(fwp)
                .env("FWP_NO_OPT", "1")
                .args(["run", "--interp"])
                .arg(&src)
                .output()
                .unwrap();
            assert_eq!(
                reference.status.code(),
                Some(1),
                "{case}: {}",
                String::from_utf8_lossy(&reference.stderr)
            );
            for opt in ["-O1", "-O2"] {
                let exe = dir.join("probe");
                let built = Command::new(fwp)
                    .arg("build")
                    .arg(&src)
                    .args([opt, "-o"])
                    .arg(&exe)
                    .output()
                    .unwrap();
                assert!(
                    built.status.success(),
                    "{}",
                    String::from_utf8_lossy(&built.stderr)
                );
                for poison in ["0", "1"] {
                    let native = Command::new(&exe)
                        .env("FWP_GC_STRESS", "1")
                        .env("FWP_GC_VERIFY", "1")
                        .env("FWP_REUSE_VERIFY", poison)
                        .output()
                        .unwrap();
                    assert_eq!(
                        native.status.code(),
                        reference.status.code(),
                        "{case}, handle {handle}, {opt}: {}",
                        String::from_utf8_lossy(&native.stderr)
                    );
                    assert_eq!(native.stdout, reference.stdout);
                    assert_eq!(native.stderr, reference.stderr);
                }
            }
        }
    }
    std::fs::remove_dir_all(&dir).unwrap();
}

#[test]
fn read_temporaries_and_write_errors_have_precise_stream_ownership() {
    use fwp::ir::*;
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
    let (generated, _) = fwp::cgen::generate_library(&p, "file_io").unwrap();
    let hooks = r#"
#include <stdio.h>
#include <stdlib.h>
static int fault, watched_fd, closes, buffer_frees;
static void *watched_buffer;
static FILE *watched_stream;
static FILE *observe_open(const char *,const char *);
static int observe_close(FILE *);
static size_t observe_write(const void *,size_t,size_t,FILE *);
static void observe_free(void *);
#define fopen observe_open
#define fclose observe_close
#define fwrite observe_write
#define free observe_free
"#;
    let fixture = r#"
#undef fopen
#undef fclose
#undef fwrite
#undef free
#include <fcntl.h>
static volatile V handle;
static FILE *observe_open(const char *p,const char *m){
 FILE *f=fopen(p,m);if(f){watched_stream=f;watched_fd=fileno(f);}return f;
}
static int observe_close(FILE *f){
 int result=fclose(f);if(f==watched_stream){closes++;if(fault==5){errno=EIO;return EOF;}if(fault==4)errno=EPIPE;}return result;
}
static size_t observe_write(const void *p,size_t size,size_t n,FILE *f){
 if(f==watched_stream&&fault==4){errno=ENOSPC;return 0;}return fwrite(p,size,n,f);
}
static void observe_free(void *p){if(p&&p==watched_buffer){buffer_frees++;watched_buffer=0;}free(p);}
static jmp_buf recovery;
static int recover(void){return 1;}
int main(int argc,char **argv){
 if(argc!=2)return 30;fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));
 for(volatile int borrowed=0;borrowed<2;borrowed++)for(volatile int mode=0;mode<(borrowed?4:3);mode++){
  fault=0;watched_buffer=0;buffer_frees=closes=0;watched_fd=-1;V path=fwp_cstr(argv[1]);
  if(borrowed){handle=fwp_p_file_open(path,0,0);closes=0;}
  fwp_trap_recover=recover;fwp_trap_jb=&recovery;fwp_trap_cleanup=0;fault=mode;
  if(!setjmp(recovery)){
   V r=borrowed?fwp_p_file_read_all(handle,0):fwp_p_file_read(path,0);
   if(mode)return 1;V text=borrowed?OBJ(r)->f[0]:r;if(strcmp(STR(text)->d,"contents"))return 2;
   if(borrowed&&OBJ(r)->f[1]!=handle)return 3;
  }else if(!mode)return 4;
  fault=0;fwp_trap_recover=0;fwp_trap_jb=0;
  if(fwp_cleanups||buffer_frees!=1||watched_buffer||closes!=(borrowed?0:1))return 5;
  if(borrowed){if(fcntl(watched_fd,F_GETFD)==-1)return 6;fwp_p_file_close(handle);handle=0;}
  if(closes!=1||fcntl(watched_fd,F_GETFD)!=-1||errno!=EBADF)return 7;
 }
 for(volatile int mode=0;mode<3;mode++){
  fault=0;closes=0;V path=fwp_cstr(argv[1]);V text=fwp_cstr("written");fault=mode?mode+3:0;
  fwp_handler h;h.prev=fwp_handlers;h.state_depth=fwp_state_len;h.cleanup=fwp_cleanups;fwp_handlers=&h;
  int failed=setjmp(h.jb);if(!failed)fwp_p_file_write_new(path,text,0);fwp_handlers=h.prev;
  if(!!failed!=!!mode||closes!=1||fwp_cleanups||fcntl(watched_fd,F_GETFD)!=-1||errno!=EBADF)return 8;
  if(failed){char expected[1024];snprintf(expected,sizeof expected,"%s: %s",argv[1],strerror(mode==1?ENOSPC:EIO));
   if(strcmp(STR(OBJ(h.value)->f[0])->d,"write")||strcmp(STR(OBJ(h.value)->f[1])->d,expected))return 9;
  }
 }
 fwp_gc_finish();return 0;
}
"#;
    let mut runtime = generated.clone();
    for name in ["fwp_p_file_read_all", "fwp_p_file_read"] {
        let start = runtime.find(&format!("static V {name}(V ")).unwrap();
        let end = start + runtime[start..].find("\n}\n").unwrap() + 3;
        let original = runtime[start..end].to_string();
        let instrumented = original.replace(
            "while ((n = fread(tmp, 1, sizeof tmp, f->f)) > 0) buf_put(&b, tmp, n);",
            "while ((n = fread(tmp, 1, sizeof tmp, f->f)) > 0) {buf_put(&b,tmp,n);watched_buffer=b.d;if(fault==1)fwp_trap(\"read buffer failure\");}"
        ).replace(
            "while ((n = fread(tmp, 1, sizeof tmp, f)) > 0) buf_put(&b, tmp, n);",
            "while ((n = fread(tmp, 1, sizeof tmp, f)) > 0) {buf_put(&b,tmp,n);watched_buffer=b.d;if(fault==1)fwp_trap(\"read buffer failure\");}"
        ).replace("V text = buf_to_str(&b);", "if(fault==2)fwp_trap(\"read String failure\");V text = buf_to_str(&b);")
        .replace("V result = buf_to_str(&b);", "if(fault==2)fwp_trap(\"read String failure\");V result = buf_to_str(&b);")
        .replace("V result = fwp_tuple2(text, h);", "if(fault==3)fwp_trap(\"read tuple failure\");V result = fwp_tuple2(text,h);");
        assert_ne!(instrumented, original);
        runtime.replace_range(start..end, &instrumented);
    }
    let omitted = runtime
        .replace(
            "fwp_cleanup_push(&buffer_cleanup, fwp_file_buffer_cleanup, &b);",
            "(void)buffer_cleanup;",
        )
        .replace("fwp_cleanup_pop(&buffer_cleanup);", "(void)buffer_cleanup;");
    assert_ne!(omitted, runtime);
    let no_stream = runtime
        .replace(
            "fwp_cleanup_push(&stream_cleanup, fwp_close_scoped_file, &file);",
            "(void)stream_cleanup;",
        )
        .replace("fwp_cleanup_pop(&stream_cleanup);", "(void)stream_cleanup;");
    assert_ne!(no_stream, runtime);
    let start = runtime
        .find("static V fwp_p_file_write_new(V path,")
        .unwrap();
    let end = start + runtime[start..].find("\n}\n").unwrap() + 3;
    let mut no_write_error = runtime.clone();
    no_write_error.replace_range(
        start..end,
        r#"static V fwp_p_file_write_new(V path,V s,const fwp_desc *err){
      FILE *f=fopen(STR(path)->d,"wb");if(!f)return fwp_io_error_path("write",STR(path)->d,err);
      fwrite(STR(s)->d,1,STR(s)->len,f);fclose(f);return FWP_UNIT;
    }
"#,
    );
    let dir = std::env::temp_dir().join(format!("fwp-file-io-owner-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let exe = dir.join("probe");
    let data = dir.join("data");
    for opt in ["-O1", "-O2"] {
        for (code, expected) in [
            (&omitted, 5),
            (&no_stream, 5),
            (&no_write_error, 8),
            (&runtime, 0),
        ] {
            fwp::cgen::compile_c(&format!("{hooks}\n{code}\n{fixture}"), &exe, opt).unwrap();
            for poison in ["0", "1"] {
                std::fs::write(&data, "contents").unwrap();
                let out = Command::new(&exe)
                    .arg(&data)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison)
                    .output()
                    .unwrap();
                assert_eq!(
                    out.status.code(),
                    Some(expected),
                    "{opt}: {}",
                    String::from_utf8_lossy(&out.stderr)
                );
            }
        }
    }
    std::fs::remove_dir_all(&dir).unwrap();
}
