//! Maintained applications compose text-file ownership without a collector.
use std::io::Write;
use std::process::{Command, Output, Stdio};

#[path = "support/ownership_ledger.rs"]
mod read_failure_ledger;
#[path = "support/record_probe.rs"]
mod read_failure_probe;

#[path = "support/file_application_memory.rs"]
mod file_application_memory;

#[test]
fn word_frequencies_preserve_separators_normalization_and_tie_order() {
    let dir = fwp::cgen::TempDir::new("wordfreq-application").unwrap();
    let source = std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("examples/wordfreq.fwp");
    let cases = [
        ("", ""),
        (" \t\r\n", ""),
        ("\u{b}\u{c}", "\u{b}\u{c}: 1\n"),
        ("Pear pear apple", "pear: 2\napple: 1\n"),
        ("z y x w v u", "u: 1\nv: 1\nw: 1\nx: 1\ny: 1\n"),
        ("... , . A", ": 3\na: 1\n"),
        ("É é Ä ä A", "a: 1\nÄ: 1\nÉ: 1\nä: 1\né: 1\n"),
    ];
    let check_cases = |command: &mut Command| {
        for (input, expected) in cases {
            let mut child = command
                .stdin(Stdio::piped())
                .stdout(Stdio::piped())
                .stderr(Stdio::piped())
                .spawn()
                .unwrap();
            child
                .stdin
                .take()
                .unwrap()
                .write_all(input.as_bytes())
                .unwrap();
            let output = child.wait_with_output().unwrap();
            assert!(output.status.success(), "{input:?}: {output:?}");
            assert_eq!(output.stdout, expected.as_bytes(), "{input:?}");
            assert!(output.stderr.is_empty(), "{input:?}: {output:?}");
        }
    };
    check_cases(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );

    let cfile = dir.join("wordfreq.c");
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env_remove("FWP_NO_OPT")
            .args(["build", "--emit-c", "-O2"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile),
    );
    let code = std::fs::read_to_string(cfile).unwrap();
    for opt in ["-O0", "-O2"] {
        let binary = dir.join("wordfreq.exe");
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();

        check_cases(&mut Command::new(binary));
    }
}

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

#[test]
fn maintained_text_tools_release_repeated_and_retained_results() {
    let dir = fwp::cgen::TempDir::new("text-file-tools").unwrap();
    let root = dir.path();
    std::fs::write(root.join("first.txt"), "Apple pie\nbanana\n世界\n").unwrap();
    std::fs::write(root.join("second.txt"), "apple\nhéllo\n世界\n").unwrap();
    for (name, library, main) in [
        (
            "todo",
            include_str!("../examples/cli/todo.fwp"),
            include_str!("fixtures/todo_repeated.fwp"),
        ),
        (
            "grep",
            include_str!("../examples/cli/grep.fwp"),
            include_str!("fixtures/grep_repeated.fwp"),
        ),
    ] {
        let source = root.join(format!("{name}.fwp"));
        std::fs::write(&source, format!("{library}\n{main}")).unwrap();
        let reference = checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .current_dir(root)
                .env("FWP_NO_OPT", "1")
                .args(["run", "--interp"])
                .arg(&source),
        );
        let stdout = String::from_utf8_lossy(&reference.stdout);
        if name == "todo" {
            assert_eq!(stdout.matches("added\n").count(), 128);
            assert!(stdout.contains("[x] buy héllo") && stdout.contains("[ ] write 世界"));
        } else {
            assert_eq!(stdout.matches("first.txt:1:Apple pie").count(), 64);
            assert_eq!(stdout.matches("second.txt:1:apple").count(), 64);
        }
        let optimized = checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .current_dir(root)
                .env_remove("FWP_NO_OPT")
                .args(["run", "--interp"])
                .arg(&source),
        );
        assert_eq!(
            (&optimized.stdout, &optimized.stderr),
            (&reference.stdout, &reference.stderr)
        );

        let cfile = root.join("tool.c");
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .env_remove("FWP_NO_OPT")
                .args(["build", "--emit-c"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile),
        );
        let mut code = std::fs::read_to_string(cfile).unwrap();

        let start = code
            .find("static void *fwp_main_thread(void *arg) {")
            .unwrap();
        let (runtime, main) = code.split_at(start);
        assert_eq!(main.matches("    fwp_init_consts();\n").count(), 1);
        assert_eq!(
            main.matches("    /* Ownership observation point: before runtime teardown. */\n")
                .count(),
            1
        );
        let measured = main.replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    size_t text_live_bytes = fwp_heap.live;\n")
                    .replace("    /* Ownership observation point: before runtime teardown. */\n", "    /* Ownership observation point: before runtime teardown. */\n    if(fwp_heap.live > text_live_bytes) exit(239);\n");
        code = format!("{runtime}{measured}");

        let binary = root.join("tool.exe");
        for opt in ["-O1", "-O2"] {
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();

            let actual = checked(Command::new(&binary).current_dir(root));
            assert_eq!(
                (&actual.stdout, &actual.stderr),
                (&reference.stdout, &reference.stderr),
                "{name} counted {opt}"
            );
            assert!(!root.join("tasks.txt").exists());
            assert_eq!(
                std::fs::read_to_string(root.join("first.txt")).unwrap(),
                "Apple pie\nbanana\n世界\n"
            );
        }
    }
}

