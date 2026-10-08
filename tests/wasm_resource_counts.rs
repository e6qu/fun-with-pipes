//! Execute the actual non-GC C path on the host; WASI runner evidence is separate.
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
fn probe() -> (fwp::cgen::TempDir, String, String) {
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
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&emitted),
    );
    let generated = std::fs::read_to_string(emitted).unwrap();
    assert!(generated.contains("#define FWP_RESOURCE_OWNERS 1"));
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
    let generated = generated.replace(
        "int main(int argc, char **argv)",
        "int program_main(int argc, char **argv)",
    );
    let fixture = r#"
#include <fcntl.h>
static int recover(void){return 1;}
int main(int argc,char **argv) {
 if(argc!=2)return 30;
 for(int cycle=0;cycle<128;cycle++) {
  V h=fwp_p_file_open(fwp_cstr(argv[1]),0,0);
  fwp_file *file=(fwp_file *)(uintptr_t)h;int fd=fileno(file->f);
  fwp_file_dup(h);
  V pair=fwp_rc_fresh(fwp_tuple2(h,h));
  for(int i=0;i<300;i++)fwp_rc_dup(pair);
  for(int i=0;i<300;i++)DROP_PAIR(pair);
  if(file->refs!=2||fcntl(fd,F_GETFD)==-1)return 3;
  DROP_PAIR(pair);
  if(file->refs||fcntl(fd,F_GETFD)!=-1||errno!=EBADF)return 4;
#ifdef FWP_RESOURCE_OWNERS
  if(fwp_wasm_counts_live||fwp_rc_slot(pair))return 5;
#endif
 }
#ifdef FWP_RESOURCE_OWNERS
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
 int failed=setjmp(recovery);
 if(!failed)fwp_rc_dup(v);
 fwp_trap_jb=0;fwp_trap_recover=0;
 if(!failed||fwp_wasm_count(entry)!=UINT64_MAX)return 7;
 fwp_wasm_set_count(entry,1);fwp_rc_free_obj(v);
 if(fwp_wasm_counts_live)return 8;
#endif
 return 0;
}
"#
    .replace("DROP_PAIR", drop_pair);
    (dir, generated, fixture)
}
#[test]
fn bump_heap_aggregate_counts_release_file_children() {
    let (dir, generated, fixture) = probe();
    let old = generated.replace(
        "#define FWP_RESOURCE_OWNERS 1",
        "#undef FWP_RESOURCE_OWNERS",
    );
    assert_ne!(old, generated);
    let data = dir.join("data");
    std::fs::write(&data, "contents").unwrap();
    let exe = dir.join("probe");
    for opt in ["-O1", "-O2"] {
        for (code, expected) in [(&old, 4), (&generated, 0)] {
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
    let (dir, generated, fixture) = probe();
    let old = generated.replace(
        "#define FWP_RESOURCE_OWNERS 1",
        "#undef FWP_RESOURCE_OWNERS",
    );
    std::fs::write(dir.join("data"), "contents").unwrap();
    let wasm = dir.join("probe.wasm");
    let runner = std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/wasm/wasi-run.mjs");
    for opt in ["-O1", "-O2"] {
        for (code, expected) in [(&old, 4), (&generated, 0)] {
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
                "{opt}, WASI: {}",
                String::from_utf8_lossy(&out.stderr)
            );
        }
    }
}
