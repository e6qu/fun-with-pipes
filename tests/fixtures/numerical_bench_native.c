static uint64_t bench_clock(void){struct timespec t;clock_gettime(CLOCK_MONOTONIC,&t);return (uint64_t)t.tv_sec*1000000000+(uint64_t)t.tv_nsec;}
static intptr_t bench_initial_charge;
static size_t bench_peak_charge;
static void bench_sample_live(void){
#if PROFILE
    intptr_t used=fwp_gc.budget_given-fwp_gc.budget-bench_initial_charge;
    if(used<0)abort();if((size_t)used>bench_peak_charge)bench_peak_charge=(size_t)used;
#endif
}
int main(void){
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    const fwp_desc scalar={.kind=K_F64};const size_t elements=65537,m=65,k=67,n=63,rounds=8;
    puts("{\"samples\":[");
    for(size_t sample=0;sample<5;sample++){
        bench_calls=bench_bytes=bench_retains=bench_nonlast_releases=bench_release_checks=0;bench_peak_charge=0;bench_kernel_ns=0;
        bench_initial_charge=fwp_gc.budget_given-fwp_gc.budget;size_t collections=fwp_gc.ncollect;
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
        uint64_t elapsed=bench_clock()-start;intptr_t live=fwp_gc.budget_given-fwp_gc.budget-bench_initial_charge;
        if(fwp_gc.ncollect!=collections || live){fprintf(stderr,"unexpected collection or retained charged storage: %zu %ld\n",fwp_gc.ncollect-collections,(long)live);return 224;}
        printf("%s{\"allocationInclusiveNs\":%llu,\"kernelNs\":%llu,\"hash\":\"%016llx\",\"requests\":%llu,\"requestedBytes\":%llu,\"liveChargedBytes\":%ld,\"peakChargedBytes\":%zu,\"retains\":%llu,\"nonlastReleases\":%llu,\"releaseChecks\":%llu,\"collections\":%zu,\"collectionPauseSeconds\":%.9f,\"chunkHighWaterBytes\":%zu,\"reservedVirtualBytes\":%zu}",sample?",\n":"",(unsigned long long)elapsed,(unsigned long long)bench_kernel_ns,(unsigned long long)hash,(unsigned long long)bench_calls,(unsigned long long)bench_bytes,(long)live,bench_peak_charge,(unsigned long long)bench_retains,(unsigned long long)bench_nonlast_releases,(unsigned long long)bench_release_checks,fwp_gc.ncollect-collections,fwp_gc.pause_total,(size_t)fwp_gc.heap_bytes,fwp_gc.reservation_bytes+fwp_gc.meta_bytes);
    }
    puts("]}");return 0;
}
