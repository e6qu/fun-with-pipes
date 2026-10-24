# CI compiler build cost

Historical measurements at the revisions named below. Counts and timings are
observations of those programs, not current compiler budgets. Commands refer
to the recorded measurement revision. Read [measurement terms](../benchmarks.md)
for timing and memory boundaries; [the plan](../../PLAN.md) owns remaining work.

The [CI profile comparison](ci-compiler-profiles-2026-10-16.json)
compares two builds of the same fwp revision, `c81b0c9f`, on each runner. Rust
optimization level 0 is the baseline; level 1 is the candidate. Both retain debug
assertions and overflow checks. The inputs are the complete `linalg_ownership`
and `arc_tasks` test targets, with unchanged generated-C flags and cases. This
measures time spent building the compiler and running tests, not fwp program
speed against C or Rust.

Each profile has a separate build and cache, one warmup, and two measured samples
in order 0/1/1/0. The table uses median whole-test elapsed time; initial builds are
reported separately. A ratio below 1 means less elapsed time for these tests.

| Runner | Build at level 0 / 1 | Tests at level 0 / 1 | Test ratio, 1 divided by 0 | Extra initial build cost |
|---|---:|---:|---:|---:|
| Linux AMD64, 4 logical CPUs | 18.80 / 45.43 s | 49.90 / 40.16 s | 0.805 | 26.63 s |
| Intel macOS, 4 logical CPUs | 108.93 / 267.13 s | 132.92 / 99.27 s | 0.747 | 158.20 s |

Level 1 reduces test elapsed time by about 19.5% and 25.3% in this comparison,
while costing more to build. Child-process CPU ratios are 0.833 and 0.783.
Both profiles pass every selected test. Two samples do not characterize runner
noise, predict the complete CI gate, or establish memory savings. Physical CPU
models, host contention and resident memory were not sampled. The report retains
compiler versions, artifact build settings, executable hashes, samples and log
hashes; the workflow retains the complete logs.
