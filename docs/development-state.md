# Current work

**Next:** audit every result from the parser-memory and weak-operation batches;
fix all failed independent groups together. Keep the work in
[PR #273](https://github.com/e6qu/fun-with-pipes/pull/273). Milestone 4 is incomplete;
do not merge an interim green head.

Worktree: `.worktrees/recording-capacity-gate`. Preparation branch:
`ownership-buffer-review`. PR branch: `ownership-peer-comparisons`, currently
`b06a2b6fe20f2842f5b9c9a3bb4e00be0278f011`. The preparation branch has no separate
PR. Integrate this complete batch into #273 before its final production matrix.
Preserve unrelated root-worktree changes and modified inactive handoffs.

## Roadmap status

| Step | Status | Delivered | Remaining |
|---|---|---|---|
| 1 | In progress | #270 documentation refresh and fresh F64 stores | Original AMD timing acceptance |
| 2 | In progress | #271 captured maps and empty-owner transfer | Original noisy timing acceptance |
| 3 | In progress | #272 structured gradients and known callbacks; all delivery gates | Original AMD timing acceptance |
| 4 | In progress | Buffer correctness/phases/native storage/timings; Swift scalar allocations; weak cancellation/error checks; parser allocation/frame checks | Queued repair/phase verification, weak-operation/service costs and native storage/reuse, parser memory boundaries |
| 5 | Pending | Existing tools and correctness tests | Three application paths, compiler phase/scaling costs and sustained load |

Keep original failed/noisy timing controls. Fewer operations or smaller images
do not establish runtime acceptance. Do not rerun unchanged samples to qualify.

## Pending verification

| Batch | Frozen source / tag | Native jobs | Status |
|---|---|---|---|
| Parser memory and argument repair | `8848e837c`, `roadmap/parser-process-memory-combined-2026-11-09` | Run `42631160983`: AMD64 `129207526319`, ARM64 `129207526124` | Queued |
| Weak phases, minimal Swift repair and original-assertion diagnosis | `8848e837c`, `roadmap/weak-operation-combined-2026-11-09` | Run `42631166444`: AMD64 `129207545716`, ARM64 `129207545782` | Queued |
| Documentation and reader controls | `8848e837c` | Run `42631171172`, job `129207557246` | Queued |
| Native weak-storage prefixes | `2470f2a94`, `roadmap/weak-operation-storage-2026-11-09` | Run `42635657945`: AMD64 `129223014018`, ARM64 `129223014753` | Queued |
| Storage documentation and reader controls | `2470f2a94` | Run `42635673348`, job `129223066100` | Queued |
| Actual native target reuse | `63accd105`, `roadmap/weak-operation-reuse-2026-11-09` | Run `42639145010`: AMD64 `129235261160`, ARM64 `129235261107` | Queued |

- [Parser batch](measurements/parser-process-memory.md): one parse per process,
  three ordinary RSS observations and two five-checkpoint sequences per case and
  language. Actual missing-touch/unmap, wrong-result and evidence-corruption
  controls verify the observer. C argument parsing now rejects partial numbers,
  negative counts and overflow; 96 native controls cover the repair. Timeouts
  retain partial output. No memory result is claimed yet.
- [Weak batch](measurements/weak-operation-phases.md): current fwp owned entries
  and separate C/Rust/Swift modules; six phases, independent live/expired counts,
  bad clocks and omitted releases. Expected completion: 36 builds, 252 native
  checks and two interpreter checks. No new timing or allocator/ARC result.
- [Swift failure](measurements/weak-queued-cleanup-2026-11-09/README.md): original
  assertions trap at line 146 after clearing the owner. Cancellation-only lifetime
  extension passes on both architectures, with and without debug information;
  lookup-only changes fail. The combined batch preserves the original filename
  and assertions. It must also pass the actual C/Rust/Swift queued cleanup checks.

Superseded while still queued, before tests: `42615022531`, `42615026734`,
`42620659615`, `42620663788`, `42622048974`, `42622044846`, `42624102561`,
`42624107549`, `42627467268`. The last four have zero executed steps in GitHub's
completed records. Their immutable tags remain.
Cancellation is not a pass. The earlier assertion-wrapper-only Swift pass is
not accepted as a repair; original failures and source comparisons are retained.

The combined source rejects booleans masquerading as integer counts, duplicate
JSON fields, malformed objects, negative counters and inconsistent parser phase
totals. It also explicitly matches the production C driver's `-ffp-contract=off`
setting. The six-phase workloads use integer operations. Both changes are covered
by the consolidated verification; no passing result is claimed yet.

Prepared in the same PR: [native weak storage](measurements/weak-operation-storage.md).
The collector uses the existing C/Rust/Swift operation modules, four explicit
lifetime prefixes, actual omitted owners and raw-stack reconstruction. Expected:
three binaries, 24 ordinary results and 48 profiles per host. Native execution is
queued at `2470f2a94`. Keep the earlier queued sources unchanged; this addition does not
establish a new timing, storage or ARC result.

Address-reuse preparation also uses the same native C/Rust/Swift operations:
save an integer target address, release the target, then inspect only live
replacement addresses and weak lookup results. Require actual C/Swift reuse,
Rust's retained-backing exclusion, and rejection of a real replacement-link
control. Expected: 12 builds and 18 native checks per host. Native execution is
queued at `63accd105`; the earlier fixture's 64 replacements did not prove reuse.

The queue has no explanatory annotations or assigned runners. These workflows
have no concurrency lock or environment approval. A separate older 146-job
workflow occupied runners during review and has since ended; that does not
establish the cause of the remaining delay. GitHub's status page reported Actions
operational. Do not infer a billing restriction or restart unchanged jobs.

## Verified comparison evidence

| Evidence | Source | Native runs |
|---|---|---|
| [Matched four-language buffers](measurements/four-language-buffers-2026-11-09/README.md) | `9850a0fda` | `42579398196`, both pass |
| [Scalar Swift allocations](measurements/swift-scalar-closures-2026-11-09/README.md) | `96e2bf43a` | `42580332788`, both pass; original ARM setup failure retained |
| [Weak callback errors](measurements/weak-callback-errors-2026-11-09/README.md) | `9a7f1baaf` | `42584848642`, both pass |
| [Returned-buffer ownership](measurements/returned-buffer-checks-2026-11-09/README.md) | `9d8bbb79a` | `42590570921`, both pass |
| [Buffer phases/native storage](measurements/returned-buffer-phases-2026-11-09/README.md) | `ec9313228` | `42600727564` phases and `42600729662` profiles/audits, both pass |
| [Buffer timings/RSS](measurements/returned-buffer-time-2026-11-09/README.md) | `b37b15ac2` | `42602375928`, both sessions/audits pass; noisy comparisons remain inconclusive |
| [Parser transitions/frames](measurements/ownership-peer-checks-2026-11-08/README.md) | `4c6cda41f` | `42522747197`, both pass |

The buffer reports retain initial Rust link and allocation-attribution failures,
their verified repairs, full logs and archive audits. Qualified ARM64 results
show slower large-buffer reads despite some lower process times; empty-array
churn remains costly. Many AMD64 copy controls fail. Native allocation requests,
fwp managed bytes, virtual mappings and RSS remain distinct. Maximum stack use
and ARC-operation counts are unmeasured. Parser allocator-internal transient
peaks and committed memory remain unresolved.

## Delivery and resources

[Earlier head `7645384bb`](measurements/ownership-peer-gates-2026-11-09/README.md)
passes all nine production jobs (`42578853160`), docs (`129032587978`) and full-log
audit (`42590693699`/`129071304611`). These do not verify later heads. Final
integration requires all nine jobs, docs and full-log audit at the exact commit.

The cancellation-packaging repair preserves partial evidence and skips only a
cancelled job with no evidence directory; ordinary missing/invalid evidence
fails. Its original invalid workflow expression and all 27 passing status/input
controls remain in that receipt. Docs `42606196247` passes 410 link sets and 106
preparation pairs after restoring the handoff's required Status column.

Free space recovered to about 145 GiB. Full builds/profiles remain on GitHub.
Focused local checks use `python3 scripts/local-guard.py` with unchanged limits:

- `python3 scripts/test-parser-process-memory.py`: eight pass; the actual Linux
  `/proc` checkpoint test is explicitly Linux-only. The first local run exposed
  its missing platform declaration; a portable timeout/reaping test now also
  passes. Linux CI must still execute the real checkpoint test.
- `python3 scripts/test-weak-operation-phases.py`: three pass.
- `python3 scripts/test-weak-operation-profiles.py`: four pass.
- `python3 scripts/test-weak-operation-reuse.py`: three pass; reuse collector,
  reader and updated builder syntax checks also pass.
- Python syntax compilation of the new collector, storage reader, tests and
  updated build/caller modules: pass. These are not native compiler checks.
- `python3 scripts/check-roadmap.py`: 413 document link sets, 106 immutable
  preparation pairs and all five roadmap steps pass; commit messages pass.

The first sandboxed guard invocation could not inspect `ps`; the same guard
passed with process-monitoring access. No resource limit was raised or bypassed.
Keep bounded report reads and runner-side large archive audits. Ownership and
parser jobs use reusable workflows; keep the numerical dispatcher below
GitHub's 512,000-byte limit.

The user merged #272 as `32d643d0a3e29c25a55d9b05c5492c0ab73e7c20`. Its tree equals
tested `8e7cdb94337c6fdac5656dfcbdab768d4a36e985`; its one-line message follows the
rule. [Delivery receipt](measurements/structured-callback-delivery-2026-11-09/README.md).
The duplicate merge run was cancelled after verifying tree equality and logs.
