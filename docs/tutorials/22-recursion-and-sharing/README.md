# 22. Recursion, loops and shared values

Read lessons 1–5 first. This lesson distinguishes a program's result from the
storage needed to compute it. A **call stack** holds unfinished function calls;
the **heap** holds separately allocated values that can outlive a call.

## When recursion can reuse a call frame

`rec` permits a definition to call itself. `down` takes a nonnegative integer,
subtracts one until zero, and returns zero. Its recursive call is a **tail call**:
there is no calculation left after that call returns. Reusing the current frame
would preserve the result.

`count-back` also descends to zero, but adds one after each recursive result.
Starting from four gives four: four additions remain pending. Those calls are
not in tail position. Turning this into an accumulator loop is a separate
transformation; in other programs it can change overflow, rounding or effect order.

For eligible direct self-tail recursion, such as `down`, the compiler proves
that the next call can reuse the current function frame. Ordinary interpreted
and native execution then use bounded call-stack space for that recurrence,
including native O0 builds.
`count-back` keeps ordinary recursion because additions remain pending. Other
calls inside an iteration can still recurse or allocate.

A function can contain both kinds of call. In `mixed`, the `1` branch calls
`mixed` on zero and then adds one; that call needs an ordinary frame. The `_`
branch subtracts one and returns the recursive result directly, so it reuses
its frame.

Starting from four follows `4 → 3 → 2 → 1 → 0` and returns one.
Even a much larger positive input leaves only one addition pending. By contrast,
`count-back` leaves one pending addition per step. Calls used to compute another
call's arguments also need ordinary frames: this optimization does not make
arbitrary recursion use constant stack space.

Resource cleanup, task/channel owners and unknown closure captures can prevent
this proof. `FWP_DUMP_IR=1` explains lowering decisions. The raw interpreter
(`FWP_NO_OPT=1`) and source debugger preserve original recursive calls; use the
small four-step examples in those modes. The
[tail-call contract](../../design.md#tail-calls-and-recursion) lists the supported
cases and cleanup restrictions.

### Result versus unfinished work

| Call | Result for input 4 | Work waiting for recursion to return |
|---|---|---|
| `down` | `0` | None; eligible self-tail calls reuse the frame. |
| `count-back` | `4` | Four additions; ordinary recursive frames remain. |
| `mixed` | `1` | One addition in the `1` arm. |

“Tail” describes a call's position, not the whole function. This is why `mixed`
can contain both reused and ordinary frames.

## An explicit loop

`loop step state` repeatedly calls `step` and uses bounded stack for that loop.
`Step[State, Result]` has two alternatives: `Again next-state` continues, and
`Stop result` returns. `down-step` uses the current integer as its state and
stops at zero. Thus `100000 | down-loop` returns zero without accumulating
100,000 unfinished recursive calls. A loop's callback can still recurse or
retain growing data; `loop` does not bound that separate work.

## Keeping an older value

`both f g` applies both functions to the same input and returns their results
as a pair. In `preserve-old`, `id` keeps the input and `map (add 1)` makes an
incremented list. The result contains both `[1, 2, 3]` and `[2, 3, 4]`.
Immutable value semantics require the first list to stay unchanged. The compiler
may reuse storage only when no other live value needs its old contents.

A **move** transfers ownership, a **borrow** uses storage kept alive by an owner,
and **sharing** gives several values a reason to keep that storage alive.
These are implementation choices here; the example adds no ownership syntax.
Keeping both lists can require extra storage. Faster code must preserve both
results, not overwrite the first list to save an allocation.

## A graph can contain a logical cycle

`Node` is a record with a name and a list of neighboring node numbers. `ring`
contains two nodes: number 0 points to number 1, and number 1 points back to 0.
`map .next` prints `[[1], [0]]`, the two neighbor lists.

The graph owns the nodes; the numbers are data, not owning references to nodes.
This represents a logical cycle without a cycle of memory owners. A larger API
would need checked lookup and a rule for deletion/stale numbers; this tiny example
does neither. Keeping the whole graph alive also keeps its nodes alive.

Automatic reference counting (ARC) frees an object when its last owner releases
it. A cycle of owning references needs another release strategy; ordinary ARC
alone cannot reclaim an unreachable cycle. fwp rejects unproved owning cycles before execution. Graph IDs are one useful representation, not automatic cycle repair.

## Run the program

From the repository root, run `fwp run docs/tutorials/22-recursion-and-sharing/main.fwp`.
Add `--interp` to use the interpreter. Both should print the output below.

[`main.fwp`](main.fwp):

```fwp
rec down : I64 -> I64
down = match
    0 -> 0
    _ -> sub 1 | down

rec count-back : I64 -> I64
count-back = match
    0 -> 0
    _ -> sub 1 | count-back | add 1

rec mixed : I64 -> I64
mixed = match
    0 -> 0
    1 -> 0 | mixed | add 1
    _ -> sub 1 | mixed

down-step : I64 -> Step[I64, I64]
down-step = match
    0 -> Stop 0
    _ -> sub 1 | Again

down-loop = loop down-step
preserve-old = both id (map (add 1))

Node = { name: String, next: List[I64] }
ring =
    [Node { name = "first", next = [1] }, Node { name = "second", next = [0] }]

main = [
    4 | down | echo,
    4 | count-back | echo,
    4 | mixed | echo,
    100000 | down-loop | echo,
    [1, 2, 3] | preserve-old | echo,
    ring | map .next | echo,
] | ignore
```

[`main.out`](main.out):

```text
0
4
1
0
([1, 2, 3], [2, 3, 4])
[[1], [0]]
```

Cycles are a different ownership problem: two objects can keep each other alive
without an outside owner. fwp's [accepted memory direction](../../gc-removal-design.md)
rejects unproved owning cycles and provides [weak channel links](../../weak-channels.md). A weak link does
not keep its target alive; `channel.upgrade` returns `None` after expiration.
This lesson uses integer graph IDs instead, so lookup rather than weak acquisition
determines whether a target still exists.
The [tail-call design](../../design.md#tail-calls-and-recursion) describes the
implemented frame reuse, remaining limits and cleanup rules.

---

Previous: [MCP tools](../21-mcp/README.md) · Next: [Ownership scopes](../23-ownership-scopes/README.md) · [All tutorials](../README.md)
