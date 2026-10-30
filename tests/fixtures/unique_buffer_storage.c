/* Diagnostic malloc/free ledger for the C peer's one buffer. */
static void *buffer_pointer;
static size_t buffer_size, buffer_requests, buffer_bytes, buffer_peak;
static void *buffer_allocate(size_t size) {
    if (buffer_pointer) fail("buffer still live", 225);
    void *pointer = malloc(size);
    if (pointer) {
        buffer_pointer = pointer;
        buffer_size = size;
        buffer_requests++;
        buffer_bytes += size;
        if (size > buffer_peak) buffer_peak = size;
    }
    return pointer;
}
static void buffer_release(void *pointer) {
    if (pointer != buffer_pointer) fail("unexpected buffer release", 225);
    buffer_pointer = NULL;
    buffer_size = 0;
    free(pointer);
}
