use std::process::ExitCode;

use fwp::diag::SourceMap;
use fwp::parser::parse_module;
use fwp::pretty;

const USAGE: &str = "\
fwp - the fwp (\"foop\") language

usage:
  fwp run <file.fwp> [args...]   run a program's `main`
  fwp test <file.fwp>            run the `test` declarations of a file
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
    let Some(path) = args.first().cloned() else {
        eprintln!("fwp test: missing file");
        return ExitCode::from(2);
    };
    let roots = fwp::mono::Roots {
        tests: true,
        ..Default::default()
    };
    let code = fwp::driver::with_big_stack(move || {
        match fwp::driver::compile_file(std::path::Path::new(&path), roots) {
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
