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

## Decision after the first diagnostic

Run `42433452458`, source `7a8d24c2e`, passes all value checks on native ARM64
and AMD64. Forced inlining does not qualify as an optimization: the largest
manual/local cases take 1.11–2.04% more process time on ARM64 and 1.17–1.59%
more on AMD64. Their copy controls pass. Many smaller cases fail copy controls;
unchanged loop sources also vary. Keep these observations; do not rerun this
unchanged candidate for a pass. The compiler remains unchanged by this experiment.

## Selected implementation: borrowed array metadata

Freeze this scope before changing the compiler:

1. Select an already-proved borrowed `array.generate` callback with a directly
   read captured `Array` of immediate scalar elements. The surrounding call owns
   the capture throughout generation. Unknown callbacks, recursive/resource
   callbacks and unsupported element representations retain their existing path.
2. Resolve each selected capture's data address and length once in the generator,
   after evaluating the original arguments. Pass those two values to the existing
   borrowed callback entry. No new closure, array, ownership count or source API.
3. Read from that address using the existing packed stride and byte-copy rules.
   Preserve sign extension and floating-point bits. Keep every negative/index
   bounds check and every source arithmetic operation in its original position.
4. Treat metadata as a borrow, never an owner. The ordinary captured owner keeps
   owned arrays and slices alive. Returning, sharing or replacing other values
   cannot invalidate it. Do not propagate an address into escaping values.
5. Traverse each callback body once to find direct reads. Do not follow unknown
   calls, clone whole programs or introduce a fixed-point search. Charge compiler
   time/RSS and compare two distinct program patterns: indexed array mapping and
   neighboring-coordinate updates, including handwritten and local AD formulas.

Correctness controls cover empty/shared/sliced arrays, signed and unsigned packed
lanes, F32/F64 bits, negative/large indices, multiple captures, retained aliases,
callback effects and failures, allocation failure, cancellation and reentry.
F128 and reference-bearing element access keep their existing rules. Comparison
builds disable only this selection; all other compiler/runtime code is identical.
Final timing acceptance remains the roadmap's two-session, two-architecture
compute-time contract. This source-cost reduction is not itself an accepted gain.

### Computation-time comparison

The `array-metadata` runner suite builds the candidate and an isolated compiler
whose metadata selection is disabled. The selection patch and source hashes are
retained; runtime, ownership and other optimizations are identical. It requires
passing focused GCC/Clang checks for the implementation before measuring.

`scripts/measure-borrowed-arrays.py` uses the 18 inputs above. A C driver calls the
ordinary compiled `measure` entry with a fresh input each time. Clocks surround
calls; there are no clocks or allocation counters inside their bodies.

| Timer | Includes | Excludes |
|---|---|---|
| Construction | Allocate and fill the input array (or supply the loop count) | Work on that input |
| Computation | The generated function, its internal allocations and cleanup of consumed inputs/intermediates | Input construction, result validation, release of the returned array, printing |
| Result release | Release the returned derivative array | Internal cleanup already performed by the function |
| Whole driver loop | All three phases plus result validation and timer calls | Runtime startup and printing |
| Whole process | Launch through exit, including output | Compilation |

The map/fold returns a scalar, so it releases its intermediate array inside the
computation. A derivative solve returns an array, released after validation.
The C driver keeps no extra input alias; this is the ordinary consuming-call
contract. It checks exact result bits and unchanged live managed storage after
every repetition. Raw interpretation supplies derivative oracles; exact formulas
check large loops and maps. The empty fold's `-0.0` bit is preserved.

| Cases | Repetitions per process |
|---|---:|
| Loop 0 / 16 / 1,000,000 / 100,000,000 | 4,096 / 4,096 / 16 / 1 |
| Map/fold 0 / 16 / 65,537 / 262,145 | 4,096 / 4,096 / 16 / 4 |
| Each derivative form: 3/0, 3/1, 3/199, 33/199, 129/199 | 4,096 / 1,024 / 32 / 32 / 8 |

Two warmups precede 24 measured rounds per session. Candidate, reference and a
byte-identical copy of each rotate through all positions six times. Use two
independent sessions per native ARM64/AMD64 architecture. Record the qualified
CPU/compiler identity, sources, binaries, stack reports, every command and sample.
Apply the frozen 2% copy limit independently to computation and process times;
a qualified process result does not qualify an unreliable computation timer.
These are paired fwp comparisons, not new C/Rust/Swift comparisons. Separate
allocation, RSS and compiler-cost observations are still required for delivery.

## Fresh-output diagnostic

The first two metadata sessions on ARM64 miss the 10% computation target:
large maps save about 1%, manual derivatives 3–5%, and local derivatives roughly
0–1%. The complete four-session audit will retain every outcome. Do not treat a
successful measurement job as accepted performance.

The next experiment changes only writes into a newly allocated F64 result array:

```text
allocate output → protect its owner → for each index:
                                      call the unchanged callback
                                      write eight result bytes
                 → finish the existing cleanup scope
```

The original store checks whether the output is a view on every iteration.
The builder also increments its initialized-element count, although F64 elements
have no destructor. The diagnostic resolves the fresh output address once and
writes with `memcpy`; it omits only that view check and counter update. Allocation,
count validation, callback order, arithmetic and whole-array failure cleanup stay
unchanged. Neither input reads nor bounds checks change.

`scripts/diagnose-array-builder.py` starts from the retained **reference** C in
run `42435795842`, so metadata caching is disabled on both sides. It accepts only
the exact generated fresh-builder shape with an immediate F64 descriptor and no
element destructor. Unknown shapes fail the experiment. This is not a change to
general array mutation or to production code.

Use the same 18 inputs, driver, repeat counts, GCC O2/strict floating-point flags,
two warmups and 24 rotated four-role rounds. Run once on native ARM64 and AMD64,
with the existing 2% computation/process copy controls. Retain every source diff,
binary, command, result and timing. The unchanged integer loop is a control.
This diagnostic selects a possible implementation; milestone acceptance still
requires two sessions per architecture and the complete correctness/memory gates.
