/* Measure the real receive/cache path using messages already queued by HTTP/2.
 * This excludes socket I/O and connection pooling; it is not a remote-call benchmark. */
#undef free
static void observe_free(void *p) {
    if (p) for (size_t i = 0; i < 128; i++) if (queued_messages[i] == p) {
        queued_messages[i] = NULL;
        messages_freed++;
        break;
    }
    free(p);
}
static double charged(void) {
    return (double)fwp_heap.live;
}
static g_cell *next_cell(V value, size_t index) {
    if (value == FWP_NONE) _Exit(20);
    V pair = OBJ(value)->f[0], text = OBJ(pair)->f[0];
    if (STR(text)->len != 16) _Exit(21);
    for (size_t j = 0; j < 16; j++) if (STR(text)->d[j] != (char)('a' + index % 26)) _Exit(22);
    return (g_cell *)(uintptr_t)OBJ(pair)->f[1];
}
int main(int argc, char **argv) {
    if (argc == 2 && !strcmp(argv[1], "--layout")) {
        printf("type\tbytes\talignment\tsource_offset\tcache_offset\treader_offset\twaiters_offset\n");
        printf("cell\t%zu\t%zu\t%zu\t%zu\t-\t-\n", sizeof(g_cell), _Alignof(g_cell), offsetof(g_cell, src), offsetof(g_cell, memo));
        printf("incoming\t%zu\t%zu\t-\t-\t%zu\n", sizeof(g_incoming), _Alignof(g_incoming), offsetof(g_incoming, reader), offsetof(g_incoming, read_waiters));
        return 0;
    }
    if (argc != 3) return 30;
    size_t count = (size_t)strtoul(argv[1], NULL, 10);
    int mode = atoi(argv[2]); /* 0: consume all; 1: stop early; 2: retain first position */
    if (!count || count > 128 || mode < 0 || mode > 2) return 31;
    fwp_lib_init(); fwp_heap_start(); fwp_tasks_init();
    double start = charged();
    measured = 1;
    g_server server = {0}; server.module = "stream-storage";
    g_conn *connection = g_conn_new(FWP_INVALID_SOCKET, "", "queued", &server);
    fwp_rc_fresh(PTR(connection)); /* transferred to the incoming source */
    g_stream *stream = g_stream_new(connection, 1);
    fwp_rc_fresh(PTR(stream)); /* active-list owner */
    fwp_rc_dup(PTR(stream)); /* incoming reader owner */
    stream->remote_end = 1;
    for (size_t i = 0; i < count; i++) {
        g_msg *message = malloc(sizeof *message + 18);
        if (!message) return 32;
        message->next = NULL; message->n = 18;
        message->d[0] = 10; message->d[1] = 16;
        memset(message->d + 2, (int)('a' + i % 26), 16);
        queued_messages[i] = message;
        if (stream->mtail) stream->mtail->next = message;
        else stream->mhead = message;
        stream->mtail = message;
    }
    const int schema[] = {PB_MSG, 1, 1, 4, PB_STR};
    const fwp_desc string_type = {.kind=K_STR, .name="String", .drop=fwp_rc_free_obj};
    g_incoming *source = g_incoming_new("queued.string", strlen("queued.string"));
    source->c = connection; source->s = stream;
    source->dec.schema = schema; source->dec.ty = &string_type;
    g_cell *root = g_cell_new(source);
    g_cell *position = root; /* borrowed while root owns the cache chain */
    g_cell *retained = mode == 2 ? position : NULL;
    if (retained) fwp_rc_dup(PTR(retained));
    unsigned long long setup_requests = requests, setup_bytes = requested_bytes;
    double setup_charge = charged();
    size_t consumed = mode == 1 ? (count + 1) / 2 : count;
    for (size_t i = 0; i < consumed; i++) {
        g_failure failure = {0}; V error = 0; const fwp_desc *error_type = NULL;
        V value = g_force(position, 0, &failure, &error, &error_type);
        if (messages_freed != i + 1 || failure.text || error || error_type) return 33;
        if (!position->forced) return 38;
        unsigned long long before = requests;
        g_msg *next_message = stream->mhead;
        if (g_force(position, 0, &failure, &error, &error_type) != value ||
            requests != before || stream->mhead != next_message) return 34;
        position = next_cell(value, i);
        if (position->src != source) return 39;

    }
    if (mode != 1) {
        g_failure failure = {0}; V error = 0; const fwp_desc *error_type = NULL;
        if (g_force(position, 0, &failure, &error, &error_type) != FWP_NONE) return 35;
        if (!position->forced) return 38;
    }
    if (retained) {
        g_failure failure = {0}; V error = 0; const fwp_desc *error_type = NULL;
        unsigned long long before = requests;
        (void)next_cell(g_force(retained, 0, &failure, &error, &error_type), 0);
        if (requests != before || messages_freed != consumed) return 36;
    }
    /* A 16-byte position plus decoded text and its two wrappers requests
     * at most 81 bytes per element. Keeping both source and cache exceeds it. */
    if (requested_bytes - setup_bytes > 81 * consumed) return 38;
    double after_read = charged();
    size_t queued_before_drop = count - messages_freed;
    g_cell_drop(PTR(root), fwp_rc_free_obj);
    if (retained) g_cell_drop(PTR(retained), fwp_rc_free_obj);
    double after_drop = charged();
    if (after_drop != start || messages_freed != count) return 40;
    measured = 0;
    printf("%zu\t%d\t%zu\t%llu\t%llu\t%llu\t%llu\t%.0f\t%.0f\t%.0f\t%zu\n",
        count, mode, consumed, setup_requests, setup_bytes,
        requests - setup_requests, requested_bytes - setup_bytes,
        setup_charge - start, after_read - start, after_drop - start,
        queued_before_drop);
    fwp_lib_finish();
    if (messages_freed != count) return 37;
    return 0;
}
