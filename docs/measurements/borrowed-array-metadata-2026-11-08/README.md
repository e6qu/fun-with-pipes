# Borrowed array metadata: target missed

Caching array addresses and lengths does **not** meet milestone 1's 10%
computation-time target. All ARM64 nontrivial cases fall short; most AMD64 cases
fail the identical-copy control and are inconclusive. Do not repeat these
unchanged timings for a pass or present this candidate as an accepted speedup.

## Comparison

Both compilers use `f227830b08ff115f7b0711274545d6685b4be0be`. The reference
disables only selection of cached metadata for borrowed array callbacks.
Representation, arithmetic, bounds checks and ownership are otherwise identical.
The [contract](../shared-loop-array-costs.md#computation-time-comparison) gives
all 18 inputs, repeat counts, flags, timers and output oracles.

- Two sessions each on native Neoverse-N2/GCC 13.3 and EPYC 7763/GCC 15.2.
- Two warmups, then 24 rotated rounds of candidate/reference and identical copies.
- Computation timing surrounds the ordinary consuming function; input construction,
  result checking/release and printing are outside it. Internal allocation and
  cleanup remain inside. Whole-process time is recorded separately.
- This compares two fwp implementations. It is not a C/Rust/Swift comparison.

## Computation results

Negative means less elapsed time. `*` means an identical-copy ratio exceeds 1.02:
the displayed difference is an observation, not a qualified gain or regression.

| Case | ARM1 | ARM2 | AMD1 | AMD2 |
|---|---:|---:|---:|---:|
| loop-0 | -0.12% | +0.10% | +0.27% | -0.07% |
| loop-16 | +0.40% | +0.20% | +0.16%* | -1.76%* |
| loop-1000000 | +0.05% | +0.02% | +0.49% | -0.71%* |
| loop-100000000 | +0.09% | +0.02% | +0.04% | -0.39% |
| array-0 | -0.15% | -0.55%* | -5.65%* | -0.54%* |
| array-16 | -1.27% | -1.26% | -2.84%* | +0.42%* |
| array-65537 | -0.59% | -1.29% | +0.39% | +10.89%* |
| array-262145 | -1.27% | -0.76% | +3.32%* | -1.36%* |
| manual-3-0 | +0.17% | -0.99% | +2.95%* | +0.43%* |
| manual-3-1 | -1.97% | -0.71% | -21.19%* | -9.54%* |
| manual-3-199 | -2.27% | -2.23% | +6.20%* | +0.33%* |
| manual-33-199 | -3.60% | -4.78% | -5.97%* | -37.30%* |
| manual-129-199 | -2.70% | -3.65% | +82.16%* | -4.94%* |
| local-3-0 | -0.09% | -0.44% | -1.73%* | +0.94%* |
| local-3-1 | -2.05% | -1.85% | +2.76%* | +0.33%* |
| local-3-199 | -0.46% | -0.47% | +55.46%* | +3.98%* |
| local-33-199 | +0.01% | +0.42% | -2.40%* | -5.95%* |
| local-129-199 | -0.86% | -1.22% | -3.45%* | +1.09%* |

`array-N` maps and folds N values. `manual-N-U` and `local-N-U` perform U
neighboring-coordinate updates on N values using handwritten and local automatic
derivatives. Each process performs the contract's stated repetitions.

Computation copy failures per session are 0, 1, 14 and 16; process copy failures
are 6, 1, 13 and 15. All qualified computation comparisons stay within the 2%
regression guard, but none supplies the required two-input, four-session speed
gain. The cause of the AMD64 variation is not established.

## Verification and retained evidence

[Producer run 42435795842](https://github.com/e6qu/fun-with-pipes/actions/runs/42435795842)
completes all four sessions. Its safety prerequisite passes GCC ARM64/AMD64 and
Clang ARM64; a separate complete audit verifies those native test artifacts.
[Timing audit job 128598127188](https://github.com/e6qu/fun-with-pipes/actions/runs/42437082841/job/128598127188)
checks all 18 cases and 1,994 recorded commands per session, reference isolation,
driver/source equality, image architecture/hashes, identical copies, raw samples,
output bits and unchanged final live managed storage. Its success verifies the
observations, not the performance target.

[summary.json](summary.json) retains medians, ratios, copy decisions, host settings
and source/artifact identities. [observations.zip](observations.zip) contains the
four full producer logs, raw sample/command records, outputs, stack reports and
reference patches. Large generated sources and native images remain in the
original GitHub artifacts identified by the summary.

Audit artifact `13600670203` is 1,446,979 bytes, SHA-256
`6df40a804073a96bc3d5b9ef16bb21ebf6aa228a43746634413880f7787cd779`.
[Artifact metadata](artifact.json), outer digest, ZIP integrity and all four
report/source identities pass guarded local verification (0.12 s).
Allocation, RSS and compiler-cost acceptance are not established by this report.
