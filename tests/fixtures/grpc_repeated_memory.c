/* Measurement-only counters for actual client connection/stream objects and
 * queued messages. Other raw buffers and allocator pages are excluded. */
static uint64_t client_connections_created, client_connections_finalized;
static uint64_t client_streams_created, client_streams_finalized;
static uint64_t client_messages_created, client_messages_freed;
static uint64_t client_message_requested, client_message_freed, client_message_peak;
static double client_charge(void);
static void client_message_free(g_msg *m) {
    if (m && client_active) {
        client_messages_freed++;
        client_message_freed += sizeof(*m) + m->n + 1;
        if (client_messages_freed > client_messages_created ||
            client_message_freed > client_message_requested) _Exit(209);
    }
    free(m);
}
static void client_call_checkpoint(void) {
    fprintf(stderr,"call-memory\t%llu\t%.0f\t%llu\t%llu\t%llu\n",
        (unsigned long long)client_streams_created,
        client_charge()-client_start_charge,
        (unsigned long long)(client_message_requested-client_message_freed),
        (unsigned long long)(client_connections_created-client_connections_finalized),
        (unsigned long long)(client_streams_created-client_streams_finalized));
}
static void client_transport_end(void) {
    fprintf(stderr,"transport-memory\t%llu\t%llu\t%llu\t%llu\t%llu\t%llu\t%llu\t%llu\t%llu\n",
        (unsigned long long)client_connections_created,
        (unsigned long long)client_connections_finalized,
        (unsigned long long)client_streams_created,
        (unsigned long long)client_streams_finalized,
        (unsigned long long)client_messages_created,
        (unsigned long long)client_messages_freed,
        (unsigned long long)client_message_requested,
        (unsigned long long)client_message_freed,
        (unsigned long long)client_message_peak);
}
