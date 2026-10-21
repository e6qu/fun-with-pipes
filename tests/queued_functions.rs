//! Queue ownership includes a proved function's captured values and call scope.
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let result = command.output().unwrap();
    assert!(result.status.success(), "{command:?}: {result:?}");
    result
}

#[test]
fn queued_functions_preserve_results_and_release_undrained_captures() {
    let dir = fwp::cgen::TempDir::new("queued-functions").unwrap();
    let source = dir.join("main.fwp");
    for (name, program, expected) in [
        (
            "values",
            include_str!("fixtures/queued_functions.fwp"),
            include_str!("fixtures/queued_functions.out"),
        ),
        (
            "cancellation",
            include_str!("fixtures/queued_function_tasks.fwp"),
            include_str!("fixtures/queued_function_tasks.out"),
        ),
        (
            "sockets",
            include_str!("fixtures/queued_sockets.fwp"),
            include_str!("fixtures/queued_sockets.out"),
        ),
        (
            "data-queues",
            include_str!("fixtures/queued_data_channels.fwp"),
            include_str!("fixtures/queued_data_channels.out"),
        ),
        (
            "task-handles",
            include_str!("fixtures/queued_task_handles.fwp"),
            include_str!("fixtures/queued_task_handles.out"),
        ),
    ] {
        std::fs::write(&source, program).unwrap();
        let compiler = env!("CARGO_BIN_EXE_fwp");
        let reference = checked(
            Command::new(compiler)
                .env("FWP_NO_OPT", "1")
                .args(["run", "--interp"])
                .arg(&source),
        );
        assert_eq!(reference.stdout, expected.as_bytes(), "{name}");
        for memory in ["arc", "tracing"] {
            let cfile = dir.join("main.c");
            checked(
                Command::new(compiler)
                    .env_remove("FWP_NO_OPT")
                    .args(["build", "--gc", memory, "--emit-c"])
                    .arg(&source)
                    .arg("-o")
                    .arg(&cfile),
            );
            let mut code = std::fs::read_to_string(cfile).unwrap();
            if name == "task-handles" && memory == "arc" {
                let create = "    task->identity = ++fwp_task_identity;";
                let release = "    if (!t->done || t->stack) abort();";
                let root_release = "        fwp_mem_free(fwp_root);";
                let finish = "\n    fwp_cl_finish();\n";
                // Library/WASI and executable shutdown each have a root release.
                for (needle, count) in [(create, 1), (release, 1), (root_release, 2), (finish, 1)] {
                    assert_eq!(code.matches(needle).count(), count, "{needle}");
                }
                code = code
                    .replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic unsigned captured_task_live, captured_task_created;")
                    .replace(create, &format!("{create}\n    captured_task_created++; if (++captured_task_live > 64) exit(201);"))
                    .replace(release, &format!("{release}\n    if (!captured_task_live) exit(202); captured_task_live--;"))
                    .replace(root_release, &format!("    if (!captured_task_live) exit(202); captured_task_live--;\n{root_release}"))
                    .replace(finish, &format!("{finish}    if (captured_task_live || !captured_task_created) exit(203);\n"));
            }
            if name == "data-queues" {
                let create = "    fwp_chan *c = (fwp_chan *)fwp_mem_alloc(sizeof(fwp_chan));";
                let release = "    if (c->sendq.head || c->recvq.head) abort();";
                let finish = "\n    fwp_cl_finish();\n";
                for needle in [create, release, finish] {
                    assert_eq!(code.matches(needle).count(), 1, "{needle}");
                }
                code = code
                    .replace(
                        "typedef uint64_t V;",
                        "typedef uint64_t V;\nstatic unsigned queue_live, queue_created;",
                    )
                    .replace(
                        create,
                        &format!("{create}\n    queue_created++; if(++queue_live > 64) exit(198);"),
                    )
                    .replace(
                        release,
                        &format!("{release}\n    if(!queue_live) exit(199); queue_live--;"),
                    )
                    .replace(
                        finish,
                        &format!("{finish}    if(queue_live || !queue_created) exit(200);\n"),
                    );
            }
            if name == "sockets" {
                // Count socket objects with value owners, not just managed bytes:
                // a collected header is not evidence its OS handle was closed.
                // Each of 64 rounds opens 6 listeners, 6 connections and 10 UDP
                // sockets. The 64-live ceiling allows original resource frames
                // within a round, but detects retention accumulating across them.
                let create = "    s->refs = 1;";
                let release = "    fwp_sock_final(s);";
                let finish = "\n    fwp_cl_finish();\n";
                for needle in [create, release, finish] {
                    assert_eq!(code.matches(needle).count(), 1, "{needle}");
                }
                code = code
                    .replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic unsigned socket_live, socket_created[3];")
                    .replace(create, &format!("{create}\n    socket_created[kind]++; if(++socket_live > 64) exit(194);"))
                    .replace(release, &format!("    fwp_socket_t observed_fd = s->fd;\n{release}\n    if(s->fd != FWP_INVALID_SOCKET) exit(195);\n    if(observed_fd != FWP_INVALID_SOCKET) {{ struct sockaddr_storage addr; socklen_t len = sizeof addr; if(getsockname(observed_fd, (struct sockaddr *)&addr, &len) == 0) exit(195); }}\n    if(!socket_live) exit(196); socket_live--;"))
                    .replace(finish, &format!("{finish}    if(socket_live || socket_created[0] != 64*6 || socket_created[1] != 64*6 || socket_created[2] != 64*10) {{ fprintf(stderr,\"socket accounting: live=%u listeners=%u connections=%u udp=%u\\n\", socket_live, socket_created[0], socket_created[1], socket_created[2]); exit(197); }}\n"));
            }
            if name == "values" {
                assert!(
                    code.contains("FWP_CHANNEL_RESULT_FIELDS);"),
                    "immediately matched receives must transfer direct fields"
                );
            }
            if memory == "arc" {
                let finish = "\n    fwp_cl_finish();\n";
                assert_eq!(code.matches(finish).count(), 1);
                code = code.replace(finish, &format!("{finish}    if(fwp_gc.ncollect || fwp_gc.enabled || fwp_gc.budget_given != fwp_gc.budget) exit(193);\n"));
            }
            let drop = "            c->owner.queue_drop(element);";
            assert_eq!(code.matches(drop).count(), 1);
            let missing_drop = code.replace(drop, "            (void)element;");
            for opt in ["-O0", "-O2"] {
                let binary = dir.join("main.exe");
                fwp::cgen::compile_c(&code, &binary, opt).unwrap();
                let stress = if memory == "arc" { "0" } else { "1" };
                let run = || {
                    let mut command = Command::new(&binary);
                    command
                        .env_remove("FWP_GC")
                        .env("FWP_GC_STRESS", stress)
                        .env("FWP_GC_VERIFY", stress)
                        .env("FWP_REUSE_VERIFY", stress);
                    command
                };
                let actual = run().output().unwrap();
                if let Some(path) = std::env::var_os("FWP_QUEUED_FUNCTION_ARTIFACTS") {
                    let path = std::path::PathBuf::from(path);
                    std::fs::create_dir_all(&path).unwrap();
                    let label = format!("{name}-{memory}{opt}");
                    std::fs::write(path.join(format!("{label}.c")), &code).unwrap();
                    std::fs::copy(&binary, path.join(format!("{label}.exe"))).unwrap();
                    std::fs::write(path.join(format!("{label}.stdout")), &actual.stdout).unwrap();
                    std::fs::write(path.join(format!("{label}.stderr")), &actual.stderr).unwrap();
                    std::fs::write(
                        path.join(format!("{label}.status")),
                        format!("{:?}\n", actual.status.code()),
                    )
                    .unwrap();
                    let (tool, flag) = if cfg!(target_os = "macos") {
                        ("otool", "-tvV")
                    } else if cfg!(target_os = "windows") {
                        ("llvm-objdump", "-d")
                    } else {
                        ("objdump", "-d")
                    };
                    let assembly = checked(Command::new(tool).arg(flag).arg(&binary));
                    std::fs::write(path.join(format!("{label}.asm")), assembly.stdout).unwrap();
                }
                assert!(actual.status.success(), "{name}/{memory}/{opt}: {actual:?}");
                assert_eq!(
                    (&actual.stdout, &actual.stderr),
                    (&reference.stdout, &reference.stderr),
                    "{memory}/{opt}"
                );
                if memory == "arc" {
                    let symbols = checked(Command::new("nm").arg(&binary));
                    let symbols = String::from_utf8_lossy(&symbols.stdout);
                    for symbol in ["fwp_gc_scan", "fwp_gc_mark_all", "fwp_gc_sweep"] {
                        assert!(
                            !symbols.contains(symbol),
                            "{name}/{opt}: ARC binary retains {symbol}"
                        );
                    }
                    fwp::cgen::compile_c(&missing_drop, &binary, opt).unwrap();
                    let omitted = run().output().unwrap();
                    let expected = match name {
                        "sockets" => 194,
                        "data-queues" => 198,
                        "task-handles" => 201,
                        _ => 193,
                    };
                    assert_eq!(
                        omitted.status.code(),
                        Some(expected),
                        "{name}/{opt}: {omitted:?}"
                    );
                    if name == "task-handles" {
                        if let Some(path) = std::env::var_os("FWP_QUEUED_FUNCTION_ARTIFACTS") {
                            let path = std::path::PathBuf::from(path);
                            let label = format!("task-handles-arc{opt}-missing-queue-owner");
                            std::fs::write(path.join(format!("{label}.c")), &missing_drop).unwrap();
                            std::fs::copy(&binary, path.join(format!("{label}.exe"))).unwrap();
                            std::fs::write(path.join(format!("{label}.stdout")), &omitted.stdout)
                                .unwrap();
                            std::fs::write(path.join(format!("{label}.stderr")), &omitted.stderr)
                                .unwrap();
                            std::fs::write(
                                path.join(format!("{label}.status")),
                                format!("{:?}\n", omitted.status.code()),
                            )
                            .unwrap();
                        }
                    }
                    if name == "sockets" {
                        let omitted_close = code.replace(
                            "    fwp_sock_final(s);",
                            "    /* omitted final socket close */",
                        );
                        assert_ne!(omitted_close, code);
                        fwp::cgen::compile_c(&omitted_close, &binary, opt).unwrap();
                        let omitted = run().output().unwrap();
                        assert_eq!(omitted.status.code(), Some(195), "{opt}: {omitted:?}");
                    }
                } else {
                    let symbols = checked(Command::new("nm").arg(&binary));
                    assert!(
                        String::from_utf8_lossy(&symbols.stdout).contains("fwp_gc_mark_all"),
                        "tracing control must contain its collector: {name}/{opt}"
                    );
                }
            }
        }
    }
}

