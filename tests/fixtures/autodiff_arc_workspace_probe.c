/* The same measured gradient runs with every tape under an actual callback
 * scope and with tracing compiled out. Cold/warm hashes match the tracing
 * control; allocations count the tape's real C buffers and gradient array. */
static V arc_workspace_entry(V *args) {
    workspace_gradient((size_t)args[0]);
    return FWP_UNIT;
}
static const fwp_fninfo arc_workspace_functions[]={
    {1,arc_workspace_entry,"ARC workspace profile",0}
};
static fwp_clo arc_workspace_callback={0,0};
int main(void) {
    fwp_heap_start();fwp_fns=fwp_fn_table;fwp_init_consts();
    fwp_fns=arc_workspace_functions;
    size_t live_bytes=fwp_heap.live;
    puts("{\"collectorFree\":true,\"profiles\":[");
    const size_t sizes[]={129,129,257,257,0,16385};
    for(size_t i=0;i<6;i++) {
        workspace_mode=(i==1 || i==3)?4:0;
        fwp_p_ad_scope(PTR(&arc_workspace_callback),(V)sizes[i]);
        if(fwp_cleanups || fwp_heap.live!=live_bytes)return 211;
        for(int64_t j=0;j<fwp_ntapes;j++)if(fwp_tapes[j].live)return 212;
        puts(i==5?"],":",");
    }
    if(fwp_tape_cached_bytes)return 196;
    fwp_tape_finish();
    if(workspace_live || fwp_tape_cached_bytes || fwp_ntapes || fwp_tapes)return 206;
    puts("\"cleanup\":\"scoped tapes and managed gradients fully reclaimed\"}");
    return 0;
}
