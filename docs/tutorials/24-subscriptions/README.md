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

`fn (handler, channel) -> ...` names the two parts of the worker state. In the
`Some value` arm, the local binding runs `handler value` once before returning
`Again`. `_` discards the handler's unit result. The names remain available in
the match arms because those arms are inside the function's scope.

`serve` takes the worker pair and returns `fn _ -> loop step worker`. That inner
function ignores its unit input and starts the loop only when called. Constructing
it captures the worker; it does not run the loop. `subscribe` supplies the pair
and passes the resulting function to `task.spawn`. The caller keeps `(channel,
task)` to control its lifetime.

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
before joining children must also fail. The original checks passed on all six native targets in
[#213](../../roadmap-history.md#scoped-subscriber-lifetimes-pr-213).
Tracing GC has since been removed. Current ownership checks require physical
release and safe reuse; this rewritten example must pass those maintained gates.

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
step = fn (handler, channel) ->
    channel.recv channel | match
        None -> Stop ()
        Some value -> let _ = handler value in Again (handler, channel)

serve : Worker -> () -> () ! {Async, IO, Network, FileIO}
serve = fn worker -> fn _ -> loop step worker

subscribe : Handler -> Channel[I64] -> Task[()] ! {Async}
subscribe = fn handler -> fn channel -> task.spawn (serve (handler, channel))

finish : (Channel[I64], Task[()]) -> Option[()] ! {Async}
finish = fn (channel, task) -> let _ = channel.close channel in task.await task

stop : (Channel[I64], Task[()]) -> Option[()] ! {Async}
stop = fn (channel, task) ->
    let _ = channel.close channel in let _ = task.cancel task in task.await task

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
