# Distinguish executable memory from whole-child accounting

The constructed-value proof in #279 passes its runtime and compiler time limits,
but four [original process-memory comparisons](resource-value-costs-2026-11-27/README.md)
exceed 5%. Later stopped page walks cannot recover the original processes or
explain their high-water readings. Keep all four misses and thresholds unchanged.

The next diagnostic observes the **same process** through its launch and exit.
GNU `time` reports the timed child's lifetime high-water usage. A process can
replace its executable with `exec`, and usage survives that replacement, while
the new address space has its own counters. The previous Python-launched observer
already demonstrated inherited pre-exec memory; that observation did not explain
the original GNU-time readings.

## Fixed scope before collecting service observations

Use the exact reference/candidate binaries and identical copies from ordinary
run `46067853489`, source `33149ad2fd888a66ff36b8eb7f2c5b61faccfccb`.
Require original artifact identities, binary hashes, architecture, Swift image
`sha256:97b9d09f1e922ee794067ea8eec4874083c97d2d5027a6a409e398d82ebca016`
and libc `2.39-0ubuntu8.12`. Record the actual kernel, CPU, page size and GNU-time
executable identity. These remain new hosted jobs, not the original machines.

For all eight original population/outcome cases, retain their C-only batch counts.
Run four balanced rounds of reference, reference-copy, candidate and candidate-copy.
Each label has both an ordinary GNU-time execution and an observed execution;
alternate which path runs first by round. That is 256 executions per architecture.
Do not select a sample, adjust counts, or repeat a completed batch based on RSS.
No new timing acceptance or speed claim is collected.

The observer follows GNU time and its one child with Linux `ptrace`. It saves
raw `smaps`, `status` and `statm` at initial stops, fork, executable replacement
and pre-teardown exit. It also saves executable paths, delivered signals, exit
statuses and each reaped process's `wait4` usage. Retain GNU time's own output
from that exact child and compare it with the child's terminal `VmHWM` counter.
GNU time's parent usage is a separate value, never the application's peak.

The selected service is required to have one timed process. Track its worker
threads, require them to be reaped before the terminal process snapshot, and
require one thread at every saved full mapping snapshot. Additional child
processes fail the observation; do not silently drop processes or workers.
Keep a 30-second deadline, 128 event limit and 4 MiB limit per raw proc file.
On failure, terminate and reap the entire observed process group. Never attach
to unrelated processes or change application code, registers or address-space
settings. Stops perturb scheduling and may change residency; ordinary executions
and identical copies expose that observation effect, not eliminate it.

## Controls and interpretation

Before measuring the service, verify actual native controls on both architectures:

- Touch and unmap 32 MiB before exit: terminal resident mappings should be small,
  but the kernel high-water and GNU-time reports must retain the touched peak.
- Reserve the same mapping without touching it: a validator expecting the touched
  peak must reject this missing-touch control.
- Touch 32 MiB and replace the executable with `/bin/true`: whole-child usage
  must retain the earlier allocation while the new address-space high-water is small.
- Track an actual joined worker through creation and exit, then take the terminal
  snapshot only after it has been reaped. Deliver a terminating signal, exceed a deadline, create an extra process and
  fail a snapshot read: propagate failure and verify no tracee is left running.
- Reconstruct all reported counters/categories from raw files and reject altered
  snapshots, process identities, wait usage or GNU-time reports, including edits
  with refreshed file hashes.

Lifecycle snapshots are not an exact page-resident transient peak. `VmHWM` is a
kernel counter and does not identify the mappings that existed at its peak.
Do not subtract a terminal page walk from a high-water value and call the result
an allocation leak. A difference between GNU time and terminal `VmHWM` is a
same-child accounting observation; it is not by itself proof of a compiler bug.
Agreement rules out that difference in the observed execution only.

Report every sample, identity-copy spread and traced/untraced difference, both
in KiB and ratios. Keep managed allocation counts separate. Any proposed runtime
repair needs a demonstrated cause and a new frozen before/after contract; a new
measurement protocol cannot retroactively qualify the original four misses.

The lifecycle interfaces and accounting scopes are documented in
[ptrace(2)](https://man7.org/linux/man-pages/man2/ptrace.2.html),
[getrusage(2)](https://man7.org/linux/man-pages/man2/getrusage.2.html) and
[proc_pid_status(5)](https://man7.org/linux/man-pages/man5/proc_pid_status.5.html).
## Preparation correction before a completed service batch

Initial lifecycle/reconstruction run `46160161430` passes nine controls on both
architectures. The first service attempt `46160536010` fails on both hosts at
the first traced execution because the runtime creates a worker thread. No
service batch completed. The initial one-thread assumption was wrong; the
observer correctly rejected it and reaped all tracees. Explicit thread control
`46160642199` also exposes that stop-order path on both hosts.

The corrected protocol above tracks the worker and checks that it has finished
before the terminal snapshot. It preserves the same binaries, cases, round
counts and ordinary controls. This is a necessary observer repair, not selection
based on a memory result. The original protocol is retained at
`roadmap/exec-memory-contract-2026-11-28`; corrected observations await verification.
