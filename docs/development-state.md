# Current work

**Next:** audit the running weak-operation timing comparison on Linux
ARM64/AMD64 while preparing callback-service costs and parser allocator-internal
memory observations. Keep this substantial batch in
[PR #273](https://github.com/e6qu/fun-with-pipes/pull/273). Milestone 4 is incomplete;
do not merge an interim green head.

Worktree: `.worktrees/recording-capacity-gate`. Preparation branch:
`ownership-buffer-review`. PR branch: `ownership-peer-comparisons`, currently
`b06a2b6fe20f2842f5b9c9a3bb4e00be0278f011`. Integrate the complete preparation
batch into #273 before its final production matrix. There is no separate prep PR.
Preserve unrelated root-worktree changes and modified inactive handoffs.

## Roadmap status

| Step | Status | Delivered | Remaining |
|---|---|---|---|
| 1 | In progress | #270 docs and fresh F64 stores | Original AMD timing acceptance |
| 2 | In progress | #271 captured maps and empty-owner transfer | Original noisy timing acceptance |
| 3 | In progress | #272 structured gradients and known callbacks; all delivery gates | Original AMD timing acceptance |
| 4 | In progress | Buffers: correctness, phases, native storage, timings/RSS; Swift closures; weak phases, queued cleanup, native storage and actual reuse | Parser internal memory boundaries; weak-operation and service costs |
| 5 | Pending | Existing tools and correctness tests | Three applications, compiler phase/scaling costs and sustained load |

Keep original failed/noisy timing controls. Fewer operations or smaller images
do not establish runtime acceptance. Do not rerun unchanged samples to qualify.

## Verified compiler repair

[The first parser-memory run](measurements/parser-entry-cleanup-2026-11-09/README.md)
failed all 20 fwp observations per host. The consuming region worker released its
input, then the generated owning entry released it again. C/Rust observations,
eight interpreter results and native storage/frame controls passed.

The repair uses `rc::consumes_arg` for owning-entry cleanup, sharing the direct-call
contract across all body variants. Native/WASI regressions now exercise direct
and owning entries, surviving aliases, allocation failures and parse errors at
O1/O2; an actual extra-drop fault restores the bug. The measurement harness now
separates cleanup, alias, node-count and result errors. Its original wrong-result
controls could mask cleanup failure and are not accepted as result evidence.

The focused workflow adds `parser_workspace` and the frozen primitive inventory.
It keeps all RSS/checkpoint and storage/frame checks, adds 48 invalid fwp arguments
and requires five evidence corruptions to fail. Repair source `ee30d13b0` is frozen as
`roadmap/parser-process-memory-owned-entry-2026-11-09`: run `42645911091`,
AMD64 job `129258996498`, ARM64 job `129258997285`, both pass. Docs
`42645917282` / `129259006921` also passes. The six parser tests, full memory
observations and all corruption controls pass on both hosts; other production
platforms still need the final matrix. Full compiler/production validation remains on GitHub.

## Reviewed CI

| Batch | Frozen source | Run / AMD64 job / ARM64 job | Status |
|---|---|---|---|
| Original parser memory | `8848e837c` | `42631160983` / `129207526319` / `129207526124` | Failed; root cause above, original records retained |
| Repaired parser memory | `ee30d13b0` | `42645911091` / `129258996498` / `129258997285` | Passed |
| Weak phases, minimal Swift repair and diagnosis | `8848e837c` | `42631166444` / `129207545716` / `129207545782` | Passed |
| Native weak-storage prefixes | `2470f2a94` | `42635657945` / `129223014018` / `129223014753` | Passed |
| Actual target reuse | `63accd105` | `42639145010` / `129235261160` / `129235261107` | Passed |
| Documentation/readers | `8848e837c`, `2470f2a94` | `42631171172` / `129207557246`; `42635673348` / `129223066100` | Passed |

[Weak results and full logs](measurements/weak-operation-verification-2026-11-09/README.md)
retain sources, artifacts and per-host counts. C/Rust/Swift request 16/24/24 target
bytes, respectively; C/Swift request separate 16/32-byte weak storage. Rust retains
its backing allocation after target destruction. All release it after the final
weak owner. C/Swift reuse all 1,024 target addresses in each ordinary reuse build;
Rust observes zero reuse while its weak owner retains the backing. No ARC count
or weak timing result is claimed.

Earlier superseded queued runs executed no tests. Immutable tags remain; do not
restart unchanged jobs or infer a billing problem from queue delays. Setup's
optional manual-page and libtool relink notices are retained. Documentation's
intentional failed/hung runner controls pass their parent tests.

## Prepared timing collection

[Weak timing](measurements/weak-operation-time.md) uses four population/lookup
cases, the existing separate modules, a C-only capped duration pilot, two sessions,
16 balanced rounds of identical executable pairs, per-phase 5 ms/2% controls,
RSS and compiler/image costs. Six altered-evidence controls check reconstruction.
The same-source phase correctness batch must pass before collecting timings.
Source `031e6f794` is frozen as `roadmap/weak-operation-time-2026-11-09`.
Run `42647816522`: AMD64 `129265753017`, ARM64 `129265753053`; both queued.
Docs `42647826087` / `129265780239` is queued. No new speed claim. The shared strict phase
reader moved from the checker to `weak_operation_phases.py`, without changing its
result contract. Three timing-reader and three existing result-reader tests pass.

A related [managed-allocation census](measurements/weak-operation-census.md) is
prepared: six phases plus successful `Some` result-cell attribution, known real
17/33-byte allocations, an extra-allocation control and an omitted free. Eight
ordinary observations and eight controls are required on each host at O1/O2.
Three reader tests pass. A guarded Apple Clang O2 check on retained source
`8848e837c` observes 1,024 16-byte `Some` cells for 64×16 live lookups, none for
expired lookups, and rejects actual extra allocation/omitted free. It is not a
rebuilt-compiler or GCC pass. Native source `54b818abc` is frozen as
`roadmap/weak-operation-census-2026-11-09`: run `42651550496`, AMD64 job
`129278956168`, ARM64 job `129278955989`, both queued. Docs `42651562531` /
`129278986150` is queued. This fills the
parent comparison's result-cell attribution requirement without changing the
queued timing source or claiming native backing bytes/ARC counts.

[The callback-service specification](measurements/weak-callback-service.md) now
fixes two queue sizes, 16-integer payloads, four success/cancellation/expiration/
handled-error cases and independent receiving counts/checksums. Implement its
ordinary fwp/C/Rust/Swift programs and missing-delivery/release controls next;
freeze final repetitions only after those checks pass. It is not yet code or a
measured service-throughput result.

## Other evidence and unresolved measurements

- [Buffer phases/native storage](measurements/returned-buffer-phases-2026-11-09/README.md):
  source `ec9313228`, runs `42600727564` and `42600729662`, both hosts pass.
- [Buffer timings/RSS](measurements/returned-buffer-time-2026-11-09/README.md):
  source `b37b15ac2`, run `42602375928`, both sessions and audits pass. Qualified
  ARM64 results show slower large-buffer reads despite some lower process times;
  empty-array churn is costly. Many AMD64 copy controls fail and remain inconclusive.
- [Ownership scope](measurements/ownership-peers.md): native requested bytes,
  fwp managed bytes, mappings and RSS remain distinct. Maximum stack use and ARC
  operation counts are unmeasured. Parser allocator-internal peaks and committed
  memory remain unresolved; [the next observer steps](measurements/parser-internal-memory.md)
  require matching libc/source identity and actual path/accounting controls. These are not completed by endpoint snapshots.

## Delivery and local checks

[Earlier head `7645384bb`](measurements/ownership-peer-gates-2026-11-09/README.md)
passes nine production jobs (`42578853160`), docs (`129032587978`) and full-log audit
(`42590693699`/`129071304611`). These do not verify later heads. Final integration
requires all nine jobs, docs and full-log audit at the exact commit.

Free space recovered to about 145 GiB. Focused checks use the unchanged
`python3 scripts/local-guard.py` limits; full builds/profiles stay on GitHub.

- Parser reader: eight pass, one explicitly Linux-only `/proc` test skipped on
  macOS. Both Linux batches execute that actual checkpoint test.
- Weak phase/profile/reuse readers: 3/4/3 pass.
- Repair Python syntax checks and Rust formatting: pass. Documentation audit:
  417 link sets, 106 immutable preparation pairs and five roadmap steps pass.
- Apple Clang O2 source diagnostic: original generated entry frees the caller's
  32-byte input early; removing only duplicate entry cleanup preserves it until
  caller release. This is not a rebuilt-compiler or Linux GCC pass.
- Retained selected reports and complete job logs with compressed/raw hashes.

The guard needed process-monitoring access because sandboxed `ps` was unavailable;
no limit was raised or bypassed. Keep bounded artifact reads and runner-side
large audits. The numerical dispatcher must remain below GitHub's 512,000-byte limit.

User-merged #272 is `32d643d0a3e29c25a55d9b05c5492c0ab73e7c20`, tree-equal to
verified `8e7cdb94337c6fdac5656dfcbdab768d4a36e985`, with a compliant one-line
message. [Delivery receipt](measurements/structured-callback-delivery-2026-11-09/README.md).
