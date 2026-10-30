# Current work

**Next:** audit PR #229's remaining Linux/Windows jobs and squash-merge only after
all nine production jobs, documentation and both G2 hosts pass at
`8d908e0e0d5db3a2d836e2fc978c70fa99ad04a8`. Then deliver the prepared file-boundary
batch below as the next single PR. Preserve the passing head while checks run.

## Active delivery

[PR #229](https://github.com/e6qu/fun-with-pipes/pull/229) combines
[direct string results](measurements/direct-string-results.md),
[file-read failure controls](measurements/file-read-failures.md), two repaired
C-library allocation observers and the
[executable-name diagnostic](measurements/timing-variation.md#executable-name-results).

| Gate | Run | Audited status |
|---|---|---|
| Production | `41051447921` | Eight jobs pass; Linux AMD still running |
| Documentation | `41051447945` | Pass |
| G2 compiler-analysis budgets | `41051466208` | Both hosts pass, 226 tests each |

Each regular Mac job passes 627 tests/132 summaries; each ownership job passes
364/127. Both Windows hosts pass 812 tests/202 summaries and ten SDK checks each; two
POSIX terminal checks are explicitly skipped on each. Linux ARM passes 994/257
and all twelve SDK/terminal checks. Complete logs are audited. The original matrix `41042531398` is fully
audited: only the two observer failures, repaired by `d0ccb80f`, occurred. Its
Mac crash artifacts are the intentional cleanup-panic control. No final-head
failure has been observed; audit newly completed targets before merging.

The string candidate qualifies four sessions at `afbafef8`: large word counting
takes 16.4–19.2% less time, with 26,216 fewer managed requests but unchanged
retains/peak charge. It still takes 2.08 times C on ARM64 and 2.42–2.44 on AMD64.
All 222,120 observations and two rejected candidates remain in the report.
The name diagnostic retains 1,024 observations and does not close D2/N1.
File-read controls pass focused GCC/Clang checks at `f0357526`, including all
40 saved executions per host. Full delivery remains pending.

## Next grouped batch

Worktree `/private/tmp/fwp-file-boundary-portability`, branch
`file-boundary-portability`. Code source `c69b9b91`; later commits only update docs.
[File-boundary portability](measurements/file-boundary-portability.md) records
three existing targets now covering Windows file errors, borrowed stream owners
and flush visibility. Observers stop comparing stream pointers after close.
Seven test probes now use a C-permitted `setjmp` context, including related
resource-frame and WASI count checks. Runtime/compiler code is unchanged.

Initial Linux/macOS focused runs each pass 16 tests/6 targets and all 22 saved
probes. Both initial Windows runs expose the same three header-order compile
errors; all logs were audited before the combined repair push.
Repaired AMD run `41055449823` / job `124061719633` and ARM run `41055457917` /
job `124061748283` pass 16/6 each. All 22 saved executions per host, exact negative
controls and native headers pass independent audit. Artifacts are `12977885309`
and `12977067487`. Require the next full matrix, including resource-frame and
actual WASI checks, before delivery; focused Windows success does not replace it.

The next PR description is `/private/tmp/fwp-file-portability-pr.md`; open it
after #229 merges. Integrate the verified merge, update its delivery record and
run one complete final-head matrix. The shortened plan preserves every acceptance
limit and links completed work to its evidence instead of repeating old next steps.

## Checks and recovery

All local checks run serially through `python3 scripts/local-guard.py`:
Rust formatting for the five changed targets, actionlint for both workflows,
`python3 scripts/test-native-test-runner.py` (20 controls), and
`python3 scripts/check-roadmap.py` (185 documents, 106 immutable preparation
pairs, eight steps). `git diff --check` passes. Full builds/suites run on GitHub.
Independent saved-probe and complete-log auditors also ran under the guard.

Active worktree `/private/tmp/fwp-direct-string-results` keeps a local live-status
handoff after its frozen head; preserve it until the next delivery record.
The primary checkout is detached at #209 with an older recovery handoff and
untracked compiler-abort report. Preserve both. Automatic approval review rejected
replacing that dirty handoff; the backup is
`/private/tmp/fwp-primary-recovery-before-file-checks.md`.

Latest verified delivery is [#228](roadmap-history.md#directory-cleanup-and-current-application-costs-pr-228),
squash `667e71f0`, identical to tested tree `f3eb5072`. Its duplicate post-merge
production run was cancelled only after tree equality was verified.

D2 remains **1.022815765 > 1.02** in `40912773534`; N1's small-array inclusive
control remains **1.030786192 > 1.02** in `40951090783`. No unchanged rerun, further
sample-count increase or relaxed limit. The original intermittent Intel compiler
abort remains unexplained; preserve [its evidence](measurements/compiler-abort.md).

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain GC-free lifetime and cycle guarantees |
| 2 | Verified | Maintain A1–A6; sharing still uses ARC |
| 3 | Verified | Maintain the stated F1–F3 call and recursion scope |
| 4 | Verified | Preserve decimal savings and the unoptimized loop gap |
| 5 | In progress | Resolve D2's zero-update requirement |
| 6 | In progress | Resolve N1's array control before N2 timing acceptance |
| 7 | In progress | Complete broader B1/B2 comparisons |
| 8 | In progress | Deliver the application batches and finish V1/V2 |
