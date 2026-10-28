# Proved scalar bounds: next delivery

PR #223 is merged and verified. Active work is branch `proved-scalar-bounds` in
`/private/tmp/fwp-scalar-bounds`, based on squash merge
`330a08939ea68a7967aecdc60a2c77ac9b55a1bb`. No follow-on PR is published yet.

**Next:** validate and publish the grouped P2/P3 experiment, then dispatch its
native runner checks. Select a compiler change only from the
[declared experiment](measurements/proved-scalar-bounds.md), using #223's frozen
limits. No compiler test or candidate timing has run yet.

## Current implementation

- Range advances use existing wrapping addition only under `position < end`.
  Character sums use it only after the existing nonnegative I64 bound proof.
  Wrapping cannot occur under these proofs; user arithmetic remains checked.
- Runtime endpoint controls cover all twelve integer types, equal/descending
  ranges, raw/optimized interpretation and native O0–O3. Callback/fold overflow
  and overflow before integer display must still trap.
- The runner builds baseline, index-only, length-only and combined compilers from
  Rust source, preserving patches and actual images. It requires a qualified
  CPU/toolchain before timing and retains seven-peer, arithmetic, memory and
  stack controls for every variant. Repeated comparisons use 56 rotating batches
  and an identical-baseline control. No improvement is claimed.
- Closed `map-order`/`checked-bounds` workflow options and four obsolete scripts
  are removed. Their old readers required the retired `memory: arc` schema.
  Historical protocols link to the original scripts; raw results remain intact.

Consolidated guarded checks pass: six evidence-control groups, Rustfmt for the
three changed Rust files, Actionlint for both workflows, and documentation audit
(172 link sets, 106 immutable pairs and eight roadmap steps). The first evidence
control run exposed a fixture alias: corrupting its input also changed its copied
reference. Independent copies fix the fixture and the rejection control passes. Full builds, suites and measurements run on GitHub.
Keep the guard's 64 GiB free disk, 2 GiB target, 1 GiB RSS and 180-second limits.

## Verified prerequisite

#223 final `a4cceb8d5a219ab7d691127844bc3ddc23a24001` passes all nine production
jobs `40771179934` and docs `40771144344`; all completed targets and compiler
diagnostics are audited. No failed target or compiler warning remains.
The squash merge has the identical tree `e3774208e2da356915f479688e5839d37d404b79`
and a compliant one-line message, with no body or trailers.
[History](roadmap-history.md#fixed-cpu-baselines-pr-223) owns the acceptance record.

The frozen baseline measurement source is `ec03d9cd81c001bf006a73e7dbfb044155884611`.
Fetch it explicitly in a clean runner: it is retained through #223, not an ancestor
of the squash merge. Six original sessions remain; host selection used first
repeat in run/session order, never speed/noise. Selected CPUs are Neoverse-N2 and
EPYC 7763. An unqualified host needs a baseline before candidate timing.
All observations and fixed decision limits are in
[the CPU report](measurements/cpu-baselines.md). Broader B1/B2 remains open.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain collector-free ownership and cycle checks |
| 2 | Verified | Maintain named A1–A6 guarantees |
| 3 | Verified | Maintain scoped F1–F3 call and recursion guarantees |
| 4 | In progress | Measure the two proved-bound changes; retain only a qualifying change |
| 5 | Pending | Derivative storage, timing and precision |
| 6 | Pending | CPU numerical kernels |
| 7 | In progress | Extend fixed baselines and integrity controls beyond these CPU cases |
| 8 | Pending | Larger-program correctness, cleanup and scale |

The historical Intel [compiler abort](measurements/compiler-abort.md) remains
unexplained. Diagnose any recurrence from source and input; do not resume
unproductive disassembly-led allocator experiments.

## Recovery and delivery

The primary checkout remains detached at #209 with a recovery pointer and
untracked compiler-abort evidence; preserve both. #223's clean worktree is
`/private/tmp/fwp-parser-workspace`. Its raw artifacts and audited logs remain
under `/private/tmp/fwp-223-*`; earlier #221/#222 evidence is also retained.
`/private/tmp/fwp-audit-production-log.py` checked every completed production log.

Keep one published PR at a time. Publication and squash merge are authorized
after all nine final-head production jobs and documentation pass. Supply one
line <=80 characters with empty body and no trailers/attribution; verify the
merged tree/message and continue [PLAN.md](../PLAN.md).
