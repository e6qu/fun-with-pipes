//! Target-specific exact arithmetic objects, shared between generated programs.
//! Content-addressed archives avoid rebuilding the C++ math core per program.
use std::path::{Path, PathBuf};
use std::process::Command;

pub const MARK: &str = "#define FWP_EXACT_FLOAT 1\n";
const FLAGS: &[&str] = &[
    "-fno-fast-math",
    "-ffp-contract=off",
    "-fPIC",
    "-ffunction-sections",
    "-fdata-sections",
];

fn run(command: &mut Command) -> Result<Vec<u8>, String> {
    let result = command.output().map_err(|e| format!("{command:?}: {e}"))?;
    if !result.status.success() {
        return Err(crate::cgen::compiler_failure(
            &format!("{command:?}"),
            &result,
        ));
    }
    Ok(result.stdout)
}

fn cxx(cc: &(String, Vec<String>), wasm: bool) -> String {
    let target = if wasm {
        Some("wasm32_wasi".into())
    } else {
        crate::cgen::native_options()
            .cross
            .map(|s| s.replace('-', "_"))
    };
    target
        .and_then(|t| std::env::var(format!("FWP_CXX_{t}")).ok())
        .or_else(|| std::env::var("CXX").ok())
        .unwrap_or_else(|| cc.0.clone())
}

/// The compiler/target identity participates in the executable cache too.
pub fn compiler_identity(cc: &(String, Vec<String>), wasm: bool) -> Result<Vec<u8>, String> {
    let cpp = cxx(cc, wasm);
    let mut result = format!("{:?}\0{:?}\0{wasm}\0", cc, cpp).into_bytes();
    for compiler in [&cc.0, &cpp] {
        for query in ["--version", "-dumpmachine"] {
            result.extend(run(Command::new(compiler).args(&cc.1).arg(query))?);
            result.push(0);
        }
    }
    // Header and library search environments can change while paths stay fixed.
    for name in [
        "PATH",
        "CPATH",
        "C_INCLUDE_PATH",
        "CPLUS_INCLUDE_PATH",
        "SDKROOT",
        "MACOSX_DEPLOYMENT_TARGET",
        "INCLUDE",
        "LIB",
    ] {
        result.extend_from_slice(name.as_bytes());
        if let Some(value) = std::env::var_os(name) {
            result.extend_from_slice(value.as_encoded_bytes());
        }
        result.push(0);
    }
    Ok(result)
}

/// Sources remain inspectable/exportable independently of the build cache.
pub fn emit_sources(c_path: &Path) -> Result<(), String> {
    for (extension, code) in [
        ("float.c", crate::softfloat::C_SOURCE),
        ("float.cpp", crate::softfloat::MATH_SOURCE),
    ] {
        let path = c_path.with_extension(extension);
        std::fs::write(&path, code).map_err(|e| format!("{}: {e}", path.display()))?;
    }
    Ok(())
}

pub fn source_stamp() -> String {
    let mut sources = crate::softfloat::C_SOURCE.as_bytes().to_vec();
    sources.extend_from_slice(crate::softfloat::MATH_SOURCE.as_bytes());
    sources.extend_from_slice(crate::softfloat::C_HEADER.as_bytes());
    crate::grpc::web::sha1(&sources)
        .iter()
        .map(|b| format!("{b:02x}"))
        .collect()
}

/// Return only complete archives. Concurrent cold builds publish atomically;
/// a failure never leaves a usable-looking cache entry.
pub fn link_archives(
    source: &str,
    cc: &(String, Vec<String>),
    opt: &str,
    wasm: bool,
    build_dir: &Path,
) -> Result<Vec<PathBuf>, String> {
    if !source.contains(MARK) {
        return Ok(Vec::new());
    }
    let mut key = compiler_identity(cc, wasm)?;
    key.extend_from_slice(
        format!(
            "{}\0{opt}\0{FLAGS:?}\0c11,c++20,no-exceptions,no-rtti,sjlj-v1",
            source_stamp()
        )
        .as_bytes(),
    );
    let hash: String = crate::grpc::web::sha1(&key)
        .iter()
        .map(|b| format!("{b:02x}"))
        .collect();
    let root = crate::aot::cache_dir().join("float");
    std::fs::create_dir_all(&root).map_err(|e| format!("{}: {e}", root.display()))?;
    let archive = root.join(format!("{hash}.a"));
    if let Some(pinned) = pin_cached(&archive, build_dir)? {
        crate::aot::prune(&root, &archive);
        return Ok(vec![pinned]);
    }
    let dir = crate::cgen::TempDir::in_parent(&root, ".build")?;
    let mut objects = Vec::new();
    for (name, code, cpp) in [
        ("float.c", crate::softfloat::C_SOURCE, false),
        ("float.cpp", crate::softfloat::MATH_SOURCE, true),
    ] {
        let source = dir.join(name);
        let object = dir.join(format!("{name}.o"));
        std::fs::write(&source, code).map_err(|e| e.to_string())?;
        let compiler = if cpp { cxx(cc, wasm) } else { cc.0.clone() };
        let mut command = Command::new(compiler);
        command.args(&cc.1).args(FLAGS).arg(opt);
        if cpp {
            command.args(["-std=c++20", "-fno-exceptions", "-fno-rtti"]);
        } else {
            command.arg("-std=c11");
            if wasm {
                command.args(["-mllvm", "-wasm-enable-sjlj"]);
            }
        }
        run(command.arg("-c").arg(&source).arg("-o").arg(&object))?;
        objects.push(object);
    }
    let built = dir.join("float.a");
    let ar = if wasm {
        "llvm-ar".into()
    } else {
        crate::cgen::archiver()
    };
    run(Command::new(ar).arg("rcs").arg(&built).args(objects))?;
    // Pin our own completed build before publication. Another process may
    // evict the public name immediately after publication.
    let pinned = pin_cached(&built, build_dir)?.ok_or("missing completed float archive")?;
    if let Err(error) = std::fs::rename(&built, &archive) {
        // Windows does not replace an existing destination; another successful
        // build may have published this exact key while ours was compiling.
        if !archive.is_file() {
            return Err(format!("{}: {error}", archive.display()));
        }
    }
    crate::aot::prune(&root, &archive);
    Ok(vec![pinned])
}

// The linker owns a private copy while LRU eviction proceeds in other builds.
fn pin_cached(archive: &Path, build_dir: &Path) -> Result<Option<PathBuf>, String> {
    let mut input = match std::fs::File::open(archive) {
        Ok(file) => file,
        Err(error) if error.kind() == std::io::ErrorKind::NotFound => return Ok(None),
        Err(error) => return Err(format!("{}: {error}", archive.display())),
    };
    let _ = input.set_modified(std::time::SystemTime::now());
    let pinned = build_dir.join("fwp-exact-float.a");
    let mut output = std::fs::File::create(&pinned).map_err(|e| e.to_string())?;
    std::io::copy(&mut input, &mut output).map_err(|e| format!("{}: {e}", archive.display()))?;
    Ok(Some(pinned))
}
