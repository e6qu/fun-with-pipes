# Combined server ownership and callback borrowing preparation

Updated 2026-10-17 UTC. Root `free-server-call-values` owns PR #160 at `1e1773b6`;
production `39025708821` is running and docs `39025708823` passes. Watcher 82509
requires all nine production jobs and docs before merge. No second PR is open.
This worktree is `/private/tmp/fwp-borrow-fold-captures`, branch
`borrow-fold-captures`; it combines the next delivery to avoid separate matrices.

## Change and acceptance

Request/connection ownership is based on `72a3cee0`, with the shutdown and waiter
lifetime repairs integrated from `ec0d063d`. Parsed requests move into jobs;
readers, writers, jobs and retained input/output callbacks have explicit owners.
Socket closure follows I/O completion; retained users can outlive the socket.
The new shutdown wake is explicit on polling platforms, using wait records on
task stacks, without heap allocation or larger task records. Controls cover
missing cleanup, aliases, partial construction, no-reuse execution, timeout,
cancellation, task deadlines and simultaneous readers. Review found polling
waits did not check task deadlines after timer wakeup; the combined preparation
now checks cancellation there, with the stack wait record protected during
unwind. A negative control omits that unlink and must leave a detectable stale
wait record.

Known fold/fold-right callbacks borrow their captures and input elements while
owning the running result. Escaping values acquire owners at their uses. The
verifier distinguishes external lifetimes from locally acquired copies; unwind
and entry cleanup include only owned references. Recursive callbacks and resource
close scopes retain their existing compilation. No body is added when borrowed
parameters need no counting. Actual channel-loop binaries in #160 retain a
channel 64 times per call, motivating this change; Linux now verifies removal of those 64 retains; other targets remain pending.

Linux borrowing probe **39027507441** at `f7aeb774` passes.
Next: finish Windows shutdown probe **39027501833** at `96fa4e2c`; fix failures.
Then publish one frozen
combined candidate and run all six native hosts, including the added waiter
lifetime tests. Retain equivalent-workload measurements and actual AMD64/ARM64
instructions, comparing against root's six-host server-values report. Use the
older Linux-only request/connection measurement as an intermediate cost reference,
not a reason to run a separate intermediate six-host matrix. Examine code size,
registers/stack and count traffic before claiming a benefit.

Integrate only after #160 merges. Transfer the delta after `855fe3d1`, preserve
root's final reports, accepted docs and allocation/state-fixture repairs, and
rewrite the root handoff. Do not replace it with this preparation file.

## Evidence and repaired failures

Request/connection revision `72a3cee0` passes Linux `39025894808`. Every request
and connection finalizes, with 544 managed bytes left after 1/16/256 calls in all
four workloads. Allocation requests match #160. Retains are 3 / 66 / 132 / 68 per
call plus one per connection. Root's strict collected Linux report is at
`/private/tmp/fwp-server-owners-linux-report.json`. It includes actual AMD64
cleanup instructions and the 16-byte reader-frame increase. This predates the
shutdown fix and does not establish its platform support.

Borrowing probe `39026721148` caught equality assertions on IR without equality;
shape assertions fixed them. Probe `39027098579` then passed all 31 ownership
unit tests, borrowed application and existing left-fold alias/reclamation tests.
The new workload's interpreter check found mismatched prepend/append construction;
`f7aeb774` uses matching heap strings while preserving the expected count of one.
The rerun passes the entire focused suite, including zero-retain checks.
All 36 measurement rows preserve allocations and 544 final managed bytes; channel
retains fall from 68 to 4 per call plus one per connection. The strict collected
report is `/private/tmp/fwp-server-borrows-linux-report.json` (2.98s). Actual AMD64
code inlines the borrowed callback and removes its per-send channel retain/drop.
The caller frame grows by 80 bytes but no longer nests the old 184-byte callback
frame. The ordinary binary grows 88 bytes; text grows 864. No timing claim.
The collector now has an explicit `server-borrows` comparison against #160,
requiring the ownership/fold controls and those exact counter changes.

Windows `39026702591` caught header order before declaring the Windows API
contract. `4cca1a10` fixed it. `39027091673` then exposed a reader that stayed
parked after local shutdown; the new explicit wake addresses it. Both matrices
are cancelled. A Windows control deliberately removes the wake and requires the
original bounded timeout. Do not raise the deadline or omit the check.

## Checks and limits

Use root `scripts/local-guard.py` for focused local checks. Full builds/tests,
benchmarks and large regeneration run on GitHub; fixed limits must not rise.
Prior compiler formatting passed in 1.18s and docs in 2.79s. Waiter lifetime
formatting passed in 1.36s and its docs audit in 2.83s. Integration applied cleanly;
combined formatting passed in 1.04s and docs in 2.86s. Combined native
validation remains next. Never execute downloaded
binaries locally. These are fwp revision comparisons, not timing or C/Rust parity.

HTTP graphs, escaped callback cycles, remote checked ARC, complete GC removal,
numerics, differentiation and larger applications remain open. JIT is excluded.

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
