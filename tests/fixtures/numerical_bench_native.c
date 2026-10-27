static uint64_t bench_clock(void){struct timespec t;clock_gettime(CLOCK_MONOTONIC,&t);return (uint64_t)t.tv_sec*1000000000+(uint64_t)t.tv_nsec;}
static size_t bench_initial_charge;
static size_t bench_peak_charge;
static void bench_sample_live(void){
#if PROFILE
    if(fwp_heap.live<bench_initial_charge)abort();
    size_t used=fwp_heap.live-bench_initial_charge;
    if(used>bench_peak_charge)bench_peak_charge=used;
#endif
}
int main(void){
    fwp_heap_start();fwp_fns=fwp_fn_table;fwp_init_consts();
    const fwp_desc scalar={.kind=K_F64};const size_t elements=65537,m=65,k=67,n=63,rounds=8;
    puts("{\"samples\":[");
    for(size_t sample=0;sample<5;sample++){
        bench_calls=bench_bytes=bench_retains=bench_nonlast_releases=bench_release_checks=0;bench_peak_charge=0;bench_kernel_ns=0;
        bench_initial_charge=fwp_heap.live;
        uint64_t hash=1469598103934665603ULL,start=bench_clock();
        for(size_t round=0;round<rounds;round++){
#if MATRIX_BENCH
            V left=fwp_rc_fresh(fwp_array_new_packed(m*k,&scalar)),right=fwp_rc_fresh(fwp_array_new_packed(k*n,&scalar));
            for(size_t i=0;i<m*k;i++)fwp_array_store(left,i,fwp_from_f64(((double)(int)((i+round)%19)-9.0)/4.0),&scalar);
            for(size_t i=0;i<k*n;i++)fwp_array_store(right,i,fwp_from_f64(((double)(int)((i+round)%13)-6.0)/8.0),&scalar);
            V af[]={k,left,m},bf[]={n,right,k};V a=fwp_rc_fresh(fwp_record(3,af)),b=fwp_rc_fresh(fwp_record(3,bf));bench_sample_live();
            __asm__ volatile("" : "+r"(a), "+r"(b) :: "memory");V result=fBENCH_ENTRY(b,a);
            for(size_t i=0;i<m*n;i++)hash=(hash^fwp_array_load(result,i,&scalar))*1099511628211ULL;
            fwp_rc_free_arr(result);
#else
            V input=fwp_rc_fresh(fwp_array_new_packed(elements,&scalar));
            for(size_t i=0;i<elements;i++)fwp_array_store(input,i,fwp_from_f64(((double)(int)((i+round)%19)-9.0)/4.0),&scalar);
            bench_sample_live();__asm__ volatile("" : "+r"(input) :: "memory");uint64_t before=bench_clock();V result=fBENCH_ENTRY(input);bench_kernel_ns+=bench_clock()-before;
            hash=(hash^result)*1099511628211ULL;
#endif
        }
        uint64_t elapsed=bench_clock()-start;
        if(fwp_heap.live!=bench_initial_charge){fprintf(stderr,"unexpected charged storage: %zu, expected %zu\n",fwp_heap.live,bench_initial_charge);return 224;}
        size_t live=fwp_heap.live-bench_initial_charge;
        printf("%s{\"allocationInclusiveNs\":%llu,\"kernelNs\":%llu,\"hash\":\"%016llx\",\"requests\":%llu,\"requestedBytes\":%llu,\"liveChargedBytes\":%zu,\"peakChargedBytes\":%zu,\"retains\":%llu,\"nonlastReleases\":%llu,\"releaseChecks\":%llu,\"chunkHighWaterBytes\":%zu,\"reservedVirtualBytes\":%zu}",sample?",\n":"",(unsigned long long)elapsed,(unsigned long long)bench_kernel_ns,(unsigned long long)hash,(unsigned long long)bench_calls,(unsigned long long)bench_bytes,live,bench_peak_charge,(unsigned long long)bench_retains,(unsigned long long)bench_nonlast_releases,(unsigned long long)bench_release_checks,(size_t)fwp_heap.heap_bytes,fwp_heap.reservation_bytes+fwp_heap.meta_bytes);
    }
    puts("]}");return 0;
}
