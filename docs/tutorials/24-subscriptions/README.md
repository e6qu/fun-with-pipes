# 24. A subscriber with an explicit lifetime

Read [tasks and channels](../06-tasks-and-channels/README.md) and
[ownership scopes](../23-ownership-scopes/README.md) first. A **subscriber** is a
worker that handles messages until its owner stops it. Here one task owns the
handler function and reads integers from a bounded channel. The channel owns
integers, never the worker or its handler, so there is no owning cycle.

These are ordinary functions built from existing APIs, not a new subscription
primitive. `Handler` names a function type; `Worker` names a pair of that function
and its input channel. The effect list permits the operations a spawned task can
perform. It does not mean every handler uses networking or files.

## Process one message at a time

`step` receives one message and retains the worker pair. `None` means the channel
is closed and empty, so `Stop ()` ends the loop. `Some value` calls the handler,
then `Again worker` continues. This processes each value before receiving the
next; it does not build a list of every message as `channel.drain` would.

The `Some` match supplies the message and the saved pair to its branch.
`curry` turns a function of that pair into the curried branch function. Inside it,
`.0` is the message and `.1 | .0` is the handler. `fork apply` calls that handler
with the message; `tap` keeps the pair while the call runs. The final `.1` recovers
the worker state. These tuple projections are zero-indexed.

`serve` delays the loop until its final `()` argument arrives. `const work`
ignores one argument and returns the function `work`; `flip` supplies the worker
pair afterward. It does not start the loop when the callback is constructed.
`subscribe` takes a handler and a channel, then spawns that delayed computation.
The caller keeps `(channel, task)` to control its lifetime.

## Finish or stop

`finish` closes the channel, then awaits the task. Closing rejects new sends but
preserves already queued values. The worker handles them in order, receives
`None`, and returns `()`. The first example sends 1 and 2; its handler adds 10 and
prints 11 and 12. `Some ()` reports successful task completion.

`stop` closes the channel, requests task cancellation, then awaits completion.
Cancellation is cooperative: a running callback stops at a cancellation point,
such as channel waiting, sleeping, yielding or a generated-code scheduling check. It cannot interrupt arbitrary C
code or promise a deadline for a callback that never cooperates. Awaiting the task
also waits for its children to finish or unwind. Only then may the caller treat
active calls as finished. Other aliases may still keep messages or captures alive.

The second example stops before its worker begins; it prints `None`. In general,
cancelling a task that already produced a result can still yield `Some result`.
Cancellation is not rollback and does not discard the channel's queued messages.
A caller retaining the channel can receive those messages after the task stops.
Dropping the final channel owner releases any unread values.

The parent task also owns its children. Dropping a task handle alone does not stop
a worker. A `task.scope` waits for its children on normal return and cancels/joins
them if its body fails. An endless worker therefore needs an explicit finish or
stop on the normal path. Keep long-running sessions in a scope whose lifetime
matches the session.

A callback can enqueue another message into this same data channel without an
owning cycle: the queued value remains an integer. However, sending to a full
queue from its only consumer can deadlock. Choose capacity/flow rules explicitly;
ownership safety is not a proof of progress.

## Errors and checks

A spawned task must handle its errors. For a fallible handler, put `attempt`
around the loop and return `Result[(), String]`: `Ok ()` on normal finish or
`Err message` when a callback fails. This worker stops on the first error. Its
owner must still close the channel; `task.await` alone does not close it or consume
its remaining messages. [The regression program](../../../tests/fixtures/subscription_lifetimes.fwp)
shows this policy, active cancellation with a child task, reentry and scope failure.

[The native check](../../../tests/arc_tasks.rs),
`subscriptions_join_active_callbacks_and_release_each_round`, compares raw
interpretation with native O1/O2 execution. Eight and 64 rounds must return to the
same managed-byte balance after each outer scope, then release all runtime charge.
Broken message, task-owner and callback releases must fail; reporting completion
before joining children must also fail. Tracing stress/reuse checks remain in the
comparison. These checks passed on all six native targets in
[#213](../../roadmap-history.md#scoped-subscriber-lifetimes-pr-213).

## Run it

From the repository root:

```sh
fwp run --interp docs/tutorials/24-subscriptions/main.fwp
fwp build docs/tutorials/24-subscriptions/main.fwp -o subscriptions
./subscriptions
```

Expected output:

```text
11
12
Some ()
None
```

[`main.fwp`](main.fwp):

```fwp
Handler = I64 -> () ! {Async, IO, Network, FileIO}
Worker = (Handler, Channel[I64])

step : Worker -> Step[Worker, ()] ! {Async, IO, Network, FileIO}
step = both (.1 | channel.recv) id | match
    (None, _) -> const () | Stop
    (Some _, _) -> curry (tap (fork apply .0 (.1 | .0)) | .1 | Again)

serve : Worker -> () -> () ! {Async, IO, Network, FileIO}
serve = flip (const (loop step))

subscribe : Handler -> Channel[I64] -> Task[()] ! {Async}
subscribe = curry (serve | task.spawn)

finish : (Channel[I64], Task[()]) -> Option[()] ! {Async}
finish = tap (.0 | channel.close) | .1 | task.await

stop : (Channel[I64], Task[()]) -> Option[()] ! {Async}
stop = tap (.0 | channel.close) | .1 | tap task.cancel | task.await

main =
    2
    | channel.make
    | both id (subscribe (add 10 | echo))
    | tap (.0 | flip channel.send 1)
    | tap (.0 | flip channel.send 2)
    | finish
    | echo
    | const 1
    | channel.make
    | both id (subscribe echo)
    | stop
    | echo
```

See the [cycle and retention contract](../../ownership.md#cycle-and-retention-contract)
for unsupported owning graphs and C-retained callbacks. Neither this example nor
weak references can automatically prove arbitrary foreign lifetimes safe.
