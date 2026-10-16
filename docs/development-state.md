# Session handoff

Updated 2026-10-16. [PR #147](https://github.com/e6qu/fun-with-pipes/pull/147)
merged as `c9127d2d` after nine production jobs and docs passed at `71c612d0`.
Its tree and single-line message were verified; duplicate post-merge production
run `38825167262` was canceled. History holds accepted delivery evidence.

The only current PR is [#148](https://github.com/e6qu/fun-with-pipes/pull/148),
branch `record-moves-and-utilities`, in `/Users/zardoz/projects/fun-with-pipes`.
Its final head remains `93b1741abcf5ab2a61460746c0077564e0328c0e`.
[Production 38825629531](https://github.com/e6qu/fun-with-pipes/actions/runs/38825629531)
is running: benchmark, regular ARM macOS and both Windows jobs pass so far.
[Docs 38825487182](https://github.com/e6qu/fun-with-pipes/actions/runs/38825487182)
passes. Ignore canceled old-head `38825485034` and skipped draft jobs.
Keep that head unchanged; these progress notes belong in the following delivery.

Standing authorization: fix failures, require all nine production jobs and docs
for the exact final head, then squash merge with an explicit one-line subject of
at most 80 characters and empty body. No attribution or trailers. Continue to the
next substantial PR without another permission request. JIT is excluded.

## Roadmap status

[PLAN.md](../PLAN.md) defines completion; none of the seven whole areas is done.

| Step | Status | Next concrete work |
|---|---|---|
| 1 | In progress | Accept record/application ownership, then process and terminal boundaries |
| 2 | In progress | Accept record moves; measure remaining wrappers and functional intermediates |
| 3 | In progress | Diagnose measured CPU costs with retained native instructions |
| 4 | In progress | Reproduce derivative slowdowns and test interleaved recording storage |
| 5 | Pending | Broaden CPU kernels; resolve runtime OpenCL compilation under the no-JIT policy |
| 6 | In progress | Preserve repeated equivalent-work measurements and regression criteria |
| 7 | In progress | Extend maintained applications with process composition and terminal checks |

Next: finish #148's final-head gate and merge when all required jobs pass. In
parallel, finish the six-host process/terminal preparation and derivative
experiments below. Transfer only its diff after `81d113aa` onto #148's accepted
squash, refresh this handoff/PLAN/history, open the next combined PR and require
its own complete final-head production/docs gate. Failures are repair tasks.

## Following process and terminal preparation

This worktree is `/private/tmp/fwp-process-utilities`, branch
`owned-process-utilities`, based on `81d113aa`. The runtime/tests are published at
`7e9e5bd8`; only subsequent experiment/docs edits are local. No process PR is open.
Do not replay the old parent preparation: #148 already contains its source/tests.
Preserve root's local handoff when integrating the following delivery.

The batch owns process argument scratch, pipe endpoints, child resources,
capture buffers, copied output strings and the containing record. It rejects
NUL arguments before OS calls, reports read/wait failures, retries interrupted
waits, preserves initially closed standard descriptors, and closes/reaps on
unwinding. Windows retains its existing reader/handle cleanup with protected
result construction. Process calls remain synchronous; this is not a proof of
cancellation/deadline responsiveness while waiting for a child.

Tests compare raw interpretation and native tracing/ARC at O1/O2. They exercise
Unicode/quoted arguments, 64 KiB per output stream, 200 KiB input, early child
exit, missing commands, partial construction and OS errors. Deliberately missing
counts or buffer frees must fail. `process.output` checks success and trimmed
status errors. A maintained shell `normalize` executable runs 64 times; the
parent retains then releases captured records/strings. Parent and child use the
same memory mode because tracing-stress environment settings are inherited.

Terminal changes own secret-line results and restore echo before traps unwind.
Descriptor validation precedes narrowing. Windows interpretation now uses real
console APIs for echo and width. Tests use real POSIX pseudo-terminals and a
private Windows console; a missing restore action must fail. An isolated Windows
Rust unit test checks interpreter console mode/width without affecting other tests.

## Checks and repaired failures

- [First six-host process run 38827570961](https://github.com/e6qu/fun-with-pipes/actions/runs/38827570961)
  at `610f698b` passed all four Linux/macOS hosts. Both Windows hosts exposed the
  same three test failures: the process probe counted an already-closed handle
  marker, CLI executable renames omitted `.exe`, and a shell pipeline used Unix
  paths. Fixes preserve checks for every actual owned handle, use the OS suffix,
  and connect two native processes directly for the binary-protocol test.
- [Complete process/terminal run 38829032952](https://github.com/e6qu/fun-with-pipes/actions/runs/38829032952)
  at `7e9e5bd8` is queued/running. It includes composed shell calls, terminal
  ownership, console regressions, existing Windows/static-memory tests and CLI
  examples. Native Windows production also runs the new terminal unit/probes and
  full CLI cases. No new platform acceptance is claimed until results pass.
- Local checks use `python3 scripts/local-guard.py COMMAND...`. Formatting passes
  (0.86 s), inventory passes (0.88 s), docs/roadmap audit passes (2.51 s), and
  standalone library-doc regeneration/check passes (0.62 s). Inventory has 257
  contracts, eight scalar signatures, 94 review declarations, 19 templates and
  84 review symbols. Full builds, full suites and timing runs stay on GitHub.
- Supplemental local probes use the accepted #147 compiler, with current POSIX
  code inserted into its emitted C. Eight baseline captured calls leave 896
  charged bytes with collection explicitly disabled; the edited mechanism ends
  at zero (1.22 s). Failure/negative controls pass (6.30 s), composed shell calls
  pass (4.32 s), and real macOS terminal restoration/negative control passes
  (3.63 s). These are mechanism checks, not changed-compiler/platform acceptance.
  Probe scripts and logs live under `/private/tmp/fwp-process-*` and
  `/private/tmp/fwp-terminal-*`.

## Derivative investigation

[Repeated metadata comparison 38828198160](https://github.com/e6qu/fun-with-pipes/actions/runs/38828198160)
runs at `48aa61dc` on four Linux/macOS hosts. It compares current fwp ARC against
the documented separate-allocation tape control from `09f1a029`, with eight
alternating process samples and a 512-derivative case. Each workload is identical;
process startup/output are timed, compilation and profiling are separate. This
is fwp versus fwp, not C/Rust parity. Within the substituted tape section, the
material changes are paired storage/growth/disposal; later precision comments
do not change these F64/nested workloads.

Completed ARM reports are in `/private/tmp/fwp-ad-metadata-current`. On ARM macOS,
512 mapped derivatives have paired/control median ratios 1.086 without reuse and
1.058 with reuse; Linux ARM ratios are 0.987 and 0.985. Keep all hosts/raw samples
before drawing a conclusion. In the actual macOS ARM binary, append has 198
instructions versus 253 in the control; backward has 374 in both. Stack-address
references are 15 versus 17 for append and 23 for both backward variants; these
are not classified as register spills. Smaller code does not prove faster code.

The next experiment interleaves the two parents and weights of each operation
inside the same two allocation blocks. It keeps payload/request counts and
arithmetic order, removing explicit region moves during growth. Fourteen access
sites and four offsets are checked before generating the variant; production
runtime remains unchanged. Tiny numeric/nested correctness checks pass under
the local guard (1.59 s); complete repeated profile/timing/binary evidence uses
the `ad-layout` CI suite. Adopt nothing without results and semantic/failure
regressions. Retain negative evidence if the experiment does not help.
