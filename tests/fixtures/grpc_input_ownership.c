/* Test a typed input cursor and real sender publication/teardown. The callback
 * hook controls next/encode order and traps; complete fwp clients separately
 * exercise compiler-generated iterator and closure destructors. */
static int stage,created,dropped,advanced,encoded,parked;
static double input_charge(void) {
    return fwp_gc.total_alloc+(double)(fwp_gc.budget_given-fwp_gc.budget);
}
static V input_node(const char *text) {
    V string=fwp_rc_fresh(fwp_str_new(text,strlen(text)));
    V node=fwp_rc_fresh(fwp_data(1,2,(V[]){string,FWP_UNIT}));
    created++;
    return node;
}
static void input_drop(V node) {
    if(!fwp_rc_release_last(node))return;
    if(fwp_tag(node)!=1||!fwp_rc_last(OBJ(node)->f[0]))_Exit(224);
    fwp_rc_resource_free_obj(OBJ(node)->f[0]);
    fwp_rc_resource_free_obj(node);
    dropped++;
}
static V probe_next(V node) {
    if(fwp_tag(node)!=1||!fwp_rc_last(OBJ(node)->f[0]))_Exit(225);
    advanced++;
    if(stage==2)fwp_trap("input continuation failed");
    if(advanced==1)return input_node("second");
    if(advanced!=2)_Exit(226);
    return 0;
}
static void probe_encode(V value,h2_buf *buffer) {
    encoded++;
    if(advanced!=encoded||strcmp(STR(value)->d,encoded==1?"first":"second"))_Exit(227);
    h2b_put(buffer,"input",5);
    if(stage==3)fwp_trap("input encoding failed");
    if(stage==4){parked=1;fwp_park(0,fwp_now_ns()+10000000000LL);fwp_check_cancel();}
}
int main(int argc,char **argv) {
    if(argc!=2)_Exit(200);stage=atoi(argv[1]);if(stage<0||stage>6)_Exit(200);
    fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));fwp_tasks_init();
    fwp_trap_recover=g_trap_recover;
    double before=input_charge();
    g_conn *c=g_conn_new(FWP_INVALID_SOCKET,"input-owner-test",0);fwp_rc_fresh(PTR(c));
    g_stream *s=g_stream_new(c,1);fwp_rc_fresh(PTR(s));fwp_rc_dup(PTR(s));s->sent_headers=1;
    static const fwp_remote remote={.input_drop=input_drop};
    V original=input_node("first");
    if(stage==6){
        uint8_t *slot=fwp_rc_slot(original);*slot=254;fwp_rc_dup(original);
        (*fwp_rc_wide_link(slot))->count=SIZE_MAX;
        jmp_buf failed;fwp_cur->trap_jb=&failed;fwp_cur->trap_cleanup=fwp_cleanups;
        if(!setjmp(failed)){g_spawn_sender(c,s,original,&remote);_Exit(237);}
        fwp_cur->trap_jb=0;fwp_cur->trap_cleanup=0;fwp_trap_jb=0;fwp_trap_cleanup=0;
        if(strcmp(fwp_trap_msg,"reference count overflow")||probe_task||fwp_gc_tasks||fwp_cleanups||dropped)_Exit(238);
        if(*slot!=255||(*fwp_rc_wide_link(slot))->count!=SIZE_MAX)_Exit(239);
        fwp_rc_forget_slot(slot);*slot=1;input_drop(original);
        if(*fwp_rc_slot(PTR(s))!=2||*fwp_rc_slot(PTR(c))!=1)_Exit(240);
        g_unlink(c,s);g_stream_drop(s);g_conn_drop(c);
        if(dropped!=created)_Exit(221);
        if(!fwp_gc.enabled&&!fwp_reuse_verify&&input_charge()!=before)_Exit(222);
        fwp_lib_finish();return 0;
    }
    if(stage==1)fwp_rc_dup(original); /* separately retained original iterator */
    g_spawn_sender(c,s,original,&remote);
    if(*fwp_rc_slot(original)!=(stage==1?3:2))_Exit(223);
    input_drop(original); /* caller gives up its borrowed-call argument */
    fwp_task *task=probe_task;
    if(!task)_Exit(228);
    if(stage==5)fwp_cancel_tree(task);
    if(stage==4){
        int64_t wait=fwp_now_ns()+10000000000LL;
        while(!parked){if(fwp_now_ns()>=wait)_Exit(229);fwp_park(0,fwp_now_ns()+1000000LL);}
        fwp_cancel_tree(task);
    }
    int64_t deadline=fwp_now_ns()+10000000000LL;
    while(fwp_gc_tasks){
        if(fwp_now_ns()>=deadline)_Exit(230);
        fwp_park(0,fwp_now_ns()+1000000LL);fwp_free_zombie();
    }
    fwp_free_zombie(); /* task and its sender record can now be freed */
    if(stage==1){
        if(*fwp_rc_slot(original)!=1||strcmp(STR(OBJ(original)->f[0])->d,"first"))_Exit(231);
        input_drop(original);
    }
    if(dropped!=created)_Exit(221);
    if(stage==0||stage==1){if(advanced!=2||encoded!=2||!s->local_end||s->reset)_Exit(232);}
    if(stage==2&&(!s->reset||strcmp(s->reset,"trap: input continuation failed")||encoded))_Exit(233);
    if(stage==3&&(!s->reset||strcmp(s->reset,"trap: input encoding failed")||encoded!=1))_Exit(234);
    if(stage==5&&(advanced||encoded))_Exit(235);
    /* Reset requests have already released their active-list owner. */
    if(*fwp_rc_slot(PTR(s))!=1+s->listed||*fwp_rc_slot(PTR(c))!=1||fwp_cleanups)_Exit(236);
    g_unlink(c,s);g_stream_drop(s);g_conn_drop(c);
    if(!fwp_gc.enabled&&!fwp_reuse_verify&&input_charge()!=before)_Exit(222);
    fwp_lib_finish();return 0;
}
