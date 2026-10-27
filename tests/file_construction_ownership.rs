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
    let (generated, _) = fwp::cgen::generate_library(&p, "file_owner", &[]).unwrap();
    let hooks = r#"
#ifdef _WIN32
#ifndef _WIN32_WINNT
#define _WIN32_WINNT 0x0a00
#endif
#include <wchar.h>
#endif
#include <stdio.h>
#include <stdint.h>
static int fault, closes, watched_fd, callbacks;
static uintptr_t watched_stream;
#ifdef _WIN32
static uintptr_t watched_os_handle;
static FILE *observe_wide_open(const wchar_t *, const wchar_t *);
#define _wfopen observe_wide_open
#endif
static void *observed_handle;
static unsigned handle_frees;
static void observe_handle_free(void *);
static FILE *observe_open(const char *, const char *);
static int observe_close(FILE *);
#define fopen observe_open
#define fclose observe_close
"#;
    let fixture = r#"
#undef fopen
#undef fclose
#ifdef _WIN32
#undef _wfopen
#else
#include <fcntl.h>
#endif
static FILE *observe_open(const char *path,const char *mode) {
 FILE *f=fopen(path,mode);if(f){watched_stream=(uintptr_t)f;watched_fd=fileno(f);}return f;
}
#ifdef _WIN32
static FILE *observe_wide_open(const wchar_t *path,const wchar_t *mode) {
 FILE *f=_wfopen(path,mode);
 if(f){watched_stream=(uintptr_t)f;watched_fd=_fileno(f);watched_os_handle=(uintptr_t)_get_osfhandle(watched_fd);}
 return f;
}
#endif
static int observed_stream_closed(void) {
#ifdef _WIN32
 DWORD flags;
 return !GetHandleInformation((HANDLE)watched_os_handle,&flags) && GetLastError()==ERROR_INVALID_HANDLE;
#else
 return fcntl(watched_fd,F_GETFD)==-1 && errno==EBADF;
#endif
}
static void observe_handle_free(void *p) {
 if(p&&p==observed_handle){if(((fwp_file *)p)->f)_Exit(3);handle_frees++;}
}
static int observe_close(FILE *f) {if((uintptr_t)f==watched_stream)closes++;return fclose(f);}
static jmp_buf construction_failure;
static int recover_construction(void){return 1;}
static V file_callback(V *a){
 fwp_value_owner input={a[0],fwp_file_drop};fwp_cleanup cleanup;
 fwp_value_protect(&input,&cleanup);callbacks++;
 if(fault==4)fwp_trap("file callback failure");
 V result=fwp_rc_fresh(fwp_tuple2(7,a[0]));
 fwp_value_finish(&input,&cleanup);return result;
}
static void drop_pair(V pair){fwp_file_drop(OBJ(pair)->f[1]);fwp_rc_free_obj(pair);}
static void file_captures(V fn,int duplicate){(void)fn;(void)duplicate;}
static void file_arguments(V *args,uint32_t start,uint32_t count){
 if(start>1||count>1-start)_Exit(32);for(uint32_t i=0;i<count;i++)fwp_file_dup(args[i]);
}
static void drop_file_arguments(V *args,uint32_t start,uint32_t count){
 if(start>1||count>1-start)_Exit(32);for(uint32_t i=0;i<count;i++)fwp_file_drop(args[i]);
}
static const fwp_owned_fninfo file_owned={file_callback,file_captures,file_arguments,drop_file_arguments};
static const fwp_fninfo callbacks_table[]={{1,file_callback,"file callback",&file_owned}};
static fwp_clo callback={0,0};
int main(int argc,char **argv){
 if(argc!=2)return 30;fwp_lib_init();fwp_heap_start();if(!fwp_heap.base)return 31;
 fwp_fns=callbacks_table;
 for(volatile int create=0;create<2;create++)for(volatile int scoped=0;scoped<2;scoped++)for(volatile int mode=0;mode<(scoped?5:4);mode++){
  fault=0;closes=0;watched_fd=-1;watched_stream=0;observed_handle=0;handle_frees=0;callbacks=0;fwp_fns=callbacks_table;
  V path=fwp_rc_fresh(fwp_cstr(argv[1]));fault=mode;
  fwp_trap_recover=recover_construction;fwp_trap_jb=&construction_failure;fwp_trap_cleanup=0;
  if(!setjmp(construction_failure)){
   V result=scoped?fwp_p_file_with_owned(path,PTR(&callback),0,drop_pair,0):fwp_p_file_open(path,create,0);
   if(mode)return 1;
   if(scoped){if(result!=7||callbacks!=1)return 6;}
   else {if(closes)return 7;fwp_p_file_close(result);fwp_p_file_close(result);fwp_file_drop(result);}
  }else if(!mode){fprintf(stderr,"unexpected trap: %s\n",fwp_trap_msg);return 8;}
  fault=0;fwp_trap_recover=0;fwp_trap_jb=0;fwp_handlers=0;
  if(fwp_cleanups||closes!=1||watched_fd<0||!observed_stream_closed())return 2;
  // Observe release before storage returns to the allocator; never read it later.
  if(observed_handle&&handle_frees!=1)_Exit(3);
  fwp_rc_free_obj(path);
  if(mode&&mode<4&&callbacks)return 4;
  if(mode==4&&callbacks!=1)return 5;
  // A failed but registered handle must not close the stream again.
  fwp_heap_finish();if(closes!=1)return 9;
  fwp_lib_init();fwp_heap_start();
 }
 fwp_heap_finish();return 0;
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
        .replace("    fwp_heap_finalizer(h, fwp_file_final);",
            "    if(fault==3)fwp_trap(\"file finalizer registration\");\n    fwp_heap_finalizer(h, fwp_file_final);");
    assert_ne!(value, injected);
    let instrument = |code: String| {
        let free = "static void fwp_mem_free(void *p) {\n";
        assert_eq!(code.matches(free).count(), 1);
        code.replace(free, &format!("{free}    observe_handle_free(p);\n"))
    };
    let runtime = instrument(generated.replacen(value, &injected, 1));
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
            let broken = instrument(generated.replacen(value, control, 1));
            fwp::cgen::compile_c(&format!("{hooks}\n{broken}\n{fixture}"), &exe, opt).unwrap();
            std::fs::write(dir.0.join("data"), "").unwrap();
            let out = Command::new(&exe).arg(dir.0.join("data")).output().unwrap();
            assert_eq!(
                out.status.code(),
                Some(expected),
                "missing constructor ownership must be detected: {}",
                String::from_utf8_lossy(&out.stderr)
            );
        }
        std::fs::write(dir.0.join("data"), "").unwrap();
        fwp::cgen::compile_c(&format!("{hooks}\n{runtime}\n{fixture}"), &exe, opt).unwrap();

        checked(Command::new(&exe).arg(dir.0.join("data")));
    }
}
