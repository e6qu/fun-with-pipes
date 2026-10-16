//! Streaming cell receive ownership survives decoder/copy traps and transfers.
use fwp::ir::*;
use std::process::Command;

#[test]
fn forced_cells_release_received_storage_and_decoder_failure_text() {
    let unit = MT::unit();
    let program = Program {
        funcs: vec![
            Func {
                name: "available".into(),
                arity: 1,
                locals: vec![unit.clone()],
                ty: MT::Fun(Box::new(unit.clone()), Box::new(MT::con("std::Bool"))),
                body: Body::Prim("tls.available".into()),
            },
            Func {
                name: "web".into(),
                arity: 0,
                locals: vec![],
                ty: unit,
                body: Body::Prim("http2.connect".into()),
            },
        ],
        exports: vec![("available".into(), 0)],
        ..Program::default()
    };
    let (generated, _) = fwp::cgen::generate_library(&program, "grpc_force").unwrap();
    let decode = "g_decode(&src->dec, g.m->d, g.m->n, &x, &why)";
    assert_eq!(generated.matches(decode).count(), 2);
    let generated = generated.replace(decode, "observed_decode(&x, &why)");
    let copy = "last->memo = FWP_NONE;\n    V f[2] = {(V)(int64_t)code, fwp_cstr(text)};";
    assert_eq!(generated.matches(copy).count(), 1);
    let generated = generated.replacen(
        copy,
        "last->memo = FWP_NONE;\n    V f[2] = {(V)(int64_t)code, observed_copy(text)};",
        1,
    );
    let hooks = r#"
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
static int stage,allocations,frees;
static void *owned[16];
static char *observed_strdup(const char *);
static void observed_free(void *);
static void no_release(void *);
static int observed_decode(uintptr_t *,char **);
static uintptr_t observed_copy(const char *);
#define strdup(p) observed_strdup(p)
#define free(p) observed_free(p)
"#;
    let fixture = r#"
#undef strdup
#undef free
static void remember(void *p){if(!p||allocations==16)_Exit(30);owned[allocations++]=p;}
static char *observed_strdup(const char *p){char *copy=strdup(p);remember(copy);return copy;}
static void observed_free(void *p){if(p)for(int i=0;i<allocations;i++)if(owned[i]==p){owned[i]=0;frees++;break;}free(p);}
static void no_release(void *p){(void)p;}
static int observed_decode(uintptr_t *out,char **why){
 if(stage==8)fwp_trap("decode trap");
 if(stage==4||stage==5||stage==10){*why=observed_strdup("decode reason");return G_DEC_BAD;}
 *out=42;return stage==9?G_DEC_ERROR:G_DEC_OK;
}
static uintptr_t observed_copy(const char *p){if(stage==2||stage==10)fwp_trap("copy trap");return fwp_cstr(p);}
static jmp_buf failed;
static int recover(void){return 1;}
int main(void){
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));fwp_tasks_init();
 g_server srv={0};srv.module="probe";g_conn *c=g_conn_new(-1,"local",&srv);
 for(stage=0;stage<11;stage++){
  allocations=frees=0;memset(owned,0,sizeof owned);
  g_stream *s=g_stream_new(c,(uint32_t)(1+2*stage));
  g_incoming *src=fwp_mem_alloc(sizeof *src);src->c=c;src->s=s;src->what="probe";
  src->results=stage==2||stage==4||stage==7||stage==10;
  if(stage<3)s->bad=strdup("bad request");else if(stage==3)s->remote_end=1;
  else{g_msg *m=malloc(sizeof *m+1);if(!m)return 31;memset(m,0,sizeof *m);m->n=1;m->d[0]=42;remember(m);s->mhead=s->mtail=m;}
  g_cell *cell=fwp_mem_alloc(sizeof *cell);cell->src=src;
  g_failure failure={0};V error=0;const fwp_desc *desc=0;volatile int trapped=0;
  fwp_trap_recover=recover;fwp_trap_jb=&failed;fwp_trap_cleanup=0;
  if(!setjmp(failed)){
   V r=g_force(cell,stage==0||stage==9,&failure,&error,&desc);
   if(stage==1||stage==2||stage==5||stage==8||stage==10)return 2;
   if(stage==0){if(r||cell->forced||cell->src!=src||!failure.text||strcmp(failure.text,"bad request")||frees)return 3;observed_free(failure.text);}
   else if(stage==9){if(r||cell->forced||cell->src!=src||error!=42||desc)return 4;}
   else{
    if(!cell->forced||cell->memo!=r||cell->src)return 5;
    if(stage==3){if(r!=FWP_NONE)return 6;}
    else{
     if(r==FWP_NONE)return 7;V value=OBJ(OBJ(r)->f[0])->f[0];
     if(stage==4){g_cell *end=(g_cell *)(uintptr_t)OBJ(OBJ(r)->f[0])->f[1];if(end->src||!end->forced||end->memo!=FWP_NONE)return 12;V text=OBJ(OBJ(value)->f[0])->f[1];if(strcmp(STR(text)->d,"bad response from probe: decode reason"))return 8;}
     else if((stage==7?OBJ(value)->f[0]:value)!=42)return 9;
    }
    int before=allocations;if(g_force(cell,0,&failure,&error,&desc)!=r||allocations!=before)return 10;
   }
  }else trapped=1;
  fwp_trap_recover=0;fwp_trap_jb=0;
  int expected=stage==4||stage==10?3:stage==5?2:1;
  if(allocations!=expected||frees!=expected||fwp_cleanups)return 1;
  if(trapped&&(cell->forced||cell->src!=src))return 11;
  FWP_KEEP_ALIVE(PTR(cell));FWP_KEEP_ALIVE(PTR(src));FWP_KEEP_ALIVE(PTR(s));FWP_KEEP_ALIVE(PTR(c));
 }
 FWP_KEEP_ALIVE(PTR(c));fwp_lib_finish();return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("grpc-force-cleanup").unwrap();
    let exe = dir.join("probe");
    let receive = "fwp_cleanup_push(&received_cleanup, g_got_release, &g);";
    assert_eq!(generated.matches(receive).count(), 1);
    let receive_omitted = generated.replacen(
        receive,
        "fwp_cleanup_push(&received_cleanup, no_release, &g);",
        1,
    );
    let reason = "fwp_tls_subject_free(why);";
    assert_eq!(generated.matches(reason).count(), 3);
    let reason_omitted = generated.replace(reason, "no_release(why);");
    let text = "fwp_cleanup_push(&text_cleanup, fwp_tls_subject_free, t);";
    assert_eq!(generated.matches(text).count(), 1);
    let text_omitted =
        generated.replacen(text, "fwp_cleanup_push(&text_cleanup, no_release, t);", 1);
    for opt in ["-O1", "-O2"] {
        for broken in [&receive_omitted, &reason_omitted, &text_omitted] {
            fwp::cgen::compile_c(&format!("{hooks}\n{broken}\n{fixture}"), &exe, opt).unwrap();
            let out = Command::new(&exe).env("FWP_GC", "off").output().unwrap();
            assert_eq!(out.status.code(), Some(1), "omitted release: {out:?}");
        }
        fwp::cgen::compile_c(&format!("{hooks}\n{generated}\n{fixture}"), &exe, opt).unwrap();
        for gc in ["off", "on"] {
            for poison in ["0", "1"] {
                let out = Command::new(&exe)
                    .env("FWP_GC", gc)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison)
                    .output()
                    .unwrap();
                assert!(out.status.success(), "{opt}/{gc}/{poison}: {out:?}");
            }
        }
    }
}

