# Directory reports after an allocation-boundary failure

These checks run the maintained [directory report](../../examples/cli/dirstat.fwp)
through generated native code. They test cleanup and failure behavior, not speed
or memory parity with C/Rust. Source `1f364c09` passes ten focused tests on each
of the six native hosts, with complete log and artifact audits. The
[archive](directory-failures-artifacts-2026-10-30.json) retains all 84 probe
executions, emitted sources, file identities, memory observations and full logs,
including the failed first run. Full production acceptance is verified in #228;
[the delivery record](../roadmap-history.md#directory-cleanup-and-current-application-costs-pr-228)
links the exact tested/merged trees and audited gates.

| Host | Passing job |
|---|---|
| Linux AMD64 | [123776242681](https://github.com/e6qu/fun-with-pipes/actions/runs/40967686175/job/123776242681) |
| Linux ARM64 | [123776242537](https://github.com/e6qu/fun-with-pipes/actions/runs/40967686175/job/123776242537) |
| macOS AMD64 | [123776242774](https://github.com/e6qu/fun-with-pipes/actions/runs/40967686175/job/123776242774) |
| macOS ARM64 | [123776242495](https://github.com/e6qu/fun-with-pipes/actions/runs/40967686175/job/123776242495) |
| Windows AMD64 | [123776242633](https://github.com/e6qu/fun-with-pipes/actions/runs/40967686175/job/123776242633) |
| Windows ARM64 | [123776242635](https://github.com/e6qu/fun-with-pipes/actions/runs/40967686175/job/123776242635) |


## Program and expected result

The input is a 64-file tree with nested, hidden and Unicode names, plus 32 files
at its root. The extra names force directory-list scratch storage to grow.
`report-once` calls `dirstat` with all files enabled, name ordering and ten rows,
then sums the lengths of its output lines. Raw interpretation, optimized
interpretation and an ordinary native build must print the same checksum.

A second build uses `--fn report-once` to retain a callable entry for the probe.
It uses the same optimizer. Compiling ordinary `main` can inline and remove that
entry; the first test harness incorrectly assumed it remained. That test failed
on all six hosts at `55eec5e0`; the other nine file-application tests passed on
each. The repair keeps both builds and saves their emitted C.

## Failures and observers

The probe injects a recoverable trap at four points while a directory is open:

| Point | Storage already owned |
|---|---|
| First scratch allocation | Path and directory handle |
| Fourth name allocation | Scratch storage and three names |
| Scratch growth | Full initial scratch buffer and sixteen names |
| Second result-list node | Remaining names and a partially built list |

For each point, it repeats recovery four times with and without a caller-held
path alias: 32 traps per optimization level. Every trap must close the directory,
restore initialized live-storage and allocation-count baselines, preserve an
alias when present, and allow a successful retry. Counts observe allocator
releases and actual handle closes; they are not process RSS measurements or a
claim that reserved allocator pages return to the OS after each call.

Two deliberately broken programs omit directory close or builder cleanup. They
must exit 241 with `directory handles remain open`, or 242 with
`directory owners remain live`, respectively. An unrelated crash does not pass
these controls.

Managed-heap exhaustion is separate. The real `fwp_heap_oom` handler prints
`fwp: out of memory` and exits 102. Four subprocesses invoke it at the same
boundaries. This checks its terminal contract without exhausting host memory;
it does not claim recoverable OOM or cleanup before process exit.

## Coverage and limits

Each host checks C O1 and O2 with its production compiler. It retains 14 probe
executions: two healthy, four deliberately broken and eight terminal OOM cases.
The terminal cases reuse the healthy probe binary with a different explicit
stage argument. Binary headers establish the native OS/architecture; source,
output, status and binary identities are retained for every execution.

The grouped `file-applications` suite also runs all nine existing tests, including
scaled directory/text work, ordinary I/O failures, aliases and missing-cleanup
controls. These focused checks do not replace the complete production matrix,
prove arbitrary cancellation safe, or complete all six application families in
[V1–V2](../../PLAN.md#8-larger-programs).
