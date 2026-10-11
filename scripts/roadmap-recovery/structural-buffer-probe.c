#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
static int mode, doublings;
static size_t requested;
static void *probe_realloc(void *p, size_t n) {
    requested = n;
    if (mode == 4) return NULL;
    if (mode == 3) return p;
    return realloc(p, n);
}
#define realloc probe_realloc
/* BUFFER_IMPLEMENTATION */
#undef realloc
int main(int argc, char **argv) {
    if (argc != 2) return 120;
    mode = atoi(argv[1]);
    fwp_buf b = {0};
    if (mode == 1) {
        buf_grow(&b, 10);
        if (!b.d || b.cap != 64) return 121;
        memcpy(b.d, "preserved", 9); b.len = 9;
        buf_grow(&b, 100);
        if (!b.d || b.cap != 128 || memcmp(b.d, "preserved", 9)) return 122;
        free(b.d); return 0;
    }
    if (mode == 2) { b.len = SIZE_MAX; buf_grow(&b, 0); return 123; }
    if (mode == 3) {
        b.d = (char *)(uintptr_t)16;
        b.len = b.cap = SIZE_MAX / 2 + 1;
        buf_grow(&b, 0);
        return b.cap == b.len + 1 && requested == b.cap ? 0 : 124;
    }
    if (mode == 4) { buf_grow(&b, 10); return 125; }
    return 126;
}
