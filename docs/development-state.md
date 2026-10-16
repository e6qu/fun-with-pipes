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
Base: `ac3060d1`. Runtime/test source: `24caa70b`; later documentation/evidence
commits do not change it. Do not open another PR. After #153 acceptance, rebase
only this branch's delta after `ac3060d1` onto its accepted squash.

Next: finish and repair six-host native run `38947981439` and actual WASI/browser
run `38947985548`, both at `24caa70b`. Earlier queued native/WASI jobs
`38946737398`/`38945989400` were canceled as superseded. Retain final allocation,
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
Five ownership contracts are proposed for promotion; the frozen inventory
baseline is unchanged. CI must verify the precise new inventory.

`service_scope_ownership` compares raw/optimized interpretation with native
O1/O2 tracing/ARC execution, including caller aliases and returned functions.
It checks final charged storage with collection off, deliberate missing-borrow
and partial-cleanup controls, and 13/14 captured-result allocation failure points.
ARC binaries must exclude tracing functions. Scope support does not establish
collector-free remote calls, service entry points or retained request contexts.

Both new tests have permanent Windows coverage and are assigned to the existing
Mac GC shard: this preparation has 232 integration targets; #153 has 230.
Windows fixture repairs declare the required Windows 10 API target before system
headers and use `_putenv_s` explicitly instead of POSIX-only environment calls.
Native Windows verification of those repairs remains pending.

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

## Local checks and next work

Use `python3 scripts/local-guard.py` with unchanged limits; native compilation
and full tests belong on CI. Earlier automatic review refused local compiler
and standalone C builds; do not bypass or repeat those requests.

The accepted interpreter runs all seven 32-call examples raw and optimized
(2.28s) and the new alias/returned-function example (0.26s). Formatting (1.30s),
six Mac coverage/runner tests (1.10s), and documentation audit (2.67s) pass.
Artifact download (16.32s), evidence retention (8.18s), and existing binary
inspection (0.13s each) passed under the guard. No local native build was used.

Service streams/connections, remote results, process exit and GPU ownership
remain. A syntax issue noticed during preparation also needs a separate tested
repair: `String -> (() -> String) ! {Network}` cannot currently annotate effects
on the outer call. The current ownership fixture returns its function inside
an explicitly typed tuple; this does not resolve the parser issue.
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
