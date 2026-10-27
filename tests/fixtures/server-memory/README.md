# Measuring memory in a server after repeated calls

A remote call runs part of a program in another process. Earlier client
measurements exclude that server process; they cannot prove its values or
serving tasks are released. This baseline measures the native server itself.

Each client takes a call count on the command line. `I64` is a signed 64-bit
integer. `consume : I64 -> I64` takes a call index and returns its numeric result;
the channel variant adds `! {Async}` to declare task/channel operations.
`const` supplies the same input for each call; `step` adds the response to an accumulated total. `curry`
adapts the tuple-taking body of `step` to the two arguments supplied by fold.
The four workloads are:

- `unary-strings`: send a 64-character name and receive a greeting. The server
  adds the seven characters `hello, `, so each result has length 71.
- `response-stream`: ask for integers 1 through 64 and sum them, giving 2,080.
  An iterator produces these values as the caller requests them.
- `request-stream`: send those 64 integers and receive their sum, 2,080.
- `channel-output`: ask the server to send `tick 1` through `tick 64` into a
  channel, a queue used to communicate between tasks. Close and drain the queue
  after the call, then add the string lengths, giving 439.

Each measured server process receives 1, 16 or 256 sequential calls from one
client, with three fresh server processes per case. The client uses ordinary
connection reuse. Samples follow serving-task removal from the scheduler;
physical task-record freeing is measured separately by the resulting managed
storage. The final sample waits for client disconnection and removal of all
connection and serving tasks. The server remains alive with its listener open.

Generated clients and servers use native `-O2` and counted ownership.
Counters begin after
listener, routing and root-task setup. They cover managed allocation requests,
requested/charged bytes, reference-count increments and selected allocation
categories. Categories count allocations, not identities of remaining objects.
Raw request/wire buffers, stack pools, TLS/OS/allocator metadata, whole-process
memory and timing are excluded. Both an interpreted server and ordinary native
server provide functional output references. No timing or C/Rust comparison is
claimed. Finalized connection/stream counts and zero live tasks check this
specific cleanup boundary; they do not prove every server lifetime.

An idle scheduler can remain on the last finished task's stack until another
task becomes ready. The measurement wakes the existing listener once, after
the connection closes and all spawned tasks finish, so the ordinary scheduler
can retire that final task before sampling. This adds no task or connection;
comparisons must use the same wake and drain boundary.

[Recorded protocol and results](../../../docs/measurements/remote-server-storage.md) name the
measured revisions. [The plan](../../../PLAN.md) tracks current acceptance work.
