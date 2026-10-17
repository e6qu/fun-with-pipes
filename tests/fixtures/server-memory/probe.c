/* Measurement only. The allocation counters share the client probe's hooks,
 * but this sample belongs to the server process and begins after listener setup. */
static uint64_t server_expected_calls;
static int server_final_recorded;
static size_t server_storage_charge(const void *p) {
    size_t ci;
    gc_chunk *m=fwp_gc_chunk_of((uintptr_t)p,&ci);
    if(!m || (m->type!=GC_SMALL && m->type!=GC_BIG))_Exit(241);
    return m->type==GC_SMALL?m->slot:m->size;
}
static void server_begin(void) {
    const char *count=getenv("FWP_SERVER_MEASURE_CALLS");char *end=0;
    if(!count || !*count)_Exit(242);
    server_expected_calls=strtoull(count,&end,10);
    if(!end || *end || !server_expected_calls || server_expected_calls>256)_Exit(242);
    server_measure_begin();
}
static void server_task_finished(void (*entry)(void *,int)) {
    if(!server_active)return;
    if(entry==g_handle)server_calls_finished++;
    uint64_t calls=0,io=0,other=0;
    for(fwp_task *t=fwp_gc_tasks;t;t=t->gc_next) {
        if(t->cfn==g_handle)calls++;
        else if(t->cfn==g_reader || t->cfn==g_writer)io++;
        else other++;
    }
    server_sample();
    if(entry==g_handle) {
        fprintf(stderr,"server-call\t%llu\t%.0f\t%llu\t%llu\t%llu\n",
            (unsigned long long)server_calls_finished,server_charge()-server_start_charge,
            (unsigned long long)calls,(unsigned long long)io,(unsigned long long)other);
        fflush(stderr);
    }
    if(server_final_recorded || server_calls_finished!=server_expected_calls || calls || io || other)return;
    if(server_calls_started!=server_expected_calls || server_connections_created!=server_connections_closed)_Exit(243);
    server_final_recorded=1;
    fprintf(stderr,"server-final\t%llu\t%llu\t%llu\t%.0f\t%.0f\t%zu\t%llu\t%llu\t%llu\t%llu\t%llu\t%llu\t0\t0\t0\n",
        (unsigned long long)server_requests,(unsigned long long)server_requested_bytes,
        (unsigned long long)server_retains,server_peak_charge,server_charge()-server_start_charge,fwp_gc.ncollect,
        (unsigned long long)server_calls_started,(unsigned long long)server_calls_finished,
        (unsigned long long)server_connections_created,(unsigned long long)server_connections_closed,
        (unsigned long long)server_connections_finalized,(unsigned long long)server_streams_finalized);
    fprintf(stderr,"server-storage\t%llu\t%llu\t%llu\t%llu\t%llu\t%llu\t%zu\t%zu\t%zu\t%zu\n",
        (unsigned long long)server_job_requested,(unsigned long long)server_job_charged,
        (unsigned long long)server_task_requested,(unsigned long long)server_task_charged,
        (unsigned long long)server_args_requested,(unsigned long long)server_args_charged,
        sizeof(g_job),sizeof(fwp_task),sizeof(g_conn),sizeof(g_stream));
    fflush(stderr);
}
