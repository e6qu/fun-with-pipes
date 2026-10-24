# Session handoff

All seven [plan](../PLAN.md) areas remain open. Prefer ownership and borrowing;
reserve ARC for necessary sharing and remove tracing. JIT is excluded.

## Current action

**Next:** resolve PR #210's Intel macOS compiler abort. Continue the targeted
allocator investigation; repair the cause
before repeating final-head acceptance. The independently verified array group
is checkpointed for its next delivery. Keep one active PR. Squash-merge only after
acceptance, with one subject line of at most eighty characters and no body/trailers.

## Active PR #210

[PR #210](https://github.com/e6qu/fun-with-pipes/pull/210) is the active delivery.
Checkout `/private/tmp/fwp-checked-peer-comparison`, branch `list-copy-delivery`,
contains the CI repair batch (`ff1aca3e`, `85df5485`) and this updated investigation.
Final-head CI and the compiler-abort repair remain required.
It fixes interrupted list copies, removes redundant sort buffers, aligns benchmark
peer arithmetic and repairs Windows test coverage.

The [compiler-abort investigation](measurements/compiler-abort.md) records the
original failure, matching compiler, experiments and evidence locations. The cause
is unresolved. No compiler/runtime repair has been made for that abort; successful
reruns cannot establish one. Diagnostic run `40113866689`, source
`bbab290503962a272398c95882724e2208c86adf`, has completed on native Intel macOS.
It isolates the Guard Malloc startup failure to Rust's 4 GiB thread; the smaller
stack reaches declaration collection but hits the diagnostic deadline. No invalid
access reported and no passing guarded inference run. No production stack change. A new sanitizer run, `40114625111`, uses exact
production Rust 1.99.1 from diagnostic source
`39e6b19fa4a0b3b8b2c7ca5049e190d0cd8b098c`; the earlier sanitizer run used nightly.
This diagnostic-only build enables ASan flags with `RUSTC_BOOTSTRAP=1`; neither
production compiler flags nor its stack policy change. Review the full job log
and archive before drawing conclusions. Earlier diagnostic helpers are COMPLETE;
do not repeat their downloads or publication.

Earlier-head production `40106524885` has six audited failures: four regular
Mac/Linux jobs fail the introduced Clippy borrow lint and then lack SDK compiler
or inspection artifacts; both Mac GC jobs reject ASan's nano-zone warning.
Local checkpoints `ff1aca3e` and `85df5485` repair these causes and preserve kernel
probe artifacts. Documentation `40106524851`, benchmark and Windows ARM64 pass;
completed logs audited. Windows AMD64 is still running and remains part of the
audit. Publishing this batch does not cancel that job: the workflow has no
cancel-in-progress policy. Audit its remaining results alongside the repaired
head, and fix any additional failures in this PR.

Focused checks passed under `scripts/local-guard.py`: standalone kernel test
compiled with production Rust O1/assertions/overflow checks; sanitized C at O1/O2,
including four deliberately broken controls; Rust formatting; workflow actionlint.
The healthy kernel test first reproduced the precise nano-zone warning locally.
Its repair retains allocator/sanitizer reporting. No full builds ran locally.

Original-head binary reviews are complete only for macOS ARM64 and benchmarks;
other hosts are UNRUN. Helpers use `fwp-list-copy-delivery`; the audit is repeatable.
Old merge/after-merge helpers are UNRUN and source-specific. Do not use them for a
new head. Final acceptance requires new exact-head gates and actual binary reviews.

## Prepared next group: array sorting and construction

Checkout `/private/tmp/fwp-array-sort-ownership`, branch `array-sort-ownership`,
is clean at report checkpoint `9824e22e827cfd6116c55ac2fcc2651ed02a7dcc`.
Its tested code is `e0c4dd51bae37c0e09be10fcb373dd035279f815`. No second PR is open.
Sorting reuses unique arrays and preserves shared arrays/views; permutation cycles
protect inline 128-bit values. List conversion now moves an unshared prefix and
copies the shared tail. Both changes protect cleanup through failure/cancellation.
No surface syntax changes.

All six focused jobs in `40100508025` and both Linux cost jobs in `40100509770`
pass with clean logs. All six independent native reviews are complete: 504 executable variants. Each host
has 84 sort/construction executables, 24 repeated observations and 48 deliberately
broken controls. Each construction observation checks 208 alias/bit-pattern cases
and 88 interrupted operations.

Both cost reviews pass: 128 executables and eight wide-sort objects in total.
At 4,096 words, moving list elements removes the remaining 4,096 retains; requests,
requested bytes and peak are unchanged, final charge and collections are zero.
This is not zero allocation or proof of zero ARC overhead. Instruction bytes grow
by 176–336 on ARM64 and 224–272 on AMD64; the ARM64 O1 entry frame grows 16 bytes.
The readable measurement report now records these costs and slower C/Rust rows.
The alias example also matches native Clang/O2 ARC output under the guard.
Current native/cost JSON uses `array-construction-*-2026-10-24.json`; earlier
sort-only records remain linked. `fwp-record-array-construction.py` is COMPLETE.

Helpers/receipts use `fwp-array-construction`. Publication is COMPLETE. Audit
helpers are repeatable. All six host download/review/prune phases are COMPLETE; never repeat them.
The verified compiler is `/private/tmp/fwp-verified-array-construction-compiler/fwp`. Reviews retain source hashes and compare actual binaries with CI reports.
Cost download/review helpers are COMPLETE for both Linux hosts. Full delivery
acceptance remains pending, after #210 is repaired and merged.

Bounded checks pass: Rust formatting, Python syntax, frozen inventory (392
primitive declarations, 382 symbols, zero unclassified), 19 native-runner controls,
workflow actionlint and 127 documentation link sets. Full builds/tests run on GitHub.

## Resources and accepted baseline

Use `python3 scripts/local-guard.py COMMAND...` serially. Preserve 64 GiB free,
target data below 2 GiB, sampled workload RSS below 1 GiB and the 180-second limit.
Free space is near 64.5 GiB; download/review/prune one host at a time. Preserve
failed evidence, reports, actual layout objects and dirty older checkouts.
`fwp-prune-reviewed-list-copy.py` is COMPLETE: six matching remote originals and
the retained compiler were verified before removing 144,736,394 duplicate ZIP bytes.
Never rerun completed archive pruning, APFS clone or publication helpers.

#209 passed all ten gates and its binary reviews, then merged with the tested tree
as `2520d136b7036ab878cac0ef48947b581c81b84a`; duplicate main CI was cancelled.
The primary checkout is detached there with this operational handoff and the
current compiler-abort investigation document dirty.
Preserve it. [History](roadmap-history.md) records accepted deliveries.

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
