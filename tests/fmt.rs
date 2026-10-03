//! The formatter over every `.fwp` file of the repository: formatting is
//! idempotent, keeps the syntax tree and every comment, and the standard
//! library, the examples and the tutorials are already formatted.

use std::path::{Path, PathBuf};

use fwp::fmt::{format_source, same_program};
use fwp::lexer::lex_with_comments;

fn root() -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR"))
}

fn collect(dir: &Path, out: &mut Vec<PathBuf>) {
    let mut entries: Vec<PathBuf> = std::fs::read_dir(dir)
        .unwrap()
        .map(|e| e.unwrap().path())
        .collect();
    entries.sort();
    for p in entries {
        if p.is_dir() {
            collect(&p, out);
        } else if p.extension().is_some_and(|e| e == "fwp") {
            out.push(p);
        }
    }
}

fn files(dirs: &[&str]) -> Vec<PathBuf> {
    let mut out = Vec::new();
    for d in dirs {
        collect(&root().join(d), &mut out);
    }
    out
}

fn comments(text: &str) -> Vec<String> {
    let (_, cs) = lex_with_comments(text, 0).unwrap();
    cs.into_iter().map(|c| c.text).collect()
}

#[test]
fn formatting_is_stable_and_faithful() {
    let all = files(&["lib", "examples", "tests", "docs/tutorials", "bench"]);
    assert!(all.len() > 50);
    let mut failures = Vec::new();
    let mut formatted = 0;
    for path in &all {
        let text = std::fs::read_to_string(path).unwrap();
        let mut next = 0;
        if fwp::parser::parse_module(&text, 0, &mut next).is_err() {
            // files with syntax errors (parser tests) cannot be formatted
            assert!(format_source(&text).is_err(), "{}", path.display());
            continue;
        }
        formatted += 1;
        let once = match format_source(&text) {
            Ok(s) => s,
            Err(d) => {
                failures.push(format!("{}: {}", path.display(), d.message));
                continue;
            }
        };
        if !same_program(&text, &once) {
            failures.push(format!(
                "{}: formatting changed the program:\n{}",
                path.display(),
                once
            ));
            continue;
        }
        if comments(&text) != comments(&once) {
            failures.push(format!("{}: formatting lost comments", path.display()));
        }
        let twice = format_source(&once).unwrap();
        if twice != once {
            failures.push(format!(
                "{}: formatting is not idempotent:\n--- once\n{}--- twice\n{}",
                path.display(),
                once,
                twice
            ));
        }
    }
    assert!(formatted > 50);
    if !failures.is_empty() {
        panic!("{}", failures.join("\n"));
    }
}

#[test]
fn repository_is_formatted() {
    let mut unformatted = Vec::new();
    for path in files(&["lib", "examples", "docs/tutorials", "bench"]) {
        let text = std::fs::read_to_string(&path).unwrap();
        if format_source(&text).ok().as_deref() != Some(text.as_str()) {
            unformatted.push(path.display().to_string());
        }
    }
    assert!(
        unformatted.is_empty(),
        "run `fwp fmt` on:\n{}",
        unformatted.join("\n")
    );
}

#[test]
fn fmt_check_command() {
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let ok = std::process::Command::new(fwp)
        .args([
            "fmt",
            "--check",
            "lib",
            "examples",
            "docs/tutorials",
            "bench",
        ])
        .current_dir(root())
        .output()
        .unwrap();
    assert!(
        ok.status.success(),
        "{}",
        String::from_utf8_lossy(&ok.stdout)
    );
    let dir = std::env::temp_dir().join(format!("fwp-fmt-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let file = dir.join("messy.fwp");
    std::fs::write(&file, "main =\n  [1,2,3]   |   map (add 1) | sum\n").unwrap();
    let check = std::process::Command::new(fwp)
        .args(["fmt", "--check"])
        .arg(&file)
        .output()
        .unwrap();
    assert_eq!(check.status.code(), Some(1));
    assert!(String::from_utf8_lossy(&check.stdout).contains("messy.fwp"));
    let fix = std::process::Command::new(fwp)
        .arg("fmt")
        .arg(&dir)
        .output()
        .unwrap();
    assert!(fix.status.success());
    let check = std::process::Command::new(fwp)
        .args(["fmt", "--check"])
        .arg(&file)
        .output()
        .unwrap();
    assert!(check.status.success());
    let _ = std::fs::remove_dir_all(&dir);
}
