//! Explicit queue draining breaks counted channel cycles without changing close.
use std::process::Command;
#[test]
fn closed_channel_cycles_keep_values_until_drain_and_then_release() {
    let dir = fwp::cgen::TempDir::new("channel-cycle").unwrap();
    let source = dir.join("probe.fwp");
    let cfile = dir.join("probe.c");
    let exe = dir.join("probe");
    std::fs::write(&source, r#"
Link = | Node (Channel[Link])
link-channel : I64 -> Channel[Link] ! {Async}
link-channel = channel.make
send-self : Channel[Link] -> Bool ! {Async}
send-self = fork channel.send id Node
receive : Channel[Link] -> Option[Link] ! {Async}
receive = channel.recv
discard-option : Option[Link] -> ()
discard-option = ignore
main = link-channel 1 | tap send-self | tap channel.close | receive | discard-option | const "drained" | echo
"#).unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = Command::new(fwp)
        .env("FWP_NO_OPT", "1")
        .args(["run", "--interp"])
        .arg(&source)
        .output()
        .unwrap();
    assert!(
        reference.status.success(),
        "{}",
        String::from_utf8_lossy(&reference.stderr)
    );
    assert_eq!(reference.stdout, b"drained\n");
    let built = Command::new(fwp)
        .env("FWP_NO_OPT", "1")
        .arg("build")
        .arg(&source)
        .args(["--emit-c", "-o"])
        .arg(&cfile)
        .output()
        .unwrap();
    assert!(
        built.status.success(),
        "{}",
        String::from_utf8_lossy(&built.stderr)
    );
    let emitted = std::fs::read_to_string(&cfile).unwrap();
    let id = |name: &str| {
        let start = emitted.find(&format!("/* {name} :")).unwrap();
        emitted[start..]
            .split("static V f")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap()
            .to_string()
    };
    let runtime = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let probe = r#"
/* Poison mode preserves storage/count metadata to detect later uses. */
static int object_released(V value){
 if(fwp_reuse_verify)return OBJ(value)->tag==0xdead;
 uint8_t *slot=fwp_rc_slot(value);return !slot||!*slot;
}
static int channel_released(V value){
 if(fwp_reuse_verify){fwp_chan *c=(fwp_chan *)(uintptr_t)value;return !c->buf&&!c->len&&!ARR(value)->len;}
 uint8_t *slot=fwp_rc_slot(value);return !slot||!*slot;
}
int main(void){
 fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();fwp_tasks_init();
 for(int iteration=0;iteration<64;iteration++){
  V ch=fMAKE(1);if(!fwp_rc_slot(ch)||*fwp_rc_slot(ch)!=1)return 1;
  fwp_rc_dup(ch);if(fSEND(ch)!=FWP_TRUE)return 2;
  fwp_chan *c=(fwp_chan *)(uintptr_t)ch;
  if(*fwp_rc_slot(ch)!=2||c->len!=1)return 3;
  V node=c->buf[c->head];if(OBJ(node)->f[0]!=ch||*fwp_rc_slot(node)!=1)return 4;
  fwp_p_channel_close(ch);
  if(*fwp_rc_slot(ch)!=2||c->len!=1||!c->closed)return 5;
  /* Dropping the outside owner leaves exactly the queue's cycle owner. */
  fwp_channel_drop(ch);if(*fwp_rc_slot(ch)!=1||c->len!=1)return 6;
  /* Restore an outside owner, then drain through the typed source function. */
  fwp_rc_dup(ch);fwp_rc_dup(ch);V received=fRECV(ch);
  if(received==FWP_NONE||OBJ(received)->f[0]!=node||c->len||*fwp_rc_slot(ch)!=2)return 7;
  fDROP(received);if(*fwp_rc_slot(ch)!=1||!object_released(node)||!object_released(received))return 8;
  fwp_channel_drop(ch);if(!channel_released(ch))return 9;
 }
 return 0;
}
"#.replace("MAKE", &id("link-channel")).replace("SEND", &id("send-self"))
    .replace("RECV", &id("receive")).replace("DROP", &id("discard-option"));
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &exe, opt).unwrap();
        for gc in ["off", "on"] {
            for poison in ["0", "1"] {
                let out = Command::new(&exe)
                    .env("FWP_GC", gc)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison)
                    .output()
                    .unwrap();
                assert!(
                    out.status.success(),
                    "{opt}, gc={gc}, poison={poison}: {:?}: {}",
                    out.status.code(),
                    String::from_utf8_lossy(&out.stderr)
                );
            }
        }
    }
}
