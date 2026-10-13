use std::collections::BTreeSet;
use std::env;
use std::fs;
use std::path::{Path, PathBuf};
use std::process::Command;

// Embed the same upstream arithmetic in the compiler and generated C. All
// local quoted includes are guarded headers; quoted system headers stay intact.
fn append(path: &Path, seen: &mut BTreeSet<PathBuf>, output: &mut String) {
    if !seen.insert(path.to_path_buf()) {
        return;
    }
    println!("cargo:rerun-if-changed={}", path.display());
    for line in fs::read_to_string(path)
        .expect("exact floating source")
        .lines()
    {
        if let Some(name) = line
            .strip_prefix("#include \"")
            .and_then(|l| l.strip_suffix('"'))
            .filter(|name| path.parent().unwrap().join(name).is_file())
        {
            append(&path.parent().unwrap().join(name), seen, output);
        } else {
            output.push_str(line);
            output.push('\n');
        }
    }
}

fn checked(command: &mut Command) {
    let result = command
        .output()
        .unwrap_or_else(|error| panic!("cannot run {command:?}: {error}"));
    assert!(
        result.status.success(),
        "{command:?}: {}",
        String::from_utf8_lossy(&result.stderr)
    );
}

fn main() {
    for variable in ["CC", "AR"] {
        println!("cargo:rerun-if-env-changed={variable}");
    }
    println!("cargo:rerun-if-changed=vendor/softfloat");
    let root = Path::new("vendor/softfloat");
    let out = PathBuf::from(env::var_os("OUT_DIR").unwrap());
    let target = env::var("TARGET").unwrap();
    let host = env::var("HOST").unwrap();
    let msvc = target.ends_with("-msvc");
    let mut sources: Vec<_> = fs::read_dir(root)
        .unwrap()
        .map(|e| e.unwrap().path())
        .filter(|p| p.extension().is_some_and(|e| e == "c"))
        .collect();
    sources.sort();
    let mut code = String::new();
    let mut seen = BTreeSet::new();
    append(&root.join("platform.h"), &mut seen, &mut code);
    append(&root.join("softfloat.h"), &mut seen, &mut code);
    for source in sources {
        append(&source, &mut seen, &mut code);
    }
    append(Path::new("runtime/fwp_float.c"), &mut seen, &mut code);
    println!("cargo:rerun-if-changed=vendor/gdtoa");
    let decimal = Path::new("vendor/gdtoa");
    let mut text_code = String::new();
    append(&decimal.join("symbols.h"), &mut seen, &mut text_code);
    for name in [
        "misc.c",
        "dmisc.c",
        "smisc.c",
        "gmisc.c",
        "gdtoa.c",
        "strtodg.c",
        "sum.c",
        "ulp.c",
    ] {
        append(&decimal.join(name), &mut seen, &mut text_code);
    }
    append(
        Path::new("runtime/fwp_float_text.c"),
        &mut seen,
        &mut text_code,
    );
    // gdtoa's internal macros must not affect the rest of generated programs.
    let macros: BTreeSet<_> = text_code
        .lines()
        .filter_map(|line| {
            line.strip_prefix("#define ").map(|s| {
                s.split(|c: char| c.is_whitespace() || c == '(')
                    .next()
                    .unwrap()
            })
        })
        .collect();
    code.push_str(&text_code);
    for name in macros {
        code.push_str(&format!("\n#undef {name}\n"));
    }
    let source = out.join("softfloat.c");
    fs::write(&source, code).unwrap();
    let object = out.join("softfloat.o");
    let compiler = env::var_os("CC").unwrap_or_else(|| {
        if target != host || msvc {
            "clang".into()
        } else {
            "cc".into()
        }
    });
    let mut command = Command::new(compiler);
    if target != host || msvc {
        let c_target = if target == "wasm32-wasip1" {
            "wasm32-wasi"
        } else {
            &target
        };
        command.arg(format!("--target={c_target}"));
    }
    if target == "wasm32-wasip1" {
        command.args(["-mllvm", "-wasm-enable-sjlj"]);
    }
    checked(
        command
            .args([
                "-std=c11",
                "-O2",
                "-fno-fast-math",
                "-ffp-contract=off",
                "-c",
            ])
            .arg(&source)
            .arg("-o")
            .arg(&object),
    );
    let archive = out.join(if msvc {
        "fwp_softfloat.lib"
    } else {
        "libfwp_softfloat.a"
    });
    let archiver = env::var_os("AR").unwrap_or_else(|| {
        if target != host || msvc {
            "llvm-ar".into()
        } else {
            "ar".into()
        }
    });
    let mut objects = vec![object];
    if target == "wasm32-wasip1" {
        for (name, flag) in [("sjlj.c", "-O2"), ("longjmp.S", "-mexception-handling")] {
            let source = Path::new("runtime/wasm").join(name);
            println!("cargo:rerun-if-changed={}", source.display());
            let object = out.join(format!("{name}.o"));
            checked(
                Command::new(env::var_os("CC").unwrap_or_else(|| "clang".into()))
                    .args(["--target=wasm32-wasi", flag, "-c"])
                    .arg(source)
                    .arg("-o")
                    .arg(&object),
            );
            objects.push(object);
        }
    }
    checked(
        Command::new(archiver)
            .arg("crs")
            .arg(&archive)
            .args(objects),
    );
    println!("cargo:rustc-link-search=native={}", out.display());
    println!("cargo:rustc-link-lib=static=fwp_softfloat");
}
