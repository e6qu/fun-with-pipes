/* Serial callback service. The receiving queue owns each delivered payload.
 * Diagnostic builds count actual allocations/frees; plain builds omit counters. */
#include "weak_callback_service.h"
#include <stdio.h>
#include <stdlib.h>

typedef struct Target Target;
typedef struct { size_t owners; Target *target; } Weak;
typedef struct { int64_t *values; Weak *weak; } Pending;
struct Target { size_t owners, length; int64_t **inbox; Weak *weak; };
#ifndef SERVICE_DIAGNOSTIC
#error "Select SERVICE_DIAGNOSTIC=0 or 1 explicitly"
#endif
#if SERVICE_DIAGNOSTIC != 0 && SERVICE_DIAGNOSTIC != 1
#error "Invalid service observation policy"
#endif
#if SERVICE_DIAGNOSTIC == 1
static size_t payloads, targets, controls, queues;
#endif

static void *allocate(size_t bytes) {
    void *result = malloc(bytes);
    if (!result) exit(91);
    return result;
}
static void drop_payload(int64_t *payload) {
    if (!payload) return;
#if SERVICE_DIAGNOSTIC == 1
    payloads--;
#endif
    free(payload);
}
static void drop_weak(Weak *weak) {
    if (!weak) return;
    if (--weak->owners == 0) {
#if SERVICE_DIAGNOSTIC == 1
        controls--;
#endif
        free(weak);
    }
}
static void drop_pending(Pending *entry) {
    drop_payload(entry->values);
    drop_weak(entry->weak);
    *entry = (Pending){NULL, NULL};
}
static void drop_target(Target *target) {
    if (--target->owners != 0) return;
    target->weak->target = NULL;
    drop_weak(target->weak);
    for (size_t i = 0; i < target->length; i++) drop_payload(target->inbox[i]);
#if SERVICE_DIAGNOSTIC == 1
    queues--;
#endif
    free(target->inbox);
#if SERVICE_DIAGNOSTIC == 1
    targets--;
#endif
    free(target);
}
static int64_t sum_payload(const int64_t *payload) {
    int64_t result = 0;
    for (size_t lane = 0; lane < 16; lane++) result += payload[lane];
    return result;
}
/* Nonzero is a handled callback error, after delivering this payload. */
static int callback(Target *active, Pending *entry, int fail, ServiceStats *stats) {
    stats->calls++;
    stats->sum += sum_payload(entry->values);
    active->inbox[active->length++] = entry->values;
    entry->values = NULL;
    stats->sent++;
    return fail;
}
ServiceStats service_run(size_t population, int mode) {
    ServiceStats stats = {0};
    Target *target = allocate(sizeof(*target));
    Weak *weak = allocate(sizeof(*weak));
    *weak = (Weak){1, target};
    *target = (Target){1, 0, allocate(population * sizeof(int64_t *)), weak};
#if SERVICE_DIAGNOSTIC == 1
    targets++; controls++; queues++;
#endif
    Pending *pending = allocate(population * sizeof(*pending));
#if SERVICE_DIAGNOSTIC == 1
    queues++;
#endif
    for (size_t i = 0; i < population; i++) {
        int64_t *values = allocate(16 * sizeof(*values));
#if SERVICE_DIAGNOSTIC == 1
        payloads++;
#endif
        for (size_t lane = 0; lane < 16; lane++) values[lane] = (int64_t)(i + lane);
        weak->owners++;
        pending[i] = (Pending){values, weak};
    }
    if (mode == 2) { drop_target(target); target = NULL; }
    for (size_t i = 0; i < population; i++) {
        Pending *entry = &pending[i];
        if (mode == 1 && i % 4 == 0) { stats.cancelled++; drop_pending(entry); continue; }
        Target *active = entry->weak->target;
        if (!active) { stats.expired++; drop_pending(entry); continue; }
        active->owners++;
        int error = callback(active, entry, mode == 3 && i == population / 2, &stats);
        drop_target(active);
        drop_pending(entry);
        if (error) { stats.errors++; break; }
    }
    for (size_t i = 0; i < population; i++) {
        drop_pending(&pending[i]);
    }
#if SERVICE_DIAGNOSTIC == 1
    queues--;
#endif
    free(pending);
    if (target) {
        for (size_t i = 0; i < target->length; i++) {
            stats.received++;
            stats.received_sum += sum_payload(target->inbox[i]);
        }
        drop_target(target);
    }
#if SERVICE_DIAGNOSTIC == 1
    if (payloads || targets || controls || queues) {
        fputs("service storage not released\n", stderr);
        exit(79);
    }
#endif
    return stats;
}
