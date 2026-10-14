//! Exact cores remain usable outside the cache and under concurrent builds.
use std::path::Path;
use std::process::{Command, Output, Stdio};

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

const SOURCE: &str =
    "main = 1.0000000000000000000000000000000002f128 | mul 2.0f128 | gt 2.0f128 | echo\n";

#[test]
fn emitted_companions_link_without_a_cpp_runtime() {
    let dir = fwp::cgen::TempDir::new("fwp-float-companions").unwrap();
    let source = dir.join("program.fwp");
    let cfile = dir.join("program.c");
    std::fs::write(&source, SOURCE).unwrap();
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile),
    );
    let cc = std::env::var("CC").unwrap_or_else(|_| "cc".into());
    let cpp = std::env::var("CXX").unwrap_or_else(|_| cc.clone());
    let mut objects = Vec::new();
    for (extension, compiler, standard) in [
        ("c", &cc, "gnu11"),
        ("float.c", &cc, "c11"),
        ("float.cpp", &cpp, "c++20"),
    ] {
        let input = cfile.with_extension(extension);
        assert!(input.is_file(), "missing companion {}", input.display());
        let object = dir.join(format!("{extension}.o"));
        let mut compile = Command::new(compiler);
        compile
            .args(["-O2", "-fno-fast-math", "-ffp-contract=off"])
            .arg(format!("-std={standard}"));
        if extension.ends_with("cpp") {
            compile.args(["-fno-exceptions", "-fno-rtti"]);
        }
        checked(compile.arg("-c").arg(input).arg("-o").arg(&object));
        objects.push(object);
    }
    let binary = dir.join(if cfg!(windows) {
        "manual.exe"
    } else {
        "manual"
    });
    let mut link = Command::new(cc);
    link.args(objects).arg("-lm");
    if cfg!(windows) {
        link.args(["-lws2_32", "-lshell32"]);
    } else {
        link.arg("-lpthread");
    }
    checked(link.arg("-o").arg(&binary));
    assert_eq!(checked(&mut Command::new(binary)).stdout, b"True\n");
}

fn archives(root: &Path) -> Vec<std::path::PathBuf> {
    let mut result: Vec<_> = std::fs::read_dir(root.join("float"))
        .unwrap()
        .map(|e| e.unwrap().path())
        .filter(|p| p.extension().is_some_and(|e| e == "a"))
        .collect();
    result.sort();
    result
}

#[test]
fn concurrent_core_publication_reuse_identity_and_eviction() {
    let dir = fwp::cgen::TempDir::new("fwp-float-cache").unwrap();
    let source = dir.join("program.fwp");
    let cache = dir.join("cache");
    std::fs::write(&source, SOURCE).unwrap();
    let command = |name: &str, cpath: Option<&Path>| {
        let mut build = Command::new(env!("CARGO_BIN_EXE_fwp"));
        build
            .env("FWP_CACHE_DIR", &cache)
            .env("FWP_CACHE_MAX", "1")
            .args(["build", "-O1"])
            .arg(&source)
            .arg("-o")
            .arg(dir.join(name));
        if let Some(cpath) = cpath {
            build.env("CPATH", cpath);
        }
        build
    };
    let mut children = Vec::new();
    for name in ["first", "second"] {
        children.push((
            name,
            command(name, None)
                .stdout(Stdio::piped())
                .stderr(Stdio::piped())
                .spawn()
                .unwrap(),
        ));
    }
    for (name, child) in children {
        let output = child.wait_with_output().unwrap();
        assert!(output.status.success(), "{name}: {output:?}");
        assert_eq!(checked(&mut Command::new(dir.join(name))).stdout, b"True\n");
    }
    let initial = archives(&cache);
    assert_eq!(initial.len(), 1);
    // A warm hit must not replace the published file. Access time is touched,
    // so use file identity on Unix and byte contents on other hosts.
    let bytes = std::fs::read(&initial[0]).unwrap();
    #[cfg(unix)]
    let inode = {
        use std::os::unix::fs::MetadataExt;
        std::fs::metadata(&initial[0]).unwrap().ino()
    };
    checked(&mut command("warm", None));
    assert_eq!(archives(&cache), initial);
    assert_eq!(std::fs::read(&initial[0]).unwrap(), bytes);
    #[cfg(unix)]
    {
        use std::os::unix::fs::MetadataExt;
        assert_eq!(std::fs::metadata(&initial[0]).unwrap().ino(), inode);
    }
    let headers = dir.join("headers");
    std::fs::create_dir(&headers).unwrap();
    checked(&mut command("new-search-path", Some(&headers)));
    let changed = archives(&cache);
    assert_eq!(changed.len(), 1);
    assert_ne!(
        changed, initial,
        "header environment must change the core identity"
    );
    assert_eq!(
        checked(&mut Command::new(dir.join("new-search-path"))).stdout,
        b"True\n"
    );
    // An old linked program remains independent of the evicted archive.
    assert_eq!(
        checked(&mut Command::new(dir.join("first"))).stdout,
        b"True\n"
    );
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env("FWP_CACHE_DIR", &cache)
            .args(["cache", "clean"]),
    );
    assert!(!cache.join("float").exists() || archives(&cache).is_empty());
}
