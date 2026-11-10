# Make the slow-reader test exercise a blocked write

**Windows verification is pending.** The test must observe the real socket
would-block branch, preserve other clients' progress and release all resources.
Increasing a timeout or accepting a run without that branch is not a repair.

## What failed

The [PR #274 matrix](https://github.com/e6qu/fun-with-pipes/actions/runs/42730888995)
tests `a0261f9ccaa4a87651fbcae11966afee68208d4d`. Both Windows architectures fail
`api_slow_clients_release_backpressured_output_o2`: no blocked-write marker
arrives within 15 seconds. Their remaining completed HTTP tests pass.

The ARM64 server log shows eight connections waiting for reads and none for
writes before the first cleanup checkpoint. This suggests the response was
accepted into transport buffers; it does not establish a runtime deadlock.
An isolated diagnostic records each large send's actual return value:
tag `roadmap/http-pressure-diagnosis-2026-11-10`,
[run 42742448906](https://github.com/e6qu/fun-with-pipes/actions/runs/42742448906).

The original test requests an 8 MiB response and a 16 KiB send buffer, then
assumes the write must block. A successful socket send does not establish that
the peer consumed its bytes. [Winsock's send contract](https://learn.microsoft.com/en-us/windows/win32/api/winsock2/nf-winsock2-send)
permits a nonblocking send to accept part or all of the requested data, depending
on available transport buffering.

## Candidate and acceptance

The candidate uses tag `roadmap/http-pressure-bounds-2026-11-10`:

- Limit each diagnostic send to 16 KiB, while retaining the complete 8 MiB
  application response and the ordinary write loop/readiness wait.
- Set the unread Windows client's receive-buffer request to 256 KiB and verify
  the value returned by `getsockopt` before sending the request.
- Keep the existing 15-second blocked-write and 30-second response deadlines.
- Require another client to finish a normal item request while the large client
  is still not reading. Check every consumed response byte.
- Preserve all eight cohorts: full transfer, split header, partial request body,
  interleaved reads, disconnects, reuse, cancellation and final cleanup.
- Keep exact socket/task/managed-memory checks and the warmed RSS budget.

These controls apply only to the saved diagnostic C and its test client. They
change neither ordinary runtime writes nor sustained-load benchmark settings.
The test never injects a synthetic would-block result or skips a platform.

Focused verification uses the production Rust O1 settings and native Windows
toolchains: [ARM64](https://github.com/e6qu/fun-with-pipes/actions/runs/42744070652)
and [AMD64](https://github.com/e6qu/fun-with-pipes/actions/runs/42744095817).
Both must pass before the final combined repair goes through the full matrix.
Retain original failures, send results, cleanup logs and exact source identities.

See the [complete application/load contract](application-tooling.md) for the
unchanged endpoint, timing scope and memory accounting.
