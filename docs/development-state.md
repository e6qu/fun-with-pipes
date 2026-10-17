# Session handoff

This is measurement preparation on `profile-closed-functions`, based on
`cd4f0b06`. The active delivery is [PR #163](https://github.com/e6qu/fun-with-pipes/pull/163)
in the root checkout on `http-server-delivery`. Finish its evidence and final
production gates there before opening another PR. PR #162 is accepted at
`1b542f32`. This preparation changes no language or runtime behavior.

## Next action

Next: validate the function-capture counter, then measure it on both Linux
architectures using the existing HTTP server and 1/16/256 sequential requests.
Do not select an optimization until executed allocation costs are known. Full
builds and measurements belong on runners. Local checks use the root guard:
`python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py COMMAND...`.

The current server uses about 899 managed allocations and 2,318 retains per
request, plus background activity. Generated code shows repeated partial
applications whose captures are themselves known, capture-free functions. A
partial application supplies some arguments and returns a function waiting for
the rest. These particular captures are fixed for the program lifetime; the
experiment counts how often their function records are allocated.

`scripts/instrument-closed-functions.py` reads allocation-counted C and counts
only literal function-reference underapplications. It excludes saturated calls,
runtime captures, nested applications and zero-argument constant evaluation.
It records source sites, names, capture IDs and native payload sizes. Counters
use the existing managed-memory interval. No timing or ordinary machine-call
frequency claim is made. Output uses an explicit file to avoid filling the
server stderr pipe during shutdown.

The intended runner probe compares outputs with an ordinary server and the
interpreter, uses three fresh processes per request count, and retains raw
source/binaries/counters. Candidates include static storage for proved constant
captures and avoiding repeated routing work. Neither is selected or implemented;
preserve effect/trap order and single-argument pipe semantics.

## Checks

No executed allocation profile yet. The classifier found 417 eligible source
sites in archived generated server C (guarded, 1.67 s). Web test harness
compilation passed (23.59 s); formatting (1.31 s) and workflow lint (1.47 s)
passed. These validate preparation, not measured runtime savings. Keep delivery
acceptance and merge decisions for PR #163 in the root handoff.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Server acceptance; remaining host owners and tracing removal |
| 2 | In progress | Measure and remove intermediate function storage and counts |
| 3 | In progress | C/Rust gaps, code size and register/cache use |
| 4 | In progress | Differentiation precision, speed and memory scaling |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Comparable repeated measurements with explicit scopes |
| 7 | In progress | Larger representative applications |
