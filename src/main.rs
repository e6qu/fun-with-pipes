use std::process::ExitCode;

use fwp::diag::SourceMap;
use fwp::parser::parse_module;
use fwp::pretty;

const USAGE: &str = "\
fwp - the fwp (\"foop\") language

usage:
  fwp run [--service m[=addr]]... <file.fwp> [args...]
                                 run a program's `main` (interpreter); calls
                                 to the exported functions of each module
                                 named by --service go to that service
  fwp build <file.fwp> [-o out] [--fn name|--cli] [--emit-c] [-O0|-O1|-O2|-O3]
            [--target native|wasm32-wasi|wasm32-browser] [--fat]
            [--staticlib|--cdylib] [--link lib-or-source]...
            [--service m[=addr]]...
                                 compile `main` (or an exported function) to a
                                 native executable or a WebAssembly module;
                                 --cli makes every exported function a
                                 subcommand of one executable, with flags
                                 and --help (see docs/cli.md);
                                 --fat builds one variant per CPU feature
                                 level and picks the best at startup;
                                 --staticlib/--cdylib build a C library
                                 (and header) of the exported functions;
                                 --link adds C code for foreign functions
                                 (also accepted by run, test and exec);
                                 --service splits the program: -o names a
                                 directory that receives the main executable
                                 and one gRPC server per named module
                                 (see docs/services.md)
  fwp serve [--service m[=addr]]... <file.fwp> <module> [--listen addr]
                                 serve a module's exported functions over
                                 gRPC with the interpreter
  fwp proto <file.fwp> [--service m]...
                                 print the .proto file of the services
  fwp exec <file.fwp> <fn> [args...]
                                 run an exported function as an executable would
  fwp exec --cli <file.fwp> [command] [args...]
                                 run a file as `fwp build --cli` would
  fwp pipe '<file.fwp:fn args> | <file.fwp:fn> ...'
                                 connect exported functions with the binary
                                 typed protocol
  fwp test <file.fwp>            run the `test` declarations of a file
  fwp test --std                 run the standard library's tests
  fwp test ... --native          run tests compiled to native code
  fwp check <file.fwp>           type-check a file and print inferred types
  fwp check --parse <file.fwp>   parse a file and print its syntax tree
  fwp fmt [--check] [paths...]   format files in place (directories are
                                 searched for .fwp files; default: .);
                                 --check lists unformatted files instead
  fwp lint [paths...]            report likely mistakes and simplifications
                                 (exit status 1 if there are any); a comment
                                 `# fwp:allow(code)` above a declaration
                                 silences a rule in it
  fwp lsp                        run the language server on stdin/stdout
  fwp help                       show this message

A file argument of `-` reads the program from standard input (run, test,
check, exec, fmt, lint).
";

/// The WebAssembly build of fwp (`--target wasm32-wasip1`) has no C
/// compiler, processes, threads, sockets or `dlopen`.
const IN_WASM: bool = cfg!(target_family = "wasm");

/// Report a command or option that the WebAssembly build of fwp lacks.
fn not_in_wasm(what: &str) -> ExitCode {
    eprintln!(
        "fwp: {} is not available in the WebAssembly build of fwp",
        what
    );
    ExitCode::from(2)
}

/// In the WebAssembly build: why the interpreter cannot run `prog`
/// (reported like a compile error, before it starts).
fn host_unsupported(cmd: &str, prog: &fwp::ir::Program) -> Option<i32> {
    if !IN_WASM {
        return None;
    }
    let why = fwp::driver::wasm_host_unsupported(prog)?;
    eprintln!("fwp {}: {}", cmd, why);
    Some(1)
}

