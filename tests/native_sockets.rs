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

#[test]
fn socket_addresses_reject_nul_before_using_the_prefix() {
    let dir = fwp::cgen::TempDir::new("socket-address").unwrap();
    let input = dir.join("main.fwp");
    std::fs::write(
        &input,
        include_str!("fixtures/socket_address_validation.fwp"),
    )
    .unwrap();
    let expected = "socket address contains a NUL byte\n".repeat(4);
    for raw in ["0", "1"] {
        let output = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env("FWP_NO_OPT", raw)
            .args(["run", "--interp"])
            .arg(&input)
            .output()
            .unwrap();
        assert!(output.status.success(), "{output:?}");
        assert_eq!(output.stdout, expected.as_bytes());
        assert!(output.stderr.is_empty());
    }
    let cfile = dir.join("main.c");
    let output = Command::new(env!("CARGO_BIN_EXE_fwp"))
        .args(["build", "--emit-c"])
        .arg(&input)
        .arg("-o")
        .arg(&cfile)
        .output()
        .unwrap();
    assert!(output.status.success(), "{output:?}");
    let code = std::fs::read_to_string(cfile).unwrap();
    for opt in ["-O1", "-O2"] {
        let binary = dir.join("socket-address.exe");
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();
        let output = Command::new(binary)
            .env("FWP_GC_STRESS", "1")
            .env("FWP_GC_VERIFY", "1")
            .env("FWP_REUSE_VERIFY", "1")
            .output()
            .unwrap();
        assert!(output.status.success(), "{output:?}");
        assert_eq!(output.stdout, expected.as_bytes());
        assert!(output.stderr.is_empty());
    }
}

#[test]
fn tcp_constructor_failures_release_real_descriptors() {
    let dir = fwp::cgen::TempDir::new("tcp-constructor").unwrap();
    let input = dir.join("main.fwp");
    let cfile = dir.join("main.c");
    std::fs::write(&input, "main = ()\n").unwrap();
    let emitted = Command::new(env!("CARGO_BIN_EXE_fwp"))
        .args(["build", "--emit-c"])
        .arg(&input)
        .arg("-o")
        .arg(&cfile)
        .output()
        .unwrap();
    assert!(emitted.status.success(), "{emitted:?}");
    let mut code = std::fs::read_to_string(cfile)
        .unwrap()
        .replace("#define FWP_UNWIND 0", "#define FWP_UNWIND 1");
    let allocation_hook = "static inline void *fwp_gc_alloc(size_t n, int leaf) {";
    assert!(code.contains(allocation_hook));
    code = code.replace(
        allocation_hook,
        &format!("{allocation_hook} if(leaf) tcp_allocation();"),
    );
    code = code.replace(
        "typedef uint64_t V;",
        "typedef uint64_t V;\nstatic void tcp_allocation(void);",
    );
    let initialized_hook = "static inline void *fwp_alloc_init(size_t n) {";
    assert!(code.contains(initialized_hook));
    code = code.replace(
        initialized_hook,
        &format!("{initialized_hook} tcp_allocation();"),
    );
    let declarations = r#"
static fwp_socket_t tcp_open(int,int,int);
static fwp_socket_t tcp_accept(fwp_socket_t,struct sockaddr *,socklen_t *);
static int tcp_close(fwp_socket_t);
static void *tcp_header_alloc(size_t);
"#;
    let start = code.find("static void fwp_sock_final(").unwrap();
    code.insert_str(start, declarations);
    for name in [
        "fwp_sock_final",
        "fwp_connect_finish",
        "fwp_p_tcp_listen",
        "fwp_accept",
    ] {
        let signature = if name == "fwp_sock_final" || name == "fwp_connect_finish" {
            format!("static void {name}(")
        } else {
            format!("static V {name}(")
        };
        let start = code.find(&signature).unwrap();
        let end = start + code[start..].find("\n}\n").unwrap() + 3;
        let body = code[start..end]
            .replace("fwp_socket_open(", "tcp_open(")
            .replace("fwp_socket_accept(", "tcp_accept(")
            .replace("fwp_socket_close(", "tcp_close(");
        code.replace_range(start..end, &body);
    }
    let allocation = "(fwp_sock *)fwp_alloc_leaf(bytes)";
    assert!(code.contains(allocation));
    code = code.replace(allocation, "(fwp_sock *)tcp_header_alloc(bytes)");
    let code = code[..code.find("int main(").unwrap()].to_string()
        + "\n#define TCP_ERROR NULL\n"
        + include_str!("fixtures/tcp_constructor_cleanup.c");
    for opt in ["-O1", "-O2"] {
        for omitted in [
            None,
            Some("fwp_p_tcp_listen"),
            Some("fwp_accept"),
            Some("fwp_p_tcp_accept_for"),
            Some("fwp_p_tcp_read_for"),
        ] {
            let mut candidate = code.clone();
            if let Some(name) = omitted {
                let start = candidate.find(&format!("static V {name}(")).unwrap();
                let end = start + candidate[start..].find("\n}\n").unwrap() + 3;
                let needle = if matches!(name, "fwp_p_tcp_accept_for" | "fwp_p_tcp_read_for") {
                    "fwp_cleanup_push(&cleanup, fwp_value_release, &owner);"
                } else {
                    "fwp_cleanup_push(&construction, fwp_connect_finish, &owner);"
                };
                let body = candidate[start..end]
                    .replace(needle, "/* deliberately omit constructor cleanup */");
                assert_ne!(body, candidate[start..end]);
                candidate.replace_range(start..end, &body);
            }
            let binary = dir.join("tcp-constructor.exe");
            fwp::cgen::compile_c(&candidate, &binary, opt).unwrap();
            let output = Command::new(&binary).env("FWP_GC", "off").output().unwrap();
            if omitted.is_none() {
                if let Some(path) = std::env::var_os("FWP_TCP_CONSTRUCTOR_ARTIFACTS") {
                    let path = std::path::PathBuf::from(path);
                    std::fs::create_dir_all(&path).unwrap();
                    std::fs::write(path.join(format!("tcp{opt}.c")), &candidate).unwrap();
                    std::fs::copy(&binary, path.join(format!("tcp{opt}.exe"))).unwrap();
                    std::fs::write(path.join(format!("tcp{opt}.stdout")), &output.stdout).unwrap();
                    std::fs::write(path.join(format!("tcp{opt}.stderr")), &output.stderr).unwrap();
                }
            }
            assert_eq!(
                output.status.code(),
                Some(if omitted.is_none() { 0 } else { 248 }),
                "{opt}/{omitted:?}: {output:?}"
            );
        }
    }
}

