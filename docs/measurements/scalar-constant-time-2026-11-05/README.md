# Scalar constants: runtime results

**The complete evidence audits pass; the 5% speedup goal remains open.**
Long solves improve by 1.7–6.3%, but 27 of 32 comparisons miss 5%. All small-case
regression, identical-copy, allocation, cleanup and stack limits pass.
Retain the verified constant-read reduction under the agreed policy; do not mark
these timing targets complete or rerun unchanged measurements for a better result.

## What was measured

Two compilers from `76690b385514c58ad94c5591da3553fa48218535`: scalar replacement
on versus off. Both keep all earlier ownership and storage optimizations.
Programs minimize the Rosenbrock function using automatically computed derivatives.
“Final” returns the final coordinates. “History” expresses the sequence then
selects its last value; unused history can be optimized away.

- Two independent sessions per architecture: Neoverse-N2 ARM64 and EPYC 7763 AMD64.
- GCC O2, explicit native target, no fast math/contraction/LTO; Rust 1.99.1.
- Two warmups, 98 balanced rounds. Each timed sample totals **seven fresh processes**,
  including startup, all solves and output. Compilation and instrumented profiles
  are outside this timing scope.
- Coordinates / updates / solves per process: 3/0/32768, 3/1/512, 3/199/32,
  3/1999/4, 33/199/32, 129/199/8. Thus the largest sample covers 56 solves.
- [The protocol](../scalar-constant-lowering.md) fixes inputs, repetitions and limits.

## Candidate / cached-reference time

Below 1 is faster; `0.9589` means 4.11% less elapsed time. Long cases require
at most `0.95`; zero/one-update cases permit at most `1.02`.

| Coordinates / updates, form | ARM1 | ARM2 | AMD1 | AMD2 |
|---|---:|---:|---:|---:|
| 3 / 0 final | 0.9974 | 0.9977 | 0.9935 | 1.0071 |
| 3 / 0 history | 0.9998 | 1.0009 | 0.9934 | 0.9981 |
| 3 / 1 final | 0.9983 | 0.9992 | 0.9732 | 0.9756 |
| 3 / 1 history | 0.9977 | 0.9987 | 0.9782 | 0.9886 |
| 3 / 199 final | 0.9703 | 0.9724 | 0.9727 | 0.9710 |
| 3 / 199 history | 0.9786 | 0.9746 | 0.9594 | 0.9729 |
| 3 / 1999 final | 0.9718 | 0.9646 | 0.9716 | 0.9654 |
| 3 / 1999 history | 0.9749 | 0.9685 | 0.9826 | 0.9743 |
| 33 / 199 final | 0.9595 | 0.9600 | 0.9385 | 0.9416 |
| 33 / 199 history | 0.9565 | 0.9559 | 0.9553 | 0.9626 |
| 129 / 199 final | 0.9589 | 0.9587 | 0.9387 | 0.9366 |
| 129 / 199 history | 0.9570 | 0.9562 | 0.9608 | 0.9469 |

Misses: ARM1 eight, ARM2 eight, AMD1 six, AMD2 five. The five qualifying long
results are AMD1 final 33/199 and 129/199; AMD2 final 33/199 and both 129/199 forms.
Identical executable copies vary by at most 1.37% (2% limit).
The largest small-case slowdown is AMD2 zero-update final, 0.71% (2% limit).

[Memory and stack](../scalar-constant-census-2026-11-05/README.md) are unchanged;
[compiler costs](../scalar-constant-analysis-2026-11-05/README.md) pass their limits.
[Whole-program C/Rust comparison and process memory](peer-costs.md) explain the
remaining gap without calling it isolated language or ARC overhead.

## Evidence and repairs

| Sessions | Original measurement | Complete audit | Records |
|---|---|---|---|
| ARM1, ARM2, AMD1; rejected AMD2 host | [42074728167](https://github.com/e6qu/fun-with-pipes/actions/runs/42074728167) | [42078637088](https://github.com/e6qu/fun-with-pipes/actions/runs/42078637088) | [index](42078637088/index.json) |
| Qualified AMD2 replacement | [42075136884](https://github.com/e6qu/fun-with-pipes/actions/runs/42075136884) | [42078654369](https://github.com/e6qu/fun-with-pipes/actions/runs/42078654369) | [index](42078654369/index.json) |

The original AMD2 host was an EPYC 9V45 and was rejected before building/timing.
Each qualified session measured once. Each directory retains reports, full logs,
per-file hashes, original artifact identities and a complete `retained-comparison.tar.xz`.
All downloaded archive digests were verified.

The [instrumented-name audit failure](../scalar-constant-checks-2026-11-05/runtime-audit/README.md)
was repaired without changing measurements. [The combined index](sessions.json)
passes four-session source/host/sample checks. Constructing it exposed missing
derived fields in the initial index and a checker variable that shadowed the
archive path; both are fixed. A regression traverses all four sessions and rejects
a corrupted final reference identity. Final production delivery remains required.
