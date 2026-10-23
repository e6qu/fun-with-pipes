//! Preserve generated record ownership probes and their observed results for CI.
use std::path::Path;
use std::process::Output;

pub fn save(group: &str, label: &str, code: &str, executable: &Path, output: &Output) {
    if let Some(root) = std::env::var_os("FWP_ARC_ARTIFACTS") {
        let directory = Path::new(&root).join("record-ownership").join(group);
        std::fs::create_dir_all(&directory).unwrap();
        let prefix = directory.join(label);
        std::fs::write(prefix.with_extension("c"), code).unwrap();
        std::fs::copy(executable, prefix.with_extension("exe")).unwrap();
        std::fs::write(prefix.with_extension("stdout"), &output.stdout).unwrap();
        std::fs::write(prefix.with_extension("stderr"), &output.stderr).unwrap();
        std::fs::write(
            prefix.with_extension("status"),
            format!("{:?}\n", output.status.code()),
        )
        .unwrap();
    }
}
