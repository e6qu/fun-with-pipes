use std::process::ExitCode;

use fwp::diag::SourceMap;
use fwp::parser::parse_module;
use fwp::pretty;

const USAGE: &str = "\
fwp - the fwp (\"foop\") language

usage:
  fwp check --parse <file.fwp>   parse a file and print its syntax tree
  fwp help                       show this message
";

fn main() -> ExitCode {
    let args: Vec<String> = std::env::args().skip(1).collect();
    match args.first().map(String::as_str) {
        Some("check") => check(&args[1..]),
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
