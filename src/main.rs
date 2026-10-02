use std::process::ExitCode;

use fwp::diag::SourceMap;
use fwp::parser::parse_module;
use fwp::pretty;

const USAGE: &str = "\
fwp - the fwp (\"foop\") language

usage:
  fwp run <file.fwp> [args...]   run a program's `main` (interpreter)
  fwp build <file.fwp> [-o out] [--fn name] [--emit-c] [-O0|-O1|-O2|-O3]
            [--target native|wasm32-wasi|wasm32-browser] [--fat]
            [--staticlib|--cdylib] [--link lib-or-source]...
                                 compile `main` (or an exported function) to a
                                 native executable or a WebAssembly module;
                                 --fat builds one variant per CPU feature
                                 level and picks the best at startup;
                                 --staticlib/--cdylib build a C library
                                 (and header) of the exported functions;
                                 --link adds C code for foreign functions
                                 (also accepted by run, test and exec)
  fwp exec <file.fwp> <fn> [args...]
                                 run an exported function as an executable would
  fwp pipe '<file.fwp:fn args> | <file.fwp:fn> ...'
                                 connect exported functions with the binary
                                 typed protocol
  fwp test <file.fwp>            run the `test` declarations of a file
  fwp test --std                 run the standard library's tests
  fwp test ... --native          run tests compiled to native code
  fwp check <file.fwp>           type-check a file and print inferred types
  fwp check --parse <file.fwp>   parse a file and print its syntax tree
  fwp help                       show this message
";

/// Remove `--link <item>` options (C libraries, sources and objects for
/// foreign functions) from the arguments before the program file.
fn take_links(args: &mut Vec<String>) {
    let mut links = Vec::new();
    let mut i = 0;
    while i < args.len() {
        if args[i] == "--link" && i + 1 < args.len() {
            links.push(args.remove(i + 1));
            args.remove(i);
        } else if args[i].ends_with(".fwp") {
            break;
        } else {
            i += 1;
        }
    }
    fwp::ffi::set_links(links);
}

fn main() -> ExitCode {
    // invalid UTF-8 in arguments becomes U+FFFD, as in native programs
    let mut args: Vec<String> = std::env::args_os()
        .skip(1)
        .map(|a| a.to_string_lossy().into_owned())
        .collect();
    if args.len() > 1 {
        let mut rest = args.split_off(1);
        take_links(&mut rest);
        args.extend(rest);
    }
    match args.first().map(String::as_str) {
        Some("check") => check(&args[1..]),
        Some("run") => run(&args[1..]),
        Some("test") => test(&args[1..]),
        Some("build") => build(&args[1..]),
        Some("exec") => exec(&args[1..]),
        Some("pipe") => pipe(&args[1..]),
        Some("help") | Some("--help") | Some("-h") | None => {
            print!("{}", USAGE);
            ExitCode::SUCCESS
        }
        Some(other) => {
            eprintln!("fwp: unknown command `{}`\n\n{}", other, USAGE);
            ExitCode::from(2)
        }
    }
}

fn check(args: &[String]) -> ExitCode {
    let parse_only = args.iter().any(|a| a == "--parse");
    let Some(path) = args.iter().find(|a| !a.starts_with("--")) else {
        eprintln!("fwp check: missing file");
        return ExitCode::from(2);
    };
    if !parse_only {
        return match fwp::driver::check_file(std::path::Path::new(path)) {
            Ok(c) => {
                eprint!("{}", c.render_warnings());
                print!("{}", fwp::driver::signatures(&c));
                ExitCode::SUCCESS
            }
            Err(f) => {
                eprint!("{}", f.rendered);
                ExitCode::from(1)
            }
        };
    }
    let text = match std::fs::read_to_string(path) {
        Ok(t) => t,
        Err(e) => {
            eprintln!("fwp: cannot read {}: {}", path, e);
            return ExitCode::from(2);
        }
    };
    let mut sm = SourceMap::default();
    let file = sm.add(path.clone(), text.clone());
    let mut next_id = 0;
    match parse_module(&text, file, &mut next_id) {
        Ok(m) => {
            if parse_only {
                print!("{}", pretty::module(&m));
            }
            ExitCode::SUCCESS
        }
        Err(d) => {
            eprint!("{}", d.render(&sm));
            ExitCode::from(1)
        }
    }
}

fn run(args: &[String]) -> ExitCode {
    let Some(path) = args.first().cloned() else {
        eprintln!("fwp run: missing file");
        return ExitCode::from(2);
    };
    let prog_args: Vec<String> = args[1..].to_vec();
    let roots = fwp::mono::Roots {
        main: true,
        ..Default::default()
    };
    let code = fwp::driver::with_big_stack(move || {
        match fwp::driver::compile_file(std::path::Path::new(&path), roots) {
            Ok((c, prog)) => {
                eprint!("{}", c.render_warnings());
                fwp::interp::run_main(&prog, prog_args).exit_code
            }
            Err(f) => {
                eprint!("{}", f.rendered);
                1
            }
        }
    });
    ExitCode::from((code & 0xff) as u8)
}

