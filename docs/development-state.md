# Session handoff

Updated 2026-10-12. Read [PLAN](../PLAN.md), [design](design.md) and
[ownership](ownership.md). This is the live handoff. [History](roadmap-history.md)
preserves prior evidence; the immutable [queue](roadmap-queue.md) supplies no
competing next actions.

Durable recovery branch: `roadmap/handoff-pr123-20261011`. Last verified
checkpoint `612b9dff7e72ea87ef7b34d222ce5104623fd919` passes audit38255322347.
Actual bounded restoration verifies473 targets/41668682 bytes; reports are in
/private/tmp/fwp-verified-aggregate-alias-restoration. Query the branch tip on
recovery: an embedded checkpoint cannot identify its own commit. Use
current-map.json and its designated publisher. Never rerun completed publishers.
Superseded payloads remain in immutable parents. Restore temporary files only
through the hash-checking restore-roadmap-recovery.py procedure.

## Execution contract

Complete the authorized roadmap automatically, one coherent production PR at a
time. Bundle related changes, fix encountered failures and preserve original
regression controls. Queued CI gates merging, not independent work. Require all
six exact-head jobs and roadmap_docs: test, bench, macos (macos-15),
macos (macos-15-intel), macos_gc (macos-15), macos_gc (macos-15-intel).
Skipped, superseded and cancelled runs pass no gate. Every complete commit
message must be one line, at most80 characters, without body or trailers.
Squash with an explicit subject, empty body and exact-head match; verify the
signed message, one parent and complete-tree parity. Authorization covers
publication, PR creation, fixes and these merges across sessions.

Preserve the Pipe semantics in PLAN. Avoid needless wrappers/fallbacks, magic
and unnecessary implicit behavior/defaults. Register spills are ordinary
lowering; protocol-defined alternatives are peers. No new surface ownership
syntax, deployment interface or compiler backend is authorized by this roadmap.

## Accepted main

