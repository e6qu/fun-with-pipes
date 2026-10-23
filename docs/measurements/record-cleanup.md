# Checking record and variant cleanup without tracing

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

## Constructors and failed calls

A constructor creates a record or a variant. A variant chooses one of several
named forms. For example, `Outcome` below is either empty or contains text and
an integer; `Value "ready" 7` selects the second form:

```fwp
Outcome = | Empty | Value String I64
```

The compiler can pass fields directly to an internal function. If another call
needs a single object, it must put those fields into storage first. Allocation
can fail at that point. Acquiring a shared field can also fail after earlier
fields have been acquired. Cleanup must release those completed owners while
preserving independent aliases and treating integer bits as numbers.

Six related probes now repeat 32 rounds in ARC and tracing:

| Check | Failure or cancellation exercised |
|---|---|
| [Nested constructors](../../tests/constructor_type_ownership.rs) | A later field fails after an earlier field creates a child value |
| [Constructor allocation](../../tests/constructor_unwind_ownership.rs) | Storage allocation fails before fields transfer to the new object |
| [Call preparation](../../tests/worker_preparation_ownership.rs) | Copying or moving fields stops partway through, or the called task is cancelled |
| [Result storage](../../tests/worker_boxing_ownership.rs) | A function returns fields but allocation of the enclosing object fails |
| [Variant conversion](../../tests/variant_conversion_ownership.rs) | A field count overflows while converting an object to direct fields |
| [Partial retains](../../tests/retain_unwind_ownership.rs) | Count overflow leaves earlier acquisitions and a caller's remaining owners to release |

Every ARC round must return its managed byte charge to the starting value, with
no wide-count entries or collections. Removing a final fixture release fails
with status 90. Existing controls still remove individual cleanup steps. Stack
placement is explicitly disabled for the nested-constructor and variant-conversion
probes that need actual objects; it stays enabled for the other four. C uses
O1/O2, and complete programs compare with raw interpretation in both modes.

The nested-constructor test also had a selection bug: substituting a function
name changed the environment-variable name used to select its record case.
Both intended cases therefore ran the variant failure. The substitution now
changes only the function placeholder. The two negative controls must return
distinct statuses, 4 for the variant and 14 for the record. Windows now includes
the constructor-allocation target and writes probe output in binary mode, so
newline conversion cannot change the expected output.

## Evidence and limits

The original record and allocator batch passed
[PR #199's full acceptance](../roadmap-history.md#checked-native-defaults-and-arc-metadata-pr-199).
Its [inspection record](native-default-2026-10-23.json) contains 95 saved binary
files per host across all six native targets, including eighty record outcomes
and sixty allocator observations per host.

The six extended probes passed
[PR #200's full acceptance](../roadmap-history.md#repeated-constructor-and-call-cleanup-pr-200).
Its [inspection record](constructor-cleanup-2026-10-23.json) contains 175 saved
binary files per host, including 160 aggregate outcomes and sixty allocator
observations. Complete logs passed audit. Local checks additionally compared
24 complete O1/O2 programs with raw interpretation in both modes.

CI saves generated C, executables, output and status under `record-ownership/`
for independent inspection. [The handoff](../development-state.md) records
commands, sources and actual acceptance. The byte charge covers managed value
storage, not process memory, allocator metadata or task stacks. These are cleanup
checks, not timing benchmarks or a comparison with C/Rust application speed.
