//! Native build options: `fwp build --static` makes an executable that
//! needs no dynamic loader, and `fwp build --pgo` trains the program once
//! and builds it again with the profile; both behave like a plain build.

use std::path::{Path, PathBuf};
use std::process::Command;

fn fwp() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_fwp"))
}

fn root() -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR"))
}

fn cc() -> String {
    std::env::var("CC").unwrap_or_else(|_| "cc".into())
}

fn have_cc() -> bool {
    Path::new("/proc/self/status").exists()
        && Command::new(cc())
            .arg("--version")
            .output()
            .is_ok_and(|o| o.status.success())
}

fn gcc() -> bool {
    Command::new(cc()).arg("--version").output().is_ok_and(|o| {
        let v = String::from_utf8_lossy(&o.stdout);
        v.contains("Free Software Foundation") || v.contains("gcc")
    })
}

fn build(src: &Path, exe: &Path, opts: &[&str]) {
    let o = Command::new(fwp())
        .arg("build")
        .arg(src)
        .arg("-o")
        .arg(exe)
        .args(opts)
        .output()
        .unwrap();
    assert!(o.status.success(), "{}", String::from_utf8_lossy(&o.stderr));
}

fn stdout(exe: &Path, args: &[&str]) -> String {
    let o = Command::new(exe).args(args).output().unwrap();
    assert!(o.status.success());
    String::from_utf8_lossy(&o.stdout).into_owned()
}

fn temp(name: &str) -> PathBuf {
    let d = std::env::temp_dir().join(format!("fwp-builds-{}-{}", name, std::process::id()));
    std::fs::create_dir_all(&d).unwrap();
    d
}

#[test]
fn static_executables_need_no_loader() {
    if !have_cc() {
        return;
    }
    let dir = temp("static");
    let exe = dir.join("hello");
    build(&root().join("examples/hello.fwp"), &exe, &["--static"]);
    // a dynamically linked ELF has a PT_INTERP program header naming its
    // loader (64-bit little-endian ELF: e_phoff at 32, e_phentsize at 54,
    // e_phnum at 56; each header's type is its first 4 bytes)
    let b = std::fs::read(&exe).unwrap();
    let u = |at: usize, n: usize| {
        b[at..at + n]
            .iter()
            .rev()
            .fold(0usize, |acc, x| (acc << 8) | *x as usize)
    };
    if &b[..4] == b"\x7fELF" && b[4] == 2 && b[5] == 1 {
        let (phoff, phentsize, phnum) = (u(32, 8), u(54, 2), u(56, 2));
        let interp = (0..phnum).any(|i| u(phoff + i * phentsize, 4) == 3);
        assert!(!interp, "the executable names a dynamic loader");
    }
    assert_eq!(stdout(&exe, &[]), "hello, world\n");
    let _ = std::fs::remove_dir_all(&dir);
}

#[test]
fn profile_guided_builds_behave_alike() {
    if !have_cc() || !gcc() {
        return;
    }
    let dir = temp("pgo");
    let src = dir.join("count.fwp");
    std::fs::write(
        &src,
        "main = () | args | head | option.and-then parse-int | option.unwrap-or 10 \
         | range 0 | map (mul 3) | filter (rem 2 | eq 0) | sum | echo\n",
    )
    .unwrap();
    let (plain, pgo) = (dir.join("plain"), dir.join("pgo"));
    build(&src, &plain, &[]);
    build(&src, &pgo, &["--pgo", "--", "100000"]);
    for n in ["0", "7", "100000"] {
        assert_eq!(stdout(&pgo, &[n]), stdout(&plain, &[n]), "count {}", n);
    }
    let _ = std::fs::remove_dir_all(&dir);
}

#[test]
fn options_are_checked() {
    let hello = root().join("examples/hello.fwp");
    let cases: &[(&[&str], &str)] = &[
        (
            &["--static", "--target", "wasm32-wasi"],
            "one native executable",
        ),
        (&["--pgo", "--staticlib"], "one native executable"),
        (&["--pgo-input", "x"], "for the training run of --pgo"),
        (&["--", "1"], "for the training run of --pgo"),
    ];
    for (opts, want) in cases {
        let o = Command::new(fwp())
            .arg("build")
            .arg(&hello)
            .args(*opts)
            .args(["-o", "/dev/null"])
            .output()
            .unwrap();
        assert_eq!(o.status.code(), Some(2), "{:?}", opts);
        let err = String::from_utf8_lossy(&o.stderr);
        assert!(err.contains(want), "{:?}: {}", opts, err);
    }
}
