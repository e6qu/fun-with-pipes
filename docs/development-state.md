# Current work

**Next:** audit `gradient-array-checks` run `41626196812` at `f00fb9dc`: every
GCC/Clang target and all 96 allocation observations. Fix all failures together.
Once it passes, freeze the measurement head and dispatch compiler analysis plus
two runtime sessions per architecture using that run as the correctness prerequisite.

## Checkout and recovery

- Persistent worktree: `.worktrees/gradient-array-results` under the primary
  repository; branch `gradient-array-results`. The detached primary checkout's
  recovery edits remain untouched.
- `/private/tmp` was cleared between messages. Published implementation
  `aed66f261c25ff74e37d04edd9f2d3717817510d` was restored. Keep working files and
  evidence in the project-local `.worktrees/gradient-work`, and checkpoint changes.
- Contract commit `c191421e`, tag `roadmap/gradient-array-protocol-2026-11-03`,
  predates implementation. The whole-change reference patch is committed at
  `aed66f26`; measurement identities still need freezing before timing.
- PR #251 merged as `296ec5b4c3540c6d57671d076d2a39247b2389f4`; this
  branch is rebased onto it. [PR #252](https://github.com/e6qu/fun-with-pipes/pull/252)
  is the only active PR and remains draft.
  Every commit/merge message is one line, at most 80 characters, with no body,
  trailers or attribution.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | All logs audited; squash message and tested-tree equality verified |
| 2 | Implemented | Both Linux compilers/lints and array selection/application checks pass; verify both repaired test assumptions |
| 3 | In progress | Run restored array fault controls and all 96 allocation observations; retain complete failures |
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
aliases and deliberate missing releases. These repairs still need runner checks.

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
No new allocation or timing observations exist yet.

Compiler/time comparison manifests, independent seven-source reconstruction and
measurement workflow routes are restored. Guarded checks pass: reference controls
(5, 0.49s), timing budgets (16, 0.13s), compiler driver controls (7, 0.83s),
evidence reader (14, 42.71s), grouped reports (12, 5.49s), retention controls
(3, 0.13s), workflow lint (5.81s), and roadmap audit (2.52s). The first roadmap
audit rejected the status word `Complete`; the handoff now uses its required
`Verified` status. No acceptance requirement was changed.

Run `41626196812` was dispatched after all known native failures were repaired.
ARM64 job `125884054605` is running integration targets; AMD64 `125884054997`
has passed build/lint and reached the selection units. The run's
compiler/runtime/library/test sources match the prepared measurement branch;
later script/docs changes do not alter those trees. No performance result exists yet.

Local work stays serial under `scripts/local-guard.py`: 64 GiB free disk, targets
below 2 GiB, sampled RSS below 1 GiB and 180 seconds. Last free space about 88 GiB.
Full builds, suites and measurements belong on GitHub runners; never raise limits.
