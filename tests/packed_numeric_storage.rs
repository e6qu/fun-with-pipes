//! Actual generated numeric storage, immutable slices and ownership boundaries.
use std::path::{Path, PathBuf};
use std::process::{Command, Output};

struct Scratch(PathBuf);
impl Scratch {
    fn new(name: &str) -> Self {
        let path = std::env::temp_dir().join(format!("fwp-packed-{}-{name}", std::process::id()));
        std::fs::create_dir(&path).unwrap();
        Self(path)
    }
}
impl Drop for Scratch {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}
fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(
        output.status.success(),
        "{command:?}: {:?}: {}",
        output.status.code(),
        String::from_utf8_lossy(&output.stderr)
    );
    output
}
fn fixture(name: &str) -> PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR"))
        .join("tests/fixtures")
        .join(name)
}
fn emitted(scratch: &Scratch, fixture_name: &str, function: &str, packing: &str) -> String {
    let path = scratch.0.join(format!("{function}-{packing}.c"));
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env_remove("FWP_NO_OPT")
            .env_remove("FWP_TYPED_ABI")
            .env("FWP_REUSE", "1")
            .env("FWP_PACKED_ARRAYS", packing)
            .args(["build", "--gc", "tracing", "--fn", function, "--emit-c"])
            .arg(fixture(fixture_name))
            .arg("-o")
            .arg(&path),
    );
    std::fs::read_to_string(path).unwrap()
}
fn function_id<'a>(source: &'a str, name: &str) -> &'a str {
    let start = source.find(&format!("/* {name} :")).unwrap();
    source[start..]
        .split("static V f")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap()
}
fn native_probe(scratch: &Scratch, name: &str, source: &str, opt: &str, stress: &str) -> Output {
    let path = scratch.0.join(format!("{name}{}", &opt[1..]));
    fwp::cgen::compile_c(source, &path, opt).unwrap();
    Command::new(path)
        .env("FWP_GC_STRESS", stress)
        .env("FWP_GC_VERIFY", "1")
        .env("FWP_REUSE_VERIFY", "0")
        .output()
        .unwrap()
}
fn instrument_allocators(source: &str) -> String {
    source.replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic uint64_t measured_calls,measured_bytes;")
        .replace("static inline void *fwp_gc_alloc(size_t n, int leaf) {", "static inline void *fwp_gc_alloc(size_t n, int leaf) {\n    if (leaf != 0) { measured_calls++; measured_bytes+=n; }")
        .replace("static inline void *fwp_alloc_init(size_t n) {", "static inline void *fwp_alloc_init(size_t n) {\n    measured_calls++; measured_bytes+=n;")
}

#[test]
fn immutable_numeric_operations_agree_with_raw_interpreter() {
    let scratch = Scratch::new("semantics");
    let source = fixture("packed_numeric_arrays.fwp");
    let reference = checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    for packing in ["0", "1"] {
        for reuse in ["0", "1"] {
            for opt in ["-O1", "-O2"] {
                let path = scratch
                    .0
                    .join(format!("packed-{packing}-{reuse}{}", &opt[1..]));
                checked(
                    Command::new(env!("CARGO_BIN_EXE_fwp"))
                        .env_remove("FWP_NO_OPT")
                        .env("FWP_PACKED_ARRAYS", packing)
                        .env("FWP_REUSE", reuse)
                        .args(["build", "--gc", "tracing", opt])
                        .arg(&source)
                        .arg("-o")
                        .arg(&path),
                );
                let output = checked(
                    Command::new(path)
                        .env("FWP_GC_STRESS", "1")
                        .env("FWP_GC_VERIFY", "1")
                        .env("FWP_REUSE_VERIFY", "1"),
                );
                assert_eq!(output.stdout, reference.stdout, "{packing} {reuse} {opt}");
                assert_eq!(output.stderr, reference.stderr, "{packing} {reuse} {opt}");
            }
        }
    }
}

