//! File paths use one aligned leaf allocation and preserve closed-handle display.
use fwp::ir::*;
use std::process::Command;

#[test]
fn inline_paths_preserve_display_and_reduce_constructor_allocations() {
    let unit = MT::Record(vec![]);
    let program = Program {
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
    let (generated, _) = fwp::cgen::generate_library(&program, "inline_file").unwrap();
    let start = generated
        .find("static V fwp_file_value(FILE *f, const char *path) {")
        .unwrap();
    let end = start + generated[start..].find("\n}\n").unwrap() + 3;
    let current = &generated[start..end];
    let previous = r#"static V fwp_file_value(FILE *f, const char *path) {
    fwp_file_cleanup file = {f, 0};
    fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup, fwp_close_scoped_file, &file);
    fwp_file *h = (fwp_file *)observe_alloc(sizeof(fwp_file), 0);
    h->f = f;
    h->path = path;
    h->refs = 1;
    file.handle = PTR(h);
#ifdef FWP_LIBRARY
    fwp_gc_finalizer(h, fwp_file_final);
#endif
    char *p = (char *)observe_alloc(strlen(path) + 1, 1);
    strcpy(p, path);
    h->path = p;
    FWP_KEEP_ALIVE(path);
    fwp_cleanup_pop(&cleanup);
    return PTR(h);
}
"#;
    let instrumented = current.replace(
        "fwp_alloc_leaf(sizeof(fwp_file) + len + 1)",
        "observe_alloc(sizeof(fwp_file) + len + 1, 1)",
    );
    assert_ne!(instrumented, current);
    let hooks = "#include <stddef.h>\nstatic void *observe_alloc(size_t,int);\n";
    let fixture = r#"
static size_t allocations, requested;
static volatile V root;
static void *observe_alloc(size_t n,int leaf){
 allocations++;requested+=n;return leaf?fwp_alloc_leaf(n):fwp_alloc(n);
}
int main(void){
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));
 const fwp_desc desc={.kind=K_FILE};
 for(size_t n=0;n<=4096;n=n? n*2:1){
  char *path=malloc(n+1);if(!path)return 20;memset(path,'x',n);path[n]=0;
  FILE *stream=tmpfile();if(!stream)return 21;
  allocations=requested=0;root=fwp_file_value(stream,path);
  fwp_file *h=(fwp_file *)(uintptr_t)root;
  if(allocations!=EXPECTED_ALLOCS||requested!=sizeof(fwp_file)+n+1)return 1;
  if((uintptr_t)h%_Alignof(fwp_file)||h->refs!=1||strlen(h->path)!=n)return 2;
  memset(path,'y',n);free(path);
  fwp_file_dup(root);fwp_file_drop(root);if(h->refs!=1)return 3;
  fwp_p_file_close(root);
  V shown=fwp_show(root,&desc);
  if(STR(shown)->len!=n+7||memcmp(STR(shown)->d,"<file ",6)||STR(shown)->d[n+6]!='>')return 4;
  for(size_t i=0;i<n;i++)if(STR(shown)->d[i+6]!='x')return 5;
  fwp_file_drop(root);if(h->refs||h->f)return 6;
  root=0;
 }
 fwp_gc_finish();return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("file-inline-path").unwrap();
    let exe = dir.join("probe");
    for opt in ["-O1", "-O2"] {
        for old in [false, true] {
            let mut runtime =
                generated.replacen(current, if old { previous } else { &instrumented }, 1);
            if old {
                runtime = runtime.replace(
                    "typedef struct { FILE *f; uint64_t refs; char path[]; } fwp_file;",
                    "typedef struct { FILE *f; const char *path; uint64_t refs; } fwp_file;",
                );
            }
            let code = format!(
                "#define EXPECTED_ALLOCS {}\n{hooks}\n{runtime}\n_Static_assert(sizeof(fwp_file) == {}, \"File header size\");\n{fixture}",
                if old { 2 } else { 1 },
                if old { 24 } else { 16 }
            );
            fwp::cgen::compile_c(&code, &exe, opt).unwrap();
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
                        "{opt}, old={old}, gc={gc}, poison={poison}: {:?}: {}",
                        out.status.code(),
                        String::from_utf8_lossy(&out.stderr)
                    );
                }
            }
        }
    }
}

#[test]
fn source_file_io_matches_the_unoptimized_interpreter() {
    let dir = fwp::cgen::TempDir::new("file-inline-display").unwrap();
    let data = dir.join("héllo.data");
    std::fs::write(&data, "contents").unwrap();
    let source = dir.join("probe.fwp");
    std::fs::write(
        &source,
        format!(
            "main = \"{}\" | file.open | file.read-all | .0 | echo\n",
            data.display()
        ),
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = Command::new(fwp)
        .env("FWP_NO_OPT", "1")
        .args(["run", "--interp"])
        .arg(&source)
        .output()
        .unwrap();
    assert!(
        reference.status.success(),
        "{}",
        String::from_utf8_lossy(&reference.stderr)
    );
    assert_eq!(reference.stdout, b"contents\n");
    let exe = dir.join("probe");
    for opt in ["-O1", "-O2"] {
        for disabled in [false, true] {
            let mut build = Command::new(fwp);
            if disabled {
                build.env("FWP_REUSE", "0").env("FWP_FREE", "0");
            }
            let out = build
                .arg("build")
                .arg(&source)
                .args([opt, "-o"])
                .arg(&exe)
                .output()
                .unwrap();
            assert!(
                out.status.success(),
                "{}",
                String::from_utf8_lossy(&out.stderr)
            );
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
                        "{}",
                        String::from_utf8_lossy(&out.stderr)
                    );
                    assert_eq!(out.stdout, reference.stdout);
                    assert_eq!(out.stderr, reference.stderr);
                }
            }
        }
    }
}
