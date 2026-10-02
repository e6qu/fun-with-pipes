//! Snapshot tests for the parser: every `tests/parse/*.fwp` is parsed and
//! its pretty-printed AST (or error) is compared with the `.out` file next
//! to it. Run with `FWP_BLESS=1` to regenerate snapshots.

use std::path::Path;

use fwp::diag::SourceMap;
use fwp::parser::parse_module;
use fwp::pretty;

fn run(path: &Path) -> String {
    let text = std::fs::read_to_string(path).unwrap();
    let mut sm = SourceMap::default();
    let name = format!("parse/{}", path.file_name().unwrap().to_string_lossy());
    let file = sm.add(name, text.clone());
    let mut next = 0;
    match parse_module(&text, file, &mut next) {
        Ok(m) => {
            let printed = pretty::module(&m);
            // The printed form must itself parse to the same printed form.
            let mut next2 = 0;
            let reparsed = parse_module(&printed, file, &mut next2)
                .unwrap_or_else(|e| panic!("reparse of {:?} failed: {}", path, e.render(&sm)));
            assert_eq!(printed, pretty::module(&reparsed), "round trip {:?}", path);
            printed
        }
        Err(d) => d.render(&sm),
    }
}

#[test]
fn parse_snapshots() {
    let dir = Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/parse");
    let bless = std::env::var("FWP_BLESS").is_ok();
    let mut failures = Vec::new();
    let mut entries: Vec<_> = std::fs::read_dir(&dir)
        .unwrap()
        .map(|e| e.unwrap().path())
        .filter(|p| p.extension().is_some_and(|e| e == "fwp"))
        .collect();
    entries.sort();
    assert!(!entries.is_empty());
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
