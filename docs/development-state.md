# Session handoff

Updated 2026-10-16. [PLAN.md](../PLAN.md) defines seven unfinished work areas.
[PR #154](https://github.com/e6qu/fun-with-pipes/pull/154) is the current draft
service-memory, compiler and iteration delivery. PR #153 is accepted.

## Current action

Workspace: `/Users/zardoz/projects/fun-with-pipes`, branch `service-iteration-delivery`.
Base: accepted #153, `9bf203d7`. The original preparation is preserved remotely
by `evidence/service-context-before-delivery-20261016` at `f366dd2b`; reports
continue to name their measured sources. Do not apply the preparation again.

Next: publish this final report/documentation update, mark #154 ready, and
verify all nine production jobs, documentation and both new Windows dependency
jobs on that final head. Then squash-merge with subject
`Reduce service memory and remove discarded iteration results` and empty body.
The helper `/private/tmp/fwp-merge-154.py` verifies exact heads, all required
results, merge tree/parent/message, and cancels only duplicate `ci.yml` runs. Six-host native run `38973106656` passes
at `20f0f5f091edf7c9b296dbf548309cf68a779e29`. Actual WebAssembly/browser and
physical-storage run `38973110352` passes on both Linux architectures at that
same source. Windows ARM64 initially exhausted the existing 25-minute job limit
after cold TLS setup; rerunning that job with its saved dependency cache passed.
The timeout was not increased. Draft-skipped checks are not acceptance.

The [current report](measurements/service-context-iteration-2026-10-16.json)
retains six-host service/iteration counts, layouts, failure controls, compiler
versions, binary hashes and repeated Linux timings. At one million elements,
old/current medians are 56.93/27.30 ms on AMD64 and 66.70/32.80 ms on ARM64.
Peak process memory is 79,216/37,648 KiB and 77,496/35,632 KiB respectively.
Each saves one allocation and 32 requested bytes per element. These are fwp-to-fwp
comparisons including startup, input construction, printing and cleanup; they do
not establish C/Rust parity. Input storage and state bookkeeping remain.

Actual AMD64 and ARM64 binaries contain checked increments without per-element
callback dispatch in the counting loop. State-owner lookup and conditional
cleanup remain. Dynamic call counts stay at two for both 32 and 128 elements.
Guarded binary inspection passed in 0.15s. Artifacts are under
`/private/tmp/fwp-context-iteration-final/38973106656`.

The compiler binds aggregate captures once outside loops and specializes known
synchronous state/service callbacks. Earlier arguments and resource lifetimes
constrain movement. The [earlier baseline](measurements/service-context-iteration-baseline-2026-10-16.json)
retains the initial iteration slowdown that prompted this repair; it is not the
current result. The service allocation limits remain unchanged.

The runtime obtains complete Linux/macOS thread-stack bounds through pthread
APIs, matching Windows. A debugger watchpoint showed the old scan missed a live
callback at `x29+24`, which GC erased during another allocation. All six hosts
pass the triggering case with stress/reuse checks. Actual ARM64 instructions
confirm the bound calculation and previously missed slot. ARC and WebAssembly do
not gain stack scanning. Temporary debugger jobs have been removed.

PR #153 merged as `9bf203d767a928f63f343a3644abc6df019c4179` after all nine
production jobs (`38958379514`) and documentation (`38955543617`) passed at
`f6dc9940`. Its tree matches that head, its parent is accepted #152, and its
message is exactly `Reduce temporary memory and clean up network resources`
with no body/trailers. Duplicate production run `38971260589` was canceled.
[Delivery history](roadmap-history.md) retains this acceptance.

The combined branch retains accepted byte-decoder fixes and both focused suites.
Keep PR #154's plain description current using `/private/tmp/fwp-context-pr-body.md`. Require all nine production jobs and documentation on its final head.
The new dependency-cache workflow's two Windows jobs must also pass when
introduced. Leave that workflow running after merge so later branches can reuse
main's dependencies. Focused checks do not replace full acceptance.

Every commit/squash message is one line, at most 80 characters, with no body,
trailers or attribution. JIT is excluded. Preserve the effect rule: only the
last function arrow may have effects; partial application is pure.

## Verified service and compiler changes

Source `8684127de6efc46a4dd17c5d95ec9cced5c10e00` passes all six native hosts
in `38958562126`, including actual interpreted/native service calls. The
[forwarded-result report](measurements/service-context-forwarded-2026-10-16.json)
retains CPU/compiler versions, layouts, counts, binary formats and actual ARM64
and AMD64 instructions. The inventory has 347 contract declarations and seven
remaining primitive reviews; other ownership boundaries remain too.

Five service helpers keep settings on the stack. Children copy them into their
existing task records, retaining shared data for independent lifetimes.
Synchronous calls borrow callback functions and TLS/capture owners. Outgoing
header pointers and copied text occupy one allocation; empty or ignored header
lists borrow previous settings. Returned values and copied captured headers
have owners. Client/server decoding scratch and channel send buffers release
on failures and cancellation.

Tests cover aliases, returned functions, typed errors, parent return/trap/
cancellation, child cleanup, overflow and allocation failure. Deliberately missing
inheritance, copying, release and retention must fail. Capture controls exercise
13/14 allocation-failure positions and inspect ARC binaries for tracing functions.

A compiler forwarding function now keeps its callback's returned tuple instead
of unpacking and rebuilding it. An actual generated consumer checks tuple release
and caller aliases; a trapping callback checks unwind cleanup. Deliberately
reintroducing the extra allocation must fail. The fixture runs before the longer
measurements and uploads its generated C on failure.

For 1/32/128 calls, compared with plain fwp state updates at O2 and collection
disabled, all six hosts have these extra costs per call:

| Scope | Managed requests | Requested bytes | Retained charged bytes |
|---|---:|---:|---:|
| Compression, deadline, empty/ignored headers | 0 | 0 | 0 |
| One outgoing header | 1 | 40 | 0 |
| Response-header capture | 1 | 24 | 0 |

The [previous owned-scope report](measurements/service-context-owned-2026-10-16.json)
at `975806e9` had two capture allocations/48 requested bytes per call. The new
forwarding function returns directly in `x0` on ARM64 and `rax` on AMD64. Its
stack use falls from 192 to 144 bytes on ARM64 and from 184 to 120 bytes on AMD64
(excluding the incoming AMD64 return address). These are instrumented binary
observations, not timing measurements or whole-program stack bounds.

Settings occupy 72 bytes aligned to eight. Linux AMD64 service tasks grow from
the original 1,512 to 1,584 bytes. Programs without service support omit those
fields. Fixed scheduler startup remains in raw rows; per-call differences remove
that fixed cost. Raw TLS/capture buffers, allocator pages and process memory are
excluded. These are fwp-to-fwp memory comparisons, not C/Rust parity or speed.

Explicit process exit passes seven native status cases and actual WASI execution.
It preserves earlier output and uses the low eight status bits; it does not
promise ordinary cleanup before process termination. The six-host baseline also
verifies reflection buffers: reflection lets tools ask a server which methods it
provides. Request and response buffers release on success, encoding traps and
cancelled sends; separate missing-cleanup controls must fail. Whole-service
ownership is still unfinished.

## Iteration implementation and acceptance

`each = const | flip fold ()` walks the input without building discarded results.
Unit, written `()`, is the running value of the fold; `const` ignores it and
selects the supplied callback. No primitive or syntax was added.

`state_sequence_ownership` compares raw/optimized interpretation with O1/O2
tracing/ARC for shared inputs, ordered output, state updates and errors. Tracing
also checks collector stress and reuse verification; ARC checks ordinary freeing.
The allocation comparison runs the old mapping definition and the new fold at
32/128 elements. Both must print the same count. The fold must eliminate at least
one allocation per element and its dynamic call count must not grow with input.
Sources, binaries and `each-storage.tsv` accompany the focused evidence.

## CI work awaiting full acceptance

`scripts/run-native-tests.py` adds explicit `--all` selection for Linux. It keeps
every Cargo target and stress case, with two executable workers and one harness
thread each. Missing/duplicate executables fail before tests; failing targets do
not skip the remainder. Mac assignments stay unchanged. Seven Python checks
pass, including real Cargo metadata for 233 integration targets. Final production
CI must verify the Linux scheduling; no total-CI speedup is claimed.

The dependency-only Windows workflow populates the default branch's exact cache
after setup changes merge. Current main caches lack the new HTTP/2 dependency
key, and sibling branches cannot share their copies. It uses the pinned TLS
setup script and native architecture validation without an unnecessary compiler
installation. It runs on ready PRs changing those files, so both jobs must pass
when introduced. Keep it running when cancelling duplicate postmerge production
CI. Guarded workflow lint passes (1.44s); actual new-workflow jobs remain to be verified.

## Evidence and local checks

Passing tuple-forwarding artifacts are under
`/private/tmp/fwp-context-forwarded-evidence/38958562126/`. The report helper is
[`scripts/collect-service-measurements.py`](../scripts/collect-service-measurements.py): pass a successful six-host run, its
exact source, artifact directory, output path, `--each-comparison` and `--capture-requests 1` through
the local guard. It validates jobs, counters, layouts, inventory and capture
controls. New source needs new binary observations. Earlier owned-scope artifacts
are under `/private/tmp/fwp-context-final-evidence/38953639844/`.
The PR description is maintained with `/private/tmp/fwp-context-pr-body.md`.

Use `python3 scripts/local-guard.py COMMAND...` with unchanged limits. Full builds,
native compilation and full tests belong on CI. Earlier automatic review refused
local compiler/standalone C builds; do not bypass or repeat those requests.
Latest guarded checks: `python3 scripts/collect-service-measurements.py` with
run `38973106656`, exact head and the artifact/output paths above passed in
30.12s; `python3 scripts/check-roadmap.py` passed in 2.67s. Actual Linux binary
inspection passed in 0.15s. Earlier Rust formatting and workflow lint passed.
No local native build was used.

Independent preparation is `/private/tmp/fwp-stream-caches`, branch
`measure-remote-stream-storage`, based on `20f0f5f0`; no second PR. The controlled
receive/cache baseline passes Linux AMD64 in `38973859489` at `deae732b`. It uses
real queued protobuf messages, repeated reads, early stop, retained positions and
a deliberate missing-cache control. Four managed allocations/89 requested bytes
per received value become 112 charged bytes after rounding. Clearing C references
alone does not release that storage with collection disabled. This excludes
network latency and connection pooling. Its handoff and retained report preserve
the exact limits; baseline collection is complete.

Preparation now fixes an incoming stream description: client text was separately
allocated without release, and server text borrowed its handler's storage. A copy
inside the existing source allocation gives it the same lifetime as that source.
Focused tests are pending; remote streams still require collector ownership.
Next establish owners for cached results, continuations, sources and connections,
with alias, early-stop, failure and cancellation tests before admitting ARC.
Retained host callbacks and GPU ownership also remain. The
[ownership guide](ownership.md#what-remains-before-remote-calls-can-use-arc)
sets the remaining contracts. All seven project work areas remain open.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Service and external ownership; remove tracing |
| 2 | In progress | Remove discarded iteration results and remaining counts |
| 3 | In progress | Reduce equivalent-work C/Rust gaps |
| 4 | In progress | Differentiation precision, speed and memory scaling |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Repeated, comparable performance measurements |
| 7 | In progress | Larger representative applications |
