# Baselines for the remaining CPU gaps

This is the current B1/P1 work in [the plan](../../PLAN.md). Before changing the
compiler, measure two programs against their checked C/Rust implementations:

| Program | Work in every implementation | Question |
|---|---|---|
| `loop` | Count down from 100,000,000; add `(i * 3) % 7` each step | Does the recorded gap against Rust persist? |
| `text-length` | For 2,000,000 indices, count decimal digits in `i` and `3 * i`, plus one separator | Does the recorded gap against C persist? |

Signed arithmetic is checked in all three. The digit-counting peers avoid string
formatting, matching the work fwp can produce after eliminating temporary text.
[Peer controls](checked-peers.md) test overflow order and allocation failures.
Different generated instructions and runtime startup still contribute to elapsed
time; these are complete-program comparisons, not a universal language tax.

## Collect first, freeze second

The `cpu-baselines` runner suite builds the existing seven-peer comparison and
keeps its binary, output, arithmetic and memory audits. It adds repeated timing
only for the two programs above. Two independent jobs run on each Linux
architecture. Each job uses GCC O2, Rust optimized, counted ownership and no
link-time optimization. Execution explicitly allows all CPUs assigned to the
runner; it does not pin a core or fix CPU frequency. Compiler versions and flags are copied from the build
record, not guessed from the host. No previous fwp executable is needed to build.

Each program gets two warmup batches per variant, then 32 measured batches.
A loop batch contains one process; a character-counting batch contains 32 fresh
processes, each with the original two-million-index input and output check.
Order rotates through C, Rust, fwp and the **same fwp executable** again.
That last variant is the noise control: identical code should take similar time.
Each process timer encloses creation, runtime startup, all work, output and
cleanup. A batch observation sums those process durations. The shorter workload
uses 32 processes because the previous complete-program log has roughly 7 ms
runs with substantial variation; batching reduces that noise without excluding
startup or relaxing a limit. Compilation, JSON writes and memory profiling are
outside the timers. Every process retains its status, output, error output and
duration; each batch also records order, binary hash and its checked sum.

Two stability checks are fixed before the run:

- The ratio between the two fwp medians must be at most 1.03.
- For each round, divide the longer identical-code time by the shorter. The
  nearest-rank 95th percentile of these ratios must be at most 1.10. This catches
  large variation that a ratio of medians could hide.

These are measurement-quality limits, not claims that every program may regress
by 3% or 10%. An unstable session is **inconclusive** and cannot set a budget.
Keep the failed observations and repair the measurement before proceeding.

[`cpu-baselines.py`](../../scripts/cpu-baselines.py) freezes a table only when two matching
sessions per architecture are complete and stable. Each selected pair must use
the same CPU model, compiler versions, settings and source inputs. For each
program/host, let `d` be the larger session's 95th-percentile control deviation
from 1. The future candidate/baseline median ratio may be at most `1 + 2d`, and
its new identical-code control must stay within `1 + d`. For example, observed
control variation of 1.2% gives a 2.4% regression limit. These thresholds are
chosen from baseline evidence and committed **before** a candidate is measured;
they are never silently recomputed from candidate results. A claimed speedup
also needs a ratio below the reciprocal, `1 / (1 + 2d)`. Results inside this band
do not distinguish a gain from control variation, even if they pass the regression
limit. This is an empirical decision rule, not a statistical confidence guarantee.

Future speedup claims need baseline and candidate executions in the same job.
The two independent sessions establish repeatability and limits; comparing their
wall times directly does not isolate a compiler change. A changed CPU model or
benchmark contract requires a new, explicitly reviewed baseline.

## Memory and retained evidence

Three separate runs of each actual executable record peak process RSS. Separate
instrumented fwp binaries record managed allocation requests, requested bytes,
retains, peak managed charge and final charge. An injected leak must be detected.
These counts exclude raw runtime buffers, stacks and C/Rust allocation counts.
Instrumented images are never timed. Their compiler stack reports are retained,
but do not describe the uninstrumented executable's frame sizes. Actual timed
text sizes, binary hashes and source hashes remain linked to their original audit.

The reader rejects missing samples, changed order/output/status, false statistics,
changed binaries, duplicate sessions, different inputs/toolchains, missing memory
or stack records, and hidden inconclusive controls. Synthetic corruption tests
run in the documentation gate. The `verify` command recomputes a frozen table
from every original record and rejects changed limits; it never rewrites the
table. Full platform tests remain separate acceptance
requirements; a baseline record is not a correctness test of all fwp programs.

## Status

Run `40765920239` at `ec03d9cd81c001bf006a73e7dbfb044155884611` passes all
four collection jobs and their binary/memory audits. Independent review verifies
every process result against arithmetic formulas, sample order/sums, source and
binary hashes, native ELF text sizes, memory observations and stack records.
Both ARM64 sessions use Neoverse-N2. AMD64 session 1 uses Intel Xeon 8370C,
while session 2 uses AMD EPYC 7763. The freeze command correctly rejects that
AMD64 pair: two architectures alone do not establish repeated named-host data.

