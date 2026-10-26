//! Real service calls whose queued callbacks retain native response channels.
use super::*;

fn instrument(generated: &str) -> String {
    let mut code = server_measurement::instrument(generated);
    for (before, after) in [
        (
            "typedef uint64_t V;",
            "typedef uint64_t V;\nstatic unsigned response_live, response_created, response_peak;\nstatic uintptr_t response_listener_fd;",
        ),
        (
            "    q->owner.sink_drop = g_sink_drop;",
            "    q->owner.sink_drop = g_sink_drop;\n    response_created++; if(++response_live > 8) _Exit(201);\n    if(response_live > response_peak) response_peak = response_live;",
        ),
        (
            "static void g_sink_drop(void *arg) {",
            "static void g_sink_drop(void *arg) {\n    if(!response_live) _Exit(202); response_live--;",
        ),
        (
            "    server_begin();",
            "    response_listener_fd = (uintptr_t)fd;\n    server_begin();",
        ),
        (
            "    server_final_recorded=1;",
            "    server_final_recorded=1;\n    fprintf(stderr, \"response-channels\\t%u\\t%u\\t%u\\n\", response_created, response_live, response_peak);\n    if(response_live || response_created != server_expected_calls) _Exit(203);\n    fprintf(stderr, \"response-listener-storage\\t%zu\\n\", response_listener_charge());",
        ),
    ] {
        assert_eq!(code.matches(before).count(), 1, "{before}");
        code = code.replacen(before, after, 1);
    }
    let finished = "static void server_task_finished(void (*entry)(void *,int)) {";
    assert_eq!(code.matches(finished).count(), 1);
    code = code.replacen(
        finished,
        &format!(
            "{}\n{finished}",
            include_str!("../fixtures/server-memory/queued-listener.c")
        ),
        1,
    );
    code
}

fn client(binary: Option<&Path>, address: Option<&str>) -> Command {
    let mut command = match binary {
        Some(binary) => Command::new(binary),
        None => {
            let mut command = Command::new(fwp());
            command.args(["run", "--interp"]);
            if address.is_some() {
                command.args(["--service", "queued"]);
            }
            command.arg(dir().join("queued-client.fwp"));
            command.env("FWP_NO_OPT", "1");
            command
        }
    };
    if let Some(address) = address {
        command.env("FWP_SERVICE_QUEUED", address);
    }
    command
}

fn check_output(command: Command, label: &str, artifacts: &Path) {
    let output = run(command, 120);
    std::fs::write(artifacts.join(format!("{label}.stdout")), &output.stdout).unwrap();
    std::fs::write(artifacts.join(format!("{label}.stderr")), &output.stderr).unwrap();
    assert!(output.status.success(), "{label}: {}", render(&output));
    assert_eq!(
        String::from_utf8_lossy(&output.stdout),
        include_str!("../grpc/queued-client.out"),
        "{label}"
    );
    assert!(output.stderr.is_empty(), "{label}: {}", render(&output));
}

