//! The tutorial's programs (examples/tutorial) run with the interpreter
//! and natively and must print their `.out` files; the other examples must
//! type-check. `FWP_BLESS=1` regenerates the outputs.

use std::path::{Path, PathBuf};
use std::process::Command;

fn fwp() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_fwp"))
}

fn examples() -> PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR")).join("examples")
}

fn sorted_fwp(dir: &Path) -> Vec<PathBuf> {
    let mut v: Vec<PathBuf> = std::fs::read_dir(dir)
        .unwrap()
        .map(|e| e.unwrap().path())
        .filter(|p| p.extension().is_some_and(|e| e == "fwp"))
        .collect();
    v.sort();
    v
}

#[test]
fn tutorial_programs() {
    let dir = examples().join("tutorial");
    let have_cc = Command::new(std::env::var("CC").unwrap_or_else(|_| "cc".into()))
        .arg("--version")
        .output()
        .is_ok();
    for path in sorted_fwp(&dir) {
        let out = Command::new(fwp()).arg("run").arg(&path).output().unwrap();
        assert!(
            out.status.success(),
            "{}: {}",
            path.display(),
            String::from_utf8_lossy(&out.stderr)
        );
        let got = String::from_utf8_lossy(&out.stdout).into_owned();
        let expected_path = path.with_extension("out");
        if std::env::var("FWP_BLESS").is_ok() {
            std::fs::write(&expected_path, &got).unwrap();
            continue;
        }
        let expected = std::fs::read_to_string(&expected_path).unwrap_or_default();
        assert_eq!(got, expected, "{}", path.display());
        if have_cc {
            let exe = std::env::temp_dir().join(format!(
                "fwp-example-{}-{}",
                std::process::id(),
                path.file_stem().unwrap().to_string_lossy()
            ));
            let b = Command::new(fwp())
                .arg("build")
                .arg(&path)
                .args(["-O1", "-o"])
                .arg(&exe)
                .output()
                .unwrap();
            assert!(b.status.success(), "{}", String::from_utf8_lossy(&b.stderr));
            let n = Command::new(&exe).output().unwrap();
            let _ = std::fs::remove_file(&exe);
            assert_eq!(
                String::from_utf8_lossy(&n.stdout),
                expected,
                "native {}",
                path.display()
            );
        }
    }
}

#[test]
fn other_examples_check() {
    for path in [
        "hello.fwp",
        "wordfreq.fwp",
        "server/api.fwp",
        "shell/tools.fwp",
    ] {
        let out = Command::new(fwp())
            .arg("check")
            .arg(examples().join(path))
            .output()
            .unwrap();
        assert!(
            out.status.success(),
            "{}: {}",
            path,
            String::from_utf8_lossy(&out.stderr)
        );
    }
}
