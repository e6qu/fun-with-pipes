# Scalar append inlining: work and memory

Inlining preserves every measured allocation, reference-count increment, tape
lookup, parent check, capacity check and recorded node. Managed and raw storage
return to zero. The largest reported frame grows by at most **16 bytes on ARM64**
and **zero on AMD64**, within the frozen 128-byte limit. This establishes memory
and work-count preservation, not a speedup.

## Comparison

Source `ecfd740be6289b365dd2a1bb9e2f60980ab27c8f`. The candidate forces the existing
checked F64 append body inline; the same-source reference changes only that
declaration back to `static`. Both retain lookup reuse and earlier optimizations.
The workload computes Rosenbrock derivatives and repeated coordinate updates.

For example, eight solves with 129 coordinates and 199 updates perform 611,328
tape lookups and record 1,630,208 nodes in **both** versions. Parent and capacity
checks also remain 1,630,208. Inlining targets call overhead, not these checks.

| Coordinates / updates | Solves per process | Managed peak bytes | Raw tape peak bytes |
|---|---:|---:|---:|
| 3 / 0 | 32,768 | 1,048,704 | 0 |
| 3 / 1 | 512 | 16,656 | 1,792 |
| 3 / 199 | 32 | 1,296 | 1,792 |
| 3 / 1,999 | 4 | 400 | 1,792 |
| 33 / 199 | 32 | 3,904 | 8,560 |
| 129 / 199 | 8 | 11,584 | 33,904 |

These whole-program counters include the repetition driver; they are not process
RAM or per-update costs. Values match across versions, architectures and both
result forms with workspace reuse 1. Workspace reuse 0 is checked separately.
Fresh single-solve GCC O1/O2 counts also match the delivered lookup-reuse parent.

ARM64's largest frame grows 704→720 bytes for 33/199 current, and 2,240→2,256 for
both 129/199 forms. Other largest-frame sizes are unchanged. Dynamic-stack
qualifications remain in the receipts: these are individual reported frames,
not a bound on total call-stack use.

## Verification

[Measurement run](https://github.com/e6qu/fun-with-pipes/actions/runs/42158774007)
and [complete audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42159822189)
pass on both architectures. Per architecture, the audit checks 171 commands,
48 native images and 96 repeated-program executions, plus 24 fresh cases per
compiler and 164 fresh images. It verifies reference isolation, exact outputs,
phase allocation, cleanup, validation counts and stack records.

- [ARM64 receipt](aarch64/audit/aarch64-verified.json) and
  [AMD64 receipt](x86_64/audit/x86_64-verified.json) contain each case's counts.
- Each architecture's `audit/observations.zip` retains 2,019 checked records;
  `audit/inventory.json.gz` records hashes, including original native images.
  Large images remain in the identified original CI artifacts.
- `audit/parent-reconciliation.json` ties storage to the delivered parent.
  Fresh reports and complete producer logs are retained beside it.
- [Artifact digest](artifact.json), [audit job](audit-job.json) and
  [complete audit log](audit-job.log.gz) identify the audit. Local guarded checks
  also verified the downloaded archive digest and every retained record hash.

[Protocol](../recording-inline.md) ·
[Compiler costs](../recording-inline-analysis-2026-11-06/README.md) ·
[Handoff](../../development-state.md)
