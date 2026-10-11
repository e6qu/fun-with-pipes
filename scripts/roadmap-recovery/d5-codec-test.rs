//! Serializer leaves must preserve borrowed inputs and raw/native semantics.
use std::path::PathBuf;
use std::process::{Command, Output};
fn checked(command: &mut Command) -> Output {
    let out = command.output().unwrap();
    assert!(
        out.status.success(),
        "{command:?}: {}: {}",
        out.status,
        String::from_utf8_lossy(&out.stderr)
    );
    out
}
#[test]
fn serializer_and_codec_results_preserve_input_aliases() {
    let directory = std::env::temp_dir().join(format!("fwp-codec-{}", std::process::id()));
    std::fs::create_dir_all(&directory).unwrap();
    let source = directory.join("codecs.fwp");
    std::fs::write(
        &source,
        r#"
checks = make {
    json = Json.Str | json.encode | string.length,
    typed-json = json.write | string.length,
    url = url.encode | string.length,
    hex = string.length | http.to-hex | string.length,
    help = const {verbose = False, count = 3} | cli.help | string.length,
    gzip = string.to-bytes | gzip.compress | bytes.length,
    gzip-chunk = string.to-bytes | gzip._chunk | bytes.length,
    deflate = string.to-bytes | deflate.compress | bytes.length,
    accept = ws._accept | string.length,
    ws-deflate = string.to-bytes | ws._deflate | bytes.length,
    key = const () | ws._key | string.length,
    gzip-end = string.length | gzip._end 0 | bytes.length,
    close = ws._close-payload 1000 | bytes.length,
    frame = string.to-bytes | ws._frame False 2 | bytes.length,
}
main = read-all () | concat "heap-dependent text" | both id checks | echo
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    let artifacts = std::env::var_os("FWP_CODEC_ARTIFACTS")
        .map(PathBuf::from)
        .unwrap_or_else(|| directory.clone());
    std::fs::create_dir_all(&artifacts).unwrap();
    std::fs::copy(&source, artifacts.join("codecs.fwp")).unwrap();
    for opt in ["-O1", "-O2"] {
        for stack in ["0", "1"] {
            let label = format!("codecs{opt}-stack{stack}");
            let exe = directory.join(&label);
            let cfile = artifacts.join(format!("{label}.c"));
            checked(
                Command::new(fwp)
                    .env_remove("FWP_NO_OPT")
                    .env("FWP_STACK", stack)
                    .args(["build"])
                    .arg(&source)
                    .args([opt, "--emit-c", "-o"])
                    .arg(&cfile),
            );
            checked(
                Command::new(fwp)
                    .env_remove("FWP_NO_OPT")
                    .env("FWP_STACK", stack)
                    .args(["build"])
                    .arg(&source)
                    .args([opt, "-o"])
                    .arg(&exe),
            );
            std::fs::copy(&exe, artifacts.join(format!("{label}.bin"))).unwrap();
            for verify in ["0", "1"] {
                let out = Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", verify)
                    .output()
                    .unwrap();
                let prefix = format!("{label}-reuse{verify}");
                std::fs::write(artifacts.join(format!("{prefix}.stdout")), &out.stdout).unwrap();
                std::fs::write(artifacts.join(format!("{prefix}.stderr")), &out.stderr).unwrap();
                std::fs::write(
                    artifacts.join(format!("{prefix}.status")),
                    format!("{}\n", out.status),
                )
                .unwrap();
                assert_eq!(
                    out.status.code(),
                    reference.status.code(),
                    "{prefix}: {}",
                    String::from_utf8_lossy(&out.stderr)
                );
                assert_eq!(out.stdout, reference.stdout, "{prefix}");
                assert_eq!(out.stderr, reference.stderr, "{prefix}");
            }
        }
    }
    std::fs::remove_dir_all(&directory).unwrap();
}
