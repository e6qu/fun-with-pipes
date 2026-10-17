/* Inactive words in the scanned State buffer are not roots. This does not
 * establish counted State ownership or immediate value reclamation. */
static size_t state_scans;
static V state_outer, state_error;
static unsigned state_mode;
static fwp_task state_task;
static unsigned state_task_exits, state_task_started, state_task_cancelled;
static void state_probe_task_exit(void) {
    if(fwp_state_len || !state_empty_from(0)) exit(112);
    state_task_exits++;
}
static void state_probe_scan(const char *lo, const char *hi, int root) {
    if (root || !fwp_state || lo != (const char *)fwp_state) return;
    /* Growth publishes the next capacity before realloc can collect the old
     * allocation. Check only words in the collector's actual object range. */
    size_t scanned=(size_t)(hi-lo)/sizeof(V);
    if(scanned<fwp_state_len) exit(107);
    size_t limit=scanned<fwp_state_cap?scanned:fwp_state_cap;
    state_scans++;
    for (size_t i=fwp_state_len;i<limit;i++)
        if (fwp_state[i]) exit(107);
}
static void state_collect(void) {
    size_t before=state_scans;
    fwp_gc_collect();
    if (!fwp_gc.armed || !fwp_gc.ncollect || state_scans==before) exit(108);
}
static int state_empty_from(size_t depth) {
    for(size_t i=depth;i<fwp_state_cap;i++) if(fwp_state[i]) return 0;
    return 1;
}
static V state_entry(V *args) {
    (void)args;
    if (!state_mode) return fwp_p_get();
    if (state_mode==1) { fwp_p_put(state_error); fwp_fail(state_error,0); }
    fwp_state_push(fwp_cstr("discarded inner state"));
    if (state_mode==2) fwp_trap("state restoration control");
    fwp_fail(state_error,0);
    return FWP_UNIT;
}
static const fwp_owned_fninfo state_owned={.entry=state_entry};
static const fwp_fninfo state_entries[]={{1,state_entry,"State slot probe",&state_owned}};
static fwp_clo state_callback={0,0};
static void state_task_body(void *arg,int cancelled) {
    if(cancelled) {
        if(fwp_state_len || !state_empty_from(0)) exit(112);
        state_task_cancelled++;return;
    }
    fwp_state_push(fwp_cstr("State on a real task stack"));
    if(arg) { state_task_started++;fwp_p_task_yield();exit(113); }
}
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    fwp_fns=state_entries;
    state_outer=fwp_cstr("outer alias");state_error=fwp_cstr("retained error alias");
    fwp_state_push(state_outer);fwp_state_push(state_error);
    if(fwp_state_pop()!=state_error || fwp_state_len!=1 || fwp_state[0]!=state_outer) return 106;
    /* Detect missing pop clearing before any subsequent allocation/collection. */
    if(fwp_state[1]) return 104;
    fwp_state_push(state_error);fwp_state_restore(1);
    if(fwp_state_len!=1 || fwp_state[0]!=state_outer) return 106;
    if(!state_empty_from(1)) return 105;
    state_collect();
    for(unsigned i=1;i<33;i++) fwp_state_push(fwp_cstr("grown State slot"));
    V second=fwp_state[1],third=fwp_state[2];
    fwp_state_restore(3);
    if(fwp_state_len!=3 || fwp_state[0]!=state_outer || fwp_state[1]!=second || fwp_state[2]!=third || !state_empty_from(3)) return 106;
    state_collect();FWP_KEEP_ALIVE(second);FWP_KEEP_ALIVE(third);
    fwp_state_restore(1);
    state_mode=0;
    V result=fwp_p_run_state(state_error,PTR(&state_callback),FWP_UNIT);
    if(fwp_state_len!=1 || !state_empty_from(1) || OBJ(result)->f[0]!=state_error || OBJ(result)->f[1]!=state_error) return 106;
    state_collect();FWP_KEEP_ALIVE(result);
    /* An actual typed failure passes through run-state to an outer handler. */
    state_mode=1;
    fwp_handler h;h.prev=fwp_handlers;h.state_depth=fwp_state_len;h.cleanup=fwp_cleanups;
    fwp_handlers=&h;
    if(!setjmp(h.jb)) { fwp_p_run_state(state_error,PTR(&state_callback),FWP_UNIT);return 109; }
    fwp_handlers=h.prev;
    if(h.value!=state_error || fwp_state_len!=1 || fwp_state[0]!=state_outer || !state_empty_from(1)) return 109;
    state_collect();
    /* The real served-call handler restores State after trap and typed error. */
    memset(&state_task,0,sizeof state_task);fwp_cur=&state_task;
    fwp_trap_recover=g_trap_recover;
    for(state_mode=2;state_mode<4;state_mode++) {
        V out=0,error=0;const fwp_desc *desc=0;
        V args[]={FWP_UNIT};
        int outcome=g_apply_user(0,args,&out,&error,&desc);
        if(outcome!=(state_mode==2?2:1) || (state_mode==3 && error!=state_error)) return 110;
        if(fwp_state_len!=1 || fwp_state[0]!=state_outer || !state_empty_from(1) || fwp_handlers) return 110;
        if(state_mode==2 && strcmp(fwp_trap_msg,"state restoration control")) return 110;
        if(state_task.trap_jb || state_task.trap_cleanup || fwp_cleanups) return 110;
    }
    fwp_cur=0;fwp_trap_recover=0;fwp_trap_jb=0;fwp_trap_cleanup=0;
    state_collect();
    if(strcmp(STR(state_outer)->d,"outer alias") || strcmp(STR(state_error)->d,"retained error alias")) return 111;
    /* Real scheduler entry/exit, including the C callback cancellation arm. */
    fwp_tasks_init();
    fwp_task *normal=fwp_spawn_task(0,state_task_body,NULL,0,0);
    fwp_await(normal);
    if(state_task_exits!=1 || fwp_state_len!=1 || fwp_state[0]!=state_outer) return 112;
    fwp_task *cancelled=fwp_spawn_task(0,state_task_body,(void *)1,0,0);
    fwp_p_task_yield();
    if(state_task_started!=1 || fwp_state_len!=1 || fwp_state[0]!=state_outer) return 113;
    fwp_cancel_tree(cancelled);fwp_await(cancelled);
    if(state_task_exits!=2 || state_task_cancelled!=1 || fwp_state_len!=1 || fwp_state[0]!=state_outer) return 113;
    fwp_state_restore(0);state_collect();
    if(fwp_state_len || !state_empty_from(0)) return 111;
    printf("State inactive slots cleared; real collections=%zu; buffer scans=%zu\n",fwp_gc.ncollect,state_scans);
    return 0;
}