#[test]
fn queued_functions_reject_channel_captures_including_returned_and_nested_values() {
    let dir = fwp::cgen::TempDir::new("queued-cycles").unwrap();
    let prefix = r#"
callbacks : I64 -> Channel[() -> () ! {Async}] ! {Async}
callbacks = channel.make
keep : Channel[() -> () ! {Async}] -> () -> () ! {Async}
keep = then2 const channel.close
"#;
    for (name, body) in [
        ("self", "send-self = fork channel.send id keep\nmain = callbacks 1 | tap send-self | channel.recv | option.map (apply ()) | ignore\n"),
        ("task-computation", "Event = { read: () -> () ! {Async} }\nevents : I64 -> Channel[Event] ! {Async}\nevents = channel.make\nwait : Task[()] -> () -> () ! {Async}\nwait = curry (.0 | task.await | ignore)\nkeep-task = keep | task.spawn\nmain = (callbacks 1, events 1) | tap (fork channel.send .1 (.0 | keep-task | wait | make Event { read = id })) | .1 | channel.recv | option.map (.read | apply ()) | ignore\n"),
        ("task-result", "Event = { read: () -> () ! {Async} }\nevents : I64 -> Channel[Event] ! {Async}\nevents = channel.make\nwait : Task[() -> () ! {Async}] -> () -> () ! {Async}\nwait = curry (.0 | task.await | option.map (apply ()) | ignore)\nkeep-task = keep | const | task.spawn\nmain = (callbacks 1, events 1) | tap (fork channel.send .1 (.0 | keep-task | wait | make Event { read = id })) | .1 | channel.recv | option.map (.read | apply ()) | ignore\n"),
        ("returned", "returned = keep | const | apply ()\nsend-self = fork channel.send id returned\nmain = callbacks 1 | tap send-self | channel.recv | option.map (apply ()) | ignore\n"),
        ("nested", "lists : I64 -> Channel[List[() -> () ! {Async}]] ! {Async}\nlists = channel.make\nmain = lists 1 | tap (flip channel.send [keep (callbacks 1)]) | channel.recv | ignore\n"),
        ("two-queues", "main = (callbacks 1, callbacks 1) | tap (fork channel.send .0 (.1 | keep)) | tap (fork channel.send .1 (.0 | keep)) | both (.0 | channel.recv) (.1 | channel.recv) | ignore\n"),
        ("caught", "caught : Channel[() -> () ! {Async}] -> Result[(), () -> () ! {Async}]\ncaught = attempt (keep | fail)\nfrom-error = caught | match\n    Err _ -> id\n    Ok _ -> const task.yield\nmain = callbacks 1 | tap (fork channel.send id from-error) | channel.recv | option.map (apply ()) | ignore\n"),
    ] {
        let source = dir.join(format!("{name}.fwp"));
        std::fs::write(&source, format!("{prefix}\n{body}")).unwrap();
        checked(Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env("FWP_NO_OPT", "1").args(["run", "--interp"]).arg(&source));
        let build = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env_remove("FWP_NO_OPT")
            .args(["build", "--gc", "arc", "--emit-c"])
            .arg(&source).arg("-o").arg(dir.join("rejected.c"))
            .output().unwrap();
        assert!(!build.status.success(), "{name}: accepted an unproved captured channel");
        let error = String::from_utf8_lossy(&build.stderr);
        assert!(error.contains("queued function") && error.contains("captured") && error.contains("Channel"), "{name}: {error}");
    }
}

