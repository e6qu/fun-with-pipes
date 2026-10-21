# Session handoff

## Next action

Next: validate the combined task-ownership group on branch `queued-task-captures`,
worktree `/private/tmp/fwp-queued-task-captures`. It proves queued task owners,
rejects result back-references and transfers task callback owners directly.
Read the [measurement plan](measurements/queued-task-handles.md) and the actual
checks below; combined native and WebAssembly acceptance remains pending.

[PR #189](https://github.com/e6qu/fun-with-pipes/pull/189) remains the sole active
PR. Its final commit is `4dfc2be31c62c9e54271692ac8638fbb66ca786b`; production run
`39641372026` and documentation run `39641321443` must pass and be audited before
squash merge. The primary workspace keeps that delivery unchanged. Rebase this
preparation onto the verified merge before opening its substantial next PR.

## Combined changes and validation

The correction checks clock-to-nanosecond range conversion, elapsed monotonic
subtraction and deadline saturation. The interpreter preserves pre-1970 Unix
timestamps and reports range errors consistently with native execution. Injected
native clocks cover read errors, both overflow directions, exact signed limits,
and pre-epoch time; interpreter tests use Windows-representable 100 ns ticks.

Source `264e8fb4` passed both WebAssembly hosts. The completed native logs identify
invalid collector/retention flags in the new ARC clock probe; binary inspection
then fails because the remaining clock artifacts were never produced. All three
flags are now off for ARC and on for tracing. Preserve that failed source's logs
in `/private/tmp/fwp-task-owner-acceptance.json`; corrected-source evidence belongs
in a separate receipt. All eight logs are now audited. Intel macOS hit the 45-minute job timeout while
Clang was still compiling REST programs; its completed tests show only the same
clock-probe failure. The corrected workflow allows that hosted job 90 minutes and
inspects binaries before REST. It keeps the full REST suite; other hosts keep their
45-minute limit. This does not alter local resource limits or count unfinished
checks as passes. Publish all repairs together.

Guarded macOS ARM64 O0 C probes pass protected cleanup (exit 0) and missing cleanup
(exit 3) in both modes, including the new range/elapsed/pre-epoch cases. Commands:
`python3 scripts/local-guard.py python3 /private/tmp/fwp-probe-clock-c.py --memory arc --optimization O0`,
and the same command with `--memory tracing`. Together with rustfmt, actionlint,
`git diff --check` and `scripts/check-roadmap.py`, the serial check took 4.58 seconds
and 0.69 CPU seconds. The C probes use the prior verified compiler's function
metadata plus edited runtime functions; they do not verify the new compiler,
interpreter tests or other platforms. Full builds and gates remain on GitHub.
The library comments now document clock range errors and negative Unix times.
The repository's standalone `tests/stdlib_doc.rs` generator was compiled under the
guard with `rustc --edition 2021 --test`, then run with `FWP_BLESS=1` and again
without blessing. Both passed (1.09 seconds wall, 0.14 CPU); the generated reference
contains only the intended clock-comment changes.

This group also transfers callback ownership into `task.spawn` and `task.within`,
preserving independent aliases. It checks POSIX clock errors and protects a
deadline callback if clock reading fails. Native probes cover transferred owners,
clock/stack/scope failures and a matched redundant-pair counter control. The three
task callback/handle test targets join the focused native suite. Deadline ownership
checks also join both Windows production gates; Unix production already assigns
their target.

Preparation run `39643823376` at `86de5747` completed: compiler/unit checks,
gRPC/REST checks and both WebAssembly hosts passed. Its native batch found two
new test defects: effectful helpers returned a bare function too early, and the
counter expected one conditional root-release site instead of two. Both are
corrected; raw interpretation of both revised examples passes. The task-result
cycle regression passed. Full log receipt:
`/private/tmp/fwp-task-capture-preflight-acceptance.json`.

Guarded rustfmt, frozen primitive inventory, workflow syntax, documentation links
and old-compiler fixture/C-emission checks pass. These are not execution evidence
for the new callback transfer. Next: publish the corrected source and rerun all six
native hosts plus both WebAssembly hosts. Keep #189 as the sole delivery PR until
its exact-head production gates pass and it is squash-merged.

## Measured change and checks

The [task-record report](measurements/task-records.md) compares preceding integer
flags with compact boolean bytes and removal of ARC's tracing-only stack marker.
ARC records shrink by 32 bytes on every measured host. Allocation requests and
retains stay at 1,706 and 1,069. Peak managed charge falls on Linux/macOS but stays
unchanged on Windows ARC because both sizes use the same allocator class.
Tracing keeps its stack marker; both modes keep cancellation/shutdown links.
No timing, total-process-memory, zero-ARC or C/Rust parity claim follows.

Measured source `c10934f5dadf9b57f2d6280589ca95541178667e` passed all six native
focused jobs in run `39636847663` and both WebAssembly jobs in `39636852832`.
Every full log was audited. All 164 native binaries have inspected architecture
headers, generated C, symbols, disassembly, sections, output and exit status.
Both WebAssembly artifacts contain 112 executed modules and twelve return-state
controls each. Focused acceptance does not replace final production acceptance.
The [raw report](measurements/task-records-2026-10-21.json) preserves the source,
immutable tag, toolchains, CPU details, counters, hashes and instruction excerpts.

The Windows C probe now expects its native CRLF output. All normal O0/O1/O2
register/stack/rounding/host-ownership probes pass; restoring the unwanted
collector snapshot exits 211. Matched Windows context comparisons retain 101
fiber switches while removing all 101 extra snapshots. The
[cancellation guide](measurements/task-cancellation.md) separates these results
from earlier cancellation-buffer storage measurements.

Local checks use `python3 scripts/local-guard.py`: rustfmt, workflow structure
(actionlint with shellcheck disabled), native target assignment, documentation
links/commit subjects, and static artifact inspection. Full builds, full
test gates and benchmarks run on GitHub. Keep the fixed limits:
64 GiB free disk, 2 GiB target, 1 GiB sampled aggregate RSS and 180 seconds.

## Inherited validation and tools

PR #188 was merged before its full checks finished. Original run `39635039734`
is now fully audited: six production jobs and documentation passed. Both Windows
jobs failed only the known CRLF assertion; macOS ARM64 GC stress failed resolving
crates.io before compilation. These repairs are included in #189. Workflows cache
locked registry sources, fetch explicitly, and build/test with Cargo offline.
This does not skip checks or promise recovery from every network outage.

The duplicate same-tree merge run `39635064120` was cancelled to free runners.
All finalized logs were audited: both Windows jobs show the known CRLF assertion;
other incomplete jobs ended on cancellation, with no additional diagnosed test
failure. Neither cancelled nor failed runs count as acceptance. The earlier
focused Windows failures at `71ef0268ca1a2f279036b4b6e57b81e2c8ad288f` remain in
separate receipts; all eight old focused logs were reviewed.

Temporary helpers and receipts under `/private/tmp`:

- `fwp-task-record-publication.json` and `fwp-task-record-acceptance.json` preserve
  the measured source/runs. `fwp-audit-task-records.py` audits those eight jobs.
- `fwp-task-record-evidence/c10934f5dadf/` holds inspected artifacts. Do not rerun
  an inspector over an existing accepted report or overwrite old measurements.
- `fwp-audit-188-final.py` audits the original full run; `fwp-audit-188-merge.py`
  preserves the cancelled duplicate's diagnostics.
- Final production run IDs and the exact delivery commit belong in the
  publication/acceptance receipts after publication. Preserve the measured source.

## Roadmap status

All seven areas in [PLAN.md](../PLAN.md) remain open. Smaller task records do not
complete ownership, tracing removal or the language's performance goals.

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing; prove retained ownership and cleanup. |
| 2 | In progress | Eliminate avoidable functional allocations and count traffic. |
| 3 | In progress | Resolve measured machine-code and performance gaps. |
| 4 | In progress | Improve differentiation time, memory and precision. |
| 5 | In progress | Validate numerical kernels and ahead-of-time GPU policy. |
| 6 | In progress | Establish equivalent-work comparisons and budgets. |
| 7 | In progress | Validate larger programs and bounded live memory. |
