# Array-owner moves: half the retains, uncertain timing gains

Moving an existing array owner out of a temporary record removes one retain and
its matching release per coordinate update in our packed-array descent program.
A retain adds a counted owner. For 129 coordinates and 199 updates, retains fall
from **51,342 to 25,671**, with unchanged allocation requests and peak managed
storage. The [ownership tests](stack-array-ownership.md) explain the proof and
verify aliases, failures and cancellation on all six native platforms.

This is a reproducible reduction in bookkeeping, not proof of a general speedup.
Small timing differences change between runs, and even byte-identical executables
show differences of several percent. The ARM64 callback also needs a larger
stack frame. We retain these costs and all slower results below.

## What is compared

Each program performs the same Rosenbrock gradient descent and prints the entire
final vector. The [first comparison](descent-peers.md) introduces the objective,
inputs and derivative formula. The [packed-array experiment](packed-descent.md)
replaces explicit fwp lists with contiguous numeric arrays; that is the baseline
for this compiler change. All programs start from alternating −1.2 and 1.0 and
subtract 0.001 times the gradient per update.

The main comparison recompiles the accepted packed program's generated C beside
the new generated C, using the same C compiler and flags. The old/new difference
is the array-owner move. AD, list-based explicit fwp, C and Rust remain measured
peers. C/Rust reuse two flat buffers; packed fwp creates an immutable output array
per update and checks indices. AD records and reverses arithmetic. Formatting
also differs. Ratios against these peers measure complete implementations,
including those differences, rather than pure compiler overhead.

A seventh timing entry is an exact copy of the new executable under another
filename. Its bytes and output must match. Comparing the two copies reveals
variation that cannot be explained by different machine instructions.

## Protocol and its repair

All peers are rebuilt together. Timing includes fresh-process startup, input
construction, all updates, complete output and teardown. Compilation, interpreter
checks and instrumented memory profiles are excluded. Zero updates still include
initialization and printing; they are not a pure startup measurement.

Two warmups precede 56 samples per executable. Each 14-round block puts every
program in each position twice and puts every ordered pair next to each other
twice within rounds. Blocks shuffle their row order with explicit seed 20261022;
cross-round boundaries are not balanced. The runner checks these properties and
records every execution order and sample.

The earlier rotating/reversing schedule balanced positions but only exposed each
program to two possible immediate predecessors. It could confound the measured
program with the heavier work before it. We repaired that protocol after two
runs showed small-case regressions. The original measurements remain evidence;
the new results do not prove execution order caused every earlier difference.

Native fwp output must equal its unoptimized interpreter output exactly. Every
program must agree with an independent Python derivative within absolute/relative
1e-10 tolerance and repeat its own complete output exactly. The recompiled old
packed program must reproduce its accepted memory profile. Current AD/list/packed
forms must preserve allocation requests, requested bytes and raw derivative
storage without increasing retains or managed peak. Cases with at least 199
updates must reduce packed retains. All these requirements pass. No timing
threshold was declared, and this report does not add one after observing results.

The revised run uses GCC 13.3.0 and Rust 1.99.1 on Intel Xeon Platinum 8573C and ARM Neoverse-N2.
The earlier AMD64 runs used AMD EPYC 7763; the revised run uses Intel. This
host change also prevents attributing cross-run differences solely to ordering.
C uses O2, a baseline architecture, no fast-math, no floating-point contraction
and static frame reporting. Rust uses O2, generic CPU, checked overflow and no
link-time optimization. fwp uses checked ARC, stack placement, packed arrays,
array fusion and bounded derivative workspace; stress instrumentation is off for
timing. Exact flags, settings, CPU reports and compile times are in the data.

## Timings, including the slower results

These are candidate/baseline median-time ratios: below 1 means less time; above
1 means more. The last column compares two copies of the candidate's exact bytes.

| Host | Coordinates | Updates | First run | Repeat | Balanced order | Identical-code ratio |
|---|---:|---:|---:|---:|---:|---:|
| AMD64 | 3 | 0 | 1.1264 | 1.0175 | 0.9383 | 1.0490 |
| AMD64 | 3 | 1 | 1.1145 | 1.1363 | 1.0715 | 1.0569 |
| AMD64 | 3 | 199 | 1.0692 | 1.0810 | 1.0047 | 1.0321 |
| AMD64 | 3 | 1999 | 1.0110 | 1.0435 | 1.0143 | 1.0387 |
| AMD64 | 33 | 199 | 1.0193 | 1.1015 | 0.9586 | 0.9842 |
| AMD64 | 129 | 199 | 1.0021 | 0.9608 | 0.9836 | 0.9501 |
| ARM64 | 3 | 0 | 1.0007 | 0.9859 | 0.9736 | 0.9821 |
| ARM64 | 3 | 1 | 1.0297 | 1.0116 | 1.0013 | 1.0244 |
| ARM64 | 3 | 199 | 1.0412 | 1.0322 | 0.9796 | 0.9970 |
| ARM64 | 3 | 1999 | 1.0043 | 0.9904 | 0.9374 | 0.9821 |
| ARM64 | 33 | 199 | 0.9925 | 1.0089 | 1.0004 | 1.0123 |
| ARM64 | 129 | 199 | 0.9583 | 0.9798 | 0.9661 | 0.9918 |

