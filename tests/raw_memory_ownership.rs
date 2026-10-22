//! Raw buffers are manually freed; string conversions copy managed leaves.
use fwp::ffi_interp::pointer_prim;
use fwp::ir::*;
use fwp::value::Value;
use std::process::Command;

#[test]
fn interop_example_releases_sorting_and_formatting_buffers() {
    let dir = fwp::cgen::TempDir::new("fwp-interop-buffers").unwrap();
    let source = std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/run/ffi.fwp");
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = Command::new(compiler)
        .env("FWP_NO_OPT", "1")
        .env("FWP_SEED", "42")
        .args(["run", "--interp"])
        .arg(&source)
        .output()
        .unwrap();
    assert!(reference.status.success(), "{reference:?}");
    assert_eq!(
        reference.stdout,
        std::fs::read(source.with_extension("out")).unwrap()
    );
    assert!(reference.stderr.is_empty());
    for gc in ["tracing", "arc"] {
        let cfile = dir.join("interop.c");
        let emitted = Command::new(compiler)
            .env_remove("FWP_NO_OPT")
            .args(["build", "--gc", gc, "--emit-c", "-O1"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile)
            .output()
            .unwrap();
        assert!(emitted.status.success(), "{emitted:?}");
        let original = std::fs::read_to_string(cfile).unwrap();
        let allocation = "void *p = calloc(n, 1);\n    if (!p) fwp_trap(\"out of memory\");\n    return (V)(uintptr_t)p;";
        let release = "free((void *)(uintptr_t)l0);\n    return FWP_UNIT;";
        assert!(original.contains(allocation) && original.contains(release));
        // Observe only raw mem.alloc/mem.free buffers, independently of managed
        // runtime storage. Reentrant qsort comparators allocate their own buffers.
        let observer = r#"
static void *interop_buffers[64];
static unsigned interop_live, interop_created;
static void *interop_alloc(size_t size) {
    void *p=calloc(size,1);
    if(!p)return p;
    for(unsigned i=0;i<64;i++)if(!interop_buffers[i]){
        interop_buffers[i]=p;interop_live++;interop_created++;return p;
    }
    exit(212);
}
static void interop_free(void *p) {
    for(unsigned i=0;i<64;i++)if(interop_buffers[i]==p){
        interop_buffers[i]=0;interop_live--;free(p);return;
    }
    exit(213);
}
"#;
        // Preserve the runtime's platform macros before any system header.
        let types = "typedef uint64_t V;";
        assert_eq!(original.matches(types).count(), 1);
        assert_eq!(original.matches("calloc(n + 1, 1)").count(), 1);
        let mut code = original
        .replacen(types, &format!("{observer}\n{types}"), 1)
        .replace(
            allocation,
            &allocation.replace("calloc(n, 1)", "interop_alloc(n)"),
        )
        .replace("calloc(n + 1, 1)", "interop_alloc(n + 1)")
        .replace(
            release,
            "interop_free((void *)(uintptr_t)l0);\n    return FWP_UNIT;",
        )
        .replace(
            "    /* Ownership observation point: before runtime teardown. */\n",
            "    if(interop_live || interop_created<3)exit(211);\n    /* Ownership observation point: before runtime teardown. */\n",
        );
        assert!(code.contains("if(interop_live || interop_created<3)exit(211);"));
        if gc == "arc" {
            let init = "    fwp_init_consts();\n";
            let end = "    /* Ownership observation point: before runtime teardown. */\n";
            assert_eq!(code.matches(init).count(), 1);
            assert_eq!(code.matches(end).count(), 1);
            code = code.replace(init, &format!("{init}    intptr_t raw_budget=fwp_gc.budget_given;\n"))
            .replace(end, &format!("{end}    if(fwp_gc.enabled || fwp_gc.ncollect || fwp_gc.budget<raw_budget)exit(214);\n"));
        }
        for opt in ["-O0", "-O2"] {
            for (label, candidate, status) in [
                ("released", code.clone(), 0),
                (
                    "missing-free",
                    code.replace(
                        "interop_free((void *)(uintptr_t)l0);",
                        "/* omit raw buffer release */",
                    ),
                    211,
                ),
            ] {
                let binary = dir.join("interop.exe");
                let measured = candidate;
                fwp::cgen::compile_c(&measured, &binary, opt).unwrap();
                let actual = Command::new(&binary)
                    .env("FWP_SEED", "42")
                    .env("FWP_GC_STRESS", if gc == "arc" { "0" } else { "1" })
                    .env("FWP_GC_VERIFY", if gc == "arc" { "0" } else { "1" })
                    .env("FWP_REUSE_VERIFY", if gc == "arc" { "0" } else { "1" })
                    .output()
                    .unwrap();
                if let Some(artifacts) = std::env::var_os("FWP_QUEUED_FUNCTION_ARTIFACTS") {
                    let artifacts = std::path::PathBuf::from(artifacts).join("interop-buffers");
                    std::fs::create_dir_all(&artifacts).unwrap();
                    let artifact = artifacts.join(format!("{gc}-{label}{opt}"));
                    std::fs::write(artifact.with_extension("c"), &measured).unwrap();
                    std::fs::copy(&binary, artifact.with_extension("exe")).unwrap();
                    std::fs::write(artifact.with_extension("stdout"), &actual.stdout).unwrap();
                    std::fs::write(artifact.with_extension("stderr"), &actual.stderr).unwrap();
                    std::fs::write(
                        artifact.with_extension("status"),
                        format!("{:?}\n", actual.status.code()),
                    )
                    .unwrap();
                }
                assert_eq!(actual.status.code(), Some(status), "{opt}: {actual:?}");
                assert_eq!(actual.stdout, reference.stdout, "{opt}");
                assert!(actual.stderr.is_empty(), "{opt}: {actual:?}");
            }
        }
    }
}

#[test]
fn string_copies_survive_their_source_buffers() {
    let string = MT::con("std::String");
    let ptr = MT::Con("std::Ptr".into(), vec![MT::con("std::U8")]);
    let input = Value::str("héllo");
    let raw = pointer_prim(
        "mem.string",
        std::slice::from_ref(&input),
        std::slice::from_ref(&string),
        &ptr,
    )
    .unwrap();
    let copy = pointer_prim(
        "ptr.read-string",
        std::slice::from_ref(&raw),
        std::slice::from_ref(&ptr),
        &string,
    )
    .unwrap();
    pointer_prim("mem.free", &[raw], &[ptr], &MT::unit()).unwrap();
    assert_eq!(input, Value::str("héllo"));
    assert_eq!(copy, input);
}

#[test]
fn native_string_boundaries_borrow_inputs_and_return_reclaimable_copies() {
    let string = MT::con("std::String");
    let ptr = MT::Con("std::Ptr".into(), vec![MT::con("std::U8")]);
    let primitive = |symbol: &str, parameter: MT, result: MT| Func {
        name: symbol.into(),
        arity: 1,
        locals: vec![parameter.clone()],
        ty: MT::Fun(Box::new(parameter), Box::new(result)),
        body: Body::Prim(symbol.into()),
    };
    let program = Program {
        funcs: vec![
            primitive("mem.string", string.clone(), ptr.clone()),
            primitive("ptr.read-string", ptr.clone(), string.clone()),
            primitive("mem.free", ptr, MT::unit()),
            Func {
                name: "discard".into(),
                arity: 1,
                locals: vec![string.clone()],
                ty: MT::Fun(Box::new(string), Box::new(MT::unit())),
                body: Body::Expr(Expr::Const(Value::unit())),
            },
        ],
        exports: [("raw", 0), ("copied", 1), ("freed", 2), ("discarded", 3)]
            .into_iter()
            .map(|(name, function)| (name.into(), function))
            .collect(),
        ..Program::default()
    };
    fwp::ir::check_locals(&program).unwrap();
    let (source, _) = fwp::cgen::generate_library(&program, "raw_memory").unwrap();
    let fresh = "return fwp_rc_fresh(fwp_c_string((const char *)(uintptr_t)l0));";
    assert!(source.contains(fresh));
    let probe = r#"
int main(void) {
 fwp_lib_init();
 V input = fwp_rc_fresh(fwp_str_new("hello",5));
 V raw = f0(input);
 if (*fwp_rc_slot(input) != 1) return 3;
 V copy = f1(raw);
 if (*fwp_rc_slot(copy) != 1) return 4;
 ((char *)(uintptr_t)raw)[0] = 'X';
 f2(raw);
 if (STR(copy)->len != 5 || memcmp(STR(copy)->d,"hello",5)) return 5;
 if (STR(input)->len != 5 || memcmp(STR(input)->d,"hello",5)) return 6;
 double before = fwp_gc.freed;
 f3(copy); f3(input);
 if (!fwp_reuse_verify && fwp_gc.freed <= before) return 7;
 if (fwp_reuse_verify && (STR(copy)->len || STR(input)->len)) return 8;
 return 0;
}


"#;
    let dir = fwp::cgen::TempDir::new("fwp-raw-memory-ownership").unwrap();
    for opt in ["-O1", "-O2"] {
        let executable = dir.join(format!("probe{opt}"));
        fwp::cgen::compile_c(&format!("{source}\n{probe}"), &executable, opt).unwrap();
        for poison in ["0", "1"] {
            let result = Command::new(&executable)
                .env("FWP_REUSE_VERIFY", poison)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .output()
                .unwrap();
            assert!(
                result.status.success(),
                "{opt}/{poison}: {}: {}",
                result.status,
                String::from_utf8_lossy(&result.stderr)
            );
        }
        for (negative, expected) in [
            (
                source.replace(fresh, "return fwp_c_string((const char *)(uintptr_t)l0);"),
                4,
            ),
            (
                source.replace(
                    "    size_t n = STR(l0)->len;",
                    "    fwp_rc_share(l0); size_t n = STR(l0)->len;",
                ),
                3,
            ),
        ] {
            assert_ne!(negative, source);
            let executable = dir.join(format!("control{opt}-{expected}"));
            fwp::cgen::compile_c(&format!("{negative}\n{probe}"), &executable, opt).unwrap();
            let result = Command::new(executable).output().unwrap();
            assert_eq!(
                result.status.code(),
                Some(expected),
                "{}: {}",
                result.status,
                String::from_utf8_lossy(&result.stderr)
            );
        }
    }
}

#[test]
fn pipe_string_copy_matches_raw_interpreter_under_gc_and_reuse_verification() {
    let dir = fwp::cgen::TempDir::new("fwp-raw-memory-pipes").unwrap();
    let source = dir.join("copy.fwp");
    let cfile = dir.join("copy.c");
    std::fs::write(&source, "copy : String -> String ! {Unsafe}\ncopy = mem.string | both ptr.read-string mem.free | .0\nmain = \"hé\" | string.repeat 3 | copy | echo\n").unwrap();
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
    assert_eq!(reference.stdout, "héhéhé\n".as_bytes());
    assert!(reference.stderr.is_empty());
    let generated = Command::new(fwp)
        .arg("build")
        .arg(&source)
        .args(["--emit-c", "-o"])
        .arg(&cfile)
        .output()
        .unwrap();
    assert!(
        generated.status.success(),
        "{}",
        String::from_utf8_lossy(&generated.stderr)
    );
    let code = std::fs::read_to_string(cfile).unwrap();
    for opt in ["-O1", "-O2"] {
        let executable = dir.join(format!("copy{opt}"));
        fwp::cgen::compile_c(&code, &executable, opt).unwrap();
        for poison in ["0", "1"] {
            let result = Command::new(&executable)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", poison)
                .output()
                .unwrap();
            assert_eq!(result.status.code(), reference.status.code());
            assert_eq!(result.stdout, reference.stdout);
            assert_eq!(result.stderr, reference.stderr);
        }
    }
}
