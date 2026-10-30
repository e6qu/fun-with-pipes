//! Exercise the WASI allocator on the host and separately on an actual WASI runner.
#![cfg(any(target_os = "linux", target_os = "macos"))]
use std::process::{Command, Output};
fn checked(command: &mut Command) -> Output {
    let out = command.output().unwrap();
    assert!(
        out.status.success(),
        "{command:?}: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    out
}
// Count libc releases of the File header without dereferencing dead storage.
const FILE_FREE_OBSERVER: &str = r#"
#include <stdlib.h>
static void *probe_file;
static unsigned probe_file_frees;
static void observe_file_free(void *p) {
    int watched = p == probe_file;
    free(p);
    if (watched) probe_file_frees++;
}
#undef free
#define free observe_file_free
"#;
fn probe(retain_storage: bool) -> (fwp::cgen::TempDir, String, String) {
    let dir = fwp::cgen::TempDir::new("fwp-wasm-resource-counts").unwrap();
    let src = dir.join("probe.fwp");
    std::fs::write(
        &src,
        r#"
other : File -> (File, File) ! {FileIO, Error[IoError]}
other = file.read-all | first (ignore | const "unused" | file.open)
main = "unused" | flip file.with other | ignore
"#,
    )
    .unwrap();
    let emitted = dir.join("probe.c");
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build"])
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&emitted),
    );
    let generated = std::fs::read_to_string(emitted).unwrap();
    let pair = fwp::ir::MT::Record(vec![
        ("0".into(), fwp::ir::MT::con("std::File")),
        ("1".into(), fwp::ir::MT::con("std::File")),
    ]);
    let marker = format!("/* {pair} */\nstatic void ");
    let start = generated
        .find(&marker)
        .expect("generated typed File pair destructor")
        + marker.len();
    let drop_pair = generated[start..].split('(').next().unwrap();
    let generated = format!("{FILE_FREE_OBSERVER}\n{generated}");
    let generated = if retain_storage {
        format!("#define FWP_RESOURCE_NO_FREE 1\n{generated}")
    } else {
        generated
    };
    let generated = generated.replace(
        "int main(int argc, char **argv)",
        "int program_main(int argc, char **argv)",
    );
    let fixture = r#"
