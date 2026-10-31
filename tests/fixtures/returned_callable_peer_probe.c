#include "returned_callable_peer.h"
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifndef RETURNED_PROFILE
#error "Select RETURNED_PROFILE=0 for ordinary or RETURNED_PROFILE=1 for counted execution"
#endif
#if RETURNED_PROFILE
#if !RETURNED_FWP
#error "The managed allocator profile applies only to fwp"
#endif
void returned_phase_begin(void);
void returned_phase_end(int32_t kind, int64_t count, int32_t phase);
int returned_profile_clean(void);
#endif

_Noreturn void returned_failure(const unsigned char *message, size_t length, int status) {
    if (fwrite(message, 1, length, stderr) != length) exit(74);
    exit(status);
}

#if RETURNED_FWP
int returned_observe(int argc, char **argv) {
#else
int main(int argc, char **argv) {
#endif
    if (argc != 2) return 73;
    int omit_release = strcmp(argv[1], "omit-release") == 0;
    if (strcmp(argv[1], "success") == 0 || omit_release) {
        const int64_t counts[] = {0, 1, 16, 4096};
        for (int32_t kind = 0; kind < 2; kind++) {
            for (size_t n = 0; n < sizeof(counts) / sizeof(counts[0]); n++) {
                int64_t count = counts[n], indirect_sum = 0, direct_sum = 0;
#if RETURNED_PROFILE
                returned_phase_begin();
#endif
                returned_callable callable = returned_make(kind, 7);
#if RETURNED_PROFILE
                returned_phase_end(kind, count, 0);
                returned_phase_begin();
#endif
                /* The factory has returned before any call uses the capture. */
                for (int64_t x = 0; x < count; x++) {
                    int64_t expected = (kind + 1) * (7 + x);
#if RETURNED_FWP
                    uint64_t input = (uint64_t)x;
                    int64_t indirect = (int64_t)fwp_apply_borrowed(callable, 1, &input);
#else
                    int64_t indirect = callable.invoke(callable.capture, x);
#endif
                    if (indirect != expected) return 75;
                    indirect_sum += indirect;
                }
#if RETURNED_PROFILE
                returned_phase_end(kind, count, 1);
                returned_phase_begin();
#endif
#if RETURNED_FWP
                if (!omit_release) fwp_closure_drop(callable);
#endif
#if RETURNED_PROFILE
                returned_phase_end(kind, count, 2);
#endif
                /* The direct control is outside the observed invocation phase. */
                for (int64_t x = 0; x < count; x++) {
                    int64_t direct = returned_direct(kind, 7, x);
                    if (direct != (kind + 1) * (7 + x)) return 75;
                    direct_sum += direct;
                }
                int64_t expected_sum = (kind + 1) * (7 * count + count * (count - 1) / 2);
                if (indirect_sum != expected_sum || direct_sum != expected_sum) return 76;
                printf("%" PRId32 " %" PRId64 " %" PRId64 " %zu %zu\n",
                       kind, count, expected_sum, sizeof(callable), _Alignof(returned_callable));
#if RETURNED_FWP
                if (!omit_release && !returned_storage_clean()) return 78;
#endif
#if RETURNED_PROFILE
                if (!omit_release && !returned_profile_clean()) return 78;
#endif
            }
        }
#if RETURNED_FWP
        if (!returned_storage_clean()) return 78;
#endif
#if RETURNED_PROFILE
        if (!returned_profile_clean()) return 78;
#endif
        return 0;
    }
#if RETURNED_FWP
    if (strcmp(argv[1], "recovery") == 0) {
        for (int32_t kind = 0; kind < 2; kind++) {
            for (int32_t completed = 0; completed <= 8; completed += 8) {
#if RETURNED_PROFILE
                returned_phase_begin();
#endif
                int result = returned_recovery(kind, completed);
#if RETURNED_PROFILE
                returned_phase_end(kind, completed, 3);
                if (!returned_profile_clean()) return 78;
#endif
                if (result) return result;
                printf("recovered %d %d\n", kind, completed);
            }
        }
        return 0;
    }
#endif
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
#if RETURNED_FWP
            uint64_t input = (uint64_t)failures[n].input;
            (void)fwp_apply_borrowed(callable, 1, &input);
#else
            (void)callable.invoke(callable.capture, failures[n].input);
#endif
        }
        fputs("overflow control unexpectedly returned\n", stderr);
        return 77;
    }
    return 73;
}