Main is59af498c32689dc4928e3681eb90dd453d8e57ce (PR #127).
Tested head8eb13370945b491cced1263ced290192e903acbb passes all six jobs in
CI38231014878 and roadmap_docs38231014937. The signed one-line squash,
`Fuse numerical pipelines and reuse autodiff workspaces`, has54 characters.
Its parent is3a4582368f987ddb0233086be50c47995eb4ed3f and its complete tested
tree is8f5e908c8dc2a0ff60976e204d46260a27f7ee79. Actual merged-source
acceptance38238135536 passes at drivera8483d40c7e4ed95831b39f36d67b3e563dc6f78.
Proofs: fwp-numerical-{final-gate-proof,merge-proof}.json and
/private/tmp/fwp-accepted-numerical-source. Duplicate main CI38238081009 is
completed/cancelled after tree parity and source acceptance; docs38238081051
passes. Cancellation supplies no additional passing gate.

Phases1–4 are accepted: native macOS ARM/Intel, runtime ownership contracts,
natural-width numeric storage and views, typed worker ABI, fused numerical
loops, blocked matrices and bounded reusable autodiff workspaces. Measurements
are in docs/measurements/numerical-kernels-2026-10-12.json. Earlier deliveries
and their limits are preserved in history and the ownership contract.

## Active PR and repair

PR #128, checked-arc-and-loop-ownership, delivers phases5–6. Current head
4ecc9b198a9362a23e50a943732e7a0dc5c03010 includes the verified aggregate
repair and streamlined docs. Full exact-head CI38256949765 is running; roadmap_docs38256949763 passes.
The repair publisher is complete; do not rerun it. The updated primary receipt
is fwp-ownership-production-publication.json; the initial receipt is preserved
as fwp-ownership-production-initial-publication.json. Its initial head
82d552c48663c28d05543313fa91e05b8c327b14 fails CI38244684931. All three
regular jobs fail only stack::variants_returned_as_structs_are_not_allocated:
24.3MiB with FWP_VRET both0 and1. Bench, both GC-stress jobs and
roadmap_docs38244684891 pass. Complete failure logs and hashes are in
fwp-pr128-initial-ci-failures.json. This head cannot merge.
The initial publisher is complete; do not rerun fwp-publish-ownership-production.py.
Receipt: fwp-ownership-production-publication.json.

Current repair preparation: ownership-evidence-variant-return-repair at
11f9bb7555b000bbd2a16f03dd46741f14075953, run38255456223. All three
complete jobs pass. The downloaded formatted sources agree across platforms;
each preserves21 ARC executions/47 rejections/3 expected compiler errors and
24.3MiB disabled versus0.0MiB rounded enabled variant allocations.
Typed aggregate bindings preserve ownership context but exposed two lowering
gaps. Return-origin analysis now follows aliases for variants and wide records;
field tracking also follows aliases across intervening bindings. The generated
six-field recursive worker no longer boxes and immediately unpacks each result.
All original allocation thresholds remain unchanged. New tests cover wide-record
aliases and owned strings with an intervening print, compared with the raw
interpreter in tracing/ARC modes at O1/O2. Tracing runs stress GC and verify reuse.
Allocation helpers now require successful process exit.

Draft: /private/tmp/fwp-variant-return-repair-draft. Diagnostic IR/C:
fwp-wide-origin-inspection and fwp-repaired-wide-origin. The latter comes from
a failed test-signature run and is diagnostic evidence only. Earlier failures,
test corrections and superseded runs are historical, not acceptance gates.

## Source and measurement provenance

Original phase5–6 preparation350500f2cbbfccbde57dbd85e9fb855e13088e7d passes
all three complete jobs in38242709162. Each target executes21 named ARC cases,
rejects47 unproved programs and verifies3 expected compiler errors (71 entries),
with seven native disassemblies. All numerical/AD/reuse/exception controls pass.
Artifacts: /private/tmp/fwp-complete-ownership-platform-evidence and
/private/tmp/fwp-complete-arc-platform-evidence; their downloads are complete.
The report docs/measurements/ownership-and-arc-2026-10-12.json separates
existing-mode numerical timings from explicit ARC execution/reclamation controls.
Measured source identities remain unchanged; no universal speedup or C/Rust parity
is claimed. Its aggregateReturnFollowup records complete11f9bb75 evidence,
including formatted compiler/test hashes and retained native assembly hashes.

Phase5 gives loop fields independent owners, removes unneeded scalar unwind
bookkeeping and uses immutable numeric descriptors. Phase6 checks native ARC
after ownership lowering. Fusion records synthesized Step shapes; inlining
preserves constructed and compile-time aggregate types. Formatting uses one
cleanup-protected buffer. Production removes the redundant Step-by-name ARC
exception; ordinary registered variant metadata is required. Eligible immutable
graphs and scoped File owners reclaim without tracing. Mutable cycles, raw
reverse-mode tape/pointers, boxed I128/U128 without counted owners, unchecked
native declarations and unproved external/deployment boundaries reject.

## Remaining ownership deliveries

1. Preparation and artifact download are complete. Do not rerun
   fwp-download-aggregate-return-repair.py. Hash-verified evidence is in
   /private/tmp/fwp-aggregate-return-repair-evidence; measurements are updated.
2. The repair publisher has completed. Require all six jobs and roadmap_docs
   on4ecc9b19 before merging; fix every failure. Do not repeat the publisher.
3. Run fwp-merge-ownership-bundle.py, then
   fwp-publish-accepted-ownership-source-audit.py and
   fwp-download-accepted-ownership-source.py. Mark phases5–6 complete only after
   actual merged-source acceptance. These helpers have not run.
4. Run fwp-close-roadmap-docs.py only after that acceptance. Review its concise
   final docs, then publish with fwp-publish-roadmap-closure.py on
   complete-language-roadmap-docs. The docs-only delta still requires all six
   exact-head jobs and roadmap_docs before fwp-merge-roadmap-closure.py.
5. Retain final proofs in a new recovery snapshot and verify actual restoration.
   No implementation phase remains after this bundle satisfies its criteria.
   Windows, new deployment interfaces and a new backend remain deferred.

## Local workspace and limits

Local source remains68f959bbf28cfc00ed91a9f4c6dd6836020ff2a4. Latest disk
observation:57,937,032KiB free (55.3GiB), below the64GiB reserve; target data
103,696KiB (101.3MiB). No local build, broad audit, checkout, rebase or
fast-forward ran below the reserve. Only serial low-priority source edits and
bounded remote metadata/artifact operations ran. Full workloads stay on GitHub.
Use scripts/local-guard.py for fwp checks when resources permit; the fr guard
belongs to another repository. Never raise or bypass its limits.

Preserve the12 authoritative docs (AGENTS, CONTRIBUTING, PLAN, design,
development-state, ownership, primitive-ownership, roadmap-queue,
roadmap-history, reference, concurrency, numerics), measurement reports and
other user changes before later synchronization. scripts/check-roadmap.py has
an existing local modification; preserve it. The earlier document backup is
/private/tmp/fwp-main-docs-remote-pre123. Do not claim a local synchronization
or restoration that did not run.
