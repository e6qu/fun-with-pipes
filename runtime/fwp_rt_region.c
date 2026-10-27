/* One invocation owns these blocks. Only proved integer/region-link nodes may
 * live here: there are no child owners or observable finalizers to run. A region
 * address is an explicit internal argument, never ambient thread/task state. */
typedef struct fwp_region_block {
    struct fwp_region_block *next;
    size_t used;
    size_t capacity;
    _Alignas(8) unsigned char data[];
} fwp_region_block;

typedef struct {
    fwp_region_block *blocks;
} fwp_region;

_Static_assert(_Alignof(fwp_obj) <= 8, "region node alignment");
_Static_assert(sizeof(fwp_region_block) % 8 == 0, "region payload alignment");
_Static_assert(sizeof(fwp_obj) % 8 == 0, "region node header alignment");
_Static_assert(sizeof(V) == 8, "region field width");

static void fwp_region_release(void *context) {
    fwp_region *region = (fwp_region *)context;
    fwp_region_block *block = region->blocks;
    region->blocks = NULL;
    while (block) {
        fwp_region_block *next = block->next;
        fwp_mem_free(block);
        block = next;
    }
}

static V fwp_region_data(V context, uint32_t tag, uint32_t count, const V *fields) {
    if (count == 0) return tag;
    size_t bytes;
    if (__builtin_mul_overflow((size_t)count, sizeof(V), &bytes) ||
        __builtin_add_overflow(bytes, sizeof(fwp_obj), &bytes))
        fwp_trap("region node too large");
    fwp_region *region = (fwp_region *)(uintptr_t)context;
    fwp_region_block *block = region->blocks;
    if (!block || bytes > block->capacity - block->used) {
        /* Fixed payload policy for the first measured workspace. Large nodes
         * use one checked exact-size block; no address is invalidated by growth. */
        size_t capacity = bytes > 4096 ? bytes : 4096;
        if (capacity > SIZE_MAX - sizeof(fwp_region_block))
            fwp_trap("region block too large");
        fwp_region_block *fresh = (fwp_region_block *)
            fwp_alloc_unique(sizeof(fwp_region_block) + capacity);
        fresh->next = block;
        fresh->used = 0;
        fresh->capacity = capacity;
        region->blocks = fresh;
        block = fresh;
    }
    fwp_obj *node = (fwp_obj *)(void *)(block->data + block->used);
    node->tag = tag;
    node->n = count;
    for (uint32_t index = 0; index < count; index++) node->f[index] = fields[index];
    block->used += bytes;
    return PTR(node);
}
