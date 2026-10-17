# Session handoff

Updated 2026-10-17 UTC. The seven areas in [PLAN.md](../PLAN.md) remain open.
PR #155 remains the only delivery; the root worktree tracks its final gates.
This branch, `own-remote-stream-caches` in `/private/tmp/fwp-owned-stream-caches`,
prepares its successor. Do not open a second delivery before #155 is accepted.

## Verified cache component

All six native jobs passed in run `38994414068` at
`886dad3bd4c75c57c5cd53040b20a039be46437b`. The
[report](measurements/remote-client-cache-ownership-2026-10-17.json) compares actual
clients against baseline `456f2dbd`, run `38991578784`. It retains source, compiler,
CPU, generated C, binary fingerprints, repeated counts and cleanup controls.
The baseline tag is `evidence/remote-client-memory-baseline-20261017`.

Native stream positions now have typed owners. Reading consumes one owner,
moves an exclusive saved result and retains a shared result. Cleanup walks
position/optional/tuple chains in a loop, stopping at aliases. The source moves
to the next unread position; releasing it does not cancel the connection.
Iterator entries transfer arguments through owned calls. Custom decoders consume
byte inputs, return owned results, release caught errors and restore the enclosing
handler on traps. Whole connections, streams and decoder captures remain open;
remote calls still require tracing.

The unique client's final managed charge stays constant at all three sizes:
6,480 bytes on Linux AMD64; 19,536 on Linux ARM64; 2,480 on both macOS hosts;
3,632 on Windows AMD64 and 3,248 on Windows ARM64. Retained histories release to
the same final charge. This removes the baseline's 64-byte-per-integer growth.
The one-pass peak is constant too. Raw buffers, total process memory and timings
are excluded. These single-call clients do not establish bounded repeated calls.
Allocation requests remain five per integer, and effective retains rise from
about one to five per integer. That bookkeeping remains an optimization target.

Controls cover 16,384-position chains, aliases at every wrapper, shared/exclusive
reads, end/failure cleanup, exact release counts, physical reclamation without
collection and collector/reuse stress. Deliberate recursive cleanup and omitted
source release fail. Stack-address spans stay at or below 592 bytes across hosts.
Actual Linux binaries use backward cleanup branches and fixed frames of 24 bytes
on AMD64 (excluding incoming return address) and 64 on ARM64 (including saved
registers); helper-call frames are separate.

Earlier probe `38993688356` exposed record poisoning on raw position/source
storage. That is repaired with the existing raw-storage release operation.
Custom decoder tests also require detection of legacy entry, leaked error values
and stale handlers. No unresolved failure remains in this cache component's
focused matrix; full production acceptance is still required.

## Next component and delivery

Independent preparation `move-unique-closure-captures` in
`/private/tmp/fwp-closure-capture-moves` is published at `e189c868`; current probe
`38995160889` is running. It transfers captures from a consumed unique closure,
preserving typed duplication for shared closures. The preceding probe passed
existing ownership/unwind controls except two test assumptions: concatenation
order and a rounded freed-byte comparison. Those tests are repaired; the rerun
must pass before claiming capture-transfer support. Its own handoff has details.

Next: finish that probe and broader capture validation, preserve both components'
measured source identities, then assemble one substantial delivery after #155
merges. Update PLAN/history from the verified merge record. Never relabel focused
runs as production acceptance or admit remote calls to ARC prematurely.

## Local checks and documentation

Use the root local guard for all worktrees. Collection passed in 19.30s after an
incorrect SHA argument was rejected by the identity check. AMD64/ARM64 downloads
passed in 2.87s/2.85s; static inspections in 0.15s/0.14s. No artifact executable
ran locally. Collector syntax passed in 0.20s; docs audits in 2.59s and 2.53s.
The docs now identify accepted PR #153 decoder/socket/service-copy/numerical work
instead of stale preparation text. Native builds, full tests and measurements
remain on GitHub runners. Fixed resource limits are unchanged.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Typed stream and external owners; remove tracing |
| 2 | In progress | Remove intermediate storage and unnecessary reference counts |
| 3 | In progress | Reduce equivalent-work C/Rust gaps |
| 4 | In progress | Differentiation precision, speed and memory scaling |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Repeated, comparable performance measurements |
| 7 | In progress | Larger representative applications |
