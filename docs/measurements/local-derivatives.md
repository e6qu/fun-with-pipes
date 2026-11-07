# Remove the global tape from local objectives

## Why this experiment

The [latest complete solves](tape-record-time-2026-11-07/README.md) take
10–13.5 times the handwritten C derivative's time on the largest input.
Recording and backward traversal dominate the saved derivative phases.
Changing tape layout did not meet any of its 32 long-case speed targets.

Test a change in the **structure exposed by the program**, rather than another
tape layout. No parser change or handwritten derivative is required.

## Calculation and proposed interface

Consider an objective built from neighboring pairs:

```text
F([x0, x1, x2]) = edge(x0, x1) + edge(x1, x2)

dF/dx0 = first partial of edge(x0, x1)
dF/dx1 = second partial of edge(x0, x1)
         + first partial of edge(x1, x2)
dF/dx2 = second partial of edge(x1, x2)
```

A partial derivative changes one input while holding the other constant.
`Dual` already carries a value and its derivative through ordinary arithmetic.
Seed the changing input with derivative 1 and the constant input with derivative
0. Evaluate `edge`, then read the resulting derivative. The compiler can
specialize this fixed-size arithmetic without recording a tape.

Prototype a function taking `(Dual[F64], Dual[F64]) -> Dual[F64]` and an immutable
`Array[F64]`. It returns one gradient value per coordinate. Each interior
coordinate evaluates the preceding and following edge once each, in that order;
endpoints evaluate one edge. Empty and singleton arrays have zero contributions.
The Rosenbrock edge is `100 * (y - x*x)^2 + (1-x)^2`; its derivative is **not**
written by hand in the candidate.

This exploits known local dependencies. It is not a replacement for `grad` on
arbitrary functions, and does not claim that general reverse differentiation can
avoid all intermediate storage. A public name/API is decided after measurement.
Initially keep the prototype in a test fixture.

## Semantic boundary

- Existing `grad`, tape validation, nested reverse mode and cleanup stay intact.
- The new calculation uses existing `Dual` rules and ordinary checked indexing.
  It does not silently change `grad` evaluation or contribution order.
- Forward and reverse differentiation can round differently. Compare each
  native program exactly with its own unoptimized interpreter; compare complete
  solves with the independent analytic oracle at absolute/relative `1e-10`.
- Test empty/singleton/two-element inputs, endpoint contributions, constant and
  nonlinear edges, input aliases and a trapping edge. State callback order.
- F64-only, pure callbacks are the first boundary. Do not promise nested, wide,
  effectful or arbitrary sparse graph support from this experiment.

## Frozen measurement

Use the existing complete-solve driver, GCC `-O2 -fno-fast-math
-ffp-contract=off`, architecture baselines `armv8-a` / `x86-64`, and no LTO.
Inputs alternate -1.2 and 1.0; the update size is 0.001.

| Coordinates / updates | Solves per process | Processes per label per round |
|---|---:|---:|
| 3 / 0 | 32768 | 7 |
| 3 / 1 | 512 | 7 |
| 3 / 199 | 32 | 7 |
| 3 / 1999 | 4 | 7 |
| 33 / 199 | 32 | 7 |
| 129 / 199 | 8 | 7 |

Seven labels: ordinary reverse AD, local forward AD, handwritten fwp lists,
handwritten fwp arrays, handwritten C, handwritten Rust, and a byte-identical
copy of ordinary reverse AD. Same current compiler for every fwp program.
Keep 98 balanced rounds, two warmups, the existing process-order seed 20261029,
and two independent sessions per architecture. Record actual CPUs and toolchain
versions. Use Neoverse-N2 or the already approved AMD EPYC 7763/9V74/9V45 hosts.

Report absolute elapsed time and every peer ratio, managed allocations/retains,
raw tape storage, peak RSS, compiler costs, instruction bytes and stack reports.
Elapsed time includes process launch, repeated solves, complete output and exit;
compilation and instrumentation are outside timing. Storage observers must show
zero tape activity for the local candidate and zero live storage at exit.
The manual peers perform different derivative arithmetic and may reuse storage;
ratios do not isolate language overhead. Keep emitted C and source hashes.

## Decision

Require at least **20% less elapsed time** than ordinary reverse AD in all four
positive long cases, no greater than 2% regression in the zero/one-update cases,
and at most 2% difference between identical copies, in both sessions per host
architecture. These limits are declared before implementing the prototype.
Report missed limits without repeating unchanged qualified sessions.

If the candidate qualifies, promote the structured operation with documented
semantics, examples and regression coverage in this PR. If it does not, use the
handwritten fwp comparison and emitted source to identify the remaining work;
do not publish an API on the strength of allocation counts alone. Prior timing
misses remain historical results, not targets this new comparison can erase.
