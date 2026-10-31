# Current work

**Next:** diagnose the three qualified AMD64 construction regressions using
byte-identical object reproduction and GCC source-level reports. Preserve the
[phase results](measurements/callable-phases.md), and fix any main production failure.
Prioritize execution time and working memory; preserve inconclusive measurements.

Worktree: `/private/tmp/fwp-returned-callables`; branch `callable-phase-costs`;
[PR #235](https://github.com/e6qu/fun-with-pipes/pull/235) is the only active PR.
The primary checkout has unrelated preserved work; do not reset it.
User-merged PR #234: `219e3a0130c18d60750fd55ec9c0a684c1dcefd4`, tree
`b4a70d124eb2674b3f9138ece4600f77cc427dab`. The subject is one line with no body.
Its full production matrix had not run before merge. Main CI `41218527464`
remains running/queued; benchmark job `124588033339` and docs `41218527417` /
`124588033356` pass and their logs are audited. Preserve the remaining gates.

## This batch

- Time 4,096 independent scalar closures per batch, 256 batches, 16 calls each.
  Compare C, Rust core with a C caller, native Swift, current fwp and the same
  generated C with only the borrowed-call branch disabled. No runtime/API change.
- Separate construction, invocation, release and complete-process clocks. Count
  ownership in separate diagnostic executables; measure process RAM separately.
- Twenty rounds balance positions/predecessors across ten labels, including one
  identical copy of each executable. Two sessions run on each same native host,
  avoiding the earlier AMD64 CPU mismatch. Noise and minimum-duration limits
  remain explicit; no unchanged retry or size-based performance claim.
- Test checksum rejection, missing/reordered/noninteger timings, insufficient
  duration, noisy copies, schedule balance and exact reference transformation.
  Add the actual new clock helper to failed-clock and omitted-check controls.

## Phase results and current checks

Measured source `dfb6ff8e`, run `41219092543`: ARM64 `124589718380` and AMD64
`124589718541` both pass two sessions and artifact audits. All compiler logs and
completed controls are reviewed. Six record tests, 56 clock controls and 33 Swift
arithmetic cases pass per host, plus fwp count/cleanup controls. ARM64 meets all
candidate timing/RAM limits. AMD64 has three qualified construction regressions
(8.6–16.1%) and one noisy addition case; combined timing acceptance remains open.
The first-run summary retains all results; no unchanged measurement retry.

The source head's docs `41219094215` / `124589718157` passes; its full log is
reviewed, with only intentional runner/selector failures. Diagnostic run
`41220300146`: ARM64 `124593267740` passes and reproduces both objects byte for
byte; its factory inlining decisions agree. AMD64 `124593267611` remains queued.
Independent audit `41219859189` / `124591988150` remains queued on AMD64; move that
read-only audit to ARM64 and supersede only its unstarted run. No saved binaries
execute in the artifact audit. A new record test freezes all 26 passing, three
failed and three inconclusive candidate phases; it needs the new head's docs gate.

## Existing evidence

[Swift results](measurements/swift-peers.md) own source `80a0504a`, four passing
native measurement jobs in `41214191081`, and independent audit `41215212017`.
Five ARM64 cases qualify in both sessions. Map/pipeline fail copy controls;
AMD64 CPU models differ. Keep all ten inconclusive case/session rows. Full raw
artifacts expire 2027-01-29; repository JSON is a summary, not their replacement.
Final PR #234 docs gate `41216482768` / `124581961872` passes, including four Swift
record tests. Logs contain only intentional runner/selector failure controls.

[Callable evidence](measurements/returned-callables.md) owns baseline `7d7cf98b`,
first candidate `1f929022`, revised candidate `dacaf253` and immutable archives.
The merged change removes one retain/release pair and one helper per invocation;
closure storage remains. Original ARM O1 text grows 24,540 → 28,892 bytes and
fails the original 5% limit. Preserve that result and hardware erratum protection.
Elapsed-time acceptance has not been established. Do not infer it from counts.

## Local checks

Free disk is about 60 GiB, below the required 64 GiB. The unchanged local guard
refuses the new focused Python test. Its first sandbox attempt could not inspect
`ps`; the escalated guard reached the disk check and refused before execution.
Do not bypass limits, build locally or download large artifacts. Checks and
measurements run on GitHub. The focused native jobs now verify the test/clock/workflow changes; no local
passing result is claimed. New diagnostic code still needs its dispatched check.

Require nine exact-head production jobs and docs before our next squash merge.
Use one subject of at most 80 characters, empty body and no attribution/trailers.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain GC-free lifetime and cycle checks |
| 2 | Verified | Preserve scoped A1–A6; broader costs belong to B1 |
| 3 | Verified | Preserve the stated F1–F3 call/recursion scope |
| 4 | Verified | Preserve decimal savings and the recorded loop gap |
| 5 | In progress | Meet D2's remaining timing requirement |
| 6 | In progress | Resolve N1 controls before N2 timing acceptance |
| 7 | In progress | Complete callable phase costs and remaining B1/B2 peers |
| 8 | In progress | Complete numerical and integrated V1/V2 acceptance |

[PLAN.md](../PLAN.md) retains the unchanged numerical budgets and failed controls.
