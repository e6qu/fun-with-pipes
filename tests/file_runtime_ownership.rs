//! File ownership closes streams independently of tracing metadata.
#![cfg(any(target_os = "linux", target_os = "macos"))]
use std::process::Command;

#[test]
fn file_aliases_and_borrowed_io_unwind_preserve_stream_owners() {
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
    let (generated, _) = fwp::cgen::generate_library(&p, "file_owners").unwrap();
    let hooks = r#"
#include <stdio.h>
#include <stdlib.h>
static int fault, watched_fd, closes;
static FILE *watched_stream;
static FILE *observe_open(const char *,const char *);
static int observe_close(FILE *);
static size_t observe_write(const void *,size_t,size_t,FILE *);
static int observe_flush(FILE *);
static int observe_error(FILE *);
#define fopen observe_open
#define fclose observe_close
#define fwrite observe_write
#define fflush observe_flush
#define ferror observe_error
"#;
    let fixture = r#"
#undef fopen
#undef fclose
#undef fwrite
#undef fflush
#undef ferror
#include <fcntl.h>
static volatile V handle;
static FILE *observe_open(const char *p,const char *m){
 FILE *f=fopen(p,m);if(f){watched_stream=f;watched_fd=fileno(f);}return f;
}
static int observe_close(FILE *f){if(f==watched_stream)closes++;return fclose(f);}
static size_t observe_write(const void *p,size_t size,size_t n,FILE *f){
 if(f==watched_stream&&fault==1){errno=ENOSPC;return 0;}return fwrite(p,size,n,f);
}
static int observe_flush(FILE *f){if(f==watched_stream&&fault==2){errno=EIO;return EOF;}return fflush(f);}
static int observe_error(FILE *f){if(f==watched_stream&&fault==3){errno=EIO;return 1;}return ferror(f);}
static jmp_buf recovery;
static int recover(void){return 1;}
int main(int argc,char **argv){
 if(argc!=2)return 30;fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));
 /* Deliberately clear the GC count. Resource counts must remain independent. */
 handle=fwp_p_file_open(fwp_cstr(argv[1]),0,0);fwp_file *h=(fwp_file *)(uintptr_t)handle;
 fwp_rc_share(handle);uint8_t *slot=fwp_rc_slot(handle);if(slot&&*slot)return 1;
 for(int i=0;i<300;i++)fwp_file_dup(handle);
 if(h->refs!=301)return 2;
 for(int i=0;i<300;i++)fwp_file_drop(handle);
 if(h->refs!=1||closes||fcntl(watched_fd,F_GETFD)==-1)return 3;
 fwp_file_drop(handle);if(h->refs||closes!=1||fcntl(watched_fd,F_GETFD)!=-1||errno!=EBADF)return 4;
 handle=fwp_p_file_open(fwp_cstr(argv[1]),1,0);h=(fwp_file *)(uintptr_t)handle;closes=0;
 fwp_file_dup(handle);fwp_p_file_close(handle);
 if(h->refs!=2||closes!=1)return 5;
 fwp_file_drop(handle);fwp_file_drop(handle);if(h->refs||closes!=1)return 5;
 /* I/O returns an owned alias without consuming the caller's owner. */
 handle=fwp_p_file_open(fwp_cstr(argv[1]),1,0);h=(fwp_file *)(uintptr_t)handle;closes=0;
 V written=fwp_p_file_write_owned(fwp_cstr("contents"),handle,0);
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
  int failed=setjmp(handler.jb);
  if(!failed){if(mode==3)fwp_p_file_read_all_owned(handle,0);else fwp_p_file_write_owned(fwp_cstr("more"),handle,0);}
  fwp_handlers=handler.prev;fault=0;
  if(!failed||h->refs!=1||closes||fwp_cleanups||fcntl(watched_fd,F_GETFD)==-1)return 7;
  if(strcmp(STR(OBJ(handler.value)->f[0])->d,mode==3?"read":"write"))return 8;
  if(strcmp(STR(OBJ(handler.value)->f[1])->d,strerror(mode==1?ENOSPC:EIO)))return 8;
 }
 /* Allocation/conversion traps clean the extra alias and the fresh String. */
 for(volatile int mode=4;mode<6;mode++){
  rewind(h->f);fault=mode;watched_text=0;double before=fwp_gc.freed;
  fwp_trap_recover=recover;fwp_trap_jb=&recovery;fwp_trap_cleanup=0;
  int failed=setjmp(recovery);if(!failed)fwp_p_file_read_all_owned(handle,0);
  fwp_trap_recover=0;fwp_trap_jb=0;fault=0;
  if(!failed||h->refs!=1||closes||fwp_cleanups||fcntl(watched_fd,F_GETFD)==-1)return 9;
  if(mode==5){
#ifndef FWP_RESOURCE_NO_FREE
   if(fwp_reuse_verify){if(!watched_text||STR(watched_text)->len||STR(watched_text)->d[0])return 10;}
   else if(fwp_gc.freed<=before)return 10;
#else
   if(fwp_gc.freed!=before)return 10;
#endif
  }
 }
 /* Overflow traps before touching the stream or registering a cleanup. */
 h->refs=UINT64_MAX;fwp_trap_recover=recover;fwp_trap_jb=&recovery;fwp_trap_cleanup=0;
 int overflow=setjmp(recovery);if(!overflow)fwp_file_dup(handle);
 fwp_trap_recover=0;fwp_trap_jb=0;
 if(!overflow||h->refs!=UINT64_MAX||closes||fwp_cleanups)return 11;
 h->refs=1;fwp_file_drop(handle);if(closes!=1||h->refs)return 12;
 /* Library finalizers still see headers, but must not close discarded streams twice. */
 handle=0;fwp_gc_finish();if(closes!=1)return 13;return 0;
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
    // The observed String is a weak test observation, not an ownership reference.
    runtime = runtime.replacen(
        "static V fwp_p_file_read_all(V ",
        "static volatile V watched_text;\nstatic V fwp_p_file_read_all(V ",
        1,
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
    let exe = dir.join("probe");
    let data = dir.join("data");
    for opt in ["-O1", "-O2"] {
        for (code, expected) in [
            (&no_alias, 6),
            (&no_owner, 7),
            (&no_text, 10),
            (&runtime, 0),
        ] {
            fwp::cgen::compile_c(&format!("{hooks}\n{code}\n{fixture}"), &exe, opt).unwrap();
            for (gc, poison) in [("on", "0"), ("on", "1"), ("off", "0"), ("off", "1")] {
                std::fs::write(&data, "contents").unwrap();
                let out = Command::new(&exe)
                    .arg(&data)
                    .env("FWP_GC", gc)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison)
                    .output()
                    .unwrap();
                assert_eq!(
                    out.status.code(),
                    Some(expected),
                    "{opt}, GC {gc}, poison {poison}: {}",
                    String::from_utf8_lossy(&out.stderr)
                );
            }
        }
        fwp::cgen::compile_c(
            &format!("{hooks}\n#define FWP_RESOURCE_NO_FREE 1\n{runtime}\n{fixture}"),
            &exe,
            opt,
        )
        .unwrap();
        for (gc, poison) in [("on", "0"), ("on", "1"), ("off", "0"), ("off", "1")] {
            std::fs::write(&data, "contents").unwrap();
            let out = Command::new(&exe)
                .arg(&data)
                .env("FWP_GC", gc)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", poison)
                .output()
                .unwrap();
            assert_eq!(
                out.status.code(),
                Some(0),
                "{opt}, GC {gc}, no free: {}",
                String::from_utf8_lossy(&out.stderr)
            );
        }
    }
    std::fs::remove_dir_all(&dir).unwrap();
}
