# Current work

**Next:** finish PR #229's gates at `8d908e0e` and squash-merge only after all
nine production jobs, documentation and both G2 hosts pass. Production is
`41051447921`, docs `41051447945`, analysis `41051466208`. The old matrix
`41042531398` is completely audited: no failures beyond the two repaired observers. Do not open a second PR.

## Preparation for the next grouped PR

Worktree `/private/tmp/fwp-file-boundary-portability`, branch
`file-boundary-portability`, starts at tested candidate `8d908e0e`. It prepares
[file-boundary portability](measurements/file-boundary-portability.md): three
existing targets cover native Windows error paths and borrowed stream owners,
fix the close observer, and retain healthy/negative probes. Runtime code and
performance protocols are unchanged. Execution is pending; do not claim native
coverage from formatting or source review.

Guarded checks pass: rustfmt for the three changed Rust files, actionlint for both
changed workflows, the 20 native-runner controls, and roadmap/whitespace checks.
Focused checks will use production GCC on Linux, Clang on Mac and native Clang on
both Windows architectures. Complete final gates belong after the next batch is
ready. All original string/failure/numerical records below remain relevant.

The active PR worktree `/private/tmp/fwp-direct-string-results` has only a local
live-status handoff change after its published source; preserve it. The primary
checkout's older recovery handoff is protected and remains untouched. Its verbatim
backup is `/private/tmp/fwp-primary-recovery-before-file-checks.md`. Current work
is recorded in these temporary worktrees and PR #229's description.

Latest verified delivery: [#228](roadmap-history.md#directory-cleanup-and-current-application-costs-pr-228),
squash `667e71f0`, identical tested tree from `f3eb5072`. Directory-boundary
coverage and the current word-frequency baseline are delivered. The duplicate
post-merge production run was cancelled only after tree equality was checked.

## Original full matrix and repaired observers

Production `41042531398`, source `3ddd989c`, still has both Linux suites running.
Both regular Mac jobs finish with 624 passing tests, two observer failures in
132 summaries and 12 passing SDK tests. Both Windows jobs finish with 809 passes
and the same two failures in 202 summaries. All four complete logs are audited;
no additional failures or compiler warnings were found.

`library_input_ownership` exits 8 and `library_result_ownership` exits 4 because
their observers record `fwp_str_new` but miss repetition's direct allocation.
Repair `d0ccb80f` adds that observation, empty/nonempty result checks, deliberate
observation-omission controls and complete saved probes. Production runtime code
is unchanged. Focused ARM Mac run `41047507000`, job `124035107898`, passes all
17 tests/6 summaries. Its full log and all 26 saved executions/native headers are
independently audited. Artifact `12973930046` retains those probes. Both omission
controls reproduce the old failures without another code change.

Both Mac ownership jobs pass 364 tests/127 summaries each. Original documentation
`41042479406`, benchmarks and both G2 hosts `41042548622` pass. Their complete logs
are audited. Audit both original Linux jobs when they finish and fix any further
issues. Their continuation does not require delaying the prepared final matrix. Both Mac crash artifacts are the verified intentional cleanup-panic
abort test, not new compiler aborts. Record final new run IDs in the PR while its
tested source is frozen.

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
  implemented in `text_file_tools`. At combined source `f0357526`, ARM Mac focused
  run `41049305186` / job `124041117692` passes 11 tests in three summaries.
  All 40 saved boundary executions, exact omission controls and native headers
  are independently audited. Artifact `12973813560` retains the evidence.
  GCC run `41049886906` / job `124043037136` also passes all 11 tests and the
  independent 40-execution audit; artifact `12973978657` retains its evidence.
  Its admission inventory accepts 82 programs with three expected rejections.
  Complete final-head platform validation remains required.

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

## Focused checks and pending repair

Preparation source `3cbc6b63`: Linux `41053039581` / `124053572242` passes
16 tests/6 summaries and all 22 saved probes pass independent audit. Windows ARM
`41053015126` / `124053490719` has 13 passes and three C compile failures: the
Windows target must be defined before any header. This is repaired locally.
The source sweep also repairs seven invalid `setjmp` initializers in file,
resource-frame and WASI count probes. Windows AMD `41053005173` has the same three failures among 13 passes; its full
log is audited. Mac ARM `41053051853` passes all 16 tests and the 22-probe audit.
Publish the target-prefix and seven `setjmp` fixes together, then verify repaired
Windows probes. The next complete matrix also covers resource-frame and WASI
recovery changes. Formatting passes; repaired-source execution remains required.
