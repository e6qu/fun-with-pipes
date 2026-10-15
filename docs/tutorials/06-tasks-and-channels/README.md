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

## A loop with explicit state

`loop step state` calls `step` until it returns `Stop result`. `Again next-state`
means continue from the supplied state. `Step[S, R]` is the variant type holding
those alternatives, where `S` is state and `R` is the final result. The loop
reuses call-stack space rather than adding a new frame on each iteration.

Here the state is `(channel, running total)`. `both id (const 0)` creates the
initial pair. `add-next` receives from the channel and sends the old state and
the optional received value to `next-step`. In its `None` arm, `.1` extracts
the total. In its `Some` arm, `curry` groups the captured state and new value
into a pair, then constructs `Again (channel, updated total)`.

`produce` also accepts `()` because spawned task functions use a unit input.
`const` discards that unused input. `send-all` builds a per-element callback
from `channel.send`; `compose ignore` discards each send's result before `each`
continues. Its explicit effect signature includes the actions allowed at this
task boundary; an effect list is permission, not proof each action occurs.

## Deadlines

A **deadline** is a time limit. `task.within 50ms` cancels its task after
50 milliseconds, including child work. The sample task sleeps for `1s` (one
second), so its result is `None`. `const 1s` supplies that duration while
ignoring the task's unit input.

## The program

[`main.fwp`](main.fwp):

```fwp
squares : List[I64] -> List[Option[I64]] ! {Async}
squares = task.map (fork mul id id)

produce : Channel[I64] -> () -> () ! {Async, IO, Network, FileIO}
produce = flip (const (both (flip send-all [1, 2, 3]) channel.close | ignore))

send-all : Channel[I64] -> List[I64] -> () ! {Async}
send-all = channel.send | flip compose ignore | each

total : Channel[I64] -> I64 ! {Async}
total = both id (const 0) | loop add-next

add-next : (Channel[I64], I64) -> Step[(Channel[I64], I64), I64] ! {Async}
add-next = fork next-step id (.0 | channel.recv)

next-step : (Channel[I64], I64) -> Option[I64] -> Step[(Channel[I64], I64), I64]
next-step = curry (match
    (_, None) -> .1 | Stop
    (_, Some _) -> curry (both (.0 | .0) (fork add (.0 | .1) .1) | Again))

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
