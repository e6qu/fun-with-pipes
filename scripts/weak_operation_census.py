"""Count actual fwp managed allocations and the successful-upgrade result cell."""
import json

from weak_operation_source import once

CASES = ((1, 1), (64, 16), (4096, 1), (4096, 64))
COSTS = ('allocations', 'slotBytes', 'someAllocations', 'someSlotBytes', 'liveBytes', 'peakLiveBytes')


def instrument(source):
    source = once(source, 'typedef uint64_t V;', '''typedef uint64_t V;
#include "weak_operation_census.h"
static ReferenceCosts reference_costs;
static int reference_in_some;
static size_t reference_phase_peak;
''')
    source = once(source, 'static inline void fwp_heap_charge(size_t bytes) {', '''static inline void fwp_heap_charge(size_t bytes) {
    reference_costs.allocations++;
    reference_costs.slot_bytes += bytes;
    if (reference_in_some) {
        reference_costs.some_allocations++;
        reference_costs.some_slot_bytes += bytes;
    }''')
    source = once(source, '    fwp_heap.live += bytes;', '''    fwp_heap.live += bytes;
    if (fwp_heap.live > reference_phase_peak) reference_phase_peak = fwp_heap.live;''')
    source = once(source, '    V result = fwp_rc_fresh(fwp_some(target));', '''    reference_in_some = 1;
    V result = fwp_rc_fresh(fwp_some(target));
    reference_in_some = 0;''')
    return source + '''
void reference_cost_begin(void) {
    reference_costs = (ReferenceCosts){0};
    reference_phase_peak = fwp_heap.live;
}
ReferenceCosts reference_cost_end(void) {
    if (fwp_heap.live < reference_baseline || reference_phase_peak < reference_baseline) exit(79);
    reference_costs.live_bytes = fwp_heap.live - reference_baseline;
    reference_costs.peak_live_bytes = reference_phase_peak - reference_baseline;
    return reference_costs;
}
int reference_calibrate(const char *control) {
    if (strcmp(control, "ordinary") && strcmp(control, "extra-allocation") && strcmp(control, "omit-free")) {
        fputs("invalid allocation control\\n", stderr); exit(2);
    }
    reference_cost_begin();
    void *first = fwp_mem_alloc(17);
    void *second = fwp_mem_alloc(33);
    if (!strcmp(control, "extra-allocation")) {
        void *extra = fwp_mem_alloc(17);
        fwp_mem_free(extra);
    }
    ReferenceCosts held = reference_cost_end();
    fwp_mem_free(first);
    if (strcmp(control, "omit-free")) fwp_mem_free(second);
    ReferenceCosts released = reference_cost_end();
    return held.allocations == 2 && held.slot_bytes == 80 && held.live_bytes == 80 && held.peak_live_bytes == 80
        && held.some_allocations == 0 && held.some_slot_bytes == 0 && released.live_bytes == 0;
}
'''


def decode_output(text, population, lookups):
    row = json.loads(text)
    assert isinstance(row, dict) and set(row) == {'population', 'lookups', 'live', 'expired', 'phases'}
    assert text == json.dumps(row, separators=(',', ':')) + '\n'
    assert all(type(row[key]) is int for key in ('population', 'lookups', 'live', 'expired'))
    assert (row['population'], row['lookups'], row['live'], row['expired']) == (population, lookups, population * lookups, 0)
    assert isinstance(row['phases'], list) and len(row['phases']) == 6
    for phase in row['phases']:
        assert isinstance(phase, dict) and set(phase) == set(COSTS)
        assert all(type(value) is int and value >= 0 for value in phase.values())
        assert phase['someAllocations'] <= phase['allocations'] and phase['someSlotBytes'] <= phase['slotBytes']
        assert phase['liveBytes'] <= phase['peakLiveBytes']
        assert (phase['allocations'] == 0) == (phase['slotBytes'] == 0)
        assert (phase['someAllocations'] == 0) == (phase['someSlotBytes'] == 0)
    # Successful/expired lookups leave the existing owners intact. Final release
    # returns to the initialized runtime baseline, independent of allocation count.
    phases = row['phases']
    for before, after in zip(phases, phases[1:]):
        assert after['peakLiveBytes'] >= before['liveBytes']
    assert phases[1]['liveBytes'] == phases[2]['liveBytes']
    assert phases[3]['liveBytes'] == phases[4]['liveBytes']
    assert phases[5]['liveBytes'] == 0
    return row