#[test]
fn task_results_reject_a_cached_self_owner_without_a_channel() {
    let dir = fwp::cgen::TempDir::new("task-result-cycle").unwrap();
    let source = dir.join("cycle.fwp");
    std::fs::write(
        &source,
        r#"
TaskResult = { read: () -> () ! {Async} }
wait : Task[TaskResult] -> () -> () ! {Async}
wait = curry (.0 | task.await | ignore)
rec work : () -> TaskResult ! {Async}
work = match
    () -> TaskResult { read = wait main }
rec main = task.spawn work
"#,
    )
    .unwrap();
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .arg("check")
            .arg(&source),
    );
    let reference = checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    let cfile = dir.join("tracing.c");
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--gc", "tracing", "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile),
    );
    let code = std::fs::read_to_string(cfile).unwrap();
    for opt in ["-O0", "-O2"] {
        let binary = dir.join("tracing.exe");
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();
        let actual = checked(
            Command::new(binary)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", "1"),
        );
        assert_eq!(
            (&actual.stdout, &actual.stderr),
            (&reference.stdout, &reference.stderr)
        );
    }

    let result = Command::new(env!("CARGO_BIN_EXE_fwp"))
        .args(["build", "--gc", "arc", "--emit-c"])
        .arg(&source)
        .arg("-o")
        .arg(dir.join("cycle.c"))
        .output()
        .unwrap();
    assert!(
        !result.status.success(),
        "accepted a task owning itself through its result"
    );
    assert!(
        String::from_utf8_lossy(&result.stderr).contains("acyclic task result"),
        "{result:?}"
    );
}

