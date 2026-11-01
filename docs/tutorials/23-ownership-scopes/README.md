# 23. Keeping callbacks, workers and graphs alive safely

Read [effects](../04-effects/README.md), [collections](../05-collections/README.md)
and [tasks/channels](../06-tasks-and-channels/README.md) first. This lesson uses
existing APIs to give every asynchronous operation an independent owner. It
uses ordinary tasks, scopes and maps. [Weak channels](../../weak-channels.md)
provide another explicit option for a callback that needs a link back to its queue.

An **owner** keeps storage alive. A channel owns its queued messages, while a
callback owns its captured values. Queuing a callback that captures the receiving
channel can create an owning cycle. Queuing an integer does not: the integer has
no reference back to the channel. Checked ARC accepts the latter shape and rejects
unproved retained relationships. Rejection is not proof that a particular run
would create a cycle.

## A scoped event callback

`channel.make 1` creates a queue with room for one message. `emit` takes that
channel, then `()`, and sends 7. `fn _ -> ...` ignores the unit input and delays
the send until that callback is invoked. `channel.send channel 7` states the
channel and message explicitly; `ignore` discards its success flag.

`task.scope` runs that callback and waits for its children before returning.
`tap` performs an action while preserving its input channel. Closing the channel
stops future sends but preserves queued messages: the two receives therefore
produce `Some 7`, then `None`. The callback owner is the scope, and the queue holds
only data. A persistent subscriber needs the same independent owner and explicit stop/join
rules. [Lesson 24](../24-subscriptions/README.md) builds one using tasks and a
data-only queue.

## A worker and cancellation

`produce` sends 1, 2 and 3 with `each`, then closes the queue. The local `let _`
finishes all sends before closing; the send callback discards each success flag. The parent
spawns the producer and drains the queue concurrently, so a capacity of one does
not deadlock. `sum` returns 6. Child tasks remain owned by their parent scope.

`wait-for-message` blocks on an empty queue. `cancel-worker` starts it, yields to
let it wait, cancels it, then awaits completion. `None` means the worker was
cancelled without a result. Awaiting completion is part of cleanup: requesting
cancellation alone does not establish that registrations and captured owners have
already been released. The queue never owns the task handle.

## Sending a channel through another channel

`route-message` creates an `inbox`, sends 42 and closes it, preserving that
message. It then makes a routing queue and sends the inbox through it with
`channel.send routes inbox`. The local names expose which queue is sent and
which receives it. Each `let _` sequences one action before the next.

Receiving from the routing queue gives `Some inbox`; mapping `channel.recv`
over that option receives `Some 42` from the inbox. The result is therefore
`Some (Some 42)`: the two options describe two independent receives.

Checked ARC accepts this ownership direction. The routing queue can own the
inbox, but the inbox holds only integers and cannot refer back. Recursive channel
types and queued HTTP/2 streams remain rejected. Known task handles have a
separate proof that follows their computation, captures and result owners; an
unknown task producer is still rejected.
Closing a queue does not discard its messages,
and receiving transfers the queued owner. Dropping the last owner releases any
messages that remain; no implicit drain operation is added.

## Sending a function through a channel

The local `callbacks` value is a queue for functions of type `I64 -> I64`. The partial
application `add 3` saves the number `3` for a later call. That saved value is a
**capture**. It cannot refer back to the queue, so this function has no ownership
cycle. `add-through-queue` sends it, receives it, then applies it to `5`:

```fwp
add-through-queue = fn _ ->
    let callbacks = channel.make 1
    in let _ = channel.send callbacks (add 3)
    in channel.recv callbacks | option.map (apply 5)
```

`fn _` ignores the initial `()`; `channel.make 1` explicitly selects capacity one.
The result is `Some 8`. `option.map` runs its function only for a received message;
`apply 5` calls that received function with `5`.