#[path = "support/http2_values.rs"]
mod http2_values;

#[test]
fn cached_stream_positions_preserve_values_and_report_storage() {
    let mut generated = http2_values::generated();
    let declaration = "typedef uint64_t V;";
    assert_eq!(generated.matches(declaration).count(), 1);
    generated = generated.replace(declaration, "typedef uint64_t V;\nstatic int measured;\nstatic unsigned long long requests, requested_bytes;\n");
    for (marker, condition) in [
        ("static inline void *fwp_alloc_init(size_t n) {", "1"),
        (
            "static inline void *fwp_gc_alloc(size_t n, int leaf) {",
            "leaf != 0",
        ),
    ] {
        assert_eq!(generated.matches(marker).count(), 1);
        generated = generated.replace(
            marker,
            &format!("{marker} if(measured && ({condition})){{requests++;requested_bytes+=n;}}"),
        );
    }
    let hooks = r#"
#include <stdlib.h>
static void *queued_messages[128];
static size_t messages_freed;
static void observe_free(void *);
#define free(p) observe_free(p)
"#;
    let code = format!(
        "{hooks}\n{generated}\n{}",
        include_str!("fixtures/grpc_stream_storage.c")
    );
    let dir = fwp::cgen::TempDir::new("grpc-stream-storage").unwrap();
    let memo = "if (cell->forced) return cell->memo;";
    assert_eq!(code.matches(memo).count(), 1);
    let broken = dir.join("without-cache.exe");
    fwp::cgen::compile_c(
        &code
            .replace(memo, "/* deliberately receive again */")
            .replace(
                "cell->src = 0;",
                "/* deliberately keep source for second receive */",
            )
            .replace("if (position->src) return 38;", ""),
        &broken,
        "-O2",
    )
    .unwrap();
    let control = Command::new(&broken)
        .args(["1", "0"])
        .env("FWP_GC", "off")
        .env("FWP_GC_STRESS", "0")
        .env("FWP_GC_VERIFY", "0")
        .env("FWP_REUSE_VERIFY", "0")
        .output()
        .unwrap();
    assert_eq!(
        control.status.code(),
        Some(34),
        "missing cache must be detected: {control:?}"
    );
    // Keeping obsolete source edges must fail even while values remain correct.
    let retained = dir.join("with-retained-source.exe");
    assert_eq!(code.matches("cell->src = 0;").count(), 2);
    fwp::cgen::compile_c(
        &code.replace("cell->src = 0;", "/* deliberately retain source */"),
        &retained,
        "-O2",
    )
    .unwrap();
    let control = Command::new(&retained)
        .args(["1", "0"])
        .env("FWP_GC", "off")
        .env("FWP_GC_STRESS", "0")
        .env("FWP_GC_VERIFY", "0")
        .env("FWP_REUSE_VERIFY", "0")
        .output()
        .unwrap();
    assert_eq!(
        control.status.code(),
        Some(38),
        "retained source must be detected: {control:?}"
    );
    let mut report = String::from("elements\tmode\tconsumed\tsetup_requests\tsetup_bytes\treceive_requests\treceive_bytes\tsetup_charged_bytes\tafter_read_charged_bytes\tafter_clearing_roots_charged_bytes\tqueued_messages\tcollections\n");
    for opt in ["-O1", "-O2"] {
        let binary = dir.join(format!("stream{opt}.exe"));
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();
        for count in [1, 32, 128] {
            for mode in [0, 1, 2] {
                for stress in ["0", "1"] {
                    let output = Command::new(&binary)
                        .args([count.to_string(), mode.to_string()])
                        .env("FWP_GC", if stress == "0" { "off" } else { "on" })
                        .env("FWP_GC_STRESS", stress)
                        .env("FWP_GC_VERIFY", stress)
                        .env("FWP_GC_STATS", "0")
                        .env("FWP_REUSE_VERIFY", "0")
                        .output()
                        .unwrap();
                    assert!(
                        output.status.success(),
                        "{opt}/{count}/{mode}/{stress}: {output:?}"
                    );
                    assert!(output.stderr.is_empty(), "{output:?}");
                    let row = String::from_utf8(output.stdout).unwrap();
                    let fields: Vec<_> = row.split_whitespace().collect();
                    assert_eq!(fields.len(), 12, "{row}");
                    assert_eq!(fields[0], count.to_string());
                    assert_eq!(fields[1], mode.to_string());
                    if stress == "0" {
                        assert_eq!(fields[11], "0", "measurement collected: {row}");
                        if opt == "-O2" {
                            report.push_str(&row);
                        }
                    }
                }
            }
        }
        if let Some(path) = std::env::var_os("FWP_STREAM_ARTIFACTS") {
            let path = std::path::PathBuf::from(path);
            std::fs::create_dir_all(&path).unwrap();
            std::fs::write(path.join("stream.c"), &code).unwrap();
            std::fs::copy(&binary, path.join(format!("stream{opt}.exe"))).unwrap();
            std::fs::write(path.join("storage.tsv"), &report).unwrap();
        }
    }
    eprint!("{report}");
}

