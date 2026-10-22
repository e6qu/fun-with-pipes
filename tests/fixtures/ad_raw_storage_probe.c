/* Measurement-only ledger for raw numeric derivative allocations. It observes
 * successful allocator requests, independently of the runtime's tape pointers.
 * It does not count allocator metadata, temporary realloc copies or managed
 * typed weights. The fixed observer storage is excluded from process-RSS runs. */
enum { AD_REGISTRY, AD_PARENTS, AD_PARTIALS, AD_ADJOINTS, AD_RAW_KINDS };
typedef struct { void *pointer; size_t bytes; unsigned kind; } ad_raw_block;
static ad_raw_block ad_raw_blocks[4096];
static size_t ad_raw_live[AD_RAW_KINDS], ad_raw_peak[AD_RAW_KINDS];
static size_t ad_raw_requests[AD_RAW_KINDS], ad_raw_bytes[AD_RAW_KINDS];
static size_t ad_raw_total_peak;
typedef struct { size_t registry, workspace, other; } ad_raw_checkpoint;
static ad_raw_checkpoint ad_raw_checkpoints[8192];
static size_t ad_raw_checkpoint_count, ad_raw_before_shutdown;

static void ad_raw_fail(const char *reason) {
    fprintf(stderr, "derivative storage observer: %s\n", reason);
    exit(232);
}
static size_t ad_raw_total(void) {
    size_t result = 0;
    for (unsigned i = 0; i < AD_RAW_KINDS; i++) result += ad_raw_live[i];
    return result;
}
static ad_raw_block *ad_raw_find(void *pointer) {
    for (size_t i = 0; i < sizeof ad_raw_blocks / sizeof *ad_raw_blocks; i++)
        if (ad_raw_blocks[i].pointer == pointer) return &ad_raw_blocks[i];
    ad_raw_fail(pointer ? "untracked allocation" : "observer capacity exceeded");
    return NULL;
}
static void ad_raw_record(ad_raw_block *block, void *result, size_t bytes, unsigned kind) {
    ad_raw_live[kind] -= block->bytes;
    ad_raw_live[kind] += bytes;
    *block = (ad_raw_block){result, bytes, kind};
    ad_raw_requests[kind]++;
    ad_raw_bytes[kind] += bytes;
    if (ad_raw_live[kind] > ad_raw_peak[kind]) ad_raw_peak[kind] = ad_raw_live[kind];
    size_t total = ad_raw_total();
    if (total > ad_raw_total_peak) ad_raw_total_peak = total;
}
static void *ad_raw_realloc(void *pointer, size_t bytes, unsigned kind) {
    if (kind >= AD_RAW_KINDS || !bytes) ad_raw_fail("invalid allocation request");
    ad_raw_block *block = ad_raw_find(pointer);
    if (pointer && block->kind != kind) ad_raw_fail("allocation kind changed");
    void *result = realloc(pointer, bytes);
    if (result) ad_raw_record(block, result, bytes, kind);
    return result; /* Failed realloc still owns the old block. */
}
static void *ad_raw_calloc(size_t count, size_t bytes, unsigned kind) {
    if (kind >= AD_RAW_KINDS || !bytes || !count || count > SIZE_MAX / bytes)
        ad_raw_fail("invalid calloc size or kind");
    ad_raw_block *block = ad_raw_find(NULL);
    void *result = calloc(count, bytes);
    if (result) ad_raw_record(block, result, count * bytes, kind);
    return result;
}
static void ad_raw_free(void *pointer) {
    if (!pointer) return;
    ad_raw_block *block = ad_raw_find(pointer);
    ad_raw_live[block->kind] -= block->bytes;
    memset(block, 0, sizeof *block);
    free(pointer);
}
static void ad_raw_sample(size_t registry, size_t workspace) {
    size_t total = ad_raw_total();
    if (ad_raw_live[AD_REGISTRY] != registry || total < registry + workspace)
        ad_raw_fail("runtime capacity exceeds observed allocation");
    if (ad_raw_checkpoint_count == sizeof ad_raw_checkpoints / sizeof *ad_raw_checkpoints)
        ad_raw_fail("checkpoint capacity exceeded");
    ad_raw_checkpoints[ad_raw_checkpoint_count++] =
        (ad_raw_checkpoint){registry, workspace, total - registry - workspace};
}
static void ad_raw_report(void) {
    if (ad_raw_total()) ad_raw_fail("unreleased raw derivative storage");
    fprintf(stderr, "{\"rawDerivativeStorage\":{\"peakBytes\":%zu,\"beforeShutdownBytes\":%zu,\"finalBytes\":%zu,\"kinds\":{",
            ad_raw_total_peak, ad_raw_before_shutdown, ad_raw_total());
    const char *names[] = {"registry", "parents", "partials", "adjoints"};
    for (unsigned i = 0; i < AD_RAW_KINDS; i++)
        fprintf(stderr, "%s\"%s\":{\"requests\":%zu,\"requestedBytes\":%zu,\"peakBytes\":%zu}",
                i ? "," : "", names[i], ad_raw_requests[i], ad_raw_bytes[i], ad_raw_peak[i]);
    fputs("},\"afterBackward\":[", stderr);
    for (size_t i = 0; i < ad_raw_checkpoint_count; i++) {
        ad_raw_checkpoint point = ad_raw_checkpoints[i];
        fprintf(stderr, "%s{\"registryBytes\":%zu,\"workspaceBytes\":%zu,\"otherBytes\":%zu}",
                i ? "," : "", point.registry, point.workspace, point.other);
    }
    fputs("]}}\n", stderr);
}
