#[allow(dead_code)]
#[path = "../src/ownership.rs"]
mod ownership;

use std::{collections::BTreeSet, fs, path::Path};

fn visit(root: &Path, dir: &Path, lowered: &BTreeSet<&str>) {
    let mut files = fs::read_dir(dir)
        .unwrap()
        .map(|entry| entry.unwrap().path())
        .collect::<Vec<_>>();
    files.sort();
    for path in files {
        if path.is_dir() {
            visit(root, &path, lowered);
            continue;
        }
        if path.extension().and_then(|s| s.to_str()) != Some("fwp") {
            continue;
        }
        for line in fs::read_to_string(&path).unwrap().lines() {
            let Some(decl) = line.trim().strip_prefix("foreign \"fwp\" ") else {
                continue;
            };
            let declared = decl.split_whitespace().next().unwrap();
            let raw = decl.split_once(" : ").expect("single-line signature").1;
            let (signature, symbol, aliased) = if let Some((ty, alias)) = raw.rsplit_once(" = ") {
                let alias = alias.trim();
                assert!(alias.starts_with('"') && alias.ends_with('"'));
                assert!(!alias[1..alias.len() - 1].contains(['"', '\\']));
                (ty, &alias[1..alias.len() - 1], true)
            } else {
                (raw, declared, false)
            };
            let flat = signature
                .split('!')
                .next()
                .unwrap()
                .split(" where ")
                .next()
                .unwrap()
                .trim();
            let scalar = !flat.is_empty()
                && flat.split("->").all(|ty| {
                    matches!(
                        ty.trim(),
                        "I8" | "I16"
                            | "I32"
                            | "I64"
                            | "U8"
                            | "U16"
                            | "U32"
                            | "U64"
                            | "F32"
                            | "F64"
                            | "Bool"
                            | "()"
                    )
                });
            let contract = ownership::primitive(symbol);
            let bucket = if contract.is_some() {
                "contract"
            } else if lowered.contains(symbol) {
                "ir_template"
            } else if scalar {
                "flat_scalar_signature"
            } else {
                "runtime_or_specialization_review"
            };
            println!(
                "{}\t{}\t{}\t{}\t{}\t{:?}\t{}",
                path.strip_prefix(root).unwrap().display(),
                declared,
                symbol,
                aliased,
                bucket,
                contract,
                signature.replace('\t', " ")
            );
        }
    }
}

fn main() {
    let names = std::env::var("FWP_AUDIT_LOWERED").unwrap();
    let lowered = names.split(',').collect::<BTreeSet<_>>();
    let root = std::env::current_dir().unwrap();
    visit(&root, &root.join("lib"), &lowered);
}
