/* Exercise the installed allocator. The debugger reads arguments and return
 * values; neither it nor this program accesses an allocation after release. */
#include <errno.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

volatile int parser_probe_case;
volatile size_t parser_probe_request;

static void exercise(int mode, size_t before, size_t after) {
    unsigned char *old = malloc(before);
    volatile unsigned char *barrier = malloc(128);
    if (!old || !barrier) exit(91);
    for (size_t i = 0; i < before; i++) old[i] = (unsigned char)(i % 251);
    for (size_t i = 0; i < 128; i++) barrier[i] = (unsigned char)i;
    uintptr_t old_address = (uintptr_t)old;
    parser_probe_case = mode;
    parser_probe_request = after;
    errno = 0;
    unsigned char *result = realloc(old, parser_probe_request);
    int observed_errno = errno;
    parser_probe_case = 0;
    if (mode == 4) {
        if (result || observed_errno != ENOMEM) exit(92);
        for (size_t i = 0; i < before; i++) if (old[i] != (unsigned char)(i % 251)) exit(93);
        free(old);
    } else {
        if (!result) exit(94);
        size_t preserved = before < after ? before : after;
        for (size_t i = 0; i < preserved; i++) if (result[i] != (unsigned char)(i % 251)) exit(95);
        int moved = (uintptr_t)result != old_address;
        if (moved != (mode == 2)) exit(96);
        free(result);
    }
    for (size_t i = 0; i < 128; i++) if (barrier[i] != (unsigned char)i) exit(97);
    free((void *)barrier);
}
int main(int argc, char **argv) {
    (void)argv;
    if (argc != 1) return 2;
    exercise(1, 64, 72);
    exercise(2, 128, 8192);
    exercise(3, 8192, 4096);
    exercise(4, 128, SIZE_MAX);
    puts("in-place-growth moving shrink failed-old-preserved");
    return 0;
}
