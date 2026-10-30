# Current work

**Next:** monitor and audit all gates at PR #229 head
`8d908e0e0d5db3a2d836e2fc978c70fa99ad04a8`: production `41051447921`,
documentation `41051447945`, and G2 `41051466208`. The older full matrix has finished and every log is audited. Merge only after all nine
production jobs, documentation and both G2 hosts pass. Use one squash subject of
at most 80 characters and an empty body, then continue PLAN.md.

## Final-head gates

Documentation, benchmarks, both G2 hosts and all four macOS jobs pass and their
complete logs are audited. Regular Mac jobs each pass 627 tests/132 summaries;
ownership jobs each pass 364/127. Linux and Windows remain in progress, with no
final-head failure observed. Audit each completed job before merging.

The next preparation is `/private/tmp/fwp-file-boundary-portability`, source
`c69b9b91`. Both repaired Windows focused runs pass 16 tests/6 targets and all
22 saved native probes per host pass audit. The earlier Linux/macOS focused runs
also pass. Next full gates must cover the seven `setjmp` probe repairs, including
resource-frame and WASI checks. Keep one active PR; open that batch after #229.

## Active PR and source

[PR #229](https://github.com/e6qu/fun-with-pipes/pull/229) contains the combined
string implementation, observer repair, file-read controls and numerical diagnostic.
Worktree `/private/tmp/fwp-direct-string-results`, branch `direct-string-results`.
This handoff has local live-status updates after the tested commit; carry them
into the next delivery record without restarting a passing matrix for status text.
The next branch `file-boundary-portability` is prepared at `c69b9b91`. Its report
records initial Windows failures and both repaired passing runs. Do not open
another PR until #229 merges. No runtime/compiler code changes are in this batch.

Latest verified delivery: [#228](roadmap-history.md#directory-cleanup-and-current-application-costs-pr-228),
squash `667e71f0`, identical tested tree from `f3eb5072`. Directory-boundary
coverage and the current word-frequency baseline are delivered. The duplicate
post-merge production run was cancelled only after tree equality was checked.

## Original full matrix and repaired observers

Production `41042531398`, source `3ddd989c`, is complete and fully audited.
Both Linux jobs (`124018564521`, `124018564324`) finish with 991 passes and exactly
the two known observer failures in 257 summaries each; no additional diagnostics.
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
are audited. No additional repairs were needed after the original jobs finished. Both Mac crash artifacts are the verified intentional cleanup-panic
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

## Next preparation while this head runs

`/private/tmp/fwp-file-boundary-portability`, branch `file-boundary-portability`,
source `3cbc6b63`, prepares portable file error/borrowed-handle probes and fixes
the close observer. It does not change #229's tested source. Focused file checks:
Windows AMD `41053005173`, Windows ARM `41053015126`, Linux GCC `41053039581`,
Mac ARM Clang `41053051853`. Execution is pending; no next PR is open.

Final-head docs `41051447945` pass with complete log audit. Benchmarks pass
(2 tests/2 summaries), and both G2 hosts pass (226 tests/3 summaries each), all fully audited.
