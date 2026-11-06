# Recording lookup work and memory

The candidate performs **three tape lookups instead of eight per input pair and
update**: 62.5% fewer lookups. It records the same derivative nodes, validates the
same parents and capacity, and uses the same heap storage. This is a work-count
result, not a measured speedup.

## Comparison and example

Source `6a0ae280c4616f791df507b44cbd31935a16cd67`; the reference disables only
compiler-selected lookup reuse. Both use the same runtime and all earlier
optimizations. The workload differentiates the Rosenbrock objective, including
its complete forward and backward passes, and runs repeated updates.

For each adjacent coordinate pair, six direct recording operations share one
lookup. Two later additions still perform their own lookups:

| Work per pair/update | Reference | Candidate |
|---|---:|---:|
| Tape lookup | 8 | 3 |
| Parent-index validation | 8 | 8 |
| Capacity check | 8 | 8 |
| Recorded derivative node | 8 | 8 |

For example, eight solves with 129 coordinates and 199 updates record
`8 * 128 * 199 * 8 = 1,630,208` nodes. Lookups fall from 1,630,208 to 611,328;
all three other counts stay at 1,630,208. Zero-update inputs perform none.

## Memory and stack

All twelve repeated-program cases have unchanged allocation requests, requested
bytes, reference-count increments, managed peak bytes and raw tape-buffer peak
bytes. Both storage counters return to zero after cleanup. Current-result and
history-result forms agree; the latter's unused history can be optimized away.

| Coordinates / updates | Solves per process | Managed peak bytes | Raw tape peak bytes |
|---|---:|---:|---:|
| 3 / 0 | 32,768 | 1,048,704 | 0 |
| 3 / 1 | 512 | 16,656 | 1,792 |
| 3 / 199 | 32 | 1,296 | 1,792 |
| 3 / 1,999 | 4 | 400 | 1,792 |
| 33 / 199 | 32 | 3,904 | 8,560 |
| 129 / 199 | 8 | 11,584 | 33,904 |

These are whole repeated-program counters, including the driver; they are not
per-update costs or process RAM. The table uses workspace reuse 1 and matches on both architectures and both
result forms. Workspace reuse 0 is audited separately. Fresh single-solve
GCC O1/O2 measurements also reconcile with the delivered scalar-constant parent.

The largest GCC-reported frame size is unchanged for every complete-program case
on both architectures, passing the 128-byte growth limit with zero growth.
Dynamic-stack entries retain their qualifications: this report does not establish
an exact maximum for the entire call stack. The saved `.su` records are retained.

## Evidence

[Measurement run](https://github.com/e6qu/fun-with-pipes/actions/runs/42134160356)
passes Linux ARM64 and AMD64. The
[corrected audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42136506956)
checks 171 commands, 48 native images and 96 repeated-program executions per
architecture, plus 24 fresh cases per compiler and 164 fresh native images.
It verifies complete outputs, reference isolation, lookup instrumentation,
validation/node counts, allocation attribution, cleanup and source identities.

- [ARM64 receipt](aarch64/audit/aarch64-verified.json) and
  [AMD64 receipt](x86_64/audit/x86_64-verified.json) contain each case's counts.
- Each architecture's `audit/observations.zip` retains all checked observations;
  `audit/inventory.json.gz` records hashes, including original source/image hashes.
  Large native images remain in the identified CI artifacts.
- Each `audit/parent-reconciliation.json` ties unchanged storage to the delivered
  parent. Fresh candidate/reference reports and complete job logs are retained.
- [Audit metadata](audit-job.json), [full audit log](audit-job.log.gz) and
  [artifact identity/digest](artifact.json) identify the audit source `31c04650`.

The first audit verified the added lookup probes but printed obsolete summary
totals. The corrected audit derives those totals from checked records and includes
lookup counts in each receipt. Only saved artifacts were re-audited; no native
measurement was repeated.

[Protocol](../recording-lookups.md) ·
[Compiler costs](../recording-lookup-analysis-2026-11-06/README.md) ·
[Handoff](../../development-state.md)