fn test(args: &[String]) -> ExitCode {
    let std_tests = args.iter().any(|a| a == "--std");
    let native = args.iter().any(|a| a == "--native");
    let path = args.iter().find(|a| !a.starts_with("--")).cloned();
    if path.is_none() && !std_tests {
        eprintln!("fwp test: missing file (or --std)");
        return ExitCode::from(2);
    }
    let roots = fwp::mono::Roots {
        tests: true,
        std_tests,
        ..Default::default()
    };
    let code = fwp::driver::with_big_stack(move || {
        let compiled = match &path {
            Some(p) => fwp::driver::compile_file(std::path::Path::new(p), roots),
            None => fwp::driver::compile_source("<empty>", "", roots),
        };
        match compiled {
            Ok((c, prog)) if native => {
                eprint!("{}", c.render_warnings());
                let src = match fwp::cgen::generate_tests(&prog) {
                    Ok(s) => s,
                    Err(e) => {
                        eprintln!("fwp test: {}", e);
                        return 1;
                    }
                };
                let dir = match fwp::cgen::TempDir::new("fwp-tests") {
                    Ok(d) => d,
                    Err(e) => {
                        eprintln!("fwp test: {}", e);
                        return 1;
                    }
                };
                let exe = dir.join("tests");
                if let Err(e) = fwp::cgen::compile_c(&src, &exe, "-O1") {
                    eprintln!("fwp test: {}", e);
                    return 1;
                }
                let status = std::process::Command::new(&exe).status();
                drop(dir);
                match status {
                    Ok(s) => s.code().unwrap_or(1),
                    Err(e) => {
                        eprintln!("fwp test: cannot run test binary: {}", e);
                        1
                    }
                }
            }
            Ok((c, prog)) => {
                eprint!("{}", c.render_warnings());
                let mut out = std::io::stdout();
                let (pass, fail) = fwp::driver::run_tests(&prog, &mut out);
                println!("\n{} passed, {} failed", pass, fail);
                if fail == 0 {
                    0
                } else {
                    1
                }
            }
            Err(f) => {
                eprint!("{}", f.rendered);
                1
            }
        }
    });
    ExitCode::from(code as u8)
}

