# Session handoff

Updated 2026-10-12. Read [PLAN](../PLAN.md), [ownership](ownership.md) and
[design](design.md) before changing code. This is the sole live handoff.
[Queue](roadmap-queue.md) preserves immutable anchors; [history](roadmap-history.md)
preserves accepted and superseded evidence. Root docs are authoritative.

Durable recovery branch: `roadmap/handoff-pr123-20261011`. Last verified
checkpoint `6489ec4a701fe35ffda631b2612be892323a98c4` passes audit38230219937.
Query the branch tip on recovery; an embedded checkpoint cannot identify its
own commit. restore-roadmap-recovery.py restores only temporary paths from a
bounded immutable archive after verifying Git blob hashes. Its runner audit
verifies397 targets/34857977 bytes. Reports are retained in
/private/tmp/fwp-verified-current-ownership-restoration. The active map is compact.
The previous complete snapshot d00d306d1bac3d731f19769300e659b48cf7c020
(audit38227215868,702 targets/48528910 bytes) retains superseded helpers and
historical source. Restore that immutable head explicitly if they are needed. Current work
uses the designated current-map.json, not an old publisher's next action.
Never rerun completed publishers. Phases1–3 are accepted; phases4–6 remain unfinished.

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

Main is `3a4582368f987ddb0233086be50c47995eb4ed3f` (PR #126), merged 2026-10-12T06:45:18Z.
Exact tested head `916263e7c07443bccd4f87e764ca0c3f33dc664e` passes all six jobs in
CI38207662016 and roadmap_docs38207662006. Signed squash subject
`Pack numeric arrays and specialize worker ABI boundaries` is one line, 56 characters,
with no body or trailers. Its sole parent is `cbf68ea60c3b9439a117ef9d9b28b472f23dc632`;
complete tree `e3e00f4c134a912e73c33c844a1cac17202e5fb4` matches the tested head.
Actual merged-source audit38214129076 passes at driverb1b5372e9d7bfffe19361cbb8a2634b33f4f874f.
Hash-verified reports: /private/tmp/fwp-accepted-numeric-source.
Local checkout remains68f959bbf28cfc00ed91a9f4c6dd6836020ff2a4.

Phases1–3 are accepted. Phase2 retains the explicit tracing compatibility model:
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
Latest disk observation:58,623,584KiB available, about55.9GiB; local target
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

## Active phase4 bundle

Verified preparation b05ba75320db7359b00af53ff0a7e43512d07406 passes all three
platform jobs in38220639450. Formatted source agrees across Linux/ARM/Intel;
reports and uninstrumented disassembly are in
/private/tmp/fwp-numerical-platform-evidence. Array fusion removes intermediate
allocation; matrix kernels allocate only the output and preserve ordered floating
arithmetic; AD reuses a bounded512KiB workspace with checked capacities and
unwind/unload cleanup. Permanent semantic, physical-reclamation, alias/view,
omission, library and actual WASI controls pass. C/Rust comparison reports are
in docs/measurements/numerical-kernels-2026-10-12.json. Timings are descriptive;
prior failing preparations and repairs are archived in history.

PR #127 is open at8eb13370945b491cced1263ced290192e903acbb on
numerical-kernels-and-workspaces, based on accepted main3a458236. Current gates:
CI38231014878 running and roadmap_docs38231014937 passing. Repair publication:
/private/tmp/fwp-scalar-reuse-production-update.json.
The previous head d19fef9 had passing docs, bench and both macOS GC jobs. Its ARM regular macOS failed the original
unique_arrays_are_written_in_place control: push allocates38149.4MiB with or
without reuse. The remaining superseded jobs were cancelled after repair publication; no
results from that failed/cancelled head count toward the new gate.
The scalar-field borrowing optimization incorrectly holds a parent through
an operation even when the borrowed field is an immediate scalar; consuming
its array field then duplicates an owner and prevents in-place writes.
Repair branch ownership-evidence-borrowed-scalar-reuse at
70d04387f475cb3fc37ac047aebbc20dfa8c1750 passes38229871625 on all three targets. Identical formatted source/proof:
/private/tmp/fwp-scalar-borrow-reuse-evidence.
Only reference-valued fields extend parent borrowing; scalar field evaluation
finishes before a later consuming argument. Preserve the original thresholds.
Source map: /private/tmp/fwp-scalar-borrow-reuse-draft/files.json.
The formatted repair and manual evidence workflow regression are published;
require all seven results again for the new production head. Failure log:
/private/tmp/fwp-pr127-macos-arm-failure.log. The superseded initial-head CI38222106138 was cancelled after
repairing the loop reclamation test's boxed-only instrumentation. Its shared
state control now marks typed pointer fields in direct flat entries as shared;
the original reclamation threshold and semantic checks remain unchanged.
Publication/source hashes: /private/tmp/fwp-numerical-production-publication.json.
The prepared fwp-merge-numerical-kernels.py requires every gate, supplies an
explicit single-line subject/empty body and verifies signed squash/tree parity.
Actual merged-source acceptance remains required after merge.

Separate phase5 preparation: ownership-evidence-flat-loop-owners. Native head
7dbeb34cbc0d99c673577fd98c104b13e96e260a passes Linux runner38224092414:
compiler, loop ownership/unwind/preparation, field and numeric controls. Flat
state fields become independent ownership parameters before RC insertion,
allowing carried arrays to move without per-iteration retain/release pairs.
Eight65537-element rounds retain/release zero times and reclaim all charged
storage with zero collections. Uninstrumented timing still trails C/Rust;
zero counts alone do not establish machine-code parity. Sources/assembly:
/private/tmp/fwp-flat-loop-owners-evidence. Formatter-only export70bed875 in
38224748379 verifies unchanged implementation and supplies the PR127 test repair;
it is not an additional native gate. Earlier failed compilation and missed
flat-entry instrumentation remain failed runs, retained in preparation receipts.

Preparation0264d036dcac0f16833ea5a6a0996172e6148ecd passes Linux38226799564 and removes
unwind registration around concretely typed F32/F64 add/subtract/multiply/negate
primitive calls. Argument evaluation and checked integer calls retain their
protection. Permanent instrumentation bounds cleanup registrations per element,
as well as requiring zero retains/allocations and reclaimed input ownership.
Actual native tests and benchmarks are restored in the preparation workflow;
this head passes its native checks. Source map:
/private/tmp/fwp-phase5-scalar-unwind-draft/files.json. Keep phase5 compiler
changes separate from PR127 until its merge/acceptance. Current b3fde38ec477433b0a11a63fcef2f15425bf7cce additionally removes
scopes around bounded scalar Array reads; map comparisons/retains remain
protected. The measured bound retains one checked-index scope per element.
All three platform jobs pass in38227512382. Verified reports, sources and
actual uninstrumented disassembly: /private/tmp/fwp-loop-ownership-platform-evidence. Source map:
/private/tmp/fwp-phase5-lookup-unwind-draft/files.json. Inspect every result
and retain formatted sources/measurements before preparing the next PR.
Assembly still reloads writable descriptors and dispatches fixed element widths.
Current c600a9343283c975be018ba59c40c7d0068d161e makes generated descriptors
const;38229158359 passes all three targets. Reports and assembly are retained
in /private/tmp/fwp-const-descriptors-platform-evidence. Source map:
/private/tmp/fwp-phase5-const-descriptors-draft/files.json. Carry the production
scalar-borrow fix into this compiler before its final bundle validation; the
phase5-compatible RC source is fwp-scalar-borrow-reuse-draft/rc-phase5.rs.

## Phase6 preparation

Independent branch ownership-evidence-tracing-free at
75981271fe74b7a7dec2bc94ea1e8e57a7420286, awaiting runner validation,
adds explicit --gc arc/tracing build selection. ARC checks monomorphic value
shapes and primitive ownership contracts; unsupported opaque/mutable graphs,
retained callbacks, raw pointers, raw AD tape lifetimes, foreign/remote and executable-protocol/library
boundaries diagnose instead of selecting tracing. The first supported target is
native main programs. Counted immutable escapes and scoped File owners must
reclaim physically. Collector implementation is excluded in ARC builds;
conflicting GC/reuse-debug settings diagnose. A counted-to-uncounted promotion
traps as an internal contract violation. Linux20adf795 passes38229919586. Extended85e2ead3 passes all three targets
in38230592270: immutable escapes, File ownership, cycle-type rejection,
missing-free/forced-collection controls, actual binary symbols/disassembly and
existing closure/unwind/AD regressions. This remains preparation, not merged support.
The native tests compare a raw interpreter with arrays/views, escaping closures
and scoped files, check charged storage at return, and deliberately omit freeing.
Initial f1a748 failed clippy for redundant diagnostic borrows; ff325009 passes
compiler checks but rejects synthesized Step shapes;6c2344 admits Step and
fails the ledger test's global rather than main-thread instrumentation anchor.
Head20adf795 scopes that anchor, rejects unproved AD token lifetimes and
includes the scalar-borrow production repair. Head0ab3d491 passes all three jobs in38231696023 and combines all
numerical/AD/loop controls and benchmarks with ARC checks on the three platforms,
adding native static-memory and explicit foreign/deployment rejection controls.
Its export workflow is fwp-phase6-arc-draft/complete-preparation.yml. The three earlier
failed preparations remain failures; none supplies an ARC acceptance gate. Broader eligibility head82ca8bb5 rejects boxed I128/U128, which lack counted owners,
and user native declarations without checked signatures. Its new golden corpus
passes compiler checks but fails38233842841 on all targets: case_of_case leaves
16 charged bytes in format's managed rendering temporary. Head75981271 renders
directly into one private output buffer and registers its recoverable-trap cleanup.
The corpus now reports every semantic/reclamation failure in one run; it still
fails if any mismatch remains and requires real exit codes. Source/proof:
/private/tmp/fwp-phase6-arc-draft/format-files.json and fwp-arc-format-publication.json.
Failure C/report: /private/tmp/fwp-arc-corpus-failure. This repair is unverified.
Draft source map:
/private/tmp/fwp-phase6-arc-draft/files.json, fwp-arc-ledger-fix-files.json,
fwp-arc-platform-files.json and fwp-phase6-arc-draft/complete-files.json.
Fix all failures;
do not broaden eligibility without physical lifetime evidence. Source was
prepared from exact accepted runtime/IR blobs plus the current phase5 compiler.
Once coherent, phases5–6 may share the next production PR and full matrix to
reduce cycle time, with each phase's criteria checked separately in order.

Latest user constraint: avoid needless wrappers, alternate paths, magic and
implicit defaults. Register spills are ordinary lowering, and protocol-defined
options are peers. Runtime matrix.cast preserves fields and may create shape
mismatches; the specialized path must preserve their existing list/zip behavior.
The checked shape branch is semantic protection, not an allocation fallback.
Dimensions and borrowed arrays cross internal primitives directly. The tile
candidate has an explicit32-element name and24KiB three-tile payload rationale;
measure it on each supported target before claiming performance. Caches and
comparison switches are compiler/runtime implementation controls, not new Pipe
syntax or implicit type conversions.
