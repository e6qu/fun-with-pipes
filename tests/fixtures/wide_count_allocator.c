/* Wide reference counts use separately allocated metadata. Count real malloc/
 * free events as well as rc_wide_len; a logical decrement can conceal a leak. */
static size_t wide_live;
static int wide_fail;
static void *wide_allocate(size_t size) {
    if (wide_fail) return NULL;
    void *result = malloc(size);
    if (result) wide_live++;
    return result;
}
static void wide_free(void *entry) {
    if (!entry || !wide_live) _Exit(239);
    wide_live--;
    free(entry);
}
