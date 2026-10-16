# Session handoff

Updated 2026-10-16. [PLAN.md](../PLAN.md) defines seven unfinished work areas.
This branch prepares the next combined service-memory and compiler PR. The only
open delivery PR is #153. Do not open a second PR before it is accepted.

## Current action

Workspace: `/private/tmp/fwp-context-owners`, branch `service-context-preparation`.
Base: `ac3060d1`. Current code: `cb0ffeea21a87750bffeb66e72180020b2acf7d8`.
The compiler change is `79ce442f`; `cb0ffeea` corrects its native test setup.

Next: require native run `38956983459` and actual WebAssembly run `38955989639`
for the new tuple-forwarding optimization. Fix any failures. Retain its allocation
comparison against the passing `975806e9` report before claiming the saving.
After #153 acceptance, rebase only this branch's changes after `ac3060d1` onto
its accepted squash. Then publish one combined PR and require all nine production
jobs plus documentation on its final commit. Focused checks do not replace that
acceptance. Preserve the existing effect rule: only a binding's final function
arrow may have effects; partial application is pure.

PR #153 is in `/Users/zardoz/projects/fun-with-pipes`, branch
`owned-values-delivery`, head `f6dc9940b562a52bc0a3b207fdd6fd58ac3d1aba`.
Its authoritative handoff is that checkout's `docs/development-state.md`.
It is temporarily draft while decoder run `38955537587` and documentation
`38955543617` check the repaired test hook and restored Windows OpenSSL setup.
Generated WebSocket code needs those headers even for parsing-only programs.
All nine production jobs must run after the focused checks pass. Draft-skipped
jobs are not acceptance. `/private/tmp/fwp-ready-153.py` checks readiness;
`/private/tmp/fwp-merge-153.py` requires explicit production/documentation run IDs.
Squash subjects must be one line, at most 80 characters, with an empty body and
no trailers or attribution. Verify the merged tree, parent and message, then
cancel duplicate postmerge CI. Standing authorization covers these actions.

## Verified service-memory baseline

Source `975806e9e76d3df3c285fb3d8f6c826ba626298e` passes all six native hosts in
`38953639844`, including actual interpreted/native service calls. The
[owned-scope report](measurements/service-context-owned-2026-10-16.json) preserves
CPU/compiler versions, layouts, counts, binary formats and ARM64 instructions.
The inventory has 347 contract declarations and seven remaining primitive
reviews. Other ownership boundaries remain too; this is not completion of GC removal.

Five service helpers keep settings on the stack, and child tasks copy settings
into their existing task records. Synchronous calls borrow TLS/capture owners;
children retain shared data when they need independent lifetimes. Header pointers
and copied text occupy one allocation. Empty or ignored header lists borrow the
previous settings. Tests cover parent return/error/trap/cancellation, child
cleanup, size and count overflow, allocation failure and deliberately missing
inheritance, copying, release and retention.

The helpers also borrow their typed callbacks and own returned values. Response
capture owns the callback result and copied headers, preserving order and
duplicates. Tests compare raw/optimized interpretation with native tracing/ARC,
retain caller aliases and returned functions, exercise typed failures and
13/14 captured-result allocation failures, and inspect ARC binaries for tracing
functions. Client and served-request decoding scratch releases on traps.
The repaired Windows evidence path explicitly names `probe.exe`.

For 1/32/128 calls, compared with plain fwp state updates at O2 and collection
disabled, all six hosts have these extra costs per call:

| Scope | Managed requests | Requested bytes | Retained charged bytes |
|---|---:|---:|---:|
| Compression, deadline, empty/ignored headers | 0 | 0 | 0 |
| One outgoing header | 1 | 40 | 0 |
| Response-header capture | 2 | 48 | 0 |

Fixed scheduler startup remains in the raw rows; the per-call difference removes
that fixed cost. Raw TLS/capture buffers, allocator pages and process memory are
excluded. These are fwp-to-fwp memory comparisons, not speed or C/Rust parity.
The original [baseline](measurements/service-context-baseline-2026-10-16.json)
records the old heap settings. The intermediate
[stack report](measurements/service-context-stack-2026-10-16.json) predates packed
headers and owned results; its old Windows fixture failures are superseded.

