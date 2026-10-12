# Session handoff

Updated 2026-10-13. The implementation roadmap and final documentation are
complete and merged. A new user-requested examples follow-up is active below.
Read [PLAN](../PLAN.md),
[design](design.md) and [ownership](ownership.md) for the accepted scope.
[History](roadmap-history.md) preserves prior evidence; the immutable
[queue](roadmap-queue.md) does not supply new work.

Durable recovery branch: `roadmap/handoff-pr123-20261011`. Last verified
checkpoint `3af176bc210cd9de367bbdf98d2eb49b2626098f` passes audit 38285912566.
Actual bounded restoration verifies 275 targets / 31127348 bytes; reports are in
/private/tmp/fwp-verified-completed-roadmap-restoration. Query the branch tip on
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

Phases 1–4 deliver native macOS on both architectures, checked runtime ownership
boundaries, natural-width numeric storage and retained views, typed scalar/record
workers, fused array kernels, guarded blocked matrices and bounded reusable
reverse-mode autodiff workspaces. Phase 5 removes per-element loop-field counts,
unneeded scalar unwind scopes and mutable descriptor dispatch. Phase 6 adds
checked native ARC with physical reclamation and actual binary controls.
Fusion registers synthesized Step variants; eligibility uses their ordinary
variant metadata. Inlining preserves constructed and compile-time aggregate
types. Return-origin and field tracking preserve unboxed aggregates through
typed aliases and intervening bindings. Allocation, owned-child and observable
effect regressions cover these paths. Formatting renders directly into a
cleanup-protected buffer.

Preparation 350500f2 passes all three complete jobs in 38242709162. Each target
executes 21 named ARC corpus cases, reports 47 eligibility rejections and verifies
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
Duplicate post-merge CI 38284763467 is completed/cancelled; its actual status
is in fwp-final-main-ci-status.json. Cancellation adds no passing gate. Merge, gate and signed-payload proofs use
the fwp-roadmap-docs prefix in the recovery snapshot.

Local main was synchronized to the final squash above before the examples branch. Disk recovered to 105.8 GiB free
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
At that synchronization only the post-merge handoff was modified. Full builds and tests ran on
GitHub; no local full build or test gate was needed. Use the fwp guard described
in CONTRIBUTING.md for future local checks, never the other repository's guard.

## Current follow-up: tacit examples and explicit const

Branch: `examples-tacit-pipelines`, based on accepted main
`592a5953b8351e67fe30ca637426007f8763b5a4`. The user requested the piped, tacit
style throughout suitable examples and clear explanations of `const` wherever
its role is otherwise surprising. This is new work after the completed roadmap.

Nine programs are revised: the effects, CLI and MCP tutorials, pricing, and
CSV, directory, grep and todo examples. Matching tutorial source blocks are
updated. Predicate-only branches use piped `match`; validation uses `tap` to
preserve the input. CSV input matches `Some`/`None` directly. `if` remains where
it preserves the original input needed by a branch. No language semantics,
implicit conversions, compiler code, expected tutorial outputs or defaults change.

The first tutorial and reference explain constant functions, values versus
callbacks, function-valued results and eager argument evaluation. Data and effects
tutorials explain captured holes and branches; the CLI tutorial explains why
`const None` discards the original string while `Some` preserves its whitespace.

Focused checks use the existing local compiler, not a rebuild of the current
source. All commands ran serially through `python3 scripts/local-guard.py`:

- Formatting and type checks for all nine revised programs pass (3.50 seconds
  sampled CPU, 6.94 seconds elapsed).
- `/private/tmp/fwp-check-tacit-examples.py` passes 36 executions: original and
  revised programs, each in raw interpretation (`FWP_NO_OPT=1`) and native mode.
  Both branches, invalid inputs and CSV file/stdin paths agree on stdout, stderr
  and exit status (20.17 seconds sampled CPU, 40.44 seconds elapsed). Results:
  `/private/tmp/fwp-tacit-example-validation/results.json`. An initial temporary
  harness incorrectly renamed effectful `main`; replacing it fixed that harness
  error. No example failure remains.
- `/private/tmp/fwp-check-tacit-docs.py` passes focused formatting, the existing
  `tutorial_readmes_match_their_programs` test, constant-function examples in
  both engines and the roadmap documentation audit (1.84 seconds sampled CPU,
  6.18 seconds elapsed). The audit checks 44 doc link sets and 106 immutable
  preparation pairs/tags; there are no remaining ownership delivery rows.

The user also asked about reducing parentheses. The expressions are already
tacit; meaningful named stages and existing combinators reduce nesting without
implicit lifting or a new pipe meaning. `is-long = string.length | gt 3` followed
by `count-long = count is-long` has no parentheses. A named `count-word` callback
reduces the stateful version to `run-state 0 (each count-word) | .1`. Both variants
produce 2 in the raw interpreter via the guarded temporary probe
`/private/tmp/fwp-less-nested-count.fwp` (0.35 seconds CPU, 0.71 elapsed). This
was a discussion and focused probe; the published examples were not changed
again or their CI restarted. The effects tutorial deliberately demonstrates state.

## CI repair and next action

PR #130 is open: https://github.com/e6qu/fun-with-pipes/pull/130.
Published examples head: `7c0dca31cb1f30433bfab2ee2bf473b322a54861`.
Roadmap_docs 38291067649 and five platform jobs in CI 38291067651 pass at
that head. Regular Intel macOS exceeded the 90-minute limit twice: jobs
114951015867 and 114985528618. Neither attempt reports failed assertions;
all four examples/tutorial checks passed in both. The retry also timed out
while continuing through passing suites. These cancellations are not passing
gates. Logs are /private/tmp/fwp-pr130-intel-final.log and
/private/tmp/fwp-pr130-intel-retry.log. Completed suites in the first attempt
took about 38% longer than the preceding passing Intel run.

The CI repair splits ordinary integration targets between the two existing
macOS jobs per architecture, using sorted Cargo target names at alternating
indices. The regular job includes unit/example/benchmark targets; the GC job
retains its separate exact stress test before its ordinary shard. All six job
names, test concurrency and 90-minute limits remain unchanged. Both shards
exclude only the separately executed stress test. Failure artifacts now cover
ordinary goldens in either job; an ordinary shard still runs after a stress
failure. Partition tests check complete, disjoint coverage, stable assignment,
rejection of unknown targets and propagation of test failures.

The guarded real Cargo metadata audit confirms 170 integration targets,
85 in each shard, with no overlap or omitted targets. Previous passing Intel
suite times total 2280.12 seconds for regular and 1758.92 seconds for gc,
excluding setup, builds and the separate stress run. These are historical
inputs, not a measured duration or passing gate for the new layout. Inventory:
/private/tmp/fwp-pr130-macos-shard-inventory.json. No local build was run.

Focused validation passes with
`python3 scripts/local-guard.py python3 -B -`: the driver runs
`python3 -B scripts/test-macos-test-shards.py` (three tests),
`python3 scripts/check-roadmap.py` (44 doc link sets, 106 immutable pairs/tags,
zero live ownership rows) and `git diff --check`, serially. Sampled CPU is
0.31 seconds; elapsed time is 2.65 seconds. No full local build or test gate ran.

Next: commit and push the CI repair, then require all six jobs and the
documentation audit at the revised head. Earlier-head successes do not satisfy that gate. Squash with subject
`Clarify tacit examples and balance macOS test coverage` and an empty body,
with no trailers. Local checks do not substitute for CI.
The completed implementation roadmap and its verified recovery snapshot remain
accepted. Do not reopen archived preparations. Windows, new deployment interfaces
and a new backend remain deferred.
