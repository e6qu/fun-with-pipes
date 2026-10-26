//! Counted channels own queued elements and transfer them into owned receive results.
use std::process::Command;

#[test]
fn channels_own_queues_and_transfer_received_values() {
    let dir = std::env::temp_dir().join(format!("fwp-channel-queue-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let source = dir.join("probe.fwp");
    let cfile = dir.join("probe.c");
    let exe = dir.join("probe");
    std::fs::write(&source, r#"give : String -> () -> String
give = const
fn-channel : I64 -> Channel[() -> String] ! {Async}
fn-channel = channel.make
task-channel : I64 -> Channel[Task[String]] ! {Async}
task-channel = channel.make
text-channel : I64 -> Channel[String] ! {Async}
text-channel = channel.make
word-channel : I64 -> Channel[I64] ! {Async}
word-channel = channel.make
main = [
 text-channel 2 | tap (flip channel.send ("text" | string.repeat 2)) | tap channel.close | channel.recv | echo,
 text-channel 1 | tap channel.close | channel.recv-for 0ns | echo,
 word-channel 1 | tap (flip channel.send 17) | channel.recv | echo,
 fn-channel 1 | tap (flip channel.send (give ("fn" | string.repeat 2))) | channel.recv | option.map (apply ()) | echo,
 task-channel 1 | tap (flip channel.send (task.spawn (give ("task" | string.repeat 2)))) | channel.recv | option.map task.await | echo,
] | ignore
"#).unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = Command::new(fwp)
        .args(["run", "--interp"])
        .arg(&source)
        .env("FWP_NO_OPT", "1")
        .output()
        .unwrap();
    assert!(
        reference.status.success(),
        "{}",
        String::from_utf8_lossy(&reference.stderr)
    );
    let build = Command::new(fwp)
        .args(["build", "--gc", "tracing"])
        .arg(&source)
        .args(["--emit-c", "-o"])
        .arg(&cfile)
        .output()
        .unwrap();
    assert!(
        build.status.success(),
        "{}",
        String::from_utf8_lossy(&build.stderr)
    );
    let emitted = std::fs::read_to_string(&cfile).unwrap();
    let id = |name: &str| {
        let start = emitted.find(&format!("/* {name}")).unwrap();
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
    assert!(runtime.contains("static void fwp_channel_drop("));
    let runtime=runtime.replace("static V fwp_chan_recv(",
        "static int fail_option;\nstatic V channel_option(V x){if(fail_option){fail_option=0;fwp_trap(\"allocation probe\");}return fwp_some(x); }\nstatic V fwp_chan_recv(")
        .replace("V result = fwp_some(x);", "V result = channel_option(x);")
        .replace("fwp_rc_fresh(fwp_some(x))", "fwp_rc_fresh(channel_option(x))");
    let grow = "static void fwp_chan_grow(fwp_chan *c) {";
    assert_eq!(runtime.matches(grow).count(), 1);
    let runtime = runtime.replace(grow, &format!("static int fail_grow;\n{grow}\nif(fail_grow){{fail_grow=0;fwp_trap(\"queue growth probe\");}}"));
    let probe = r#"
static jmp_buf recovered;static int recover(void){return 1;}
static V blocking_ch,blocking_value;static int send_mode,field_mode,worker_completed;
static void text_drop(V v);
static int sink_calls,sink_drops;
static int sink(void *arg,V value){if(arg!=&sink_calls||!fwp_rc_last(value))_Exit(38);sink_calls++;return 1;}
static void sink_drop(void *arg){if(arg!=&sink_calls)_Exit(39);sink_drops++;}
static void worker(void *arg,int failed){
 (void)arg;if(failed)return;
 fwp_value_owner ch_owner={blocking_ch,fwp_channel_drop};
 fwp_cleanup ch_cleanup;fwp_value_protect(&ch_owner,&ch_cleanup);
 if(send_mode){if(fSEND(blocking_ch,blocking_value)!=FWP_FALSE)fwp_trap("expected closed send");}
 else if(field_mode){if(fwp_chan_recv_owned(blocking_ch,0,fwp_rc_dup,FWP_CHANNEL_RESULT_FIELDS).tag)fwp_trap("expected closed field receive");}
 else if(fRECV(blocking_ch)!=FWP_NONE)fwp_trap("expected closed receive");
 fwp_value_finish(&ch_owner,&ch_cleanup);fwp_channel_drop(blocking_ch);worker_completed=1;
}
static int dead(V v){return fwp_reuse_verify?STR(v)->len==0:*fwp_rc_slot(v)==0;}
static void text_drop(V v){if(fwp_rc_release_last(v))fwp_rc_free_obj(v);}
static void option_drop(V v){if(v&&fwp_rc_release_last(v)){text_drop(OBJ(v)->f[0]);fwp_rc_free_obj(v);}}
int main(void){
 fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();fwp_tasks_init();
 V ch=fMAKE(32);if(*fwp_rc_slot(ch)!=1)return 1;
 V values[20];for(int i=0;i<20;i++){
  values[i]=fwp_rc_fresh(fwp_str_new("input",5));
  if(fSEND(ch,values[i])!=FWP_TRUE||*fwp_rc_slot(ch)!=1||*fwp_rc_slot(values[i])!=1)return 2;
 }
 if(((fwp_chan *)(uintptr_t)ch)->size<20)return 3;
 fCLOSE(ch);V first=fRECV(ch);
 if(first==FWP_NONE||OBJ(first)->f[0]!=values[0]||*fwp_rc_slot(values[0])!=1)return 4;
 fwp_channel_drop(ch);if(STR(OBJ(first)->f[0])->len!=5)return 5;
 for(int i=1;i<20;i++)if(!dead(values[i]))return 6;
 option_drop(first);if(!dead(values[0]))return 7;
 // Queue and external aliases are distinct owners, and closed sends retain nothing.
 ch=fMAKE(2);V value=fwp_rc_fresh(fwp_str_new("alias",5));fwp_rc_dup(value);
 fSEND(ch,value);if(*fwp_rc_slot(value)!=2)return 8;
 V received=fRECV(ch);if(*fwp_rc_slot(value)!=2)return 9;
 fCLOSE(ch);fwp_rc_dup(value);if(fSEND(ch,value)!=FWP_FALSE||*fwp_rc_slot(value)!=2)return 10;
 fwp_channel_drop(ch);option_drop(received);if(*fwp_rc_slot(value)!=1)return 11;
 text_drop(value);if(!dead(value))return 12;
 // Scalar address bits receive neither heap duplication nor destruction.
 V scalar=fwp_rc_fresh(fwp_str_new("scalar",6));ch=fWORD(1);
 if(fSENDWORD(ch,scalar)!=FWP_TRUE||*fwp_rc_slot(scalar)!=1)return 13;
 V word=fRECVWORD(ch);if(OBJ(word)->f[0]!=scalar||*fwp_rc_slot(scalar)!=1)return 14;
 fwp_rc_free_obj(word);fwp_channel_drop(ch);if(*fwp_rc_slot(scalar)!=1)return 15;text_drop(scalar);
 // Blocked send/receive calls own their borrowed handles until wait links clear.
 for(field_mode=0;field_mode<2;field_mode++)for(int mode=0;mode<4;mode++)for(int early_drop=0;early_drop<2;early_drop++){
  blocking_ch=fMAKE(1);send_mode=mode<2;worker_completed=0;
  V queued=0;if(send_mode){queued=fwp_rc_fresh(fwp_str_new("queued",6));fSEND(blocking_ch,queued);}
  blocking_value=send_mode?fwp_rc_fresh(fwp_str_new("pending",7)):0;
  fwp_rc_dup(blocking_ch);fwp_task *t=fwp_spawn_task(0,worker,0,0,0);fwp_p_task_yield();
  fwp_chan *c=(fwp_chan *)(uintptr_t)blocking_ch;
  if(*fwp_rc_slot(blocking_ch)!=2||!(send_mode?c->sendq.head:c->recvq.head))return 16;
  if(send_mode&&*fwp_rc_slot(blocking_value)!=1)return 17;
  if(early_drop)fwp_channel_drop(blocking_ch);
  if(mode%2==0)fwp_p_task_cancel(PTR(t));else fCLOSE(blocking_ch);
  if(fwp_await(t)!=FWP_NONE||t->cleanups||worker_completed!=(mode%2))return 18;
  if(send_mode&&!dead(blocking_value))return 19;
  if(!early_drop){
   if(*fwp_rc_slot(blocking_ch)!=1||c->sendq.head||c->recvq.head)return 20;
   fwp_channel_drop(blocking_ch);
  }
  if(send_mode&&!dead(queued))return 21;
 }
 // Timed receive keeps ready values ahead of the deadline and returns None when empty.
 ch=fMAKE(1);V duration=fwp_record(1,(V[]){0});
 if(fwp_p_channel_recv_for_owned(duration,ch,fwp_rc_dup)!=FWP_NONE||*fwp_rc_slot(ch)!=1)return 38;
 value=fwp_rc_fresh(fwp_str_new("timed",5));fSEND(ch,value);
 received=fwp_p_channel_recv_for_owned(duration,ch,fwp_rc_dup);
 if(OBJ(received)->f[0]!=value||*fwp_rc_slot(value)!=1)return 39;option_drop(received);fwp_channel_drop(ch);
 // Direct fields move exactly one owner, allocate no Option and distinguish Some 0.
 ch=fMAKE(1);value=fwp_rc_fresh(fwp_str_new("fields",6));fSEND(ch,value);
 fail_option=1;intptr_t before_fields=fwp_gc.budget;
 fwp_option_result fields=fwp_chan_recv_owned(ch,fwp_after(duration),fwp_rc_dup,FWP_CHANNEL_RESULT_FIELDS);
 V field=fields.value;
 if(!fields.tag||field!=value||*fwp_rc_slot(value)!=1)return 43;
 if(!fail_option||before_fields!=fwp_gc.budget||((fwp_chan *)(uintptr_t)ch)->len)return 44;
 fail_option=0;fwp_channel_drop(ch);if(STR(field)->len!=6)return 45;text_drop(field);if(!dead(value))return 46;
 ch=fWORD(1);fSENDWORD(ch,0);
 fields=fwp_chan_recv_owned(ch,0,NULL,FWP_CHANNEL_RESULT_FIELDS);
 if(!fields.tag||fields.value!=0)return 47;
 if(fwp_chan_recv_owned(ch,fwp_after(duration),NULL,FWP_CHANNEL_RESULT_FIELDS).tag)return 48;
 fCLOSE(ch);if(fwp_chan_recv_owned(ch,0,NULL,FWP_CHANNEL_RESULT_FIELDS).tag)return 49;fwp_channel_drop(ch);
 // Queue function captures and task caches retain their typed descendants.
 value=fwp_rc_fresh(fwp_str_new("function",8));V fn=fwp_rc_fresh(fwp_pap(GIVE,1,&value));
 ch=fwp_p_channel_make_owned(1,fwp_closure_drop);fwp_p_channel_send_owned(ch,fn,fwp_closure_drop);
 if(*fwp_rc_slot(fn)!=1||*fwp_rc_slot(value)!=1)return 29;
 received=fwp_p_channel_recv_owned(ch,fwp_rc_dup);V unit=FWP_UNIT;
 V text=fwp_apply_borrowed(OBJ(received)->f[0],1,&unit);if(text!=value||*fwp_rc_slot(value)!=2)return 30;
 text_drop(text);fwp_channel_drop(ch);fwp_closure_drop(OBJ(received)->f[0]);fwp_rc_free_obj(received);if(!dead(value))return 31;
 value=fwp_rc_fresh(fwp_str_new("task",4));fn=fwp_rc_fresh(fwp_pap(GIVE,1,&value));
 fwp_task *task=(fwp_task *)(uintptr_t)fwp_p_task_spawn_owned(fn,text_drop);
 ch=fwp_p_channel_make_owned(1,fwp_task_drop);fwp_p_channel_send_owned(ch,PTR(task),fwp_task_drop);fwp_tasks_finish();
 if(*fwp_rc_slot(PTR(task))!=1||*fwp_rc_slot(value)!=1)return 32;
 fwp_channel_drop(ch);if(!dead(value))return 33;
 // An old channel and buffer keep new queue elements alive through a minor GC.
 ch=fMAKE(2);value=fwp_rc_fresh(fwp_str_new("old",3));fSEND(ch,value);received=fRECV(ch);option_drop(received);
 fwp_gc_collect();fwp_gc_collect();FWP_KEEP_ALIVE(ch);
 value=fwp_rc_fresh(fwp_str_new("young",5));fSEND(ch,value);value=0;
 fwp_gc.major_next=0;size_t minors=fwp_gc.nminor;fwp_gc_collect();FWP_KEEP_ALIVE(ch);
 if(fwp_gc.nminor!=minors+1)return 34;received=fRECV(ch);if(STR(OBJ(received)->f[0])->len!=5)return 34;option_drop(received);fwp_channel_drop(ch);
 // Untyped queue channels and promoted handles keep tracing.
 for(int promoted=0;promoted<2;promoted++){
  ch=promoted?fMAKE(1):fwp_p_channel_make(1);if(promoted)fwp_rc_share(ch);
  value=fwp_rc_fresh(fwp_str_new("shared",6));fSEND(ch,value);
  received=fRECV(ch);if(*fwp_rc_slot(value)||STR(OBJ(received)->f[0])->len!=6)return 35;
  fwp_channel_drop(ch);option_drop(received);
 }
 // Native sinks borrow during the call; send releases its owner afterward.
 ch=fMAKE(1);((fwp_chan *)(uintptr_t)ch)->sink=sink;((fwp_chan *)(uintptr_t)ch)->owner.sink_drop=sink_drop;((fwp_chan *)(uintptr_t)ch)->sink_ctx=&sink_calls;
 fwp_rc_dup(ch);
 value=fwp_rc_fresh(fwp_str_new("sink",4));if(fSEND(ch,value)!=FWP_TRUE||sink_calls!=1)return 36;
 if(!dead(value))return 38;
 fwp_channel_drop(ch);if(sink_drops||*fwp_rc_slot(ch)!=1)return 39;
 fCLOSE(ch);V rejected=fwp_rc_fresh(fwp_str_new("closed",6));if(fSEND(ch,rejected)!=FWP_FALSE||!dead(rejected)||sink_calls!=1)return 37;
 fwp_channel_drop(ch);if(sink_drops!=1)return 40;
 // Moving a saturated count must not attempt an additional retain.
 ch=fMAKE(2);value=fwp_rc_fresh(fwp_str_new("overflow",8));uint8_t *slot=fwp_rc_slot(value);
 *slot=254;fwp_rc_dup(value);(*fwp_rc_wide_link(slot))->count=SIZE_MAX;
 if(fSEND(ch,value)!=FWP_TRUE||(*fwp_rc_wide_link(slot))->count!=SIZE_MAX)return 22;
 received=fRECV(ch);if(OBJ(received)->f[0]!=value||(*fwp_rc_wide_link(slot))->count!=SIZE_MAX)return 23;
 fwp_rc_forget_slot(slot);*slot=1;fwp_channel_drop(ch);option_drop(received);if(!dead(value))return 24;
 // A failed receive allocation leaves its element and queue owner intact.
 ch=fMAKE(1);value=fwp_rc_fresh(fwp_str_new("retry",5));fSEND(ch,value);
 fail_option=1;fwp_trap_recover=recover;fwp_trap_jb=&recovered;fwp_trap_cleanup=0;
 if(setjmp(recovered)==0){fRECV(ch);return 25;}
 fwp_trap_recover=0;fwp_trap_jb=0;
 if(fwp_cleanups||((fwp_chan *)(uintptr_t)ch)->len!=1||*fwp_rc_slot(value)!=1)return 26;
 received=fRECV(ch);if(OBJ(received)->f[0]!=value||*fwp_rc_slot(value)!=1)return 27;
 fwp_channel_drop(ch);option_drop(received);if(!dead(value))return 28;
 // Uncounted tracing receives also preserve the queued value on allocation failure.
 ch=fwp_p_channel_make(1);value=fwp_str_new("uncounted retry",15);fwp_p_channel_send(ch,value);
 fail_option=1;fwp_trap_recover=recover;fwp_trap_jb=&recovered;fwp_trap_cleanup=0;
 if(setjmp(recovered)==0){fwp_p_channel_recv(ch);return 50;}
 fwp_trap_recover=0;fwp_trap_jb=0;
 if(((fwp_chan *)(uintptr_t)ch)->len!=1||((fwp_chan *)(uintptr_t)ch)->buf[((fwp_chan *)(uintptr_t)ch)->head]!=value)return 51;
 received=fwp_p_channel_recv(ch);if(OBJ(received)->f[0]!=value||STR(value)->len!=15)return 52;
 fwp_p_channel_close(ch);FWP_KEEP_ALIVE(received);
 // A failed buffer allocation consumes the message but leaves the queue empty.
 ch=fMAKE(1);value=fwp_rc_fresh(fwp_str_new("growth",6));
 fail_grow=1;fwp_trap_recover=recover;fwp_trap_jb=&recovered;fwp_trap_cleanup=0;
 if(setjmp(recovered)==0){fSEND(ch,value);return 41;}
 fwp_trap_recover=0;fwp_trap_jb=0;
 if(fwp_cleanups||((fwp_chan *)(uintptr_t)ch)->len||!dead(value))return 42;
 fwp_channel_drop(ch);
 return 0;
}
"#.replace("GIVE",&id("give :"))
 .replace("SENDWORD",&id("channel.send : Channel[I64]"))
 .replace("RECVWORD",&id("channel.recv : Channel[I64]"))
 .replace("WORD",&id("channel.make : I64 -> Channel[I64]"))
 .replace("MAKE",&id("channel.make : I64 -> Channel[String]"))
 .replace("SEND",&id("channel.send : Channel[String]"))
 .replace("CLOSE",&id("channel.close : Channel[String]"))
 .replace("RECV",&id("channel.recv : Channel[String]"));
    let extra_queue_retain = runtime.replace(
        "if ((!count || !*count) && drop) fwp_rc_share(x);",
        "if (count && *count && drop) fwp_rc_dup(x); else if (drop) fwp_rc_share(x);",
    );
    let no_queue_drop = runtime.replace(
        "c->owner.queue_drop(element);",
        "/* omit queued element release */",
    );
    let no_message_cleanup = runtime.replace(
        "fwp_value_protect(&message, &message_cleanup);",
        "message.drop = NULL; /* deliberately omit pending-message cleanup */",
    );
    let extra_receive = runtime.replace(
        "V result = form == FWP_CHANNEL_RESULT_BOXED ? fwp_rc_fresh(channel_option(x)) : x;",
        "if(dup)dup(x);V result = form == FWP_CHANNEL_RESULT_BOXED ? fwp_rc_fresh(channel_option(x)) : x;",
    );
    let early_remove=runtime.replace(
        "V result = form == FWP_CHANNEL_RESULT_BOXED ? fwp_rc_fresh(channel_option(x)) : x;\n            c->buf[c->head] = 0;\n            c->head = (c->head + 1) % c->size;\n            c->len--;",
        "c->buf[c->head] = 0;\n            c->head = (c->head + 1) % c->size;\n            c->len--;\n            V result = form == FWP_CHANNEL_RESULT_BOXED ? fwp_rc_fresh(channel_option(x)) : x;");
    let sink_drop = "        c->owner.sink_drop = NULL;\n        drop(context);";
    assert_eq!(runtime.matches(sink_drop).count(), 1);
    let no_sink_drop = runtime.replacen(
        sink_drop,
        "        c->owner.sink_drop = NULL;\n        /* omit native context release */",
        1,
    );
    let traced_sink_value = runtime.replace(
        "if (!c->closed) result = c->sink(c->sink_ctx, x) ? FWP_TRUE : FWP_FALSE;",
        "if (!c->closed) { result = c->sink(c->sink_ctx, x) ? FWP_TRUE : FWP_FALSE; fwp_rc_share(x); }",
    );
    for control in [
        &extra_queue_retain,
        &no_message_cleanup,
        &no_queue_drop,
        &extra_receive,
        &early_remove,
        &no_sink_drop,
        &traced_sink_value,
    ] {
        assert_ne!(control, &runtime);
    }
    for opt in ["-O1", "-O2"] {
        for (control, code) in [
            (&extra_queue_retain, 2),
            (&no_message_cleanup, 19),
            (&no_queue_drop, 6),
            (&extra_receive, 4),
            (&early_remove, 26),
            (&no_sink_drop, 40),
            (&traced_sink_value, 38),
        ] {
            fwp::cgen::compile_c(&format!("{control}\n{probe}"), &exe, opt).unwrap();
            let out = Command::new(&exe)
                .env("FWP_REUSE_VERIFY", "1")
                .output()
                .unwrap();
            assert_eq!(out.status.code(), Some(code));
        }
        fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let out = Command::new(&exe)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", poison)
                .output()
                .unwrap();
            assert!(
                out.status.success(),
                "exit {:?}: {}",
                out.status.code(),
                String::from_utf8_lossy(&out.stderr)
            );
        }
        fwp::cgen::compile_c(&emitted, &exe, opt).unwrap();
        let out = Command::new(&exe)
            .env("FWP_GC_STRESS", "1")
            .env("FWP_GC_VERIFY", "1")
            .env("FWP_REUSE_VERIFY", "1")
            .output()
            .unwrap();
        assert_eq!(out.status.code(), reference.status.code());
        assert_eq!(out.stdout, reference.stdout);
        assert_eq!(out.stderr, reference.stderr);
    }
    std::fs::remove_dir_all(dir).unwrap();
}
