/* Diagnostic observer inserted after the ordinary peer's includes/types.
 * Records successful allocation API transitions, not malloc's internal overlap,
 * allocator headers or resident pages. Never linked into timing executables. */
static struct { void *pointer; size_t bytes; } parser_storage_slots[2];
static struct { size_t before, after; } parser_storage_events[64];
static size_t parser_storage_count, parser_storage_live, parser_storage_peak;
static size_t parser_storage_requests, parser_storage_bytes;
static int parser_storage_active;
#ifdef PARSER_STORAGE_OMIT_RELEASE
static int parser_storage_omitted;
#endif

static void parser_storage_event(size_t before, size_t after) {
    if (parser_storage_count == 64 || parser_storage_live < before) abort();
    parser_storage_events[parser_storage_count].before = before;
    parser_storage_events[parser_storage_count++].after = after;
    parser_storage_live = parser_storage_live - before + after;
    if (parser_storage_live > parser_storage_peak) parser_storage_peak = parser_storage_live;
    if (after) { parser_storage_requests++; parser_storage_bytes += after; }
}

static void *parser_storage_realloc(void *pointer, size_t bytes) {
    if (!parser_storage_active) return realloc(pointer, bytes);
    size_t slot = 0;
    while (slot < 2 && parser_storage_slots[slot].pointer != pointer) slot++;
    if (slot == 2 || !bytes) abort();
    size_t before = parser_storage_slots[slot].bytes;
    void *next = realloc(pointer, bytes);
    if (next) {
        /* Save the slot before realloc; never inspect its invalidated old pointer. */
        parser_storage_slots[slot].pointer = next;
        parser_storage_slots[slot].bytes = bytes;
        parser_storage_event(before, bytes);
    }
    return next;
}

static void parser_storage_free(void *pointer) {
    if (!parser_storage_active || !pointer) { free(pointer); return; }
    size_t slot = 0;
    while (slot < 2 && parser_storage_slots[slot].pointer != pointer) slot++;
    if (slot == 2) abort();
#ifdef PARSER_STORAGE_OMIT_RELEASE
    if (!parser_storage_omitted) { parser_storage_omitted = 1; return; }
#endif
    parser_storage_event(parser_storage_slots[slot].bytes, 0);
    parser_storage_slots[slot].pointer = NULL;
    parser_storage_slots[slot].bytes = 0;
    free(pointer);
}

static void parser_storage_begin(void) {
    if (parser_storage_active || parser_storage_live) abort();
    for (size_t i = 0; i < 2; i++)
        if (parser_storage_slots[i].pointer || parser_storage_slots[i].bytes) abort();
    parser_storage_count = parser_storage_peak = parser_storage_requests = parser_storage_bytes = 0;
    parser_storage_active = 1;
}

static void parser_storage_finish(void) {
    if (!parser_storage_active) abort();
    parser_storage_active = 0;
    fprintf(stderr, "{\"requests\":%zu,\"requestedBytes\":%zu,\"peakLiveBytes\":%zu,"
            "\"finalLiveBytes\":%zu,\"events\":[", parser_storage_requests,
            parser_storage_bytes, parser_storage_peak, parser_storage_live);
    for (size_t i = 0; i < parser_storage_count; i++)
        fprintf(stderr, "%s[%zu,%zu]", i ? "," : "",
                parser_storage_events[i].before, parser_storage_events[i].after);
    fputs("]}\n", stderr);
    if (parser_storage_live) exit(78);
}

#define realloc parser_storage_realloc
#define free parser_storage_free
