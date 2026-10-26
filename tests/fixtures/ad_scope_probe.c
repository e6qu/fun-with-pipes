static void *scope_tracked[9];
static unsigned scope_released[9];
static int scope_mode, scope_error;
static V scope_base, scope_inner, scope_outputs, scope_seeds;
static jmp_buf scope_recovered;
static fwp_task scope_cancelled_task;
static fwp_task *scope_saved_task;
static int scope_recover(void) { return 1; }
static void scope_probe_free(void *p) {
    for (int i=0;i<9;i++) if (p && p==scope_tracked[i]) scope_released[i]++;
    free(p);
}
static void *scope_probe_calloc(size_t n,size_t size) {
    void *p=calloc(n,size);scope_tracked[8]=p;return p;
}
static void scope_record_and_observe(V base,int offset) {
    /* Scope cleanup must own real operation buffers, not input placeholders. */
    struct { uint32_t tag,n; V fields[4]; } tuple={0,4,{base,fwp_from_f64(1),(V)(int64_t)-1,0}};
    fwp_p_ad_push(PTR(&tuple));
    fwp_tape *t=fwp_tape_of((int64_t)base>>32);
    scope_tracked[offset]=t->pa;scope_tracked[offset+1]=t->pb;
    scope_tracked[offset+2]=t->da;scope_tracked[offset+3]=t->db;
}
static fwp_clo inner_scope_callback={1,0};
static V scope_inner_entry(V *args) {
    (void)args;
    scope_inner=fwp_p_ad_tape(3);scope_record_and_observe(scope_inner,4);
    return 11;
}
static V scope_outer_entry(V *args) {
    (void)args;
    scope_base=fwp_p_ad_tape(2);scope_record_and_observe(scope_base,0);
#if FWP_ARC_ONLY
    if (fwp_heap.ncollect) scope_error=65;
#else
    fwp_heap_collect();
    if (!fwp_heap.armed || !fwp_heap.ncollect) scope_error=65;
#endif
    if (scope_mode==1) fwp_trap("gradient callback control");
    if (scope_mode==2) fwp_check_cancel();
    if (scope_mode==3) {
        ARR(scope_outputs)->d[0]=scope_base;
        fwp_rc_free_arr(fwp_rc_fresh(fwp_p_ad_backward(scope_base,scope_outputs,scope_seeds)));
        fwp_tape *t=&fwp_tapes[(((int64_t)scope_base>>32)&0xffff)-1];
        if (t->scope || t->live) scope_error=62;
    }
    if (scope_mode==4 && fwp_p_ad_scope(PTR(&inner_scope_callback), FWP_UNIT)!=11) scope_error=66;
    if (scope_mode==5) {
        scope_inner=fwp_p_ad_tape(3);scope_record_and_observe(scope_inner,4);
    }
    return 7;
}
static const fwp_fninfo scope_entries[]={
    {1,scope_outer_entry,"scope outer",0},
    {1,scope_inner_entry,"scope inner",0}
};
static fwp_clo outer_scope_callback={0,0};
int main(void) {
    fwp_heap_start();fwp_fns=fwp_fn_table;fwp_init_consts();
    size_t baseline=fwp_heap.live;
    for(unsigned round=0;round<32;round++) {
    scope_outputs=fwp_rc_fresh(fwp_arr_new(1));scope_seeds=fwp_rc_fresh(fwp_arr_new(1));
    ARR(scope_seeds)->d[0]=fwp_from_f64(1);
    fwp_fns=scope_entries;
    fwp_trap_recover=scope_recover;fwp_trap_jb=&scope_recovered;fwp_trap_cleanup=0;
    for (scope_mode=0;scope_mode<6;scope_mode++) {
        memset(scope_tracked,0,sizeof(scope_tracked));memset(scope_released,0,sizeof(scope_released));
        scope_error=0;scope_inner=0;
        if (scope_mode==2) {
            scope_saved_task=fwp_cur;memset(&scope_cancelled_task,0,sizeof(scope_cancelled_task));
            scope_cancelled_task.cancelled=1;fwp_cur=&scope_cancelled_task;
#ifdef _WIN32
            /* This synthetic task executes on the main thread stack. */
            scope_cancelled_task.ctx.top=fwp_heap.main_top;
#endif
            jmp_buf scope_cancelled_task_base; scope_cancelled_task.base = &scope_cancelled_task_base;
            if (!setjmp(scope_cancelled_task_base)) { fwp_p_ad_scope(PTR(&outer_scope_callback), FWP_UNIT);return 63; }
            scope_cancelled_task.base=NULL;fwp_cur=scope_saved_task;
            if (!scope_cancelled_task.unwinding) return 64;
        } else if (!setjmp(scope_recovered)) {
            if (fwp_p_ad_scope(PTR(&outer_scope_callback), FWP_UNIT)!=7 || scope_mode==1) return 67;
        } else if (scope_mode!=1 || strcmp(fwp_trap_msg,"gradient callback control")) return 68;
        if (scope_error) return scope_error;
        if (fwp_cleanups) return 69;
        /* Paired arrays have owning bases at even indices and borrowed
         * interior regions at odd indices, for both outer and nested tapes. */
        for (int i=0;i<4;i++) if (!scope_tracked[i] || scope_released[i]!=(i%2==0?1u:0u)) return 61;
        if (scope_mode==3 && (!scope_tracked[8] || scope_released[8]!=1)) return 70;
        if (scope_mode==4 || scope_mode==5)
            for (int i=4;i<8;i++) if (!scope_tracked[i] || scope_released[i]!=(i%2==0?1u:0u)) return 71;
        if (!setjmp(scope_recovered)) { fwp_p_ad_backward(scope_base,scope_outputs,scope_seeds);return 72; }
        if (strcmp(fwp_trap_msg,FWP_AD_OUTSIDE)) return 73;
        if (scope_inner) {
            if (!setjmp(scope_recovered)) { fwp_p_ad_backward(scope_inner,scope_outputs,scope_seeds);return 74; }
            if (strcmp(fwp_trap_msg,FWP_AD_OUTSIDE)) return 75;
        }
    }
    fwp_trap_recover=0;fwp_trap_jb=0;
    memset(scope_tracked,0,sizeof(scope_tracked));
    fwp_fns=fwp_fn_table;
    fwp_tape_scope owned_scope={-1}; fwp_cleanup owned_cleanup;
    fwp_cleanup_push(&owned_cleanup,fwp_tape_scope_release,&owned_scope);
    scope_base=fwp_p_ad_tape(1);ARR(scope_outputs)->d[0]=scope_base;
    V owned=AD_BACKWARD(scope_base,scope_outputs,scope_seeds);
    if (*fwp_rc_slot(owned)!=1 || ARR(owned)->len!=1 || fwp_f64(ARR(owned)->d[0])!=1) return 76;
    fwp_rc_free_arr(owned);
    uint8_t *remaining=fwp_rc_slot(owned);
#ifndef FWP_ARC_ONLY
    if (fwp_reuse_verify) { if (ARR(owned)->len!=0) return 77; }
    else
#endif
    if (remaining && *remaining!=0) return 77;
    fwp_cleanup_pop(&owned_cleanup);fwp_tape_scope_release(&owned_scope);
    fwp_rc_free_arr(scope_outputs);fwp_rc_free_arr(scope_seeds);
    scope_outputs=scope_seeds=0;fwp_tape_finish();
    if(fwp_tapes||fwp_ntapes||fwp_tapes_cap||fwp_tape_cached_bytes)return 78;
#ifdef FWP_ARC_ONLY
    if(fwp_heap.live!=baseline||fwp_heap.rc_wide_len)return 90;
#endif
    }
    printf("scoped autodiff releases callback tapes; tape=%zu align=%zu scope=%zu cleanup=%zu\n",
           sizeof(fwp_tape),_Alignof(fwp_tape),sizeof(fwp_tape_scope),sizeof(fwp_cleanup));
    return 0;
}
