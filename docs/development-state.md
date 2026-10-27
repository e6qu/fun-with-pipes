# Current work

**Next:** verify the A3 static-array-callback change on both native Linux
architectures and finish A2's per-owner attribution using the saved reports.
Keep this measurement, the related implementation and documentation in one PR;
run the full production matrix after the batch is ready.

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
  allocation/live-byte metric. Candidate verification and full CI are pending.
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
| 2 | In progress | A2 attribution and A3–A6 reductions, unique buffer and scoped workspace |
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
