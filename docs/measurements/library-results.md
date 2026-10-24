# Returning owned values to C callers

Historical measurements at the revisions named below. Counts and timings are
observations of those programs, not current compiler budgets. Commands refer
to the recorded measurement revision. Read [measurement terms](../benchmarks.md)
for timing and memory boundaries; [the plan](../../PLAN.md) owns remaining work.

A C caller releases an owned fwp result with `fwp_release_NAME`, including all
fields of a returned record. For example, `greet("c")` returns a string released
with `fwp_release_greet(result)`. See [C interop](../tutorials/09-c-interop/README.md).

**Check, not timing benchmark:** [six-host report](library-results-2026-10-18.json),
`d6d36961`. After warmup, 256 call batches read/return strings and aliases,
compute a derivative and run a pipeline. Static/shared linking, O1/O2 and
derivative-buffer reuse off/on make eight configurations. Shared hosts load/call/
unload three times. Outputs match interpretation; all 96 shutdown observations
have zero counted bytes/collections. Twenty-four inspected ARC libraries omit tracing.

| Measured call | Additional retains | Intermediate record allocations |
|---|---:|---:|
| Return the copied input string unchanged | 0 | 0 |
| Return two fields sharing the copied input string | 1 | 0 |

Two shared fields need one additional owner. Eligible result fields pass directly,
avoiding an intermediate record box; other calling conventions may still box.
Counts exclude initial count creation/release. Read-only input strings still copy.
Four missing-cleanup/extra-allocation/extra-retain controls per host fail as required.
Windows export/toolchain repairs prevent accidentally calling the system's different
`norm` function (25 instead of 5). No C/Rust speed was measured; counted bytes
exclude allocator capacity and host RAM. [PR #165](../roadmap-history.md#owned-c-results-and-failure-cleanup-pr-165)
records acceptance. Use `suite=library-results`.
