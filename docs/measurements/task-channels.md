# Sending task handles through channels

This extension is part of [PR #190](https://github.com/e6qu/fun-with-pipes/pull/190),
together with the [queued callback work](queued-task-handles.md). All six native
and both WebAssembly focused jobs pass. Full production acceptance is still
pending; [the handoff](../development-state.md) records the final-head gates.

A task handle keeps a computation and its eventual result alive. A channel owns
each message until a receiver takes it or the channel is released. Sending a task
handle therefore transfers an owner into the queue; independent aliases can still
await that task repeatedly. The existing runtime already has typed task cleanup.
This change extends the compiler's acceptance proof, with no new runtime operation.

The candidate accepts a known task producer only when its computation and result
cannot own a queue containing callbacks or tasks. Otherwise the queue could own
a task that owns the queue. Records containing tasks use the same check. Unknown
task producers and external task-bearing queues remain rejected. Sending nested task-bearing queues, or retaining them inside queued task
computations/results, still needs a stronger proof.
A rejection reports a missing proof; it does not establish that every run cycles.

## Example

`Task[String]` is a handle to a text result. `Channel[Task[String]]` is a queue of
those handles; its capacity here is one. `! {Async}` permits task/queue operations.
`const "ready"` makes a function that ignores its unit argument, `()`, and returns
that text. `task.spawn` starts it. `tap` sends the handle while keeping the queue
as the pipe's value; `flip channel.send` puts the message before that queue.

```fwp
jobs : I64 -> Channel[Task[String]] ! {Async}
jobs = channel.make
main =
    1
    | jobs
    | tap (flip channel.send (task.spawn (const "ready")))
    | channel.recv
    | option.and-then task.await
    | echo
```

Receiving returns `Some task` when a message exists. Awaiting returns `Some text`
after success or `None` after cancellation. `option.and-then` combines these two
optional steps, so the program prints `Some "ready"`, rather than a nested option.

## Validation

The [repeated-work fixture](../../tests/fixtures/queued_task_handles.fwp) now
includes direct task messages, records with task fields, repeated awaits, close,
cancellation, undrained messages and caught failure. Existing native O0/O2 and
WebAssembly checks compare interpretation, verify physical release and deliberately
omit queue destruction to prove that the counters detect retention.

Proof tests cover known producers, unknown task inputs, captured task-bearing
queues, task-result owners and external queues without any local spawn. Separate
negative programs run in the interpreter and tracing mode before ARC rejection.
An unknown data-only queue stays distinct from one that may own tasks/callbacks;
a known neighboring field cannot turn an unknown producer into a proof.

Source `bf78c7ab8fcc052b5931165f28393450b9106d21`, retained by tag
`roadmap/revision-task-channels-bf78c7ab8fcc`, passed all eight jobs in
[run 39666299981](https://github.com/e6qu/fun-with-pipes/actions/runs/39666299981).
Every complete job log was audited. The [source-specific inspection report](task-channels-2026-10-21.json)
records all 132 executed native binaries and 64 task-channel WebAssembly modules,
including deliberate missing-owner controls. Native headers identify the actual
OS/architecture; generated C, symbols and disassembly are tied to their binaries
by hashes. ARC binaries omit the tracing collector entry points.

These are correctness and ownership checks. Expanding acceptance claims no
allocation-count reduction, speedup or C/Rust parity. The earlier callback retain
comparison remains separately identified in [its report](queued-task-handles.md).
Final delivery still requires nine production jobs and documentation for the
exact commit being merged.
