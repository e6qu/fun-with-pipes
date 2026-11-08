# Loop, array and derivative computation versus C and Rust

**One native session per architecture.** ARM64's large arrays and checked loop
compare well with these peers. The local derivative helper still costs much
more than an explicit derivative. Most AMD64 array/derivative copy controls
fail, so their ratios remain inconclusive.

## What is compared

| Program | Same work | Differences |
|---|---|---|
| Checked loop | Descend from N; accumulate `(i * 3) % 7`, checking integer arithmetic | Compiler lowering and retained checks |
| Map/fold | Build `x * 3 + 1` in an independent array; sum in order from negative zero; consume the input | fwp's allocator/array owners, C malloc/free, Rust Vec |
| Coordinate updates | Same neighboring-pair objective, initial values, step 0.001 and update count | C/Rust reuse two mutable buffers with an explicit derivative; fwp allocates immutable outputs, with either explicit derivatives (`manual`) or local automatic derivatives (`local`) |

This measures implementation choices as well as compiled arithmetic; it does
not isolate a universal language or ARC tax. The checked loop result also shows
why an older whole-process ratio should not be called a computation overhead.
[The protocol](../shared-loop-array-costs.md#c-and-rust-computation-comparison)
specifies all inputs, expected bits, repeat counts, flags and boundaries.

## Computation time ratios

Each cell is `fwp time / peer time`. For example, 1.124 means 12.4% more time;
0.640 means 36.0% less. `*` means one of that pair's identical-copy controls
exceeded 2%; the ratio is **inconclusive**. Computation includes consumed-input
and intermediate cleanup, but excludes input construction and final-result
release. The full report retains those phases and whole-process observations.

| Input | ARM fwp/C | ARM fwp/Rust | AMD fwp/C | AMD fwp/Rust |
|---|---:|---:|---:|---:|
| loop-0 | 1.001× | 0.976× | 1.060× | 1.012× |
| loop-16 | 0.876× | 0.994× | 1.071×* | 1.029×* |
| loop-1000000 | 0.801× | 0.949× | 1.001× | 1.052× |
| loop-100000000 | 0.819× | 0.951× | 1.002× | 1.045× |
| array-0 | 1.279× | 1.824× | 1.530×* | 1.687×* |
| array-16 | 1.474×* | 1.473×* | 1.558×* | 1.541×* |
| array-65537 | 0.640× | 0.663× | 0.472×* | 0.507×* |
| array-262145 | 0.739× | 0.767× | 0.577×* | 0.623×* |
| manual-3-0 | 1.002× | 0.966× | 1.045× | 0.987× |
| manual-3-1 | 1.396× | 1.114× | 1.976×* | 1.697×* |
| manual-3-199 | 3.102× | 3.111× | 3.525×* | 3.544×* |
| manual-33-199 | 1.330× | 2.497× | 2.357×* | 4.587×* |
| manual-129-199 | 1.124× | 2.257× | 2.101×* | 4.076×* |
| local-3-0 | 1.003× | 0.963× | 1.094×* | 1.029×* |
| local-3-1 | 1.467× | 1.175× | 2.115×* | 1.814×* |
| local-3-199 | 3.548× | 3.563× | 3.436×* | 3.454×* |
| local-33-199 | 2.714×* | 5.035× | 3.146×* | 6.103×* |
| local-129-199 | 2.468× | 4.981× | 2.770×* | 5.372×* |

For the largest ARM case, manual fwp takes about 12% more computation time than
C and 126% more than Rust. Local automatic derivatives take about 147% more than
C and 398% more than Rust. Those are useful-work comparisons; older whole-process
reports include different startup/output shares. No claim of C/Rust parity for
general autodiff follows from faster array construction.

All implementations check their own exact result words on every execution.
Loop/map expected words agree exactly. The derivative formulas preserve their
own evaluation order; each fwp result agrees with the independent coordinate
formula to absolute/relative tolerance `1e-10`. Both sets of words are retained.

## Memory and image observations

Separate executions under GNU `time -v` report process peak RSS. These are single
observations, not allocator-call counts or repeated speed measurements. They
include each language's process/runtime/library memory. Do not add RSS to managed
live-storage counts. Whole-file bytes likewise include more than the computation.

| Host / input | fwp RSS KiB | C RSS KiB | Rust RSS KiB | fwp image bytes | C image bytes | Rust image bytes |
|---|---:|---:|---:|---:|---:|---:|
| arm / loop-100000000 | 1772 | 1376 | 1636 | 147400 | 70568 | 4624208 |
| arm / array-262145 | 5496 | 5040 | 5844 | 147920 | 70648 | 4624112 |
| arm / manual-129-199 | 1472 | 1388 | 1620 | 147976 | 70744 | 4623856 |
| arm / local-129-199 | 1404 | 1380 | 1636 | 147968 | 70744 | 4623856 |
| amd / loop-100000000 | 2196 | 1540 | 2040 | 113264 | 16128 | 4546880 |
| amd / array-262145 | 5912 | 5612 | 6260 | 113792 | 16216 | 4547424 |
| amd / manual-129-199 | 1688 | 1544 | 2124 | 117928 | 16216 | 4548640 |
| amd / local-129-199 | 1816 | 1544 | 2252 | 117944 | 16216 | 4548640 |

fwp's [separate instrumentation](../fresh-array-costs-2026-11-08/README.md#memory)
counts zero retains here, but the largest derivative solve requests 200 arrays.
C/Rust's source reuses two buffers; allocator-call and ARC counts for those peers
were not instrumented. Source-level buffer reuse is not a measurement of total
process allocations. Execution time and working memory take priority over size.

## Source and verification

Saved fwp code: `066175c3ad47cf8d226a1dc2b16fba55eba71b7d`.
Comparison/auditor: `a84e8b3ebc5e16c1036a500470e47062d88c3f78`,
[run 42441977298](https://github.com/e6qu/fun-with-pipes/actions/runs/42441977298).
ARM64 uses Neoverse-N2/GCC 13.3; AMD64 uses EPYC 9V74/GCC 15.2. Rust is 1.99.1,
`-O`, generic CPU, no LTO. C/fwp use O2, no fast math or FP contraction, generic
architecture and no LTO. The [full report](summary.json) records exact versions,
flags, host/affinity, source/image hashes and resource observations.

Each host passes all 18 cases and the independent 2,916-command audit, including
156 execution observations per case (2 warmups and 24 rounds, six rotated roles),
exact checksums, copied/native image hashes and recomputed summaries. A passing
audit preserves failed timing controls; it does not establish speed acceptance.

| Host | Raw observations and audit | Original artifact receipt | File hashes | Complete job log |
|---|---|---|---|---|
| ARM64 | [Archive](arm-observations.zip) | [Receipt](arm-artifact.json) | [Manifest](arm-files.json) | [Log](arm.log.gz) |
| AMD64 | [Archive](amd-observations.zip) | [Receipt](amd-artifact.json) | [Manifest](amd-files.json) | [Log](amd.log.gz) |

Original C/Rust sources, native images and the audited input archives remain in
the digest-identified GitHub artifacts. Compact archives retain every new sample,
command, resource report, stack report and summary. No downloaded binary ran
locally. These are single-session peer observations, not a two-session confirmation.
