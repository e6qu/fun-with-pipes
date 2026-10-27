# Cleanup when collection operations fail

`map` applies a function to every list element. A later call can fail after an
earlier call has already produced a result. That partial result and the temporary
storage holding it must be released. Independently owned input values must remain
valid.

Automatic reference counting (ARC) releases storage when its last counted owner
finishes using it. An alias is another reference to the same value. These checks
exercise that cleanup directly. G5 removes duplicate tracing executions; the
migrated tests still need full target validation.

`String -> String` means a function from text to text. The following
`! {Error[String]}` allows it to fail with a string message. `const "expected"`
ignores its input and produces that message; `fail` raises it. `attempt` catches
an error and returns an `Err` value; `echo` prints the result.

Here `if` tests each word with `eq "stop"`. It raises the error on a match;
otherwise `concat "!"` appends an exclamation mark:

```fwp
decorate : String -> String ! {Error[String]}
decorate = if (eq "stop") (const "expected" | fail) (concat "!")
main = ["a", "stop"] | attempt (map decorate) | echo
```

The program prints `Err "expected"` because the second word fails. The
intermediate `"a!"` must be released even though no completed list is returned.

## Cases checked

| Probe | Work and cleanup obligations |
|---|---|
| [Loop preparation](../../tests/loop_preparation_ownership.rs) | Prepare tuple fields for an iteration; release fields acquired before a later acquisition fails; preserve independent aliases and integer bits |
| [Map](../../tests/map_unwind_ownership.rs) | Release completed results and temporary storage after callback failure, result-list allocation failure or cancellation |
| [Filter and prefix selection](../../tests/selection_unwind_ownership.rs) | `filter` keeps matching elements; `take-while` keeps a matching prefix. Their selected aliases and temporary storage must be released when a predicate fails or the task is cancelled |
| [Zip](../../tests/zip_unwind_ownership.rs) | Combine corresponding elements from two lists; release partial results and both temporary buffers, including failure while allocating the second buffer |

The collection probes also use integers whose bits happen to equal valid object
addresses. Typed cleanup must treat those integers as numbers, not as additional
owners of the pointed-to objects.

Each probe runs 32 rounds with counted ownership. Every round must return
the allocator's accounted bytes for live values (the managed byte charge) to the
starting value, with no wide-count entries. A wide count is an extra counter used when the usual single-byte
counter is too small. Deliberately omitting a final fixture release must fail with
status 90. Removing a temporary-buffer release must fail with status 3; the loop's
missing partial cleanup must fail with status 5.

Settings are explicit: dynamic memory, enabled stack placement, C emission at O2,
and native C builds at optimization levels O1/O2. The checks observe physical
release and live allocation identities; they do not keep dead storage allocated
or read its old contents. Removing a collector-specific run does not remove its
distinct failure or cancellation case.
Complete programs compare with the raw interpreter, which disables optimization.

## Evidence and limits

These tests measure cleanup, not execution speed. The byte charge covers managed
storage, not resident memory, allocator metadata or every external allocation.
They provide no C/Rust performance comparison and do not prove a bound for
arbitrary programs.

CI saves generated C, executables, output and exit status under `record-ownership/`.
The related record, constructor and collection probes now save unexpected
outcomes before asserting success, so a failed check leaves its evidence intact.
The earlier accepted results are recorded below. They verify their named source
revision. The collector-free changes passed integrated validation in
[#217](../roadmap-history.md#tracing-gc-removal-pr-217).

See [record cleanup](record-cleanup.md) for constructors and field conversions,
[ownership](../ownership.md) for the memory contract and [PLAN.md](../../PLAN.md)
for the remaining work on unnecessary reference counts and allocations.

## Native acceptance

[PR #201](../roadmap-history.md#failed-loops-and-collection-cleanup-pr-201) passed
all production jobs and documentation. Its
[inspection record](collection-cleanup-2026-10-23.json) contains 331 saved binary
files per host across all six native targets. This includes 316 aggregate cleanup
outcomes and sixty allocator observations per host. All complete job logs were
audited; these are ownership checks, not performance comparisons.
