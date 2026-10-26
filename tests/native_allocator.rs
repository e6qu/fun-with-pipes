//! Check physical allocation, counts and release independently of the scheduler.
#![cfg(any(target_os = "linux", target_os = "macos", target_os = "windows"))]
use std::process::Command;

#[path = "support/allocation_report.rs"]
mod allocation_report;

#[test]
fn first_allocation_and_free_balance_without_explicit_initialization() {
    let source = include_str!("../runtime/fwp_rt_heap.c");
    let end =
        source.find("#endif /* FWP_NATIVE_HEAP */").unwrap() + "#endif /* FWP_NATIVE_HEAP */".len();
    let prefix = include_str!("fixtures/native_allocator_probe.c")
        .split("/* NATIVE_ALLOCATOR */")
        .next()
        .unwrap();
    let probe = r#"
int main(void) {
    size_t sizes[] = {0, 1, 17, 1024, HEAP_MAX_SMALL + 16};
    for (int mode = 0; mode < 3; ++mode) {
        for (size_t i = 0; i < sizeof sizes / sizeof *sizes; ++i) {
            size_t size = sizes[i];
            void *value = mode == 0 ? fwp_alloc_leaf(size) :
                mode == 1 ? fwp_alloc(size) : fwp_alloc_init(size);
            size_t expected = size > HEAP_MAX_SMALL ? size :
                fwp_heap.slot[fwp_heap.cls_of[(size + 15) >> 4]];
            if (fwp_heap.live != expected || fwp_heap.peak != expected || fwp_heap.total_alloc != (double)expected) return 35;
            fwp_mem_free(value);
            if (fwp_heap.live || fwp_heap.freed != (double)expected) return 36;
            fwp_heap_finish();
        }
    }
    return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("first-allocation").unwrap();
    let binary = dir.join("probe.exe");
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(
            &format!("{prefix}\n{}{probe}", &source[..end]),
            &binary,
            opt,
        )
        .unwrap();
        let output = Command::new(&binary).output().unwrap();
        assert!(output.status.success(), "{opt}: {output:?}");
    }
}

#[test]
fn native_pages_counts_reuse_and_unload() {
    let source = include_str!("../runtime/fwp_rt_heap.c");
    let end =
        source.find("#endif /* FWP_NATIVE_HEAP */").unwrap() + "#endif /* FWP_NATIVE_HEAP */".len();
    let allocator = &source[..end];
    let original = "static void fwp_mem_free(void *p) {\n";
    assert_eq!(allocator.matches(original).count(), 1);
    let missing_free = allocator.replace(
        original,
        "static void fwp_mem_free(void *p) { (void)p; return;\n",
    );
    let dir = fwp::cgen::TempDir::new("native-allocator").unwrap();
    let binary = dir.join("probe.exe");
    for opt in ["-O1", "-O2"] {
        for (code, expected) in [(allocator, 0), (missing_free.as_str(), 27)] {
            let c = include_str!("fixtures/native_allocator_probe.c")
                .replace("/* NATIVE_ALLOCATOR */", code);
            fwp::cgen::compile_c(&c, &binary, opt).unwrap();
            let out = Command::new(&binary).output().unwrap();
            assert_eq!(out.status.code(), Some(expected), "{opt}: {out:?}");
        }
    }
}

