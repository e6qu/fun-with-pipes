# Cleanup after failed map and set operations

Historical measurements at the revisions named below. Counts and timings are
observations of those programs, not current compiler budgets. Commands refer
to the recorded measurement revision. Read [measurement terms](../benchmarks.md)
for timing and memory boundaries; [the plan](../../PLAN.md) owns remaining work.

**Check, not timing benchmark:** partial results must free when a map callback,
allocation or retain fails, while independently held inputs remain valid.
A reproducer with 32 caught failures left 2,048 bytes before the repair and zero
afterward. The [six-host report](map-failures-2026-10-18.json),
`af834f8c`, covers 22 conversion/insertion/removal/update/set/callback operations.

Inject failures at each of 108 allocation/retain points (110 with reuse poisoning).
Six configurations combine O1/O2 with ARC, stressed tracing and stressed tracing
plus reuse verification. Callbacks changing strings to integers and vice versa
must match interpretation and clean up by result type. All 66 focused tests pass;
48 saved binaries include tracing-presence controls. Missing partial-map or first
scratch-array cleanup must fail the probe. ARC shutdown charge is zero.

Counts exclude allocator capacity/process RAM; binary sizes identify the tested
files, not a claimed code-size improvement. No elapsed-time/C/Rust comparison
was made. [PR #165](../roadmap-history.md#owned-c-results-and-failure-cleanup-pr-165)
records acceptance. Use `scripts/summarize-map-failures.py` from that recorded
revision to audit its historical artifacts. The current collector also checks
comparison failures, compact sets and [sort-storage peaks](arc-comparison.md#releasing-map-sort-storage-sooner).
