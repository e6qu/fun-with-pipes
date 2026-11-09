#include "weak_callback_service.h"
#include <inttypes.h>
#include <stdio.h>
int main(int argc, char **argv) {
    (void)argv;
    if (argc != 1) { fputs("expected no arguments\n", stderr); return 2; }
    const size_t populations[] = {64, 4096};
    for (size_t i = 0; i < 2; i++) {
        size_t population = populations[i];
        for (int mode = 0; mode < 4; mode++) {
            ServiceStats stats = service_run(population, mode);
            printf("{\"population\":%zu,\"mode\":%d,\"calls\":%" PRId64
                   ",\"cancelled\":%" PRId64 ",\"expired\":%" PRId64 ",\"errors\":%" PRId64
                   ",\"sent\":%" PRId64 ",\"received\":%" PRId64 ",\"sum\":%" PRId64
                   ",\"received_sum\":%" PRId64 "}\n", population, mode, stats.calls,
                   stats.cancelled, stats.expired, stats.errors, stats.sent, stats.received,
                   stats.sum, stats.received_sum);
        }
    }
    return 0;
}
