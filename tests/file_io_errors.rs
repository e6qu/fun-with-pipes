//! File reads report the same errors as the unoptimized interpreter.
use fwp::ir::*;
use std::process::Command;

#[path = "support/record_probe.rs"]
mod record_probe;
#[test]
fn read_failures_and_invalid_utf8_match_the_original_interpreter() {
    let dir = fwp::cgen::TempDir::new("file-errors").unwrap();
    std::fs::write(dir.join("invalid"), [0xff]).unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let cases = [("missing", "missing"), ("invalid", "invalid")];
    // Opening a directory as a file differs between CRTs; test that Unix case
    // separately while malformed bytes and missing paths run on every host.
    let cases = cases
        .into_iter()
        .chain(cfg!(unix).then_some(("directory", ".")));
    for (case, path) in cases {
        for handle in [false, true] {
            let src = dir.join(format!("{case}-{handle}.fwp"));
            let pipe = if handle {
                "file.open | file.read-all | second file.close | .0"
            } else {
                "file.read"
            };
            std::fs::write(&src, format!("main = \"{path}\" | {pipe} | echo\n")).unwrap();
            let reference = Command::new(fwp)
                .current_dir(dir.path())
                .env("FWP_NO_OPT", "1")
                .args(["run", "--interp"])
                .arg(&src)
                .output()
                .unwrap();
            assert_eq!(reference.status.code(), Some(1), "{case}: {reference:?}");
            let optimized = Command::new(fwp)
                .current_dir(dir.path())
                .env_remove("FWP_NO_OPT")
                .args(["run", "--interp"])
                .arg(&src)
                .output()
                .unwrap();
            assert_eq!(optimized.status.code(), reference.status.code());
            assert_eq!(optimized.stdout, reference.stdout);
            assert_eq!(optimized.stderr, reference.stderr);
            for opt in ["-O1", "-O2"] {
                let exe = dir.join("probe.exe");
                let built = Command::new(fwp)
                    .current_dir(dir.path())
                    .args(["build"])
                    .arg(&src)
                    .args([opt, "-o"])
                    .arg(&exe)
                    .output()
                    .unwrap();
                assert!(built.status.success(), "{built:?}");
                let native = Command::new(&exe).current_dir(dir.path()).output().unwrap();
                assert_eq!(
                    native.status.code(),
                    reference.status.code(),
                    "{case}, handle {handle}, {opt}: {native:?}"
                );
                assert_eq!(native.stdout, reference.stdout);
                assert_eq!(native.stderr, reference.stderr);
            }
        }
    }
}

