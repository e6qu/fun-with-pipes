# Private pair-buffer allocation results

[Run 42003323499](https://github.com/e6qu/fun-with-pipes/actions/runs/42003323499)
passes on native Linux ARM64/AMD64 at
`e4d645cd4c88e49ff0d7d781ec9af10095d01fd6`. [Source/job/artifact identities](packed-pair-census-2026-11-05.json)
retain the complete observations. The [contract](packed-pair-storage.md) fixes
acceptance. No new runtime timing or process-RSS claim yet.

## What is compared

Both compilers come from that source. The reference changes only the internal
pair-reuse constant to false; it retains consuming ownership, cleanup and earlier
optimizations. Its counts/peaks reproduce the delivered parent's saved results.
C/Rust are not part of this allocation comparison.

Six inputs use 3, 33 or 129 coordinates, with zero, one, 199 or 1,999 updates.
Current-result and history forms run with derivative workspace reuse off/on.
Repeated solves use GCC O2; fresh solves additionally use O1. Each host checks
12 repeated cases and 24 fresh cases, verifies outputs/cleanup and audits the
fresh source, counters, native images and saved observations in the runner job.

| 129 coordinates / 199 updates | Allocating reference | Reuse | Saving |
|---|---:|---:|---:|
| Fresh solve: allocation requests | 727 | 528 | 199 |
| Fresh solve: requested bytes | 1,034,366 | 625,222 | 409,144 |
| Eight solves: allocation requests | 5,953 | 4,361 | 1,592 |
| Eight solves: requested bytes | 8,278,216 | 5,005,064 | 3,273,152 |

The checks establish exactly U fewer requests and (16N-8)U fewer requested bytes
for N coordinates and U updates per solve. All savings belong to forward
recording. Retain counts and raw derivative storage are unchanged; zero-update
observations remain identical. Overall peak managed storage does not grow;
final managed/raw storage is zero. For a fresh 129/199 current-result solve at
GCC O2 on ARM64, peak managed storage falls from 9,248 to 7,200 bytes. Within
forward recording it falls from 9,248 to 6,688 bytes; setup, reverse propagation,
result construction and retirement peaks are unchanged. The saved reports cover
both architectures, optimization levels and workspace modes.

Requested bytes measure allocation traffic, not simultaneous live memory or
process RAM. Reuse keeps the original input capacity until the fold finishes.
Compiler costs and qualified timing sessions are still required; older timing
misses remain separate. Full production verification follows the complete batch.

## Retained observations

[Archive audit 42008501553](https://github.com/e6qu/fun-with-pipes/actions/runs/42008501553)
verifies raw profiles, exact reference sources, images and saved-parent agreement.
It passes after fixing a retention bug: outer/nested reports previously shared ZIP
member names. Separate namespaces now retain both, reject duplicates and reread
bytes against their hashes. Original warning-bearing run 42006250074 is preserved.

[ARM64 receipts and observations](packed-pair-census-2026-11-05/aarch64/audit/aarch64-verified.json)
and [AMD64 receipts and observations](packed-pair-census-2026-11-05/x86_64/audit/x86_64-verified.json)
are saved beside compressed full logs, fresh reports, parent reconciliation and
file inventories. `observations.zip` retains `original/`, `fresh-reference/` and
`fresh-candidate/` paths. Large generated images remain in the original artifacts.
[Retention artifact 13405128918](https://github.com/e6qu/fun-with-pipes/actions/runs/42008501553/artifacts/13405128918):
2,518,914 bytes; SHA-256
`63aeebc80c33a1851bcc58d91debb8ad5f3b11b14945e589b380c88ea355af81`.

These measurements precede the [cleanup-record repair](packed-pair-cleanup-repair.md).
The repair must repeat affected correctness/storage checks before new timing.
