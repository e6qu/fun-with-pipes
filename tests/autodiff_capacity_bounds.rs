//! Check actual native tape growth and allocator-failure ownership without giant allocations.
#[path = "support/c_instrument.rs"]
mod c_instrument;
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
    let tape = c_instrument::calls(
        &source[start..end],
        &[("realloc", "capacity_realloc"), ("free", "capacity_free")],
    )
    .replace("PTRDIFF_MAX", "INT32_MAX")
    .replace("exit(102)", "capacity_exit(102)")
    // Faults recover instead of exiting; an invalid-registry negative
    // control must not run real process shutdown after returning its code.
    .replace("atexit(fwp_tape_finish)", "0");
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
    let missing_input_bound = code.replace(
        "if (n < 0 || n > fwp_tape_limit()) fwp_trap(\"autodiff: too many inputs\");",
        "",
    );
    let missing_release = code.replace(
        "capacity_free(t->pa);capacity_free(t->pb);",
        "(void)t->pa;capacity_free(t->pb);",
    );
    let missing_registry_owner = code.replace("if (!next) {", "if (!next) { fwp_tapes = next;");
    assert_ne!(missing_input_bound, code);
    assert_ne!(missing_release, code);
    assert_ne!(missing_registry_owner, code);
    for opt in ["-O1", "-O2"] {
        for (label, source, expected) in [
            ("checked", &code, 0),
            ("missing-bound", &missing_input_bound, 182),
            ("missing-release", &missing_release, 184),
            ("missing-registry-owner", &missing_registry_owner, 186),
        ] {
            let executable = directory.join(format!("{label}{}", &opt[1..]));
            fwp::cgen::compile_c(source, &executable, opt).unwrap();
            let out = Command::new(&executable)
                .env("FWP_AD_WORKSPACE", "0")
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", "1")
                .output()
                .unwrap();
            assert_eq!(
                out.status.code(),
                Some(expected),
                "{label} {opt}: {}",
                String::from_utf8_lossy(&out.stderr)
            );
            if expected == 0 {
                assert_eq!(
                    out.stdout,
                    b"checked tape capacities and exact realloc failure ownership passed\n"
                );
            }
        }
    }
    std::fs::remove_dir_all(&directory).unwrap();
}
