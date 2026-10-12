# Session handoff

Updated 2026-10-12. Read [PLAN](../PLAN.md), [ownership](ownership.md) and
[design](design.md) before changing code. This is the sole live handoff.
[Queue](roadmap-queue.md) preserves immutable anchors; [history](roadmap-history.md)
preserves accepted and superseded evidence. Root docs are authoritative.

Durable recovery branch: `roadmap/handoff-pr123-20261011`. Last verified
checkpoint `b489b06c0cf47e203064666105452260d9c9d940` passes audit38240335790.
Query the branch tip on recovery; an embedded checkpoint cannot identify its
own commit. restore-roadmap-recovery.py restores only temporary paths from a
bounded immutable archive after verifying Git blob hashes. Its runner audit
verifies368 targets/36541095 bytes. Reports are retained in
/private/tmp/fwp-verified-final-ownership-restoration. The active map retains current
ARC/format drafts, phase4 acceptance and complete ec866d57 platform evidence.
Older phase4 and standalone phase5 artifact payloads remain in parent checkpoints;
the current map retains their receipts and current delivery helpers. Prior snapshot79dbf674 failed because
its descriptor omitted version=1; the current repair passes actual restoration.
The previous complete snapshot d00d306d1bac3d731f19769300e659b48cf7c020
(audit38227215868,702 targets/48528910 bytes) retains superseded helpers and
historical source. Restore that immutable head explicitly if they are needed. Current work
uses the designated current-map.json, not an old publisher's next action.
Never rerun completed publishers. Phases1–4 are accepted; phases5–6 remain unfinished.

## Execution contract

Finish the plan automatically, one coherent bundle production PR at a time. The
user requested larger related bundles to reduce testing cycle time. Preserve
all included regression/negative controls; run the full matrix once per final
bundle head. Keep one production PR open at a time. Publication,
repairs and squash merges are authorized across sessions. Fix failing checks;
CI gates merging while independent preparation continues. Preserve the language
semantics and phase order in PLAN. Require all six exact-head jobs and roadmap_docs:
`test`, `bench`, `macos (macos-15)`, `macos (macos-15-intel)`,
`macos_gc (macos-15)`, `macos_gc (macos-15-intel)`. Skipped, queued, cancelled,
superseded or earlier-head runs do not pass a gate. Regular macOS excludes only
the golden GC stress suite; dedicated GC jobs execute it.
The user also authorized the boy scout rule: fix encountered issues and bugs
even outside the current roadmap item. Preserve original controls and record
actual validation; bundle coherent fixes without changing the phase order.

Every entire commit message is one line, at most 80 characters, with no body,
trailers or attribution. Use ordinary author metadata. Squash with an explicit
subject, empty body and exact-head match. Verify the raw resulting message,
one parent and complete-tree parity before updating main.

```sh
gh pr merge NUMBER --squash --subject 'SUBJECT' --body '' --match-head-commit SHA
```

## Main and verified coverage

