static int prefix_case(int64_t leaves, int constants) {
    V tuple=fwp_record(4,(V[4]){0,0,0,0});
    V outs=fwp_arr_new(constants ? 1 : 4), seeds=fwp_arr_new(constants ? 1 : 4);
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
    V result=fwp_p_ad_backward(base,outs,seeds);
    if(prefix_scans!=(constants ? 0 : 1))return 241;
    if(ARR(result)->len!=(size_t)leaves)return 242;
    for(int64_t i=0;i<leaves;i++) {
        double expected=constants ? 0.0 : i==0 ? 13.0 : i==1 ? 9.0 : 0.0;
        if(fwp_f64(ARR(result)->d[i])!=expected)return 243;
    }
    size_t expected_bytes=(size_t)(constants ? (leaves ? leaves : 1) : 4)*sizeof(double);
    if(prefix_adj_bytes!=expected_bytes)return 240;
    for(int64_t i=0;i<fwp_ntapes;i++)if(fwp_tapes[i].live)return 244;
    if(fwp_cleanups)return 245;
    fwp_tape_finish();
    return 0;
}
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    int result=prefix_case(3,0);if(result)return result;
    result=prefix_case(3,1);if(result)return result;
    result=prefix_case(0,1);if(result)return result;
    puts("numeric backward prefix preserves inputs and bounds adjoints and scans");
    return 0;
}