The two supplementary jobs in [run 40768027818](https://github.com/e6qu/fun-with-pipes/actions/runs/40768027818)
also pass and are independently audited. Session 1 repeats EPYC 7763; session 2
uses EPYC 9V74. The selector orders jobs by workflow run and session label,
then chooses the first repeated CPU model, regardless of speed or noise.
It therefore selects the two Neoverse-N2 sessions and the two EPYC 7763 sessions.
The Xeon and EPYC 9V74 observations remain in the table as additional sessions.
A noisy selected pair cannot be replaced with a later stable one. Job identity
includes workflow run, architecture and session label; labels alone restart.

The [frozen table](cpu-budgets-2026-10-28.json) records all six original file
hashes. The documentation gate recomputes the table and rejects changed limits.
All measurements use `ec03d9cd81c001bf006a73e7dbfb044155884611`; subsequent changes
add evidence, reader checks and docs, without changing the measured compiler or
collection routine. All nine final-head production jobs and documentation passed;
[the #223 acceptance record](../roadmap-history.md#fixed-cpu-baselines-pr-223)
confirms the audited logs and identical squash-merge tree.
No compiler speedup is claimed.

## Frozen decision limits

The candidate/baseline ratio must not exceed the regression limit. A speedup
claim additionally requires a ratio **below** the improvement limit and a stable
identical-code control. Future baseline and candidate must run in the same job.
Rounded values below are for reading; the JSON retains exact values.

| CPU | Program | Regression limit | Improvement limit | Control pair limit |
|---|---|---:|---:|---:|
| Neoverse-N2 | `loop` | 1.013710 | 0.986475 | 1.006855 |
| Neoverse-N2 | `text-length` | 1.050845 | 0.951615 | 1.025422 |
| EPYC 7763 | `loop` | 1.037577 | 0.963784 | 1.018789 |
| EPYC 7763 | `text-length` | 1.104889 | 0.905069 | 1.052444 |

The least precise case is EPYC character counting: this protocol needs more than
about 9.5% less elapsed time to distinguish improvement from observed variation.
A smaller apparent gain is inconclusive under these limits. ARM64 loop timing
resolves a reduction greater than about 1.35%. These limits do not establish
C/Rust parity; the peer gaps below remain explicit.

## All observations

All times below are median **batch milliseconds**: one
process for `loop`, 32 fresh processes for `text-length`. A ratio of 1.27 means
fwp took 27% more time than that peer; 0.74 means 26% less. Ratios are formed
within one job, never across different CPUs. The first four sessions come from
`40765920239`; the two labelled “extra” come from `40768027818`.

| CPU/session | Program | C ms | Rust ms | fwp ms | Identical fwp ms | fwp/C | fwp/Rust |
|---|---|---:|---:|---:|---:|---:|---:|
| Neoverse-N2/1 | `loop` | 176.583 | 114.218 | 130.697 | 130.805 | 0.740 | 1.144 |
| Neoverse-N2/1 | `text-length` | 107.415 | 192.918 | 209.395 | 209.167 | 1.949 | 1.085 |
| Neoverse-N2/2 | `loop` | 176.513 | 114.235 | 130.797 | 130.819 | 0.741 | 1.145 |
| Neoverse-N2/2 | `text-length` | 103.649 | 186.650 | 199.045 | 200.083 | 1.920 | 1.066 |
| Xeon 8370C/1 | `loop` | 161.826 | 115.439 | 146.658 | 147.382 | 0.906 | 1.270 |
| Xeon 8370C/1 | `text-length` | 111.010 | 213.238 | 229.710 | 232.098 | 2.069 | 1.077 |
| EPYC 7763/2 | `loop` | 127.059 | 106.841 | 149.712 | 149.154 | 1.178 | 1.401 |
| EPYC 7763/2 | `text-length` | 114.365 | 216.131 | 236.500 | 235.181 | 2.068 | 1.094 |
| EPYC 7763/extra 1 | `loop` | 126.465 | 106.946 | 148.810 | 149.341 | 1.177 | 1.391 |
| EPYC 7763/extra 1 | `text-length` | 114.378 | 216.073 | 235.080 | 232.781 | 2.055 | 1.088 |
| EPYC 9V74/extra 2 | `loop` | 110.892 | 96.652 | 114.981 | 114.833 | 1.037 | 1.190 |
| EPYC 9V74/extra 2 | `text-length` | 97.788 | 198.764 | 197.528 | 197.618 | 2.020 | 0.994 |

All hosts allow four CPUs. ARM64 uses GCC 13.3.0; AMD64 uses GCC 15.2.0.
Both use Rust 1.99.1. C uses `-std=c11 -O2 -ffp-contract=off`, Rust
`--edition=2021 -O`, and fwp `-O2` with `FWP_LTO=0`. Exact versions, source
and binary hashes, individual process timings and outputs are retained in the
original JSON records linked below. These samples confirm a gap, not its cause.

Both fwp programs report zero managed allocation requests, requested bytes,
retains, peak charge and final charge in all separate ordinary memory runs.
This excludes raw runtime storage and stacks. Process RSS spans 1,388–2,200 KiB
for fwp across these runs; it is a separate whole-process measure, not an ARC
allocation count. The timed fwp text sections are 10,316/11,116 bytes on ARM64
and 11,058/11,954 bytes on AMD64 for loop/character counting. Corresponding
C text sections are 600/600 and 489/569 bytes; Rust text sections are
218,780/218,876 and 242,131/242,195 bytes. These linked-code totals include
language runtime differences, so they do not isolate the computation.

The separately instrumented fwp images report static `main` frames of 160 bytes
on ARM64 and 128 bytes on AMD64. Full per-function stack reports remain in each
record; these are neither total stack high-water measurements nor frame sizes
of the uninstrumented timed images.

Original records: [ARM64 session 1](cpu-baseline-2026-10-28-arm-1.json),
[ARM64 session 2](cpu-baseline-2026-10-28-arm-2.json),
[AMD64 session 1](cpu-baseline-2026-10-28-amd-1.json),
[AMD64 session 2](cpu-baseline-2026-10-28-amd-2.json).

Supplementary records: [AMD64 extra 1](cpu-baseline-2026-10-28-amd-extra-1.json),
[AMD64 extra 2](cpu-baseline-2026-10-28-amd-extra-2.json).
