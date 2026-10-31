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
fn mixed_recursion_keeps_debugger_calls_and_return_order() {
    let dir = fwp::cgen::TempDir::new("debugger-recursion").unwrap();
    let source = dir.join("program.fwp");
    std::fs::write(
        &source,
        "rec mixed : I64 -> I64\nmixed = match\n    0 -> 0\n    1 -> 0 | mixed | add 1\n    _ -> sub 1 | mixed\nmain = 4 | mixed | echo\n",
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
            b"{\"id\":1,\"command\":\"trace\",\"argument\":\"call return\"}\n{\"id\":2,\"command\":\"continue\"}\n",
        )
        .unwrap();
    let output = process.wait_with_output().unwrap();
    assert!(output.status.success(), "{output:?}");
    assert!(output.stderr.is_empty(), "{output:?}");
    let messages: Vec<_> = std::str::from_utf8(&output.stdout)
        .unwrap()
        .lines()
        .map(|line| Json::parse(line).unwrap())
        .collect();
    let events: Vec<_> = messages
        .iter()
        .filter(|message| message.get("function").and_then(Json::as_str) == Some("mixed"))
        .collect();
    assert_eq!(events.len(), 10, "{events:?}");
    let mut depths = Vec::new();
    for event in &events[..5] {
        assert_eq!(event.get("event").and_then(Json::as_str), Some("call"));
        let Json::Num(depth) = event.get("depth").unwrap() else {
            panic!("missing call depth: {event}")
        };
        depths.push(depth.parse::<usize>().unwrap());
    }
    assert!(
        depths.windows(2).all(|pair| pair[0] < pair[1]),
        "{depths:?}"
    );
    for (event, depth) in events[5..].iter().zip(depths.into_iter().rev()) {
        assert_eq!(event.get("event").and_then(Json::as_str), Some("return"));
        assert_eq!(event.get("depth"), Some(&Json::Num(depth.to_string())));
    }
    assert!(messages.iter().any(|message| {
        message.get("event").and_then(Json::as_str) == Some("output")
            && message.get("text").and_then(Json::as_str) == Some("1\n")
    }));
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

#[test]
fn debugger_resolves_shadowed_source_names() {
    let dir = fwp::cgen::TempDir::new("debugger-locals").unwrap();
    let source = dir.join("locals.fwp");
    std::fs::write(
        &source,
        "main =\n    let x = 3\n    in let x = x + 2\n    in x | echo\n",
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
            br#"{"id":1,"command":"break","argument":"locals.fwp:4"}
{"id":2,"command":"continue"}
{"id":3,"command":"print","argument":"x"}
{"id":4,"command":"clear","argument":"locals.fwp:4"}
{"id":5,"command":"continue"}
"#,
        )
        .unwrap();
    let output = process.wait_with_output().unwrap();
    assert!(output.status.success(), "{output:?}");
    let messages: Vec<Json> = std::str::from_utf8(&output.stdout)
        .unwrap()
        .lines()
        .map(|line| Json::parse(line).unwrap())
        .collect();
    let answer = messages
        .iter()
        .find(|m| m.get("id") == Some(&Json::Num("3".into())))
        .unwrap();
    assert_eq!(
        answer.at(&["result", "name"]).and_then(Json::as_str),
        Some("x"),
        "{messages:?}"
    );
    assert_eq!(
        answer
            .at(&["result", "value", "display"])
            .and_then(Json::as_str),
        Some("5"),
        "{messages:?}"
    );
}
