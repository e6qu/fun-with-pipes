# Session handoff

Updated 2026-10-16. [PLAN.md](../PLAN.md) defines completion. None of its seven
whole work areas is complete. This is the current action list; accepted evidence
belongs in [delivery history](roadmap-history.md).

## Active delivery and next batch

[PR #151](https://github.com/e6qu/fun-with-pipes/pull/151) is the only open delivery.
Its final head is `27cdc7ff1b9c59b025159768b11452ab5adbc58c`, in worktree
`/private/tmp/fwp-wasi-delivery`. Production `38872161681` has passed all four macOS jobs, both Windows jobs
and benchmarks; Linux ARM64 has also passed; only Linux AMD64 remains running. Docs
`38872161673` passes for that exact head. Previous head `796f5a4c` did not pass acceptance:
Intel macOS GC exceeded the 90-minute job limit in `38861611494`; the run was
canceled after that timeout. Six jobs had passed, with both Linux jobs unfinished.
The repair assigns tests explicitly using measured durations, keeping full
coverage and existing limits. New tests no longer reshuffle unrelated targets.
Require all nine jobs and docs for the repaired exact head before squash merge.
Accepted #150 is `729db67f71386750aad0bbe477f546e5276b0223`; its duplicate
postmerge production `38860909658` is confirmed canceled.

The next combined batch is now in the main workspace
`/Users/zardoz/projects/fun-with-pipes`, branch `owned-numerics-delivery`, based on
#151's previous head `796f5a4c`. It combines the prepared hash/range and vector
ownership changes and the CI repair, with 221 explicit integration targets
(the repair's 219 plus `range_array` and `vector_ownership`). Once #151 merges, transfer this combined delta onto the verified
squash commit before opening its PR. Do not replay #151's old commit chain.

Preparation sources remain available for evidence: `borrowed-hash-arguments`
through `8d692024` in `/private/tmp/fwp-hash-borrows` (delta after `28cc4d0e`), and
`owned-vector-preparation` through `43947be9` in `/private/tmp/fwp-owned-vectors`
(delta after `aab2a928`). They are already incorporated here, not separate tasks
or additional PRs. Review conflicts preserved #151's allocation counter repair,
accepted history, and the new zero-retain assertions.

Next: merge #151 once its repaired exact-head gates pass. Scalar-splat native/WASI, cost and paired checks below now pass. Rebase only
this batch's delta, publish one substantial PR, then require fresh full production
and documentation acceptance.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Complete deployment and primitive ownership; remove tracing |
| 2 | In progress | Deliver borrowed hash fields and direct range arrays |
| 3 | In progress | Measure remaining C/Rust gaps and inspect generated code |
| 4 | In progress | Reduce derivative recording costs and validate scaling |
| 5 | In progress | Measure lane kernels and resolve runtime OpenCL compilation |
| 6 | In progress | Retain comparable, repeated measurements and storage costs |
| 7 | In progress | Extend maintained programs across deployment boundaries |

## Combined changes

Hash's explicit nonescape proof means its input is used only during the call;
borrowing alone does not imply this. Existing stack placement removes temporary
tuple allocations. Ownership lowering borrows temporary structural-tuple fields
from live owners, including sole-use named fields. It never moves calls, traps or
resource frames. The independent verifier checks owner liveness after every
field; retained aliases and later consumption preserve ordinary ownership.

Immediate inline-integer `range | array.from-list` constructs packed storage
without list nodes. Bounds retain their order; empty/descending ranges remain
empty. Wide size arithmetic rejects oversized arrays before machine-size
conversion, including on 32-bit WASI. I128/U128 retain the existing boxed path.

The nine vector primitives own result wrappers, arrays, boxed integer aliases and
reduction accumulators. Partial construction and replaced accumulators have
cleanup on arithmetic/allocation failures. F128 lanes copy inline payload bits
without retaining temporary scalar boxes. This preserves wrapping integer lane
operations, checked division, float order and manual-record common-prefix behavior.
The new lane example introduces notation and optional results before use. Library
comments/generated docs describe C loops without promising vector instructions.

## Measured vector optimization in progress

Combined revision `3577ba37` passes all six native jobs `38874211385` and both
actual WASI jobs `38874214456`. It resolves F64 array addresses before lane loops,
combines eligible lane pipelines without intermediate lists, and removes sole
immediate product vectors through ordered direct dot. The proof preserves
floating-point order, common-prefix lengths, aliases, effects and first traps.

Cost run `38874218523` passes all four hosts; the retained
[intermediate report](measurements/vector-direct-intermediate-2026-10-16.json)
verifies all source/binary/assembly identities (guarded 0.15 s). On all four
hosts, four/sixty-four-lane checked ARC requests fall from 262,147/65,539 to
131,074/32,770, with zero retains/final storage and 128/1,312 peak charged bytes.
These unpaired runs do not isolate timing improvements. Remaining CPU overhead
is about 4.61/2.07 times C on AMD64 and 5.90/1.91 on ARM64. Generated code still
constructs two splat vectors per iteration.

The following implementation now recognizes both consecutive splats have a sole immediate F64 dot
use: it binds their scalar values once in their original order and reduces the
repeated product directly. Keep the portable size proof, zero-lane evaluation, individually
rounded product, ordered sum, retained aliases and effect/trap order. No generic
constant-function conversion or floating reassociation is allowed. Require fresh
native/WASI gates, four-host allocation/code evidence and paired timings against
original baseline `38869050349`; keep the intermediate evidence visible.
Splat reduction revision `b1a34ea0` passes all six native jobs `38877218687`, both
actual WASI jobs `38877223390` and all four cost jobs `38877226777`. The retained
[final report](measurements/vector-scalar-splats-2026-10-16.json) verifies every
source/binary/assembly identity (guarded 0.20 s): both workloads on every host/mode
use two requests, 40 requested bytes, 48 peak charged bytes, zero retains/final
storage. Both actual ARM64 loops use register state without calls, loads or
stores in their calculation bodies (excerpt validation 0.15 s). Setup and output
are outside those loops; this is not a dynamic cache/spill claim. Same-run C/Rust
ratios and limits are in benchmarks. Paired run `38881665737` passes all four hosts. Its
[retained report](measurements/vector-paired-2026-10-16.json) verifies original
artifact identities, twelve balanced samples and matching profiles (guarded
0.19 s). ARC CPU ratios against baseline are 0.161/0.313 on Linux AMD64,
0.116/0.241 on Linux ARM64, 0.327/0.416 on ARM macOS and 0.270/0.504 on Intel macOS
for four/sixty-four lanes. Benchmarks retain remaining C/Rust gaps; no broad parity
claim follows. The batch is ready for its final-head full production validation.
Eight semantic cases pass the accepted interpreter (guarded 1.36 s); eager stage
arguments print before pipe input and their division trap remains first. A
retained-splat alias case is also included. Formatting passes (1.29 s) and docs
pass (3.15 s). The hot-loop regression counts both initialized-object and leaf
allocation paths and allows only bounded output allocation.

Earlier direct-storage/fusion runs are superseded and unfinished jobs were
canceled: `38872997832`, `38873005668`, `38873505915`, `38873509149`, `38873512960`.
Completed parts remain evidence, not acceptance of the current combined change.
The paired runner now uses `scripts/repeat-revision-comparison.py` with an explicit
hash/vector workload; it verifies matching reference sources and artifact hashes.

## Following ownership preparation

`owned-value-decoders` in `/private/tmp/fwp-owned-decoders`, based on `3577ba37`,
is prepared through `8f848fde`. Only its later delta belongs to the following
batch. It owns ternary, URL/form/HTTP and compressed-byte/WebSocket decoder
results, removes scratch arrays and tests allocation-failure cleanup. At previous
`e912227b`, both WASI jobs passed. Native ternary/text tests passed on Windows,
but web/std-library checks lacked OpenSSL and HTTP/2 curl prerequisites. The
preparation repairs those dependencies and Unix-specific web test handling,
including interpreter console shutdown on Windows. New six-native `38881941135`
and actual WASI `38881944210` are pending. Its handoff records the expanded 22
contracts, 50 distinct remaining review symbols, and 224 explicit macOS targets.
Native compressed-byte helpers remain unavailable on WASI. No second delivery PR
is open; this work remains outside the numerical delta and is not accepted.

## Completed focused checks and measurements

Hash/range compiler revision `ac72124c` passes native `38864599295` on all six
hosts and actual WASI `38864602220` on both Linux hosts. Four-host costs
`38864604854` pass. All source/binary/assembly hashes were verified. The
[borrowed-field report](measurements/hash-borrowed-fields-2026-10-16.json) shows
two managed requests, zero retains and zero final charged storage for both
workloads on all four hosts. Small/large peak charged bytes are 144/32,776.
The inspected ARM64 loop uses a stack tuple and register-held state, with no
allocation or count calls. This is not a dynamic spill/cache measurement.

Two four-host paired runs, `38866837452` and `38867789225`, compare those binaries
against post-fusion baseline `38856285939`. Both pass; their identities agree.
The [paired report](measurements/hash-borrowed-cpu-2026-10-16.json) retains slower
samples and remaining C/Rust overhead. First-run small ARM macOS and large Intel
macOS ARC regressions did not repeat. Small Linux and Intel macOS CPU medians fall
in both runs; large-input changes are generally small. No universal speedup or
parity claim follows from fewer objects/counts. [Benchmarks](benchmarks.md) explain
inputs, timing, ratios, managed/system memory scopes and remaining differences.

Vector runtime revision `637b3eb2` passes native `38867603162` on all six hosts
and actual WASI `38867607803` on both Linux hosts. These include all fifteen
numeric formats, aliases, empty/singleton results, invalid lengths, array views,
wide precision/wrapping, and injected partial-construction/accumulator failures.
Missing-free controls fail as intended. Follow-up `6be8f245` adds the introductory
example, manual-record compatibility case, generated-code capture and the
runner-only C/Rust lane comparison; it does not change the runtime. The extended
fixture and example pass the accepted #148 interpreter (0.25/0.26 s). Their
changed-compiler execution still needs the combined production gate.

Lane costs `38869050349` at `6be8f245` pass all four hosts. The retained
[vector report](measurements/vector-lanes-2026-10-16.json) verifies every source,
binary and assembly hash (guarded 0.20 s). All modes/hosts use 262,147 / 65,539
managed requests for four/sixty-four lanes, zero retains and zero final charged
storage. Linux ARM64 checked ARC takes 11.200 / 3.647 times C's CPU time.
C/Rust stack arrays allocate no application heap storage. These scopes exclude
startup/printing allocation internals differently; benchmarks explain that limit.

Actual code shows three vector constructions per mapped input, materialized
range/result lists and scalar F64 multiply with per-element representation
handling. The C reference uses register calculations and vector instructions.
The direct-storage, pipeline and scalar-splat changes above target those measured
costs while preserving manual-record lengths, boxed ownership and checked
division. This baseline is not a measurement of speedup from adding ownership
contracts.

## Local verification and resolved failures

The hash allocation counter originally missed `fwp_alloc_init`; both fast and
nonduplicated slow paths are now counted, including #151's fix. The strict
zero-retain control caught remaining named array aliases; `ac72124c` repaired
only their sole, pure hash use. Range fixture signatures were made explicit.
No assertion was weakened. Earlier failed/superseded focused runs are historical
evidence, not remaining actions. The intermediate stack/range reports remain
linked from benchmarks so the final changes can be traced.

Vector formatting passed (1.11 s), docs passed (2.81 s), and the inventory audit
passed (1.11 s): 271 contracted declarations, 72 remaining distinct review
symbols. Its frozen baseline was unchanged. Combined formatting (1.29 s), docs (3.00 s)
and inventory (1.30 s) pass. Compiler/runtime/test/workflow sources matched the
prepared `43947be9` tree before the final library-comment clarification. Source-
generated library docs pass after regeneration (1.27 s); the final documentation
audit passes (2.80 s). No changed compiler was built locally. The earlier
local diagnostic compilation stopped with an OS signal error; no process remained
and limits were not raised. Do not restart that refused workload.

The CI repair is incorporated here with 221 explicit targets. Guarded
`python3 scripts/test-macos-test-shards.py` passes (0.30 s);
`python3 scripts/check-roadmap.py` passes (2.82 s). The measured balance projects
about 85.45 minutes per Intel job, which is an estimate, not acceptance. Existing
assignments match #151; only the two new targets were added.

## Delivery rules and remaining direction

Standing authorization covers fixes, publication and squash merge after every
exact-head gate passes. Every commit is one line, at most 80 characters, with
empty body and no trailers or attribution. Verify merged tree, parent and exact
message before canceling duplicate postmerge production. Skipped focused jobs
are not acceptance. Keep one delivery PR open at a time.

Use `python3 scripts/local-guard.py` for serial bounded local checks. Full builds,
suites, benchmarks and large regeneration run on GitHub. Browser/service re-entry,
retained host callbacks, remaining numerical/network contracts, derivative scaling
and broader applications remain open. JIT is excluded; OpenCL's existing runtime
compilation is an implementation gap to resolve, not an exception. Default
tracing remains; this batch does not complete any whole roadmap area.
