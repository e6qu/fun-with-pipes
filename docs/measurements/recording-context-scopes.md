# Share validated tape access within closed numeric calls

This contract precedes implementation. Its delivered starting point is
`d992a5734a12cf976c1ca20f75e9829a18bde0cc` ([PR #264](https://github.com/e6qu/fun-with-pipes/pull/264)).
[The delivery receipt](recording-capacity-delivery-2026-11-06/README.md) verifies
the complete platform gates, audit and identical tested/merged tree.

## Observed work

The retained source and census in PR #264 show three registry lookups per
neighboring input pair and update: one inside the numeric map callback, one
inside its nested addition and one inside the fold callback. The current proof
already verifies the whole numeric call graph but shares state only among direct
append calls in one worker. Generated map/fold loops start each callback afresh.

Investigate one coherent group:

1. Pass the existing validated recording state to eligible direct numeric callees.
2. Keep one state around the selected packed neighboring-pair map loop.
3. Keep a separate state around the selected packed numeric-record fold loop.

Do not join these scopes across map/fold boundaries. Do not add public syntax,
process-global state, compatibility entries or hidden execution settings.

## Safety boundary

Prove the complete reachable callback graph before generating borrowed state.
Keep the existing float primitive allowlist, plain numeric fields, acyclic call
graph, expression/depth/type budgets and rejection of branches/unknown calls.
Task-entry ticks disable the transformation. Reject registry creation/retirement,
typed recording, trace hooks, suspension, reentry and resource cleanup.

An append can move tape buffers but cannot move the registry entry. Keep the
existing ID comparison: switching between live tape IDs must validate each new
selection. Retired slots never reuse state from an earlier invocation. Ordinary
function-value entry starts fresh state; direct proven calls can borrow their
caller's state. Use existing worker/boxed entry infrastructure, with explicit
internal parameters and all direct-call paths updated together.

Initialize loop state after setup/allocation and use it only during the loop.
Numeric payloads remain valid while appends grow their separate buffers. End the
borrow before loop-exit boxing or cleanup. A trap unwinds out of the borrow; it
must not resume with cached state. Confirm ownership lowering introduces no
user-code callback inside this proven region.

Preserve arithmetic, evaluation/trap order, mixed-tape checks, parent bounds,
full-tape checks, capacity checks, exact weight bits, allocation order and cleanup.
Typed/nested differentiation keeps its current representation and behavior.

## Required checks

- Extend the existing proof unit tests for nested single-append callees, multiple
  callers, zero-argument calls, rejected recursive/reentrant graphs and exhausted
  analysis budgets. Keep rejected cases negative controls.
- Extend ad_tape_scopes and its lookup probe for forwarded calls and loop-scoped
  lookup counts. Include alternating IDs, inactive nodes, empty/singleton inputs,
  invalid handles, slot reuse, nested traps and complete final release.
- Exercise every direct-call code-generation path, including record-returning
  calls and existing boxed entries. Compare raw interpreter/native results.
- Preserve moving-allocation, native OOM, typed retry, cancellation, workspace,
  reuse-disabled and nested/F128 tests. Run affected targets on production GCC
  ARM64/AMD64 and macOS Clang, with O0/O1/O2 where the existing probe requires it.
- Deliberately break ID switching, lifetime rejection and lookup observation to
  establish that the probes detect those failures.

## Frozen measurements and reference

Use the [capacity protocol](recording-capacity.md#frozen-measurements-and-limits):
six inputs and both result forms, two qualified sessions per native architecture,
Neoverse N2/EPYC 7763, GCC O2, no fast math/contraction/LTO, two warmups and
98 balanced rounds of seven fresh processes. Keep the same seven compiler
inputs with 48 commands each and O1/O2 memory census.
Run each qualified timing session once, after the whole group and focused checks.

For the measured single-tape objective with N >= 2 and positive updates, test
whether lookup counts change from 3*(N-1) to two per update (one map, one fold).
This is a prospective acceptance count, not an observed reduction. Zero-update
programs keep zero recording lookups. Arbitrary inputs may switch tape IDs and
must retain the necessary validations.

Keep allocation/retain counts, eight nodes per pair, parent/capacity checks,
managed/raw peaks and zero final storage unchanged. Retain maximum stack-frame,
code-size, compiler time/RSS, native compile time, process RSS and C/Rust costs.
Keep the existing 5% long-solve target, 2% small/copy limits, 5% compiler limit
and 128-byte largest-frame growth allowance. Timing misses stay explicit under
the agreed retention policy; none of the earlier comparisons closes implicitly.

Build the reference from the same source by changing one internal compile-time
selector, `AD_RECORDING_SCOPES`, from true to false. It disables only the new
forwarding and loop scopes. Keep the existing `AD_RECORDING_LOOKUPS` selection,
append inlining and checked capacity gate enabled in both versions. This is a
measurement edit to a separate source checkout, not a runtime option or public
setting. There is no dependency on an older fwp executable.

With this selector disabled, preserve the previous direct-push admission rule,
local context declaration and generated call arguments. Verify emitted C against
the delivered source for representative direct/nested/loop/negative controls.
Keep analysis bounded at the existing depth 64, expression budget 4096 and type
budget 32. Reuse the existing per-function fact storage; do not compute the new
transitive counts in the disabled comparison. Record compiler time and peak RSS
for both versions, rather than assuming the proof is free.

Require exactly the declared selector edit, all preserved runtime/library/source
hashes, a complete reference patch and corruption controls. Audit every native
image, observation and log. Original-image reconstruction must use the exact
measured C and flags; new native inspection does not create new timing samples.

Finish with all nine final-head production jobs, docs, complete artifact/log
audits, and verified squash merge with one line <=80 characters and empty body.

## Approved hardware amendment, 6 November 2026

The user explicitly approved EPYC **7763, 9V74 and 9V45** as AMD64 peer models.
Record the exact model in each session and compare candidate/reference on that
same host. Recheck the recorded model before timing; another allowed model may
not replace it within a session. Neoverse N2 remains the ARM64 requirement.
Core count, toolchains, inputs, flags, sample counts and every limit above stay
fixed. This changes hardware qualification, not the speed acceptance rule.

- Retain both completed ARM sessions and their sixteen 5% misses; do not rerun.
- Retain all four rejected AMD hosts as pre-build/pre-timing rejections. They
  contain no samples and do not become successful sessions retroactively.
- The completed compiler-cost AMD session used 9V74. Its seven passing numeric
  comparisons are accepted under this amendment, alongside the seven ARM results.
- The two AMD runtime sessions and complete archive audits subsequently finished;
  [the final results](recording-context-time-2026-11-06/README.md) retain their
  misses and copy-control failure alongside the ARM sessions.
- Future compiler-cost runs must qualify hardware before building. The earlier
  workflow recorded the CPU but did not enforce that requirement; the new guard
  fixes this without repeating the completed comparison.

PR #265 was user-merged as `e187b92d75bf936bc7191ea11eeca0c573005399` before
the final production matrix completed. Its tree equals review head
`db94106b3ad2e8c65a384379c653bd395069b5fb`; the squash message is one line.
[PR #266 completed verification](recording-context-delivery-2026-11-06/README.md).
This protocol records the original experiment; it is not an outstanding task.
