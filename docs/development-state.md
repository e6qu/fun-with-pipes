# Connection ownership preparation

Updated 2026-10-17 UTC. Root `free-server-call-values` owns PR #160 at `1e1773b6`;
production `39025708821` is running and docs `39025708823` passes. Its watcher
session 82509 merges only after all nine production jobs and docs pass for that
head. This worktree prepares the next delivery; no second PR is open.

## Current change

Worktree `/private/tmp/fwp-server-connection-owners`, branch
`own-server-connections`, is published at `96fa4e2c` with Windows AMD64 probe
**39027501833** running. The next local delta adds wait-record lifetime checks
and the plain explanation in [ownership](ownership.md).

Parser lists own requests until moving them into serving jobs, including a
request reset in the same input batch. Connection startup moves into the reader;
writer tasks, jobs and retained input/output callbacks acquire separate owners.
Socket closure follows I/O completion; retained users keep the closed record
alive until their last release. Tests cover partial construction, failure,
pre-entry cancellation, overflow, retained aliases and explicit no-reuse builds.
HTTP graphs, escaped callback cycles and remote checked ARC remain unproved.

Native Windows exposed two issues in the newly enabled client startup test.
`4cca1a10` fixes Windows API declaration order before a standard header. The next
run `39027091673` compiled, but timed out draining a reader after local shutdown.
`96fa4e2c` explicitly wakes socket waiters on shutdown/close. Polling wait records
live on task stacks and unlink on return/cancellation; no heap allocation or
task-header field is added. A Windows negative control removes the wake and
requires the original bounded timeout. Additional local checks exercise timeout,
cancellation and waking two readers on one descriptor.

Next: finish the Windows probe and fix failures, then publish the added lifetime
checks and run all six hosts at one frozen revision. Refresh measurements and
actual ARM64/AMD64 reviews because the runtime changed. Preserve explicit macOS
GC-shard and Windows assignments, all existing stress/reuse tests, and the state
fixture repaired in #160. Do not increase test timeouts to hide the failure.

## Earlier evidence and limits

Runtime `72a3cee0` passes Linux `39025894808`: every request and connection
finalizes; all four workloads leave 544 managed bytes after 1/16/256 calls.
Allocations/requested bytes match #160. Retains per call are 3 / 66 / 132 / 68,
plus one per connection, for greetings / returned streams / sent streams / text
channels. Collection is off and physical freeing on, three fresh processes per
case. This compares identical fwp workloads, not C/Rust timing.

The root collector validated that Linux report in 2.99s. Its private location is
`/private/tmp/fwp-server-owners-linux-report.json`; artifacts are under
`/private/tmp/fwp-server-memory-evidence/39025894808`. Actual AMD64 instructions
show request/connection cleanup, distinct socket closure and a 16-byte reader
frame increase. These are earlier-revision results, not validation of the new
shutdown fix. Never execute downloaded binaries locally.

Earlier failed candidates exposed an ambiguous negative-control source anchor,
unconditional connection counting in no-reuse mode, and a missing message schema
in the no-reuse test. All are repaired without removing their controls. Runs
`39025166581`, `39025450771` and `39026702591` are cancelled; cancellation was
requested for superseded `39027091673`. Old evidence tags remain immutable.

Integration starts from this branch's delta after `855fe3d1`. Preserve root's
final #160 reports, accepted documentation and allocation/state-fixture repairs;
do not replace the root handoff with this preparation file. The independent
compiler borrowing candidate is tracked only in the root handoff.

## Checks and resource limits

Use `python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py COMMAND...`
for focused local checks. Full builds/tests and measurements run on GitHub.
Keep the fixed CPU/memory/disk/deadline limits. Shutdown repair formatting passed
in 1.30s and its documentation audit in 2.79s. Added waiter checks pass formatting
in 1.36s; native results are pending. The earlier documentation audit failure for
a missing `Next:` marker was repaired; its premature pass claim was corrected.

All seven roadmap areas remain open. Complete GC removal, lower count costs,
numerics, differentiation and larger programs remain work. JIT is excluded.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Server requests/connections and external owners; remove tracing |
| 2 | In progress | Remove intermediate storage and unnecessary reference counts |
| 3 | In progress | Reduce equivalent-work C/Rust gaps |
| 4 | In progress | Differentiation precision, speed and memory scaling |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Repeated, comparable performance measurements |
| 7 | In progress | Larger representative applications |
