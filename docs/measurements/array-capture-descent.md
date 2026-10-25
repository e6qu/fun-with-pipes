# Borrowing array captures in numerical descent

Array generation can read an existing array without creating another owner for
each element. The [ownership change](array-capture-borrows.md) explains the proof
and its failure/cancellation checks. Here we measure it in a complete program:
Rosenbrock gradient descent, which repeatedly adjusts a vector toward a minimum.
The [first comparison](descent-peers.md) defines the function and derivative.
For 129 coordinates and 199 updates, retains fall from **25,671 to zero** on
both architectures. Allocation requests stay at 459 and managed peak at 7,200 bytes.
Necessary array storage remains; this is not an allocation-free program.

## Programs and measurement boundary

The baseline is the accepted [array-owner move](array-owner-moves.md). Its saved
generated C is rebuilt beside the candidate with the same C compiler and flags.
Both fwp programs use packed arrays and the explicit derivative. The candidate
also borrows captures inside eligible generation callbacks and removes temporary
record/alias owners. Inputs and update counts are compile-time constants.

Other peers remain fwp automatic differentiation (AD), fwp explicit derivatives
using lists, and handwritten C/Rust explicit derivatives. All start at alternating
−1.2 and 1.0 and subtract 0.001 times the gradient per update. Every program prints
the complete final vector. An independent Python derivative checks it within
absolute/relative tolerance 1e-10; each native fwp form must also match its own
unoptimized interpreter exactly. Timed outputs must repeat exactly.

C/Rust reuse two flat buffers; packed fwp allocates an immutable output array per
update and checks indices. AD records and reverses arithmetic; list fwp creates
lists and pairs. Formatting also differs. C/Rust ratios include these differences
and necessary language checks: they are not isolated compiler overhead.

The timer includes a fresh process, initialization, every update, complete output
and teardown. Compilation and memory instrumentation are excluded. Zero updates
still include initialization and printing. Two warmups precede 56 samples per
entry. Each 14-round block balances positions and ordered adjacent pairs, with
row order shuffled using seed 20261022; cross-round boundaries are not balanced.
A seventh entry copies the candidate executable byte for byte under another name.
Its timing difference exposes variation unrelated to different instructions.

## Count and storage requirements

Before measurement, repeated packed cases (at least 199 updates) were required
to have zero retains. A retain adds a counted owner. Allocation requests, requested
bytes and raw derivative storage must stay unchanged; managed peak may not grow.
The rebuilt baseline must reproduce its recorded profile. All variants must end
with no managed or raw storage remaining and perform no tracing collections.
These requirements pass on both measured architectures.

The first two compiler attempts passed focused ownership tests but failed this
application requirement on both hosts: 3 coordinates × 199 updates still made
597 retains. A temporary record first acquired an owner; removing that record
exposed a last-read alias that reacquired it. Both failed sources and artifact
hashes remain in the data. The current proof handles both cases. Measurement now
reports every count/storage budget violation across inputs before failing;
incorrect output, cleanup violations and invalid raw traces still stop immediately.

Managed charge measures runtime-requested storage, not process resident memory.
Raw derivative buffers are reported separately. Uninstrumented process RSS includes
other process storage and must not be added to these peaks.

The count/storage profiles below are identical on both architectures.

| Coordinates | Updates | Old retains | New retains | Requests | Requested bytes | Managed peak bytes |
|---:|---:|---:|---:|---:|---:|---:|
| 3 | 0 | 0 | 0 | 8 | 202 | 128 |
| 3 | 1 | 3 | 0 | 9 | 280 | 176 |
| 3 | 199 | 597 | 0 | 207 | 6617 | 176 |
| 3 | 1999 | 5997 | 0 | 2007 | 64212 | 176 |
| 33 | 199 | 6567 | 0 | 267 | 56701 | 1824 |
| 129 | 199 | 25671 | 0 | 459 | 216925 | 7200 |

## Timings, including slower results

Each ratio divides candidate median time by the named peer's median. Below 1
means less time; 1.25 means 25% more time. The identical-copy column compares the
same machine code under two filenames. No speed threshold was declared. These
single-run observations do not establish a general speedup or C/Rust parity.