#[test]
fn tcp_values_preserve_scopes_and_release_storage_without_tracing() {
    let dir = fwp::cgen::TempDir::new("tcp-values").unwrap();
    let input = dir.join("main.fwp");
    std::fs::write(&input, include_str!("fixtures/tcp_ownership.fwp")).unwrap();
    let expected = b"rebound\nFalse\nholder released\nping\nFalse\n(Some (), Some ())\n";
    for raw in ["0", "1"] {
        let output = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["run", "--interp"])
            .env("FWP_NO_OPT", raw)
            .arg(&input)
            .output()
            .unwrap();
        assert!(output.status.success(), "{output:?}");
        assert_eq!(output.stdout, expected);
        assert!(output.stderr.is_empty());
    }
    for mode in ["tracing", "arc"] {
        let cfile = dir.join("tcp.c");
        let output = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--gc", mode, "--emit-c"])
            .arg(&input)
            .arg("-o")
            .arg(&cfile)
            .output()
            .unwrap();
        assert!(output.status.success(), "{output:?}");
        let code = std::fs::read_to_string(cfile).unwrap();
        let start = code
            .find("static void *fwp_main_thread(void *arg) {")
            .unwrap();
        let end = start + code[start..].find("\n}\n").unwrap() + 3;
        let body = code[start..end]
            .replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    fwp_tasks_init();\n    intptr_t tcp_budget=fwp_gc.budget;\n")
            .replace("    fwp_cl_finish();\n", "    fwp_cl_finish();\n    if(fwp_gc.ncollect || fwp_gc.budget<tcp_budget) { fprintf(stderr,\"TCP charged storage left: %lld\\n\",(long long)(tcp_budget-fwp_gc.budget)); exit(248); }\n");
        let mut measured = code.clone();
        measured.replace_range(start..end, &body);
        for opt in ["-O1", "-O2"] {
            let binary = dir.join("tcp.exe");
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            let output = Command::new(&binary)
                .env("FWP_GC_STRESS", if mode == "arc" { "0" } else { "1" })
                .env("FWP_GC_VERIFY", if mode == "arc" { "0" } else { "1" })
                .env("FWP_REUSE_VERIFY", if mode == "arc" { "0" } else { "1" })
                .output()
                .unwrap();
            assert!(output.status.success(), "{mode}/{opt}: {output:?}");
            assert_eq!(output.stdout, expected);
            fwp::cgen::compile_c(&measured, &binary, opt).unwrap();
            let output = Command::new(&binary)
                .env("FWP_GC", "off")
                .env("FWP_GC_STRESS", "0")
                .env("FWP_GC_VERIFY", "0")
                .env("FWP_REUSE_VERIFY", "0")
                .output()
                .unwrap();
            if let Some(path) = std::env::var_os("FWP_TCP_CONSTRUCTOR_ARTIFACTS") {
                let path = std::path::PathBuf::from(path);
                std::fs::create_dir_all(&path).unwrap();
                let label = format!("lifetime-{mode}-{opt}");
                std::fs::write(path.join(format!("{label}.c")), &measured).unwrap();
                std::fs::copy(&binary, path.join(format!("{label}.exe"))).unwrap();
                std::fs::write(path.join(format!("{label}.stdout")), &output.stdout).unwrap();
                std::fs::write(path.join(format!("{label}.stderr")), &output.stderr).unwrap();
            }
            assert!(output.status.success(), "{mode}/{opt}: {output:?}");
            assert_eq!(output.stdout, expected);
            assert!(output.stderr.is_empty());
            if mode == "arc" {
                let output = Command::new("nm").arg(&binary).output().unwrap();
                assert!(output.status.success());
                let symbols = String::from_utf8_lossy(&output.stdout);
                for symbol in ["fwp_gc_scan", "fwp_gc_mark_all", "fwp_gc_sweep"] {
                    assert!(!symbols.contains(symbol), "ARC binary contains {symbol}");
                }
            }
        }
    }
}
