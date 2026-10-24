# Memory between JSON API requests

Status: source `027be46e` passes all seven checks on Linux ARM64, both macOS
architectures and Windows AMD64. Linux AMD64 O1 exceeds the RSS budget; Windows
ARM64 O2 has an intermittent idle-checkpoint timeout. The stack-page repair and
complete native matrix remain pending. Neither limit has been relaxed.
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

For the open Linux failure, `http-mappings` runs the saved O1/O2 executables in
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
omitting advice or protection must be detected. The complete API run and new
mapping snapshots must confirm application RSS after the repair. No throughput
or C/Rust performance claim follows from this memory change.

## Windows timeout investigation

The original Windows ARM64 O2 process completed checkpoint 40 but did not reach
48 within 20 seconds. This was a normal-request group, before the partial-body
disconnect group at 56. Its recorded managed charge was stable at 2,576 bytes.
All three O2 attempts in [diagnostic run 40067911096](https://github.com/e6qu/fun-with-pipes/actions/runs/40067911096)
passed, including negative controls. That does not establish a repair: the
original timeout remains open while repeated saved-binary runs gather task and
socket state. Neither the checkpoint deadline nor connection-close expectations
have changed.

A separate `socket-inheritance` diagnostic uses native Rust sockets on Windows
ARM64 and AMD64. It records original/cloned handle flags, drops both client
handles while a child is alive, then checks connection closure after child exit.
An explicitly inheritable socket is the control. This tests whether unrelated
compiler children can prolong a cloned client connection, a possibility reported
in [Rust issue #70719](https://github.com/rust-lang/rust/issues/70719). It is a
hypothesis until the runner results confirm it; no runtime repair follows merely
from that report.
