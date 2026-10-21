//! Reverse-mode autodiff and devices beyond the golden programs: large
//! parallel kernels give the same bits on every device and thread count in
//! both backends, and (with
//! `--ignored`) timings of reverse against forward mode and of parallel
//! kernels, natively and in the interpreter.

use std::path::{Path, PathBuf};
use std::process::{Command, Output};
use std::time::Instant;

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
    Command::new(cc()).arg("--version").output().is_ok()
}

struct TempDir(PathBuf);

impl TempDir {
    fn new(name: &str) -> TempDir {
        let d = std::env::temp_dir().join(format!("fwp-num-{}-{}", name, std::process::id()));
        let _ = std::fs::remove_dir_all(&d);
        std::fs::create_dir_all(&d).unwrap();
        TempDir(d)
    }
}

impl Drop for TempDir {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}

fn render(out: &Output) -> String {
    let mut s = String::from_utf8_lossy(&out.stdout).to_string();
    if !out.stderr.is_empty() {
        s.push_str("--- stderr\n");
        s.push_str(&String::from_utf8_lossy(&out.stderr));
    }
    if let Some(c) = out.status.code().filter(|c| *c != 0) {
        s.push_str(&format!("--- exit {}\n", c));
    }
    s
}

fn interp(path: &Path, env: &[(&str, &str)]) -> String {
    let out = Command::new(fwp())
        .args(["run", "--interp"])
        .arg(path)
        .envs(env.iter().copied())
        .env("FWP_NO_OPT", "1")
        .output()
        .unwrap();
    render(&out)
}

fn build(path: &Path, exe: &Path) {
    let out = Command::new(fwp())
        .env_remove("FWP_NO_OPT")
        .arg("build")
        .arg(path)
        .args(["-O2", "-o"])
        .arg(exe)
        .output()
        .unwrap();
    assert!(
        out.status.success(),
        "fwp build {}: {}",
        path.display(),
        String::from_utf8_lossy(&out.stderr)
    );
}

fn native(exe: &Path, env: &[(&str, &str)]) -> String {
    render(
        &Command::new(exe)
            .envs(env.iter().copied())
            .output()
            .unwrap(),
    )
}

#[test]
fn parallel_kernels_are_deterministic() {
    let path = root().join("tests/numerics/determinism.fwp");
    let got = interp(&path, &[]);
    let lines: Vec<&str> = got.lines().collect();
    assert_eq!(lines.len(), 3, "{}", got);
    // one hash and one sum for all six devices
    let hashes = lines[0]
        .trim_matches(['[', ']'])
        .split(", ")
        .collect::<Vec<_>>();
    assert_eq!(hashes.len(), 6, "{}", got);
    assert!(hashes.iter().all(|h| *h == hashes[0]), "{}", got);
    let sums = lines[1]
        .trim_matches(['[', ']'])
        .split(", ")
        .collect::<Vec<_>>();
    assert!(sums.iter().all(|s| *s == sums[0]), "{}", got);
    if !have_cc() {
        return;
    }
    let dir = TempDir::new("det");
    let exe = dir.0.join("determinism");
    build(&path, &exe);
    assert_eq!(native(&exe, &[]), got);
}

