//! Generated REST/MCP entries must preserve values and release request owners.
use fwp::json::Json;
use std::io::Write;
use std::path::{Path, PathBuf};
use std::process::{Command, Output, Stdio};

#[path = "support/client_allocations.rs"]
mod client_allocations;

fn fixture() -> PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/fixtures/server_entries.fwp")
}

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

fn generated(dir: &Path, interface: &str, mode: &str, free: bool) -> String {
    let name = interface.trim_start_matches("--");
    let path = dir.join(format!("{name}-{mode}-{free}.c"));
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", interface, "--gc", mode, "--emit-c", "-o"])
            .arg(&path)
            .arg(fixture())
            .env("FWP_FREE", if free { "1" } else { "0" }),
    );
    let source = std::fs::read_to_string(path).unwrap();
    assert_eq!(source.contains("#define FWP_ARC_ONLY 1"), mode == "arc");
    source
}

fn run_input(command: &mut Command, input: String) -> Output {
    let mut child = command
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .unwrap();
    let mut stdin = child.stdin.take().unwrap();
    // Drain output while writing: repeated replies can exceed a pipe's capacity.
    let writer = std::thread::spawn(move || stdin.write_all(input.as_bytes()));
    let output = child.wait_with_output().unwrap();
    writer.join().unwrap().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

fn request(id: usize, method: &str, parameters: &str) -> String {
    format!(
        "{{\"jsonrpc\":\"2.0\",\"id\":{id},\"method\":\"{method}\",\"params\":{{\"_meta\":{{\"io.modelcontextprotocol/protocolVersion\":\"{}\"}},{parameters}}}}}\n",
        fwp::mcp::VERSION
    )
}

fn tool(id: usize, name: &str, arguments: &str) -> String {
    request(
        id,
        "tools/call",
        &format!("\"name\":\"{name}\",\"arguments\":{arguments}"),
    )
}

fn input(repeats: usize) -> String {
    let mut input = String::new();
    for repetition in 0..repeats {
        let id = repetition * 8;
        input.push_str(&tool(id, "copy", r#"{"text":"owned é","values":[1,-2,3]}"#));
        input.push_str(&tool(
            id + 1,
            "duplicate",
            r#"{"text":"aliased","values":[4,5]}"#,
        ));
        input.push_str(&tool(id + 2, "checked", r#"{"input":7}"#));
        input.push_str(&tool(id + 3, "checked", r#"{"input":0}"#));
        input.push_str(&tool(id + 4, "outcome", r#"{"input":0}"#));
        input.push_str(&tool(id + 5, "copy", r#"{"text":9,"values":[]}"#));
        input.push_str("{broken JSON\n");
        input.push_str(&request(id + 7, "unknown/method", "\"unused\":true"));
        input.push_str("\n{\"jsonrpc\":\"2.0\",\"method\":\"notifications/cancelled\"}\n");
    }
    input
}

fn assert_replies(output: &Output, repeats: usize) {
    let text = String::from_utf8_lossy(&output.stdout);
    let replies: Vec<_> = text
        .lines()
        .map(|line| Json::parse(line).unwrap())
        .collect();
    assert_eq!(replies.len(), repeats * 8, "{text}");
    for (repetition, replies) in replies.as_chunks::<8>().0.iter().enumerate() {
        for (index, reply) in replies.iter().enumerate() {
            let expected = if index == 6 {
                Json::Null
            } else {
                Json::Num((repetition * 8 + index) as f64)
            };
            assert_eq!(reply.get("id"), Some(&expected), "{reply:?}");
        }
        assert_eq!(
            replies[0].at(&["result", "structuredContent"]),
            Some(&Json::parse(r#"{"text":"owned é","values":[1,-2,3]}"#).unwrap())
        );
        assert_eq!(
            replies[1].at(&["result", "structuredContent", "result"]),
            Some(
                &Json::parse(
                    r#"[{"text":"aliased","values":[4,5]},{"text":"aliased","values":[4,5]}]"#
                )
                .unwrap()
            )
        );
        assert_eq!(
            replies[2]
                .at(&["result", "structuredContent", "result"])
                .and_then(Json::as_str),
            Some("value 7")
        );
        for reply in &replies[3..6] {
            assert_eq!(
                reply.at(&["result", "isError"]),
                Some(&Json::Bool(true)),
                "{reply:?}"
            );
        }
        assert_eq!(
            replies[6].at(&["error", "code"]),
            Some(&Json::Num(-32700.0))
        );
        assert_eq!(
            replies[7].at(&["error", "code"]),
            Some(&Json::Num(-32601.0))
        );
    }
}

#[test]
fn mcp_stdio_aliases_errors_and_notifications_match_raw_interpreter() {
    let dir = fwp::cgen::TempDir::new("mcp-entry").unwrap();
    eprintln!("MCP entries: raw interpreter reference");
    let reference = run_input(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["serve", "--mcp", "--interp"])
            .arg(fixture())
            .env("FWP_NO_OPT", "1"),
        input(2),
    );
    assert_replies(&reference, 2);
    for mode in ["tracing", "arc"] {
        eprintln!("MCP entries: {mode} native result and alias checks");
        let source = generated(dir.path(), "--mcp", mode, true);
        let binary = dir.join(format!("mcp-{mode}.exe"));
        fwp::cgen::compile_c(&source, &binary, "-O1").unwrap();
        let stress = if mode == "tracing" { "16" } else { "0" };
        let result = run_input(
            Command::new(&binary)
                .env("FWP_GC_STRESS", stress)
                .env("FWP_GC_VERIFY", if mode == "tracing" { "1" } else { "0" })
                .env(
                    "FWP_REUSE_VERIFY",
                    if mode == "tracing" { "1" } else { "0" },
                ),
            input(2),
        );
        assert_eq!(result.stdout, reference.stdout, "{mode}");
        assert!(result.stderr.is_empty(), "{mode}: {result:?}");
    }
}

#[test]
fn generated_entries_reject_unproved_channel_cycles() {
    let dir = fwp::cgen::TempDir::new("entry-cycle").unwrap();
    let source = dir.join("cycle.fwp");
    std::fs::write(&source, "# expose: rest, mcp\n\nfunctions : I64 -> Channel[() -> String] ! {Async}\nfunctions = channel.make\n\nexport rejected : () -> () ! {Async}\nrejected = const 1 | functions | channel.close\n").unwrap();
    for interface in ["--rest", "--mcp"] {
        let output = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", interface, "--gc", "arc", "--emit-c", "-o"])
            .arg(dir.join("rejected.c"))
            .arg(&source)
            .output()
            .unwrap();
        assert!(!output.status.success());
        let error = String::from_utf8_lossy(&output.stderr);
        assert!(
            error.contains("--gc arc") && error.contains("channel payloads cannot contain"),
            "{interface}: {error}"
        );
    }
}

#[test]
#[ignore = "runner-only repeated generated-entry memory measurement"]
fn mcp_stdio_releases_repeated_requests_without_collection() {
    assert_eq!(std::env::var("GITHUB_ACTIONS").as_deref(), Ok("true"));
    let artifacts =
        PathBuf::from(std::env::var_os("FWP_SERVER_ENTRY_ARTIFACTS").expect("entry artifacts"));
    std::fs::create_dir_all(&artifacts).unwrap();
    std::fs::copy(fixture(), artifacts.join("server_entries.fwp")).unwrap();
    std::fs::write(artifacts.join("scope.txt"), "Repeated generated MCP standard-input server, same fixture and messages in tracing and checked ARC. One, 16 or 128 repetitions of eight replies: returned record, duplicated record aliases, successful value, caught error, explicit error result, invalid typed input, malformed JSON, and unknown method; blank lines and notifications produce no reply. Ordinary -O2 servers validate every response before the allocation-instrumented server is compared byte for byte. Collection is disabled and counted freeing enabled except in the explicit tracing build with FWP_FREE=0, which must demonstrate increasing retained storage. Managed allocation requests, payload bytes, actual count increments and peak/final charged storage cover constant initialization completion through main and cached-value cleanup, before whole-runtime disposal. Raw buffers, OS storage, allocator metadata and process RSS are excluded. No elapsed-time or C/Rust comparison.\n").unwrap();
    let mut rows = String::from("mode\tfree\trepeats\trequests\trequested_bytes\tretains\tpeak_bytes\tfinal_bytes\tcollections\n");
    let mut finals = Vec::new();
    for (mode, free) in [("tracing", true), ("arc", true), ("tracing", false)] {
        let source = generated(&artifacts, "--mcp", mode, free);
        let ordinary = artifacts.join(format!("mcp-{mode}-{free}.exe"));
        fwp::cgen::compile_c(&source, &ordinary, "-O2").unwrap();
        let measured = client_allocations::instrument_client_allocations(&source);
        let binary = artifacts.join(format!("mcp-measured-{mode}-{free}.exe"));
        std::fs::write(binary.with_extension("c"), &measured).unwrap();
        fwp::cgen::compile_c(&measured, &binary, "-O2").unwrap();
        let mut case_finals = Vec::new();
        for repeats in [1, 16, 128] {
            let run = |path: &Path| {
                run_input(
                    Command::new(path)
                        .env("FWP_GC", "off")
                        .env("FWP_GC_STRESS", "0")
                        .env("FWP_GC_VERIFY", "0")
                        .env("FWP_REUSE_VERIFY", "0"),
                    input(repeats),
                )
            };
            let expected = run(&ordinary);
            assert_replies(&expected, repeats);
            let output = run(&binary);
            assert_eq!(output.stdout, expected.stdout);
            let stderr = String::from_utf8(output.stderr).unwrap();
            std::fs::write(
                artifacts.join(format!("mcp-{mode}-{free}-{repeats}.stderr")),
                &stderr,
            )
            .unwrap();
            let counters: Vec<u64> = stderr
                .lines()
                .find_map(|line| line.strip_prefix("client-memory\t"))
                .expect("memory counters")
                .split('\t')
                .map(|n| n.parse().unwrap())
                .collect();
            assert_eq!(counters.len(), 6);
            assert_eq!(counters[5], 0);
            assert!(counters[3] >= counters[4]);
            case_finals.push(counters[4]);
            rows.push_str(&format!(
                "{mode}\t{free}\t{repeats}\t{}\n",
                counters
                    .iter()
                    .map(u64::to_string)
                    .collect::<Vec<_>>()
                    .join("\t")
            ));
            std::fs::write(artifacts.join("mcp-stdio-memory.tsv"), &rows).unwrap();
        }
        if free {
            assert!(
                case_finals.windows(2).all(|pair| pair[0] == pair[1]),
                "{mode}: {case_finals:?}"
            );
        } else {
            assert!(
                case_finals.windows(2).all(|pair| pair[0] < pair[1]),
                "missing-free control: {case_finals:?}"
            );
        }
        finals.push((mode, free, case_finals));
    }
    eprintln!("MCP final managed bytes: {finals:?}");
}
