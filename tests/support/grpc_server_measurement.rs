//! Measure server storage after requests and connection tasks finish.
use super::*;

fn instrument(generated: &str) -> String {
    // Reuse the existing allocation/retain counter hooks, changing their sample
    // boundary to server readiness. The generated application is unchanged.
    let mut code = instrument_client_allocations(generated);
    for name in [
        "active",
        "requests",
        "requested_bytes",
        "retains",
        "start_charge",
        "peak_charge",
        "sample",
        "charge",
        "measure_begin",
        "measure_end",
    ] {
        code = code.replace(&format!("client_{name}"), &format!("server_{name}"));
    }
    let declaration = "typedef uint64_t V;";
    let counters = r#"
static uint64_t server_calls_started,server_calls_finished;
static uint64_t server_connections_created,server_connections_closed,server_connections_finalized,server_streams_finalized;
static uint64_t server_job_requested,server_job_charged,server_task_requested,server_task_charged,server_args_requested,server_args_charged;
static void server_begin(void);
static void server_task_finished(void (*)(void *,int));
static void server_task_retiring(void);
static size_t server_storage_charge(const void *);
"#;
    code = code.replacen(declaration, &format!("{declaration}\n{counters}"), 1);
    for (before,after) in [
        ("    fwp_zombie = t;", "    fwp_zombie = t;\n    server_task_retiring();"),
        ("    server_measure_begin();\n", ""),
        ("    fwp_tasks_init();\n    g_accept_loop(fd, srv);", "    fwp_tasks_init();\n    server_begin();\n    g_accept_loop(fd, srv);"),
        ("        enum fwp_task_ownership ownership = finished->ownership;", "        void (*server_entry)(void *,int) = finished->cfn;\n        enum fwp_task_ownership ownership = finished->ownership;"),
        ("        if (ownership == FWP_TASK_UNIQUE) fwp_task_dispose(PTR(finished));", "        if (ownership == FWP_TASK_UNIQUE) fwp_task_dispose(PTR(finished));\n        server_task_finished(server_entry);"),
        ("static void g_start_call(g_conn *c, g_stream *s) {", "static void g_start_call(g_conn *c, g_stream *s) {\n    if(server_active)server_calls_started++;"),
        ("    g_job *j = (g_job *)fwp_mem_alloc(sizeof *j);", "    g_job *j = (g_job *)fwp_mem_alloc(sizeof *j);\n    if(server_active){server_job_requested+=sizeof(*j);server_job_charged+=server_storage_charge(j);}"),
        ("    j->sv.task = s->task;", "    j->sv.task = s->task;\n    if(server_active){server_task_requested+=sizeof(*s->task);server_task_charged+=server_storage_charge(s->task);}"),
        ("    fwp_gc_finalizer(c, g_conn_final);", "    fwp_gc_finalizer(c, g_conn_final);\n    if(server_active)server_connections_created++;"),
        ("        fwp_socket_close(c->fd);\n        c->fd = FWP_INVALID_SOCKET;", "        fwp_socket_close(c->fd);\n        c->fd = FWP_INVALID_SOCKET;\n        if(server_active)server_connections_closed++;"),
        ("static void g_conn_final(void *p) {", "static void g_conn_final(void *p) {\n    if(server_active)server_connections_finalized++;"),
        ("static void g_stream_final(void *p) {", "static void g_stream_final(void *p) {\n    if(server_active)server_streams_finalized++;"),
    ] {
        assert_eq!(code.matches(before).count(),1,"{before}");
        code=code.replacen(before,after,1);
    }
    let main = code
        .find("static void *fwp_main_thread(void *arg) {")
        .unwrap();
    code.insert_str(main, include_str!("../fixtures/server-memory/probe.c"));
    code
}

fn measured_server(binary: &Path, calls: usize) -> Server {
    let mut command = Command::new(binary);
    command
        .args(["--listen", "127.0.0.1:0"])
        .env("FWP_SERVER_MEASURE_CALLS", calls.to_string())
        .env("FWP_GC", "off")
        .env("FWP_FREE", "1")
        .env("FWP_GC_STRESS", "0")
        .env("FWP_GC_VERIFY", "0")
        .env("FWP_REUSE_VERIFY", "0")
        .env("FWP_GC_STATS", "0");
    start(command, Duration::from_secs(60))
}

#[test]
#[ignore = "native server memory evidence runs on GitHub runners"]
fn repeated_server_call_memory() {
    measure_server_calls("tracing");
}

