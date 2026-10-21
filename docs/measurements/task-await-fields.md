# Matching task results without a temporary box

Immediate task-result matches avoid a temporary heap object. The measured source
passes six native and two WebAssembly focused jobs. Final delivery checks remain
separate; see [the handoff](../development-state.md).

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

`! {Async}` permits waiting. The compiler passes the option's tag and payload
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

## Measured result

The [2026-10-22 report](task-await-fields-2026-10-22.json) records source
`f2b5d400fedaca3a24208cd3bcdf08f2ebe51c61`, tag
`roadmap/revision-await-fields-f2b5d400feda`, and all eight passing jobs in
[the focused run](https://github.com/e6qu/fun-with-pipes/actions/runs/39678830873).
Every complete log was audited. At both C O0 and O2, on Linux/macOS/Windows ARM64
and AMD64, the fixture makes **134 → 100 allocation requests** and requests
**544 fewer bytes**. Retains stay at 54; peak managed storage is unchanged.
These results hold in both checked ARC and tracing modes.

The ARC byte totals are the same on both architectures within these groups:

| Native hosts | Requested bytes, boxed control → direct fields | Peak managed bytes, both versions |
|---|---:|---:|
| Linux and macOS, ARM64/AMD64 | 8,869 → 8,325 | 1,488 |
| Windows, ARM64/AMD64 | 9,205 → 8,661 | 1,552 |

Tracing totals differ by host because their task storage differs; the report
retains each value. Every counted run ends with zero managed charge and zero
collections. This fixture reduces allocation traffic, not peak storage. It has no
execution-time, process-memory or C/Rust comparison. Required sharing, text,
task records and stacks still cost space and work.

Independent inspection covers 204 executed native binaries, including all 48
await comparisons, and 64 executed await WebAssembly modules. Native file headers
confirm the recorded architecture. At O0 the boxed control's await helper calls
`fwp_await_owned`; the direct-fields helper does not. ARC symbols exclude the
tracing scan, mark and sweep functions. The report retains generated-C, binary,
output and inspection hashes, compiler versions, flags and hardware details.
Binary sizes are recorded; no code-size or register-use improvement is claimed.

Native probes deliberately omit the result retain and must fail while an alias
keeps storage safe to inspect. Overflow and cancellation checks preserve other
owners. WebAssembly runs WASI/browser entry paths with JSPI/Asyncify at O1/O2;
missing scheduler shutdown or cached-result release must fail. These execution
checks use Node and do not establish coverage of every browser engine.

The same source verifies partial-capture State scopes, repeated Jacobian tape
cleanup and the repaired C-interop buffer releases. Earlier failed controls are
not acceptance: the first WASM control omitted State cleanup in a fixture with no
State storage, and an earlier Windows buffer observer preceded platform headers.
The accepted source fixes both without relaxing the ownership proof.