fn compile(code: &str, label: &str, opt: &str, artifacts: &Path) -> PathBuf {
    let binary = artifacts.join(format!("{label}.exe"));
    std::fs::write(artifacts.join(format!("{label}.c")), code).unwrap();
    fwp::cgen::compile_c(code, &binary, opt).unwrap();
    // Inspect the executable header, so an emulated executable cannot count
    // as native architecture coverage merely because it happens to run.
    let bytes = std::fs::read(&binary).unwrap();
    assert!(bytes.len() >= 64, "{label}: truncated executable");
    let machine = if bytes.starts_with(b"\x7fELF") {
        assert_eq!(&bytes[4..6], &[2, 1], "64-bit little-endian ELF");
        match u16::from_le_bytes(bytes[18..20].try_into().unwrap()) {
            62 => "x86_64",
            183 => "aarch64",
            other => panic!("{label}: unexpected ELF machine {other}"),
        }
    } else if bytes.starts_with(b"MZ") {
        let pe = u32::from_le_bytes(bytes[60..64].try_into().unwrap()) as usize;
        assert_eq!(&bytes[pe..pe + 4], b"PE\0\0");
        assert_eq!(
            u16::from_le_bytes(bytes[pe + 24..pe + 26].try_into().unwrap()),
            0x20b
        );
        match u16::from_le_bytes(bytes[pe + 4..pe + 6].try_into().unwrap()) {
            0x8664 => "x86_64",
            0xaa64 => "aarch64",
            other => panic!("{label}: unexpected PE machine {other}"),
        }
    } else {
        assert_eq!(
            &bytes[..4],
            b"\xcf\xfa\xed\xfe",
            "single-architecture Mach-O"
        );
        match u32::from_le_bytes(bytes[4..8].try_into().unwrap()) {
            0x1000007 => "x86_64",
            0x100000c => "aarch64",
            other => panic!("{label}: unexpected Mach-O machine {other}"),
        }
    };
    assert_eq!(
        machine,
        std::env::consts::ARCH,
        "{label}: non-native binary"
    );
    std::fs::write(artifacts.join(format!("{label}.architecture")), machine).unwrap();
    let (tool, flag) = if cfg!(target_os = "macos") {
        ("otool", "-tvV")
    } else if cfg!(target_os = "windows") {
        ("llvm-objdump", "-d")
    } else {
        ("objdump", "-d")
    };
    let mut disassemble = Command::new(tool);
    disassemble.arg(flag).arg(&binary);
    let assembly = run(disassemble, 60);
    assert!(assembly.status.success(), "{}", render(&assembly));
    std::fs::write(artifacts.join(format!("{label}.asm")), assembly.stdout).unwrap();
    let mut symbols = Command::new("nm");
    symbols.arg(&binary);
    let symbols = run(symbols, 30);
    assert!(symbols.status.success(), "{}", render(&symbols));
    let text = String::from_utf8_lossy(&symbols.stdout);

    for symbol in ["fwp_heap_scan", "fwp_heap_mark_all", "fwp_heap_sweep"] {
        assert!(!text.contains(symbol), "{label} retains {symbol}");
    }

    std::fs::write(artifacts.join(format!("{label}.nm")), symbols.stdout).unwrap();
    binary
}

