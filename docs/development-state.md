# Current work

Updated 2026-11-28. **Current work: same-process executable memory accounting**
on `rss-exec-accounting`, starting from verified #279. The
[fixed diagnostic](measurements/executable-rss-accounting.md) observes GNU time's
own child at fork, exec and exit and preserves ordinary untraced controls.

**Next: verify native lifecycle/failure controls, then collect and reconstruct
all fixed service observations on both architectures.** Native control run
`46159844843` passes all seven actual lifecycle/failure tests on both hosts;
raw-reconstruction run `46160161430` passes all nine tests on both hosts.
Fixed service collection `46160536010` is running at `d14c9c0b` in the original
pinned image. The protocol was frozen at `4baf1339`, retained by immutable tag
`roadmap/exec-memory-contract-2026-11-28`. A tenth control explicitly checks
unexpected thread creation; it awaits native verification.
The original four 5% RSS misses remain open; this work
does not repeat timing acceptance or recover the original processes.

Local `python3 scripts/local-guard.py git diff --check` again refused below the
64 GiB free-disk floor. No local builds/tests ran and no limits changed.

## Completed #279 preparation

- [The frozen contract](measurements/resource-field-costs.md) predates production
  code: `a107435fe3b19963e3670a66e29fa211f82a35fa`, retained by
  `roadmap/resource-value-contract-2026-11-27`.
- [Native attribution](measurements/resource-frame-attribution-2026-11-27/README.md)
  passes both hosts in `46063375647`: 44 executions and 12 native images each,
  real extra-owner and altered-summary controls. Source `041db8772962f0e15ff44d70b56f1142fc8aa103`
  is retained by `roadmap/resource-frame-attribution-preparation-2026-11-27`.
- The proof carries surviving ownership through records, known partial captures,
  returned values and branch joins. Saturated/unknown factories, ended scopes,
  unsafe joins and rebound locals remain conservative. Ordinary owners and
  original binding anchors remain intact.
- Focused `46067857005` passes both native hosts at `33149ad2fd888a66ff36b8eb7f2c5b61faccfccb`:
  all 11 proof tests, seven resource tests, eight semantic targets, 32 count cases,
  eight real faults and six altered reports per host. Large cases remove 15–21%
  of registrations, 13.5–17% of successful retains and 2,048–4,096 allocation
  requests; charged peak is unchanged and all storage releases. These are counts.
- [Original compiler costs](measurements/resource-value-costs-2026-11-27/README.md)
  from `46065857276` reconstruct: 61/64 acceptance, two noisy AMD64 comparisons
  and a qualified 2.059% generic-512 increase against the frozen 2% limit.
  The repair classifies only queried locals, caching per local and type. New
  compiler run `46068984506` passes all 64 comparisons and proves unchanged C
  for four applications and twelve growth inputs. Focused repair checks
  `46068988582` pass on both native hosts; counts are identical to the first
  implementation. Complete logs have no compiler diagnostics.
  Source-format `46068992809` passes with an empty patch.
- Ordinary service/peer run `46067853489` passes both jobs: all 32 service time
  comparisons qualify and meet their limits. Large cases take 5–16% less time.
  Four process-RSS ratios miss 5%: ARM64 session 2 cancellation; AMD64 session 1
  small error and session 2 small full-delivery/expiry. Keep these misses open.
  Page-walk run `46073285460` passes against unchanged binaries, the exact
  original image and libc 2.39-0ubuntu8.12. All 256 executions and 4,805 snapshots
  reconstruct, with exact agreement between fast RSS counters and page walks.
  Later sampled peaks remain close; they do not explain the four original misses.
  Compiler-only repair measurements preserve exact emitted C, so these runtime
  observations also apply to the repaired compiler.
- HTTP cleanup `46065944554` and load `46065948202` pass: 34 load trials,
  29,756,171 attempts, zero failures and successful shutdowns. All sampled
  within-trial RSS slopes are zero. This is capacity evidence, not HTTP speedup.
- Retained frame reader and docs `46067000815` pass. Cost reader/docs
  `46069448947` and repaired compiler/count reconstruction `46070965850` pass.
  Final documentation also includes all ordinary runtime and raw page-walk records.
  Runner exports `46068360511`, `46068364228`, `46068367762`, `46069093836`
  verify original archive/source identities and reconstruct raw observations.
  Only small text evidence is downloaded locally; native images stay on runners.
  Repair exports `46070520960` and `46070235418` also pass raw reconstruction.
  Runtime/stack export `46073885767` and memory export `46073880453` pass;
  all original misses remain in the retained report.
- Initial PR documentation `46074605235` exposed missing mapping-control
  `.smaps` files in the text export. The exporter now includes them and checks
  reconstruction after filtering, before publishing the archive. Its corrected
  export `46075009391` passes, including reconstruction of the filtered archive.
  Full documentation `46075387053` passes on the repair branch, including both
  retained 128-execution memory archives. Final PR gates subsequently passed;
  original native observations are unchanged. Superseded production
  `46074605382` had no reported failures before replacement; its cancellation
  is not acceptance evidence.
- Earlier failures are preserved: attribution `46062709945` needed scoped hooks
  and OpenSSL linkage; `46064688201` needed runner-generated formatting;
  `46065431503` and `46066997172` exposed fixture syntax errors, now fixed and
  verified. `46065857276` rejected a preparation-tag prefix before service
  timing; the corrected service run collects that previously unmeasured work.
  Export jobs initially needed pagination for the many skipped numerical jobs.

Local disk is about 24 GiB free. `python3 scripts/local-guard.py git diff --check`
refused below the unchanged 64 GiB floor. No local compiler or tests ran and no
limits were raised. #278 already delivered reviewed ignore rules. Local `main`
is `30fe4c7806f5ef54eda09d02f02047c9e3ed5a2d`; worktrees/stashes are preserved.

## Verified delivery

[PR #279](https://github.com/e6qu/fun-with-pipes/pull/279) squash-merged as
`30fe4c7806f5ef54eda09d02f02047c9e3ed5a2d`. It and tested head
`c2384e254940a2cbaf3d50031f63f12d716aac1c` have tree
`890bf19aae1e8972143cadcecafca4d887def38c`. The merge message is one line,
without body or trailers.

- [Production `46076028758`](https://github.com/e6qu/fun-with-pipes/actions/runs/46076028758): all nine jobs pass.
- [Documentation `46076028837`](https://github.com/e6qu/fun-with-pipes/actions/runs/46076028837), job `140763838520`: pass.
- [Complete-log audit `46086008068`](https://github.com/e6qu/fun-with-pipes/actions/runs/46086008068), job `140795617116`: all ten reports pass.
  Linux retains 257 target logs per host, regular macOS 131 and ownership macOS
  126. Each Windows host retains 57 logs covering all 155 successful started targets.
- Audit artifact `15239042326`: 1,199,711 bytes, GitHub SHA-256
  `212df2394168379c3f2ce05f4619d84978ef3d3bba3b5529840d7dd4120e15dc`.
  Original source/artifact identities were verified on the runner.
- Duplicate postmerge `46086206304` and `46086206160` were cancelled after tree
  equality was established; those cancellations are not passing-gate evidence.

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
| 8 | In progress | #279 constructed-value proof; all timing/compiler targets; lifetime/HTTP checks and final gates | Four original RSS limits; same-process accounting diagnosis |

## #278 checkout recovery and local limits

The root checkout was 133 commits behind `origin/main`; #278 fast-forwarded it
and completed recovery on `finish-delivery-hygiene`. That main already ignored
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
