use std::process::ExitCode;

use fwp::diag::SourceMap;
use fwp::parser::parse_module;
use fwp::pretty;

const USAGE: &str = "\
fwp - the fwp (\"foop\") language

usage:
  fwp run [--service m[=addr]]... <file.fwp> [args...]
                                 run a program's `main`, compiled to native
                                 code (cached); calls to the exported
                                 functions of each module named by --service
                                 go to that service
  fwp build <file.fwp> [-o out] [--fn name|--cli|--rest] [--emit-c] [-O0|-O1|-O2|-O3]
            [--target native|wasm32-wasi|wasm32-browser] [--fat]
            [--memory static [--heap S] [--pool S] [--stack S]
                             [--tasks N] [--task-stack S] [--threads N]]
            [--wasm-async jspi|asyncify]
            [--staticlib|--cdylib] [--link lib-or-source]...
            [--service m[=addr]]...
                                 compile `main` (or an exported function) to a
                                 native executable or a WebAssembly module;
                                 --cli makes every exported function a
                                 subcommand of one executable, with flags,
                                 --help, --version, --completions
                                 bash|zsh|fish and --man (see docs/cli.md);
                                 --rest makes every exported function an
                                 endpoint of one HTTP server, with JSON
                                 and an OpenAPI document (see docs/rest.md);
                                 --memory static maps all of the program's
                                 memory once at startup, of the given sizes
                                 (such as 64M), and none after it;
                                 --fat builds one variant per CPU feature
                                 level and picks the best at startup;
                                 --wasm-async=asyncify runs the tasks of a
                                 WebAssembly program without JSPI (needs
                                 binaryen's wasm-opt);
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
                                 gRPC
  fwp serve --rest <file.fwp> [--listen addr]
                                 serve a file's exported functions as REST
                                 endpoints
                                 (every `fwp serve`, and the servers that
                                 --rest, --grpc and --service build, take
                                 --tls-cert file --tls-key file to serve
                                 over TLS; see docs/tls.md)
  fwp proto <file.fwp> [--service m]...
                                 print the .proto file of the services
  fwp openapi [--yaml] <file.fwp>
                                 print the OpenAPI document of the endpoints
  fwp openapi --import <spec.json> [-o client.fwp]
                                 generate an fwp client module of an API
                                 (OpenAPI 3 or Swagger 2.0, JSON or YAML)
  fwp build <file.fwp> --grpc [-o out]
  fwp serve --grpc <file.fwp> [--listen addr]
  fwp proto --grpc <file.fwp>    a gRPC server of a file's exported
                                 functions (built or served) and its
                                 .proto file; with reflection and health
                                 checking (see docs/grpc.md)
  fwp proto --import <file.proto> [-o out.fwp]
                                 fwp types, clients and server routes for
                                 the services of a .proto file
  fwp exec <file.fwp> <fn> [args...]
                                 run an exported function as an executable would
  fwp exec --cli <file.fwp> [command] [args...]
                                 run a file as `fwp build --cli` would
                                 (`fwp exec --cli f.fwp --completions bash`
                                 prints its completion script)
  fwp pipe '<file.fwp:fn args> | <file.fwp:fn> ...'
                                 connect exported functions with the binary
                                 typed protocol
  fwp test <file.fwp>            run the `test` declarations of a file
  fwp test --std                 run the standard library's tests
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

run, exec, test, serve and pipe compile programs to native executables
through C, cached by content in `fwp cache dir` (FWP_CACHE_DIR; at most
FWP_CACHE_MAX, default 256); -O0..-O3 before the file sets the C
optimization level (default -O2, -O1 for tests). --interp (or
FWP_RUN=interp) runs the interpreter instead, as does a missing C compiler.
  fwp cache dir | clean          print or empty the cache of executables
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

/// Take `--interp`, `--native` and `-O<n>` before the program file.
fn take_run_options(
    cmd: &str,
    args: &mut Vec<String>,
    opt: &str,
) -> Result<(bool, String), ExitCode> {
    let asked_native = args
        .iter()
        .take_while(|a| !a.ends_with(".fwp") && *a != "-")
        .any(|a| a == "--native");
    match fwp::aot::take_mode(args) {
        Ok(m) => {
            if m == fwp::aot::Mode::Native && IN_WASM && asked_native {
                return Err(not_in_wasm(&format!(
                    "`fwp {} --native` (it needs a C compiler)",
                    cmd
                )));
            }
            Ok((fwp::aot::wants_native(m), fwp::aot::take_opt(args, opt)))
        }
        Err(e) => {
            eprintln!("fwp {}: {}", cmd, e);
            Err(ExitCode::from(2))
        }
    }
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
    #[cfg(target_family = "wasm")]
    fwp::fiber::keep();
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
        Some("cache") => ExitCode::from(fwp::aot::cache_command(&args[1..]) as u8),
        Some("openapi") => openapi(&args[1..]),
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
    let (native, opt) = match take_run_options("run", &mut args, "-O2") {
        Ok(o) => o,
        Err(c) => return c,
    };
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
                if native {
                    let generated = fwp::cgen::generate(&prog);
                    let name = program_name(&path);
                    if let Some(code) =
                        fwp::aot::run_native("run", generated, &opt, &name, &prog_args)
                    {
                        return code;
                    }
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
    let mut args = args.to_vec();
    // no arguments go to the program, so the mode may follow the file
    args.sort_by_key(|a| a != "--interp" && a != "--native");
    let (native, opt) = match take_run_options("test", &mut args, "-O1") {
        Ok(o) => o,
        Err(c) => return c,
    };
    let std_tests = args.iter().any(|a| a == "--std");
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
            Some(p) => fwp::driver::compile_input(p, roots),
            None => fwp::driver::compile_source("<empty>", "", roots),
        };
        match compiled {
            Ok((c, prog)) => {
                eprint!("{}", c.render_warnings());
                if let Some(code) = host_unsupported("test", &prog) {
                    return code;
                }
                if native {
                    let generated = fwp::cgen::generate_tests(&prog);
                    let name = path
                        .as_deref()
                        .map(program_name)
                        .unwrap_or_else(|| "std".into());
                    if let Some(code) = fwp::aot::run_native("test", generated, &opt, &name, &[]) {
                        return code;
                    }
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
    if args.iter().any(|a| a == "--grpc") {
        return ExitCode::from(fwp::grpc_cli::build(args).clamp(0, 255) as u8);
    }
    let mut path = None;
    let mut out = None;
    let mut emit_c = false;
    let mut func: Option<String> = None;
    let mut cli = false;
    let mut rest = false;
    let mut opt = "-O2".to_string();
    let mut target = fwp::cgen::Target::Native;
    let mut fat = false;
    let mut wasm_async = fwp::asyncify::WasmAsync::Jspi;
    let mut lib: Option<fwp::cgen::LibKind> = None;
    let mut services: Vec<(String, String)> = Vec::new();
    let mut memory: Option<fwp::cgen::StaticMemory> = None;
    let mut sizes: Vec<(String, String)> = Vec::new();
    let mut i = 0;
    while i < args.len() {
        match args[i].as_str() {
            "--memory" | "--memory=static" | "--memory=dynamic" => {
                let v = match args[i].split_once('=') {
                    Some((_, v)) => Some(v.to_string()),
                    None => {
                        i += 1;
                        args.get(i).cloned()
                    }
                };
                match v.as_deref() {
                    Some("static") => memory = Some(Default::default()),
                    Some("dynamic") => memory = None,
                    _ => {
                        eprintln!("fwp build: --memory is static or dynamic");
                        return ExitCode::from(2);
                    }
                }
            }
            o @ ("--heap" | "--pool" | "--stack" | "--tasks" | "--task-stack" | "--threads") => {
                i += 1;
                match args.get(i) {
                    Some(v) => sizes.push((o.to_string(), v.clone())),
                    None => {
                        eprintln!("fwp build: {} needs a value", o);
                        return ExitCode::from(2);
                    }
                }
            }
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
            "--wasm-async" | "--wasm-async=jspi" | "--wasm-async=asyncify" => {
                let v = match args[i].split_once('=') {
                    Some((_, v)) => Some(v.to_string()),
                    None => {
                        i += 1;
                        args.get(i).cloned()
                    }
                };
                match v.as_deref().and_then(fwp::asyncify::WasmAsync::parse) {
                    Some(w) => wasm_async = w,
                    None => {
                        eprintln!("fwp build: --wasm-async is jspi or asyncify");
                        return ExitCode::from(2);
                    }
                }
            }
            "--fn" => {
                i += 1;
                func = args.get(i).cloned();
            }
            "--cli" => cli = true,
            "--rest" => rest = true,
            a if a.starts_with("-O") => opt = a.to_string(),
            a => path = Some(a.to_string()),
        }
        i += 1;
    }
    let Some(path) = path else {
        eprintln!("fwp build: missing file");
        return ExitCode::from(2);
    };
    if !sizes.is_empty() && memory.is_none() {
        eprintln!(
            "fwp build: {} sets a part of static memory: add --memory static",
            sizes[0].0
        );
        return ExitCode::from(2);
    }
    if let Some(m) = memory.as_mut() {
        if target.is_wasm() || lib.is_some() {
            eprintln!("fwp build: --memory static builds native executables (not WebAssembly or libraries)");
            return ExitCode::from(2);
        }
        for (o, v) in &sizes {
            let n = if o == "--tasks" || o == "--threads" {
                v.parse::<u64>().ok().filter(|n| *n <= 65536)
            } else {
                fwp::cgen::parse_size(v).filter(|n| *n >= 64 << 10)
            };
            let Some(n) = n else {
                eprintln!(
                    "fwp build: {} {}: expected {}",
                    o,
                    v,
                    if o == "--tasks" || o == "--threads" {
                        "a count"
                    } else {
                        "a size of at least 64K, such as 512K, 64M or 1G"
                    }
                );
                return ExitCode::from(2);
            };
            match o.as_str() {
                "--heap" => m.heap = n,
                "--pool" => m.pool = n,
                "--stack" => m.stack = n,
                "--tasks" => m.tasks = n,
                "--task-stack" => m.task_stack = n,
                _ => m.threads = n,
            }
        }
        fwp::cgen::set_static_memory(Some(*m));
    }
    if IN_WASM && !emit_c {
        return not_in_wasm(
            "compiling with `fwp build` (it needs a C compiler; `--emit-c` writes the C source)",
        );
    }
    let src = std::path::PathBuf::from(&path);
    if rest && (cli || func.is_some() || lib.is_some() || !services.is_empty()) {
        eprintln!("fwp build: --rest builds every exported function into one server (not with --cli, --fn, --staticlib, --cdylib or --service)");
        return ExitCode::from(2);
    }
    if rest && target.is_wasm() {
        eprintln!("fwp build: --rest builds a native server: WebAssembly targets have no sockets (the `Network` effect)");
        return ExitCode::from(2);
    }
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
        let compiled = if rest {
            fwp::rest::compile(&src)
        } else {
            fwp::driver::compile_file(&src, roots)
        };
        let (c, prog) = match compiled {
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
        // tasks without JSPI: the module goes through Asyncify (programs
        // without tasks need nothing)
        let asyncify = target.is_wasm()
            && wasm_async == fwp::asyncify::WasmAsync::Asyncify
            && fwp::cgen::uses_async(&prog);
        if asyncify && fwp::asyncify::wasm_opt().is_none() {
            eprintln!("fwp build: --wasm-async=asyncify needs binaryen's wasm-opt (`npm install -g binaryen`, or set FWP_WASM_OPT)");
            return 1;
        }
        let csrc = if asyncify {
            format!("{}{}", fwp::asyncify::ASYNCIFY_MARK, csrc)
        } else {
            csrc
        };
        let compiled = if fat {
            fwp::cgen::compile_fat(&csrc, &out, &opt)
        } else {
            fwp::cgen::compile_for(&csrc, &out, &opt, target).and_then(|_| {
                if asyncify {
                    fwp::asyncify::apply(&out, &opt)
                } else {
                    Ok(())
                }
            })
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
    if args.first().map(String::as_str) == Some("--rest") {
        return serve_rest(&args[1..]);
    }
    if args.iter().any(|a| a == "--grpc") {
        return ExitCode::from(fwp::grpc_cli::serve(args).clamp(0, 255) as u8);
    }
    let mut args = args.to_vec();
    let (native, opt) = match take_run_options("serve", &mut args, "-O2") {
        Ok(o) => o,
        Err(c) => return c,
    };
    let tls = match fwp::tls::server_files(&mut args) {
        Ok(t) => t,
        Err(e) => {
            eprintln!("fwp serve: {}", e);
            return ExitCode::from(2);
        }
    };
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
            "fwp serve: usage: fwp serve [--service m]... <file.fwp> <module> [--listen host:port] [--tls-cert file --tls-key file]"
        );
        return ExitCode::from(2);
    };
    let (path, module) = (path.clone(), module.clone());
    let code = fwp::driver::with_big_stack(move || {
        let roots = fwp::mono::Roots {
            service: Some(module.clone()),
            remote,
            ..Default::default()
        };
        match fwp::driver::compile_file(std::path::Path::new(&path), roots) {
            Ok((c, prog)) => {
                eprint!("{}", c.render_warnings());
                if native {
                    let generated = fwp::services::check_service(&prog)
                        .and_then(|_| fwp::cgen::generate_service(&prog));
                    let mut sargs = Vec::new();
                    if let Some(l) = &listen {
                        sargs.extend(["--listen".to_string(), l.clone()]);
                    }
                    sargs.extend(fwp::aot::tls_args(&tls));
                    let name = module.replace('.', "-");
                    if let Some(code) =
                        fwp::aot::run_native("serve", generated, &opt, &name, &sargs)
                    {
                        return code;
                    }
                }
                fwp::services::serve(&prog, listen, tls)
            }
            Err(f) => {
                eprint!("{}", f.rendered);
                1
            }
        }
    });
    ExitCode::from(code.clamp(0, 255) as u8)
}

/// `fwp serve --rest file.fwp [--listen addr] [--openapi]`: the REST
/// server of a file, compiled (interpreted with `--interp`).
fn serve_rest(args: &[String]) -> ExitCode {
    let mut args = args.to_vec();
    let (native, opt) = match take_run_options("serve", &mut args, "-O2") {
        Ok(o) => o,
        Err(c) => return c,
    };
    let Some(path) = args.iter().find(|a| a.ends_with(".fwp")).cloned() else {
        eprintln!("fwp serve: usage: fwp serve --rest <file.fwp> [--listen host:port]");
        return ExitCode::from(2);
    };
    let server_args: Vec<String> = args.iter().filter(|a| **a != path).cloned().collect();
    let code = fwp::driver::with_big_stack(move || {
        match fwp::rest::compile(std::path::Path::new(&path)) {
            Ok((c, prog)) => {
                eprint!("{}", c.render_warnings());
                if native {
                    let generated = fwp::cgen::generate(&prog);
                    let name = program_name(&path);
                    if let Some(code) =
                        fwp::aot::run_native("serve", generated, &opt, &name, &server_args)
                    {
                        return code;
                    }
                }
                fwp::interp::run_main(&prog, server_args).exit_code
            }
            Err(f) => {
                eprint!("{}", f.rendered);
                1
            }
        }
    });
    ExitCode::from((code & 0xff) as u8)
}

/// `fwp openapi file.fwp`: the OpenAPI document of a file's endpoints;
/// `fwp openapi --import spec.json [-o out.fwp]`: an fwp client module.
fn openapi(args: &[String]) -> ExitCode {
    let mut import = None;
    let mut out = None;
    let mut path = None;
    let mut yaml = false;
    let mut i = 0;
    while i < args.len() {
        match args[i].as_str() {
            "--yaml" => yaml = true,
            "--import" => {
                i += 1;
                import = args.get(i).cloned();
            }
            "-o" => {
                i += 1;
                out = args.get(i).cloned();
            }
            a => path = Some(a.to_string()),
        }
        i += 1;
    }
    if let Some(spec) = import {
        let text = match std::fs::read_to_string(&spec) {
            Ok(t) => t,
            Err(e) => {
                eprintln!("fwp openapi: cannot read {}: {}", spec, e);
                return ExitCode::from(2);
            }
        };
        let module = match fwp::openapi_import::client(&text) {
            Ok(m) => m,
            Err(e) => {
                eprintln!("fwp openapi: {}: {}", spec, e);
                return ExitCode::from(1);
            }
        };
        for w in &module.warnings {
            eprintln!("fwp openapi: {}: {}", spec, w);
        }
        return match out {
            Some(o) => match std::fs::write(&o, &module.text) {
                Ok(()) => ExitCode::SUCCESS,
                Err(e) => {
                    eprintln!("fwp openapi: cannot write {}: {}", o, e);
                    ExitCode::from(1)
                }
            },
            None => {
                print!("{}", module.text);
                ExitCode::SUCCESS
            }
        };
    }
    let Some(path) = path else {
        eprintln!("fwp openapi: usage: fwp openapi [--yaml] <file.fwp>\n       fwp openapi --import <spec.json> [-o client.fwp]");
        return ExitCode::from(2);
    };
    let code = fwp::driver::with_big_stack(move || {
        match fwp::rest::describe(std::path::Path::new(&path)) {
            Ok((c, _, _, doc)) => {
                eprint!("{}", c.render_warnings());
                if yaml {
                    print!("{}", fwp::openapi::yaml(&doc));
                } else {
                    print!("{}", doc.pretty());
                }
                0
            }
            Err(f) => {
                eprint!("{}", f.rendered);
                1
            }
        }
    });
    ExitCode::from(code)
}

fn proto(args: &[String]) -> ExitCode {
    if args.iter().any(|a| a == "--grpc" || a == "--import") {
        return ExitCode::from(fwp::grpc_cli::proto(args).clamp(0, 255) as u8);
    }
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
    let mut args = args.to_vec();
    let (native, opt) = match take_run_options("exec", &mut args, "-O2") {
        Ok(o) => o,
        Err(c) => return c,
    };
    let args = &args[..];
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
                let pname = program_name(&path);
                if cli {
                    if native {
                        let generated = fwp::cgen::generate_cli(&prog, &pname);
                        if let Some(code) =
                            fwp::aot::run_native("exec", generated, &opt, &pname, &fargs)
                        {
                            return code;
                        }
                    }
                    return fwp::exec::exec_program(&prog, &pname, &fargs);
                }
                match prog.exports.iter().find(|(n, _)| *n == name) {
                    Some((_, fid)) => {
                        if native {
                            let generated = fwp::cgen::generate_exec(&prog, *fid, &name);
                            if let Some(code) =
                                fwp::aot::run_native("exec", generated, &opt, &name, &fargs)
                            {
                                return code;
                            }
                        }
                        fwp::exec::exec(&prog, *fid, &name, &fargs)
                    }
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
    // the mode's options come before the stages, whose own arguments may
    // look like them
    let lead = args
        .iter()
        .take_while(|a| *a == "--interp" || *a == "--native")
        .count();
    let mut mode_args = args[..lead].to_vec();
    let args = &args[lead..];
    let interp = match fwp::aot::take_mode(&mut mode_args) {
        Ok(m) => m == fwp::aot::Mode::Interp,
        Err(e) => {
            eprintln!("fwp pipe: {}", e);
            return ExitCode::from(2);
        }
    };
    let spec = args.join(" ");
    let exe = std::env::current_exe().unwrap_or_else(|_| "fwp".into());
    match fwp::exec::run_pipeline(&exe, &spec, interp) {
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
