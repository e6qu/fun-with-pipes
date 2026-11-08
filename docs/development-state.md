# Current work

**Next:** monitor the repair commit on [PR #270](https://github.com/e6qu/fun-with-pipes/pull/270)
and audit every completed production/docs result before merging. Use the PR's
current exact head, then dispatch the complete artifact/log audit after its gates
finish. The original production `42444906666` and docs `42444906569` tested
`56ffa96bc28f573f01f28a3e23827414d90d6e31`. Bench job `128621688027` failed the
lesson 7 formatter check; docs job `128621687708` found a historical report title
changed without its generator. Both causes are fixed together in this commit.
Other jobs had reported no failure when their available steps were reviewed;
the new head still requires the full nine-job production matrix and docs audit.
Do not mark milestone 1 complete: AMD64 timing acceptance remains open. The user
has been asked whether to retain the verified ARM64 improvement with that goal
open or withhold the compiler change pending reliable AMD64 measurements.
Publication and correctness checks can proceed while that decision is pending.

## Workspace and scope

Branch `performance-roadmap-review`, worktree `.worktrees/recording-capacity-gate`,
base `bbcaafea00d6bf9e26feea60f90d8d440aa16d00` (merged #269). The root worktree
has unrelated changes; do not modify/reset it. #269's tested/merged trees match;
[production, documentation and complete audits pass](measurements/computed-numeric-delivery-2026-11-08/README.md).
Its redundant post-merge run `42431179791` was cancelled after verifying equal
trees and no failed jobs.

This PR combines the five-step roadmap, the complete documentation/tutorial
review, a measured compiler improvement and reproducible measurement tools.
Use a normal PR; draft status must not suppress CI. Preserve passing results
while remaining gates run. [PLAN.md](../PLAN.md) owns acceptance.

## Roadmap status

| Step | Status | Evidence and remaining work |
|---|---|---|
| 1 | In progress | Fresh F64 output stores improve large-array computation 26–31% in both ARM64 sessions. Docs/tutorial sweep and complete measurement audits are ready; AMD64 acceptance and final platform/docs gates remain open. |
| 2 | Pending | Broader lifetime/representation proofs selected from measured costs, covering at least two application patterns. |
| 3 | Pending | Structured differentiation across three objective families, preserving general reverse AD, nesting and precision. |
| 4 | Pending | Current Swift/C/Rust ownership comparisons, with phase timing and explicit memory boundaries. |
| 5 | Pending | Three end-to-end application/tooling paths and compiler phase/scaling costs; demonstrated usability repairs. |

## Implementation and safety

Executable compiler change: `f21bf13902239805ef74048e8a8b3fc4d4237cbb`.
Known `array.generate` callbacks returning exactly F64 store directly into their
fresh output. Such output cannot be a view and its elements need no destructor.
The protected builder still frees partial/completed output. Input reads, bounds
checks, callbacks, effects and other element types retain their behavior.
No new runtime helper, capture parameter or source API was added.

Focused run `42438693432` passes all eight targets on AMD64 GCC
(`128603076444`), ARM64 GCC (`128603076704`) and ARM64 Clang (`128603076570`).
Complete safety audit `128607338068` in `42440117133` verifies 348/348/342 native
images and 372 probe statuses per host. Tests cover packing, numeric types,
aliases, slices, dynamic counts, callback failure/cancellation and physical frees.
Other test assertions on stores/prefix counts were reviewed: they cover unchanged
map lowering or runtime AD builders, not the changed generated F64 worker.

Later production-code edits only clarify the builder's destructor-free prefix
comment. Other changes are docs, tests and measurement/audit tooling. Final-head
production checks are still required; focused coverage is not a full delivery gate.

## Measurements and decisions

The [frozen protocol](measurements/shared-loop-array-costs.md) defines inputs,
phase boundaries and original limits. Do not rerun unchanged timings to obtain
a pass, relax limits after seeing results or substitute counts for runtime gains.

| Investigation | Evidence | Decision |
|---|---|---|
| Forced callback inlining | [Run 42433452458](measurements/loop-array-diagnosis-2026-11-08/README.md) | Rejected; largest derivative cases take 1.11–2.04% more process time. |
| Cached captured-array metadata | [Run 42435795842 and complete audit](measurements/borrowed-array-metadata-2026-11-08/README.md) | Rejected and removed; misses the 10% computation target. |
| Direct fresh-output stores | [Diagnostic 42437082841 and complete audit](measurements/fresh-array-diagnosis-2026-11-08/README.md) | Selected for compiler implementation; diagnostic gains alone do not verify it. |
| Production candidate/reference | [Run 42440117133; audit 42441970817](measurements/fresh-array-costs-2026-11-08/README.md) | All 72 cases pass correctness/data checks. ARM64 large arrays improve 26–31%; AMD64 acceptance remains open. |
| Equivalent C/Rust computation | [Run 42441977298, both complete audits](measurements/loop-array-peers-2026-11-08/README.md) | Qualified long loops are competitive. Largest ARM64 local-AD case takes 2.47× C and 4.98× Rust. One session per architecture; most AMD64 array/derivative controls fail. |
| Explicit CPU placement | [Run 42443629870 and complete audit](measurements/array-affinity-2026-11-08/README.md) | Pinning alone does not resolve large-array copy variation. Not a replacement accepted timing protocol. |

Production sessions used source `066175c3ad47cf8d226a1dc2b16fba55eba71b7d`.
AMD64 sessions have 13/12 failed computation-copy controls and one qualified
3.38% zero-update regression; they ran on different CPU models (9V45 and 7763).
Both ARM64 sessions pass all computation-copy controls and qualified guard limits.
Allocations and peak managed storage are unchanged. Separate ordinary RSS,
compiler time/RSS, code and stack observations are retained in the reports.

Complete production-measurement audit `42441970817`, job `128612920574`, verifies
all 7,976 timing/build commands plus 216 resource commands per first-session host.
Peer jobs `128612937644`/`128612937839` each audit all 2,916 commands.
Placement job `128617878874` at `c35f211a9` and the local standalone auditor
verify four cases, 16 native/copy images and all 416 commands/samples.

Two tooling failures are repaired and recorded: `42439586418` lacked historical
Git source for its audit (fixed with a full-history checkout); `42442853547`
failed hardware preflight before measuring (assigned-CPU qualification and a
hardware receipt are now explicit). Both repaired paths pass. Original logs and
failed observations remain evidence, not unfinished implementation tasks.

## Documentation and remaining checks

All 24 tutorial READMEs and the tracked Markdown inventory have been reviewed.
[The documentation map](README.md) separates learning, reference, compiler work
and evidence. Stale delivery instructions, duplicate status prose and obsolete
roadmap items are removed; original observations/contracts remain intact.
Lesson 7 now labels Fahrenheit as `fahrenheit`; source and transcripts agree.
Its native session needs final runner verification. The isolated production
formatter now verifies canonical form, identical parsed meaning and idempotence.

The latest prior full docs check is `42438695310`, job `128603080353`, at
`f21bf1390`; subsequent edits need the final-head check. Generated library guides
must still be maintained through their source comments/generator.

- Guarded local checks pass: fourteen measurement controls, five diagnostic
  controls, Rust formatting, tutorial source/output copies, workflow syntax and
  sparse/index links across 384 Markdown files and five roadmap rows.
- Retained artifacts pass digest/archive checks; the standalone placement audit
  checks all samples without executing any binaries locally.
- No full local compiler build, native suite or benchmark was run. A temporary
  formatter probe compiles the production parser/formatter modules and the exact
  string-escaping helper under the guard (2.54 CPU seconds/5.02 seconds elapsed). Full checks stay
  on GitHub. The last disk reading was about 86 GiB; preserve the 64 GiB limit
  and use `scripts/local-guard.py` for focused checks.
- This sparse checkout omits tracked examples. The full documentation audit
  belongs on a complete runner checkout; the local index-aware audit checks links.
- `numerics.yml` is only 25 bytes below GitHub's 512,000-byte limit. Extend reusable
  workflows instead of growing that file. The earlier size failure is repaired.

## Batched CI repairs

- Formatter failure: update lesson 7 source and its README together, using the
  formatter's `.sensor` shorthand and canonical layout; explain the shorthand.
  The isolated formatter verifies unchanged parsed meaning and idempotence.
  `/tmp/fwp-roadmap-tutorial-copies --exact tutorial_readmes_match_their_programs`
  passes through the local guard after the edit. Full failed log:
  `/tmp/fwp-270-bench.log`. Its missing-artifact error follows the early fmt exit.
- Generated report failure: update `scripts/report-current-kernels.py` to emit
  the historical PR #243 heading. The report body and observations are unchanged.
  Guarded `python3 scripts/test-current-kernel-report.py` passes both controls.
  A source sweep found no other removed prose still emitted by a generator.
  Full failed log: `/tmp/fwp-270-docs.log`. Expected negative-control failures
  earlier in that log pass their enclosing tests; they are not job failures.
