# Reusing an unshared array during sorting

This preparation passes focused native checks; full delivery is still required. The current accepted behavior copies the
array and retains its elements before sorting. The proposed change consumes
one array reference: it reuses storage when there is only one owner, and copies
when another owner or a view needs the original values. Source code stays
immutable; using an array again makes the compiler preserve that owner.

For example, `words | array.from-list | array.sort` can hand its intermediate
array directly to sorting. If a program keeps the unsorted array too, sorting
must leave it unchanged. Empty and singleton arrays are already sorted and can
transfer the existing reference without copying.

## Representation and cleanup

A sort key for an ordinary element fits in one machine word. A 128-bit float
instead uses a pointer into the array's original bytes. Writing sorted values
back one by one could overwrite a value still needed later. The preparation
applies the sorted permutation in cycles, saving one sixteen-byte value on the
stack. This must preserve every bit, including stable ordering of equal values.

The input, output and both temporary buffers need explicit cleanup on allocation,
comparison failure and cancellation. Reuse verification may require copying unique
storage; that copy transfers children without extra retains. Shared copies retain
children. Views retain their original backing until sorting has finished.

## Required checks before acceptance

- Compare current native output with the interpreter without optimizations, using
  dynamic strings, small integers and 128-bit floats; include empty, singleton,
  sorted, reversed, duplicate and mixed inputs.
- Check live aliases, array views, distinct permutations and unchanged original
  values. Detect deliberately unsafe wide-value overwrites and shared mutation.
- Interrupt allocation/retain/comparison sites and cancellation; require repeated
  zero managed balances. Keep tracing stress, verification and reuse controls.
- Run production GCC/Clang at O1/O2 on all six native targets. Inspect actual
  executables and retain source, status and toolchain metadata.
- Measure requests, requested bytes, retains, peak and final charge against an
  explicit control that restores copying. Record ordinary code sizes and stack
  frames separately from instrumented counts. Use the same input family as the
  [existing sort-storage comparison](list-sort-storage.md). Do not infer elapsed
  speed or C/Rust parity from allocation savings.

The count comparison has three rows: list scratch buffers, array scratch buffers,
and array ownership. The last row uses the same generated program twice, changing
only the sort's uniqueness decision to force a copy. Inputs contain 0, 1, 32 or
4,096 words; each case records three identical observations at O1/O2. Counting
starts after constant initialization and includes parsing, construction, output
and language cleanup. It excludes allocator metadata, raw runtime buffers and
stack storage. Empty/singleton arrays transfer their reference in both variants.

A separate comparison compiles the ordinary string/128-bit fixture into four
objects: reuse and forced-copy variants at O1/O2. It saves compiler stack reports
and inspects the actual object bytes. External floating-library code is not in
these objects; per-function stack reports do not measure maximum call-stack use.
Executable correctness comes from the native tests, not these unlinked objects.

Focused source `e78069765ac5798f71d7e11d216bcb71d6850d21` passes all six native
jobs in [run 40095196564](https://github.com/e6qu/fun-with-pipes/actions/runs/40095196564).
Every completed log is clean. Independent executable review has passed on Windows
AMD64 and Linux ARM64; the other four reviews are pending. No measured storage or
layout result, timing gain or final delivery support is claimed yet. PR #210's final head stays
unchanged while this work is prepared separately.
