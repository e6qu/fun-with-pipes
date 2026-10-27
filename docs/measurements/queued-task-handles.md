# Queued callbacks that retain task handles

The G5 artifact audit now expects twenty binaries per host: normal and deliberately
broken queue, callback-transfer, clock-owner, await-result and raw-buffer cases at
O0/O2. Collector symbols must be absent from all of them. Callback transfers and
direct await results retain their exact count comparisons. This updated matrix
has not yet passed integrated G5 validation; historical reports below describe
their recorded source and larger two-mode matrix.

This extension passed full production acceptance in [PR #190](../roadmap-history.md#queued-task-owners-and-callback-transfers-pr-190).
The measurements below keep their exact source revisions.

A task handle keeps a task's result available for later `task.await` calls. A
callback is a function saved for a later call. Saving a callback in a channel can
therefore keep its captured task alive after the original caller finishes.

The compiler follows the task's producer, the computation it will run,
and its eventual result. Each can hide another owner. It accepts a queued capture
only when those owners are proved and cannot point back to a function queue.
Unknown task producers stay rejected. This introduces no new runtime wrapper,
weak handle, implicit cleanup or reference-count operation.

Task results need a separate check: unlike captures fixed before publication,
a task's result is assigned later. A result that owns its producing task, directly
or through a returned closure, would make a reference-count cycle. The compiler
rejects flows that can return to that task. Several creations can share one
compile-time summary when their task result types match. If this obscures whether a captured task is older than its owner,
the compiler rejects the result graph. This can reject safe programs: the
diagnostic reports a missing proof, not a cycle in every execution. This check also
applies when there is no channel.

For example, the previous compiler accepted this ownership cycle in ARC mode:

```fwp
TaskResult = { read: () -> () ! {Async} }
wait : Task[TaskResult] -> () -> () ! {Async}
wait = curry (.0 | task.await | ignore)
rec work : () -> TaskResult ! {Async}
work = match
    () -> TaskResult { read = wait main }
rec main = task.spawn work
```

`rec` permits recursive references. Here `main` caches the spawned task. The task
returns a record whose `read` function captures that same task: task → result →
function → task. Nothing needs to invoke `read` for the ownership cycle to exist.
The new ARC check rejects it; ordinary recursion without an owning back-reference
remains allowed. The regression also checks interpretation and tracing execution.

## Example

`Task[String]` is a handle to a task producing text. `Option[String]` is either
`Some text` after success or `None` after cancellation. `Channel[Event]` stores
records containing a callback. The `Async` effect permits waiting for tasks or
queue operations.

`const text` creates a function that ignores its input and returns that text;
`task.spawn` runs it with unit, `()`. The `read-task` function uses `curry` to turn
a function taking a pair into two successive single-argument calls. `.0` selects
the task from `(task, ())`. Capturing the first argument saves the task; awaiting
happens only when the callback later receives `()`. `flip channel.send` puts the
message argument before the queue, leaving the queue as the pipe input.

```fwp
Event = { read: () -> Option[String] ! {Async} }
events : I64 -> Channel[Event] ! {Async}
events = channel.make
read-task : Task[String] -> () -> Option[String] ! {Async}
read-task = curry (.0 | task.await)
event : String -> Event ! {Async}
event = const | task.spawn | read-task | make Event { read = id }
main =
    1
    | events
    | tap (flip channel.send (event "ready"))
    | channel.recv
    | option.and-then (.read | apply ())
    | echo
```

This prints `Some "ready"`. `make Event { read = id }` stores the callback in the
record. `tap` sends the event while keeping the queue for the next step. Receiving
transfers the event to the caller; `.read | apply ()` invokes its callback.
`option.and-then` keeps one optional result instead of nesting two `Some` values.
The captured task remains owned until the callback is released, so receiving an
event does not invalidate its handle. Raw interpretation and focused native/ARC
checks pass at the measured source below. The later direct-task-message extension
has separate validation in [the task-message report](task-channels.md).

## Programs under test

The [fixture](../../tests/fixtures/queued_task_handles.fwp) repeats 64 rounds and
prints `task captures released` once. It queues callbacks that await text tasks,
uses independent aliases, cancels tasks, follows nested task results, calls
functions returned by tasks, receives after close, and releases undrained/error
paths. A final yield lets runnable children finish between rounds.

Native checks compare raw interpretation with checked ARC and tracing at O0/O2.
ARC counters require no more than 64 live task records and none at teardown,
including the root. Managed storage must return to its baseline with no tracing
collections. Deliberately omitting queued-value destruction must reach the live
record limit with exit 201. Tracing runs keep stress/reuse verification.

WebAssembly checks add this fixture to WASI and browser-loader execution under
both explicitly selected suspension modes, JSPI and Asyncify, at O1/O2. They
compare physical allocations, bytes and reference-count entries with the entry
baseline. Missing scheduler cleanup and missing queued-value release must fail.

These correctness, cycle-policy and bounded-retention checks passed at source
`521a160091040207067601ca3e57d7cc444e33f0`, retained by tag
`roadmap/revision-task-owners-521a16009104`. All eight jobs in
[run 39656585197](https://github.com/e6qu/fun-with-pipes/actions/runs/39656585197)
passed; their complete logs were audited. This source predates direct Task
messages and does not establish acceptance of that extension.

## Transferring task callbacks

The same group changes `task.spawn` and `task.within` to take one existing callback
owner. Previously, the runtime duplicated that owner and the caller released its
copy immediately afterward. A last use can now transfer directly. If the program
uses the callback again, compiler-inserted duplication preserves that independent
owner; sharing still costs reference-count operations. The source syntax is unchanged.

The task owns the callback through preparation, completion and cancellation.
Deadline calls also protect it while reading the clock. POSIX clock failures now
report an error rather than using an uninitialized timestamp. Timestamp conversion
checks the signed nanosecond range on each platform, and deadline addition
saturates without signed overflow, including at the range boundaries. Fault-injection
checks cover clock failure, range overflow, stack allocation, scope growth, and preservation of
independent aliases; removing protection must fail those checks.

The measurement in `tests/retained_thunk_ownership.rs` runs ordinary task creation,
early cancellation and deadline calls. It compares two versions of the same
generated C at O0/O2 in ARC and tracing modes: direct ownership transfer, and a
control with the redundant retain/release pair restored. It counts actual counted
callbacks, allocation requests/bytes, retains, peak/final managed charge and
collections. This isolates the redundant pair; it is not an old-compiler timing
comparison. Both must match raw interpretation, and only the retain count may
differ. The [source-specific report](queued-task-handles-2026-10-21.json) preserves
hardware, compilers, flags, counts, generated-C hashes and actual binary inspection.

All six native hosts show **10 → 5 retains**, with 27 allocation requests unchanged,
at both O0 and O2. Each of five task creations removes one redundant retain/release
pair; the other five retains remain necessary. Requested bytes and peak managed
charge are identical between the control and transfer versions:

| Hosts | Memory mode | Requested bytes | Peak managed bytes |
|---|---|---:|---:|
| Linux/macOS, ARM64/AMD64 | ARC | 2,306 | 688 |
| Linux/macOS, ARM64/AMD64 | Tracing | 2,354 | 816 |
| Windows, ARM64/AMD64 | ARC | 2,402 | 816 |
| Windows AMD64 | Tracing | 4,226 | 1,328 |
| Windows ARM64 | Tracing | 3,650 | 1,328 |

ARC final managed charge and collection count are zero. Counts cover entry after
constant initialization through runtime cleanup; raw stack mappings, allocator
metadata and process memory are excluded. This is a 50% reduction in counted
retains for this program, not a 50% speedup. No timing or C/Rust comparison ran.

The focused native workflow disables link-time optimization explicitly and uses
`scripts/inspect-task-owners.py` to preserve headers, symbols, instructions,
sections, compiler flags and CPU details for 22 executed binaries per host. That
includes failing cleanup controls. All 132 native binaries were independently
checked against their executed artifacts, including architecture headers, symbols
and generated C; O0 callback-transfer routines were disassembled independently.
The report rechecks counter differences and absence of tracing entry points in
ARC binaries. Both WebAssembly artifacts contain 32 executed task-capture modules
whose headers, source/output hashes and available symbols were inspected.
[PR #190](../roadmap-history.md#queued-task-owners-and-callback-transfers-pr-190) records full production acceptance of the combined delivery.

Clock conversion also checks the signed nanosecond range before narrowing, including
elapsed monotonic time. The interpreter now reports the same range errors and keeps
negative Unix timestamps for dates before 1970, rather than returning zero. Boundary
probes use injected clocks; interpreter tests use exact 100 ns ticks, which Windows
can represent. These checks do not require changing the host clock.
