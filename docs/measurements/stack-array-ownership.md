# Moving an array owner out of a temporary record

An owner keeps storage alive and is responsible for releasing it. A move transfers
that responsibility without adding another owner. The compiler now uses a move
when extracting the sole counted numeric-array field from an eligible temporary
record on the stack. Other live aliases keep their existing owners.

For example, consider a temporary pair containing an array and the integer `7`.
After inspecting the pair, a function returns its array field and never uses the
pair again. Previously this path added an array owner for the result, then removed
the pair's owner. The result can instead take over the existing owner. The integer
needs no cleanup, and the array remains alive until the result is released.
The array's buffer still lives on the heap; moving its handle does not move its data
onto the stack or prove that the whole program is allocation-free.

## When the compiler can do this

The C generator requires a dying stack record with exactly one tracked child,
matching the selected field's numeric-array type. Array elements must have an
inline scalar representation. Other record fields must not need counted cleanup,
and the record must not occupy a protected resource slot. The ownership instruction
sequence must select the field, duplicate it and immediately drop the parent.
Only that redundant duplicate/drop pair is removed. The result still releases its
owner normally, including on failure and cancellation.

The rule does not require the array itself to be uniquely owned. If another value
shares the array, moving this one reference neither increments nor removes that
other owner's reference. Nested storage, resource-owning siblings and other
record representations retain their existing rules. No source syntax changes.

## What the tests verify

[The existing projection test](../../tests/boxed_projection_ownership.rs) builds
a record, hashes it while borrowed, then extracts the array. Hashing the whole
record keeps this test on the stack-record path rather than the already supported
separate-field representation. The interpreter checks the value and failure result.

[The native observer](../../tests/fixtures/stack_array_projection.c) repeats unique
and shared-owner cases 64 times. It checks the same array handle and contents,
no extra retains during projection, and complete cleanup. Separate repetitions
fail or cancel after ownership transfers and check that cleanup still releases
it. Tests run at O0/O2 with ARC and tracing; tracing also uses collection stress,
heap verification and reuse checks. Two deliberately broken versions restore the
extra retain or omit the result release and must fail with codes 201 and 204.
These controls test that the observer can detect the mistakes being prevented.

## Evidence

Source `026db07bacbe0c1b60ae78b92d008d2039f84761`, tag
`roadmap/revision-stack-array-026db07bacbe`, passes all six native hosts and the
32-bit/WASI job in
[run 39767702114](https://github.com/e6qu/fun-with-pipes/actions/runs/39767702114).
The `pointer-ownership` workflow also checks neighboring field/array transfers,
array loops, callback copies, foreign buffers, library cleanup and the ARC corpus.
Each native host passes 28 integration test functions; Linux AMD64 also passes
176 compiler unit tests. Linux uses production GCC, macOS Clang and Windows
LLVM-MinGW. The additional 32-bit checks establish that boundary, not a native OS.

[The retained evidence](stack-array-ownership-2026-10-22.json) contains all seven
complete-log audits, outputs and hashes. All **270 native images and 12 executed
WASI modules** were independently inspected. Each native host contributes 14 new
array-move executables plus 31 neighboring callback/buffer/library images. Checks
cover actual instructions, architecture, generated C, tracing exclusion in ARC
and the deliberately broken cleanup controls.

These results establish correctness for the tested rule and cases. They do not
establish a general speedup, zero heap use or zero ARC. The [numerical comparison](array-owner-moves.md)
compares the candidate with the previously accepted generated C,
including slower small cases and ARM64's larger callback frame. Delivery acceptance
still requires all production jobs and documentation for the final PR commit;
see the [handoff](../development-state.md).
