# Session handoff

Updated 2026-10-15. [PR #145](https://github.com/e6qu/fun-with-pipes/pull/145)
is being repaired after [run 38772340049](https://github.com/e6qu/fun-with-pipes/actions/runs/38772340049)
failed `tutorial_readmes_match_their_programs` on ARM macOS: the README showed
`sum-pair`/`sum-curried` definitions absent from the tutorial program. Added the
definitions and both example calls to `main.fwp`, its expected output and README.
The fast documentation job now runs the exact consistency check before the long
production suites. The repaired head needs a new full gate; old passes do not
authorize merging it.
The user authorized squash merge after all nine production jobs and documentation
pass, then continuing the roadmap without asking again. Use a single-line
subject of at most 80 characters and an explicitly empty body, with no trailers.

The next batch is being prepared separately on `checked-library-ownership`,
based on PR #145's earlier head `4ff50085`. Do not open its PR until #145 merges. Rebase it
onto the squash commit without replaying #145's commits.

## Roadmap status

| Step | Status | Next concrete work |
|---|---|---|
| 1 | In progress | Check copied C library exports and data-only channel queues without tracing |
| 2 | In progress | Measure remaining closure, container and call costs in representative programs |
| 3 | In progress | Investigate current array and matrix C/Rust gaps; preserve floating-point order |
| 4 | In progress | Investigate sustained derivative timing differences, especially macOS |
| 5 | Pending | Broaden kernels and resolve runtime OpenCL compilation under the no-JIT policy |
| 6 | In progress | Add controlled same-method before/after and ARC-specific timing comparisons |
| 7 | In progress | Extend numerical, collection-heavy and repeated application coverage |

The remaining project criteria are in [PLAN.md](../PLAN.md). JIT is excluded,
not deferred. Every function takes one argument and can return another function;
keep explicit `curry`/`uncurry`, without implicit tuple conversion. Infix
arithmetic complements curried calls and pipes.

## PR #145: implemented and checked

The PR adds fixed-precedence arithmetic, removes unnecessary cleanup around
proved bounded internal array-index increments, omits conservative GC root fences
in checked ARC, and improves benchmark comparability and sample ordering.

Four-host [performance run 38771808755](https://github.com/e6qu/fun-with-pipes/actions/runs/38771808755)
passed at code revision `f42d6226`; head `4ff50085` changed only this handoff.
Linux/macOS ARM64/AMD64 all passed arithmetic raw-interpreter/native comparisons,
array fusion, ARC reclamation, workspace, borrowed callback and pipe tests, plus
numerical, derivative and complete-program measurements.
The earlier focused run's missing helper signatures were fixed and rerun.

Artifacts are downloaded at `/private/tmp/fwp-pr145-performance`; baseline ARM
macOS artifacts are at `/private/tmp/fwp-baseline-macos-arm`. The guarded download
passed in 65.37 seconds. Inspection confirms zero allocations, retains and cleanup
registrations in the fused reduction for 0/1/7/129/257 elements at O1/O2 on all
four hosts. The old baseline recorded 129/257 cleanup registrations for 129/257
elements. ARC assembly reports contain no scan/mark/sweep symbols. The ARM macOS
reduction loop uses scalar registers, loads, multiply/add and index increment;
its body has no per-element cleanup call. This is operation-count and code
inspection evidence, not an isolated timing speedup.

Current numerical and derivative reports retain source, compiler, CPU and raw
samples. Array kernel time remains roughly 1.4–2.5 times C. The sustained paired
metadata case is slightly slower than the separate-allocation control on both
Macs and slightly faster on both Linux runners. Do not call fewer allocations a
universal speedup. New and baseline timing methods differ; a controlled
same-method optimization comparison and ARC-specific timing remain unfinished.

Earlier guarded lexer/parser/formatter checks, `cargo fmt --all -- --check`,
measurement-fixture compilation and `python3 scripts/check-roadmap.py` passed.
Full acceptance is the current production run, not the older focused runs.

## Next batch: checked library and channel ownership

Workload: C hosts repeatedly call string/record, collection and scoped derivative
exports, then release a dynamic library. Existing export wrappers copy string
inputs and release typed values, but returned string pointers are retained for
the library's lifetime and have no host release API.

Implement checked ARC for static/shared native libraries whose inputs are copied
and whose results contain only scalar bits or records of those bits. Reject
returned strings, raw pointers and unproved callbacks. Check every export as an
independent entry with no assumed state or derivative scope. Preserve the existing
ABI and ordinary tracing-library behavior. Host calls must be serialized; this
batch does not establish concurrent entry safety.

Include channels whose payloads contain only data: their existing typed queue
owners already release pending messages, but ARC previously rejected them all.
Reject functions, tasks and channel handles anywhere in a payload; they can
publish a reference back to the queue. Immutable recursive data remains eligible.
Preserve close/drain semantics and cancellation of blocked senders/receivers.

Acceptance: interpreter/host output agreement, bounded live memory over repeated
calls, cleanup after traps, real static linking and repeated dynamic load/unload,
no tracing symbols, and a missing-release control that fails. Exercise O1/O2,
workspace reuse on/off and all supported native platforms. Preserve existing
library input/result/resource/autodiff tests. Full CI runs before merge.
Channel acceptance additionally requires recursive data, closed-send rejection,
timed receive, undrained queue destruction, failure cleanup and blocked task
cancellation, with a missing queue-release control that fails.

Implementation and regression tests are prepared for runner validation. The existing interpreter
validated the fixture output (`5`, `4`, `6.0`, `55`) through the local guard in
0.64 seconds. Guarded `cargo fmt --all` passed in 1.12 seconds. These checks do
not yet verify the changed compiler or library eligibility rules.

The focused library ledger found an allocator accounting bug: the first small
allocation used an uninitialized size-class table and charged zero bytes, while
freeing credited its actual size. Fixed charging during lazy initialization and
added small/large first-allocation controls for all three allocation paths.
The initial probe failed with a -16-byte balance; after the fix, the guarded
runtime probe passed with zero balance for workspace reuse on/off (1.91 s).
`python3 /private/tmp/fwp-library-boundary-check.py` passed (2.11 s): three actual
dynamic unloads each reported zero live-byte balance and zero collections;
omitting result release failed with the expected code 186; the allocator checks
passed. These focused probes use existing compiler output with the changed
runtime and ARC define inserted. CI must still validate the new compiler proof,
static linking, all platforms and the complete tests.
Guarded roadmap audit passed (2.92 s), as did the new Rust test harness's
metadata-only type check against the existing library artifact (0.14 s).
The initial type-check command named a nonexistent top-level rlib; the corrected
command used the existing dependency artifact. No compiler rebuild ran locally.
The focused runner suite is `numerics.yml` with `suite=library` on four hosts;
the Windows production jobs explicitly include the new library test.

Published the library and allocator changes at `6c1440af` and dispatched
[four-host run 38777828868](https://github.com/e6qu/fun-with-pipes/actions/runs/38777828868).
All four hosts passed, including formatting, Clippy and the complete selected
library/allocator regressions. This run predates channel eligibility and does
not verify that addition.
The subsequent channel fixture initially composed a returned function through
`| task.spawn`; corrected it to explicit `compose`, as in the existing task
examples. The raw interpreter passed in 0.60 seconds. The guarded runtime probe
`python3 /private/tmp/fwp-channel-runtime-check.py` matched raw output, reclaimed
queued/cancelled owners, and detected an omitted queue drop (2,112 retained bytes,
expected exit 193; 3.41 seconds). The recursive-data extension also passed the
same probe (3.61 seconds). New compiler proof validation remains on CI. The channel proof was published at
`0c045fc3` and its extended four-host library suite was dispatched.

The guarded `python3 /private/tmp/fwp-tutorial-fix-check.py` passed the exact
README consistency test; interpreter/native tutorial checks and formatting also
passed using the existing compiler (2.63 s). This repairs the failed check without
rebuilding the compiler locally.

## Next action

Next: publish PR #145's tutorial fix, inspect its new final production checks and squash merge once
all pass. Meanwhile finish the separate library batch, publish runner checks and
record actual results here. Keep one active delivery PR. Full builds, suites and
benchmarks stay on runners; focused local checks use
`python3 scripts/local-guard.py COMMAND...` with its fixed resource limits.
