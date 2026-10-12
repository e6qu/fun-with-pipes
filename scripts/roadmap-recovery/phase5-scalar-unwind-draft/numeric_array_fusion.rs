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
fn numeric_array_fusion_preserves_effects_checked_traps_and_raw_semantics() {
    let directory =
        std::env::temp_dir().join(format!("fwp-array-fusion-semantics-{}", std::process::id()));
    std::fs::create_dir(&directory).unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let basic = include_str!("fixtures/numeric_array_fusion.fwp");
    let cases=[
      ("numeric",basic,0),
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
        if label == "distinct-traps" {
            assert!(
                String::from_utf8_lossy(&reference.stderr).contains("arithmetic overflow in I64")
            );
        }
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
                let actual = Command::new(&binary)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", "1")
                    .output()
                    .unwrap();
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
        assert!(source.contains("static inline void *fwp_gc_alloc(size_t n, int leaf) {"));
        assert!(source.contains("static inline void *fwp_alloc_init(size_t n) {"));
        assert_eq!(source.matches("static void fwp_cleanup_push(fwp_cleanup *c, void (*release)(void *), void *arg) {").count(), 1);
        let code=source.replace("typedef uint64_t V;","typedef uint64_t V;\nstatic uint64_t measured_calls,measured_bytes,measured_retains,measured_scopes;")
          .replace("static inline void *fwp_gc_alloc(size_t n, int leaf) {","static inline void *fwp_gc_alloc(size_t n, int leaf) {\nif(leaf!=0){measured_calls++;measured_bytes+=n;}")
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
            let out = checked(
                Command::new(&executable)
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", "0"),
            );
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
