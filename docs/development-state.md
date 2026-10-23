# Session handoff

All seven areas of [PLAN.md](../PLAN.md) remain open. Remove tracing and prefer
ownership, borrowing and moves; use ARC only where sharing needs it. JIT is excluded.
Continue substantial grouped PRs, with one active delivery and exact-head acceptance.

## Accepted baseline

[PR #198](https://github.com/e6qu/fun-with-pipes/pull/198) is squash-merged as
`27a3e009b83e28f06130a5d686a3196b9934e53f`. All nine production jobs
(`39845348815`) and docs (`39845348589`) passed exact head
`30c6d65c10b3cc33cfeb72f523e4d47624508896`. Final inspection covered 480 native
binaries and 816 execution observations. The merge tree, sole parent and exact
one-line message were verified; no body or trailers. [History](roadmap-history.md#local-callback-captures-and-repeated-numerical-work-pr-198)
records the result. Redundant main production run `39871314012` was cancelled;
main documentation was preserved.

Receipts: `/private/tmp/fwp-198-final-acceptance.json`,
`/private/tmp/fwp-198-merge.json`, `/private/tmp/fwp-198-merge-runs.json`.
The clean `/private/tmp/fwp-direct-entry-delivery` worktree preserves the tested
head. Do not rerun its completed merge, publication or inspection helpers.

**Next:** publish the checked ownership migration as one
combined PR, run focused native-command checks, then the full production matrix.
Fix all encountered failures and inspect default-build binaries before merging.
No permission question is pending.

## Current ownership migration

Branch `checked-native-default` lives in `/private/tmp/fwp-checked-native-default`,
based on #198's verified merge. It is separate from the clean delivery worktree
and has not been published. The primary checkout is detached at the same merge;
its modified handoff mirrors this state. Use the preparation worktree for code.

The preparation includes:

- Checked ARC for ordinary native builds, commands and generated modules.
  Ownership rejection stays an error; no automatic switch to tracing is added.
  Explicit `--gc tracing` still exists, so this does not complete GC removal.
- Consistent build option errors: repeated or unknown `--gc` values are rejected,
  including options after the source file. Previously `build` accepted repeats.
- Default run/build/test/pipe checks, cache identity against explicit ARC, and
  O0/O1/O2 binaries with symbol/output evidence for independent inspection.
- Explicit tracing selection in existing collector, disabled-freeing and
  poisoned-storage probes. Dynamic comparisons select both ARC and tracing.
  The expired inter-task derivative keeps its tracing runtime-trap test and
  separate ARC compile rejection. No test assertion or collector gate is removed.
- Current README, reference, design and ownership guidance for the new behavior.

This is implemented preparation, **not verified support**. The mode-selection
audit covers workflow scripts and hand-built compiler IR probes. Three unused pre-ARC allocation scripts were removed; the benchmark
guide links their frozen sources instead. Run `native-commands` on Linux AMD64
first using the existing evidence workflow;
it compiles every test target and runs six targets covering commands, standard
tests, ARC, CLI ownership and the golden corpus.
Then require the full final production matrix. Inspect actual default-build
binaries from all six native platforms. Keep every failure and repair its cause.

## Checks and resources

`python3 scripts/local-guard.py python3 /private/tmp/fwp-check-native-default.py`
passes formatting, workflows, all 106 documentation link sets/immutable preparation
anchors, seven plan steps and test-function/collector-setting preservation
(final check: 8.76s). No compiler build or native execution of this preparation
has run yet. Full suites remain runner work.

Keep local checks serial and guarded: at least 64 GiB free disk, generated target
storage below 2 GiB, sampled aggregate RSS below 1 GiB and a 180-second deadline.
Do not increase limits. Preserve modified worktrees and receipts. The initial
explicit-control edit inventory is `/private/tmp/fwp-checked-default-explicit-controls.json`.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing and limit ARC at remaining boundaries |
| 2 | In progress | Extend borrowing and remove functional overhead |
| 3 | In progress | Meet measured machine-level time and memory budgets |
| 4 | In progress | Improve differentiation speed, memory and precision |
| 5 | In progress | Validate CPU numerical kernels |
| 6 | In progress | Stabilize comparisons and set workload budgets |
| 7 | In progress | Complete the application acceptance suite |
