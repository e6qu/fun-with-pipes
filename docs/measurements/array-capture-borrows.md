# Reading captured arrays without extra owners

A callback is a function another function calls. A capture is a value it keeps
for those calls. During array generation, for example, a callback can read an
existing weights array at each index to compute a new value. The existing array
must stay alive for the whole generation, but each read need not create another
owner. An owner is responsible for keeping storage alive and eventually releasing
it; a borrow uses that storage while its owner remains alive.

The compiler gives eligible known numeric callbacks a borrowed calling convention.
Their caller keeps captures alive across the generation loop. The callback's body
uses those existing owners; it acquires a separate owner only when a value must
outlive that use, such as when storing an array in state. The output array still
has its own heap buffer. This change does not make array generation allocation-free.

For example, the [complete read fixture](../../tests/fixtures/array_capture_reads.fwp)
defines a checked `read-index`: given an array and an index, it returns that element
or traps if the index is invalid. Its copy operation is:

```fwp
copy : Array[F64] -> Array[F64]
copy = fork array.generate array.length read-index
```

`F64` is a 64-bit floating-point number. The signature says `copy` takes and returns
an array of those numbers. `fork f g h` applies `g` and `h` to the same input, then
passes their results to `f`. Here, `array.length` supplies the output count and
`read-index` supplies a function that remembers the input array.

`array.generate`
calls that function for indices zero through count minus one. Copying
`array[0.0, 1.25, -2.5]` therefore returns those same elements in a new array;
the original remains usable. The caller keeps the input alive while the callback
reads it, so those reads need no extra counted owner.

## Why borrowing at entry was insufficient

The first implementation passed the focused native tests but failed the application
count requirement on both Linux architectures. The three-coordinate, 199-update
program still performed 597 retains: one per coordinate update. The borrowed
callback immediately built a temporary pair from its array and index, acquiring
an array owner inside that pair. Borrowing at entry had moved the retain.

The ownership pass now eliminates this temporary owner when a record's fields are
caller-borrowed parameters and all uses project a field or pass the temporary to
a proved nonescaping call. A nonescaping call cannot keep that record after it
returns. The caller's owners stay alive throughout.

The first repair exposed a second
source of the same retain: a local alias at the last read. Normalization now
revisits aliases exposed by forwarding and uses the caller's lifetime even when
there is no later local read. Whole-record escapes,
unknown consumers and resource boundaries preserve ordinary ownership; returning
a projected field still acquires an owner for the result. Compiler tests check
repeated borrowing and both projected-field and whole-record escapes.

No new syntax or user annotation is needed. The generator requires a known target
and scalar numeric result; recursive callbacks and resource scopes retain their
existing calling convention. This is a specific optimization, not a claim that
all closures avoid counts or that every lifetime can be inferred.

## What is checked

The [read fixture](../../tests/fixtures/array_capture_reads.fwp) keeps the original
array alongside a generated copy. Native checks require the correct values, no
capture retains during generation, and zero remaining managed charge before
runtime teardown. Empty and negative lengths invoke no callbacks. Deliberately
adding a retain/release pair must fail the count observer; leaking an owner must
fail the cleanup observer.

The [effect fixture](../../tests/fixtures/array_capture_effects.fwp) stores a capture
in state, fails after writing two output elements, yields, and cancels a task at
that same partial-output point. Tests require both error and cancellation to reach
partial-array cleanup. A separate control skips those releases and must fail.
The original input remains usable throughout. Values agree with raw interpretation.

The [order fixture](../../tests/fixtures/array_capture_order.fwp) prints count
preparation before capture preparation, then callback indices 0, 1 and 2 before
its result. Zero and negative lengths still prepare captures but call no callback.
Its O0/O2 native checks agree with the interpreter, with stack placement on/off
under both ownership modes. Their executions are recorded in the complete logs;
they are additional to the saved observer images counted below.

Tests compile C at O0 and O2, with stack placement on/off, checked ARC and tracing.
Tracing controls also enable collection stress, heap verification and reuse checks.
The observer measures managed allocator charge, not process resident memory or
system allocation counts. These tests check ownership and observable behavior;
they do not time the implementation or compare its speed with C/Rust.

## Evidence and limits

Compiler source `80d8f27e1bf57e4665503d6d1ed1af261f7dc672`, tag `roadmap/revision-array-captures-80d8f27e1bf5`, passes five native jobs and width checks in
[run 39783028890](https://github.com/e6qu/fun-with-pipes/actions/runs/39783028890). Linux AMD64's
native checks passed, but a new compiler unit fixture incorrectly expected a list
alias to qualify for an optimization that excludes algebraic lists. The corrected
fixture tests eligible numeric arrays and verifies that excluded list aliases keep
their owners, including returned values.

It changes no production compiler code.
Linux AMD64 passes in [repair run 39789349262](https://github.com/e6qu/fun-with-pipes/actions/runs/39789349262),
source `3e5763b69ed075516bcbadf5d18dcb2a12f98078`; the failed original job remains in the data. The audit step
now executes all independent checks before returning failure if any failed.
Linux uses production GCC, macOS Clang and Windows LLVM-MinGW.

Neighboring checks
cover folds, array failures, field moves, foreign callbacks, libraries and ARC
execution. Linux AMD64 also runs compiler unit tests and contract inventories.

[Retained evidence](array-capture-borrows-2026-10-22.json) includes complete-log
audits and independent inspection of **558 native images**: each host contributes
48 capture controls and 45 neighboring images. Inspection checks actual machine
instructions, architecture, source/binary hashes, output and deliberately broken
controls. ARC images omit tracing entry points.

The additional 32-bit job executes pointer-width interpreter checks and twelve
WASI modules. These preserve the existing foreign-storage boundary; they are not
native-platform evidence or a new WASI array-generation benchmark.

Application measurements must separately establish the declared zero-retain
requirement, allocation/peak budgets and remaining C/Rust costs. [PR #197](../roadmap-history.md#borrowed-array-captures-pr-197) records passing final-head production and documentation.
Those delivery checks are separate from the focused measurements above.