#include <fcntl.h>
#include <sys/stat.h>
static int recover(void){return 1;}
int main(int argc,char **argv) {
 if(argc!=2)return 30;struct stat descriptor_status;
 for(int cycle=0;cycle<128;cycle++) {
  V path=fwp_rc_fresh(fwp_cstr(argv[1]));
  V h=fwp_p_file_open(path,0,0);
  fwp_rc_free_obj(path);
  fwp_file *file=(fwp_file *)(uintptr_t)h;int fd=fileno(file->f);
  probe_file = file; unsigned before_free = probe_file_frees;
  fwp_file_dup(h);
  V pair=fwp_rc_fresh(fwp_tuple2(h,h));
  for(int i=0;i<300;i++)fwp_rc_dup(pair);
  for(int i=0;i<300;i++)DROP_PAIR(pair);
  if(file->refs!=2||fstat(fd,&descriptor_status)==-1)return 3;
  DROP_PAIR(pair);
  if(fstat(fd,&descriptor_status)!=-1||errno!=EBADF)return 4;
#ifndef FWP_RESOURCE_NO_FREE
  if(probe_file_frees != before_free + 1)return 29;
#else
  if(probe_file_frees != before_free || file->refs)return 29;
#endif
  if(fwp_wasm_counts_live||fwp_rc_slot(pair))return 5;
 }
 /* Pointer-shaped scalars and constants never cause header reads or new counts. */
 V constant=(V)(uintptr_t)"constant";
 V values[]={0,1,4096,UINT64_MAX,constant};
 for(size_t i=0;i<sizeof values/sizeof *values;i++) {
  fwp_rc_dup(values[i]);fwp_rc_drop(values[i]);fwp_rc_free_obj(values[i]);
  if(fwp_rc_slot(values[i])||fwp_rc_last(values[i]))return 6;
 }
 V v=fwp_rc_fresh(fwp_tuple2(0,0));
 fwp_wasm_rc *entry=*fwp_wasm_count_link(v);
 fwp_wasm_set_count(entry,UINT64_MAX);
 jmp_buf recovery;fwp_trap_jb=&recovery;fwp_trap_recover=recover;
 int failed=0;
 if(setjmp(recovery))failed=1;else fwp_rc_dup(v);
 fwp_trap_jb=0;fwp_trap_recover=0;
 if(!failed||fwp_wasm_count(entry)!=UINT64_MAX)return 7;
 fwp_wasm_set_count(entry,1);fwp_rc_free_obj(v);
 if(fwp_wasm_counts_live)return 8;
 return 0;
}
"#
    .replace("DROP_PAIR", drop_pair);
    (dir, generated, fixture)
}
#[test]
fn host_wasi_aggregate_counts_release_file_children() {
    let (dir, generated, fixture) = probe(false);
    let fixture = runtime_owners(fixture);
    let old = generated.replace(
        "static void fwp_file_drop(V h) {",
        "static void fwp_file_drop(V h) { (void)h; return;",
    );
    assert_ne!(old, generated);
    let data = dir.join("data");
    std::fs::write(&data, "contents").unwrap();
    let exe = dir.join("probe");
    for opt in ["-O1", "-O2"] {
        let leaked_file = generated.replace("    fwp_rc_resource_free_obj(h);", "    (void)h;");
        assert_ne!(leaked_file, generated);
        for (code, expected) in [(&old, 4), (&leaked_file, 29), (&generated, 0)] {
            fwp::cgen::compile_c(&format!("#define __wasm__ 1\n{code}\n{fixture}"), &exe, opt)
                .unwrap();
            let out = Command::new(&exe).arg(&data).output().unwrap();
            assert_eq!(
                out.status.code(),
                Some(expected),
                "{opt}: {}",
                String::from_utf8_lossy(&out.stderr)
            );
        }
    }
}

#[test]
fn wasi_aggregate_counts_release_file_children() {
    let check = fwp::cgen::TempDir::new("fwp-wasi-count-toolchain").unwrap();
    let src = check.join("probe.c");
    std::fs::write(&src, "int main(void){return 0;}").unwrap();
    let toolchain = Command::new(std::env::var("FWP_WASM_CC").unwrap_or_else(|_| "clang".into()))
        .args(["--target=wasm32-wasi", "-o"])
        .arg(check.join("probe.wasm"))
        .arg(src)
        .output()
        .is_ok_and(|o| o.status.success())
        && Command::new("node")
            .arg("--version")
            .output()
            .is_ok_and(|o| o.status.success());
    if !toolchain {
        assert!(
            std::env::var_os("FWP_REQUIRE_WASM_RESOURCE_COUNTS").is_none(),
            "required WASI toolchain or node unavailable"
        );
        eprintln!("skipping actual WASI evidence: toolchain unavailable");
        return;
    }
    for retain_storage in [false, true] {
        let (dir, generated, fixture) = probe(retain_storage);
        let fixture = runtime_owners(fixture);
        let old = generated.replace(
            "static void fwp_file_drop(V h) {",
            "static void fwp_file_drop(V h) { (void)h; return;",
        );
        std::fs::write(dir.join("data"), "contents").unwrap();
        let wasm = dir.join("probe.wasm");
        let runner =
            std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/wasm/wasi-run.mjs");
        let omitted = generated.replace("        fwp_rc_free_obj(v);", "        fwp_rc_drop(v);");
        let omitted_runtime =
            generated.replace("fwp_rc_resource_free_arr(value);", "fwp_rc_drop(value);");
        let leaked_file = generated.replace("    fwp_rc_resource_free_obj(h);", "    (void)h;");
        assert_ne!(leaked_file, generated);
        let cases = if retain_storage {
            vec![(&omitted, 5), (&omitted_runtime, 9), (&generated, 0)]
        } else {
            vec![(&old, 4), (&leaked_file, 29), (&generated, 0)]
        };
        for opt in ["-O1", "-O2"] {
            for &(code, expected) in &cases {
                fwp::cgen::compile_for(
                    &format!("{code}\n{fixture}"),
                    &wasm,
                    opt,
                    fwp::cgen::Target::Wasi,
                )
                .unwrap();
                let out = Command::new("node")
                    .arg("--no-warnings")
                    .arg(&runner)
                    .arg(&wasm)
                    .arg("data")
                    .current_dir(dir.path())
                    .output()
                    .unwrap();
                assert_eq!(
                    out.status.code(),
                    Some(expected),
                    "{opt}, WASI, retained storage {retain_storage}: {}",
                    String::from_utf8_lossy(&out.stderr)
                );
            }
        }
    }
}

