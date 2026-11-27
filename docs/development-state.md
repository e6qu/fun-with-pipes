# Current work

Updated 2026-11-27. **Next: complete the focused lifetime and ordinary performance
checks, retain their evidence, then open one substantial PR and finish every gate.**
Branch `resource-frame-costs` starts from verified #278. Follow the
[frozen value-protection contract](measurements/resource-field-costs.md).
No delivery PR is open during measurement preparation.

- Native attribution `46063375647` passes both hosts: 44 executions, 12 native
  binaries and altered-summary controls each. ARM64/AMD64 service/HTTP counts
  agree. Source `041db8772962f0e15ff44d70b56f1142fc8aa103` is retained by
  `roadmap/resource-frame-attribution-preparation-2026-11-27`.
- Contract `a107435fe3b19963e3670a66e29fa211f82a35fa` is retained by
  `roadmap/resource-value-contract-2026-11-27`; it predates implementation.
- The implemented proof carries the oldest enclosing lifetime owner through
  new records, known partial captures and returned values. It rejects protection
  from ended scopes, unknown factories, unsafe joins and rebound locals.
- Initial implementation run `46064688201` passes proof, semantic and raw-count
  checks, but fails formatting on both hosts. The runner-generated patch from
  `46064969889` is applied. Count targets pass: large cases remove 15–21% of
  cleanup registrations, 13.5–17% of successful retains and 2,048–4,096 allocation
  requests, with unchanged charged peak and complete release. This is not timing.
- Corrected run `46065431503` passes formatting/Clippy, but added fixture cases
  fail before execution: local member access must use pipes, and a File cannot
  be captured by a branch closure. Those fixture spellings are corrected; a
  callback type diagnostic is also being checked after the name corrections.
  The production proof and its previously passing native/count controls are unchanged.
- Ordinary service/peer/compiler measurements: `46065857276`, at immutable
  `roadmap/resource-value-time-preparation-2026-11-27` (production proof unchanged
  from the initial count run). HTTP cleanup controls: `46065944554`; sustained
  load: `46065948202`. All are pending, not verified support.
- Small audited attribution export `46065853405` passes both hosts; review data
  is retained in `measurements/resource-frame-attribution-2026-11-27`. Full native
  archives stay on runners. Earlier preparation `46062709945` failed on report-hook scope and
  missing HTTP TLS linkage; corrected attribution and raw audit pass.

Local disk is about 22 GiB free. `python3 scripts/local-guard.py git diff --check`
refused below the unchanged 64 GiB floor. No local compiler or tests ran; no
limits were raised. PR #278 already delivered the reviewed ignore rules.

Local `main` is current at `5a9047178b88c801f37a279dfeca55b0e190bf07`.
The previous branch `finish-delivery-hygiene` retains tested head
`8cdff5dda27f1ae7a79be421fd5cfdb18fdb636b`; its tree equals the merge.
This handoff carries the postmerge results into the next delivery without
changing the accepted head. No delivery PR is open during measurement preparation.
Published preparation: `9b24e6965dd4c7cfb6e88163a34722e0b99ec901`, retained by
`roadmap/resource-field-census-preparation-2026-11-10`. Focused native census
run `42830283981` passes both jobs: ARM64 `129878222562`, AMD64 `129878222459`.
Both complete logs are clean. [Retained census](measurements/resource-field-census-2026-11-10/README.md)
reconstructs all 17 inputs on both hosts; each C hash and classification agrees.
Executed counts at `b4b11d4a9f545b03a6af4b03f37612fb15650c9c`, retained by
`roadmap/resource-field-holds-preparation-2026-11-10`, also pass both jobs in run
`42833961349`: ARM64 `129891087787`, AMD64 `129891088346`. Complete logs are clean.
[Both reports](measurements/resource-field-holds-2026-11-10/README.md) reconstruct
all 34 executions per host, unchanged totals and real extra-pair controls.

## Verified delivery

