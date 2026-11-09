#include "returned_buffer_peer.h"
#include <errno.h>
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>

static void fail(const char *text, int status) {
    fprintf(stderr, "%s\n", text);
    exit(status);
}

static int64_t number(const char *text) {
    const char *digit = text;
    if (*digit == '-') digit++;
    if (!*digit) fail("invalid integer", 2);
    for (; *digit; digit++) if (*digit < '0' || *digit > '9') fail("invalid integer", 2);
    errno = 0;
    char *end;
    intmax_t value = strtoimax(text, &end, 10);
    if (errno || *end || value < INT64_MIN || value > INT64_MAX) fail("invalid integer", 2);
    return (int64_t)value;
}

int returned_buffer_observe(int argc, char **argv) {
    if (argc != 3) fail("expected length repeats", 2);
    int64_t length = number(argv[1]), repeats = number(argv[2]);
    /* Bound this experiment explicitly; do not imply matched allocator failure. */
    if (length > 262144) fail("length exceeds experiment bound", 2);
    if (repeats < 1 || repeats > 64) fail("repeats outside experiment bound", 2);
    int64_t size = length > 0 ? length : 0;
    int64_t expected = size * (size - 1) / 2, checksum = 0;
    for (int64_t repeat = 0; repeat < repeats; repeat++) {
        ReturnedBuffer first = returned_buffer_make(length);
#if BUFFER_SHARED == 1
        ReturnedBuffer second = returned_buffer_alias(first);
#endif
        int64_t value = returned_buffer_scan(first);
        if (value != expected) fail("incorrect result", 4);
        checksum += value;
        returned_buffer_release(first);
#if BUFFER_SHARED == 1
        value = returned_buffer_scan(second);
        if (value != expected) fail("incorrect result", 4);
        checksum += value;
        returned_buffer_release(second);
#endif
#if BUFFER_DIAGNOSTIC == 1
        if (!returned_buffer_clean()) fail("buffer release check failed", 79);
#endif
    }
    printf("%" PRId64 "\n", checksum);
    return 0;
}

#if RETURNED_FWP == 0
int main(int argc, char **argv) { return returned_buffer_observe(argc, argv); }
#endif