#[test]
fn maintained_text_command_lines_match_raw_interpretation() {
    let dir = fwp::cgen::TempDir::new("text-command-lines").unwrap();
    let root = dir.path();
    std::fs::write(root.join("input.txt"), "Apple pie\nbanana\n世界\n").unwrap();
    for (name, library, cases) in [
        (
            "todo",
            include_str!("../examples/cli/todo.fwp"),
            vec![
                (vec!["add", "buy", "héllo"], "", "added\n", 0),
                (vec!["done", "1"], "", "item 1 is done\n", 0),
                (vec!["list"], "", "  1. [x] buy héllo\n", 0),
                (vec!["clear"], "", "cleared\n", 0),
                (vec!["list"], "", "", 0),
            ],
        ),
        (
            "grep",
            include_str!("../examples/cli/grep.fwp"),
            vec![
                (vec!["-in", "apple", "input.txt"], "", "1:Apple pie\n", 0),
                (vec!["-vc", "a"], "a\nhéllo\n世界\n", "2\n", 0),
                (vec!["-c", "missing", "input.txt"], "", "0\n", 1),
                (vec!["世界", "input.txt"], "", "世界\n", 0),
            ],
        ),
    ] {
        let source = root.join(format!("{name}.fwp"));
        std::fs::write(&source, library).unwrap();
        for mode in ["interp", "native"] {
            let todo = root.join("todo.txt");
            if todo.exists() {
                std::fs::remove_file(&todo).unwrap();
            }
            let executable = root.join(format!("{name}{}", std::env::consts::EXE_SUFFIX));
            if mode != "interp" {
                let mut build = Command::new(env!("CARGO_BIN_EXE_fwp"));
                build.args(["build", "-O2"]).arg(&source);
                if name == "todo" {
                    build.arg("--cli");
                } else {
                    build.args(["--fn", "grep"]);
                }
                checked(build.arg("-o").arg(&executable));
            }
            for (arguments, input, expected, status) in &cases {
                let mut command = if mode == "interp" {
                    let mut c = Command::new(env!("CARGO_BIN_EXE_fwp"));
                    c.args(["exec", "--interp"]).env("FWP_NO_OPT", "1");
                    if name == "todo" {
                        c.arg("--cli").arg(&source);
                    } else {
                        c.arg(&source).arg("grep");
                    }
                    c
                } else {
                    Command::new(&executable)
                };
                let mut child = command
                    .args(arguments)
                    .current_dir(root)
                    .env_remove("TODO_FILE")
                    .env_remove("FWP_OUT")
                    .stdin(Stdio::piped())
                    .stdout(Stdio::piped())
                    .stderr(Stdio::piped())
                    .spawn()
                    .unwrap();
                child
                    .stdin
                    .take()
                    .unwrap()
                    .write_all(input.as_bytes())
                    .unwrap();
                let result = child.wait_with_output().unwrap();
                assert_eq!(
                    result.status.code(),
                    Some(*status),
                    "{name} {mode}: {result:?}"
                );
                assert_eq!(result.stdout, expected.as_bytes(), "{name} {mode}");
                assert!(result.stderr.is_empty(), "{name} {mode}: {result:?}");
            }
        }
    }
}