#[test]
fn static_heap_reuses_explicitly_released_pages_and_slots() {
    let dir = fwp::cgen::TempDir::new("static-heap-pressure").unwrap();
    let source = dir.join("pressure.fwp");
    let generated = dir.join("pressure.c");
    std::fs::write(&source, "main = ()\n").unwrap();
    let emitted = Command::new(env!("CARGO_BIN_EXE_fwp"))
        .args(["build", "--memory", "static", "--heap", "1M", "--emit-c"])
        .arg(&source)
        .arg("-o")
        .arg(&generated)
        .output()
        .unwrap();
    assert!(emitted.status.success(), "{emitted:?}");
    let code = std::fs::read_to_string(&generated).unwrap();
    let entry = "static void *fwp_main_thread(void *arg) {";
    let start = "    fwp_heap_start();\n";
    assert_eq!(code.matches(entry).count(), 1);
    assert_eq!(code.matches(start).count(), 1);
    let program = code
        .replace(
            entry,
            &format!(
                "{}\n{entry}",
                include_str!("fixtures/static_heap_pressure.c")
            ),
        )
        .replace(
            start,
            &format!("{start}    static_heap_pressure_probe();\n"),
        );
    for opt in ["-O0", "-O1", "-O2"] {
        let binary = dir.join(format!("pressure{opt}.exe"));
        fwp::cgen::compile_c(&program, &binary, opt).unwrap();
        for kind in ["slots", "pages", "exhausted"] {
            let output = Command::new(&binary)
                .env("FWP_STATIC_PROBE", kind)
                .env_remove("FWP_MEMORY_REPORT")
                .env_remove("FWP_ALLOC_STATS")
                .output()
                .unwrap();
            assert_eq!(
                output.status.code(),
                Some(if kind == "exhausted" { 102 } else { 0 }),
                "{opt}/{kind}: {output:?}"
            );
            assert!(output.stdout.is_empty(), "{output:?}");
            if kind == "exhausted" {
                assert!(
                    String::from_utf8_lossy(&output.stderr)
                        .contains("the static heap (1024 KiB) is full"),
                    "{output:?}"
                );
            } else {
                assert!(output.stderr.is_empty(), "{output:?}");
            }
        }
    }
}

#[test]
fn counted_metadata_releases_values_and_resources() {
    let dir = fwp::cgen::TempDir::new("counted-metadata").unwrap();
    let source = dir.join("metadata.fwp");
    std::fs::write(&source, "main = ()\n").unwrap();
    let artifacts = std::env::var_os("FWP_ARC_ARTIFACTS")
        .map(|path| std::path::PathBuf::from(path).join("allocator-metadata"));
    if let Some(path) = &artifacts {
        std::fs::create_dir_all(path).unwrap();
    }
    for memory in ["dynamic", "static"] {
        let generated = dir.join(format!("{memory}.c"));
        let mut build = Command::new(env!("CARGO_BIN_EXE_fwp"));
        build.args(["build", "--memory", memory, "--emit-c"]);
        if memory == "static" {
            build.args(["--heap", "1M"]);
        }
        let emitted = build
            .arg(&source)
            .arg("-o")
            .arg(&generated)
            .output()
            .unwrap();
        assert!(emitted.status.success(), "{emitted:?}");
        let code = std::fs::read_to_string(&generated).unwrap();
        let entry = "static void *fwp_main_thread(void *arg) {";
        let start = "    fwp_heap_start();\n";
        assert_eq!(code.matches(entry).count(), 1);
        assert_eq!(code.matches(start).count(), 1);
        let measured = code
            .replace(
                entry,
                &format!("{}\n{entry}", include_str!("fixtures/arc_metadata_probe.c")),
            )
            .replace(start, &format!("{start}    arc_metadata_probe();\n"));
        for opt in ["-O0", "-O1", "-O2"] {
            let label = format!("{memory}{opt}");
            let binary = dir.join(format!("{label}.exe"));
            fwp::cgen::compile_c(&measured, &binary, opt).unwrap();
            if let Some(path) = &artifacts {
                std::fs::write(path.join(format!("{label}.c")), &measured).unwrap();
                std::fs::copy(&binary, path.join(format!("{label}.exe"))).unwrap();
            }
            for kind in ["plain", "object", "array", "file", "socket"] {
                let output = Command::new(&binary)
                    .env("FWP_METADATA_CASE", kind)
                    .env("FWP_METADATA_FILE", dir.join("resource.dat"))
                    .env_remove("FWP_ALLOC_STATS")
                    .env_remove("FWP_MEMORY_REPORT")
                    .output()
                    .unwrap();
                assert!(
                    output.status.success() && output.stderr.is_empty(),
                    "{label}/{kind}: {output:?}"
                );
                let fields: Vec<i64> = String::from_utf8_lossy(&output.stdout)
                    .split_whitespace()
                    .map(|value| value.parse().unwrap())
                    .collect();
                assert_eq!(
                    fields,
                    [
                        65536,
                        4128,
                        4096,
                        0,
                        i64::from(kind == "object" || kind == "array")
                    ],
                    "{label}/{kind}"
                );
                if let Some(path) = &artifacts {
                    std::fs::write(path.join(format!("{label}-{kind}.stdout")), &output.stdout)
                        .unwrap();
                    std::fs::write(path.join(format!("{label}-{kind}.stderr")), &output.stderr)
                        .unwrap();
                    std::fs::write(
                        path.join(format!("{label}-{kind}.status")),
                        format!("{:?}\n", output.status.code()),
                    )
                    .unwrap();
                }
            }
        }
    }
}

