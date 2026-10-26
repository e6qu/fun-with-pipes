static unsigned typed_mode, typed_started;
static V typed_child_initial;
static unsigned typed_child_released;
static fwp_task *typed_child;
static jmp_buf typed_trap;
static int typed_recover(void) { return 1; }
static int typed_failure(int code,unsigned line) {
    fprintf(stderr,"typed State mode %u line %u: control %d; depth=%zu owner=%d cleanup=%d\n",
        typed_mode,line,code,fwp_state_len,fwp_state_owners!=NULL,fwp_cleanups!=NULL);
    return code;
}
static void typed_drop_string(V value) {
    uint8_t *count=fwp_rc_slot(value);
    int last=count && *count==1;
    double before=fwp_heap.freed;
    /* A live State slot is an additional owner, including under poisoning.
     * Detect an omitted retain before destroying or reading its payload. */
    if(last && fwp_state_len && fwp_p_get()==value) exit(typed_failure(127,__LINE__));
    DROP_STRING(value);
    if(last) {
        count=fwp_rc_slot(value);
#ifndef FWP_ARC_ONLY
        if(fwp_reuse_verify) {
            /* Verification retains the physical leaf and poisons its payload.
             * Establish that storage still exists before inspecting poison. */
            if(!count || *count!=1) exit(typed_failure(125,__LINE__));
            if(STR(value)->len || STR(value)->d[0]) exit(typed_failure(125,__LINE__));
        } else
#endif
        {
            /* Small freed slots can still have a metadata address. Require a
             * cleared count and an actual counted-storage free counter change. */
            if((count && *count) || fwp_heap.freed<=before) exit(typed_failure(125,__LINE__));
        }
        if(value==typed_child_initial) typed_child_released++;
    }
}
static void typed_no_args(V *v,uint32_t first,uint32_t n) { (void)v;(void)first;(void)n; }
static void typed_no_captures(V v,int dup) { (void)v;(void)dup; }
static void typed_pair_drop(V value) {
    if(fwp_rc_release_last(value)) {
        typed_drop_string(OBJ(value)->f[0]);typed_drop_string(OBJ(value)->f[1]);
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
#ifndef FWP_ARC_ONLY
    fwp_heap_collect();
    if(!fwp_heap.armed || !fwp_heap.ncollect) exit(typed_failure(129,__LINE__));
#endif
    if(typed_mode==1) {
        V value=fwp_rc_fresh(fwp_cstr("replacement"));
        fwp_p_put_owned(value,fwp_rc_dup);typed_drop_string(value);
        /* Detect a lost slot reference before reading its payload. */
        V stored=fwp_p_get();
        if(!fwp_rc_slot(stored) || *fwp_rc_slot(stored)!=1) exit(typed_failure(127,__LINE__));
    }
    if(typed_mode==2) fwp_fail(fwp_p_get_owned(fwp_rc_dup),0);
    if(typed_mode==3) fwp_trap("typed State callback control");
    if(typed_mode==5 && fwp_cur==typed_child) {
        typed_started=1;fwp_p_task_yield();exit(typed_failure(130,__LINE__));
    }
    if(typed_mode==5 || typed_mode==6) {
        fwp_state_owner *expected=fwp_state_owners;
        if(fwp_cur!=typed_child) {
            typed_child_released=0;typed_child=fwp_spawn_task(0,typed_child_body,NULL,0,0);
            typed_child->ownership=FWP_TASK_SHARED;
            fwp_rc_fresh(PTR(typed_child));fwp_rc_dup(PTR(typed_child));
            if(typed_mode==5) {
                fwp_p_task_yield();
                if(!typed_started) exit(typed_failure(130,__LINE__));
                fwp_cancel_tree(typed_child);
            }
            fwp_await(typed_child);
            if(typed_mode==5 && typed_child_released!=1) exit(typed_failure(125,__LINE__));
            fwp_task_drop(PTR(typed_child));fwp_free_zombie();
        } else fwp_p_task_yield();
        /* Reject a stale task-stack owner before accessing its fields. */
        if(fwp_state_owners!=expected) exit(typed_failure(128,__LINE__));
    }
    return fwp_p_get_owned(fwp_rc_dup);
}
static const fwp_owned_fninfo typed_owned={typed_entry,typed_no_captures,typed_no_args,typed_no_args};
static const fwp_fninfo typed_entries[]={{1,typed_entry,"typed State",&typed_owned}};
static fwp_clo typed_callback={0,0};
static void typed_child_body(void *arg,int cancelled) {
    (void)arg;
    if(cancelled) { if(fwp_state_owners) exit(typed_failure(125,__LINE__));return; }
    V initial=fwp_rc_fresh(fwp_cstr("child State"));
    typed_child_initial=initial;
    fwp_value_owner initial_owner={initial,typed_drop_string};
    fwp_cleanup initial_cleanup;fwp_value_protect(&initial_owner,&initial_cleanup);
    V pair=fwp_p_run_state_owned(initial,PTR(&typed_callback),FWP_UNIT,
        fwp_rc_dup,typed_drop_string,typed_drop_string);
    typed_pair_drop(pair);
    initial=fwp_value_finish(&initial_owner,&initial_cleanup);typed_drop_string(initial);
}
int main(void) {
    fwp_heap_start();fwp_fns=fwp_fn_table;fwp_init_consts();
    fwp_tasks_init();fwp_fns=typed_entries;
    size_t baseline=fwp_heap.live;
    fwp_trap_recover=typed_recover;fwp_trap_jb=&typed_trap;fwp_trap_cleanup=0;
    for(int round=0;round<32;round++) {
    typed_started=0;
    for(typed_mode=0;typed_mode<7;typed_mode++) {
        V initial=fwp_rc_fresh(fwp_cstr("initial State"));
        size_t before=fwp_heap.ncollect;
        if(typed_mode==2) {
            fwp_handler handler;handler.prev=fwp_handlers;handler.state_depth=0;handler.cleanup=fwp_cleanups;
            fwp_handlers=&handler;
            if(!setjmp(handler.jb)) {
                fwp_p_run_state_owned(initial,PTR(&typed_callback),FWP_UNIT,fwp_rc_dup,typed_drop_string,typed_drop_string);return typed_failure(131,__LINE__);
            }
            fwp_handlers=handler.prev;
            if(handler.value!=initial || !fwp_rc_slot(initial) || *fwp_rc_slot(initial)!=2) return typed_failure(125,__LINE__);
            typed_drop_string(handler.value);
        } else if(!setjmp(typed_trap)) {
            V pair=fwp_p_run_state_owned(initial,PTR(&typed_callback),FWP_UNIT,fwp_rc_dup,typed_drop_string,typed_drop_string);
            if(typed_mode==3 || typed_mode==4) return typed_failure(132,__LINE__);
            if(!fwp_rc_slot(pair) || *fwp_rc_slot(pair)!=1) return typed_failure(126,__LINE__);
            V value=OBJ(pair)->f[0];
            if(OBJ(pair)->f[1]!=value || !fwp_rc_slot(value) || *fwp_rc_slot(value)!=(typed_mode==1?2:3)) return typed_failure(120,__LINE__);
            if(strcmp(STR(value)->d,typed_mode==1?"replacement":"initial State")) return typed_failure(124,__LINE__);
            typed_pair_drop(pair);
        } else {
            const char *expected=typed_mode==3?"typed State callback control":"typed State boxing control";
            if(strcmp(fwp_trap_msg,expected)) return typed_failure(132,__LINE__);
            fwp_state_restore(0);
        }
        if(fwp_state_owners || fwp_cleanups || fwp_state_len) return typed_failure(125,__LINE__);
#ifndef FWP_ARC_ONLY
        if(fwp_heap.ncollect<=before) return typed_failure(125,__LINE__);
#else
        if(fwp_heap.ncollect!=before) return typed_failure(129,__LINE__);
#endif
        if(!fwp_rc_slot(initial) || *fwp_rc_slot(initial)!=1) return typed_failure(125,__LINE__);
        typed_drop_string(initial);
    }
    /* An address-shaped I64 in an untyped slot must not clear a real count. */
    V sentinel=fwp_rc_fresh(fwp_cstr("scalar sentinel"));
    fwp_state_push(FWP_UNIT);fwp_p_put_owned(sentinel,NULL);
    if(!fwp_rc_slot(sentinel) || *fwp_rc_slot(sentinel)!=1) return typed_failure(133,__LINE__);
    fwp_state_restore(0);typed_drop_string(sentinel);
    fwp_tasks_finish();fwp_free_zombie();
#ifdef FWP_ARC_ONLY
    if(fwp_heap.live!=baseline||fwp_heap.rc_wide_len||fwp_heap.ncollect)return 90;
#endif
    }
    fwp_trap_recover=NULL;fwp_trap_jb=NULL;fwp_fns=fwp_fn_table;
    fwp_native_tasks_finish();
#ifdef FWP_ARC_ONLY
    if(fwp_heap.live!=0||fwp_heap.rc_wide_len||fwp_heap.ncollect)return 90;
#endif
    printf("typed State ownership; collections=%zu owner=%zu cleanup=%zu task=%zu\n",
        fwp_heap.ncollect,sizeof(fwp_state_owner),sizeof(fwp_cleanup),sizeof(fwp_task));
    return 0;
}
