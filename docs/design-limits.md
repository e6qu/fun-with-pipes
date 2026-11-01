# Design goals and practical limits

A goal needs a named workload, input, host, semantic contract and measured budget.
Set limits before testing a candidate; retain regressions and inconclusive results.
Correctness obligations extend beyond the benchmark cases.

## Ownership and cycles

**Feasible:** prove moves, borrows and bounded lifetimes; count necessary sharing.
**Not promised:** automatic reclamation of every owning cycle using ordinary ARC.

```mermaid
flowchart LR
    Q["Queue"] -->|owns| C["Callback"]
    C -->|captures a strong owner| Q
```

Neither object reaches zero owners merely because outside references disappear.
fwp rejects unproved relationships of this kind. A weak back-link observes the
queue without owning it; acquisition can fail after the final strong owner goes.

- [Weak channels](weak-channels.md) are implemented. Closing preserves queued
  messages; silently draining them to break a cycle would change behavior.
- [Scoped parser storage](parser-workspace.md) proves one grouped lifetime.
  General region relationships are not implemented.
- Foreign code must obey explicit lifetime/release contracts. fwp cannot prove
  arbitrary host behavior or remove a JavaScript host's collector.
- Bounded storage means bounded by live data and declared workspace/cache limits.
  A program that keeps adding results needs growing storage.
- Memory safety is not universal leak freedom; even Rust permits reference cycles
  ([explanation](https://doc.rust-lang.org/book/ch15-06-reference-cycles.html)).

[Accepted ownership design](gc-removal-design.md) states fwp's chosen tradeoffs.
[Perceus](https://www.microsoft.com/en-us/research/publication/perceus-garbage-free-reference-counting-with-reuse/)
is research precedent for functional reuse, not evidence for fwp's contracts.

## Compiler analysis

Use finite summaries and revisit changed dependencies. Measure analysis time,
memory and specialization growth as inputs grow; preserve the
[G2 budgets](measurements/ownership-analysis.md).

More precise types cannot decide every runtime lifetime. Conservative rejection
is permitted; unbounded search for an exact proof is not. A terminating analysis
is not necessarily linear-time.

## Abstraction and native code

| Pattern | Achievable result | Necessary limit |
|---|---|---|
| Known curried calls | Direct calls without intermediate closures | Preserve computation between argument stages. |
| Escaping function | Store its captures efficiently | Runtime captures must live somewhere. |
| Unknown callback | Share or borrow safely | Indirect dispatch may remain. |
| Collection fusion | Remove intermediate collections | Preserve effects, termination and first failure. |
| Immutable reuse | Update unique storage | Keep older shared values unchanged. |
| Native layout/code | Improve measured time and working memory | Padding, decoding, register spills and cache tradeoffs remain. |

For example, two strict traversals cannot always become one interleaved loop:
that can run a second-stage effect before a first-stage failure. “Zero-cost”
therefore describes proved patterns, not every higher-order program.

The C backend delegates instruction selection and register allocation to mature
compilers. Universal C/Rust parity or optimal register/cache use is not an
acceptance criterion. Compare equivalent arithmetic: checked overflow and ordered
floating-point operations restrict legal transformations. LLVM's
[vectorizer documentation](https://llvm.org/docs/Vectorizers.html) explains reduction
restrictions; strict arithmetic does not prevent every form of vectorization.

## Numerical work

- Reverse differentiation stores intermediate information or recomputes it.
  Checkpointing trades memory for replay; fwp exposes it for pure steps.
- Gradient/Hessian outputs need space proportional to their returned values.
  Arbitrary derivative nesting cannot have constant cost.
- Preserve F128's arithmetic without promising F64 speed or exact real arithmetic.
  A branch derivative does not create a derivative at a discontinuity.
- Improve serial/parallel CPU kernels while preserving rounding and reduction
  order. GPU execution is outside this roadmap; JIT is excluded.

See [implemented numerical contracts](numerics.md#reverse-mode) and the
[AD survey](https://www.jmlr.org/papers/v18/17-468.html).

## Evidence and validation

| Evidence | What it can establish | Limit |
|---|---|---|
| Repeated same-host comparisons | A useful change for stated inputs | No universal speedup or noise-free overhead number |
| Allocation and live-storage counters | Specific costs and release behavior | Not whole-process resident memory |
| Representative programs | Maintained behavior and usability cases | Not correctness of every possible program |
| Inferred ordinary types | Fewer annotations | Generic signatures remain explicit |

[Benchmarks](benchmarks.md) define comparable work and overhead.
[Ownership](ownership.md#cycle-and-retention-contract) defines lifetime boundaries.
[Tail calls](design.md#tail-calls-and-recursion) define frame-reuse limits.
[PLAN.md](../PLAN.md) owns priorities; this page owns feasibility limits.
