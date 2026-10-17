//! Benchmarks against C and Rust (`bench/<name>/main.{fwp,c,rs}`): each
//! program is built with `fwp build -O2`, `cc -O2` and `rustc -O`, the
//! three must print the same, and the median of six runs in rotating order is
//! reported with raw samples, compiler/host metadata and ratios to both baselines
//! (on stdout, in target/bench.md, and in the GitHub
//! Actions job summary). Timings are not asserted: shared machines are too
//! noisy. Run with `cargo test --release --test bench benchmarks -- --ignored
//! --exact --nocapture`.

use std::path::{Path, PathBuf};
use std::process::Command;
use std::time::{Duration, Instant};

#[path = "support/entry_checks.rs"]
mod entry_checks;

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

/// Compare two arrangements of the existing generic ownership check. This
/// experiment does not change the runtime until native measurements are read.
#[test]
#[ignore = "runner-only ownership-check code size, frequency and elapsed samples"]
fn entry_check_arrangement_measurement() {
    assert_eq!(std::env::var("GITHUB_ACTIONS").as_deref(), Ok("true"));
    let dir = PathBuf::from(
        std::env::var_os("FWP_ENTRY_CHECK_ARTIFACTS").expect("entry-check artifact directory"),
    );
    std::fs::create_dir_all(&dir).unwrap();
    std::fs::write(dir.join("scope.txt"), "Compare ordinary compiler-selected inlining with an explicit noinline attribute on the existing native fwp_rc_share ownership check. Both variants use identical checked-ARC generated C, -O2, the ordinary fwp optimizer and -ffp-contract=off. No check is removed or relaxed. Whole binary sizes include linking/runtime choices; archived binaries permit separate instruction-section inspection. Numerical inputs are the maintained loop, pipeline and map benchmarks at their declared sizes; C implementations establish output only, not a timed performance baseline here. After one warm-up, six whole-process samples per fwp variant alternate run order; startup, allocation, execution, output and shutdown are included. Separate instrumented binaries count calls to the ownership check through entry execution and cached-value cleanup; these binaries are excluded from timing and size comparison. Counting can prevent elimination/inlining and does not establish ordinary machine-call frequency. HTTP client/server variants are compiled for size only in this experiment; network behavior has separate tests. This is a code-arrangement experiment at one source revision, not evidence of C/Rust speed parity.\n").unwrap();
    let cc = std::env::var("CC").unwrap_or_else(|_| "cc".into());
    std::fs::write(dir.join("c.txt"), command_output(&cc, &["--version"])).unwrap();
    std::fs::write(dir.join("rust.txt"), command_output("rustc", &["-Vv"])).unwrap();
    let mut sizes = String::from("program\tvariant\tfile_bytes\n");
    let mut timings = String::from("program\tround\tposition\tvariant\telapsed_ns\n");
    let mut checks = String::from("program\tvariant\tentry_check_calls\n");
    for (name, source, numerical) in [
        ("loop", "bench/loop/main.fwp", true),
        ("pipeline", "bench/pipeline/main.fwp", true),
        ("map", "bench/map/main.fwp", true),
        ("http-client", "tests/web/arc-client.fwp", false),
        ("http-server", "tests/web/server.fwp", false),
    ] {
        std::fs::copy(root().join(source), dir.join(format!("{name}.fwp"))).unwrap();
        let cfile = dir.join(format!("{name}-ordinary.c"));
        build(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .args(["build", "--gc", "arc", "--emit-c", "-o"])
                .arg(&cfile)
                .arg(root().join(source)),
        );
        let ordinary = std::fs::read_to_string(cfile).unwrap();
        let signature = entry_checks::SIGNATURE;
        assert_eq!(ordinary.matches(signature).count(), 1);
        let outlined = ordinary.replace(
            signature,
            "static __attribute__((noinline)) void fwp_rc_share(V v) {",
        );
        let mut executables = Vec::new();
        let expected = if numerical {
            let reference = dir.join(format!("{name}-c-reference.exe"));
            build(
                Command::new(&cc)
                    .args(["-O2", "-o"])
                    .arg(&reference)
                    .arg(root().join("bench").join(name).join("main.c")),
            );
            Some(measure(&reference).0)
        } else {
            None
        };
        for (variant, code) in [("ordinary", ordinary), ("noinline", outlined)] {
            std::fs::write(dir.join(format!("{name}-{variant}.c")), &code).unwrap();
            let binary = dir.join(format!("{name}-{variant}.exe"));
            fwp::cgen::compile_c(&code, &binary, "-O2").unwrap();
            sizes.push_str(&format!(
                "{name}\t{variant}\t{}\n",
                std::fs::metadata(&binary).unwrap().len()
            ));
            std::fs::write(dir.join("binary-sizes.tsv"), &sizes).unwrap();
            if let Some(reference) = &expected {
                assert_eq!(&measure(&binary).0, reference, "{name}/{variant}");
                let definition = if variant == "ordinary" {
                    signature
                } else {
                    "static __attribute__((noinline)) void fwp_rc_share(V v) {"
                };
                let instrumented = entry_checks::instrument(&code, definition);
                let measured = dir.join(format!("{name}-{variant}-counted.exe"));
                std::fs::write(
                    dir.join(format!("{name}-{variant}-counted.c")),
                    &instrumented,
                )
                .unwrap();
                fwp::cgen::compile_c(&instrumented, &measured, "-O2").unwrap();
                let out = Command::new(measured).output().unwrap();
                assert!(out.status.success(), "{out:?}");
                assert_eq!(&String::from_utf8_lossy(&out.stdout), reference);
                let stderr = String::from_utf8(out.stderr).unwrap();
                let count = entry_checks::count(&stderr);
                checks.push_str(&format!("{name}\t{variant}\t{count}\n"));
                std::fs::write(dir.join("entry-checks.tsv"), &checks).unwrap();
            }
            executables.push((variant, binary));
        }
        if let Some(reference) = expected {
            for round in 0..6 {
                for position in 0..2 {
                    let (variant, binary) = &executables[(round + position) % 2];
                    let (output, elapsed) = measure(binary);
                    assert_eq!(output, reference, "{name}/{variant}/{round}");
                    timings.push_str(&format!(
                        "{name}\t{round}\t{position}\t{variant}\t{}\n",
                        elapsed.as_nanos()
                    ));
                    std::fs::write(dir.join("elapsed.tsv"), &timings).unwrap();
                }
            }
        }
    }
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
