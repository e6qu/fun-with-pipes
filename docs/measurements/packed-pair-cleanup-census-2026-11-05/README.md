# Pair reuse after the cleanup repair

**Stack/count checks and full saved-data audits pass on ARM64 and AMD64.**
Compare two compilers from 373955e8: the candidate reuses a private numeric pair
buffer; the reference allocates its output. Both keep the repaired cleanup and
all other transformations. This is fwp versus fwp, not C/Rust parity.

[Run 42015900941](https://github.com/e6qu/fun-with-pipes/actions/runs/42015900941)
measures six Rosenbrock solve sizes, both final-result/history forms.
[Audit 42018351007](https://github.com/e6qu/fun-with-pipes/actions/runs/42018351007)
verifies every saved command/output, native image header, compiler/source hash,
stack report, allocation profile and reference comparison. It also passes eight
budget and seven saved-stack failure controls. [Receipt](retention.json) identifies
all sources; each host directory retains full logs, artifact metadata and records.

## Stack: the observed regression is repaired

GCC O2 compiles the same 12 complete programs for both compilers. All candidate
maximum reported frame counts equal their references. The allowed increase stays
128 bytes; none is used. Selected counts, candidate = reference:

| Program | AMD64 bytes | ARM64 bytes |
|---|---:|---:|
| 3 coordinates, any tested updates/form | 720 | 704 |
| 33 coordinates / 199 updates, final result | 720 | 704 |
| 33 coordinates / 199 updates, history | 768 | 816 |
| 129 coordinates / 199 updates, either form | 2,192 | 2,240 |

The first implementation's AMD64 33/199 final-result frame was 928 bytes against
an 848-byte limit. Keeping one protected owner removes that observed excess.

These numbers are **not total call-stack bounds**. History programs include
GCC `dynamic` entries whose variable portion is not bounded by the report.
Candidate/reference entries agree in function, known bytes and qualifier; path
line numbers can differ. The audit retains these entries separately. See the
[exact metric and GCC qualifiers](../packed-pair-cleanup-repair.md#what-the-stack-comparison-establishes).

## Allocation savings are preserved

Both architectures verify 12 repeated cases at O2 and 24 fresh cases per compiler
at O1/O2, with derivative workspace reuse explicitly on and off. The allocating
reference agrees with saved parent #259 counts, phase peaks and derivative storage.

For 129 coordinates / 199 updates, on both hosts:

| Scope / metric | Allocating reference | Reuse |
|---|---:|---:|
| One fresh solve: managed requests | 727 | 528 |
| One fresh solve: requested bytes | 1,034,366 | 625,222 |
| One fresh solve: peak charged bytes | 9,248 | 7,200 |
| Eight solves: managed requests | 5,953 | 4,361 |
| Eight solves: requested bytes | 8,278,216 | 5,005,064 |
| Eight solves: peak charged bytes | 13,632 | 11,584 |

For N coordinates and U updates, savings remain U requests and (16N−8)U requested
bytes per solve, all during forward recording. Retains and raw derivative storage
are unchanged. Zero-update observations are identical; final managed/raw storage
is zero. Allocation traffic and managed peaks do not establish process RSS or speed.

## Retained evidence

Each host's `audit/observations.zip` contains the original reports, commands,
inputs, outputs and stack files; `inventory.json.gz` hashes every original member.
The full generated C and native images remain in the original digest-identified
artifacts. Compressed audit reports contain recomputed counts, frame maxima and
dynamic entries. Parent reconciliation, fresh phase profiles and full job logs
are alongside them. No unchanged native measurement was rerun for the
[auditor correction](../packed-pair-cleanup-checks-2026-11-05/README.md#saved-stack-audit-repair).

[Original results](../packed-pair-time-2026-11-05/README.md), including 23 speed
misses and the original stack failure, remain separate. Repaired-source runtime
and final production verification still remain.
