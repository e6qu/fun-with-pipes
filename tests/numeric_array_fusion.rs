//! Actual numeric Array fusion, trap order, raw semantics and allocation controls.
use std::process::{Command, Output};
fn checked(command: &mut Command) -> Output {
    let out = command.output().unwrap();
    assert!(
        out.status.success(),
        "{command:?}: status={} stdout={} stderr={}",
        out.status,
        String::from_utf8_lossy(&out.stdout),
        String::from_utf8_lossy(&out.stderr)
    );
    out
}

#[test]
fn generated_numeric_fold_removes_the_array_allocation() {
    let directory = fwp::cgen::TempDir::new("fwp-generated-fold").unwrap();
    let input = directory.join("generated.fwp");
    std::fs::write(&input, include_str!("fixtures/generated_array_folds.fwp")).unwrap();
    for packing in ["0", "1"] {
        for mode in ["0", "1"] {
            let cfile = directory.join(format!("generated-{packing}-{mode}.c"));
            checked(
                Command::new(env!("CARGO_BIN_EXE_fwp"))
                    .env_remove("FWP_NO_OPT")
                    .env("FWP_PACKED_ARRAYS", packing)
                    .env("FWP_ARRAY_FUSION", mode)
                    .args(["build", "--fn", "generated-sum", "--emit-c"])
                    .arg(&input)
                    .arg("-o")
                    .arg(&cfile),
            );
            let source = std::fs::read_to_string(&cfile).unwrap();
            let start = source.find("/* generated-sum :").unwrap();
            let id = source[start..]
                .split("static V f")
                .nth(1)
                .unwrap()
                .split('(')
                .next()
                .unwrap();
            let probe = include_str!("fixtures/generated_array_fold_probe.c")
                .replace("fGENERATED", &format!("f{id}"))
                .replace("FUSED", mode);
            let mut code = source.replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic uint64_t measured_calls,measured_bytes,measured_retains;")
                .replace("int main(int argc, char **argv)", "int original_main(int argc, char **argv)");
            for (old,new) in [
                ("static inline void *fwp_heap_alloc(size_t n, int kind) {", "static inline void *fwp_heap_alloc(size_t n, int kind) {\nif(kind!=0){measured_calls++;measured_bytes+=n;}"),
                ("static inline void *fwp_alloc_init(size_t n) {", "static inline void *fwp_alloc_init(size_t n) {\nmeasured_calls++;measured_bytes+=n;"),
                ("static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) {", "static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) {\nmeasured_retains++;"),
            ] {
                assert_eq!(code.matches(old).count(),1);
                code=code.replace(old,new);
            }
            for opt in ["-O1", "-O2"] {
                let binary = directory.join(format!("generated-{packing}-{mode}{opt}.bin"));
                let measured = format!("{code}\n{probe}");
                fwp::cgen::compile_c(&measured, &binary, opt).unwrap();
                let result = checked(&mut Command::new(&binary));
                assert_eq!(String::from_utf8_lossy(&result.stdout).lines().count(), 6);
                if let Some(destination) = std::env::var_os("FWP_ARRAY_FUSION_ARTIFACTS") {
                    let destination = std::path::PathBuf::from(destination);
                    std::fs::create_dir_all(&destination).unwrap();
                    let prefix = destination.join(format!("generated-{packing}-{mode}{opt}"));
                    std::fs::write(prefix.with_extension("original.c"), &source).unwrap();
                    std::fs::write(prefix.with_extension("measured.c"), &measured).unwrap();
                    std::fs::write(prefix.with_extension("jsonl"), result.stdout).unwrap();
                    std::fs::copy(&binary, prefix.with_extension("bin")).unwrap();
                }
                if mode == "1" {
                    // A deliberately retained allocation must invalidate the
                    // zero-allocation claim even when the numeric result agrees.
                    let negative = probe.replace(
                        "        V result=",
                        "        (void)fwp_rc_fresh(fwp_arr_new(1));\n        V result=",
                    );
                    assert_ne!(negative, probe);
                    let binary =
                        directory.join(format!("unexpected-allocation-{packing}{opt}.bin"));
                    fwp::cgen::compile_c(&format!("{code}\n{negative}"), &binary, opt).unwrap();
                    assert_eq!(Command::new(&binary).status().unwrap().code(), Some(171));
                }
            }
        }
    }
}
#[test]
fn numeric_array_fusion_preserves_effects_checked_traps_and_raw_semantics() {
    let directory =
        std::env::temp_dir().join(format!("fwp-array-fusion-semantics-{}", std::process::id()));
    std::fs::create_dir(&directory).unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let basic = include_str!("fixtures/numeric_array_fusion.fwp");
    let cases=[
      ("numeric",basic,0),
      ("generated",include_str!("fixtures/generated_array_folds.fwp"),0),
      ("generated-effect-order","main = array.generate 3 (tap echo) | array.fold add 9223372036854775807 | echo\n",101),
      ("generated-distinct-traps","main = array.generate 3 (add 9223372036854775806) | array.fold div 0 | echo\n",101),
      ("generated-size","main = array.generate 2305843009213693952 id | array.fold add 0 | echo\n",101),
      ("generated-eager-arguments","main = array.generate (() | const 0 | tap (const \"count\" | echo)) (add (() | const 1 | tap (const \"capture\" | echo))) | array.fold add (() | const 0 | tap (const \"seed\" | echo)) | echo\n",0),
      ("generated-reused","main = array.generate 4 id | both array.to-list (array.fold add 0) | echo\n",0),
      ("generated-unknown","unknown : (I64 -> I64 -> I64) -> Array[I64] -> I64\nunknown = flip array.fold 0\nmain = array.generate 4 id | unknown (() | read-line | if (eq None) (const sub) (const add)) | echo\n",0),
      ("effect-order","main = [1i8, 2i8] | array.from-list | array.map (tap echo) | array.fold add 127i8 | echo\n",101),
      ("distinct-traps","main = [0, 9223372036854775807] | array.from-list | array.map (add 1) | array.fold div 0 | echo\n",101),
      ("length-overflow","main = [127i8] | array.from-list | array.map (add 1i8) | array.length | echo\n",101),
      ("owned-map-lookup","main = map.empty | map.insert \"values\" ([1, 2, 3] | array.from-list) | map.get \"values\" | option.unwrap-or ([] | array.from-list) | array.to-list | echo\n",0),
      ("recursive-callback","descend : I64 -> I64\nrec descend = if (le 0) id (sub 1 | descend)\nmain = [3, 2] | array.from-list | array.map descend | array.fold add 0 | echo\n",0),
    ];
    for (label, source, status) in cases {
        let input = directory.join(format!("{label}.fwp"));
        std::fs::write(&input, source).unwrap();
        let reference = Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input)
            .output()
            .unwrap();
        assert_eq!(
            reference.status.code(),
            Some(status),
            "{label}: {}",
            String::from_utf8_lossy(&reference.stderr)
        );
        if label == "effect-order" {
            assert_eq!(reference.stdout, b"1\n2\n");
        }
        if label == "generated-effect-order" {
            assert_eq!(reference.stdout, b"0\n1\n2\n");
        }
        if label == "generated" {
            assert_eq!(reference.stdout, b"0\n0\n6\n10\n6\n");
        }
        if label == "generated-size" {
            assert!(String::from_utf8_lossy(&reference.stderr).contains("array too large"));
        }
        if matches!(label, "distinct-traps" | "generated-distinct-traps") {
            assert!(
                String::from_utf8_lossy(&reference.stderr).contains("arithmetic overflow in I64")
            );
        }
        let optimized = Command::new(fwp)
            .env_remove("FWP_NO_OPT")
            .env("FWP_ARRAY_FUSION", "1")
            .args(["run", "--interp"])
            .arg(&input)
            .output()
            .unwrap();
        assert_eq!(
            (
                optimized.status.code(),
                &optimized.stdout,
                &optimized.stderr
            ),
            (
                reference.status.code(),
                &reference.stdout,
                &reference.stderr
            ),
            "{label}: optimized interpreter"
        );
        for mode in ["0", "1"] {
            for opt in ["-O1", "-O2"] {
                let binary = directory.join(format!("{label}-{mode}{}", &opt[1..]));
                checked(
                    Command::new(fwp)
                        .env_remove("FWP_NO_OPT")
                        .env("FWP_ARRAY_FUSION", mode)
                        .args(["build", opt])
                        .arg(&input)
                        .arg("-o")
                        .arg(&binary),
                );
                let actual = Command::new(&binary).output().unwrap();
                assert_eq!(
                    (&actual.stdout, &actual.stderr, actual.status.code()),
                    (
                        &reference.stdout,
                        &reference.stderr,
                        reference.status.code()
                    ),
                    "{label} {mode} {opt}"
                );
            }
        }
    }
    std::fs::remove_dir_all(directory).unwrap();
}
#[test]
fn numeric_array_fusion_eliminates_intermediates_and_reclaims_inputs() {
    let directory = std::env::temp_dir().join(format!(
        "fwp-array-fusion-allocation-{}",
        std::process::id()
    ));
    std::fs::create_dir(&directory).unwrap();
    let input = directory.join("numeric.fwp");
    std::fs::write(&input, include_str!("fixtures/numeric_array_fusion.fwp")).unwrap();
    let mut results = Vec::new();
    for mode in ["0", "1"] {
        let cfile = directory.join(format!("mode-{mode}.c"));
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .env_remove("FWP_NO_OPT")
                .env("FWP_ARRAY_FUSION", mode)
                .args(["build", "--fn", "reduce64", "--emit-c"])
                .arg(&input)
                .arg("-o")
                .arg(&cfile),
        );
        let source = std::fs::read_to_string(&cfile).unwrap();
        let start = source.find("/* reduce64 :").unwrap();
        let id = source[start..]
            .split("static V f")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap();
        let probe = include_str!("fixtures/array_fusion_allocation_probe.c")
            .replace("fREDUCE64", &format!("f{id}"))
            .replace("FUSED", mode);
        assert!(source.contains("static inline void *fwp_heap_alloc(size_t n, int kind) {"));
        assert!(source.contains("static inline void *fwp_alloc_init(size_t n) {"));
        assert_eq!(source.matches("static void fwp_cleanup_push(fwp_cleanup *c, void (*release)(void *), void *arg) {").count(), 1);
        let code=source.replace("typedef uint64_t V;","typedef uint64_t V;\nstatic uint64_t measured_calls,measured_bytes,measured_retains,measured_scopes;")
          .replace("static inline void *fwp_heap_alloc(size_t n, int kind) {","static inline void *fwp_heap_alloc(size_t n, int kind) {\nif(kind!=0){measured_calls++;measured_bytes+=n;}")
          .replace("static inline void *fwp_alloc_init(size_t n) {","static inline void *fwp_alloc_init(size_t n) {\nmeasured_calls++;measured_bytes+=n;")
          .replace("static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) {", "static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) {\n        measured_retains++;")
          .replace("static void fwp_cleanup_push(fwp_cleanup *c, void (*release)(void *), void *arg) {", "static void fwp_cleanup_push(fwp_cleanup *c, void (*release)(void *), void *arg) {\nmeasured_scopes++;")
          .replace("int main(int argc, char **argv)","int original_main(int argc, char **argv)");
        if let Some(destination) = std::env::var_os("FWP_ARRAY_FUSION_ARTIFACTS") {
            let destination = std::path::PathBuf::from(destination);
            std::fs::create_dir_all(&destination).unwrap();
            std::fs::write(destination.join(format!("original-{mode}.c")), &source).unwrap();
            std::fs::write(
                destination.join(format!("measured-{mode}.c")),
                format!("{code}\n{probe}"),
            )
            .unwrap();
        }
        for opt in ["-O1", "-O2"] {
            let executable = directory.join(format!("profile-{mode}{}", &opt[1..]));
            fwp::cgen::compile_c(&format!("{code}\n{probe}"), &executable, opt).unwrap();
            let out = checked(&mut Command::new(&executable));
            if let Some(destination) = std::env::var_os("FWP_ARRAY_FUSION_ARTIFACTS") {
                let destination = std::path::PathBuf::from(destination);
                std::fs::create_dir_all(&destination).unwrap();
                std::fs::write(
                    destination.join(format!("permanent-{mode}{opt}.json")),
                    &out.stdout,
                )
                .unwrap();
                if opt == "-O2" {
                    let mut disasm = if cfg!(target_os = "macos") {
                        let mut c = Command::new("otool");
                        c.arg("-tvV");
                        c
                    } else {
                        let mut c = Command::new("objdump");
                        c.arg("-d");
                        c
                    };
                    let assembly = checked(disasm.arg(&executable));
                    std::fs::write(
                        destination.join(format!("production-{mode}.asm")),
                        assembly.stdout,
                    )
                    .unwrap();
                }
            }
            let report = fwp::json::Json::parse(std::str::from_utf8(&out.stdout).unwrap()).unwrap();
            let Some(fwp::json::Json::Arr(cases)) = report.get("cases") else {
                panic!("missing measured cases");
            };
            let bits: Vec<_> = cases
                .iter()
                .map(|case| {
                    let bits = case.get("resultBits").unwrap().as_str().unwrap();
                    let word = u64::from_str_radix(bits, 16).unwrap();
                    let value = f64::from_bits(word);
                    // Arithmetic NaN payload/sign choice is compiler dependent;
                    // recorded payloads remain intact, and every other bit is exact.
                    let compared = if value.is_nan() {
                        assert_ne!(word & (1u64 << 51), 0);
                        "quiet-nan".to_string()
                    } else {
                        bits.to_string()
                    };
                    (case.get("elements").unwrap().clone(), compared)
                })
                .collect();
            results.push(bits);
        }
    }
    assert!(
        results.windows(2).all(|pair| pair[0] == pair[1]),
        "Finite result bits or NaN classification changed: {results:?}"
    );
    std::fs::remove_dir_all(directory).unwrap();
}
