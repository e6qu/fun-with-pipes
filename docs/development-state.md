# Session handoff

This is preparation for the next compiler delivery on `profile-closed-functions`, based on
`cd4f0b06`. The active delivery is [PR #163](https://github.com/e6qu/fun-with-pipes/pull/163)
in the root checkout on `http-server-delivery`. Finish its evidence and final
production gates there before opening another PR. PR #162 is accepted at
`1b542f32`. The language semantics and runtime ownership rules are unchanged.

## Next action

Next: validate static storage for partial functions whose captures are all fixed
function references, then rerun the unchanged profile and memory/correctness
checks. Baseline [profiling](https://github.com/e6qu/fun-with-pipes/actions/runs/39066197415)
passed on Linux AMD64 and ARM64 at `a141efd4`. Both measured 177 such allocations
and 3,808 requested payload bytes per additional HTTP request, about 20% of all
managed allocation requests. No timing savings are established. Raw artifacts
and the checked summary are under `/private/tmp/fwp-function-profile` and
`/private/tmp/fwp-function-profile-baseline.json`.

The compiler change is local; focused native checks pass, with platform evidence pending. It interns identical partial-function
recipes in static storage, using the existing closure type and typed call path.
Captured values must be literal capture-free functions; zero-argument evaluations,
effects, runtime data and saturated applications keep their original evaluation.
Addresses are filled during existing constant initialization. A small C compile
probe showed that wasm32 rejects a pointer widened to 64-bit V in a static
initializer; explicit startup stores avoid a second target-specific representation.
Measure startup/static-data cost as well as removed per-call allocations. No
runtime owner is permanently retained by these code-only constants.

Acceptance: interpreter agreement, O1/O2 and both memory modes, aliases and repeated
calls, observable effects/traps, dynamic captures, GC/reuse verification, native
platforms and WASI, and the same server profile/memory workload. Inspect actual
static object sizes/initialization and generated calls. Keep the current delivery
head unchanged while its final gates run. Full builds belong on runners; focused
checks use the root guard:
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
captures and avoiding repeated routing work. Static storage is selected from the
measured 177 allocations; routing changes
remain unselected. Preserve effect/trap order and single-argument pipe semantics.

## Checks

Both baseline profile jobs passed. The classifier found 417 eligible source
sites in archived generated server C (guarded, 1.67 s). Web test harness
compilation passed (23.59 s); formatting (1.31 s) and workflow lint (1.47 s)
passed. The existing alias/capture stress test passed at O1/O2, stack on/off
(22.38 s including rebuild). The new fixture matches the interpreter in both
memory modes, with compiler optimization on/off and O1/O2 (9.36 s). Tracing
keeps GC stress/verification and reuse checks; ARC uses its required verification
settings. An initial attempt to enable reuse retention in ARC was rejected by
its existing runtime contract, then corrected in the test. The fixture's initial
function-return effect annotation and function-valued pipe were corrected to the
existing final-arrow effect and composition rules. WASI harness compilation passed
(0.72 s); actual WASI execution belongs on equipped runners. Compiler clippy, workflow lint
and documentation checks passed; Linux runner checks also exercise GCC. No post-change server
allocation savings have been measured yet. Keep delivery
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
