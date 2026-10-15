//! Directory and environment snapshots own copies and release partial construction.
use std::path::Path;
use std::process::{Command, Output};
fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}
fn names(root: &Path) {
    std::fs::create_dir(root.join("names")).unwrap();
    std::fs::create_dir(root.join("empty")).unwrap();
    for name in (0..32)
        .map(|i| format!("name{i:02}"))
        .chain(["héllo", "empty file", "z"].map(str::to_string))
    {
        std::fs::write(root.join("names").join(name), "kept").unwrap();
    }
}
#[test]
fn snapshots_match_raw_interpretation() {
    let dir = fwp::cgen::TempDir::new("system-snapshots").unwrap();
    let root = dir.join(".");
    names(&root);
    let source = dir.join("snapshots.fwp");
    std::fs::write(&source, include_str!("fixtures/system_snapshots.fwp")).unwrap();
    let expected = checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .current_dir(&root)
            .env("FWP_NO_OPT", "1")
            .env("FWP_SNAPSHOT_COPY", "copied")
            .args(["run", "--interp"])
            .arg(&source),
    );
    for gc in ["tracing", "arc"] {
        let cfile = dir.join("snapshots.c");
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .env_remove("FWP_NO_OPT")
                .args(["build", "--gc", gc, "--emit-c"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(cfile).unwrap();
        let binary = dir.join("snapshots.exe");
        for optimization in ["-O1", "-O2"] {
            fwp::cgen::compile_c(&code, &binary, optimization).unwrap();
            let verify = if gc == "arc" { "0" } else { "1" };
            let actual = checked(
                Command::new(&binary)
                    .current_dir(&root)
                    .env("FWP_SNAPSHOT_COPY", "copied")
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", verify)
                    .env("FWP_GC_VERIFY", verify)
                    .env("FWP_REUSE_VERIFY", verify),
            );
            assert_eq!(
                (&actual.stdout, &actual.stderr),
                (&expected.stdout, &expected.stderr),
                "{gc} {optimization}"
            );
            assert!(root.join("made/a").is_dir());
        }
    }
}
fn instrument(mut code: String) -> String {
    let declarations = "static V snapshot_lossy(const char *,size_t);static V snapshot_record(size_t,const V *);static void *snapshot_alloc(size_t);static void *snapshot_leaf(size_t);static void *snapshot_resize(void *,size_t,size_t);\n";
    code = code.replace(
        "static V fwp_p_dir_list(",
        &format!("{declarations}static V fwp_p_dir_list("),
    );
    code = code.replace("static void fwp_directory_release(", "static DIR *snapshot_open(const char *);static int snapshot_close(DIR *);\nstatic void fwp_directory_release(")
        .replace("closedir(*directory)", "snapshot_close(*directory)");
    code = code.replace("static void fwp_win_find_finish(", "static V snapshot_wide(const wchar_t *,size_t);static HANDLE snapshot_find(const wchar_t *,WIN32_FIND_DATAW *);static BOOL snapshot_find_close(HANDLE);\nstatic void fwp_win_find_finish(")
        .replace("FindClose(*handle)", "snapshot_find_close(*handle)");
    code = code.replace("static void fwp_win_environment_finish(", "static LPWCH snapshot_environment(void);static BOOL snapshot_environment_free(LPWCH);\nstatic void fwp_win_environment_finish(")
        .replace("FreeEnvironmentStringsW(", "snapshot_environment_free(");
    for (start, end) in [
        ("static V fwp_p_dir_list(", "static V fwp_p_dir_create("),
        ("static V fwp_p_dir_create_all(", "static V fwp_p_env_cwd("),
    ] {
        let mut offset = 0;
        while let Some(found) = code[offset..].find(start) {
            let a = offset + found;
            let b = a + code[a..].find(end).unwrap();
            let body = code[a..b]
                .replace("fwp_str_lossy(", "snapshot_lossy(")
                .replace("fwp_record(", "snapshot_record(")
                .replace("fwp_mem_alloc(", "snapshot_alloc(")
                .replace("fwp_alloc_leaf(", "snapshot_leaf(")
                .replace("fwp_mem_realloc(", "snapshot_resize(")
                .replace("fwp_win_string(", "snapshot_wide(")
                .replace("opendir(", "snapshot_open(")
                .replace("FindFirstFileW(", "snapshot_find(")
                .replace("GetEnvironmentStringsW()", "snapshot_environment()");
            code.replace_range(a..b, &body);
            offset = a + body.len();
        }
    }
    code = code
        .replace(
            "static V fwp_map_finish_protected(",
            "static V snapshot_node(V,size_t,const V *);\nstatic V fwp_map_finish_protected(",
        )
        .replace(
            "V node = fwp_rc_fresh(fwp_data(1, 2, fields));",
            "V node = fwp_rc_fresh(snapshot_node(1, 2, fields));",
        )
        .replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        );
    code.push_str(include_str!("fixtures/system_snapshot_probe.c"));
    code
}
fn probe(binary: &Path, root: &Path, gc: &str, collect: &str) -> Command {
    let mut command = Command::new(binary);
    command.env_clear();
    for key in ["PATH", "SystemRoot", "TEMP", "TMP"] {
        if let Some(value) = std::env::var_os(key) {
            command.env(key, value);
        }
    }
    for i in 0..24 {
        command.env(format!("FWP_SNAPSHOT_{i:02}"), format!("value{i:02}"));
    }
    command
        .arg(root.join("names"))
        .arg(root.join("made/a"))
        .env("FWP_SNAPSHOT_COPY", "copied")
        .env("FWP_GC_STRESS", "0")
        .env("FWP_GC_VERIFY", if gc == "arc" { "0" } else { "1" })
        .env("FWP_REUSE_VERIFY", "0")
        .env("FWP_SNAPSHOT_COLLECTION", collect);
    command
}
#[test]
fn snapshots_release_copies_partial_results_and_system_handles() {
    let dir = fwp::cgen::TempDir::new("snapshot-cleanup").unwrap();
    let root = dir.join(".");
    names(&root);
    let source = dir.join("probe.fwp");
    std::fs::write(&source, "main = [task.yield (), echo \"probe\"] | ignore\n").unwrap();
    for gc in ["tracing", "arc"] {
        let cfile = dir.join("probe.c");
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .args(["build", "--gc", gc, "--emit-c"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile),
        );
        let code = instrument(std::fs::read_to_string(cfile).unwrap());
        let binary = dir.join("probe.exe");
        for optimization in ["-O1", "-O2"] {
            fwp::cgen::compile_c(&code, &binary, optimization).unwrap();
            for collect in if gc == "arc" {
                &["0"][..]
            } else {
                &["0", "1"][..]
            } {
                checked(&mut probe(&binary, &root, gc, collect));
            }
        }
        for (release, replacement, status) in [
            ("fwp_mem_free(owner->items);", "(void)owner->items;", 241),
            (
                if cfg!(windows) {
                    "snapshot_find_close(*handle)"
                } else {
                    "snapshot_close(*directory)"
                },
                "0",
                242,
            ),
        ] {
            assert!(code.contains(release));
            fwp::cgen::compile_c(&code.replace(release, replacement), &binary, "-O2").unwrap();
            let omitted = probe(&binary, &root, gc, "0").output().unwrap();
            assert_eq!(omitted.status.code(), Some(status), "{omitted:?}");
        }
    }
}
