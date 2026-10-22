# Session handoff

## Current combined delivery

Main is `40dda0795fd150feb3dc0543052c3bf041e865c8`, the verified squash of
[PR #195](https://github.com/e6qu/fun-with-pipes/pull/195). All nine production
jobs and documentation passed; tree, parent and one-line message were verified.
Redundant same-tree production CI was cancelled; documentation was preserved.
[History](roadmap-history.md#native-commands-and-test-recovery-pr-195) records
its native command, test-recovery and derivative-storage work.

Branch `array-moves-and-callback-inputs`, worktree
`/private/tmp/fwp-array-callback-delivery`, combines copied synchronous C callback
strings, array-owner moves, C/Rust application comparisons and the measurement
repair. The preparation at `ea4ce3f1f496513e5edddec6ff4483418ba50875` was replayed
onto #195's identical merge tree; files were verified before these delivery-doc
updates. [PR #196](https://github.com/e6qu/fun-with-pipes/pull/196) is the sole open PR,
at `7bb4b5d49341fc67f9b76840feeeb8e479c3392e`. Production run `39775586712`
and documentation run `39775586540` have started. Documentation, benchmarks and both ARM64 macOS jobs pass;
the six other production jobs remain running with no failed steps in the latest
complete-job audit. The earlier head failed
the tutorial copy check; its retained receipt is
`/private/tmp/fwp-196-d98abe29139c-acceptance.json`. The supplied visit.c/fwp/output
and console session repair pass the actual Rust consistency check and saved
interpreter example locally (5.59s). Superseded production `39772506582` was
cancelled; all final gates must pass at the repaired head.
Focused checks alone do not authorize merge.

**Next:** audit all final-head jobs with `/private/tmp/fwp-audit-196-final.py`; fix any
failures together. Require all nine production jobs and documentation for the
exact commit. Then squash-merge with an explicit one-line subject of at most 80
characters and empty body; verify tree, parent and message. Publication and merge
are already authorized. Ready merge/postmerge helpers: `/private/tmp/fwp-merge-196.py`
and `/private/tmp/fwp-after-merge-196.py` (not yet run). Publication receipt:
`/private/tmp/fwp-array-callback-delivery-publication.json`.
The publication helper opened the PR correctly but looked for a wrong docs
workflow name; `fwp-locate-array-callback-runs.py` repaired its local receipt.
The actual production and documentation jobs are running.
Continue the next ownership task independently while these gates run.

## Focused checks and measurements

| Work | Focused evidence |
|---|---|
| [Copied callback strings](measurements/callback-inputs.md) | Source `6d8ef30bb428`, run `39758960569`; all six native hosts and 32-bit/WASI pass, with 186 native images and 12 WASI modules inspected |
| [Four-way derivative baseline](measurements/descent-peers.md) | Source `018581d6c071`, run `39755925964`; both Linux jobs and 72 images pass |
| [Packed-array baseline](measurements/packed-descent.md) | Source `1827c3bdc427`, run `39763694417`; both Linux jobs and 96 images pass |
| [Stack-array ownership](measurements/stack-array-ownership.md) | Compiler source `026db07bacbe`, run `39767702114`; all six native hosts and 32-bit/WASI pass, with 270 native images and 12 modules inspected |
| [Array-move measurements](measurements/array-owner-moves.md) | First/repeat runs `39767706345`/`39769019993`; revised protocol source `96967e9ba199`, run `39770344180`; all six Linux jobs and 372 images pass |

All complete logs are audited. The new ownership checks cover shared aliases,
failure/cancellation, tracing stress/verification and deliberately broken cleanup
controls at O0/O2. Missing C compilers fail explicitly. Callback return pointers,
retained callbacks and struct-valued C callback arguments remain outside the new
copied-input contract. No JIT, compatibility adapter or runtime wrapper was added.

The largest packed descent case now makes 25,671 retains instead of 51,342,
with unchanged 459 allocation requests and 7,200-byte managed peak. All repeated
cases halve retains, and managed/raw ledgers finish at zero. Timings do not
establish a general speedup. Earlier small-case slowdowns are preserved; revised
order balances positions and immediate predecessor pairs within rounds and adds
a byte-identical control. Identical bytes still vary by several percent. The
revised AMD64 runner is Intel, unlike the earlier AMD hosts; cross-run differences
cannot be attributed solely to ordering. ARM64's callback frame grows 48→64 bytes;
AMD64 stays at 48. Reports retain code/stack costs and all samples.

Count/storage requirements and focused correctness pass. Timing remains
inconclusive, with no speed threshold or parity claim. One retain per coordinate
still comes from the callback capture. The next compiler task is to prove
caller-owned borrowing through eligible known callbacks, preserving exceptional
cleanup. Before claiming speed, establish a timing budget and stable identical-code
controls. Broader ownership boundaries and all seven roadmap areas remain open.

## Following preparation: borrow array-generation captures

Branch `borrow-array-captures`, worktree `/private/tmp/fwp-array-capture-borrows`,
has published source `80d8f27e1bf57e4665503d6d1ed1af261f7dc672`, tag
`roadmap/revision-array-captures-80d8f27e1bf5`. Ownership run `39783028890`
passes Linux ARM64, both Windows hosts, ARM macOS and pointer-width checks.
Intel macOS is running. Linux AMD64 failed the new alias unit test; the full log
shows 178 passed and one failed. Native ownership checks passed in that job. Its queued
measurement run `39783034906` was cancelled after the reporting-only replacement
was published. Compiler-focused receipt:
`/private/tmp/fwp-array-captures-publication.json`. Keep #196's final head unchanged.
The branch starts at #196's initial `d98abe29139c`, but includes its later tutorial
repair; preserve that repair when integrating onto #196's eventual merge tree.

The generator gives eligible known numeric `array.generate` callbacks direct
borrowed calls while the caller keeps captures alive. It reuses ownership insertion,
liveness checks and partial-array cleanup. Recursive/resource-scoped callbacks
keep ordinary ownership. Record forwarding removes temporary owners only through
projections and proved borrowed calls. Alias normalization uses a caller-borrowed
parameter's whole-call lifetime, including its last read. Escaping results still
acquire owners. No new syntax or ownership-IR convention was added.

Two earlier sources (`90d54aaeeab8`, `f564d587cfdf`) passed all seven focused jobs
but failed both numerical zero-retain requirements: 597 retains remained for
3 coordinates × 199 updates. First, a temporary record acquired an array owner;
then a last-read alias reacquired that owner after record forwarding. Every
completed log and both hosts' generated C/profile artifacts were audited.
Receipts are archived with each source's twelve-character suffix. The first
repair passed 178 compiler unit tests. The second adds a last-read/escape test.

A controlled C experiment removing only the final retain/release pair reproduces
zero retains at O0/O2, with identical output, 207 allocation requests, 6,617 requested
bytes, 176-byte managed peak and zero final charge. This diagnoses the cost but
does not verify the new Rust lowering. Guarded `fwp-diagnose-capture-last-read.py`
passes in 1.94s; receipt `fwp-capture-last-read-diagnosis.json`.

Tests cover shared inputs, zero/negative counts, state retention, errors, yields,
cancellation and partial-array cleanup. Broken controls add retains, leak owners
or skip partial releases. The effect-order regression prints count preparation,
capture preparation and each callback index; its saved-interpreter output matches
in 0.25s. Its native O0/O2, ARC/tracing and stack on/off checks are in the new run.
Guarded `fwp-ready-array-captures.py` passes in 8.10s (format, workflow, docs and
exact accepted baseline reconstruction). These focused local checks do not prove
new native behavior. Previous Windows images and twelve WASI modules were inspected;
final-source inspection remains required.

**Next:** run `fwp-audit-array-captures.py` and `fwp-audit-capture-descent.py` under
`/private/tmp/`; fix every failure together. Preserve the declared zero-retain
requirement for repeated packed cases, unchanged allocation/byte/raw-storage counts
and no larger managed peak. Inspect 93 native images per host, twelve adjacent
WASI modules and 132 numerical images when their jobs pass, using the
`fwp-inspect-array-captures.py`, `fwp-inspect-capture-width.py` and
`fwp-inspect-capture-descent.py` helpers. Report code/stack costs, slower cases and
identical-code variation without inventing a speed claim. The prepared
`fwp-inspect-capture-workers.py` records actual numerical-function instructions
and static frames after the two numerical host inspections complete.
`fwp-record-capture-ownership.py` is prepared but has not run; it requires the full
focused acceptance and inspection. All publication helpers have already run; do not repeat their mutations.

Reporting-only source `d1467854766fd93fa6e6c768d42f35e83fec3c1a`, tag
`roadmap/revision-capture-reporting-d1467854766f`, runs numerical comparison
`39786472473`. Receipt `fwp-capture-reporting-publication.json` proves the compiler,
runtime and native tests are unchanged from source `80d8f27e`; its focused matrix
continues. Both source IDs must remain in the final evidence. The preparation
worktree is clean at `d1467854`.

The measurement runner now records all count/storage violations across inputs,
saves its report and fails at the end. Incorrect output, invalid raw-memory traces,
cleanup violations and tool failures still stop immediately. Acceptance limits are
unchanged. Three focused controls cover recorded cases from both hosts, seven
simultaneous budget violations and a changed frozen baseline; they pass in 0.14s.
Both CI workflows run these controls. Workflow validation passes in 3.33s and the
publication precheck in 8.20s, all guarded. The batch also fixes a macOS shell
assignment that could mask an `xcrun` failure. Automatic review rejected moving
the early managed-cleanup assertion; it remains unchanged. No approval is pending.
The numerical auditor and image/worker inspectors use the reporting publication;
the native ownership auditor and inspector use the compiler publication.

The failed unit fixture used an algebraic list, which `parameter_type` deliberately
excludes from direct borrowing, yet expected its alias to disappear. The pending
repair tests an eligible numeric array and also checks that the excluded list
keeps its owner, for direct/record aliases and escaping results. Production code
is unchanged. The ownership-audit shell block now runs all three independent
checks even if one fails, retaining a failing exit status. Publish this test/workflow
repair and rerun Linux AMD64 only; keep passing platform checks and the ongoing
numerical run tied to their original sources. The final delivery still requires
all nine production jobs and docs at one exact head. No failure is waived.

## Resume files

Paths below are under `/private/tmp/`; keep accepted sources and receipts intact.

| Purpose | Files |
|---|---|
| Accepted #195 delivery | `fwp-195-final-acceptance.json`, `fwp-195-merge-runs.json` |
| Compiler-focused evidence | `fwp-stack-array-publication.json`, `fwp-stack-array-acceptance.json`, `fwp-stack-array-evidence/026db07bacbe/` |
| Numerical measurement and controls | `fwp-balanced-descent-publication.json`, `fwp-balanced-descent-acceptance.json`, `fwp-balanced-descent-evidence/96967e9ba199/` |
| Earlier numerical runs | `fwp-stack-descent-evidence/026db07bacbe/`, `fwp-stack-descent-repeat-evidence/026db07bacbe/` |
| Final preparation and integration | `fwp-stack-array-final-preparation.json`, `fwp-array-callback-delivery-integration.json` |

The primary checkout is detached at #195 with the live handoff as its only edit.
Run focused checks there, serially, through `python3 scripts/local-guard.py`.
Full builds, full suites and benchmarks stay on GitHub. Preserve 64 GiB free disk,
target data below 2 GiB, sampled workload RSS below 1 GiB and the 180-second limit.
Do not raise limits. Earlier disk cleanup removed only completed downloaded
archives, preserving reports and hashes; receipt:
`fwp-completed-archive-cleanup-20261022.json`. A later clean-checkout review removed
six inactive, clean worktrees (394 MiB nominal), preserving their branches and
all modified worktrees. Free space after cleanup: 65.85 GiB. Receipt:
`/private/tmp/fwp-clean-worktrees-20261022.json`; the review is
`fwp-old-worktrees-review.json`. Do not rerun the cleanup helper.
The next preparation includes the application-acceptance update and effect-order
regression in published source `80d8f27e`; the later reporting-only changes are listed above.

Report validation `fwp-check-array-callback-reports.py` passes in 7.43s, including
the repaired required roadmap-status table. Recent guarded checks: `fwp-check-balanced-descent.py` passes in 6.28s (order
balance, seed reproducibility, workflow/docs); AMD64/ARM64 recorded-sample analysis
passes in 2.32s/2.20s; actual callback disassembly/frame inspection passes in 0.37s.
Native artifact inspection is complete; do not repeat downloads or measurements
without a new reason. Interpreter-only checks are not evidence for new C generation.

[PLAN.md](../PLAN.md) remains the project roadmap; [history](roadmap-history.md)
records completed delivery. All seven areas remain open. JIT is excluded.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing and limit ARC at remaining boundaries |
| 2 | In progress | Prove callback borrowing and remove functional overhead |
| 3 | In progress | Meet measured machine-level time and memory budgets |
| 4 | In progress | Improve differentiation speed, memory and precision |
| 5 | In progress | Validate CPU numerical kernels |
| 6 | In progress | Stabilize comparisons and set workload budgets |
| 7 | In progress | Complete the finite application acceptance suite |