#[test]
fn scaled_text_tools_release_partial_results_and_file_handles() {
    for (program, library, fixture) in [
        (
            "wc",
            include_str!("../examples/cli/wc.fwp"),
            include_str!("fixtures/wc_live.fwp"),
        ),
        (
            "grep",
            include_str!("../examples/cli/grep.fwp"),
            include_str!("fixtures/grep_live.fwp"),
        ),
        (
            "csv",
            include_str!("../examples/cli/csvtool.fwp"),
            include_str!("fixtures/csv_live.fwp"),
        ),
        (
            "todo",
            include_str!("../examples/cli/todo.fwp"),
            include_str!("fixtures/todo_live.fwp"),
        ),
    ] {
        let dir = fwp::cgen::TempDir::new(program).unwrap();
        let source = dir.join(format!("{program}.fwp"));
        std::fs::write(&source, format!("{library}\n{fixture}")).unwrap();
        std::fs::write(dir.join("invalid.txt"), [b'a', b'\n', 0xff]).unwrap();
        let compiler = env!("CARGO_BIN_EXE_fwp");
        let cfile = dir.join(format!("{program}.c"));
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
        let unclosed = measured.replace(
            "#define FILE_APP_OMIT_CLOSE 0",
            "#define FILE_APP_OMIT_CLOSE 1",
        );
        assert_ne!(omitted, measured);
        assert_ne!(unclosed, measured);
        let raw_leak = measured.replace(
            "#define FILE_APP_OMIT_RAW_FREE 0",
            "#define FILE_APP_OMIT_RAW_FREE 1",
        );
        assert_ne!(raw_leak, measured);
        let unclosed_write = measured.replace(
            "#define FILE_APP_OMIT_WRITE_CLOSE 0",
            "#define FILE_APP_OMIT_WRITE_CLOSE 1",
        );
        assert_ne!(unclosed_write, measured);
        for opt in ["-O1", "-O2"] {
            let mut binaries = vec![
                dir.join("measured.exe"),
                dir.join("missing-release.exe"),
                dir.join("missing-close.exe"),
                dir.join("missing-buffer-free.exe"),
            ];
            let mut variants = vec![
                ("measured", &measured),
                ("missing-release", &omitted),
                ("missing-close", &unclosed),
                ("missing-buffer-free", &raw_leak),
            ];
            if program == "todo" {
                binaries.push(dir.join("missing-write-close.exe"));
                variants.push(("missing-write-close", &unclosed_write));
            }
            for ((label, code), binary) in variants.iter().zip(&binaries) {
                eprintln!("file application {program}: compile {label} at {opt}");
                fwp::cgen::compile_c(code, binary, opt).unwrap();
                if let Some(path) = std::env::var_os("FWP_FILE_APPLICATION_ARTIFACTS") {
                    let path = std::path::PathBuf::from(path);
                    std::fs::create_dir_all(&path).unwrap();
                    std::fs::copy(&source, path.join(format!("{program}.fwp"))).unwrap();
                    std::fs::write(path.join(format!("{program}-{label}{opt}.c")), code).unwrap();
                    std::fs::copy(binary, path.join(format!("{program}-{label}{opt}.bin")))
                        .unwrap();
                }
            }
            for lines in [128, 4096] {
                let first = if program == "csv" {
                    let mut text = String::from("id,name,city\n");
                    for i in 0..lines {
                        text.push_str(&format!("{i},\"héllo, {i}\",\"say \"\"hi\"\"\"\n"));
                    }
                    text
                } else if program == "todo" {
                    (0..lines)
                        .map(|i| format!("[ ] task héllo {i}\n"))
                        .collect()
                } else {
                    "Apple pie\nhéllo 世界\n\nlast\n".repeat(lines / 4)
                };
                let second = "one\ttwo three\n\n".repeat(lines / 2);
                std::fs::write(dir.join("first.txt"), &first).unwrap();
                std::fs::write(dir.join("second.txt"), &second).unwrap();
                if program == "todo" {
                    std::fs::write(dir.join("seed.txt"), &first).unwrap();
                }
                let counts = [&first, &second].map(|text| {
                    (
                        text.bytes().filter(|&byte| byte == b'\n').count(),
                        text.split([' ', '\t', '\r', '\n'])
                            .filter(|word| !word.is_empty())
                            .count(),
                        text.len(),
                    )
                });
                let expected = [
                    counts[0],
                    counts[1],
                    (
                        counts[0].0 + counts[1].0,
                        counts[0].1 + counts[1].1,
                        counts[0].2 + counts[1].2,
                    ),
                ];
                eprintln!("file application {program}: interpret {lines} lines for {opt}");
                let reference = checked(
                    Command::new(compiler)
                        .current_dir(dir.path())
                        .env("FWP_NO_OPT", "1")
                        .args(["run", "--interp", "--link"])
                        .arg(
                            std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
                                .join("tests/fixtures/file_app_checkpoint.c"),
                        )
                        .arg(&source),
                );
                assert!(reference.stderr.is_empty());
                if program == "wc" {
                    let rows: Vec<_> = std::str::from_utf8(&reference.stdout)
                        .unwrap()
                        .lines()
                        .collect();
                    assert_eq!(rows.len(), 3);
                    for ((row, expected), name) in
                        rows.iter()
                            .zip(expected)
                            .zip(["first.txt", "second.txt", "total"])
                    {
                        let fields: Vec<_> = row.split_whitespace().collect();
                        assert_eq!(fields.len(), 4);
                        assert_eq!(fields[3], name);
                        assert_eq!(
                            (
                                fields[0].parse::<usize>().unwrap(),
                                fields[1].parse::<usize>().unwrap(),
                                fields[2].parse::<usize>().unwrap()
                            ),
                            expected
                        );
                    }
                } else {
                    let mut expected = String::new();
                    if program == "grep" {
                        expected.push_str("0\n");
                        for (index, line) in first.lines().enumerate() {
                            if line.to_ascii_lowercase().contains('a') {
                                expected.push_str(&format!("first.txt:{}:{line}\n", index + 1));
                            }
                        }
                        expected.push_str(&format!(
                            "0\nfirst.txt:{}\nsecond.txt:{lines}\n1\nfirst.txt:0\nsecond.txt:0\n",
                            first.lines().filter(|line| !line.contains('a')).count()
                        ));
                    } else if program == "todo" {
                        for i in 0..lines {
                            expected.push_str(&format!("{:>3}. [ ] task héllo {i}\n", i + 1));
                        }
                        for i in 1..lines {
                            expected.push_str(&format!("{i:>3}. [ ] task héllo {i}\n"));
                        }
                        expected.push_str(&format!("{lines:>3}. [ ] new 世界\n"));
                    } else {
                        expected.push_str("name\tid\n");
                        for i in 0..lines {
                            expected.push_str(&format!("héllo, {i}\t{i}\n"));
                        }
                    }
                    assert_eq!(reference.stdout, expected.as_bytes(), "{program}, {lines}");
                }
                for (index, binary) in binaries.iter().enumerate() {
                    eprintln!(
                        "file application {program}: run variant {index}, {lines} lines, {opt}"
                    );
                    let mut command = Command::new(binary);
                    command.current_dir(dir.path());
                    let (actual, resident) = if index == 0 {
                        file_application_memory::run_observed(&mut command)
                    } else {
                        (
                            command.env("FWP_FILE_APP_RSS", "0").output().unwrap(),
                            String::new(),
                        )
                    };
                    file_application_memory::save_execution(
                        program,
                        lines,
                        variants[index].0,
                        opt,
                        &actual,
                        &resident,
                    );
                    assert_eq!(
                        actual.status.code(),
                        Some(if index == 0 { 0 } else { 241 }),
                        "{opt}, {lines}: {actual:?}"
                    );
                    if index == 0 {
                        assert_eq!(resident.lines().count(), 10, "{actual:?}");
                        assert_eq!(actual.stdout, reference.stdout);
                        if program == "todo" {
                            assert_eq!(
                                std::fs::read_to_string(dir.join("seed.txt")).unwrap(),
                                first
                            );
                            assert_eq!(
                                std::fs::read_to_string(dir.join("first.txt")).unwrap(),
                                format!("{first}[ ] partial\n")
                            );
                            assert!(!dir.join("missing-dir").exists());
                        }
                        file_application_memory::check_observations(&actual.stderr);
                    }
                }
            }
        }
    }
}

