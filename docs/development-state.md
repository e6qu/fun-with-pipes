# Session handoff

Updated 2026-10-16. [PLAN.md](../PLAN.md) defines seven unfinished work areas.
[PR #153](https://github.com/e6qu/fun-with-pipes/pull/153) is the only delivery PR.
It combines decoded-value cleanup, numerical worker storage and UDP/TCP/TLS
lifetimes. The main workspace is `/Users/zardoz/projects/fun-with-pipes`, branch
`owned-values-delivery`. `/private/tmp/fwp-tcp-owners` holds the combined
preparation, branch `tcp-owner-preparation`, descended from published `bb6d2ea3`.
Do not apply either batch again or open a competing delivery PR.

## Current action and acceptance

PR #153 remains at `78e9a372abe0daad90318b9ae14751cf6587c31f`. Production
`38925341899` failed its Windows ARM TLS stream comparison: the native socket
formatter used localized Windows reset wording while the interpreter used its
established common wording. Both implementations still rejected the connection;
there was no successful read or weakened certificate check. Benchmarks and both
ARM macOS jobs passed; other jobs are still running and may reveal further work.
Documentation `38925341680` passed. Do not merge this head.

This preparation aligns five common Windows socket messages with the interpreter
(permission, address already in use, aborted/reset/refused connections). The
native socket probe now compares those actual OS codes against the interpreter's
formatter; the deterministic TLS probe requires the exact reset diagnostic.
The focused TCP workflow also runs the real TLS stream comparison, in addition
to mutual TLS and existing socket lifetime/error controls.

Repair `abe3be17` is published; focused Windows run `38931783848` is queued.
The following workflow edit saves and uploads each failed TLS/autodiff/golden
step log immediately, while later checks continue, preserving the failing exit
status. This removes the need to wait for the entire job before reading that log.
Next: fix the focused run and inspect the remaining old production results for
additional failures, then publish the verified repair to
PR #153 and require all nine production jobs plus documentation on the new head.
Do not restart full CI before incorporating any other discovered failures.
`/private/tmp/fwp-merge-153.py` still targets the failed old head and must be
updated to the final head/run IDs before use. Squash subject remains
`Reduce temporary memory and clean up network resources`, with an empty body.

PR #152 is accepted as `1fa0fec690b7747a9ffcf2d72903d16544889258`; its nine
production jobs and documentation passed, merge tree/message were verified and
duplicate CI was canceled. Standing publication/fix/merge authorization persists.

## Combined changes and focused evidence

- [Decoded values and numerical workers](measurements/owned-values-and-kernels-2026-10-16.json):
  failure/cancellation cleanup and one fewer full result array. In the recorded
  8,193-number, one-worker calculation, peak temporary storage falls from 69,648
  to 4,104 bytes; the output still uses 65,552 bytes. This compares earlier fwp
  memory use, not speed or parity with C/Rust.
- [DNS](measurements/dns-ownership-2026-10-16.json): ordered distinct results
  without the old 64-address cutoff; 81 addresses and 162 allocation failures.
- [UDP](measurements/udp-ownership-2026-10-16.json): socket owners, captures,
  cancellation, partial receives, Linux wait-list disposal and real library unload.
- [Original TCP constructor repair](measurements/tcp-construction-2026-10-16.json):
  six native and both actual WASI jobs pass for the recorded earlier revision.
- [TCP/TLS ownership](measurements/tcp-tls-ownership-2026-10-16.json): all four
  Linux/macOS jobs `38922677306` pass at `a0447849f2dbce39e9e558001ac1fd75a842f028`;
  both Windows jobs `38923766437` pass after the test-only repair `7c3c375b`.
  Runtime/compiler/library files are identical between these heads. Both actual
  WASI regressions `38922688282` pass on `a0447849`. WASI evidence covers shared
  runtime behavior, not networking support.
- [CI compiler settings](measurements/ci-compiler-profiles-2026-10-16.json):
  measured selected test/build costs, with development assertions and overflow
  checks retained. These do not predict full-suite duration.

TCP/TLS copies share a handle. Explicit close affects every copy; releasing the
last owner also closes it. Original function/task scopes keep captured resources
alive. Tests compare raw and optimized interpretation with O1/O2 tracing stress
and ARC, use real traffic, 301 owners, timeout/cancellation and allocation failures.
Actual library unload closes three retained TCP descriptors while preserving a
host socket. POSIX TLS teardown/transfer probes run on Linux/macOS; Windows has
separate actual socket-library unload, mutual TLS and socket-error checks.

Native Windows listeners now use the interpreter's ordinary bind policy instead
of enabling Winsock port reuse over a live listener. TLS now captures Winsock
socket errors instead of losing them through the CRT errno slot. Deterministic
read/write/handshake probes reject socket resets misreported as successful reads,
while preserving clean shutdown and readiness waits. Deliberately omitting
cleanup or error capture must fail the controls.

Exact ARM64 executable inspection confirms an aligned 64-bit count at byte offset
8, 16-byte plain socket headers and 24-byte TLS-stream headers with a pointer at
offset 16. There is no separate counter allocation. ARC executable drops omit the
unused finalizer-table scan; tracing and unloadable libraries retain it. Collector
functions are absent from the inspected TCP/TLS ARC binaries. OpenSSL remains a
dynamic dependency. These are representation/cleanup facts, not timing claims or
zero total process memory. Artifacts are under `/private/tmp/fwp-tcp-final-evidence`.

## Local validation and limits

Use `python3 scripts/local-guard.py` serially with its fixed CPU, memory, disk and
deadline limits. Full builds, native tests and benchmarks belong on GitHub.
Earlier local compiler and standalone C builds were refused by automatic review;
do not retry or bypass that restriction.

Guarded checks pass: Rust formatting 1.18s; accepted-interpreter TCP example
0.25s and library example 0.26s; example formatting 0.01s; macOS partition tests
0.13s; primitive inventory 0.95s (335 contracted declarations, 19 remaining review
symbols); final evidence retention 0.59s; ARM64 inspection 0.25s. The standalone
stdlib documentation generator was regenerated and rechecked. The last documentation
audit passed in 2.70s. Inventory counts are implementation facts, not support proof.
All 229 integration targets remain assigned; the eight targets added in this PR
use the existing macOS GC job, preserving prior assignments.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Ownership of services and external contexts; remove tracing |
| 2 | In progress | Remove remaining functional allocation and counting costs |
| 3 | In progress | Diagnose and reduce equivalent-work C/Rust gaps |
| 4 | In progress | Differentiation precision, speed and memory scaling |
| 5 | In progress | CPU kernels and the runtime OpenCL compilation gap |
| 6 | In progress | Repeatable performance comparisons |
| 7 | In progress | Larger representative applications |

## Following work

After #153 acceptance, continue copied service-result ownership and then retained
service contexts/callbacks. Independent, uncommitted preparation is in
`/private/tmp/fwp-service-values`, branch `service-value-preparation`, based on
`a0447849`. Its handoff records the draft `grpc.metadata`/`grpc.peer-subject`
changes and unrun native tests. Do not integrate it as verified support. Rebase
only its delta after `a0447849` onto the accepted squash when preparing the next
substantial PR.

Current primitive reviews also include HTTP/2 streams, process exit and GPU
execution. Retained external callbacks, mutable cycles and host re-entry still
need explicit lifetime rules. Conservative captured-function handling can inhibit
optimizations. The OpenCL runtime compilation gap conflicts with the no-JIT
objective; do not expand it. New backends and distributed execution are excluded.
