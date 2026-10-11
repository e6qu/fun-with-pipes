//! Valid leaf/constant kernels must never form an empty-stack top pointer.
use std::path::PathBuf;
use std::process::Command;

#[test]
fn empty_kernel_stack_is_safe_and_omission_is_detected() {
    let source = include_str!("../runtime/fwp_rt_kernel.c");
    let start = source.find("/* ---------------------------------------------------------------- kernels */").unwrap();
    let end = source[start..].find("/* elements start..start+len into out */").unwrap() + start;
    let kernel = &source[start..end];
    let guarded = "sp ? stack + (sp - 1) * FWP_KCHUNK : stack";
    assert_eq!(kernel.matches(guarded).count(), 1);
    let directory = std::env::temp_dir().join(format!("fwp-kernel-stack-{}", std::process::id()));
    std::fs::create_dir_all(&directory).unwrap();
    let artifacts = std::env::var_os("FWP_KERNEL_BOUNDS_ARTIFACTS").map(PathBuf::from).unwrap_or_else(|| directory.join("artifacts"));
    std::fs::create_dir_all(&artifacts).unwrap();
    let template = include_str!("fixtures/kernel_stack_probe.c");
    for optimization in ["-O1", "-O2"] {
        for omitted in [false, true] {
            let body = if omitted { kernel.replace(guarded, "stack + (sp - 1) * FWP_KCHUNK") } else { kernel.to_owned() };
            let label = format!("kernel{optimization}-omit{omitted}");
            let cfile = artifacts.join(format!("{label}.c"));
            let executable = directory.join(&label);
            std::fs::write(&cfile, template.replace("/* KERNEL */", &body)).unwrap();
            let compiler = Command::new("clang").args(["-std=c11", optimization, "-ffp-contract=off", "-fsanitize=address,undefined,unsigned-integer-overflow", "-fno-sanitize-recover=all"]).arg(&cfile).args(["-lm", "-o"]).arg(&executable).output().unwrap();
            std::fs::write(artifacts.join(format!("{label}.compile.stdout")), &compiler.stdout).unwrap();
            std::fs::write(artifacts.join(format!("{label}.compile.stderr")), &compiler.stderr).unwrap();
            assert!(compiler.status.success(), "{}", String::from_utf8_lossy(&compiler.stderr));
            std::fs::copy(&executable, artifacts.join(format!("{label}.bin"))).unwrap();
            let output = Command::new(&executable).output().unwrap();
            std::fs::write(artifacts.join(format!("{label}.stdout")), &output.stdout).unwrap();
            std::fs::write(artifacts.join(format!("{label}.stderr")), &output.stderr).unwrap();
            std::fs::write(artifacts.join(format!("{label}.status")), format!("{}\n", output.status)).unwrap();
            if omitted {
                assert!(!output.status.success(), "{label} failed to detect empty-stack subtraction");
                assert!(String::from_utf8_lossy(&output.stderr).contains("unsigned integer overflow"), "{label}: {}", String::from_utf8_lossy(&output.stderr));
            } else {
                assert!(output.status.success(), "{label}: {}", String::from_utf8_lossy(&output.stderr));
                assert_eq!(output.stdout, b"kernel stack controls passed\n");
                assert!(output.stderr.is_empty());
            }
        }
    }
    std::fs::remove_dir_all(directory).unwrap();
}