#[test]
fn recursive_record_callable_types_have_a_finite_proof() {
    let dir = fwp::cgen::TempDir::new("queued-recursive-types").unwrap();
    let source = dir.join("main.fwp");
    std::fs::write(&source, r#"
A = { tail: List[A] }
B = { tail: List[B] }
from-a : A -> I64
from-a = const 1
from-b : B -> I64
from-b = const 2
callbacks : I64 -> Channel[I64 -> I64] ! {Async}
callbacks = channel.make
main = [callbacks 1 | channel.close, apply (A { tail = [] }) ((from-a, from-b) | .0) | echo] | ignore
"#).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    assert_eq!(reference.stdout, b"1\n");
    let cfile = dir.join("main.c");
    checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["build", "--gc", "arc", "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile),
    );
    let code = std::fs::read_to_string(cfile).unwrap();
    let binary = dir.join("main.exe");
    fwp::cgen::compile_c(&code, &binary, "-O2").unwrap();
    let actual = checked(
        Command::new(binary)
            .env_remove("FWP_GC")
            .env("FWP_GC_STRESS", "0")
            .env("FWP_GC_VERIFY", "0")
            .env("FWP_REUSE_VERIFY", "0"),
    );
    assert_eq!(
        (&actual.stdout, &actual.stderr),
        (&reference.stdout, &reference.stderr)
    );
}

#[test]
fn a_trapping_branch_does_not_create_an_unknown_queued_function() {
    let dir = fwp::cgen::TempDir::new("queued-never-function").unwrap();
    let source = dir.join("main.fwp");
    let program = r#"
callbacks : I64 -> Channel[I64 -> I64] ! {Async}
callbacks = channel.make
choose : Bool -> I64 -> I64
choose = if id (const (add 1)) (const "unreachable" | prim.trap)
main = callbacks 1 | tap (flip channel.send (choose True)) | channel.recv | option.map (apply 2) | echo
"#;
    std::fs::write(&source, program).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    assert_eq!(reference.stdout, b"Some 3\n");
    for memory in ["arc", "tracing"] {
        let cfile = dir.join("main.c");
        checked(
            Command::new(compiler)
                .env("FWP_NO_OPT", "1")
                .args(["build", "--gc", memory, "--emit-c"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(cfile).unwrap();
        for opt in ["-O0", "-O2"] {
            let binary = dir.join("main.exe");
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            let stress = if memory == "arc" { "0" } else { "1" };
            let actual = checked(
                Command::new(binary)
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", stress)
                    .env("FWP_GC_VERIFY", stress)
                    .env("FWP_REUSE_VERIFY", stress),
            );
            assert_eq!(
                (&actual.stdout, &actual.stderr),
                (&reference.stdout, &reference.stderr)
            );
        }
    }
}

#[test]
fn empty_callable_collections_do_not_create_unknown_calls() {
    let dir = fwp::cgen::TempDir::new("queued-empty-callable").unwrap();
    let source = dir.join("main.fwp");
    std::fs::write(
        &source,
        r#"
callbacks : I64 -> Channel[I64 -> I64] ! {Async}
callbacks = channel.make
calls : List[(I64 -> I64, I64)] -> List[I64]
calls = map (uncurry id)
main = [callbacks 1 | channel.close, [] | calls | echo] | ignore
"#,
    )
    .unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    assert_eq!(reference.stdout, b"[]\n");
    let cfile = dir.join("main.c");
    checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["build", "--gc", "arc", "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile),
    );
    let code = std::fs::read_to_string(cfile).unwrap();
    let binary = dir.join("main.exe");
    fwp::cgen::compile_c(&code, &binary, "-O2").unwrap();
    let actual = checked(
        Command::new(binary)
            .env_remove("FWP_GC")
            .env("FWP_GC_STRESS", "0")
            .env("FWP_GC_VERIFY", "0")
            .env("FWP_REUSE_VERIFY", "0"),
    );
    assert_eq!(
        (&actual.stdout, &actual.stderr),
        (&reference.stdout, &reference.stderr)
    );
}

#[test]
fn queued_remote_iterators_reject_hidden_stream_owners() {
    let dir = fwp::cgen::TempDir::new("queued-remote-iterator").unwrap();
    std::fs::write(
        dir.join("greeter.fwp"),
        "export count : I64 -> Iterator[I64]\ncount = flip iter.take (iter.count-from 1)\n",
    )
    .unwrap();
    let source = dir.join("main.fwp");
    std::fs::write(
        &source,
        "import greeter\nmain = channel.make 1 | tap (flip channel.send (3 | greeter.count)) | channel.recv | ignore\n",
    )
    .unwrap();
    for (remote, memory, accepted) in [
        (false, "arc", true),
        (true, "tracing", true),
        (true, "arc", false),
    ] {
        let mut build = Command::new(env!("CARGO_BIN_EXE_fwp"));
        build.args(["build", "--gc", memory, "--emit-c"]);
        if remote {
            build.args(["--service", "greeter"]);
        }
        let result = build
            .arg(&source)
            .arg("-o")
            .arg(dir.join(format!("remote-{remote}-{memory}")))
            .output()
            .unwrap();
        assert_eq!(
            result.status.success(),
            accepted,
            "remote={remote}/{memory}: {result:?}"
        );
        if !accepted {
            let error = String::from_utf8_lossy(&result.stderr);
            assert!(
                error.contains("queued function") && error.contains("GrpcCell"),
                "{error}"
            );
        }
    }
}

#[test]
fn queued_autodiff_functions_require_the_receivers_scope() {
    let dir = fwp::cgen::TempDir::new("queued-ad-scope").unwrap();
    let source = dir.join("main.fwp");
    for (callback, accepted) in [("ad.scope (apply 1)", true), ("apply 1", false)] {
        std::fs::write(&source, format!("callbacks : I64 -> Channel[I64 -> I64] ! {{Async}}\ncallbacks = channel.make\nmain = callbacks 1 | tap (flip channel.send ad.tape) | channel.recv | option.map ({callback}) | ignore\n")).unwrap();
        let cfile = dir.join("main.c");
        let built = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--gc", "arc", "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile)
            .output()
            .unwrap();
        assert_eq!(built.status.success(), accepted, "{callback}: {built:?}");
        if accepted {
            let reference = checked(
                Command::new(env!("CARGO_BIN_EXE_fwp"))
                    .env("FWP_NO_OPT", "1")
                    .args(["run", "--interp"])
                    .arg(&source),
            );
            let code = std::fs::read_to_string(cfile).unwrap();
            let binary = dir.join("main.exe");
            fwp::cgen::compile_c(&code, &binary, "-O2").unwrap();
            let actual = checked(
                Command::new(binary)
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0"),
            );
            assert_eq!(
                (&actual.stdout, &actual.stderr),
                (&reference.stdout, &reference.stderr)
            );
        } else {
            assert!(
                String::from_utf8_lossy(&built.stderr).contains("outside an autodiff scope"),
                "{built:?}"
            );
        }
    }
}

#[test]
fn queued_function_storage_is_bounded_across_transfers_close_and_failed_receive() {
    let dir = fwp::cgen::TempDir::new("queued-function-storage").unwrap();
    let source = dir.join("main.fwp");
    std::fs::write(&source, r#"
give : String -> () -> String
give = const
texts : I64 -> Channel[() -> String] ! {Async}
texts = channel.make
main = texts 1 | tap (flip channel.send (give "capture")) | channel.recv | option.map (apply ()) | echo
"#).unwrap();
    let cfile = dir.join("main.c");
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env("FWP_NO_OPT", "1")
            .args(["build", "--gc", "arc", "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
    let start = emitted.find("/* give :").unwrap();
    let give = emitted[start..]
        .split("static V f")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let mut runtime = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let receive = "static fwp_channel_result fwp_chan_recv_owned(";
    assert_eq!(runtime.matches(receive).count(), 1);
    runtime = runtime.replace(receive, &format!("static int fail_option;\nstatic V queue_option(V x) {{ if(fail_option) {{ fail_option=0; fwp_trap(\"queue allocation probe\"); }} return fwp_some(x); }}\n{receive}"));
    let option = "fwp_rc_fresh(fwp_some(x))";
    assert_eq!(runtime.matches(option).count(), 1);
    runtime = runtime.replace(option, "fwp_rc_fresh(queue_option(x))");
    let probe = r#"
static jmp_buf recovered;
static int recover(void){return 1;}
static void text_drop(V v){if(fwp_rc_release_last(v))fwp_rc_free_obj(v);}
int main(void){
 fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();fwp_tasks_init();
 intptr_t baseline=fwp_gc.budget;
 for(int iteration=0;iteration<64;iteration++)for(int mode=0;mode<4;mode++){
  V value=fwp_rc_fresh(fwp_str_new("capture",7));
  V fn=fwp_rc_fresh(fwp_pap(GIVE,1,&value));
  V ch=fwp_p_channel_make_owned(1,fwp_closure_drop);
  if(mode==2)fwp_p_channel_close(ch);
  if(fwp_p_channel_send_owned(ch,fn,fwp_closure_drop)!=(mode==2?FWP_FALSE:FWP_TRUE))return 191;
  if(mode!=2&&(*fwp_rc_slot(fn)!=1||*fwp_rc_slot(value)!=1))return 192;
  if(mode==0||mode==3){
   if(mode==3){
    fail_option=1;fwp_trap_recover=recover;fwp_trap_jb=&recovered;fwp_trap_cleanup=0;
    if(setjmp(recovered)==0){fwp_p_channel_recv_owned(ch,fwp_rc_dup);return 193;}
    fwp_trap_recover=0;fwp_trap_jb=0;
    if(fwp_cleanups||((fwp_chan *)(uintptr_t)ch)->len!=1||*fwp_rc_slot(fn)!=1||*fwp_rc_slot(value)!=1)return 194;
   }
   V received=fwp_p_channel_recv_owned(ch,fwp_rc_dup),unit=FWP_UNIT;
   if(received==FWP_NONE||OBJ(received)->f[0]!=fn)return 195;
   V text=fwp_apply_borrowed(fn,1,&unit);
   if(text!=value||*fwp_rc_slot(value)!=2)return 196;
   text_drop(text);fwp_closure_drop(fn);fwp_rc_free_obj(received);
  }
  fwp_channel_drop(ch);
  if(fwp_gc.ncollect||fwp_gc.enabled||fwp_gc.budget!=baseline){
   fprintf(stderr,"queued closure storage iteration=%d mode=%d bytes=%lld\n",iteration,mode,(long long)(baseline-fwp_gc.budget));return 197;
  }
 }
 return 0;
}
"#.replace("GIVE", give);
    let code = format!("{runtime}\n{probe}");
    let drop = "c->owner.queue_drop(element);";
    assert_eq!(code.matches(drop).count(), 1);
    let omitted = code.replace(drop, "(void)element;");
    for opt in ["-O0", "-O2"] {
        let binary = dir.join("probe.exe");
        for (candidate, status) in [(&code, 0), (&omitted, 197)] {
            fwp::cgen::compile_c(candidate, &binary, opt).unwrap();
            let result = Command::new(&binary)
                .env_remove("FWP_GC")
                .env("FWP_GC_STRESS", "0")
                .env("FWP_GC_VERIFY", "0")
                .env("FWP_REUSE_VERIFY", "0")
                .output()
                .unwrap();
            assert_eq!(result.status.code(), Some(status), "{opt}: {result:?}");
            if let Some(path) = std::env::var_os("FWP_QUEUED_FUNCTION_ARTIFACTS") {
                let path = std::path::PathBuf::from(path);
                std::fs::create_dir_all(&path).unwrap();
                let label = format!("bounded-{status}{opt}");
                std::fs::write(path.join(format!("{label}.c")), candidate).unwrap();
                std::fs::copy(&binary, path.join(format!("{label}.exe"))).unwrap();
                std::fs::write(path.join(format!("{label}.stderr")), &result.stderr).unwrap();
            }
        }
    }
}
