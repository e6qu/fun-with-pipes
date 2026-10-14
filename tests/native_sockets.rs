//! Generated runtime socket ABI, error propagation and binary transfers.
#![cfg(any(target_os = "linux", target_os = "macos", target_os = "windows"))]
use std::process::Command;

#[test]
fn native_socket_handles_errors_and_binary_transfers() {
    let source = include_str!("fixtures/native_socket_probe.c").replace(
        "/* SOCKET_RUNTIME */",
        include_str!("../runtime/fwp_rt_socket.c"),
    );
    let dir = fwp::cgen::TempDir::new("native-sockets").unwrap();
    let binary = dir.join(if cfg!(windows) { "probe.exe" } else { "probe" });
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&source, &binary, opt).unwrap();
        let result = Command::new(&binary).output().unwrap();
        assert!(result.status.success(), "{opt}: {result:?}");
    }
}
