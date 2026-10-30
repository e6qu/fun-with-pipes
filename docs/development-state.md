# Current work

**Next:** publish and verify the grouped file-boundary/documentation PR from
`file-boundary-portability`. Run one complete final-head matrix, audit every job
and fix any failure before squash-merging. Use one subject of at most 80
characters and an empty body. Then continue the numerical and comparison work
in [PLAN.md](../PLAN.md). Keep one active PR.

## Current batch

Worktree `/private/tmp/fwp-file-boundary-portability`, branch
`file-boundary-portability`. Code source `c69b9b91`; later commits update docs and
integrate the verified #229 squash. No compiler/runtime/library/build input changes
are in this batch. The PR description is `/private/tmp/fwp-file-portability-pr.md`.

[File-boundary portability](measurements/file-boundary-portability.md) records
three existing targets now covering Windows file errors, borrowed stream owners
and flush visibility. Observers stop comparing stream pointers after close.
Seven test probes now use a C-permitted `setjmp` context, including related
resource-frame and WASI count checks. Windows production CI explicitly assigns
all three targets. Native probes save generated C, images, output and statuses.

Initial Linux/macOS focused runs each pass 16 tests/6 targets and all 22 saved
probes. Both initial Windows runs expose the same three header-order compile
errors; all logs were audited before the combined repair push. Repaired AMD run
`41055449823` / job `124061719633` and ARM run `41055457917` / job `124061748283`
pass 16/6 each. All 22 saved executions per host, exact negative controls and
native headers pass independent audit; artifacts `12977885309` and `12977067487`.
Require the full matrix, including resource-frame and actual WASI checks, before
delivery. Focused Windows success does not replace those gates.

The plan removes repeated delivery history and obsolete next steps while keeping
all eight milestone anchors and acceptance limits. The benchmark guide identifies
specific missing ownership comparisons, links current numerical measurements and
distinguishes descriptive timings from fixed performance gates. Historical samples
remain unchanged. The #229 delivery record replaces its old pending directions.

## Latest verified delivery

[#229](roadmap-history.md#string-costs-and-application-cleanup-pr-229) merged as
`bae1a858126794845552c98108237002fb114f37`, exactly matching tested
`8d908e0e0d5db3a2d836e2fc978c70fa99ad04a8`, tree
`bdccb27c1278a9291e0e64718e71659d37b32c9a`. All nine production jobs
`41051447921`, documentation `41051447945` and both G2 hosts `41051466208` pass,
with complete log audits. The measured production code is unchanged from
`afbafef8`. Duplicate post-merge runs were cancelled after verifying tree equality.
The delivery record owns counts, repairs, evidence and remaining limits.

## Checks and recovery

Local checks run serially through `python3 scripts/local-guard.py`:
Rust formatting for the five changed targets, actionlint for both workflows,
`python3 scripts/test-native-test-runner.py` (20 controls), and
`python3 scripts/check-roadmap.py` (185 documents, 106 immutable preparation
pairs, eight steps). `git diff --check` passes. Full builds/suites run on GitHub.
Independent saved-probe and complete-log auditors also ran under the guard.

The primary checkout is detached at #209 with an older recovery handoff and
untracked compiler-abort report. Preserve both. Automatic approval review rejected
replacing that dirty handoff; the backup is
`/private/tmp/fwp-primary-recovery-before-file-checks.md`. The former active worktree
`/private/tmp/fwp-direct-string-results` retains its local live-status handoff;
#229's delivery is now recorded here. Do not overwrite the protected primary copy.

D2 remains **1.022815765 > 1.02** in `40912773534`; N1's small-array inclusive
control remains **1.030786192 > 1.02** in `40951090783`. No unchanged rerun, further
sample-count increase or relaxed limit. Fixed CPU affinity and equal executable
names were insufficient. The original intermittent Intel compiler abort remains
unexplained; preserve [its evidence](measurements/compiler-abort.md).

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain GC-free lifetime and cycle guarantees |
| 2 | Verified | Maintain A1–A6; sharing still uses ARC |
| 3 | Verified | Maintain the stated F1–F3 call and recursion scope |
| 4 | Verified | Preserve decimal savings and the unoptimized loop gap |
| 5 | In progress | Resolve D2's zero-update requirement |
| 6 | In progress | Resolve N1's array control before N2 timing acceptance |
| 7 | In progress | Complete the named B1/B2 comparison gaps |
| 8 | In progress | Deliver file-boundary coverage and finish V1/V2 |
