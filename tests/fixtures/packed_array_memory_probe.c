/* Exercise generated slice functions and generated typed Array[I8] teardown. */
static size_t probe_capacity(V value) {
    uintptr_t off=(uintptr_t)value-(uintptr_t)fwp_gc.base;
    if(off>=fwp_gc.top<<GC_SHIFT)return 0;
    gc_chunk *m=&fwp_gc.meta[off>>GC_SHIFT];
    if(m->type==GC_BIG && (off&(GC_CHUNK-1))==0)return m->size;
    if(m->type==GC_SMALL && (off&(GC_CHUNK-1))%m->slot==0)return m->slot;
    return 0;
}
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    const fwp_desc element={.kind=K_I8};
    V (*functions[])(V)={fSLICED,fNESTED,fEMPTY};
    const char *names[]={"sliced","nested","empty"};
    const size_t lengths[]={3,2,0},offsets[]={1,2,0};
    puts("{\"cases\":[");
    for(size_t which=0;which<3;which++) {
        uint64_t before_calls=measured_calls,before_bytes=measured_bytes;
        double before_freed=fwp_gc.freed;
        V result=functions[which](257);
        size_t length=fwp_array_len(result);
        if(length!=lengths[which])return 134;
        size_t own_capacity=probe_capacity(result),backing_capacity=0;
        V owner=fwp_array_owner(result);
        uint8_t *owner_count=fwp_rc_slot(owner);
        if(!owner_count || *owner_count!=1)return 135;
        if(FWP_PACKED_ARRAYS && length) {
            if(!fwp_array_is_view(result) || fwp_array_len(owner)!=257)return 136;
            if(fwp_array_data(result)!=fwp_array_data(owner)+offsets[which])return 137;
            backing_capacity=fwp_array_capacity(owner,&element);
            if(backing_capacity<sizeof(fwp_arr)+257)return 138;
        }else if(fwp_array_is_view(result))return 139;
        for(size_t i=0;i<length;i++)if(fwp_array_load(result,i,&element)!=(V)(int64_t)-128)return 140;
        uint64_t calls=measured_calls-before_calls,bytes=measured_bytes-before_bytes;
        if(calls!=(which==1?3:2))return 141;
        size_t stride=fwp_array_stride(&element);
        size_t expected_bytes=sizeof(fwp_arr)+257*stride;
        expected_bytes+=FWP_PACKED_ARRAYS && length?sizeof(fwp_array_view):sizeof(fwp_arr)+length*stride;
        if(which==1)expected_bytes+=FWP_PACKED_ARRAYS?sizeof(fwp_array_view):sizeof(fwp_arr)+5*stride;
        if(bytes!=expected_bytes)return 142;
        double before_drop=fwp_gc.freed;
        fARRAY_DROP(result);
        double released=fwp_gc.freed-before_drop;
        if(released<(double)(own_capacity+backing_capacity))return 143;
        printf("%s{\"name\":\"%s\",\"inputLength\":257,\"resultLength\":%zu,\"isView\":%s,\"managedCalls\":%llu,\"managedRequestedBytes\":%llu,\"resultCapacityBytes\":%zu,\"retainedBackingCapacityBytes\":%zu,\"freedBeforeReturnBytes\":%.0f,\"freedAtDropBytes\":%.0f}",which?",\n":"",names[which],length,FWP_PACKED_ARRAYS&&length?"true":"false",(unsigned long long)calls,(unsigned long long)bytes,own_capacity,backing_capacity,before_drop-before_freed,released);
    }
    puts("],\"scope\":\"Managed allocator requests and rounded object capacities; complete typed last-owner releases without a tracing collection. No timing or total process memory claim.\"}");
    return 0;
}
