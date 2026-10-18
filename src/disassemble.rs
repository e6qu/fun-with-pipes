//! Disassemble an existing ahead-of-time binary through an explicitly selected
//! LLVM tool. No source is compiled and the inspected program is never executed.
use crate::json::Json;
use std::path::Path;
use std::process::Command;

pub fn inspect(path: &Path, tool: &str) -> Result<Json, String> {
    let path = std::fs::canonicalize(path).map_err(|e| e.to_string())?;
    if !path.is_file() {
        return Err("disassembly needs a binary file".into());
    }
    let version = Command::new(tool)
        .arg("--version")
        .output()
        .map_err(|e| format!("cannot start {tool}: {e}; install LLVM or select --tool PATH"))?;
    if !version.status.success() {
        return Err(String::from_utf8_lossy(&version.stderr).into_owned());
    }
    let output = Command::new(tool)
        .args([
            "--disassemble",
            "--print-imm-hex",
            "--demangle",
            "--source",
            "--line-numbers",
        ])
        .arg(&path)
        .output()
        .map_err(|e| e.to_string())?;
    if !output.status.success() {
        return Err(String::from_utf8_lossy(&output.stderr).into_owned());
    }
    let text = String::from_utf8(output.stdout).map_err(|e| e.to_string())?;
    let instructions = parse(&text);
    if instructions.is_empty() {
        return Err(
            "the binary has no disassembled instructions; check its format and executable sections"
                .into(),
        );
    }
    Ok(Json::obj(vec![
        ("binary", Json::str(path.to_string_lossy())),
        ("tool", Json::str(tool)),
        (
            "tool_version",
            Json::str(String::from_utf8_lossy(&version.stdout)),
        ),
        ("instructions", Json::Arr(instructions)),
        ("text", Json::str(text)),
        (
            "diagnostics",
            Json::str(String::from_utf8_lossy(&output.stderr)),
        ),
    ]))
}

/// Preserve LLVM's encoding spelling: some targets print byte groups, others
/// print an instruction word. It is not relabeled as target memory byte order.
pub fn parse(text: &str) -> Vec<Json> {
    let mut function = String::new();
    let mut section = String::new();
    let mut instructions = Vec::new();
    let mut source_file = String::new();
    let mut source_line = None;
    let mut source_text = String::new();
    for line in text.lines() {
        let line = line.trim();
        if let Some(name) = line
            .strip_prefix("Disassembly of section ")
            .and_then(|s| s.strip_suffix(':'))
        {
            section = name.to_string();
            function.clear();
            source_file.clear();
            source_line = None;
            source_text.clear();
            continue;
        }
        if let Some((_, name)) = line.split_once(" <") {
            if let Some(name) = name.strip_suffix(">:") {
                function = name.to_string();
                source_file.clear();
                source_line = None;
                source_text.clear();
                continue;
            }
        }
        if let Some(comment) = line.strip_prefix("; ") {
            if let Some((file, line)) = comment.rsplit_once(':') {
                if let Ok(line) = line.parse::<u32>() {
                    source_file = file.to_string();
                    source_line = Some(line);
                    source_text.clear();
                    continue;
                }
            }
            if !comment.ends_with("():") {
                source_text = comment.to_string();
            }
            continue;
        }
        let Some((address, rest)) = line.split_once(':') else {
            continue;
        };
        if address.is_empty() || !address.bytes().all(|c| c.is_ascii_hexdigit()) {
            continue;
        }
        // LLVM separates the raw encoding and assembly with tabs. A mnemonic
        // such as `add` can itself consist only of hex digits: do not guess it
        // is an instruction byte from whitespace-delimited tokens alone.
        let columns: Vec<_> = rest
            .trim_start_matches(' ')
            .split('\t')
            .filter(|s| !s.trim().is_empty())
            .collect();
        if columns.len() < 2 {
            continue;
        }
        let encoding = columns[0].trim();
        if !encoding
            .split_whitespace()
            .all(|s| s.len() % 2 == 0 && s.bytes().all(|b| b.is_ascii_hexdigit()))
        {
            continue;
        }
        let assembly = columns[1..].join(" ");
        instructions.push(Json::obj(vec![
            ("address", Json::str(format!("0x{address}"))),
            ("encoding", Json::str(encoding)),
            ("assembly", Json::str(assembly.trim())),
            ("function", Json::str(&function)),
            ("section", Json::str(&section)),
            (
                "c_file",
                if source_file.is_empty() {
                    Json::Null
                } else {
                    Json::str(&source_file)
                },
            ),
            (
                "c_line",
                source_line.map_or(Json::Null, |line| Json::Num(line.to_string())),
            ),
            (
                "c_source",
                if source_text.is_empty() {
                    Json::Null
                } else {
                    Json::str(&source_text)
                },
            ),
        ]));
    }
    instructions
}

pub fn run(args: &[String]) -> i32 {
    let mut tool = None;
    let mut json = false;
    let mut path = None;
    let mut args = args.iter();
    while let Some(arg) = args.next() {
        match arg.as_str() {
            "--tool" => match args.next() {
                Some(t) if !t.starts_with('-') => tool = Some(t),
                _ => {
                    eprintln!("--tool needs a path");
                    return 2;
                }
            },
            "--json" => json = true,
            "--help" | "-h" => {
                println!("Usage: fwp disassemble [--json] --tool LLVM_OBJDUMP BINARY\nInspect existing native machine code without executing it.");
                return 0;
            }
            s if s.starts_with('-') || path.is_some() => {
                eprintln!("unexpected argument {arg}");
                return 2;
            }
            _ => path = Some(arg),
        }
    }
    let Some(path) = path else {
        eprintln!("fwp disassemble: missing binary");
        return 2;
    };
    let Some(tool) = tool else {
        eprintln!("fwp disassemble: select --tool LLVM_OBJDUMP explicitly");
        return 2;
    };
    match inspect(Path::new(path), tool) {
        Ok(report) => {
            if json {
                println!("{report}");
            } else {
                print!("{}", report.get("text").and_then(Json::as_str).unwrap());
            }
            0
        }
        Err(error) => {
            eprintln!("fwp disassemble: {error}");
            1
        }
    }
}