#[test]
fn cpu_worker_limits_match_availability_and_both_backends() {
    let dir = TempDir::new("worker-limits");
    for (operation, expected) in [("kernel.run", "array[1.0, 2.0]\n"), ("kernel.sum", "3.0\n")] {
        let path = dir.0.join("workers.fwp");
        std::fs::write(
            &path,
            format!(
                r#"
count : I64
count = "FWP_TEST_WORKERS" | env.get | option.and-then parse-int | (match
    Some _ -> id
    None -> "test requires FWP_TEST_WORKERS" | prim.trap)
kernel : Kernel
kernel = vector [1.0, 2.0] | tensor.lazy | tensor.kernel
main = count | CpuParallel | tap (device.available | echo) | flip {operation} kernel | echo
"#
            ),
        )
        .unwrap();
        let mut references = Vec::new();
        for count in [i64::MIN, -1, 0, 1, 256, 257, i64::MAX] {
            let setting = count.to_string();
            let got = interp(&path, &[("FWP_TEST_WORKERS", &setting)]);
            let want = if (1..=256).contains(&count) {
                format!("True\n{expected}")
            } else {
                "False\n--- stderr\nfwp: trap: device: thread count must be between 1 and 256\n--- exit 101\n".into()
            };
            assert_eq!(got, want, "{operation}: {count}");
            references.push((setting, got));
        }
        if !have_cc() {
            continue;
        }
        for memory in ["arc", "tracing"] {
            for opt in ["-O0", "-O2"] {
                let binary = dir.0.join("workers.exe");
                let mut command = Command::new(fwp());
                command
                    .env_remove("FWP_NO_OPT")
                    .args(["build", opt, "--gc", memory]);
                let output = command.arg(&path).arg("-o").arg(&binary).output().unwrap();
                assert!(output.status.success(), "{memory}/{opt}: {output:?}");
                for (setting, expected) in &references {
                    assert_eq!(
                        native(
                            &binary,
                            &[
                                ("FWP_TEST_WORKERS", setting),
                                ("FWP_GC_STRESS", "1"),
                                ("FWP_GC_VERIFY", "1"),
                                ("FWP_REUSE_VERIFY", "1")
                            ]
                        ),
                        *expected,
                        "{operation}/{memory}/{opt}/{setting}"
                    );
                }
            }
        }
    }
}

/// A program computing the gradient of a function of n inputs, in
/// reverse or forward mode.
fn gradient_program(mode: &str, n: usize) -> String {
    format!(
        "f : List[t] -> t where Field[t], Floating[t], FromFloat[t], Dup[t]\n\
         f = fork zip id (drop 1) | map (fork mul .0 (.1 | sin) | add 1.5 | ln) | sum\n\n\
         main = {n} | range 0 | map (int.to-float | mul 0.01 | cos) | {mode} f | take 2 | echo\n",
        n = n,
        mode = mode
    )
}

fn kernel_program(device: &str, n: usize) -> String {
    format!(
        "xs : Vector[F64, _]\n\
         xs = {n} | range 0 | map (int.to-float | mul 0.001 | add 1.0) | vector.from-list\n\n\
         step : TensorExpr[n] -> TensorExpr[n]\n\
         step = sqrt | sin | add (tensor.fill 1.5) | exp | ln | cos | mul (tensor.fill 0.5) | add (tensor.fill 1.0)\n\n\
         main = xs | tensor.lazy | iterate 20 step | last | option.unwrap-or (tensor.fill 0.0) | tensor.sum-on ({d}) | echo\n",
        n = n,
        d = device
    )
}

fn timed(cmd: &mut Command) -> (String, f64) {
    let t = Instant::now();
    let out = cmd.output().unwrap();
    (render(&out), t.elapsed().as_secs_f64())
}

/// Timings (run with `cargo test --release --test numerics -- --ignored
/// --nocapture`).
#[test]
#[ignore]
fn bench() {
    let dir = TempDir::new("bench");
    let mut cases: Vec<(String, String)> = Vec::new();
    for n in [100, 1000] {
        cases.push((format!("grad n={}", n), gradient_program("grad", n)));
        cases.push((format!("gradient n={}", n), gradient_program("gradient", n)));
    }
    for d in ["Cpu", "CpuParallel 2", "CpuParallel 4"] {
        cases.push((
            format!("20 fused steps, 4M elements, {}", d),
            kernel_program(d, 4_000_000),
        ));
    }
    for (name, src) in cases {
        let path = dir.0.join("bench.fwp");
        std::fs::write(&path, &src).unwrap();
        let exe = dir.0.join("bench");
        build(&path, &exe);
        let (a, t_native) = timed(&mut Command::new(&exe));
        let (b, t_interp) = if name.contains("4M") || name.contains("gradient n=1000") {
            (a.clone(), f64::NAN)
        } else {
            timed(
                Command::new(fwp())
                    .env("FWP_NO_OPT", "1")
                    .args(["run", "--interp"])
                    .arg(&path),
            )
        };
        assert_eq!(a, b);
        println!(
            "{:<45} native {:8.3}s  interpreter {:8.3}s  {}",
            name,
            t_native,
            t_interp,
            a.trim()
        );
    }
}
