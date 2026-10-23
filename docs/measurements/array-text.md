# Removing temporary numeric lists

Status: implementation and tests are in preparation. No allocation reduction or
speed improvement has been accepted yet. [The handoff](../development-state.md)
records the source and checks; [the plan](../../PLAN.md) remains open.

An array stores adjacent numbers in one buffer. A list stores a separate node for
each element. This program currently creates a list, copies it into an array,
then creates another list solely to print it:

```fwp
main = [1.0, 2.0, 3.0] | array.from-list | array.to-list | echo
```

It prints `[1.0, 2.0, 3.0]`. The proposed changes store eligible literal arrays
as static program data and read a numeric array directly when its only list
consumer is `show` or `json.write`. `echo` uses `show` before printing. Ordinary
array display retains its `array[...]` notation. No language syntax changes.

Static storage applies only to fixed-width integers through 64 bits and F32/F64
literals, including empty arrays. It cannot retain a dynamically produced value.
Printing can also read inline target-sized integers. Boxed numbers and values
that own resources keep their existing construction and cleanup rules. Updates
must preserve any older live value; slices must keep their backing array alive.

## Checks declared before measurement

`tests/array_text.rs` compares the raw interpreter, optimized interpreter and
generated C at O1/O2, with array transformations enabled and disabled. It covers
integer limits, small floats, signed zero, JSON, empty arrays, slices, aliases,
effects before output and failure before output. ARC and tracing executions are
compared; tracing also runs collection and reuse verification.

The allocation probe executes each of these complete programs 64 times:

| Program | Input | Required optimized managed requests per iteration |
|---|---|---:|
| Literal array → list → display | 129 F64 values, 0 through 128 | 1 string |
| Literal array → list → JSON | Same values | 1 string |
| Generate array → list → display | Generate the same 129 values | 1 array + 1 string |
| Literal array → map → fold → display | Add 1, then sum from 0 | 1 string |
| Literal array → list → iterator map/fold → display | Same addition and sum | 1 string |

Here a managed request asks fwp's allocator for an object; it is not an operating
system allocation. Each program must finish every iteration with its original
managed-storage balance, no wide reference counts and no collection. The probe
also tracks the temporary text buffer's allocated capacity and requires zero
retained bytes. It deliberately omits managed and buffer releases in separate
controls: both must fail. This does not measure every C library allocation.

The disabled-transformation controls must retain at least 129 requests. Their
actual counts are saved, not guessed. Packed and full-word array layouts both
run. The neighboring map/fold and iterator cases must retain their loop
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
