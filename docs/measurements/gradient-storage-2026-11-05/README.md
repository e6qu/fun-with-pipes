# Where the current gradient update still allocates

**An untimed allocation breakdown, not a new optimization or speed result.**
Both architectures pass the independent raw-data audit. This report identifies
specific work for the next ownership proof after [PR #258](https://github.com/e6qu/fun-with-pipes/pull/258).

## Program and method

The program minimizes the Rosenbrock function. Each adjacent pair contributes
`100 * (y - x*x)^2 + (1 - x)^2`; each update subtracts `0.001 * gradient` from
coordinates initially alternating between −1.2 and 1.0. A *gradient* contains one
derivative per coordinate. Reverse-mode differentiation first evaluates the
function while recording operations in a *tape*, then follows that record backward.

```text
create input list
  → repeat: record objective → compute derivatives → scale → update coordinates
  → print final coordinates → release remaining storage
```

Run one fresh solve for each of six inputs: 3 coordinates with 0, 1, 199 or 1,999
updates; 33 or 129 coordinates with 199 updates. Check both current/history forms,
O1/O2 and derivative-workspace reuse off/on. History selects the last value, so
unused earlier history can be removed by optimization.

This driver owns its initial coordinate list exclusively. The
[repeated timing driver](../owned-numeric-time-2026-11-05/README.md) captures that
list across solves and must copy its first update. Their absolute counts differ;
do not substitute one driver's totals into the other's acceptance checks.

There is no second implementation or timer here. Independent whole-program
counters are reconciled with per-phase and allocator-call-site counters. Known-work
controls and deliberately broken observers must behave as specified. This neither
measures overhead against C/Rust/Swift nor closes any existing speed target.

## One fresh solve: 129 coordinates, 199 updates

Both architectures and both result forms agree at O2:

| Phase | Allocation requests | Requested bytes | Effective retains |
|---|---:|---:|---:|
| Outside derivative phases | 329 | 212,894 | 199 |
| Forward evaluation with recording | 1,593 | 845,376 | 199 |
| Derivative result arrays | 199 | 206,960 | 0 |
| Other derivative phases | 0 | 0 | 0 |
| **Total** | **2,121** | **1,265,230** | **398** |

A request is one call for managed storage; requested bytes include its value header,
not allocator padding. A retain adds an owner to existing counted storage. These
are traffic totals, not simultaneously live bytes. Outside work includes the initial
129 list cells, 199 coordinate scratch buffers and one output allocation.

Peak charged managed storage is 9,280 bytes. With workspace reuse enabled, peak
raw derivative storage is 33,904 bytes; it remains cached until shutdown, then
reaches zero. Final managed storage is also zero. These separate peaks are not
process RSS and need not occur together. Use the linked timing report for RSS/time.

## Concrete remaining allocation sites

For N ≥ 3 coordinates, each update requests:

| Object | Requests | Requested bytes |
|---|---:|---:|
| Packed input records | 1 | 16N + 8 |
| Packed neighboring pairs | 1 | 16N − 8 |
| Fold result with two numeric fields | 1 | 24 |
| Singleton root and seed lists | 2 | 48 |
| Seed-conversion scratch | 1 | 16 |
| Singleton root and seed arrays | 2 | 32 |
| Derivative result array | 1 | 8N + 8 |
| Coordinate scratch | 1 | 8N + 8 |

The cached initial fold record adds one 24-byte request per process with updates.
The source-derived forward formula, `8U + (U>0)` requests and
`(32N + 120)U + 24(U>0)` bytes, matches all 96 audited observations.
The two retain sites are preparation of the scoped gradient's input list and the
cached initial fold record. Each contributes one effective retain per update.

The next proof should examine these together:

- Borrow the read-only input through a known derivative scope, preserving its
  caller's owner and exceptional cleanup. Ordinary direct-call borrowing does not
  currently cover that callback boundary or all private numeric operations.
- Pass the fold seed/result as numeric fields. Only literal, effect-free cached
  records may become constants; do not assume every user-defined `zero` is pure.
- Seed one backward root without temporary lists/arrays, preserving explicit seed
  values, scalar precision, nested derivatives and invalid-root cleanup.
- Reuse a consumed derivative array as coordinate scratch only after proving its
  layout and exclusivity. Preserve views/aliases, callback order and list sharing;
  never free an interior array pointer as separately allocated scratch.

If all four proofs succeed, the source predicts seven fewer requests per update
plus the cached record. This is an unimplemented target. Freeze selection rules,
whole-process predictions, a same-source reference and failure tests before code;
measure the actual result before making any speed or memory claim.

## Source, hosts and retained evidence

[Run 41932568083](https://github.com/e6qu/fun-with-pipes/actions/runs/41932568083),
`suite=derivative-forward-costs`, `comparison=baseline`, uses immutable source
`07541ff956d582bb9c3936b86261e43fa25b0b2f`
(`roadmap/owned-numeric-measurement-2026-11-05`).

| Host | Compiler | Job | Audited records |
|---|---|---|---|
| ARM64 Neoverse-N2 | GCC 13.3.0 | 126932900347 | [Receipt](aarch64/audit.json), [profiles](aarch64/verified.json.gz), [raw records](aarch64/records.zip) |
| AMD64 EPYC 9V45 | GCC 15.2.0 | 126932900366 | [Receipt](x86_64/audit.json), [profiles](x86_64/verified.json.gz), [raw records](x86_64/records.zip) |

Generated C uses O1/O2, `-std=gnu11`, `-ffp-contract=off`, `-fno-fast-math`,
`-fno-lto`, `-fstack-usage`, `-Werror`, and `-march=armv8-a` / `x86-64`.
The driver clears inherited fwp settings and explicitly sets LTO/workspace reuse;
other compiler switches use this frozen source's settings. This is not the timing
protocol's separately fixed compiler configuration. Every command is retained.

Each host audit checks 24 cases, both workspace settings, 82 native ELF images,
raw/interpreted outputs, phase totals, source sites and observer controls. Archives
retain programs, ordinary C, control sources, raw outputs, stack records and report
commands. File inventories and original artifact digests identify all emitted
images and instrumented C; the complete originals remain in the referenced GitHub
artifacts and local scratch archives. No generated C or executable was changed for
this diagnostic. Independent audits took 12.72s/12.10s; retention took 1.47s.
