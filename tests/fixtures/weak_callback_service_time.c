/* Ordinary service calls; output checks stay outside each service clock. */
#include "weak_callback_service.h"
#include "callable_phase_clock.h"
#include <errno.h>
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#ifndef SERVICE_FWP
#error "Select SERVICE_FWP explicitly"
#endif
static void fail(const char *message, int status) { fprintf(stderr, "%s\n", message); exit(status); }
static int64_t number(const char *text) {
    if (!*text) fail("invalid integer", 2);
    for (const char *p=text; *p; p++) if (*p<'0' || *p>'9') fail("invalid integer", 2);
    errno=0;
    char *end;
    intmax_t value=strtoimax(text,&end,10);
    if (errno || *end || value>INT64_MAX) fail("invalid integer",2);
    return (int64_t)value;
}
static ServiceStats expected(size_t population, int mode) {
    ServiceStats stats={0};
    for (size_t index=0; index<population; index++) {
        if (mode==2) { stats.expired++; continue; }
        if (mode==1 && index%4==0) { stats.cancelled++; continue; }
        if (mode==3 && index>population/2) continue;
        stats.calls++; stats.sum+=(int64_t)(16*index+120);
    }
    stats.errors=mode==3; stats.sent=stats.received=stats.calls; stats.received_sum=stats.sum;
    return stats;
}
int service_observe(int argc, char **argv) {
    if (argc!=4) fail("expected population mode batches",2);
    int64_t population=number(argv[1]), mode=number(argv[2]), batches=number(argv[3]);
    if ((population!=64 && population!=4096) || mode>3 ||
        (batches!=1 && batches!=16 && batches!=64 && batches!=256 && batches!=1024 && batches!=4096 && batches!=16384))
        fail("invalid experiment arguments",2);
    ServiceStats want=expected((size_t)population,(int)mode), total={0};
    uint64_t elapsed=0;
    for (int64_t batch=0; batch<batches; batch++) {
        uint64_t before=callable_phase_clock();
        ServiceStats stats=service_run((size_t)population,(int)mode);
        uint64_t after=callable_phase_clock();
        if (after<before) fail("clock moved backwards",77);
        elapsed+=after-before;
        if (stats.calls!=want.calls) fail("incorrect service result",4);
        if (stats.cancelled!=want.cancelled) fail("incorrect service result",4);
        if (stats.expired!=want.expired) fail("incorrect service result",4);
        if (stats.errors!=want.errors) fail("incorrect service result",4);
        if (stats.sent!=want.sent) fail("incorrect service result",4);
        if (stats.received!=want.received) fail("incorrect service result",4);
        if (stats.sum!=want.sum) fail("incorrect service result",4);
        if (stats.received_sum!=want.received_sum) fail("incorrect service result",4);
        total.calls+=stats.calls;
        total.cancelled+=stats.cancelled;
        total.expired+=stats.expired;
        total.errors+=stats.errors;
        total.sent+=stats.sent;
        total.received+=stats.received;
        total.sum+=stats.sum;
        total.received_sum+=stats.received_sum;
    }
    printf("{\"population\":%" PRId64 ",\"mode\":%" PRId64 ",\"batches\":%" PRId64
           ",\"calls\":%" PRId64
           ",\"cancelled\":%" PRId64
           ",\"expired\":%" PRId64
           ",\"errors\":%" PRId64
           ",\"sent\":%" PRId64
           ",\"received\":%" PRId64
           ",\"sum\":%" PRId64
           ",\"received_sum\":%" PRId64
           ",\"serviceNs\":%" PRIu64 "}\n", population, mode, batches,
           total.calls, total.cancelled, total.expired, total.errors, total.sent, total.received, total.sum, total.received_sum, elapsed);
    return 0;
}
#if SERVICE_FWP == 0
int main(int argc, char **argv) { return service_observe(argc,argv); }
#endif
