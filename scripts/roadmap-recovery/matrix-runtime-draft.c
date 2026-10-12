/* F64 matrix fast path: exact shape guards preserve cast/malformed fallback. */
static V fwp_p_matrix_valid_f64(V b,V a) {
    int64_t m=(int64_t)OBJ(a)->f[2],k=(int64_t)OBJ(a)->f[0];
    int64_t br=(int64_t)OBJ(b)->f[2],n=(int64_t)OBJ(b)->f[0];
    if(m<0 || k<0 || br!=k || n<0)return FWP_FALSE;
    uint64_t rows=(uint64_t)m,inner=(uint64_t)k,cols=(uint64_t)n;
    uint64_t limit=(SIZE_MAX-sizeof(fwp_arr))/sizeof(V);
    if((inner && rows>limit/inner) || (cols && inner>limit/cols) || (cols && rows>limit/cols))return FWP_FALSE;
    return (fwp_array_len(OBJ(a)->f[1])==rows*inner && fwp_array_len(OBJ(b)->f[1])==inner*cols) ? FWP_TRUE : FWP_FALSE;
}
static void fwp_matrix_output_release(void *arg) { fwp_rc_free_arr(*(V *)arg); }
static V fwp_p_matrix_mul_f64(V b,V a) {
    if(fwp_p_matrix_valid_f64(b,a)!=FWP_TRUE)fwp_trap("invalid internal matrix shape");
    size_t m=(size_t)OBJ(a)->f[2],k=(size_t)OBJ(a)->f[0],n=(size_t)OBJ(b)->f[0];
    V left=OBJ(a)->f[1],right=OBJ(b)->f[1];const fwp_desc scalar={.kind=K_F64};
    V result=fwp_array_typed_new(m*n,&scalar);
    fwp_cleanup cleanup;fwp_cleanup_push(&cleanup,fwp_matrix_output_release,&result);
    for(size_t z=0;z<m*n;z++)fwp_array_store(result,z,fwp_from_f64(0.0),&scalar);
    for(size_t ib=0;ib<m;ib+=32){
        size_t ie=m-ib<32?m:ib+32;
        for(size_t kb=0;kb<k;kb+=32){
            size_t ke=k-kb<32?k:kb+32;FWP_TICK();
            for(size_t jb=0;jb<n;jb+=32){
                size_t je=n-jb<32?n:jb+32;
                for(size_t i=ib;i<ie;i++)for(size_t q=kb;q<ke;q++){
                    double x=fwp_f64(fwp_array_load(left,i*k+q,&scalar));
                    for(size_t j=jb;j<je;j++){
                        double product=x*fwp_f64(fwp_array_load(right,q*n+j,&scalar));
                        double prior=fwp_f64(fwp_array_load(result,i*n+j,&scalar));
                        fwp_array_store(result,i*n+j,fwp_from_f64(product+prior),&scalar);
                    }
                }
            }
        }
    }
    fwp_cleanup_pop(&cleanup);FWP_KEEP_ALIVE(a);FWP_KEEP_ALIVE(b);return result;
}
