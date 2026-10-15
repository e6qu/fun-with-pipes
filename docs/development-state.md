# Session handoff

Updated 2026-10-16. PR #146 merged as `be890914` after all nine production
jobs and documentation passed. Current [PR #147](https://github.com/e6qu/fun-with-pipes/pull/147)
is at `71c612d0`; production run `38814786923` has eight passing jobs and one
running (Linux AMD64). Documentation passes in
`38814787519`. Do not change its head merely to refresh tracking.

Standing authorization: fix failures, require all nine production jobs and docs
for the exact head, then squash merge with an explicit one-line subject of at
most 80 characters and an empty body. No trailers or attribution. Continue to
the next substantial PR without requesting permission again. JIT is excluded.

## Current preparation and delivery sequence

`move-unboxed-fields` in `/private/tmp/fwp-field-moves` contains the next batch.
Only commits after preparation anchor `a2679ecb` belong to it. No PR is open for
this work. Root `/Users/zardoz/projects/fun-with-pipes` remains on #147 and has a
local handoff update; preserve/reconcile that update when switching branches.
After #147 passes, merge it, fetch main, and rebase only preparation commits after
`a2679ecb` onto the accepted squash. Preserve #147's Windows fixes when resolving
tracking conflicts. Record acceptance, open the next combined PR and run the
full final-head gate. Component runs below are not a substitute for that gate.

[PLAN.md](../PLAN.md) defines the seven remaining work areas. None is complete.
Current changes address ownership, functional overhead, numerical measurements
and larger applications; derivative scaling and the other listed goals remain.

## Roadmap status

| Step | Status | Next concrete work |
|---|---|---|
| 1 | In progress | Accept field transfers and explicit empty-container ownership; extend remaining boundaries |
| 2 | In progress | Measure and remove remaining record wrappers and functional intermediates |
| 3 | In progress | Diagnose the AMD64 matrix gap using generated instructions and controlled timing |
| 4 | In progress | Accept #147 precision fixes; measure derivative timing and memory scaling |
| 5 | Pending | Broaden CPU kernels and resolve runtime OpenCL compilation under the no-JIT policy |
| 6 | In progress | Retain comparable C/Rust results and establish repeatable regression criteria |
| 7 | In progress | Repair and validate the maintained directory application in checked ARC |

Next: inspect combined repair run `38822994702` at `86bdcba6` and fix any remaining application failures; merge #147
only after its exact-head gate passes, then publish the combined preparation.

## Batch scope

- Move a selected field out of an already flattened record when its parent is
  immediately dropped. Release siblings without temporarily retaining the result.
- Transfer typed fields from uniquely owned boxed records and free their outer
  cell. Shared parents still duplicate children; stack records retain their
  existing treatment. Mixed scalar/pointer bits, I128 boxes, shared children,
  shared parents, partial retain failures and later traps have regressions.
- Own working-directory results and temporary OS buffers. `env.cwd` now declares
  `Error[IoError]` and reports kind `cwd` when lookup fails, instead of returning
  a substitute `.` or trapping. Windows tests cover both UTF-16 and UTF-8 scratch
  cleanup during string construction failure. Generated library docs are updated.
- Repair Windows probes: binary stdout, escaped source paths, native file-handle
  checks, explicit `.exe` filenames for ARC symbol inspection. Keep the real
  symbol/cleanup checks; do not skip them on Windows.
- Run the maintained `examples/cli/dirstat.fwp` 192 times over a nested Unicode
  fixture, comparing raw interpretation with tracing/ARC O1/O2 and checking final
  ARC storage. This exposed a rejected static empty-map boundary. Empty maps/sets
  now have an explicit static-result contract; the extended test also checks
  empty aliases, insertion and removal back to empty. Native repair validation
  is pending; do not describe the application as accepted yet.

## Checks and unresolved failures

- Field moves and adjacent ownership regressions pass all six native hosts in
  `38817873592` at `a3d8f16e`. Negative controls restore redundant counts and fail
  as expected. Earlier Windows newline/path probe failures are repaired.
- Working-directory tests pass all six hosts at `713d98ec` in `38819770126`.
  That run fails older Windows ARC file fixtures with unescaped paths; `6b40fb88`
  repairs both real and missing paths. ARC execution then passes both Windows
  hosts in `38820866204`.
- Run `38820866204` fails the new directory application on all six hosts because
  `map.empty` was classified as an uncounted owner. Logs are
  `/private/tmp/fwp-app-linux.log` and `/private/tmp/fwp-app-windows.log`.
  The explicit static contract is published at `f5a38e2e`; changed-compiler CI
  in `38822110000` reaches the next missing contract, Boolean `or`.
  Both `and` and `or` now have explicit immediate-value contracts. A bounded
  harness compiles the application with the existing front end and the current
  ARC contract/scope checker: it reproduces the rejection, then passes (1.42 s)
  with no uncovered primitive. This checks eligibility, not new native emission.
  It is `/private/tmp/fwp-directory-contract-check.py`. The inventory passes
  (0.48 s): 252 contracts, eight scalar signatures, 99 review declarations,
  19 templates and 89 review symbols. Native application acceptance still awaits
  the combined repair in `38822994702`. The superseded `38822110000` is canceled
  after the same missing-Boolean-contract failure on four hosts, freeing its
  unfinished runners. A bounded O1 application mechanism probe using #147's
  downloaded ARM64 compiler and explicit ARC preprocessor mode passes (2.75 s),
  including output parity and final memory. It deliberately bypasses old
  eligibility and does not establish changed-compiler acceptance:
  `/private/tmp/fwp-directory-runtime-check.py`.
- Guarded local formatting passes (1.07 s), extended raw-interpreter application
  passes (1.66 s), and primitive inventory passes (0.61 s): 250 contracts,
  10 scalar signatures, 99 review declarations, 19 templates, 89 review symbols.
  Commands: `python3 scripts/local-guard.py cargo fmt --check`, guarded
  `/private/tmp/fwp-directory-report-raw.py`, and guarded
  `scripts/check-primitive-inventory.py --baseline tests/fixtures/primitive-inventory-baseline.json --output /private/tmp/fwp-static-inventory.json`.
  Existing local compiler predates these changes; local raw/edited-C probes do
  not verify changed emission. All full builds and gates remain on runners.

## Numerical evidence to retain

Solver run `38817877068` at `a3d8f16e` passes Linux/macOS ARM64/AMD64.
Eight matrix products now perform zero retains/nonlast releases and 16 release
checks versus 24/24/56. Forty allocations, 811,648 requested bytes, 101,392 peak
charged bytes, zero final storage/collections and output hashes agree. The two
input wrapper allocations per product remain: fwp uses five versus C/Rust's three.
Artifacts: `/private/tmp/fwp-boxed-numerical-evidence`.

Paired run `38821156704` at `6b40fb88` passes all four hosts using that verified
emitted C. The control restores count traffic for nonfailing inputs, not the
entire old compiler or its overflow scaffolding. Forty rotating samples per
binary and separate profiles compare both memory modes with unchanged arithmetic
and allocations. Artifacts: `/private/tmp/fwp-record-moves-evidence`.
Raw comparisons are retained in `docs/measurements/numerical-record-moves-2026-10-16.json`;
`docs/benchmarks.md` now explains current C/Rust overhead and the separate paired
comparison, including slower results. Guarded consolidation passed (0.13 s).
Linux AMD64's cross-language matrix gap remains; different runner CPUs prevent
attributing cross-run changes solely to record moves.

## Subsequent investigation

A small isolated x86 C compile suggests an output-pointer `restrict` parameter
could give Clang a clearer no-alias promise than a local pointer. Inputs may still
alias. The probe reduced spill/reload annotations from 44/47 to 30/33 and explicit
stack reserve from 168 to 72 bytes. It is neither a runtime change nor a timing
result. Files: `/private/tmp/fwp-matrix-output-alias.c` and `.s`; guarded
`clang -O2 -std=gnu11 -ffp-contract=off -target x86_64-apple-darwin -S` passed
in 0.17 s. Before adoption prove fresh output lifetime, preserve checks/ticks and
floating order, inspect actual inlining/instructions and measure all four hosts.
Do not mark the GC allocator broadly malloc-like: its arena aliases need care.

`scripts/measure-matrix-alias.py` and the `matrix-alias` evidence suite now
compare verified emitted C with its identical loop moved into an always-inlined
helper taking a restrict-qualified output parameter. Only output is disjoint;
inputs may alias. The arithmetic, ticks and all profiles must agree, and symbols
must show no out-of-line helper. This is a runner experiment before any runtime
change. Source transformations and Python syntax pass for all eight downloaded
timing sources. Run `38822697830` passes all four hosts against solver run
`38817877068`, with unchanged profiles and no helper call. It is slower on
Linux AMD64: ARC kernel 1.192× and allocation-inclusive 1.194×; tracing kernel
1.716×. Linux/macOS ARM64 and Intel macOS changes are small and mixed. Actual
AMD64 ARC disassembly has 303 instructions versus 387, 89 stack-addressed
instructions versus 115 and a 376-byte explicit stack reservation versus 472 bytes; both use the same
two-lane multiply/add sequence. Fewer instructions are not a timing gain.
Repeat run `38823092869` passes all four hosts. Both AMD64 runs use EPYC 7763:
ARC allocation-inclusive ratios are 1.194 then 0.883; tracing ratios are 1.528
then 1.207. Reject the candidate: smaller code does not show a dependable portable
gain. Runtime is unchanged. Both runs and actual AMD64 kernels are retained in
`docs/measurements/matrix-output-alias-2026-10-16.json`; benchmarks explain the
negative result. Guarded report consolidation passes (0.13 s). Artifacts:
`/private/tmp/fwp-matrix-alias-evidence`; extracted kernels `/private/tmp/fwp-matrix-{local,parameter}-kernel.asm`.

## Clock and logging extension

Inspection found `time.monotonic` and `time.unix` allocate a one-field Duration
record without a counted-result contract, excluding ordinary `log.info` from
checked ARC. Extend this batch with explicit ownership for these records.
Acceptance: interpreter/native agreement on clock ordering and logging fields
(timestamps naturally differ), repeated ARC cleanup, a missing-count negative
control, tracing stress/reuse and all six native targets. No timing or zero-heap
claim is intended; the existing Duration allocation remains measured overhead.

The clock contract uses existing fresh-leaf ownership: the Duration has only an
I64 field. `tests/clock_ownership.rs` repeats 128 ordered reads, wall-clock reads
and log messages, checks both memory modes and rejects an omitted count with
exit 231. The test exposed an extra blank line in every `log.event`: it appended
a newline before `eprint`, which already appends one. Removing that redundant
append restores one line per event; raw/native log fields are compared while
validating, rather than comparing, timestamps. The first fixture failure exposed
this bug; the corrected edited-C mechanism probe passes (2.46 s). Local formatting
passes (1.07 s), generated stdlib docs regenerate and verify (0.48 s), inventory
passes (0.48 s): 254 contracts, eight scalar signatures, 97 review declarations,
19 templates and 87 review symbols. Actual compiler validation remains on CI.

Clock/logging changes are published at `93156ee0`; six-host combined validation
runs in `38823885563`. The preceding Boolean/static-container/application batch
at `86bdcba6` has five hosts passing in `38822994702`, with Intel macOS still
running. Do not replace these component results with final-head acceptance.
