# Current work

**Next:** audit timing run `42764964658` against the frozen speed/memory limits,
then publish the combined change as a normal PR and run the final delivery gates.
[PR #274](https://github.com/e6qu/fun-with-pipes/pull/274) is fully verified and merged.

## Delivered baseline

#274 squash commit `e8997ac874f2c57009a5a13a7a5192c4f762272e` has the exact tree of
passing head `9fdb5e7bd3b23e7a720c490c7b8a21a843b4221b`. All nine production jobs,
documentation and the full-log audit pass; the complete archive's SHA-256/CRC,
ten source reports and empty issue list are verified. The one-line squash message
has no body or trailers. [Delivery receipt](measurements/application-final-gates-2026-11-10/README.md).

Worktree `.worktrees/compiler-checking-costs`, branch `compiler-body-costs`, is
rebased onto that squash commit. Historical recording tags retain their original
sources. Candidate `c65ecb37691538ef5a24619376f68b1d243cbdea` is published under
`roadmap/compiler-borrowed-types-2026-11-10`. Focused run `42763406320` and
profiler replay `42763409910` pass on both architectures. Ordinary timing run
`42764964658` is dispatched at the same candidate, with two sessions per
architecture and full reference `35a12dfee0266134237d03d1262649be69df7c41`.
No next PR has opened yet.

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
[Focused candidate checks](measurements/compiler-borrowed-types-2026-11-10/README.md)
pass on ARM64 (`129654174367`) and AMD64 (`129654174360`): all seven type tests,
eight report/option tests, the signature/error corpus, sixteen exact-C comparisons
and all growth error locations. Both hosts remove the same 1.09–1.10 million
copies per application (29–32%), with unchanged visit counts. Complete logs and
small source/report/observer receipts are retained and audited. The console
application-label repair preserves previously correct JSON/counts.

## Profiler repair

[Recording history](measurements/compiler-cpu-samples-2026-11-10/README.md)
retains all failures. Source `f7f4336f79ee3d76684cc77960ffb7fc0ef3a387`, run
`42754692740`, records four applications on each host with identical C. Direct
DWARF stack decoding repairs perf's unavailable parent-column attribution.
ARM64 passes all apps; AMD64 misses words/numerical callers. Per-thread replay
`42759680401` does not repair this; do not accept those profiles.

AMD64 perf 7.0.14's libdw load-base calculation conflicts with the recorded ELF
segment layout (4 KiB virtual/file offset difference). Recording `42761474854` at `5cab084d5` uses Ubuntu 24.04/perf 6.8 on both
architectures. ARM64 passes; AMD64 now resolves checking callers in words/HTTP,
but numerical/callback reports fail addr2line's one-second internal read deadline.
Replay `42763409910` passes both architectures (AMD `129654190514`, ARM
`129654190596`) with the decoder deadline explicitly 10 seconds and the unchanged
120-second total command deadline. Both complete logs are audited. All eight
reports match sample/period totals with no empty stacks; unnamed leaf frames
retain 25–42% of periods. Reports, settings and failures are retained in the receipt.
This is diagnostic work; production platform coverage remains unchanged.

Local guarded checks pass: `test-compiler-sampling.py` (5 controls),
`test-compiler-build-comparison.py` (4 controls), `actionlint` on all three changed
workflows, `cargo fmt --all -- --check`, and `check-roadmap.py` (450 document
link sets, 106 preparation anchors, 6 milestones). The documentation gate also
now runs the compiler reader controls; `test-compiler-scaling.py` (3 controls)
and roadmap workflow lint pass. Renaming a heading exposed one stale link; it
is repaired and the final link check passes. No local compiler
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
| 6 | In progress | Borrowed type walks: native correctness, exact C and 29–32% fewer copies verified | Ordinary timing/memory comparison and final delivery |

Original milestone 1–3 timing limits remain open; do not repeat unchanged noisy
measurements for acceptance. Keep CPU models separate, new reporter overhead
unmeasured and the public gradient API unchanged without representative evidence.

Preserve unrelated root-worktree changes, old worktrees and handoff stash
`451bbf713d451f2d62d80fd7676839404875846a`. Local checks remain serial through
`python3 scripts/local-guard.py`: 64 GiB free, target data <2 GiB, sampled RSS
<1 GiB, 180-second deadline. Full gates, builds and measurements run on GitHub.
