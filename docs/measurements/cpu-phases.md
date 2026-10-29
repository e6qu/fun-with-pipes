# Where the CPU benchmark time goes

This experiment prepares the next [P2 change](../../PLAN.md#4-cpu-performance).
Both native Linux sessions completed and their artifacts were audited. The [previous scalar changes](proved-scalar-bounds.md)
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


## Results at the measured source

Source `c92fed4208a16627f0f420f58ce1f7729bf0f061` passed the ARM64 job in
[run 40795538429](https://github.com/e6qu/fun-with-pipes/actions/runs/40795538429)
and the qualified AMD64 job in
[run 40795656380](https://github.com/e6qu/fun-with-pipes/actions/runs/40795656380).
The first run's AMD64 host was EPYC 9V45; it was rejected before benchmark work.
Keep its [host record](cpu-phases-2026-10-29-unqualified.json). The retry qualified
as EPYC 7763; it was selected by hardware identity, not timing results.

[ARM64 raw observations](cpu-phases-2026-10-29-arm.json),
[AMD64 raw observations](cpu-phases-2026-10-29-amd.json) and the
[artifact archive](cpu-phases-artifacts-2026-10-29.json) preserve every sample,
original seven-peer/memory report, command and artifact identity. Each host passed
benchmark output checks, eleven native peer controls, seven leak controls and
both omitted-clock-boundary controls. Independent review checked 21 ordinary
binaries, 14 memory profiles, six diagnostic binaries and two omitted-boundary
binaries per host without executing downloaded images locally.

### Ordinary and diagnostic elapsed time

Values are **median batch milliseconds**: one process for `loop`, 32 for
`text-length`. “Same” is another invocation of the identical ordinary binary.

| Host/program | C | C same | C diagnostic | Rust | Rust same | Rust diagnostic | fwp | fwp same | fwp diagnostic |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| ARM64 loop | 176.586 | 176.518 | 172.660 | 114.176 | 114.108 | 114.119 | 130.661 | 130.695 | 156.586 |
| ARM64 text-length | 103.188 | 103.246 | 103.221 | 186.775 | 186.608 | 186.953 | 202.096 | 202.167 | 202.701 |
| AMD64 loop | 126.527 | 126.435 | 131.127 | 107.127 | 107.130 | 110.376 | 127.864 | 128.424 | 143.510 |
| AMD64 text-length | 113.540 | 113.252 | 103.479 | 215.162 | 215.109 | 225.642 | 237.400 | 236.565 | 233.165 |

Both ARM64 fwp controls pass the original limits. AMD64 text passes narrowly:
its paired p95 ratio is 1.052066 against the fixed 1.052444 limit. AMD64 loop
is **inconclusive**, at 1.032855 against 1.018789. None of these limits changed.
The three languages' full control ratios remain in the raw records.

The diagnostic changes fwp loop elapsed time by **+19.84% on ARM64 and +12.24%
on AMD64**. Its text change is +0.30% and −1.78%. C text changes by −8.86% on
AMD64 despite computing the same result; Rust text changes by +4.87%. These are
instrumentation/layout effects, not accepted language optimizations. The current
AMD64 ordinary fwp loop also differs from the earlier baseline session; without a
same-job source comparison it is not evidence that the startup repair sped it up.

### Internal intervals

Values below are **median microseconds per diagnostic process**, including all
72 samples (and all 32 processes per text batch). Individual medians do not add
to the median process duration.

| Host/program | C calculation | Rust calculation | fwp calculation | fwp thread start | fwp setup | fwp output | fwp entry return | fwp cleanup | fwp join/flush |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| ARM64 loop | 171573.388 | 112931.293 | 155159.220 | 115.353 | 31.352 | 13.212 | 0.064 | 0.608 | 133.593 |
| ARM64 text-length | 2481.052 | 4918.847 | 5205.069 | 95.515 | 27.880 | 10.488 | 0.048 | 0.280 | 86.380 |
| AMD64 loop | 130201.424 | 109154.701 | 142247.033 | 99.790 | 27.561 | 12.198 | 0.080 | 0.771 | 68.647 |
| AMD64 text-length | 2548.286 | 6167.674 | 6251.873 | 91.587 | 33.919 | 7.604 | 0.090 | 0.270 | 42.105 |

Across these diagnostics, C output takes 26–53 µs and Rust output 8–23 µs.
Unaccounted wall-time medians are 0.65–1.18 ms; they include the launcher and
unobserved/reporting work, not just runtime overhead. Setup/cleanup is small
compared with calculation in the diagnostic builds. Because instrumentation
changes code and timings, these intervals do not precisely partition the ordinary
programs' performance gap. They support investigating computation next.

### Code, stack and memory

The compiler emits distinct observed clock calls around the calculations and
output in the retained images. Source and machine-code review establish the
observed boundaries, not an absence of instrumentation effects.

| Host/program | C `.text` ordinary → diagnostic | Rust `.text` ordinary → diagnostic | fwp `.text` ordinary → diagnostic |
|---|---:|---:|---:|
| ARM64 loop | 600 → 1,024 | 218,780 → 223,948 | 10,364 → 10,892 |
| ARM64 text-length | 600 → 1,088 | 218,876 → 224,044 | 11,164 → 11,692 |
| AMD64 loop | 489 → 889 | 242,131 → 246,931 | 11,058 → 11,634 |
| AMD64 text-length | 569 → 969 | 242,195 → 246,995 | 11,986 → 12,594 |

These section sizes include padding. Whole-image bytes and exact sources/binaries
are recorded separately; Rust includes its linked runtime code. Actual timed C
main frames are 80/64 bytes for ARM64 loop/text and 32/32 for AMD64. fwp diagnostic
main frames are 160 bytes on ARM64 and 128 on AMD64; worker frames are 304/272
and 288/256 respectively. These are per-function reports, not peak call-chain use.

Both ordinary fwp programs still report zero managed requests, bytes, retains and
peak/final managed charge in separate profiles. Deliberate 16-byte leaks remain
detectable. That excludes raw runtime allocations and stacks. The raw report also
retains three RSS observations per language/program and all seven peer comparisons;
no process-memory or wider benchmark speedup is claimed.

### Decision

Keep the startup error-handling repair for correctness. Do not remove its required
stack setup or infer an optimization from these clock-instrumented images.
Investigate the repeated divisions in decimal digit counting next. A bit-length
estimate followed by an exact power-of-ten comparison is a testable alternative:
it needs integer-boundary proofs, a visible constant-table cost and an ordinary
same-job comparison against the current helper on both architectures. Preserve
all checked arithmetic, evaluation order and existing fixed timing limits. No
candidate has yet passed that acceptance test; P2/P3 remain open.
