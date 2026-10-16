# Session handoff

Updated 2026-10-16. [PLAN.md](../PLAN.md) defines seven unfinished work areas.
This branch prepares the combined service-memory, compiler and iteration delivery.
PR #153 is accepted; keep only one new delivery PR open.

## Current action

Workspace: `/Users/zardoz/projects/fun-with-pipes`, branch `service-iteration-delivery`.
Base: accepted #153, `9bf203d7`. The original preparation is preserved remotely
by `evidence/service-context-before-delivery-20261016` at `f366dd2b`; reports
continue to name their measured sources. Do not apply the preparation again.

Next: inspect focused run `38971183112` at `f366dd2b`, then run the
native matrix and actual WebAssembly checks on the combined branch. The new
`each` saves memory but the first timing comparison is slower; do not accept it on allocation
counts alone. The optimizer now exposes calls through pure non-resource bindings
and specializes callbacks discovered inside state handlers. The regression counts
runtime dispatch as input grows and checks eager captures before input errors,
including empty inputs. The functional/allocation step now passes on Linux
AMD64, including zero extra runtime dispatch as input grows; repeated service checks and timing remain.
No local build was run.

All six native hosts pass at `dbb9dbec` in run `38969247542`. The
[retained baseline](measurements/service-context-iteration-baseline-2026-10-16.json)
records service memory, iteration allocation counts, repeated Linux timings,
binary hashes and generated trap programs. Retention passed under the local
guard (37.47s). Compared with the old map-based definition, each saves one
allocation and 32 requested bytes per element. At one million elements it takes
16.6% longer on Linux AMD64 and 11.8% longer on Linux ARM64. AMD64 median process
peak memory falls from 79,268 to 37,688 KiB. These are fwp-to-fwp comparisons,
including startup/input/cleanup; they do not establish C/Rust parity.

The runtime now obtains the complete Linux/macOS thread-stack bound through
pthread APIs, matching Windows. A debugger watchpoint proved the old scan bound
missed a live callback at `x29+24`; GC erased it while allocating another closure.
All six hosts now pass the triggering case, including stress and reuse checks.
ARC and WebAssembly do not gain stack scanning. The passing artifacts are under
`/private/tmp/fwp-context-each-evidence/38969247542`; actual ARM64 instructions
confirm the pthread queries, base-plus-size calculation and the previously missed callback slot. Guarded inspection passed
(0.13s); inspect the forthcoming direct loop as well. Temporary debugger jobs
and the ineffective compiler-frame-bound attempt have been removed.

Both actual WebAssembly jobs in `38967912068` pass at `16643edf`; the subsequent
stack-bound fix is native-only. The new optimizer change requires fresh actual
WebAssembly checks. Formatting passes (1.11s); full validation remains on CI.

PR #153 merged as `9bf203d767a928f63f343a3644abc6df019c4179` after all nine
production jobs (`38958379514`) and documentation (`38955543617`) passed at
`f6dc9940`. Its tree matches that head, its parent is accepted #152, and its
message is exactly `Reduce temporary memory and clean up network resources`
with no body/trailers. Duplicate production run `38971260589` was canceled.
[Delivery history](roadmap-history.md) retains this acceptance.

The combined branch retains accepted byte-decoder fixes and both focused suites.
Publish one PR, using `/private/tmp/fwp-context-pr-body.md` after updating its
results. Require all nine production jobs and documentation on its final head.
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
`/private/tmp/fwp-retain-context-final.py`: pass a successful six-host run, its
exact source, artifact directory, output path, `--each-comparison` and `--capture-requests 1` through
the local guard. It validates jobs, counters, layouts, inventory and capture
controls. New source needs new binary observations. Earlier owned-scope artifacts
are under `/private/tmp/fwp-context-final-evidence/38953639844/`.
The next PR description is `/private/tmp/fwp-context-pr-body.md`.

Use `python3 scripts/local-guard.py COMMAND...` with unchanged limits. Full builds,
native compilation and full tests belong on CI. Earlier automatic review refused
local compiler/standalone C builds; do not bypass or repeat those requests.
Recent guarded checks: Rust formatting 1.11s, workflow lint 1.44s, documentation
audit 2.64s, six-host report retention 37.47s, actual ARM64 stack-bound inspection
0.13s. Retaining the binary observation in the report passed in 1.84s. No local
native build was used.

Remote stream caches, connections, HTTP/2 server operations, retained host
callbacks and GPU ownership remain. The [ownership guide](ownership.md#what-remains-before-remote-calls-can-use-arc)
sets concrete tests for repeated calls, early stop, aliases, detached users and
cycles. Prefer ownership and borrowing; do not substitute permanent retention
or silent tracing. All seven project work areas remain open.

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
