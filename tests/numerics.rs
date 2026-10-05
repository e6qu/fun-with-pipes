//! Reverse-mode autodiff and devices beyond the golden programs: large
//! parallel kernels give the same bits on every device and thread count in
//! both backends, the GPU device without OpenCL fails cleanly, and (with
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
        .output()
        .unwrap();
    render(&out)
}

fn build(path: &Path, exe: &Path) {
    let out = Command::new(fwp())
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
fn gpu_without_opencl() {
    let path = root().join("tests/numerics/gpu.fwp");
    let missing = "/nonexistent/libOpenCL.so.1";
    let msg = format!(
        "no OpenCL device: the OpenCL library ({}) could not be loaded",
        missing
    );
    let want = format!(
        "False\nErr \"{m}\"\nOk (Vector {{data = array[1.0, 2.0]}})\n--- stderr\nfwp: trap: device: {m}\n--- exit 101\n",
        m = msg
    );
    let env = [("FWP_OPENCL_LIB", missing)];
    assert_eq!(interp(&path, &env), want);
    if !have_cc() {
        return;
    }
    let dir = TempDir::new("gpu");
    let exe = dir.0.join("gpu");
    build(&path, &exe);
    assert_eq!(native(&exe, &env), want);
    // a library without platforms
    let stub = dir.0.join("libstubcl.so");
    let src = dir.0.join("stub.c");
    let mut c = String::from("#include <stdint.h>\nint32_t clGetPlatformIDs(uint32_t n, void **p, uint32_t *num) { (void)n; (void)p; if (num) *num = 0; return 0; }\n");
    for f in [
        "clGetDeviceIDs",
        "clGetDeviceInfo",
        "clCreateContext",
        "clCreateCommandQueue",
        "clCreateProgramWithSource",
        "clBuildProgram",
        "clGetProgramBuildInfo",
        "clCreateKernel",
        "clCreateBuffer",
        "clSetKernelArg",
        "clEnqueueNDRangeKernel",
        "clEnqueueReadBuffer",
        "clFinish",
        "clReleaseMemObject",
        "clReleaseKernel",
        "clReleaseProgram",
        "clReleaseCommandQueue",
        "clReleaseContext",
    ] {
        c.push_str(&format!("int32_t {}(void) {{ return -1; }}\n", f));
    }
    std::fs::write(&src, c).unwrap();
    let ok = Command::new(cc())
        .args(["-shared", "-fPIC", "-o"])
        .arg(&stub)
        .arg(&src)
        .status()
        .unwrap();
    assert!(ok.success());
    let stub = stub.to_string_lossy().to_string();
    let env = [("FWP_OPENCL_LIB", stub.as_str())];
    let msg = "no OpenCL device: there is no OpenCL platform";
    let want = format!(
        "False\nErr \"{m}\"\nOk (Vector {{data = array[1.0, 2.0]}})\n--- stderr\nfwp: trap: device: {m}\n--- exit 101\n",
        m = msg
    );
    assert_eq!(interp(&path, &env), want);
    assert_eq!(native(&exe, &env), want);
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
            timed(Command::new(fwp()).args(["run", "--interp"]).arg(&path))
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
