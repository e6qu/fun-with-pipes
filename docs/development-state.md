# Session handoff

Updated 2026-10-17 UTC. All seven work areas in [PLAN.md](../PLAN.md) remain open.

## Current delivery and next preparation

Root branch `free-closed-connections` has [PR #158](https://github.com/e6qu/fun-with-pipes/pull/158)
at `2e747ce652f97d19e26737b5ac3d271cd66dc3ca`. Production `39008557317`
and documentation `39008557262` gate its authorized squash merge. The root
handoff and `/private/tmp/fwp-watch-merge-158.py` own that acceptance. Do not
open a second PR. #157 is accepted as `30668bf8`; see [history](roadmap-history.md).

This worktree `/private/tmp/fwp-sender-input-owners`, branch `own-sender-inputs`,
prepares pending input ownership after #158. Its current change is measurement
only, with the production runtime/compiler unchanged from #158. It measures
synchronous integer sending, bidirectional strings, retained original input
aliases and early server completion. The [fixture guide](../tests/fixtures/sender-inputs/README.md)
explains notation, outputs and scope. Do not infer lifetime safety from typechecking.

The baseline uses 1/16/256 calls of up to 64 inputs and three measured processes
per case, with collection disabled and physical freeing enabled. Native hooks
close connections and drain I/O/sender tasks before the next call and final
sample. Ordinary native/raw interpreter outputs provide functional references;
their pooling performs different transport work. A separate input-client drain
fixture admits sender tasks without weakening the response-only fixture.

Counters record allocation requests/charged bytes, retains, connection/request/
message cleanup, sender task completion, input values pulled/encoded and sender/
task allocation categories. Early completion can perform different work between
runs; retain actual input counts rather than impose equal allocation totals.
No elapsed-time, whole-process memory or C/Rust comparison is claimed. Retain
source, emitted C, binaries and raw checkpoints before modifying ownership.

Linux probe `39008824856` runs measurement-only source
`ef69079dccc87fb08ed829fe83467bfc65d7df20`. Next: inspect and repair it, then freeze
the passing baseline across all six native hosts. Inspect actual ARM64/AMD64
binaries. Only then implement concrete input-iterator ownership, preserving
continuation evaluation before current-element encoding, retained aliases,
early response, cancellation and failed sender publication. Existing remote
entries can mark input values permanently shared; adding a retain alone does
not fix that. Keep pending node owners alive through next evaluation and send.

Local work uses the root guard with unchanged limits. Formatting passed in 1.30s; fixture formatting in 0.01s and documentation
audit in 3.19s. The local six-host collector passed syntax parsing in 0.20s.
No local builds or native execution ran. All native measurement work belongs on
GitHub. Private design notes are `/private/tmp/fwp-next-connection-ownership.md`.
Do not copy this preparation's old plan/history over the active root handoff.

Pending sender values, retained server callbacks/channels, host re-entry,
numerical ownership and cycle policies remain open. Remote checked ARC remains
unsupported. All seven project work areas remain open; JIT is excluded.

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
