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

#[test]
fn socket_scratch_is_released_on_cancel_and_allocation_failure() {
    let dir = fwp::cgen::TempDir::new("socket-scratch").unwrap();
    let input = dir.join("main.fwp");
    let cfile = dir.join("main.c");
    std::fs::write(&input, "main = ()\n").unwrap();
    let built = Command::new(env!("CARGO_BIN_EXE_fwp"))
        .args(["build", "--emit-c"])
        .arg(&input)
        .arg("-o")
        .arg(&cfile)
        .output()
        .unwrap();
    assert!(built.status.success(), "{built:?}");
    let mut code = std::fs::read_to_string(cfile)
        .unwrap()
        .replace("#define FWP_UNWIND 0", "#define FWP_UNWIND 1");
    let declaration = "typedef uint64_t V;";
    code = code.replace(
        declaration,
        &format!("{declaration}\nstatic void socket_managed_allocation(void);"),
    );
    let slow = "static inline void *fwp_gc_alloc(size_t n, int leaf) {";
    assert!(code.contains(slow));
    code = code.replace(
        slow,
        &format!("{slow} if(leaf!=0) socket_managed_allocation();"),
    );
    for name in ["fwp_tcp_read", "fwp_p_udp_recv_from", "fwp_p_udp_send_to"] {
        let start = code.find(&format!("static V {name}(")).unwrap();
        let end = start + code[start..].find("\n}\n").unwrap() + 3;
        let body = code[start..end]
            .replace("malloc(", "socket_native_alloc(")
            .replace("free(buf)", "socket_native_free(buf)")
            .replace(
                "&buffer_cleanup, free,",
                "&buffer_cleanup, socket_native_free,",
            )
            .replace("fwp_socket_recv(", "socket_receive(")
            .replace("fwp_socket_recvfrom(", "socket_receive_from(")
            .replace("fwp_socket_sendto(", "socket_send_to(")
            .replace("fwp_wait_fd(", "socket_wait(")
            .replace("fwp_resolve(", "socket_resolve(");
        code.replace_range(start..end, &body);
    }
    let start = code.find("static void fwp_addrinfo_release(").unwrap();
    let end = start + code[start..].find("\n}\n").unwrap() + 3;
    let body = code[start..end].replace("freeaddrinfo(", "socket_resolver_free(");
    code.replace_range(start..end, &body);
    code.insert_str(start, include_str!("fixtures/socket_scratch_peer.c"));
    let code = code[..code.find("int main(").unwrap()].to_string()
        + include_str!("fixtures/socket_scratch_cleanup.c");
    let no_buffer_cleanup = code.replace(
        "fwp_cleanup_push(&buffer_cleanup, socket_native_free, buf);",
        "/* omitted buffer owner */",
    );
    let no_resolver_cleanup = code.replace(
        "fwp_cleanup_push(&address_cleanup, fwp_addrinfo_release, &res);",
        "/* omitted resolver owner */",
    );
    // Keep the ordinary-path pops valid; the controls fail during unwind before those paths.
    assert_ne!(code, no_buffer_cleanup);
    assert_ne!(code, no_resolver_cleanup);
    for opt in ["-O1", "-O2"] {
        for (source, expected) in [
            (&code, 0),
            (&no_buffer_cleanup, 248),
            (&no_resolver_cleanup, 248),
        ] {
            let binary = dir.join("socket-scratch.exe");
            fwp::cgen::compile_c(source, &binary, opt).unwrap();
            let output = Command::new(&binary).env("FWP_GC", "off").output().unwrap();
            assert_eq!(output.status.code(), Some(expected), "{opt}: {output:?}");
        }
    }
}
