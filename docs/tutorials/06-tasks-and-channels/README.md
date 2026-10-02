# 6. Tasks and channels

Concurrency is structured. `task.spawn` starts a task as a child of the
current one. Every task waits for its children before it finishes, so no
task outlives the code that started it. `task.await` returns `Some result`,
or `None` if the task was cancelled.

## Channels

A channel is a bounded queue. Sending to a full channel waits, so a fast
producer cannot outrun a slow consumer (this is called backpressure).
After `channel.close`, receivers drain what is left and then get `None`.

## Loops

`loop step state` calls `step` until it returns `Stop result`. Each step
returns `Again next-state` to continue. The loop runs in constant stack
space, which makes it the tool for long-running processes:

```fwp
total : Channel[I64] -> I64 ! {Async}
total = both id (const 0) | loop add-next
```

## Deadlines

`task.within d f` runs `f` in a task with a deadline. When the deadline
passes, the task is cancelled and the result is `None`. A deadline also
applies to everything the task started.

## The program

[`main.fwp`](main.fwp):

```fwp
# 6. Tasks and channels

# Each element is handled by its own task; results come back in order.
squares = task.map (fork mul id id)

# A producer task sends into a bounded channel; the consumer reads until
# the channel is closed.
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
    # a deadline cancels a task that takes too long
    task.within 50ms (const 1s | task.sleep) | echo,
] | ignore
```

Run it with `fwp run docs/tutorials/06-tasks-and-channels/main.fwp`, or compile it with
`fwp build docs/tutorials/06-tasks-and-channels/main.fwp -o tasks-and-channels`. The output is
[`main.out`](main.out):

```
[Some 1, Some 4, Some 9, Some 16]
6
None
```

In compiled programs, tasks are green threads on an event loop; in the
interpreter, each task is a thread, and only one runs at a time. See
[docs/concurrency.md](../../concurrency.md) for the details.

---

Previous: [Collections and strings](../05-collections/README.md) · Next: [Functions as executables](../07-executables-and-pipes/README.md) · [All tutorials](../README.md)
