#include "weak_callback_service.h"
#include <inttypes.h>
#include <stdio.h>
#include <string.h>
int main(int argc, char **argv) {
    if (argc != 3 || (strcmp(argv[1], "64") && strcmp(argv[1], "4096"))
        || strlen(argv[2]) != 1 || argv[2][0] < '0' || argv[2][0] > '3') {
        fputs("expected population 64|4096 and mode 0|1|2|3\n", stderr); return 2;
    }
    size_t population = strcmp(argv[1], "64") == 0 ? 64 : 4096;
    int mode = argv[2][0] - '0';
    ServiceStats stats = service_run(population, mode);
    printf("{\"population\":%zu,\"mode\":%d,\"calls\":%" PRId64
           ",\"cancelled\":%" PRId64 ",\"expired\":%" PRId64 ",\"errors\":%" PRId64
           ",\"sent\":%" PRId64 ",\"received\":%" PRId64 ",\"sum\":%" PRId64
           ",\"received_sum\":%" PRId64 "}\n", population, mode, stats.calls,
           stats.cancelled, stats.expired, stats.errors, stats.sent, stats.received,
           stats.sum, stats.received_sum);
    return 0;
}
