# Sending task handles through channels

This is an unverified compiler change on `task-channel-owners`, prepared after
the [queued callback work](queued-task-handles.md). It has no delivery PR yet.

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

## Validation required

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

Local source checks alone do not verify the new proof or native ownership. Require
all six focused native hosts, both WebAssembly hosts, inspected binaries and the
final delivery's nine production jobs plus documentation. No allocation-count,
timing or C/Rust-parity improvement is claimed by expanding acceptance.
