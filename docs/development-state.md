# Session handoff

Updated 2026-10-16. [PLAN.md](../PLAN.md) defines seven unfinished work areas.
This worktree is `/private/tmp/fwp-tcp-owners`, branch `tcp-owner-preparation`,
based on PR #153's `bb6d2ea3`. It is preparation, not a second open delivery PR.

## Current delivery and next action

[PR #153](https://github.com/e6qu/fun-with-pipes/pull/153) is the only open delivery.
The main workspace `/Users/zardoz/projects/fun-with-pipes` tracks its branch
`owned-values-delivery`. Head `bb6d2ea3bacc5b9b5017e23dcca64943d893c44f`
has production `38915283341` running; benchmarks and documentation `38915283274`
pass. Its decoded-value, numerical-worker and UDP changes are already combined.

Production `38915283341` failed on Windows ARM64 because the new byte-decoder
tests require OpenSSL but ran before dependency installation. The workflow repair
moves both decoder targets into the existing TLS step and preserves coverage.
The earlier ordinary-resource step now finishes independent targets after a
failure. Other current-head production jobs may still reveal additional fixes.

Next: to avoid another full acceptance cycle, combine this preparation into the same
PR #153 after focused tests pass. Do not open a second delivery PR or wait to
merge the known failing head. Update its plain-language description to cover
TCP/TLS as well as decoded values, numerical workers and UDP. Publish the combined
head once, require fresh nine-job production and documentation acceptance, then
squash-merge with `Reduce temporary memory and clean up network resources` and
an empty body. Verify merge tree, parent and message; cancel duplicate postmerge
CI. `/private/tmp/fwp-merge-153.py` still names the old head/runs and MUST be
updated before use. Standing authorization covers these steps.

PR #152 is accepted as `1fa0fec6`, with all nine production jobs and docs passing,
matching tested files, a single-line commit message and no trailers. Duplicate
run `38914679717` is canceled. [Delivery history](roadmap-history.md) has the record.

## TCP and TLS preparation

The first repair closes an operating-system socket if allocating its returned
TCP handle fails. It uses the existing pending-connection cleanup mechanism.
[Constructor evidence](measurements/tcp-construction-2026-10-16.json) records
`985fc772b7f090e91d17ad26267e67ddf3c35b24`: six native jobs `38916070418`
and both actual WASI regression jobs `38916075039` pass. Real sockets, 32 failed
listen allocations, 32 failed accept allocations, successful transfers and
omitted-cleanup controls are retained. This earlier revision does not enable ARC
for TCP/TLS.

The broader runtime at `eaa42582` adds logical owners for TCP connections and
listeners, including TLS, and preserves function/task capture lifetimes. Copies
share the same handle; explicit close affects them all. The last owner also closes
it. Optional accepted connections, read bytes and certificate-subject text clean
up partially built results on failure.

Common socket headers retain the previous UDP/plain-TCP size. Only stream handles
in TLS-enabled programs add a session pointer, within the same allocation. There
is no separate counter allocation. This is not a claim of zero runtime overhead.
Compiler contracts and source inspection do not establish tested support.

Preparation `1487cd96` repairs the failure tests and adds real TCP library
unload plus TLS executable inspection. Native replacement `38920866331` passes
on ARM macOS and both Linux hosts; other hosts are pending. This includes all five TCP tests, UDP,
task cleanup, mutual TLS, POSIX TLS controls and actual socket-library unload.
Earlier `38919269219` found obsolete test hooks and a Linux ARM64 negative control
that assumed a conservative collector would discard a stale register. The repair
checks actual premature session release and optional-certificate construction
failure. The runtime was unchanged by these test fixes.

Both actual WASI regression jobs `38918290525` pass for runtime `eaa42582`.
ARM64 `nm`/`otool` inspection of the passing TLS executable confirms no tracing
functions, a 24-byte stream header, its 64-bit count at offset 8 and TLS pointer
at offset 16. The non-TLS TCP probe requests 16 bytes. OpenSSL remains a dynamic
library dependency. These are representation observations, not throughput claims.
Artifacts are in `/private/tmp/fwp-tcp-148-evidence/macos-arm64` and the prior TCP
probe is in `/private/tmp/fwp-tcp-59-evidence/macos-arm64`.

Refinement `33f8de56` removes an unnecessary finalizer-table search when an
ARC-only executable releases a socket. Such sockets never register there;
tracing and unloadable libraries retain the lookup. The native probe traps if
an ARC executable performs it. File cleanup already uses the correct guard.
Native `38921794654` and WASI `38921802829` began for this revision.

Windows then exposed two existing native/interpreter differences. Native TCP
and HTTP/2 listeners enabled Winsock `SO_REUSEADDR`, which can bind over a live
listener; the interpreter does not. The repair keeps Unix reuse and Windows'
ordinary bind behavior. Native TLS read the CRT errno slot, losing Windows socket
resets; it now clears and captures Winsock's error slot as the interpreter does.
Clean TLS shutdown is distinguished from a stale socket error. A deterministic
native test covers handshake/read/write resets, clean shutdown and readiness
waits; ignoring socket errors must make its negative control fail. Runtime repair `a0447849` is under native `38922677306` and WASI `38922688282`.
ARM macOS and ARM Linux pass. Windows AMD64 passes the TCP, UDP and actual socket
library tests; its two TLS checks exposed test harness issues: `nm` needs the
actual `.exe` filename, and prepended OpenSSL headers need the Windows API contract
selected first. These two test-only repairs get a Windows-only run; keep the
unchanged-runtime Linux/macOS and WASI checks. Final production still requires
all nine jobs on one combined exact head. Do not normalize an unexpected successful read away.

The native suite compares raw and optimized interpretation with O1/O2 tracing
stress and ARC, checks cleanup without collections, and inspects ARC symbols.
It covers real TCP traffic, timeout, simultaneous accepts closed through an alias,
301 owners and optional-result allocation failures. Mutual TLS adds ARC execution
on every native host. Existing POSIX teardown/transfer probes run on Linux/macOS;
they are not Windows teardown evidence. Independent TLS steps run even if an
earlier test fails, while the overall job remains failed.

## Local checks and limits

Use `python3 scripts/local-guard.py` serially with the existing CPU, memory, disk
and deadline limits. Full builds, native tests and benchmarks belong on GitHub.
Earlier local compiler and standalone C builds were refused by automatic review;
do not retry or bypass that restriction.

The accepted compiler `/private/tmp/fwp-148-compiler/fwp-macos-arm64/fwp` gives the
raw TCP fixture's expected output in 0.25s. Guarded Rust formatting passes in
1.10s. The lightweight standalone `tests/stdlib_doc.rs` generator builds in 0.61s,
regenerates in 0.50s and rechecks without blessing in 0.01s. Primitive inventory
passes in 1.32s: 335 contracted declarations, 19 remaining review symbols. These
are implementation counts, not support evidence. The documentation audit passes
in 2.46s. Constructor evidence retention passes in 0.13s. The new TCP library fixture
prints `True` under the accepted interpreter (guarded, 0.26s), and the updated
Rust formatting check passes in 1.12s. Binary inspection passes under the guard
in 0.25s/0.26s; the latest formatting check passes in 1.20s.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Deployment and primitive ownership; remove tracing GC |
| 2 | In progress | Remove remaining functional abstraction costs |
| 3 | In progress | Diagnose and reduce equivalent-work C/Rust gaps |
| 4 | In progress | Differentiation speed, memory scaling and precision |
| 5 | In progress | CPU kernels and the runtime OpenCL compilation gap |
| 6 | In progress | Repeatable comparisons across representative workloads |
| 7 | In progress | Larger numerical, collection-heavy and long-running programs |

## Remaining work

Finish and verify the TCP/TLS preparation, including the new library teardown
and TLS binary checks. Remaining primitive reviews are concentrated in
network-service callbacks and HTTP/2 streams, process exit and GPU execution.
Callbacks retained by external code, mutable cycles and host re-entry still need
explicit lifetime rules. Conservative handling of captured functions can prevent
optimizations. General collector removal is unfinished.

The existing OpenCL runtime compilation conflicts with the no-JIT objective.
Do not expand it or introduce a JIT. A new backend and distributed execution
remain outside scope. Continue the memory and performance work in the plan after
the current deliveries; completing a batch does not complete the roadmap.
