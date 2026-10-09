//! Connection headers and full addresses share one allocation without truncation.
use fwp::ir::*;
use std::process::Command;

#[test]
fn connection_addresses_preserve_long_pool_keys_in_one_allocation() {
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
    let (generated, _) = fwp::cgen::generate_library(&program, "grpc_addresses").unwrap();
    assert!(generated.contains("#define FWP_GCTX_OWNERS 1"));
    let start = generated.find("struct g_conn {").unwrap();
    let end = start + generated[start..].find("\n};").unwrap() + 3;
    let legacy = generated[start..end]
        .replace("struct g_conn {", "struct legacy_g_conn {")
        .replace("char *authority;", "char authority[256];");
    let mut generated = generated.replace(
        "fwp_mem_alloc(sizeof *c + n + 1)",
        "observe_connection_alloc(sizeof *c + n + 1)",
    );
    for (before, after) in [
        (
            "startup.reader = fwp_spawn_task(0, g_reader, c, 0, 1);",
            "startup.reader=fwp_spawn_task(0,driver,c,0,1);reader= startup.reader;",
        ),
        (
            "startup.writer = fwp_spawn_task(0, g_writer, c, 0, 1);",
            "startup.writer=fwp_spawn_task(0,driver,c,0,1);writer= startup.writer;",
        ),
    ] {
        assert_eq!(generated.matches(before).count(), 1);
        generated = generated.replacen(before, after, 1);
    }
    let hooks = r#"
#include <stdint.h>
#include <stddef.h>
static void *reader,*writer;
static void driver(void *,int);
static void *observe_connection_alloc(size_t);
"#;
    let fixture = r#"
static int connection_allocations;static size_t connection_bytes;
static void *observe_connection_alloc(size_t n){connection_allocations++;connection_bytes=n;return fwp_mem_alloc(n);}
static char target[5000];static g_conn *connected;static const g_tls *options;
static void driver(void *arg,int stop){g_conn *c=arg;if(!stop){fwp_park(0,0);fwp_check_cancel();}g_conn_release(c);}
static void client(void *arg,int stop){if(stop)_Exit(10);char *error=0;connected=g_connect(target,options,&error);if(error||!connected)_Exit(11);}
static void drop_options(g_tls *t){t->users=1;g_tls_release(t);}
static int distinguish(g_tls *a,g_tls *b){
 g_conn c={0};c.tlskey=a->key;c.tlskey_len=a->key_len;
 int ok=g_same_tls(&c,a)&&!g_same_tls(&c,b)&&!g_same_tls(&c,0);
 g_conn clear={0};ok=ok&&g_same_tls(&clear,0)&&!g_same_tls(&clear,a);
 drop_options(a);drop_options(b);return ok;
}
int main(void){
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));fwp_tasks_init();fwp_trap_recover=g_trap_recover;
 if(!distinguish(g_tls_new("a",0,"b|c","d","e"),g_tls_new("a",0,"b","c|d","e")))return 1;
 for(int field=0;field<5;field++){
  const char *v[4]={"a","b","c","d"};const char *w[4]={"a","b","c","d"};
  if(field<4)w[field]="different";
  if(!distinguish(g_tls_new(v[0],0,v[1],v[2],v[3]),g_tls_new(w[0],field==4,w[1],w[2],w[3])))return 1;
 }
 char long_name[4097];memset(long_name,'x',sizeof long_name-1);long_name[sizeof long_name-1]=0;
 char other_name[4097];memcpy(other_name,long_name,sizeof long_name);other_name[4095]='y';
 if(!distinguish(g_tls_new("a",0,long_name,"c","d"),g_tls_new("a",0,other_name,"c","d")))return 1;
 g_tls *original=g_tls_new("ca|file",1,long_name,"cert","key");
 g_tls *same=g_tls_new("ca|file",1,long_name,"cert","key");
 V listener=fwp_p_tcp_listen(fwp_cstr("127.0.0.1:0"),0);V address=fwp_p_local_addr(listener);snprintf(target,sizeof target,"%s",STR(address)->d);
 size_t at=strlen(target);memmove(target+7,target,at+1);memcpy(target,"grpc://",7);at+=7;memset(target+at,'/',4096);target[at+4096]=0;
 options=original;fwp_task *task=fwp_spawn_task(0,client,0,0,0);fwp_await(task);
 if(!connected||connected->refs!=2||g_pool!=connected||!g_same_tls(connected,same)||connected->tlskey==original->key)return 1;
 if(strcmp(connected->authority,target)||connected->authority!=(char*)(connected+1)||connection_allocations!=1||connection_bytes!=sizeof(g_conn)+strlen(target)+1)return 1;
 drop_options(original);options=0;
 g_ctx context={0};context.tls=same;fwp_cur->gctx=&context;
 char *error=0;int reused=0;g_conn *selected=0;
 g_stream *stream=g_open_tls(target,"/test",0,&selected,&reused,&error,0);
 if(!stream||selected!=connected||!reused||error||!g_same_tls(connected,same))return 1;
 fwp_cur->gctx=0;drop_options(same);
 fwp_gc_forget_finalizer(stream);g_unlink(connected,stream);g_stream_final(stream);
 g_conn_dead(connected,"finished");fwp_cancel_tree(reader);fwp_cancel_tree(writer);fwp_await(reader);fwp_await(writer);
 if(connected->refs||connected->fd!=-1||g_pool)return 2;
 fwp_gc_forget_finalizer(connected);g_conn_final(connected);fwp_p_tcp_stop(listener);
 FWP_KEEP_ALIVE(listener);FWP_KEEP_ALIVE(PTR(task));FWP_KEEP_ALIVE(PTR(connected));
 char short_name[]="short";g_conn *short_conn=g_conn_new(-1,short_name,0);short_name[0]='x';
 if(strcmp(short_conn->authority,"short")||connection_allocations!=2||connection_bytes!=sizeof(g_conn)+6||connection_bytes>=sizeof(struct legacy_g_conn))return 1;
 fwp_lib_finish();return 0;
}
"#;
    let copied = "memcpy(c->authority, authority, n + 1);";
    assert_eq!(generated.matches(copied).count(), 1);
    let broken = generated.replacen(
        copied,
        "snprintf(c->authority, 256, \"%s\", authority);",
        1,
    );
    let dir = fwp::cgen::TempDir::new("grpc-connection-addresses").unwrap();
    let exe = dir.join("probe");
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(
            &format!("{hooks}\n{broken}\n{legacy}\n{fixture}"),
            &exe,
            opt,
        )
        .unwrap();
        let out = Command::new(&exe).env("FWP_GC", "off").output().unwrap();
        assert_eq!(out.status.code(), Some(1), "old address truncation: {out:?}");
        fwp::cgen::compile_c(
            &format!("{hooks}\n{generated}\n{legacy}\n{fixture}"),
            &exe,
            opt,
        )
        .unwrap();
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
    let address = format!("grpc://127.0.0.1:1234{}", "/".repeat(4096));
    assert_eq!(fwp::tls::grpc_addr(&address), (false, "127.0.0.1:1234"));
}
