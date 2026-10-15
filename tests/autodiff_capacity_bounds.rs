//! Check actual native tape growth and allocator-failure ownership without giant allocations.
#[path = "support/c_instrument.rs"]
mod c_instrument;
use std::process::Command;

#[test]
fn paired_metadata_preserves_values_alignment_and_recoverable_growth() {
    let directory = fwp::cgen::TempDir::new("fwp-ad-pairs").unwrap();
    let input = directory.join("runtime.fwp");
    let cfile = directory.join("runtime.c");
    std::fs::write(&input, "main = echo \"runtime\"\n").unwrap();
    let output = Command::new(env!("CARGO_BIN_EXE_fwp"))
        .args(["build", "--emit-c", "-o"])
        .arg(&cfile)
        .arg(&input)
        .output()
        .unwrap();
    assert!(output.status.success(), "{output:?}");
    let source = std::fs::read_to_string(cfile).unwrap();
    let start = source
        .find("/* ------------------------------------------------------------------ tapes */")
        .unwrap();
    let end = source
        .find("/* ---------------------------------------------------------------- kernels */")
        .unwrap();
    let tape = c_instrument::calls(&source[start..end], &[
        ("realloc", "pair_realloc"), ("free", "pair_free"), ("memmove", "pair_move"),
    ]).replace(
        "static void fwp_owned_tape_reserve(fwp_owned_tape *owner, int64_t cap) {",
        "static void fwp_owned_tape_reserve(fwp_owned_tape *owner, int64_t cap) {\n    if (pair_fail_weights) fwp_trap(\"paired weight growth control\");",
    );
    let declarations = "static void *pair_realloc(void *,size_t);\nstatic void pair_free(void *);\nstatic void *pair_move(void *,const void *,size_t);\nstatic int pair_fail_weights;\n";
    let code = format!("{}{declarations}{tape}{}", &source[..start], &source[end..]).replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let parent_move = "if (used) pair_move(t->pa + cap, t->pb, used * sizeof(int32_t));";
    let derivative_move = "if (used) pair_move(t->da + cap, t->db, used * sizeof(double));";
    assert_eq!(code.matches(parent_move).count(), 1);
    assert_eq!(code.matches(derivative_move).count(), 1);
    let no_parents = code.replace(parent_move, "");
    let no_derivatives = code.replace(derivative_move, "");
    let full_capacity = code.replace("used * sizeof(int32_t)", "(size_t)cap * sizeof(int32_t)");
    let early_capacity = code.replace(
        "fwp_owned_tape_reserve(t->owned, cap);",
        "t->cap = cap; fwp_owned_tape_reserve(t->owned, cap);",
    );
    assert_ne!(early_capacity, code);
    // Clamp below doubling so the relocated second region overlaps its source.
    let clamped = code.replace(
        "return limit < (size_t)INT32_MAX ? (int64_t)limit : INT32_MAX;",
        "return 273;",
    );
    assert_ne!(clamped, code);
    for opt in ["-O1", "-O2"] {
        for arc in [false, true] {
            for (name, runtime, expected) in [
                ("paired", &code, 0),
                ("clamped", &clamped, 0),
                ("missing-parents", &no_parents, 211),
                ("missing-derivatives", &no_derivatives, 212),
                ("full-capacity", &full_capacity, 213),
                ("early-capacity", &early_capacity, 216),
            ] {
                let mode = if arc { "#define FWP_ARC_ONLY 1\n" } else { "" };
                let source = format!(
                    "{mode}{runtime}\n{}",
                    include_str!("fixtures/autodiff_pairs_probe.c")
                );
                let binary = directory.join(name);
                fwp::cgen::compile_c(&source, &binary, opt).unwrap();
                for cache in ["0", "1"] {
                    let output = Command::new(&binary)
                        .env("FWP_AD_WORKSPACE", cache)
                        .env("FWP_GC_STRESS", if arc { "0" } else { "1" })
                        .env("FWP_GC_VERIFY", if arc { "0" } else { "1" })
                        .env("FWP_REUSE_VERIFY", if arc { "0" } else { "1" })
                        .output()
                        .unwrap();
                    assert_eq!(
                        output.status.code(),
                        Some(expected),
                        "{name} {opt} arc={arc} cache={cache}: {output:?}"
                    );
                    if expected == 0 {
                        assert!(output.stderr.is_empty(), "{output:?}");
                    }
                }
                if let Some(path) = std::env::var_os("FWP_AD_WORKSPACE_ARTIFACTS") {
                    let path = std::path::PathBuf::from(path);
                    std::fs::create_dir_all(&path).unwrap();
                    std::fs::write(path.join(format!("pairs-{name}-{opt}-arc{arc}.c")), source)
                        .unwrap();
                }
            }
        }
    }
}

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
        "capacity_free(t->pa);capacity_free(t->da);",
        "(void)t->pa;capacity_free(t->da);",
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
                    String::from_utf8(out.stdout).unwrap().replace("\r\n", "\n"),
                    "checked tape capacities and exact realloc failure ownership passed\n"
                );
            }
        }
    }
    std::fs::remove_dir_all(&directory).unwrap();
}

