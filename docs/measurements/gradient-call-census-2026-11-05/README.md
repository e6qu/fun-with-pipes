# Gradient-call allocation results

**Both architectures pass corrected local and CI audits.**
[Runtime results](../gradient-call-time-2026-11-05/README.md) are audited;
these results establish allocation and reference-count
savings, not elapsed time or whole-process memory savings.

[Run 41964853201](https://github.com/e6qu/fun-with-pipes/actions/runs/41964853201)
measured source `8c0e4b0ef06aa9f528eeaedbfbab9461a82dd0d7` on native Linux
ARM64 and AMD64 with GCC. The [contract](../gradient-call-storage.md) and
[focused correctness checks](../gradient-call-checks-2026-11-05/README.md#passing-focused-matrix)
define the compared implementations. Both come from the same source: the reference
disables scoped input borrowing, numeric fold fields, direct backward seeds and
consumed coordinate scratch. Earlier optimizations stay enabled on both sides.

## Work and observed savings

Each program repeatedly computes a derivative and updates a coordinate list.
Heap requests below count runtime-owned value storage; raw derivative buffers
are tracked separately. Neither count includes every allocation made by system libraries.
Six inputs cover 3, 33 and 129 coordinates, with zero, one, 199 or 1,999 updates.
Both final-result and history forms run with derivative workspace reuse off/on.
Fresh solves additionally run at GCC O1 and O2. The repeated driver uses GCC O2.
All outputs match the analytic result; both architectures agree on the counts.

| 129 coordinates, 199 updates | Reference | Candidate | Saving |
|---|---:|---:|---:|
| Fresh solve: heap requests | 2,121 | 727 | 1,394 (65.7%) |
| Fresh solve: requested bytes | 1,265,230 | 1,034,366 | 230,864 (18.2%) |
| Eight solves: heap requests | 17,098 | 5,953 | 11,145 (65.2%) |
| Eight solves: requested bytes | 10,124,960 | 8,278,216 | 1,846,744 (18.2%) |
| Eight solves: effective reference-count increments | 3,192 | 8 | 3,184 |
| Eight solves: peak charged managed bytes | 13,664 | 13,632 | 32 |

The cached seed disappears once per process, so eight solves do not save exactly
eight times a fresh solve. Initial shared coordinates still need a first copy.
For positive updates U and coordinates N, a fresh solve saves 7U+1 requests,
(8N+128)U+24 requested bytes and 2U effective reference-count increments.
Zero-update observations remain identical. All final managed/raw bytes are zero;
raw derivative storage is unchanged (33,904 peak bytes in the largest repeated
case). Requested bytes describe allocator traffic, not simultaneous live memory.

## Remaining storage

For U updates and N coordinates, the candidate still makes:

| Phase | Requests | Requested bytes |
|---|---:|---:|
| Forward recording | 2U | 32NU |
| Gradient result array | U | (8N+8)U |

[Checked counts](remaining-allocations.json.gz) match every fresh input, both forms,
O1/O2 and workspace settings on both architectures. For 129/199, recording
requests 821,472 bytes and result arrays 206,960 bytes; input construction/output
accounts for the other 5,934 bytes. These are allocation traffic, not elapsed time.

The next storage investigation should map those two recording requests to their
producer/consumer lifetimes before choosing a transformation. Preserve evaluation
order, aliases and failure cleanup. Separately examine the zero-update source
and driver; these positive-update counts cannot explain its timing regression.

## Failure and correction

Both original jobs failed only the fresh-solve phase-byte check. The runtime's
`fwp_map_items` scratch allocation reserves `(N + 1) * sizeof(V)`. The checker
used N words, wrongly assigning eight bytes per update to objective recording.

| Phase | Incorrect expected byte saving | Correct expected byte saving |
|---|---:|---:|
| Coordinate scratch, outside derivative phases | 8NU | (8N+8)U |
| Objective recording | 128U+24 | 120U+24 |
| Combined | (8N+128)U+24 | (8N+128)U+24 |

The overall prediction and acceptance limits did not change. Original-policy
audits reproduce exactly 80 phase differences per host; no other limit fails.
The corrected checker passes on those same observations. Six budget controls
use literal examples and reject a wrong phase assignment even with correct totals.
No native program or timing was rerun to obtain a passing result.

## Retained evidence and reproduction

- [AMD64 receipt](amd-verified.json) and [ARM64 receipt](arm-verified.json) preserve
  original failures separately from the empty corrected-failure lists.
- Each receipt records the measured source, original artifact digest, original
  and corrected checker hashes, exact per-input counts and cleanup observations.
- Beside them: original job metadata/full logs, artifact receipts, raw observations
  and stdout/stderr archives, original audited fresh reports and file inventories.
- Complete generated C and native images remain in the digest-identified GitHub
  artifacts. Local audits reconstructed the counters/source and checked 24 repeated
  images plus 164 fresh images per architecture, without executing saved binaries.
- `gradient-call-census-report` takes explicit `evidence_run=41964853201` and
  `source_revision=8c0e4b0ef06aa9f528eeaedbfbab9461a82dd0d7`, verifies matching
  code trees, downloads the original artifacts, and runs
  `scripts/audit-gradient-call-census.py`. It does not build benchmark programs.

The original run remains failed in GitHub. The [separate report-only run](https://github.com/e6qu/fun-with-pipes/actions/runs/41967470333)
passes on both architectures. Its [receipt](report-ci/audit.json) and complete log
record no unexpected diagnostics.
[Compiler-cost checks](../gradient-call-analysis-2026-11-05/README.md) now pass.
[Runtime comparisons](../gradient-call-time-2026-11-05/README.md) are audited,
with 17 missed timing limits retained before final production checks and merge. Older missed speed goals stay open in [PLAN.md](../../../PLAN.md).
