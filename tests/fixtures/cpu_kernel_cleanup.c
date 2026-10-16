static jmp_buf kernel_jump;
static int kernel_recover(void) {return 1;}
static void kernel_counters_reset(void) {
    if(atomic_load(&kernel_live)) exit(248);
    atomic_store(&kernel_peak,0);atomic_store(&kernel_requests,0);
    kernel_managed_requests=kernel_managed_left=0;
    kernel_thread_attempts=kernel_thread_started=kernel_thread_joined=kernel_thread_fail=0;
}
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    intptr_t initial=fwp_gc.budget;
    const size_t n=8193;
    V code=fwp_rc_fresh(fwp_arr_new(3)); ARR(code)->d[0]=0;ARR(code)->d[1]=1;ARR(code)->d[2]=4;
    V constants=fwp_rc_fresh(fwp_arr_new(1)); ARR(constants)->d[0]=fwp_from_f64(0.5);
    V data=fwp_rc_fresh(fwp_arr_new(n));
    for(size_t i=0;i<n;i++) ARR(data)->d[i]=fwp_from_f64((double)i);
    V inputs=fwp_rc_fresh(fwp_cons(data,0));
    intptr_t budget=fwp_gc.budget;
    for(int sum=0;sum<2;sum++) for(int threads=1;threads<=4;threads+=3) {
        kernel_counters_reset();
        V result=sum ? fwp_p_device_sum(threads,n,code,constants,inputs)
                     : fwp_p_device_run(threads,n,code,constants,inputs);
        if(sum) {if(fwp_f64(result)!=(double)(n*(n-1))/4.0)return 247;}
        else {
            if(ARR(result)->len!=n)return 247;
            for(size_t i=0;i<n;i++) if(fwp_f64(ARR(result)->d[i])!=(double)i*0.5)return 247;
            fwp_rc_free_arr(fwp_rc_fresh(result));
        }
        size_t workers=sum && threads==4 ? 3 : (size_t)threads;
        size_t expected=1+workers+(sum ? 1 : 0);
        size_t peak_bound=sizeof(double *)+workers*2*FWP_KCHUNK*sizeof(double)+(sum ? 3*sizeof(double):0);
        if(fwp_gc.budget!=budget || atomic_load(&kernel_live) ||
           atomic_load(&kernel_requests)!=expected || atomic_load(&kernel_peak)>peak_bound ||
           kernel_managed_requests!=(sum ? 0:1))return 248;
        printf("kernel %s threads %d: native requests %zu, native peak %zu, managed requests %d, final native and charged storage 0\n",
            sum ? "sum":"run",threads,atomic_load(&kernel_requests),atomic_load(&kernel_peak),kernel_managed_requests);
    }
    for(int which=0;which<3;which++) {
        kernel_counters_reset();
        kernel_managed_left=which==0 ? 1:0;
        kernel_thread_fail=which ? 2:0;
        fwp_trap_recover=kernel_recover;fwp_trap_jb=&kernel_jump;fwp_trap_cleanup=fwp_cleanups;
        if(!setjmp(kernel_jump)) {
            if(which==2) fwp_p_device_sum(4,n,code,constants,inputs);
            else fwp_p_device_run(4,n,code,constants,inputs);
            return 247;
        }
        kernel_managed_left=kernel_thread_fail=0;
        fwp_trap_recover=NULL;fwp_trap_jb=NULL;
        if(fwp_cleanups || atomic_load(&kernel_live) || fwp_gc.budget!=budget)return 248;
        if(which && (kernel_thread_attempts!=2 || kernel_thread_started!=1 || kernel_thread_joined!=1))return 249;
    }
    fwp_rc_free_obj(inputs);fwp_rc_free_arr(data);fwp_rc_free_arr(constants);fwp_rc_free_arr(code);
    if(fwp_gc.budget!=initial)return 248;
    puts("allocation and worker-start failures: all started workers joined; final storage 0");
    return 0;
}
