#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

/* Already ordered distinct keys, matching the directly constructed fwp set.
 * Hash its canonical bytes: unsigned LEB128 count, then little-endian I64 keys.
 * FNV-1a multiplication wraps modulo 2^64 in all three implementations. */
int main(void) {
    const uint64_t n = 1000000;
    uint64_t *keys = malloc(n * sizeof *keys);
    if (n && !keys) return 1;
    for (uint64_t i = 0; i < n; i++) keys[i] = i;
    uint64_t hash = UINT64_C(0xcbf29ce484222325), count = n;
    do {
        uint64_t byte = count & 0x7f;
        count >>= 7;
        hash = (hash ^ (byte | (count ? 0x80 : 0))) * UINT64_C(0x100000001b3);
    } while (count);
    for (uint64_t i = 0; i < n; i++) {
        for (unsigned shift = 0; shift < 64; shift += 8)
            hash = (hash ^ ((keys[i] >> shift) & 0xff)) * UINT64_C(0x100000001b3);
    }
    printf("%" PRIu64 "\n", hash);
    free(keys);
    return 0;
}
