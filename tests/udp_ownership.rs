//! UDP owners preserve aliases, captured sockets, cancellation and original scopes.
#![cfg(any(target_os = "linux", target_os = "macos", target_os = "windows"))]
use std::process::{Command, Output};
fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}
fn emitted(source: &str, arc: bool, dir: &fwp::cgen::TempDir) -> String {
    let input = dir.join("main.fwp");
    let cfile = dir.join("main.c");
    std::fs::write(&input, source).unwrap();
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args([
                "build",
                "--gc",
                if arc { "arc" } else { "tracing" },
                "--emit-c",
            ])
            .arg(input)
            .arg("-o")
            .arg(&cfile),
    );
    std::fs::read_to_string(cfile).unwrap()
}

#[test]
fn udp_results_preserve_values_aliases_and_release_storage() {
    let dir = fwp::cgen::TempDir::new("udp-ownership").unwrap();
    let source = include_str!("fixtures/udp_ownership.fwp");
    let input = dir.join("main.fwp");
    std::fs::write(&input, source).unwrap();
    let raw = checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["run", "--interp"])
            .env("FWP_NO_OPT", "1")
            .arg(&input),
    );
    assert_eq!(
        raw.stdout,
        b"rebound\nFalse\nholder released\n\nping\nNone\nNone\n(Some (), Some ())\nFalse\nFalse\n"
    );
    let optimized = checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["run", "--interp"])
            .env_remove("FWP_NO_OPT")
            .arg(&input),
    );
    assert_eq!(
        (&raw.stdout, &raw.stderr),
        (&optimized.stdout, &optimized.stderr)
    );
    let retained = dir.join("retained.c");
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--emit-c"])
            .env("FWP_FREE", "0")
            .arg(&input)
            .arg("-o")
            .arg(&retained),
    );
    let retained = std::fs::read_to_string(retained).unwrap();
    for opt in ["-O1", "-O2"] {
        let binary = dir.join("retained.exe");
        fwp::cgen::compile_c(&retained, &binary, opt).unwrap();
        let output = checked(Command::new(binary).env("FWP_GC", "off"));
        assert_eq!(output.stdout, raw.stdout);
        assert_eq!(output.stderr, raw.stderr);
    }
    for arc in [false, true] {
        let code = emitted(source, arc, &dir);
        for opt in ["-O1", "-O2"] {
            let binary = dir.join("udp.exe");
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            if arc {
                let symbols = checked(Command::new("nm").arg(&binary));
                let symbols = String::from_utf8_lossy(&symbols.stdout);
                for name in ["fwp_gc_scan", "fwp_gc_mark_all", "fwp_gc_sweep"] {
                    assert!(!symbols.contains(name), "ARC binary contains {name}");
                }
            }
            let native = checked(
                Command::new(&binary)
                    .env("FWP_GC_STRESS", if arc { "0" } else { "1" })
                    .env("FWP_GC_VERIFY", if arc { "0" } else { "1" })
                    .env("FWP_REUSE_VERIFY", if arc { "0" } else { "1" }),
            );
            assert_eq!((&native.stdout, &native.stderr), (&raw.stdout, &raw.stderr));
            let start = code
                .find("static void *fwp_main_thread(void *arg) {")
                .unwrap();
            let end = start + code[start..].find("\n}\n").unwrap() + 3;
            let body = code[start..end]
                .replace(
                    "    fwp_init_consts();\n",
                    "    fwp_init_consts();\n    fwp_tasks_init();\n    intptr_t udp_budget=fwp_gc.budget;\n",
                )
                .replace(
                    "    fwp_cl_finish();\n",
                    "    fwp_cl_finish();\n    if(fwp_gc.budget<udp_budget) { fprintf(stderr,\"UDP charged storage left: %lld\\n\",(long long)(udp_budget-fwp_gc.budget)); exit(248); }\n",
                );
            let body = if arc {
                body.replace(
                    "if(fwp_gc.budget<udp_budget)",
                    "if(fwp_gc.ncollect || fwp_gc.enabled || fwp_gc.budget<udp_budget)",
                )
            } else {
                body
            };
            let mut measured = code.clone();
            measured.replace_range(start..end, &body);
            fwp::cgen::compile_c(&measured, &binary, opt).unwrap();
            let native = Command::new(&binary)
                .env("FWP_GC", "off")
                .env("FWP_GC_STRESS", "0")
                .env("FWP_GC_VERIFY", "0")
                .env("FWP_REUSE_VERIFY", "0")
                .output()
                .unwrap();
            if let Some(path) = std::env::var_os("FWP_UDP_ARTIFACTS") {
                let path = std::path::PathBuf::from(path);
                std::fs::create_dir_all(&path).unwrap();
                let label = format!("lifetime-{}-{opt}", if arc { "arc" } else { "tracing" });
                std::fs::write(path.join(format!("{label}.c")), &measured).unwrap();
                std::fs::copy(&binary, path.join(format!("{label}.exe"))).unwrap();
                std::fs::write(path.join(format!("{label}.stdout")), &native.stdout).unwrap();
                std::fs::write(path.join(format!("{label}.stderr")), &native.stderr).unwrap();
                std::fs::write(
                    path.join(format!("{label}.status")),
                    format!("{:?}\n", native.status.code()),
                )
                .unwrap();
            }
            assert!(native.status.success(), "{arc}/{opt}: {native:?}");
            assert_eq!(native.stdout, raw.stdout);
            if cfg!(target_os = "linux") && !arc && opt == "-O1" {
                let omitted = measured.replace(
                    "    fwp_mem_free(w);",
                    "    /* omitted descriptor wait-list release */",
                );
                assert_ne!(measured, omitted);
                fwp::cgen::compile_c(&omitted, &binary, opt).unwrap();
                let output = Command::new(&binary)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                assert_eq!(output.status.code(), Some(248), "{output:?}");
            }
        }
    }
}

