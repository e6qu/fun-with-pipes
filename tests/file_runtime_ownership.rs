//! File aliases own streams through successful I/O, failure and final release.
use fwp::ir::*;
use std::process::Command;

#[path = "support/record_probe.rs"]
mod record_probe;

#[test]
fn file_aliases_and_borrowed_io_unwind_preserve_stream_owners() {
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
    let (generated, _) = fwp::cgen::generate_library(&p, "file_owners", &[]).unwrap();
    let stream_observer = include_str!("fixtures/file_stream_observer.c");
    let hooks = r#"
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
static uintptr_t watched_text;
static unsigned watched_text_frees;
static int fault, closes;
static int observe_close(FILE *);
static size_t observe_write(const void *,size_t,size_t,FILE *);
static int observe_flush(FILE *);
static int observe_error(FILE *);
#ifdef _WIN32
#define _wfopen observe_wopen
#else
#define fopen observe_open
#endif
#define fclose observe_close
#define fwrite observe_write
#define fflush observe_flush
#define ferror observe_error
"#;
    let fixture = r#"
#undef fopen
#undef _wfopen
#undef fclose
#undef fwrite
#undef fflush
#undef ferror
#include <fcntl.h>
static volatile V handle;
static int observe_close(FILE *f){if(f==watched_stream){watched_stream=NULL;closes++;}return fclose(f);}
static size_t observe_write(const void *p,size_t size,size_t n,FILE *f){
 if(f==watched_stream&&fault==1){errno=ENOSPC;return 0;}return fwrite(p,size,n,f);
}
static int observe_flush(FILE *f){if(f==watched_stream&&fault==2){errno=EIO;return EOF;}return fflush(f);}
static int observe_error(FILE *f){if(f==watched_stream&&fault==3){errno=EIO;return 1;}return ferror(f);}
static jmp_buf recovery;
static int recover(void){return 1;}
int main(int argc,char **argv){
 if(argc!=2)return 30;fwp_lib_init();fwp_heap_start();
 V path=fwp_rc_fresh(fwp_cstr(argv[1]));
 V contents=fwp_rc_fresh(fwp_cstr("contents")), more=fwp_rc_fresh(fwp_cstr("more"));
 handle=fwp_p_file_open(path,0,0);fwp_file *h=(fwp_file *)(uintptr_t)handle;
 if(!fwp_rc_last(handle))return 1;
 for(int i=0;i<300;i++)fwp_file_dup(handle);
 if(h->refs!=301)return 2;
 for(int i=0;i<300;i++)fwp_file_drop(handle);
 if(h->refs!=1||closes||!stream_is_open())return 3;
 fwp_file_drop(handle);if(closes!=1||stream_is_open())return 4;
 handle=fwp_p_file_open(path,1,0);h=(fwp_file *)(uintptr_t)handle;closes=0;
 fwp_file_dup(handle);fwp_p_file_close(handle);
 if(h->refs!=2||closes!=1)return 5;
 fwp_file_drop(handle);fwp_file_drop(handle);if(closes!=1)return 5;
 /* I/O returns an owned alias without consuming the caller's owner. */
 handle=fwp_p_file_open(path,1,0);h=(fwp_file *)(uintptr_t)handle;closes=0;
 V written=fwp_p_file_write_owned(contents,handle,0);
 if(written!=handle||h->refs!=2||fwp_cleanups)return 6;
 fwp_file_drop(written);rewind(h->f);
 V tuple=fwp_p_file_read_all_owned(handle,0);
 if(h->refs!=2||OBJ(tuple)->f[1]!=handle||strcmp(STR(OBJ(tuple)->f[0])->d,"contents")||fwp_cleanups)return 6;
 fwp_file_text_drop(OBJ(tuple)->f[0]);fwp_file_drop(OBJ(tuple)->f[1]);fwp_rc_free_obj(tuple);
 if(h->refs!=1||closes)return 6;
 /* Recoverable I/O failures must discard only the extra alias. */
 for(volatile int mode=1;mode<4;mode++){
  rewind(h->f);fault=mode;
  fwp_handler handler;handler.prev=fwp_handlers;handler.state_depth=fwp_state_len;
  handler.cleanup=fwp_cleanups;fwp_handlers=&handler;
  int failed=0;
  if(setjmp(handler.jb))failed=1;else{if(mode==3)fwp_p_file_read_all_owned(handle,0);else fwp_p_file_write_owned(more,handle,0);}
  fwp_handlers=handler.prev;fault=0;
  if(!failed||h->refs!=1||closes||fwp_cleanups||!stream_is_open())return 7;
  if(strcmp(STR(OBJ(handler.value)->f[0])->d,mode==3?"read":"write"))return 8;
  if(strcmp(STR(OBJ(handler.value)->f[1])->d,strerror(mode==1?ENOSPC:EIO)))return 8;
  fwp_rc_free_obj(OBJ(handler.value)->f[0]);fwp_rc_free_obj(OBJ(handler.value)->f[1]);fwp_rc_free_obj(handler.value);
 }
 /* Allocation/conversion traps clean the extra alias and the fresh String. */
 for(volatile int mode=4;mode<6;mode++){
  rewind(h->f);fault=mode;watched_text=0;watched_text_frees=0;double before=fwp_heap.freed;
  fwp_trap_recover=recover;fwp_trap_jb=&recovery;fwp_trap_cleanup=0;
  int failed=0;if(setjmp(recovery))failed=1;else fwp_p_file_read_all_owned(handle,0);
  fwp_trap_recover=0;fwp_trap_jb=0;fault=0;
  if(!failed||h->refs!=1||closes||fwp_cleanups||!stream_is_open())return 9;
  if(mode==5){
#ifndef FWP_RESOURCE_NO_FREE
   if(!watched_text||watched_text_frees!=1||fwp_heap.freed<=before)return 10;
#else
   if(!watched_text||watched_text_frees||fwp_heap.freed!=before)return 10;
#endif
  }
 }
 /* Overflow traps before touching the stream or registering a cleanup. */
 h->refs=UINT64_MAX;fwp_trap_recover=recover;fwp_trap_jb=&recovery;fwp_trap_cleanup=0;
 int overflow=0;if(setjmp(recovery))overflow=1;else fwp_file_dup(handle);
 fwp_trap_recover=0;fwp_trap_jb=0;
 if(!overflow||h->refs!=UINT64_MAX||closes||fwp_cleanups)return 11;
 h->refs=1;fwp_file_drop(handle);if(closes!=1)return 12;
 /* Library finalizers still see headers, but must not close discarded streams twice. */
 fwp_rc_free_obj(path);fwp_rc_free_obj(contents);fwp_rc_free_obj(more);
 handle=0;fwp_heap_finish();if(closes!=1)return 13;return 0;
}
"#;
    let mut runtime = generated;
    let start = runtime.find("static V fwp_p_file_read_all(V ").unwrap();
    let end = start + runtime[start..].find("\n}\n").unwrap() + 3;
    let original = runtime[start..end].to_string();
    let instrumented = original
        .replace("V text = fwp_rc_fresh(buf_to_str(&b));", "if(fault==4)fwp_trap(\"conversion failure\");V text = fwp_rc_fresh(buf_to_str(&b));watched_text=text;")
        .replace("V result = fwp_tuple2(text, h);", "if(fault==5)fwp_trap(\"tuple failure\");V result = fwp_tuple2(text,h);");
    assert_ne!(original, instrumented);
    runtime.replace_range(start..end, &instrumented);
    let free = "static void fwp_mem_free(void *p) {\n";
    assert_eq!(runtime.matches(free).count(), 1);
    runtime = runtime.replace(
        free,
        &format!("{free}    if(p && (uintptr_t)p==watched_text)watched_text_frees++;\n"),
    );
    let no_alias = runtime.replace("    fwp_file_dup(h);", "    (void)h;");
    assert_ne!(no_alias, runtime);
    let no_owner = runtime
        .replace(
            "    fwp_value_protect(&owner, &cleanup);",
            "    (void)cleanup;",
        )
        .replace(
            "    return fwp_value_finish(&owner, &cleanup);",
            "    return owner.value;",
        )
        .replace(
            "    fwp_value_finish(&owner, &cleanup);",
            "    owner.value = 0;",
        );
    assert_ne!(no_owner, runtime);
    let no_text = runtime
        .replace(
            "    fwp_value_protect(&text_owner, &text_cleanup);",
            "    (void)text_cleanup;",
        )
        .replace(
            "    fwp_value_finish(&text_owner, &text_cleanup);",
            "    text_owner.value = 0;",
        );
    assert_ne!(no_text, runtime);
    let dir = std::env::temp_dir().join(format!("fwp-file-runtime-owners-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let exe = dir.join("probe.exe");
    let data = dir.join("data");
    for opt in ["-O1", "-O2"] {
        for (index, (code, expected)) in [
            (&no_alias, 6),
            (&no_owner, 7),
            (&no_text, 10),
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
                "file_runtime_ownership",
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
        let program = format!(
            "{stream_observer}\n{hooks}\n#define FWP_RESOURCE_NO_FREE 1\n{runtime}\n{fixture}"
        );
        fwp::cgen::compile_c(&program, &exe, opt).unwrap();

        std::fs::write(&data, "contents").unwrap();
        let out = Command::new(&exe).arg(&data).output().unwrap();
        record_probe::save(
            "file_runtime_ownership",
            &format!("suppressed-free{opt}"),
            &program,
            &exe,
            &out,
        );
        assert_eq!(
            out.status.code(),
            Some(0),
            "{opt}, no free: {}",
            String::from_utf8_lossy(&out.stderr)
        );
    }
    std::fs::remove_dir_all(&dir).unwrap();
}