The first AMD64 zero-update result was 12.64% slower; its repeated 199-update
case was 8.10% slower. ARM64's 199-update case was 4.12% and 3.22% slower.
Those small-case differences do not reproduce at the same size under the repaired
schedule. In the revised run, AMD64's identical-code ratios range from about
0.95 to 1.06. We therefore do not attribute changes of a few percent to this
compiler rule or claim that all regressions have been ruled out.

The data includes 5,000 paired-round resamples with seed 20261022 and 95%
percentile intervals for ratios of medians. These are exploratory within-run
uncertainty estimates, not guarantees about new runners or independent repeat
experiments. They do not correct all scheduling or between-round effects.
Keep the count result separate from timing; stronger speed claims need a protocol
whose identical-code control is stable relative to the proposed gain.

For the largest case in the revised run, medians in milliseconds are:

| Host | AD fwp | List fwp | Old packed fwp | New packed fwp | Identical copy | C | Rust |
|---|---:|---:|---:|---:|---:|---:|---:|
| AMD64 | 37.352 | 6.280 | 2.502 | 2.461 | 2.590 | 0.806 | 0.988 |
| ARM64 | 39.898 | 6.095 | 2.695 | 2.603 | 2.625 | 0.865 | 1.021 |

New packed fwp still takes about **3.05×/3.01× C time** and **2.49×/2.55× Rust
time** on AMD64/ARM64. Lower retain counts do not establish C/Rust parity.

## Storage and machine code

Both architectures reproduce the same largest-case profiles:

| Packed fwp version | Allocation requests | Requested bytes | Retains | Peak managed bytes |
|---|---:|---:|---:|---:|
| Accepted baseline | 459 | 216,925 | 51,342 | 7,200 |
| Array-owner move | 459 | 216,925 | 25,671 | 7,200 |

All repeated packed cases halve retains. Managed and raw-storage ledgers return
to zero; there are no collections. Requests count fwp allocation-interface calls,
not necessarily system allocations. Requested bytes accumulate, while peak bytes
measure storage live at one instant. Explicit derivatives use no raw AD workspace.
Whole-process resident-memory measurements are separate and include other storage;
do not add them to managed peaks or infer C/Rust allocation-count parity.

The ARM64 numerical callback's GCC frame estimate grows from **48 to 64 bytes**.
Disassembly shows another saved register, `x21`, keeping the array header across
a helper call; the floating-point saves move to preserve stack alignment. This is
ordinary register allocation, and its cost is part of the result. AMD64's estimate
stays at 48 bytes. These are per-function static estimates, not measured peak stack
use or Rust stack estimates. The data retains all reported C frames and the actual
callback instructions, including the removed retain path.

Whole executable and code-section sizes for the largest packed case are:

| Host | Version | Executable bytes | Code-section bytes |
|---|---|---:|---:|
| AMD64 | fwp-packed | 83,256 | 41,634 |
| AMD64 | fwp-packed-baseline | 83,264 | 41,746 |
| ARM64 | fwp-packed | 84,728 | 40,060 |
| ARM64 | fwp-packed-baseline | 84,736 | 40,108 |

These sizes include runtime and linked code, not just the numerical loop.

## Sources and remaining work

Compiler source is `026db07bacbe0c1b60ae78b92d008d2039f84761`. The first and
repeat runs are
[39767706345](https://github.com/e6qu/fun-with-pipes/actions/runs/39767706345) and
[39769019993](https://github.com/e6qu/fun-with-pipes/actions/runs/39769019993).
Their corresponding executable hashes are identical. The protocol repair changes
only the runner/workflow, at `96967e9ba19957296f7ba035637860a9e305ff83`, tag
`roadmap/revision-balanced-descent-96967e9ba199`. Both Linux jobs pass in
[39770344180](https://github.com/e6qu/fun-with-pipes/actions/runs/39770344180).
Select `descent-peers` in the **Numerical and ownership evidence** workflow.

[All three experiments](array-owner-moves-2026-10-22.json) retain samples, outputs,
settings, profiles, complete-log audits and independent inspection of **372 actual
images**: 120 in each original run and 132 in the revised run. The latter includes
12 byte-identical controls and 48 untimed profiles. Inspection checks architecture,
generated C, binary hashes, instructions and tracing exclusion in ARC.

One counted callback capture remains per coordinate update. The next compiler
question is whether eligible known callbacks can borrow their captures throughout
the call while the caller keeps them alive, including failure/cancellation. Unknown
or escaping callbacks need separate ownership proofs. Preserve the current memory
budgets and control timing variability before making a speed claim. Full production
acceptance for delivery is tracked in the [handoff](../development-state.md).
