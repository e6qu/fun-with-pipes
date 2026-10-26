//! Declared precision must survive the interpreter, C ABI, text and wire paths.
use std::process::Command;

#[path = "support/record_probe.rs"]
mod record_probe;

#[test]
fn canonical_float_text_preserves_values_and_output_order() {
    let directory = fwp::cgen::TempDir::new("float-text-program").unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let input =
        std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/fixtures/float_text.fwp");
    let reference = Command::new(compiler)
        .env("FWP_NO_OPT", "1")
        .args(["run", "--interp"])
        .arg(&input)
        .output()
        .unwrap();
    assert!(reference.status.success(), "{reference:?}");
    assert!(reference.stderr.is_empty(), "{reference:?}");
    {
        let cfile = directory.join("text.c");
        let emitted = Command::new(compiler)
            .env_remove("FWP_NO_OPT")
            .env("FWP_LTO", "0")
            .env("FWP_STACK", "1")
            .args(["build", "--memory", "dynamic", "--emit-c", "-O2"])
            .arg(&input)
            .arg("-o")
            .arg(&cfile)
            .output()
            .unwrap();
        assert!(emitted.status.success(), "counted: {emitted:?}");
        let code = std::fs::read_to_string(cfile).unwrap();
        for opt in ["-O1", "-O2"] {
            let executable = directory.join("text.exe");
            fwp::cgen::compile_c(&code, &executable, opt).unwrap();
            let actual = Command::new(&executable).output().unwrap();
            record_probe::save(
                "float_formats",
                &format!("program{opt}"),
                &code,
                &executable,
                &actual,
            );
            assert_eq!(
                (&actual.stdout, &actual.stderr, actual.status.code()),
                (
                    &reference.stdout,
                    &reference.stderr,
                    reference.status.code()
                ),
                "{opt}"
            );
        }
    }
}

#[test]
fn float_text_matches_frozen_precision_and_detects_corruption() {
    let directory = fwp::cgen::TempDir::new("float-text-precision").unwrap();
    let input = directory.join("main.fwp");
    std::fs::write(&input, "main = 0.1 | echo\n").unwrap();
    let cfile = directory.join("main.c");
    let emitted = Command::new(env!("CARGO_BIN_EXE_fwp"))
        .env_remove("FWP_NO_OPT")
        .env("FWP_LTO", "0")
        .args(["build", "--memory", "dynamic", "--emit-c", "-O2"])
        .arg(&input)
        .arg("-o")
        .arg(&cfile)
        .output()
        .unwrap();
    assert!(emitted.status.success(), "{emitted:?}");
    let generated = std::fs::read_to_string(cfile).unwrap();
    assert_eq!(
        generated.matches("int main(int argc, char **argv)").count(),
        1
    );
    let generated = generated.replace(
        "int main(int argc, char **argv)",
        "int saved_main(int argc, char **argv)",
    );
    let mut failures = Vec::new();
    for opt in ["-O1", "-O2"] {
        for (label, control, status) in [
            ("checked", 0, 0),
            ("changed-digit", 1, 77),
            ("changed-boundary", 2, 78),
        ] {
            let code = format!("{generated}\n{}\n#define FORMAT_CONTROL {control}\n#define FORMAT_SAMPLES 4096\n{}",
                include_str!("fixtures/float_text_baseline.c"), include_str!("fixtures/float_text_probe.c"));
            let executable = directory.join("probe.exe");
            fwp::cgen::compile_c(&code, &executable, opt).unwrap();
            let actual = Command::new(&executable).output().unwrap();
            record_probe::save(
                "float_formats",
                &format!("precision-{label}{opt}"),
                &code,
                &executable,
                &actual,
            );
            let text = std::str::from_utf8(&actual.stdout);
            let summary_ok = text.is_ok_and(|text| {
                let lines: Vec<_> = text.lines().collect();
                matches!(lines.as_slice(), [line]
                    if line.starts_with("float-text values=119768 precisions=")
                    && (status != 0 || line.ends_with("mismatches=0 bounds=0")))
            });
            if actual.status.code() != Some(status)
                || !summary_ok
                || (status == 0 && !actual.stderr.is_empty())
            {
                failures.push(format!("{label} {opt}: {actual:?}"));
            }
        }
    }
    assert!(failures.is_empty(), "{}", failures.join("\n"));
}

