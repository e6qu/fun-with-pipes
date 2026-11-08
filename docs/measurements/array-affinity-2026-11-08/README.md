# CPU placement does not resolve AMD64 array timing variation

Pinning the process to one assigned CPU improves the empty-work control in this
session, but both large arrays still fail the unchanged 2% identical-copy limit.
This does not establish a reliable replacement timing protocol or qualify the
original compiler comparison. Do not repeat these timings for a passing result.

## Experiment

All four roles run **the same saved candidate bytes**, not candidate versus
reference. `all` permits assigned CPUs 0–3; `one` permits CPU 0. Each has an
identical copy. `/usr/bin/taskset` applies the explicit mask. The original inputs
and repetition counts stay unchanged; two warmups precede 24 rotated rounds.
[The predeclared protocol](../shared-loop-array-costs.md#cpu-placement-diagnostic-after-the-production-comparison)
explains the boundaries. No compiler build or source rewrite was performed.

The native host was EPYC 9V45 with four assigned and four visible CPUs. Inner
computation clocks are unchanged. Whole-command time includes GNU `time` and
`taskset`, so it is not the earlier unwrapped process timer. Resource observations
are retained separately from the computation result.

## Results

Variation is `(larger copy median / smaller copy median - 1) × 100`.
At most 2% qualifies. This measures stability, not an optimization speedup.

| Input | All CPUs | One CPU | Outcome |
|---|---:|---:|---|
| loop-100000000 | 0.23% | 0.26% | Both qualify |
| manual-3-0 | 3.86% | 1.40% | Only one CPU qualifies |
| array-65537 | 3.87% | 2.62% | Neither qualifies |
| array-262145 | 6.61% | 5.82% | Neither qualifies |

CPU placement alone is insufficient for these array observations. This experiment
does not distinguish scheduler interference, memory placement, clock behavior or
other causes of the remaining variation. None is claimed as the cause.

## Verification and retained data

[Run 42443629870](https://github.com/e6qu/fun-with-pipes/actions/runs/42443629870),
job `128617878874`, source `c35f211a9`. The input images come from AMD64 session 2
of source `066175c3ad47cf8d226a1dc2b16fba55eba71b7d`.
The [complete audit](audit.json) verifies all four cases, 16 native/copy images
and 416 commands/samples, including explicit masks, exact checksums, final live
storage, resource reports and recomputed summaries.

- [Observations and native images](observations.zip), [full summary](summary.json).
- [Original artifact receipt](artifact.json), [complete job log](job.log.gz).
- [Reproducible auditor](../../../scripts/audit-array-affinity.py), with required
  archive, receipt, compressed baseline, log and output paths. It reads images;
  it does not execute them.

The [initial preflight failure](../fresh-array-costs-2026-11-08/README.md#placement-diagnostic-preflight-repair)
took no measurements. Its repair qualifies assigned CPUs and always retains a
hardware receipt; unknown models and incorrect assignments still fail.
[PLAN.md](../../../PLAN.md) owns acceptance; the AMD64 speed goal remains open.
