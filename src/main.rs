use std::process::ExitCode;

use fwp::diag::SourceMap;
use fwp::parser::parse_module;
use fwp::pretty;

const USAGE: &str = "\
fwp - the fwp (\"foop\") language

usage:
  fwp run <file.fwp> [args...]   run a program's `main` (interpreter)
  fwp build <file.fwp> [-o out] [--emit-c] [-O0|-O1|-O2|-O3]
                                 compile `main` to a native executable
  fwp test <file.fwp>            run the `test` declarations of a file
  fwp test --std                 run the standard library's tests
  fwp test ... --native          run tests compiled to native code
  fwp check <file.fwp>           type-check a file and print inferred types
  fwp check --parse <file.fwp>   parse a file and print its syntax tree
  fwp help                       show this message
";

fn main() -> ExitCode {
    let args: Vec<String> = std::env::args().skip(1).collect();
    match args.first().map(String::as_str) {
        Some("check") => check(&args[1..]),
        Some("run") => run(&args[1..]),
        Some("test") => test(&args[1..]),
        Some("build") => build(&args[1..]),
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
    ExitCode::from(code.clamp(0, 255) as u8)
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
                let exe = std::env::temp_dir().join(format!("fwp-tests-{}", std::process::id()));
                if let Err(e) = fwp::cgen::compile_c(&src, &exe, "-O1") {
                    eprintln!("fwp test: {}", e);
                    return 1;
                }
                let status = std::process::Command::new(&exe).status();
                let _ = std::fs::remove_file(&exe);
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
    let mut opt = "-O2".to_string();
    let mut i = 0;
    while i < args.len() {
        match args[i].as_str() {
            "-o" => {
                i += 1;
                out = args.get(i).cloned();
            }
            "--emit-c" => emit_c = true,
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
        let stem = src
            .file_stem()
            .unwrap_or_default()
            .to_string_lossy()
            .to_string();
        std::path::PathBuf::from(stem)
    });
    let roots = fwp::mono::Roots {
        main: true,
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
        let csrc = match fwp::cgen::generate(&prog) {
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
        match fwp::cgen::compile_c(&csrc, &out, &opt) {
            Ok(()) => 0,
            Err(e) => {
                eprintln!("fwp build: {}", e);
                1
            }
        }
    });
    ExitCode::from(code)
}
