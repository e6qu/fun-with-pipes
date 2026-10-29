# Where the CPU benchmark time goes

This experiment prepares the next [P2 change](../../PLAN.md#4-cpu-performance).
It has no measured result yet. The [previous scalar changes](proved-scalar-bounds.md)
did not meet the fixed improvement limits and were removed. Before choosing
another optimization, separate calculation from runtime setup and output.

## Programs and comparison

Use the unchanged checked signed-I64 programs in `bench/loop` and
`bench/text-length`, each implemented in fwp, C and Rust:

| Program | Work in one process | Output |
|---|---|---|
| `loop` | Count down from 100,000,000; add `(i * 3) % 7`, checking subtraction, multiplication and addition | `300000003` |
| `text-length` | For integers 0 through 1,999,999, count decimal characters in `i`, a separator and `i * 3`; sum those lengths | `28518516` |

Each prints its result and a newline. Text counting does not materialize two
million strings. The implementations use the same inputs and overflow behavior;
the compiler may prove checks redundant. This is not an unchecked-C comparison.

Run the `cpu-phases` choice in the Numerical and ownership evidence workflow.
The job records its source commit, input hashes, toolchains and host **before any
benchmark timing**. Only the Neoverse-N2/GCC 13.3.0 and EPYC 7763/GCC 15.2.0
hosts in the [frozen table](cpu-baselines.md) qualify; both require Rust 1.99.1
and four available CPUs. Preserve a rejected host record. Do not select hosts
by the speed of their results or change the table to accept a noisy run.

Build current fwp from Rust sources; no previous fwp executable is required.
Use GCC `-O2 -ffp-contract=off`, C11 for the C peers and GNU C11 for generated
C, and Rust `--edition=2021 -O`. fwp uses dynamic memory and `FWP_LTO=0`.
This source includes the startup error-handling repair; it is not the older
baseline source. Host qualification does not make those revisions identical.

First run the seven existing C/Rust/fwp comparisons, their arithmetic/allocation
failure controls, actual-binary inspection, and separate memory/leak checks.
Keep that report as context, with its own six-sample sequential timing protocol.
Then collect the following diagnostic experiment for the two selected programs.

## Clock boundaries

A diagnostic is a modified executable containing timing calls. Keep its source,
actual executable, compiler command, sections, symbols and machine code alongside
the ordinary executable. These are different builds, not interchangeable samples.

| Implementation | Intervals recorded inside its diagnostic executable |
|---|---|
| C and Rust | Entry to completed calculation; completed calculation through printing and an explicit stdout flush |
| fwp | C launcher entry to worker entry; runtime setup; calculation; printing and explicit flush; return from the language entry; worker cleanup; join and final flush |

For fwp, calculation starts after constants are initialized and ends at entry to
the integer printer. Setup includes the work before that boundary; cleanup includes
the work after the language entry returns. C/Rust do not have equivalent fwp runtime
phases. Startup before C/Rust `main` and work after it returns remain unobserved.

C uses `CLOCK_MONOTONIC`; Rust uses `Instant`. Each completed result is passed to
an optimization barrier before its ending clock. A barrier preserves that result,
but does not establish that every source operation stayed between the clocks.
Review generated C and the actual compiled boundaries before attributing a cost.
Timing calls can change inlining, register allocation and scheduling. The explicit
flush also moves work that an ordinary program may perform later at exit.

The C observer requires each boundary exactly once. A deliberately omitted fwp
boundary must terminate with status 246 despite otherwise correct output. The
reader rejects missing, reordered, negative or noninteger timestamps, elapsed
internal time exceeding measured process time, and changed outputs. Clock calls
and their perturbation are not subtracted using an assumed correction factor.

## Samples and interpretation

For each program, measure nine entries: ordinary, identical-code control and
diagnostic for each language. The identical control executes the **same binary**
again. Rotate the starting entry each round, with two warmup rounds and 72 measured
rounds. Each entry occupies each position eight times in the measured rounds.
A loop batch runs one process; a text batch runs 32 processes. Use all available
CPUs without affinity pinning. Each process has a 120-second timeout.

An external timer starts immediately before launching the process and ends after
capturing its output and waiting for exit. Retain every process duration, status,
stdout, stderr and binary hash. A batch duration is the sum of its process durations;
report its median separately from internal phase medians. Save JSON outside timed
process intervals. Keep warmups, slow observations, failures and partial reports.

Report ordinary C/Rust/fwp whole-process medians and all three identical-code
controls. Apply the existing fwp control limits without resetting them; a failing
control makes the comparison inconclusive. C/Rust control ratios are descriptive,
without a newly invented acceptance threshold. Report diagnostic/ordinary ratios
so instrumentation cost is visible. Phase observations alone do not establish a
speedup, causal overhead, or compliance with P2's improvement budget.

The difference between diagnostic wall time and its recorded internal intervals
includes process launch, unobserved startup/exit and diagnostic reporting. It is
not exclusively fwp runtime cost. Separate phase medians need not sum to the median
whole-process time. An apparent dominant cost needs a controlled source change
before it becomes an optimization claim.

Retain whole-image and `.text` sizes for ordinary and diagnostic builds, GCC stack
reports for the actual timed C/fwp diagnostic images, and the separate ordinary-fwp
managed-allocation/retain/peak-storage/RSS profiles. Those storage profiles are
instrumented builds, not the timed images. No Rust stack-size claim follows from
GCC reports. Preserve all seven peer results, including regressions outside the
selected pair.

The implementation is [cpu-phases.py](../../scripts/cpu-phases.py); its reader and
instrumentation controls are [test-cpu-phases.py](../../scripts/test-cpu-phases.py).
Final conclusions must identify the measured source and both host runs, link raw
records, and state what remains unproved.
