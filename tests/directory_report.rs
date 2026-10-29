//! The maintained dirstat example composes filesystem and collection ownership.
use std::collections::BTreeMap;
#[cfg(unix)]
use std::os::unix::fs::PermissionsExt;
use std::path::{Path, PathBuf};
use std::process::{Command, Output};

#[path = "support/ownership_ledger.rs"]
mod directory_failure_ledger;
#[path = "support/record_probe.rs"]
mod directory_failure_probe;
#[path = "support/file_application_memory.rs"]
mod file_application_memory;

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

#[test]
fn repeated_directory_reports_match_the_interpreter_and_release_storage() {
    let dir = fwp::cgen::TempDir::new("directory-report").unwrap();
    let root = dir.join("tree");
    std::fs::create_dir_all(root.join("nested")).unwrap();
    std::fs::create_dir(root.join(".hidden")).unwrap();
    for (path, bytes) in [
        ("first.rs", 7),
        ("nested/second.rs", 11),
        ("notes.txt", 5),
        ("nested/héllo.txt", 13),
        ("empty", 0),
        (".hidden/secret.rs", 17),
    ] {
        std::fs::write(root.join(path), vec![b'x'; bytes]).unwrap();
    }
    let source = dir.join("report.fwp");
    let empty_containers = r#"
empty-map : Map[String, String]
empty-map = map.empty
empty-set : Set[String]
empty-set = set.empty
empty-report : I64 -> () ! {IO}
empty-report = const ()
    | tap (const [(False, False), (False, True), (True, False), (True, True)]
        | map (both (uncurry and) (uncurry or)) | echo)
    | tap (const empty-map
    | both (map.insert "key" "value" | map.values) map.size | echo)
    | tap (const empty-set | both (set.insert "value" | set.to-list) set.size | echo)
    | const empty-map | map.insert "key" "value" | map.remove "key"
    | both map.to-list map.size | echo
"#;
    let program = format!(
        "{}\n{empty_containers}\nreport : I64 -> () ! {{FileIO, IO, Error[IoError]}}\nreport = const \"tree\" | tap (dirstat {{top = 10, all = False, sort = Bytes}} | each echo) | tap (dirstat {{top = 10, all = True, sort = Files}} | each echo) | dirstat {{top = 2, all = True, sort = Name}} | each echo\nmain = range 0 64 | each (tap empty-report | report)\n",
        include_str!("../examples/cli/dirstat.fwp")
    );
    std::fs::write(&source, program).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(compiler)
            .current_dir(dir.join("."))
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    let text = String::from_utf8_lossy(&reference.stdout);
    assert_eq!(text.matches("extension").count(), 64 * 3);
    assert!(text.contains("rs") && text.contains("txt") && text.contains("(none)"));
    {
        let cfile = dir.join("report.c");
        checked(
            Command::new(compiler)
                .args(["build", "--emit-c"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile),
        );
        let mut code = std::fs::read_to_string(cfile).unwrap();
        {
            let start = code
                .find("static void *fwp_main_thread(void *arg) {")
                .unwrap();
            let (runtime, main) = code.split_at(start);
            let measured = main.replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    size_t report_live_bytes = fwp_heap.live;\n")
                .replace("    /* Ownership observation point: before runtime teardown. */\n", "    /* Ownership observation point: before runtime teardown. */\n    if(fwp_heap.live > report_live_bytes) exit(229);\n");
            code = format!("{runtime}{measured}");
        }
        let binary = dir.join("report.exe");
        for opt in ["-O1", "-O2"] {
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();

            let actual = checked(Command::new(&binary).current_dir(dir.join(".")));
            assert_eq!(
                (&actual.stdout, &actual.stderr),
                (&reference.stdout, &reference.stderr),
                "counted {opt}"
            );
        }
    }
}

// The denied subtree follows a successfully visited directory in name order.
// Restore access even if an assertion fails so temporary files can be removed.
struct DeniedDirectory {
    path: PathBuf,
    #[cfg(unix)]
    original: std::fs::Permissions,
}

impl DeniedDirectory {
    fn new(path: PathBuf) -> Self {
        #[cfg(unix)]
        let original = std::fs::metadata(&path).unwrap().permissions();
        #[cfg(unix)]
        std::fs::set_permissions(&path, std::fs::Permissions::from_mode(0o000)).unwrap();
        #[cfg(windows)]
        checked(
            Command::new("icacls")
                .arg(&path)
                .args(["/deny", "*S-1-1-0:(RD)"]),
        );
        let denied = Self {
            path,
            #[cfg(unix)]
            original,
        };
        // Directory enumeration can report access failures while advancing the
        // iterator, after its constructor succeeded.
        let listing = std::fs::read_dir(&denied.path)
            .and_then(|entries| entries.collect::<Result<Vec<_>, _>>());
        #[cfg(windows)]
        if listing.is_ok() {
            for command in [
                Command::new("icacls").arg(&denied.path),
                Command::new("whoami").arg("/priv"),
            ] {
                let output = checked(command);
                eprintln!("{}", String::from_utf8_lossy(&output.stdout));
            }
        }
        let error = listing.unwrap_err();
        assert_eq!(
            error.kind(),
            std::io::ErrorKind::PermissionDenied,
            "{error}"
        );
        denied
    }
}

impl Drop for DeniedDirectory {
    fn drop(&mut self) {
        #[cfg(unix)]
        let restored = std::fs::set_permissions(&self.path, self.original.clone());
        // RD denies listing only; removing this test's deny restores the inherited ACL.
        // https://learn.microsoft.com/windows-server/administration/windows-commands/icacls
        #[cfg(windows)]
        let restored = Command::new("icacls")
            .arg(&self.path)
            .args(["/remove:d", "*S-1-1-0"])
            .output()
            .and_then(|output| {
                if output.status.success() {
                    Ok(())
                } else {
                    Err(std::io::Error::other(format!("{output:?}")))
                }
            });
        if let Err(error) = restored {
            if std::thread::panicking() {
                eprintln!("restore denied-directory permissions: {error}");
            } else {
                panic!("restore denied-directory permissions: {error}");
            }
        }
    }
}

fn populate_tree(root: &Path, files: usize) -> [BTreeMap<String, (usize, usize)>; 2] {
    let mut totals = [BTreeMap::new(), BTreeMap::new()];
    for i in 0..files {
        let folder = if i % 17 == 0 {
            ".hidden".to_string()
        } else {
            format!("dir-{}", i % 16)
        };
        let hidden = if i % 13 == 0 { "." } else { "" };
        let extension = ["rs", "txt", "gz", "RS", ""][i % 5];
        let suffix = if extension.is_empty() {
            String::new()
        } else {
            format!(".{extension}")
        };
        let relative = format!("{folder}/{hidden}héllo-{i}{suffix}");
        let path = root.join(&relative);
        std::fs::create_dir_all(path.parent().unwrap()).unwrap();
        let size = i * 7 % 97;
        std::fs::write(path, vec![b'x'; size]).unwrap();
        let key = if extension.is_empty() {
            "(none)"
        } else {
            extension
        };
        for (include_hidden, map) in totals.iter_mut().enumerate() {
            if include_hidden == 0 && relative.split('/').any(|part| part.starts_with('.')) {
                continue;
            }
            let total = map.entry(key.to_string()).or_insert((0, 0));
            total.0 += 1;
            total.1 += size;
        }
    }
    totals
}

fn check_scaled_report(output: &[u8], totals: &[BTreeMap<String, (usize, usize)>; 2]) {
    let text = std::str::from_utf8(output).unwrap();
    let blocks: Vec<_> = text.split("---\n").collect();
    assert_eq!(blocks.len(), 4, "{text}");
    assert!(blocks[3].is_empty());
    for (case, block) in blocks[..3].iter().enumerate() {
        let mut lines = block.lines();
        assert_eq!(
            lines.next().unwrap().split_whitespace().collect::<Vec<_>>(),
            ["extension", "files", "bytes"]
        );
        let mut expected: Vec<_> = totals[usize::from(case != 0)]
            .iter()
            .map(|(name, &(count, bytes))| (name.clone(), count, bytes))
            .collect();
        expected.sort_by(|a, b| match case {
            0 => b.2.cmp(&a.2).then_with(|| a.0.cmp(&b.0)),
            1 => b.1.cmp(&a.1).then_with(|| a.0.cmp(&b.0)),
            _ => a.0.cmp(&b.0),
        });
        if case == 2 {
            expected.truncate(2);
        }
        let actual: Vec<_> = lines
            .map(|line| {
                let fields: Vec<_> = line.split_whitespace().collect();
                assert_eq!(fields.len(), 3, "{line}");
                (
                    fields[0].to_string(),
                    fields[1].parse::<usize>().unwrap(),
                    fields[2].parse::<usize>().unwrap(),
                )
            })
            .collect();
        assert_eq!(actual, expected, "report case {case}");
    }
}

#[test]
fn scaled_directory_reports_bound_live_storage_and_release_error_paths() {
    let dir = fwp::cgen::TempDir::new("directory-live").unwrap();
    let source = dir.join("report.fwp");
    std::fs::write(
        &source,
        format!(
            "{}\n{}",
            include_str!("../examples/cli/dirstat.fwp"),
            include_str!("fixtures/directory_live.fwp")
        ),
    )
    .unwrap();
    std::fs::write(dir.join("ordinary-file"), "a file is not a directory").unwrap();
    std::fs::create_dir_all(dir.join("denied-tree/a-good")).unwrap();
    std::fs::create_dir_all(dir.join("denied-tree/z-denied")).unwrap();
    std::fs::write(
        dir.join("denied-tree/a-good/first.txt"),
        "visited before failure",
    )
    .unwrap();
    std::fs::write(dir.join("denied-tree/z-denied/secret.txt"), "unreadable").unwrap();
    let denied = DeniedDirectory::new(dir.join("denied-tree/z-denied"));
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let cfile = dir.join("report.c");
    checked(
        Command::new(compiler)
            .env_remove("FWP_NO_OPT")
            .args(["build", "--emit-c", "-O1"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile),
    );
    let measured = file_application_memory::observe(&std::fs::read_to_string(&cfile).unwrap());
    let omitted = measured.replace(
        "static void fwp_rc_free_obj(V v) {",
        "static void fwp_rc_free_obj(V v) { if(file_app_active) return;",
    );
    assert_ne!(omitted, measured);
    let unclosed = measured.replace(
        "#define FILE_APP_OMIT_CLOSE 0",
        "#define FILE_APP_OMIT_CLOSE 1",
    );
    assert_ne!(unclosed, measured);
    let binary = dir.join("report.exe");
    let control = dir.join("missing-release.exe");
    let handle_control = dir.join("missing-close.exe");
    for opt in ["-O1", "-O2"] {
        eprintln!("directory application: compile ownership controls at {opt}");
        fwp::cgen::compile_c(&measured, &binary, opt).unwrap();
        fwp::cgen::compile_c(&omitted, &control, opt).unwrap();
        fwp::cgen::compile_c(&unclosed, &handle_control, opt).unwrap();
        if let Some(path) = std::env::var_os("FWP_FILE_APPLICATION_ARTIFACTS") {
            let path = std::path::PathBuf::from(path);
            std::fs::create_dir_all(&path).unwrap();
            std::fs::copy(&source, path.join("directory.fwp")).unwrap();
            for (name, code, executable) in [
                ("measured", &measured, &binary),
                ("missing-release", &omitted, &control),
                ("missing-close", &unclosed, &handle_control),
            ] {
                std::fs::write(path.join(format!("directory-{name}{opt}.c")), code).unwrap();
                std::fs::copy(executable, path.join(format!("directory-{name}{opt}.bin"))).unwrap();
            }
        }
        for files in [64, 1024] {
            eprintln!("directory application: {files} files at {opt}");
            let tree = dir.join("tree");
            if tree.exists() {
                std::fs::remove_dir_all(&tree).unwrap();
            }
            let totals = populate_tree(&tree, files);
            let reference = checked(
                Command::new(compiler)
                    .current_dir(dir.path())
                    .env("FWP_NO_OPT", "1")
                    .args(["run", "--interp", "--link"])
                    .arg(
                        Path::new(env!("CARGO_MANIFEST_DIR"))
                            .join("tests/fixtures/file_app_checkpoint.c"),
                    )
                    .arg(&source),
            );
            assert!(reference.stderr.is_empty());
            check_scaled_report(&reference.stdout, &totals);
            let (actual, resident) = file_application_memory::run_observed(
                Command::new(&binary).current_dir(dir.path()),
            );
            file_application_memory::save_execution(
                "directory",
                files,
                "measured",
                opt,
                &actual,
                &resident,
            );
            assert!(actual.status.success(), "{actual:?}");
            assert_eq!(resident.lines().count(), 10, "{actual:?}");
            assert_eq!(actual.stdout, reference.stdout);
            file_application_memory::check_observations(&actual.stderr);
            for (name, executable) in [
                ("missing-release", &control),
                ("missing-close", &handle_control),
            ] {
                let broken = Command::new(executable)
                    .env("FWP_FILE_APP_RSS", "0")
                    .current_dir(dir.path())
                    .output()
                    .unwrap();
                file_application_memory::save_execution("directory", files, name, opt, &broken, "");
                assert_eq!(
                    broken.status.code(),
                    Some(241),
                    "{name}, {opt}, {files}: {broken:?}"
                );
            }
        }
    }
    drop(denied);
}

#[test]
fn directory_allocation_boundaries_unwind_or_exit_by_their_contract() {
    let dir = fwp::cgen::TempDir::new("directory-allocation-failures").unwrap();
    populate_tree(&dir.join("tree"), 64);
    // Force growth in one enumeration, as well as the existing nested tree.
    for i in 0..32 {
        std::fs::write(dir.join(format!("tree/root-{i}.txt")), b"root").unwrap();
    }
    let source = dir.join("report.fwp");
    std::fs::write(&source, format!("{}\nexport report-once : String -> I64 ! {{FileIO, Error[IoError]}}\nreport-once = dirstat {{top = 10, all = True, sort = Name}} | map string.length | sum\nmain = \"tree\" | report-once | echo\n", include_str!("../examples/cli/dirstat.fwp"))).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let raw = checked(
        Command::new(compiler)
            .current_dir(dir.path())
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    let optimized = checked(
        Command::new(compiler)
            .current_dir(dir.path())
            .env_remove("FWP_NO_OPT")
            .args(["run", "--interp"])
            .arg(&source),
    );
    assert_eq!(optimized.stdout, raw.stdout);
    assert_eq!(optimized.stderr, raw.stderr);
    let expected: u64 = std::str::from_utf8(&raw.stdout)
        .unwrap()
        .trim()
        .parse()
        .unwrap();
    let cfile = dir.join("report.c");
    checked(
        Command::new(compiler)
            .args(["build", "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile),
    );
    let code = std::fs::read_to_string(cfile).unwrap();
    let entry = code
        .split("/* report-once :")
        .nth(1)
        .unwrap()
        .split("static V f")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let entry = format!("f{entry}");
    let mut observed = directory_failure_ledger::instrument_native(&code, 65536);
    let mut replace = |before: &str, after: &str, count: usize| {
        assert_eq!(observed.matches(before).count(), count, "{before}");
        observed = observed.replace(before, after);
    };
    replace(
        "typedef uint64_t V;",
        r#"typedef uint64_t V;
#define PROBE_OMIT_MAP 0
#define PROBE_OMIT_CLOSE 0
static int probe_active,probe_stage,probe_phase,probe_fatal,probe_hit;
static unsigned probe_allocations;
static uint64_t probe_opened,probe_closed;
static void fwp_trap(const char *);
static void fwp_heap_oom(void);
static void probe_directory_failure(void) {
    if(probe_opened==probe_closed) _Exit(246);
    probe_hit=1;
    if(probe_fatal) fwp_heap_oom();
    fwp_trap("directory allocation boundary");
}
static void probe_directory_allocation(void) {
    if(probe_active && probe_stage==4 && probe_phase==4 && ++probe_allocations==2)
        probe_directory_failure();
}
"#,
        1,
    );
    replace("static inline void *fwp_heap_alloc(size_t n, int kind) {",
        "static inline void *fwp_heap_alloc(size_t n, int kind) {\n    if(kind!=0) probe_directory_allocation();",1);
    replace(
        "static inline void *fwp_alloc_init(size_t n) {",
        "static inline void *fwp_alloc_init(size_t n) {\n    probe_directory_allocation();",
        1,
    );
    for (before, after) in [
        ("DIR *directory=opendir(STR(path)->d);", "DIR *directory=opendir(STR(path)->d); if(directory) probe_opened++;"),
        ("if (*directory) closedir(*directory);", "if (*directory && (!PROBE_OMIT_CLOSE || !probe_active)) { if(closedir(*directory)) _Exit(245); probe_closed++; }"),
        ("HANDLE handle = FindFirstFileW(pattern, &entry);", "HANDLE handle = FindFirstFileW(pattern, &entry); if(handle != INVALID_HANDLE_VALUE) probe_opened++;"),
        ("if (*handle != INVALID_HANDLE_VALUE) FindClose(*handle);", "if (*handle != INVALID_HANDLE_VALUE && (!PROBE_OMIT_CLOSE || !probe_active)) { if(!FindClose(*handle)) _Exit(245); probe_closed++; }"),
    ] { replace(before,after,1); }
    // Change only the two platform versions of dir.list, not other map builders.
    for signature in [
        "static V fwp_p_dir_list(V path, const fwp_desc *err, void (*drop_list)(V)) {",
        "static V fwp_p_dir_list(V path, const fwp_desc *error, void (*drop_list)(V)) {",
    ] {
        let start = observed.find(signature).unwrap();
        let end = start + observed[start..].find("\n}\n").unwrap() + 3;
        let mut body = observed[start..end].to_owned();
        for marker in [
            "owner.items=(V *)fwp_mem_alloc(capacity*sizeof(V));",
            "owner.items[owner.count]=fwp_rc_fresh(",
        ] {
            assert_eq!(body.matches(marker).count(), 1);
            let check = if marker.starts_with("owner.items[") {
                "if(probe_active && probe_stage==2 && owner.count==3) probe_directory_failure(); "
            } else {
                "if(probe_active && probe_stage==1) probe_directory_failure(); "
            };
            body = body.replace(marker, &format!("{check}{marker}"));
        }
        let grow = if body.contains("owner.items=fwp_mem_realloc(") {
            "owner.items=fwp_mem_realloc("
        } else {
            "owner.items = (V *)fwp_mem_realloc("
        };
        assert_eq!(body.matches(grow).count(), 1);
        body = body.replace(
            grow,
            &format!("if(probe_active && probe_stage==3) probe_directory_failure(); {grow}"),
        );
        let protect = if body.contains("fwp_map_protect(&owner,&owner_cleanup);") {
            "fwp_map_protect(&owner,&owner_cleanup);"
        } else {
            "fwp_map_protect(&owner,&cleanup);"
        };
        assert_eq!(body.matches(protect).count(), 1);
        body = body.replace(
            protect,
            &format!("if(!PROBE_OMIT_MAP || !probe_active) {protect}"),
        );
        assert_eq!(
            body.matches("V result=fwp_map_finish_protected(").count(),
            1
        );
        body = body.replace(
            "V result=fwp_map_finish_protected(",
            "probe_phase=4; V result=fwp_map_finish_protected(",
        );
        body = body.replace(
            "\n    fwp_cleanup_pop(",
            "\n    probe_phase=0; fwp_cleanup_pop(",
        );
        observed.replace_range(start..end, &body);
    }
    observed = observed.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let probe = include_str!("fixtures/directory_allocation_failures.c")
        .replace("REPORT", &entry)
        .replace("EXPECTED", &format!("UINT64_C({expected})"));
    let healthy = format!("{observed}\n{probe}");
    for opt in ["-O1", "-O2"] {
        let binary = dir.join(format!("ordinary{opt}.exe"));
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();
        let actual = checked(Command::new(&binary).current_dir(dir.path()));
        assert_eq!((&actual.stdout, &actual.stderr), (&raw.stdout, &raw.stderr));
        for (name, program, status, message) in [
            (
                "healthy",
                healthy.clone(),
                0,
                "32 directory allocation-boundary traps and retries preserve owners\n",
            ),
            (
                "missing-close",
                healthy.replace("#define PROBE_OMIT_CLOSE 0", "#define PROBE_OMIT_CLOSE 1"),
                241,
                "directory handles remain open\n",
            ),
            (
                "missing-builder",
                healthy.replace("#define PROBE_OMIT_MAP 0", "#define PROBE_OMIT_MAP 1"),
                242,
                "directory owners remain live\n",
            ),
        ] {
            let binary = dir.join(format!("{name}{opt}.exe"));
            fwp::cgen::compile_c(&program, &binary, opt).unwrap();
            let output = Command::new(&binary)
                .current_dir(dir.path())
                .output()
                .unwrap();
            directory_failure_probe::save(
                "directory-allocation",
                &format!("{name}{opt}"),
                &program,
                &binary,
                &output,
            );
            assert_eq!(
                output.status.code(),
                Some(status),
                "{name} {opt}: {output:?}"
            );
            if status == 0 {
                assert_eq!(output.stdout, message.as_bytes());
                assert!(output.stderr.is_empty());
            } else {
                assert!(output.stdout.is_empty());
                assert_eq!(output.stderr, message.as_bytes());
            }
            if name == "healthy" {
                for stage in 1..=4 {
                    let output = Command::new(&binary)
                        .current_dir(dir.path())
                        .arg(stage.to_string())
                        .output()
                        .unwrap();
                    directory_failure_probe::save(
                        "directory-allocation",
                        &format!("fatal-{stage}{opt}"),
                        &program,
                        &binary,
                        &output,
                    );
                    assert_eq!(
                        output.status.code(),
                        Some(102),
                        "fatal {stage} {opt}: {output:?}"
                    );
                    assert!(output.stdout.is_empty());
                    assert_eq!(output.stderr, b"fwp: out of memory\n");
                }
            }
        }
    }
}
