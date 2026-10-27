# Current work

**Next:** add A5's generated-program, failure/cancellation and representation
controls, then compile and run the complete focused batch on GitHub. Work is isolated in `/private/tmp/fwp-unique-array`,
branch `unique-array-storage`. PR #218 remains the only open PR; monitor its
production run `40480893046` at `4e504ee381d1d85f2172b508459d026300013ba5` and
squash-merge only after all gates pass. Documentation `40480892776`, analysis
`40480891997` and the benchmark job have passed. No platform failures reported.

A5 preparation is **unverified**: `src/rc/unique.rs` is a proof draft with controls,
connected to local I64 array generation but not yet compiled. It checks one release per
normal path, rejects independent owners and requires nonescaping borrowed calls.
The allocator draft separates chunk headers from count arrays and adds a unique
allocation kind with no count slots. The backend draft selects it for known capture-free I64 generators whose
verified ownership body has one release and only nonescaping borrowed uses.
Metadata probes now cover absent unique counts and counted/unique chunk reuse,
but the Rust compiler/tests have not been built. Extend teardown/physical
observers and accounting before any claim of support. A guarded local diagnostic
replaced the saved GCC-generated C's complete allocator section with the current
allocator source (no compiler build). Clang O1/O2 passed zeroed unique storage,
reuse, 301-owner wide counts and zero final live growth. It observed a 40-byte
chunk header and 8-byte count pointer. This is not GCC or whole-compiler proof. Counted chunks now use a
separate count allocation; measure its added pointer lookup and allocation cost. `/private/tmp/fwp-a5-review.md` records allocator
options, exact source paths and the required physical-release/metadata controls.
A stale ownership-module comment about tracing and the Windows failure-artifact
step label were corrected. The working-tree primitive inventory passes (394 declarations, 384 symbols,
40 aliases); its recorded HEAD is the base commit, not a published A5 source.
Formatting passes. The 40-byte chunk-header probe covers all count slots; unique
chunks have null count pointers, including counted/unique big-chunk reuse.
Native metadata probes and generated-array probes are drafted but have not run
with the current compiler. They require absent count metadata, exactly one free,
partial-failure cleanup and rejection of omitted-free/extra-count controls.
The fixture's raw-interpreter outputs and formatting pass with the verified #217
compiler artifact; this is not new-backend verification. The `unique-arrays`
focused suite builds current source and runs unit, allocator, array/unwind and
library-unload checks plus Clippy on native Linux AMD64/ARM64 in one batch.
All following A2/A3 evidence belongs to PR #218, not to verified A5 support.

## Current batch

- Worktree: `/private/tmp/fwp-arc-residual-costs`; branch `arc-residual-costs`.
- Base: `9dfa014596e1954e3e67c653123dad77a14f5241`, the verified #217 squash merge.
- Added a current-compiler [A2 protocol](measurements/arc-residual-costs.md) for
  channel payloads, cached-map reads, word frequency, packed descent and a
  runtime-sized numeric buffer. Both native hosts pass run `40474903463` at
  `405bcfde48afdc07267c76251ac3c70a0d346e97`: all 13 cases agree between hosts,
  all repetitions agree and the omitted-observation control is rejected. The
  checked report is `measurements/arc-residual-baseline-2026-10-27.json`.
- Selected A3 change: known scalar array callbacks with no captures use the
  existing direct-call generator. Target: remove N redundant retain attempts and
  closure-release checks for N elements; preserve every effective count and
  allocation/live-byte metric. Candidate verification passes on both hosts at `863a5215b39c9c04bceb14aacc96972e3b41752a`,
  run `40479298165`. All 12 tests and 13 measured cases pass per host; logs and
  all artifact hashes were audited. Full delivery CI remains pending.
- Focused candidate `3c66e1f1`, run `40477814241`: both hosts passed the other
  eleven array/capture/unwind checks; the new test tried to find helpers already
  inlined out of `main`. The repair builds an explicit exported `probe` entry.
  The failed test also prevented measurement/artifact creation. The workflow
  now runs measurements after a successful compiler build even if tests fail,
  and preserves generated probe C separately. Both failed logs were audited.
- Profiles distinguish attempted/effective retains, releases, last-owner checks,
  uniqueness checks, count initialization and typed frees. Generated-C sites
  explain where operations happen; ordinary binaries retain size/frame evidence.
