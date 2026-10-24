# Session handoff

All seven [plan](../PLAN.md) areas remain open. Prefer ownership and borrowing;
reserve ARC for sharing and remove tracing. JIT is excluded.

## Current action

**Next:** audit array-sort preparation and batch repairs/measurements while
finishing exact-head CI and binary acceptance for
[PR #210](https://github.com/e6qu/fun-with-pipes/pull/210), then squash-merge only
when all nine production jobs and docs pass. Use one subject of at most eighty
characters, an empty body and no trailers. Continue the plan with one active PR.

Delivery checkout `/private/tmp/fwp-checked-peer-comparison`, branch
`list-copy-delivery`, CLEAN at `281b54d9193b432bb808b4387cc0a4dad34dacba`.
Production run `40091968517`; docs `40091968459`. Docs, benchmarks and both macOS ARM64 shards pass; other jobs are running.
Completed logs are clean; no failed job is known. Keep the final head unchanged while its gates run unless
a repair is necessary. Audit every failed job and completed target before pushing.

The PR fixes interrupted list copies, removes redundant list/array sort buffers,
aligns benchmark peer arithmetic, fixes Windows test/coverage issues and records
rejected sort experiments. It includes readable reports and plan updates.
Compiler/runtime/library sources match focused `883f1c140089`; the repaired
Windows fixtures and measured storage results use `851c7a774b92`.

## Delivery helpers and reviews

Helpers/receipts under `/private/tmp` use `fwp-list-copy-delivery`.
Preparation, publication and run discovery are COMPLETE; never rerun them.
Audit with `fwp-audit-list-copy-delivery-final.py`. Strict merge/after-merge helpers
are prepared but UNRUN. They require ten exact-head gates and 8,798 actual
binary files: the inherited 8,627 plus 144 list-copy, eleven checked-peer and
sixteen sort-storage images. Host reviews: macOS ARM64 downloads and 1,161 ownership images pass; arrays
are being reviewed. Other phases/hosts are UNRUN.
Benchmark review is COMPLETE:
62 actual executables, five corruption controls and seven leak controls pass.

Use `fwp-review-list-copy-delivery-host.py --host HOST --phase PHASE` serially.
Hosts: ubuntu-latest, ubuntu-24.04-arm, macos-15, macos-15-intel, windows-2025,
windows-11-arm. Phases: download, ownership, arrays, floats, Linux-only controls,
files, services, maps, lists, prune. The list phase reads macOS GC artifacts;
other hosts use their normal artifacts. Pruning requires that phase too.
For benchmark use `fwp-download-list-copy-delivery-benchmark.py`, then
`fwp-review-list-copy-delivery-benchmark.py --host ubuntu-latest` (62 images).

Review tools are adapted from #209. File inspection still requires unchanged
workloads/oracles, but allows exactly src/cgen.rs and src/ownership.rs changes,
plus the three known runtime files, matched against publication hashes. New
list inspection compares actual images and saved results with the CI inspector.
Benchmark review adds checked-peer and sort-storage images and a fifth corrupted
artifact control. Benchmark tools pass on final artifacts; host tools are syntax-checked but
not yet exercised on final artifacts. Repair stale assumptions without weakening source/count requirements.

## Independent next group

Checkout `/private/tmp/fwp-array-sort-ownership`, branch `array-sort-ownership`,
started at `281b54d9193b`. Published preparation
`e78069765ac5798f71d7e11d216bcb71d6850d21` runs six-host focused CI
`40095196564` (all six jobs pass; every completed log is clean). Its prototype consumes the sort input,
reuses unique arrays and copies shared arrays/views. A cycle permutation protects
128-bit values from overwriting unread keys. Cleanup covers input, result and
scratch on failure/cancellation. This is NOT accepted native behavior yet.

New regression coverage checks 540 alias/bit-pattern cases per observation,
interrupted allocation/retain/comparison sites and six deliberate broken controls.
It targets ARC/tracing, O1/O2 and reuse verification, with 42 saved binaries/host.
`inspect-array-sort.py` independently reconstructs the instrumentation and inspects
actual binaries. The `array-sort` focused workflow uses all six native hosts.
Next preparation work: publish/run the storage and layout measurements, and
finish four remaining independent binary reviews. Windows AMD64 and Linux ARM64
reviews pass: 84 actual images, 24 observations and 48 broken controls. No
preparation failure remains.
Unpublished follow-up files add production inspection, a third array-ownership
count comparison, and ordinary 128-bit fixture object/stack measurements on both
Linux architectures. Their Python syntax, actionlint and focused coverage assertion
pass; the full 19 native-runner controls also pass. Interpreter output matches the
new inspector's expected handled-error text. These
measurements have no accepted result yet. Helpers/receipts use
`fwp-array-sort-preparation`; publication is COMPLETE, audit is repeatable.
No second PR is open. Keep PR #210's tested head unchanged.

Bounded prototype checks: inventory passes (392/382/0); Rust formatting passes;
fixture typechecks with the verified `883f1c140089` compiler; Python syntax passes.
The first inventory check failed due to an overbroad edit in its exception list;
correcting that edit passed. No current-compiler native build has run locally.

## Completed preparation

Published preparation `e5983ace1cc9fff7176482eeadb106d7a13a61e0` and prior immutable
tags remain on `checked-peer-comparison`. No second PR is open.

- Checked peers: source `31ee015e9435`, run `40084725349`; both Linux jobs and
  92 independent binary reviews pass. Signed-overflow checks and trap order
  agree; C failed allocations are repaired. Slower loop/text rows are retained.
- Ordered-sort experiment: source `cbacdff5e8cb`, run `40085991550`; both jobs and
  128 binary reviews pass. Both candidates fail the timing screen: AMD64 gains
  stay below five percent, ARM64 is slower, code/stack grow. Neither is adopted.
- List cleanup: source `883f1c140089`, run `40088243982`; Linux/macOS on both
  architectures pass. Both Windows jobs fail only a scalar-key fixture's CRLF/LF
  assumption; all new cleanup tests pass. Source `851c7a774b92` repairs stdout
  mode and passes full Windows replacements `40089546129` and `40089548269`.
  All completed logs and 144 actual native images are independently reviewed.
- Sort storage: source `851c7a774b92`, run `40089544249`; both Linux jobs and
  96 binary reviews pass. At 4,096 words, lists save two requests/65,552 requested
  bytes; arrays save one/32,776. Peak and retains are unchanged, final charge zero.
  Code is smaller, and O1 list entry frames shrink sixteen bytes. No timing claim.

Reports are in the delivery checkout's docs/measurements: checked-peers,
map-order-results, list-copy-cleanup, list-sort-storage, with raw JSON records.
Every preparation publication/download/review helper is COMPLETE. Do not rerun.
`fwp-record-list-sort-results.py` wrote reports but failed its last index edit;
that link was fixed separately. The generator's scope label was corrected from
“from” to “after” constant initialization; measured observations are unchanged.

Bounded checks pass: frozen inventory (392 declarations, 382 symbols, zero
unclassified), Rust formatting, Python syntax, 19 native-runner controls,
126 documentation link sets and actionlint for all three changed workflows.
A missing live status table was restored after the docs check caught it.

## Previous delivery and resource limits

#209 is verified and merged at `2520d136b7036ab878cac0ef48947b581c81b84a` from
`b298665da6ac97fe4bcc05318c66e671fed7a5a4`: all ten gates, complete log audits and
8,627 binary files pass. The merge has the identical tested tree and one line
without body/trailers. Its merge/after-merge helpers are COMPLETE. Duplicate
same-tree main run `40091501837` was cancelled. Primary checkout is detached at
that merge with only this operational handoff dirty; preserve it.

Use `python3 scripts/local-guard.py COMMAND...` serially. Full builds, suites,
benchmarks and large regeneration run on GitHub. Keep 64 GiB free, target below
2 GiB, sampled workload RSS below 1 GiB and the 180-second deadline. Do not raise
or bypass limits. Download refusals were resolved by verified APFS clones of
identical temporary files, retaining every path/content/mode. Receipts:
`fwp-evidence-clones-oct24.json`, `fwp-checkout-clones-oct24-verified.json`.
Completed #209 archive copies were pruned only after all reviews and matching
remote digests. Keep unique failed API evidence and all other failure records,
reports/layout images and dirty old checkouts.

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