The compiler checks the saved values, not just the arrow type. The current subset
permits immutable captures, including strings, containers and other proved
functions. The compiler also admits shared socket handles (`UdpSocket`,
`Listener`, `Conn`): they cannot own a queue or callback. The
[socket example and validation status](../../ownership.md#functions-stored-in-channels)
explain their lifetime and current checks. Known data-only channels and task computations can also pass when their
captures and results cannot lead back to the queue. Unknown producers and
unproved HTTP/2 stream contexts remain rejected. Files have a separate single-use rule that forbids
capturing them in reusable functions; pass a file as the last argument instead.
A function using State
or autodiff must still run inside the required scope after it is received; sending
it does not preserve a sender's temporary scope. See the
[proof and validation status](../../ownership.md#functions-stored-in-channels).

## A graph with deletion

`graph` owns two records, keyed by integer IDs 0 and 1. Each record's `links` list
contains the other ID. This is a logical cycle, but the integers own no nodes.
`map.remove 1` creates a graph without node 1, and `map.get 1` returns `None`.
The other branch still sees node 0's link `[1]`. Thus deletion does not silently
repair incoming links: callers must check lookup or explicitly remove those links.
This example never reuses IDs. If a slot is reused, pair its index with a
**generation**, a number changed each time the slot gets a new occupant. A lookup
must match both. For example, an old `(2, 4)` handle must not find the replacement
at `(2, 5)`. The [generation example](../../../tests/fixtures/graph_generations.fwp)
checks stale lookup, deletion and reuse; its expected output is stored beside it.

`both f g` runs both functions on the same input and returns a pair. Immutable
sharing preserves the original graph for the second branch; it does not mutate
that graph when the first branch removes node 1.

## Run it

From the repository root:

```sh
fwp run --interp docs/tutorials/23-ownership-scopes/main.fwp
fwp build docs/tutorials/23-ownership-scopes/main.fwp -o ownership-scopes
./ownership-scopes
```

The expected output is:

```text
(Some 7, None)
6
None
Some (Some 42)
Some 8
(None, Some [1])
```

The integration checks compare raw interpretation with counted native execution
and verify reclamation after teardown. The [ownership guide](../../ownership.md#functions-stored-in-channels) links the
separate channel, task and callback checks. This example alone does not prove
arbitrary callbacks or graphs safe.

[`main.fwp`](main.fwp):

```fwp
emit : Channel[I64] -> () -> () ! {Async}
emit = fn channel -> fn _ -> channel.send channel 7 | ignore

produce : Channel[I64] -> () -> () ! {Async, IO, Network, FileIO}
produce = fn channel -> fn _ ->
    let _ = [1, 2, 3] | each (channel.send channel | ignore)
    in channel.close channel

wait-for-message : Channel[I64] -> () -> () ! {Async}
wait-for-message = fn channel -> fn _ -> channel.recv channel | ignore

cancel-worker : Channel[I64] -> Option[()] ! {Async, IO, Network, FileIO}
cancel-worker = fn channel ->
    let worker = task.spawn (wait-for-message channel)
    in let _ = task.yield ()
    in let _ = task.cancel worker
    in task.await worker

route-message : () -> Option[Option[I64]] ! {Async}
route-message = fn _ ->
    let inbox = channel.make 1
    in let _ = channel.send inbox 42
    in let _ = channel.close inbox
    in let routes = channel.make 1
    in let _ = channel.send routes inbox
    in let _ = channel.close routes
    in channel.recv routes | option.map channel.recv

add-through-queue : () -> Option[I64] ! {Async}
add-through-queue = fn _ ->
    let callbacks = channel.make 1
    in let _ = channel.send callbacks (add 3)
    in channel.recv callbacks | option.map (apply 5)

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
    () | add-through-queue | echo,
    graph
    | both (map.remove 1 | map.get 1) (map.get 0 | option.map .links)
    | echo,
] | ignore
```

See [ownership contracts](../../ownership.md#cycle-and-retention-contract) for the
limits. [Weak channels](../../weak-channels.md) provide non-owning links to queues;
[the graph generation example](../../../tests/fixtures/graph_generations.fwp)
shows how to reject a stale ID after reusing a deleted node’s slot. Both have
verified regression checks. Tracing GC is removed; [the plan](../../../PLAN.md)
tracks the remaining work to reduce reference counting and temporary storage.
