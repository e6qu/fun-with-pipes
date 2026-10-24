# Memory between JSON API requests

Status: the stack repair `4fc97ca1` passes all six native API jobs and both Linux
stack-policy checks. Repaired stack mappings have no huge pages. The client repair
`05de0f65` passes all twelve HTTP/protocol jobs. Native Windows probes confirm
that duplicated client sockets were inherited by unrelated child processes.
No memory budget or deadline has been relaxed. Final delivery remains pending.
This extends the [application acceptance suite](../application-acceptance.md).
It is a correctness and memory check, not a throughput benchmark or a comparison
with C/Rust servers.

The program is the maintained `examples/server/api.fwp`. Eight clients reuse
eight cleartext HTTP/1 connections. Each round checks health, item lookup, an
invalid item, a missing route, an authorized UTF-8 JSON create, rejected
authorization, missing JSON fields, a zero-duration delay, five streamed lines
and the request counter. Expected statuses and bodies are checked independently
by the Rust driver; an unoptimized interpreter run checks the same request set.

Each connection performs 1, 4, 16, 1, 16 and 4 rounds in successive groups.
The first group warms routes, metrics and reusable storage. Next, eight clients
disconnect partway through request bodies; eight more complete one normal round.
Finally, seven slow handlers enter before shutdown. The application's three-second
shutdown grace is shorter than its five-second handler timeout. The test requires
successful shutdown, closed sockets and released managed storage. A runtime
observation confirms that shutdown cancelled the listener's task group; merely
waiting for handler timeouts does not satisfy this check.

After each of the first eight groups, the listener's existing 100 ms accept
timeout provides an observation point. Sampling waits until only the listener
task remains. It does not force task retirement or change application scheduling.
The observer pauses there while the driver reads process resident memory (RSS),
then resumes through an explicit input pipe. Startup, request reads, checkpoints
and shutdown all have deadlines; failures retain diagnostics and status.

Requirements fixed before measuring:

- Managed allocator charge equals the first completed group's charge at every
  later idle checkpoint, with no tracing collections.
- Every accepted connection has closed at its checkpoint and at final shutdown.
- Raw metric-name and registry-capacity bytes stay at the warmed size. Executables
  deliberately retain these until their existing exit callback; a separate record
  checks its cleanup after the final managed-storage observation.
- RSS never exceeds the warmed sample by more than 8 MiB. This is a bounded-growth
  screen, not a claim of zero growth. Preserve every sample, including increases.
- O1 and O2 each reject controls that deliberately omit managed frees or socket
  closes after warmup. Both must exit with the observer's failure status, 241.

Managed charge counts storage currently charged to values by fwp’s allocator.
It excludes allocator pages, raw networking buffers, TLS-library storage and
task stacks. Metrics bytes exclude malloc overhead. RSS includes such resident
process costs but is not an allocation count. None of these quantities should be
added together. TLS, HTTP/2 and arbitrary servers are outside this measurement;
their existing functional and ownership checks remain required.

`tests/support/http_application.rs` drives the application; the adjacent memory
module inserts `tests/fixtures/http_app_memory.c` into generated C. Production
and the `http-application` focused workflow retain C, native binaries, diagnostic
logs, exit status and RSS samples for every variant. Native Linux uses GCC;
macOS and Windows use their production Clang toolchains. Passing one host does
not establish the others. Review actual binaries before making tracing-removal
or representation claims. The [saved-binary inspector](../../scripts/inspect-http-application.py)
checks architecture, executable sections, tracing symbols, all checkpoint records,
RSS limits and the negative controls. It reads binaries as data, without executing
another host's code. Final acceptance still requires the exact delivery source's
complete production matrix and documentation audit.

To investigate the original Linux failure, `http-mappings` runs the saved O1/O2 executables in
three fresh native processes each and records `/proc/PID/smaps` at every idle
checkpoint. Those snapshots identify resident mappings and large physical pages;
a successful diagnostic run does not turn an exceeded budget into a pass.
`http-idle-checks` compiles O2 once, verifies both negative controls, then starts
32 fresh processes from that executable with task/socket wait records. It keeps
every attempt and fails if any attempt fails. Reusing the binary avoids repeated
C compilation; each process still starts with fresh application state.

## Linux physical pages and stack reuse

The original AMD64 O1 run grew from 39,184 to 47,396 KiB RSS: 8,212 KiB, exceeding
its 8,192 KiB allowance by 20 KiB. All eight idle checkpoints still had exactly
3,120 bytes of managed charge, one listener task and no unclosed connections.
Final shutdown closed all 72 connections and released the managed charge. These
counters exclude task stacks, so they could not explain the RSS change alone.

