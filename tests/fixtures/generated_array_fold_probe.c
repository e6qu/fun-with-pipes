static volatile int64_t generated_input;
int main(void) {
    fwp_heap_start();fwp_fns=fwp_fn_table;fwp_init_consts();
    const int64_t counts[]={-3,0,1,16,4096,262144};
    for(size_t i=0;i<sizeof counts/sizeof counts[0];i++) {
        generated_input=counts[i];
        size_t live=fwp_heap.live,slots=fwp_heap.rc_bytes;
        fwp_heap.peak=live;
        measured_calls=0;measured_bytes=0;measured_retains=0;
        V result=fGENERATED((V)generated_input);
        int64_t n=counts[i]<0?0:counts[i];
        if((int64_t)result!=n*(n-1)/2)return 170;
        if(FUSED && (measured_calls || measured_bytes || measured_retains))return 171;
        if(!FUSED && measured_calls==0)return 172;
        if(fwp_heap.live!=live)return 173;
        if(FUSED && fwp_heap.rc_bytes!=slots)return 174;
        if(FUSED && fwp_heap.peak!=live)return 175;
        printf("{\"length\":%lld,\"requests\":%llu,\"bytes\":%llu,\"retains\":%llu,\"peakLiveBytes\":%zu,\"finalLiveBytes\":%zu,\"countBytes\":%zu}\n",
            (long long)counts[i],(unsigned long long)measured_calls,
            (unsigned long long)measured_bytes,(unsigned long long)measured_retains,
            fwp_heap.peak-live,fwp_heap.live-live,fwp_heap.rc_bytes-slots);
    }
    return 0;
}
