//! Rebuilt nested loop records stay flattened and box with exact unwind owners.
use std::process::Command;
fn checked(command: &mut Command) -> std::process::Output {
    let out = command.output().unwrap();
    assert!(
        out.status.success(),
        "{command:?}: {:?}: {}",
        out.status.code(),
        String::from_utf8_lossy(&out.stderr)
    );
    out
}
#[test]
fn nested_loop_fields_retain_exact_owners_when_boxing_unwinds() {
    let dir = std::env::temp_dir().join(format!("fwp-nested-loop-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let src = dir.join("probe.fwp");
    let cfile = dir.join("probe.c");
    let exe = dir.join("probe");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(&src,r#"step : (I64, (String, String, I64), String) -> Step[(I64, (String, String, I64), String), (String, String, I64)]
step = if (.0 | eq 0) (.1 | Stop)
    (make { 0 = .0 | sub 1, 1 = make { 0 = .1 | .0 | concat "x", 1 = .1 | .1 | concat "y", 2 = .1 | .2 }, 2 = .2 } | Again)
main = [task.yield (), (1, ("left", "right", 17), "tail") | loop step | echo] | ignore
"#).unwrap();
    let reference = checked(
        Command::new(fwp)
            .args(["run", "--interp"])
            .arg(&src)
            .env("FWP_NO_OPT", "1"),
    );
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
    let start = emitted.find("/* loop of step :").unwrap();
    let body = &emitted[start..];
    let id = body
        .split(" int fs")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let fs_start = emitted
        .find(&format!(
            "static inline __attribute__((always_inline)) int fs{id}(V *st, V *nx, V *out) {{"
        ))
        .unwrap();
    let fs_end = fs_start + emitted[fs_start..].find("\n}\n").unwrap() + 3;
    let step = &emitted[fs_start..fs_end];
    let loop_start = emitted
        .find(&format!("static V fwp_loop{id}(V s) {{"))
        .unwrap();
    let loop_end = loop_start + emitted[loop_start..].find("\n}\n").unwrap() + 3;
    assert!(
        emitted[loop_start..loop_end].contains("V st[5]"),
        "nested record must stay as fields"
    );
    assert!(
        !step
            .split("next2:;")
            .nth(1)
            .unwrap()
            .contains("fwp_record(3"),
        "Again boxed its rebuilt inner record"
    );
    let header = emitted
        .lines()
        .find(|l| l.starts_with("static void fwp_vdrop") && l.ends_with(" {"))
        .unwrap();
    let drops = &emitted[emitted.find(header).unwrap()..];
    let state_drop = drops
        .split("case 0: ")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let record_drop = drops
        .split("case 1: ")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let probe=r#"
static volatile V first,second,word,tail,inner_box,state_box;
static jmp_buf failure;static int recover(void){return 1;}
static int dead(V v){return fwp_reuse_verify?STR(v)->len==0:*fwp_rc_slot(v)==0;}
static void drop_leaf(V v){if(fwp_rc_release_last(v))fwp_rc_free_obj(v);}
int main(void){
 fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
 for(int test=0;test<4;test++)for(int same=0;same<2;same++)for(int box_alias=0;box_alias<2;box_alias++)
 for(int inner_alias=0;inner_alias<2;inner_alias++)for(int leaf_alias=0;leaf_alias<2;leaf_alias++){
  fault=0;current_dup=0;first=fwp_rc_fresh(fwp_str_new("first",5));
  if(same){second=first;fwp_rc_dup(second);}else second=fwp_rc_fresh(fwp_str_new("other",5));
  word=fwp_rc_fresh(fwp_str_new("scalar",6));tail=fwp_rc_fresh(fwp_str_new("tail",4));
  inner_box=fwp_rc_fresh(fwp_record(3,(V[]){first,second,word}));
  state_box=fwp_rc_fresh(fwp_record(3,(V[]){0,inner_box,tail}));
  if(box_alias)fwp_rc_dup(state_box);if(inner_alias)fwp_rc_dup(inner_box);
  if(leaf_alias){fwp_rc_dup(first);fwp_rc_dup(second);}
  fault=test;fwp_trap_recover=recover;fwp_trap_jb=&failure;fwp_trap_cleanup=0;
  if(!setjmp(failure)){
   V out=LOOP(state_box);if(test)return 31;
   if(OBJ(out)->f[0]!=first||OBJ(out)->f[1]!=second||OBJ(out)->f[2]!=word)return 32;
   RECORD_DROP(out);
  }else if(!test)return 33;
  fault=0;fwp_trap_recover=0;fwp_trap_jb=0;
  if(fwp_cleanups)return 34;
  unsigned expected=((box_alias||inner_alias)+leaf_alias)*(same?2:1);
  if(expected){if(*fwp_rc_slot(first)!=expected||*fwp_rc_slot(second)!=expected||STR(first)->len!=5||STR(second)->len!=5)return 1;}
  else if(!dead(first)||!dead(second))return 2;
  if(box_alias){if(*fwp_rc_slot(tail)!=1||STR(tail)->len!=4)return 3;}
  else if(!dead(tail))return 4;
  if(*fwp_rc_slot(word)!=1||STR(word)->len!=6)return 5;
  if(box_alias)STATE_DROP(state_box);if(inner_alias)RECORD_DROP(inner_box);
  if(leaf_alias){drop_leaf(first);drop_leaf(second);}
  if(!dead(first)||!dead(second)||!dead(tail))return 6;
  drop_leaf(word);
 }
 return 0;
}
"#.replace("LOOP",&format!("fwp_loop{id}")).replace("STATE_DROP",state_drop).replace("RECORD_DROP",record_drop);
    let injected = step
        .replace(
            "fwp_rc_dup(st[1]);",
            "if (fault==1 && current_dup++==0) fwp_trap(\"nested retain\"); fwp_rc_dup(st[1]);",
        )
        .replace(
            "fwp_rc_dup(st[2]);",
            "if (fault==2) fwp_trap(\"nested retain\"); fwp_rc_dup(st[2]);",
        );
    let runtime=emitted.replacen(step,&injected,1).replace("typedef uint64_t V;","typedef uint64_t V;\nstatic int fault,current_dup; static void fwp_trap(const char *msg);")
        .replace("static V fwp_data(uint32_t tag, uint32_t n, const V *f) {","static V fwp_data(uint32_t tag, uint32_t n, const V *f) { if(fault==3 && n==3)fwp_trap(\"nested allocation\");")
        .replace("int main(int argc, char **argv)","int original_main(int argc, char **argv)");
    // These are the original state, progressive retains, and completed
    // retained children awaiting the box. Remove one scope at a time;
    // each actual fault path must then expose a leaked counted reference.
    let boxing = injected.find("fwp_rc_fresh(fwp_record(3").unwrap();
    let scopes: Vec<_> = injected[..boxing]
        .lines()
        .filter(|line| line.contains("fwp_cleanup_push("))
        .rev()
        .take(3)
        .collect();
    assert_eq!(scopes.len(), 3);
    let controls: Vec<_> = scopes
        .iter()
        .map(|line| {
            let args = line
                .split("fwp_cleanup_push(")
                .nth(1)
                .unwrap()
                .split(");")
                .next()
                .unwrap();
            let node = args.split(',').next().unwrap().trim_start_matches('&');
            let unprotected = injected
                .replace(
                    &format!("fwp_cleanup_push({args});"),
                    &format!("(void){node};"),
                )
                .replace(
                    &format!("fwp_cleanup_pop(&{node});"),
                    &format!("(void){node};"),
                );
            assert_ne!(unprotected, injected);
            runtime.replacen(&injected, &unprotected, 1)
        })
        .collect();
    for opt in ["-O1", "-O2"] {
        for control in &controls {
            fwp::cgen::compile_c(&format!("{control}\n{probe}"), &exe, opt).unwrap();
            let out = Command::new(&exe)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", "1")
                .output()
                .unwrap();
            assert_eq!(
                out.status.code(),
                Some(2),
                "missing boxing scope must leak an owner: {}",
                String::from_utf8_lossy(&out.stderr)
            );
        }

        fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            checked(
                Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison),
            );
        }
        fwp::cgen::compile_c(&emitted, &exe, opt).unwrap();
        let native = checked(
            Command::new(&exe)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", "1"),
        );
        assert_eq!(native.stdout, reference.stdout);
    }
    std::fs::remove_dir_all(dir).unwrap();
}
