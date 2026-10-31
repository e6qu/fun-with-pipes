#include "returned_callable_peer.h"

#define FAIL(message, status) \
    returned_failure((const unsigned char *)(message), sizeof(message) - 1, status)

static int64_t addition(int64_t capture, int64_t input) {
    int64_t result;
    if (__builtin_add_overflow(capture, input, &result)) {
        FAIL("addition overflow\n", 70);
    }
    return result;
}

static int64_t composition(int64_t capture, int64_t input) {
    int64_t result, sum = addition(capture, input);
    if (__builtin_mul_overflow(sum, INT64_C(2), &result)) {
        FAIL("multiplication overflow\n", 70);
    }
    return result;
}

returned_callable returned_make(int32_t kind, int64_t capture) {
    switch (kind) {
    case 0: return (returned_callable){addition, capture};
    case 1: return (returned_callable){composition, capture};
    default:
        FAIL("invalid callable kind\n", 71);
    }
}

int64_t returned_direct(int32_t kind, int64_t capture, int64_t input) {
    switch (kind) {
    case 0: return addition(capture, input);
    case 1: return composition(capture, input);
    default:
        FAIL("invalid callable kind\n", 71);
    }
}
