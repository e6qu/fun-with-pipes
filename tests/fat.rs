//! Fat binaries: one executable holding a variant per CPU feature level.
//! Every variant the CPU supports must produce the golden output, and the
//! dispatcher must pick the best one by default.

use std::path::{Path, PathBuf};
use std::process::Command;

fn fwp() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_fwp"))
}

fn render(stdout: &[u8], stderr: &[u8], code: i32) -> String {
    let mut s = String::from_utf8_lossy(stdout).to_string();
    if !stderr.is_empty() {
        s.push_str("--- stderr\n");
        s.push_str(&String::from_utf8_lossy(stderr));
    }
    if code != 0 {
        s.push_str(&format!("--- exit {}\n", code));
    }
    s
}

/// Variants this CPU can run, best last.
fn supported() -> Vec<&'static str> {
    #[cfg(target_arch = "x86_64")]
    {
        let mut v = vec!["x86-64"];
        if is_x86_feature_detected!("sse4.2") && is_x86_feature_detected!("popcnt") {
            v.push("x86-64-v2");
            if is_x86_feature_detected!("avx2")
                && is_x86_feature_detected!("bmi2")
                && is_x86_feature_detected!("fma")
            {
                v.push("x86-64-v3");
            }
        }
        v
    }
    #[cfg(not(target_arch = "x86_64"))]
    {
        vec!["baseline"]
    }
}

#[test]
fn fat_variants_agree() {
    if Command::new(std::env::var("CC").unwrap_or_else(|_| "cc".into()))
        .arg("--version")
        .output()
        .is_err()
    {
        return;
    }
    let run = Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/run");
    for name in ["numerics", "linalg", "lanes"] {
        let exe = std::env::temp_dir().join(format!("fwp-fat-{}-{}", std::process::id(), name));
        let b = Command::new(fwp())
            .arg("build")
            .arg(format!("{}.fwp", name))
            .arg("--fat")
            .arg("-o")
            .arg(&exe)
            .current_dir(&run)
            .output()
            .unwrap();
        assert!(b.status.success(), "{}", String::from_utf8_lossy(&b.stderr));
        let expected = std::fs::read_to_string(run.join(format!("{}.out", name))).unwrap();
        let variants = supported();
        for v in &variants {
            let out = Command::new(&exe)
                .env("FWP_VARIANT", v)
                .env("FWP_SEED", "42")
                .current_dir(&run)
                .output()
                .unwrap();
            assert_eq!(
                render(&out.stdout, &out.stderr, out.status.code().unwrap_or(-1)),
                expected,
                "{} variant {}",
                name,
                v
            );
        }
        let shown = Command::new(&exe)
            .env("FWP_VARIANT_SHOW", "1")
            .current_dir(&run)
            .output()
            .unwrap();
        let first = String::from_utf8_lossy(&shown.stderr)
            .lines()
            .next()
            .unwrap_or("")
            .to_string();
        assert_eq!(first, format!("fwp: variant {}", variants.last().unwrap()));
        let _ = std::fs::remove_file(&exe);
    }
}