Settings occupy 72 bytes aligned to eight bytes. The Linux AMD64 service task
is 1,584 bytes versus the original 1,512; all host layouts are in the report.
Actual Linux ARM64 instructions copy the settings with four 16-byte registers
and one eight-byte register. The wrapper reserves 144 stack bytes and its separate
handler 464; these are instrumented binary observations, not a total stack bound.
The callback helper remains a call. Programs without service support omit the
settings fields.

Explicit `exit` also passes native checks at `975806e9` and actual WASI checks
on both Linux architectures in `38949856424`, source `6b642a82`. Seven status
cases preserve prior output and use the low eight bits of the exit status.
Exit produces no result; it does not promise normal scope cleanup before process
termination. Broader WASI/browser checks pass at `24caa70b` in `38947985548`.
The compiler optimization below needs fresh WebAssembly checks.

## Implemented follow-ups awaiting verification

Generated code at the passing baseline shows why response capture still allocates
twice: a forwarding function unpacks its callback's owned tuple and allocates an
identical tuple in its boxed entry. `79ce442f` keeps that returned owner when
every return path forwards a dynamic callback result. Known direct calls and
functions constructing records retain their existing worker choices.

The allocation test now requires one capture-result allocation per call. A new
native test compares interpreter results, shared strings and a trapping callback;
a deliberately reintroduced result-box allocation must fail its count. The
fixture enables real task unwind support and initializes the scheduler before
counting result allocations. Existing
record-worker and conversion controls run with it. Do not claim the one-allocation
result until `38956983459` passes, or WebAssembly support until `38955989639` passes.

A further local repair registers a channel sender's encoded buffer before
encoding and sending. It releases on success, encoding traps and cancellation
while the send waits for connection space. The existing response test now covers
all three paths and requires deliberately omitted sender cleanup to fail. This
repair is not part of `38956983459`; final combined CI must verify it.

The shared `scripts/run-native-tests.py` also adds explicit `--all` selection for
Linux. It retains every Cargo target and stress case, with two executable workers
and one harness thread each. Missing/duplicate executables fail before execution;
failed targets do not skip the remainder. Mac assignments remain unchanged.
Seven Python checks pass, including real Cargo metadata for 233 integration
targets. Final production CI still needs to verify Linux's new scheduling.

## Evidence and local work

Artifacts for the passing baseline are under
`/private/tmp/fwp-context-final-evidence/38953639844/`. The report helper is
`/private/tmp/fwp-retain-context-final.py`: pass a completed successful six-host
run, its exact source, artifact directory and output path through the local guard.
It checks jobs, counts, layouts, inventory and capture controls. New source needs
new binary observations; do not reuse instruction addresses from an older binary.
The next PR description draft is `/private/tmp/fwp-context-pr-body.md`.

Use `python3 scripts/local-guard.py COMMAND...` with unchanged limits. Full builds,
native compilation and full tests belong on CI. Earlier automatic review refused
local compiler/standalone C builds; do not bypass or repeat those requests.
Recent guarded checks: formatting 1.08s, documentation audit 2.60s, evidence
retention 33.72s, existing ARM64 binary inspection 0.14s. Earlier seven runner
checks passed in 1.07s. No local native build was used.

Remote stream caches, shared connections, HTTP/2 server operations and GPU
ownership remain. The [ownership guide](ownership.md#what-remains-before-remote-calls-can-use-arc)
sets concrete tests for repeated calls, early stop, aliases, detached users and
cycles. Prefer ownership and borrowing; do not replace missing lifetime proofs
with permanent retention or silent tracing. All seven project work areas remain
open. JIT is excluded, not deferred.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Service and external ownership; remove tracing |
| 2 | In progress | Avoid tuple rebuilding, allocations and unnecessary counts |
| 3 | In progress | Reduce equivalent-work C/Rust gaps |
| 4 | In progress | Differentiation precision, speed and memory scaling |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Repeated, comparable performance measurements |
| 7 | In progress | Larger representative applications |
