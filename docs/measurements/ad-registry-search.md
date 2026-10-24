# Autodiff registry search

Historical measurements at the revisions named below. Counts and timings are
observations of those programs, not current compiler budgets. Commands refer
to the recorded measurement revision. Read [measurement terms](../benchmarks.md)
for timing and memory boundaries; [the plan](../../PLAN.md) owns remaining work.

[This comparison](ad-search-2026-10-15.json) changes where fwp starts
looking for an available registry entry. The control starts at entry zero each
time. The new version remembers the first entry that might be available; that
remembered position is a **cursor**.

| Simultaneous tapes | Occupied/unavailable entries revisited by control | Revisited with cursor |
|---|---:|---:|
| 1 | 0 | 0 |
| 257 | 32,896 | 0 |
| 4,096 | 8,386,560 | 0 |
| 16,384 | 134,209,536 | 0 |

The counter measures those visits, not every CPU instruction. Creating tapes in
order avoids repeated scans in this test; arbitrary free gaps can still require
a search. The cursor costs eight static bytes and no new heap allocation.
Allocation counts and live-storage measurements are identical between versions.

For 16,384 tapes, median complete-process times over seven samples are:

| Host | Restart-at-zero control | Cursor version |
|---|---:|---:|
| Linux AMD64 | 164.802 ms | 10.681 ms |
| Linux ARM64 | 166.837 ms | 8.686 ms |
| macOS ARM64 | 144.215 ms | 12.551 ms |
| macOS Intel | 197.902 ms | 24.284 ms |

This large case is much faster; small cases are not consistently faster. These
are fwp-versus-fwp results, not overhead relative to C. The control retains the
new cursor-maintenance code and changes only its search start. All measured
storage is reclaimed with no tracing collections.
