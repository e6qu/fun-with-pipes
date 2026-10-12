# Session handoff

Updated 2026-10-12. The implementation roadmap is complete; final documentation
delivery is described below. Read [PLAN](../PLAN.md),
[design](design.md) and [ownership](ownership.md) for the accepted scope.
[History](roadmap-history.md) preserves prior evidence; the immutable
[queue](roadmap-queue.md) does not supply new work.

Durable recovery branch: `roadmap/handoff-pr123-20261011`. Last verified
checkpoint `2ad52901fdef3725d5a98efce4430402ce91a3b1` passes audit38257164471.
Actual bounded restoration verifies502 targets/43576850 bytes; reports are in
/private/tmp/fwp-verified-production-repair-restoration. Query the branch tip on
recovery: an embedded checkpoint cannot identify its own commit. Use
current-map.json and its designated publisher. Never rerun completed publishers.
Superseded payloads remain in immutable parents. Restore temporary files only
through the hash-checking restore-roadmap-recovery.py procedure.


## Accepted source and gates

PR #128 is squash-merged at `7350a5566fa991c89916ea67ab693c2a0bba9327`.
Tested head: `4ecc9b198a9362a23e50a943732e7a0dc5c03010`.
Complete tree: `fcabfba0e0ca6b7a3e0ef0f7b99792bad7da8381`. The signed squash has one parent and exactly
the tested tree. Its complete message is the single line
`Complete checked ARC execution and loop ownership optimizations` (63 characters), with no body or trailers.
All six jobs pass at the tested head in CI38256949765; roadmap_docs38256949763 passes.
Actual merged-source audit38268514619 at driver40d7c6606eda15a9b6ece4283a9bafc5f795cf19
verifies hashes, the full source delta, primitive
inventory, compatibility review and that all gates completed before merge.

Proofs: fwp-ownership-final-gate-proof.json, fwp-ownership-merge-proof.json,
fwp-ownership-signed-payload.txt and /private/tmp/fwp-accepted-ownership-source.
The acceptance audit publication and download receipts identify driver and run.
Duplicate main CI 38267463468 is completed/cancelled after tree parity and source
acceptance; main roadmap_docs 38267463390 passes. Cancellation supplies no
additional passing gate.
Never substitute a skipped, superseded or cancelled run for a passing gate.

## Delivered scope and evidence

Phases1–4 deliver native macOS on both architectures, checked runtime ownership
boundaries, natural-width numeric storage and retained views, typed scalar/record
workers, fused array kernels, guarded blocked matrices and bounded reusable
reverse-mode autodiff workspaces. Phase5 removes per-element loop-field counts,
unneeded scalar unwind scopes and mutable descriptor dispatch. Phase6 adds
checked native ARC with physical reclamation and actual binary controls.
Fusion registers synthesized Step variants; eligibility uses their ordinary
variant metadata. Inlining preserves constructed and compile-time aggregate
types. Return-origin and field tracking preserve unboxed aggregates through
typed aliases and intervening bindings. Allocation, owned-child and observable
effect regressions cover these paths. Formatting renders directly into a
cleanup-protected buffer.

Preparation350500f2 passes all three complete jobs in38242709162. Each target
executes21 named ARC corpus cases, reports47 eligibility rejections and verifies
3 expected compilation errors (71 entries), with seven native disassemblies.
Normal-return ledgers require zero new charged live storage and zero collections;
missing-free and forced-tracing controls fail deliberately. The original deep
recursion native/golden control also has a bounded raw-interpreter counterpart.
The production matrix additionally verifies removal of the Step-by-name exception.

Aggregate repair 11f9bb75 passes all three jobs in run 38255456223. It preserves
the 24.3 MiB disabled versus 0.0 MiB rounded enabled variant allocation control,
and the wide-record alias meets the original <1 MiB bound. Owned-string aliases
and intervening effects match the raw interpreter in tracing and ARC modes.
Evidence is in /private/tmp/fwp-aggregate-return-repair-evidence and the report's
aggregateReturnFollowup. These controls add no new timing claim.

Reports: docs/measurements/numerical-kernels-2026-10-12.json and
ownership-and-arc-2026-10-12.json in the same directory. Sources, hardware/flags,
allocations, counts, live memory and timings are in
/private/tmp/fwp-complete-ownership-platform-evidence and
/private/tmp/fwp-complete-arc-platform-evidence. Numerical timings describe the
existing memory mode and use uninstrumented numerical binaries. ARC lifetime
ledgers and native disassembly are separate reclamation controls. No universal speedup
or C/Rust parity is claimed.

ARC accepts proved immutable counted graphs and scoped File owners. Unproved
mutable cycles, raw reverse-mode tape/pointer lifetimes, boxed I128/U128 without
counted owners, custom native signatures and foreign/deployment boundaries are
explicitly rejected. Rejection never selects tracing. Existing tracing-mode
features remain available. Register spills are normal lowering; protocol-defined
alternatives are peers. Avoid needless wrappers/fallbacks and hidden defaults.

## Remaining ownership deliveries

None. The accepted source satisfies all six implementation phases. Final
documentation delivery is described below.

## Local workspace and next action

The local source checkout remains68f959bbf28cfc00ed91a9f4c6dd6836020ff2a4.
Free disk was 55.3 GiB, below the required 64 GiB reserve; target data was 101 MiB.
No local build, checkout, rebase or fast-forward ran below the reserve. Accepted
implementation sources are on main and in retained artifacts; local docs are
current. Preserve all12 authoritative docs and user changes before any later
synchronization. Use the fwp guard in CONTRIBUTING.md for local checks, never
the other repository's fr guard. Full workloads remain on GitHub runners.

No implementation or defect task remains. Final documentation delivery is PR #129 on complete-language-roadmap-docs,
head bedbf8a1fe22127567305eb17be5efa3bc4366e7. Its publisher and the closure
editor are complete; do not rerun them. CI 38274773884 and roadmap_docs
38274773721 are queued; query current status. If the PR is open, finish all required gates
and the authorized single-line squash; once merged, no roadmap task remains.
Do not reopen archived preparations or repeat completed publication/download
helpers. Preserve these proofs and the current recovery snapshot. Windows, new deployment
interfaces and a new backend remain deferred, not automatic next tasks.
