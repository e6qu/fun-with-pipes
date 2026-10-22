# Session handoff

All seven areas of [PLAN.md](../PLAN.md) remain open. Continue grouped deliveries;
JIT is excluded. Ownership, borrowing and removal of tracing remain the priority.

## Merged baseline

The user merged [PR #197](https://github.com/e6qu/fun-with-pipes/pull/197).
Main is `b94710c9212cbbfc3e39409835e539b371069b36`; all nine production jobs
in run `39793823991` and documentation `39793823875` passed for head
`0367e81941a213b96de14dbe175143ff0a121f77`. The merge tree matches that head,
its sole parent is #196, and its message is one line under 80 characters without
trailers. Receipt: `/private/tmp/fwp-197-user-merge.json`. Do not merge it again.
All completed logs have now been audited without unexpected errors or panics:
`/private/tmp/fwp-197-final-acceptance.json`. Earlier HTTP 503 download failures
were resolved; the auditor now checkpoints each downloaded job.
No duplicate main production run was present at the merge check.

Borrowed numeric array captures now avoid temporary parameter-record owners and
last-read alias retains. [The measurement](measurements/array-capture-descent.md)
shows 25,671 → zero retains for 129 coordinates and 199 updates, with unchanged
459 allocation requests and 7,200-byte managed peak. Cleanup, effects and order
remain checked. This does not remove all GC or demonstrate general C/Rust parity.
[The ownership report](measurements/array-capture-borrows.md) retains 558 native
images and twelve WASI modules; history preserves preparation evidence.

## Current batch: direct calls and reliable comparisons

Worktree `/private/tmp/fwp-descent-call-costs`, branch
`measure-descent-call-costs`, starts from #197's tested head. Published source
`e681dc447039cd1ce5fbf4a27add9e96f9238275` emits generic call adapters only
for function values and external dispatch. Direct calls keep concrete bodies;
services and transport-created iterators explicitly keep their table entries.
Stack function values still retain adapters and ownership metadata. Do not claim
the numeric array callback has lost its entry: its stack closure still needs it.

Native run `39806320364` exposed a test configuration error: the new direct/dynamic
call test requested tracing stress in ARC-only mode. The local repair enables
collector stress/verification only for tracing and retains reuse verification in
both modes. Production compiler code is unchanged. All six completed native jobs have been audited: this is their only failure.
No failed native job counts as acceptance. The intentional
gRPC startup-timeout panic is a caught, passing negative control, recorded
separately from unexpected diagnostics. Auditor/receipt:
`/private/tmp/fwp-audit-entry-preparation.py` and
`/private/tmp/fwp-entry-preparation-acceptance.json`.

Both Linux numerical jobs in `39806328073` pass; all 132 executable images are
inspected. Instruction bytes in the largest case fall 41,778 → 34,418 on AMD64
and 40,172 → 32,508 on ARM64. All packed cases preserve zero retains and their
allocation/storage budgets. Generic adapters fall from eighteen to two. Timing
is inconclusive: identical AMD64 copies differ by up to 22%; ARM64's 33-coordinate
case is 5.3% slower. Preserve these results; claim smaller code only. The report
and raw evidence are prepared in this worktree, with artifact inspections under
`/private/tmp/fwp-entry-descent-evidence/e681dc447039/`.

The width job passes: twelve executed 32-bit WASI modules and their instructions
have been inspected, including allocation bounds and broken controls. Evidence:
`/private/tmp/fwp-entry-native-evidence/e681dc447039/pointer-width.json`.
This does not substitute for native platform checks.

An earlier inline experiment at `55de3ce53f0924c9cd688a0d680058b3f47d076d`
passed both Linux jobs in `39798044726`; all 120 images were inspected. Neither
candidate met the predeclared 5% improvement. No inlining rule was selected.
The worktree retains the complete report and slower/noisy cases.

## Next action

Finish auditing all failed native jobs together, then publish the test repair
with the prepared comparison tools and reports. No next PR is open yet.
The new batched protocol runs 512 complete solves per process, each with fresh
input and full output/cleanup. It compares old/new packed fwp, identical copies
of both, and C/Rust using 48 balanced samples after four warmups. It is a separate
experiment to diagnose startup noise; it does not replace the single-solve report.
Both copy controls must stay within 2%; timing claims need two independent runs
on matching CPU models. The workflow choice is `descent-batches`.

Prepared files include `scripts/measure-descent-batches.py`, the workflow,
`docs/measurements/descent-batch-protocol.md`, `direct-call-entries.md` and its
raw JSON. They are uncommitted, along with the ARC test-environment repair.
Bounded checks passed: 72 saved-source edits, schedule checks, Python syntax,
workflow lint, Rust formatting and budget fault controls (3.95 seconds).
Six small C/Rust binaries also executed two complete 33×199 solves each and
matched output and cleanup profiles (3.01 seconds); no local timing claim.
Receipts are `/private/tmp/fwp-check-batch-probe.py` and
`/private/tmp/fwp-batch-two-solve-check/report.json`.

Integrate the completed batch onto #197's merge, keep one active PR, and require
all nine production gates plus documentation on its final head. Squash merge is
authorized after acceptance, with an explicit single-line subject of at most
80 characters and an empty body. Verify the merge, update this handoff and
continue the plan. Full builds, test suites and timing run on GitHub.

## Local resources

Use `python3 scripts/local-guard.py COMMAND...` serially for bounded checks.
Preserve 64 GiB free disk, targets below 2 GiB, sampled workload RSS below 1 GiB
and the 180-second deadline. The guard stopped an artifact download below the
disk threshold. Removing two verified clean, inactive worktrees restored about
67 GiB; modified worktrees, branches, commits and evidence were preserved.
Cleanup receipts: `/private/tmp/fwp-clean-worktrees-20261022-second.json` and
`/private/tmp/fwp-clean-worktrees-20261022-third.json`. Do not repeat old mutation
helpers or remove other worktrees without checking their current contents.
