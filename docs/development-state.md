# PR #225: startup repairs and decimal counting

**Next:** finish auditing production run `40813465621` at
`18ae46cdbf2fa2cc8b33cee78b86ed9b8a2dce4a`, then publish every repair together.
Two confirmed Windows failures are the standalone decimal oracle's CRLF versus LF
assertion (`integer_output`, line 233). Local repair emits no line ending on either
side; eight guarded Clang O0/O1/O2/O3 valid/broken cases pass. Production fwp uses
binary streams already; its runtime and accepted timing candidate are unchanged.
An early Windows log upload prevents waiting for later suites to see this failure.

macOS ARM64 regular job `123248963643` passed all 132 Rust result summaries/619
tests and SDK/package checks, then ownership-artifact ZIP upload failed with
`EILSEQ: illegal byte sequence, read`. The upload log names no input file; the
origin is unresolved. Its crash bundle contains the expected scheduler cleanup
abort control, not a new compiler crash. A prepared packaging change streams and
hashes every file, verifies archived bytes, writes a source/file manifest, and
uploads the verified ZIP directly (`archive: false`). Read errors name the file
and fail without publishing an incomplete archive. Do not claim this establishes
the origin of EILSEQ or native verification before the repaired matrix passes.
Six guarded packaging controls, 20 native-runner controls and actionlint pass.
The two injected-file controls initially missed macOS temp-path aliases; resolving
the fixture root fixed those tests. No production error was suppressed.

Docs `40813452487`/`123248922710` pass and are audited. Benchmark job `123248963708`
passes (2 summaries/2 tests). macOS ARM64 ownership `123248963737` passes (127
summaries/359 tests). Intel macOS ownership `123248963419` also passes (127 summaries/359 tests), fully audited. Other five jobs still run; Windows first-step logs are fully
available in `/private/tmp/fwp-225-windows-{arm,amd}-early/windows-native.log`.
Audit their final logs before publishing the batch. Logs of completed jobs are
`/private/tmp/fwp-225-final-*.log`; the regular ARM upload failure remains a failure.
After repair require all nine jobs plus docs at the new head before squash merge;
use one <=80-character subject and empty body, then verify tree/message.

D1 runs independently in `/private/tmp/fwp-ad-refresh`, branch `ad-cost-refresh`,
source `21a1de329c8e4cec1b9ba7cd284c9be876facf5c`; no second PR. All four jobs in
`40816041693` pass and their complete logs/artifacts are audited: six cases, 80
images and 68 stack reports per session, analytic output checks, timing samples,
workspace on/off, phase clocks and broken controls. Two ARM hosts are Neoverse-N2;
AMD sessions are EPYC 7763 and Xeon 6973P-C, so they are not a repeated same-host
baseline. Short-process controls are noisy. Output diagnostic `40818110583` now
runs at the same source. D1 archival/budgets, D2 and D3 remain unfinished.

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
owns raw reports and size/stack costs. Final production is running as listed above;
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
