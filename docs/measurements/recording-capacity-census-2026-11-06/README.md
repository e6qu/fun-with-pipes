# Checked capacity gate: work and memory

All measured allocation and validation counts are unchanged. Both versions
release all managed and raw storage. Neither architecture increases the largest
reported stack frame. This verifies storage preservation, not a speedup.

The candidate keeps the checked no-growth path at the caller. The same-source
reference recombines the gate and unchanged growth body. Both retain the previous
append inlining and lookup reuse. Source: `51edfc0e7884e1a75201bc9876fd13cb8ca25eee`.

The workload computes Rosenbrock derivatives and repeated coordinate updates:
six coordinate/update cases (3/0, 3/1, 3/199, 3/1999, 33/199, 129/199), with both
final-coordinate and history-producing forms. For example, eight solves of
129 coordinates and 199 updates perform 611,328 tape lookups and record 1,630,208
nodes in each version. Inlining targets call overhead, not these validations.

[Measurement run](https://github.com/e6qu/fun-with-pipes/actions/runs/42179964294)
and [complete audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42181326578)
pass on both architectures. Per architecture the audit verifies:

- 171 commands, 48 native images and 96 repeated-program executions.
- Allocation, reference-count, lookup, parent/capacity-check and node counts.
- Managed/raw peaks and final release; fresh-solve GCC O1/O2 phase attribution.
- Both workspace policies and exact agreement with the delivered parent.
- Complete-program stack records, including dynamic-frame qualifications.

These counters are program storage, not total process RAM. Reported individual
frames do not bound the complete call stack. Runtime and compiler costs are
measured separately under the [frozen contract](../recording-capacity.md).

[ARM64 receipt](aarch64/audit/aarch64-verified.json) and
[AMD64 receipt](x86_64/audit/x86_64-verified.json) contain each case's counts.
Each architecture retains 2,019 observations in `audit/observations.zip`, with
hashes in `audit/inventory.json.gz`; original native images remain in the
identified CI artifacts. The downloaded audit digest and all 4,038 retained
record hashes were also verified locally.

[Artifact](artifact.json) · [Audit job](audit-job.json) ·
[Complete audit log](audit-job.log.gz) · [Handoff](../../development-state.md)
