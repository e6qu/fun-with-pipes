#ifndef FWP_WEAK_OPERATION_CENSUS_H
#define FWP_WEAK_OPERATION_CENSUS_H
#include <stdint.h>

typedef struct {
    uint64_t allocations, slot_bytes, some_allocations, some_slot_bytes;
    uint64_t live_bytes, peak_live_bytes;
} ReferenceCosts;
void reference_cost_begin(void);
ReferenceCosts reference_cost_end(void);
int reference_calibrate(const char *control);
#endif
