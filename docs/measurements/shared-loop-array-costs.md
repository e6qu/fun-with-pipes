# Shared loop and array costs

This is milestone 1's investigation, starting from merged PR #269
(`bbcaafea00d6bf9e26feea60f90d8d440aa16d00`). No speed improvement is accepted yet.
[The roadmap](../../PLAN.md) defines the final correctness and performance gates.

## First question: can C optimize across the array callback?

The saved local-derivative program generates one output array per update. For
each coordinate it calls a borrowed callback: the input stays alive outside the
call, so reading it needs no retain/release pair. The callback still reads array
headers and bounds, handles the first/last coordinate and performs scalar math.

```text
input array → generate loop → callback(input, index) → output element
                              ├─ read current and adjacent coordinates
                              ├─ calculate contributions in source order
                              └─ return the updated coordinate
```

The C backend may inline a small callback but leave a larger one as a call.
Inlining means placing its body inside the loop. This can expose invariant
array metadata and index relationships to the C optimizer. It does not itself
prove faster execution, fewer bounds checks or vectorization.

Two source observations rule out premature fixes:

- F64 `from-float` is a bit-preserving round trip through runtime helpers; it
  does not use the software F128 conversion path.
- The checked integer loop already uses unboxed state and no scheduler ticks.
  Its repeated-looking multiplication intentionally exposes operand ranges after
  the overflow check. [The earlier experiment](checked-products.md) explains why.

## Diagnostic comparison, before a compiler change

`scripts/diagnose-loop-arrays.py` runs only on native Linux GitHub runners.
It emits current C and compares two versions of that same source:

| Version | Only difference |
|---|---|
| Original | Current generated declarations |
| Inline | Add `inline __attribute__((always_inline))` to borrowed array callback definitions |

Both keep all arithmetic, bounds checks, ownership, cleanup and evaluation order.
The script rejects unexpected declarations and retains the full source diff.
There is no production compiler change at this stage. This experiment tests
whether a call boundary matters; it does not authorize unrestricted inlining.

Inputs are fixed before execution:

- Checked integer loop: 0, 16, 1,000,000 and 100,000,000 iterations. It has no
  borrowed array callback and is an unchanged-source control.
- F64 array generation/map/fold: 0, 16, 65,537 and 262,145 elements. Each generated
  value reads the immutable input at the same index, multiplies by 3 and adds 1;
  the fold adds left to right from `-0.0`.
- Manual and local-automatic neighboring-pair derivatives: 3, 33 and 129
  coordinates, 199 updates, 32 independent solves. Three-coordinate 0/1-update
  cases check setup and short work. The existing fixtures define the formulas.

Build with GCC O2, the host's explicit generic architecture, FP contraction off,
no fast math and no LTO. Retain GCC inlining reports, compiler/host identities,
source/executable hashes, full commands and outputs. Check raw interpretation
against both binaries before timing; use analytic checks for the large loop and
array cases so interpretation does not require millions of iterations.

Two warmups precede 16 measured rounds. Four roles (original, inline and one
byte-identical copy of each) rotate through every position four times. Record
every whole-process observation, including startup, output and cleanup. Copy
variation above 2% makes that comparison inconclusive. These short diagnostic
timings select further work; they cannot satisfy the roadmap's two-session,
compute-time acceptance or establish parity with C, Rust or Swift.

Before accepting a compiler change, freeze its selection/exclusions and measure
the affected computation separately from construction, printing and teardown.
Use unchanged loop cases as guards. Retain allocation/live-memory, compiler,
code and stack costs as required by the roadmap; preserve misses and noise.
