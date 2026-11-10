# Explain the service's process-memory readings

The ordinary comparison at `d80357c8c81d206c9d9934b141b5a5fafe97c430` passes
ARM64 timing and compiler-cost limits, but four ARM64 process-RSS comparisons
exceed the frozen 5% limit. Preserve those observations and limits. This diagnostic
does not replace them or repeat elapsed-time sampling to obtain qualification.

Large-case heap requests and peak charged storage are unchanged. Reported static
frames and code are smaller. These facts do not establish the cause of RSS changes.
Linux documents approximate fast RSS/high-water counters and more detailed
[page-level accounting](https://man7.org/linux/man-pages/man5/proc_pid_status.5.html).
Determine which memory categories and counter differences occur in these programs.

## Fixed experiment

- Reuse the exact reference/candidate binaries and identical copies from native
  run `42798403679`. Verify archive size/digest, all member checksums and binary
  hashes against the original reports. Do not rebuild or alter these programs.
- Keep all eight original cases and their recorded C-only batch counts. Run four
  balanced rounds of reference/reference-copy/candidate/candidate-copy on each
  architecture. This measures memory, not runtime performance.
- Every 50 ms, stop the observer's own child, read its complete `smaps`, `status`
  and `statm`, then resume it. Retain every snapshot, actual stop count, child
  output, exit status and `wait4` high-water value. Allow 30 seconds per child
  and at most 600 snapshots. Always terminate/reap a failed or timed-out child.
- Reuse the existing mapping parser and actual 16 MiB reservation/touch/unmap
  control. Both omitted-touch and omitted-unmap variants must be rejected.
- Reconstruct resident/anonymous/private pages and mapped heap, stack, executable
  and library categories from raw snapshots. Compare fast counters with the same
  stopped process's page walk; keep all disagreements and copy variation visible.

These are observed snapshots, not an exact transient peak or an allocator ledger.
Stopping a process perturbs timing, so discard timing claims from these runs.
No sample is selected or rerun based on its memory result. Attribution must explain
the observations before changing compiler code or proposing a future memory gate.
The [original acceptance contract](nested-resource-owners.md) remains unchanged.

## Environment correction after the first diagnostic

[Run `42810648965`](nested-resource-host-memory-2026-11-10/README.md) passes all
observation controls on both hosts, with lower
candidate page residency and zero fast-RSS/page-walk disagreement. It runs on
the runner host, whereas the original measurements ran inside Swift's container.
It therefore does not reproduce the original library environment or explain the
four misses. Preserve it as an environment-limited observation.

Correct the diagnostic to use the original multi-architecture image digest
`sha256:bca121f6eb59fd80340d1296887b2698ed8f3eb9eca7d80c181f8af769dc7ee0`
and require the recorded libc package `2.39-0ubuntu8.9`. Keep the same binaries,
cases and observation settings. This is an environment repair, not a timing rerun
or permission to replace original RSS observations.

`wait4PeakRssKiB` includes the child's pre-exec memory. Linux preserves resource
usage across `exec`; it can therefore reflect the Python observer's inherited
memory, even when fwp's own snapshots remain small. Keep that raw value, label
its whole-child scope and verify this with an allocation-before-exec control.
The original comparison uses GNU `time` as its launcher; this observer-specific
issue does not establish a cause for its missed limits.
Use the stopped-process page readings for memory categories; none is an exact
transient peak. [Linux accounting semantics](https://man7.org/linux/man-pages/man2/getrusage.2.html).

## Corrected result

[Run `42812351743`](nested-resource-memory-2026-11-10/README.md) passes both native
jobs and all controls in the pinned image. Candidate resident-page peaks are lower
in every case, and fast RSS agrees with all page walks. The original missed
high-water limits remain unexplained; they are not replaced or reclassified.
No compiler repair or relaxed limit follows from this diagnostic. Finish the
combined PR's delivery checks with the original acceptance limits still open.