- The unique-buffer fixture has local, shared-result and callback-reader cases.
  These establish costs, not an implemented uncounted representation. A5 still
  needs a lifetime proof and failure, cancellation, capture, unknown-call and
  weak-link controls. Counts live in allocator chunk metadata, not inline in
  the array payload; the future representation must address that storage too.
- A2 now classifies each remaining owner and balances retains/non-final releases.
  Candidate indirect sites distinguish map insertion from map-to-list key copies.
  Ordinary buffer binaries shrink; entry frame estimates grow. No speed or peak
  stack improvement is claimed. See the report for exact before/after figures.
- Current docs now mark G5 complete and keep ARC minimization separate.
  Historical reports keep their original sources and numerical claims.

## Verified baseline

G5 tracing removal passed all nine [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/40433794313),
[documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/40433794300) and
both [analysis hosts](https://github.com/e6qu/fun-with-pipes/actions/runs/40433851517)
on `2721bf14a389f685e3dd64f5bf3d6921f61a6212`. All nine completed logs were audited;
no failed target was hidden. [#217](https://github.com/e6qu/fun-with-pipes/pull/217)
merged as `9dfa014596e1954e3e67c653123dad77a14f5241` with an identical tested tree
and a one-line 57-character subject, empty body and no trailers. See
[history](roadmap-history.md#tracing-gc-removal-pr-217) for repairs and evidence.

## Checks actually run for this batch

All local workloads use `python3 scripts/local-guard.py`; full compiler builds,
full suites and measurements run on GitHub. The first sandboxed guard invocation
could not read `ps`; rerunning with process-sampling permission kept all limits.

- `python3 scripts/test-ownership-profile.py`: eight reader/comparison controls pass.
- `python3 /private/tmp/fwp-check-ownership-profile.py`: actual emitted runtime
  control passes on Apple Clang 17 ARM64 at O1/O2. Exact totals cover 301 retains,
  wide counts, indirect calls, two frees, unique/shared and unmanaged cases.
  Uses the verified #217 macOS compiler artifact, whose hash was checked. This
  is a diagnostic convenience, not a build dependency or GCC verification.
- The same bounded check passes fixture formatting and interpreted outputs for
  local/shared/callback arrays. It initially caught reversed `apply` arguments
  in the new callback fixture; `flip apply` fixes the declared function type.
- No full compiler build, suite or benchmark has run locally.
- Guarded report audit: both complete artifact sets, hashes, profiles, three
  samples per input and ordinary binary/stack records agree; 13 cases pass.
  All focused-job logs are clean. Static-callback raw-interpreter outputs pass;
  its formatting was corrected with the language formatter. Rust formatting,
  workflow lint, staged whitespace and the 164-link documentation audit pass.
- Per-owner audit checks that effective retains balance non-final releases and
  verifies word-frequency string/record formulas on both hosts. A report-reader
  bug counted alternative C-preprocessor braces together; function-range checks
  now follow the emitter's layout and exclude global descriptors, with a regression
  control. No observed counts changed. The explicit native probe entry survives
  optimization in the verified compiler; formatting passes.

## Roadmap status

| Step | Status | Remaining acceptance |
|---|---|---|
| 1 | Verified | Preserve G1–G5 lifetime and collector-free checks |
| 2 | In progress | Deliver A2/first A3; A5 unique buffer, later A3/A4/A6 and scoped workspace |
| 3 | In progress | F1–F3 function-call and recursion costs |
| 4 | In progress | P1–P3 measured CPU budgets |
| 5 | In progress | D1–D3 derivative correctness and time/storage budgets |
| 6 | In progress | N1–N2 numerical accuracy and kernel budgets |
| 7 | In progress | B1–B2 reproducible comparisons and enforced budgets |
| 8 | In progress | V1–V2 application correctness, cleanup and scaling matrix |

## Recovery and open defect

Primary checkout remains detached at #209 with a local pointer to this worktree;
preserve its untracked compiler-abort report. Do not replay old temporary G5
migration scripts. No background publisher or detached merge watcher is running.
After publication, monitor exact-head CI with timed wake-ups, repair every
failure and squash-merge only passing gates with the required one-line message.

The intermittent Intel compiler abort remains unexplained. Preserve
[its evidence](measurements/compiler-abort.md); diagnose recurrence from source
and input, not speculative disassembly-led allocator experiments.
