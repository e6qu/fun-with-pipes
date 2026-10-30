# Current work

**Next:** run focused file-read checks for the combined PR #229 batch, finish
auditing the original production matrix, then publish all known fixes together
and run its complete final-head gates. Merge only after nine production jobs,
documentation and both G2 hosts pass, using one squash subject of at most 80
characters and an empty body. Continue PLAN.md after the verified merge.

## Active PR and source

[PR #229](https://github.com/e6qu/fun-with-pipes/pull/229) still points to failed
head `3ddd989c`. Worktree `/private/tmp/fwp-direct-string-results`, branch
`direct-string-results`, contains the combined repair, file-read controls and
retained numerical diagnostic. The separate preparation worktree
`/private/tmp/fwp-numerical-controls` is clean at `b46e8c04`; its work is now
included in this branch. Do not open another PR.

Latest verified delivery: [#228](roadmap-history.md#directory-cleanup-and-current-application-costs-pr-228),
squash `667e71f0`, identical tested tree from `f3eb5072`. Directory-boundary
coverage and the current word-frequency baseline are delivered. The duplicate
post-merge production run was cancelled only after tree equality was checked.

## Original full matrix and repaired observers

Production `41042531398`, source `3ddd989c`, remains running. Its completed
ARM Mac regular job `124018564229` has 624 passing tests, two observer failures
in 132 summaries, and 12 passing SDK tests. The Intel Mac regular shard has the
same two failures among 131 targets/623 passes; its remaining job steps are still
running. Windows AMD's completed TLS/ownership step has exactly the same failures
among 98 targets/249 passes. All those completed logs are audited.

`library_input_ownership` exits 8 and `library_result_ownership` exits 4 because
their observers record `fwp_str_new` but miss repetition's direct allocation.
Repair `d0ccb80f` adds that observation, empty/nonempty result checks, deliberate
observation-omission controls and complete saved probes. Production runtime code
is unchanged. Focused ARM Mac run `41047507000`, job `124035107898`, passes all
17 tests/6 summaries. Its full log and all 26 saved executions/native headers are
independently audited. Artifact `12973930046` retains those probes. Both omission
controls reproduce the old failures without another code change.

ARM Mac ownership job `124018564253` passes 364 tests/127 summaries. Original
documentation `41042479406`, benchmarks and both G2 hosts `41042548622` pass.
Their complete logs are audited. Remaining original Linux, Windows and Intel Mac
jobs must finish so additional failures can join the repair. The ARM Mac crash
artifact is the verified intentional cleanup-panic abort test, not a new compiler
abort. Record final new run IDs in the PR while its tested source is frozen.

## Work bundled before the final rerun

- [Direct string results](measurements/direct-string-results.md): byte search and
  unique non-growing replacement qualify four sessions at `afbafef8`. Large
  word counting takes 16.4–19.2% less time; still 2.08 times C on ARM64 and
  2.42–2.44 on AMD64. Managed requests fall by 26,216; retains and peak charge do
  not fall. Code/stack costs and the two rejected earlier candidates remain
  explicit. All 222,120 observations across the three experiments are retained.
- [Executable-name diagnostic](measurements/timing-variation.md#executable-name-results):
  protocol `9a08edb6`, source `0c61ca76`, run `41045294362`, job `124027797546`.
  All 1,024 observations and 2,076 artifact files pass independent audit, with
  full logs and eight damaged-evidence controls. Equal names still leave a
  2.19% elapsed / 2.13% CPU history-copy difference. Naming alone does not repair
  D2/N1. The earlier EPYC 9V74 host rejection `41045000047` is retained.
- [File-read allocation controls](measurements/file-read-failures.md): first
  scratch allocation, growth and result construction during either of two reads;
  aliases, retries, omitted cleanup and terminal OOM. Text and byte probes are
  implemented in `text_file_tools`, but **not yet executed**. Only formatting and
  source review have run; do not claim platform coverage before the focused and
  complete native checks pass.

Guarded local checks pass: Rust formatting, Python syntax, workflow lint, roadmap
checks, all retained diagnostic observations and eight damage cases. The original
string batch also passed seven small Clang tests, 144 O0/O1/O2 size/control exits,
84 retained-evidence rejection tests, eight stricter allocation audits and four
explicit passing-timing audits. No local full build or benchmark ran.

## Remaining roadmap and recovery

D2's zero-update result remains **1.022815765 > 1.02** in `40912773534`; N1's
small-array inclusive copy control remains **1.030786192 > 1.02** in `40951090783`.
Retain every failed result. Do not repeat unchanged timings, increase sample
counts again or relax limits after observing these outcomes. A merge does not
complete these goals or the other V1/V2 application requirements.

GC removal, A1–A6, F1–F3 and the selected decimal-counting optimization are
verified at their documented scopes. Sharing still uses ARC. D2, N1/N2, broader
B1/B2 comparisons and integrated V1/V2 acceptance remain open in [PLAN.md](../PLAN.md).

The original intermittent Intel compiler abort remains unexplained; preserve
[its evidence](measurements/compiler-abort.md) and diagnose recurrence from source.
The primary checkout is detached at #209 with a recovery handoff and untracked
compiler-abort report. Preserve both. All local checks remain serial under
`scripts/local-guard.py`; full builds, suites and measurements run on GitHub.

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
| 8 | In progress | Deliver this application batch and finish V1/V2 |
