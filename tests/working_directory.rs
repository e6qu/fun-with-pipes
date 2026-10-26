//! Working-directory lookup owns its result and reports unavailable paths.
#[cfg(unix)]
use std::io::{BufRead, BufReader, Read, Write};
#[cfg(unix)]
use std::process::Stdio;
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

#[test]
fn working_directory_matches_raw_interpretation() {
    let dir = fwp::cgen::TempDir::new("working-directory").unwrap();
    let root = dir.join("héllo directory");
    std::fs::create_dir(&root).unwrap();
    let source = dir.join("directory.fwp");
    std::fs::write(&source, "main = env.cwd () | echo\n").unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(compiler)
            .current_dir(&root)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    assert!(String::from_utf8_lossy(&reference.stdout).contains("héllo directory"));

    let cfile = dir.join("directory.c");
    checked(
        Command::new(compiler)
            .args(["build", "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile),
    );
    let code = std::fs::read_to_string(cfile).unwrap();
    let binary = dir.join("directory.exe");
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();

        let actual = checked(Command::new(&binary).current_dir(&root));
        assert_eq!(
            (&actual.stdout, &actual.stderr),
            (&reference.stdout, &reference.stderr)
        );
    }
}

#[cfg(unix)]
fn removed_directory(command: &mut Command, path: &std::path::Path) -> String {
    std::fs::create_dir(path).unwrap();
    let mut child = command
        .current_dir(path)
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .unwrap();
    let mut output = BufReader::new(child.stdout.take().unwrap());
    let mut ready = String::new();
    output.read_line(&mut ready).unwrap();
    assert_eq!(ready, "ready\n");
    std::fs::remove_dir(path).unwrap();
    child
        .stdin
        .take()
        .unwrap()
        .write_all(b"continue\n")
        .unwrap();
    let mut result = String::new();
    output.read_to_string(&mut result).unwrap();
    let done = child.wait_with_output().unwrap();
    assert!(done.status.success(), "{done:?}");
    assert!(done.stderr.is_empty(), "{done:?}");
    result
}

#[cfg(unix)]
#[test]
fn a_removed_directory_is_an_explicit_error() {
    let dir = fwp::cgen::TempDir::new("removed-directory").unwrap();
    let source = dir.join("removed.fwp");
    std::fs::write(&source,
        "main = [echo \"ready\", read-line () | ignore, attempt env.cwd () | show | echo] | ignore\n").unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = removed_directory(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
        &dir.join("gone"),
    );
    assert!(
        reference.starts_with("Err ") && reference.contains("cwd"),
        "{reference}"
    );

    let binary = dir.join("removed.exe");
    checked(
        Command::new(compiler)
            .args(["build", "-O2"])
            .arg(&source)
            .arg("-o")
            .arg(&binary),
    );
    assert_eq!(
        removed_directory(Command::new(&binary), &dir.join("gone")),
        reference
    );
}

fn instrument(mut code: String) -> String {
    if let Some(start) = code.find("static V fwp_win_string(") {
        let end = start + code[start..].find("\n}\n").unwrap() + 3;
        let body = code[start..end]
            .replace("malloc(", "cwd_alloc(")
            .replace("fwp_win_free", "cwd_free")
            .replace("free(bytes)", "cwd_free(bytes)")
            .replace("fwp_str_new(", "cwd_string_allocation(");
        let declarations = "static void *cwd_alloc(size_t);static void cwd_free(void *);static V cwd_string_allocation(const char *,size_t);\n";
        code.replace_range(start..end, &format!("{declarations}{body}"));
    }
    let mut offset = 0;
    while let Some(found) = code[offset..].find("static V fwp_p_env_cwd(") {
        let start = offset + found;
        let end = start + code[start..].find("\n}\n").unwrap() + 3;
        let body = code[start..end]
            .replace("getcwd(", "cwd_read(")
            .replace("fwp_str_lossy(", "cwd_string(")
            .replace("fwp_buf_release", "cwd_release")
            .replace("GetCurrentDirectoryW(", "cwd_read_wide(")
            .replace("fwp_win_string(", "cwd_string_wide(")
            .replace("malloc(", "cwd_alloc(")
            .replace("fwp_win_free", "cwd_free")
            .replace("free(path)", "cwd_free(path)");
        let declarations = "static V cwd_string(const char *,size_t);\n#ifdef _WIN32\nstatic DWORD cwd_read_wide(DWORD,wchar_t *);static V cwd_string_wide(const wchar_t *,size_t);static void *cwd_alloc(size_t);static void cwd_free(void *);\n#else\nstatic char *cwd_read(char *,size_t);static void cwd_release(void *);\n#endif\n";
        code.replace_range(start..end, &format!("{declarations}{body}"));
        offset = start + declarations.len() + body.len();
    }
    code
}

#[test]
fn directory_results_and_temporary_buffers_are_released() {
    let dir = fwp::cgen::TempDir::new("directory-ownership").unwrap();
    let source = dir.join("probe.fwp");
    std::fs::write(&source, "export exercise : () -> String ! {IO, Error[IoError]}\nexercise = env.cwd\nmain = exercise () | echo\n").unwrap();

    let cfile = dir.join("probe.c");
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--fn", "exercise", "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
    let entry = emitted[emitted.find("/* exercise :").unwrap()..]
        .split("static V f")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let code = instrument(emitted.clone()).replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    ) + &include_str!("fixtures/working_directory_probe.c")
        .replace("fEXERCISE", &format!("f{entry}"));
    let binary = dir.join("probe.exe");

    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();
        checked(&mut Command::new(&binary));
    }
    let uncounted = code.replace("fwp_rc_fresh(fwp_p_env_cwd(", "(fwp_p_env_cwd(");
    assert_ne!(uncounted, code);
    let unreleased = code.replace("cwd_live--;", "/* intentionally retain scratch */");
    for (broken, status) in [(uncounted, 219), (unreleased, 221)] {
        fwp::cgen::compile_c(&broken, &binary, "-O2").unwrap();
        let output = Command::new(&binary).output().unwrap();
        assert_eq!(output.status.code(), Some(status), "counted: {output:?}");
    }
}
