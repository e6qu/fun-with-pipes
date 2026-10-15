//! Benchmarks against C and Rust (`bench/<name>/main.{fwp,c,rs}`): each
//! program is built with `fwp build -O2`, `cc -O2` and `rustc -O`, the
//! three must print the same, and the median of six runs in rotating order is
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

fn build(cmd: &mut Command) -> Duration {
    let started = Instant::now();
    let o = cmd.output().unwrap();
    assert!(
        o.status.success(),
        "{:?}: {}",
        cmd,
        String::from_utf8_lossy(&o.stderr)
    );
    started.elapsed()
}

/// Output and elapsed time of one complete process.
fn measure(exe: &Path) -> (String, Duration) {
    let t = Instant::now();
    let o = Command::new(exe).output().unwrap();
    let elapsed = t.elapsed();
    assert!(
        o.status.success(),
        "{}: {}",
        exe.display(),
        String::from_utf8_lossy(&o.stderr)
    );
    (String::from_utf8(o.stdout).unwrap(), elapsed)
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
         Each executable has one warmup and six measured runs. Orders rotate\n\
         C/Rust/fwp, Rust/fwp/C, fwp/C/Rust, twice; each implementation occupies\n\
         every position twice. The table uses the median. Samples include startup, input\n\
         construction, computation, allocation and output; compilation is excluded.\n\
         These runs use native fwp, not the interpreter or checked ARC mode.\n\n\
         A ratio above 1 means fwp took longer. The percentage is\n\
         `(fwp / baseline - 1) * 100`, not a separately measured language cost.\n\
         Matching output does not imply equal work: maps use sorted pairs in\n\
         all three but sorting implementations differ; pipelines can remove collections, and\n\
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
    let mut builds = String::from("\n## Compilation and binary size\n\nOne build per implementation; elapsed time includes compiler startup and linking.\nThe fwp compiler itself is already built. Binary sizes include each toolchain's\nruntime and linking choices; they are not executable-code sizes alone.\n\n| Program | C build | Rust build | fwp build | C bytes | Rust bytes | fwp bytes |\n|---|---:|---:|---:|---:|---:|---:|\n");
    for name in &names {
        let src = root().join("bench").join(name);
        let (c, rs, fw) = (
            dir.join(format!("{}-c", name)),
            dir.join(format!("{}-rs", name)),
            dir.join(format!("{}-fwp", name)),
        );
        let c_build = build(
            Command::new(&cc)
                .args(["-O2", "-o"])
                .arg(&c)
                .arg(src.join("main.c")),
        );
        let rust_build = build(
            Command::new("rustc")
                .args(["-O", "-o"])
                .arg(&rs)
                .arg(src.join("main.rs")),
        );
        let fwp_build = build(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .arg("build")
                .arg(src.join("main.fwp"))
                .args(["-O2", "-o"])
                .arg(&fw),
        );
        let executables = [&c, &rs, &fw];
        let reference = measure(&c).0;
        for exe in [&rs, &fw] {
            assert_eq!(measure(exe).0, reference, "{name}: warmup output differs");
        }
        let mut samples: [Vec<Duration>; 3] = std::array::from_fn(|_| Vec::new());
        for round in 0..6 {
            for position in 0..3 {
                let index = (round + position) % 3;
                let (output, elapsed) = measure(executables[index]);
                assert_eq!(output, reference, "{name}: output differs in round {round}");
                samples[index].push(elapsed);
            }
        }
        let [tc, tr, tf] = samples.each_ref().map(|values| {
            let mut sorted = values.clone();
            sorted.sort();
            (sorted[2] + sorted[3]) / 2
        });
        table.push_str(&format!(
            "| {} | {} | {} | {} | {} | {} |\n",
            name,
            ms(tc),
            ms(tr),
            ms(tf),
            comparison(tf, tc),
            comparison(tf, tr),
        ));
        let render_samples =
            |values: Vec<Duration>| values.into_iter().map(ms).collect::<Vec<_>>().join(", ");
        let [sc, sr, sf] = samples;
        raw.push_str(&format!(
            "| {name} | {} | {} | {} |\n",
            render_samples(sc),
            render_samples(sr),
            render_samples(sf)
        ));
        builds.push_str(&format!(
            "| {name} | {} | {} | {} | {} | {} | {} |\n",
            ms(c_build),
            ms(rust_build),
            ms(fwp_build),
            std::fs::metadata(&c).unwrap().len(),
            std::fs::metadata(&rs).unwrap().len(),
            std::fs::metadata(&fw).unwrap().len(),
        ));
    }
    table.push_str(&raw);
    table.push_str(&builds);
    // The benchmark job runs on Linux; record the runner's actual CPU details.
    // Other hosts retain their OS/architecture above without inventing a CPU model.
    if std::env::consts::OS == "linux" {
        table.push_str(&format!(
            "\n## Processor\n\n```text\n{}\n```\n",
            command_output("lscpu", &[])
        ));
    } else if std::env::consts::OS == "macos" {
        table.push_str(&format!(
            "\n## Processor\n\n```text\n{}\n```\n",
            command_output("sysctl", &["-n", "machdep.cpu.brand_string"]),
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
