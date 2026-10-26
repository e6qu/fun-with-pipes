//! Darwin-specific failures must be exercised, rather than hidden by
//! Linux-only guards in the older allocation and process-memory tests.
#![cfg(target_os = "macos")]

#[path = "support/allocation_report.rs"]
mod allocation_report;

use std::path::{Path, PathBuf};
use std::process::{Command, Output};

fn fwp() -> &'static str {
    env!("CARGO_BIN_EXE_fwp")
}

fn root() -> &'static Path {
    Path::new(env!("CARGO_MANIFEST_DIR"))
}

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(
        output.status.success(),
        "{command:?} exited with {}: {}",
        output.status,
        String::from_utf8_lossy(&output.stderr)
    );
    output
}

struct Scratch(PathBuf);

impl Scratch {
    fn new(name: &str) -> Self {
        let path = std::env::temp_dir().join(format!("fwp-macos-{}-{name}", std::process::id()));
        std::fs::create_dir_all(&path).unwrap();
        Self(path)
    }
}

impl Drop for Scratch {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}

#[test]
fn native_tasks_and_autodiff_release_allocations() {
    let scratch = Scratch::new("runtime");
    for name in ["tasks", "autodiff_reverse", "wide_records"] {
        let src = root().join(format!("tests/run/{name}.fwp"));
        let exe = scratch.0.join(name);
        checked(
            Command::new(fwp())
                .args(["build"])
                .arg(&src)
                .args(["-O1", "-o"])
                .arg(&exe),
        );
        let interpreted = checked(
            Command::new(fwp())
                .args(["run", "--interp"])
                .arg(&src)
                .env("FWP_SEED", "42"),
        );
        let native = checked(
            Command::new(&exe)
                .env("FWP_SEED", "42")
                .env("FWP_ALLOC_STATS", "1"),
        );
        assert_eq!(native.stdout, interpreted.stdout, "{name}");
        let stderr = String::from_utf8_lossy(&native.stderr);
        let stats = allocation_report::parse(&stderr).unwrap();
        assert!(
            stats.allocated > 0 && stats.peak_live > 0,
            "{name}: {stats:?}"
        );
        assert_eq!(stats.live, 0, "{name}: {stats:?}");
        assert_eq!(stats.released, stats.allocated, "{name}: {stats:?}");
    }
}

#[test]
fn optimized_lists_match_interpreter() {
    let scratch = Scratch::new("optimized-lists");
    // These failed in the full Darwin sweep: flat-map, a right-fold
    // callback and filesystem lists. Keep this local reproducer short;
    // the full native corpus still executes the original long iterator.
    for name in ["traits", "stdlib_fixes", "cli_fs"] {
        let fixture = root().join(format!("tests/run/{name}.fwp"));
        let source = std::fs::read_to_string(&fixture).unwrap();
        let expected = std::fs::read_to_string(fixture.with_extension("out")).unwrap();
        let (source, expected) = if name == "stdlib_fixes" {
            (
                source.replace("300000", "300").replace("299999", "299"),
                expected.replace("[299999]", "[299]"),
            )
        } else {
            (source, expected)
        };
        let src = scratch.0.join(format!("{name}.fwp"));
        std::fs::write(&src, source).unwrap();
        let interpreted = checked(
            Command::new(fwp())
                .args(["run", "--interp"])
                .arg(&src)
                .current_dir(&scratch.0)
                .env("FWP_SEED", "42"),
        );
        assert_eq!(interpreted.stdout, expected.as_bytes(), "{name}");
        for opt in ["-O1", "-O2"] {
            let exe = scratch.0.join(format!("{name}{opt}"));
            checked(
                Command::new(fwp())
                    .args(["build"])
                    .arg(&src)
                    .args([opt, "-o"])
                    .arg(&exe),
            );

            let output = checked(
                Command::new(&exe)
                    .current_dir(&scratch.0)
                    .env("FWP_SEED", "42"),
            );
            assert_eq!(output.stdout, expected.as_bytes(), "{name}, {opt}");
        }
    }
}

