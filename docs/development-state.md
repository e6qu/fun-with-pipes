# Session handoff

The [plan](../PLAN.md) remains open in all seven areas. Current work removes
avoidable ownership operations while preserving pipe semantics, immutable values,
checked arithmetic and failure/cancellation cleanup. JIT is excluded.

## Current PR: array moves and copied C callback inputs

[PR #196](https://github.com/e6qu/fun-with-pipes/pull/196) is the only open PR.
Its exact head is `7bb4b5d49341fc67f9b76840feeeb8e479c3392e`, branch
`array-moves-and-callback-inputs`, worktree `/private/tmp/fwp-array-callback-delivery`.
Eight production jobs and docs pass with complete logs audited. Only Windows
AMD64 remains running, with no failed step. Runs: production `39775586712`,
docs `39775586540`. The earlier tutorial-copy failure was repaired; its superseded
production run was cancelled. Do not change this head while its gates finish.

The PR combines copied synchronous C callback strings, stack-array owner moves,
C/Rust derivative comparisons and a repaired timing protocol. Preparation includes
all six native hosts, twelve WASI modules and inspected numerical binaries.
Counts improve; earlier timing regressions and noisy identical-code controls remain
in the reports. This does not finish GC removal or establish C/Rust parity.

**Next:** run `/private/tmp/fwp-audit-196-final.py`. Once all nine production jobs
and docs pass, run `fwp-merge-196.py`, then `fwp-after-merge-196.py`. These helpers
check exact sources and evidence, supply a one-line squash subject and empty body,
verify merge tree/parent/message, cancel redundant same-tree push CI and preserve
docs. They have not run. Publication and merge are already authorized.

The primary checkout is detached at verified #195 merge
`40dda0795fd150feb3dc0543052c3bf041e865c8`; this handoff is its only edit.
#195 passed every gate and delivered native command ownership, failed-test cleanup
and raw derivative workspace measurements. Its duplicate production run was cancelled.

## Next combined PR: borrow array-generation captures

Worktree `/private/tmp/fwp-array-capture-borrows`, branch `borrow-array-captures`,
is at `3e5763b69ed075516bcbadf5d18dcb2a12f98078` with uncommitted measurement
reports and plan/design/ownership/benchmark/application-suite updates.
The ownership report is `docs/measurements/array-capture-borrows.md` plus its JSON. It starts
at #196's initial `d98abe29139c` but includes the later tutorial repair. Preserve
that repair when integrating onto #196's merge tree. Do not open another PR yet.

Known numeric `array.generate` callbacks borrow captures while the caller keeps
them alive. The ownership pass removes temporary parameter-record and last-read
alias owners when uses cannot escape. Returned or stored values acquire owners.
Recursive/resource-scoped callbacks keep ordinary ownership. No syntax, wrapper
or ownership-IR convention was added.

| Evidence | Source and run | Current result |
|---|---|---|
| Compiler/native tests | `80d8f27e1bf57e4665503d6d1ed1af261f7dc672`, run `39783028890` | Five native hosts and width job pass; Linux AMD64 native tests pass but one new compiler unit fixture fails |
| Reporting-only change | `d1467854766fd93fa6e6c768d42f35e83fec3c1a`, run `39786472473` | Both numerical jobs pass; all 132 native images inspected; workflow still reports running despite all 61 jobs completed |
| Test/workflow repair | `3e5763b69ed075516bcbadf5d18dcb2a12f98078`, run `39789349262` | Passes, including 179 compiler unit tests; production compiler code is unchanged |

The failed fixture used an algebraic list, deliberately excluded from direct
borrowing, but expected alias removal. The repair tests eligible numeric arrays
and checks that excluded list aliases keep owners, including escapes. It also
makes the audit step run all three independent checks before returning failure.
The original failure remains recorded; it is not waived.

All 558 saved images from six native hosts and twelve WASI modules are inspected.
The corrected AMD64 source/run is recorded separately from the unchanged compiler.
Tests cover shared inputs, empty/negative counts, state, errors, yields,
cancellation, partial-array cleanup and effect order at O0/O2, ARC/tracing and
stack on/off. Broken controls add counts, leak owners or skip partial cleanup.
The extra order regression executes in logs; it is outside the saved-image count.

### Measured result and limits

Both Linux hosts reproduce 25,671 → **zero retains** for 129 coordinates and
199 updates, with unchanged 459 allocation requests, 216,925 requested bytes and
7,200-byte managed peak. Managed/raw storage ends at zero; no tracing collections.
All declared count/storage budgets pass. All 132 images were disassembled.

Largest new/old median ratios are 0.7216 AMD64 and 0.7983 ARM64; new/C is
2.3300/2.3754 and new/Rust 2.0138/1.9761. AMD64's one-update identical-code control
differs by 10%; ARM64's one-update candidate is 0.8% slower. No general speed claim
or timing budget. The update frame shrinks 112 → 96 bytes while instruction
sections grow 144/112 bytes. Generic dispatch and dynamic frame estimates are
retained in the machine-code report.

Earlier sources `90d54aaeeab8` and `f564d587cfdf` passed focused tests but failed
both application jobs with 597 retains at 3×199 updates. A temporary record,
then a last-read alias, caused the counts. Their logs/artifacts remain in the new
report. A controlled C edit diagnosed the cause; it was not compiler acceptance.
The runner now reports all count/storage budget violations before failing.
Incorrect output, cleanup violations, invalid raw traces and tool failures still
stop immediately. Automatic review rejected moving the early cleanup assertion;
it remains unchanged and no approval is pending.

### Next concrete actions

1. The targeted repair and combined preparation are accepted. Refresh
   `fwp-audit-capture-descent.py` for the numerical workflow conclusion.
   Numerical `jobsAccepted` is separate from strict workflow acceptance; do not
   invent a completed workflow conclusion.
2. Native, WASI and numerical inspection is complete. Do not repeat downloads.
3. `fwp-accept-capture-preparation.py` and `fwp-record-capture-ownership.py` have
   run successfully. The ownership report preserves the failed fixture and
   corrected-job proof, and includes an explained example from the tested program.
4. The numerical report was written by `fwp-record-capture-measurement.py` to
   `docs/measurements/array-capture-descent.md` and its JSON. Review final prose,
   cross-links and current handoff; run bounded format/docs/report checks.
5. After #196 merges, integrate the combined preparation onto that merge, verify
   compiler/runtime/native-test changes against recorded sources, update history
   and publish one substantial PR. Require all nine production jobs and docs at
   its exact head before squash-merge. Then continue the plan.

## Resume files and local checks

All helper/receipt paths below are under `/private/tmp/`.

| Purpose | Files |
|---|---|
| #196 delivery | `fwp-array-callback-delivery-publication.json`, `fwp-196-final-acceptance.json`, `fwp-array-callback-delivery-integration.json` |
| Compiler preparation | `fwp-array-captures-publication.json`, `fwp-array-captures-acceptance.json` |
| Numerical preparation | `fwp-capture-reporting-publication.json`, `fwp-capture-descent-acceptance.json` |
| Test-only repair | `fwp-capture-test-repair-publication.json`, `fwp-capture-test-repair-acceptance.json` |
| Native artifacts | `fwp-array-captures-evidence/80d8f27e1bf5/` |
| Numerical artifacts | `fwp-capture-descent-evidence/d1467854766f/`, including `worker-inspection.json` |
| Earlier failure artifacts | `fwp-capture-failure-evidence/90d54aaeeab8/`, `fwp-capture-failure-evidence/f564d587cfdf/` |

All publication helpers have already run; do not repeat their mutations.
Guarded preparation checks pass: formatting/workflow/docs/baseline reconstruction
8.13s; budget collector controls 0.14s; effect-order interpreter 0.25s. The saved
interpreter does not verify new native lowering. Full builds/tests/benchmarks stay
on GitHub; local checks remain serial under `python3 scripts/local-guard.py`.
Preserve 64 GiB free disk, targets below 2 GiB, sampled RSS below 1 GiB and the
180-second deadline. Never raise limits automatically.

Earlier cleanup removed only completed archives and six verified clean inactive
worktrees, preserving branches, evidence and dirty worktrees. Receipts:
`fwp-completed-archive-cleanup-20261022.json`, `fwp-clean-worktrees-20261022.json`.
Do not repeat cleanup helpers. Last post-cleanup space was 65.85 GiB; the guard
continues checking it. The longer old handoff is backed up as
`fwp-handoff-before-streamline-20261022.md`; it is historical context, not next work.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing and limit ARC at remaining boundaries |
| 2 | In progress | Extend proved borrowing and remove functional overhead |
| 3 | In progress | Meet measured machine-level time and memory budgets |
| 4 | In progress | Improve differentiation speed, memory and precision |
| 5 | In progress | Validate CPU numerical kernels |
| 6 | In progress | Stabilize comparisons and set workload budgets |
| 7 | In progress | Complete the finite application acceptance suite |
