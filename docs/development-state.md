# Session handoff

Updated 2026-10-16. This branch is independent preparation for the next service
context batch. The only delivery PR remains #153 at `ac3060d1`; its authoritative
handoff is in `/Users/zardoz/projects/fun-with-pipes/docs/development-state.md`.
Do not open another PR or repeat that delivery. Both native Mac runner checks
`38938194232` and documentation `38938199569` pass. PR #153 is ready and requires
all nine production jobs in `38941991952` on exact head `ac3060d1`. Draft skips
are not acceptance. Merge only the tested head with an explicit one-line subject,
empty body and no trailers.

## Preparation and acceptance

Workspace: `/private/tmp/fwp-context-owners`, branch `service-context-preparation`,
based on #153 preparation `ac3060d1`. The runtime change below is implemented but not yet verified natively. The first step measures repeated plain, gzip, deadline, outgoing-header
and response-capture scopes at 1, 32 and 128 calls. Every call increments state;
raw/optimized interpretation and native output must agree on the final count.
Instrumentation reports managed allocation requests, requested bytes and final
charged bytes with collection disabled. Raw TLS/capture buffers, allocator pages
and total process memory remain outside those counters. This is an fwp baseline,
not a speed or C/Rust comparison.

Baseline source `9b137078` passes Linux run `38941168779`; `3846e2d5` only improves
documentation. Superseded `38939097999` was canceled. The retained
[measurement](measurements/service-context-baseline-2026-10-16.json) records all
15 programs, native ELF hashes and per-call differences versus plain fwp state
updates. Between 32 and 128 calls, gzip/deadline add one 64-byte managed request
per call, metadata adds five requests/128 requested bytes and capture adds
four/120. These are memory counts, not timings or C/Rust comparisons; raw
allocations are excluded. Artifact inspection passed under the guard (6.85s).
Detached-child settings pass at O1/O2 with stress/reuse verification, including
parent return, typed error, trap and cancellation. Omitting inheritance fails.

Five service scope constructors now keep their settings on the stack. Child
tasks copy settings into a typed field in their existing task allocation, while
TLS/capture resources retain their separate owners. Completion clears the copy
so a completed task does not retain stale context pointers. Programs without
service support omit the field. No checked ARC admission changes are made.

Initial `38942724799` stopped at a test Clippy lint, now fixed. Replacement
`38943086313` at `ad77934c` passes Linux ARM64; other hosts remain active. That
revision tests stack settings and inline task copies only.

The next combined follow-up also borrows TLS/capture owners in synchronous
scopes and packs outgoing header pointers/text into one owned allocation. Child
tasks retain that block only when they actually inherit it. Empty or ignored
header lists borrow the previous settings. Size arithmetic is checked before
allocation. Tests cover allocation failure, four size-overflow cases, child
return/error/trap/cancellation, owner overflow and atomic acquisition, and
separate controls for lost inheritance, a borrowed parent stack, omitted free,
omitted unwind cleanup and omitted child retain. Existing TLS/capture controls
now require a single owner inside ordinary and nested scopes.

Next: complete `context-storage` run `38944540937` at published `7469df49` on
Linux, including actual interpreter/native gRPC calls. Then require `context-owners`
on all six hosts and real WASI regressions. The new changes are unverified until
those checks pass. Allocation assertions require no per-call overhead versus
plain updates for gzip/deadline/empty headers; nonempty copied headers require
one allocation per call and no retained charge after the scope ends. Retain
`storage.tsv`, `layout.tsv`, compiler/CPU metadata and binaries. Measure the
larger task header and inspect instructions; do not claim a speedup from counts.
Capture result values and service streams/connections remain unfinished, and
checked ARC admission is unchanged.
After #153 is accepted, rebase only this branch's delta after `ac3060d1` onto its
accepted squash; keep one active delivery PR.

Local checks use `python3 scripts/local-guard.py` with unchanged limits. The
accepted compiler interpreted all five 32-call examples, both raw and optimized,
and printed `32` in every case (1.80s); this does not validate the new native
instrumentation. A named helper
needed an explicit `I64 -> () ! {Network, State[I64]}` signature because generic
signatures remain explicit. Formatting passes (1.12s); partition/concurrent-runner checks pass (1.03s),
and the documentation audit passes (2.63s). The service guide now introduces
request contexts, callback functions, `const`, deadlines and response metadata
before using their examples. Native work belongs on CI.
The new test target is assigned to the existing macOS GC job, giving this
preparation 231 integration targets; #153 still has 230.

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
