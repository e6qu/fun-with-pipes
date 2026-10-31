static const fwp_desc array_list_f64 = {.kind=K_F64};
static volatile size_t array_list_length;
int main(void) {
    fwp_heap_start(); fwp_fns=fwp_fn_table; fwp_init_consts();
    const size_t lengths[]={0,1,129,4096};
    for(size_t c=0;c<4;c++) for(int sliced=0;sliced<2;sliced++) {
        array_list_length=lengths[c]; size_t n=array_list_length;
        size_t initial=fwp_heap.live;
        V backing=fwp_array_typed_new(n+2,&array_list_f64);
        for(size_t i=0;i<n+2;i++)
            fwp_array_store(backing,i,fwp_from_f64(((int64_t)i-17)/4.0),&array_list_f64);
        V input=sliced ? fwp_p_array_slice_typed(1,n,backing,NULL,&array_list_f64)
                       : fwp_p_array_slice_typed(0,n,backing,NULL,&array_list_f64);
        for(int operation=0;operation<3;operation++) {
            size_t live=fwp_heap.live;
            fwp_rc_dup(input); /* Caller keeps the original alias. */
            measured_calls=0; measured_bytes=0;
            V result=operation==1 ? fFOLDED(input)
                     : operation==2 ? fFILTERED(input) : fMAPPED(input);
            uint64_t calls=measured_calls,bytes=measured_bytes;
            double sum=-0.0;
            V cursor=result;
            for(size_t i=0;i<n;i++) {
                V original=fwp_array_load(input,i,&array_list_f64);
                if(operation==1) sum=fwp_f64(original)*3.0+sum;
                else if(operation==2) {
                    if(fwp_f64(original)>0.0) {
                        if(!cursor || OBJ(cursor)->f[0]!=original) return 182;
                        cursor=OBJ(cursor)->f[1];
                    }
                } else {
                    if(!cursor || OBJ(cursor)->f[0]!=fwp_float_convert(K_F64,K_F32,original)) return 176;
                    cursor=OBJ(cursor)->f[1];
                }
                if(original!=fwp_array_load(backing,i+(size_t)sliced,&array_list_f64)) return 177;
            }
            if(operation==1) { if(result!=fwp_from_f64(sum)) return 178; }
            else {
                if(cursor) return 179;
                if(operation==2) (void)fDROP_FILTERED(result);
                else (void)fRELEASE(result);
            }
            if(fwp_heap.live!=live || fwp_cleanups) return 180;
            printf("%zu %d %d %llu %llu\n",n,sliced,operation,
                   (unsigned long long)calls,(unsigned long long)bytes);
        }
        if(fwp_rc_release_last(input)) fwp_rc_free_arr(input);
        if(fwp_rc_release_last(backing)) fwp_rc_free_arr(backing);
        if(fwp_heap.live!=initial || fwp_cleanups) return 181;
    }
    return 0;
}
