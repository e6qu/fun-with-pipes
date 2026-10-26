static int prefix_case(int64_t leaves, int constants) {
    V tuple=fwp_rc_fresh(fwp_record(4,(V[4]){0,0,0,0}));
    V outs=fwp_rc_fresh(fwp_arr_new(constants ? 1 : 4)), seeds=fwp_rc_fresh(fwp_arr_new(constants ? 1 : 4));
    V base=fwp_p_ad_tape((V)leaves), early=base, tail;
    if(leaves) {
        OBJ(tuple)->f[0]=base;OBJ(tuple)->f[1]=fwp_from_f64(2.0);
        OBJ(tuple)->f[2]=base+1;OBJ(tuple)->f[3]=fwp_from_f64(3.0);
        early=fwp_p_ad_push(tuple);tail=early;
        for(int i=0;i<4096;i++) {
            OBJ(tuple)->f[0]=tail;OBJ(tuple)->f[1]=fwp_from_f64(NAN);
            OBJ(tuple)->f[2]=(V)(int64_t)-1;OBJ(tuple)->f[3]=fwp_from_f64(0.0);
            tail=fwp_p_ad_push(tuple);
        }
    }
    if(constants) {
        ARR(outs)->d[0]=(V)(int64_t)-1;ARR(seeds)->d[0]=fwp_from_f64(NAN);
    } else {
        ARR(outs)->d[0]=early;ARR(outs)->d[1]=base;ARR(outs)->d[2]=early;ARR(outs)->d[3]=(V)(int64_t)-1;
        ARR(seeds)->d[0]=fwp_from_f64(2.0);ARR(seeds)->d[1]=fwp_from_f64(7.0);
        ARR(seeds)->d[2]=fwp_from_f64(1.0);ARR(seeds)->d[3]=fwp_from_f64(NAN);
    }
    prefix_scans=0;prefix_adj_bytes=0;
    V result=fwp_rc_fresh(fwp_p_ad_backward(base,outs,seeds));
    if(prefix_scans!=(constants ? 0 : 1))return 241;
    if(ARR(result)->len!=(size_t)leaves)return 242;
    for(int64_t i=0;i<leaves;i++) {
        double expected=constants ? 0.0 : i==0 ? 13.0 : i==1 ? 9.0 : 0.0;
        if(fwp_f64(ARR(result)->d[i])!=expected)return 243;
    }
    size_t expected_bytes=(size_t)(constants ? leaves : 4)*sizeof(double);
    if(prefix_adj_bytes!=expected_bytes)return 240;
    for(int64_t i=0;i<fwp_ntapes;i++)if(fwp_tapes[i].live)return 244;
    if(!fwp_cleanups||fwp_cleanups->release!=fwp_tape_scope_release||fwp_cleanups->prev)return 245;
    fwp_rc_free_arr(result);fwp_rc_free_arr(outs);fwp_rc_free_arr(seeds);fwp_rc_free_obj(tuple);
    fwp_tape_finish();
    return 0;
}
int main(void) {
    fwp_heap_start();fwp_fns=fwp_fn_table;fwp_init_consts();
    fwp_tape_scope scope={-1};fwp_cleanup scope_owner;
    fwp_cleanup_push(&scope_owner,fwp_tape_scope_release,&scope);
    size_t baseline=fwp_heap.live;
    for(int round=0;round<32;round++) {
    int result=prefix_case(3,0);if(result)return result;
    result=prefix_case(3,1);if(result)return result;
    result=prefix_case(0,1);if(result)return result;
#ifdef FWP_ARC_ONLY
    if(fwp_heap.live!=baseline||fwp_heap.ncollect||fwp_heap.rc_wide_len)return 90;
#endif
    }
    if(fwp_tape_workspace_enabled()) {
        V outs=fwp_rc_fresh(fwp_arr_new(0)),seeds=fwp_rc_fresh(fwp_arr_new(0));
        size_t previous=0;int growths=0;
        for(int64_t n=1;n<=65;n++) {
            V base=fwp_p_ad_tape((V)n);
            V values=fwp_rc_fresh(fwp_p_ad_backward(base,outs,seeds));
            if(ARR(values)->len!=(size_t)n)return 242;
            for(int64_t i=0;i<n;i++)if(fwp_f64(ARR(values)->d[i])!=0.0)return 243;
            fwp_rc_free_arr(values);
            if(prefix_adj_bytes<(size_t)n*8 || prefix_adj_bytes>=(size_t)n*16)return 246;
            growths+=prefix_adj_bytes!=previous;previous=prefix_adj_bytes;
        }
        if(growths!=8)return 246;
        fwp_rc_free_arr(outs);fwp_rc_free_arr(seeds);fwp_tape_finish();
    }
    if(scope.head!=-1||fwp_cleanups!=&scope_owner)return 245;
    fwp_cleanup_pop(&scope_owner);fwp_tape_scope_release(&scope);
#ifdef FWP_ARC_ONLY
    if(fwp_heap.live!=baseline||fwp_heap.ncollect||fwp_heap.rc_wide_len)return 90;
#else
    (void)baseline;
#endif
    puts("numeric backward prefix preserves inputs and bounds adjoints and scans");
    return 0;
}
