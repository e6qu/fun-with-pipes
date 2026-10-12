# Session handoff

Updated 2026-10-12. Read [PLAN](../PLAN.md), [ownership](ownership.md) and
[design](design.md) before changing code. This is the sole live handoff.
[Queue](roadmap-queue.md) preserves immutable anchors; [history](roadmap-history.md)
preserves accepted and superseded evidence. Root docs are authoritative.

Durable recovery branch: `roadmap/handoff-pr123-20261011`. Last verified
checkpoint `817335feace85d9bda136f3bac94515f2f25fb87` passes audit38215614654.
Query the branch tip on recovery; an embedded checkpoint cannot identify its
own commit. restore-roadmap-recovery.py restores only temporary paths from a
bounded immutable archive after verifying Git blob hashes. Its runner audit
verifies368 targets/19186843 bytes. Reports are retained in
/private/tmp/fwp-verified-phase4-active-restoration. On recovery, run the
bounded restore-numeric-finalization-archive.py after restoring temporary
sources to reconstruct the verified gzip export from its retained base64 text. Never rerun completed publishers. Phases1–3 are accepted; phases4–6 remain unfinished.

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
Latest disk observation:57,358,200KiB available, about54.7GiB; local target
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

Preparation branch ownership-evidence-numeric-array-fusion has a passing
Linux bundle3dbcddafe52b77a95f8db600d43d6208d4739b6c in runner38216031833.
Formatted source/reports: /private/tmp/fwp-matrix-wasi-workspace-evidence.
Eligible pure Array map/fold/length fusion removes intermediate allocations;
effect/trap, recursion, exact finite bits and arithmetic NaN controls pass.
Native/interpreter AD caches are bounded to512KiB. Cold/warm allocation,
scoped ownership, stale tokens, adjoint zeroing, capacity faults, cancellation,
reentrancy, normal/nested scopes, library unload and actual wasm32 limits pass.
The library omission control fails as intended. Matrix ordinary and cast-shape
products match the raw interpreter under both optimization settings.

Direct matrix dimension/array arguments and output-only allocation pass at
019580cc1ce07cc3f801e20ab3328c85ab6d8d68 in runner38217572666. Trap and
cancellation cleanup, deliberately omitted cleanup, internal primitive access
rejection and raw-interpreter shape controls pass. The kernel allocates exactly
one output payload; callers retain responsibility for their input owners.

Equivalent C/Rust/generated benchmarks are being validated. Head80b454 in
runner38218487246 passed compiler and regression checks, then failed its profile
instrumentation because a function prefix also matched a compile-time stub.
Head e5de4d3811e2cc77a78612f359db2b93a92b9b88 makes that match precise; results
are pending. Timings use separate uninstrumented executables, and all workloads
must agree on exact result hashes. Allocation, reference-count operations,
charged live memory and process RSS are recorded separately. No speed claim is
accepted yet. Permanent test artifacts now supply allocation metadata without
rebuilding the same evidence. Historical failed preparation heads are retained;
none substitutes for a passing production gate.

Current source is /private/tmp/fwp-phase4-matrix-draft; the complete publication
mapping is /private/tmp/fwp-numerical-performance-files.json. Next finish the
benchmark checks, run the coherent numerical/AD bundle on Linux and both Macs,
then export formatted source and open one production PR from accepted main.
Require all six exact-head jobs plus roadmap_docs before squash. Continue
phases5–6 after actual merged-source acceptance. Fix encountered bugs throughout;
CI waiting gates merges, not preparation. No phase4 production PR is open yet.

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
