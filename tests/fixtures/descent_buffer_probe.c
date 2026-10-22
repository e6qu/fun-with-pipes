/* Untimed observation of the two explicit numerical buffers, excluding stdio.
 * The measurement script replaces only the workload's malloc/free calls. */
static void *input_addresses[2];
static size_t input_sizes[2];
static size_t input_requests, input_requested_bytes, input_live_bytes, input_peak_bytes;

static void *input_alloc(size_t bytes) {
    void *value = malloc(bytes);
    if (!value) return NULL;
    for (size_t i = 0; i < 2; ++i) {
        if (!input_addresses[i]) {
            input_addresses[i] = value;
            input_sizes[i] = bytes;
            input_requests++;
            input_requested_bytes += bytes;
            input_live_bytes += bytes;
            if (input_live_bytes > input_peak_bytes) input_peak_bytes = input_live_bytes;
            return value;
        }
    }
    _Exit(227);
}

static void input_free(void *value) {
    if (!value) return;
    for (size_t i = 0; i < 2; ++i) {
        if (input_addresses[i] == value) {
            input_live_bytes -= input_sizes[i];
            input_addresses[i] = NULL;
            input_sizes[i] = 0;
            free(value);
            return;
        }
    }
    _Exit(227);
}

static void observe_inputs(size_t solve) {
    fprintf(stderr, "{\"solve\":%zu,\"inputRequests\":%zu,\"inputRequestedBytes\":%zu,\"inputLiveBytes\":%zu,\"inputPeakBytes\":%zu}\n",
        solve, input_requests, input_requested_bytes, input_live_bytes, input_peak_bytes);
    if (input_live_bytes || input_requests != 2 * solve ||
        input_requested_bytes != 2 * solve * DIMENSIONS * sizeof(double) ||
        input_peak_bytes != 2 * DIMENSIONS * sizeof(double)) _Exit(226);
}
