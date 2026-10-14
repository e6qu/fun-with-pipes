//! Check bounded AD workspace reuse and exact owners at actual native boundaries.
#[path = "support/c_instrument.rs"]
mod c_instrument;
use std::process::Command;
#[test]
fn autodiff_workspaces_reuse_bounded_storage_and_release_every_private_owner() {
    let directory = std::env::temp_dir().join(format!("fwp-ad-workspace-{}", std::process::id()));
    std::fs::create_dir(&directory).unwrap();
    let input = directory.join("runtime.fwp");
    let cfile = directory.join("runtime.c");
    std::fs::write(&input, "main = echo \"runtime\"\n").unwrap();
    let out = Command::new(env!("CARGO_BIN_EXE_fwp"))
        .args(["build", "--emit-c"])
        .arg(&input)
        .arg("-o")
        .arg(&cfile)
        .output()
        .unwrap();
    assert!(
        out.status.success(),
        "{}",
        String::from_utf8_lossy(&out.stderr)
    );
    let source = std::fs::read_to_string(cfile).unwrap();
    let start = source
        .find("/* ------------------------------------------------------------------ tapes */")
        .unwrap();
    let end = start
        + source[start..]
            .find("/* ---------------------------------------------------------------- kernels */")
            .unwrap();
    let tape = c_instrument::calls(
        &source[start..end],
        &[("realloc", "workspace_realloc"), ("free", "workspace_free")],
    )
    .replace("(double *)calloc(", "(double *)workspace_calloc(")
    .replace(
        "V r = fwp_arr_new((size_t)tp.leaves);",
        "V r = workspace_result_array((size_t)tp.leaves);",
    );
    assert!(tape.contains("V r = workspace_result_array((size_t)tp.leaves);"));
    let declarations="static void *workspace_realloc(void *,size_t);\nstatic void *workspace_calloc(size_t,size_t);\nstatic void workspace_free(void *);\nstatic V workspace_result_array(size_t);\n";
    let runtime=format!("{}{}{}{}",&source[..start],declarations,tape,&source[end..])
      .replace("typedef uint64_t V;","typedef uint64_t V;\nstatic uint64_t measured_calls,measured_bytes;")
      .replace("static inline void *fwp_gc_alloc(size_t n, int leaf) {","static inline void *fwp_gc_alloc(size_t n, int leaf) {\nif(leaf!=0){measured_calls++;measured_bytes+=n;}")
      .replace("static inline void *fwp_alloc_init(size_t n) {","static inline void *fwp_alloc_init(size_t n) {\nmeasured_calls++;measured_bytes+=n;")
      .replace("int main(int argc, char **argv)","int original_main(int argc, char **argv)");
    let probe = include_str!("fixtures/autodiff_workspace_probe.c");
    let mut gradients = Vec::new();
    for arc in [0, 1] {
        let probe = if arc == 1 {
            format!(
                "{}\n{}",
                probe.replace("int main(void)", "int tracing_probe_main(void)"),
                include_str!("fixtures/autodiff_arc_workspace_probe.c")
            )
        } else {
            probe.to_owned()
        };
        let mode = if arc == 1 {
            "#define FWP_ARC_ONLY 1\n"
        } else {
            ""
        };
        let code = format!("{mode}{runtime}\n{probe}");
        for opt in ["-O1", "-O2"] {
            let executable = directory.join(&opt[1..]);
            fwp::cgen::compile_c(&code, &executable, opt).unwrap();
            for cache in ["0", "1"] {
                let output = Command::new(&executable)
                    .env("FWP_AD_WORKSPACE", cache)
                    .env("FWP_GC_STRESS", if arc == 1 { "0" } else { "1" })
                    .env("FWP_GC_VERIFY", if arc == 1 { "0" } else { "1" })
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                assert_eq!(
                    output.status.code(),
                    Some(0),
                    "{opt} cache={cache}: {}",
                    String::from_utf8_lossy(&output.stderr)
                );
                let report =
                    fwp::json::Json::parse(std::str::from_utf8(&output.stdout).unwrap()).unwrap();
                let Some(fwp::json::Json::Arr(profiles)) = report.get("profiles") else {
                    panic!("missing workspace profiles");
                };
                let hashes: Vec<_> = profiles
                    .iter()
                    .map(|profile| profile.get("gradientHash").unwrap().clone())
                    .collect();
                gradients.push(hashes);
                if let Some(destination) = std::env::var_os("FWP_AD_WORKSPACE_ARTIFACTS") {
                    let destination = std::path::PathBuf::from(destination);
                    std::fs::create_dir_all(&destination).unwrap();
                    std::fs::write(
                        destination.join(format!("native-arc{arc}{opt}-cache{cache}.json")),
                        &output.stdout,
                    )
                    .unwrap();
                }
            }
        }
    }
    assert!(
        gradients.windows(2).all(|pair| pair[0] == pair[1]),
        "AD gradients changed with workspace reuse or optimization"
    );
    std::fs::remove_dir_all(directory).unwrap();
}

