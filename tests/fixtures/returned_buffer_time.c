/* Ordinary caller: reusable slots outside phases, no allocation/ARC observer. */
#include "returned_buffer_peer.h"
#include "callable_phase_clock.h"
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
    if (argc != 4) fail("expected length population batches", 2);
    int64_t length = number(argv[1]), population = number(argv[2]), batches = number(argv[3]);
    int64_t required = length == 0 || length == 16 ? 4096 : length == 4096 ? 256 : length == 262144 ? 4 : -1;
    if (required == -1 || population != required ||
        (batches != 16 && batches != 64 && batches != 256 && batches != 1024)) {
        fail("invalid experiment arguments", 2);
    }
    ReturnedBuffer *first = malloc((size_t)population * sizeof(*first));
    if (!first) fail("out of memory", 102);
#if BUFFER_SHARED == 1
    ReturnedBuffer *second = malloc((size_t)population * sizeof(*second));
    if (!second) { free(first); fail("out of memory", 102); }
#endif
    int64_t checksum = 0;
    uint64_t construction = 0, reading = 0, release = 0;
    for (int64_t batch = 0; batch < batches; batch++) {
        uint64_t t0 = callable_phase_clock();
        for (int64_t i = 0; i < population; i++) {
            first[i] = returned_buffer_make(length);
#if BUFFER_SHARED == 1
            second[i] = returned_buffer_alias(first[i]);
#endif
        }
        uint64_t t1 = callable_phase_clock();
        for (int64_t i = 0; i < population; i++) checksum += returned_buffer_scan(first[i]);
        uint64_t t2 = callable_phase_clock();
        for (int64_t i = 0; i < population; i++) returned_buffer_release(first[i]);
        uint64_t t3 = callable_phase_clock();
#if BUFFER_SHARED == 1
        for (int64_t i = 0; i < population; i++) checksum += returned_buffer_scan(second[i]);
        uint64_t t4 = callable_phase_clock();
        for (int64_t i = 0; i < population; i++) returned_buffer_release(second[i]);
        uint64_t t5 = callable_phase_clock();
        if (t4 < t3 || t5 < t4) fail("clock moved backwards", 77);
        reading += t4 - t3;
        release += t5 - t4;
#endif
        if (t1 < t0 || t2 < t1 || t3 < t2) fail("clock moved backwards", 77);
        construction += t1 - t0;
        reading += t2 - t1;
        release += t3 - t2;
    }
    free(first);
#if BUFFER_SHARED == 1
    free(second);
#endif
    int64_t expected = length * (length - 1) / 2 * population * batches * (BUFFER_SHARED + 1);
    if (checksum != expected) fail("incorrect result", 4);
    printf("{\"checksum\":%" PRId64 ",\"construction\":%" PRIu64 ",\"reading\":%" PRIu64
           ",\"release\":%" PRIu64 "}\n", checksum, construction, reading, release);
    return 0;
}

#if RETURNED_FWP == 0
int main(int argc, char **argv) { return returned_buffer_observe(argc, argv); }
#endif
