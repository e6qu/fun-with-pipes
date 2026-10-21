# Matching task results without a temporary box

This optimization is under development, after the combined task-ownership group.
It is not verified platform support. See [the handoff](../development-state.md).

`Task[String]` is a handle to a computation that returns text. Awaiting it produces
an `Option[String]`: `Some` contains the successful result; `None` means that the
task was cancelled. In a tacit match, the selected arm receives the constructor's
payload. This function returns the text length, or zero after cancellation:

```fwp
read : Task[String] -> I64 ! {Async}
read = task.await | match
    Some -> string.length
    None -> 0
```

`! {Async}` permits waiting. The candidate passes the option's tag and payload
directly to this match as C fields. It removes the temporary heap object around
`Some`; it does not remove the text, task record or task stack. An option saved in
a list or otherwise escaping the direct match still has its ordinary representation.

The task keeps its cached result so that other handles and repeated awaits still
work. A counted payload therefore needs a new owner before the caller can release
its task handle. Integers need no retain; wide floats and heap values use their
typed ownership rules. A cancelled task returns `None` without allocating a box.
Waiting, cancellation checks and result-retain failures keep their previous order.

## What the comparison measures

The [test program](../../tests/fixtures/task_await_fields.fwp) starts sixteen tasks
returning the decimal strings for 0 through 15 and reads each result twice. Their
lengths sum to 44. It also reads a cancelled task, an integer and a wide float,
then stores one text option in a list. The output is:

```text
44
0
17
2.0
[Some "escapeescape"]
```

The comparison uses the same fwp-generated C twice. One version uses direct
fields; the other restores the former box allocation, extracts its payload, then
frees the box. Both keep identical task execution, result retains and output.
The control counts restored boxes: 32 text reads plus the integer and wide result
give 34. Cancellation and the stored option contribute no difference.

The test counts allocation requests, requested bytes, retains, peak/final managed
storage and collections from program entry after constant initialization through
cleanup. It excludes raw scheduler stack mappings, allocator metadata and process
memory. Frontend optimization is O1; native C settings are O0/O2 with link-time
optimization disabled in the focused workflow. ARC and tracing modes run separately.
Collection/reuse stress is a separate correctness run, outside the count comparison.

No measured saving is reported yet. Required evidence includes all six native
hosts, both WebAssembly hosts, generated C and executed machine-code inspection.
The runtime probe also deliberately omits the result retain and must fail while
an independent alias keeps the storage safe to inspect. Overflow and cancellation
checks must preserve other owners. Final production acceptance remains separate.
This is a comparison of two fwp representations, not a timing benchmark or a
claim of parity with C/Rust. Required sharing and task storage remain costs.