#[test]
fn udp_construction_aliases_and_partial_receives_release_every_owner() {
    let dir = fwp::cgen::TempDir::new("udp-cleanup").unwrap();
    for arc in [false, true] {
        let code = emitted(include_str!("fixtures/udp_ownership.fwp"), arc, &dir);
        let line = code
            .lines()
            .find(|line| line.contains("return fwp_p_udp_recv_from(l0, l1,"))
            .unwrap();
        let args = line
            .trim()
            .strip_prefix("return fwp_p_udp_recv_from(l0, l1, ")
            .unwrap()
            .strip_suffix(");")
            .unwrap();
        let (error, tuple) = args.split_once(", ").unwrap();
        let descriptors = format!("#define UDP_ERROR ({error})\n#define UDP_TUPLE ({tuple})\n");
        let mut code = code.replace("#define FWP_UNWIND 0", "#define FWP_UNWIND 1");
        code = code.replace(
            "typedef uint64_t V;",
            "typedef uint64_t V;\nstatic void udp_allocation(void);",
        );
        let init = "static inline void *fwp_alloc_init(size_t n) {";
        let slow = "static inline void *fwp_gc_alloc(size_t n, int leaf) {";
        assert!(code.contains(init) && code.contains(slow));
        code = code
            .replace(init, &format!("{init} udp_allocation();"))
            .replace(slow, &format!("{slow} if(leaf!=0) udp_allocation();"));
        let start = code.find("static void fwp_sock_final(").unwrap();
        let replaced = code[start..]
            .replace("fwp_socket_open(", "udp_socket_open(")
            .replace("fwp_socket_close(", "udp_socket_close(");
        code.replace_range(start.., &replaced);
        code.insert_str(start, include_str!("fixtures/udp_owner_peer.c"));
        let start = code.find("static V fwp_p_udp_recv_from(").unwrap();
        let end = start + code[start..].find("\n}\n").unwrap() + 3;
        let receive = code[start..end]
            .replace("malloc(", "udp_buffer_alloc(")
            .replace("free(buf)", "udp_buffer_free(buf)")
            .replace(
                "&buffer_cleanup, free,",
                "&buffer_cleanup, udp_buffer_free,",
            );
        code.replace_range(start..end, &receive);
        let code = code[..code.find("int main(").unwrap()].to_owned()
            + &descriptors
            + include_str!("fixtures/udp_owner_cleanup.c");
        let no_constructor = code.replace(
            "fwp_cleanup_push(&cleanup, fwp_connect_finish, &owner);",
            "/* omitted descriptor owner */",
        );
        let no_fields = code.replace(
            "if (d && d->drop) d->drop(f->values[i]);",
            "/* omitted partial receive field */",
        );
        let no_final_close =
            code.replace("    fwp_sock_final(s);", "    s->fd = FWP_INVALID_SOCKET;");
        for broken in [&no_constructor, &no_fields, &no_final_close] {
            assert_ne!(&code, broken);
        }
        for opt in ["-O1", "-O2"] {
            for (source, expected) in [
                (&code, 0),
                (&no_constructor, 248),
                (&no_fields, 248),
                (&no_final_close, 248),
            ] {
                let binary = dir.join("udp-cleanup.exe");
                fwp::cgen::compile_c(source, &binary, opt).unwrap();
                let output = Command::new(&binary)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                assert_eq!(
                    output.status.code(),
                    Some(expected),
                    "{arc}/{opt}: {output:?}"
                );
                if expected == 0 && opt == "-O2" {
                    if let Some(path) = std::env::var_os("FWP_UDP_ARTIFACTS") {
                        let path = std::path::PathBuf::from(path);
                        std::fs::create_dir_all(&path).unwrap();
                        let label = if arc { "udp-arc" } else { "udp-tracing" };
                        std::fs::write(path.join(format!("{label}.c")), source).unwrap();
                        std::fs::copy(&binary, path.join(format!("{label}.exe"))).unwrap();
                        std::fs::write(path.join(format!("{label}.txt")), output.stdout).unwrap();
                    }
                }
            }
        }
    }
}

