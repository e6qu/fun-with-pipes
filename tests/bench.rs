//! Benchmarks against C and Rust (`bench/<name>/main.{fwp,c,rs}`): each
//! program is built with `fwp build -O2`, `cc -O2` and `rustc -O`, the
//! three must print the same, and the best of three runs of each is
//! reported with raw samples, compiler/host metadata and ratios to both baselines
//! (on stdout, in target/bench.md, and in the GitHub
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

/// Output, best elapsed time, and all three complete-process samples.
fn measure(exe: &Path) -> (String, Duration, Vec<Duration>) {
    let mut best = Duration::MAX;
    let mut out = String::new();
    let mut samples = Vec::new();
    for sample in 0..3 {
        let t = Instant::now();
        let o = Command::new(exe).output().unwrap();
        let d = t.elapsed();
        assert!(
            o.status.success(),
            "{}: {}",
            exe.display(),
            String::from_utf8_lossy(&o.stderr)
        );
        let current = String::from_utf8(o.stdout).unwrap();
        if sample == 0 {
            out = current;
        } else {
            assert_eq!(
                current,
                out,
                "{} changed output between samples",
                exe.display()
            );
        }
        best = best.min(d);
        samples.push(d);
    }
    (out, best, samples)
}

fn command_output(command: &str, args: &[&str]) -> String {
    let output = Command::new(command).args(args).output().unwrap();
    assert!(output.status.success(), "{command} {args:?} failed");
    String::from_utf8(output.stdout).unwrap().trim().to_owned()
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
    let cc = std::env::var("CC").unwrap_or_else(|_| "cc".into());
    let ms = |d: Duration| format!("{:.3} ms", d.as_secs_f64() * 1000.0);
    let comparison = |fwp: Duration, baseline: Duration| {
        let ratio = fwp.as_secs_f64() / baseline.as_secs_f64();
        format!("{ratio:.3}× ({:+.1}%)", (ratio - 1.0) * 100.0)
    };
    let mut table = format!(
        "# fwp, C and Rust: complete-program elapsed time\n\n\
         Source commit: `{}`. Host: `{}/{}`.\n\n\
         Each executable runs three times in order C, Rust, fwp; the table uses\n\
         the shortest elapsed time. Samples include process startup, input\n\
         construction, computation, allocation and output; compilation is excluded.\n\
         These runs use native fwp, not the interpreter or checked ARC mode.\n\n\
         A ratio above 1 means fwp took longer. The percentage is\n\
         `(fwp / baseline - 1) * 100`, not a separately measured language cost.\n\
         Matching output does not imply equal work: maps use different data\n\
         structures in Rust, pipelines can remove intermediate collections, and\n\
         fwp can remove string formatting when only its length is needed.\n\
         fwp checks integer overflow; the C and optimized Rust baselines do not\n\
         provide the same overflow guarantees. No allocation or peak-memory\n\
         counters are collected by this comparison. See docs/benchmarks.md.\n\n\
         C compiler (`{cc} -O2`):\n\n```text\n{}\n```\n\n\
         Rust compiler (`rustc -O`):\n\n```text\n{}\n```\n\n\
         fwp build flags: `-O2`; fwp compiles through the system C toolchain.\n\n\
         | Program | C | Rust | fwp | fwp / C (extra time) | fwp / Rust (extra time) |\n\
         |---|--:|--:|--:|--:|--:|\n",
        command_output("git", &["rev-parse", "HEAD"]),
        std::env::consts::OS,
        std::env::consts::ARCH,
        command_output(&cc, &["--version"]),
        command_output("rustc", &["-vV"]),
    );
    let mut raw = String::from("\n## Raw elapsed samples\n\nAll samples below are milliseconds, in execution order.\n\n| Program | C | Rust | fwp |\n|---|---|---|---|\n");
    for name in &names {
        let src = root().join("bench").join(name);
        let (c, rs, fw) = (
            dir.join(format!("{}-c", name)),
            dir.join(format!("{}-rs", name)),
            dir.join(format!("{}-fwp", name)),
        );
        build(
            Command::new(&cc)
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
        let (oc, tc, sc) = measure(&c);
        let (or, tr, sr) = measure(&rs);
        let (of, tf, sf) = measure(&fw);
        assert_eq!(oc, or, "{}: C and Rust disagree", name);
        assert_eq!(oc, of, "{}: C and fwp disagree", name);
        table.push_str(&format!(
            "| {} | {} | {} | {} | {} | {} |\n",
            name,
            ms(tc),
            ms(tr),
            ms(tf),
            comparison(tf, tc),
            comparison(tf, tr),
        ));
        let samples =
            |values: Vec<Duration>| values.into_iter().map(ms).collect::<Vec<_>>().join(", ");
        raw.push_str(&format!(
            "| {name} | {} | {} | {} |\n",
            samples(sc),
            samples(sr),
            samples(sf)
        ));
    }
    table.push_str(&raw);
    // The benchmark job runs on Linux; record the runner's actual CPU details.
    // Other hosts retain their OS/architecture above without inventing a CPU model.
    if std::env::consts::OS == "linux" {
        table.push_str(&format!(
            "\n## Processor\n\n```text\n{}\n```\n",
            command_output("lscpu", &[])
        ));
    }
    let _ = std::fs::remove_dir_all(&dir);
    println!("\n{}", table);
    std::fs::write(root().join("target").join("bench.md"), &table).unwrap();
    if let Ok(summary) = std::env::var("GITHUB_STEP_SUMMARY") {
        use std::io::Write;
        if let Ok(mut f) = std::fs::OpenOptions::new().append(true).open(summary) {
            let _ = writeln!(f, "### Benchmarks\n\n{}", table);
        }
    }
}
