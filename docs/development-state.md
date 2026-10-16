# Session handoff

Updated 2026-10-16. [PLAN.md](../PLAN.md) retains seven unfinished project areas.
This is the combined preparation for the delivery after PR #152. Keep one active
PR, fix failures, and merge only after all final-head production and docs gates.

## Delivery chain

PR #151 is accepted as `3dff03b644c4922845f7c4b9f3a9673dece5ef16`. Its tested
head `27cdc7ff` passes all nine production jobs `38872161681` and docs
`38872161673`. Merge tree, parent and one-line message were verified. Duplicate
postmerge production `38884089916` is confirmed canceled.

[PR #152](https://github.com/e6qu/fun-with-pipes/pull/152) is the only open delivery.
Current head `c81b0c9f016f0e359f22e8819792baba0760ab30` has fresh production
`38890080777` running and docs `38890080771` passing. Prior `ed936381` production
`38884588161` failed because `examples/vector-lanes.fwp` was unformatted; the
example is fixed, and language formatting now runs before long production suites.
The old unfinished run was superseded. Prior passing jobs are not acceptance of
the corrected head.
Its main-workspace handoff retains numerical evidence and is authoritative for
that PR. Do not change its head for this preparation. Draft-only skipped jobs
are not acceptance. Use an explicit one-line subject, at most 80 characters,
and empty body for squash merge; no attribution or trailers.

Current preparation: `/private/tmp/fwp-owned-kernels`, branch `owned-cpu-kernels`.
It includes decoder/metrics branch `owned-value-decoders` through `21a621c6`, plus
CPU kernel changes. The complete following-delivery delta starts after
`3577ba3780c19051845a5beba3f064f608cedf1e`. Rebase only that delta onto accepted
#152, preserving its final numerical changes, measurements and documentation.
Do not replay the numerical preparation ancestry or publish competing PRs.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Complete deployment and primitive ownership; remove tracing |
| 2 | In progress | Deliver numerical and owned-value batches; reduce remaining abstractions |
| 3 | In progress | Measure remaining C/Rust gaps and inspect generated code |
| 4 | In progress | Reduce derivative recording costs and validate scaling |
| 5 | In progress | Validate CPU kernels and resolve runtime OpenCL compilation |
| 6 | In progress | Retain comparable, repeated measurements and storage costs |
| 7 | In progress | Extend maintained programs across deployment boundaries |

## Following batch: owned values and CPU kernels

Acceptance requires raw/optimized interpreter/native parity, tracing stress and
reuse checks, checked ARC storage returning to baseline, injected failures and
controls that deliberately omit cleanup. Actual WASI validates supported helpers
and physical frees. Native-only compression/WebSocket helpers remain unavailable
on WASI. Maintain existing coverage and explicit macOS assignments. Require fresh
combined full delivery gates after preparation, not just these focused results.

- Eight balanced-ternary contracts traverse input lists directly and own partial
  result lists. Packing writes result bytes directly. Digit order, widths,
  padding and count behavior stay unchanged.
- Eight text contracts cover URL/form/HTTP-head decoding and scalar helpers.
  HTTP headers are built without line-index/value scratch arrays. Typed fields
  protect copied strings, errors and partially constructed results.
- Six byte contracts cover gzip/deflate, CRC32 and WebSocket parsing/inflation.
  Encoders also protect native output during managed result allocation. Native
  allocator OOM still exits; recoverable fault tests inject managed allocations.
- Five metrics/syntax contracts copy immutable metric snapshots and protect
  rendering buffers. Complete metric names, including NUL, match interpreter
  lookup and sorting. Observation suffixes no longer need a joined-name buffer.
  Registry entries live for the process/library instance and are released on
  library teardown; repeated updates reuse entries, distinct names require space.
- Two CPU tensor contracts borrow inputs and own elementwise results/reduction
  scratch. Workers copy chunks directly into one result array, removing a second
  full-size native output and copy. Workspace remains per worker; reductions
  still use one scalar per 4096-element block. Thread-start failure joins started
  workers before trapping; POSIX no longer silently executes missing workers on
  the caller. Existing explicit worker bounds/WASI single-thread behavior remain.

CPU validation keeps malformed-code/input-size order, immutable aliases/views,
chunk/block boundaries and floating operation order. WASI checks full counts
before 32-bit conversion; omitted-check controls must expose truncation. Native
allocation/worker-failure controls must detect omitted input/output disposal.
The fixed kernel probe uses 8193 F64 values, multiplies each by 0.5, and checks
both output and ordered reduction with one/four requested workers. It records
native requested bytes and managed requests, excluding ledger headers. The
immutable `21a621c6` kernel executor supplies a same-probe tracing-mode baseline,
with collection off; current tracing and ARC are measured separately. This is
an allocation comparison between fwp runtimes, not C/Rust parity or a speed claim.
C source, executables and disassembly are retained for inspection.

## Actual preparation results

`30399066f869f4dc06d15a58c884184fcd0f9d2d` passes all six native jobs in
`38886033175`, including all decoder ownership, Windows web/std-library peers,
ARC execution and library docs. Earlier `72321a55` passes both actual WASI jobs
`38884843627`; the subsequent HTTP/2 socket repair is native-only. Metrics and
CPU kernels were added later and are not covered by those passing runs.

[Intermediate ternary/text evidence](measurements/value-decoders-2026-10-16.json)
at `e912227b` retains all six target artifact sets and exact counts, explicitly
recording neighboring Windows gate failures at that revision. Packing/converting
40 trits needs one result allocation; text cases need 3/7/13/12/6 requests.
Disposal restores initial charged storage. These are not elapsed-time claims.

Validation exposed and repaired these issues:

- A ternary fault fixture decremented a final owner without freeing it. It now
  performs last-owner destruction and checks input/output storage together.
- Added Windows peers lacked native OpenSSL/HTTP2 curl prerequisites. Pinned
  caches, the configured client and portable fixtures now cover both hosts.
- WebSocket mask seeding called a POSIX clock; it now uses `fwp_unix_ns`.
- Native HTTP/2 treated Winsock would-block as closure; receive/final-send loops
  now use existing `fwp_socket_again`. Both Windows peers pass.

The independent gzip fixture uses fixed Python-produced bytes. Windows shutdown
uses targeted console events and a corresponding interpreter handler. No failed
checks are removed. Superseded `38881941135`, `38886468434` and `38886471769` are
confirmed canceled. Incomplete/canceled runs are not acceptance.

Combined source `7c1bd94e` reached passing kernel value/allocation/baseline and
validation-order checks on Intel macOS and Linux ARM64. Its Unix size probe
failed because omitted input cleanup was detected during the first successful
call, before the older expected trap case; the fixture now frees its other
storage and consistently reports the missing owner. WASI ARM64 passed the new
32-bit kernel count controls, but exposed seven live metric registry allocations
at exit. Executables now register registry cleanup on first use; library teardown
keeps its existing cleanup. A WASI negative control omits that registration and
must expose the leak. Fresh combined checks must verify both repairs.

Review also found that the final reduction block can overflow its end or loop
index at the address limit. C and interpreter loops now use the remaining length
before adding. Small native/interpreter/actual-WASI probes evaluate only the last
4095 constant elements; a WASI control restores the wrapped end and must fail.
These checks need CI; no large input or multi-billion-element loop runs locally.

[The combined evidence report](measurements/owned-values-and-kernels-2026-10-16.json)
retains all six native allocation artifact sets at `457f00d3` from `38893386853`.
All kernel, decoder, metrics, web and ordinary-library checks pass there. The two
overall Windows jobs failed only the new unload fixture's export selection; the
four Linux/macOS jobs pass. Windows fixtures now use the same ordinary external
definitions as generated library tests. Focused unload `38894911944` at `234da577`
passes **all six** native hosts, including every deliberate missing-cleanup control.
Runtime sources are unchanged by that repair. Actual WASI `38891578037` at
`c8f4646c` passes **both** hosts, including registry shutdown, count narrowing and
final-block overflow controls. None of this replaces full final-head production.

The Windows unload peer uses LoadLibrary/FreeLibrary, VirtualQuery, native sockets,
fiber deletion, thread-key release and console-handler removal. It verifies task
cancellation, host-owned sockets/fiber state, cached results, wide counts and
metric storage at shared unload and static process exit. POSIX checks remain.
Full Windows CI now includes this test.

For 8193 F64 values multiplied by 0.5, one-worker native temporary requests fall
from three to two and native peak from 69,648 to 4,104 bytes. The result array
remains. All native/charged final deltas are zero; managed/worker-start omission
controls fail as intended. Four-worker peak varies with overlap. Actual retained
ARM64/AMD64 ARC probe binaries contain packed multiply instructions and chunk
copies; they still use arithmetic workspace. No timing, cache, register-only or
C/Rust parity claim is made. Both runtime and repaired test hashes are retained.
Local report/hash verification and six-host assembly inspection each passed under
the guard in 0.13 s; raw artifacts are in `/private/tmp/fwp-owned-values-457`.

The dead arithmetic exception list in `arc.rs` is removed: all 26 entries already
use the shared explicit contract table, checked against the inventory. Full final
production must cover the cleanup and integration with #152's final optimizer.
Superseded failed/incomplete runs are historical evidence, not remaining tasks.

The GC golden suite already uses four workers. No concurrency or coverage change
was made. Published `234da577` adds per-example start/elapsed logging for the next
full production run. Golden interpreter/native tests share fixture paths; any
later scheduling change must preserve isolation. PR #152's ARM macOS stress suite
passed in 832.58 s. Accepted #151's Intel suite took 1228.83 s; these different hosts
are not a before/after speed comparison.

## Local checks and limits

Local checks use the fixed `python3 scripts/local-guard.py` limits: serial,
64 GiB free disk, target data below 2 GiB, aggregate sampled RSS below 1 GiB,
and 180 seconds. Full builds, suites, measurements and evidence run on GitHub.
An earlier local fwp compiler build was refused; never retry it locally.
Automatic approval review also rejected local compilation of the small C size
probe. No such probe executed; it runs in CI, with no local workaround.

| Command after the guard | Latest result |
|---|---|
| Accepted compiler `run --interp tests/fixtures/cpu_kernel_ownership.fwp` | Pass, 0.26 s |
| Accepted compiler `run --interp tests/fixtures/metrics_ownership.fwp` | Pass, 0.25 s |
| `cargo fmt --all` | Pass, 1.13 s |
| Library-doc generator from source comments, before local C rejection | Pass, 0.74 s |
| Primitive inventory with frozen baseline | Pass, 0.96 s; 300 contracts, 43 distinct review symbols |
| `python3 scripts/test-macos-test-shards.py` | Pass, 0.13 s; 226 targets, old assignments unchanged |
| `python3 scripts/check-roadmap.py` | Pass, 2.53 s |

The accepted reference interpreter is `/private/tmp/fwp-148-compiler/fwp-macos-arm64/fwp`.
No local check establishes native support. Unreviewed symbols are mostly
networking, plus exit and GPU execution. Raw pointers, foreign/host callback
retention, mutable cycles and deployment exclusions also remain beyond that count.
JIT is prohibited; the existing OpenCL runtime-build gap is unresolved by CPU work.

Next: finish #152's remaining full production gates and squash merge when all
nine jobs plus docs pass on `c81b0c9f`. Preserve the root workspace's local handoff
edits without adding a commit to that tested PR. Then rebase this preparation's
complete delta after `3577ba37` onto the accepted merge, preserving #152's final
optimizer, formatting preflight and numerical measurements. Resolve docs into one
current handoff, publish the next substantial PR, and require fresh full production
and docs on its final head. Do not rerun completed focused probes without a new
source change, failure or unresolved concern.
