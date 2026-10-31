# Current cost of printing descent results

Replacing formatted vector output with a shared checksum greatly reduces these
programs' elapsed time. It does not make the remaining work free, and the
subtraction is not pure formatting time: the checksum also does work.

These four sessions refresh the [output protocol](descent-output-protocol.md)
at the same source as the [current derivative baseline](descent-costs.md).
They compare **explicit derivatives**, not automatic differentiation. Each solve
starts from alternating -1.2/1.0 coordinates and performs the stated number of
Rosenbrock updates. fwp uses immutable packed arrays. C/Rust use coordinate-wise
formulas and reuse two buffers. All three link the same separately compiled C
checksum consumer, which reads every final coordinate's exact bits before cleanup.

## Largest case: 129 coordinates, 199 updates

Each process performs 4,096 complete solves. Elapsed time includes input creation,
updates, output/checksum, cleanup and process launch; compilation and memory probes
are separate. Each number below is **fwp time divided by peer time**: 1 means equal
elapsed time, 2 means twice as long. Both full-output and checksum identical-code
controls pass for these rows.

| Host/session | Full / C | Full / Rust | Checksum / C | Checksum / Rust |
|---|---:|---:|---:|---:|
| Neoverse-N2 1 | 7.136 | 8.169 | 1.190 | 1.188 |
| Neoverse-N2 2 | 7.149 | 8.183 | 1.189 | 1.188 |
| EPYC 7763 | 9.439 | 10.201 | 2.017 | 1.855 |
| EPYC 9V45 | 8.960 | 9.762 | 1.548 | 1.578 |

For example, ARM64 checksum fwp takes about 19% longer than C. Full printing
takes about 614–615% longer. fwp prints the shortest decimal representation that
round-trips; C uses `%.17g`, and Rust uses `Display`. Those algorithms and the
programs' allocation/bounds-check differences are part of these ratios.
This table amortizes process launch across repeated solves and uses coordinate-wise
peers; the single-process AD baseline uses edge-wise C/Rust peers. Do not treat
the different ratios as a measured change in compiler performance.

## Keep the inconclusive observations

Each session uses four warmups and 48 samples in a balanced eight-entry order.
The unchanged rule requires each fwp/identical-copy median ratio to differ from
1 by at most 2%. All six inputs and every raw sample remain in the archive.

| Session | Inputs whose checksum control misses that rule |
|---|---|
| Neoverse-N2 1 | 3 coordinates, 1 update |
| Neoverse-N2 2 | None |
| EPYC 7763 | 3 coordinates, 0 or 1 update |
| EPYC 9V45 | 3 coordinates, 1 update |

Full-output controls pass throughout. The short checksum programs remain noisy
even with 32,768 solves per process; their uncertain ratios are not accepted
performance evidence. The AMD64 sessions have different CPU models, so they
cannot be pooled as a repeated same-host baseline. No control limit was relaxed
and no samples were discarded. These diagnostics do not accept a compiler change.

## Correctness and storage

Each implementation's complete coordinates pass an analytic reference with
absolute/relative tolerance 1e-10. Untimed programs expose every result's exact
bits, which independently determine its expected checksum; timed runs repeat
that checksum exactly. fwp full output also matches its raw interpreter.
Omitting a coordinate changes the checksum, and missing-release controls fail
at the first solve rather than waiting for final shutdown.

The fwp observer reports no live managed/raw storage after each solve and no
retains. C/Rust's observers verify release of their two numerical buffers after
each solve; they do not cover formatter/runtime allocations. Whole-process RSS,
allocation counts, actual instruction bytes and GCC stack reports are separate
observations in the archive. Instrumented allocation counts are not a trace of
the timed, uninstrumented executable.

All four job logs and artifacts were audited: 109 measurement images and 60
untimed control images per session, exact bits/checksums, memory observations,
all timing samples and stack records. The actual images pass the current
collector-name absence check. During review, the measurement runner was found
to check an obsolete `fwp_gc_` prefix; it now checks `fwp_heap_`. The independent
artifact audit used the corrected names; this repair changes no timed code.

## Evidence and checks

Runs [40818110583](https://github.com/e6qu/fun-with-pipes/actions/runs/40818110583)
and [40818973752](https://github.com/e6qu/fun-with-pipes/actions/runs/40818973752)
use source `21a1de329c8e4cec1b9ba7cd284c9be876facf5c`.
The [archive index](descent-output-current-artifacts-2026-10-29.json) records
complete job identities, controls and all 5,784 artifact file hashes. Exact reports
and complete logs are compressed losslessly:

| Session | Report | Job log |
|---|---|---|
| ARM 1 | [JSON](descent-output-current-2026-10-29-arm-1.json.gz) | [Log](descent-output-current-2026-10-29-arm-1.log.gz) |
| ARM 2 | [JSON](descent-output-current-2026-10-29-arm-2.json.gz) | [Log](descent-output-current-2026-10-29-arm-2.log.gz) |
| AMD 1 | [JSON](descent-output-current-2026-10-29-amd-1.json.gz) | [Log](descent-output-current-2026-10-29-amd-1.log.gz) |
| AMD 2 | [JSON](descent-output-current-2026-10-29-amd-2.json.gz) | [Log](descent-output-current-2026-10-29-amd-2.log.gz) |

Use `gzip -dc` to read a report. Verify the archive and its original decisions with:

```sh
python3 scripts/local-guard.py python3 scripts/check-descent-output-baselines.py \
  --archive docs/measurements/descent-output-current-artifacts-2026-10-29.json
```

The [plan](../../PLAN.md#8-automatic-differentiation) still requires matched repeated-host
budgets before a D2 candidate is measured. These observations identify work to
investigate; they are not a substitute for the candidate's correctness and timing
comparison.
