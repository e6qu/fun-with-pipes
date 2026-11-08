# Current work

**Next:** implement the [frozen borrowed-array metadata change](measurements/shared-loop-array-costs.md#selected-implementation-borrowed-array-metadata)
and focused lifetime/value controls, then measure its runtime/compiler costs.
Continue the docs/tutorial refresh in the same PR. The user approved the revised project roadmap and one
substantial normal PR for milestone 1. No next PR has been opened yet.

## Workspace and delivery

Branch `performance-roadmap-review`, worktree `.worktrees/recording-capacity-gate`,
base `bbcaafea00d6bf9e26feea60f90d8d440aa16d00` (user-merged PR #269).
The root worktree has unrelated changes; do not modify/reset it.

The merge tree equals tested `e7965762490c89d2a39f5937fe8322291ea906fc`:
`3a6d513c61e331f86f10824b5a1926b4306db543`. Its squash message is one line,
without trailers. Production run `42422580747` passes all nine jobs;
documentation `42422580660`, job `128553981338`, passes.
Complete production-log audit `42430683595`, job `128578680532`, passes.
[The retained archive](measurements/computed-numeric-delivery-2026-11-08/README.md)
has its verified download digest and complete audit log. No #269 gate remains queued.

## Roadmap status

| Step | Status | Evidence and remaining work |
|---|---|---|
| 1 | In progress | Project roadmap reorganized. Review saved C and costs, freeze the diagnostic/candidate contract, implement a reusable improvement, refresh every doc/tutorial and finish final production checks together. |
| 2 | Pending | Select broader lifetime/representation proofs from measured remaining costs; demonstrate applicability beyond one benchmark. |
| 3 | Pending | Define structured differentiation across three objective families while preserving general reverse AD, nesting and precision. |
| 4 | Pending | Complete current peer/ownership comparisons, including Swift, phase timing and explicit memory boundaries. |
| 5 | Pending | Validate three end-to-end application/tooling paths and compiler phase/scaling costs; fix demonstrated usability gaps. |

## Current evidence and diagnosis

[PR #269 results](measurements/computed-numeric-time-2026-11-07/README.md):
qualified long local-derivative solves take 48–65% less time than ordinary reverse
AD. The largest process removes 407,552 temporary allocations, leaving 1,745,
matching handwritten fwp arrays in request/retain counts. All final storage is
released. Local AD remains 2.6–8.1% slower than handwritten fwp arrays and
4.2–5.7 times handwritten C. Their shared remaining cost is not yet attributed.
One runtime and two compiler timing copy controls remain inconclusive; do not
promote the experimental helper or claim those controls passed.

The latest production benchmark job `128553982216`, artifact `13594660994`,
measured source `e79657624`, uses AMD EPYC 7763/GCC 15.2/Rust 1.99.1.
The checked loop takes 159.768 ms versus C 128.769 and Rust 106.924 ms,
with zero managed requests/retains. Six rotated whole-process samples make this
a diagnostic snapshot, not a new acceptance comparison. Native allocator/RSS
and managed storage are different observations.

Saved sources are in `/tmp/fwp-269-bench.zip` (original artifact) and
`/tmp/fwp-269-loop-bench-evidence-e7965762490c89d2a39f5937fe8322291ea906fc-3757-loop-generated.c`.
`/tmp/fwp-computed-129.c` is the measured ARM2 local-derivative program.
The loop already has unboxed state and no scheduler ticks. Its checked I64
multiply deliberately exposes `x * y` after a successful overflow check to retain
operand-range information (`Scalar::arith`); do not call that a bug or remove it
without a controlled comparison. Numeric loop state currently types F32/F64
fields, with other fields as value words; this is a source observation, not an
established cause or selected optimization.

The first diagnostic changed only borrowed-array callback declarations in emitted
C to force inlining. It passed all 18 cases on each architecture in run
`42433452458` at `7a8d24c2efe475dacf6018fda03340253a4d7559`.
[Complete retained results](measurements/loop-array-diagnosis-2026-11-08/README.md)
show no useful gain; largest manual/local cases are 1.11–2.04% slower. Both
archive hashes match metadata; all builds have empty stderr. Many smaller copy
controls fail. Do not ship forced inlining or repeat this unchanged experiment.
Five local source/schedule controls pass under the guard (0.13 s). A saved-input
path overwrite in the diagnostic is repaired: single/repeated sources now have
different paths. Original archived evidence and this limitation are preserved.
The initial dispatch `42433311089` failed before starting runners: adding the suite
made `numerics.yml` 512,104 bytes, above GitHub's 512,000-byte limit. Shorter input
descriptions reduce it to 511,678 bytes without changing execution. The focused
workflow-size and five-row roadmap/handoff checks pass (guard: 0.13 s). Future
workflow additions must check this limit before publication.

## Documentation work

All 372 Markdown files from the base are materialized; 24 tutorial READMEs
have runnable source/output copies. Lessons 1–20 have been reviewed and edited;
21–24 and the wider reference/evidence sweep remain. Review is not complete.
Lesson 7 now returns a `fahrenheit` field instead of mislabeling Fahrenheit as
`celsius`; its source/transcript copies change together. Native session execution
and formatter validation still need the runner. The standalone all-tutorial
copy-check harness compiled under the guard (0.38 s). Small factual fixes
already correct stale private-pair delivery status in ownership, the README's
old direction, and #269's passed production coverage in design. The measurement
index now records delivered gradient-call storage and dates older CPU experiments;
continue checking obsolete directions during the sweep. Preserve historical measurements/contracts.
Keep live work in PLAN/handoff, semantics in reference/design, and evidence in
measurement records. Cross-link rather than duplicating status histories.

## Checks and resource limits

The guarded source/archive preparation restored 305 sparse Markdown files and
read the saved loop C (0.25 s, 0.06 s sampled CPU). No binaries were executed and
no local build/benchmark was run. Disk: 89 GiB free; minimum 64 GiB. Local focused
checks use `scripts/local-guard.py`, serially, below 1 GiB RSS/2 GiB target and
180 seconds. Full suites, benchmarks and large audits stay on GitHub.

Next milestone validation has not run. Keep one active normal PR, group related
fixes, audit every completed target/diagnostic, and run the full final matrix once
the batch is ready. No draft PR unless explicitly requested. Existing failures
are repaired, not hidden; frozen timing misses are retained, not rerun for a pass.
