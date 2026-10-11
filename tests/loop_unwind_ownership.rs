//! Current loop state and owned Step cleanup on cancellation.
use std::path::PathBuf;
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let out = command.output().unwrap();
    assert!(
        out.status.success(),
        "{command:?}: status {:?}: {}",
        out.status.code(),
        String::from_utf8_lossy(&out.stderr)
    );
    out
}
struct Scratch(PathBuf);
impl Scratch {
    fn new(name: &str) -> Self {
        let p = std::env::temp_dir().join(format!("fwp-loop-unwind-{}-{name}", std::process::id()));
        std::fs::create_dir_all(&p).unwrap();
        Self(p)
    }
}
impl Drop for Scratch {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}

const SOURCE: &str = r#"record-step : (I64, String) -> Step[(I64, String), String]
record-step = if (.0 | eq 0) (.1 | Stop)
    (make { 0 = .0 | sub 1, 1 = .1 | concat "!" } | Again)
nested-step : (I64, (String, String)) -> Step[(I64, (String, String)), (String, String)]
nested-step = if (.0 | eq 0) (.1 | Stop)
    (make { 0 = .0 | sub 1, 1 = .1 | both (.0 | concat "x") (.1 | concat "y") } | Again)
captured-step : String -> (I64, String) -> Step[(I64, String), String]
captured-step = curry (if (.1 | .0 | eq 0) (.1 | .1 | Stop)
    (make { 0 = .1 | .0 | sub 1, 1 = fork concat .0 (.1 | .1) } | Again))
direct : (I64, String) -> String
direct = loop record-step
nested : (I64, (String, String)) -> (String, String)
nested = loop nested-step
generic : (I64, String) -> String
generic = loop Again
choose : Bool -> ((I64, String) -> String)
choose = if id (const generic) (const direct)
dynamic : ((I64, String) -> Step[(I64, String), String]) -> (I64, String) -> String
dynamic = loop
captured : String -> (I64, String) -> String
captured = captured-step | loop
choose-dynamic : Bool -> (((I64, String) -> Step[(I64, String), String]) -> (I64, String) -> String)
choose-dynamic = if id (const dynamic) (const (const direct))
choose-captured : Bool -> (String -> (I64, String) -> String)
choose-captured = if id (const captured) (const (const direct))
main = [task.yield (),
    (1, "seed") | direct | echo,
    (1, ("left", "right")) | nested | echo,
    (1, "seed") | choose-dynamic (read-all () | string.length | eq 0) record-step | echo,
    (1, "seed") | choose-captured (read-all () | string.length | eq 0) ("cap" | concat "!") | echo,
    (1, "seed") | choose (read-all () | string.length | gt 0) | echo,
] | ignore
"#;
fn function_id<'a>(emitted: &'a str, name: &str) -> &'a str {
    let start = emitted
        .find(&format!("/* {name} :"))
        .unwrap_or_else(|| panic!("missing emitted function {name}"));
    emitted[start..]
        .split("static V f")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap()
}
fn loop_scope(emitted: &str, id: &str) -> (String, usize) {
    let start = emitted
        .find(&format!("static V fwp_loop{id}(V s) {{"))
        .unwrap();
    let body = &emitted[start..];
    let slots = body
        .split("V st[")
        .nth(1)
        .unwrap()
        .split(']')
        .next()
        .unwrap()
        .parse()
        .unwrap();
    let scope = body
        .split("fwp_cleanup_push(&state_cleanup, fwp_owner_release")
        .nth(1)
        .unwrap()
        .split(',')
        .next()
        .unwrap()
        .to_string();
    (scope, slots)
}
#[test]
fn current_loop_states_release_at_first_and_later_cancellation_ticks() {
    let dir = Scratch::new("ticks");
    let src = dir.0.join("ticks.fwp");
    let cfile = dir.0.join("ticks.c");
    let exe = dir.0.join("ticks");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(&src, SOURCE).unwrap();
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src),
    );
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
    let step = function_id(&emitted, "record-step");
    let nested = function_id(&emitted, "nested-step");
    let (step_scope, step_slots) = loop_scope(&emitted, step);
    let (nested_scope, nested_slots) = loop_scope(&emitted, nested);
    let step_read = match step_slots {
        1 => "text=OBJ(((fwp_owner_ctxSCOPE *)fwp_cleanups->arg)->v0)->f[1];",
        2 => "text=((fwp_owner_ctxSCOPE *)fwp_cleanups->arg)->v0;",
        _ => panic!("unexpected record state width {step_slots}"),
    };
    let nested_read = match nested_slots {
        1 => "V pair=OBJ(((fwp_owner_ctxNSCOPE *)fwp_cleanups->arg)->v0)->f[1]; text=OBJ(pair)->f[0]; other=OBJ(pair)->f[1];",
        2 => "V pair=((fwp_owner_ctxNSCOPE *)fwp_cleanups->arg)->v0; text=OBJ(pair)->f[0]; other=OBJ(pair)->f[1];",
        3 => "text=((fwp_owner_ctxNSCOPE *)fwp_cleanups->arg)->v0; other=((fwp_owner_ctxNSCOPE *)fwp_cleanups->arg)->v1;",
        _ => panic!("unexpected nested state width {nested_slots}"),
    };
    assert!(
        emitted.contains(&format!(
            "typedef struct {{ V v0; V v1; }} fwp_owner_ctx{nested_scope};"
        )),
        "nested state must own its flattened String fields directly"
    );
    let probe=r#"
