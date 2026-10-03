//! The traps of plain-C arithmetic (`src/cgen.rs`, `Scalar`): overflow,
//! division by zero and `MIN / -1` in every fixed-width integer type, each
//! a program of its own, natively and in the interpreter alike.

use std::path::PathBuf;
use std::process::Command;

fn fwp() -> &'static str {
    env!("CARGO_BIN_EXE_fwp")
}

fn have_cc() -> bool {
    Command::new(std::env::var("CC").unwrap_or_else(|_| "cc".into()))
        .arg("--version")
        .output()
        .is_ok_and(|o| o.status.success())
}

const CASES: &[&str] = &[
    "127i8 | add 1",
    "-128i8 | sub 1",
    "16i8 | mul 8",
    "-128i8 | div -1",
    "-128i8 | rem -1",
    "-128i8 | neg",
    "5i8 | div 0",
    "32767i16 | add 1",
    "-32768i16 | mul -1",
    "2147483647i32 | add 1",
    "-2147483648i32 | div -1",
    "65536i32 | mul 32768",
    "9223372036854775807 | add 1",
    "-9223372036854775807 | sub 2",
    "4294967296 | mul 2147483648",
    "-9223372036854775807 | sub 1 | div -1",
    "-9223372036854775807 | sub 1 | rem -1",
    "-9223372036854775807 | sub 1 | neg",
    "7 | rem 0",
    "255u8 | add 1",
    "0u8 | sub 1",
    "16u8 | mul 16",
    "3u8 | rem 0",
    "65535u16 | add 1",
    "4294967295u32 | add 1",
    "0u32 | sub 1",
    "1u32 | div 0",
    "18446744073709551615u64 | add 1",
    "0u64 | sub 1",
    "4294967296u64 | mul 4294967296",
    "9u64 | div 0",
];

fn outcome(c: &mut Command) -> String {
    let o = c.output().unwrap();
    format!(
        "{}--- stderr\n{}--- exit {:?}",
        String::from_utf8_lossy(&o.stdout),
        String::from_utf8_lossy(&o.stderr),
        o.status.code()
    )
}

#[test]
fn traps_agree() {
    if !have_cc() {
        return;
    }
    let dir = std::env::temp_dir().join(format!("fwp-scalar-traps-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let cache = dir.join("cache");
    let threads: Vec<_> = CASES
        .iter()
        .enumerate()
        .map(|(i, case)| {
            let file: PathBuf = dir.join(format!("t{}.fwp", i));
            std::fs::write(
                &file,
                format!("main = [\"before\" | echo, {} | echo] | ignore\n", case),
            )
            .unwrap();
            let cache = cache.clone();
            std::thread::spawn(move || {
                let interp = outcome(Command::new(fwp()).args(["run", "--interp"]).arg(&file));
                let native = outcome(
                    Command::new(fwp())
                        .args(["run", "-O1"])
                        .arg(&file)
                        .env("FWP_CACHE_DIR", &cache),
                );
                (case, interp, native)
            })
        })
        .collect();
    let mut failures = Vec::new();
    for t in threads {
        let (case, interp, native) = t.join().unwrap();
        if !interp.contains("fwp: trap: ") || !interp.contains("--- exit Some(101)") {
            failures.push(format!(
                "{}: the interpreter did not trap:\n{}",
                case, interp
            ));
        } else if interp != native {
            failures.push(format!(
                "{}:\ninterpreter:\n{}\nnative:\n{}",
                case, interp, native
            ));
        }
    }
    let _ = std::fs::remove_dir_all(&dir);
    assert!(failures.is_empty(), "{}", failures.join("\n\n"));
}
