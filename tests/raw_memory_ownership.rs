//! Raw buffers are manually freed; string conversions copy managed leaves.
use fwp::ffi_interp::pointer_prim;
use fwp::ir::*;
use fwp::value::Value;
use std::process::Command;

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