fn runtime_owners(fixture: String) -> String {
    let owners = r#"
 V path=fwp_rc_fresh(fwp_cstr(argv[1]));
 V h=fwp_p_file_open(path,0,0);
 fwp_rc_free_obj(path);
 fwp_file *file=(fwp_file *)(uintptr_t)h;int fd=fileno(file->f);
 fwp_task *task=(fwp_task *)fwp_mem_alloc(sizeof *task);
 task->done=1;task->ownership=FWP_TASK_SHARED;task->has_result=1;task->result=h;task->result_drop=fwp_file_drop;
 V cached=fwp_rc_fresh(PTR(task));fwp_rc_dup(cached);fwp_task_drop(cached);
 if(file->refs!=1||fstat(fd,&descriptor_status)==-1)return 9;
 fwp_task_drop(cached);
 if(fstat(fd,&descriptor_status)!=-1||fwp_wasm_counts_live)return 9;
 path=fwp_rc_fresh(fwp_cstr(argv[1]));
 h=fwp_p_file_open(path,0,0);fwp_rc_free_obj(path);file=(fwp_file *)(uintptr_t)h;fd=fileno(file->f);
 V channel=fwp_p_channel_make_owned(1,fwp_file_drop);
 fwp_chan *c=(fwp_chan *)(uintptr_t)channel;
 fwp_chan_grow(c);c->buf[0]=h;c->len=1;
 fwp_rc_dup(channel);fwp_channel_drop(channel);
 if(file->refs!=1||fstat(fd,&descriptor_status)==-1)return 10;
 fwp_channel_drop(channel);
 if(fstat(fd,&descriptor_status)!=-1||fwp_wasm_counts_live)return 10;
"#;
    fixture.replace(
        " /* Pointer-shaped",
        &format!("{owners}\n /* Pointer-shaped"),
    )
}

#[test]
fn retained_storage_disposes_resource_counts_without_freeing_storage() {
    let (dir, generated, fixture) = probe(true);
    let fixture = runtime_owners(fixture);
    assert!(generated.contains("#define FWP_RESOURCE_NO_FREE 1"));
    let data = dir.join("data");
    std::fs::write(&data, "contents").unwrap();
    let exe = dir.join("probe");
    let omitted = generated.replace("        fwp_rc_free_obj(v);", "        fwp_rc_drop(v);");
    assert_ne!(omitted, generated);
    let omitted_runtime =
        generated.replace("fwp_rc_resource_free_arr(value);", "fwp_rc_drop(value);");
    assert_ne!(omitted_runtime, generated);
    for opt in ["-O1", "-O2"] {
        for (code, expected) in [(&omitted, 5), (&omitted_runtime, 9), (&generated, 0)] {
            fwp::cgen::compile_c(&format!("#define __wasm__ 1\n{code}\n{fixture}"), &exe, opt)
                .unwrap();
            let out = Command::new(&exe).arg(&data).output().unwrap();
            assert_eq!(
                out.status.code(),
                Some(expected),
                "{opt}: {}",
                String::from_utf8_lossy(&out.stderr)
            );
        }
    }
}

