#include <stdint.h>

/* Compile separately without LTO. It does not observe buffer storage. */
int64_t buffer_peer_opaque(int64_t value);
