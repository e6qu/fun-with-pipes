static int metrics_left, metrics_buffers;
static jmp_buf metrics_jump;
static int metrics_recover(void) { return 1; }
static void metrics_allocation(void) {
    if(metrics_left>0 && !--metrics_left) fwp_trap("injected snapshot allocation failure");
}
static void metrics_leaf_drop(V value) {
    if(fwp_rc_release_last(value)) fwp_rc_resource_free_obj(value);
}
int main(void) {
    fwp_heap_start(); fwp_fns=fwp_fn_table; fwp_init_consts();
    size_t initial_live_bytes=fwp_heap.live;
    V name=fwp_rc_fresh(fwp_str_new("a\0b",3));
    V syntax=fwp_rc_fresh(fwp_data(SY_STR,1,&name));
    fwp_p_metrics_update(0,name,fwp_from_f64(1));
    fwp_p_metrics_update(2,name,fwp_from_f64(2));
    if(fwp_nmetrics!=3) return 247;
    size_t capacity=fwp_metrics_cap;
    for(int repeat=0;repeat<64;repeat++) {
        fwp_p_metrics_update(0,name,fwp_from_f64(-1));
        fwp_p_metrics_update(2,name,fwp_from_f64(0.5));
    }
    if(fwp_nmetrics!=3 || fwp_metrics_cap!=capacity) return 247;
    for(int which=0;which<2;which++) {
        int failures=0,completed=0;
        for(int allocation=1;allocation<64;allocation++) {
            size_t live_bytes=fwp_heap.live;
            fwp_trap_recover=metrics_recover; fwp_trap_jb=&metrics_jump;
            fwp_trap_cleanup=fwp_cleanups;
            metrics_left=allocation;
            if(!setjmp(metrics_jump)) {
                V result=which ? fwp_p_syntax_show(syntax) : fwp_p_metrics_snapshot(METRICS_LIST);
                metrics_left=0;
                if(which) metrics_leaf_drop(fwp_rc_fresh(result));
                else METRICS_LIST->drop(result);
                completed=1;
            } else failures++;
            metrics_left=0; fwp_trap_recover=NULL; fwp_trap_jb=NULL;
            if(fwp_cleanups || fwp_heap.live!=live_bytes || metrics_buffers) {
                fprintf(stderr,"snapshot %d allocation %d: charged delta %lld; buffers %d\n",which,allocation,(long long)(fwp_heap.live - live_bytes),metrics_buffers);
                return 248;
            }
            if(!fwp_rc_last(name) || !fwp_rc_last(syntax)) return 249;
            if(completed) break;
        }
        /* Three metrics: copied name, copied kind, tuple and list node each.
         * Syntax rendering allocates one managed result, plus native scratch. */
        int expected=which ? 1 : 12;
        if(!completed || failures!=expected) return 247;
        printf("snapshot %d: %d managed allocation requests; final charged delta 0; native scratch 0\n",which,failures);
    }
    fwp_metrics_finish();
    if(fwp_metrics || fwp_nmetrics || fwp_metrics_cap) return 249;
    metrics_leaf_drop(syntax); metrics_leaf_drop(name);
    if(fwp_heap.live!=initial_live_bytes) return 248;
    return 0;
}
