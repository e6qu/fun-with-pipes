# Reading numeric arrays without a temporary list

This candidate belongs to steps 7–8 of [PLAN.md](../../PLAN.md). It has no accepted
measurement yet. The [handoff](../development-state.md) records verification.

An array stores elements contiguously. A list stores a head and a link to the next
cell. Converting an array to a list before immediately mapping or folding it can
therefore allocate storage that the calculation does not need:

```fwp
total : Array[F64] -> F64
total = array.to-list | map (mul 3.0) | fold add -0.0
```

This multiplies each element by three and adds the results from left to right,
starting at negative zero. Direct traversal can remove both temporary lists.
It must keep that arithmetic order. It cannot reassociate the sum, contract
multiplication with addition, or stop before an eager stage's first failure.

The compiler uses its existing typed loop and callback proof. Known numeric
map/filter stages can read the array directly; unsupported callbacks retain
their existing implementation. Retained inputs and slices keep their owners.
Effectful stages, distinct possible traps and early stopping keep the existing
fusion restrictions. For a returned list, callbacks proved total, pure and free of owned captures may
visit elements backward and prepend results directly in source order. This avoids
copying a reversed list. Folds and possibly trapping callbacks retain forward
order. No new language syntax or runtime primitive is introduced.

## Gradient results

Reverse-mode AD records operations, traverses their dependencies backward and
returns one derivative per input. `rev._backward-float` currently obtains an F64
array, converts it to a list, then maps `float.convert` to the requested format.
Direct traversal removes the first list. The conversion remains: narrower
formats round, and NaNs must retain the supported conversion behavior.

The runtime phase observer measures tape setup, forward work with recording,
reverse setup, reverse traversal, result-array construction and tape retirement.
The final list/conversion happens **after** those phases. Whole-solve and
allocation comparisons include it; none of those six phase clocks isolates it.
Forward time also includes the objective and temporary values, not just recording.

## Counts and correctness

`numeric_array_fusion` supplies dynamic arrays of 0, 1, 129 and 4,096 elements,
ordinary/sliced inputs, retained aliases and packed/word storage. At O1/O2 it
compares one compiler with `FWP_ARRAY_FUSION=1` and `0`. A returned mapped or filtered list
must remove at least one allocation and 24 requested bytes per element. A scalar
fold must allocate no element list. Every element and input alias is checked;
live storage and cleanup records must return to their initial state.

Separate raw-interpreter/native controls cover rounding, signed zero, infinities,
NaNs, reused lists, callback output, distinct traps and early stopping. Existing
AD checks cover nested gradients, capacity, stale nodes, failure, cancellation,
workspace reuse and physical release. A count reduction does not establish speed.

## Whole-solve comparison

Run `array-list-measurements` on native Linux ARM64/AMD64, two sessions each.
Record the actual CPU and toolchain before building. Require four available CPUs;
CPU models may differ between sessions. Each candidate/reference comparison is
within one host, with the same compiler and flags. These sessions do not replace
the older matching-host [D2](descent-costs.md) or [N1/N2](kernel-baselines.md) rules.

Use GCC O2, the architecture baseline, no LTO, no fast math and no contraction.
C/Rust compute explicit derivatives, so their ratios include different algorithms.
Seven labels cover AD current/history with fusion on/off, an identical candidate
copy, C and Rust. The off setting disables all numeric array fusion, including
formatting: whole-solve differences cannot be attributed solely to gradient lists.
The direct boundary probe above establishes the narrower allocation claim.

| Coordinates | Updates | Solves per process |
|---|---:|---:|
| 3 | 0 | 32,768 |
| 3 | 1 | 512 |
| 3 | 199 | 32 |
| 3 | 1,999 | 4 |
| 33 | 199 | 32 |
| 129 | 199 | 8 |

Use two warmups and 49 measured rounds, seven processes per label/round, seed
20261101. The existing balanced 49-entry cycle supplies the complete retained
order. Time includes launch, repeated complete solves, full output and cleanup;
compilation and verification are outside it. Check every coordinate against the
analytic oracle at absolute/relative tolerance 1e-10 and require repeatable output.
Run the phase observer separately in twelve alternating pairs after two warmups;
report its effect on total time. Keep profiles and RSS separate from timing.

Require candidate/reference time at most 1.02 and identical-copy variation at
most 2%. Require at least one fewer 24-byte cell per input per gradient, no extra
retains/peak charge, identical raw tape storage and zero final storage. Preserve
the existing comparison's +1,024 instruction-byte and +128 static-frame-byte
screens. These are measurement requirements, not universal runtime guarantees.
Save all failing/noisy cases, sources, binaries, commands, profiles and samples.
Never retry unchanged cases or relax limits to obtain acceptance.

## First candidate: output reversal still copied

At `dc0a6407`, the direct fold meets zero-allocation requirements. The returned
mapped list fails the frozen savings rule: at length 129 it allocates 258 cells
versus 259 allocation requests in the reference (6,192 versus 7,232 requested
bytes). The input list is gone, but generated C calls the borrowing `reverse`
primitive, which copies the newly built result. Length one saves only 16 bytes.
Correctness, alias, cleanup and all separate AD tests pass on the first completed
Linux ARM64 job in run `41252379702`; this is not acceptance of the cost change.

The repair uses backward traversal only under the total-callback proof above;
its measurements are pending. Original limits remain unchanged. The probe now
collects all cost failures across both storage modes before reporting them.
