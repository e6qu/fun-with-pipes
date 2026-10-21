# Queued callbacks that retain task handles

This preparation is not verified support yet. PR #189 remains the active delivery;
finish its production acceptance before opening the next PR.

A task handle keeps a task's result available for later `task.await` calls. A
callback is a function saved for a later call. Saving a callback in a channel can
therefore keep its captured task alive after the original caller finishes.

The candidate compiler follows the task's producer, the computation it will run,
and its eventual result. Each can hide another owner. It accepts a queued capture
only when those owners are proved and cannot point back to a function queue.
Unknown task producers stay rejected. This introduces no new runtime wrapper,
weak handle, implicit cleanup or reference-count operation.

Task results need a separate check: unlike captures fixed before publication,
a task's result is assigned later. A result that owns its producing task, directly
or through a returned closure, would make a reference-count cycle. The candidate
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
event does not invalidate its handle. Source checking and raw interpretation of
this example passed with the verified #188 compiler; the new ARC eligibility
proof still needs the runner checks described below.

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

These are correctness, cycle-policy and bounded-retention checks. They do not
measure speed or parity with C/Rust. Runner results, architecture inspection and
the complete native/WASM inventory remain pending.

## Transferring task callbacks

The same group changes `task.spawn` and `task.within` to take one existing callback
owner. Previously, the runtime duplicated that owner and the caller released its
copy immediately afterward. A last use can now transfer directly. If the program
uses the callback again, compiler-inserted duplication preserves that independent
owner; sharing still costs reference-count operations. The source syntax is unchanged.

The task owns the callback through preparation, completion and cancellation.
Deadline calls also protect it while reading the clock. POSIX clock failures now
report an error rather than using an uninitialized timestamp. Fault-injection
checks cover clock failure, stack allocation, scope growth, and preservation of
independent aliases; removing protection must fail those checks.

The measurement in `tests/retained_thunk_ownership.rs` runs ordinary task creation,
early cancellation and deadline calls. It compares two versions of the same
generated C at O0/O2 in ARC and tracing modes: direct ownership transfer, and a
control with the redundant retain/release pair restored. It counts actual counted
callbacks, allocation requests/bytes, retains, peak/final managed charge and
collections. This isolates the redundant pair; it is not an old-compiler timing
comparison. Both must match raw interpretation, and only the retain count may
differ. Results and binary inspection are pending.

The focused native workflow disables link-time optimization explicitly and uses
`scripts/inspect-task-owners.py` to preserve headers, symbols, instructions,
sections, compiler flags and CPU details for 22 executed binaries per host. That
includes failing cleanup controls. The report checks counter differences again
and requires ARC binaries to exclude tracing entry points.
