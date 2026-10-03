//! Benchmarks against C and Rust (`bench/<name>/main.{fwp,c,rs}`): each
//! program is built with `fwp build -O2`, `cc -O2` and `rustc -O`, the
//! three must print the same, and the best of three runs of each is
//! reported as a table (on stdout, in target/bench.md, and in the GitHub
//! Actions job summary). Timings are not asserted: shared machines are too
//! noisy. Run with `cargo test --release --test bench -- --ignored
//! --nocapture`.

use std::path::{Path, PathBuf};
use std::process::Command;
use std::time::{Duration, Instant};

fn root() -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR"))
}

fn build(cmd: &mut Command) {
    let o = cmd.output().unwrap();
    assert!(
        o.status.success(),
        "{:?}: {}",
        cmd,
        String::from_utf8_lossy(&o.stderr)
    );
}

/// The output of an executable and its best time over three runs.
fn measure(exe: &Path) -> (String, Duration) {
    let mut best = Duration::MAX;
    let mut out = String::new();
    for _ in 0..3 {
        let t = Instant::now();
        let o = Command::new(exe).output().unwrap();
        let d = t.elapsed();
        assert!(
            o.status.success(),
            "{}: {}",
            exe.display(),
            String::from_utf8_lossy(&o.stderr)
        );
        out = String::from_utf8_lossy(&o.stdout).into_owned();
        best = best.min(d);
    }
    (out, best)
}

#[test]
#[ignore]
fn benchmarks() {
    let dir = std::env::temp_dir().join(format!("fwp-bench-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let mut names: Vec<String> = std::fs::read_dir(root().join("bench"))
        .unwrap()
        .map(|e| e.unwrap().file_name().to_string_lossy().into_owned())
        .filter(|n| root().join("bench").join(n).join("main.fwp").exists())
        .collect();
    names.sort();
    let ms = |d: Duration| format!("{:.0} ms", d.as_secs_f64() * 1000.0);
    let mut table = String::from(
        "| benchmark | C (cc -O2) | Rust (rustc -O) | fwp (fwp build -O2) | fwp / C |\n|---|--:|--:|--:|--:|\n",
    );
    for name in &names {
        let src = root().join("bench").join(name);
        let (c, rs, fw) = (
            dir.join(format!("{}-c", name)),
            dir.join(format!("{}-rs", name)),
            dir.join(format!("{}-fwp", name)),
        );
        build(
            Command::new(std::env::var("CC").unwrap_or_else(|_| "cc".into()))
                .args(["-O2", "-o"])
                .arg(&c)
                .arg(src.join("main.c")),
        );
        build(
            Command::new("rustc")
                .args(["-O", "-o"])
                .arg(&rs)
                .arg(src.join("main.rs")),
        );
        build(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .arg("build")
                .arg(src.join("main.fwp"))
                .args(["-O2", "-o"])
                .arg(&fw),
        );
        let (oc, tc) = measure(&c);
        let (or, tr) = measure(&rs);
        let (of, tf) = measure(&fw);
        assert_eq!(oc, or, "{}: C and Rust disagree", name);
        assert_eq!(oc, of, "{}: C and fwp disagree", name);
        table.push_str(&format!(
            "| {} | {} | {} | {} | {:.1}× |\n",
            name,
            ms(tc),
            ms(tr),
            ms(tf),
            tf.as_secs_f64() / tc.as_secs_f64()
        ));
    }
    let _ = std::fs::remove_dir_all(&dir);
    println!("\n{}", table);
    let _ = std::fs::write(root().join("target").join("bench.md"), &table);
    if let Ok(summary) = std::env::var("GITHUB_STEP_SUMMARY") {
        use std::io::Write;
        if let Ok(mut f) = std::fs::OpenOptions::new().append(true).open(summary) {
            let _ = writeln!(f, "### Benchmarks\n\n{}", table);
        }
    }
}
