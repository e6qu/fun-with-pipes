//! Check actual native tape growth and allocator-failure ownership without giant allocations.
use std::process::Command;
#[test]
fn tape_capacity_checks_and_realloc_failures_preserve_owners() {
    let directory = std::env::temp_dir().join(format!("fwp-ad-capacity-{}", std::process::id()));
    std::fs::create_dir(&directory).unwrap();
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
    assert!(
        output.status.success(),
        "{}",
        String::from_utf8_lossy(&output.stderr)
    );
    let source = std::fs::read_to_string(&cfile).unwrap();
    let start = source
        .find("/* ------------------------------------------------------------------ tapes */")
        .unwrap();
    let end = start
        + source[start..]
            .find("/* ---------------------------------------------------------------- kernels */")
            .unwrap();
    let tape = source[start..end]
        .replace("PTRDIFF_MAX", "INT32_MAX")
        .replace("realloc(", "capacity_realloc(")
        .replace("free(", "capacity_free(")
        .replace("exit(102)", "capacity_exit(102)");
    let declarations="static void *capacity_realloc(void *,size_t);\nstatic void capacity_free(void *);\nstatic void capacity_exit(int);\n";
    let runtime = format!(
        "{}{}{}{}",
        &source[..start],
        declarations,
        tape,
        &source[end..]
    )
    .replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let code = format!(
        "{runtime}\n{}",
        include_str!("fixtures/autodiff_capacity_probe.c")
    );
    for opt in ["-O1", "-O2"] {
        let executable = directory.join(&opt[1..]);
        fwp::cgen::compile_c(&code, &executable, opt).unwrap();
        let out = Command::new(&executable)
            .env("FWP_GC_STRESS", "1")
            .env("FWP_GC_VERIFY", "1")
            .env("FWP_REUSE_VERIFY", "1")
            .output()
            .unwrap();
        assert_eq!(
            out.status.code(),
            Some(0),
            "{opt}: {}",
            String::from_utf8_lossy(&out.stderr)
        );
        assert_eq!(
            out.stdout,
            b"checked tape capacities and exact realloc failure ownership passed\n"
        );
    }
    std::fs::remove_dir_all(&directory).unwrap();
}
