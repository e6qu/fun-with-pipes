# Checking record cleanup without tracing

A record groups named fields. Updating one field produces a new value; any
older value still visible to the program must remain unchanged. Here `String`
means text, `I64` is a signed 64-bit integer, and `Box -> Box` describes a function
that takes and returns a `Box`:

```fwp
Box = { name: String, code: I64 }
rename : Box -> Box
rename = with { name = "new" }
```

`rename` replaces the name and keeps the code. The compiler may reuse a record
whose only owner is consumed by the call. If another owner keeps the old record,
the update must copy its fields and preserve that owner's name.

## What the checks exercise

Three native tests now emit both checked ARC and tracing code:

- [Record updates](../../tests/record_update_ownership.rs): replacing an owned
  field, with and without an independently live alias.
- [General copies](../../tests/general_record_update_ownership.rs): returning
  both the original record and its updated copy.
- [Field conversion](../../tests/record_conversion_ownership.rs): passing boxed
  record fields into an internal C function that takes the fields directly.

They use dynamic storage, emit probe C with explicit O2, and compile that C at
O1/O2. Complete programs also run at O1/O2 and compare with the unoptimized
interpreter. C probes also
force count overflow partway through acquiring field owners, then check cleanup
of the completed fields, unfinished copy and remaining caller values. Deliberate
removal of each cleanup must fail its corresponding observation.

Each probe repeats 32 rounds. After every ARC round, its allocator byte charge
must return to the starting value, with no wide-count entries or collections.
Removing a final fixture release must fail with status 90. Tracing keeps its
existing stress and poisoned-storage checks; it is not used to reclaim ARC work.

## A defect found in the old fixtures

Counts above 254 use a separate count entry; the object's one-byte count slot
contains the marker 255. To force overflow, these tests deliberately invent
counts that do not represent real aliases. Their cleanup must discard that
invented state and restore the fixture's actual sole owner.

Five fixtures previously set the separate count to one but left marker 255 in
the slot. The final-release check therefore skipped freeing the value. One
record-update round retained 64 bytes and four count entries. This was a test
fixture defect, not evidence of a product-runtime leak.

Cleanup now uses the existing `fwp_rc_fresh` operation to clear wide metadata
and set the inline count to one. The related
[variant conversion](../../tests/variant_conversion_ownership.rs) and
[retain-overflow](../../tests/retain_unwind_ownership.rs) tests also check that
no wide entries remain, and deliberately restore the old mistake to prove
that the observation detects it. No runtime ownership rule changes.

## Evidence and limits

Local Apple Clang/ARM64 checks passed 18 inspected record-probe binaries and 24
observations at O1/O2. The two related overflow fixtures passed eight binaries
and twelve observations, including the broken-cleanup controls. These checks use
the accepted #197 compiler with the exact current runtime substituted into its
generated C; new-compiler and cross-platform acceptance remains a CI requirement.

Focused GCC/AMD64 run `39922765292` at `df84b726cc2a2a37fbaf7c1cca53aacc93cc8bb8`
passed all twenty selected targets (65 integration tests), 179 library tests and
independent audits. Inspection verified eighty saved record outcomes, including
the deliberate failures, plus fifteen default/allocator binaries. This establishes
focused Linux evidence; full native acceptance still requires all six hosts.

CI saves generated C, executables, output and status under `record-ownership/`
for independent inspection. [The handoff](../development-state.md) records
commands, sources and actual acceptance. The byte charge covers managed value
storage, not process memory, allocator metadata or task stacks. These are cleanup
checks, not timing benchmarks or a comparison with C/Rust application speed.