#[test]
fn views_retain_backing_and_small_copies_release_it_without_collection() {
    let scratch = Scratch::new("memory");
    for packing in ["0", "1"] {
        let mut source = emitted(&scratch, "packed_numeric_arrays.fwp", "sliced", packing);
        let mut probe = include_str!("fixtures/packed_array_memory_probe.c").to_string();
        for name in ["compact-nested", "compact", "sliced", "nested", "empty"] {
            probe = probe.replace(
                &format!("f{}", name.to_uppercase().replace('-', "_")),
                &format!("f{}", function_id(&source, name)),
            );
        }
        let at = source
            .find("/* Array[I8] */\nstatic void fwp_drop")
            .unwrap();
        let drop = source[at..]
            .split("static void ")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap();
        probe = probe.replace("fARRAY_DROP", drop);
        source = instrument_allocators(&source).replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        );
        source.push_str(&probe);
        for opt in ["-O1", "-O2"] {
            let output = native_probe(&scratch, &format!("memory-{packing}"), &source, opt, "0");
            assert_eq!(
                output.status.code(),
                Some(0),
                "{packing} {opt}: {}",
                String::from_utf8_lossy(&output.stderr)
            );
            if packing == "1" {
                for (name, old, new, expected) in [
                    ("retain", "fwp_rc_dup(owner);", "(void)owner;", 135),
                    ("drop", "v = owner; continue;", "return;", 143),
                    ("counter", "static inline void *fwp_alloc_init(size_t n) {\n    measured_calls++; measured_bytes+=n;", "static inline void *fwp_alloc_init(size_t n) {\n    (void)n;", 141),
                ] {
                    assert!(source.contains(old));
                    let output = native_probe(&scratch, name, &source.replace(old, new), opt, "0");
                    assert_eq!(output.status.code(), Some(expected), "{name} {opt}: {}", String::from_utf8_lossy(&output.stderr));
                }
            }
        }
    }
}

#[test]
fn generated_arrays_have_natural_width_alignment_and_exact_bits() {
    let scratch = Scratch::new("bytes");
    let source = emitted(&scratch, "numeric_layout_baseline.fwp", "step", "1");
    let probe = include_str!("fixtures/numeric_layout_probe.c")
        .replace("fSTEP", &format!("f{}", function_id(&source, "step")));
    let source = source.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    ) + &probe;
    for opt in ["-O1", "-O2"] {
        let output = native_probe(&scratch, "bytes", &source, opt, "1");
        assert_eq!(
            output.status.code(),
            Some(0),
            "{opt}: {}",
            String::from_utf8_lossy(&output.stderr)
        );
    }
}

#[test]
fn typed_float_worker_bridges_preserve_zero_and_nan_payloads() {
    let scratch = Scratch::new("abi");
    for (function, ctype, width, words) in [
        (
            "bits64",
            "double",
            8,
            [
                0u64,
                0x8000000000000000,
                0x7ff8000000001234,
                0x7ff0000000001234,
            ],
        ),
        (
            "bits32",
            "float",
            4,
            [0u64, 0x80000000, 0x7fc01234, 0x7f801234],
        ),
    ] {
        let source = emitted(&scratch, "numeric_layout_baseline.fwp", function, "1");
        let id = function_id(&source, function);
        let bits = words.map(|word| format!("UINT64_C({word})")).join(",");
        let probe = format!(
            r#"
_Static_assert(sizeof(fwp_wr{id})==3*{width},"natural aggregate width");
_Static_assert(_Generic(((fwp_wr{id}*)0)->f0,{ctype}:1,default:0),"native field type");
int main(void) {{
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    const V bits[]={{{bits}}};
    for(size_t j=0;j<4;j++) {{ V r=f{id}(bits[j]);
        for(size_t k=0;k<3;k++)if(OBJ(r)->f[k]!=bits[j])return 130;
        if(!fwp_rc_release_last(r))return 131;fwp_rc_free_obj(r);
    }}return 0;
}}
"#
        );
        let source = source.replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        ) + &probe;
        for opt in ["-O1", "-O2"] {
            let output = native_probe(&scratch, function, &source, opt, "1");
            assert_eq!(
                output.status.code(),
                Some(0),
                "{function} {opt}: {}",
                String::from_utf8_lossy(&output.stderr)
            );
        }
    }
}

#[test]
fn binary_decode_accepts_empty_records_and_checks_counts_before_allocation() {
    let scratch = Scratch::new("decode");
    for packing in ["0", "1"] {
        let source = instrument_allocators(&emitted(
            &scratch,
            "numeric_layout_baseline.fwp",
            "step",
            packing,
        ))
        .replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        ) + include_str!("fixtures/protocol_count_probe.c");
        for opt in ["-O1", "-O2"] {
            let output = native_probe(&scratch, &format!("decode-{packing}"), &source, opt, "1");
            assert_eq!(
                output.status.code(),
                Some(0),
                "{packing} {opt}: {}",
                String::from_utf8_lossy(&output.stderr)
            );
            if packing == "1" {
                for (name, old, new, expected) in [
                    (
                        "empty-wire",
                        "if(fwp_wire_empty_inner(elem,0))return !unique || *count<=1;",
                        "(void)unique;",
                        154,
                    ),
                    (
                        "count-bound",
                        "*count>(SIZE_MAX-sizeof(fwp_arr))/sizeof(V)",
                        "0",
                        155,
                    ),
                ] {
                    assert!(source.contains(old));
                    let output = native_probe(&scratch, name, &source.replace(old, new), opt, "1");
                    assert_eq!(
                        output.status.code(),
                        Some(expected),
                        "{name} {opt}: {}",
                        String::from_utf8_lossy(&output.stderr)
                    );
                }
            }
        }
    }
}
