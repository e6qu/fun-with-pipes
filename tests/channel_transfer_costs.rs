//! Runner-only operation counts for sequential channel exchanges, without timing.
#[path = "support/client_allocations.rs"]
mod client_allocations;

use std::fmt::Write;
use std::path::PathBuf;
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

fn instrument(generated: &str) -> String {
    let mut code = client_allocations::instrument_client_allocations(generated);
    let entry = "static V fwp_p_channel_send_owned(V ch, V x, void (*dup)(V)) {";
    assert_eq!(code.matches(entry).count(), 1);
    code = code.replacen(entry, &format!("static uint64_t channel_calls, channel_accepted, channel_unique, channel_retains;\n{entry}\nif(client_active)channel_calls++;"), 1);
    let retain = "                if (c->owner.queue.dup) c->owner.queue.dup(x);";
    assert_eq!(code.matches(retain).count(), 1);
    code = code.replacen(retain, &format!("                uint64_t before = client_retains;\n                uint8_t *payload_count = fwp_rc_slot(x);\n                if(client_active && payload_count && *payload_count == 1)channel_unique++;\n{retain}\n                if(client_active)channel_retains += client_retains - before;"), 1);
    // Restrict the accepted-send counter to this function; the older untyped
    // helper has the same buffer insertion and must not be counted twice.
    let start = code.find(entry).unwrap();
    let end = start + code[start..].find("\nstatic V fwp_chan_recv(").unwrap();
    let body = &code[start..end];
    let inserted = "            c->len++;";
    assert_eq!(body.matches(inserted).count(), 1);
    let body = body.replacen(
        inserted,
        &format!("{inserted}\n            if(client_active)channel_accepted++;"),
        1,
    );
    code.replace_range(start..end, &body);
    let finish = "    client_measure_end();";
    assert_eq!(code.matches(finish).count(), 1);
    code.replacen(finish, &format!("{finish}\n    fprintf(stderr, \"channel-counts\\t%llu\\t%llu\\t%llu\\t%llu\\n\", (unsigned long long)channel_calls, (unsigned long long)channel_accepted, (unsigned long long)channel_unique, (unsigned long long)channel_retains);"), 1)
}

fn execute(binary: &std::path::Path, count: &str) -> Output {
    checked(
        Command::new(binary)
            .arg(count)
            .env_remove("FWP_GC")
            .env("FWP_GC_STRESS", "0")
            .env("FWP_GC_VERIFY", "0")
            .env("FWP_REUSE_VERIFY", "0"),
    )
}

