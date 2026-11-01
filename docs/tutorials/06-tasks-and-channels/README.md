# 6. Tasks and channels

Prerequisites: [lessons 1–5](../README.md), including effects, tuples and
`Option`. **Concurrency** means several pieces of work can make progress during
the same period, including while others wait. It does not promise that every
piece runs on a separate CPU core.

A **task** is one such piece of work. `task.spawn` starts a child task. A parent
waits for its children before finishing, so their lifetimes stay within its
scope; this is **structured concurrency**. `task.await` returns `Some result`
or `None` for cancellation. `task.map` applies a function in tasks and collects
these optional results.

## Sending values through a channel

A **channel** is a queue between tasks. Its capacity bounds how many values can
wait in the queue. Sending to a full queue waits until a receiver makes room;
this is **backpressure**. After `channel.close`, receivers can read the queued
values and then get `None`.

The program makes a channel with capacity two. A producer sends `1`, `2`, `3`
and closes it. The consumer adds the received values, so the result is `6`.
`tap (produce | task.spawn)` starts the producer and passes the original channel
on to the consumer. `the-channel` supplies an explicit type for that channel.

Automatic reference counting (ARC) releases a value when its last owner lets go.
Sharing this channel is not a cycle: its queued integers cannot refer back to
it. A queued callback capturing the channel could form an owning cycle:
the queue keeps the callback alive, and the callback keeps the queue alive.
The compiler rejects this relationship when it cannot prove cleanup.

A **weak reference** observes a channel without keeping it alive.
`channel.downgrade` makes that reference; `channel.upgrade` returns `Some channel`
while a strong owner exists and `None` afterward. Closing the channel preserves
queued messages and does not expire weak references. Releasing the final strong
owner does. [The weak-channel examples](../../weak-channels.md) show both outcomes.
For a long-lived worker, [lesson 24](../24-subscriptions/README.md) instead keeps
the handler in a separate task and queues only data.

## A loop with explicit state

`loop step state` calls `step` until it returns `Stop result`. `Again next-state`
means continue from the supplied state. `Step[S, R]` is the variant type holding
those alternatives, where `S` is state and `R` is the final result. The loop
reuses call-stack space rather than adding a new frame on each iteration.
The callback can still recurse or retain growing data. See
[lesson 22](../22-recursion-and-sharing/README.md) for tail calls and the limits
of this guarantee.

Here the state is `(channel, accumulated)`. The pattern in `fn (channel,
accumulated) -> ...` names both fields. `channel.recv` returns `None` when the
closed queue is empty, so that arm stops with the accumulated total. `Some value`
names a received integer and continues with the updated total.

`produce` accepts a channel, then `()` because spawned task functions use a unit
input. `fn _ -> ...` ignores that input and delays the body until the task starts.
`each` sends the three integers in order. `let _ = ... in ...` finishes sending
before closing the channel; `_` discards the unit result. Its effect signature
lists the actions allowed at this task boundary, not actions every call performs.

## Deadlines

A **deadline** is a time limit. `task.within 50ms` cancels its task after
50 milliseconds, including child work. The sample task sleeps for `1s` (one
second), so its result is `None`. `const 1s` supplies that duration while
ignoring the task's unit input.

## The program

[`main.fwp`](main.fwp):

```fwp
squares : List[I64] -> List[Option[I64]] ! {Async}
squares = task.map (fn x -> x * x)

produce : Channel[I64] -> () -> () ! {Async, IO, Network, FileIO}
produce = fn channel -> fn _ ->
    let _ = [1, 2, 3] | each (channel.send channel | ignore)
    in channel.close channel

total : Channel[I64] -> I64 ! {Async}
total = fn channel -> loop add-next (channel, 0)

add-next : (Channel[I64], I64) -> Step[(Channel[I64], I64), I64] ! {Async}
add-next = fn (channel, accumulated) ->
    channel.recv channel | match
        None -> Stop accumulated
        Some value -> Again (channel, accumulated + value)

the-channel : Channel[I64] -> Channel[I64]
the-channel = id

main = [
    [1, 2, 3, 4] | squares | echo,
    2 | channel.make | the-channel | tap (produce | task.spawn) | total | echo,
    task.within 50ms (const 1s | task.sleep) | echo,
] | ignore
```

Run it with `fwp run docs/tutorials/06-tasks-and-channels/main.fwp` (compiled to native code and cached), or
build an executable with `fwp build docs/tutorials/06-tasks-and-channels/main.fwp -o tasks-and-channels`. The output is
[`main.out`](main.out):

```
[Some 1, Some 4, Some 9, Some 16]
6
None
```

In compiled programs, the runtime switches between task stacks on one event
loop; these lightweight tasks are often called green threads. In the
interpreter, tasks use host threads but only one executes language code at a time. See
[docs/concurrency.md](../../concurrency.md) for the details.

---

Previous: [Collections and strings](../05-collections/README.md) · Next: [Functions as executables](../07-executables-and-pipes/README.md) · [All tutorials](../README.md)