#[test]
fn udp_library_unload_closes_retained_handles_and_preserves_host_socket() {
    let dir = fwp::cgen::TempDir::new("udp-unload").unwrap();
    let input = dir.join("library.fwp");
    std::fs::write(&input, include_str!("fixtures/udp_library.fwp")).unwrap();
    let reference = checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input),
    );
    assert_eq!(reference.stdout, b"True\n");
    for mode in ["tracing", "arc"] {
        let cfile = dir.join("library.c");
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .args(["build", "--gc", mode, "--cdylib", "--emit-c"])
                .arg(&input)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(&cfile).unwrap() + include_str!("fixtures/udp_unload.c");
        let header = std::fs::read_to_string(cfile.with_extension("h")).unwrap();
        let omitted = code.replace(
            "    fwp_gc_finalizer(s, fwp_sock_final);",
            "    /* omitted library socket finalizer */",
        );
        assert_ne!(code, omitted);
        let library = dir.join(format!("libudp.{}", fwp::cgen::shared_library_extension()));
        let host = dir.join("host.exe");
        for opt in ["-O1", "-O2"] {
            fwp::cgen::compile_c(include_str!("fixtures/udp_unload_host.c"), &host, opt).unwrap();
            for (source, expected) in [(&code, 0), (&omitted, 248)] {
                fwp::cgen::compile_library(
                    source,
                    &header,
                    &library,
                    opt,
                    fwp::cgen::LibKind::Shared,
                )
                .unwrap();
                if mode == "arc" {
                    let symbols = checked(Command::new("nm").arg(&library));
                    let symbols = String::from_utf8_lossy(&symbols.stdout);
                    for name in ["fwp_gc_scan", "fwp_gc_mark_all", "fwp_gc_sweep"] {
                        assert!(!symbols.contains(name), "ARC library contains {name}");
                    }
                }
                for reuse in ["0", "1"] {
                    let output = Command::new(&host)
                        .arg(&library)
                        .env("FWP_REUSE_VERIFY", reuse)
                        .env("FWP_GC", "off")
                        .output()
                        .unwrap();
                    if mode == "arc" && reuse == "1" {
                        assert_eq!(output.status.code(), Some(101), "{output:?}");
                        assert!(String::from_utf8_lossy(&output.stderr).contains(
                            "--gc arc cannot retain released storage for reuse verification"
                        ));
                    } else {
                        assert_eq!(
                            output.status.code(),
                            Some(expected),
                            "{mode}/{opt}/{reuse}: {output:?}"
                        );
                    }
                }
            }
        }
    }
}

#[test]
fn socket_kind_selects_stream_cleanup_without_increasing_udp_header_size() {
    let runtime = include_str!("../runtime/fwp_rt_task.c");
    let start = runtime
        .find("typedef struct { fwp_socket_t fd; int kind;")
        .unwrap();
    let end = start + runtime[start..].find("#endif").unwrap() + "#endif".len();
    let layout = &runtime[start..end];
    let start = runtime.find("static void fwp_sock_final(").unwrap();
    let end = start + runtime[start..].find("\n}\n").unwrap() + 3;
    let finalizer = &runtime[start..end];
    let source = include_str!("fixtures/socket_kind_cleanup.c")
        .replace("/* SOCKET_LAYOUT */", layout)
        .replace("/* SOCKET_FINALIZER */", finalizer);
    let dir = fwp::cgen::TempDir::new("socket-kind").unwrap();
    for opt in ["-O1", "-O2"] {
        let binary = dir.join("socket-kind.exe");
        fwp::cgen::compile_c(&source, &binary, opt).unwrap();
        checked(&mut Command::new(&binary));
        let broken = source.replace(
            "s->kind != 2 && ((fwp_stream *)s)->tls",
            "((fwp_stream *)s)->tls",
        );
        assert_ne!(source, broken);
        fwp::cgen::compile_c(&broken, &binary, opt).unwrap();
        let output = Command::new(binary).output().unwrap();
        assert_eq!(output.status.code(), Some(248), "{output:?}");
    }
}
