# Session handoff

Updated 2026-10-16. This branch prepares the next combined service-memory PR.
The only delivery PR is #153, repaired at `a0af12d9`; its authoritative handoff
is `/Users/zardoz/projects/fun-with-pipes/docs/development-state.md`.
It requires all nine production jobs `38946985320` and documentation
`38946985234` on that exact head. Earlier production found a stale decoder
instrumentation hook; the repair changes the test, not runtime behavior.
Do not merge until every final-head gate passes. Use one squash subject, at most
80 characters, an empty body, no trailers and no attribution.

## Current action

Workspace: `/private/tmp/fwp-context-owners`, branch `service-context-preparation`.
Base: `ac3060d1`. Runtime callback source: `24caa70b`; combined repairs and explicit-exit
follow-up: `6b642a82`; decoding cleanup and CI scheduling: `4656043f`. Do not open another PR. After #153 acceptance, rebase
only this branch's delta after `ac3060d1` onto its accepted squash.

Next: require all six native jobs in `38951742782` at `4656043f`, combining the
context, callback, exit and message-decoding checks. Queued `38949852186` was
superseded before execution. Focused actual WASI ARC run `38949856424` at
`6b642a82` checks explicit exit. Broader WASI/browser run `38947985548` passes on
both Linux architectures at callback source `24caa70b`, before exit tests.
Retain final allocation,
layout, compiler/CPU and binary evidence before claiming verified support.
Do not broaden ARC admission beyond the tested ownership contracts.

## Implemented, awaiting combined native verification

Five service scope constructors keep settings on the stack. A child task copies
settings into its existing task allocation; completion clears that copy. Programs
without service support omit the field. Synchronous scopes borrow TLS/capture
owners. Only independently live child tasks need extra owners.

Outgoing header pointers and text share one owned allocation. Child tasks retain
that allocation when inheriting it. Empty or ignored header lists borrow the
previous settings. Checked size arithmetic precedes allocation. Cleanup covers
return, typed error, trap, cancellation, partial child preparation and counter
overflow. Tests deliberately omit inheritance, copying, release, unwind cleanup
and child retain; every broken variant must fail.

The five scopes also borrow typed callbacks and own their results. Response
capture protects the callback result before copying headers directly into an
owned list, preserving order and duplicates without a temporary pointer array.
Existing capture/task controls use actual compiler-generated result types.
The ownership inventory passes on Linux ARM64: five scope contracts are
promoted, giving 346 contract declarations and eight remaining reviews. The
frozen inventory baseline is unchanged. Runtime verification is still pending.

`service_scope_ownership` compares raw/optimized interpretation with native
O1/O2 tracing/ARC execution, including caller aliases and returned functions. A later fixture extension
adds actual typed callback failures whose string payloads must survive scope
cleanup; its final-head production check is still required.
It checks final charged storage with collection off, deliberate missing-borrow
and partial-cleanup controls, and 13/14 captured-result allocation failure points.
ARC binaries must exclude tracing functions. Scope support does not establish
collector-free remote calls, service entry points or retained request contexts.

The scope/context tests have permanent Windows coverage and are assigned to
the existing Mac GC shard. The exit follow-up adds a third target; #153 has 230.
Windows fixture repairs declare the required Windows 10 API target before system
headers and use `_putenv_s` explicitly instead of POSIX-only environment calls.
Native Windows verification of those repairs remains pending. Linux ARM64
passes the repeated-allocation assertions but exposed two harness defects:
negative controls returned through library shutdown, whose child cancellation
replaced the original failure code; and the callback-result ledger included
lazy scheduler startup. Prepared repairs use `_Exit` only for failed controls
and initialize the scheduler before the result-lifetime ledger. Successful
controls still execute full shutdown. The allocation report still includes
startup separately; this does not hide the larger task cost. Windows ARM64
also exposed host path separators in the inventory keys (`lib\\...` versus
`lib/...` in the frozen baseline). The scanner and source-hash keys now emit
repository paths with forward slashes; the contract assertions are unchanged.

## Explicit exit follow-up

Published in `6b642a82`, not yet native-verified: `exit` has the nonreturning
ownership contract. It borrows its I32 status, produces no result and needs no
collector. Runtime exit behavior is unchanged: output before exit is preserved,
later steps do not run, and the process status uses the low eight bits. It does
not promise ordinary scope unwinding or individually freed live values.
The proposed inventory becomes 347 contracts/seven remaining reviews.