#[test]
fn registry_growth_preserves_tokens_scopes_and_capacity_bounds() {
    let directory = fwp::cgen::TempDir::new("fwp-ad-registry").unwrap();
    let input = directory.join("runtime.fwp");
    let cfile = directory.join("runtime.c");
    std::fs::write(&input, "main = echo \"runtime\"\n").unwrap();
    let output = Command::new(env!("CARGO_BIN_EXE_fwp"))
        .args(["build", "--emit-c", "-o"])
        .arg(&cfile)
        .arg(&input)
        .output()
        .unwrap();
    assert!(output.status.success(), "{output:?}");
    let code = std::fs::read_to_string(cfile)
        .unwrap()
        .replace("realloc(fwp_tapes,", "registry_realloc(fwp_tapes,")
        .replace("(double *)calloc(", "(double *)registry_calloc(")
        .replace("free(fwp_tapes);", "registry_free(fwp_tapes);")
        .replace("atexit(fwp_tape_finish)", "0")
        .replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        );
    let code = code.replace("static int64_t fwp_ntapes = 0;",
        "static void *registry_realloc(void *, size_t);\nstatic void *registry_calloc(size_t, size_t);\nstatic void registry_free(void *);\nstatic int64_t fwp_ntapes = 0;");
    let search = "while (slot < fwp_ntapes && (fwp_tapes[slot].live || fwp_tapes[slot].gen >= 32767)) slot++;";
    assert_eq!(code.matches(search).count(), 1);
    let code = code.replace("static int64_t fwp_ntapes = 0;", "static size_t registry_scans;\nstatic int64_t fwp_ntapes = 0;")
        .replace(search, "while (slot < fwp_ntapes && (fwp_tapes[slot].live || fwp_tapes[slot].gen >= 32767)) { registry_scans++; slot++; }");
    let incremental = code
        .replace("if (fwp_ntapes == fwp_tapes_cap)", "if (1)")
        .replace(
            "int64_t cap = fwp_tapes_cap ? fwp_tapes_cap * 2 : 1;",
            "int64_t cap = fwp_ntapes + 1;",
        );
    let stale_capacity = code.replace("fwp_ntapes = fwp_tapes_cap = 0;", "fwp_ntapes = 0;");
    let dummy_adjoint = code.replace(
        "int64_t needed = active;",
        "int64_t needed = active ? active : 1;",
    );
    assert_ne!(dummy_adjoint, code);
    assert_ne!(incremental, code);
    assert_ne!(stale_capacity, code);
    let restart_search = code.replace("int64_t slot = fwp_tape_next_slot;", "int64_t slot = 0;");
    let missed_release = code
        .replace("fwp_tape_next_slot = t - fwp_tapes;", "(void)0;")
        .replace("fwp_tape_next_slot = slot;", "(void)0;");
    let stale_cursor = code.replace(
        "    fwp_tape_next_slot = 0;",
        "    /* omitted cursor reset */",
    );
    let owned_release = "t->owned = NULL; t->live = 0;\n    int64_t slot = (id & 0xffff) - 1;\n    if (t->gen < 32767 && slot < fwp_tape_next_slot)\n        fwp_tape_next_slot = slot;";
    assert_eq!(code.matches(owned_release).count(), 1);
    let missed_owned_release = code.replace(owned_release, "t->owned = NULL; t->live = 0;");
    assert_ne!(restart_search, code);
    assert_ne!(missed_release, code);
    assert_ne!(stale_cursor, code);
    for arc in ["0", "1"] {
        for opt in ["-O1", "-O2"] {
            for (label, runtime, expected) in [
                ("bounded", &code, 0),
                ("incremental", &incremental, 193),
                ("stale-capacity", &stale_capacity, 196),
                ("dummy-adjoint", &dummy_adjoint, 202),
                ("restart-search", &restart_search, 205),
                ("missed-release", &missed_release, 206),
                ("stale-cursor", &stale_cursor, 196),
                ("missed-owned-release", &missed_owned_release, 207),
            ] {
                let mode = if arc == "1" {
                    "#define FWP_ARC_ONLY 1\n"
                } else {
                    ""
                };
                let source = format!(
                    "{mode}{runtime}\n{}",
                    include_str!("fixtures/autodiff_registry_probe.c")
                );
                let binary = directory.join(label);
                fwp::cgen::compile_c(&source, &binary, opt).unwrap();
                for cache in ["0", "1"] {
                    let output = Command::new(&binary)
                        .env("FWP_AD_WORKSPACE", cache)
                        .env("FWP_GC_STRESS", if arc == "1" { "0" } else { "1" })
                        .env("FWP_GC_VERIFY", if arc == "1" { "0" } else { "1" })
                        .env("FWP_REUSE_VERIFY", if arc == "1" { "0" } else { "1" })
                        .output()
                        .unwrap();
                    assert_eq!(
                        output.status.code(),
                        Some(expected),
                        "{label} arc={arc} {opt} cache={cache}: {output:?}"
                    );
                }
                if let Some(destination) = std::env::var_os("FWP_AD_WORKSPACE_ARTIFACTS") {
                    let destination = std::path::PathBuf::from(destination);
                    std::fs::create_dir_all(&destination).unwrap();
                    std::fs::write(
                        destination.join(format!("registry-{label}-arc{arc}{opt}.c")),
                        &source,
                    )
                    .unwrap();
                }
            }
        }
    }
}
