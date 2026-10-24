# Session handoff

All seven [plan](../PLAN.md) areas remain open. Prefer ownership and borrowing;
reserve ARC for sharing and remove tracing. JIT is excluded.

## Current action

**Next:** diagnose and repair PR #210's Intel macOS compiler allocator abort.
The current changes preserve allocator messages, named inputs and the compiler
image during the full CI run. They do not establish a runtime repair. Then verify
the final head: nine production jobs, docs and saved binaries.
Keep one active PR. Squash-merge only after every gate passes, with one subject
of at most 80 characters and an empty body, then continue the plan.

Checkout `/private/tmp/fwp-checked-peer-comparison`, branch `list-copy-delivery`.
Prepared from verified #209 merge `2520d136b7036ab878cac0ef48947b581c81b84a` and published preparation
`e5983ace1cc9fff7176482eeadb106d7a13a61e0`. Compiler/runtime/library sources match focused `883f1c140089`;
the Windows test repair and measured results use `851c7a774b92`.
The preparation branch and immutable source tags are retained.

## Unresolved compiler abort

[PR #210](https://github.com/e6qu/fun-with-pipes/pull/210)'s original head
`281b54d9193b432bb808b4387cc0a4dad34dacba` passed nine of ten gates. All completed
logs were audited; only the Intel macOS GC job failed, in
`console_input_matches_raw_interpretation`. The Rust compiler aborted in type
inference, before generated C ran. Preserve [the original failure](https://github.com/e6qu/fun-with-pipes/actions/runs/40091968517/job/120866324330).

The saved production compiler has the crash report's exact UUID
`42cd802d-3482-3779-acce-42251ea4f37d`. Disassembly places the failure in ordinary
system `free`, releasing a boxed function result type. Its owning type-checker
code and library inputs are unchanged from the passing base. This narrows the
investigation; it does not identify the cause.

[Completed diagnostics](https://github.com/e6qu/fun-with-pipes/actions/runs/40103957497)
pass 360 production compilations, 90 nightly AddressSanitizer compilations and
three runs of the original two-worker test neighborhood. Their logs and artifact
hashes were independently reviewed. Earlier partial runs and heap-check results
are retained. Passing reruns do not repair the original crash.

[A guarded-allocation diagnostic](https://github.com/e6qu/fun-with-pipes/actions/runs/40105746847)
reuses the matching compiler binary. Ordinary allocations pass; Guard Malloc
cannot create the requested 4 GiB worker stack and stops before inference with
EAGAIN. This distinct diagnostic limitation does not explain the original abort.
The saved system allocator UUID also matches the crash. Inspect its internal
free path and obtain a failing allocation history before changing ownership code.

macOS can suppress malloc error messages when stderr is captured. CI now explicitly
requests those messages and preserves the debug compiler with crash reports.
The console test logs each source body and uses a distinct filename for each case.
No retry or ignored failure is added.

Local investigation records use `fwp-console-*` and `fwp-list-copy-console-failure`
under `/private/tmp`; completed publication/review helpers must not be rerun.
The independently verified next array-sort/construction group is checkpointed at
`9824e22e827cfd6116c55ac2fcc2651ed02a7dcc`, tested source `e0c4dd51bae3`, on
`array-sort-ownership`. Six native jobs and both Linux cost jobs pass; 504 native
executables and 128 cost executables were reviewed. It remains the next grouped
delivery after this failure is resolved. Keep one active PR.

## Grouped changes and evidence

| Work | Result | Evidence |
|---|---|---|
| Checked C/Rust peers | Explicit signed overflow and trap order; C allocation failures repaired | [Protocol and results](measurements/checked-peers.md), source `31ee015e9435`, run `40084725349`; both Linux jobs and 92 binary reviews pass |
| Ordered-sort experiment | Both candidates fail their predeclared screen; neither is adopted | [Results](measurements/map-order-results.md), source `cbacdff5e8cb`, run `40085991550`; 128 binary reviews pass; slower/noisy samples retained |
| Interrupted list copies | Fix the 80-byte handled-callback leak; protect partial results in seven operations; preserve aliases | [Cleanup](measurements/list-copy-cleanup.md) and [144 native binaries](measurements/list-copy-native-2026-10-24.json) |
| Sort buffers | Remove two list buffers and one array buffer without changing the merge algorithm | [Results](measurements/list-sort-storage.md), source `851c7a774b92`, run `40089544249`; both Linux jobs and 96 binary reviews pass |
| Windows repair | Explicit binary stdout fixes CRLF/LF test failure; all three list targets enter production coverage | Runs `40089546129` and `40089548269`; complete logs and both native artifact reviews pass |

List cleanup runs at O1/O2 in ARC and tracing modes, including collection stress,
reuse, cancellation and deliberate missing releases. Each host has six balanced
observations and twelve missing-cleanup controls. Source `883f1c140089` passes
Linux/macOS on both architectures in `40088243982`; its two Windows jobs fail only
the old scalar-key fixture. The Windows replacements above use `851c7a774b92`,
with identical compiler/runtime/library sources. Preserve the original failures.

At 4,096 words, sorting requests 65,552 fewer bytes for lists and 32,776 fewer
for arrays. Both Linux architectures and O1/O2 agree. Whole-program peak storage
and retain counts stay unchanged; final charge is zero. Ordinary code is smaller;
the O1 list entry frame shrinks sixteen bytes. This is no timing-speedup claim.
Current complete-program comparisons still show slower loop and character-counting
rows. New production steps inspect list-copy binaries and sort-storage evidence.
Full final-head acceptance is still required.

## Verification and local receipts

Helpers and receipts under `/private/tmp` use these prefixes:

- `fwp-checked-peer`, `fwp-map-order`, `fwp-list-copy`, `fwp-list-sort`:
  preparation publication, focused audits and independent reviews are complete.
  Never rerun completed publication/download/review helpers.
- `fwp-record-list-copy-native.py` and `fwp-record-arc-map-delivery.py` are complete.
  `fwp-record-list-sort-results.py` wrote the reports, then failed its final index
  edit; that link was fixed separately. Do not rerun it over the edited prose.
- `fwp-sort-callback-leak` preserves the original leak and repair controls.
  `fwp-list-copy-runtime-probe` records 130 allocation/retain interruptions plus
  six callback exits across eight rounds. Early probes used saved C with explicit
  runtime/API edits; focused current-compiler CI supplies compilation acceptance.
- `fwp-verified-list-copy-compiler/receipt.json` verifies the current macOS compiler
  from source `883f1c140089`. `fwp-list-sort-current-probe` records its bounded
  32-word counters. These do not replace production GCC or native target checks.

Bounded checks pass: frozen inventory (392 declarations, 382 symbols, zero
unclassified), Rust formatting, Python syntax, 19 native-runner controls,
126 documentation link sets and actionlint for all three changed workflows.
The docs check caught a missing live roadmap table; restoring it passes the
check. The storage report label now correctly says counting starts after constant
initialization; its code and measured observations are unchanged. Full builds
and suites run on GitHub.

## Last accepted delivery

[PR #209](https://github.com/e6qu/fun-with-pipes/pull/209) passed all nine production
jobs in `40082867710` and docs in `40082867648` at `b298665da6ac`.
All logs and 8,627 actual binary files were independently reviewed. Its verified
squash is `2520d136b7036ab878cac0ef48947b581c81b84a`, with the same tested tree
and a one-line message without body/trailers. [History](roadmap-history.md#map-peak-storage-and-explicit-benchmarks-pr-209)
links the acceptance record. Duplicate same-tree main run `40091501837` was
cancelled. Its merge/after-merge helpers are COMPLETE; never rerun them.
Primary checkout is detached there with only an operational handoff dirty.

## Local resources

Run focused checks serially through `python3 scripts/local-guard.py COMMAND...`.
Keep 64 GiB free, generated target data below 2 GiB, sampled workload RSS below
1 GiB and the 180-second deadline. Never raise or bypass limits. Full builds,
suites, benchmarks and large regeneration belong on GitHub runners.

Disk refusals stopped downloads before violating the reserve. Byte-identical
APFS clones preserved every file/path/mode while recovering space; receipts are
`fwp-evidence-clones-oct24.json` and `fwp-checkout-clones-oct24-verified.json`.
Completed #209 ZIP copies were pruned only after all reviews and remote digest
checks. Keep unique failed evidence, all reports/layout images and dirty old
checkouts. The initial checkout-clone attempt failed before changing any file
because a pruned directory lacked `.git`; its empty receipt is retained.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing; prove cleanup and borrowing at remaining boundaries |
| 2 | In progress | Remove functional allocation/counting costs and extend tail-call proofs |
| 3 | In progress | Meet measured machine-level time and memory budgets |
| 4 | In progress | Improve differentiation speed, memory and precision |
| 5 | In progress | Validate CPU numerical kernels against accuracy and cost budgets |
| 6 | In progress | Stabilize equivalent-work comparisons and regression budgets |
| 7 | In progress | Complete the selected application acceptance suite |