#[test]
#[ignore = "runner-only allocation/count measurements; run with explicit artifact directory"]
fn sequential_channel_operation_counts() {
    let artifacts = PathBuf::from(
        std::env::var_os("FWP_CHANNEL_COST_ARTIFACTS")
            .expect("set FWP_CHANNEL_COST_ARTIFACTS explicitly"),
    );
    std::fs::create_dir_all(&artifacts).unwrap();
    let mut rows = String::from(
        "case\tmemory\toptimization\tmessages\tsample\trequests\trequested_bytes\tretains\tpeak_charge\tfinal_charge\tcollections\tsends\taccepted\tunique_payloads\tqueue_retains\tbinary_bytes\n",
    );
    for (name, program) in [
        (
            "unique-text",
            include_str!("fixtures/channel_transfer_text.fwp"),
        ),
        (
            "unique-function",
            include_str!("fixtures/channel_transfer_function.fwp"),
        ),
        (
            "shared-text",
            include_str!("fixtures/channel_transfer_shared_text.fwp"),
        ),
        (
            "shared-function",
            include_str!("fixtures/channel_transfer_shared_function.fwp"),
        ),
        (
            "closed-function",
            include_str!("fixtures/channel_transfer_closed.fwp"),
        ),
    ] {
        let source = artifacts.join(format!("{name}.fwp"));
        std::fs::write(&source, program).unwrap();
        let compiler = env!("CARGO_BIN_EXE_fwp");
        let mut references = Vec::new();
        for n in [0, 16, 1024] {
            let count = n.to_string();
            let reference = checked(
                Command::new(compiler)
                    .env("FWP_NO_OPT", "1")
                    .args(["exec", "--interp"])
                    .arg(&source)
                    .args(["work", &count]),
            );
            assert_eq!(reference.stdout, format!("{n}\n").as_bytes());
            assert!(reference.stderr.is_empty(), "{reference:?}");
            references.push((n, reference.stdout));
        }
        for memory in ["arc", "tracing"] {
            let label = format!("{name}-{memory}-O2");
            let cfile = artifacts.join(format!("{label}.c"));
            checked(
                Command::new(compiler)
                    .env_remove("FWP_NO_OPT")
                    .args(["build", "--fn", "work", "--gc", memory, "--emit-c"])
                    .arg(&source)
                    .arg("-o")
                    .arg(&cfile),
            );
            let code = std::fs::read_to_string(&cfile).unwrap();
            let binary = artifacts.join(format!("{label}.exe"));
            fwp::cgen::compile_c(&code, &binary, "-O2").unwrap();
            let binary_bytes = std::fs::metadata(&binary).unwrap().len();
            let (tool, flag) = if cfg!(target_os = "macos") {
                ("otool", "-tvV")
            } else if cfg!(target_os = "windows") {
                ("llvm-objdump", "-d")
            } else {
                ("objdump", "-d")
            };
            let assembly = checked(Command::new(tool).arg(flag).arg(&binary));
            std::fs::write(artifacts.join(format!("{label}.asm")), assembly.stdout).unwrap();
            let measured = instrument(&code);
            std::fs::write(artifacts.join(format!("{label}-counted.c")), &measured).unwrap();
            let probe = artifacts.join(format!("{label}-counted.exe"));
            fwp::cgen::compile_c(&measured, &probe, "-O2").unwrap();
            for (n, expected) in &references {
                let count = n.to_string();
                let normal = execute(&binary, &count);
                assert_eq!(&normal.stdout, expected, "{label}/{n}");
                assert!(normal.stderr.is_empty(), "{normal:?}");
                let mut previous = None;
                for sample in 0..3 {
                    let result = execute(&probe, &count);
                    assert_eq!(&result.stdout, expected, "{label}/{n}");
                    let stderr = String::from_utf8(result.stderr).unwrap();
                    let lines: Vec<_> = stderr.lines().collect();
                    assert_eq!(lines.len(), 2, "{stderr}");
                    let memory_fields: Vec<u64> = lines[0]
                        .strip_prefix("client-memory\t")
                        .unwrap()
                        .split('\t')
                        .map(|x| x.parse().unwrap())
                        .collect();
                    let queue_fields: Vec<u64> = lines[1]
                        .strip_prefix("channel-counts\t")
                        .unwrap()
                        .split('\t')
                        .map(|x| x.parse().unwrap())
                        .collect();
                    assert_eq!(memory_fields.len(), 6);
                    assert_eq!(queue_fields.len(), 4);
                    assert_eq!(queue_fields[0], *n, "{label}: {stderr}");
                    assert_eq!(
                        queue_fields[1],
                        if name == "closed-function" { 0 } else { *n },
                        "{label}: {stderr}"
                    );
                    assert!(queue_fields[2] <= queue_fields[1], "{stderr}");
                    if memory == "arc" {
                        assert_eq!(memory_fields[4], 0, "{label}: retained storage: {stderr}");
                        assert_eq!(
                            memory_fields[5], 0,
                            "{label}: unexpected collection: {stderr}"
                        );
                    }
                    if let Some(ref previous) = previous {
                        assert_eq!(&stderr, previous, "unstable operation counts: {label}/{n}");
                    }
                    previous = Some(stderr.clone());
                    std::fs::write(
                        artifacts.join(format!("{label}-{n}-{sample}.stderr")),
                        &stderr,
                    )
                    .unwrap();
                    writeln!(
                        rows,
                        "{name}\t{memory}\tO2\t{n}\t{sample}\t{}\t{}\t{binary_bytes}",
                        lines[0].strip_prefix("client-memory\t").unwrap(),
                        lines[1].strip_prefix("channel-counts\t").unwrap()
                    )
                    .unwrap();
                    std::fs::write(artifacts.join("counts.tsv"), &rows).unwrap();
                }
            }
        }
    }
}
