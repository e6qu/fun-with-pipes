# Session handoff

Updated 2026-10-17 UTC. All seven work areas in [PLAN.md](../PLAN.md) remain open.

## Current delivery

Branch `free-closed-connections` starts at accepted #157 merge
`30668bf83894b9a3739cc24ba8ba63911826da2d`. It frees closed client connections
and completed I/O task records, closes idle connections during library unload,
and repairs fatal allocation errors on task stacks. No syntax changes.
There is no open delivery PR yet. Keep one active delivery PR at a time.

#157 passed all nine production jobs in `39004098429` and documentation in
`39004095234` at `57d2a09eee4937ad644721f73e286b9fc94a2c25`.
The squash tree, parent and complete one-line message were verified; duplicate
postmerge production `39007997287` was canceled. See [history](roadmap-history.md).
Private acceptance record: `/private/tmp/fwp157-merge-record.json`.

## Evidence and remaining acceptance

The closed-connection baseline `4103b0a09f06cae69721c29151571ba9e9a621b9`
passes all six native jobs in `39002767125`, retained by
`evidence/closed-remote-baseline-20261017`. Its report and raw tables are
[retained here](measurements/closed-remote-baseline-2026-10-17.json).
It closes every connection and finishes its I/O tasks, but leaves additional
managed storage per connection: Linux AMD64 3,904 bytes, ARM64 12,608;
either Mac 1,600; Windows AMD64 2,368, ARM64 2,112.

The final focused candidate is `3a773a85bb147ea8e7acb03ffa1eeeba59c2d4d8`,
run `39007195648`, with all six native jobs passing. The source tag is
`evidence/closed-remote-ownership-20261017`; the
[final report](measurements/closed-remote-ownership-2026-10-17.json) retains raw
checkpoint/drain tables and actual Linux AMD64/ARM64 binary reviews. Collection
passed in 23.82s. All connections, requests and messages release without GC;
final managed bytes stay constant across 1/16/256 full, partial and retained
batches: Linux AMD64 1,792, ARM64 6,144; either Mac 640;
Windows AMD64 1,024, ARM64 896. Allocation requests/bytes are unchanged.
Shared connections add three count increments each; unique task cleanup adds none.
See [the guide](benchmarks.md#freeing-closed-connections-and-finished-tasks) for
measurement boundaries, baseline values and remaining costs.

Transferred compiler/runtime/test/workflow files matched the measured candidate.
Final review then restored the existing recoverable server TLS protocol-list
allocation path and added its failure regression check. This is outside the
measured client workload; its validation awaits the full production gate.
Earlier failing probes exposed and repaired fixture mutations, starvation in a
drain fixture, unique tasks incorrectly sent through a counted-free helper and
Windows artifact filenames. Partially passing probes are not acceptance.

Actual binary review confirms last-owner connection cleanup and direct unique-task
freeing after stack/link removal, without task reference-count updates. Private
artifacts are under `/private/tmp/fwp-closed-client-evidence/39007195648`;
downloaded executables have not run locally. No speed or C/Rust parity claim.

Next: publish this delivery and require all nine production jobs plus documentation
at its exact final head before authorized squash merge. Use the explicit subject
`Free closed connections and finished I/O tasks` and an empty body; verify the
resulting tree, parent and complete message. Queued gates merge, not independent
preparation; fix test failures. Do not push status-only updates during final gates.

## Local checks and next preparation

Use the root `scripts/local-guard.py` with fixed limits for serial local checks.
Native builds, full suites and measurements run on GitHub. Final `cargo fmt --all -- --check` passed under the guard in 1.32s;
`python3 scripts/check-roadmap.py` passed under the guard in 3.32s. Baseline
collection passed in 28.43s; static final binary inspection took 0.14–0.16s.
No local native build or full test suite ran.

Preparation worktree `/private/tmp/fwp-client-connection-owners`, branch
`own-client-connections`, preserves the measured source. Do not copy its older
plan/history over this handoff. Private next-input notes and four workloads are
`/private/tmp/fwp-next-connection-ownership.md` and
`/private/tmp/fwp-next-input-workloads`. They describe synchronous sending,
bidirectional sending, retained inputs and early server completion. The workloads
only pass typechecking with the existing prebuilt compiler; they have not run.
Measure those lifetimes before implementing typed pending-input owners. Preserve
continuation evaluation before encoding the current value; a sender retain alone
cannot own an iterator already marked permanently shared.

Pending sender values, server callbacks/channels, host re-entry, remaining
numerical/network ownership and cycle policies remain open. Remote calls still
require tracing; this batch does not admit them to checked ARC. JIT is excluded.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Typed stream and external owners; remove tracing |
| 2 | In progress | Remove intermediate storage and unnecessary reference counts |
| 3 | In progress | Reduce equivalent-work C/Rust gaps |
| 4 | In progress | Differentiation precision, speed and memory scaling |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Repeated, comparable performance measurements |
| 7 | In progress | Larger representative applications |
