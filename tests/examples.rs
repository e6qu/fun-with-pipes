//! The tutorials (docs/tutorials/*/): each program runs with the
//! interpreter and natively and must print its `main.out`, and each
//! README must show the program, its output, and only code taken from the
//! program. The other examples must type-check. `FWP_BLESS=1` regenerates
//! the outputs.

use std::path::{Path, PathBuf};
use std::process::Command;

fn fwp() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_fwp"))
}

fn examples() -> PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR")).join("examples")
}

fn tutorials() -> Vec<PathBuf> {
    let dir = Path::new(env!("CARGO_MANIFEST_DIR")).join("docs/tutorials");
    let mut v: Vec<PathBuf> = std::fs::read_dir(dir)
        .unwrap()
        .map(|e| e.unwrap().path().join("main.fwp"))
        .filter(|p| p.exists())
        .collect();
    v.sort();
    v
}

/// The bodies of the fenced code blocks of a language in a Markdown file.
fn code_blocks(md: &str, lang: &str) -> Vec<String> {
    let mut out = Vec::new();
    let mut cur: Option<String> = None;
    for line in md.lines() {
        match &mut cur {
            None if line.trim_start() == format!("```{}", lang) => cur = Some(String::new()),
            Some(_) if line.trim_start() == "```" => out.push(cur.take().unwrap()),
            Some(b) => {
                b.push_str(line);
                b.push('\n');
            }
            None => {}
        }
    }
    out
}

#[test]
fn tutorial_readmes_match_their_programs() {
    for path in tutorials() {
        let dir = path.parent().unwrap();
        let readme = std::fs::read_to_string(dir.join("README.md")).unwrap();
        let program = std::fs::read_to_string(&path).unwrap();
        let output = std::fs::read_to_string(dir.join("main.out")).unwrap();
        assert!(
            readme.contains(program.trim_end()),
            "{}: README must show main.fwp",
            dir.display()
        );
        assert!(
            readme.contains(output.trim_end()),
            "{}: README must show main.out",
            dir.display()
        );
        let lines: Vec<&str> = program.lines().map(str::trim_end).collect();
        for block in code_blocks(&readme, "fwp") {
            assert!(
                block
                    .lines()
                    .filter(|l| !l.trim().is_empty())
                    .all(|l| lines.contains(&l.trim_end())),
                "{}: README code not in main.fwp:\n{}",
                dir.display(),
                block
            );
        }
    }
}

#[test]
fn tutorial_programs() {
    let have_cc = Command::new(std::env::var("CC").unwrap_or_else(|_| "cc".into()))
        .arg("--version")
        .output()
        .is_ok();
    for path in tutorials() {
        let out = Command::new(fwp())
            .args(["run", "--interp"])
            .arg(&path)
            .output()
            .unwrap();
        assert!(
            out.status.success(),
            "{}: {}",
            path.display(),
            String::from_utf8_lossy(&out.stderr)
        );
        let got = String::from_utf8_lossy(&out.stdout).into_owned();
        let expected_path = path.with_extension("out");
        if std::env::var("FWP_BLESS").is_ok() {
            std::fs::write(&expected_path, &got).unwrap();
            continue;
        }
        let expected = std::fs::read_to_string(&expected_path).unwrap_or_default();
        assert_eq!(got, expected, "{}", path.display());
        if have_cc {
            let exe = std::env::temp_dir().join(format!(
                "fwp-example-{}-{}",
                std::process::id(),
                path.parent()
                    .unwrap()
                    .file_name()
                    .unwrap()
                    .to_string_lossy()
            ));
            let b = Command::new(fwp())
                .arg("build")
                .arg(&path)
                .args(["-O1", "-o"])
                .arg(&exe)
                .output()
                .unwrap();
            assert!(b.status.success(), "{}", String::from_utf8_lossy(&b.stderr));
            let n = Command::new(&exe).output().unwrap();
            let _ = std::fs::remove_file(&exe);
            assert_eq!(
                String::from_utf8_lossy(&n.stdout),
                expected,
                "native {}",
                path.display()
            );
        }
    }
}

#[test]
fn other_examples_check() {
    for path in [
        "hello.fwp",
        "wordfreq.fwp",
        "server/api.fwp",
        "server/chat.fwp",
        "shell/tools.fwp",
        "services/main.fwp",
        "cli/wc.fwp",
        "cli/grep.fwp",
        "cli/todo.fwp",
        "cli/dirstat.fwp",
        "rest/books.fwp",
        "rest/shop.fwp",
        "rest/client.fwp",
        "rest/uploads.fwp",
    ] {
        let out = Command::new(fwp())
            .arg("check")
            .arg(examples().join(path))
            .output()
            .unwrap();
        assert!(
            out.status.success(),
            "{}: {}",
            path,
            String::from_utf8_lossy(&out.stderr)
        );
    }
}
