# PR #225: CPU repairs and derivative baselines

**Next:** publish this combined batch, then monitor and audit all nine production
jobs plus documentation at its final head; repair any failure before squash merge.
Original run `40813465621` at `18ae46cdbf2fa2cc8b33cee78b86ed9b8a2dce4a` has only
the two Linux jobs still running. Every failed job and every completed job is fully
audited below. Keep those Linux jobs available for audit when they finish; they
cannot replace repaired-head gates. All currently known failures are in this batch.
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
The combined documentation audit passes 176 link sets, 106 immutable preparation
anchors and all eight roadmap rows; all four changed workflows pass actionlint.
The two injected-file controls initially missed macOS temp-path aliases; resolving
the fixture root fixed those tests. No production error was suppressed.

Docs `40813452487`/`123248922710` pass and are audited. Benchmark job `123248963708`
passes (2 summaries/2 tests). macOS ARM64 ownership `123248963737` passes (127
summaries/359 tests). Intel macOS ownership `123248963419` also passes (127 summaries/359 tests), fully audited. Windows AMD64 `123248963703` is fully audited: 202 summaries, 798 passing tests,
exactly the confirmed CRLF failure, no other failed targets or unexpected diagnostics.
Regular Intel macOS `123248963702` passes/audited (132 summaries/619 tests).
Windows ARM64 `123248963929` also finishes with exactly the same 202 summaries,
798 passing tests and one CRLF failure, no other unexpected diagnostics. Only
Linux AMD64/ARM64 remain running; Windows first-step logs are fully
available in `/private/tmp/fwp-225-windows-{arm,amd}-early/windows-native.log`.
Audit the remaining Linux logs when available. Logs of completed jobs are
`/private/tmp/fwp-225-final-*.log`; the regular ARM upload failure remains a failure.
After repair require all nine jobs plus docs at the new head before squash merge;
use one <=80-character subject and empty body, then verify tree/message.

D1 preparation and its archived results are now included in this same PR, applied
from `ad-cost-refresh` commits 21a1/d02b after local repair commit
`2b3e960660a584eb2b12653b3c05ebbe41a1ec12`. This batch includes both that preparation and the completed output archive. Continue implementation here; `/private/tmp/fwp-ad-refresh` is a retained
preparation worktree, not a second delivery. The measured source is remotely
retained as `roadmap/derivative-baseline-21a1de32`.

D1 run `40816041693` at `21a1de329c8e4cec1b9ba7cd284c9be876facf5c` passes all four
jobs; full logs/artifacts are audited (six cases, 80 images, 68 stack reports per
session, analytic outputs, all samples, workspace on/off, clocks and broken
controls). Exact reports/logs are compressed losslessly with 2,228 artifact file
identities. Archive verifier and six rejection controls pass. Both ARM hosts are
Neoverse-N2; AMD sessions are EPYC 7763 and Xeon 6973P-C, so do not pool them as
repeated same-host evidence. Short controls remain noisy. The refreshed
[report](measurements/descent-costs.md) explains ratios, allocations and limits.

Output run `40818110583` passes both jobs and is fully audited: 109 measurement
images and 60 control images per host; every output bit/checksum, cleanup profile,
48 timing rounds and complete log inspected. ARM 3:1 and AMD 3:0/3:1 checksum
controls are inconclusive under the unchanged 2% rule. No observations discarded.
Current collector-name checks pass on actual images; fixed the runner's stale
`fwp_gc_` prefix to `fwp_heap_`. Second run `40818973752` also passes, and both jobs (`123266691377`/`123266691555`)
are fully audited. Its ARM controls pass; AMD 3:1 checksum remains inconclusive.
All four output reports/logs and 5,784 artifact identities are archived. The
archive verifier and five rejection controls pass, including all 16 separate
coordinate-buffer controls per host. AMD output hosts are EPYC 7763 and 9V45;
retain that difference. No runtime change follows from diagnostics alone. D1
matched repeated-host budgets, D2 and D3 remain unfinished. The plan now names
the heap-allocated four-scalar `ad.push` argument as the first candidate to prove
and measure; raw buffers already reuse storage.

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
| 5 | In progress | D1 output and repeated-host budgets, then D2/D3 |
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
