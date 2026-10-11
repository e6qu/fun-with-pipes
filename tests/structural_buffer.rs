//! Structural text/binary scratch growth must reject overflow and failed allocation.
use std::path::PathBuf;
use std::process::Command;
#[test]
fn structural_buffer_growth_checks_sizes_and_allocation() {
    let directory = std::env::temp_dir().join(format!("fwp-buffer-growth-{}", std::process::id()));
    std::fs::create_dir(&directory).unwrap();
    struct Scratch(PathBuf);
    impl Drop for Scratch {
        fn drop(&mut self) { let _ = std::fs::remove_dir_all(&self.0); }
    }
    let scratch = Scratch(directory);
    let source = include_str!("../runtime/fwp_rt_ops.c");
    let start = source.find("typedef struct { char *d; size_t len, cap; } fwp_buf;").unwrap();
    let end = source.find("\nstatic void buf_put(").unwrap();
    let implementation = source[start..end].replace("cap *= 2;", "if (++doublings > 64) exit(127); cap *= 2;");
    let variants = [
        ("complete", implementation.clone(), [0, 102, 0, 102]),
        ("omit-size", implementation.replace("b->len == SIZE_MAX || extra > SIZE_MAX - b->len - 1", "0"), [0, 123, 0, 102]),
        ("omit-capacity", implementation.replace("if (cap > SIZE_MAX / 2) { cap = needed; break; }", ""), [0, 102, 127, 102]),
        ("omit-allocation", implementation.replace("if (!data)", "if (0)"), [0, 102, 0, 125]),
    ];
    for opt in ["-O1", "-O2"] {
        for (label, code, statuses) in &variants {
            let cfile = scratch.0.join(format!("{label}{}.c", &opt[1..]));
            let executable = cfile.with_extension("bin");
            let probe = include_str!("fixtures/structural_buffer_probe.c").replace("/* BUFFER_IMPLEMENTATION */", code);
            std::fs::write(&cfile, &probe).unwrap();
            let output = Command::new(std::env::var_os("CC").unwrap_or_else(|| "cc".into()))
                .args(["-std=c11", opt, "-fsanitize=address,undefined", "-fno-omit-frame-pointer"])
                .arg(&cfile).arg("-o").arg(&executable).output().unwrap();
            assert!(output.status.success(), "{}", String::from_utf8_lossy(&output.stderr));
            for (index, expected) in statuses.iter().enumerate() {
                let output = Command::new(&executable).arg((index + 1).to_string()).output().unwrap();
                if let Some(destination) = std::env::var_os("FWP_BUFFER_ARTIFACTS") {
                    let destination = PathBuf::from(destination); std::fs::create_dir_all(&destination).unwrap();
                    let prefix = destination.join(format!("{label}{}-{}", &opt[1..], index + 1));
                    std::fs::write(prefix.with_extension("c"), &probe).unwrap();
                    std::fs::copy(&executable, prefix.with_extension("bin")).unwrap();
                    std::fs::write(prefix.with_extension("stdout"), &output.stdout).unwrap();
                    std::fs::write(prefix.with_extension("stderr"), &output.stderr).unwrap();
                    std::fs::write(prefix.with_extension("status"), format!("{}\n", output.status)).unwrap();
                }
                assert_eq!(output.status.code(), Some(*expected), "{label} {opt} case{}: {}", index + 1, String::from_utf8_lossy(&output.stderr));
            }
        }
    }
}
