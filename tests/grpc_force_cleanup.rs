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
                name: "pooled".into(),
                arity: 1,
                locals: vec![MT::con("std::String")],
                ty: MT::Fun(
                    Box::new(MT::con("std::String")),
                    Box::new(MT::con("std::Bool")),
                ),
                body: Body::Prim("http2.pooled".into()),
            },
        ],
        exports: vec![("available".into(), 0)],
        ..Program::default()
    };
    let (generated, _) = fwp::cgen::generate_library(&program, "grpc_force", &[]).unwrap();
    let decode = "g_decode(&src->dec, g->m->d, g->m->n, &x, &why)";
    assert_eq!(generated.matches(decode).count(), 2);
    let generated = generated.replace(decode, "observed_decode(&x, &why)");
    let copy = "V f[2] = {(V)(int64_t)code, fwp_rc_fresh(fwp_cstr(text))};";
    assert_eq!(generated.matches(copy).count(), 1);
    let generated = generated.replacen(
        copy,
        "V f[2] = {(V)(int64_t)code, fwp_rc_fresh(observed_copy(text))};",
        1,
    );
    let end =
        "if (c->server) { g->kind = G_END; g->code = 0; g->text = g_copy_text(\"\"); return; }";
    assert_eq!(generated.matches(end).count(), 1);
    let generated = generated.replacen(end, "if (c->server) { g->kind = G_END; g->code = 0; g->text = g_copy_text(\"\"); if(stage==11)fwp_trap(\"receive trap\"); return; }", 1);
    let hooks = r#"