static fwp_task cancelled_loop;
static volatile V original_text, state_box, capture, scalar_word, observed_text, observed_other;
static int wanted_tick, current_tick;
static int dead_string(V v) { return fwp_reuse_verify ? STR(v)->len==0 : *fwp_rc_slot(v)==0; }
static void cancel_at_loop_tick(void) {
    if (!fwp_cur || !fwp_cleanups) return;
    V text=0, other=0;
    if (fwp_cleanups->release==fwp_value_release) {
        fwp_value_owner *owner=fwp_cleanups->arg;
        if (!owner->value) return;
        text=OBJ(owner->value)->f[1];
    } else if (fwp_cleanups->release==fwp_owner_releaseSCOPE) {
        READ_RECORD_OWNER
    } else if (fwp_cleanups->release==fwp_owner_releaseNSCOPE) {
        READ_NESTED_OWNER
    } else return;
    if (++current_tick!=wanted_tick) return;
    observed_text=text;observed_other=other;fwp_cur->cancelled=1;fwp_budget=0;
}
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    for (volatile int tick=1;tick<=2;tick++) for (volatile int mode=0;mode<5;mode++) {
        original_text=fwp_rc_fresh(fwp_str_new("seed",4));fwp_rc_dup(original_text);
        scalar_word=fwp_rc_fresh(fwp_str_new("scalar bits",11));
        capture=fwp_rc_fresh(fwp_str_new("cap",3));
        V payload=original_text;
        if (mode==4) { fwp_rc_dup(original_text);payload=fwp_rc_fresh(fwp_data(0,2,(V[]){original_text,original_text})); }
        state_box=fwp_rc_fresh(fwp_data(0,2,(V[]){scalar_word,payload}));
        wanted_tick=tick;current_tick=0;observed_text=0;observed_other=0;
        memset(&cancelled_loop,0,sizeof cancelled_loop);fwp_cur=&cancelled_loop;fwp_budget=1000000;
        if (!setjmp(cancelled_loop.base)) {
            if (mode==0) fwp_loopSTEP(state_box);
            else if (mode==1) fGENERIC(state_box);
            else if (mode==2) fDYNAMIC(PTR(&fcSTEP),state_box);
            else if (mode==3) fCAPTURED(capture,state_box);
            else fwp_loopNESTED(state_box);
            return 1;
        }
        fwp_cur=NULL;
        if (!cancelled_loop.unwinding || fwp_cleanups || current_tick!=tick || !observed_text) return 2;
        if (*fwp_rc_slot(original_text)!=1 || STR(original_text)->len!=4 || memcmp(STR(original_text)->d,"seed",4)) return 3;
        if (observed_text!=original_text && !dead_string(observed_text)) return 4;
        if (observed_other && observed_other!=original_text && !dead_string(observed_other)) return 5;
        if (*fwp_rc_slot(scalar_word)!=1 || STR(scalar_word)->len!=11) return 6;
        if (mode==3) { if (!dead_string(capture)) return 7; } else fwp_rc_free_obj(capture);
        fwp_rc_free_obj(original_text);fwp_rc_free_obj(scalar_word);
    }
    puts("loop states release at cancellation ticks with aliases and scalar bits intact");
    return 0;
}
"#.replace("READ_RECORD_OWNER",step_read).replace("READ_NESTED_OWNER",nested_read).replace("NSCOPE",&nested_scope).replace("SCOPE",&step_scope).replace("NESTED",nested).replace("STEP",step).replace("GENERIC",function_id(&emitted,"generic")).replace("DYNAMIC",function_id(&emitted,"dynamic")).replace("CAPTURED",function_id(&emitted,"captured"));
    let runtime = "static void cancel_at_loop_tick(void);\n".to_string()
        + &emitted
            .replace("FWP_TICK();", "cancel_at_loop_tick(); FWP_TICK();")
            .replace(
                "int main(int argc, char **argv)",
                "int original_main(int argc, char **argv)",
            );
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let out = checked(
                Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison),
            );
            assert_eq!(
                out.stdout,
                b"loop states release at cancellation ticks with aliases and scalar bits intact\n"
            );
        }
        checked(
            Command::new(fwp)
                .arg("build")
                .arg(&src)
                .args([opt, "-o"])
                .arg(&exe),
        );
        let out = checked(
            Command::new(&exe)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", "1"),
        );
        assert_eq!(out.stdout, reference.stdout);
    }
}