[PR #278](https://github.com/e6qu/fun-with-pipes/pull/278) squash-merged as
`5a9047178b88c801f37a279dfeca55b0e190bf07` after every final-head gate passed.
Both it and tested head `8cdff5dda27f1ae7a79be421fd5cfdb18fdb636b` have tree
`cc672edd509c28272f48cf19d9002f42a757413c`. The merge message is exactly one
line, with no body or trailers.

- [Production `46021862122`](https://github.com/e6qu/fun-with-pipes/actions/runs/46021862122): all nine jobs pass.
- [Documentation `46021862175`](https://github.com/e6qu/fun-with-pipes/actions/runs/46021862175), job `140583233331`: pass.
- [Complete-log audit `46037710967`](https://github.com/e6qu/fun-with-pipes/actions/runs/46037710967), job `140637239616`: all ten reports pass.
  Both Linux hosts retain 257 target logs, each regular Mac 131, each ownership
  Mac 126, and each Windows host 57 logs with all 155 started targets successful.
- Audit artifact `15217982784`: 1,196,823 bytes; GitHub reports SHA-256
  `5eb3080e558b5511df91576df17d5ad2f0f59a8e24a3ab6ab76c48edaceac2ff`.
  Source, coverage and artifact identities were verified on the runner; no local
  archive verification was performed.
- Duplicate postmerge runs `46038247521` and `46038247409` were cancelled after
  proving merge/tested-head tree equality. They are not passing-gate evidence.

[PR #277](https://github.com/e6qu/fun-with-pipes/pull/277) merged as
`03c742f38d4d4a3f89393d3f05455f9cede0838a`, with the same tree as tested head
`58038846d5e822d0b9f15a549a97bed12337dcc5`.

- [Production `42837106816`](https://github.com/e6qu/fun-with-pipes/actions/runs/42837106816): all nine jobs pass.
- [Documentation `42837106970`](https://github.com/e6qu/fun-with-pipes/actions/runs/42837106970), job `129902136348`: pass.
- [Complete-log audit `46020511395`](https://github.com/e6qu/fun-with-pipes/actions/runs/46020511395), job `140578644274`: pass on 2026-11-27; all ten reports have no issues.
- Audit artifact `15207263613`: 1,183,696 bytes; GitHub reports SHA-256
  `2e34d5a0a4d18632d560239ed54f03ab76adf97b9445d7161f7d1f65267c5cf4`.
  The runner verified source, target coverage and original artifact identities.
  No local archive verification was performed.
- Postmerge production `42854655896` and documentation `42854655812` also pass.

[PR #276](https://github.com/e6qu/fun-with-pipes/pull/276) merged as
`b2bbd0389d227ea097ea1239d8d02ec6346f4be7`. Its tree equals tested head
`55060a061801a51a583dccc5777113e5ce49ccce`; message is one 63-character line,
without body or trailers. [Final receipts](measurements/nested-resource-final-gates-2026-11-10/README.md):

- Production `42814261330`: all nine jobs pass.
- Documentation `42814261144`, job `129823185341`: pass.
- Complete-log audit `42828337804`, job `129871448955`: pass; ten reports, no issues.
- Audit artifact `13770546233`: full size/SHA-256/member checksums pass locally.
- Duplicate main checks `42829037660` and `42829037694` cancelled after equal-tree proof.

## Performance results stay qualified

[Nested borrowing](measurements/nested-resource-time-2026-11-10/README.md) uses
16–21% less time in qualified service cases; 31/32 runtime and 63/64 compiler
comparisons qualify. One runtime comparison and one compiler comparison are noisy;
four original ARM64 RSS limits miss 5%. Keep all original acceptance limits open.
Large cases perform 29.7–36.9% fewer cleanup registrations and 4.85–5.34% fewer
actual reference-count updates, with unchanged allocation requests/charged peak.

[Memory diagnosis](measurements/nested-resource-memory-2026-11-10/README.md) uses
original binaries/container/libc and finds lower sampled resident-page peaks.
It does not establish the cause of the original RSS misses or replace their limit.
[All 34 HTTP trials](measurements/nested-resource-http-load-2026-11-10/README.md)
pass: 26,228,542 attempts, no failures, successful shutdowns and flat sampled RSS.
This is capacity evidence, not an HTTP speedup. Do not repeat unchanged timings.

## Selection and implementation scope

The earlier [static census](measurements/resource-field-census-2026-11-10/README.md)
and [plain-field service counts](measurements/resource-field-holds-2026-11-10/README.md)
remain unchanged evidence. Whole-frame service registrations are 21.6% of all
registrations; HTTP has 24.3%. Plain HTTP fields cause only 0.09% of successful
retains. The selected proof extends enclosing ownership; a standalone plain-field
optimization is rejected. Actual callable constructors/captures are inspected,
not inferred from arrow types. Keep ordinary owners and original disposal timing.

## Roadmap status

| Step | Status | Delivered | Remaining |
|---|---|---|---|
| 1 | In progress | #270 docs and fresh F64 stores | Original AMD timing acceptance |
| 2 | In progress | #271 captured maps and empty-owner transfer | Original noisy timing acceptance |
| 3 | In progress | #272 structured gradients and known callbacks | Original AMD timing acceptance |
| 4 | Verified | #273 ownership/peer comparisons and parser cleanup; all gates | Recorded comparison limits apply |
| 5 | Verified | #274 applications, compiler reports/growth, HTTP load; all gates | Recorded observation limits apply |
| 6 | In progress | #275 borrowed types; application speed/memory targets; all gates | Four noisy growth comparisons |
| 7 | In progress | #276 nested lifetime borrowing, gains, diagnosis; all gates | Original noisy/RSS acceptance |
| 8 | In progress | #277 baseline; new HTTP/callable attribution and implemented value proof | Corrected semantic gates, ordinary measurements and final delivery |

## Current checkout and local limits

The root checkout was 133 commits behind `origin/main`; it is now fast-forwarded
and the cleanup is on `finish-delivery-hygiene`. Current main already ignored
`__pycache__/`. The follow-up adds standalone `*.pyc`/`*.pyo` and `/.worktrees/`,
so nested worktrees no longer depend on a private `.git/info/exclude` entry.
Source files, fixtures and measurement reports remain eligible for tracking.

`python3 scripts/local-guard.py git diff --check` did not run its child: the
sandbox first denied process sampling; with sampling permitted, the guard stopped
because free disk is below 64 GiB (about 44 GiB observed). No limits were raised
and no local build, test suite or benchmark ran. Validation belongs on runners.
The follow-up's final-head runner gates and complete-log audit now pass.

Initial head `16fad7b80e6b08f029223b8d8ef6ee1284f9ec80`, production run
`46020925329`, exposed Rust 1.100's `needless_range_loop` diagnostic in recording
scope selection and a Windows AMD64 compiler/header mismatch. The loop now uses
`enumerate()` with the same function IDs and traversal order. The Windows runner
had standalone Clang 20.1.8 and VS 2026 headers requiring Clang 22 or newer;
setup now selects Visual Studio's bundled AMD64 Clang explicitly. Native ARM64
keeps its image compiler. Both target-specific C and C++ variables are explicit.
Both repairs pass the full final-head native matrix, including standalone
compiler packaging and the interpreter/native semantic controls.

The old untracked root `docs/measurements/compiler-abort.md` was preserved at
`/private/tmp/fwp-finish-wip-2026-11-27/compiler-abort.original.md` before checkout;
main contains its later historical account. Other worktrees' handoff edits and
all stashes were preserved. The original compiler abort remains unexplained.

## Previous focused checks and preservation

All checks use `python3 scripts/local-guard.py` serially. The census reader's
four tests and the existing proof reader's two tests pass. Changed-workflow
`actionlint` passes. No local compiler build, full suite or benchmark ran.
The explicit census CLI check passes. After staging new docs, the roadmap check
passes 473 doc link sets, 106 immutable preparation anchors and eight milestone
statuses. Real saved service C matches all five typed counter hooks; no compiler
was run locally. Retained readers reconstruct both static and executed reports.
Counter/auditor CLI checks, changed-workflow actionlint and staged documentation
checks pass. All native focused controls and #277's final delivery gates pass.

Keep 64 GiB free, generated targets below 2 GiB, workload RSS below 1 GiB and the
180-second guard deadline. Preserve old worktrees,
stash `451bbf713d451f2d62d80fd7676839404875846a` and backup
`540b0682408d751afb6e439d58a3b887bdcba373`.
Earlier temporary source-review files are no longer present. The saved census
archive and selected service/HTTP C are at `/private/tmp/fwp-frame-attribution`.
Do not download full compiler/binary archives locally or raise transfer limits.
