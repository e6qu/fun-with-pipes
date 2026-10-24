# Session handoff

All seven [plan](../PLAN.md) areas remain open. Prefer ownership and borrowing;
reserve ARC for necessary sharing and remove tracing. JIT is excluded.

## Current action

**Next:** finish PR #210's remaining production gates and binary reviews, then
squash-merge only after acceptance. Publish the prepared array-sort group as the
next substantial PR; keep one active PR. Use a one-line subject of at most eighty
characters, an empty body and no trailers. Continue the plan after verified merges.

[PR #210](https://github.com/e6qu/fun-with-pipes/pull/210) is unchanged at
`281b54d9193b432bb808b4387cc0a4dad34dacba`. Checkout
`/private/tmp/fwp-checked-peer-comparison`, branch `list-copy-delivery`, is clean.
Production run `40091968517`; docs `40091968459`. Docs, benchmarks and both macOS
ARM64 shards pass. The other six production jobs are running; no failure is known.
Completed logs are clean. Audit every failed job and completed target before any
repair push; preserve this head while its remaining gates run.

The PR fixes interrupted list copies, removes redundant sort buffers, aligns
benchmark peer arithmetic, fixes Windows test coverage and records rejected sort
experiments. Its preparation evidence is in the checkout's measurement reports.

## Final-head reviews for #210

All macOS ARM64 phases pass, including 1,161 ownership images, 168 array outcomes,
24 layout comparisons and 24 list-copy binaries. Its duplicate ZIP copies are
pruned after matching remote digests. The benchmark review passes 62 executables,
five corruption controls and seven leak controls. Other host reviews are UNRUN.

Helpers/receipts under `/private/tmp` use `fwp-list-copy-delivery`.
Publication/discovery and benchmark download/review are COMPLETE; never rerun.
Repeat `fwp-audit-list-copy-delivery-final.py` for the exact-head gate/log audit.
Strict merge/after-merge helpers are prepared, UNRUN, and require all ten gates
plus 8,798 actual binary files. They preserve the tested tree and verify the
one-line squash message. The after-merge helper cancels duplicate same-tree CI.

Use `fwp-review-list-copy-delivery-host.py --host HOST --phase PHASE` serially.
Hosts: ubuntu-latest, ubuntu-24.04-arm, macos-15-intel, windows-2025, windows-11-arm.
Phases: download, ownership, arrays, floats, Linux-only controls, files, services,
maps, lists, prune. List inspection uses macOS GC artifacts; other hosts use their
normal artifacts. Pruning requires every review. File inspection allows exactly
the known source changes and publication hashes; repair stale assumptions without
weakening source/count checks. The adapted tools already pass on macOS ARM64.

## Prepared next delivery: array sorting

Checkout `/private/tmp/fwp-array-sort-ownership`, branch `array-sort-ownership`,
started from #210's head. It consumes the sort input, reuses unique arrays and
copies shared arrays/views. A cycle permutation protects 128-bit values from
being overwritten before they move. Input, result and scratch cleanup cover
failure/cancellation. No surface syntax changes. Full delivery is still pending.

Focused source `e78069765ac5798f71d7e11d216bcb71d6850d21` passes all six jobs in
`40095196564`, with clean logs and independent review of 252 executables,
72 repeated observations and 144 deliberately broken controls. Each observation
checks 540 alias/bit-pattern cases and 232–272 interrupted operations.

Follow-up `d763c34c824fc8aaf7d4e76aba9ae29cbf950d9e` adds production inspection and
cost measurements, with unchanged compiler/runtime/library/tests. Both Linux jobs
in `40096410788` and independent reviews pass: 112 executables plus eight ordinary
wide-sort objects. At 4,096 words both architectures/O1/O2 save one allocation,
32,776 requested bytes and 4,096 retains. Peak is unchanged; final charge is zero.
Code/stack costs and slower C/Rust rows remain in the report. No timing gain claim.

Readable results and raw JSON are in `docs/measurements/array-sort-ownership.md`,
`array-sort-native-2026-10-24.json` and `array-sort-costs-2026-10-24.json` in that
checkout. Results, indexes and plan are checkpointed together;
prepare the next delivery after #210 merges. No second PR is open.

Helpers/receipts use `fwp-array-sort-preparation`, `fwp-array-sort-measurement`
and `fwp-array-sort-costs`. All publication, download and independent review work
is COMPLETE. Both `fwp-record-array-sort-native.py` and
`fwp-record-array-sort-costs.py` are COMPLETE; never rerun over edited reports.
`fwp-prune-array-sort-preparation.py` is COMPLETE: matching GitHub originals and
all reports remain; six duplicate ZIPs are removed. The verified ARM64 compiler
is `/private/tmp/fwp-verified-array-sort-compiler/fwp`, with its source/digest receipt.
Cost archives remain. Audit helpers are repeatable; completed reviews are not.

Bounded checks pass: frozen inventory (392 declarations, 382 symbols, zero
unclassified), Rust formatting, Python syntax, 19 native-runner controls,
workflow actionlint and 127 documentation link sets. The inventory's first check
caught an overbroad exception-list edit; correcting it passed. Full builds/tests
ran only on GitHub. The final documentation check includes the new report links.

## Resources and last accepted delivery

Use `python3 scripts/local-guard.py COMMAND...` serially. Keep 64 GiB free, target
below 2 GiB, sampled workload RSS below 1 GiB and the 180-second deadline; never
raise or bypass limits. Full suites, builds and benchmarks run on GitHub.
About 66 GiB is free after verified duplicate pruning. Earlier APFS clones
preserved identical files; receipts are `fwp-evidence-clones-oct24.json` and
`fwp-checkout-clones-oct24-verified.json`. Keep unique failed evidence, reports,
layout images and dirty old checkouts. Never rerun completed clone passes.

#209 passed all ten gates and 8,627 binary reviews, then merged with the tested
tree as `2520d136b7036ab878cac0ef48947b581c81b84a`. Its merge/after-merge helpers
are COMPLETE, and duplicate main run `40091501837` was cancelled. The primary
checkout is detached there with only this operational handoff dirty. Preserve it.
[History](roadmap-history.md) contains the detailed evidence.

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