#[test]
fn owned_steps_release_if_payload_preparation_fails() {
    let dir = Scratch::new("payload");
    let src = dir.0.join("payload.fwp");
    let cfile = dir.0.join("payload.c");
    let exe = dir.0.join("payload");
    std::fs::write(&src, SOURCE).unwrap();
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
    let drop_step = emitted
        .split("return fwp_p_loop_own(l0, l1,")
        .nth(1)
        .unwrap()
        .split(',')
        .nth(2)
        .unwrap()
        .trim();
    let probe = r#"
static volatile V original_text, scalar_word, owned_step;
static int recover_payload(void) { return 1; }
static void fail_duplicate(V value) { (void)value; fwp_trap("injected payload preparation failure"); }
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    for (volatile int stop=0;stop<2;stop++) for (volatile int alias=0;alias<2;alias++) {
        original_text=fwp_rc_fresh(fwp_str_new("seed",4));fwp_rc_dup(original_text);
        scalar_word=fwp_rc_fresh(fwp_str_new("scalar bits",11));
        V payload=stop ? original_text : fwp_rc_fresh(fwp_data(0,2,(V[]){scalar_word,original_text}));
        owned_step=fwp_rc_fresh(fwp_data(stop,1,&payload));
        if (alias) fwp_rc_dup(owned_step);
        fwp_handler h;
        h.prev=fwp_handlers;h.state_depth=fwp_state_len;h.cleanup=fwp_cleanups;
        fwp_handlers=&h;fwp_trap_recover=recover_payload;fwp_trap_jb=&h.jb;fwp_trap_cleanup=h.cleanup;
        if (!setjmp(h.jb)) {
            fwp_loop_payload(owned_step,stop,fail_duplicate,fail_duplicate,DROP_STEP);
            return 1;
        }
        fwp_handlers=h.prev;fwp_trap_recover=NULL;fwp_trap_jb=NULL;
        if (fwp_cleanups || *fwp_rc_slot(original_text)!=(alias ? 2 : 1)) return 2;
        if (alias) {
            if (*fwp_rc_slot(owned_step)!=1 || OBJ(owned_step)->tag!=(V)stop) return 3;
            DROP_STEP(owned_step);
        }
        if (*fwp_rc_slot(original_text)!=1 || STR(original_text)->len!=4) return 4;
        if (*fwp_rc_slot(scalar_word)!=1 || STR(scalar_word)->len!=11) return 5;
        fwp_rc_free_obj(original_text);fwp_rc_free_obj(scalar_word);
    }
    puts("owned Steps release on payload preparation failure without losing aliases");
    return 0;
}
"#.replace("DROP_STEP",drop_step);
    let runtime = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let out = checked(
                Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison),
            );
            assert_eq!(
                out.stdout,
                b"owned Steps release on payload preparation failure without losing aliases\n"
            );
        }
    }
}
