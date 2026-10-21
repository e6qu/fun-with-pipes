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
rejects flows that can return to that task. It joins possible producers at compile
time, so repeated creation sites can be ambiguous; rejection means a missing
proof, not that every execution necessarily creates a cycle. This check also
applies when there is no channel.

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
measure speed, ARC operation counts or parity with C/Rust. Runner results,
architecture inspection and the complete native/WASM inventory remain pending.
