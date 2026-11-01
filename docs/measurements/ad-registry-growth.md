# Autodiff registry growth

Historical results; reproduce with the recorded revisions, not current main.
[Measurement terms](../benchmarks.md) explain the costs;
[PLAN.md](../../PLAN.md) tracks current work.

The runtime keeps a table of active tapes, called a **registry**.
[This comparison](ad-registry-2026-10-15.json) runs identical fwp
batches. The control grows that table by one entry per request; the changed
version doubles capacity, capped at the existing limit.

| Simultaneous tapes | Table allocation requests, control → changed | Peak table bytes, control → changed |
|---|---:|---:|
| 1 | 1 → 1 | 104 → 104 |
| 256 | 256 → 9 | 26,624 → 26,624 |
| 257 | 257 → 10 | 26,728 → 53,248 |
| 4,096 | 4,096 → 13 | 425,984 → 425,984 |

Doubling makes fewer requests but can reserve unused space: 26,520 extra live
bytes at 257 tapes. The table is already included in tape-storage totals.
Cumulative requested table bytes at 4,096 tapes fall from 872,628,224 to 851,864;
this does not measure physical copying. Managed counters are unchanged, final
measured storage is zero, and timings support no general speedup claim.
