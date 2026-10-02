//! Snapshot tests for `fwp lint`: every `tests/lint/*.fwp` is linted and
//! the rendered warnings are compared with the `.out` file next to it.
//! Run with `FWP_BLESS=1` to regenerate.

use std::path::Path;

use fwp::diag::{render_all, SourceMap};

fn run(path: &Path) -> String {
    let text = std::fs::read_to_string(path).unwrap();
    let mut sm = SourceMap::default();
    let name = format!("lint/{}", path.file_name().unwrap().to_string_lossy());
    let file = sm.add(name, text.clone());
    match fwp::lint::lint_source(&text, file) {
        Ok(ws) => {
            let diags: Vec<_> = ws.into_iter().map(|w| w.diag).collect();
            render_all(&diags, &sm)
        }
        Err(errors) => render_all(&errors, &sm),
    }
}

#[test]
fn lint_snapshots() {
    let dir = Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/lint");
    let bless = std::env::var("FWP_BLESS").is_ok();
    let mut entries: Vec<_> = std::fs::read_dir(&dir)
        .unwrap()
        .map(|e| e.unwrap().path())
        .filter(|p| p.extension().is_some_and(|e| e == "fwp"))
        .collect();
    entries.sort();
    assert!(!entries.is_empty());
    let mut failures = Vec::new();
    for path in entries {
        let got = run(&path);
        let out = path.with_extension("out");
        if bless {
            std::fs::write(&out, &got).unwrap();
            continue;
        }
        let want = std::fs::read_to_string(&out).unwrap_or_default();
        if got != want {
            failures.push(format!(
                "{}:\n--- expected\n{}--- got\n{}",
                path.display(),
                want,
                got
            ));
        }
    }
    if !failures.is_empty() {
        panic!("{}", failures.join("\n"));
    }
}

#[test]
fn every_rule_has_a_snapshot() {
    let rules =
        std::fs::read_to_string(Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/lint/rules.out"))
            .unwrap();
    for (code, _) in fwp::lint::RULES {
        assert!(rules.contains(&format!("[{}]", code)), "{}", code);
    }
}

#[test]
fn lint_command_exit_status() {
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let dir = Path::new(env!("CARGO_MANIFEST_DIR"));
    let warn = std::process::Command::new(fwp)
        .arg("lint")
        .arg(dir.join("tests/lint/rules.fwp"))
        .output()
        .unwrap();
    assert_eq!(warn.status.code(), Some(1));
    let stderr = String::from_utf8_lossy(&warn.stderr);
    assert!(stderr.contains("rules.fwp:4:1: warning: `helper` is never used [unused-binding]"));
    let clean = std::process::Command::new(fwp)
        .arg("lint")
        .arg(dir.join("tests/lint/library.fwp"))
        .output()
        .unwrap();
    assert!(
        clean.status.success(),
        "{}",
        String::from_utf8_lossy(&clean.stderr)
    );
}