#[test]
fn file_read_allocation_boundaries_release_scratch_handles_and_prior_results() {
    let dir = fwp::cgen::TempDir::new("file-read-allocation-failures").unwrap();
    std::fs::write(dir.join("input"), vec![b'x'; 150000]).unwrap();
    for (kind, body) in [
        ("text", "both file.read file.read | uncurry concat | string.length"),
        ("bytes", "both file.read-bytes file.read-bytes | both (.0 | bytes.length) (.1 | bytes.length) | uncurry add"),
    ] {
        let source = dir.join(format!("{kind}.fwp"));
        std::fs::write(&source, format!("export read-pair : String -> I64 ! {{FileIO, Error[IoError]}}\nread-pair = {body}\nmain = \"input\" | read-pair | echo\n")).unwrap();
        let compiler = env!("CARGO_BIN_EXE_fwp");
        for optimized in [false, true] {
            let mut command = Command::new(compiler);
            command.current_dir(dir.path()).args(["run", "--interp"]).arg(&source);
            if optimized { command.env_remove("FWP_NO_OPT"); } else { command.env("FWP_NO_OPT", "1"); }
            let result = checked(&mut command);
            assert_eq!(result.stdout, b"300000\n");
            assert!(result.stderr.is_empty());
        }
        let cfile = dir.join(format!("{kind}.c"));
        checked(Command::new(compiler).args(["build", "--fn", "read-pair", "--emit-c"])
            .arg(&source).arg("-o").arg(&cfile));
        let code = std::fs::read_to_string(&cfile).unwrap();
        if let Some(root) = std::env::var_os("FWP_ARC_ARTIFACTS") {
            let inputs = std::path::Path::new(&root).join("file-read-allocation-input");
            std::fs::create_dir_all(&inputs).unwrap();
            std::fs::copy(&source, inputs.join(format!("{kind}.fwp"))).unwrap();
            std::fs::write(inputs.join(format!("{kind}-entry.c")), &code).unwrap();
        }

        let entry = format!("f{}", code.split("/* read-pair :").nth(1).unwrap()
            .split("static V f").nth(1).unwrap().split('(').next().unwrap());
        let mut observed = read_failure_ledger::instrument_native(&code, 65536);
        let declarations = r#"typedef uint64_t V;
#define READ_OMIT_CLOSE 0
#define READ_OMIT_RAW 0
#define READ_OMIT_OWNER 0
static int read_active,read_stage,read_target,read_number,read_fatal,read_hit;
static size_t read_opened,read_closed,read_raw;
static void fwp_trap(const char *);
static void fwp_heap_oom(void);
static void read_boundary(int stage) {
    if (!read_active || read_number!=read_target || stage!=read_stage) return;
    if ((stage<3 && read_opened!=read_closed+1) ||
        (stage==3 && read_opened!=read_closed) ||
        (stage==1 && read_raw) || (stage>1 && !read_raw)) _Exit(246);
    read_hit=1;
    if(read_fatal) fwp_heap_oom();
    fwp_trap("file read allocation boundary");
}
"#;
        assert_eq!(observed.matches("typedef uint64_t V;").count(), 1);
        observed = observed.replacen("typedef uint64_t V;", declarations, 1);
        let buffer = "typedef struct { char *d; size_t len, cap; } fwp_buf;";
        assert_eq!(observed.matches(buffer).count(), 1);
        observed = observed.replacen(buffer, &format!("{buffer}\nstatic fwp_buf *read_buffer;"), 1);
        let mut replace = |before: &str, after: &str| {
            assert_eq!(observed.matches(before).count(), 1, "{before}");
            observed = observed.replacen(before, after, 1);
        };
        replace("        char *data = (char *)realloc(b->d, cap);", "        if(b==read_buffer) read_boundary(b->cap ? 2 : 1);\n        char *data = (char *)realloc(b->d, cap);");
        replace("        b->d = data;\n        b->cap = cap;", "        if(b==read_buffer) read_raw += cap-b->cap;\n        b->d = data;\n        b->cap = cap;");
        replace("static void fwp_mem_free(void *p) {\n", "static void fwp_mem_free(void *p) {\n    if(READ_OMIT_OWNER && read_active) return;\n");
        // Only file.read/read-bytes use this tracked buffer. Other buffers and
        // allocator pages are outside its raw-storage ledger.
        for signature in ["static V buf_to_str(", "static void fwp_file_buffer_cleanup("] {
            let start = observed.find(signature).unwrap();
            let end = start + observed[start..].find("\n}").unwrap() + 2;
            let body = &observed[start..end];
            assert_eq!(body.matches("    free(b->d);").count(), 1);
            let mut body = body.replace("    free(b->d);", "    if(b==read_buffer) { if(!READ_OMIT_RAW || !read_active || read_number!=read_target) { free(b->d); read_raw-=b->cap; } read_buffer=NULL; } else free(b->d);");
            if signature.starts_with("static V buf_to_str") {
                let marker="    V r = fwp_str_new(b->d ? b->d : \"\", b->len);";
                assert_eq!(body.matches(marker).count(), 1);
                body=body.replace(marker,&format!("    if(b==read_buffer) read_boundary(3);\n{marker}"));
            }
            observed.replace_range(start..end, &body);
        }
        let signature = "static V fwp_p_file_read_impl(";
        let start = observed.find(signature).unwrap();
        let end = start + observed[start..].find("\n}").unwrap() + 2;
        let mut body = observed[start..end].to_owned();
        for (before, after) in [
            ("    if (!f) return fwp_io_error_path(\"read\", STR(path)->d, err);", "    if (!f) return fwp_io_error_path(\"read\", STR(path)->d, err);\n    read_number++; read_opened++;"),
            ("    fwp_buf b = {0};", "    fwp_buf b = {0};\n    read_buffer=&b;"),
            ("    fclose(f);", "    if(fclose(f)) _Exit(247); read_closed++;"),
        ] {
            assert_eq!(body.matches(before).count(), 1, "{before}");
            body=body.replace(before,after);
        }
        observed.replace_range(start..end,&body);
        // Count only the unwind close for this read; normal closes above remain
        // healthy even when the deliberate fault omits its cleanup callback.
        let signature="static void fwp_close_scoped_file(";
        let start=observed.find(signature).unwrap();
        let end=start+observed[start..].find("\n}").unwrap()+2;
        let body=&observed[start..end];
        assert_eq!(body.matches("fclose(file->stream);").count(),1);
        let body=body.replace("fclose(file->stream);", "if(!READ_OMIT_CLOSE || !read_active) { if(fclose(file->stream)) _Exit(247); read_closed++; }");
        observed.replace_range(start..end,&body);
        observed=observed.replace("int main(int argc, char **argv)","int original_main(int argc, char **argv)");
        let probe=include_str!("fixtures/file_allocation_failures.c").replace("READ_PAIR",&entry);
        let healthy=format!("{observed}\n{probe}");
        for opt in ["-O1","-O2"] {
            for (name, program, status, message) in [
                ("healthy", healthy.clone(), 0, "48 file read allocation-boundary traps and retries preserve owners\n"),
                ("missing-close", healthy.replace("#define READ_OMIT_CLOSE 0","#define READ_OMIT_CLOSE 1"), 241, "file read handles remain open\n"),
                ("missing-scratch", healthy.replace("#define READ_OMIT_RAW 0","#define READ_OMIT_RAW 1"), 242, "file read scratch remains live\n"),
                ("missing-owner", healthy.replace("#define READ_OMIT_OWNER 0","#define READ_OMIT_OWNER 1"), 243, "file read owners remain live\n"),
            ] {
                let binary=dir.join(format!("{kind}-{name}{opt}.exe"));
                fwp::cgen::compile_c(&program,&binary,opt).unwrap();
                let output=Command::new(&binary).current_dir(dir.path()).output().unwrap();
                read_failure_probe::save("file-read-allocation",&format!("{kind}-{name}{opt}"),&program,&binary,&output);
                assert_eq!(output.status.code(),Some(status),"{kind} {name} {opt}: {output:?}");
                if status==0 { assert_eq!(output.stdout,message.as_bytes()); assert!(output.stderr.is_empty()); }
                else { assert!(output.stdout.is_empty()); assert_eq!(output.stderr,message.as_bytes()); }
                if name=="healthy" {
                    for stage in 1..=3 { for target in 1..=2 {
                        let output=Command::new(&binary).current_dir(dir.path()).args([stage.to_string(),target.to_string()]).output().unwrap();
                        read_failure_probe::save("file-read-allocation",&format!("{kind}-fatal-{stage}-{target}{opt}"),&program,&binary,&output);
                        assert_eq!(output.status.code(),Some(102),"{kind} {stage} {target} {opt}: {output:?}");
                        assert!(output.stdout.is_empty());
                        assert_eq!(output.stderr,b"fwp: out of memory\n");
                    } }
                }
            }
        }
    }
}
