int main(void) {
    fwp_heap_start(); fwp_fns=fwp_fn_table; fwp_init_consts();
    const fwp_desc element={.kind=K_F64};
    const size_t sizes[]={0,1,7,129};
    for(size_t test=0;test<4;test++) {
        size_t n=sizes[test]; size_t live_bytes=fwp_heap.live;
        V xs=0;
        for(size_t i=n;i;i--)xs=fwp_rc_fresh(fwp_cons(fwp_from_f64((double)(i-1)),xs));
        uint64_t calls=mapped_calls,bytes=mapped_bytes;
        V result=fTRANSFORM(xs);
        calls=mapped_calls-calls;bytes=mapped_bytes-bytes;
        if(fwp_array_len(result)!=n)return 234;
        for(size_t i=0;i<n;i++)if(fwp_array_load(result,i,&element)!=fwp_from_f64(2.0*(double)i))return 235;
        fwp_rc_resource_free_arr(result);
        if(fwp_heap.live!=live_bytes)return 236;
        printf("%zu %llu %llu\n",n,(unsigned long long)calls,(unsigned long long)bytes);
    }
    return 0;
}
