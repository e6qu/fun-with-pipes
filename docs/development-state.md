# Connection ownership preparation

Updated 2026-10-17 UTC. This branch prepares the next delivery; it is not the
active pull request. Root `free-server-call-values` owns PR #160 at
`1f1a928738ae32d88bcd2a7ac1fff1e0004e0f3c`, whose final production run
`39023664259` is running and documentation `39023663596` passes. Keep that
head stable. Merge only after all nine production jobs and docs pass.

## Change and acceptance

Base request preparation `4b7ecb8bb16583f48ae8fc9d85f0cda5c623b23e` passes Linux
`39024071318`; the earlier move revision also passes `39023556994`. Every
request finalizes in four workloads at 1/16/256 calls. The first version left
864 managed bytes independent of call count. The move version removes one
request retain per call; collect its exact counters before publishing claims.

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

Next: format and audit locally using the root guard; publish preparation and run
Linux `server-repeat`. Fix any failures, then freeze the combined request and
connection candidate for all six native hosts. Retain unchanged-workload memory,
allocation and count comparisons and inspect actual ARM64/AMD64 instructions.
Do not execute downloaded artifacts. No full builds locally. Integrate into the
next substantial PR only after #160 merges; preserve its final evidence/docs.
All seven work areas in PLAN.md remain open; this does not complete GC removal.

## Local checks

Root-guarded `cargo fmt --all` passed in 1.22s. `python3 scripts/check-roadmap.py` passed in 2.84s (52 link sets,
106 immutable preparation pairs and seven roadmap steps). `git diff --check`
passes. Native checks remain pending on GitHub.

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