[Mapping run 40067908998](https://github.com/e6qu/fun-with-pipes/actions/runs/40067908998)
used saved `027be46e` binaries, with diagnostic workflow `b2d34d05`. It recorded
three fresh processes at each optimization level on each Linux architecture.
These diagnostic reruns stayed within the budget; they do not erase the original
failure. They identified the large allocations:

| Native runner | Task-stack physical pages | Whole-process anonymous huge pages |
|---|---|---|
| Linux AMD64 | 2,048 KiB resident in lightly used 256 MiB stack mappings | 34–36 MiB |
| Linux ARM64 | Ordinary pages; representative stack mapping 52 KiB resident | Zero |

A virtual mapping reserves addresses. Resident pages are the physical memory
actually backing those addresses. Linux can back a small touched part of a large
mapping with a 2 MiB transparent huge page. That is wasteful for shallow task
stacks even though it can benefit dense arrays. See the
[Linux memory advice documentation](https://www.kernel.org/pub/linux/docs/man-pages/book/man-pages-6.8.pdf).

The repair requests `MADV_NOHUGEPAGE` when allocating a Linux task stack, before
using it. Reused stacks keep that policy. It preserves the 256 MiB virtual limit,
guard page and stack pool; it does not disable large pages for other storage.
A kernel built without transparent-huge-page support rejects the advice with
`EINVAL` and already uses ordinary pages. Other advice errors and guard-page
setup errors release the mapping and trap before publishing a runnable task.
Previously the guard-page setup result was ignored.

`task_stack_pages_guard_reuse_and_setup_failures` compiles the actual runtime
allocation block at O1/O2. It checks Linux mappings, guard permissions, reuse,
unsupported advice, allocation/advice/protection errors and cleanup. Deliberately
omitting advice or protection must be detected. The complete API checks and mapping snapshots below confirm application RSS
after the repair. No throughput
or C/Rust performance claim follows from this memory change.

[Repaired mapping run 40069848297](https://github.com/e6qu/fun-with-pipes/actions/runs/40069848297)
checks `4fc97ca1` in three new processes per optimization level and architecture.
All 96 repaired idle samples have ordinary task-stack pages and meet the budget.
The [sample records](http-stack-pages.json) retain both revisions, executable
hashes and artifact digests. Each table range covers all 24 samples for that row;
growth lists the three process maxima relative to each process's first sample.

| Host / C optimization | Before RSS (KiB) | Repaired RSS (KiB) | Repaired growth (KiB) |
|---|---:|---:|---|
| AMD64 / O1 | 45,320–47,404 | 13,204–13,444 | 180, 160, 196 |
| AMD64 / O2 | 45,192–47,292 | 13,092–13,288 | 176, 128, 144 |
| ARM64 / O1 | 12,408–12,616 | 12,372–12,596 | 180, 120, 124 |
| ARM64 / O2 | 12,036–12,220 | 12,004–12,172 | 144, 152, 168 |

Representative AMD64 task stacks now use 52 KiB of physical pages instead of
2,048 KiB. The AMD64 process still has 2 MiB of anonymous huge pages elsewhere:
the repair is deliberately scoped to task stacks. These runs used different
runner instances; this is direct mapping evidence and a memory-budget check,
not a paired throughput benchmark. ARM64 already used ordinary pages.

## Windows socket lifetime repair

The original Windows ARM64 O2 process completed checkpoint 40 but did not reach
48 within 20 seconds. This was a normal-request group, before the partial-body
disconnect group at 56. Its recorded managed charge was stable at 2,576 bytes.
All three O2 attempts in [diagnostic run 40067911096](https://github.com/e6qu/fun-with-pipes/actions/runs/40067911096)
passed, including negative controls. Source `4fc97ca1` also passes the six-host
API matrix (`40069237866`) and 32 fresh isolated Windows ARM64 processes
(`40069240258`). Those isolated repetitions do not reproduce the original overlap
between API clients and another test's C compilation. Neither the checkpoint
deadline nor connection-close expectations have changed.

A separate `socket-inheritance` diagnostic uses native Rust sockets on Windows
ARM64 and AMD64. It records original/cloned handle flags, drops both client
handles while a child is alive, then checks connection closure after child exit.
An explicitly inheritable socket is the control. This tests whether unrelated
compiler children can prolong a cloned client connection, a possibility reported
in [Rust issue #70719](https://github.com/rust-lang/rust/issues/70719). The first diagnostic (`10626760`, run `40069759142`) showed that the original
socket closes while a child is alive. Its cloned-socket case waited until child
exit, then the diagnostic incorrectly rejected the resulting connection reset.
The revised probe records reset and EOF as closure, preserving both results.
[The repaired probe](https://github.com/e6qu/fun-with-pipes/actions/runs/40070406753)
passes on both native Windows architectures. Original sockets have inheritance
flags 0 and close while the child lives; cloned sockets have flags 1 and remain
open until the child exits. The explicit-inheritance control reproduces this.
The saved PE executables, imports and all six observations were independently
reviewed. Isolated API repeats did not expose this overlap with compiler children;
they were diagnostics, not a repair.

The API, ordinary HTTP, WebSocket and GC test clients now hold one `TcpStream`
inside their buffered reader and borrow it for writes. No socket duplication is
needed. `client_socket_closes_while_another_child_runs` requires the actual client
connection to close while a separately started child is still alive. This avoids
serializing tests, extending deadlines or changing the language's scheduler.
Focused checks include native/interpreter HTTP, WebSocket protocols and repeated
Linux HTTP/REST memory checks. All twelve jobs at `05de0f65` pass in
[run 40070408748](https://github.com/e6qu/fun-with-pipes/actions/runs/40070408748).


## Static task-stack guards

A follow-up audit found the same unchecked protection call in Unix static-memory
startup. It now releases the shared mapping and exits with a specific diagnostic
if any task guard cannot be installed. The test compiles the production initializer
at O1/O2, checks that every guard faults while the stack body remains writable,
and injects first/last guard failures and mapping failure. An intentionally omitted
guard must be detected. All four native Linux/macOS jobs pass these checks at `cf3a11e4` in
[run 40072655673](https://github.com/e6qu/fun-with-pipes/actions/runs/40072655673).
Independent review verifies eight binaries and forty outcome records. Windows
uses its existing OS-managed fiber stacks. The [focused evidence](http-memory-focused-2026-10-24.json)
records this review and the six-host API binary checks; final delivery remains separate.
