/* Inserted into actual emitted C. The source program still parses and walks.
 * Retain one input alias per call; include that retain in the total timer. */
/* DECLARATIONS */
#include <inttypes.h>
static uint64_t parser_token_ns, parser_construct_ns, parser_release_ns;
static size_t parser_nodes, parser_blocks, parser_payload, parser_requested, parser_rounded, parser_unused, parser_heap_allocations, parser_payload;
static uint64_t parser_now(void) {
    struct timespec t;
    if (clock_gettime(CLOCK_MONOTONIC, &t)) exit(90);
    return (uint64_t)t.tv_sec * 1000000000 + (uint64_t)t.tv_nsec;
}
/* MAIN */
int main(int argc, char **argv) {
    if (argc != 5) return 90;
    size_t rounds = strtoull(argv[2], NULL, 10), nodes = strtoull(argv[4], NULL, 10);
    int64_t expected = strtoll(argv[3], NULL, 10);
    if (!rounds || !nodes) return 90;
    FILE *file = fopen(argv[1], "rb");
    if (!file || fseek(file, 0, SEEK_END)) return 90;
    long size = ftell(file);
    if (size < 1 || size > 65536 || fseek(file, 0, SEEK_SET)) return 90;
    char *text = malloc((size_t)size + 1);
    if (!text || fread(text, 1, (size_t)size, file) != (size_t)size || fclose(file)) return 90;
    text[size] = 0;
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts(); fwp_budget = INT32_MAX;
    V input = fwp_rc_fresh(fwp_cstr(text));
    free(text);
    size_t baseline = fwp_heap.live, peak = 0;
    size_t allocations_before = parser_heap_allocations;
    double allocated_before = fwp_heap.total_alloc;
    uint64_t total = 0;
    for (size_t repeat = 0; repeat < rounds; repeat++) {
        fwp_heap.peak = baseline;
        uint64_t begin = parser_now();
        fwp_rc_dup(input);
        V result = @entry@(input);
        total += parser_now() - begin;
        if ((int64_t)result != expected || fwp_heap.live != baseline || fwp_cleanups) return 93;
        if (fwp_heap.peak - baseline > peak) peak = fwp_heap.peak - baseline;
    }
    double allocated = fwp_heap.total_alloc - allocated_before;
    if (!fwp_rc_release_last(input)) return 94;
    fwp_rc_free_obj(input);
    if (fwp_heap.live) return 94;
    if (parser_token_ns + parser_construct_ns + parser_release_ns > total) return 95;
    @node_check@
    printf("{\"rounds\":%zu,\"result\":%" PRId64 ",\"nodes\":%zu,\"tokenizeNs\":%" PRIu64
        ",\"constructNs\":%" PRIu64 ",\"walkAndReleaseNs\":%" PRIu64 ",\"releaseNs\":@release_format@"
        ",\"totalNs\":%" PRIu64 ",\"peakHeapSlotBytes\":%zu,\"allocatedHeapSlotBytes\":%.0f"
        ",\"heapAllocations\":%zu,\"regionBlocks\":%zu,\"regionPayloadBytes\":%zu,\"regionRequestedBytes\":%zu,\"regionRoundedBytes\":%zu,\"regionUnusedBytes\":%zu,\"finalLiveBytes\":%zu}\n",
        rounds, expected, nodes, parser_token_ns, parser_construct_ns,
        total - parser_token_ns - parser_construct_ns, @release_argument@
        total, peak, allocated, parser_heap_allocations - allocations_before, parser_blocks, parser_payload, parser_requested, parser_rounded, parser_unused, fwp_heap.live);
    return 0;
}