#[test]
#[ignore = "native ARC server memory evidence runs on GitHub runners"]
fn repeated_arc_server_call_memory() {
    measure_server_calls("arc");
}

fn measure_server_calls(memory_mode: &str) {
    assert!(have_cc(), "native compiler is required for server evidence");
    let artifacts = PathBuf::from(
        std::env::var_os("FWP_SERVER_MEMORY_ARTIFACTS").expect("server artifact directory"),
    );
    std::fs::create_dir_all(&artifacts).unwrap();
    let d = scratch(&format!("server-memory-{memory_mode}"));
    std::fs::write(
        artifacts.join("memory-mode.txt"),
        format!("{memory_mode}\n"),
    )
    .unwrap();
    std::fs::copy(dir().join("greeter.fwp"), d.join("greeter.fwp")).unwrap();
    std::fs::copy(dir().join("greeter.fwp"), artifacts.join("greeter.fwp")).unwrap();
    std::fs::write(
        artifacts.join("scope.txt"),
        include_str!("../fixtures/server-memory/README.md"),
    )
    .unwrap();
    let mut reference = Command::new(fwp());
    reference
        .args(["serve", "--interp"])
        .arg(dir().join("client.fwp"))
        .arg("greeter")
        .args(["--listen", "127.0.0.1:0"]);
    let interpreted_server = start(reference, Duration::from_secs(60));
    let mut memory=String::from("mode\tcalls\trepetition\tallocations\trequested_bytes\tretains\tpeak_charged_bytes\tfinal_charged_bytes\tcollections\tcalls_started\tcalls_finished\tconnections_created\tconnections_closed\tconnections_finalized\tstreams_finalized\tlive_call_tasks\tlive_io_tasks\tlive_other_tasks\n");
    let mut checkpoints=String::from("mode\tcalls\trepetition\tcompleted_calls\tmanaged_charged_bytes\tlive_call_tasks\tlive_io_tasks\tlive_other_tasks\n");
    let mut storage=String::from("mode\tcalls\trepetition\tjob_requested_bytes\tjob_charged_bytes\ttask_requested_bytes\ttask_charged_bytes\targs_requested_bytes\targs_charged_bytes\tjob_header_bytes\ttask_header_bytes\tconnection_header_bytes\tstream_header_bytes\n");
    for (mode,consume,per_call) in [
        ("unary-strings", "const \"x\" | string.repeat 64 | make greeter.HelloRequest { name = id, times = const 1 } | greeter.say-hello | .message | string.length",71),
        ("response-stream", "const 64 | greeter.count | iter.fold add 0",2080),
        ("request-stream", "const 1 | iter.count-from | iter.take 64 | greeter.total",2080),
        ("channel-output", "const 128 | channel.make | tap (greeter.ticks 64) | tap channel.close | channel.drain | map string.length | sum",439),
    ] {
        let source=d.join(format!("{mode}.fwp"));
        let signature=if mode=="channel-output" {"I64 -> I64 ! {Async}"} else {"I64 -> I64"};
        std::fs::write(&source,format!("import greeter\n\nconsume : {signature}\nconsume = {consume}\nstep = curry (both .0 (.1 | consume) | uncurry add)\n\nmain =\n    () | args | head | option.and-then parse-int\n    | (match\n        Some _ -> id\n        None -> \"expected a numeric call count\" | fail)\n    | flip iter.take (iter.count-from 0)\n    | iter.fold step 0\n    | echo\n")).unwrap();
        std::fs::copy(&source,artifacts.join(format!("{mode}.fwp"))).unwrap();
        let split=d.join(mode);
        build(&["--gc",memory_mode,source.to_str().unwrap(),"--service","greeter","--emit-c","-o",split.to_str().unwrap()],&d);
        let client_code=std::fs::read_to_string(split.join(format!("{mode}.c"))).unwrap();
        let server_code=std::fs::read_to_string(split.join("greeter.c")).unwrap();
        for code in [&client_code, &server_code] {
            assert_eq!(code.contains("#define FWP_ARC_ONLY 1"), memory_mode == "arc");
        }
        let measured_code=instrument(&server_code);
        std::fs::write(artifacts.join(format!("{mode}-client.c")),&client_code).unwrap();
        std::fs::write(artifacts.join(format!("{mode}-server.c")),&server_code).unwrap();
        std::fs::write(artifacts.join(format!("{mode}-server-measured.c")),&measured_code).unwrap();
        let client=artifacts.join(format!("{mode}-client{}",std::env::consts::EXE_SUFFIX));
        let ordinary=artifacts.join(format!("{mode}-server{}",std::env::consts::EXE_SUFFIX));
        let measured=artifacts.join(format!("{mode}-server-measured{}",std::env::consts::EXE_SUFFIX));
        for (code,binary) in [(&client_code,&client),(&server_code,&ordinary),(&measured_code,&measured)] {
            fwp::cgen::compile_c(code,binary,"-O2").unwrap();
            if memory_mode == "arc" {
                let mut nm = Command::new("nm"); nm.arg(binary);
                let symbols = run(nm, 30);
                assert!(symbols.status.success(), "{}", render(&symbols));
                let text = String::from_utf8_lossy(&symbols.stdout);
                for tracing in ["fwp_gc_scan", "fwp_gc_mark_all", "fwp_gc_sweep"] {
                    assert!(!text.contains(tracing), "{} contains {tracing}", binary.display());
                }
                std::fs::write(binary.with_extension("nm"), symbols.stdout).unwrap();
            }
        }
        let mut command=Command::new(&ordinary);command.args(["--listen","127.0.0.1:0"]);
        let ordinary_server=start(command,Duration::from_secs(60));
        for calls in [1,16,256] {
            let expected=format!("{}\n",calls*per_call);
            for server in [&interpreted_server,&ordinary_server] {
                let mut command=Command::new(&client);command.arg(calls.to_string()).env("FWP_SERVICE_GREETER",&server.addr);
                let output=run(command,120);assert!(output.status.success(),"{mode}/{calls}: {}",render(&output));
                assert_eq!(String::from_utf8_lossy(&output.stdout),expected);assert!(output.stderr.is_empty(),"{output:?}");
            }
            for repetition in 0..3 {
                let mut server=measured_server(&measured,calls);
                let mut command=Command::new(&client);command.arg(calls.to_string()).env("FWP_SERVICE_GREETER",&server.addr);
                let output=run(command,120);assert!(output.status.success(),"{mode}/{calls}: {}",render(&output));
                assert_eq!(String::from_utf8_lossy(&output.stdout),expected);assert!(output.stderr.is_empty(),"{output:?}");
                assert!(server.wait_log("server-storage\t"),"no completed server sample: {}",server.log.lock().unwrap());
                assert!(server.child.try_wait().unwrap().is_none(),"server exited before sample collection");
                let log=server.log.lock().unwrap().clone();
                std::fs::write(artifacts.join(format!("{mode}-{calls}-{repetition}.log")),&log).unwrap();
                let mut final_seen=false;let mut storage_seen=false;let mut completed=0;
                for line in log.lines() {
                    if let Some(fields)=line.strip_prefix("server-call\t") {
                        let v:Vec<u64>=fields.split('\t').map(|n|n.parse().unwrap()).collect();
                        completed+=1;assert_eq!(v.len(),5);assert_eq!(v[0],completed);assert_eq!(v[2],0);assert_eq!(v[4],0);
                        checkpoints.push_str(&format!("{mode}\t{calls}\t{repetition}\t{fields}\n"));
                    } else if let Some(fields)=line.strip_prefix("server-final\t") {
                        assert!(!final_seen);final_seen=true;
                        let v:Vec<u64>=fields.split('\t').map(|n|n.parse().unwrap()).collect();
                        assert_eq!(v.len(),15);assert_eq!(v[5],0);assert_eq!(v[6],calls as u64);assert_eq!(v[7],calls as u64);
                        assert_eq!(v[8],1);assert_eq!(v[9],1);assert_eq!(&v[12..],&[0,0,0]);
                        memory.push_str(&format!("{mode}\t{calls}\t{repetition}\t{fields}\n"));
                    } else if let Some(fields)=line.strip_prefix("server-storage\t") {
                        assert!(!storage_seen);storage_seen=true;
                        let v:Vec<u64>=fields.split('\t').map(|n|n.parse().unwrap()).collect();assert_eq!(v.len(),10);
                        assert_eq!(v[0],calls as u64*v[6]);assert_eq!(v[2],calls as u64*v[7]);
                        storage.push_str(&format!("{mode}\t{calls}\t{repetition}\t{fields}\n"));
                    }
                }
                assert!(final_seen&&storage_seen);assert_eq!(completed,calls as u64);
            }
        }
    }
    for (name, contents) in [
        ("memory.tsv", memory),
        ("checkpoints.tsv", checkpoints),
        ("storage.tsv", storage),
    ] {
        std::fs::write(artifacts.join(name), contents).unwrap();
    }
}
