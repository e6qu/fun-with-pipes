/* Measurement-only input clients: allow only reader, writer and sender tasks.
 * Keep the response-only fixture separately strict about unexpected tasks. */
static uint64_t client_connection_requested,client_connection_charged;
static uint64_t client_io_task_requested,client_io_task_charged;
static size_t client_storage_charge(const void *p) {
    size_t ci;
    gc_chunk *m=fwp_gc_chunk_of((uintptr_t)p,&ci);
    if(!m || (m->type!=GC_SMALL && m->type!=GC_BIG))_Exit(217);
    return m->type==GC_SMALL?m->slot:m->size;
}
static void client_note_connection(g_conn *c) {
    client_connection_requested+=sizeof(*c)+strlen(c->authority)+1;
    client_connection_charged+=client_storage_charge(c);
}
static void client_note_io_task(fwp_task *t) {
    client_io_task_requested+=sizeof(*t);
    client_io_task_charged+=client_storage_charge(t);
}
static void client_connection_storage(void) {
    fprintf(stderr,"connection-storage\t%llu\t%llu\t%llu\t%llu\t%zu\t%zu\n",
        (unsigned long long)client_connection_requested,
        (unsigned long long)client_connection_charged,
        (unsigned long long)client_io_task_requested,
        (unsigned long long)client_io_task_charged,sizeof(g_conn),sizeof(fwp_task));
}
static void client_require_drained(void) {
    if (g_pool || fwp_gc_tasks || fwp_zombie ||
        client_connections_closed != client_connections_created) _Exit(213);
}
static void client_drain_connections(void) {
    if (!g_pool && !fwp_gc_tasks) return;
    if (fwp_cur != fwp_root) _Exit(214);
    for (fwp_task *t=fwp_gc_tasks;t;t=t->gc_next)
        if (t->cfn!=g_reader && t->cfn!=g_writer && t->cfn!=g_send_all) _Exit(215);
    while (g_pool) g_conn_dead(g_pool,"measurement closes completed connection");
    /* Wake detached I/O tasks even if a platform has not reported shutdown yet.
     * Each task still runs its ordinary cancellation/socket-release path. */
    for (fwp_task *t=fwp_gc_tasks;t;t=t->gc_next) fwp_cancel_tree(t);
    int64_t deadline=fwp_now_ns()+10000000000LL;
    while (fwp_gc_tasks) {
        if (fwp_now_ns()>=deadline) _Exit(216);
        fwp_park(0,fwp_now_ns()+1000000LL);
        fwp_free_zombie();
    }
    fwp_free_zombie();
    client_require_drained();
    fprintf(stderr,"connection-drain\t%llu\t%llu\t0\t%.0f\t%llu\t%llu\t%llu\n",
        (unsigned long long)client_connections_created,
        (unsigned long long)client_connections_closed,
        client_charge()-client_start_charge,
        (unsigned long long)(client_connections_created-client_connections_finalized),
        (unsigned long long)(client_streams_created-client_streams_finalized),
        (unsigned long long)(client_message_requested-client_message_freed));
}

static uint64_t client_sender_requested,client_sender_charged;
static uint64_t client_sender_task_requested,client_sender_task_charged;
static void client_note_sender(g_sender *x) {
    client_senders_created++;
    client_sender_requested+=sizeof(*x);
    client_sender_charged+=client_storage_charge(x);
}
static void client_note_sender_task(fwp_task *t) {
    client_sender_task_requested+=sizeof(*t);
    client_sender_task_charged+=client_storage_charge(t);
}
static void client_sender_storage(void) {
    fprintf(stderr,"sender-storage\t%llu\t%llu\t%llu\t%llu\t%llu\t%llu\t%llu\t%llu\t%zu\t%zu\n",
        (unsigned long long)client_senders_created,(unsigned long long)client_senders_finished,
        (unsigned long long)client_inputs_pulled,(unsigned long long)client_inputs_encoded,
        (unsigned long long)client_sender_requested,(unsigned long long)client_sender_charged,
        (unsigned long long)client_sender_task_requested,(unsigned long long)client_sender_task_charged,
        sizeof(g_sender),sizeof(fwp_task));
}