#[test]
fn read_temporaries_and_write_errors_have_precise_stream_ownership() {
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
    let (generated, _) = fwp::cgen::generate_library(&p, "file_io", &[]).unwrap();
    let stream_observer = include_str!("fixtures/file_stream_observer.c");
    let hooks = r#"
#include <stdio.h>
#include <stdlib.h>
static int fault, closes, buffer_frees;
static void *watched_buffer;
static int observe_close(FILE *);
static size_t observe_write(const void *,size_t,size_t,FILE *);
static void observe_free(void *);
#ifdef _WIN32
#define _wfopen observe_wopen
#else
#define fopen observe_open
#endif
#define fclose observe_close
#define fwrite observe_write
#define free observe_free
"#;
    let fixture = r#"
#undef fopen
#undef _wfopen
#undef fclose
#undef fwrite
#undef free
#include <fcntl.h>
static volatile V handle;
static int observe_close(FILE *f){
 int observed=f==watched_stream;if(observed){watched_stream=NULL;closes++;}
 int result=fclose(f);if(observed){if(fault==5){errno=EIO;return EOF;}if(fault==4)errno=EPIPE;}return result;
}
static size_t observe_write(const void *p,size_t size,size_t n,FILE *f){
 if(f==watched_stream&&fault==4){errno=ENOSPC;return 0;}return fwrite(p,size,n,f);
}
static void observe_free(void *p){if(p&&p==watched_buffer){buffer_frees++;watched_buffer=0;}free(p);}
static jmp_buf recovery;
static int recover(void){return 1;}
int main(int argc,char **argv){
 if(argc!=2)return 30;fwp_lib_init();fwp_heap_start();
 for(volatile int borrowed=0;borrowed<2;borrowed++)for(volatile int mode=0;mode<(borrowed?4:3);mode++){
  fault=0;watched_buffer=0;buffer_frees=closes=0;V path=fwp_cstr(argv[1]);
  if(borrowed){handle=fwp_p_file_open(path,0,0);closes=0;}
  fwp_trap_recover=recover;fwp_trap_jb=&recovery;fwp_trap_cleanup=0;fault=mode;
  if(!setjmp(recovery)){
   V r=borrowed?fwp_p_file_read_all(handle,0):fwp_p_file_read(path,0);
   if(mode)return 1;V text=borrowed?OBJ(r)->f[0]:r;if(strcmp(STR(text)->d,"contents"))return 2;
   if(borrowed&&OBJ(r)->f[1]!=handle)return 3;
  }else if(!mode)return 4;
  fault=0;fwp_trap_recover=0;fwp_trap_jb=0;
  if(fwp_cleanups||buffer_frees!=1||watched_buffer||closes!=(borrowed?0:1))return 5;
  if(borrowed){if(!stream_is_open())return 6;fwp_p_file_close(handle);handle=0;}
  if(closes!=1||stream_is_open())return 7;
 }
 for(volatile int mode=0;mode<3;mode++){
  fault=0;closes=0;V path=fwp_cstr(argv[1]);V text=fwp_cstr("written");fault=mode?mode+3:0;
  fwp_handler h;h.prev=fwp_handlers;h.state_depth=fwp_state_len;h.cleanup=fwp_cleanups;fwp_handlers=&h;
  int failed=0;if(setjmp(h.jb))failed=1;else fwp_p_file_write_new(path,text,0);fwp_handlers=h.prev;
  if(!!failed!=!!mode||closes!=1||fwp_cleanups||stream_is_open())return 8;
  if(failed){char expected[1024];snprintf(expected,sizeof expected,"%s: %s",argv[1],strerror(mode==1?ENOSPC:EIO));
   if(strcmp(STR(OBJ(h.value)->f[0])->d,"write")||strcmp(STR(OBJ(h.value)->f[1])->d,expected))return 9;
  }
 }
 fwp_heap_finish();return 0;
}
"#;
    let mut runtime = generated.clone();
    for name in ["fwp_p_file_read_all", "fwp_p_file_read_impl"] {
        let start = runtime.find(&format!("static V {name}(V ")).unwrap();
        let end = start + runtime[start..].find("\n}\n").unwrap() + 3;
        let original = runtime[start..end].to_string();
        let instrumented = original.replace(
            "while ((n = fread(tmp, 1, sizeof tmp, f->f)) > 0) buf_put(&b, tmp, n);",
            "while ((n = fread(tmp, 1, sizeof tmp, f->f)) > 0) {buf_put(&b,tmp,n);watched_buffer=b.d;if(fault==1)fwp_trap(\"read buffer failure\");}"
        ).replace(
            "while ((n = fread(tmp, 1, sizeof tmp, f)) > 0) buf_put(&b, tmp, n);",
            "while ((n = fread(tmp, 1, sizeof tmp, f)) > 0) {buf_put(&b,tmp,n);watched_buffer=b.d;if(fault==1)fwp_trap(\"read buffer failure\");}"
        ).replace("V text = fwp_rc_fresh(buf_to_str(&b));", "if(fault==2)fwp_trap(\"read String failure\");V text = fwp_rc_fresh(buf_to_str(&b));")
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
    let error_branch = "    if (error) {\n        errno = error;\n        return fwp_io_error_path(\"write\", STR(path)->d, err);\n    }";
    assert_eq!(runtime[start..end].matches(error_branch).count(), 1);
    no_write_error.replace_range(
        start..end,
        &runtime[start..end].replace(error_branch, "    (void)error;"),
    );
    let dir = std::env::temp_dir().join(format!("fwp-file-io-owner-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let exe = dir.join("probe.exe");
    let data = dir.join("data");
    for opt in ["-O1", "-O2"] {
        for (index, (code, expected)) in [
            (&omitted, 5),
            (&no_stream, 5),
            (&no_write_error, 8),
            (&runtime, 0),
        ]
        .into_iter()
        .enumerate()
        {
            let program = format!("{stream_observer}\n{hooks}\n{code}\n{fixture}");
            fwp::cgen::compile_c(&program, &exe, opt).unwrap();

            std::fs::write(&data, "contents").unwrap();
            let out = Command::new(&exe).arg(&data).output().unwrap();
            record_probe::save(
                "file_io_errors",
                &format!("control-{index}-{expected}{opt}"),
                &program,
                &exe,
                &out,
            );
            assert_eq!(
                out.status.code(),
                Some(expected),
                "{opt}: {}",
                String::from_utf8_lossy(&out.stderr)
            );
        }
    }
    std::fs::remove_dir_all(&dir).unwrap();
}
