//! Embedded zero bytes must not redirect filesystem operations to a prefix.
use std::path::Path;
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

fn unchanged(root: &Path) {
    assert_eq!(
        std::fs::read(root.join("user-data.txt")).unwrap(),
        b"original"
    );
    assert_eq!(
        std::fs::read(root.join("destination.txt")).unwrap(),
        b"destination"
    );
    assert!(root.join("empty").is_dir());
    assert!(!root.join("new").exists());
}

#[test]
fn invalid_paths_fail_before_accessing_or_modifying_prefixes() {
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let scratch = fwp::cgen::TempDir::new("path-validation").unwrap();
    let root = scratch.path();
    std::fs::write(root.join("user-data.txt"), "original").unwrap();
    std::fs::write(root.join("destination.txt"), "destination").unwrap();
    std::fs::create_dir(root.join("empty")).unwrap();
    for (name, source, errors) in [
        ("paths", include_str!("fixtures/path_validation.fwp"), 13),
        (
            "resources",
            include_str!("fixtures/resource_path_validation.fwp"),
            3,
        ),
    ] {
        let path = root.join(format!("{name}.fwp"));
        std::fs::write(&path, source).unwrap();
        let reference = checked(
            Command::new(compiler)
                .env("FWP_NO_OPT", "1")
                .args(["run", "--interp"])
                .arg(&path)
                .current_dir(root),
        );
        let text = String::from_utf8_lossy(&reference.stdout);
        assert_eq!(
            text.matches("path contains a NUL character").count(),
            errors,
            "{text}"
        );
        assert!(!text.contains("Ok"), "{text}");
        if name == "paths" {
            assert!(text.starts_with("[False, False]\n"), "{text}");
        }
        unchanged(root);

        for opt in ["-O1", "-O2"] {
            let exe = root.join(format!("{name}-counted-{opt}.exe"));
            checked(
                Command::new(compiler)
                    .args(["build", opt])
                    .arg(&path)
                    .arg("-o")
                    .arg(&exe)
                    .current_dir(root),
            );

            let result = checked(Command::new(&exe).current_dir(root));
            assert_eq!(result.stdout, reference.stdout, "{name} {opt}");
            assert_eq!(result.stderr, reference.stderr);
            unchanged(root);
        }
    }
}
