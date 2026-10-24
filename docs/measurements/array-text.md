# Removing temporary numeric lists

Status: implementation and tests are in preparation. No allocation reduction or
speed improvement has been accepted yet. [The handoff](../development-state.md)
records the source and checks; [the plan](../../PLAN.md) remains open.

An array stores adjacent numbers in one buffer. A list stores a separate node for
each element. This program currently creates a list, copies it into an array,
then creates another list solely to print it:

`|` passes the value on its left to the function on its right. `array.from-list`
and `array.to-list` convert between the two containers; `echo` prints a value.

```fwp
main = [1.0, 2.0, 3.0] | array.from-list | array.to-list | echo
```

It prints `[1.0, 2.0, 3.0]`. The proposed changes store eligible literal arrays
as static program data and read a numeric array directly when its only list
consumer is `show` or `json.write`. `echo` uses `show` before printing. Ordinary
array display retains its `array[...]` notation. No language syntax changes.

Two neighboring costs are included: displaying a string on its own can reuse
that immutable string, because its bytes do not change; strings inside lists
or tuples still need quotes and escaping. An array iterator can keep its array,
index and accumulator in separate loop variables, avoiding temporary state
tuples before the loop starts.

Static storage applies only to fixed-width integers through 64 bits and 32-/64-bit
floating-point literals (F32/F64), including empty arrays. It cannot retain a dynamically produced value.
The existing representation reserves the array in the executable's data section
and fills its elements once at startup. Avoiding heap requests does not make
this data or initialization work free; both belong in the cost review.
Printing can also read inline target-sized integers. Boxed numbers and values
that own resources keep their existing construction and cleanup rules. Updates
must preserve any older live value; slices must keep their backing array alive.

## Checks declared before measurement

`tests/array_text.rs` compares the raw interpreter, optimized interpreter and
generated C at O1/O2, with array transformations enabled and disabled. It covers
integer limits, small floats, signed zero, JSON, empty arrays, slices, aliases,
effects before output, failure before output and lists with multiple consumers.
Automatic reference counting (ARC) releases a value when its last owner goes
away; tracing collection instead follows live references. Both executions are
compared; tracing also runs collection and reuse verification.

The allocation probe executes each of these complete programs 64 times:

`map` applies a function to each element; `fold` combines elements into an
accumulator. An iterator supplies elements one at a time. The two reduction
cases below both add one to each number and sum the results, giving 8,385.

| Program | Input | Required optimized managed requests per iteration |
|---|---|---:|
| Literal array → list → display | 129 F64 values, 0 through 128 | 1 string |
| Literal array → list → JSON | Same values | 1 string |
| Generate array → list → display | Generate the same 129 values | 1 array + 1 string |
| Literal array → map → fold → display | Add 1, then sum from 0 | 1 string |
| Literal array → list → iterator map/fold → display | Same addition and sum | 1 string |

Here a managed request asks fwp's allocator for an object; it is not an operating
system allocation. Each program must finish every iteration with its original
managed-storage balance, no overflow entries for reference counts and no collection.
A reference count records how many owners share a value. The probe requires
zero count increments in the optimized cases, while retaining the actual
disabled-control counts in its output. It also tracks the temporary text buffer's allocated capacity and requires zero
retained bytes. It deliberately omits managed and buffer releases in separate
controls: both must fail. This does not measure every C library allocation.

The disabled-transformation controls must retain at least 129 requests. Their
actual counts are saved, not guessed. Both compact arrays (each number uses its
own width) and full-word arrays (at least eight bytes per element) run.
The neighboring map/fold and iterator cases must retain their loop
optimizations after literal folding; introducing an array constant must not hide
its element type from later compiler steps.

## Evidence needed for acceptance

Run the focused checks on native Linux, macOS and Windows, each on ARM64/AMD64.
Keep generated C, executable files, output, status and source identity. Inspect
the actual machine types, static array bytes/alignment, calls and instructions;
report executable, code, static-data and stack costs. Final delivery still needs
all production jobs and documentation at its exact commit.

These checks establish allocation and lifetime behavior for the named programs,
not speed. Before a timing claim, compare complete equivalent-work programs using
the [comparison protocol](../benchmarks.md), retaining repeated samples and noise
controls. The [descent comparison](float-text-results.md) motivates reducing
temporary lists, but its earlier timings cannot establish this change's benefit.

The existing full-output/checksum experiment is also being rerun with this
compiler on both Linux architectures. Its six inputs, 48 samples, four warmups
and 2% identical-copy checks remain unchanged. It reports current complete
programs against C/Rust; an earlier revision measured at another time is not a
paired speed comparison. Static input initialization occurs once per process and
remains inside the total timing. The largest case is expected to make 200 managed
requests with full output and 199 with the checksum consumer, with no retained
storage after each solve; these predictions are not accepted measurements.
