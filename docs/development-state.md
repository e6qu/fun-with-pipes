# Session handoff

All seven [plan](../PLAN.md) areas remain open. Prefer ownership and borrowing;
reserve ARC for sharing and remove tracing. JIT is excluded.

## Current action

**Next:** publish this checked-peer preparation and run `benchmark-comparison`
on both native Linux architectures. Audit both complete logs and inspect the
saved binaries before accepting new measurements.

Checkout `/private/tmp/fwp-checked-peer-comparison`, branch
`checked-peer-comparison`, based on `b298665da6ac97fe4bcc05318c66e671fed7a5a4`.
This is independent preparation while [PR #209](https://github.com/e6qu/fun-with-pipes/pull/209)
finishes. Keep one active PR; do not disturb its final head. #209's benchmark and
documentation gates pass; all eight native jobs were running at the latest audit.
Its 35 benchmark images and corruption/leak controls passed independent review.

## Prepared changes

[Checked peers](measurements/checked-peers.md) make C/Rust signed calculations
explicitly checked, retain fwp evaluation order in the loop and repair failed
C allocations. The compiler/runtime are unchanged. Saved native probes cover
51 dynamic inputs, six deliberately removed arithmetic checks and a missing
partial cleanup. These controls and the new timings remain unverified.

Local guarded checks pass Python syntax, workflow parsing, Rust formatting and
whitespace. A command-edit mistake that passed C-only flags to `fwp build` was
caught during diff review and fixed before publication. Native GCC/Rust checks,
all seven output comparisons and artifact review belong on GitHub runners.

Keep the [dated ARC comparison](measurements/arc-comparison.md) and its original
peer rules. Changed peer timing is not a compiler speedup. Sorting, storage and
formatting algorithms still differ. No new performance ratio is accepted yet.

## Delivery state

#208 is verified and merged at `058dc4e5954571ed222ca4d26af4403a52a8516b`.
[History](roadmap-history.md#api-memory-stack-guards-and-connection-cleanup-pr-208)
records its gates and 8,454 actual binary files. Primary checkout remains there
with an operational handoff. Preserve it and unique failed API artifacts.

#209 source is `b298665da6ac97fe4bcc05318c66e671fed7a5a4`; production
`40082867710`, docs `40082867648`. Delivery helpers under `/private/tmp` use prefix
`fwp-arc-map-delivery`. Preparation/publication are complete; merge is unrun.
Audit all nine production jobs plus docs, review all six native hosts and the
benchmark, then squash-merge with one subject of at most 80 characters and an
empty body. Continue with a substantial group; do not open another PR early.

## Local limits

Use `python3 scripts/local-guard.py COMMAND...` serially. Full builds, suites and
benchmarks run on GitHub. Preserve 64 GiB free, target below 2 GiB, sampled RSS
below 1 GiB and the 180-second deadline. Do not bypass or increase those limits.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing and limit counting at remaining boundaries |
| 2 | In progress | Extend borrowing and remove functional overhead |
| 3 | In progress | Meet measured machine-level time and memory budgets |
| 4 | In progress | Improve differentiation speed, memory and precision |
| 5 | In progress | Validate CPU numerical kernels |
| 6 | In progress | Stabilize comparisons and set workload budgets |
| 7 | In progress | Complete the application acceptance suite |