fn check_queued_response_channels(opt: &str) {
    assert!(have_cc(), "a native C compiler is required");
    let scratch = scratch(&format!("queued-responses-counted{opt}"));
    let artifacts = std::env::var_os("FWP_QUEUED_GRPC_ARTIFACTS")
        .map(PathBuf::from)
        .unwrap_or_else(|| scratch.join("evidence"))
        .join(format!("counted{opt}"));
    std::fs::create_dir_all(&artifacts).unwrap();
    for file in ["queued.fwp", "queued-client.fwp", "queued-client.out"] {
        std::fs::copy(dir().join(file), artifacts.join(file)).unwrap();
    }
    check_output(client(None, None), "local-raw-interpreter", &artifacts);
    let mut reference = Command::new(fwp());
    reference
        .args(["serve", "--interp"])
        .arg(dir().join("queued-client.fwp"))
        .args(["queued", "--listen", "127.0.0.1:0"])
        .env("FWP_NO_OPT", "1");
    let reference = start(reference, Duration::from_secs(60));
    check_output(
        client(None, Some(&reference.addr)),
        "remote-raw-interpreter",
        &artifacts,
    );
    let split = scratch.join("counted");
    build(
        &[
            "--service",
            "queued",
            "--emit-c",
            dir().join("queued-client.fwp").to_str().unwrap(),
            "-o",
            split.to_str().unwrap(),
        ],
        &dir(),
    );
    let client_code = std::fs::read_to_string(split.join("queued-client.c")).unwrap();
    let server_code = std::fs::read_to_string(split.join("queued.c")).unwrap();
    let measured_code = instrument(&server_code);
    let release = "            c->owner.queue_drop(element);";
    assert_eq!(measured_code.matches(release).count(), 1);
    let broken_code = measured_code.replace(release, "            (void)element;");
    let label = format!("counted{opt}");
    let client_binary = compile(&client_code, &format!("{label}-client"), opt, &artifacts);
    check_output(
        client(Some(&client_binary), Some(&reference.addr)),
        &format!("{label}-interpreted-server"),
        &artifacts,
    );
    let ordinary = compile(&server_code, &format!("{label}-ordinary"), opt, &artifacts);
    let mut command = Command::new(&ordinary);
    command.args(["--listen", "127.0.0.1:0"]);
    let ordinary = start(command, Duration::from_secs(60));
    check_output(
        client(None, Some(&ordinary.addr)),
        &format!("{label}-interpreted-client"),
        &artifacts,
    );
    check_output(
        client(Some(&client_binary), Some(&ordinary.addr)),
        &format!("{label}-native"),
        &artifacts,
    );
    drop(ordinary);
    for (variant, code) in [
        ("measured", &measured_code),
        ("omitted-release", &broken_code),
    ] {
        let case = format!("{label}-{variant}");
        let binary = compile(code, &case, opt, &artifacts);
        let mut command = Command::new(&binary);
        command
            .args(["--listen", "127.0.0.1:0"])
            .env("FWP_SERVER_MEASURE_CALLS", "72");
        let mut server = start(command, Duration::from_secs(60));
        if variant == "omitted-release" {
            let output = run(client(Some(&client_binary), Some(&server.addr)), 120);
            std::fs::write(
                artifacts.join(format!("{case}-client.log")),
                render(&output),
            )
            .unwrap();
            let began = Instant::now();
            let status = loop {
                if let Some(status) = server.child.try_wait().unwrap() {
                    break status;
                }
                assert!(
                    began.elapsed() < Duration::from_secs(15),
                    "missing-release control did not exit: {}",
                    server.log.lock().unwrap()
                );
                std::thread::sleep(Duration::from_millis(20));
            };
            assert_eq!(
                status.code(),
                Some(201),
                "{case}: {}",
                server.log.lock().unwrap()
            );
            std::fs::write(artifacts.join(format!("{case}.status")), "201\n").unwrap();
        } else {
            check_output(
                client(Some(&client_binary), Some(&server.addr)),
                &case,
                &artifacts,
            );
            assert!(
                server.wait_log("server-storage\t"),
                "{case}: {}",
                server.log.lock().unwrap()
            );
            assert!(server.child.try_wait().unwrap().is_none(), "{case} exited");
            let log = server.log.lock().unwrap().clone();
            std::fs::write(artifacts.join(format!("{case}-server.log")), &log).unwrap();
            let responses: Vec<u64> = log
                .lines()
                .find_map(|line| line.strip_prefix("response-channels\t"))
                .unwrap()
                .split('\t')
                .map(|n| n.parse().unwrap())
                .collect();
            assert_eq!(&responses[..2], &[72, 0], "{case}");
            assert!((1..=8).contains(&responses[2]), "{case}");
            let final_counts: Vec<u64> = log
                .lines()
                .find_map(|line| line.strip_prefix("server-final\t"))
                .unwrap()
                .split('\t')
                .map(|n| n.parse().unwrap())
                .collect();
            assert_eq!(final_counts.len(), 14);
            let listener_charge: u64 = log
                .lines()
                .find_map(|line| line.strip_prefix("response-listener-storage\t"))
                .unwrap()
                .parse()
                .unwrap();
            assert_eq!(
                final_counts[4], listener_charge,
                "{case}: storage beyond the live listener remains"
            );
            assert_eq!(
                &final_counts[5..],
                &[72, 72, 1, 1, 1, 72, 0, 0, 0],
                "{case}"
            );
            std::fs::write(
                artifacts.join(format!("{case}.status")),
                "running after completed sample\n",
            )
            .unwrap();
        }
        std::fs::write(
            artifacts.join(format!("{case}-server.log")),
            server.log.lock().unwrap().as_bytes(),
        )
        .unwrap();
    }
}

#[test]
fn queued_response_channels_o0() {
    check_queued_response_channels("-O0");
}

#[test]
fn queued_response_channels_o2() {
    check_queued_response_channels("-O2");
}
