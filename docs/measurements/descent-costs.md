# Current costs of automatic derivatives

Current-source sessions measure derivative costs and timing reliability. These
are baselines, not an optimization result. They refresh the [older comparisons](descent-peers.md)
without requiring an earlier fwp executable or generated-C archive. D1 is still
incomplete: repeated-process groups now use matching hosts, but short-case noise
and fixed comparison budgets remain. The
[output diagnostic](descent-output-current.md) is also refreshed; the plan names
a scalar recording-argument candidate to prove and measure after those limits.

## Initial single-process results

For the largest case, 129 coordinates and 199 updates, each process prints its
final vector. These are median milliseconds for the complete process; smaller is
better. All six inputs and all timing samples remain in the linked reports.

| Host/session | AD history | AD current | Explicit list | Packed fwp | C | Rust |
|---|---:|---:|---:|---:|---:|---:|
| Neoverse-N2 1 | 39.709 | 38.807 | 5.829 | 1.874 | 1.051 | 1.199 |
| Neoverse-N2 2 | 39.417 | 38.612 | 5.596 | 1.683 | 0.869 | 1.017 |
| EPYC 7763 | 41.863 | 40.827 | 7.128 | 3.015 | 1.144 | 1.383 |
| Xeon 6973P-C | 28.834 | 27.873 | 4.713 | 1.488 | 0.707 | 0.826 |

AD-current takes 35.7–44.4 times C's time here; packed fwp takes 1.78–2.64 times
C's time. These ratios compare different amounts of work: C and packed fwp use
explicit derivative formulas, while AD records and reverses operations. They
are not isolated compiler overhead. The two AMD64 sessions use different CPU
models and cannot establish a repeated same-host budget. Short-case controls
also vary: on Xeon, identical AD-current images differ by about 9.8% at 3
coordinates/199 updates. Keep those observations; no speedup is accepted here.

Memory observations agree across all four hosts for this largest case:

| fwp form | Managed allocation requests | Retains | Peak managed charge |
|---|---:|---:|---:|
| AD history | 1,104,186 | 868,638 | 845,424 bytes |
| AD current | 1,103,785 | 868,237 | 26,288 bytes |
| Explicit list | 206,891 | 51,342 | 21,824 bytes |
| Explicit packed | 200 | 0 | 4,352 bytes |

Keeping only current weights greatly reduces live storage, but leaves most
allocation/counting work. AD-current requests 31,360,398 managed bytes over the
whole run. Its separate raw derivative buffers peak at 33,904 bytes; parent and
weight buffers grow five times, then are reused across updates. All observed
managed/raw storage is released at shutdown. Raw and managed observations are
different counters; neither is whole-process resident memory, which is recorded
separately. The existing workspace already avoids per-update raw buffer allocation.

The diagnostic clocks put about 34.56 ms in forward-with-recording on Neoverse-N2
session 1, versus 0.40 ms in reverse traversal. Forward includes objective
arithmetic and temporary collection/value construction; this does not attribute
that time solely to tape appends. The clocks perturb execution: paired
instrumented/ordinary timings, including both faster and slower observations,
are retained. Investigate the temporary values around recording before assuming
larger raw-buffer caches will help; D2 first targets the heap record passed to scalar `ad.push`; its lifetime proof and fixed comparison limits remain.

## Retained evidence