#if defined(_WIN32) && !defined(_WIN32_WINNT)
#define _WIN32_WINNT 0x0a00
#endif
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
 fwp_lib_init();fwp_heap_start();fwp_tasks_init();
 g_server srv={0};srv.module="probe";g_conn *c=g_conn_new(-1, "", "local",&srv);
 for(stage=0;stage<12;stage++){
  allocations=frees=0;memset(owned,0,sizeof owned);
  g_stream *s=g_stream_new(c,(uint32_t)(1+2*stage));
  g_incoming *src=fwp_mem_alloc(sizeof *src);src->c=c;src->s=s;src->what="probe";
  static const fwp_desc scalar_type={.kind=K_I64};src->dec.ty=&scalar_type;src->dec.error=&scalar_type;
  src->results=stage==2||stage==4||stage==7||stage==10;
  if(stage<3)s->bad=strdup("bad request");else if(stage==3||stage==11)s->remote_end=1;
  else{g_msg *m=malloc(sizeof *m+1);if(!m)return 31;memset(m,0,sizeof *m);m->n=1;m->d[0]=42;remember(m);s->mhead=s->mtail=m;}
  g_cell *cell=fwp_mem_alloc(sizeof *cell);cell->src=src;
  g_failure failure={0};V error=0;const fwp_desc *desc=0;volatile int trapped=0;
  fwp_trap_recover=recover;fwp_trap_jb=&failed;fwp_trap_cleanup=0;
  if(!setjmp(failed)){
   V r=g_force(cell,stage==0||stage==9,&failure,&error,&desc);
   if(stage==1||stage==2||stage==5||stage==8||stage==10||stage==11)return 2;
   if(stage==0){if(r||cell->forced||cell->src!=src||!failure.text||strcmp(failure.text,"bad request")||frees)return 3;observed_free(failure.text);}
   else if(stage==9){if(r||cell->forced||cell->src!=src||error!=42||desc!=&scalar_type)return 4;}
   else{
    if(!cell->forced||cell->memo!=r)return 5;
    if(stage==3){if(r!=FWP_NONE)return 6;}
    else{
     if(r==FWP_NONE)return 7;V value=OBJ(OBJ(r)->f[0])->f[0];
     if(stage==4){g_cell *end=(g_cell *)(uintptr_t)OBJ(OBJ(r)->f[0])->f[1];if(!end->forced||end->memo!=FWP_NONE)return 12;V text=OBJ(OBJ(value)->f[0])->f[1];if(strcmp(STR(text)->d,"bad response from probe: decode reason"))return 8;}
     else if((stage==7?OBJ(value)->f[0]:value)!=42)return 9;
    }
    int before=allocations;if(g_force(cell,0,&failure,&error,&desc)!=r||allocations!=before)return 10;
   }
  }else trapped=1;
  fwp_trap_recover=0;fwp_trap_jb=0;
  int expected=stage==4||stage==10?3:stage==5?2:1;
  if(allocations!=expected||frees!=expected||fwp_cleanups)return 1;
  if(src->reader||src->read_waiters.head)return 13;
  if(trapped&&(cell->forced||cell->src!=src))return 11;

 }
 fwp_lib_finish();return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("grpc-force-cleanup").unwrap();
    let exe = dir.join("probe");
    let receive = "fwp_cleanup_push(&reading_cleanup, g_received_stream_release, &received);";
    assert_eq!(generated.matches(receive).count(), 1);
    let receive_omitted = generated.replacen(
        receive,
        "fwp_cleanup_push(&reading_cleanup, no_release, &received);",
        1,
    );
    let early = "fwp_cleanup_push(&reading_cleanup, g_received_stream_release, &received);\n    g_got *g = &received.got;\n    g_recv(src->c, src->s, src->deadline, g);";
    assert_eq!(generated.matches(early).count(), 1);
    let late_owner = generated.replacen(early, "g_got *g = &received.got;\n    g_recv(src->c, src->s, src->deadline, g);\n    fwp_cleanup_push(&reading_cleanup, g_received_stream_release, &received);", 1);
    let reason = "fwp_tls_subject_free(why);";
    assert_eq!(generated.matches(reason).count(), 3);
    let reason_omitted = generated.replace(reason, "no_release(why);");
    let text = "fwp_cleanup_push(&text_cleanup, fwp_tls_subject_free, t);";
    assert_eq!(generated.matches(text).count(), 1);
    let text_omitted =
        generated.replacen(text, "fwp_cleanup_push(&text_cleanup, no_release, t);", 1);
    for opt in ["-O1", "-O2"] {
        for broken in [
            &receive_omitted,
            &reason_omitted,
            &text_omitted,
            &late_owner,
        ] {
            fwp::cgen::compile_c(&format!("{hooks}\n{broken}\n{fixture}"), &exe, opt).unwrap();
            let out = Command::new(&exe).output().unwrap();
            assert_eq!(out.status.code(), Some(1), "omitted release: {out:?}");
        }
        fwp::cgen::compile_c(&format!("{hooks}\n{generated}\n{fixture}"), &exe, opt).unwrap();

        let out = Command::new(&exe).output().unwrap();
        assert!(out.status.success(), "{opt}: {out:?}");
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
            "static inline void *fwp_heap_alloc(size_t n, int kind) {",
            "kind != 0",
        ),
    ] {
        assert_eq!(generated.matches(marker).count(), 1);
        generated = generated.replace(
            marker,
            &format!("{marker} if(measured && ({condition})){{requests++;requested_bytes+=n;}}"),
        );
    }
    let hooks = r#"
