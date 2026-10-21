# Session handoff

## Next action

Next: prepare the retained-resource ownership batch on branch
`prove-retained-resource-ownership`, based on accepted merge `447a18f8b1ac4b7faa2c655fa2ea7a24d4e0c44c`.
No PR is open for this preparation. Group the proof, implementation, representative
programs, failure/cancellation controls and readable documentation in one PR.

Start with `src/arc_scope.rs::queued_capture_type`, `src/arc.rs` and the
[queued-function contract](ownership.md#functions-stored-in-channels). Audit a
queued callback capturing an independently owned file: establish how the closure
acquires, uses and releases that owner, including repeated calls, undrained/closed
queues, failures and cancellation. Check the existing linear-use rules before
relaxing any rejection. A file cannot itself own a queue, but that fact alone
does not prove safe closure lifetime or resource use. Add a runnable acceptance
program only when its complete contract is established; keep unsupported captures
rejected with a precise explanation. Do not add weak handles or new syntax merely
to bypass a missing proof. Ownership and removal of tracing remain the priority.

Read [PLAN.md](../PLAN.md), [ownership](ownership.md) and relevant
[design](design.md) sections before changing code. The current edits only record
the completed delivery and this next investigation; no ownership change has been
implemented or verified in this preparation.

## Accepted delivery

[PR #183](roadmap-history.md#checked-product-bounds-pr-183) is squash-merged.
All nine production jobs in `39543123372` and documentation `39543123369` passed
at `3606d072d0f708b600f44050ab9cafe1390bceee`. Every complete log was audited clean.
Merge `447a18f8b1ac4b7faa2c655fa2ea7a24d4e0c44c` has the identical tested tree
`40b47a0670c38bc0b05c6dbd1afefd3ad5f7d7c5`. Its verified message is exactly
`Preserve numeric bounds after checked multiplication`: one line, 52 characters, no body,
trailers or attribution. Receipt: `/private/tmp/fwp-183-final-acceptance.json`.
The redundant post-merge production run `39557406360` was cancelled after tree
verification; post-merge documentation `39557406176` passed.

The [measurement guide](measurements/checked-products.md) and
[raw report](measurements/checked-products-2026-10-21.json) retain the comparisons,
binary evidence and limits. O2 counting loops improve, but matched C remains
faster, AMD64 timings vary by CPU and O0/O1 emit an extra product. Tracing remains
in the measured binaries. These results do not finish a roadmap work area.

## Evidence and local resources

Measured source `b57e2dcda716ebd27007d01aaf5e4e79d22518b6` remains available through
`roadmap/revision-checked-product-b57e2dcd`. Focused run `39536765734` passed on
both Linux architectures, including actual compiler C/instruction equality,
runtime-input and sanitizer controls. Receipts: `/private/tmp/fwp-range-native-audit.json`
and `/private/tmp/fwp-compiled-range-audited.json`; complete artifacts:
`/private/tmp/fwp-compiled-range-costs`. Immutable baseline inputs share hardlinks
with `/private/tmp/fwp-integer-range-costs`. The older handoff is preserved at
`/private/tmp/fwp-183-pre-merge-handoff.md`; detailed delivery history belongs in
[the history index](roadmap-history.md), not a competing next-action list.

Use `python3 scripts/local-guard.py` for serial local checks. Full builds, native
execution, full suites and measurements run on GitHub. Preserve 64 GiB free disk,
target data below 2 GiB, sampled aggregate RSS below 1 GiB and the 180-second
deadline. No limits were raised. The final log audit passed in 18.26s; merge
verification passed in 9.34s. Recheck free space before downloading artifacts.
The merged-status documentation and next handoff pass `python3 scripts/check-roadmap.py`
and `git diff --check` under the guard (3.78s).

Authorized cleanup manifests are `/private/tmp/fwp-disk-cleanup-2026-10-20.json`,
`/private/tmp/fwp-disk-cleanup-second-2026-10-20.json`,
`/private/tmp/fwp-disk-cleanup-extra-generated-2026-10-20.json` and
`/private/tmp/fwp-disk-cleanup-2026-10-21.json`. The earliest counting artifact
trees are partial; restore their verified remote artifacts before binary audits.
Current matched/range evidence and sources remain intact.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing; prove retained ownership and cleanup. |
| 2 | In progress | Eliminate avoidable functional allocations and count traffic. |
| 3 | In progress | Resolve measured machine-code and performance gaps. |
| 4 | In progress | Improve differentiation time, memory and precision. |
| 5 | In progress | Validate numerical kernels and ahead-of-time GPU policy. |
| 6 | In progress | Establish equivalent-work comparisons and budgets. |
| 7 | In progress | Validate larger programs and bounded live memory. |
