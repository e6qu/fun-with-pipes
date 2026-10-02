//! Snapshot tests for the type checker: every `tests/check/*.fwp` is
//! checked; the inferred signatures (or diagnostics) are compared with the
//! `.out` file next to it. Run with `FWP_BLESS=1` to regenerate.

use std::path::Path;

use fwp::driver::{check_source, signatures};

fn run(path: &Path) -> String {
    let text = std::fs::read_to_string(path).unwrap();
    let name = format!("check/{}", path.file_name().unwrap().to_string_lossy());
    match check_source(&name, &text, path.parent()) {
        Ok(c) => format!("{}{}", c.render_warnings(), signatures(&c)),
        Err(f) => f.rendered,
    }
}

#[test]
fn check_snapshots() {
    let dir = Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/check");
    let bless = std::env::var("FWP_BLESS").is_ok();
    let mut entries: Vec<_> = std::fs::read_dir(&dir)
        .unwrap()
        .map(|e| e.unwrap().path())
        .filter(|p| p.extension().is_some_and(|e| e == "fwp"))
        .collect();
    entries.sort();
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
