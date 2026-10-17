# Session handoff

Updated 2026-10-17 UTC. [PLAN.md](../PLAN.md) retains seven unfinished work areas.
One delivery is open: [PR #155](https://github.com/e6qu/fun-with-pipes/pull/155),
branch `remote-stream-delivery` in `/Users/zardoz/projects/fun-with-pipes`.
Its published head is `31385092e4a3b357243b7c255af0e7d4521901c9`. Production
`38986731253` failed in `grpc_receive_cleanup`; no merge occurred and the old
watcher exited. The error was a fault-injection hook expecting one generic
`free(g->m)` statement after the runtime added two more. It now matches only
`g_got_release`. Documentation and benchmarks passed; other old jobs were still
running when the failure was found. That superseded production run is cancelled. The failed head is not acceptance.

## Combined stream and chain delivery

The verified chain preparation `7ffb4552` has been applied to the existing PR
branch, together with the receive-test repair, to avoid a second full CI cycle.
Root changes are still awaiting the focused repair run before publication.
The same repair is mirrored to preparation branch `bounded-chain-destruction`
in `/private/tmp/fwp-chain-destruction`, which already contains both batches.
The focused stream suite and Windows production job now include neighboring
receive, status, send, encoding, client and server cleanup targets. The stream
collector explicitly requires the repaired receive test.

Focused run `38989714484` at `117f817b` passed on Intel macOS but exposed
Windows fixture portability failures in the newly added neighboring tests.
Eight hooks included CRT headers before selecting the required Windows API.
The server fixture also assumed POSIX socket descriptors and the Unix OpenSSL
executable layout. These are repaired: early API selection, native-width handles,
loopback TCP pairs, an OS-level closed-socket check and the configured Windows
tool location. Formatting through the guard passed in 1.27s. Both worktrees
contain the repairs; runtime/compiler behavior is unchanged by them.

Repair `6ac13de78fd10932f28a34ce776a9197acd3175a` is published; focused run
`38990255544` is testing it on all six native hosts. Next: finish that run.
Fix any failures; refresh its stream report, then commit/push the complete combined
PR #155 with a description covering both changes. Require all nine production
jobs plus documentation on that new final head. Create a new merge watcher for
its new head/run IDs; the prior watcher is finished. Squash with one line of at
most 80 characters and an explicitly empty body, no trailers or AI attribution.
Cancel duplicate/superseded production runs only; leave Windows dependency jobs
running. Failing tests are tasks, and JIT is excluded.

The first stream batch's six-host evidence is `38985903147` at `4c26f21f`, with
16-byte positions and 81 requested bytes per received 16-character value versus
24/89 previously; four allocations remain. It fixes shared readers, cancellation
during decoding and description lifetime. This focused source predates the new
compiler loop and receive-test repair, so the combined run is required.

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
The next measurement is prepared locally on `measure-remote-stream-clients` in
`/private/tmp/fwp-stream-clients`, based on `6ac13de7`; it has no PR and has not
run yet. The ignored runner-only test in `tests/grpc.rs` generates actual native
clients for full consumption, the first 32 values, and a retained first position.
It compares output with raw interpretation, then records three allocation/live
storage samples at 64/1,024/16,384 values with GC off. The server is interpreted
and excluded from the counters; raw buffers/process memory and timings are also
excluded. The new `stream-clients` focused suite records compiler/CPU/source and
binaries. Local guarded formatting passed in 1.11s; runner verification remains
required. Finish the current PR's repair/publication first, then validate this
preparation while production runs. Retained host callbacks, GPU resources and
all seven project areas remain open.

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
