# Session handoff

Updated 2026-10-12. The implementation roadmap and final documentation are
complete and merged. Read [PLAN](../PLAN.md),
[design](design.md) and [ownership](ownership.md) for the accepted scope.
[History](roadmap-history.md) preserves prior evidence; the immutable
[queue](roadmap-queue.md) does not supply new work.

Durable recovery branch: `roadmap/handoff-pr123-20261011`. Last verified
checkpoint `0ec03c1540b81c4fdf8b7b7aaf826716e427664d` passes audit38276132014.
Actual bounded restoration verifies518 targets/44090395 bytes; reports are in
/private/tmp/fwp-verified-roadmap-closure-restoration. Query the branch tip on
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

None. The accepted source satisfies all six implementation phases and the
final documentation PR is merged.

## Final documentation and local workspace

PR #129 is squash-merged at `592a5953b8351e67fe30ca637426007f8763b5a4`.
Tested head: `bedbf8a1fe22127567305eb17be5efa3bc4366e7`.
All six jobs in CI 38274773884 and roadmap_docs 38274773721 passed before merge.
The signed squash message is exactly
`Record completed roadmap and accepted ownership evidence` (56 characters),
with no body or trailers. Complete tree `fa17c2b3a29effe8876f0bb9ccf92a94144a05aa`
matches the tested head. Only documentation differs from accepted PR #128;
implementation source is unchanged. Main roadmap_docs 38284763414 also passes.
The redundant post-merge CI status is in fwp-final-main-ci-status.json;
cancellation adds no passing gate. Merge, gate and signed-payload proofs use
the fwp-roadmap-docs prefix in the recovery snapshot.

Local main is now at the final squash above. Disk recovered to 105.8 GiB free
before synchronization; target data remained 101.3 MiB. No local workload ran
below the 64 GiB reserve. The following serial guarded operations passed:

- `python3 scripts/local-guard.py git fetch --no-tags origin main:refs/remotes/origin/main`
- `python3 scripts/local-guard.py python3 /private/tmp/fwp-prepare-local-main-sync.py`
- `python3 scripts/local-guard.py python3 /private/tmp/fwp-sync-accepted-main.py`

`python3 scripts/local-guard.py python3 scripts/check-roadmap.py` passes:
44 doc link sets, 106 immutable queue pairs/tags, zero live delivery rows and
commit-message checks (0.38 seconds sampled CPU, 3.09 seconds elapsed).

The sync proof and backup manifest preserve all 15 prior local files and modes.
Every prior file except this live handoff already matched accepted main.
Only this post-merge handoff is locally modified. Full builds and tests ran on
GitHub; no local full build or test gate was needed. Use the fwp guard described
in CONTRIBUTING.md for future local checks, never the other repository's guard.

## Next action

No implementation, defect or documentation delivery remains in this roadmap.
Retain the completion record and verify the final recovery snapshot audit.
Query the recovery branch tip for its final checkpoint and audit; an embedded
snapshot cannot record its own commit. Do not rerun completed publishers or
reopen archived preparations. Windows, new deployment interfaces and a new
backend remain deferred, not automatic next tasks.