#[test]
fn openssl_prefix_is_usable_in_both_backends() {
    // The macOS CI jobs always provide this prefix. A developer without
    // OpenSSL can still run the other platform regressions locally.
    if std::env::var_os("FWP_OPENSSL_DIR").is_none() {
        return;
    }
    let scratch = Scratch::new("openssl");
    let src = scratch.0.join("available.fwp");
    std::fs::write(&src, "main = tls.available () | echo\n").unwrap();
    let interpreted = checked(Command::new(fwp()).args(["run", "--interp"]).arg(&src));
    assert_eq!(interpreted.stdout, b"True\n");
    let exe = scratch.0.join("available");
    checked(
        Command::new(fwp())
            .args(["build"])
            .arg(&src)
            .arg("-o")
            .arg(&exe),
    );
    assert_eq!(checked(&mut Command::new(&exe)).stdout, interpreted.stdout);
}

#[test]
fn global_owner_survives_allocations_and_releases_storage() {
    let scratch = Scratch::new("global-owner");
    let generated = scratch.0.join("global.c");
    checked(
        Command::new(fwp())
            .args(["build"])
            .arg(root().join("examples/hello.fwp"))
            .args(["--emit-c", "-o"])
            .arg(&generated),
    );
    let source = std::fs::read_to_string(generated).unwrap().replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let source = format!(
        "{source}\n{}",
        r#"
static V global_value;
static __attribute__((noinline)) void make_owner(void) {
    global_value = fwp_rc_fresh(fwp_cstr("global owner"));
}
int main(void) {
    fwp_heap_start();
    size_t baseline = fwp_heap.live;
    make_owner();
    size_t owned_bytes = fwp_heap.live;
    for (int i = 0; i < 100; i++) {
        V scratch = fwp_rc_fresh(fwp_cstr("temporary"));
        if (strcmp(STR(global_value)->d, "global owner") || !fwp_rc_last(global_value)) return 2;
        fwp_rc_free_obj(scratch);
        if (fwp_heap.live != owned_bytes) return 3;
    }
    fwp_rc_free_obj(global_value);global_value = 0;
    if (fwp_heap.live != baseline) return 3;
    puts("global owner released");
    return 0;
}
"#
    );
    let omitted = source.replace(
        "fwp_rc_free_obj(global_value);",
        "/* omit global owner release */",
    );
    assert_ne!(omitted, source);
    for opt in ["-O1", "-O2"] {
        let exe = scratch.0.join(format!("global{opt}"));
        fwp::cgen::compile_c(&source, &exe, opt).unwrap();
        assert_eq!(
            checked(&mut Command::new(&exe)).stdout,
            b"global owner released\n"
        );
        fwp::cgen::compile_c(&omitted, &exe, opt).unwrap();
        assert_eq!(Command::new(&exe).output().unwrap().status.code(), Some(3));
    }
}

#[test]
fn darwin_library_names_and_unsupported_static_linking() {
    let scratch = Scratch::new("libraries");
    checked(
        Command::new(fwp())
            .args(["build"])
            .arg(root().join("tests/c-interop/geom.fwp"))
            .arg("--cdylib")
            .arg("-o")
            .arg("geom")
            .current_dir(&scratch.0),
    );
    assert!(scratch.0.join("libgeom.dylib").is_file());
    assert!(scratch.0.join("libgeom.h").is_file());
    let output = Command::new(fwp())
        .args(["build"])
        .arg(root().join("examples/hello.fwp"))
        .arg("--static")
        .arg("-o")
        .arg(scratch.0.join("hello"))
        .output()
        .unwrap();
    assert_eq!(output.status.code(), Some(2));
    assert!(String::from_utf8_lossy(&output.stderr).contains("--static is unavailable on macOS"));
}