fn build(args: &[String]) -> ExitCode {
    let mut path = None;
    let mut out = None;
    let mut emit_c = false;
    let mut func: Option<String> = None;
    let mut opt = "-O2".to_string();
    let mut target = fwp::cgen::Target::Native;
    let mut fat = false;
    let mut lib: Option<fwp::cgen::LibKind> = None;
    let mut i = 0;
    while i < args.len() {
        match args[i].as_str() {
            "-o" => {
                i += 1;
                out = args.get(i).cloned();
            }
            "--emit-c" => emit_c = true,
            "--fat" => fat = true,
            "--staticlib" => lib = Some(fwp::cgen::LibKind::Static),
            "--cdylib" => lib = Some(fwp::cgen::LibKind::Shared),
            "--link" => {
                i += 1;
                if let Some(l) = args.get(i) {
                    let mut links = fwp::ffi::links();
                    links.push(l.clone());
                    fwp::ffi::set_links(links);
                }
            }
            "--target" => {
                i += 1;
                match args.get(i).and_then(|t| fwp::cgen::Target::parse(t)) {
                    Some(t) => target = t,
                    None => {
                        eprintln!(
                            "fwp build: unknown target (native, wasm32-wasi, wasm32-browser)"
                        );
                        return ExitCode::from(2);
                    }
                }
            }
            "--fn" => {
                i += 1;
                func = args.get(i).cloned();
            }
            a if a.starts_with("-O") => opt = a.to_string(),
            a => path = Some(a.to_string()),
        }
        i += 1;
    }
    let Some(path) = path else {
        eprintln!("fwp build: missing file");
        return ExitCode::from(2);
    };
    let src = std::path::PathBuf::from(&path);
    let out = out.map(std::path::PathBuf::from).unwrap_or_else(|| {
        let stem = match &func {
            Some(f) => f.clone(),
            None => src
                .file_stem()
                .unwrap_or_default()
                .to_string_lossy()
                .to_string(),
        };
        let stem = if target.is_wasm() {
            format!("{}.wasm", stem)
        } else {
            stem
        };
        std::path::PathBuf::from(stem)
    });
    let out = match lib {
        Some(kind) if !out.to_string_lossy().contains('.') => {
            let stem = out.to_string_lossy().to_string();
            let ext = if kind == fwp::cgen::LibKind::Static {
                "a"
            } else {
                "so"
            };
            let name = if stem.starts_with("lib") {
                stem
            } else {
                format!("lib{}", stem)
            };
            std::path::PathBuf::from(format!("{}.{}", name, ext))
        }
        _ => out,
    };
    let roots = fwp::mono::Roots {
        main: func.is_none() && lib.is_none(),
        exports: func.is_some() || lib.is_some(),
        ..Default::default()
    };
    let code = fwp::driver::with_big_stack(move || {
        let (c, prog) = match fwp::driver::compile_file(&src, roots) {
            Ok(r) => r,
            Err(f) => {
                eprint!("{}", f.rendered);
                return 1;
            }
        };
        eprint!("{}", c.render_warnings());
        if let Err(e) = fwp::cgen::check_target(&prog, target) {
            eprintln!("fwp build: {}", e);
            return 1;
        }
        if let Some(kind) = lib {
            let name = out
                .file_stem()
                .map(|s| s.to_string_lossy().to_string())
                .unwrap_or_default();
            let built = fwp::cgen::generate_library(&prog, &name).and_then(|(c, h)| {
                if emit_c {
                    std::fs::write(out.with_extension("c"), c).map_err(|e| e.to_string())?;
                    std::fs::write(out.with_extension("h"), h).map_err(|e| e.to_string())
                } else {
                    fwp::cgen::compile_library(&c, &h, &out, &opt, kind)
                }
            });
            return match built {
                Ok(()) => 0,
                Err(e) => {
                    eprintln!("fwp build: {}", e);
                    1
                }
            };
        }
        let generated = match &func {
            None => fwp::cgen::generate(&prog),
            Some(name) => match prog.exports.iter().find(|(n, _)| n == name) {
                Some((_, fid)) => fwp::cgen::generate_exec(&prog, *fid, name),
                None => Err(format!("`{}` is not an exported function", name)),
            },
        };
        let csrc = match generated {
            Ok(s) => s,
            Err(e) => {
                eprintln!("fwp build: {}", e);
                return 1;
            }
        };
        if emit_c {
            let cpath = out.with_extension("c");
            if let Err(e) = std::fs::write(&cpath, &csrc) {
                eprintln!("fwp build: cannot write {}: {}", cpath.display(), e);
                return 1;
            }
            return 0;
        }
        if fat && target.is_wasm() {
            eprintln!("fwp build: --fat applies to native executables only");
            return 2;
        }
        let compiled = if fat {
            fwp::cgen::compile_fat(&csrc, &out, &opt)
        } else {
            fwp::cgen::compile_for(&csrc, &out, &opt, target)
        };
        match compiled {
            Ok(()) => 0,
            Err(e) => {
                eprintln!("fwp build: {}", e);
                1
            }
        }
    });
    ExitCode::from(code)
}

fn exec(args: &[String]) -> ExitCode {
    let (Some(path), Some(name)) = (args.first().cloned(), args.get(1).cloned()) else {
        eprintln!("fwp exec: usage: fwp exec <file.fwp> <function> [args...]");
        return ExitCode::from(2);
    };
    let fargs: Vec<String> = args[2..].to_vec();
    let roots = fwp::mono::Roots {
        exports: true,
        ..Default::default()
    };
    let code = fwp::driver::with_big_stack(move || {
        match fwp::driver::compile_file(std::path::Path::new(&path), roots) {
            Ok((c, prog)) => {
                eprint!("{}", c.render_warnings());
                match prog.exports.iter().find(|(n, _)| *n == name) {
                    Some((_, fid)) => fwp::exec::exec(&prog, *fid, &name, &fargs),
                    None => {
                        let names: Vec<&str> =
                            prog.exports.iter().map(|(n, _)| n.as_str()).collect();
                        eprintln!(
                            "fwp exec: `{}` is not an exported function (exported: {})",
                            name,
                            if names.is_empty() {
                                "none".to_string()
                            } else {
                                names.join(", ")
                            }
                        );
                        2
                    }
                }
            }
            Err(f) => {
                eprint!("{}", f.rendered);
                1
            }
        }
    });
    ExitCode::from((code & 0xff) as u8)
}

fn pipe(args: &[String]) -> ExitCode {
    let spec = args.join(" ");
    let exe = std::env::current_exe().unwrap_or_else(|_| "fwp".into());
    match fwp::exec::run_pipeline(&exe, &spec) {
        Ok(code) => ExitCode::from((code & 0xff) as u8),
        Err(e) => {
            eprintln!("fwp pipe: {}", e);
            ExitCode::from(2)
        }
    }
}
