static struct {void *pointer;size_t bytes;} workspace_allocations[64];
static uint64_t workspace_calls,workspace_requested;
static size_t workspace_live,workspace_peak;
static V workspace_outputs,workspace_seeds,workspace_node,workspace_base,workspace_inner;
static int workspace_mode;
static fwp_tape_scope workspace_direct_scope={-1};
static fwp_cleanup workspace_direct_cleanup;
static jmp_buf workspace_recovered;
static fwp_task workspace_cancelled;
static fwp_task *workspace_saved_task;
static int workspace_recover(void){return 1;}
static void *workspace_realloc(void *old,size_t bytes) {
    size_t slot=0;
    if(old){while(slot<64 && workspace_allocations[slot].pointer!=old)slot++;}
    else {while(slot<64 && workspace_allocations[slot].pointer)slot++;}
    if(slot==64)abort();
    void *next=realloc(old,bytes?bytes:1);if(!next)abort();
    workspace_calls++;workspace_requested+=bytes;
    workspace_live-=workspace_allocations[slot].bytes;workspace_live+=bytes;
    workspace_allocations[slot].pointer=next;workspace_allocations[slot].bytes=bytes;
    if(workspace_live>workspace_peak)workspace_peak=workspace_live;
    return next;
}
static void *workspace_calloc(size_t n,size_t bytes){
    if(n && bytes>SIZE_MAX/n)abort();size_t total=n*bytes;
    void *p=workspace_realloc(0,total);memset(p,0,total);return p;
}
static void workspace_free(void *p){
    if(!p)return;size_t slot=0;while(slot<64 && workspace_allocations[slot].pointer!=p)slot++;
    if(slot==64)abort();workspace_live-=workspace_allocations[slot].bytes;
    memset(&workspace_allocations[slot],0,sizeof(workspace_allocations[slot]));free(p);
}
static V workspace_result_array(size_t n){
    if(workspace_mode==1)fwp_trap("workspace result allocation control");
    if(workspace_mode==2)fwp_check_cancel();
    if(workspace_mode==3){workspace_mode=0;workspace_inner=fwp_p_ad_tape(3);}
    return fwp_arr_new(n);
}
static int workspace_dead(V base){
    fwp_cleanup *saved=fwp_trap_cleanup;fwp_trap_cleanup=fwp_cleanups;
    if(!setjmp(workspace_recovered)){
        fwp_tape_of((int64_t)base>>32);fwp_trap_cleanup=saved;return 0;
    }
    fwp_trap_cleanup=saved;return !strcmp(fwp_trap_msg,FWP_AD_OUTSIDE);
}
static uint64_t workspace_gradient(size_t n){
    const fwp_desc number={.kind=K_F64};const fwp_desc index={.kind=K_I64};
    workspace_outputs=fwp_rc_fresh(fwp_array_new_packed(n,&index));
    workspace_seeds=fwp_rc_fresh(fwp_array_new_packed(n,&number));
    V fields[4]={0,0,(V)(int64_t)-1,0};workspace_node=fwp_rc_fresh(fwp_record(4,fields));
    uint64_t calls=workspace_calls,requested=workspace_requested;
    uint64_t managed=measured_calls,managed_bytes=measured_bytes;
    workspace_base=fwp_p_ad_tape((V)n);
    for(size_t i=0;i<n;i++){
        double x=((double)(int)(i%17)-8.0)/4.0;
        OBJ(workspace_node)->f[0]=workspace_base+(V)i;
        OBJ(workspace_node)->f[1]=fwp_from_f64(2.0*x);
        V node=fwp_p_ad_push(workspace_node);
        fwp_array_store(workspace_outputs,i,node,&index);
        fwp_array_store(workspace_seeds,i,fwp_from_f64(1.0),&number);
    }
    V result=fwp_rc_fresh(fwp_p_ad_backward(workspace_base,workspace_outputs,workspace_seeds));
    calls=workspace_calls-calls;requested=workspace_requested-requested;
    managed=measured_calls-managed;managed_bytes=measured_bytes-managed_bytes;
    uint64_t hash=1469598103934665603ULL;
    for(size_t i=0;i<n;i++){
        double x=((double)(int)(i%17)-8.0)/4.0;
        V bits=fwp_array_load(result,i,&number);
        if(bits!=fwp_from_f64(0.0+1.0*(2.0*x)))exit(191);
        hash=(hash^bits)*1099511628211ULL;
    }
    if(managed!=1 || managed_bytes!=8+n*8)exit(192);
    if(workspace_mode==4 && fwp_tape_workspace_enabled() && calls)exit(193);
    if(!fwp_tape_workspace_enabled() && n && !calls)exit(194);
    if(fwp_tape_cached_bytes>FWP_AD_WORKSPACE_BUDGET)exit(195);
    printf("{\"leaves\":%zu,\"nativeCalls\":%llu,\"nativeRequestedBytes\":%llu,\"nativeLiveBytes\":%zu,\"nativePeakBytes\":%zu,\"cachedBytes\":%zu,\"managedCalls\":%llu,\"managedRequestedBytes\":%llu,\"gradientHash\":\"%016llx\"}",n,(unsigned long long)calls,(unsigned long long)requested,workspace_live,workspace_peak,fwp_tape_cached_bytes,(unsigned long long)managed,(unsigned long long)managed_bytes,(unsigned long long)hash);
    fwp_rc_free_arr(result);fwp_rc_free_arr(workspace_outputs);fwp_rc_free_arr(workspace_seeds);fwp_rc_free_obj(workspace_node);
    return hash;
}
static fwp_clo workspace_callback={0,0},workspace_nested_callback={1,0};
static V workspace_nested_base;
static V workspace_nested_entry(V *args){
    (void)args;workspace_nested_base=fwp_p_ad_tape(7);return FWP_UNIT;
}
static V workspace_scope_entry(V *args){
    (void)args;workspace_base=fwp_p_ad_tape(5);
    if(workspace_mode==5)return FWP_UNIT;
    if(workspace_mode==7){
        fwp_p_ad_scope(PTR(&workspace_nested_callback),FWP_UNIT);
        if(!workspace_dead(workspace_nested_base)){
            int64_t id=(int64_t)workspace_nested_base>>32;size_t slot=(size_t)((id&0xffff)-1);
            fprintf(stderr,"nested tape token=%lld slot=%zu live=%d generation=%u scope=%p\n",(long long)workspace_nested_base,slot,fwp_tapes[slot].live,fwp_tapes[slot].gen,(void *)fwp_tapes[slot].scope);exit(207);
        }
        if(fwp_tape_of((int64_t)workspace_base>>32)->leaves!=5)exit(208);
        return FWP_UNIT;
    }
    fwp_trap("workspace scope control");return FWP_UNIT;
}
static const fwp_fninfo workspace_functions[]={
    {1,workspace_scope_entry,"workspace scope control",0},
    {1,workspace_nested_entry,"workspace nested control",0}
};
int main(void){
    fwp_heap_start();fwp_fns=fwp_fn_table;fwp_init_consts();
    size_t initial_live=fwp_heap.live;
    fwp_cleanup_push(&workspace_direct_cleanup,fwp_tape_scope_release,&workspace_direct_scope);
    fwp_trap_recover=workspace_recover;fwp_trap_jb=&workspace_recovered;fwp_trap_cleanup=&workspace_direct_cleanup;
    puts("{\"profiles\":[");
    workspace_mode=0;workspace_gradient(129);puts(",");
    workspace_mode=4;workspace_gradient(129);puts(",");
    workspace_mode=0;workspace_gradient(257);puts(",");
    workspace_mode=4;workspace_gradient(257);puts(",");
    workspace_mode=0;workspace_gradient(0);puts(",");
    workspace_mode=0;workspace_gradient(16385);puts("],");
    if(fwp_tape_cached_bytes) return 196; /* oversize workspace is not retained */
    /* Detached owners must survive return, trap, cancellation and registry
     * reuse during result allocation. Each retirement leaves one bounded owner. */
    const fwp_desc number={.kind=K_F64};const fwp_desc index={.kind=K_I64};
    workspace_outputs=fwp_rc_fresh(fwp_array_new_packed(1,&index));
    workspace_seeds=fwp_rc_fresh(fwp_array_new_packed(1,&number));
    fwp_array_store(workspace_seeds,0,fwp_from_f64(1.0),&number);
    for(workspace_mode=1;workspace_mode<=3;workspace_mode++){
        if(workspace_mode==3)fwp_tapes[0].gen=32766;
        workspace_base=fwp_p_ad_tape(1);fwp_array_store(workspace_outputs,0,workspace_base,&index);
        if(workspace_mode==2){
            workspace_saved_task=fwp_cur;memset(&workspace_cancelled,0,sizeof(workspace_cancelled));workspace_cancelled.cancelled=1;fwp_cur=&workspace_cancelled;
            jmp_buf workspace_cancelled_base; workspace_cancelled.base = &workspace_cancelled_base;
            if (!setjmp(workspace_cancelled_base)){fwp_p_ad_backward(workspace_base,workspace_outputs,workspace_seeds);return 197;}
            workspace_cancelled.base=NULL;fwp_cur=workspace_saved_task;if(!workspace_cancelled.unwinding || fwp_cleanups || workspace_direct_scope.head!=-1)return 198;
            fwp_cleanup_push(&workspace_direct_cleanup,fwp_tape_scope_release,&workspace_direct_scope);
        } else if(!setjmp(workspace_recovered)){
            V result=fwp_rc_fresh(fwp_p_ad_backward(workspace_base,workspace_outputs,workspace_seeds));
            if(workspace_mode==1)return 199;fwp_rc_free_arr(result);
        } else if(workspace_mode!=1 || strcmp(fwp_trap_msg,"workspace result allocation control"))return 200;
        if(fwp_cleanups!=&workspace_direct_cleanup || !workspace_dead(workspace_base) || fwp_tape_cached_bytes>FWP_AD_WORKSPACE_BUDGET)return 201;
        if(workspace_inner){
            fwp_tape *inner=fwp_tape_of((int64_t)workspace_inner>>32);if(inner->leaves!=3)return 202;
            workspace_mode=0;fwp_array_store(workspace_outputs,0,workspace_inner,&index);
            V result=fwp_rc_fresh(fwp_p_ad_backward(workspace_inner,workspace_outputs,workspace_seeds));
            if(fwp_f64(fwp_array_load(result,0,&number))!=1.0)return 203;
            fwp_rc_free_arr(result);workspace_inner=0;break;
        }
    }
    fwp_fns=workspace_functions;
    for(workspace_mode=5;workspace_mode<=7;workspace_mode+=2){
        if(fwp_p_ad_scope(PTR(&workspace_callback),FWP_UNIT)!=FWP_UNIT)return 209;
        if(fwp_cleanups!=&workspace_direct_cleanup || !workspace_dead(workspace_base))return 210;
    }
    workspace_mode=6;
    if(!setjmp(workspace_recovered)){fwp_p_ad_scope(PTR(&workspace_callback),FWP_UNIT);return 204;}
    if(strcmp(fwp_trap_msg,"workspace scope control") || fwp_cleanups!=&workspace_direct_cleanup || !workspace_dead(workspace_base))return 205;
    fwp_rc_free_arr(workspace_outputs);fwp_rc_free_arr(workspace_seeds);
    fwp_cleanup_pop(&workspace_direct_cleanup);fwp_tape_scope_release(&workspace_direct_scope);
    fwp_tape_finish();
    if(workspace_live || fwp_tape_cached_bytes || fwp_ntapes || fwp_tapes)return 206;
    if(fwp_heap.live!=initial_live)return 211;
    puts("\"cleanup\":\"bounded owners released after trap, cancellation, reentrancy and shutdown\"}");return 0;
}
