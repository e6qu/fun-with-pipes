//! Binary file reads preserve arbitrary bytes; text reads validate UTF-8.
use std::process::{Command, Output};
fn checked(command: &mut Command) -> Output {
    let out = command.output().unwrap();
    assert!(
        out.status.success(),
        "{command:?}: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    out
}
#[test]
fn byte_reads_and_text_validation_match_the_unoptimized_interpreter() {
    let dir = fwp::cgen::TempDir::new("fwp-file-read-kinds").unwrap();
    let binary = dir.join("binary");
    let text = dir.join("text");
    let empty = dir.join("empty");
    std::fs::write(&binary, [0, 255, 192, 128, 10]).unwrap();
    std::fs::write(&text, "héllo\n").unwrap();
    std::fs::write(&empty, []).unwrap();
    let src = dir.join("probe.fwp");
    std::fs::write(
        &src,
        r#"
main = [
    "BINARY" | file.read-bytes | bytes.to-list | echo,
    "BINARY" | attempt file.read | echo,
    "TEXT" | file.read | echo,
    "TEXT" | file.read-bytes | bytes.to-list | echo,
    "EMPTY" | file.read-bytes | bytes.to-list | echo,
    "EMPTY" | file.read | echo,
] | ignore
"#
        .replace("BINARY", &binary.to_string_lossy())
        .replace("TEXT", &text.to_string_lossy())
        .replace("EMPTY", &empty.to_string_lossy()),
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src),
    );
    assert!(reference
        .stdout
        .starts_with(b"[0, 255, 192, 128, 10]\nErr (IoError"));
    for opt in ["-O1", "-O2"] {
        let exe = dir.join("probe");
        checked(
            Command::new(fwp)
                .arg("build")
                .arg(&src)
                .args([opt, "-o"])
                .arg(&exe),
        );
        for gc in ["on", "off"] {
            for poison in ["0", "1"] {
                let out = checked(
                    Command::new(&exe)
                        .env("FWP_GC", gc)
                        .env("FWP_GC_STRESS", "1")
                        .env("FWP_GC_VERIFY", "1")
                        .env("FWP_REUSE_VERIFY", poison),
                );
                assert_eq!(out.stdout, reference.stdout);
                assert_eq!(out.stderr, reference.stderr);
            }
        }
    }
}
