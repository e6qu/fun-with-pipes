# Current work

**Next:** monitor runtime sessions `41629714632` and replacement AMD64 session 1
`41631438916`. Frozen source is `1f6a4ac80ed3e9e89106c27573d0c73d46bb6968`;
correctness prerequisite is `41626196812`. Compiler analysis `41629709664` passes
and all 480 commands are audited. Run each completed timing run through
`gradient-array-report` from the repaired audit branch, supplying that run and
the frozen source. Retain every timing/host outcome. PR #252 stays draft until
reports are complete and ready for the final nine-job production matrix.

## Checkout and recovery

- Persistent worktree: `.worktrees/gradient-array-results` under the primary
  repository; branch `gradient-array-results`. The detached primary checkout's
  recovery edits remain untouched.
- `/private/tmp` was cleared between messages. Published implementation
  `aed66f261c25ff74e37d04edd9f2d3717817510d` was restored. Keep working files and
  evidence in the project-local `.worktrees/gradient-work`, and checkpoint changes.
- Contract commit `c191421e`, tag `roadmap/gradient-array-protocol-2026-11-03`,
  predates implementation. The whole-change reference patch is committed at
  `aed66f26`; `roadmap/gradient-array-measurement-2026-11-03` freezes `1f6a4ac8`.
- PR #251 merged as `296ec5b4c3540c6d57671d076d2a39247b2389f4`; this
  branch is rebased onto it. [PR #252](https://github.com/e6qu/fun-with-pipes/pull/252)
  is the only active PR and remains draft.
  Every commit/merge message is one line, at most 80 characters, with no body,
  trailers or attribution.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | All logs audited; squash message and tested-tree equality verified |
| 2 | Verified | Focused array, typed/nested and both-engine behavior checks pass |
| 3 | Verified | All cleanup controls and 96 allocation observations pass; exact savings and all logs retained |
| 4 | Pending | Compiler/runtime measurements, independent audits, final platform matrix and delivery |

## Completed predecessor

PR #251 merged as `296ec5b4`, with all nine production jobs and documentation
passed and all logs audited. Its one-line message and tested-tree equality are
verified. [History](roadmap-history.md#direct-private-range-indices-pr-251) and
[gate records](measurements/range-zip-storage-2026-11-03/platforms/final-gates.json)
retain the complete evidence. Larger solves take 7.1–10.0% less time; small-case
speed goals remain open. Do not repeat completed measurements.

## Gradient-array first run and repairs

Run `41618374217` tests `aed66f26`. ARM64 job `125857466013` and AMD64 job
`125857466216` complete with the same two failures under GCC and Clang. Both
builds, all-target Clippy and selection units pass. All 16 integration target logs
per host have been inspected; no other failures were found. [Retained evidence](measurements/gradient-array-storage-2026-11-03/README.md)
includes all 32 target logs, full jobs, artifact identities and diagnostics.
Archive digests match GitHub metadata; tag
`roadmap/gradient-array-first-attempt-2026-11-03` preserves the original source.

| Failure | Cause and repair |
|---|---|
| Nested cleanup instrumentation cannot find stage 5 | It targets the removed list builder. Move stages 5 and 12 to the completed array-slot transfer and the protected input-owner transfer. Keep every existing fault/cancellation mode. |
| F128 recording exceeds cumulative charge by 32 bytes | The expected value now builds an extra array from a singleton list. Saved generated C calls `array.from-list` before the workload. Make that expected array an explicit compile-time constant; keep every original recording/memory limit. |

The recording harness now collects failures across all scalar types, stack modes,
optimization levels and workspace modes instead of stopping at the first result.
The new array-map/zip fault branch shares the existing list harness: callback
failure, between-stage failure, cancellation, allocation failure, partial output,
aliases and deliberate missing releases. Both repairs and the additional controls pass on GCC/Clang ARM64/AMD64.

The complete gradient/update fixture already passes both engines and native
GCC/Clang O1/O2, including input aliases and empty/singleton cases. Packed slices,
map order, F128 precision, typed-result owner controls, checkpoints, workspace,
capacity and library cleanup also pass in the first run, except the two cases above.

## Checks and current execution

Guarded local checks before the temporary-directory reset passed: primitive
inventory (394 declarations, 384 symbols, 40 aliases), generated stdlib comparison,
reference isolation and Clang O1/O2 typed-result cleanup controls. These are
focused checks, not final-platform or performance acceptance. Rust formatting
passes again in the persistent checkout (1.79s).

The count limits, exact constructor attribution and runner count/audit step are
restored. Guarded checks pass: gradient count fault tests (3, 0.13s), whole-change
reference controls (3, 0.24s), formatting (1.78s), and workflow lint (5.85s).
The array unwind extension and typed callback rejection controls are restored.
Allocation results are now retained below; timing remains unmeasured.

Compiler/time comparison manifests, independent seven-source reconstruction and
measurement workflow routes are restored. Guarded checks pass: reference controls
(5, 0.49s), timing budgets (16, 0.13s), compiler driver controls (7, 0.83s),
evidence reader (14, 42.71s), grouped reports (12, 5.49s), retention controls
(3, 0.13s), workflow lint (5.81s), and roadmap audit (2.52s). The first roadmap
audit rejected the status word `Complete`; the handoff now uses its required
`Verified` status. No acceptance requirement was changed.

Run `41626196812` passes at `f00fb9dccf6fa0ea6b1bde6f0a6906fc2ed83224`:
ARM64 job `125884054605`, artifact `13226204616`; AMD64 job `125884054997`,
artifact `13226053942`. Each host passes 19 units, 72 integration executions,
48 allocation observations, 16 array-map/zip controls and 72 typed probes.
Every target/full log is clean and all 525 saved images per host have native
ELF headers. Artifact digests match metadata; the runner independently audited
all raw count files. Retention/derived-summary check passed locally in 0.99s.
[Complete results](measurements/gradient-array-storage-2026-11-03/README.md).

Largest current-only solve: 105,203 → 79,731 requests; 3,736,014 → 3,326,870
requested bytes; retains 995, peak 14,976, final 0 remain unchanged. Raw buffers
and derivative work stay unchanged; largest reported stack frames do not grow.
Code size is reported separately. No elapsed-time result exists yet.

Documentation `41627595545` / `125888781247` passes at `a4f9df46`; its full log
contains only expected runner-failure controls. The duplicate post-merge main
run `41625843765` is cancelled after confirming the tested #251 tree; it had no
failed jobs or steps. Native check sources match the prepared measurement branch;
subsequent scripts/docs changes do not alter compiler/runtime/library/test trees.

[Compiler analysis](measurements/gradient-array-analysis-2026-11-03/README.md)
`41629709664` passes: AMD64 job `125895871607`, ARM64 `125895872041`. All 480
commands, exact source/reference files, inputs, generated C, images and memory
records are audited. Maximum ratios: time 1.0001024, RSS 1.0017344, identical
copies 1.0115275. Local audits: AMD64 57.85s, ARM64 49.47s, input/retention 0.13s.

Runtime `41629714632` has three qualified sessions measuring. AMD64 session 1
rejected EPYC 9V74 in that run and replacement `41630230085`, then EPYC 9V45 in
`41630692989`. All stopped before building/timing; none has measured samples.
Replacement `41631438916` requests only that session on the same frozen source.
[All host records](measurements/gradient-array-time-2026-11-03/README.md) are retained.
Scratch archives and audit helpers are under `.worktrees/gradient-work`:
`checks-41626196812`, `gradient-analysis`, `audit-gradient-analysis.py` and
`collect-gradient-checks.py`. Large raw timing audits run on GitHub, not locally.

A real-patch regression exposed an audit-only bug: canonical Git and difflib
hunks need not match. The seven-source checker now validates patch application,
exact resulting bytes, file inventory and hashes. The complete reference tests
pass (6 tests, 0.61s). This changes neither frozen measurement source nor limits.

Local work stays serial under `scripts/local-guard.py`: 64 GiB free disk, targets
below 2 GiB, sampled RSS below 1 GiB and 180 seconds. Last free space about 88 GiB.
Full builds, suites and measurements belong on GitHub runners; never raise limits.
