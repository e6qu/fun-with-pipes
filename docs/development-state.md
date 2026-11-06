# Current work

**Next:** finish the census/runtime evidence audits and resolve the pending
CPU-policy question before requesting more AMD64 timings. Source for every run is
`319782736b0a983022f2a48879b35c9e57992949`. Audit every failed job and completed
result; do not repeat qualified timings or passing native suites.

| Run | Suite | Last result |
|---|---|---|
| `42224646191` | recording-context-census | Both passed; full producer logs clean. Complete archive audit queued below. |
| `42224658244` | recording-context-analysis | Both reported time/RSS/copy limits pass; full audit passes. AMD CPU was 9V74, so frozen-host acceptance is pending the policy decision. |
| `42224669329` | recording-context-time | Both ARM sessions complete with eight long-case speed misses each; small/copy limits pass. Both AMD hosts rejected before building/timing. |
| `42228557375` | recording-context-time, AMD replacements only | Both rejected before build/timing: 9V74 and 9V45 again. No AMD samples exist. |
| `42228884598` | recording-context-compiler-report | Passed; full log and 12.3 MB audit archive verified. Records retained in recording-context-analysis-2026-11-06. |
| `42229061410` | recording-context-census-report | Dispatched for the completed census run. |
| `42230424553` | recording-context-report | Dispatched for original ARM sessions and rejected AMD hosts. |
| `42231927387` | recording-context-report | Dispatched for replacement AMD host rejections. |

Initial job IDs: census ARM `127914973561`, AMD `127914973641`; compiler analysis
ARM `127915006870`, AMD `127915007195`; time ARM sessions 1/2
`127915047727` / `127915047757`, AMD sessions 1/2 `127915047834` / `127915047762`.
Replacement AMD jobs: session 1 `127928229175`, session 2 `127928229350`.
Compiler-report job `127929341718`; census-report job `127929948850`.

AMD rejections: session 1 EPYC 9V74; session 2 EPYC 9V45; required EPYC 7763.
Both failed only qualification; builds and timings were skipped. Full logs and
small archive hashes verified. Artifacts `13506258100` / `13505828703`;
`/tmp/fwp-context-time-amd{1,2}-rejected{.zip,.log,-job.json,-artifact.json}`.
Replacement rejection logs: `/tmp/fwp-context-time-amd{1,2}-replacement-rejected{.log,-job.json}`. Both full logs reviewed; only qualification failed.
Replacement used native_runner=ubuntu-latest, comparison_session=both; all runs
use evidence_run=42213041403. Do not replace a host that has qualified and timed.

ARM runtime full logs reviewed: only the expected final budget assertion fails.
Session 1 long cases range 2.085% slower to 2.367% faster; session 2 ranges
1.963% slower to 2.477% faster. All 16 required 5% targets remain open; small-case
and identical-copy limits pass. Do not rerun either qualified ARM session.
Records: `/tmp/fwp-context-time-arm{1,2}-job.log`, `-job.json`, `-limit-misses.json`.

Pending question (not answered yet): explicitly allow EPYC 7763, 9V74 and 9V45
as matched-session peers, retaining exact hardware and all other frozen settings,
or require EPYC 7763 for all timing. The compiler-cost workflow recorded CPU but
never enforced the runtime CPU filter, and its AMD report is 9V74. The new README
labels those results observations pending this decision. Do not quietly treat
that hardware requirement as met or change the protocol without an answer.

Next: finish the report audits, runtime report for each completed
original/replacement run, then original-image checks on runners. Retain all
limits/misses before final production delivery. Large originals stay on runners.

