# Session handoff

Updated 2026-10-17 UTC. [PLAN.md](../PLAN.md) retains seven unfinished work areas.
One delivery is open: [PR #155](https://github.com/e6qu/fun-with-pipes/pull/155),
branch `remote-stream-delivery` in `/Users/zardoz/projects/fun-with-pipes`.
Published head `e71a2295b1d0d0a5d51fb90b6cbe442364aee431` includes stream correctness/storage work, bounded-stack
chain cleanup and portable neighboring service tests. Final production acceptance
is still required; no merge has occurred.

## Current delivery and acceptance

The stream component report remains the passing six-host measurement at
`4c26f21fe717c4df35a4439e59c1812a5edb449d`, run `38985903147`. The chain component
report remains the passing six-host measurement at `aea7d6df`, run `38988093805`.
Preserve these measured source identities instead of relabeling them as the
combined revision. Their runtime/compiler changes are now bundled in PR #155.

The first production attempt (`38986731253`, head `31385092`) found a fragile
receive-test fault injection: a generic `free(g->m)` match was no longer unique.
The repair targets only `g_got_release`. Expanded focused checks then exposed
Windows-only fixture assumptions: late API-version selection, POSIX-only socket
handles/pairs and a Unix OpenSSL path. Those are repaired. Run `38990255544` at
`6ac13de7` passed Linux AMD64; Windows AMD64 passed every neighboring fixture
except a diagnostic assertion expecting LF instead of Windows CRLF. That assertion
now normalizes text line endings; it still checks the exact message, exit 102
and empty stdout. These fixes change tests, not runtime behavior.

Final production run `38990872293` is queued/running on that exact published
head; its benchmark job passed. Documentation run `38990872208` passed. The superseded focused run
`38990255544` was cancelled after diagnosing the Windows assertion; all affected
targets are included in production CI. Do not repeat the entire six-host focused
suite solely for that assertion. Both measured component identities remain intact.

Next: monitor the final matrix and fix failures. The new merge watcher is running in exec session `9247`:
`/private/tmp/fwp-watch-155.py`, invoking `/private/tmp/fwp-merge-155.py` with this
head and those run IDs. It requires all nine named production jobs plus the
single documentation job to pass on the same head. It supplies the squash subject
`Fix shared stream reads and bound cleanup stack use` and an empty body, then
verifies tree, parent and exact one-line message and writes
`/private/tmp/fwp155-merge-record.json`. Keep Windows dependency jobs running;
only cancel superseded checks or duplicate postmerge production jobs. Queued CI
does not block independent preparation.

Static inspection of the combined Linux AMD64 binaries from passing job
`117270859226` confirms unchanged stream receive frames: 344 bytes in the O2
fixture and 216 bytes in the O1 service client, including saved registers and
excluding the incoming return address. Download took 2.67s and inspection 0.15s
through the local guard; no downloaded executable ran locally. Artifacts are in
`/private/tmp/fwp-stream-combined/38990255544/stream-storage-ubuntu-latest`.
The retained report still identifies its original measured binaries.

## Verified chain cleanup

Baseline [38987418673](https://github.com/e6qu/fun-with-pipes/actions/runs/38987418673)
at `70e36523aa42926683a3d9944a04ebfba943709f` and candidate
[38988093805](https://github.com/e6qu/fun-with-pipes/actions/runs/38988093805)
at `aea7d6df` pass on all six native OS/architecture targets. The baseline tag is
`evidence/wrapped-chain-baseline-20261017`. Earlier fixture lookup/poisoning
failures are repaired and superseded; they establish no acceptance.

The compiler follows a final counted field through records and variants with
one nonempty constructor when that path returns to the original type. These
wrappers release in a loop; a remaining owner stops child destruction. Existing
direct self-tail handling and count-only mode stay unchanged. Other branching
recursive graphs can still need calls. There is no runtime work list.

Checks cover optional and optional/tuple chains at 64, 1,024 and 16,384 links,
root/node/optional/tuple aliases, physical reclamation with zero collections,
O1/O2 interpreter/native agreement, and hybrid collector/reuse stress with
physical freeing enabled and disabled. Restoring recursive destructors must
exceed the stack bound. The source examples hash their whole small chain to
retain independently callable type-specific cleanup functions.

The [report](measurements/wrapped-chain-cleanup-2026-10-17.json) compares O1/O2
stack-address variation, not total stack size or timing. Linux AMD64's preceding
O2 span grows from 2,048 bytes at 64 links to 32,768 at 1,024; ARM64 grows from
3,072 to 49,152. Candidate spans stay at 16 and 32 bytes respectively through
16,384 links. Across all hosts/flags/aliases, candidate spans are at most 48 bytes.
A zero span means the sampled address stayed the same, not zero stack storage.

Static inspection of actual Linux O2 binaries confirms backward branches and
fixed Link-cleanup frames: AMD64 24 bytes excluding the incoming return address;
ARM64 64 bytes including saved registers. Apple Silicon also reserves 64 bytes.
The report retains excerpts/hashes; ordinary release helpers have their own
frames. Node allocations and reference counts remain. Baseline CPU/compiler
metadata was not recorded separately, so its logs/binaries are retained without
a timing claim. Native remote caches still need explicit ownership.

## Reproduction and local checks

Artifacts: `/private/tmp/fwp-chain-evidence/`, grouped by run and native host.
Use `scripts/collect-chain-measurements.py` with both run IDs/full heads,
`--artifacts` and `--output`, through
`python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py`.
Collection passed in 27.83s; refresh after binary inspection passed in 2.89s.
Static inspections used `/private/tmp/fwp-inspect-chain-binaries.py` with each
artifact folder through the same guard and passed in 0.14–0.15s. Mach-O uses its
format-specific objdump mode. No downloaded executable ran locally.

Formatting passed in 1.14s; the tuple example's prebuilt-compiler type check in
0.26s; collector syntax in 0.14s; docs audit in 2.70s. The guard remains serial/low priority with 64 GiB free disk,
target below 2 GiB, sampled aggregate RSS below 1 GiB and a 180-second deadline.
Full builds, tests and native execution stay on GitHub runners.

## Documentation cleanup

Ownership and TLS guides now point to PR #153's accepted UDP/TCP/TLS delivery;
they no longer describe it as unaccepted preparation. A stale runtime reference
to `docs/grpc.md` now points to `docs/services.md`. The benchmark guide explains
stack-address span, instrumentation overhead and what the measurements exclude.
The seven project areas remain open, and JIT is excluded.

## Subsequent ownership work

Next give cached results and continuations typed owners and bounded-stack
last-reference destruction, including partial construction and retained aliases.
Move a source owner forward when possible. Establish owners for pools, calls,
connections, streams and decoder captures; scheduler identities remain borrows.
The existing connection counter controls transport closure, not complete object
destruction. [Ownership](ownership.md#what-remains-before-remote-calls-can-use-arc)
records these distinctions. Remote calls remain excluded from checked ARC. Compiler work must review
`CGen::drop_body`, lowering of `grpc._force` and RPC result descriptors together.
Standard wire decoding already returns owned values and cleans partial fields
through `fwp_decode` in `runtime/fwp_rt_exec.c`. The cache must preserve/transfer
those owners through wrapper construction, publication and failure. The custom
callback branch still uses `fwp_apply1` and needs a separate result contract;
marking `grpc._force` reviewed alone cannot establish graph ownership.

A promising next contract consumes a position: when it has one owner, transfer
its saved result directly; when shared, return another result owner. Keep type
information in generated code or existing method descriptors instead of adding
a destructor pointer to every position. For long chains, release a position,
its optional-result wrapper and its tuple iteratively while each is uniquely
owned; stop at a shared wrapper. Decode results and partial construction need
owners before publication. Runtime calls into `grpc._iter` must use the owned
application machinery and transfer arguments exactly once. These are proposed
implementation constraints, not completed work. Measure actual language clients
as well as C fixtures: retaining an earlier iterator intentionally retains its
saved sequence, so dropping C roots alone cannot prove bounded consumption.
## Complete-client measurement preparation

Branch `measure-remote-stream-clients`, worktree `/private/tmp/fwp-stream-clients`,
is at `456f2dbd` and includes delivery head `e71a2295` through a merge. It has no
PR. Focused run `38991578784` passed on all six native hosts. The baseline report
`docs/measurements/remote-client-memory-baseline-2026-10-17.json` is generated in
this preparation worktree; collection through the guard passed in 20.66s. Earlier preparation runs failed on an extra `--` program argument and a
Unix `Command` captured across a panic-unwind boundary; both are corrected.

The runner-only test generates actual native clients consuming all 64/1,024/16,384
integers, only the first 32, or the whole sequence while retaining the original
iterator for a later reread. Output must agree with raw interpretation and an
uninstrumented native client. Three measured processes record managed allocations,
retains and allocator-charged storage with collection off and physical freeing
on. The server is interpreted. Raw buffers, process/server memory and timing are
excluded. Invalid input fails explicitly. A neighboring regression now verifies
that silent service startup times out: stderr is drained on a background reader,
and timeout kills and waits for the child instead of blocking in `read_line`.

Linux ARM64 and Apple Silicon samples are downloaded under
`/private/tmp/fwp-stream-client-evidence/38991578784/`. Both show five allocation
requests per additional consumed integer and about 104 requested bytes (argument
string length contributes a small fixed difference). After entry cleanup, charged
storage still grows by exactly 64 bytes per consumed integer in both full-read
modes. Linux ARM64's unique case ends at 23,872 / 85,312 / 1,068,352 bytes; Apple
Silicon ends at 6,816 / 68,256 / 1,051,296. All three repetitions agree on these
hosts. Partial consumption stays fixed in managed storage; that does not prove
bounded unread raw message queues, which are excluded.

Generated C confirms `GrpcCell` is not counted by `src/rc.rs::needs_rc`: the
`(I64, GrpcCell[I64])` destructor does not visit its cell field. The next cache
change must coordinate that classification, a typed bounded-stack cell destructor,
closure captures, the consuming `grpc._force` contract and remote iterator entry
calls. Prefer transferring an exclusive cached result, duplicating only for a
shared cell. Standard wire decoding already returns owned values. Connection,
stream and decoder lifetimes still need review; do not admit whole remote calls
to checked ARC before those graphs are owned. Releasing cache memory must not
silently introduce earlier remote cancellation or change observable effects.

The passing baseline is collected with
`scripts/collect-stream-client-measurements.py` in that worktree. It requires all
six jobs, both named tests, exact source IDs and 27 rows per host, then retains
ranges, environments and binary hashes. Guarded Python syntax passed in 0.20s;
formatting in 1.16s; the corrected fwp input program type-checks in 0.26s using
the prebuilt compiler. Downloads took 2.87s/2.84s under the guard. No local native
builds ran. Preserve the measurement source under
`evidence/remote-client-memory-baseline-20261017` before publication.

The ownership candidate is started separately on `own-remote-stream-caches` in
`/private/tmp/fwp-owned-stream-caches`, based on `456f2dbd`. Its uncommitted changes
span `src/rc.rs`, `src/ownership.rs`, `src/cgen.rs` and `runtime/fwp_rt_grpc.c`:
count cells, consume force arguments, move exclusive cached results, release
cell/optional/tuple chains iteratively, and use owned remote-iterator entry calls.
Source allocations move between unread positions and release at the end; freeing
a source does not cancel the connection. Connections, streams and decoder
contracts remain unfinished, and ARC still rejects remote calls. This candidate
is not verified. Finish partial-construction/error owners, update affected fixture
hooks, add alias/cleanup/negative controls and single-host probes before broad CI.
Do not publish it as supported merely because the baseline passed.
Retained host callbacks, GPU resources and all seven project areas remain open.

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
