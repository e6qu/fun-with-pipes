//! C interop: foreign C functions from user C code (`--link`) in the
//! interpreter and natively, and fwp code built as C libraries used from
//! Rust (static library) and C (shared library through the generated
//! header).

use std::alloc::{GlobalAlloc, Layout, System};
use std::cell::Cell;
use std::path::{Path, PathBuf};
use std::process::Command;

fn fwp() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_fwp"))
}

fn dir() -> PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/c-interop")
}

fn have(tool: &str) -> bool {
    Command::new(tool).arg("--version").output().is_ok()
}

fn cc() -> String {
    std::env::var("CC").unwrap_or_else(|_| "cc".into())
}

fn stdout(mut cmd: Command) -> String {
    let out = cmd.output().unwrap();
    assert!(
        out.status.success(),
        "{:?} failed:\n{}{}",
        cmd,
        String::from_utf8_lossy(&out.stdout),
        String::from_utf8_lossy(&out.stderr)
    );
    String::from_utf8_lossy(&out.stdout).into_owned()
}

fn scratch(name: &str) -> PathBuf {
    let d = std::env::temp_dir().join(format!("fwp-ffi-test-{}-{}", std::process::id(), name));
    let _ = std::fs::remove_dir_all(&d);
    std::fs::create_dir_all(&d).unwrap();
    d
}

fn retain_interop(dir: &Path, kind: &str, output: &str) {
    if let Some(root) = std::env::var_os("FWP_LIBRARY_RESULT_ARTIFACTS") {
        let artifacts = PathBuf::from(root).join("interop").join(kind);
        std::fs::create_dir_all(&artifacts).unwrap();
        for entry in std::fs::read_dir(dir).unwrap() {
            let entry = entry.unwrap();
            if entry.file_type().unwrap().is_file() {
                std::fs::copy(entry.path(), artifacts.join(entry.file_name())).unwrap();
            }
        }
        std::fs::write(artifacts.join("host.stdout"), output).unwrap();
    }
}

