//! The gRPC commands (docs/grpc.md): `fwp build --grpc`, `fwp serve
//! --grpc`, `fwp proto --grpc` and `fwp proto --import`.

use std::path::{Path, PathBuf};

use crate::ir::Program;

const USAGE: &str = "usage: fwp build <file.fwp> --grpc [-o out] [-O0..-O3] [--fat] [--emit-c]
       fwp serve --grpc <file.fwp> [--listen host:port] [--tls-cert file --tls-key file]
       fwp proto --grpc <file.fwp>
       fwp proto --import <file.proto> [-o out.fwp]";

fn stem(path: &Path) -> String {
    path.file_stem()
        .unwrap_or_default()
        .to_string_lossy()
        .to_string()
}

/// The root file's exported functions, as a service named after the file
/// (or its `# grpc:` annotations).
fn compile(path: &Path, remote: Vec<(String, String)>) -> Result<Program, (String, i32)> {
    let roots = crate::mono::Roots {
        service: Some("main".into()),
        remote,
        ..Default::default()
    };
    let (c, mut prog) = crate::driver::compile_file(path, roots).map_err(|f| (f.rendered, 1))?;
    eprint!("{}", c.render_warnings());
    let name = if path == Path::new("-") {
        "main".to_string()
    } else {
        stem(path)
    };
    crate::rpc::name_main_service(&mut prog, &name).map_err(|e| (e, 1))?;
    crate::services::check_service(&prog).map_err(|e| (e, 1))?;
    Ok(prog)
}

fn report(cmd: &str, e: (String, i32)) -> i32 {
    if e.0.ends_with('\n') {
        eprint!("{}", e.0);
    } else {
        eprintln!("fwp {}: {}", cmd, e.0);
    }
    e.1
}

/// `fwp build file.fwp --grpc`: a server of the file's exported functions.
pub fn build(args: &[String]) -> i32 {
    let mut path = None;
    let mut out = None;
    let mut opt = "-O2".to_string();
    let (mut fat, mut emit_c) = (false, false);
    let mut i = 0;
    while i < args.len() {
        match args[i].as_str() {
            "--grpc" => {}
            "-o" => {
                i += 1;
                out = args.get(i).cloned();
            }
            "--fat" => fat = true,
            "--emit-c" => emit_c = true,
            a if a.starts_with("-O") => opt = a.to_string(),
            a if a.starts_with('-') => {
                eprintln!(
                    "fwp build: `{}` cannot be combined with --grpc\n{}",
                    a, USAGE
                );
                return 2;
            }
            a => path = Some(PathBuf::from(a)),
        }
        i += 1;
    }
    let Some(path) = path else {
        eprintln!("fwp build: missing file\n{}", USAGE);
        return 2;
    };
    let out = out
        .map(PathBuf::from)
        .unwrap_or_else(|| PathBuf::from(stem(&path)));
    crate::driver::with_big_stack(move || {
        let prog = match compile(&path, Vec::new()) {
            Ok(p) => p,
            Err(e) => return report("build", e),
        };
        let csrc = match crate::cgen::generate_service(&prog) {
            Ok(s) => s,
            Err(e) => return report("build", (e, 1)),
        };
        let done = if emit_c {
            std::fs::write(out.with_extension("c"), &csrc).map_err(|e| e.to_string())
        } else if fat {
            crate::cgen::compile_fat(&csrc, &out, &opt)
        } else {
            crate::cgen::compile_c(&csrc, &out, &opt)
        };
        match done {
            Ok(()) => 0,
            Err(e) => report("build", (e, 1)),
        }
    })
}

/// `fwp serve --grpc file.fwp`: serve the file's exported functions with
/// the interpreter.
pub fn serve(args: &[String]) -> i32 {
    let mut args = args.to_vec();
    let tls = match crate::tls::server_files(&mut args) {
        Ok(t) => t,
        Err(e) => {
            eprintln!("fwp serve: {}\n{}", e, USAGE);
            return 2;
        }
    };
    let mut path = None;
    let mut listen = None;
    let mut remote = Vec::new();
    let mut i = 0;
    while i < args.len() {
        match args[i].as_str() {
            "--grpc" => {}
            "--listen" if i + 1 < args.len() => {
                i += 1;
                listen = Some(args[i].clone());
            }
            "--service" if i + 1 < args.len() => {
                i += 1;
                remote.push(service_spec(&args[i]));
            }
            a if a.starts_with("--listen=") => listen = Some(a[9..].to_string()),
            a if a.starts_with("--service=") => remote.push(service_spec(&a[10..])),
            a if a.starts_with('-') && a != "-" => {
                eprintln!("fwp serve: unknown option `{}`\n{}", a, USAGE);
                return 2;
            }
            a => path = Some(PathBuf::from(a)),
        }
        i += 1;
    }
    let Some(path) = path else {
        eprintln!("fwp serve: missing file\n{}", USAGE);
        return 2;
    };
    crate::driver::with_big_stack(move || match compile(&path, remote) {
        Ok(prog) => crate::grpc::serve(&prog, listen, tls),
        Err(e) => report("serve", e),
    })
}

fn service_spec(s: &str) -> (String, String) {
    match s.split_once('=') {
        Some((m, a)) => (m.to_string(), a.to_string()),
        None => (s.to_string(), crate::mono::DEFAULT_SERVICE_ADDR.to_string()),
    }
}

/// `fwp proto --grpc file.fwp` and `fwp proto --import file.proto`.
pub fn proto(args: &[String]) -> i32 {
    let import = args.iter().any(|a| a == "--import");
    let mut path = None;
    let mut out = None;
    let mut i = 0;
    while i < args.len() {
        match args[i].as_str() {
            "--grpc" | "--import" => {}
            "-o" if i + 1 < args.len() => {
                i += 1;
                out = Some(PathBuf::from(&args[i]));
            }
            a if a.starts_with('-') && a != "-" => {
                eprintln!("fwp proto: unknown option `{}`\n{}", a, USAGE);
                return 2;
            }
            a => path = Some(PathBuf::from(a)),
        }
        i += 1;
    }
    let Some(path) = path else {
        eprintln!("fwp proto: missing file\n{}", USAGE);
        return 2;
    };
    if import {
        let text = match crate::proto_import::generate(&path) {
            Ok(t) => t,
            Err(e) => {
                eprintln!("fwp proto: {}", e);
                return 1;
            }
        };
        return match out {
            Some(o) => match std::fs::write(&o, text) {
                Ok(()) => 0,
                Err(e) => {
                    eprintln!("fwp proto: cannot write {}: {}", o.display(), e);
                    1
                }
            },
            None => {
                print!("{}", text);
                0
            }
        };
    }
    crate::driver::with_big_stack(move || {
        let prog = match compile(&path, Vec::new()) {
            Ok(p) => p,
            Err(e) => return report("proto", e),
        };
        let name = path
            .file_name()
            .map(|n| n.to_string_lossy().to_string())
            .unwrap_or_default();
        match crate::services::proto_text(&[prog], &name) {
            Ok(t) => match out {
                Some(o) => match std::fs::write(&o, t) {
                    Ok(()) => 0,
                    Err(e) => report("proto", (format!("cannot write {}: {}", o.display(), e), 1)),
                },
                None => {
                    print!("{}", t);
                    0
                }
            },
            Err(e) => report("proto", (e, 1)),
        }
    })
}