[Draft PR #265](https://github.com/e6qu/fun-with-pipes/pull/265) is the only active PR.
Worktree `.worktrees/recording-capacity-gate`, branch `recording-context-scopes`.
Measurement/tool source: `319782736b0a983022f2a48879b35c9e57992949`.
Native source: `49371e06f5bba4598273a1b807140775dde64c57`; subsequent commits
change only evidence readers and docs. Base: `d992a5734a12cf976c1ca20f75e9829a18bde0cc`.
Documentation/evidence updates retain the passing full focused audit, compiler
cost observations with their CPU caveat and the observed ARM timing misses.

## Roadmap status

| Step | Status | Next result |
|---|---|---|
| 1 | Verified | Contract and #264 delivery frozen in `5dc8efd02` before production edits. |
| 2 | Implemented | Numeric call forwarding and loop scopes pass focused checks. Final matrix pending. |
| 3 | In progress | Focused/reference checks and full audit pass. Single measurement batch dispatched. |
| 4 | Pending | Nine final-head production jobs/docs, complete audit and verified squash merge. |

## Passing verification

[Complete records and repairs](measurements/recording-context-checks-2026-11-06/README.md).

| Run / job | Result |
|---|---|
| `42213041403`: AMD `127876137274`, ARM `127876137456`, mac `127876137522` | 25/25 native targets per host; 305 compiler units pass, four existing runner-only exclusions. All complete logs clean. Recovery probe passes. |
| `42213046373` / `127876155092` | Eight raw/optimized emitted-C comparisons match the delivered compiler with new scopes disabled. Full log clean. |
| `42213039124` / `127876122034` | Native-source docs pass; only expected failure-control diagnostics. |
| `42218866499` / `127895597129` | Earlier pagination-tool docs pass; full log reviewed. |
| `42221400241` / `127904076811` | Full focused audit passes: 75 targets, 2,682 native images, 2,730 probe observations; no issues. |
| `42221406301` / `127904085671` | Current docs pass; seven audit controls and clean complete log. |

Full audit artifact `13503834185`, 7,293,923 bytes, hash
`20e47ac1fab25227ae167f7b6dae717e1645eb01f0052efb12e3cd2c66da0c35`.
Retained in `docs/measurements/recording-context-checks-2026-11-06/audit.zip`.
Source/hash, retained-record hashes and complete audit log verified locally.
Large native archives stayed on runners. Draft production skips are not gates.

## Implementation and repaired failures

The [frozen contract](measurements/recording-context-scopes.md) governs this group.
Depth 64/expression 4096/type 32 proof limits are unchanged. Repeated recording
workers and selected pair-map/fold callbacks start separate scopes; proven numeric
callees borrow state. Standalone single-append workers gain none. Unknown calls,
task ticks, lifecycle operations, reentry and resource cleanup remain excluded.
Tape-ID changes still validate. No runtime wrapper or public setting was added.

- The loop harness recovered traps in a fixture with FWP_UNWIND=0. Commit
  `49371e06f` adds a real typed attempt boundary and requires FWP_UNWIND=1.
  All alias, failure, lookup and exact-release assertions now pass on three hosts.
- Evidence readers previously truncated job/artifact listings at 100 entries.
  The native run has 128 jobs. Shared explicit pagination rejects truncation,
  duplicate IDs and changing totals; affected census/compiler/diagnostic readers
  are repaired too.
- Audit `42220789909` failed because the ZIP writer local shadowed the new records
  function; upload then had no output. `319782736` renames it and adds a real
  entry-point control with later-page jobs, native headers and a missing-target
  rejection. All seven controls pass; the repaired full audit passes above.

## Measurement and delivery rules

The contract specifies native Neoverse N2/EPYC 7763 with fixed inputs, flags,
sessions and limits; any AMD CPU change awaits the explicit decision above.
Target two registry lookups per positive update instead of 3*(N-1); the complete
census archive audit is queued. ARM runtime limits are reported above.
Allocation/retain counts, eight nodes per pair, validation and final storage
must stay unchanged.

Retain all timing misses and inconclusive copy controls. Replace only hosts
rejected before building/timing; never rerun qualified unchanged samples for a
pass. Full census/compiler/runtime audits and original-image checks run on GitHub.
Final delivery still needs all nine exact-head production jobs, docs and full
audit, then an explicit one-line squash subject <=80 characters and empty body.
Verify the actual merge message and tested/merged tree equality.

## Local work and queue

Use `scripts/local-guard.py`; last free space 74 GiB. No local native build,
full suite, benchmark or large audit ran. Seven audit controls, changed Python
and embedded workflow syntax, handoff/links and workflow size pass. Actionlint
syntax/expressions pass with shellcheck/pyflakes disabled. Small log/archive
reviews took 0.12–0.13 s; actual 128-job metadata review took 2.63 s.
Changed PLAN/design link checks initially hit sparse-checkout omissions; 95
small tracked targets were restored unchanged from HEAD, then all changed-document
checks passed. Git restore needed normal authorized index access.
A scratch preflight review expected the earlier 304-unit count; corrected to
retain the actual 305 passing units. No native assertion was weakened.

Source lifetime review found no additional defect: numeric-only proof, separate
map/fold state after setup, fresh ordinary/exported entries, preserved ID checks
and ownership lowering without resource callbacks. Changed docs/handoff links
pass (guard, 0.13 s); `git diff --check` is clean. No native suite was repeated.

The user has a free GitHub account with a 20-job parallel limit. Wait for occupied
hosted runners; do not infer restrictions from queue time or restart queued work.
Superseded queued docs `42217822914` was confirmed cancelled. Keep current runs.
[PR #264 delivery](measurements/recording-capacity-delivery-2026-11-06/README.md)
is verified; its timing misses and all earlier misses remain in PLAN.md.
