# Session handoff

All seven [plan](../PLAN.md) areas remain open. Prefer ownership and borrowing;
reserve ARC for necessary sharing and remove tracing. JIT is excluded.

## Current action

**Next:** resolve PR #210's Intel macOS compiler abort. Finish the pending
instrumented diagnostics, preserve any failing input, and repair the cause before
repeating final-head acceptance. Checkpoint the prepared array group’s completed binary reviews and readable
results for its next delivery. Keep one active PR. Squash-merge only after
acceptance, with one subject line of at most eighty characters and no body/trailers.

## Active PR #210

[PR #210](https://github.com/e6qu/fun-with-pipes/pull/210) remains at
`281b54d9193b432bb808b4387cc0a4dad34dacba`. Checkout
`/private/tmp/fwp-checked-peer-comparison`, branch `list-copy-delivery`, is clean.
It fixes interrupted list copies, removes redundant sort buffers, aligns benchmark
peer arithmetic and repairs Windows test coverage.

Production `40091968517` and docs `40091968459` are complete: nine of ten gates
pass. Every completed job log was audited. Intel macOS GC job `120866324330` fails
only `console_input_matches_raw_interpretation`. The compiler aborts during type
inference, before C generation. Its crash report shows `malloc_report` beneath
`TypeTable::open_call`; the cause is unresolved. Crash ZIPs, digests and extracted
logs are in `/private/tmp/fwp-list-copy-console-failure`. Never count a passing
retry as a repair or discard this evidence.

Diagnostic source `359f680d147bb931dcffd6a91d7ded541efd5993`, branch
`console-inference-diagnostic`, run `40100186269`, repeats named inputs with Rust
1.99.1, allocator heap checks and nightly AddressSanitizer. The production console
test and all 360 heap-check compilations pass; inspected allocator logs are empty.
The 3,600-call production and sanitizer loops are still active. Their artifacts
and review receipts use `/private/tmp/fwp-console-diagnostic-evidence`.
`fwp-review-console-diagnostics.py` safely visits newly completed jobs. The bounded
local driver check passed eighteen compilations and a stop-on-first-failure control.

Final-head independent reviews for #210 are complete only for macOS ARM64 and the
benchmark job. Other hosts are UNRUN. Helpers/receipts use `fwp-list-copy-delivery`.
The audit helper is repeatable. Publication and completed reviews must not be
rerun; merge/after-merge helpers are UNRUN and require all ten gates plus the full
binary review. A repair needs new source-specific acceptance, preserving old results.

## Prepared next group: array sorting and construction

Checkout `/private/tmp/fwp-array-sort-ownership`, branch `array-sort-ownership`,
is clean at `e0c4dd51bae37c0e09be10fcb373dd035279f815`. No second PR is open.
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
The primary checkout is detached there with only this operational handoff dirty.
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
