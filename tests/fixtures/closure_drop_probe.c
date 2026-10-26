static unsigned closure_mode, closure_allocs, closure_frees, closure_captures;
static V *closure_children;
static jmp_buf closure_recovered;
static int closure_recover(void) { return 1; }
static void closure_probe_noop(void *arg) { (void)arg; }
static void *closure_probe_alloc(size_t n) {
    closure_allocs++;
    if (closure_mode == 2 && closure_allocs == 2) return NULL;
    return malloc(n);
}
static void closure_probe_free(void *p) { closure_frees++; free(p); }
static V closure_entry(V *args) { (void)args; return FWP_UNIT; }
static void closure_arguments(V *args,uint32_t offset,uint32_t n) {
    (void)args; (void)offset; (void)n;
}
static void closure_leaf_captures(V f,int duplicate) {
    if (duplicate) return;
    closure_captures++;
    fwp_rc_free_obj(f);
}
static void closure_root_captures(V f,int duplicate) {
    if (duplicate) return;
    unsigned count = closure_mode == 2 ? 200 : 80;
    for (unsigned i=0;i<count;i++) fwp_closure_drop(closure_children[i]);
    if (closure_mode == 1) fwp_trap("closure capture cleanup control");
    closure_captures++;
    fwp_rc_free_obj(f);
}
static const fwp_owned_fninfo closure_leaf_owned={closure_entry,closure_leaf_captures,closure_arguments,closure_arguments};
static const fwp_owned_fninfo closure_root_owned={closure_entry,closure_root_captures,closure_arguments,closure_arguments};
static const fwp_fninfo closure_entries[]={
    {1,closure_entry,"leaf",&closure_leaf_owned},
    {1,closure_entry,"root",&closure_root_owned}
};
static V closure_new(unsigned fn) {
    fwp_clo *value=fwp_alloc(sizeof(fwp_clo));value->fn=fn;value->n=0;
    return fwp_rc_fresh(PTR(value));
}
int main(void) {
    volatile V children[200]={0};closure_children=(V *)children;
    fwp_heap_start();fwp_fns=fwp_fn_table;fwp_init_consts();
    fwp_fns=closure_entries;
    fwp_trap_recover=closure_recover;fwp_trap_jb=&closure_recovered;fwp_trap_cleanup=0;
    for (closure_mode=0;closure_mode<3;closure_mode++) {
        closure_allocs=closure_frees=closure_captures=0;
        unsigned count=closure_mode==2?200:80;
        for(unsigned i=0;i<count;i++) children[i]=closure_new(0);
        V root=closure_new(1);
        if (!setjmp(closure_recovered)) {
            fwp_closure_drop(root);
            if (closure_mode) return 93;
        } else {
            const char *expected=closure_mode==1?"closure capture cleanup control":"out of memory";
            if (strcmp(fwp_trap_msg,expected)) return 93;
        }
        /* Detect the stale pointer without dereferencing dead stack storage. */
        if (fwp_closure_drop_get() || fwp_cleanups) return 94;
        if (closure_allocs!=(closure_mode==2?2:1) || closure_frees!=1) return 95;
        if (closure_captures!=(closure_mode?0:81)) return 96;
        unsigned before=closure_captures;
        fwp_closure_drop(closure_new(0));
        if (closure_captures!=before+1 || fwp_closure_drop_get() || fwp_cleanups) return 97;
        fwp_heap_collect();
        if (!fwp_heap.armed || !fwp_heap.ncollect) return 98;
        FWP_KEEP_ALIVE(children);
    }
    printf("Closure cleanup context resets after capture trap and spill OOM; real collections=%zu\n",fwp_heap.ncollect);
    return 0;
}
