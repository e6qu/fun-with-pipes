static unsigned typed_mode, typed_started;
static V typed_child_initial;
static fwp_task *typed_child;
static jmp_buf typed_trap;
static int typed_recover(void) { return 1; }
static void typed_no_args(V *v,uint32_t first,uint32_t n) { (void)v;(void)first;(void)n; }
static void typed_no_captures(V v,int dup) { (void)v;(void)dup; }
static void typed_pair_drop(V value) {
    if(fwp_rc_release_last(value)) {
        DROP_STRING(OBJ(value)->f[0]);DROP_STRING(OBJ(value)->f[1]);
        fwp_rc_free_obj(value);
    }
}
static V typed_tuple(V first,V second) {
    if(typed_mode==4) fwp_trap("typed State boxing control");
    return fwp_tuple2(first,second);
}
static void typed_child_body(void *arg,int cancelled);
static V typed_entry(V *args) {
    (void)args;
    fwp_gc_collect();
    if(!fwp_gc.armed || !fwp_gc.ncollect) exit(129);
    if(typed_mode==1) {
        V value=fwp_rc_fresh(fwp_cstr("replacement"));
        fwp_p_put_owned(value,fwp_rc_dup);DROP_STRING(value);
        /* Detect a lost slot reference before reading its payload. */
        V stored=fwp_p_get();
        if(!fwp_rc_slot(stored) || *fwp_rc_slot(stored)!=1) exit(127);
    }
    if(typed_mode==2) fwp_fail(fwp_p_get_owned(fwp_rc_dup),0);
    if(typed_mode==3) fwp_trap("typed State callback control");
    if(typed_mode==5 && fwp_cur==typed_child) {
        typed_started=1;fwp_p_task_yield();exit(130);
    }
    if(typed_mode==5 || typed_mode==6) {
        fwp_state_owner *expected=fwp_state_owners;
        if(fwp_cur!=typed_child) {
            typed_child=fwp_spawn_task(0,typed_child_body,NULL,0,0);
            if(typed_mode==5) {
                fwp_p_task_yield();
                if(!typed_started) exit(130);
                fwp_cancel_tree(typed_child);
            }
            fwp_await(typed_child);
            if(typed_mode==5 && fwp_rc_slot(typed_child_initial)) exit(125);
        } else fwp_p_task_yield();
        /* Reject a stale task-stack owner before accessing its fields. */
        if(fwp_state_owners!=expected) exit(128);
    }
    return fwp_p_get_owned(fwp_rc_dup);
}
static const fwp_owned_fninfo typed_owned={typed_entry,typed_no_captures,typed_no_args,typed_no_args};
static const fwp_fninfo typed_entries[]={{1,typed_entry,"typed State",&typed_owned}};
static fwp_clo typed_callback={0,0};
static void typed_child_body(void *arg,int cancelled) {
    (void)arg;
    if(cancelled) { if(fwp_state_owners) exit(125);return; }
    V initial=fwp_rc_fresh(fwp_cstr("child State"));
    typed_child_initial=initial;
    fwp_value_owner initial_owner={initial,DROP_STRING};
    fwp_cleanup initial_cleanup;fwp_value_protect(&initial_owner,&initial_cleanup);
    V pair=fwp_p_run_state_owned(initial,PTR(&typed_callback),FWP_UNIT,
        fwp_rc_dup,DROP_STRING,DROP_STRING);
    typed_pair_drop(pair);
    initial=fwp_value_finish(&initial_owner,&initial_cleanup);DROP_STRING(initial);
}
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    fwp_tasks_init();fwp_fns=typed_entries;
    fwp_trap_recover=typed_recover;fwp_trap_jb=&typed_trap;fwp_trap_cleanup=0;
    for(typed_mode=0;typed_mode<7;typed_mode++) {
        V initial=fwp_rc_fresh(fwp_cstr("initial State"));
        size_t before=fwp_gc.ncollect;
        if(typed_mode==2) {
            fwp_handler handler;handler.prev=fwp_handlers;handler.state_depth=0;handler.cleanup=fwp_cleanups;
            fwp_handlers=&handler;
            if(!setjmp(handler.jb)) {
                fwp_p_run_state_owned(initial,PTR(&typed_callback),FWP_UNIT,fwp_rc_dup,DROP_STRING,DROP_STRING);return 131;
            }
            fwp_handlers=handler.prev;
            if(handler.value!=initial || !fwp_rc_slot(initial) || *fwp_rc_slot(initial)!=2) return 125;
            DROP_STRING(handler.value);
        } else if(!setjmp(typed_trap)) {
            V pair=fwp_p_run_state_owned(initial,PTR(&typed_callback),FWP_UNIT,fwp_rc_dup,DROP_STRING,DROP_STRING);
            if(typed_mode==3 || typed_mode==4) return 132;
            if(!fwp_rc_slot(pair) || *fwp_rc_slot(pair)!=1) return 126;
            V value=OBJ(pair)->f[0];
            if(OBJ(pair)->f[1]!=value || !fwp_rc_slot(value) || *fwp_rc_slot(value)!=(typed_mode==1?2:3)) return 120;
            if(strcmp(STR(value)->d,typed_mode==1?"replacement":"initial State")) return 124;
            typed_pair_drop(pair);
        } else {
            const char *expected=typed_mode==3?"typed State callback control":"typed State boxing control";
            if(strcmp(fwp_trap_msg,expected)) return 132;
            fwp_state_restore(0);
        }
        if(fwp_state_owners || fwp_cleanups || fwp_state_len) return 125;
        if(fwp_gc.ncollect<=before || !fwp_rc_slot(initial) || *fwp_rc_slot(initial)!=1) return 125;
        DROP_STRING(initial);
        if(fwp_rc_slot(initial)) return 125;
    }
    /* An address-shaped I64 in an untyped slot must not clear a real count. */
    V sentinel=fwp_rc_fresh(fwp_cstr("scalar sentinel"));
    fwp_state_push(FWP_UNIT);fwp_p_put_owned(sentinel,NULL);
    if(!fwp_rc_slot(sentinel) || *fwp_rc_slot(sentinel)!=1) return 133;
    fwp_state_restore(0);DROP_STRING(sentinel);
    printf("typed State ownership; collections=%zu owner=%zu cleanup=%zu task=%zu\n",
        fwp_gc.ncollect,sizeof(fwp_state_owner),sizeof(fwp_cleanup),sizeof(fwp_task));
    return 0;
}
