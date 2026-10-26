//! The maintained dirstat example composes filesystem and collection ownership.
use std::collections::BTreeMap;
#[cfg(unix)]
use std::os::unix::fs::PermissionsExt;
use std::path::{Path, PathBuf};
use std::process::{Command, Output};

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
    for mode in ["tracing", "arc"] {
        let cfile = dir.join("report.c");
        checked(
            Command::new(compiler)
                .args(["build", "--gc", mode, "--emit-c"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile),
        );
        let mut code = std::fs::read_to_string(cfile).unwrap();
        if mode == "arc" {
            let start = code
                .find("static void *fwp_main_thread(void *arg) {")
                .unwrap();
            let (runtime, main) = code.split_at(start);
            let measured = main.replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    size_t report_live_bytes = fwp_heap.live;\n")
                .replace("    /* Ownership observation point: before runtime teardown. */\n", "    /* Ownership observation point: before runtime teardown. */\n    if(fwp_heap.ncollect || fwp_heap.enabled || fwp_heap.live > report_live_bytes) exit(229);\n");
            code = format!("{runtime}{measured}");
        }
        let binary = dir.join("report.exe");
        for opt in ["-O1", "-O2"] {
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            let verify = if mode == "arc" { "0" } else { "1" };
            let actual = checked(
                Command::new(&binary)
                    .current_dir(dir.join("."))
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", verify)
                    .env("FWP_GC_VERIFY", verify)
                    .env("FWP_REUSE_VERIFY", verify),
            );
            assert_eq!(
                (&actual.stdout, &actual.stderr),
                (&reference.stdout, &reference.stderr),
                "{mode} {opt}"
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
                Command::new(&binary)
                    .current_dir(dir.path())
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0"),
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
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
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
