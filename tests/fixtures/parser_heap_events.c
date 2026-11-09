/* Diagnostic events only: libc output does not allocate in fwp's managed heap.
 * No event is used as a timing or RSS measurement. */
static int parser_event_phase = -1;
static size_t parser_event_count;

static int parser_event_active(void) {
    if (parser_event_phase < 0 || parser_event_phase == 4) return 0;
    if (++parser_event_count > 131072) exit(97);
    return 1;
}

static void parser_heap_event(const char *kind, const void *address,
                              size_t requested, size_t charged, size_t live) {
    if (!parser_event_active()) return;
    if (printf("{\"event\":\"%s\",\"phase\":%d,\"address\":%llu,"
               "\"requested\":%zu,\"charged\":%zu,\"heapLive\":%zu}\n",
               kind, parser_event_phase, (unsigned long long)(uintptr_t)address,
               requested, charged, live) < 0) exit(97);
}

static void parser_region_event(const char *kind, const void *block, const void *node,
                                size_t bytes, size_t used, size_t capacity) {
    if (!parser_event_active()) return;
    if (printf("{\"event\":\"%s\",\"phase\":%d,\"block\":%llu,\"node\":%llu,"
               "\"bytes\":%zu,\"used\":%zu,\"capacity\":%zu}\n",
               kind, parser_event_phase, (unsigned long long)(uintptr_t)block,
               (unsigned long long)(uintptr_t)node, bytes, used, capacity) < 0) exit(97);
}

static void parser_resize_event(const char *kind, const void *old, const void *fresh,
                                size_t before, size_t after) {
    if (!parser_event_active()) return;
    if (printf("{\"event\":\"%s\",\"phase\":%d,\"old\":%llu,\"fresh\":%llu,"
               "\"before\":%zu,\"after\":%zu}\n",
               kind, parser_event_phase, (unsigned long long)(uintptr_t)old,
               (unsigned long long)(uintptr_t)fresh, before, after) < 0) exit(97);
}

void parser_memory_checkpoint(unsigned phase) {
    if (phase > 4 || (int)phase != parser_event_phase + 1) exit(97);
    parser_event_phase = (int)phase;
    if (phase == 0) fwp_heap.peak = fwp_heap.live;
    if (printf("{\"event\":\"checkpoint\",\"phase\":%u,\"heapLive\":%zu,"
               "\"heapPeak\":%zu,\"nodes\":%zu,\"regionHeader\":%zu}\n",
               phase, fwp_heap.live, fwp_heap.peak, parser_memory_nodes,
               sizeof(fwp_region_block)) < 0) exit(97);
    if (fflush(stdout)) exit(97);
}