/// Remove `--link <item>` options (C libraries, sources and objects for
/// foreign functions) from the arguments before the program file.
fn take_links(args: &mut Vec<String>) {
    let mut links = Vec::new();
    let mut i = 0;
    while i < args.len() {
        if args[i] == "--link" && i + 1 < args.len() {
            links.push(args.remove(i + 1));
            args.remove(i);
        } else if args[i].ends_with(".fwp") || args[i] == "-" {
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
    if IN_WASM && !fwp::ffi::links().is_empty() {
        return not_in_wasm("`--link` (C code for foreign functions)");
    }
    match args.first().map(String::as_str) {
        Some("check") => check(&args[1..]),
        Some("run") => run(&args[1..]),
        Some("test") => test(&args[1..]),
        Some("build") => build(&args[1..]),
        Some("exec") => exec(&args[1..]),
        Some("pipe") if IN_WASM => not_in_wasm("`fwp pipe` (it starts processes)"),
        Some("pipe") => pipe(&args[1..]),
        Some("fmt") => fmt(&args[1..]),
        Some("lint") => lint(&args[1..]),
        Some("lsp") => {
            let code = fwp::driver::with_big_stack(|| {
                fwp::lsp::serve(std::io::stdin().lock(), std::io::stdout())
            });
            ExitCode::from(code as u8)
        }
        Some("serve") if IN_WASM => not_in_wasm("`fwp serve` (it needs sockets)"),
        Some("serve") => serve(&args[1..]),
        Some("proto") => proto(&args[1..]),
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
        let path = path.clone();
        return fwp::driver::with_big_stack(move || match fwp::driver::check_input(&path) {
            Ok(c) => {
                eprint!("{}", c.render_warnings());
                print!("{}", fwp::driver::signatures(&c));
                ExitCode::SUCCESS
            }
            Err(f) => {
                eprint!("{}", f.rendered);
                ExitCode::from(1)
            }
        });
    }
    let (path, text) = match read_input(path) {
        Ok(t) => t,
        Err(e) => {
            eprintln!("fwp: {}", e);
            return ExitCode::from(2);
        }
    };
    let mut sm = SourceMap::default();
    let file = sm.add(path, text.clone());
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

/// A `--service m[=addr]` option: the module and its default address.
fn service_spec(s: &str) -> (String, String) {
    match s.split_once('=') {
        Some((m, a)) => (m.to_string(), a.to_string()),
        None => (s.to_string(), fwp::mono::DEFAULT_SERVICE_ADDR.to_string()),
    }
}

/// Remove `--service m[=addr]` options before the program file.
fn take_services(args: &mut Vec<String>) -> Vec<(String, String)> {
    let mut out = Vec::new();
    let mut i = 0;
    while i < args.len() {
        if args[i] == "--service" && i + 1 < args.len() {
            out.push(service_spec(&args.remove(i + 1)));
            args.remove(i);
        } else if let Some(s) = args[i].strip_prefix("--service=") {
            out.push(service_spec(s));
            args.remove(i);
        } else if args[i].ends_with(".fwp") || args[i] == "-" {
            break;
        } else {
            i += 1;
        }
    }
    out
}

fn run(args: &[String]) -> ExitCode {
    let mut args = args.to_vec();
    let remote = take_services(&mut args);
    let Some(path) = args.first().cloned() else {
        eprintln!("fwp run: missing file");
        return ExitCode::from(2);
    };
    let prog_args: Vec<String> = args[1..].to_vec();
    let roots = fwp::mono::Roots {
        main: true,
        remote,
        ..Default::default()
    };
    let code =
        fwp::driver::with_big_stack(move || match fwp::driver::compile_input(&path, roots) {
            Ok((c, prog)) => {
                eprint!("{}", c.render_warnings());
                if let Some(code) = host_unsupported("run", &prog) {
                    return code;
                }
                fwp::interp::run_main(&prog, prog_args).exit_code
            }
            Err(f) => {
                eprint!("{}", f.rendered);
                1
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
    if native && IN_WASM {
        return not_in_wasm("`fwp test --native` (it needs a C compiler)");
    }
    let roots = fwp::mono::Roots {
        tests: true,
        std_tests,
        ..Default::default()
    };
    let code = fwp::driver::with_big_stack(move || {
        let compiled = match &path {
            Some(p) => fwp::driver::compile_input(p, roots),
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
                if let Some(code) = host_unsupported("test", &prog) {
                    return code;
                }
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
    let mut cli = false;
    let mut opt = "-O2".to_string();
    let mut target = fwp::cgen::Target::Native;
    let mut fat = false;
    let mut lib: Option<fwp::cgen::LibKind> = None;
    let mut services: Vec<(String, String)> = Vec::new();
    let mut i = 0;
    while i < args.len() {
        match args[i].as_str() {
            "--service" => {
                i += 1;
                if let Some(s) = args.get(i) {
                    services.push(service_spec(s));
                }
            }
            a if a.starts_with("--service=") => services.push(service_spec(&a[10..])),
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
            "--cli" => cli = true,
            a if a.starts_with("-O") => opt = a.to_string(),
            a => path = Some(a.to_string()),
        }
        i += 1;
    }
    let Some(path) = path else {
        eprintln!("fwp build: missing file");
        return ExitCode::from(2);
    };
    if IN_WASM && !emit_c {
        return not_in_wasm(
            "compiling with `fwp build` (it needs a C compiler; `--emit-c` writes the C source)",
        );
    }
    let src = std::path::PathBuf::from(&path);
    if cli && (func.is_some() || lib.is_some()) {
        eprintln!("fwp build: --cli builds every exported function into one executable (not with --fn, --staticlib or --cdylib)");
        return ExitCode::from(2);
    }
    if !services.is_empty() {
        if cli || func.is_some() || lib.is_some() || target.is_wasm() {
            eprintln!("fwp build: --service builds native executables (not with --fn, --staticlib, --cdylib or WebAssembly)");
            return ExitCode::from(2);
        }
        let dir = std::path::PathBuf::from(out.unwrap_or_else(|| ".".into()));
        return build_split(src, dir, services, &opt, fat, emit_c);
    }
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
        main: func.is_none() && lib.is_none() && !cli,
        exports: func.is_some() || lib.is_some() || cli,
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
            None if cli => {
                let stem = out.file_stem().unwrap_or_default().to_string_lossy();
                let name = stem.strip_suffix(".wasm").unwrap_or(&stem).to_string();
                fwp::cgen::generate_cli(&prog, &name)
            }
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

/// A split build: the main executable, whose calls to the named modules'
/// exported functions are gRPC calls, and one server per named module.
fn build_split(
    src: std::path::PathBuf,
    dir: std::path::PathBuf,
    services: Vec<(String, String)>,
    opt: &str,
    fat: bool,
    emit_c: bool,
) -> ExitCode {
    let opt = opt.to_string();
    let code = fwp::driver::with_big_stack(move || {
        if let Err(e) = std::fs::create_dir_all(&dir) {
            eprintln!("fwp build: cannot create {}: {}", dir.display(), e);
            return 1;
        }
        let stem = src
            .file_stem()
            .unwrap_or_default()
            .to_string_lossy()
            .to_string();
        let mut outputs: Vec<(Option<String>, std::path::PathBuf)> = vec![(None, dir.join(&stem))];
        for (m, _) in &services {
            if services.iter().filter(|(n, _)| n == m).count() > 1 {
                eprintln!("fwp build: service `{}` is named twice", m);
                return 2;
            }
            outputs.push((Some(m.clone()), dir.join(m.replace('.', "-"))));
        }
        for (service, exe) in outputs {
            let roots = fwp::mono::Roots {
                main: service.is_none(),
                service: service.clone(),
                remote: services.clone(),
                ..Default::default()
            };
            let (c, prog) = match fwp::driver::compile_file(&src, roots) {
                Ok(r) => r,
                Err(f) => {
                    eprint!("{}", f.rendered);
                    return 1;
                }
            };
            if service.is_none() {
                eprint!("{}", c.render_warnings());
            }
            let generated = match &service {
                None => fwp::cgen::generate(&prog),
                Some(_) => fwp::services::check_service(&prog)
                    .and_then(|_| fwp::cgen::generate_service(&prog)),
            };
            let csrc = match generated {
                Ok(s) => s,
                Err(e) => {
                    eprintln!("fwp build: {}", e);
                    return 1;
                }
            };
            let done = if emit_c {
                std::fs::write(exe.with_extension("c"), &csrc).map_err(|e| e.to_string())
            } else if fat {
                fwp::cgen::compile_fat(&csrc, &exe, &opt)
            } else {
                fwp::cgen::compile_c(&csrc, &exe, &opt)
            };
            if let Err(e) = done {
                eprintln!("fwp build: {}", e);
                return 1;
            }
        }
        0
    });
    ExitCode::from(code)
}

fn serve(args: &[String]) -> ExitCode {
    let mut args = args.to_vec();
    let mut remote = take_services(&mut args);
    let mut listen = None;
    let mut pos = Vec::new();
    let mut i = 0;
    while i < args.len() {
        if args[i] == "--listen" && i + 1 < args.len() {
            listen = Some(args[i + 1].clone());
            i += 2;
            continue;
        }
        if args[i] == "--service" && i + 1 < args.len() {
            remote.push(service_spec(&args[i + 1]));
            i += 2;
            continue;
        }
        if let Some(a) = args[i].strip_prefix("--listen=") {
            listen = Some(a.to_string());
        } else {
            pos.push(args[i].clone());
        }
        i += 1;
    }
    let [path, module] = &pos[..] else {
        eprintln!(
            "fwp serve: usage: fwp serve [--service m]... <file.fwp> <module> [--listen host:port]"
        );
        return ExitCode::from(2);
    };
    let (path, module) = (path.clone(), module.clone());
    let code = fwp::driver::with_big_stack(move || {
        let roots = fwp::mono::Roots {
            service: Some(module),
            remote,
            ..Default::default()
        };
        match fwp::driver::compile_file(std::path::Path::new(&path), roots) {
            Ok((c, prog)) => {
                eprint!("{}", c.render_warnings());
                fwp::services::serve(&prog, listen)
            }
            Err(f) => {
                eprint!("{}", f.rendered);
                1
            }
        }
    });
    ExitCode::from(code.clamp(0, 255) as u8)
}

fn proto(args: &[String]) -> ExitCode {
    let mut args = args.to_vec();
    let mut services: Vec<String> = take_services(&mut args).into_iter().map(|s| s.0).collect();
    let mut path = None;
    let mut i = 0;
    while i < args.len() {
        if args[i] == "--service" && i + 1 < args.len() {
            services.push(service_spec(&args[i + 1]).0);
            i += 2;
            continue;
        }
        path = Some(args[i].clone());
        i += 1;
    }
    let Some(path) = path else {
        eprintln!("fwp proto: usage: fwp proto <file.fwp> [--service module]...");
        return ExitCode::from(2);
    };
    let code = fwp::driver::with_big_stack(move || {
        let src = std::path::PathBuf::from(&path);
        if services.is_empty() {
            // every imported module with exported functions
            let c = match fwp::driver::check_file(&src) {
                Ok(c) => c,
                Err(f) => {
                    eprint!("{}", f.rendered);
                    return 1;
                }
            };
            let mut mods: Vec<String> = c
                .env
                .bindings
                .iter()
                .filter(|b| {
                    b.module != "main"
                        && b.module != "std"
                        && b.test_name.is_none()
                        && c.env.globals[&b.name].exported
                })
                .map(|b| b.module.clone())
                .collect();
            mods.sort();
            mods.dedup();
            services = mods;
        }
        let mut progs = Vec::new();
        for m in &services {
            let roots = fwp::mono::Roots {
                service: Some(m.clone()),
                ..Default::default()
            };
            match fwp::driver::compile_file(&src, roots) {
                Ok((_, p)) => progs.push(p),
                Err(f) => {
                    eprint!("{}", f.rendered);
                    return 1;
                }
            }
        }
        if progs.is_empty() {
            eprintln!("fwp proto: no imported module exports functions");
            return 1;
        }
        let name = src
            .file_name()
            .map(|n| n.to_string_lossy().to_string())
            .unwrap_or_default();
        match fwp::services::proto_text(&progs, &name) {
            Ok(t) => {
                print!("{}", t);
                0
            }
            Err(e) => {
                eprintln!("fwp proto: {}", e);
                1
            }
        }
    });
    ExitCode::from(code)
}

fn exec(args: &[String]) -> ExitCode {
    let (cli, args) = match args.first().map(String::as_str) {
        Some("--cli") => (true, &args[1..]),
        _ => (false, args),
    };
    let (Some(path), Some(name)) = (
        args.first().cloned(),
        args.get(1).cloned().or_else(|| cli.then(String::new)),
    ) else {
        eprintln!("fwp exec: usage: fwp exec <file.fwp> <function> [args...]\n       fwp exec --cli <file.fwp> [command] [args...]");
        return ExitCode::from(2);
    };
    let fargs: Vec<String> = args[if cli { 1 } else { 2 }..].to_vec();
    let roots = fwp::mono::Roots {
        exports: true,
        ..Default::default()
    };
    let code =
        fwp::driver::with_big_stack(move || match fwp::driver::compile_input(&path, roots) {
            Ok((c, prog)) => {
                eprint!("{}", c.render_warnings());
                if let Some(code) = host_unsupported("exec", &prog) {
                    return code;
                }
                if cli {
                    return fwp::exec::exec_program(&prog, &program_name(&path), &fargs);
                }
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
        });
    ExitCode::from((code & 0xff) as u8)
}

/// The name of a multi-command program: the file name without `.fwp`
/// (`fwp exec --cli`), or of the executable (`fwp build --cli`).
fn program_name(path: &str) -> String {
    if path == "-" {
        return "main".into();
    }
    std::path::Path::new(path)
        .file_stem()
        .map(|s| s.to_string_lossy().to_string())
        .unwrap_or_else(|| "main".into())
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

/// The `.fwp` files named by the arguments; directories are searched
/// recursively (skipping hidden directories and `target`).
fn source_files(args: &[String]) -> Vec<std::path::PathBuf> {
    fn walk(dir: &std::path::Path, out: &mut Vec<std::path::PathBuf>) {
        let Ok(rd) = std::fs::read_dir(dir) else {
            return;
        };
        let mut entries: Vec<_> = rd.filter_map(|e| e.ok()).map(|e| e.path()).collect();
        entries.sort();
        for p in entries {
            let name = p.file_name().unwrap_or_default().to_string_lossy();
            if p.is_dir() {
                if !name.starts_with('.') && name != "target" {
                    walk(&p, out);
                }
            } else if p.extension().is_some_and(|e| e == "fwp") {
                out.push(p);
            }
        }
    }
    let mut out = Vec::new();
    let paths: Vec<&str> = if args.is_empty() {
        vec!["."]
    } else {
        args.iter().map(String::as_str).collect()
    };
    for a in paths {
        let p = std::path::PathBuf::from(a);
        if a != "-" && p.is_dir() {
            walk(&p, &mut out);
        } else {
            out.push(p);
        }
    }
    out
}

/// The display name and text of a source file; `-` is standard input.
fn read_input(path: &str) -> Result<(String, String), String> {
    if path == "-" {
        return fwp::driver::read_stdin()
            .map(|t| (fwp::driver::STDIN_NAME.to_string(), t))
            .map_err(|e| format!("cannot read standard input: {}", e));
    }
    std::fs::read_to_string(path)
        .map(|t| (path.to_string(), t))
        .map_err(|e| format!("cannot read {}: {}", path, e))
}

fn fmt(args: &[String]) -> ExitCode {
    let check = args.iter().any(|a| a == "--check");
    let paths: Vec<String> = args.iter().filter(|a| *a != "--check").cloned().collect();
    let mut code = ExitCode::SUCCESS;
    for path in source_files(&paths) {
        let (name, text) = match read_input(&path.to_string_lossy()) {
            Ok(t) => t,
            Err(e) => {
                eprintln!("fwp fmt: {}", e);
                code = ExitCode::from(2);
                continue;
            }
        };
        let formatted = match fwp::fmt::format_source(&text) {
            Ok(f) => f,
            Err(d) => {
                let mut sm = SourceMap::default();
                sm.add(name, text);
                eprint!("{}", d.render(&sm));
                code = ExitCode::from(1);
                continue;
            }
        };
        if path.as_os_str() == "-" && !check {
            // standard input: the formatted text goes to standard output
            print!("{}", formatted);
            continue;
        }
        if formatted == text {
            continue;
        }
        if check {
            println!("{}", name);
            code = ExitCode::from(1);
        } else if let Err(e) = std::fs::write(&path, formatted) {
            eprintln!("fwp fmt: cannot write {}: {}", path.display(), e);
            code = ExitCode::from(2);
        }
    }
    code
}

fn lint(args: &[String]) -> ExitCode {
    let mut code = ExitCode::SUCCESS;
    for path in source_files(args) {
        let (name, text) = match read_input(&path.to_string_lossy()) {
            Ok(t) => t,
            Err(e) => {
                eprintln!("fwp lint: {}", e);
                code = ExitCode::from(2);
                continue;
            }
        };
        let mut sm = SourceMap::default();
        let file = sm.add(name, text.clone());
        let diags = match fwp::lint::lint_source(&text, file) {
            Ok(ws) => ws.into_iter().map(|w| w.diag).collect(),
            Err(errors) => errors,
        };
        if !diags.is_empty() {
            eprint!("{}", fwp::diag::render_all(&diags, &sm));
            code = ExitCode::from(1);
        }
    }
    code
}
