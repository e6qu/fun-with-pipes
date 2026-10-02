//! `docs/stdlib.md` is generated from `lib/*.fwp`: each module's leading
//! comment, then its types, traits and signatures with the comments above
//! them. Definitions, tests and internal names are left out: a name with a
//! part that starts with `_` (`_helper`, `table._row`), or a declaration
//! with a comment line `# internal` above it. The test fails when the
//! file is stale; `FWP_BLESS=1` regenerates it.

use std::path::Path;

/// Modules in reading order.
const MODULES: &[(&str, &str)] = &[
    ("prelude", "Prelude"),
    ("list", "Lists"),
    ("option", "Option and Result"),
    ("string", "Strings"),
    ("collections", "Arrays, maps, sets and bytes"),
    ("iter", "Iterators"),
    ("io", "Console, environment and time"),
    ("fs", "Files, directories and paths"),
    ("process", "Processes"),
    ("cli", "Command-line programs and terminals"),
    ("csv", "CSV"),
    ("task", "Tasks and channels"),
    ("net", "Networking"),
    ("tls", "TLS"),
    ("http", "HTTP"),
    ("json", "JSON"),
    ("rest", "REST endpoints and clients"),
    ("grpc", "gRPC"),
    ("protobuf", "Protobuf"),
    ("url", "URLs"),
    ("log", "Logs and metrics"),
    ("numeric", "Vectors, matrices and complex numbers"),
    ("autodiff", "Automatic differentiation"),
    ("tensor", "Tensor expressions"),
    ("ternary", "Balanced ternary"),
    ("simd", "SIMD"),
    ("ffi", "C interop"),
];

fn is_comment(l: &str) -> bool {
    l.starts_with('#')
}

/// Whether a top-level line starts a declaration that belongs in the
/// summary, and the name it declares.
fn summary_name(l: &str) -> Option<&str> {
    let l = l
        .strip_prefix("foreign \"fwp\" ")
        .or_else(|| l.strip_prefix("export "))
        .or_else(|| l.strip_prefix("rec "))
        .unwrap_or(l);
    if l.starts_with("trait ") || l.starts_with("resource ") {
        return Some(l.split_whitespace().nth(1).unwrap_or(""));
    }
    let first = l.split_whitespace().next()?;
    let rest = l[first.len()..].trim_start();
    if first.starts_with(|c: char| c.is_ascii_lowercase()) && rest.starts_with(": ") {
        return Some(first);
    }
    if first.starts_with(|c: char| c.is_ascii_uppercase()) && !first.contains('.') {
        // a type declaration: `Name = ...` or `Name[T] = ...`
        let after = l.find('=')?;
        if !l[..after].contains(':') {
            return Some(first);
        }
    }
    None
}

fn module_doc(text: &str) -> (String, String) {
    let lines: Vec<&str> = text.lines().collect();
    let mut i = 0;
    let mut intro = String::new();
    while i < lines.len() && is_comment(lines[i]) {
        let t = lines[i].trim_start_matches('#');
        intro.push_str(t.strip_prefix(' ').unwrap_or(t));
        intro.push('\n');
        i += 1;
    }
    let mut body = String::new();
    let mut pending: Vec<&str> = Vec::new();
    while i < lines.len() {
        let l = lines[i];
        i += 1;
        if is_comment(l) {
            // section rulers stay out of the summary
            if !l.contains("----") {
                pending.push(l);
            }
            continue;
        }
        if l.trim().is_empty() {
            pending.clear();
            continue;
        }
        if l.starts_with(' ') {
            continue;
        }
        match summary_name(l) {
            Some(name)
                if !name.split('.').any(|part| part.starts_with('_'))
                    && !pending.iter().any(|c| c.trim() == "# internal") =>
            {
                let block = l.trim_end().ends_with(['=', '{', '[', '(']);
                if !body.is_empty() && (!pending.is_empty() || block) {
                    body.push('\n');
                }
                for c in &pending {
                    body.push_str(c);
                    body.push('\n');
                }
                body.push_str(l.strip_prefix("foreign \"fwp\" ").unwrap_or(l));
                body.push('\n');
                // the indented continuation of a type or trait
                if block {
                    while i < lines.len() && (lines[i].starts_with(' ') || lines[i].is_empty()) {
                        if lines[i].is_empty() {
                            if lines.get(i + 1).is_some_and(|n| n.starts_with(' ')) {
                                body.push('\n');
                            } else {
                                break;
                            }
                        } else {
                            body.push_str(lines[i]);
                            body.push('\n');
                        }
                        i += 1;
                    }
                    // a closing bracket in column 1
                    if i < lines.len() && lines[i].starts_with(['}', ']', ')']) {
                        body.push_str(lines[i]);
                        body.push('\n');
                        i += 1;
                    }
                }
            }
            _ => {}
        }
        pending.clear();
    }
    (intro, body)
}

fn generate(root: &Path) -> String {
    let mut out = String::from(
        "# Standard library\n\n\
         Generated from `lib/*.fwp` by `tests/stdlib_doc.rs`; do not edit.\n\
         Run `FWP_BLESS=1 cargo test --test stdlib_doc` after changing the library.\n\
         Every module is available without an import.\n\n",
    );
    for (_, title) in MODULES {
        out.push_str(&format!("- [{}](#{})\n", title, anchor(title)));
    }
    for (file, title) in MODULES {
        let text = std::fs::read_to_string(root.join("lib").join(format!("{}.fwp", file))).unwrap();
        let (intro, body) = module_doc(&text);
        out.push_str(&format!("\n## {}\n\n", title));
        out.push_str(&format!("`lib/{}.fwp`\n\n", file));
        if !intro.trim().is_empty() {
            out.push_str(intro.trim_end());
            out.push_str("\n\n");
        }
        out.push_str("```fwp\n");
        out.push_str(&body);
        out.push_str("```\n");
    }
    out
}

fn anchor(title: &str) -> String {
    title
        .to_lowercase()
        .chars()
        .filter(|c| c.is_alphanumeric() || *c == ' ' || *c == '-')
        .map(|c| if c == ' ' { '-' } else { c })
        .collect()
}

#[test]
fn stdlib_doc_is_current() {
    let root = Path::new(env!("CARGO_MANIFEST_DIR"));
    let mut files: Vec<String> = std::fs::read_dir(root.join("lib"))
        .unwrap()
        .map(|e| e.unwrap().file_name().to_string_lossy().into_owned())
        .filter(|n| n.ends_with(".fwp"))
        .map(|n| n.trim_end_matches(".fwp").to_string())
        .collect();
    files.sort();
    let mut listed: Vec<String> = MODULES.iter().map(|(f, _)| f.to_string()).collect();
    listed.sort();
    assert_eq!(files, listed, "every lib file must be listed in MODULES");
    let doc = generate(root);
    let path = root.join("docs/stdlib.md");
    if std::env::var("FWP_BLESS").is_ok() {
        std::fs::write(&path, &doc).unwrap();
        return;
    }
    let have = std::fs::read_to_string(&path).unwrap_or_default();
    assert!(
        have == doc,
        "docs/stdlib.md is stale; run FWP_BLESS=1 cargo test --test stdlib_doc"
    );
}