`process_exit_ownership` tests raw/optimized interpretation, O1/O2 native tracing
and ARC, actual ARC WASI execution when the required toolchain is configured,
and native ARC binaries without tracing symbols. It covers zero, 1, 255, 256,
-1 and both I32 endpoints, using one compiled program per mode/optimization.
All seven cases pass in both accepted-interpreter modes (2.42s). Formatting
(1.34s) and the documentation audit (2.75s) pass. The tests have permanent
Windows/Mac coverage, making 233 preparation targets. Do not
claim actual WASI support from a native-only job that does not run that check.

## Retained evidence and limits

The [baseline](measurements/service-context-baseline-2026-10-16.json), source
`9b137078`, passed Linux run `38941168779`. It compares 1/32/128 fwp scope calls
with plain fwp state updates. Gzip/deadline added one 64-byte managed request per
call; outgoing headers added five requests/128 requested bytes and capture four/120.
Collection was disabled. These are memory measurements, not speed or C/Rust parity.

The [intermediate stack-copy report](measurements/service-context-stack-2026-10-16.json)
records source `ad77934c`, run `38943086313`. Ordinary allocation/output tests
passed on all six native hosts: gzip/deadline add no per-call allocation relative
to plain updates. All four Unix jobs also passed the detached-child tests.
Windows jobs failed separate C fixtures before the API-target repair; do not
count them as complete native acceptance. Header/capture costs in that report
predate the packed-header and callback-result changes.

On Linux AMD64 the service task grew from 1,512 to 1,576 bytes in that intermediate
revision. The latest context adds another owner pointer and needs fresh layout
measurements. Existing plain programs exclude service fields and are not a
substitute for the old service-task baseline. ARM64 and AMD64 instructions show
64-byte copies into stack storage; the ARM wrapper reserves 128 stack bytes,
with a separate 352-byte handler frame. These are instrumented O2 binaries,
not a total stack bound or a speed claim. Actual ELF, Mach-O and PE formats and
source/binary hashes are retained for all six hosts.

The probes measure managed requests, requested bytes and final charged storage
from constant initialization through main cleanup. They exclude raw TLS/capture
buffers, allocator pages/metadata and total process memory. Final-header tests
require one allocation per nonempty header scope, no retained charge growth,
and no per-call overhead for gzip/deadline/empty/ignored headers versus plain.

## Message-decoding cleanup follow-up

Source review found an unprotected temporary protocol buffer in `g_decode`.
It now registers cleanup before conversion and releases through one normal exit
or trap unwinding. The added test uses actual protocol decoding for ordinary
results, tagged success/error results, malformed wire data, invalid text and a
missing tag. Injected result-allocation traps must free the temporary buffer;
deliberately omitted cleanup must fail. O1/O2, GC stress/verification and reuse
checks run on CI, with permanent Windows coverage in the existing canonical
serialization target. This does not establish ownership of whole service streams.
Formatting passes (1.20s); native results are pending.

## CI scheduling follow-up

The shared `scripts/run-native-tests.py` now has explicit `--all` selection for
Linux and retains both existing Mac shards. Linux still runs every Cargo target
and GC stress test, with two executable workers and one harness thread each.
Every produced executable must match the requested target set; missing or
duplicate artifacts fail before execution. Failures do not skip remaining
executables. Per-executable logs are uploaded. Seven Python coverage and failure
checks pass under the local guard (1.07s), including the real 233-target Cargo
metadata. The documentation audit passes (2.90s); an earlier invocation used a
nonexistent script name and was corrected to `scripts/check-roadmap.py`.
Native CI must verify the new scheduling; no speedup is claimed.

## Local checks and next work

Use `python3 scripts/local-guard.py` with unchanged limits; native compilation
and full tests belong on CI. Earlier automatic review refused local compiler
and standalone C builds; do not bypass or repeat those requests.

The accepted interpreter also runs the typed-failure example (0.25s), producing
the four expected error strings. The accepted interpreter runs all seven 32-call examples raw and optimized
(2.28s) and the new alias/returned-function example (0.26s). Formatting (1.30s),
six Mac coverage/runner tests (1.10s), and documentation audit (2.67s) pass.
Artifact download (16.32s), evidence retention (8.18s), and existing binary
inspection (0.13s each) passed under the guard. No local native build was used.

The ownership guide now records concrete next checks for remote stream caches,
shared connections, early stop, detached users and cycles. These are requirements,
not an implemented ownership policy. Service streams/connections, remote results and GPU ownership remain; the exit
follow-up still needs its checks. Preserve the existing effect rule in `docs/design.md`: only the final
arrow of a binding may have effects, so partial application does not perform
work. The function-and-string tuple in the ownership fixture tests returned
functions and shared data together; no parser or effect-rule change is proposed.
The service guide introduces callbacks, `const`, settings, deadlines, headers,
streaming and compression before its examples. Preserve those explanations.

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
