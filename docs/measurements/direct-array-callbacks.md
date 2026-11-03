# Direct calls inside scalar array maps

**Status:** [focused native verification](direct-array-callbacks-2026-11-03/README.md)
and [compiler-cost limits](direct-array-analysis-2026-11-03/README.md) pass.
Runtime audits remain. The experiment was declared before implementation against
`e2d55aa81a7830cf7379570944ed7f307c55f7af`. PR #252 has since merged with all final
gates passing. Preserve its [complete timing results](gradient-array-time-2026-11-03/README.md).

## Work to remove

Mapping a known function over an array currently calls the generic function
application machinery for each element. For example:

```fwp
scale = fn x -> x * 0.25
main = array.from-list [2.0, 4.0] | array.map scale | array.to-list | echo
```

The result is `[0.5, 1.0]`. The compiler already knows `scale`; selected native
code should call that function directly for both elements. It must still build
an independent result array and leave any alias of the input unchanged.

The gradient-array change exposed this path in conversion and scaling maps.
The older scalar-buffer map called its function directly. This source difference
is not proof of the timing regressions' cause.

## Selection and ownership

- Initially select only an explicit known function with no captured arguments,
  exactly one parameter, and ordinary scalar parameter/result types: fixed-width
  integers through 64 bits, ISize/USize, F32 and F64. Follow no unbounded call graph.
- Leave dynamic/captured callbacks, wide values, references and records on their
  existing specified path. No new syntax, public API, wrapper, conversion or
  compatibility behavior is needed.
- Emit the selected loop through C generation, using existing typed-array
  accessors and builder cleanup. Do not change array layout or add another
  optimizer pass, temporary buffer or copying stage.
- Evaluate the input once, before allocation. Read all elements in order, including
  packed arrays and views; invoke the callback once per element. Do not interleave
  map with its following zip, skip unused results or move effects/traps.
- The input remains borrowed. Protect the caller's live owners and the partial
  result during callback failure, allocation failure and task cancellation.
  Mark a result slot initialized only after a successful store; return exactly
  one independent owner. Scalar elements add no retain/release operations.

## Verification before timing

Group the implementation with semantic, cleanup, reference and evidence checks:

1. Compare raw interpreter, optimized interpreter and native GCC/Clang O1/O2 for
   empty/singleton/many arrays, numeric widths, conversions, aliases, packed/sliced
   input, eager callbacks, failures and following shorter/empty zip inputs.
   Test rejection of dynamic/captured/wide/reference callbacks explicitly.
2. Keep the existing map/zip and array cleanup controls. Add a selected direct-map
   fault probe for partial output, cancellation and allocation failure; missing
   cleanup must fail. Require no increase in ARC/allocation/live-memory totals and zero
   final managed/raw storage. Verify ordinary and disabled reuse modes.
3. Inspect emitted C and native images. For the selected loop, count one direct
   callback per element and no generic callback application; do not infer this
   from a source comment alone. Preserve callback entry/preemption semantics.
4. Run the same compiler scaling workloads and limits as the gradient-array
   contract. The selector performs constant work per call site using existing
   types; it must not rescan or clone the program.

## Frozen performance comparison

Before measurements, save a same-source reference that disables only this new
selection; verify exact source/patch/compiler identities and corruption controls.
Both compilers keep PR #252's complete gradient-array implementation. Do not use
an older compiler binary or mix input-record/output-list changes into the result.

Use the existing six Rosenbrock coordinate/update pairs, current/history forms,
98-sample schedule and two qualified native sessions per ARM64/AMD64. Keep the
same programs, GCC settings, workspace policy, process repetitions and output.
Require identical-copy variation ≤2%, zero/one-update regression ≤2%, and ≥5%
less elapsed time on larger cases. Keep compiler time/RSS within 5%, largest
reported frame growth within 128 bytes, and report code size separately.

No allocation, retain, peak-managed or raw-buffer increase is allowed. Report
whole-process RSS separately, including increases; allocation counts do not prove
an RSS reduction. Retain every miss or noisy result without rerunning unchanged
measurements for a pass. Accepted policy may retain proven work reductions while
leaving speed goals open; never label missed limits as passed.

After PR #252 merges, publish this as the sole active PR. After focused checks and
the complete measurement audit, run one final nine-job production matrix plus
docs. Merge only after all gates pass, with a one-line squash message. The
unrelated ownership candidates remain unselected.
