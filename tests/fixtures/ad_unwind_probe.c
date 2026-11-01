static void *tracked[5];
static unsigned released[5];
static int probe_mode;
static jmp_buf recovered;
static fwp_task cancelled_task;
static fwp_task *saved_current;
static V selected_base, other_base, outputs, seeds, before_wrap, last_generation;
static int recover_probe(void) { return 1; }
static void probe_free(void *p) {
    for (int i=0;i<5;i++) if (p && p==tracked[i]) released[i]++;
    free(p);
}
static void *probe_calloc(size_t n, size_t size) {
    void *p=calloc(n,size);
    tracked[4]=p;
    return p;
}
static V probe_result_array(size_t n) {
    if (probe_mode==3) fwp_trap("autodiff result allocation control");
    if (probe_mode==4) fwp_check_cancel();
    return fwp_arr_new(n);
}
static int invalid_push(V a, V b) {
    struct { uint32_t tag,n; V fields[4]; } value={0,4,{0,0,0,0}};
    V tuple=PTR(&value);
    OBJ(tuple)->f[0]=a;OBJ(tuple)->f[1]=fwp_from_f64(1);
    OBJ(tuple)->f[2]=b;OBJ(tuple)->f[3]=fwp_from_f64(1);
    if (!setjmp(recovered)) { fwp_p_ad_push(OBJ(tuple)->f[0], OBJ(tuple)->f[1], OBJ(tuple)->f[2], OBJ(tuple)->f[3]);return 31; }
    if (strcmp(fwp_trap_msg,FWP_AD_INVALID_NODE)) return 32;
    return 0;
}
int main(void) {
    fwp_heap_start();fwp_fns=fwp_fn_table;fwp_init_consts();
    /* Static storage keeps the changing scope head defined after longjmp. */
    static fwp_tape_scope scope={-1};static fwp_cleanup scope_owner;
    fwp_cleanup_push(&scope_owner,fwp_tape_scope_release,&scope);
    fwp_trap_recover=recover_probe;fwp_trap_jb=&recovered;fwp_trap_cleanup=&scope_owner;
    size_t baseline=fwp_heap.live;
    for (unsigned round=0;round<32;round++) {
    for (probe_mode=0;probe_mode<5;probe_mode++) {
        selected_base=fwp_p_ad_tape(2);
        other_base=fwp_p_ad_tape(1);
        int code=invalid_push(selected_base+2,(V)(int64_t)-1);
        if (code) return code;
        code=invalid_push(selected_base,selected_base+2);
        if (code) return code;
        code=invalid_push((V)(int64_t)-1,selected_base+2);
        if (code) return code;
        fwp_tape *t=fwp_tape_of((int64_t)selected_base>>32);
        if (t->len!=2 || !t->live) return 33;
        /* Record a real operation so unwind still owns all metadata buffers. */
        struct { uint32_t tag,n; V fields[4]; } value={0,4,{selected_base,fwp_from_f64(1),(V)(int64_t)-1,0}};
        V recorded=fwp_p_ad_push(OBJ(PTR(&value))->f[0], OBJ(PTR(&value))->f[1], OBJ(PTR(&value))->f[2], OBJ(PTR(&value))->f[3]);
        /* The tape must own copied scalars, never the caller's record. Seed
         * the recorded node after overwriting every input field. */
        memset(&value,0,sizeof(value));
        outputs=fwp_rc_fresh(fwp_arr_new(2));seeds=fwp_rc_fresh(fwp_arr_new(2));
        ARR(outputs)->d[0]=recorded;ARR(outputs)->d[1]=selected_base+1;
        ARR(seeds)->d[0]=fwp_from_f64(2);ARR(seeds)->d[1]=fwp_from_f64(3);
        if (probe_mode==1) ARR(outputs)->d[0]=other_base;
        if (probe_mode==2) ARR(outputs)->d[0]=selected_base+3;
        tracked[0]=t->pa;tracked[1]=t->pb;tracked[2]=t->da;tracked[3]=t->db;tracked[4]=0;
        memset(released,0,sizeof(released));
        saved_current=fwp_cur;
        if (probe_mode==4) {
            memset(&cancelled_task,0,sizeof(cancelled_task));
            cancelled_task.cancelled=1;fwp_cur=&cancelled_task;
            /* The injected task has its own cleanup chain. The caller keeps
             * the scope containing the independent other computation. */
            fwp_cleanups=NULL;
            jmp_buf cancelled_task_base; cancelled_task.base = &cancelled_task_base;
            if (!setjmp(cancelled_task_base)) { fwp_p_ad_backward(selected_base,outputs,seeds);return 34; }
            cancelled_task.base=NULL;fwp_cur=saved_current;fwp_cleanups=&scope_owner;
            if (!cancelled_task.unwinding) return 35;
        } else if (!setjmp(recovered)) {
            V result=fwp_rc_fresh(fwp_p_ad_backward(selected_base,outputs,seeds));
            if (probe_mode!=0) return 36;
            if (ARR(result)->len!=2 || fwp_f64(ARR(result)->d[0])!=2 || fwp_f64(ARR(result)->d[1])!=3) return 37;
            fwp_rc_free_arr(result);
        } else {
            const char *expected=probe_mode==1 ? FWP_AD_MIXED :
                probe_mode==2 ? FWP_AD_INVALID_NODE : "autodiff result allocation control";
            if (probe_mode==0 || strcmp(fwp_trap_msg,expected)) return 38;
        }
        if (fwp_cleanups!=&scope_owner) return 39;
        t=&fwp_tapes[(((int64_t)selected_base>>32)&0xffff)-1];
        if (t->live || t->pa || t->pb || t->da || t->db || t->len || t->cap || t->leaves) return 40;
        /* Each pair has one owning base; its interior region is never freed. */
        for (int i=0;i<4;i++) if (!tracked[i] || released[i]!=(i%2==0?1u:0u)) return 41;
        /* Output validation now precedes adjoint allocation. On these two
         * paths there must be no allocation to release; later failures still
         * own both metadata pairs and the adjoint buffer. */
        if (probe_mode==1 || probe_mode==2) {
            if (tracked[4] || released[4]) return 41;
        } else if (!tracked[4] || released[4]!=1) return 41;
        if (!setjmp(recovered)) { fwp_p_ad_backward(selected_base,outputs,seeds);return 42; }
        if (strcmp(fwp_trap_msg,FWP_AD_OUTSIDE)) return 43;
        // The other computation remains live, and gets its own normal teardown.
        memset(tracked,0,sizeof(tracked));
        ARR(outputs)->len=1;ARR(outputs)->d[0]=other_base;
        int previous_mode=probe_mode;probe_mode=0;
        V result=fwp_rc_fresh(fwp_p_ad_backward(other_base,outputs,seeds));
        probe_mode=previous_mode;
        if (ARR(result)->len!=1 || fwp_f64(ARR(result)->d[0])!=2) return 44;
        fwp_rc_free_arr(result);fwp_rc_free_arr(outputs);fwp_rc_free_arr(seeds);
        outputs=seeds=0;
        if(fwp_heap.live!=baseline||fwp_heap.rc_wide_len)return 90;
    }
    }
    outputs=fwp_rc_fresh(fwp_arr_new(0));seeds=fwp_rc_fresh(fwp_arr_new(0));
    before_wrap=selected_base;
    fwp_tapes[0].gen=32766;
    probe_mode=0;
    last_generation=fwp_p_ad_tape(0);
    if (((int64_t)last_generation>>48)!=32767) return 45;
    ARR(outputs)->len=0;ARR(seeds)->len=0;
    fwp_rc_free_arr(fwp_rc_fresh(fwp_p_ad_backward(last_generation,outputs,seeds)));
    selected_base=fwp_p_ad_tape(0);
    if ((((int64_t)selected_base>>32)&0xffff)==(((int64_t)last_generation>>32)&0xffff)) return 46;
    if (!setjmp(recovered)) { fwp_p_ad_backward(last_generation,outputs,seeds);return 47; }
    if (strcmp(fwp_trap_msg,FWP_AD_OUTSIDE)) return 48;
    if (!setjmp(recovered)) { fwp_p_ad_backward(before_wrap,outputs,seeds);return 49; }
    if (strcmp(fwp_trap_msg,FWP_AD_OUTSIDE)) return 50;
    fwp_rc_free_arr(fwp_rc_fresh(fwp_p_ad_backward(selected_base,outputs,seeds)));
    fwp_rc_free_arr(outputs);fwp_rc_free_arr(seeds);outputs=seeds=0;
    memset(tracked,0,sizeof(tracked));
    if(scope.head!=-1||fwp_cleanups!=&scope_owner)return 54;
    fwp_cleanup_pop(&scope_owner);fwp_tape_scope_release(&scope);
    fwp_trap_cleanup=NULL;fwp_tape_finish();
    if(fwp_tapes||fwp_ntapes||fwp_tapes_cap||fwp_tape_cached_bytes)return 53;
    if(fwp_heap.live!=baseline||fwp_heap.rc_wide_len)return 90;
    if (fwp_cleanups) return 51;
    fwp_trap_recover=0;fwp_trap_jb=0;
    puts("autodiff releases allocated detached buffers on return, trap and task cancellation");
    return 0;
}
