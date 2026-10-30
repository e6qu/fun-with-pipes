/* A5 peer: one runtime-sized buffer, borrowed reads, then destruction.
 * The harness makes each input/result opaque to prevent folding repeated calls.
 * No barrier prevents ordinary optimization within the buffer operation. */
#include <errno.h>
#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#ifndef BUFFER_ENTRY
#error "Set BUFFER_ENTRY explicitly: 0 unique, 1 callback, 2 scan"
#endif
#if BUFFER_ENTRY < 0 || BUFFER_ENTRY > 2
#error "Invalid BUFFER_ENTRY"
#endif
static const char *const buffer_entries[] = {"unique", "callback", "scan"};

static void fail(const char *message, int status) {
    fprintf(stderr, "%s\n", message);
    exit(status);
}

static int64_t number(const char *text) {
    const char *digit = text;
    if (*digit == '-') digit++;
    if (!*digit) fail("invalid integer", 2);
    for (; *digit; digit++)
        if (*digit < '0' || *digit > '9') fail("invalid integer", 2);
    errno = 0;
    char *end;
    intmax_t value = strtoimax(text, &end, 10);
    if (errno || *end || value < INT64_MIN || value > INT64_MAX)
        fail("invalid integer", 2);
    return (int64_t)value;
}

static int64_t add(int64_t left, int64_t right) {
    int64_t result;
    if (__builtin_add_overflow(left, right, &result)) fail("integer overflow", 3);
    return result;
}

static int64_t read_buffer(const int64_t *values, size_t length) {
    return add((int64_t)length, length ? values[0] : 0);
}

static int64_t work(int64_t input) {
    size_t length = input < 0 ? 0 : (size_t)input;
    if (length > (size_t)PTRDIFF_MAX / sizeof(int64_t)) fail("array too large", 3);
    int64_t *values = length ? malloc(length * sizeof(*values)) : NULL;
    if (length && !values) fail("out of memory", 102);
    for (size_t i = 0; i < length; i++) values[i] = (int64_t)i;
    int64_t result = 0;
    if (BUFFER_ENTRY == 2) {
        for (size_t i = 0; i < length; i++) result = add(result, values[i]);
    } else {
        result = read_buffer(values, length);
        if (BUFFER_ENTRY == 0) result = add(result, (int64_t)length);
    }
    free(values);
    return result;
}

int main(int argc, char **argv) {
    if (argc != 4) fail("expected entry length repeats", 2);
    if (strcmp(argv[1], buffer_entries[BUFFER_ENTRY])) fail("invalid entry", 2);
    int64_t length = number(argv[2]), repeats = number(argv[3]);
    if (repeats <= 0) fail("repeats must be positive", 2);
    uint64_t size = length < 0 ? 0 : (uint64_t)length;
    __uint128_t expected = BUFFER_ENTRY == 2
        ? (__uint128_t)size * (size ? size - 1 : 0) / 2
        : (__uint128_t)size * (BUFFER_ENTRY == 0 ? 2 : 1);
    int64_t checksum = 0;
    for (int64_t round = 0; round < repeats; round++) {
        int64_t input = length;
        __asm__ volatile ("" : "+r" (input));
        int64_t result = work(input);
        __asm__ volatile ("" : "+r" (result));
        if (result < 0 || (__uint128_t)result != expected) fail("incorrect result", 4);
        checksum = add(checksum, result);
    }
    printf("%" PRId64 "\n", checksum);
    return 0;
}
