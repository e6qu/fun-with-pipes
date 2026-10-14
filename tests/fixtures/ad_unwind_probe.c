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
    V fields[4]={0,0,0,0};
    V tuple=fwp_record(4,fields);
    OBJ(tuple)->f[0]=a;OBJ(tuple)->f[1]=fwp_from_f64(1);
    OBJ(tuple)->f[2]=b;OBJ(tuple)->f[3]=fwp_from_f64(1);
    if (!setjmp(recovered)) { fwp_p_ad_push(tuple);return 31; }
    if (strcmp(fwp_trap_msg,FWP_AD_INVALID_NODE)) return 32;
    return 0;
}
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    fwp_trap_recover=recover_probe;fwp_trap_jb=&recovered;fwp_trap_cleanup=0;
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
        outputs=fwp_arr_new(2);seeds=fwp_arr_new(2);
        ARR(outputs)->d[0]=selected_base;ARR(outputs)->d[1]=selected_base+1;
        ARR(seeds)->d[0]=fwp_from_f64(2);ARR(seeds)->d[1]=fwp_from_f64(3);
        fwp_gc_collect();
        if (!fwp_gc.armed || !fwp_gc.ncollect) return 52;
        if (probe_mode==1) ARR(outputs)->d[0]=other_base;
        if (probe_mode==2) ARR(outputs)->d[0]=selected_base+2;
        tracked[0]=t->pa;tracked[1]=t->pb;tracked[2]=t->da;tracked[3]=t->db;tracked[4]=0;
        memset(released,0,sizeof(released));
        saved_current=fwp_cur;
        if (probe_mode==4) {
            memset(&cancelled_task,0,sizeof(cancelled_task));
            cancelled_task.cancelled=1;fwp_cur=&cancelled_task;
            if (!setjmp(cancelled_task.base)) { fwp_p_ad_backward(selected_base,outputs,seeds);return 34; }
            fwp_cur=saved_current;
            if (!cancelled_task.unwinding) return 35;
        } else if (!setjmp(recovered)) {
            V result=fwp_p_ad_backward(selected_base,outputs,seeds);
            if (probe_mode!=0) return 36;
            if (ARR(result)->len!=2 || fwp_f64(ARR(result)->d[0])!=2 || fwp_f64(ARR(result)->d[1])!=3) return 37;
        } else {
            const char *expected=probe_mode==1 ? FWP_AD_MIXED :
                probe_mode==2 ? FWP_AD_INVALID_NODE : "autodiff result allocation control";
            if (probe_mode==0 || strcmp(fwp_trap_msg,expected)) return 38;
        }
        if (fwp_cleanups) return 39;
        t=&fwp_tapes[(((int64_t)selected_base>>32)&0xffff)-1];
        if (t->live || t->pa || t->pb || t->da || t->db || t->len || t->cap || t->leaves) return 40;
        for (int i=0;i<4;i++) if (!tracked[i] || released[i]!=1) return 41;
        /* Output validation now precedes adjoint allocation. On these two
         * paths there must be no allocation to release; later failures still
         * own all five detached buffers. */
        if (probe_mode==1 || probe_mode==2) {
            if (tracked[4] || released[4]) return 41;
        } else if (!tracked[4] || released[4]!=1) return 41;
        if (!setjmp(recovered)) { fwp_p_ad_backward(selected_base,outputs,seeds);return 42; }
        if (strcmp(fwp_trap_msg,FWP_AD_OUTSIDE)) return 43;
        // The other computation remains live, and gets its own normal teardown.
        memset(tracked,0,sizeof(tracked));
        ARR(outputs)->len=1;ARR(outputs)->d[0]=other_base;
        int previous_mode=probe_mode;probe_mode=0;
        V result=fwp_p_ad_backward(other_base,outputs,seeds);
        probe_mode=previous_mode;
        if (ARR(result)->len!=1 || fwp_f64(ARR(result)->d[0])!=2) return 44;
    }
    before_wrap=selected_base;
    fwp_tapes[0].gen=32766;
    probe_mode=0;
    last_generation=fwp_p_ad_tape(0);
    if (((int64_t)last_generation>>48)!=32767) return 45;
    ARR(outputs)->len=0;ARR(seeds)->len=0;
    fwp_p_ad_backward(last_generation,outputs,seeds);
    selected_base=fwp_p_ad_tape(0);
    if ((((int64_t)selected_base>>32)&0xffff)==(((int64_t)last_generation>>32)&0xffff)) return 46;
    if (!setjmp(recovered)) { fwp_p_ad_backward(last_generation,outputs,seeds);return 47; }
    if (strcmp(fwp_trap_msg,FWP_AD_OUTSIDE)) return 48;
    if (!setjmp(recovered)) { fwp_p_ad_backward(before_wrap,outputs,seeds);return 49; }
    if (strcmp(fwp_trap_msg,FWP_AD_OUTSIDE)) return 50;
    fwp_p_ad_backward(selected_base,outputs,seeds);
    if (fwp_cleanups) return 51;
    fwp_trap_recover=0;fwp_trap_jb=0;
    puts("autodiff releases five detached buffers on return, trap and task cancellation");
    return 0;
}
