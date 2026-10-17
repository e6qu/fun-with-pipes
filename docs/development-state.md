# Session handoff

Updated 2026-10-17 UTC. All seven work areas in [PLAN.md](../PLAN.md) remain open.
This is preparation state; the root worktree owns the active delivery handoff.

## Delivery order

Root `/Users/zardoz/projects/fun-with-pipes` has input cleanup PR #159 at
`91398527`, production `39016595534` and docs `39016595480`.
Keep one active delivery PR. Its exact-head watcher handles authorized merge
only after all nine production jobs and documentation pass.

This worktree `/private/tmp/fwp-server-call-owners`, branch
`own-server-call-storage`, starts at input preparation `9a4e2ace`. Transfer only
its later delta, preserving root's accepted #158 allocation-test repairs and
current history. There is no server PR yet.

## Verified server storage candidate

Source `e6455c0ddcf692669af02d1eb67c7600de096977`, tag
`evidence/server-call-storage-windows-20261017`, passes all six native hosts in
`39018276989`. The [comparison](measurements/server-call-storage-2026-10-17.json)
uses baseline `06432959`, run `39014733093`, with identical language workloads
and measurement boundaries. All 18 raw tables and actual Linux ARM64/AMD64
instruction reviews are retained. Full production acceptance remains required.

Job records contain the service context and reuse its existing owner count.
Serving-task completion clears borrowed pointers; detached senders retain the
job independently. Unscoped internal task records have unique scheduler owners;
scopes use the existing shared-owner policy. Method argument slots use the stack.
Decoded values, results, connections/requests and channel contexts remain outside
this storage change. Do not claim server checked ARC or complete GC removal.

All 36 cases per host remove one allocation and 24 requested bytes per call,
preserve reference-count increments and lower final managed bytes. At 256 calls
Linux retains 119,648 / 1,885,024 / 1,151,840 / 369,504 bytes for greetings /
returned streams / sent streams / channel output. Other hosts retain 544 fewer
bytes in each mode. Storage still grows with calls. The measured argument slots
add 48 bytes to the call helper's stack frame on both reviewed architectures.
The [benchmark guide](benchmarks.md#freeing-finished-server-tasks-and-keeping-argument-slots-on-the-stack)
explains the comparison and exclusions. No timing or C/Rust claim.

## Fixes and remaining verification

The first all-host run `39017837346` found a C fixture expecting LF on Windows,
where `puts` produces CRLF. Both Windows hosts pass the repaired run. Earlier
Linux probes found fixture instrumentation and reuse-poison observation errors;
final focused checks verify their repairs. No runtime failure remains known in
the storage candidate.

Typed-value probe `39018465355` found that an input-owner negative control matched
both the new internal task policy and the sender policy. The control now anchors
to the sender completion callback. This test-only repair is later than the
storage evidence revision; the typed-value probe checks it before integration.

Typed arguments/results and response iterators are prepared separately in
`/private/tmp/fwp-server-value-owners`, branch `own-server-values`, based on
`c298bdcd`. Its `b7db1159` runs Linux probe `39019491138` with explicit partial
decode, alias, error, continuation and cancellation cleanup controls. It is not
verified yet. Prefer one coherent server delivery after those checks and
measurements pass; preserve the Windows fix and sender control repair once.

Next: fix typed-value probe failures, compare its measurements against this
storage candidate, and require all-six evidence before the next delivery's full
production run. Server request/connection and channel callback lifetimes remain
open afterward. Keep all seven roadmap areas open; JIT is excluded.

## Local checks and artifacts

Use the root `scripts/local-guard.py` with fixed limits. Full compilation, tests
and measurements run on GitHub. No downloaded executable has run locally.
Documentation audit passed in 3.36s and formatting in 1.30s. Final artifact collection passed in 21.41s; static AMD64 inspection in 0.17s,
ARM64 in 0.15s and instruction comparison/review retention in 0.21s. Validated
report summary passed in 0.15s. Artifacts:
`/private/tmp/fwp-server-memory-evidence/39018276989`.

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