#[test]
fn backward_prefix_bounds_actual_native_storage_and_scans() {
    let directory = fwp::cgen::TempDir::new("fwp-ad-prefix").unwrap();
    let input = directory.join("runtime.fwp");
    let cfile = directory.join("runtime.c");
    std::fs::write(&input, "main = echo \"runtime\"\n").unwrap();
    let output = Command::new(env!("CARGO_BIN_EXE_fwp"))
        .args(["build", "--emit-c"])
        .arg(&input)
        .arg("-o")
        .arg(&cfile)
        .output()
        .unwrap();
    assert!(output.status.success(), "{output:?}");
    let code = std::fs::read_to_string(cfile).unwrap();
    let scan = "for (int64_t i = active - 1; i >= tp.leaves; i--) {";
    let release = "fwp_tape_buffers *b = (fwp_tape_buffers *)arg;";
    assert_eq!(code.matches(scan).count(), 1);
    assert_eq!(code.matches(release).count(), 1);
    let code = code
        .replace(
            "typedef uint64_t V;",
            "typedef uint64_t V;\nstatic size_t prefix_scans,prefix_adj_bytes;",
        )
        .replace(scan, &format!("{scan}\n        prefix_scans++;"))
        .replace(
            release,
            &format!("{release}\n    prefix_adj_bytes=(size_t)b->adjcap*sizeof(double);"),
        )
        .replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        );
    let needed = "int64_t needed = active ? active : 1;";
    assert_eq!(code.matches(needed).count(), 1);
    let full_storage = code.replace(needed, "int64_t needed = tp.len ? tp.len : 1;");
    let full_scan =
        full_storage.replace(scan, "for (int64_t i = tp.len - 1; i >= tp.leaves; i--) {");
    let probe = include_str!("fixtures/autodiff_prefix_probe.c");
    for opt in ["-O1", "-O2"] {
        for (name, code, status) in [
            ("bounded", &code, 0),
            ("full-storage", &full_storage, 240),
            ("full-scan", &full_scan, 241),
        ] {
            let binary = directory.join(name);
            let code = format!("{code}\n{probe}");
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            for reuse in ["0", "1"] {
                let output = Command::new(&binary)
                    .env("FWP_AD_WORKSPACE", "0")
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", reuse)
                    .output()
                    .unwrap();
                assert_eq!(
                    output.status.code(),
                    Some(status),
                    "{name} {opt} {reuse}: {output:?}"
                );
                if let Some(destination) = std::env::var_os("FWP_AD_WORKSPACE_ARTIFACTS") {
                    let destination = std::path::PathBuf::from(destination);
                    std::fs::create_dir_all(&destination).unwrap();
                    let prefix = destination.join(format!("prefix-{name}-{opt}-reuse{reuse}"));
                    std::fs::write(prefix.with_extension("c"), &code).unwrap();
                    std::fs::write(prefix.with_extension("status"), format!("{output:?}\n"))
                        .unwrap();
                }
            }
        }
    }
}

#[test]
fn unused_tape_suffix_preserves_language_values_and_forward_traps() {
    let directory = fwp::cgen::TempDir::new("fwp-ad-prefix-language").unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    for (name, source, expected, status, diagnostic) in [
        ("values", include_str!("run/ad_unused_suffix.fwp"),
         include_str!("run/ad_unused_suffix.out"), 0, ""),
        ("trap", "bad : List[Rev[F64]] -> List[Rev[F64]]\nbad = tap (const \"unused suffix still evaluated\" | prim.trap)\nmain = [2.0] | vjp bad [1.0] | echo\n",
         "", 101, "unused suffix still evaluated"),
    ] {
        let input = directory.join(format!("{name}.fwp"));
        std::fs::write(&input, source).unwrap();
        let reference = Command::new(compiler).args(["run", "--interp"])
            .arg(&input).env("FWP_NO_OPT", "1").output().unwrap();
        assert_eq!(reference.status.code(), Some(status), "{reference:?}");
        assert_eq!(String::from_utf8_lossy(&reference.stdout).replace("\r\n", "\n"), expected);
        assert!(String::from_utf8_lossy(&reference.stderr).contains(diagnostic));
        for arc in [false, true] {
            for opt in ["-O1", "-O2"] {
                let binary = directory.join("prefix.exe");
                let mut build = Command::new(compiler);
                build.arg("build").arg(&input).arg(opt).arg("-o").arg(&binary);
                if arc { build.args(["--gc", "arc"]); }
                let built = build.output().unwrap();
                assert!(built.status.success(), "{built:?}");
                for workspace in ["0", "1"] {
                    let output = Command::new(&binary).env("FWP_AD_WORKSPACE", workspace)
                        .env("FWP_GC_STRESS", if arc { "0" } else { "1" })
                        .env("FWP_GC_VERIFY", if arc { "0" } else { "1" })
                        .env("FWP_REUSE_VERIFY", if arc { "0" } else { "1" })
                        .output().unwrap();
                    assert_eq!(output.status.code(), reference.status.code(), "{output:?}");
                    assert_eq!(output.stdout, reference.stdout);
                    assert!(String::from_utf8_lossy(&output.stderr).contains(diagnostic));
                }
            }
        }
    }
}
