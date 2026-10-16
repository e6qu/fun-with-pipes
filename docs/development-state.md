# Session handoff

Updated 2026-10-16. [PLAN.md](../PLAN.md) defines seven unfinished work areas.
This branch prepares one combined service-memory, compiler and iteration PR.
The only open delivery PR is #153; do not open a second before it is accepted.

## Current action

Workspace: `/private/tmp/fwp-context-owners`, branch `service-context-preparation`.
Preparation base: `ac3060d1`. The latest test repair limits diagnostics to
modes that support them; it does not change the compiler or library.

Next: publish the test repair and run all six native hosts again. Actual
WebAssembly run `38962206780` uses unchanged library/compiler source `2a98d395`.
Run `38963627765` found that ARC also rejects reuse verification, which retains
freed storage for comparison. Tracing still tests both reuse settings with GC
stress; ARC tests ordinary freeing. The earlier normal-completion measurement
hook repair remains. The Linux ARM64 allocation comparison passes: increasing
from 32 to 128 iterations avoids 96 requests and 3,072 requested bytes versus
the former mapping definition. Complete native semantic and cross-host checks
are still required. Retain the final comparison and inspect its binaries after
those pass. Guarded Rust formatting passes (0.14s).

After #153 passes and merges, preserve the preparation's current head under a
remote evidence tag before rebasing: the reports refer to earlier source commits.
Rebase only changes after `ac3060d1` onto the accepted squash. Preserve both the
byte-decoder repair and context-owner suites when resolving workflow conflicts.
Publish one combined PR; require all nine production jobs and documentation on
its final head. The new dependency-cache workflow's two Windows jobs must also
pass when introduced. Focused runs do not replace full acceptance.

PR #153 is in `/Users/zardoz/projects/fun-with-pipes`, branch
`owned-values-delivery`, head `f6dc9940b562a52bc0a3b207fdd6fd58ac3d1aba`.
Its six focused decoder jobs (`38955537587`) and documentation (`38955543617`)
pass. It is ready; production run `38958379514` is running on that exact head.
Use `/private/tmp/fwp-merge-153.py --production-run 38958379514
--documentation-run 38955543617` to check it, adding `--merge` only after all
nine production jobs pass. The helper verifies the squash tree, parent and
one-line message, then cancels duplicate production CI. Preserve the root's
uncommitted handoff before switching branches. Standing authorization covers
publication, fixes and merge; failing tests are tasks to fix.

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
promise ordinary cleanup before process termination. Broader WASI/browser and
physical-storage checks pass on both Linux architectures in `38955989639` at
compiler source `79ce442f`. The newer library change below requires its fresh run.

Service reflection cleanup at `9fa2a0f4` passes the complete Linux AMD64 run
`38959410533`. Reflection lets tools ask a server which methods it provides.
Request and response buffers release on success, encoding traps and cancelled
sends; separate missing-cleanup controls must fail. The current six-host run
includes this repair. Whole-service ownership is still unfinished.

## New iteration simplification awaiting checks

The measured plain `each` builds and discards a list of unit results. The new
library definition is `each = const | flip fold ()`. Unit, written `()`, is the
running value of the fold. `const` ignores that value and selects the supplied
callback. This adds no primitive or syntax.

Accepted-interpreter checks preserve shared inputs, ordered output, state updates
and typed failure (0.26s). A division-trap check prints `2`, then `0`, and exits
with the expected status 101 before visiting the final element (0.25s).
Library formatting passes (0.01s).

New tests in `state_sequence_ownership` compare raw/optimized interpretation with
O1/O2 tracing/ARC. Collector stress/verification applies only to tracing; reuse
verification applies to both modes. A separate executable control
uses the old mapping definition and compares managed allocation slopes at 32/128
elements. Both must print the same count; the new definition must eliminate at
least one allocation per element. `each-storage.tsv`, source and binaries are
uploaded with the context evidence. Earlier reports still use mapping-based
`each`; retain a new report after the current native run passes.

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
CI. Guarded actionlint passes on all changed workflows (1.27s); actual new-workflow
jobs remain to be verified on the next PR.

## Evidence and local checks

Passing tuple-forwarding artifacts are under
`/private/tmp/fwp-context-forwarded-evidence/38958562126/`. The report helper is
`/private/tmp/fwp-retain-context-final.py`: pass a successful six-host run, its
exact source, artifact directory, output path and `--capture-requests 1` through
the local guard. It validates jobs, counters, layouts, inventory and capture
controls. New source needs new binary observations. Earlier owned-scope artifacts
are under `/private/tmp/fwp-context-final-evidence/38953639844/`.
The next PR description is `/private/tmp/fwp-context-pr-body.md`.

Use `python3 scripts/local-guard.py COMMAND...` with unchanged limits. Full builds,
native compilation and full tests belong on CI. Earlier automatic review refused
local compiler/standalone C builds; do not bypass or repeat those requests.
Recent guarded checks: Rust formatting 1.08s, six actual generated sources with
unique allocation/normal-completion hooks 0.13s, documentation audit 2.52s, report
retention 20.42s, replacement ARM64/AMD64 binary inspection 0.13s. No local native
build was used. An obsolete morning run (`38888712709`) has a stale in-progress
listing, but all its jobs finished and GitHub reports it completed when cancelling;
it is not using runners.

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
