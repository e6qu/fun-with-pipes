# Connection ownership preparation

Updated 2026-10-17 UTC. This branch prepares the next delivery; it is not the
active pull request. Root `free-server-call-values` owns PR #160 at
`1f1a928738ae32d88bcd2a7ac1fff1e0004e0f3c`, whose final production run
`39023664259` is running and documentation `39023663596` passes. Keep that
head stable. Merge only after all nine production jobs and docs pass.

## Change and acceptance

Base request preparation `4b7ecb8bb16583f48ae8fc9d85f0cda5c623b23e` passes Linux
`39024071318`; the earlier move revision also passes `39023556994`. Every
request finalizes in four workloads at 1/16/256 calls. The move version leaves
864 managed bytes independent of call count and has 2 / 65 / 130 / 66 retains
per call (greeting / returned stream / sent stream / output channel). Allocation
counts and requested bytes match #160. Guarded exact comparison passed in 0.20s.

This branch gives accepted gRPC connections explicit owners for startup,
reader/writer tasks, serving jobs and retained input/output callbacks. Startup
ownership transfers to the reader; the writer and independently live jobs retain
storage. Socket closure still follows I/O task completion, allowing callbacks
to observe a closed connection until their last owner releases its record.
HTTP handler graphs and remote checked ARC remain outside this proof.

New tests exercise startup failure, TLS rejection, cancellation before reader
or writer entry, writer startup failure, job count overflow, a retained serving
context and a channel surviving connection closure. Deliberately omitted cleanup
must make the tests fail. Run at O1/O2 with collection on/off, stress verification
and reuse poisoning. Preserve existing client startup and server tests.

Linux connection probe `39024793754` at `6acdd93c` passes the new request and
connection tests, existing startup/listener tests, channels and task reclamation.
It failed an older output-channel negative control: its source anchor matched
both job and channel cleanup after this change. The repair names the sink context
explicitly and still requires the omitted release to fail. The probe did not
reach end-to-end service tests or measurement, so it is not acceptance.

An existing startup fixture used Unix `fcntl` to check an open socket. It now
uses portable `getsockopt` and the platform's invalid-socket constant. Both new
targets have explicit macOS GC-shard and Windows production assignments; Windows
also gains the portable client startup test. The report collector has an explicit
`server-owners` comparison against the #160 report, requiring every request and
connection finalized, constant final managed storage and unchanged allocations.

Next: finish local formatting/audits, publish and freeze the combined candidate
for all six native hosts. Fix any failures. Retain unchanged-workload memory,
allocation and count comparisons and inspect actual ARM64/AMD64 instructions.
Do not execute downloaded artifacts. No full builds locally. Integrate into the
next substantial PR only after #160 merges; preserve its final evidence/docs.
All seven work areas in PLAN.md remain open; this does not complete GC removal.

## Local checks

Root-guarded `cargo fmt --all` passed in 1.22s. `python3 scripts/check-roadmap.py` passed in 2.84s (52 link sets,
106 immutable preparation pairs and seven roadmap steps). `git diff --check`
passes. Native test-runner tests pass (7 tests, guarded 1.16s). Request binary inspection
passed in 0.15s, without executing artifacts. Broader native checks remain pending
on GitHub. Final formatting passed in 1.10s, docs in 2.63s; real Cargo
metadata coverage and report syntax checks passed in 0.14s (all 236 targets
assigned, including both new ownership targets).

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
