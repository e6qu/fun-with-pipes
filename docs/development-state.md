# Session handoff

All seven [plan](../PLAN.md) areas remain open. Prefer ownership and borrowing;
reserve ARC for sharing and remove tracing. JIT is excluded.

## Current action

**Next:** publish the [ordered-sort experiment](measurements/map-order-protocol.md)
and run `map-order` on both native Linux architectures. Its two candidates are
changes to saved generated C only; no runtime optimization is adopted yet.

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
partial cleanup. Both native Linux jobs in `40084725349` pass on source
`31ee015e943517e9e3e24714001a6f2f616a01b7`; complete logs and 92 actual images were
independently reviewed. [Results](measurements/checked-peers.md#native-linux-results)
keep all samples and slower comparisons.

Local guarded checks pass Python syntax, workflow parsing, Rust formatting,
whitespace and all 122 tracked documentation link sets. The source and immutable
revision tag are published. Both focused jobs and independent binary reviews pass. A command-edit mistake that passed C-only flags to `fwp build` was
caught during diff review and fixed before publication. Both hosts passed native GCC/Rust checks and all seven output comparisons.

A source review also found stale ownership documentation: parsing already
returns owned numeric trees, and trim/case/replace consume source owners.
Those tables now match `src/ownership.rs`; tracing-only age restrictions are
labeled explicitly. No compiler contract changed. The frozen inventory check passes: 392
declarations, 382 distinct symbols and no unclassified contracts.

Keep the [dated ARC comparison](measurements/arc-comparison.md) and its original
peer rules. Changed peer timing is not a compiler speedup. Sorting, storage and
formatting algorithms still differ. The loop remains slower than Rust and direct character counting slower than C.
These comparisons are one session per architecture, not universal overhead.

The AMD64 map executable already specializes integer comparisons. The next
experiment therefore tests skipping already ordered merge work, with a separate
stability/alias probe and deliberately omitted merge. The screen requires a 5%
map gain, at most 3% slowdown elsewhere and identical-copy controls within 3%,
on both elapsed and child CPU time for every allowed CPU. Keep failed screens.

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