#[test]
fn counted_wasm_storage_is_physically_reclaimed_after_the_last_alias() {
    let (dir, generated, _) = probe(false);
    // Observe the actual libc free, independently of the runtime's count table.
    // Omitting physical reclamation must fail even when all metadata is gone.
    let observer = r#"
#include <stdlib.h>
static void *probe_watched;
static unsigned probe_frees;
static void probe_free(void *p) {
    int watched = p == probe_watched;
    free(p);
    if (watched) probe_frees++;
}
#define free probe_free
"#;
    let fixture = r#"
int main(void) {
    for (unsigned cycle = 0; cycle < 10000; cycle++) {
        V value = fwp_rc_fresh(fwp_tuple2(31, 47));
        probe_watched = (void *)(uintptr_t)value;
        unsigned before = probe_frees;
        for (unsigned i = 0; i < 300; i++) fwp_rc_dup(value);
        for (unsigned i = 0; i < 300; i++) {
            fwp_rc_free_obj(value);
            if (fwp_rc_release_last(value)) return 11;
            if (probe_frees != before) return 12;
        }
        if (!fwp_rc_last(value)) return 13;
        if (OBJ(value)->f[0] != 31 || OBJ(value)->f[1] != 47) return 14;
        fwp_rc_free_obj(value);
        if (probe_frees != before + EXPECT_FREE) return 15;
        if (fwp_wasm_counts_live) return 16;
    }
    return 0;
}
"#;
    let needle = "    free((void *)(uintptr_t)value);";
    assert_eq!(generated.matches(needle).count(), 1);
    let omitted = generated.replace(needle, "    (void)value; /* omit physical free */");
    let disabled = format!("#define FWP_RESOURCE_NO_FREE 1\n{generated}");
    let cases = [(&generated, 1, 0), (&omitted, 1, 15), (&disabled, 0, 0)];
    let wasm_cc = std::env::var("FWP_WASM_CC").unwrap_or_else(|_| "clang".into());
    let probe_c = dir.join("toolchain.c");
    std::fs::write(&probe_c, "int main(void){return 0;}").unwrap();
    let wasi = Command::new(wasm_cc)
        .args(["--target=wasm32-wasi", "-o"])
        .arg(dir.join("toolchain.wasm"))
        .arg(probe_c)
        .output()
        .is_ok_and(|o| o.status.success())
        && Command::new("node")
            .arg("--version")
            .output()
            .is_ok_and(|o| o.status.success());
    assert!(
        wasi || std::env::var_os("FWP_REQUIRE_WASM_RESOURCE_COUNTS").is_none(),
        "required actual WASI reclamation evidence unavailable"
    );
    for opt in ["-O1", "-O2"] {
        for (code, free, expected) in cases {
            let code = format!(
                "{observer}\n{code}\n{}",
                fixture.replace("EXPECT_FREE", &free.to_string())
            );
            let exe = dir.join("reclaim");
            fwp::cgen::compile_c(&format!("#define __wasm__ 1\n{code}"), &exe, opt).unwrap();
            let out = Command::new(&exe).output().unwrap();
            assert_eq!(
                out.status.code(),
                Some(expected),
                "host {opt}: {}",
                String::from_utf8_lossy(&out.stderr)
            );
            if wasi {
                let wasm = dir.join("reclaim.wasm");
                fwp::cgen::compile_for(&code, &wasm, opt, fwp::cgen::Target::Wasi).unwrap();
                let out = Command::new("node")
                    .arg("--no-warnings")
                    .arg(
                        std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
                            .join("tests/wasm/wasi-run.mjs"),
                    )
                    .arg(wasm)
                    .output()
                    .unwrap();
                assert_eq!(
                    out.status.code(),
                    Some(expected),
                    "WASI {opt}: {}",
                    String::from_utf8_lossy(&out.stderr)
                );
            }
        }
    }
}