Source `21a1de329c8e4cec1b9ba7cd284c9be876facf5c`,
[run 40816041693](https://github.com/e6qu/fun-with-pipes/actions/runs/40816041693).
All four full job logs and artifacts were audited: 80 native images and 68 GCC
stack reports per session, all outputs/samples, workspace-on/off profiles,
phase sequences and both broken controls. These focused jobs are not the full
production gate for a future implementation.

The [archive index](descent-baseline-artifacts-2026-10-29.json) retains complete
job identities, every artifact file hash, instruction-section sizes and controls.
Exact JSON reports and complete logs are losslessly compressed:

| Session | Report | Job log |
|---|---|---|
| ARM 1 | [JSON](descent-baseline-2026-10-29-arm-1.json.gz) | [Log](descent-baseline-2026-10-29-arm-1.log.gz) |
| ARM 2 | [JSON](descent-baseline-2026-10-29-arm-2.json.gz) | [Log](descent-baseline-2026-10-29-arm-2.log.gz) |
| AMD 1 | [JSON](descent-baseline-2026-10-29-amd-1.json.gz) | [Log](descent-baseline-2026-10-29-amd-1.log.gz) |
| AMD 2 | [JSON](descent-baseline-2026-10-29-amd-2.json.gz) | [Log](descent-baseline-2026-10-29-amd-2.log.gz) |

For example, `gzip -dc docs/measurements/descent-baseline-2026-10-29-arm-1.json.gz`
prints the original report. The archive verifier checks original byte hashes,
samples, ratios, cleanup, phase completeness and distinct job executions:

```sh
python3 scripts/local-guard.py python3 scripts/check-descent-baselines.py \
  --archive docs/measurements/descent-baseline-artifacts-2026-10-29.json
```

## What the programs compute

Rosenbrock's function penalizes each adjacent pair of coordinates `x, y` by
`100 * (y - x*x)^2 + (1 - x)^2`. A derivative tells us how that sum changes when
one coordinate changes. Each update subtracts `0.001 * derivative` from every
coordinate. Initial coordinates alternate -1.2 and 1.0. The output is the complete
final vector; all entries must be finite.

The six existing cases are 3 coordinates with 0, 1, 199 and 1,999 updates, and
33 or 129 coordinates with 199 updates. An update means one derivative evaluation
and one new vector. The history implementation therefore stores `updates + 1`
vectors, including the initial one. Zero updates still construct and print the
initial vector; it is not a measurement of process startup alone.

| Program | Derivative calculation | Storage during descent |
|---|---|---|
| fwp AD, history | Record local derivatives, then traverse them in reverse | Immutable lists; retain every vector until the final selection |
| fwp AD, current | Same automatic derivative | Immutable lists; retain only current weights |
| fwp explicit list | Handwritten formula | Immutable lists and intermediate list/pair values |
| fwp explicit packed | Handwritten formula | One new packed array per update; reads previous array |
| C explicit | Handwritten formula | Two reused contiguous buffers |
| Rust explicit | Handwritten formula | Two reused contiguous buffers |

A seventh timing label runs an exact copy of the fwp AD-current executable.
It checks whether execution order or host variation changes the measured time
of identical code. It is not another implementation.

C/Rust do not implement general automatic differentiation. Ratios against them
include recording and reverse traversal, collection representation, allocation,
formatting and runtime startup/teardown. The packed fwp formula may recompute an
edge residual while C/Rust compute it once and add to two coordinates. Explain
these differences; do not label the entire ratio “compiler overhead.”

## Original measurements and controls

Build every program from current source in the same native Linux job on ARM64 or
AMD64. Use GCC O2, no fast math, `-ffp-contract=off`, no LTO, an explicit baseline
architecture and stack-usage output. Rust uses opt-level 2, checked arithmetic,
one codegen unit, generic CPU and no LTO. Record actual CPU, available processors,
compiler versions, flags, source hashes and executable hashes.

Run two warmups and 56 measured rounds. Each fourteen-round block balances every
position and ordered adjacent pair within its seven-entry rows, using the
existing Williams schedule and explicit seed 20261029. Cross-round boundaries
are not exactly balanced; retain every actual order. Use a 180-second timeout
per process and preserve incomplete results and diagnostics if a command fails.
Collect two independent sessions per architecture. These establish new descent
baselines; they do not change the CPU-counting budgets or claim a speedup.

Check each fwp program against its raw interpreter output, and all implementations
against the independent Python analytic derivative with absolute and relative
tolerance 1e-10. Each implementation's timed output must repeat exactly. Preserve
all samples and slow/noisy cases. Report medians and identical-code variation
separately for each case and session; do not pool hosts or select quieter runs.

Timing includes fresh-process launch, input construction, every update, complete
output and teardown. Compilation and observers are separate. Record generated C,
actual native image identities, instruction/file sizes and GCC stack estimates.
Do not infer memory safety from an instruction listing.

For each fwp form, separately observe managed allocation requests/bytes, retains,
peak/live charge, and raw derivative registry/parent/weight/adjoint storage.
Verify each backward traversal retires its tape, idle workspace is bounded by
512 KiB, and physical raw storage is zero after shutdown. Compare enabled and
disabled workspace reuse with explicit settings. Keep leak and omitted-observation
controls; instrumentation must not be used as ordinary execution timing.

## Matched-host grouped processes

A second experiment kept the same programs, inputs, compiler settings and output
checks, but grouped complete processes into each sample. Its results stay
separate from the original 56 single-process rounds above.

Before building, require Linux, four available processors and one of these exact
host/toolchain pairs: Neoverse-N2 with GCC 13.3.0 (Ubuntu
13.3.0-6ubuntu2~24.04.1), or EPYC 7763 with GCC 15.2.0 (Ubuntu 15.2.0-16ubuntu1).
Both use Rust 1.99.1, commit `58cf8f9c3`. Save qualification results even when the
CPU or compiler differs; such a job stops before compiling or timing. Collect
two independent qualified sessions per architecture and retain every rejected
host. Select the first two qualified sessions by run/job ID, before reading their
timings. No result is discarded because it is noisy or slow.

Each measured sample sums several complete fresh-process times per label:

| Coordinates | Updates | Processes per label per sample |
|---|---:|---:|
| 3 | 0 or 1 | 42 |
| 3 | 199 | 21 |
| 3 | 1,999 | 7 |
| 33 or 129 | 199 | 7 |

For example, a 3-coordinate/199-update sample runs each of the seven labels 21
times. Its AD-current total includes 21 launches, solves, complete outputs and
shutdowns. Divide that total by 21 when reporting time per solve; it does not
amortize startup inside one process. Grouping reduces the influence of an
isolated scheduling delay without dropping that observation.

Run two warmup rounds and 98 measured rounds, seed 20261029. A 49-entry cycle
contains every ordered pair of labels, including a label following itself.
Repeat it to reach the stated process count, rotating the start by one entry
per round. Across 49 rounds each label occupies each position equally often.
Actual round boundaries are also saved; they replace a cyclic edge and are not
claimed to make the entire flattened order perfectly balanced.

Save each process's time, exit status and checked output hashes, along with its
round's exact order and per-label totals. Keep the expected stdout files.
File writes and output checks happen outside process timing. Wrong output saves
the actual bytes and fails; an interrupted round retains its completed process
observations and is marked incomplete. No partial round becomes a valid sample.
The separate 12-round phase diagnostic and allocation/cleanup controls stay as
specified above.

Source `b1ca235415d4d2caabdb4f568d9300cf50a59400`,
[run 40822958582](https://github.com/e6qu/fun-with-pipes/actions/runs/40822958582),
completed all four matching-host sessions. All 80 images, 68 stack reports and
every process observation were audited per session. The
[archive index](descent-groups-artifacts-2026-10-29.json) identifies all 4,628
original artifact files and links losslessly compressed reports and job logs.

Grouping fresh processes did **not** resolve the short-case noise. The table
retains the range across all four sessions. A ratio of 1 means identical-code
medians agree. Paired P95 is the 95th percentile of the larger of a round's
ratio and its reciprocal; it describes variation, not a confidence interval.

| Coordinates:updates | Identical median ratio range | Largest paired P95 |
|---|---:|---:|
| 3:0 | 0.972486–0.991166 | 1.238130 |
| 3:1 | 0.970672–1.010967 | 1.249295 |
| 3:199 | 1.026767–1.061122 | 1.250575 |
| 3:1,999 | 1.000080–1.011026 | 1.159583 |
| 33:199 | 1.003150–1.037663 | 1.162780 |
| 129:199 | 0.993619–1.000104 | 1.065271 |

The largest AD-current case takes 38.96–39.03 ms on ARM64 and 41.67–41.80 ms on
AMD64 per complete process. All four still request 1,103,785 managed allocations
and perform 868,237 retains. No derivative optimization is accepted from these
measurements. The timing limits remain unset; the noisier cases are not omitted.

## Repeating solves within one process

The next experiment removes repeated startup from each solve. It retains the
same six implementations, seven timing labels, host qualification, compiler
settings, analytic output checks and all original standalone measurements.
Each independent solve starts from the original vector, performs the stated
updates, prints the complete vector and releases its temporary values.

| Coordinates:updates | Solves per process |
|---|---:|
| 3:0 | 32,768 |
| 3:1 | 512 |
| 3:199 | 32 |
| 3:1,999 | 4 |
| 33:199 | 32 |
| 129:199 | 8 |

fwp repeats its source pipeline with `range | each`; C/Rust repeat their complete
workload functions, including input/gradient allocation and release. Runtime and
constant initialization happen once. Dividing time by the solve count gives an
amortized cost, not standalone startup or pure arithmetic time. Loop/dispatch,
formatting and language-specific collection costs remain included.

Use seven fresh processes per label per sample, two warmup rounds and 98 measured
rounds, with the same 49-entry balanced cycle and seed. Every output line must
match the implementation's checked reference; all coordinates also pass the
analytic tolerance. Keep observer timings separate. Check managed cleanup,
every derivative retirement, bounded idle raw workspace and physical release at
shutdown. The largest update count stays within the observer's existing 8,192
checkpoints; no observation limit is raised or disabled.

Use the existing 2% identical-median criterion when judging timing reliability;
report paired tails as well. Retain every result if this protocol is also noisy.
Publish per-case timing/noise limits, allocation counts and code/stack bounds
before changing the `ad.push` contract. No contract is changed during preparation.

## Separating costs before selecting D2

1. Compare AD-history and AD-current to quantify retaining old vectors. Compare
   explicit list/packed forms to expose representation costs, retaining their
   different arithmetic work in the explanation.
2. In a separate diagnostic image, time tape setup, forward work with recording,
   reverse setup/traversal, derivative-result construction and retirement. Forward
   time includes the objective and collection work; it is not pure append cost.
   Record operation counts and allocation changes at these boundaries. Compare
   this image with ordinary execution in 12 alternating paired rounds after two
   warmups to show the observer's own effect. Very
   short phases may round to zero at the host clock's resolution; do not treat
   that as zero computation cost.
3. Preserve the [refreshed output diagnostic](descent-output-current.md) for
   packed fwp and C/Rust: full vector formatting versus a shared checksum consumer,
   with exact result bits verified separately. Four audited sessions retain their
   inconclusive short controls. Do not call zero-update time “output cost.”
4. Select D2 only after these observations identify a removable cost. Write its
   per-size storage/time limits before measuring a candidate. Preserve failure,
   cancellation and nested-scope cleanup; recomputation may replay only pure work.
5. D3 checks F64/F128 analytic and numerical derivatives, nesting, branch-domain
   boundaries and checkpointed work. State tolerances and domains explicitly;
   neither derivatives at discontinuities nor constant storage for arbitrary AD
   are promised.

The [implementation plan](../../PLAN.md#5-differentiation) owns acceptance and
[the handoff](../development-state.md) owns the current action. D1 remains open until its remaining measurements and fixed budgets are complete.
