# Session handoff

Updated 2026-10-13. Deliver all ten tasks in [PLAN](../PLAN.md) together in
[PR #132](https://github.com/e6qu/fun-with-pipes/pull/132), branch
`roadmap-status-audit`. Publication and squash merge are already authorized.
Require seven production jobs plus docs on the final PR head, then merge with
one explicitly supplied subject of at most 80 characters and an empty body.
No trailers or attribution. Fix failures; queued CI gates merging, not work.

Linux/macOS on ARM64 and AMD64 are the active platforms, one binary per pair.
Windows remains desired but deferred. Preserve pipe syntax, types, effects,
checked arithmetic and evaluation/trap order. [Design](design.md) and
[ownership](ownership.md) specify the current implementation and its limits.

## Accepted baseline

Main at task start: `8ae361a43f7634bf818ec8415d8c1ea95fdb74ed`, PR #131.
Its six production gates establish the earlier delivery, not this bundle.
[History](roadmap-history.md) retains exact heads, trees and gates;
[the immutable queue](roadmap-queue.md) is completed preparation evidence.
Do not repeat those deliveries or old publishers.

## Bundle implementation

| Task | Implementation and verification |
|---|---|
| 1 Docs | Current plan/handoff separated from immutable evidence; stale classifications and duplicate next actions removed |
| 2 Linux ARM64 | Full native runner added; first baseline completed all targets with one omission-control failure, being fixed below |
| 3 Binaries | Four per-platform compiler packages; ELF/Mach-O architecture and copied compiler/interpreter/generated tracing/ARC smoke checks outside checkout |
| 4 Measurements | Dynamic-input, paired current-compiler controls, allocations/retains/live bytes, process timings, generated C and native instructions |
| 5 Callback dispatch | Direct iterator callbacks and known run-state callbacks specialize; measured consumer dispatch removed |
| 6 Loop allocation | Fused loop state flattens into locals; generated-C controls reject per-step state records; actual ARM/AMD instructions inspected |
| 7 Fusion | Direct fold/each/find consumers share lazy pipeline fusion; raw interpreter, early stop, callback failure, state and GC/reuse controls pass focused gates |
| 8 Reconstructed trees | CSV builds counted nested strings/lists with pending-field/row/scratch cleanup; normal and injected partial-trap omission controls pass |
| 9 Wide integers | I128/U128 counted leaves, arithmetic and alias/aggregate ownership; discarded overflowing-result box fixed; portable signed multiplication validated on Linux ARM |
| 10 Scoped AD | Finite closure-flow scope proof; return/escape/trap/cancellation controls; ARC cold/warm workspace counts and bounded cache |

## Remaining ownership deliveries

All ten implementations are in this bundle; final production acceptance remains.
The original six-phase queue is closed. I128/U128 remain boxed. CSV decode,
JSON/protocol reconstruction, unproved runtime graphs/cycles, foreign boundaries
and ambiguous/unscoped AD calls remain outside checked ARC. Lazy producers still
allocate and dispatch; State update callbacks can still dispatch. No universal
zero-allocation, register-placement or C/Rust speed claim is made.

## Actual validation and fixes

- Baseline CI 38365626793 at `c9a86c6` predates compiler changes. Benchmark and
  both macOS ARM jobs pass. Intel regular tests and package smoke pass, but its
  package upload fails with GitHub artifact DNS ENOTFOUND: that job is failed.
  Native Linux ARM completes with one HTTP/2 omission-control failure; all other
  targets pass. Linux AMD64 and Intel GC also passed; the two failures above are the final baseline result.
- Focused 38367368626 exposed a 2,064-byte wide overflowing-arithmetic leak and
  an obsolete blanket wide-integer rejection test; both were fixed.
- Focused 38369225440 at `ba69a3e` verifies CSV normal/partial cleanup, wide
  reclamation and scoped gradients. Its returned-callback rejection fixture
  was ill-typed; corrected before the next run.
- Focused 38370736725 at `6feb659` passes Linux AMD64 and both macOS jobs,
  including the golden ARC corpus and ARC scope/workspace controls. Linux ARM
  finds Clang/libgcc missing __muloti4. Signed multiplication now checks unsigned
  magnitudes, including MIN/MAX and both signs, without an extra runtime library.
- Focused 38372305868 at `f845fe4` passes both Linux jobs and macOS ARM;
  Intel also passes: all four focused platform jobs are successful.
- Latest published head `2446c9010ae9bc239fc3bc9438302c01606a8ed8`, focused
  run 38373379103, extends the HTTP/2 isolated-construction/register-clearing
  control to AArch64. Both Linux jobs (including Clang/GCC controls) and macOS
  ARM pass; Intel is still running at this checkpoint.

The HTTP/2 omission control accidentally kept a dead owner pointer in a
callee-saved register under native ARM GCC. Its positive owner fence remains;
the missing-fence control must still fail. This is a test-reliability fix,
not permission to skip GC or native platform checks.

The [permanent four-platform report](measurements/native-ownership-2026-10-13.json)
records head `f845fe4f6c33a1666267d184a9f833d12c7d9f05`, run 38372305868,
compiler/hardware/flags, generated C and native instruction hashes, scope control
statuses and eight workspace profiles per platform. Paired 1,000-element
allocation counts agree on all four platforms:
fold 6,005→4,003; stateful each 7,009→4,006; find 142→113; map/filter/fold
9,511→4,003. Producer allocations remain. ARM instructions use checked register
adds/overflow branches; AMD64 uses add/jo. Process timings include startup and
output. ARC workspace reuse needs zero new native buffer allocations on warm
129/257-leaf gradients, one managed result array, and at most 512 KiB retained
cache. Oversized workspaces and final teardown release their buffers.

Local checks use `python3 scripts/local-guard.py` only. Docs audit passes
44 link sets, 106 immutable queue pairs/tags, no old live rows and commit
subjects (0.31s CPU / 2.67s elapsed). Python syntax, rustfmt, whitespace and
workflow YAML parsing pass; generated-loop assertions pass against all four
paired Linux AMD64 C probes. Full builds/suites/regeneration stay on runners.
Local resource limits are unchanged.

## Delivery acceptance and next action

The final revision includes wide-integer escaping-capture and caught-error
cleanup controls, the four-platform evidence record, and current documentation.
All ten implementations are present. Full production validation is required
before claiming this bundle accepted; a preflight or older baseline is not enough.
[PR #132](https://github.com/e6qu/fun-with-pipes/pull/132) is the live acceptance
record for the final head and merge. Check its current head and all jobs directly.

If the PR is open, fix any failed gate and rerun affected checks. Require both
Linux jobs, bench, regular and GC ARM/Intel macOS, and documentation on the exact
final head; then squash-merge with an explicit one-line subject ≤80 characters
and empty body. Verify the merged tree matches the tested head and the entire
commit message has no body/trailers. If the PR is already merged with those
proofs, this ten-task bundle is complete: do not reopen it or old preparation
branches. Windows and other deferred boundaries need a new scope decision.