#[test]
fn allocation_report_matches_physical_release_and_peak_bytes() {
    let source = include_str!("../runtime/fwp_rt_heap.c");
    let end =
        source.find("#endif /* FWP_NATIVE_HEAP */").unwrap() + "#endif /* FWP_NATIVE_HEAP */".len();
    let prefix = include_str!("fixtures/native_allocator_probe.c")
        .split("/* NATIVE_ALLOCATOR */")
        .next()
        .unwrap();
    let report_probe = r#"
int main(void) {
    fwp_heap_start();
    void *small = fwp_alloc_leaf(32);
    void *large = fwp_alloc_leaf(100000);
    fwp_mem_free(small);
    fwp_heap_report();
    fwp_mem_free(large);
    fwp_heap_report();
    fwp_heap_finish();
    return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("allocation-report").unwrap();
    let binary = dir.join("probe.exe");
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(
            &format!("{prefix}\n{}{report_probe}", &source[..end]),
            &binary,
            opt,
        )
        .unwrap();
        let output = Command::new(&binary)
            .env_remove("FWP_ALLOC_STATS")
            .env_remove("FWP_MEMORY_REPORT")
            .output()
            .unwrap();
        assert!(
            output.status.success() && output.stdout.is_empty(),
            "{opt}: {output:?}"
        );
        let stderr = String::from_utf8(output.stderr).unwrap();
        let reports: Vec<_> = stderr
            .lines()
            .map(|line| allocation_report::parse(line).unwrap())
            .collect();
        assert_eq!(reports.len(), 2, "{stderr}");
        for report in &reports {
            assert_eq!(report.allocated, 100032);
            assert_eq!(report.peak_live, 100032);
            assert!(report.heap_extent >= report.peak_live);
            assert!(report.rss_kib > 0);
        }
        assert_eq!((reports[0].released, reports[0].live), (32, 100000));
        assert_eq!((reports[1].released, reports[1].live), (100032, 0));
        assert_eq!(reports[0].heap_extent, reports[1].heap_extent);
    }
}

#[test]
fn allocation_report_requires_complete_explicit_units() {
    let report = "fwp allocation: 4096 bytes allocated, 3072 bytes released, 1024 live bytes, 2048 peak live bytes, 65536 heap extent bytes, max RSS 1234 KiB";
    let expected = allocation_report::AllocationReport {
        allocated: 4096,
        released: 3072,
        live: 1024,
        peak_live: 2048,
        heap_extent: 65536,
        rss_kib: 1234,
    };
    for ending in ["", "\n", "\r\n"] {
        assert_eq!(
            allocation_report::parse(&format!("{report}{ending}")).unwrap(),
            expected
        );
    }
    for invalid in [
        String::new(),
        report.replace(" bytes allocated", " MiB allocated"),
        report.replace("1024 live bytes", "-1 live bytes"),
        report.replace("1024 live bytes", "1.5 live bytes"),
        report.replace("1234 KiB", "1234 bytes"),
        report.replace(", 3072 bytes released", ""),
        format!("{report}\n{report}"),
        format!("{report}, extra field"),
        report.replace(
            "1024 live bytes",
            "340282366920938463463374607431768211456 live bytes",
        ),
    ] {
        assert!(allocation_report::parse(&invalid).is_err(), "{invalid}");
    }
}
