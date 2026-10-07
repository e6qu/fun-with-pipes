//! Caller effects must not contaminate known pure function-valued arguments.
use fwp::driver::{check_source, signatures};
use std::path::Path;
use std::process::Command;

const SOURCE: &str = r#"
has-text : (String -> String) -> Bool
has-text = apply "!" | string.length | gt 1
main = [
    "a b c" | words | map concat | find has-text | option.map (apply "!") | echo,
    option.map (apply "!") ("a b c" | words | map concat | find has-text) | echo,
    "a b c" | words | map concat | nth 1 | option.map (apply "!") | echo,
] | ignore
"#;

#[test]
fn pure_function_values_in_io_pipes_and_applications() {
    let checked = check_source("pure-callbacks.fwp", SOURCE, None)
        .unwrap_or_else(|e| panic!("{}", e.rendered));
    let types = signatures(&checked);
    assert!(
        types.contains("has-text : (String -> String) -> Bool"),
        "{types}"
    );
    assert!(types.contains("main : ()"), "{types}");
}

#[test]
fn effectful_callbacks_still_require_their_effects() {
    for source in [
        "bad : String -> ()\nbad = print\n",
        "bad : List[String] -> List[()]\nbad = map print\n",
        "bad : Option[String] -> Option[()]\nbad = option.map print\n",
    ] {
        let error = check_source("missing-effects.fwp", source, None)
            .err()
            .unwrap_or_else(|| panic!("accepted missing effects: {source}"));
        assert!(error.rendered.contains("IO"), "{}", error.rendered);
    }
}

#[test]
fn call_related_effect_and_size_snapshots_stay_stable() {
    let root = Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/check");
    let mut paths: Vec<_> = std::fs::read_dir(&root)
        .unwrap()
        .map(|e| e.unwrap().path())
        .filter(|p| {
            p.extension().is_some_and(|e| e == "fwp") && {
                let name = p.file_stem().unwrap().to_string_lossy();
                [
                    "effect",
                    "handler",
                    "abstract",
                    "size",
                    "comptime",
                    "resource_capture",
                ]
                .iter()
                .any(|part| name.contains(part))
            }
        })
        .collect();
    paths.sort();
    assert!(paths.len() >= 4);
    for path in paths {
        let source = std::fs::read_to_string(&path).unwrap();
        let name = format!("check/{}", path.file_name().unwrap().to_string_lossy());
        let got = match check_source(&name, &source, path.parent()) {
            Ok(c) => format!("{}{}", c.render_warnings(), signatures(&c)),
            Err(f) => f
                .rendered
                .replace(concat!(env!("CARGO_MANIFEST_DIR"), "/tests/"), ""),
        };
        let want = std::fs::read_to_string(path.with_extension("out")).unwrap();
        assert_eq!(got, want, "{}", path.display());
    }
}

#[test]
fn inferred_pure_callbacks_agree_with_native_execution() {
    let dir = std::env::temp_dir().join(format!("fwp-call-effects-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let source = dir.join("pure.fwp");
    std::fs::write(&source, SOURCE).unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = Command::new(fwp)
        .args(["run", "--interp"])
        .arg(&source)
        .output()
        .unwrap();
    assert!(
        reference.status.success(),
        "{}",
        String::from_utf8_lossy(&reference.stderr)
    );
    for opt in ["-O1", "-O2"] {
        let exe = dir.join(format!("pure{opt}"));
        let built = Command::new(fwp)
            .arg("build")
            .arg(&source)
            .args([opt, "-o"])
            .arg(&exe)
            .output()
            .unwrap();
        assert!(
            built.status.success(),
            "{}",
            String::from_utf8_lossy(&built.stderr)
        );
        let got = Command::new(&exe)
            .env("FWP_GC_STRESS", "1")
            .env("FWP_GC_VERIFY", "1")
            .output()
            .unwrap();
        assert!(
            got.status.success(),
            "{}",
            String::from_utf8_lossy(&got.stderr)
        );
        assert_eq!(got.stdout, reference.stdout, "{opt}");
        assert_eq!(got.stderr, reference.stderr, "{opt}");
    }
    std::fs::remove_dir_all(dir).unwrap();
}