#[test]
fn declared_formats_agree_in_raw_and_native_execution() {
    let directory = fwp::cgen::TempDir::new("fwp-float-formats").unwrap();
    let source = directory.join("formats.fwp");
    std::fs::write(&source, r#"
quad-half : F128 -> F16
quad-half = float.convert
read-wide : String -> Result[F128, String]
read-wide = json.read
input : () -> F128 ! {IO}
input = const "FWP_FLOAT_INPUT" | env.get | option.unwrap-or "4" | parse-float | option.unwrap-or 4.0f128
values : F128 -> Array[F128]
values = fork array.make (const 8) id
get-first : Array[F128] -> F128
get-first = array.get 0 | option.unwrap-or 0.0f128
read-array : String -> Result[Array[F128], String]
read-array = json.read
main = [
    1.0001f16 | eq 1.0f16 | echo,
    1.001bf16 | eq 1.0bf16 | echo,
    9007199254740993.0f128 | gt 9007199254740992.0f128 | echo,
    1.0004882812500000000000000000000002f128 | quad-half | gt 1.0f16 | echo,
    "1e400" | parse-float | option.unwrap-or 0.0f128 | ln | gt 900.0f128 | echo,
    1.0000000000000000000000000000000002f128 | ln | gt 0.0f128 | echo,
    7.0f128 | rem 4.0f128 | eq 3.0f128 | echo,
    -2.5f16 | round | eq -3.0f16 | echo,
    1.0e-40bf16 | gt 0.0bf16 | echo,
    1.0000000000000000000000000000000002f128 | json.write | read-wide | result.unwrap-or 0.0f128 | gt 1.0f128 | echo,
    [1.0001f16, 2.0f16] | array.from-list | array.to-list | head | eq (Some 1.0f16) | echo,
    () | input | values | get-first | eq 4.0f128 | echo,
    () | input | values | array.to-list | head | eq (Some 4.0f128) | echo,
    () | input | values | array.slice 2 4 | get-first | eq 4.0f128 | echo,
    () | input | values | array.map (add 1.0f128) | array.fold add 0.0f128 | eq 40.0f128 | echo,
    () | input | values | array.set 0 9.0f128 | option.map get-first | eq (Some 9.0f128) | echo,
    () | input | values | array.push 1.0f128 | array.sort | get-first | eq 1.0f128 | echo,
    () | input | values | json.write | read-array | result.map get-first | eq (Ok 4.0f128) | echo,
] | ignore
"#).unwrap();
    let expected = "True\n".repeat(18).into_bytes();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let raw = Command::new(fwp)
        .env("FWP_NO_OPT", "1")
        .env("FWP_FLOAT_INPUT", "4")
        .args(["run", "--interp"])
        .arg(&source)
        .output()
        .unwrap();
    assert!(raw.status.success(), "{raw:?}");
    assert_eq!(raw.stdout, expected, "{raw:?}");
    assert!(raw.stderr.is_empty(), "{raw:?}");
    for opt in ["-O1", "-O2"] {
        let binary = directory.join(format!("formats-{}", &opt[1..]));
        let built = Command::new(fwp)
            .env_remove("FWP_NO_OPT")
            .env("FWP_CACHE_DIR", directory.join("cache"))
            .args(["build", opt])
            .arg(&source)
            .arg("-o")
            .arg(&binary)
            .output()
            .unwrap();
        assert!(built.status.success(), "{built:?}");
        let native = Command::new(&binary)
            .env("FWP_FLOAT_INPUT", "4")
            .output()
            .unwrap();
        assert!(native.status.success(), "{native:?}");
        assert!(native.stderr.is_empty(), "{native:?}");
        assert_eq!(native.stdout, expected, "{native:?}");
    }
}

#[test]
fn quad_array_bytes_and_escaping_owners_are_independent() {
    let directory = fwp::cgen::TempDir::new("fwp-quad-array-bits").unwrap();
    let path = directory.join("quad.fwp");
    std::fs::write(
        &path,
        "export quad : F128 -> Array[F128]\nquad = array.make 8\n",
    )
    .unwrap();
    let c = directory.join("quad.c");
    let output = Command::new(env!("CARGO_BIN_EXE_fwp"))
        .args(["build", "--fn", "quad", "--emit-c"])
        .arg(&path)
        .arg("-o")
        .arg(&c)
        .output()
        .unwrap();
    assert!(output.status.success(), "{output:?}");
    let source = std::fs::read_to_string(&c).unwrap().replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let probe = r#"
static void quad_drop(V v) { if (fwp_rc_release_last(v)) fwp_rc_free_obj(v); }
int main(void) {
    fwp_heap_start(); fwp_fns=fwp_fn_table; fwp_init_consts();
    const fwp_desc quad={.kind=K_F128,.dup=fwp_rc_dup,.drop=quad_drop};
    const float128_t words[]={{{1,0}},{{0,UINT64_C(0x8000000000000000)}},
        {{UINT64_C(0x1234),UINT64_C(0x7fff800000000000)}}};
    V a=fwp_array_typed_new(3,&quad);
    if(fwp_array_stride(&quad)!=16 || (uintptr_t)fwp_array_data(a)%8) return 180;
    for(size_t i=0;i<3;i++) fwp_array_store(a,i,PTR(&words[i]),&quad);
    if(memcmp(fwp_array_data(a),words,sizeof words)) return 181;
    V saved=fwp_array_retain(fwp_array_load(a,2,&quad),fwp_rc_dup,&quad);
    if(saved>=a && saved<a+sizeof(fwp_arr)+sizeof words) return 182;
    V original=saved;
    fwp_rc_free_arr(a);
    float128_t value=fwp_f128(saved);
    if(memcmp(&value,&words[2],16)) return 183;
    if(!fwp_rc_slot(saved) || *fwp_rc_slot(saved)!=1) return 184;
    quad_drop(saved);
    FWP_KEEP_ALIVE(original);
    return 0;
}
"#;
    let source = source + probe;
    for (name, code, expected) in [
        ("owned", source.clone(), 0),
        (
            "missing-copy",
            source.replace("return fwp_box_f128(fwp_f128(value));", "return value;"),
            182,
        ),
    ] {
        let binary = directory.join(name);
        fwp::cgen::compile_c(&code, &binary, "-O2").unwrap();
        let output = Command::new(binary).output().unwrap();
        assert_eq!(output.status.code(), Some(expected), "{name}: {output:?}");
    }
}
