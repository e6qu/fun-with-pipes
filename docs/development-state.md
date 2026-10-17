# Session handoff

Updated 2026-10-17 UTC. [PLAN.md](../PLAN.md) retains seven unfinished work areas.
There is one active delivery: [PR #155](https://github.com/e6qu/fun-with-pipes/pull/155)
at `31385092e4a3b357243b7c255af0e7d4521901c9`, branch `remote-stream-delivery`
in `/Users/zardoz/projects/fun-with-pipes`. Production run `38986731253` is still
running; documentation `38986731302` and the benchmark job pass. Do not change
that final head or merge before all nine production jobs pass. The authorized
watcher `/private/tmp/fwp-watch-155.py` verifies head, gates, merge tree, parent
and one-line message. Its merge record will be `/private/tmp/fwp155-merge-record.json`.

## Next delivery ready for assembly

Preparation branch `bounded-chain-destruction`, worktree
`/private/tmp/fwp-chain-destruction`, starts from PR #155's final head. The
compiler and expanded tests are verified at `aea7d6df682fc0c067a4533fe019f0bfd0c14b4f`.
Remaining local changes are the final report/collector, explanatory docs,
updated handoff and comment corrections. Plain PR body:
`/private/tmp/fwp-chain-pr-body.md`.

Next: commit and preserve this final preparation, wait for PR #155's complete
acceptance, then assemble it on the accepted merge and publish the next delivery.
Run all nine production jobs and documentation on its final commit. Fix failures;
queued CI gates merging, not independent work. Squash subject must be one line,
at most 80 characters, with an explicitly empty body and no trailers/attribution.
Cancel duplicate postmerge `ci.yml` only; leave `windows-dependencies.yml` running.

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
Native `g_decode` still uses unowned `fwp_decode`; custom decoder callbacks need
a reviewed result contract too. Marking the primitive reviewed alone cannot
safely establish ownership.

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