#if defined(_WIN32) && !defined(_WIN32_WINNT)
#define _WIN32_WINNT 0x0a00
#endif
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
    assert_eq!(code.matches(memo).count(), 2);
    // A separate source slot keeps the intentionally broken second receive valid.
    // The same old layout below must fail the per-message storage budget.
    let shared_slot = "union { g_incoming *src; V memo; };";
    assert_eq!(code.matches(shared_slot).count(), 1);
    let separate_slots = code.replace(shared_slot, "struct { g_incoming *src; V memo; };");
    let broken = dir.join("without-cache.exe");
    fwp::cgen::compile_c(
        &separate_slots.replace(memo, "/* deliberately receive again */"),
        &broken,
        "-O2",
    )
    .unwrap();
    let control = Command::new(&broken).args(["1", "0"]).output().unwrap();
    assert_eq!(
        control.status.code(),
        Some(34),
        "missing cache must be detected: {control:?}"
    );
    // Keeping both mutually exclusive fields costs another word per position.
    let retained = dir.join("with-separate-source.exe");
    fwp::cgen::compile_c(&separate_slots, &retained, "-O2").unwrap();
    let control = Command::new(&retained).args(["1", "0"]).output().unwrap();
    assert_eq!(
        control.status.code(),
        Some(38),
        "extra per-position storage must be detected: {control:?}"
    );
    let missing_drop = code.replace(
        "g_cell_drop(PTR(root), fwp_rc_free_obj);",
        "/* omit cache owner */",
    );
    assert_ne!(missing_drop, code);
    fwp::cgen::compile_c(&missing_drop, &broken, "-O2").unwrap();
    let control = Command::new(&broken).args(["32", "1"]).output().unwrap();
    assert_eq!(
        control.status.code(),
        Some(40),
        "missing cache drop: {control:?}"
    );
    let mut report = String::from("elements\tmode\tconsumed\tsetup_requests\tsetup_bytes\treceive_requests\treceive_bytes\tsetup_charged_bytes\tafter_read_charged_bytes\tafter_owner_drop_charged_bytes\tqueued_messages\n");
    for opt in ["-O1", "-O2"] {
        let binary = dir.join(format!("stream{opt}.exe"));
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();
        for count in [1, 32, 128] {
            for mode in [0, 1, 2] {
                let output = Command::new(&binary)
                    .args([count.to_string(), mode.to_string()])
                    .output()
                    .unwrap();
                assert!(output.status.success(), "{opt}/{count}/{mode}: {output:?}");
                assert!(output.stderr.is_empty(), "{output:?}");
                let row = String::from_utf8(output.stdout).unwrap();
                let fields: Vec<_> = row.split_whitespace().collect();
                assert_eq!(fields.len(), 11, "{row}");
                assert_eq!(fields[0], count.to_string());
                assert_eq!(fields[1], mode.to_string());

                assert_eq!(fields[9], "0", "cache owner did not release: {row}");
                if opt == "-O2" {
                    report.push_str(&row);
                }
            }
        }
        if let Some(path) = std::env::var_os("FWP_STREAM_ARTIFACTS") {
            let path = std::path::PathBuf::from(path);
            std::fs::create_dir_all(&path).unwrap();
            std::fs::write(path.join("stream.c"), &code).unwrap();
            std::fs::copy(&binary, path.join(format!("stream{opt}.exe"))).unwrap();
            std::fs::write(path.join("storage.tsv"), &report).unwrap();
            if opt == "-O2" {
                let layout = Command::new(&binary).arg("--layout").output().unwrap();
                assert!(layout.status.success(), "stream layout probe: {layout:?}");
                std::fs::write(path.join("layout.tsv"), layout.stdout).unwrap();
            }
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
    fwp_lib_init(); fwp_heap_start();
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

        fwp_mem_free(source);
    }
    const size_t lengths[]={0,1,1018,1019,1020,1021,1022,1023,1024,2048};
    char name[2049], address[2049];
    memset(address,'b',sizeof address-1); address[sizeof address-1]=0;
    const char *addresses[]={"","x","localhost:1234",address};
    for(size_t i=0;i<sizeof lengths/sizeof lengths[0];i++) {
      memset(name,'a',sizeof name); name[lengths[i]]=0;
      for(size_t j=0;j<sizeof addresses/sizeof addresses[0];j++) {
        char *before=g_strdupf("%s (%s)",name,addresses[j]);
        if(!before)return 30;
        description_allocations=description_bytes=0; measure_description=1;
        g_incoming *source=g_incoming_client(name,addresses[j]);
        measure_description=0;
        if(strcmp(source->what,before)||description_allocations!=1||description_bytes!=sizeof(g_incoming)+strlen(before)+1)return 3;
        if(strlen(source->what)>=G_MESSAGE_BYTES)return 4;
        free(before); fwp_mem_free(source);
      }
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
    assert_eq!(generated.matches(copied).count(), 2);
    // Mutate the copying constructor only; the client formats its own text.
    let borrowed = generated.replacen(copied, "src->what = what;", 1);
    for opt in ["-O1", "-O2"] {
        let binary = dir.join(format!("description{opt}.exe"));
        fwp::cgen::compile_c(&format!("{borrowed}\n{fixture}"), &binary, opt).unwrap();
        let control = Command::new(&binary).output().unwrap();
        assert_eq!(
            control.status.code(),
            Some(1),
            "borrowed description must be detected: {control:?}"
        );
        let code = format!("{generated}\n{fixture}");
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();

        let output = Command::new(&binary).output().unwrap();
        assert!(output.status.success(), "{opt}: {output:?}");

        if let Some(path) = std::env::var_os("FWP_STREAM_ARTIFACTS") {
            let path = std::path::PathBuf::from(path);
            std::fs::create_dir_all(&path).unwrap();
            std::fs::write(path.join("description.c"), code).unwrap();
            std::fs::copy(&binary, path.join(format!("description{opt}.exe"))).unwrap();
        }
    }
}

#[test]
fn concurrent_reads_share_one_receive_and_cancel_independently() {
    let generated = http2_values::generated();
    let decoder = "g_decode(&src->dec, g->m->d, g->m->n, &x, &why)";
    assert_eq!(generated.matches(decoder).count(), 2);
    let marker = "/* encode a message (with the oneof tag of `value` when `tag`) */";
    assert_eq!(generated.matches(marker).count(), 1);
    let hook = r#"
static int pause_decode, decode_started;
static int decode_with_pause(const g_codec *codec,const unsigned char *message,size_t size,V *out,char **why) {
    if(pause_decode) { pause_decode=0; decode_started=1; fwp_preempt(); }
    return g_decode(codec,message,size,out,why);
}
"#;
    let generated = generated
        .replace(marker, &format!("{hook}\n{marker}"))
        .replace(
            decoder,
            "decode_with_pause(&src->dec, g->m->d, g->m->n, &x, &why)",
        );
    let code = format!(
        "{}\n{}",
        generated,
        include_str!("fixtures/grpc_stream_readers.c")
    );
    let wait = "while (src->reader) {";
    assert_eq!(code.matches(wait).count(), 1);
    let dir = fwp::cgen::TempDir::new("grpc-stream-readers").unwrap();
    let broken = dir.join("without-serialization.exe");
    fwp::cgen::compile_c(&code.replace(wait, "while (0) {"), &broken, "-O2").unwrap();
    let control = Command::new(&broken).arg("0").output().unwrap();
    assert_eq!(
        control.status.code(),
        Some(43),
        "missing serialization must consume two different values: {control:?}"
    );
    let restore = "if (got->kind == G_MSG && got->m && fwp_cur->cancelled) {";
    assert_eq!(code.matches(restore).count(), 1);
    let lost = dir.join("without-message-restoration.exe");
    fwp::cgen::compile_c(&code.replace(restore, "if (0) {"), &lost, "-O2").unwrap();
    let control = Command::new(&lost).arg("4").output().unwrap();
    assert_eq!(
        control.status.code(),
        Some(46),
        "cancelled decoder must not discard the first message: {control:?}"
    );
    for opt in ["-O1", "-O2"] {
        let binary = dir.join(format!("readers{opt}.exe"));
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();
        for mode in 0..6 {
            let output = Command::new(&binary)
                .arg(mode.to_string())
                .output()
                .unwrap();
            assert!(output.status.success(), "{opt}/{mode}: {output:?}");
        }
        if let Some(path) = std::env::var_os("FWP_STREAM_ARTIFACTS") {
            let path = std::path::PathBuf::from(path);
            std::fs::create_dir_all(&path).unwrap();
            std::fs::write(path.join("readers.c"), &code).unwrap();
            std::fs::copy(&binary, path.join(format!("readers{opt}.exe"))).unwrap();
        }
    }
}

#[test]
fn cache_owners_release_aliases_and_long_chains_without_collection() {
    let mut generated = http2_values::generated();
    let declaration = "typedef uint64_t V;";
    let observer = r#"
static int cache_observe;
static size_t cache_releases;
static uintptr_t cache_stack_low, cache_stack_high;
static __attribute__((noinline)) void observe_cache_stack(void) {
    if (!cache_observe) return;
    volatile unsigned char marker = 0;
    uintptr_t address = (uintptr_t)&marker;
    if (address < cache_stack_low) cache_stack_low = address;
    if (address > cache_stack_high) cache_stack_high = address;
    if (cache_stack_high-cache_stack_low > 4096) _Exit(175);
}
"#;
    assert_eq!(generated.matches(declaration).count(), 1);
    generated = generated.replace(declaration, &format!("{declaration}\n{observer}"));
    for function in ["fwp_rc_free_obj", "fwp_rc_free_arr"] {
        let free = format!("static void {function}(V v) {{\n    if (fwp_rc_last(v)) fwp_mem_free((void *)(uintptr_t)v);");
        assert_eq!(generated.matches(&free).count(), 1);
        generated = generated.replace(
            &free,
            &format!("static void {function}(V v) {{\n    if (fwp_rc_last(v)) {{ if(cache_observe)cache_releases++; fwp_mem_free((void *)(uintptr_t)v); }}"),
        );
    }
    let entry = "static void g_cell_drop(V value, void (*drop_element)(V)) {";
    assert_eq!(generated.matches(entry).count(), 1);
    generated = generated.replace(entry, &format!("{entry}\n    observe_cache_stack();"));
    let code = format!(
        "{generated}\n{}",
        include_str!("fixtures/grpc_cache_ownership.c")
    );
    let tail = "        value = next;\n    }\n}\n\n/* Protect the first client read";
    assert_eq!(code.matches(tail).count(), 1);
    let recursive = code.replace(tail, "        g_cell_drop(next, drop_element);\n        observe_cache_stack();\n        return;\n    }\n}\n\n/* Protect the first client read");
    let release = "            g_incoming_drop(source);";
    assert_eq!(code.matches(release).count(), 1);
    let missing_source = code.replace(release, "            (void)source;");
    let dir = fwp::cgen::TempDir::new("grpc-cache-owners").unwrap();
    for opt in ["-O1", "-O2"] {
        let binary = dir.join("cache.exe");
        for (broken, expected) in [(&recursive, 175), (&missing_source, 171)] {
            fwp::cgen::compile_c(broken, &binary, opt).unwrap();
            let output = Command::new(&binary).args(["16384", "0"]).output().unwrap();
            assert_eq!(output.status.code(), Some(expected), "{opt}: {output:?}");
        }
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();
        let mut samples = Vec::new();
        for count in [64, 1024, 16384] {
            for mode in 0..11 {
                // Failure cases use small samples; successful destruction
                // also runs at larger sizes to check bounded cleanup.
                if mode >= 7 && count != 64 {
                    continue;
                }
                let output = Command::new(&binary)
                    .args([count.to_string(), mode.to_string()])
                    .output()
                    .unwrap();
                assert!(output.status.success(), "{opt}/{count}/{mode}: {output:?}");

                samples.extend_from_slice(&output.stdout);
            }
        }
        if let Some(path) = std::env::var_os("FWP_STREAM_CLIENT_ARTIFACTS") {
            let path = std::path::PathBuf::from(path);
            std::fs::create_dir_all(&path).unwrap();
            std::fs::write(path.join("cache-owners.c"), &code).unwrap();
            std::fs::copy(&binary, path.join(format!("cache-owners{opt}.exe"))).unwrap();
            std::fs::write(path.join(format!("cache-owners{opt}.tsv")), &samples).unwrap();
        }
    }
}

#[test]
fn decoder_callbacks_transfer_values_and_restore_handlers_after_traps() {
    let code = format!(
        "{}\n{}",
        http2_values::generated(),
        include_str!("fixtures/grpc_decoder_callback.c")
    );
    let call = "fwp_apply_borrowed_prefix(k->fn, 1, &bytes, 1)";
    assert_eq!(code.matches(call).count(), 1);
    let legacy = code.replace(call, "fwp_apply1(k->fn, bytes)");
    let release = "        fwp_value_release(&error);";
    assert_eq!(code.matches(release).count(), 1);
    let leaked_error = code.replace(release, "        (void)error;");
    let restore = "    fwp_handlers = ((fwp_handler *)value)->prev;";
    assert_eq!(code.matches(restore).count(), 1);
    let stale_handler = code.replace(restore, "    (void)value;");
    let dir = fwp::cgen::TempDir::new("grpc-decoder-callback").unwrap();
    let binary = dir.join("decoder.exe");
    for opt in ["-O1", "-O2"] {
        for (source, expected) in [(&legacy, 197), (&leaked_error, 194), (&stale_handler, 192)] {
            fwp::cgen::compile_c(source, &binary, opt).unwrap();
            let output = Command::new(&binary).output().unwrap();
            assert_eq!(output.status.code(), Some(expected), "{opt}: {output:?}");
        }
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();

        let output = Command::new(&binary).output().unwrap();
        assert!(output.status.success(), "{opt}: {output:?}");
    }
}
