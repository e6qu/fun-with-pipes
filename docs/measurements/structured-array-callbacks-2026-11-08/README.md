# Known array callbacks: complete-gradient costs

The compiler removes temporary derivative inputs when an array callback's
mathematical function is known. Both ARM64 sessions meet the primary speed
target: about **91% less computation for neighboring pairs and 85% less for
independent losses**. AMD64 observations show large reductions too, but fail
the frozen identical-copy noise limit. **Combined timing acceptance stays open.**

This compares fwp before and after the compiler change, not fwp against C,
Rust or Swift. The [contract](../structured-autodiff.md#selected-change-known-array-callbacks)
predates implementation. No limit was relaxed and no unchanged session rerun.

## Work and verification

- Baseline: `04ddc0ac5d296ec895364236c4120341d7328e41`.
- Candidate: `4a32c102f74f738433c1d55969936b023a5510f0`.
- Retention tags: `roadmap/structured-gradient-baseline-2026-11-08` and
  `roadmap/structured-gradient-candidate-2026-11-08`; both survive squash merge.
- [Measurement run](https://github.com/e6qu/fun-with-pipes/actions/runs/42510222540):
  all four jobs, source/binary audits and evidence-rejection controls pass.
- [Focused safety run](https://github.com/e6qu/fun-with-pipes/actions/runs/42508330680):
  GCC Linux ARM64/AMD64 and Clang macOS ARM64 pass. Its source differs only in
  the handoff. Checks cover values, input aliases, evaluation/trap order,
  cleanup, unknown callbacks, nested differentiation and F128.

Each process computes 256 entire gradients, including conversions and result
assembly. Inputs are runtime data; analytic derivatives only check results.
Construction, computation, release and whole-process time are separate.
Two warmups precede 24 rotated rounds of baseline/candidate and their identical
copies. Timing uses ordinary binaries on one pinned CPU. Instrumented storage,
compiler and process-RSS measurements run separately in session 1.

Both ARM hosts are Neoverse-N2. AMD session 1 is EPYC 7763; session 2 is EPYC
9V45. Do not pool these models. Rust is 1.99.1; GCC is 13.3.0 on ARM and 15.2.0
on AMD. Generated C uses strict O2, no contraction, fast math or LTO, and the
`armv8-a`/`x86-64` baselines. Each identity JSON records every setting.

## Computation time

Ratios are candidate/baseline, paired by round; 0.10 means 90% less time.
Intervals are the contract's paired 95% bootstrap intervals. Both primary
cases require an upper bound at most 0.90 in every session and passing copy
controls. Identical executables must agree within the frozen 2% limit.

| Session | Neighbors, 129 inputs | Independent, 129 inputs | Primary timing accepted? |
|---|---|---|---|
| ARM 1 | 0.0898 [0.0890, 0.0908] | 0.1489 [0.1475, 0.1510] | Yes |
| ARM 2 | 0.0894 [0.0886, 0.0911] | 0.1479 [0.1470, 0.1497] | Yes |
| AMD 1 | 0.0796 [0.0772, 0.0897] | 0.1447 [0.1322, 0.1471] | No: both copy controls fail |
| AMD 2 | 0.0843 [0.0830, 0.0938] | 0.1547 [0.1394, 0.1782] | No: both copy controls fail |

For context, ARM session 1's neighboring computation falls from 20.01 to
1.79 microseconds per gradient; independent computation falls from 8.88 to
1.31 microseconds. Whole-process medians, divided by 256 gradients, fall from
28.77 to 10.71 and 17.84 to 10.24 microseconds respectively. These latter numbers
include construction, checking, release, process startup and shutdown; they are
descriptive medians, not an independently qualified process-speed claim.

All 14 ARM cases pass copy controls. Seven AMD session 1 cases and five AMD
session 2 cases fail them. Primary candidate-copy ratios are 0.9707/1.0329 in
AMD 1 and 1.0473/1.0230 in AMD 2. Every observation remains in the adjacent
samples and summaries. No guard establishes a qualified regression above 2%;
inconclusive guard results do not prove equivalence.

## Allocation and live storage

Both architectures report these per-gradient counts, with workspace reuse both
on and off. Counts include the driver's input lists, result lists and arrays.

| Case | Baseline requests | Candidate requests | Managed peak bytes, before → after |
|---|---:|---:|---:|
| Neighbors 0 / 1 | 2 / 4 | 2 / 4 | 32 / 80, unchanged |
| Neighbors 3 | 24 | 8 | 256 → 224 |
| Neighbors 33 | 324 | 68 | 2,432 → 2,432 |
| Neighbors 129 | 1,284 | 260 | 9,536 → 9,536 |
| Independent 0 / 1 | 2 / 6 | 2 / 4 | 32 / 96 → 32 / 80 |
| Independent 16 | 66 | 34 | 1,168 → 1,168 |
| Independent 129 | 518 | 260 | 9,536 → 9,536 |

All positive local cases meet `2*n + 2`. At 129 inputs, requested bytes per
gradient fall from 32,848 to 8,272 for neighbors and 14,464 to 8,272 for
independent loss. Actual reference-count increments remain one per call for the
shared input; attempted retain calls fall from 258/260 respectively to two.
Attempted operations and actual count changes are separate metrics.

The remaining 260 requests are 129 input-list cells, 129 result-list cells and
two arrays. This comparison deliberately keeps list inputs/results equivalent
across methods. Removing those containers would require a different representation
or eliminating conversions across a larger caller; it is a separate experiment.
At ARM session 1's 129-input size, release takes about 2.15–2.19 microseconds,
already longer than the candidate computation. Fewer derivative objects do not
make data construction and release free.

Local methods use no raw derivative-recording storage. All measured managed
owners return to baseline and raw buffers reach zero after real shutdown.
Dense forward mode's cached constant retains its ordinary process lifetime;
it is released at constant shutdown. No peak increases; unchanged reverse/dense
methods retain their previous counts. Charged managed bytes exclude common
runtime initialization and are not process RSS.

## Compiler, stack and representation costs

Generated neighboring calls pass four C doubles to `w5`; independent calls
pass two to `w7`. They return numeric fields directly. The array call sites
use those known workers, preserving checked reads and cleanup scopes. Heap
derivative input records disappear from these paths; generic entries elsewhere
are not a promise of universal allocation-free calls.

| Session / primary case | fwp compilation ms, before → after | C compilation ms, before → after | Entry frame bytes | Native image bytes |
|---|---:|---:|---:|---:|
| ARM 1 neighbors | 337.84 → 338.05 | 1,973.16 → 1,867.37 | 784 → 304 | 149,168 → 148,128 |
| ARM 1 independent | 327.28 → 328.69 | 1,950.07 → 1,886.03 | 432 → 352 | 148,784 → 147,920 |
| AMD 1 neighbors | 353.68 → 366.29 | 2,236.66 → 2,096.50 | 880 → 288 | 131,536 → 126,352 |
| AMD 1 independent | 343.21 → 351.08 | 2,129.47 → 2,089.25 | 432 → 352 | 126,992 → 126,144 |

These are single compile observations, not a compiler-speed acceptance study.
AMD neighboring fwp compilation increases 3.6%; the C stage decreases. fwp
compiler peak RSS changes by at most 444 KiB across these four comparisons;
C compiler peak RSS decreases. Driver main frames remain unchanged. Individual
frames do not establish total call-stack use. Existing worker-size, recursion
and expansion budgets remain unchanged and have focused regression checks.

Process peak RSS observations, in KiB: neighboring ARM 1,928 → 1,536; AMD
2,260 → 1,864; independent ARM 1,604 → 1,600; AMD 1,864 → 1,928. The last
increase is retained. These single process observations include startup and
allocator behavior; they do not change the exact managed-storage accounting.

## Evidence and remaining acceptance

Adjacent JSON retains all timing samples, identities, complete summaries,
storage/compiler observations, audit results and rejected-fault receipts. Logs
are complete gzip copies. `images/` retains both primary generated C sources,
actual baseline/candidate binaries and compiler stack reports for both native
architectures. Files were read directly from the original ZIP entries with CRC
verification; [artifacts.json](artifacts.json) records GitHub's archive digests
and download URLs. Full archives, including every auxiliary command/output,
remain attached to the measurement run; no local whole-archive digest check is
claimed. Local disk was below the 64 GiB reserve, so inspection used small HTTP
range reads rather than full downloads or local execution.

The runner audit reconstructs all sources, commands, samples, summaries and
native images. It rejects missing samples, changed arithmetic policy, wrong
architecture, invented ratios and, in session 1, unreleased storage.
The documentation job also runs `scripts/check-structured-callback-report.py`
against these saved samples, storage records, image hashes and stack reports;
it preserves the original failed timing qualifications.

The allocation/cleanup requirements and ARM timing targets pass. AMD timing
acceptance stays open under the original rule. Full final-head production,
documentation and complete-log audits remain required before delivery.