Main is `59af498c32689dc4928e3681eb90dd453d8e57ce` (PR #127), merged2026-10-12T10:43:08Z.
Exact tested head8eb13370945b491cced1263ced290192e903acbb passes all six jobs in
CI38231014878 and roadmap_docs38231014937. Signed squash subject
`Fuse numerical pipelines and reuse autodiff workspaces` is one line,54 characters,
with no body or trailers. Its sole parent is3a4582368f987ddb0233086be50c47995eb4ed3f;
complete tree8f5e908c8dc2a0ff60976e204d46260a27f7ee79 matches the tested head.
Actual merged-source audit38238135536 passes at drivera8483d40c7e4ed95831b39f36d67b3e563dc6f78.
Hash-verified reports: /private/tmp/fwp-accepted-numerical-source. Merge and gate
proofs: fwp-numerical-merge-proof.json and fwp-numerical-final-gate-proof.json.
Duplicate main CI38238081009 is completed/cancelled after complete-tree
parity and actual source acceptance.
Cancellation supplies no additional passing gate.
Main roadmap_docs38238081051 passes.
Local checkout remains68f959bbf28cfc00ed91a9f4c6dd6836020ff2a4.

Phases1–4 are accepted. Phase2 retains the explicit tracing compatibility model:
375 declarations,168 ownership contracts,19 IR combinators,11 flat signatures,
and177 fallback declarations/167 symbols. Phase3 adds natural1/2/4-byte numeric
payloads, bounded backing-owner views, concrete scalar/record worker ABI and
checked protocol/count paths. Storage and ABI preserve exact float bits;
arithmetic NaN payload choices retain the existing compiler contract. F16/BF16
and128-bit formats keep their documented existing representations. This does
not establish tracing-free execution or a timing improvement.
Original ownership, binary representation, omission, GC stress, reuse, actual
wasm32 count and platform controls pass. Completed sources, failure repairs and
measurements are archived in history; they no longer supply next actions.

## Remaining ownership deliveries

Queue33 and35–112 are accepted;34 is a verified duplicate. No resource ownership
preparation remains open. Phase6 must establish tracing-free eligibility and a
supported cycle policy; retain explicit compatibility fallbacks until then.

## Local checks and recovery

Full builds/tests, benchmarks and large regeneration run on GitHub. Local
workloads are serial, low priority and guarded: sampled aggregate RSS below1GiB,
target below2GiB, at least64GiB free disk, deadline180 seconds. Stop at limits;
never raise or bypass them. Use `python3 scripts/local-guard.py COMMAND...` for
fwp checks. The fun-refactor guard applies to that other repository.
Latest disk observation:56,620,208KiB available, about54.0GiB; last local target
103,696KiB, about101.3MiB. The64GiB reserve remains unavailable. No local compiled
check, broad doc audit, rebase or fast-forward ran. Only source edits and bounded
remote metadata publication/downloads ran serially at low priority.

Protect all11 authoritative docs before any guarded main fast-forward:
CONTRIBUTING.md, PLAN.md, docs/design.md, docs/development-state.md,
docs/ownership.md, docs/primitive-ownership.md, docs/roadmap-queue.md,
docs/roadmap-history.md, docs/reference.md, docs/concurrency.md, docs/numerics.md.
Actual pre-acceptance hashed backup: /private/tmp/fwp-main-docs-remote-pre123.
Do not claim a local fast-forward or byte-for-byte restore that did not run.
Preserve other user changes. Last Rust checkout was
/private/tmp/fwp-library-resource-bundle-worktree; source identities require
guarded cleaning before switching compiled checkouts when resources permit.
Immutable tags, remote source heads and retained receipt hashes survive temporary
file loss. Never treat an earlier head, skipped check or source snapshot as a
passing production gate.

The duplicate main matrix38214091518 was cancelled after all seven pre-merge
gates, complete-tree parity and actual merged-source acceptance were verified.
Its status is retained in fwp-main126-duplicate-ci-status.json; cancellation
is not recorded as a passing main run. Earlier checkpoint and preparation
instructions are historical; use the current checkpoint and active bundle.

## Active phases5–6 bundle

Phase4 is accepted on main. Its original numerical, AD, reuse, GC stress, library,
WASI and allocation controls pass the full production matrix and merged-source
audit. Measurements remain in docs/measurements/numerical-kernels-2026-10-12.json.
Prior preparation and repair details are preserved in history.

Separate phase5 preparation: independently owned loop-state fields remove
per-element retains/releases; typed scalar calls and bounded Array reads avoid
unnecessary unwind registration; generated immutable descriptors eliminate
runtime width dispatch in the measured F64 loop. The checked-index scope remains.
Latest standalone headc600a9343283c975be018ba59c40c7d0068d161e passes all three
jobs in38229158359. Reports, formatted sources and actual binary disassembly:
/private/tmp/fwp-const-descriptors-platform-evidence. The current ARC branch also
contains the scalar-borrow production repair and these phase5 changes.
Eight65537-element rounds retain/release zero times and reclaim all charged
storage with zero collections. Timings vary across shared runners; zero counts
and smaller dispatch do not establish C/Rust parity or a universal speedup.
Earlier preparation and instrumentation repairs are preserved in history.

## Phase6 preparation

Current branch ownership-evidence-tracing-free:
350500f2cbbfccbde57dbd85e9fb855e13088e7d, run38242709162 pending.
Explicit --gc arc checks native-main monomorphic types, native declaration
provenance and primitive ownership contracts after ownership lowering.
Unproved mutable/cyclic graphs, raw tape/pointers, boxed I128/U128, custom native
signatures and foreign/deployment boundaries diagnose. The collector body is
excluded; physical reclamation and forced-collection controls are required.

Baseline ec866d572f68e68c746992d55a7f75ff88188644 passes all three complete
jobs in38237738284:71 corpus entries,21 executions,47 explicit rejections and
3 expected front-end errors. It includes direct-buffer formatting cleanup,
typed aggregate inlining, original deep recursion plus a bounded raw-interpreter
control, all numerical/AD/reuse regressions and platform measurements.
Retained evidence: /private/tmp/fwp-complete-ownership-platform-baseline and
/private/tmp/fwp-complete-arc-platform-baseline. Prior failures are in history.

Post-lowering check a2500e0f passes CI38239726785 but reduces actual executions
to17: basics, comptime, fusion_iter and fusion_lists acquire unknown temporary
types. This is a coverage regression, not acceptance. Its Linux corpus and
artifact proof are fwp-lowered-arc-linux-corpus.txt and its -proof.json.
Head2d4bf66a registers synthesized Step variant fields where fusion creates
them and adds a permanent named regression for all21 prior executions. Linux
and ARM in38242127912 restore the three fused cases but fail on comptime;
Intel was superseded. Retained counted IR identifies an inlined compile-time
record whose parameter type was discarded. Current350500f2 preserves typed
bindings for aggregate constants as well as constructed aggregates. The full
three-platform workflow is restored; temporary IR diagnostics are removed.
Receipts: fwp-arc-step-types-publication.json and fwp-arc-constant-types-publication.json.
Failure IR/report/proof: /private/tmp/fwp-arc-step-type-failure. Keep the
post-lowering check and all21 named eligibility controls before acceptance.

## Final delivery procedure

After all three current preparation jobs pass, retain both artifact families with
fwp-download-complete-ownership-platform.py and fwp-download-complete-arc-platform.py.
These must target the latest successful head before use. The first verifies identical formatted source; the second retains actual ARC
binaries' disassembly and the complete corpus classification. These helpers are
prepared, not completed. Build the final measurement report from actual artifacts.
The source map fwp-ownership-production-files.json and publisher
fwp-publish-ownership-production.py target checked-arc-and-loop-ownership, based
on accepted main59af498c. They preserve original reuse and ownership controls.
Include AGENTS.md along with the11 other live docs; do not revert its new explicit
design constraints. This next PR bundles phases5–6. It is not yet published.
Require all six exact-head jobs and roadmap_docs before fwp-merge-ownership-bundle.py.
Then run the prepared ownership merged-source audit publisher/downloader and
update the plan to Done only after actual acceptance. Keep final source support
and deliberately rejected ARC boundaries explicit. No additional feature phase
remains after this bundle satisfies its acceptance criteria.
