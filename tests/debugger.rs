use fwp::json::Json;
use std::io::Write;
use std::process::{Command, Stdio};

#[test]
fn protocol_steps_inspects_and_traces_without_mixing_program_output() {
    let dir = fwp::cgen::TempDir::new("debugger").unwrap();
    let source = dir.join("program.fwp");
    std::fs::write(
        &source,
        "increment : I64 -> I64\nincrement = add 1\nmain = 41 | increment | echo\n",
    )
    .unwrap();
    let mut process = Command::new(env!("CARGO_BIN_EXE_fwp"))
        .args(["debug", "--json"])
        .arg(&source)
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .unwrap();
    process
        .stdin
        .take()
        .unwrap()
        .write_all(
            br#"{"id":1,"command":"break","argument":"increment"}
{"id":2,"command":"continue"}
{"id":3,"command":"locals"}
{"id":4,"command":"stack"}
{"id":5,"command":"trace","argument":"call expression bind return error"}
{"id":6,"command":"continue"}
"#,
        )
        .unwrap();
    let output = process.wait_with_output().unwrap();
    assert!(output.status.success(), "{output:?}");
    let messages: Vec<_> = std::str::from_utf8(&output.stdout)
        .unwrap()
        .lines()
        .map(|line| Json::parse(line).unwrap())
        .collect();
    assert!(messages
        .iter()
        .any(|m| m.get("event").and_then(Json::as_str) == Some("expression")));
    let locals = messages
        .iter()
        .find(|m| m.get("id") == Some(&Json::Num("3".into())))
        .unwrap();
    assert_eq!(
        locals.at(&["result"]).unwrap().as_array().unwrap()[0]
            .at(&["value", "display"])
            .and_then(Json::as_str),
        Some("41")
    );
    assert!(messages
        .iter()
        .any(|m| m.get("event").and_then(Json::as_str) == Some("output")
            && m.get("text").and_then(Json::as_str) == Some("42\n")));
    assert_eq!(
        messages.last().unwrap().get("event").and_then(Json::as_str),
        Some("finished")
    );
    assert!(output.stderr.is_empty(), "{output:?}");
}

#[test]
fn disassembly_keeps_encoding_and_assembly_separate() {
    let text = "Disassembly of section .text:\n0000000000000000 <worker>:\n       0: 48 01 c0   \tadd\t%rax, %rax\n       3: c3         \tretq\n";
    let parsed = fwp::disassemble::parse(text);
    assert_eq!(parsed.len(), 2);
    assert_eq!(
        parsed[0].get("assembly").and_then(Json::as_str),
        Some("add %rax, %rax")
    );
    assert_eq!(
        parsed[0].get("encoding").and_then(Json::as_str),
        Some("48 01 c0")
    );
    assert_eq!(
        parsed[0].get("function").and_then(Json::as_str),
        Some("worker")
    );
    let arm = fwp::disassemble::parse("0 <f>:\n0: d65f03c0\tret\n");
    assert_eq!(
        arm[0].get("encoding").and_then(Json::as_str),
        Some("d65f03c0")
    );
}
