# Current work

**Next:** implement and verify the [single-owner cleanup repair](measurements/packed-pair-cleanup-repair.md).
Original runtime measurements found a stack-budget failure; keep every original
outcome. Finish the repair, its focused/storage checks and stack preflight before
new runtime measurements. Keep one active PR (#260), then final production CI.

## Roadmap status

[PLAN.md](../PLAN.md) and this table track the same five current delivery steps.

| Step | Status | Work |
|---|---|---|
| 1 | Verified | Consume the private owner; borrow/escape analysis and cleanup agree. |
| 2 | Verified | Reuse equal-width numeric storage; preserve aliases, stages and physical charge. |
| 3 | Verified | Three focused native hosts and full log/image/probe audits pass. |
| 4 | In progress | Original counts/compiler limits pass; runtime exposes redundant cleanup storage and a stack failure. |
| 5 | Pending | Retain evidence, pass all final production/docs gates, audit and squash merge. |

## Verified parent delivery

PR #259 squash `cbb779446162efa71301f64350662f2c7c0d8073` matches tested
`e3a2e1d34eaa9364ff22273ed10fef7afb98204e`, tree
`3db09774419f8b81114cb60e35fe6fbe3aab82c4`. Its message is exactly
`Remove temporary storage around gradient calls`, with no body/trailers.
All nine production jobs (`41986867960`, attempt 1), docs (`41986867893`)
and complete log audit (`42000937569`, auditor f339616c) pass.
[Delivery record](measurements/gradient-call-delivery-2026-11-05.json) and
[history](roadmap-history.md#gradient-call-storage-pr-259) preserve identities.

## Current branch and verified native checks

Draft [PR #260](https://github.com/e6qu/fun-with-pipes/pull/260), branch/worktree
`packed-pair-storage`. Published auditor repair `4eb6ec6a`; compiler/runtime/library/native-test sources
remain unchanged.
Pre-rebase preparation head
`f339616c639e4c55703f619cc46ca08f93f11ee8`. The [contract](measurements/packed-pair-storage.md)
was frozen before code at `3b7954eef411b7b621d09718ae2aad41e72e744e`, retained by
`roadmap/packed-pair-storage-protocol-2026-11-05`.

- Consume the private input; update borrow inference, escape analysis and cleanup.
  Equal-width numeric results reuse its sole owner without a runtime count query.
  Other widths allocate; preserve the explicit no-reuse control and physical charge.
- Focused run `41991479079` passes Linux AMD64/ARM64 and macOS ARM64 at
  `6e02c048019642b6f6eb52c9ae6fef5fa8f2f3f7`. Compiler/runtime/library/test sources
  have not changed since. All-target lint, formatting, compiler units and 25 native
  targets cover both orientations/layouts, aliases, bits, failures and cancellation.
- Full focused audit `41997987727` passes: 25 targets, 822 native images and
  838 probe records per host; source/artifact hashes and image architecture checked.
  [Evidence and preparation repair](measurements/packed-pair-checks-2026-11-05.md)
  identify the saved observations. Original images remain in the source artifacts.
- `packed-pair-census` passes repeated solves and fresh O1/O2 phase accounting.
  `packed-pair-analysis` keeps seven inputs and 48 scheduled compiler commands.
  `packed-pair-time` / `packed-pair-report` prepare the two sessions per architecture
  and complete archived-source audits. Compiler costs `42005106056` and four
  runtime sessions `42005111118` use frozen a1f18947, tag
  `roadmap/packed-pair-timing-2026-11-05`.
- Parent delivery, focused audit, controls and exact census reconciliation pass.
  Preserve all earlier missed timing goals; no changed thresholds.

Small control run `42000589145` failed only historical source availability: one
18-test script reports five missing-commit/tag errors; the other seven scripts
pass (58 tests). All eight ran. Repair: full-history/tag checkout and historical
PR refs, matching docs CI. The repaired small batch passes; do not rerun it unchanged.
The compiler/runtime/library/native-test sources remain identical to 6e02c048.

The rebase onto #259's verified squash is complete. Focused implementation and
auditor identities are retained by `roadmap/packed-pair-checks-2026-11-05` and
`roadmap/packed-pair-auditors-2026-11-05`; the original contract tag is unchanged.
Repair controls `42002432263` pass all eight scripts (76 tests) on b8081559.
Docs `42002435391`, `42003321627`, `42005102020` and `42006248863` pass. The census now also checks the allocating
reference against saved parent counts/peaks: 24 fresh and 12 repeated cases,
with mutation controls. These new controls run first in the census job.
Draft production `42002435468` is skipped intentionally, not final acceptance.
Census `42003323499` passes both native Linux architectures at e4d645cd,
with `evidence_run=41991479079`. Its early controls include the new saved-parent
reconciliation test before either compiler build; both hosts pass those controls
and every repeated/fresh count, cleanup, parent-reconciliation and phase check. Source tag: `roadmap/packed-pair-census-2026-11-05`.
Census acceptance and reference/parent reconciliation now permit timing.

Redundant post-merge main production `42001754691` was canceled while queued:
its tree equals the fully verified PR head. Main docs `42001754627` already pass.
Keep the original final PR gates/audit as delivery evidence.

## Measurements and remaining goals

Parent [census](measurements/gradient-call-census-2026-11-05/README.md): fresh
129/199 changes 2,121 -> 727 requests, 1,265,230 -> 1,034,366 requested bytes and
398 fewer retains. Final managed/raw bytes are zero. Corrected phase audit
`41967470333` retains the original attribution error (scratch reserves N+1 words).
[Compiler costs](measurements/gradient-call-analysis-2026-11-05/README.md) pass.
[Runtime](measurements/gradient-call-time-2026-11-05/README.md) retains 17 misses:
16 larger cases miss 5%, and AMD64 session 2 zero-update current slows 2.1822%.
Three-coordinate long solves improve 14.3–25.2%; RSS is mixed. Prior #258's four
AMD64 misses and all other PLAN.md goals remain separate.

[Observed pair-reuse fresh 129/199 counts](measurements/packed-pair-census-2026-11-05.md):
727 -> 528 requests, 1,034,366 -> 625,222 bytes. Reuse retains original capacity through the fold; check
phase and overall peaks rather than claiming lower live memory from fewer requests.

## Resource limits and retained local work

No local validation or large downloads below 64 GiB free. Latest observed free
space was about 1.27 GiB after a drop below 1 GiB; task scratch is about 3.8 GiB and both build directories are
empty. Use runners, never raise/bypass the guard. Unrelated work remains untouched.
Earlier verified duplicate-download cleanup removed 1,820.39 MiB, preserving logs,
observations and verified remote originals. Receipt:
`../gradient-work/removed-verified-downloads-2026-11-05-pair-preparation.json`.

Before the disk drop, bounded checks passed: Rust/fixture formatting; all 14
reference/budget scripts plus workflow syntax (14.88s); primitive inventory,
shard assignment and syntax (1.28s). Receipts: `../gradient-work/packed-pair-reference-checks.json`
and `../gradient-work/packed-pair-inventory.json`. Preparation controls and the checkout repair pass on GitHub. Parent docs/benchmark audits remain in
`../gradient-work/gradient-call-final-repaired/`.

Old run `38888712709` has stale in-progress metadata, but all jobs completed on
October 16 and GitHub rejects cancellation as already completed. No active runner
or queue cause is established. Metadata: `../gradient-work/stale-paths-{run,jobs}-38888712709.json`.

## Current measurement runs and repairs

Compiler costs `42005106056` pass both architectures at frozen a1f18947.
Audit run `42008507459` checks their saved 336 commands and six selection checks
per host with `storage-compiler-report`; no timing rerun is needed. Full artifacts remain on
GitHub; the report retains inputs, generated C, resource records, logs and hashes.

Runtime `42005111118`: both ARM64 sessions and AMD64 session 1 are measuring.
AMD64 session 2 rejected EPYC 9V74 before building/timing; the contract requires
EPYC 7763. Replacement `42008084704` rejected the same model before any build.
Preserve both host reports; do not treat these as measurements or change the CPU
requirement. Only the missing session is requested again in `42008513001` on frozen a1f18947.

Census audit `42006250074` checks all counts, raw profiles, source reconstruction,
native images and saved-parent agreement. It exposed four duplicate ZIP-member
warnings: outer and nested archives both contain fresh report paths. Repair uses
separate `original/` and `fresh-{reference,candidate}/` namespaces, rejects duplicate
members and rereads retained bytes against their hashes. Repair audit `42008501553` rechecks original run
42003323499/source e4d645cd; never rerun the measured programs for this repair.
Original warning-bearing artifact 13404918559 (2,518,595 bytes), SHA-256
`e07f839a46fb71aaa5a4558b5f7edf3d2f94f7d9e324d86394e1e5930ed45dbb`, is retained.

The mocked audit-output capture is verified by docs 42005102020 and 42006248863;
production diagnostic filters remain strict. Full native gates wait until this
measurement/documentation group is ready. Draft skips do not establish acceptance.

Original census and compiler artifact audits pass (42008501553/42008507459),
with compact observations retained in docs. Docs 42008509366 pass at 4eb6ec6a.
Runtime 42005111118 finished: three measured sessions, 23 missed speed targets,
one AMD64 stack limit failure; report audit 42009905049 is running. Four AMD64
session-2 host requests rejected before timing; no old-candidate retries remain.
The repair protocol above supersedes the original runtime next action.
Cleanup removed 399,065,683 bytes of verified duplicate downloads; receipt
`../gradient-work/removed-verified-downloads-2026-11-05-disk-emergency.json`.
No local native checks/builds or large original-artifact downloads below reserve.
