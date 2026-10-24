# Reusing an unshared array during sorting

This is an unverified preparation. The current accepted behavior copies the
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

No measured result or delivery support is claimed yet. PR #210's final head stays
unchanged while this work is prepared separately.
