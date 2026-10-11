#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
/* BUMP_ALLOCATOR */
int main(void) {
    void *empty = fwp_alloc(0);
    if (!empty) return 129;
    free(empty);
    unsigned char backing[32];
    fwp_heap_cur = (char *)backing;
    fwp_heap_end = (char *)backing + sizeof(backing);
    if (fwp_alloc(1) != backing || fwp_heap_cur != (char *)backing + 16) return 130;
    fwp_alloc(SIZE_MAX);
    return 128;
}
