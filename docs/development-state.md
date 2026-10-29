# PR #225: startup repairs and decimal counting

**Next:** publish this finished batch, mark #225 ready and monitor all nine
production jobs plus documentation for the final commit. Audit every completed
target and diagnostic; batch any repairs before pushing. Once all gates pass,
squash with an explicit one-line subject (<=80 characters) and empty body, verify
the merge tree/message, then begin D1–D3. Do not repeat accepted measurements
unless affected runtime/compiler/input changes require it.

Worktree `/private/tmp/fwp-cpu-phases`, branch `cpu-execution-costs`,
[PR #225](https://github.com/e6qu/fun-with-pipes/pull/225).
Balanced measurement source: `0c84afe98baec2b771fd416aced35eb4d6c11a24`.
Runtime/compiler/native tests match correctness-tested
`9c89a3761cba2c3bccb02dff93b3fec6754f4583`.

| Run | Job | Session | Audited result |
|---|---|---|---|
| 40810741109 | 123240190193 | ARM64 1 | Qualifies |
| 40810741109 | 123240190249 | ARM64 2 | Qualifies |
| 40810741109 | 123240190307 | AMD64 1 | Qualifies |
| 40811270742 | 123241898078 | AMD64 2 | Qualifies |

All four meet unchanged timing limits with stable controls. Text counting takes
33.8–34.8% less time on ARM64 and 38.6–39.6% less on AMD64; it remains
25.0–26.2% slower than C. Loop is unchanged. Each raw sample, generated program,
binary, memory profile and full job log was audited. Two nonmatching AMD64 hosts
stopped before building/timing; their records remain in the archive.
The [report](measurements/decimal-count.md#balanced-results-accepted-measurement)
owns raw reports and size/stack costs. Final production has not started;
the earlier draft-skipped matrix is not a gate.

## Included work

- Check main-thread attributes, stack setup, creation/join and stack-overflow
  handler registration. Static numerical-worker setup joins already-started
  workers and releases valid attributes on failure. No silent process-stack path.
- Startup checkpoint `3db10b5a9f1e22d1bc1d93c6faea055f484f90ad`, run
  `40792244152`, passed native Linux/macOS ARM64/AMD64. Every log/artifact audited:
  11 tests, seven images, 32 main-startup and three worker/control outcomes per host.
  This repairs source error handling; it does **not** diagnose the old Intel abort.
- [Phase diagnostics](measurements/cpu-phases.md) at `c92fed4208a16627f0f420f58ce1f7729bf0f061`
  retain calculation/setup/output intervals, their perturbation and all raw results.
  Both qualified sessions and all artifacts are audited; no speedup follows alone.
- Exact decimal-threshold tree: at most five comparisons, no lookup table,
  unchanged signed magnitude and checked expression order. Both GCC hosts at 9c89
  pass seven integer-output groups at O0/O1/O2/O3, output, peer and memory checks.
  Full production coverage still required. Code/stack tradeoffs are in the report.

## Retained experiments and checks

The [decimal report](measurements/decimal-count.md) preserves the rejected table,
inconclusive short/long/interleaved protocols, every raw observation and all host
rejections. Do not pool protocols or choose sessions by timing. The balanced
schedule fixes unequal preceding workloads; it does not prove a CPU mechanism.
GitHub retry status copies are not independent executions; the reader rejects them.

- Four balanced jobs qualify; logs and artifacts audited: 7 paired programs,
  21 peer images and 14 storage/control images per session.
- Guarded final archive verification passes with `--expected-decision accepted`.
  Long/interleaved archives retain `not-accepted`. A deliberately false acceptance
  claim for the long archive exits 1 at the intended assertion.
- Nine Python measurement-control groups, actionlint and Rustfmt passed before
  final reporting. The earlier docs run `40810737278`/`123240169983` passed and its
  full log was audited. Final guarded documentation audit passes (174 link sets,
  106 immutable preparation pairs/tags), actionlint passes, all three repeat
  archives verify their explicit decisions, and `git diff --check` is clean.
- All checks are serial through `scripts/local-guard.py`; no full local build.
  Full nine-job production and documentation gates remain required after publication.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain collector-free ownership and cycle checks |
| 2 | Verified | Maintain named A1–A6 guarantees; no universal ARC-free claim |
| 3 | Verified | Maintain scoped F1–F3 call/recursion guarantees |
| 4 | In progress | Verify selected CPU timing and startup repairs |
| 5 | Pending | D1–D3 derivative storage, timing and precision |
| 6 | Pending | N1–N2 CPU numerical kernels |
| 7 | In progress | Broader B1/B2 baselines and integrity checks |
| 8 | Pending | V1–V2 larger-program correctness, cleanup and scale |

## Recovery

#224 merged as `52e8da582644a93d996816d344894fdf5435a92f` after all nine jobs
`40790143419` and docs `40790141513` passed and were audited. Its merge tree equals
tested b4e004d5 and its one-line message/body were verified; duplicate postmerge
production `40801397077` was cancelled. [History](roadmap-history.md) owns details.
Older measured ancestry is remotely retained by `roadmap/revision-decimal-count-df80c15e`.

Raw files: `/private/tmp/fwp-{balanced,long,tree,decimal}-{arm,amd}*`, corresponding `.log`
files, phase/startup folders and `/private/tmp/fwp-224-final-*.log`. Audit helpers:
`fwp-audit-production-log.py`, `fwp-audit-{balanced,long,interleaved}-artifacts.py`,
`fwp-read-tree-result.py`, `fwp-archive-decimal-repeat.py`, all in `/private/tmp`.
The archive helper takes an explicit manifest, prefix, source and protocol.

The primary checkout is detached at #209: preserve its recovery pointer and
untracked `docs/measurements/compiler-abort.md`. The historical Intel compiler
abort remains unexplained. No local full builds/suites/benchmarks. Use the guard
serially with 64 GiB free disk, 2 GiB target, 1 GiB RSS and 180 seconds; current
disk is about 73 GiB free. Final matrix and compliant merge remain authorized.