| Host | Coordinates | Updates | Candidate ms | Candidate / old | Candidate / identical copy | Candidate / C | Candidate / Rust |
|---|---:|---:|---:|---:|---:|---:|---:|
| AMD64 | 3 | 0 | 0.985 | 0.9801 | 1.0178 | 1.4637 | 1.1283 |
| AMD64 | 3 | 1 | 1.131 | 0.9870 | 1.1001 | 1.3824 | 0.9827 |
| AMD64 | 3 | 199 | 0.986 | 0.9861 | 0.9823 | 1.3245 | 1.0795 |
| AMD64 | 3 | 1999 | 1.019 | 0.8986 | 1.0018 | 1.3505 | 1.1307 |
| AMD64 | 33 | 199 | 1.263 | 0.9559 | 1.0529 | 1.6532 | 1.4385 |
| AMD64 | 129 | 199 | 1.999 | 0.7216 | 0.9657 | 2.3300 | 2.0138 |
| ARM64 | 3 | 0 | 1.083 | 0.9772 | 1.0127 | 1.2786 | 1.1061 |
| ARM64 | 3 | 1 | 1.060 | 1.0078 | 0.9982 | 1.3145 | 1.1478 |
| ARM64 | 3 | 199 | 1.020 | 0.9777 | 0.9993 | 1.4122 | 1.1271 |
| ARM64 | 3 | 1999 | 1.068 | 0.8970 | 0.9936 | 1.4274 | 1.1738 |
| ARM64 | 33 | 199 | 1.315 | 0.9096 | 1.0205 | 1.6072 | 1.3635 |
| ARM64 | 129 | 199 | 2.058 | 0.7983 | 0.9765 | 2.3754 | 1.9761 |

The largest case takes 27.8%/20.2% less median time than its rebuilt fwp baseline
on AMD64/ARM64 in this run. It still takes **2.33×/2.38× C time** (133%/138% more)
and **2.01×/1.98× Rust time** (101%/98% more). These compare complete programs,
including their different allocation and checking work.

The ARM64 one-update case is 0.8% slower. AMD64's one-update identical-code control
differs by 10%, and its 33-coordinate control by 5.3%; these differences cannot
come from the compiler change. Small-case speed claims remain inconclusive.
Independent repeats and a declared timing budget are still needed.

## Hosts, machine code and remaining costs

Hardware and compiler versions below come from each job, not assumptions about
the runner label. C uses O2, baseline architecture, no fast-math or floating-point
contraction, and static frame reporting. Rust uses O2, generic CPU, checked
overflow and no link-time optimization. fwp uses checked ARC, stack placement,
packed arrays and array fusion; timing excludes stress instrumentation.

- **x86_64 — INTEL(R) XEON(R) PLATINUM 8573C**: gcc (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0; rustc 1.99.1 (58cf8f9c3 2026-10-13).
- **aarch64 — Neoverse-N2**: gcc (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0; rustc 1.99.1 (58cf8f9c3 2026-10-13).

All 132 saved native images were independently disassembled and checked against
their hashes and processor architecture. Checked ARC images omit tracing entry
points. For the 129-coordinate, 199-update program, the table gives full executable
and instruction-section sizes. These include runtime code, not just the loop.

| Host | Version | Binary bytes | Instruction-section bytes | Update-function frame bytes |
|---|---|---:|---:|---|
| x86_64 | Previous compiler | 83264 | 41634 | 112 |
| x86_64 | Borrowed captures | 83224 | 41778 | 96 |
| aarch64 | Previous compiler | 84736 | 40060 | 112 |
| aarch64 | Borrowed captures | 84696 | 40172 | 96 |

The update function's frame decreases from 112 to 96 bytes. Total instruction
sections grow by 144 bytes on AMD64 and 112 on ARM64 even though executable files
shrink by 40 bytes. File size includes alignment and metadata; a smaller file does
not mean fewer instructions.

The new generator calls known numerical work directly; the baseline dispatches
through a function value. Timing differences therefore include direct-call
optimization as well as removing retains. Both generators have 96-byte static
frames. The numerical helper's frame stays 48 bytes on AMD64 and 64 on ARM64.
General dispatch code remains in the executable for other calls.

Frames are GCC's per-function estimates, not measured peak stack use. A dynamic
qualifier means runtime-sized storage can add to the listed amount. Function
names can change between compilations; the data preserves their actual machine
instructions and generated-source hashes for inspection. Necessary array storage,
checked operations and remaining representation costs still need work.

[Retained data](array-capture-descent-2026-10-22.json) includes every sample/order, complete profiles,
compile commands/times, process RSS, binary hashes, static frames, machine-code
inspection and failed-attempt evidence. Reporting source `d1467854766fd93fa6e6c768d42f35e83fec3c1a`
uses unchanged compiler/native-test source `80d8f27e1bf57e4665503d6d1ed1af261f7dc672`;
[run 39786472473](https://github.com/e6qu/fun-with-pipes/actions/runs/39786472473)
passes both numerical jobs. [PR #197](../roadmap-history.md#borrowed-array-captures-pr-197) records the separate final-head production acceptance.
