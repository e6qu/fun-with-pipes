//! Compile C harness inputs with their explicit exported entry points.
use std::path::{Path, PathBuf};

// These C harnesses call exported functions directly. Main-only compilation may
// specialize their callers and correctly remove the original entries.
pub fn generate(path: &Path) -> String {
    let path = path.to_owned();
    fwp::driver::with_big_stack(move || {
        let (compilation, program) = fwp::driver::compile_file(
            &path,
            fwp::mono::Roots {
                main: true,
                exports: true,
                ..Default::default()
            },
        )
        .map_err(|error| error.rendered)
        .unwrap();
        assert!(
            compilation.warnings.is_empty(),
            "{}",
            compilation.render_warnings()
        );
        let emitted = fwp::cgen::generate(&program).unwrap();
        if let Some(root) = std::env::var_os("FWP_ARC_ARTIFACTS") {
            let directory = PathBuf::from(root)
                .join("record-ownership/exported-probes")
                .join(path.parent().unwrap().file_name().unwrap());
            std::fs::create_dir_all(&directory).unwrap();
            std::fs::copy(&path, directory.join("input.fwp")).unwrap();
            std::fs::write(directory.join("generated.c"), &emitted).unwrap();
        }
        emitted
    })
}
