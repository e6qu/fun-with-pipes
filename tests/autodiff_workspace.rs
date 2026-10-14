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
