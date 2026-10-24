# Memory between JSON API requests

Status: Linux ARM64 passes the first complete native run. Linux AMD64 O1 exceeds
the RSS budget; Windows ARM64 O2 has an idle-checkpoint timeout. Repairs and the
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
`http-idle-checks` repeats the O2 check three times with task/socket wait records.
It preserves every attempt and fails if any attempt fails.
