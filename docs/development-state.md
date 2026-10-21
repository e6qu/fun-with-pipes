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

This group also transfers callback ownership into `task.spawn` and `task.within`,
preserving independent aliases. It checks POSIX clock errors and protects a
deadline callback if clock reading fails. Native probes cover transferred owners,
clock/stack/scope failures and a matched redundant-pair counter control. The three
task callback/handle test targets join the focused native suite.

Preparation run `39643823376` at `86de5747` completed: compiler/unit checks,
gRPC/REST checks and both WebAssembly hosts passed. Its native batch found two
new test defects: effectful helpers returned a bare function too early, and the
counter expected one conditional root-release site instead of two. Both are
corrected; raw interpretation of both revised examples passes. The task-result
cycle regression passed. Full log receipt:
`/private/tmp/fwp-task-capture-preflight-acceptance.json`.

Guarded rustfmt, frozen primitive inventory, workflow syntax, documentation links
and old-compiler fixture/C-emission checks pass. These are not execution evidence
for the new callback transfer. Next: publish the combined source and run all six
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
links/commit subjects, and static artifact inspection. Full builds, native
execution, full suites and benchmarks run on GitHub. Keep the fixed limits:
64 GiB free disk, 2 GiB target, 1 GiB sampled aggregate RSS and 180 seconds.

## Inherited validation and tools

PR #188 was merged before its full checks finished. Its original production run
`39635039734` remains under audit. The macOS ARM64 job failed resolving crates.io
before compilation; production and focused workflows now cache locked registry
sources, fetch explicitly, and build/test with Cargo offline. This does not skip
checks or promise recovery from every network outage.

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
