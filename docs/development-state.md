# Session handoff

Updated 2026-10-16. [PLAN.md](../PLAN.md) defines seven unfinished project areas.
This is remote-stream preparation in `/private/tmp/fwp-stream-caches`, branch
`measure-remote-stream-storage`, based on `20f0f5f0`. There is no second PR.

## Current delivery

[PR #154](https://github.com/e6qu/fun-with-pipes/pull/154) remains the active
delivery in `/Users/zardoz/projects/fun-with-pipes`, branch
`service-iteration-delivery`, at `51354d10d5a55e0b4153653f68b670f69712e4d9`.
Final production run: `38977201910`; documentation: `38977126983`; Windows
dependencies: `38977201787`. Documentation, dependencies, benchmarks and both
Apple Silicon production jobs pass. Other production jobs are running.

The authorized merge watcher is exec session `96582`, running
`/private/tmp/fwp-watch-154.py`. It checks every 45 seconds, stops on a failing
gate, and requires all nine production jobs, docs and both new dependency jobs
on the exact head. It supplies the one-line squash subject and empty body, then
checks tree, parent and message. Inspect its output and
`/private/tmp/fwp154-merge-record.json` before taking another merge action.
Leave the postmerge Windows dependency-cache workflow running.

Before delivering this preparation, preserve its measured ancestry under a
remote evidence tag, then rebase only changes after `20f0f5f0` onto accepted #154.
Keep one delivery PR at a time. Recheck the combined final source before merging.

## Current preparation and next action

All six native jobs pass in `38980361640` at
`7b378e76dff097fa988a707b50e7dfc53072bdd4`. This verifies stream descriptions,
source lifetime, concurrent readers, cancellation, native layout probes, and
actual interpreted/native shared-stream clients and servers.

The final refinement formats client descriptions directly into their source's
allocation, avoiding a temporary 1 KiB array that a C compiler could inline into
a suspended caller. Component lengths are bounded before addition. The existing
1,023-byte client description limit is preserved; server descriptions retain
their full length. Forty short/long method/address combinations exercise the
punctuation and truncation boundaries against the old formatter.

Next: publish this refinement with the updated evidence collection, run
`stream-owners` on all six hosts, and retain the report with
`python3 scripts/local-guard.py python3 scripts/collect-stream-measurements.py`.
Supply `--run`, exact `--head`, `--artifacts` and `--output`. The collector checks
successful jobs, named unit/native/service tests, allocation rows, layouts,
compiler/CPU details and artifact hashes. It never executes downloaded binaries.
The workflow records the actual `CC` compiler, including Windows' selected
native toolchain. It also retains the already-tested service executables at O1;
fixture binaries and generated C are retained at O1/O2. This refinement still
needs CI; the passing preceding run cannot verify it.

## What is implemented and tested

A received stream position caches its value so every reference sees the same
message. The interpreter represents a position as either unread source or cached
value. Completing a position releases its source reference; the cached
continuation keeps the next unread position alive. Normal and error ends retain
no source. Native positions clear their obsolete source pointer after constructing
the result. Failures before publication keep the original source intact.

Incoming descriptions share their source's allocation. This replaces a separate
unreleased client allocation and a server borrow from handler storage. Mutation,
allocation-size, overflow and deliberately borrowed-text controls pass.

One task receives at a time for a shared unread position. Other tasks wait and
then use the cache. Completion, error and cancellation release the receive guard
and wake waiters. Cancelling a waiter leaves the receiver running. The controlled
cancellation fixture uses a server request stream; existing client-call
cancellation still resets that call's stream. Task identities and wait lists are
borrowed from the scheduler, not owning back-references. Recursive reading of
the same source traps explicitly.

The deterministic native test starts two readers before supplying two messages:
both must receive the first, leaving the second queued. Removing synchronization
must produce different results and fail. Receiver/waiter cancellation are tested
separately, with a ten-second task deadline bounding broken wakeups. Native
O1/O2 runs check GC stress, verification and reuse. Interpreter weak references
check early stop, retained earlier positions, failures and last-owner release.
The actual shared-stream client sums 1..1024 in two tasks; both print
`Some 524800` across interpreted/native server/client combinations.

Windows fixtures now choose the required Windows 10 API before their CRT headers.
The preceding header-order and harness failures are fixed in the passing six-host
run. Regular Windows CI now includes both native cleanup targets, interpreter
source-lifetime tests and the shared-stream client/server test.

## Measurements and limits

The [initial baseline](measurements/remote-stream-baseline-2026-10-16.json) passes
Linux AMD64 in `38973859489` at `deae732b`. It receives queued protobuf messages
containing 16-character strings, at 1/32/128 elements, with repeated reads,
full/half consumption and a retained first position. It records four managed
requests/89 requested bytes per value, charged as 112 bytes after rounding.
Setup charges 688 bytes; at 128 values, 15,024 bytes remain charged after clearing
C references with collection disabled. Whole-library shutdown frees queued raw
messages. Current source/description/guard storage has a different fixed setup
cost; retain fresh rows rather than applying the baseline setup to it.

These are controlled receive/cache measurements. They exclude socket I/O,
connection pooling, raw codec/message buffers and whole-call timing. They are
not comparisons against C/Rust. Native cached values still lack explicit
last-reference destruction; services remain excluded from checked ARC.

Earlier passing source-lifetime artifacts are under
`/private/tmp/fwp-stream-source-evidence/38977738266`, at `451cc94e`. Actual AMD64
instructions publish the cache and clear the source pointer; the common frame
remains. This is representation evidence, not a speed claim. Earlier description
artifacts are under `/private/tmp/fwp-stream-description-evidence/38977205160`.
Use the final run for new claims and fresh binary observations.

## Checks and remaining ownership work

Full builds, native compilation, large regeneration and full tests run on GitHub.
Use `python3 scripts/local-guard.py COMMAND...` for serial bounded local checks;
keep all limits unchanged. Recent guarded results: Rust formatting 1.09s,
workflow lint 0.89s. The docs audit caught a missing roadmap status
table in the rewritten handoff; it now passes after restoration (2.53s). The accepted prebuilt compiler formats the
shared client in 0.01s and type-checks it in 0.24s. The collector was checked
against passing one-host evidence in 4.93s; it rejected an incorrect source SHA.
No compiler or C program was built locally.

Next give native cached values and continuations explicit typed owners, with
last-reference and partial-construction cleanup. Move the source to its unread
continuation when possible, avoiding a retain/release for each message. The
source must keep its connection, stream and decoder captures valid. Establish
which references own each task/connection/stream and which merely borrow before
admitting remote calls to ARC. Long cached chains need bounded-stack destruction.
Connection pooling, detached users, cancellation, retained host callbacks and
GPU ownership remain. Preserve immutable iterator behavior and existing syntax.

Every commit/squash message is one line, at most 80 characters, with no body,
trailers or attribution. JIT is excluded. Failing tests are work to fix.
All seven areas in PLAN.md remain open; this delivery does not finish GC removal.

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
