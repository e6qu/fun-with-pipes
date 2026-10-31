#include "returned_callable_peer.h"
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

_Noreturn void returned_failure(const unsigned char *message, size_t length, int status) {
    if (fwrite(message, 1, length, stderr) != length) exit(74);
    exit(status);
}

int main(int argc, char **argv) {
    if (argc != 2) return 73;
    if (strcmp(argv[1], "success") == 0) {
        const int64_t counts[] = {0, 1, 16, 4096};
        for (int32_t kind = 0; kind < 2; kind++) {
            for (size_t n = 0; n < sizeof(counts) / sizeof(counts[0]); n++) {
                int64_t count = counts[n], indirect_sum = 0, direct_sum = 0;
                returned_callable callable = returned_make(kind, 7);
                /* The factory has returned before any call uses the capture. */
                for (int64_t x = 0; x < count; x++) {
                    int64_t expected = (kind + 1) * (7 + x);
                    int64_t indirect = callable.invoke(callable.capture, x);
                    int64_t direct = returned_direct(kind, 7, x);
                    if (indirect != expected || direct != expected) return 75;
                    indirect_sum += indirect;
                    direct_sum += direct;
                }
                int64_t expected_sum = (kind + 1) * (7 * count + count * (count - 1) / 2);
                if (indirect_sum != expected_sum || direct_sum != expected_sum) return 76;
                printf("%" PRId32 " %" PRId64 " %" PRId64 " %zu %zu\n",
                       kind, count, expected_sum, sizeof(callable), _Alignof(returned_callable));
            }
        }
        return 0;
    }
    const struct { const char *name; int32_t kind; int64_t capture, input; } failures[] = {
        {"add-max", 0, INT64_MAX, 1},
        {"add-min", 0, INT64_MIN, -1},
        {"composition-add", 1, INT64_MAX, 1},
        {"mul-max", 1, INT64_MAX / 2 + 1, 0},
        {"mul-min", 1, INT64_MIN / 2 - 1, 0},
        {"invalid-kind", 2, 7, 0},
    };
    int direct = strncmp(argv[1], "direct-", 7) == 0;
    const char *name = argv[1] + (direct ? 7 : 0);
    for (size_t n = 0; n < sizeof(failures) / sizeof(failures[0]); n++) {
        if (strcmp(name, failures[n].name) != 0) continue;
        if (direct) {
            (void)returned_direct(failures[n].kind, failures[n].capture, failures[n].input);
        } else {
            returned_callable callable = returned_make(failures[n].kind, failures[n].capture);
            (void)callable.invoke(callable.capture, failures[n].input);
        }
        fputs("overflow control unexpectedly returned\n", stderr);
        return 77;
    }
    return 73;
}
