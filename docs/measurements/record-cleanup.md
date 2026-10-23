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

## Selecting fields, returning aliases and reusing storage

An alias is another live reference to the same value. Selecting one field must
release discarded fields while preserving any aliases that the caller still
uses. An internal **reuse token** temporarily owns an emptied object: a later
constructor may fill that storage, or cleanup must free it. Tokens are compiler
bookkeeping, not a new language feature.

These ten test targets now check both ARC and tracing:

| Check | What must remain true |
|---|---|
| [Field selection](../../tests/field_context_ownership.rs) | Selecting an integer releases the unused nested string, even when the outer record is eliminated |
| [Pattern matching](../../tests/match_context_ownership.rs) | Matching a variant preserves its child type so discarded owners are released |
| [Returned aliases](../../tests/variant_alias_ownership.rs) | Returned variant fields transfer once, remain unboxed where expected, and preserve caller aliases across task suspension |
| [Reusable storage](../../tests/reuse_token_ownership.rs) | A consumed object's empty storage transfers to a new result or is freed on failure, an unused branch or a tail call |
| [Partial calls](../../tests/argument_preparation_ownership.rs) | Failure while acquiring arguments preserves caller aliases; unique captured values move without extra retains |
| [Right folds](../../tests/fold_unwind_ownership.rs) | A failed callback, allocation or cancelled task releases the accumulator and temporary buffer |
| [Loop cancellation](../../tests/loop_unwind_ownership.rs) | Cancellation releases the current state at the first or a later iteration; failed result preparation preserves outside aliases |
| [Cached values](../../tests/caf_ownership.rs) | Initialization can fail or reenter; the cache and its callers keep separate owners, released at the correct lifetime boundary |
| [Escaping functions](../../tests/closure_ownership.rs) | A returned function keeps its captured values alive and releases its storage after use |
| [Temporary containers](../../tests/temporary_ownership.rs) | Discarding a temporary list releases its children while preserving independent aliases |

Here is the field-selection pattern. `Leaf` constructs an `Inner` containing a
string. `make` constructs a record by applying each field function to the input;
`const 17` ignores that input and returns 17. `.number` selects the numeric field.

```fwp
Inner = | Leaf String
Outer = { child: Inner, number: I64 }
make-outer : String -> Outer
make-outer = make { child = string.repeat 2 | Leaf, number = const 17 }
discard : String -> I64
discard = make-outer | .number
main = "input" | discard | echo
```

The result is `17`. The repeated string is unused after field selection. The
compiler can remove the outer record, but must still release that string.
The source tests also choose the function at runtime so a direct-call rewrite
cannot hide the cleanup obligation.

The first seven targets repeat instrumented probes for 32 rounds, with and
without caller aliases.
ARC requires the managed byte charge to return to its starting value, no extra
count-table entries and no collections. Deliberately missing releases or adding
an extra owner must fail. Two internal-compiler controls erase a needed child
type: ARC must reject them before C generation; tracing retains the old runtime
leak controls. An absent proof must not quietly enable tracing.

The reuse target also runs a million-step countdown at C O1/O2 in both modes.
It compares the result with a small raw-interpreter case of the same recurrence.
This checks that unused storage is cleaned up without accumulating native call
frames for this eligible recursion pattern; it makes no promise for arbitrary
recursion. Tracing keeps its old-cell, poisoned-storage and collection-on/off
controls. ARC additionally rejects settings that disable ownership or freeing.

A **partial call** supplies an argument and returns a function waiting for its
next argument. For example, `add 1` waits for a number; it adds one to that number.
Captured values must stay alive while the returned function can use them. A
unique function can transfer those values into its call without increasing their
reference counts. An independently live alias must keep its own values.

A **fold** repeatedly combines an element with an accumulator; a right fold
starts at the right end of the list. These tests deliberately fail after an
intermediate accumulator exists. They also omit a temporary-buffer release to
prove the check detects it. Loop checks cancel both before and after an update,
including nested state fields and integer words that resemble addresses.
The twelve-pattern capture report retains its existing rows and columns; each
pattern now repeats 32 times before the final rows are reported.

A computed top-level value is cached after its first successful evaluation.
Repeated reads share that value. The cache retains one owner until program
teardown; a caller that keeps the value needs its own owner. Cached-value probes
repeat initialization, failure, replacement and teardown for 32 lifetimes, and
separately check that a complete program initializes its value just once.
The two function/container workloads run 10,000 iterations. ARC must end with
no live managed charge, extra count entries or collections; deliberately missing
closure-storage or child-value cleanup must fail. Their older tracing-based
freed-byte comparisons remain separate controls, not ARC measurements.

Windows now selects the previously omitted match-context, reuse-token, ARC
program-corpus, HTTP/2 body-copy and temporary-container targets. Linux's `static_memory` target is
Linux-specific; Windows uses `windows_static_memory` for native storage checks.
Selecting a target that skips execution does not establish platform support.
The two variant tests that change process-wide generator options serialize those
changes, so concurrent test execution cannot select another test's memory mode.
Generated C, executable and output are saved before checking each result.

## Evidence and limits

The original record and allocator batch passed
[PR #199's full acceptance](../roadmap-history.md#checked-native-defaults-and-arc-metadata-pr-199).
Its [inspection record](native-default-2026-10-23.json) contains 95 saved binary
files per host across all six native targets, including eighty record outcomes
and sixty allocator observations per host.

The constructor and call batch passed
[PR #200](https://github.com/e6qu/fun-with-pipes/pull/200) at source
`69c3b1e0135dd95961dba3729911ec27dc1736b6`, including all production jobs,
documentation and inspection of 1,050 saved native binary files across six hosts.

The ten extended targets have local
Apple Clang ARM64 checks using accepted compiler `5e17fc10e860b1971ffc9cd9cb57fcb795ccad24`
with its unchanged runtime. The new internal-compiler cases and all other native
platforms still require CI. The three newly added targets have not yet passed
the Rust harness or GCC; their local source checks are not final acceptance. See the handoff for exact commands, receipts and
current acceptance; these local checks do not establish GCC or Windows support.

CI saves generated C, executables, output and status under `record-ownership/`
for independent inspection. [The handoff](../development-state.md) records
commands, sources and actual acceptance. The byte charge covers managed value
storage, not process memory, allocator metadata or task stacks. These are cleanup
checks, not timing benchmarks or a comparison with C/Rust application speed.
