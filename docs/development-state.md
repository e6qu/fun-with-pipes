# Connection ownership preparation

Updated 2026-10-17 UTC. This branch prepares the next delivery; it is not the
active pull request. Root `free-server-call-values` owns PR #160 at
`1e1773b6d75fea3b16585c637738bd9fc52e836d`, with new production
`39025708821` and docs `39025708823` queued after repairing a state-restoration
fixture that called the old method-dispatch interface. Keep that
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

Further review found a real mode mismatch: accepted connections were counted
in explicit `FWP_REUSE=0` builds, but output channels in that mode do not acquire
counted owners. Connection startup now activates counts only with resource
ownership enabled, matching request/source/channel construction. A separate
compiler subprocess selects no-reuse mode and tests a channel retained across
socket closure, plus a deliberately broken unconditional-count control.

Superseded six-host `39025166581` at `d3d68598` was cancelled after finding this
bug; it is not acceptance. The immutable tag `evidence/server-owners-20261017`
retains that candidate. The corrected source is `7770db9a9c2bebee455d9c02dd748fbd7e54fb11`, frozen as
`evidence/server-owners-modes-20261017`; all-six run `39025450771` failed the ARM64 no-reuse regression. Its test channel
had no message schema, so actual encoding dereferenced NULL before sending. The
fixture now supplies a real one-field integer schema; runtime behavior is unchanged.
It also includes the direct-dispatch state fixture repair from PR #160 and adds
that focused test to the server suite/report checks. Cancel the superseded run
and publish this corrected test candidate under a new immutable tag.
Next: run the corrected Linux probe, then all six hosts; fix failures, collect
and compare their measurements, and review
actual ARM64/AMD64 binaries. Do not move old evidence tags. Retain unchanged-workload memory,
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
assigned, including both new ownership targets). No-reuse fix formatting passed
in 1.28s; the documentation audit failed in 2.51s because the rewrite removed the
required `Next:` marker. That marker is restored; the rerun passed in 2.66s (52 link sets,
106 immutable pairs and seven roadmap steps). The earlier recorded pass was
incorrect; the documentation-only correction did not change the frozen runtime.
The message-schema/state-fixture revision passes formatting in 1.02s and the
documentation audit in 2.41s.

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
