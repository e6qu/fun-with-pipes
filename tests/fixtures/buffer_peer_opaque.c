#include "buffer_peer_opaque.h"

int64_t buffer_peer_opaque(int64_t value) {
    __asm__ volatile ("" : "+r" (value));
    return value;
}
