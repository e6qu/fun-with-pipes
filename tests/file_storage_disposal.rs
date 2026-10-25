//! Last File owners unlink finalizers before returning unshared storage.
use fwp::ir::*;
use std::process::Command;

#[path = "support/record_probe.rs"]
mod record_probe;

#[test]
fn file_storage_disposal_removes_finalizers_before_reuse() {
    fwp::cgen::set_native_options(fwp::cgen::NativeOptions {
        arc: false,
        ..Default::default()
    });
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
    let exe = dir.join("probe.exe");
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

#[test]
fn arc_file_owners_close_descriptors_and_release_storage_each_round() {
    let dir = fwp::cgen::TempDir::new("arc-file-storage").unwrap();
    let source = dir.join("files.fwp");
    let cfile = dir.join("files.c");
    std::fs::write(&source, "export probe : () -> I64\nprobe = const 7\n").unwrap();
    let emitted = Command::new(env!("CARGO_BIN_EXE_fwp"))
        .args([
            "build",
            "--gc",
            "arc",
            "--memory",
            "dynamic",
            "--staticlib",
            "--emit-c",
        ])
        .arg(&source)
        .arg("-o")
        .arg(&cfile)
        .output()
        .unwrap();
    assert!(emitted.status.success(), "{emitted:?}");
    let generated = std::fs::read_to_string(&cfile).unwrap();
    let fixture = r#"
#include <sys/stat.h>
static uintptr_t descriptor(FILE *stream) {
#ifdef _WIN32
    return (uintptr_t)_get_osfhandle(_fileno(stream));
#else
    return (uintptr_t)fileno(stream);
#endif
}
static int closed(uintptr_t descriptor) {
#ifdef _WIN32
    DWORD flags;
    return !GetHandleInformation((HANDLE)descriptor, &flags) && GetLastError() == ERROR_INVALID_HANDLE;
#else
    struct stat status;
    return fstat((int)descriptor, &status) == -1 && errno == EBADF;
#endif
}
int main(int argc, char **argv) {
    if (argc != 2) _Exit(218);
    unsigned rounds = (unsigned)strtoul(argv[1], NULL, 10);
    if (rounds != 8 && rounds != 1024) _Exit(218);
    fwp_lib_init(); fwp_gc_start(__builtin_frame_address(0));
    intptr_t empty = fwp_gc.budget;
    FILE *stream = tmpfile(); if (!stream) _Exit(219);
    uintptr_t keep_descriptor = descriptor(stream);
    V keep = fwp_file_value(stream, "kept");
    intptr_t baseline = fwp_gc.budget;
    for (unsigned round = 0; round < rounds; round++) {
        stream = tmpfile(); if (!stream) _Exit(219);
        uintptr_t fd = descriptor(stream);
        V value = fwp_file_value(stream, "round");
        fwp_file *file = (fwp_file *)(uintptr_t)value;
        if (fwp_gc.nfins != 2) _Exit(211);
        for (unsigned owner = 0; owner < 300; owner++) fwp_file_dup(value);
        for (unsigned owner = 0; owner < 300; owner++) fwp_file_drop(value);
        if (file->refs != 1 || closed(fd) || closed(keep_descriptor)) _Exit(213);
        if (round & 1) {
            fwp_p_file_close(value); fwp_p_file_close(value);
            if (file->refs != 1 || file->f || !closed(fd)) _Exit(214);
        }
        fwp_file_drop(value);
        if (!closed(fd)) _Exit(210);
        /* Stop before a broken finalizer list can revisit freed storage. */
        if (fwp_gc.nfins != 1) _Exit(211);
        if (fwp_gc.budget != baseline) _Exit(212);
        if (closed(keep_descriptor) || fwp_gc.ncollect) _Exit(215);
    }
    fwp_file_drop(keep);
    if (!closed(keep_descriptor)) _Exit(210);
    if (fwp_gc.nfins) _Exit(211);
    if (fwp_gc.budget != empty) _Exit(212);
    return 0;
}
"#;
    let mut cases = vec![("normal", generated.clone(), 0)];
    for (name, before, after, status) in [
        (
            "missing-close",
            "    fwp_p_file_close(h);\n#ifdef FWP_LIBRARY",
            "    /* omit close */\n#ifdef FWP_LIBRARY",
            210,
        ),
        (
            "missing-finalizer-removal",
            "    fwp_gc_forget_finalizer(file);",
            "    /* omit finalizer removal */",
            211,
        ),
        (
            "missing-storage-free",
            "    fwp_mem_free(file);",
            "    /* omit physical storage free */",
            212,
        ),
    ] {
        assert_eq!(generated.matches(before).count(), 1, "{name}");
        cases.push((name, generated.replace(before, after), status));
    }
    for opt in ["-O1", "-O2"] {
        for (name, code, expected) in &cases {
            let code = format!("{code}\n{fixture}");
            let exe = dir.join(format!("{name}{opt}.exe"));
            fwp::cgen::compile_c(&code, &exe, opt).unwrap();
            for rounds in [8, 1024] {
                let out = Command::new(&exe)
                    .arg(rounds.to_string())
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STATS", "0")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                record_probe::save(
                    "file_storage_disposal",
                    &format!("arc-{name}{opt}-{rounds}"),
                    &code,
                    &exe,
                    &out,
                );
                assert_eq!(
                    out.status.code(),
                    Some(*expected),
                    "{name}{opt}/{rounds}: {out:?}"
                );
                assert!(
                    out.stdout.is_empty() && out.stderr.is_empty(),
                    "{name}{opt}/{rounds}: {out:?}"
                );
            }
        }
    }
}
