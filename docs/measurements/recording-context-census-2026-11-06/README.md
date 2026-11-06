# Shared tape access: work and memory

The measured single-tape objective now performs **two registry lookups per
positive update**, instead of `3 × (coordinates − 1)`. Allocation/retain counts,
recorded nodes, parent/capacity checks and peak tracked storage are unchanged.
Both versions release all tracked storage. Largest reported stack frames are
unchanged on both architectures. These are work/storage results, not speedups.

## Comparison

The candidate borrows validated tape access across proven numeric calls and
keeps separate state around the neighboring-pair map and numeric fold. The
same-source reference disables only those new scopes. Earlier lookup reuse,
append inlining and capacity inlining remain enabled in both versions.
Source: `319782736b0a983022f2a48879b35c9e57992949`.

The program minimizes the Rosenbrock function with automatic derivatives.
Six coordinate/update cases (3/0, 3/1, 3/199, 3/1999, 33/199, 129/199) use both
final-coordinate and history-producing forms. Zero updates perform no tape
lookups. Inputs that switch tape IDs still require their separate validations;
the two-lookup result applies to this measured single-tape objective.

For **eight solves of 129 coordinates and 199 updates**, both architectures give:

| Observation | Reference | Candidate |
|---|---:|---:|
| Registry lookups | 611,328 | 3,184 |
| Recorded nodes; parent checks; capacity checks, each | 1,630,208 | 1,630,208 |
| Allocation requests | 4,361 | 4,361 |
| Requested bytes, cumulative | 5,005,064 | 5,005,064 |
| Retains | 8 | 8 |
| Peak tracked managed bytes | 11,584 | 11,584 |
| Peak tracked raw bytes | 33,904 | 33,904 |
| Final tracked managed/raw bytes | 0 / 0 | 0 / 0 |

The reference performs `3 × 128 × 199 × 8` lookups; the candidate performs
`2 × 199 × 8`. Managed/raw counters describe program storage, not total process
RAM; their peaks need not coincide and must not be added. Individual reported
stack frames do not bound the whole call stack; dynamic-frame records remain
in each receipt.

## Verification

[Measurement run](https://github.com/e6qu/fun-with-pipes/actions/runs/42224646191)
and [complete audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42229061410)
pass. Per architecture, the audit verifies:

- 171 commands, 48 repeated-program native images and 96 executions.
- All twelve case/form combinations and the exact same-source reference edit.
- Fresh-solve O1/O2 phase counts, both workspace policies and 164 fresh images.
- Allocation/retain counts, lookup/node/check counts, storage peaks and release.
- Complete-program stack records and every producer diagnostic.

[ARM64 receipt](aarch64/audit/aarch64-verified.json) ·
[AMD64 receipt](x86_64/audit/x86_64-verified.json) ·
[Artifact identity](artifact.json) · [Audit job](audit-job.json) ·
[Complete audit log](audit-job.log.gz).
Each architecture retains 2,019 observations in `audit/observations.zip`, with
hashes in `audit/inventory.json.gz`. Local guarded checks verify the downloaded
archive digest, all 4,038 retained-record hashes, count formulas and memory/frame
limits (0.25 s). Large original native archives were audited on GitHub.

[Runtime results](../recording-context-time-2026-11-06/README.md) ·
[Compiler costs](../recording-context-analysis-2026-11-06/README.md) ·
[Contract](../recording-context-scopes.md).
