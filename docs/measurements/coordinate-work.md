# Matching the numerical formula in C and Rust

The largest explicit-derivative fwp case takes 10.40–13.69 times the matched C
implementation's time and 11.86–14.07 times Rust's in this run. Matching the formula
arrangement does not close the gap. These are complete implementations with
remaining differences in buffers, checked access and formatting, not a measurement
of pure language overhead or an improvement over a prior compiler.

## What runs

Each solve starts with a vector alternating -1.2 and 1.0. Gradient descent repeatedly
subtracts 0.001 times the Rosenbrock derivative, then prints the complete vector.
A derivative describes how the objective changes when a coordinate changes.
Here the derivative is an explicit formula: this experiment does **not** measure
automatic differentiation or its recording storage.

The [fwp program](../../tests/fixtures/descent_packed.fwp) computes each new
coordinate from its previous, current and next input coordinates. New
[C](../../tests/fixtures/descent_coordinate.c) and
[Rust](../../tests/fixtures/descent_coordinate.rs) peers use the same formula and
boundary cases. The original C/Rust peers compute each adjacent pair's residual
once and add its contributions to both coordinates; they remain separate entries.
Both C/Rust arrangements reuse two buffers. fwp builds a new immutable array per
update. Checked indexing also differs. fwp searches decimal precisions for a
representation that parses back to the original float; the coordinate-based C
peer uses `printf("%.17g", value)` and Rust uses its ordinary `Display` formatter.
The checks compare numerical values, not identical printed text across languages.

There are six timed entries: fwp, a byte-identical copy of fwp, coordinate-based
C/Rust, and the original edge-based C/Rust. Each process performs 512 fresh solves,
including inputs, arithmetic, complete output and cleanup. Process/runtime startup
and teardown happen once; compilation and memory probes are excluded from timing.
Inputs have 3 coordinates with 0, 1, 199 or 1,999 updates, or 33/129 coordinates
with 199 updates. The [protocol](coordinate-work-protocol.md) fixes four warmups,
48 balanced samples, seed 20261022 and a 2% identical-copy limit.

## Results and limits

[Run 39827232824](https://github.com/e6qu/fun-with-pipes/actions/runs/39827232824)
passes both Linux jobs. Source `b9d598629ab38cfdd29d7863ec9cdbfd9bd893b6` rebuilds
saved, inspected C from compiler `927c6b1852a69748ae613291d89774bb8ae31121`.
It uses the expanded callback-local compiler, unlike the earlier adapter-only
[repeated-solve comparison](descent-batches.md).

AMD64 used **AMD EPYC 9V74 80-Core Processor**; ARM64 used **Neoverse-N2**. Both use GCC 13.3.0
and Rust 1.99.1 at O2, baseline CPU settings, no C floating contraction or fast-math,
checked Rust integer arithmetic and no Rust LTO. The
[raw record](coordinate-work-2026-10-22.json) preserves every sample, command,
source/binary hash, compiler stack record, process peak and memory observation.

A ratio of 10 means fwp took ten times the peer's time (900% extra time). The
copy column compares two identical fwp binaries; it should lie within 0.98–1.02.

| Host | Coordinates-updates | fwp / coordinate C | fwp / coordinate Rust | fwp / edge C | fwp / edge Rust | fwp / identical |
|---|---|---:|---:|---:|---:|---:|
| AMD64 | 3-0 | 1.73 | 1.17 | 1.79 | 1.16 | 0.9948 |
| AMD64 | 3-1 | 8.78 | 6.30 | 8.93 | 5.77 | 0.9969 |
| AMD64 | 3-199 | 6.02 | 4.68 | 5.30 | 5.17 | 0.9945 |
| AMD64 | 3-1999 | 2.89 | 2.63 | 2.15 | 3.42 | 1.0272 |
| AMD64 | 33-199 | 13.38 | 12.82 | 10.72 | 11.93 | 0.9989 |
| AMD64 | 129-199 | 13.69 | 14.07 | 10.97 | 14.23 | 1.0015 |
| ARM64 | 3-0 | 1.70 | 1.53 | 1.69 | 1.52 | 1.0169 |
| ARM64 | 3-1 | 10.78 | 9.34 | 10.96 | 9.56 | 1.0015 |
| ARM64 | 3-199 | 7.60 | 6.64 | 7.18 | 7.24 | 0.9999 |
| ARM64 | 3-1999 | 3.87 | 3.47 | 3.41 | 4.40 | 1.0003 |
| ARM64 | 33-199 | 10.41 | 11.06 | 9.61 | 10.54 | 1.0000 |
| ARM64 | 129-199 | 10.40 | 11.86 | 9.59 | 12.10 | 1.0003 |

AMD64's 3-coordinate/1,999-update control fails the 2% limit; retain that row as
inconclusive timing. The other eleven controls pass. This is one run per host,
not the two independent matching-CPU runs required for a useful speed claim.
Changing formula arrangement affects the peers differently: in the largest case,
coordinate C takes about 8–20% less time than edge C, while coordinate Rust takes
about 1–2% more. It does not explain fwp's remaining order-of-magnitude gap.

## Storage and executable checks

All 144 saved executables were independently inspected for native architecture,
source/binary hashes and actual instructions. The fwp ARC images contain no
tracing scan/mark/sweep routines. Largest-case machine loops retain 512 complete
solves: AMD64 fwp unrolls its loop to two entry calls per iteration, while ARM64
calls once. C/Rust retain buffer allocation, arithmetic, output and deallocation
inside their outer loop. Rust's indirect AMD64 allocation calls were resolved
through the actual executable's relocation records, not inferred from source.

Untimed probes observe storage after **every** solve. fwp has zero managed/raw
live storage at all checkpoints and zero retains. Each C/Rust peer has zero live
numerical buffer bytes at every checkpoint. These are different observation scopes:

| Largest case, per solve | fwp managed values | C/Rust numerical buffers only |
|---|---:|---:|
| Allocation requests | 459 | 2 |
| Requested bytes | 216,925 | 2,064 |
| Peak live bytes | 7,200 | 2,064 |
| Live bytes after the solve | 0 | 0 |

fwp's counts cover its managed values, including output construction; the peer
probes cover only their two numerical buffers. They exclude formatting, unrelated
runtime storage and allocator metadata. A managed request is not necessarily an
operating-system allocation. These columns do not establish a total-memory ratio;
process peak resident memory is recorded separately.

Small C/Rust controls check two-coordinate boundaries, zero/one/many updates and
seven malformed-output cases. At 33 coordinates/199 updates, omitting one buffer
release fails on the first solve for both arrangements in both languages. fwp's
delayed-release control also fails at the first checkpoint; removing intermediate
observations lets the same delay pass its final-only check. All these deliberately
broken cases are excluded from timing.

Next separate output construction, callback calls, checked indexing and numerical
buffer storage before selecting a compiler optimization. Preserve immutable values,
arithmetic/trap order and cleanup; do not treat these finite workloads as proof of
bounded memory for arbitrary programs.
