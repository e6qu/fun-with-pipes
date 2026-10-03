//! C interop: foreign C functions from user C code (`--link`) in the
//! interpreter and natively, and fwp code built as C libraries used from
//! Rust (static library) and C (shared library through the generated
//! header).

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
    stdout(rustc);
    assert_eq!(stdout(Command::new(&exe)), GEOM_OUT.replace("LANG", "rust"));
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
        .arg(d.join("libgeom.so"));
    stdout(build);
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
    assert_eq!(stdout(Command::new(&exe)), GEOM_OUT.replace("LANG", "c"));
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
