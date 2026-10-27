//! Terminal modes are restored before a failed read unwinds its frame.
use std::process::Command;

#[test]
fn terminal_echo_restores_after_success_and_traps() {
    let dir = fwp::cgen::TempDir::new("terminal-ownership").unwrap();
    let source = dir.join("terminal.fwp");
    std::fs::write(
        &source,
        "main = [task.yield (), term.read-secret () | echo] | ignore\n",
    )
    .unwrap();
    {
        let cfile = dir.join("terminal.c");
        let output = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile)
            .output()
            .unwrap();
        assert!(output.status.success(), "{output:?}");
        let mut code = std::fs::read_to_string(cfile).unwrap();
        let mut offset = 0;
        while let Some(found) = code[offset..].find("static V fwp_p_term_read_secret(void) {") {
            let start = offset + found;
            let end = start + code[start..].find("\n}").unwrap() + 2;
            let body = code[start..end].replace("fwp_p_read_line()", "terminal_test_read()");
            assert_ne!(body, code[start..end]);
            let replacement = format!("static V terminal_test_read(void);\n{body}");
            code.replace_range(start..end, &replacement);
            offset = start + replacement.len();
        }
        code = code.replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        );
        code.push_str(include_str!("fixtures/terminal_ownership_probe.c"));
        // glibc declares pseudo-terminal allocation APIs with GNU/XSI features.
        code = format!("#if defined(__linux__) && !defined(_GNU_SOURCE)\n#define _GNU_SOURCE 1\n#endif\n{code}");
        let binary = dir.join("probe.exe");
        for optimization in ["-O1", "-O2"] {
            fwp::cgen::compile_c(&code, &binary, optimization).unwrap();
            let result = Command::new(&binary).output().unwrap();
            assert!(
                result.status.success(),
                "counted {optimization}: {result:?}"
            );
        }
        // Drop the restore action only while unwinding. Normal return still restores.
        let broken = code
            .replace(
                "fwp_cleanup_push(&cleanup, fwp_terminal_restore, &terminal);",
                "fwp_cleanup_push(&cleanup, terminal_test_no_restore, &terminal);",
            )
            .replace(
                "fwp_cleanup_push(&cleanup, fwp_win_console_restore, &console);",
                "fwp_cleanup_push(&cleanup, terminal_test_no_restore, &console);",
            );
        assert_ne!(broken, code);
        let broken =
            format!("static void terminal_test_no_restore(void *p) {{ (void)p; }}\n{broken}");
        fwp::cgen::compile_c(&broken, &binary, "-O2").unwrap();
        let result = Command::new(&binary).output().unwrap();
        assert_eq!(result.status.code(), Some(245), "counted: {result:?}");
    }
}