const VEC_OUT: &str = "Vec2 {x = 11.0, y = 22.0}
11.0
63
10.5
[\"ok\", \"error\"]
[True, False]
";

#[test]
fn foreign_functions_interpreted() {
    if !have(&cc()) {
        return;
    }
    let mut cmd = Command::new(fwp());
    cmd.args(["run", "--interp", "--link"])
        .arg(dir().join("vec.c"))
        .arg(dir().join("vec.fwp"));
    assert_eq!(stdout(cmd), VEC_OUT);
}

#[test]
fn foreign_bridges_compile_before_program_effects() {
    let scratch = fwp::cgen::TempDir::new("ffi-compile-phase").unwrap();
    let probe = scratch.join("compiler.exe");
    let compiled = Command::new("rustc")
        .args(["--edition", "2021"])
        .arg(Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/fixtures/ffi_compiler_phase.rs"))
        .arg("-o")
        .arg(&probe)
        .output()
        .unwrap();
    assert!(compiled.status.success(), "{compiled:?}");
    let input = scratch.join("main.fwp");
    std::fs::write(
        &input,
        r#"
foreign "C" abs : I32 -> I32
main = ["effect" | file.write-new "effect.txt", -7i32 | abs | echo] | ignore
"#,
    )
    .unwrap();
    let marker = scratch.join("effect.txt");
    let native = scratch.join("native.exe");
    let mut build = Command::new(fwp());
    build
        .current_dir(scratch.path())
        .env("CC", &probe)
        .env("FWP_TEST_CC", cc())
        .env("FWP_TEST_EFFECT", &marker)
        .args(["build", "-O1"])
        .arg(&input)
        .arg("-o")
        .arg(&native);
    let built = build.output().unwrap();
    assert!(built.status.success(), "{built:?}");
    assert!(!marker.exists());
    for optimized in [false, true] {
        let mut run = Command::new(fwp());
        run.current_dir(scratch.path())
            .env("CC", &probe)
            .env("FWP_TEST_CC", cc())
            .env("FWP_TEST_EFFECT", &marker)
            .args(["run", "--interp"])
            .arg(&input);
        if optimized {
            run.env_remove("FWP_NO_OPT");
        } else {
            run.env("FWP_NO_OPT", "1");
        }
        let actual = run.output().unwrap();
        assert!(actual.status.success(), "{optimized}: {actual:?}");
        assert_eq!(actual.stdout, b"7\n");
        assert!(actual.stderr.is_empty(), "{actual:?}");
        assert_eq!(std::fs::read(&marker).unwrap(), b"effect");
        std::fs::remove_file(&marker).unwrap();
    }
    let actual = Command::new(&native)
        .current_dir(scratch.path())
        .output()
        .unwrap();
    assert!(actual.status.success(), "{actual:?}");
    assert_eq!(actual.stdout, b"7\n");
    assert_eq!(std::fs::read(&marker).unwrap(), b"effect");
    // Prove that the launcher really detects compilation after an effect.
    let late = Command::new(&probe)
        .env("FWP_TEST_CC", cc())
        .env("FWP_TEST_EFFECT", &marker)
        .arg("--version")
        .output()
        .unwrap();
    assert_eq!(late.status.code(), Some(88));
    assert!(String::from_utf8_lossy(&late.stderr).contains("compiler started after program effect"));
    std::fs::remove_file(&marker).unwrap();
    // Setup failures must not partially execute the program.
    let unavailable = Command::new(fwp())
        .current_dir(scratch.path())
        .env("FWP_NO_OPT", "1")
        .env("CC", scratch.join("missing-compiler"))
        .args(["run", "--interp"])
        .arg(&input)
        .output()
        .unwrap();
    assert_eq!(unavailable.status.code(), Some(101));
    assert!(unavailable.stdout.is_empty());
    assert!(String::from_utf8_lossy(&unavailable.stderr).contains("cannot run C compiler"));
    assert!(!marker.exists());
}

#[test]
fn foreign_functions_native() {
    if !have(&cc()) {
        return;
    }
    let d = scratch("native");
    let exe = d.join("vec");
    let mut build = Command::new(fwp());
    build
        .arg("build")
        .arg(dir().join("vec.fwp"))
        .arg("--link")
        .arg(dir().join("vec.c"))
        .arg("-o")
        .arg(&exe);
    stdout(build);
    assert_eq!(stdout(Command::new(&exe)), VEC_OUT);
    let _ = std::fs::remove_dir_all(&d);
}

const GEOM_OUT: &str = "norm = 5
scale = (3, -4)
add_ints = 42
hello, LANG!
word_count = 4
";

#[test]
fn exact_float_abi_preserves_bits_and_owned_value_records() {
    let temp = fwp::cgen::TempDir::new("fwp-exact-ffi").unwrap();
    let c = temp.join("bits.c");
    std::fs::write(&c, r#"
#include <stdint.h>
struct fwp_binary128 { uint64_t low, high; };
struct fwp_c_Pack { struct fwp_binary128 q; uint16_t h, b; };
uint16_t echo_half(uint16_t x) { return x; }
uint16_t half_nan(void) { return UINT16_C(0x7c35); }
uint16_t bfloat_nan(void) { return UINT16_C(0x7f95); }
uint64_t half_bits(uint16_t x) { return x; }
struct fwp_binary128 echo_quad(struct fwp_binary128 x) { return x; }
struct fwp_binary128 quad_nan(void) { return (struct fwp_binary128){UINT64_C(0x1234),UINT64_C(0x7fff000000000000)}; }
uint64_t quad_low(struct fwp_binary128 x) { return x.low; }
struct fwp_c_Pack echo_pack(struct fwp_c_Pack x) { return x; }
struct fwp_binary128 invoke_quad(struct fwp_binary128 (*f)(struct fwp_binary128), struct fwp_binary128 x) { return f(x); }
"#).unwrap();
    for callbacks in [false, true] {
        let source = temp.join(format!("bits-{callbacks}.fwp"));
        let callback = if callbacks {
            "    1.0000000000000000000000000000000002f128 | invoke-quad id | gt 1.0f128 | echo,\n"
        } else {
            ""
        };
        let callback_decl = if callbacks {
            "foreign \"C\" invoke-quad : (F128 -> F128) -> F128 -> F128 = \"invoke_quad\"\n"
        } else {
            ""
        };
        std::fs::write(&source, format!(r#"
repr(C) Pack = {{ q: F128, h: F16, b: BF16 }}
foreign "C" echo-half : F16 -> F16 = "echo_half"
foreign "C" echo-bfloat : BF16 -> BF16 = "echo_half"
foreign "C" echo-quad : F128 -> F128 = "echo_quad"
foreign "C" echo-pack : Pack -> Pack = "echo_pack"
foreign "C" half-nan : () -> F16 = "half_nan"
foreign "C" bfloat-nan : () -> BF16 = "bfloat_nan"
foreign "C" half-bits : F16 -> U64 = "half_bits"
foreign "C" bfloat-bits : BF16 -> U64 = "half_bits"
foreign "C" quad-nan : () -> F128 = "quad_nan"
foreign "C" quad-low : F128 -> U64 = "quad_low"
{callback_decl}
main = [
    1.0f16 | echo-half | eq 1.0f16 | echo,
    1.0bf16 | echo-bfloat | eq 1.0bf16 | echo,
    1.0000000000000000000000000000000002f128 | echo-quad | gt 1.0f128 | echo,
    {{ q = 1.0000000000000000000000000000000002f128, h = 1.0f16, b = 2.0bf16 }} | echo-pack | .q | gt 1.0f128 | echo,
    () | half-nan | echo-half | half-bits | eq 31797u64 | echo,
    () | bfloat-nan | echo-bfloat | bfloat-bits | eq 32661u64 | echo,
    () | quad-nan | echo-quad | quad-low | eq 4660u64 | echo,
{callback}] | ignore
"#)).unwrap();
        let expected = "True\n".repeat(if callbacks { 8 } else { 7 });
        let mut interpreted = Command::new(fwp());
        interpreted
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp", "--link"])
            .arg(&c)
            .arg(&source);
        assert_eq!(stdout(interpreted), expected);
        for gc in ["tracing", "arc"] {
            let binary = temp.join(format!("bits-{callbacks}-{gc}"));
            let mut build = Command::new(fwp());
            build
                .env_remove("FWP_NO_OPT")
                .args(["build", "--gc", gc, "--link"])
                .arg(&c)
                .arg(&source)
                .arg("-o")
                .arg(&binary);
            stdout(build);
            let mut run = Command::new(binary);
            let verify = if gc == "arc" { "0" } else { "1" };
            run.env("FWP_GC_STRESS", verify)
                .env("FWP_GC_VERIFY", verify)
                .env("FWP_REUSE_VERIFY", verify);
            assert_eq!(stdout(run), expected);
        }
    }
}

#[test]
fn exact_float_exports_link_from_static_and_shared_libraries() {
    let temp = fwp::cgen::TempDir::new("fwp-float-exports").unwrap();
    let source = temp.join("bits.fwp");
    std::fs::write(
        &source,
        r#"
repr(C) Pack = { q: F128, h: F16, b: BF16 }
export quad-id : F128 -> F128
quad-id = id
export quad-double : F128 -> F128
quad-double = mul 2.0f128
export quad-sqrt : F128 -> F128
quad-sqrt = sqrt
export pack-id : Pack -> Pack
pack-id = id
"#,
    )
    .unwrap();
    let host = temp.join("host.c");
    std::fs::write(&host, r#"
#include "libbits.h"
_Static_assert(sizeof(struct fwp_binary128)==16,"quad ABI width");
_Static_assert(_Alignof(struct fwp_binary128)==8,"quad ABI alignment");
int main(void) {
    struct fwp_binary128 q={1,UINT64_C(0x3fff000000000000)};
    struct fwp_binary128 nan={UINT64_C(0x1234),UINT64_C(0x7fff000000000000)};
    for(int i=0;i<2048;i++) {
        struct fwp_binary128 r=quad_double(q);
        if(r.low!=1 || r.high!=UINT64_C(0x4000000000000000)) return 1;
        r=quad_id(nan);
        if(r.low!=nan.low || r.high!=nan.high) return 2;
        r=quad_sqrt((struct fwp_binary128){0,UINT64_C(0x4001000000000000)});
        if(r.low || r.high!=UINT64_C(0x4000000000000000)) return 3;
        Pack p=pack_id((Pack){nan,UINT16_C(0x7c35),UINT16_C(0x7f95)});
        if(p.q.low!=nan.low || p.q.high!=nan.high || p.h!=UINT16_C(0x7c35) || p.b!=UINT16_C(0x7f95)) return 4;
    }
    return 0;
}
"#).unwrap();
    for kind in ["--staticlib", "--cdylib"] {
        let extension = if kind == "--staticlib" {
            "a"
        } else {
            fwp::cgen::shared_library_extension()
        };
        let library = temp.join(format!("libbits.{extension}"));
        let mut build = Command::new(fwp());
        build
            .args(["build", kind])
            .arg(&source)
            .arg("-o")
            .arg(&library);
        stdout(build);
        let binary = temp.join("host");
        let mut link = Command::new(cc());
        link.arg("-std=c11")
            .arg(&host)
            .arg(&library)
            .arg(format!("-Wl,-rpath,{}", temp.path().display()))
            .args(["-lm", "-lpthread", "-o"])
            .arg(&binary);
        stdout(link);
        let mut run = Command::new(binary);
        run.env("FWP_GC_STRESS", "1")
            .env("FWP_GC_VERIFY", "1")
            .env("FWP_REUSE_VERIFY", "1");
        stdout(run);
        if kind == "--staticlib" {
            let mut members = Command::new(std::env::var("AR").unwrap_or_else(|_| "ar".into()));
            members.arg("t").arg(&library);
            let members = stdout(members);
            assert!(members.lines().any(|m| m == "float.c.o"));
            assert!(members.lines().any(|m| m == "float.cpp.o"));
            assert!(!members.lines().any(|m| m.ends_with(".a")));
        }
    }
}

#[test]
fn static_library_from_rust() {
    if !have(&cc()) || !have("rustc") {
        return;
    }
    let d = scratch("static");
    let mut build = Command::new(fwp());
    build
        .arg("build")
        .arg(dir().join("geom.fwp"))
        .arg("--staticlib")
        .arg("-o")
        .arg(d.join("libgeom.a"));
    stdout(build);
    assert!(d.join("libgeom.h").exists());
    let exe = d.join("geom-rs");
    let mut rustc = Command::new("rustc");
    rustc
        .args(["--edition", "2021"])
        .arg(dir().join("main.rs"))
        .arg("-L")
        .arg(&d)
        .args(["-l", "static=geom", "-l", "m", "-o"])
        .arg(&exe);
    if cfg!(windows) {
        // The generated archive uses LLVM-MinGW/UCRT, not the MSVC CRT.
        // Match that ABI explicitly for the Rust caller.
        rustc
            .args([
                "--target",
                &format!("{}-pc-windows-gnullvm", std::env::consts::ARCH),
            ])
            .args(["-C", &format!("linker={}", cc())])
            .args(["-l", "ws2_32", "-l", "shell32"]);
    }
    stdout(rustc);
    let output = stdout(Command::new(&exe));
    retain_interop(&d, "static-rust", &output);
    assert_eq!(output, GEOM_OUT.replace("LANG", "rust"));
    let _ = std::fs::remove_dir_all(&d);
}

#[test]
fn shared_library_from_c() {
    if !have(&cc()) {
        return;
    }
    let d = scratch("shared");
    let mut build = Command::new(fwp());
    build
        .arg("build")
        .arg(dir().join("geom.fwp"))
        .arg("--cdylib")
        .arg("-o")
        .arg(d.join(format!("libgeom.{}", fwp::cgen::shared_library_extension())));
    stdout(build);
    if cfg!(windows) {
        // An internal COFF symbol is not proof of a public DLL export. In
        // particular automatic exports used to omit `norm`, letting the host
        // silently bind to the unrelated CRT function with the same name.
        let mut inspect = Command::new("llvm-objdump");
        inspect.arg("-p").arg(d.join("libgeom.dll"));
        let image = stdout(inspect);
        let exports = image.split("Export Table:").nth(1).unwrap();
        for name in [
            "norm",
            "scale",
            "add_ints",
            "greet",
            "fwp_release_greet",
            "word_count",
        ] {
            assert!(
                exports
                    .lines()
                    .any(|line| line.split_whitespace().last() == Some(name)),
                "missing public DLL export {name}: {exports}"
            );
        }
    }
    let exe = d.join("geom-c");
    let mut c = Command::new(cc());
    c.arg("-I")
        .arg(&d)
        .arg(dir().join("main.c"))
        .arg("-L")
        .arg(&d)
        .arg("-lgeom")
        .arg(format!("-Wl,-rpath,{}", d.display()))
        .arg("-o")
        .arg(&exe);
    stdout(c);
    let output = stdout(Command::new(&exe));
    retain_interop(&d, "shared-c", &output);
    // This external C host uses the platform text stream convention.
    assert_eq!(output.replace("\r\n", "\n"), GEOM_OUT.replace("LANG", "c"));
    let _ = std::fs::remove_dir_all(&d);
}

#[test]
fn unsupported_types_are_reported() {
    let d = scratch("errors");
    let src = d.join("bad.fwp");
    std::fs::write(
        &src,
        "foreign \"C\" takes-list : List[I64] -> I64 = \"abs\"\nmain = [1] | takes-list | echo\n",
    )
    .unwrap();
    let out = Command::new(fwp())
        .arg("build")
        .arg(&src)
        .arg("-o")
        .arg(d.join("bad"))
        .output()
        .unwrap();
    assert!(!out.status.success());
    assert_eq!(
        String::from_utf8_lossy(&out.stderr),
        "fwp build: foreign function `abs`: `List[I64]` has no C representation (records need `repr(C)`)\n"
    );
    let _ = std::fs::remove_dir_all(&d);
}

// Count the real allocator operations for the large, NUL-terminated copies in
// this test. Other threads and differently sized compiler allocations are excluded.
thread_local! {
    static C_STRING_COUNTS: Cell<(bool, usize, usize)> = const { Cell::new((false, 0, 0)) };
}
struct CStringAllocator;
fn count_c_string(size: usize, released: bool) {
    if size == 65537 {
        C_STRING_COUNTS.with(|state| {
            let (active, allocated, freed) = state.get();
            if active {
                state.set((
                    active,
                    allocated + usize::from(!released),
                    freed + usize::from(released),
                ));
            }
        });
    }
}
unsafe impl GlobalAlloc for CStringAllocator {
    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
        let pointer = System.alloc(layout);
        if !pointer.is_null() {
            count_c_string(layout.size(), false);
        }
        pointer
    }
    unsafe fn dealloc(&self, pointer: *mut u8, layout: Layout) {
        count_c_string(layout.size(), true);
        System.dealloc(pointer, layout);
    }
    unsafe fn realloc(&self, pointer: *mut u8, layout: Layout, size: usize) -> *mut u8 {
        let result = System.realloc(pointer, layout, size);
        if !result.is_null() {
            count_c_string(layout.size(), true);
            count_c_string(size, false);
        }
        result
    }
}
#[global_allocator]
static C_STRING_ALLOCATOR: CStringAllocator = CStringAllocator;

#[test]
fn interpreter_reclaims_foreign_string_copies_after_aliases_reentry_and_errors() {
    let dir = fwp::cgen::TempDir::new("ffi-string-lifetimes").unwrap();
    let c = dir.join("strings.c");
    std::fs::write(
        &c,
        r#"
#include <stddef.h>
#include <string.h>
const char *text_alias(const char *s) { return s; }
const char *callback_alias(const char *(*f)(const char *), const char *s) {
    const char *first = f(s);
    const char *second = f(s);
    if (!first || !second) return NULL;
    return strcmp(first, second) == 0 ? first : NULL;
}
"#,
    )
    .unwrap();
    fwp::ffi::set_links(vec![c.to_string_lossy().into_owned()]);
    let (_, program) = fwp::driver::compile_source("strings.fwp", r#"
foreign "C" text-alias : String -> String = "text_alias"
foreign "C" callback-alias : (String -> String) -> String -> String = "callback_alias"
foreign "C" callback-error : (String -> String ! {Error[String]}) -> String -> String ! {Error[String]} = "callback_alias"
foreign "C" compare : String -> String -> I32 = "strcmp"
export aliased : String -> String
aliased = text-alias
export nested : String -> String
nested = callback-alias text-alias
raising : String -> String ! {Error[String]}
raising = const "stop" | fail
export failed : String -> String ! {Error[String]}
failed = callback-error raising
export bad-argument : String -> I32
bad-argument = flip compare "bad\0argument"
"#, fwp::mono::Roots { exports: true, ..Default::default() }).map_err(|e| e.rendered).unwrap();
    assert_eq!(
        program.exports.len(),
        4,
        "all cleanup probes must be compiled"
    );
    let input = fwp::value::Value::str(&"x".repeat(65536));
    let mut interpreter = fwp::interp::Interp::new(&program, Box::new(std::io::sink())).unwrap();
    for name in ["aliased", "nested", "failed", "bad-argument"] {
        let id = program.exports.iter().find(|(n, _)| n == name).unwrap().1;
        C_STRING_COUNTS.with(|state| state.set((true, 0, 0)));
        for _ in 0..16 {
            let result = interpreter.call(id, vec![input.clone()]);
            match name {
                "aliased" | "nested" => assert_eq!(result.unwrap(), input),
                "failed" => assert!(
                    matches!(result, Err(fwp::interp::Ctl::Fail(..))),
                    "{result:?}"
                ),
                "bad-argument" => assert!(
                    matches!(result, Err(fwp::interp::Ctl::Trap(ref message)) if message.contains("NUL")),
                    "{result:?}"
                ),
                _ => unreachable!(),
            }
        }
        let (_, allocated, freed) = C_STRING_COUNTS.with(|state| state.replace((false, 0, 0)));
        assert!(
            allocated >= 16,
            "{name}: the observer must see actual C-string copies"
        );
        assert_eq!(
            allocated, freed,
            "{name}: foreign C-string copies remain allocated"
        );
    }
    fwp::ffi::set_links(Vec::new());
}
