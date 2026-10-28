# Current work

**Next:** monitor all nine final-head production jobs plus documentation for
[PR #223](https://github.com/e6qu/fun-with-pipes/pull/223). Audit every target and
compiler diagnostic, repair failures, then squash-merge only after every gate
passes. Continue with P2/P3: isolate one proved redundant cost and compare it
against the frozen same-job baseline. No CPU optimization is claimed in #223.

Worktree: `/private/tmp/fwp-parser-workspace`; branch `cpu-baselines-and-budgets`.
Base: merged #222, `17978b97373f3e9236468ac19c1b8e0d290816d7`.
Measurement source: `ec03d9cd81c001bf006a73e7dbfb044155884611`.
Subsequent edits add reader checks, retained evidence and docs; the measured
compiler and collection routine are unchanged.

## Completed batch, acceptance pending

B1/P1's `loop` and `text-length` sessions and corresponding B2 integrity checks
are implemented. [The report](measurements/cpu-baselines.md) owns exact inputs,
timing scope, toolchains, all observations, costs and frozen decision limits.
All four jobs of `40765920239` and both extra AMD64 jobs of `40768027818` pass.
Every log and artifact is audited: each job checks 21 timed images, 14 instrumented
images, 21 RSS distributions and eleven peer-control images. No compiler warnings
or failed targets. Documentation `40765901608` passes at the measurement head;
its draft-skipped production run is not final acceptance.

The first AMD64 pair used different CPU models, so freezing correctly failed.
All six raw records are retained. The first repeated CPU model in run/session
order selects Neoverse-N2 and EPYC 7763, without selecting for speed or noise.
Xeon 8370C and EPYC 9V74 remain additional observations. A noisy selected pair
cannot be replaced by a later stable pair. The frozen table retains hashes of
all original records; CI recomputes it and rejects edited limits.

Two warmup batches and 32 rotating batches include identical-fwp controls.
Each loop batch has one process; character counting has 32 fresh processes with
unchanged input and individual output checks. Limits derive from observed noise
before any candidate measurement. EPYC character counting needs more than about
9.5% less time for a speedup claim; smaller gains are inconclusive. Both fwp
programs have zero managed requests/retains, but this excludes raw runtime storage
and stack use. Whole-process RSS, timed code sizes and separately instrumented
stack reports are retained. B1/B2 for A/D/N remains open.

Run `40764926704` was cancelled while every job was queued, before the short-sample
batching repair. No completed evidence was discarded. Preserve all seven original
peer comparisons; additional repeated timing targets only the two named gaps.

## Verified previous delivery

F1–F3 are verified in #222. Final `b69f111e` and merge `17978b97` share tree
`5a434a44f164e664b31c70a8d7b1db9e8dc8ab5d`; the squash message meets the one-line
rule. All nine production jobs `40721714559`, docs `40721714558` and both G2 hosts
`40721764744` pass. [History](roadmap-history.md#functional-calls-and-recursion-pr-222)
owns counts and links. Postmerge runs also pass; acceptance uses audited final-head
runs. G2 preserves exact lifetime facts, 40-byte origins and unchanged budgets.

Long timing `40721041382` at `98a1d8eb` accepts all four original limits after
increasing batches to 65,536 invocations. Only docs changed before the final head.
ARM64 O2 remains about 1.9% slower than ordinary calls, despite beating the explicit
loop. Earlier noisy results remain inconclusive. [The report](functional-costs.md)
owns all sessions. State `each` still allocates per element.

The historical Intel [compiler abort](measurements/compiler-abort.md) remains
unexplained; no recurrence or new source evidence appeared. Diagnose a recurrence
from source and input; do not resume disassembly-led allocator experiments.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain collector-free ownership and cycle checks |
| 2 | Verified | Maintain the named A1–A6 guarantees |
| 3 | Verified | Maintain the scoped F1–F3 call and recursion guarantees |
| 4 | In progress | Accept CPU baselines, then isolate and measure a proved repair |
| 5 | Pending | Derivative storage, timing and precision |
| 6 | Pending | CPU numerical kernels |
| 7 | In progress | Accept the CPU integrity controls; broader B1/B2 remains open |
| 8 | Pending | Larger-program correctness, cleanup and scale |

## Local checks and recovery

Guarded independent audits of all six CPU sessions pass, including mathematical
output checks, per-process data, original sources, native binaries and memory
records. Consolidated checks pass under `python3 scripts/local-guard.py`: eight Python
control groups (`scripts/test-cpu-baselines.py`), frozen-table `verify`, Actionlint
on both changed workflows, and `scripts/check-roadmap.py` (171 doc link sets,
106 immutable pairs and eight roadmap steps). No full local build, suite or benchmark. Keep 64 GiB free,
2 GiB target, 1 GiB RSS and 180-second guard limits unchanged.

Raw CPU artifacts: `/private/tmp/fwp-223-{arm,amd}-{1,2}` and
`/private/tmp/fwp-223-amd-extra-{1,2}`. Logs: `/private/tmp/fwp-223-baselines.log`
and `/private/tmp/fwp-223-extra.log`. Audit: `/private/tmp/fwp-audit-cpu-session.py`.
Original reports and frozen limits live in `docs/measurements/cpu-*.json`.
Previous delivery evidence remains under `/private/tmp/fwp-222-*` and
`/private/tmp/fwp-221-*`; preserve it. Primary checkout is detached at #209 with
a recovery pointer and untracked compiler-abort evidence; preserve both.

Publication and squash merge are authorized after all final-head gates pass:
one line <=80 characters, empty body, no trailers/attribution. Verify merged tree
and message, then continue [PLAN.md](../PLAN.md) in substantial groups.
