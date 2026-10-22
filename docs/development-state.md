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

## Current delivery: direct calls and reliable comparisons

Delivery branch `direct-call-entries`, worktree
`/private/tmp/fwp-direct-entry-delivery`, is based on #197's verified merge.
Preparation remains in `/private/tmp/fwp-descent-call-costs`; its complete tree
was reproduced on the merge before updating this delivery handoff. Published source
`e681dc447039cd1ce5fbf4a27add9e96f9238275` emits generic call adapters only
for function values and external dispatch. Direct calls keep concrete bodies;
services and transport-created iterators explicitly keep their table entries.
In the measured adapter-only source, stack function values still retain adapters
and ownership metadata. Those measurements do not establish the newer capture
representation described below.

Native run `39806320364` exposed a test configuration error: the new direct/dynamic
call test requested tracing stress in ARC-only mode. The local repair enables
collector stress/verification only for tracing and retains reuse verification in
both modes. Production compiler code is unchanged. All six completed native jobs have been audited: this is their only failure.
All 714 saved native images from individually passing tests are inspected;
`docs/measurements/direct-call-native-2026-10-22.json` preserves the failed jobs
separately from their successful artifact checks.
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

## Expanded work requested for this PR

The user explicitly added three related tasks: extend capture simplification to
`fold`/`fold-right`, test callback lifetime boundaries, and check live memory between
complete solves. Work is in `/private/tmp/fwp-direct-entry-delivery`, branch
`direct-call-entries`, starting at integrated commit
`105bda29b849059098a5b95da3363a0c81d306d1`. No PR has been opened yet.

Uncommitted compiler edits flatten eligible local callback captures into local
values, preserve capture evaluation at the original binding, and reuse typed
child-owner/unwind cleanup. Every value use must be a known array generator or
fold callback. Escapes, aliases, ordinary calls and resource frames retain their
representation. Fold entry marking now follows actual borrowed/owned dispatch.
Existing zero-retain, error/cancellation/order and stress tests remain required;
new representation assertions and a mixed/reused/stored callback fixture extend them.
Focused CI saves 24 additional fold/boundary executables under `direct-captures/`,
including forced extra-retain controls, for independent machine-code inspection.
The saved interpreter validates the fixture; it does not verify new C generation.
Expanded transformation, documentation, workflow and budget checks passed in
6.78 seconds before adding artifact capture; repeat affected formatting/workflow
checks for the final published source.

The repeated-work observer records managed/raw live storage after each solve.
Its delayed-release control must fail 225 even though the final-only control
releases everything before exit. Six bounded local C controls passed in 3.06s:
`/private/tmp/fwp-two-solve-observers-verified/report.json`. Checks caught and fixed
loop scoping and the control's typed leaf-release call before publication.
The fixture's function-value applications and concatenation oracle were corrected;
its interpreter/format check passes in 0.37s. Full compiler checks belong on CI.

Both initial batched jobs in `39812251121` now pass; inspect their artifacts with
`/private/tmp/fwp-inspect-descent-batches.py --host HOST`. Their 48 images/host
predate the new between-solve observer and do not validate it. The earlier repaired
native run `39812255716` is running its test targets. Audit every failure together.

## Next action

**Next:** publish the expanded preparation after final formatting and run
focused compiler/native checks plus numerical comparisons on GitHub. Inspect the
earlier completed timing artifacts while those run; then publish one combined PR.

All failed native jobs have been audited, and the test repair and comparison
tools are published. Publish this integrated branch as one PR and require its full production gates.
Numerical checks can continue while those gates run. Publication receipt:
`/private/tmp/fwp-direct-entry-publication.json`; integration receipt:
`/private/tmp/fwp-direct-entry-integration.json`.
The new batched protocol runs 512 complete solves per process, each with fresh
input and full output/cleanup. It compares old/new packed fwp, identical copies
of both, and C/Rust using 48 balanced samples after four warmups. It is a separate
experiment to diagnose startup noise; it does not replace the single-solve report.
Both copy controls must stay within 2%; timing claims need two independent runs
on matching CPU models. The workflow choice is `descent-batches`.

Preparation `b9ff767c5ab3642ac4bc26ae2ae6153f20560d3b` is published.
Repeated-work run `39812251121` has both Linux hosts; native repair run
`39812255716` selects Linux AMD64. Other hosts will verify the repaired test
in final production CI, avoiding another full six-host preparation. Publication
receipt: `/private/tmp/fwp-batch-preparation-publication.json`.

Prepared files include `scripts/measure-descent-batches.py`, the workflow,
`docs/measurements/descent-batch-protocol.md`, `direct-call-entries.md` and its
raw JSON. They are committed with the ARC test-environment repair.
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
