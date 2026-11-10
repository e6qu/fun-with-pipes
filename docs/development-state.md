# Current work

**Next:** implement and verify the selected borrowed type traversals, bundle the
compiler change, observation repairs and delivery/docs updates in one normal PR.
[PR #274](https://github.com/e6qu/fun-with-pipes/pull/274) is fully verified and merged.

## Delivered baseline

#274 squash commit `e8997ac874f2c57009a5a13a7a5192c4f762272e` has the exact tree of
passing head `9fdb5e7bd3b23e7a720c490c7b8a21a843b4221b`. All nine production jobs,
documentation and the full-log audit pass; the complete archive's SHA-256/CRC,
ten source reports and empty issue list are verified. The one-line squash message
has no body or trailers. [Delivery receipt](measurements/application-final-gates-2026-11-10/README.md).

Worktree `.worktrees/compiler-checking-costs`, branch `compiler-body-costs`, is
rebased onto that squash commit. Historical recording tags retain their original
sources. No next PR has opened yet; the compiler candidate is not implemented.

## Selected change and measurements

[Exact copy counts](measurements/compiler-type-copies-2026-11-10/README.md) pass
both native Linux hosts at `35a12dfee0266134237d03d1262649be69df7c41`, run
`42758033441` (AMD `129636888892`, ARM `129636889101`). The ordinary compiler
source equals merged #274. All four applications emit identical C with/without
the separate-checkout observer, and both hosts produce identical node counts.
Full logs have no unexpected diagnostics. The observer patches and retained
reports are verified; generated C/binaries remain in named CI artifacts.

The [frozen contract](measurements/compiler-type-walks.md) selects borrowing in
`free_vars` and `zonk`: preserve inference, variable order, normalization, rows,
effects and diagnostics; keep row flattening unchanged initially. Measure remaining
copies, then ordinary whole emit-C time on four apps and twelve growth inputs.
Require two sessions per architecture, existing 2% copy controls, ≥5% improvement
for words/callbacks, ≤2% other time regression and ≤5% peak-RSS growth. No speedup
has been measured. Run focused checks first and one complete final delivery matrix.
The observation script's group-loop variable also needs renaming to restore
correct console application labels; original JSON/counts are correct.

## Profiler repair

[Recording history](measurements/compiler-cpu-samples-2026-11-10/README.md)
retains all failures. Source `f7f4336f79ee3d76684cc77960ffb7fc0ef3a387`, run
`42754692740`, records four applications on each host with identical C. Direct
DWARF stack decoding repairs perf's unavailable parent-column attribution.
ARM64 passes all apps; AMD64 misses words/numerical callers. Per-thread replay
`42759680401` does not repair this; do not accept those profiles.

AMD64 perf 7.0.14's libdw load-base calculation conflicts with the recorded ELF
segment layout (4 KiB virtual/file offset difference). The next recording selects
Ubuntu 24.04's perf 6.8 environment explicitly on both architectures, retaining
ordinary compiler optimization/link settings and requiring resolved callers plus
complete sample/period accounting. The ineffective per-thread workaround is
removed. This is diagnostic work; production platform coverage remains unchanged.

Local guarded reader controls, workflow lint and roadmap checks have passed for
the prepared scripts; recheck after current docs/workflow edits. No local compiler
build, full suite or benchmark ran. One artifact read was stopped by the guard's
serialization lock; it ran successfully after the prior read finished, with no
limit changes. All report downloads remain small and serial.

## Roadmap status

| Step | Status | Delivered | Remaining |
|---|---|---|---|
| 1 | In progress | #270 documentation and fresh F64 stores | Original AMD timing acceptance |
| 2 | In progress | #271 captured maps and empty-owner transfer | Original noisy timing acceptance |
| 3 | In progress | #272 structured gradients and known callbacks; all delivery gates | Original AMD timing acceptance |
| 4 | Verified | #273 ownership/peer comparisons and parser cleanup repair; all gates | Recorded comparison limits apply |
| 5 | Verified | #274 applications, compiler reports/growth, HTTP load and Windows pressure repair; all gates | Recorded observation limits apply |
| 6 | In progress | Verified baseline copy counts and frozen borrowing contract | Compiler implementation, correctness, count/timing/memory comparison and final delivery |

Original milestone 1–3 timing limits remain open; do not repeat unchanged noisy
measurements for acceptance. Keep CPU models separate, new reporter overhead
unmeasured and the public gradient API unchanged without representative evidence.

Preserve unrelated root-worktree changes, old worktrees and handoff stash
`451bbf713d451f2d62d80fd7676839404875846a`. Local checks remain serial through
`python3 scripts/local-guard.py`: 64 GiB free, target data <2 GiB, sampled RSS
<1 GiB, 180-second deadline. Full gates, builds and measurements run on GitHub.
