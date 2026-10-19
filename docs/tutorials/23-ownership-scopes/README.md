# 23. Keeping callbacks, workers and graphs alive safely

Read [effects](../04-effects/README.md), [collections](../05-collections/README.md)
and [tasks/channels](../06-tasks-and-channels/README.md) first. This lesson uses
existing APIs to give every asynchronous operation an independent owner. It
introduces no weak-reference or subscription API.

An **owner** keeps storage alive. A channel owns its queued messages, while a
callback owns its captured values. Queuing a callback that captures the receiving
channel can create an owning cycle. Queuing an integer does not: the integer has
no reference back to the channel. Checked ARC accepts the latter shape and rejects
unproved retained relationships. Rejection is not proof that a particular run
would create a cycle.

## A scoped event callback

`channel.make 1` creates a queue with room for one message. `emit` takes that
channel, then `()`, and sends 7. `channel.send` takes the channel before the
message; `flip channel.send 7` selects the message first, so the channel can be
piped into it. `ignore` discards the success flag. `const` ignores an input:
`flip (const work)` turns `work channel` into a callback accepting `()` after
the channel has been supplied, without running the work during partial application.

`task.scope` runs that callback and waits for its children before returning.
`tap` performs an action while preserving its input channel. Closing the channel
stops future sends but preserves queued messages: the two receives therefore
produce `Some 7`, then `None`. The callback owner is the scope, and the queue holds
only data. A persistent event subscription would need the same independent
registration owner plus explicit disconnect/active-callback rules; this example
does not implement that larger API.

## A worker and cancellation

`produce` sends 1, 2 and 3, then closes the queue. `send-all` applies the same send
to each list element; `compose ignore` discards each success flag. The parent
spawns the producer and drains the queue concurrently, so a capacity of one does
not deadlock. `sum` returns 6. Child tasks remain owned by their parent scope.

`wait-for-message` blocks on an empty queue. `cancel-worker` starts it, yields to
let it wait, cancels it, then awaits completion. `None` means the worker was
cancelled without a result. Awaiting completion is part of cleanup: requesting
cancellation alone does not establish that registrations and captured owners have
already been released. The queue never owns the task handle.

## Sending a channel through another channel

`routes` makes a queue whose messages are integer channels. `route-message`
creates an `inbox`, sends 42 to it and closes it, preserving that message.
`both id (const 1 | routes)` pairs the inbox with a new routing queue.
`fork channel.send .1 .0` sends the inbox (`.0`) through the routing queue (`.1`).
Here `fork f g h` computes `f (g input) (h input)`, so the send order is explicit.

Receiving from the routing queue gives `Some inbox`; mapping `channel.recv`
over that option receives `Some 42` from the inbox. The result is therefore
`Some (Some 42)`: the two options describe two independent receives.

Checked ARC accepts this ownership direction. The routing queue can own the
inbox, but the inbox holds only integers and cannot refer back. It still rejects
recursive channel types and queued functions, tasks or HTTP stream handles whose
captures could complete a cycle. Closing a queue does not discard its messages,
and receiving transfers the queued owner. Dropping the last owner releases any
messages that remain; no implicit drain operation is added.

## A graph with deletion

`graph` owns two records, keyed by integer IDs 0 and 1. Each record's `links` list
contains the other ID. This is a logical cycle, but the integers own no nodes.
`map.remove 1` creates a graph without node 1, and `map.get 1` returns `None`.
The other branch still sees node 0's link `[1]`. Thus deletion does not silently
repair incoming links: callers must check lookup or explicitly remove those links.
This example never reuses IDs. A reusable-ID API would also need generations or
another rule to stop an old ID from naming an unrelated replacement node.

`both f g` runs both functions on the same input and returns a pair. Immutable
sharing preserves the original graph for the second branch; it does not mutate
that graph when the first branch removes node 1.

## Run it

From the repository root:

```sh
fwp run --interp docs/tutorials/23-ownership-scopes/main.fwp
fwp build --gc arc docs/tutorials/23-ownership-scopes/main.fwp -o ownership-scopes
./ownership-scopes
```

The expected output is:

```text
(Some 7, None)
6
None
Some (Some 42)
(None, Some [1])
```

The integration checks compare raw interpretation with counted native execution
and verify reclamation after teardown. Passing evidence for the current revision
belongs in the [handoff](../../development-state.md); this example alone does not
prove arbitrary callbacks or graphs safe.

[`main.fwp`](main.fwp):

```fwp
emit : Channel[I64] -> () -> () ! {Async}
emit = flip (const (flip channel.send 7 | ignore))

send-all : Channel[I64] -> List[I64] -> () ! {Async}
send-all = channel.send | flip compose ignore | each

produce : Channel[I64] -> () -> () ! {Async, IO, Network, FileIO}
produce = flip (const (both (flip send-all [1, 2, 3]) channel.close | ignore))

wait-for-message : Channel[I64] -> () -> () ! {Async}
wait-for-message = flip (const (channel.recv | ignore))

cancel-worker : Channel[I64] -> Option[()] ! {Async, IO, Network, FileIO}
cancel-worker =
    wait-for-message
    | task.spawn
    | tap (const () | task.yield)
    | tap task.cancel
    | task.await

inbox : I64 -> Channel[I64] ! {Async}
inbox = channel.make
routes : I64 -> Channel[Channel[I64]] ! {Async}
routes = channel.make
route-message : () -> Option[Option[I64]] ! {Async}
route-message =
    const 1
    | inbox
    | tap (flip channel.send 42)
    | tap channel.close
    | both id (const 1 | routes)
    | tap (fork channel.send .1 .0)
    | .1
    | tap channel.close
    | channel.recv
    | option.map channel.recv

Node = { label: String, links: List[I64] }
graph : Map[I64, Node]
graph =
    map.empty
    | map.insert 0 Node { label = "first", links = [1] }
    | map.insert 1 Node { label = "second", links = [0] }

main = [
    1
    | channel.make
    | tap (emit | task.scope)
    | tap channel.close
    | both channel.recv channel.recv
    | echo,
    1 | channel.make | tap (produce | task.spawn) | channel.drain | sum | echo,
    1 | channel.make | cancel-worker | echo,
    () | route-message | echo,
    graph
    | both (map.remove 1 | map.get 1) (map.get 0 | option.map .links)
    | echo,
] | ignore
```

See [ownership contracts](../../ownership.md#proposed-cycle-policy) for the design
limits and the distinction between current checked ARC and proposed weak handles.
