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
    let (generated, _) = fwp::cgen::generate_library(&program, "inline_file", &[]).unwrap();
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
    fwp_rc_fresh(PTR(h));
    file.handle = PTR(h);
#ifdef FWP_LIBRARY
    fwp_heap_finalizer(h, fwp_file_final);
#endif
    char *p = (char *)observe_alloc(strlen(path) + 1, 1);
    strcpy(p, path);
    h->path = p;

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
 fwp_lib_init();fwp_heap_start();
 const fwp_desc desc={.kind=K_FILE};
 for(size_t n=0;n<=4096;n=n? n*2:1){
  char *path=malloc(n+1);if(!path)return 20;memset(path,'x',n);path[n]=0;
  FILE *stream=tmpfile();if(!stream)return 21;
  size_t before=fwp_heap.live;
  allocations=requested=0;root=fwp_file_value(stream,path);
  fwp_file *h=(fwp_file *)(uintptr_t)root;
  if(allocations!=EXPECTED_ALLOCS||requested!=sizeof(fwp_file)+n+1)return 1;
  if((uintptr_t)h%_Alignof(fwp_file)||h->refs!=1||strlen(h->path)!=n)return 2;
  memset(path,'y',n);free(path);
  fwp_file_dup(root);fwp_file_drop(root);if(h->refs!=1)return 3;
  fwp_p_file_close(root);
  V shown=fwp_rc_fresh(fwp_show(root,&desc));
  if(STR(shown)->len!=n+7||memcmp(STR(shown)->d,"<file ",6)||STR(shown)->d[n+6]!='>')return 4;
  for(size_t i=0;i<n;i++)if(STR(shown)->d[i+6]!='x')return 5;
  fwp_rc_free_obj(shown);
  fwp_file_drop(root);
  root=0;
  if(fwp_heap.live!=before)return 6;
 }
 fwp_heap_finish();return 0;
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
                let drop_start = runtime.find("static void fwp_file_drop(V h) {").unwrap();
                let drop_end = drop_start + runtime[drop_start..].find("\n}\n").unwrap() + 3;
                runtime.replace_range(drop_start..drop_end, "static void fwp_file_drop(V h) {\n    if (!h) return;\n    fwp_file *file = (fwp_file *)(uintptr_t)h;\n    if (!file->refs || --file->refs) return;\n    fwp_p_file_close(h);\n    fwp_heap_forget_finalizer(file);\n    fwp_mem_free((void *)file->path);\n    fwp_mem_free(file);\n}\n");
            }
            let code = format!(
                "#define EXPECTED_ALLOCS {}\n{hooks}\n{runtime}\n_Static_assert(sizeof(fwp_file) == {}, \"File header size\");\n{fixture}",
                if old { 2 } else { 1 },
                if old { 24 } else { 16 }
            );
            fwp::cgen::compile_c(&code, &exe, opt).unwrap();

            let out = Command::new(&exe).output().unwrap();
            assert!(
                out.status.success(),
                "{opt}, old={old}: {:?}: {}",
                out.status.code(),
                String::from_utf8_lossy(&out.stderr)
            );
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
            "main = {:?} | file.open | file.read-all | .0 | echo\n",
            data.to_string_lossy()
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
        for no_reuse in [false, true] {
            let cfile = dir.join("probe.c");
            let out = Command::new(fwp)
                .args(["build"])
                .arg(&source)
                .args([opt, "--emit-c", "-o"])
                .arg(&cfile)
                .output()
                .unwrap();
            assert!(
                out.status.success(),
                "{}",
                String::from_utf8_lossy(&out.stderr)
            );
            let code = std::fs::read_to_string(&cfile).unwrap();
            let code = if no_reuse {
                format!("#define FWP_NO_REUSE 1\n{code}")
            } else {
                code
            };
            fwp::cgen::compile_c(&code, &exe, opt).unwrap();

            let out = Command::new(&exe).output().unwrap();
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
