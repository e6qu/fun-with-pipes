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