#[test]
fn incoming_stream_descriptions_outlive_their_input_text() {
    let generated = http2_values::generated();
    let allocation = "static void *fwp_mem_alloc(size_t n) { return fwp_alloc(n); }";
    assert_eq!(generated.matches(allocation).count(), 1);
    let generated = generated.replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic size_t description_allocations, description_bytes;\nstatic int measure_description;\n").replace(allocation, "static void *fwp_mem_alloc(size_t n) { if(measure_description){description_allocations++;description_bytes+=n;} return fwp_alloc(n); }");
    let fixture = r#"
static jmp_buf description_failure;
static int recover_description(void) { return 1; }
int main(void) {
    fwp_lib_init(); fwp_gc_start(__builtin_frame_address(0));
    for (size_t length=0; length<=2048; length+=128) {
        char input[2049]; memset(input,'x',length); input[length]=0;
        description_allocations=description_bytes=0; measure_description=1;
        g_incoming *source=g_incoming_new(input,length);
        measure_description=0;
        if(description_allocations!=1||description_bytes!=sizeof(g_incoming)+length+1)return 2;
        memset(input,'z',length);
        (void)fwp_cstr("allocation after construction");
        if(strlen(source->what)!=length)return 1;
        for(size_t i=0;i<length;i++)if(source->what[i]!='x')return 1;
        FWP_KEEP_ALIVE(PTR(source));
        fwp_mem_free(source);
    }
    char name[2049]; memset(name,'a',sizeof name-1); name[sizeof name-1]=0;
    for(int long_name=0;long_name<2;long_name++) {
        const char *method=long_name?name:"module.method";
        char *before=g_strdupf("%s (%s)",method,"localhost:1234");
        if(!before)return 30;
        description_allocations=description_bytes=0; measure_description=1;
        g_incoming *source=g_incoming_format("%s (%s)",method,"localhost:1234");
        measure_description=0;
        if(strcmp(source->what,before)||description_allocations!=1||description_bytes!=sizeof(g_incoming)+strlen(before)+1)return 3;
        if(long_name&&strlen(source->what)!=G_MESSAGE_BYTES-1)return 4;
        free(before); fwp_mem_free(source);
    }
    volatile int trapped=0;
    description_allocations=description_bytes=0; measure_description=1;
    fwp_trap_recover=recover_description; fwp_trap_jb=&description_failure; fwp_trap_cleanup=0;
    if(!setjmp(description_failure)) (void)g_incoming_new("",SIZE_MAX);
    else trapped=1;
    measure_description=0; fwp_trap_recover=0; fwp_trap_jb=0;
    if(!trapped||description_allocations||strcmp(fwp_trap_msg,"stream description too long"))return 5;
    fwp_lib_finish(); return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("grpc-stream-description").unwrap();
    let copied = "src->what = text;";
    assert_eq!(generated.matches(copied).count(), 1);
    let borrowed = generated.replace(copied, "src->what = what;");
    for opt in ["-O1", "-O2"] {
        let binary = dir.join(format!("description{opt}.exe"));
        fwp::cgen::compile_c(&format!("{borrowed}\n{fixture}"), &binary, opt).unwrap();
        let control = Command::new(&binary)
            .env("FWP_GC", "off")
            .env("FWP_GC_STRESS", "0")
            .env("FWP_GC_VERIFY", "0")
            .env("FWP_REUSE_VERIFY", "0")
            .output()
            .unwrap();
        assert_eq!(
            control.status.code(),
            Some(1),
            "borrowed description must be detected: {control:?}"
        );
        let code = format!("{generated}\n{fixture}");
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();
        for stress in ["0", "1"] {
            let output = Command::new(&binary)
                .env("FWP_GC", if stress == "0" { "off" } else { "on" })
                .env("FWP_GC_STRESS", stress)
                .env("FWP_GC_VERIFY", stress)
                .env("FWP_REUSE_VERIFY", stress)
                .output()
                .unwrap();
            assert!(output.status.success(), "{opt}/{stress}: {output:?}");
        }
        if let Some(path) = std::env::var_os("FWP_STREAM_ARTIFACTS") {
            let path = std::path::PathBuf::from(path);
            std::fs::create_dir_all(&path).unwrap();
            std::fs::write(path.join("description.c"), code).unwrap();
            std::fs::copy(&binary, path.join(format!("description{opt}.exe"))).unwrap();
        }
    }
}
