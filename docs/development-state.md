# PR #225: startup repairs and CPU comparisons

**Next:** publish and run the predecessor-balanced decimal schedule on the first
two qualified jobs per architecture. Position rotation alone left different
preceding workloads for baseline and its identical control; all four interleaved
sessions are retained as an overall rejection. Keep every original limit. Only
accept after both complete sessions on both hosts pass, then run the final matrix.

Worktree `/private/tmp/fwp-cpu-phases`, branch `cpu-execution-costs`, draft
[PR #225](https://github.com/e6qu/fun-with-pipes/pull/225). Published source
`e8a8cb8fefceaa8e955823f3c1d6edb737bf789e` has the same runtime/compiler/native
tests as correctness-tested `9c89a3761cba2c3bccb02dff93b3fec6754f4583`.

| Run | Job | Host/session | Current state |
|---|---|---|---|
| 40806970215 | 123228137999 | ARM64 1 | Complete, audited |
| 40806970215 | 123228138086 | ARM64 2 | Complete, audited |
| 40806970215 | 123228138038 | AMD64 1 | Complete, audited |
| 40807119729 | 123228617759 | AMD64 2 | Complete, audited |

Both other AMD64 allocations rejected EPYC 9V45/other nonmatching hardware before
building/timing. Preserve their records/logs under
`/private/tmp/fwp-interleaved-unqualified-{first,second}`. All four selected jobs completed. The next protocol has not yet been dispatched. Documentation
`40806921690` passed and its log is audited; draft-skipped production is not a gate.

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

## Measurement decisions and retained evidence

[The decimal report](measurements/decimal-count.md) owns the protocol and numbers.

| Experiment/source | Outcome | Retained records |
|---|---|---|
| Bit-length/table, df80c15e | ARM64 qualifies; AMD64 does not; rejected overall | `decimal-count-2026-10-29-*.json` |
| Short threshold tree, 9c89a376 | One noisy control per host; inconclusive | `decimal-tree-2026-10-29-*.json` |
| Longer separate batches, 0c904dc8 | Both ARM64 qualify; both AMD64 inconclusive | `decimal-long-2026-10-29-*.json` |
| Position interleaving, e8a8cb8f | AMD64 qualifies; ARM64 text controls fail | `decimal-interleaved-2026-10-29-*.json` |

Longer source is `0c904dc859439a8a6e31e7bdf30c87ca69821de7`. Runs
`40804467873`, `40804655433`, and attempt 4 of `40805067812` supply four complete
sessions. All logs, raw samples, seven paired programs, 21 peers and 14 storage
images per session are independently audited. The archive includes seven actual
hardware rejections and exact job metadata. GitHub copies unchanged sibling status
on retry with a new ID but identical runner/timestamps: those are not new executions.
The permanent reader and a negative control reject such duplicate evidence.

Longer separate batches did not fix AMD64 variation. Position interleaving passes
AMD64 but fails both ARM64 text controls (1.071585/1.069806 versus 1.025422).
Actual sequence review finds baseline follows Rust 7,680 times, C 1,908 times,
control 12 times; its identical control instead follows candidate 7,680 times,
baseline 1,908 times, Rust 12 times. Positions were balanced; preceding work was
not. This is a concrete harness imbalance, not proof of a hardware mechanism.
All interleaved logs/artifacts are audited and permanently archived, with two
host rejections. Never combine passing results from different protocols.

The prospective `decimal-count-balanced` protocol uses a 25-execution cycle with
every ordered predecessor/current pair exactly once. Repeat twice for loop and
32 times for text (ten/160 processes per variant/sample). Rotate the cycle over
75 samples (all 25 positions three times), plus two warmups. One transition at
a rotated sample boundary can differ; it is retained and bounded by a test.
All numerical limits and first-two independent job selection remain unchanged.
Compiler/runtime/native tests still match 9c89 exactly; focused arithmetic is
not repeated. Full production gates remain required.

## Checks and pending publication

Nine guarded Python control groups pass, including order, missing data, noise,
job selection, copied retry-status rejection, and complete cycle/position balance. Both short archives verify with
unchanged decisions. Both complete long/interleaved archives verify `accepted: false`.
Actionlint, Rustfmt, small Clang helper/control tests and the documentation audit
pass. The Clang checks do not substitute for GCC or final native production gates.

The next grouped push includes all long/interleaved reports and archives, their
CI verifiers, source/job identity controls and the new balanced schedule. Full
final-head production CI has not started. After the measurement decision, finish
the report/plan, publish once and run all nine jobs plus docs. Audit all targets
and diagnostics, repair failures, then squash with one <=80-character line and
empty body. Verify the merged tree/message and continue to D1–D3.

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

Raw files: `/private/tmp/fwp-{long,tree,decimal}-{arm,amd}*`, corresponding `.log`
files, phase/startup folders and `/private/tmp/fwp-224-final-*.log`. Audit helpers:
`fwp-audit-production-log.py`, `fwp-audit-{long,interleaved}-artifacts.py`,
`fwp-read-tree-result.py`, `fwp-archive-decimal-repeat.py`, all in `/private/tmp`.
The archive helper takes an explicit manifest, prefix, source and protocol.

The primary checkout is detached at #209: preserve its recovery pointer and
untracked `docs/measurements/compiler-abort.md`. The historical Intel compiler
abort remains unexplained. No local full builds/suites/benchmarks. Use the guard
serially with 64 GiB free disk, 2 GiB target, 1 GiB RSS and 180 seconds; current
disk is about 73 GiB free. Final matrix and compliant merge remain authorized.
