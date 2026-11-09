/* Factory and reader compile separately from the caller, without LTO. */
#include "returned_buffer_peer.h"
#include <stdio.h>
#include <stdlib.h>

#if BUFFER_DIAGNOSTIC == 1
static size_t live_buffers;
int returned_buffer_clean(void) { return live_buffers == 0; }
#endif

ReturnedBuffer returned_buffer_make(int64_t input) {
    size_t length = input > 0 ? (size_t)input : 0;
    ReturnedBuffer result = {0};
    result.length = length;
#if BUFFER_SHARED == 1
    result.owners = malloc(sizeof(size_t) + length * sizeof(int64_t));
    if (!result.owners) { fputs("out of memory\n", stderr); exit(102); }
    *result.owners = 1;
    result.data = (int64_t *)(result.owners + 1);
#else
    if (length) {
        result.data = malloc(length * sizeof(int64_t));
        if (!result.data) { fputs("out of memory\n", stderr); exit(102); }
    }
#endif
    for (size_t i = 0; i < length; i++) result.data[i] = (int64_t)i;
#if BUFFER_DIAGNOSTIC == 1
    live_buffers++;
#endif
    return result;
}

int64_t returned_buffer_scan(ReturnedBuffer value) {
    int64_t sum = 0;
    for (size_t i = 0; i < value.length; i++) {
        if (__builtin_add_overflow(sum, value.data[i], &sum)) {
            fputs("integer overflow\n", stderr); exit(3);
        }
    }
    return sum;
}

#if BUFFER_SHARED == 1
ReturnedBuffer returned_buffer_alias(ReturnedBuffer value) {
    (*value.owners)++;
    return value;
}
#endif

void returned_buffer_release(ReturnedBuffer value) {
#if BUFFER_SHARED == 1
    if (--*value.owners != 0) return;
    free(value.owners);
#else
    free(value.data);
#endif
#if BUFFER_DIAGNOSTIC == 1
    live_buffers--;
#endif
}
