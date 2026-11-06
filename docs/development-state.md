# Current work

**Next:** publish the retained AMD evidence and original-image input plan, then
dispatch its verification. Monitor merged-source
production jobs; audit every failed step and completed target. Batch repairs and
evidence before the final PR matrix. Do not repeat qualified measurements.

[Draft PR #266](https://github.com/e6qu/fun-with-pipes/pull/266) is the only active PR.
Worktree `.worktrees/recording-capacity-gate`, branch `recording-context-verification`.
The user approved EPYC 7763, 9V74 and 9V45 on 6 November. No decision is pending.

AMD runtime run `42251223529`, source `1720c3b8cd06d7756295186233181cd64544bf44`:
both sessions completed, failing only the final timing limits. Session 1 job
`128006547069` has six long-case speed misses and a 2.673% zero-update history
regression. Session 2 job `128006547098` has eight long-case speed misses, a
3.292% one-update history regression and 2.009% identical-copy variation on
3/1999 current (inconclusive against 2%). Both complete logs reviewed under the
guard (0.13 s): no other diagnostics. Session 2's actual CPU is EPYC 7763;
its record explicitly allows all three approved models. Small host artifact
`13520077385` source/digest verified in `/tmp/fwp-context-approved-amd2-host*`.
Dispatch used native_runner=ubuntu-latest, comparison_session=both,
evidence_run=42213041403. Never restart a qualified session for a passing result.
Complete archive audit `42255876958` / `128022817587` passes at tool source
`5d66906be56d771ca2fcd5584a89a2ec0ace85dd`, measured source `1720c3b8...`.
Session 1 used 9V45; session 2 used 7763. Compact artifact `13521838079`, 505,070
bytes, SHA-256 `3d0559a6760cf2a3f345b0157b7da2591eeeb4f7d1e3bfa33bfc1278ce742379`.
Local retention check passes (0.24 s): complete audit log, both producer/report
hashes and all seventeen misses. Large retained artifact `13522617467` remains
on GitHub (29,984,310 bytes); identity/digest retained with the compact records.

Policy-head docs `42251227613` / `128006538642` pass. Full log reviewed: only
three intentional test-runner failure controls. Native source trees still match
`49371e06f5bba4598273a1b807140775dde64c57`; policy/evidence edits do not require
repeating the completed native focused run or compiler-cost measurements.

## Roadmap status

| Step | Status | Next result |
|---|---|---|
| 1 | Implemented | Three-model qualification, exact-host recheck, reader restrictions and future compiler-cost qualification. Focused controls pass; amendment published before AMD timing. |
| 2 | Verified | Both AMD sessions and complete archive audit retained, including every miss, all ARM results and old host rejections. Timing acceptance remains open. |
| 3 | Pending | Original session-1 native images on both architectures; source/phase review for the next optimization. |
| 4 | In progress | Merged-source production matrix running; final next-PR head still needs nine jobs, docs and complete audit before squash merge. |

## Merge and current CI

User merge `e187b92d75bf936bc7191ea11eeca0c573005399` equals review head
`db94106b3ad2e8c65a384379c653bd395069b5fb` at tree
`26c54d4b20611841e36f6c465e837a5474fdad94`. The actual squash subject is one line,
with no body/trailers: Reuse validated tape access across numeric
calls and loops (#265). The user merged before final production acceptance.

- Main production run `42248510976`: bench passes; six jobs running and two queued at last check. Complete bench log has no unexpected diagnostics.
  Bench `127996982688`; Linux ARM `127996983403`, AMD `127996983681`;
  macOS regular ARM `127996983198`, AMD `127996983302`;
  macOS ownership ARM `127996983804`, AMD `127996983252`;
  Windows ARM `127996983442`, AMD `127996983555`.
- Main docs `42248509969` / `127996978359` pass; complete log reviewed. Review-head docs `42235592916` /
  `127952223193` passed; complete log reviewed with only its three intentional
  runner-failure controls. Logs/identities: `/tmp/fwp-context-merged-{review-docs,bench}*`.
- Superseded docs `42233681205` was confirmed cancelled. Draft production skips
  are not gates. Leave current queued jobs in place.
- PR #266 was marked ready while evidence was unfinished. Returned it to draft
  to batch the remaining records before final production CI. Intermediate matrices
  `42252415868` and `42254513671` are confirmed cancelled; the latter's nine jobs
  were all queued. Main verification continues. Current docs `42254513622` queued.

## Measurements already completed

Producer/tool source `319782736b0a983022f2a48879b35c9e57992949`.
Native compiler/fixture source `49371e06f5bba4598273a1b807140775dde64c57`.
Subsequent edits affect measurement tools/docs only; do not repeat native focused
checks without a production change. Verify source-tree equality in preflight.

| Run | Result and records |
|---|---|
| `42224646191` census; audit `42229061410` / `127929948850` | Both architectures pass. [Receipts](measurements/recording-context-census-2026-11-06/README.md): two lookups/update instead of 3*(N-1), unchanged allocation/retain/node/check counts, peaks and largest frames; zero final tracked storage. |
| `42224658244` compiler costs; audit `42228884598` / `127929341718` | All fourteen time/RSS/copy limits pass. ARM N2 and AMD 9V74; the user accepts 9V74 under the explicit amendment. [Reports](measurements/recording-context-analysis-2026-11-06/README.md). Do not repeat. |
| `42224669329` runtime; audit `42230424553` / `127934609454` | Both ARM sessions complete, eight long-case 5% misses each; small/copy limits pass. Both AMD hosts rejected before build/timing. [Results](measurements/recording-context-time-2026-11-06/README.md). |
| `42228557375` AMD replacements; audit `42231927387` / `127939715479` | Both rejected before build/timing. These rejected hosts supplied no samples. New qualified AMD samples are in `42251223529`. |

Original and replacement AMD session 1 used 9V74, session 2 used 9V45; their
rejections remain historical outcomes. Existing ARM session 1/2 jobs are
`127915047727` / `127915047757`; never rerun these qualified sessions. All producer
logs and audit logs were reviewed. Compact census/runtime archive digests,
4,038 observation hashes, six log hashes and two report hashes pass local guarded
checks (0.25 s each). Large original archives stayed on runners.

## Correctness and previous repairs

[Complete records](measurements/recording-context-checks-2026-11-06/README.md):

- Native run `42213041403`: 25 targets and 305 compiler tests per host, all pass;
  four existing runner-only exclusions. AMD/ARM/mac jobs `127876137274`,
  `127876137456`, `127876137522`. Full focused audit `42221400241` /
  `127904076811`: 2,682 native images, 2,730 probe observations, no issues.
- Parent reference `42213046373` / `127876155092`: eight raw/optimized generated-C
  comparisons match the delivered compiler with new scopes disabled.
- Tool-source docs `42221406301` / `127904085671` pass; complete log reviewed.
- Recovered-trap fixture needed a real `attempt` boundary (FWP_UNWIND=1).
  Pagination readers needed all 128 job records. The audit ZIP writer shadowed
  the imported `records` function. All three repairs are verified and retained.

## Remaining protocol and delivery rules

The [hardware amendment](measurements/recording-context-scopes.md#approved-hardware-amendment-6-november-2026)
changes CPU qualification only. All inputs, toolchains, flags, sample counts,
core count and timing limits remain fixed. Keep exact CPU per session; candidate
and reference share that host. No timing miss becomes a pass through this change.
Future compiler-cost runs now qualify before building; completed costs are retained.

The image input plan selects session 1 per
architecture with protocol `recording-context`. Use the ARM source/index above
and the new AMD source/index. It requires append inlining for both reference and
candidate; reconstruct all 48 original hashes with matching C/GCC/flags and no
execution/retiming. Then finish exact-final-head gates and complete audit.
Squash merge with an explicit one-line subject <=80 characters and empty body;
verify message and tested/merged tree equality. Continue the plan afterward.

## Local checks and runner queue

Use `scripts/local-guard.py`; last free space 73 GiB. No local native builds,
full suites or benchmarks. Nine focused host-policy/schedule controls pass
(0.13 s guard): approved/unknown CPUs, all other requirements, altered policy,
historical exact-host records and changed CPU within a session. Both completed ARM reports validate with the amended reader; all production
source trees match the native proof. Python syntax, handoff, merge subject and
workflow size pass (guard, 1.22 s); actionlint syntax/expressions pass (0.25 s,
shellcheck/pyflakes disabled). A scratch check initially omitted the scripts
import path; corrected before rerunning it. No production defect was involved. The branch switch removed sparse measurement files; restore only
needed small tracked records, not all historical archives.
Latest evidence checks: `python3 scripts/local-guard.py python3
/tmp/fwp-context-retain-approved.py` passes (0.24 s). Guarded image-plan,
plan/handoff, workflow-size, production-tree equality and whitespace checks pass
(0.12 s). Full documentation links run in CI's complete checkout.

The user has a free GitHub account with 20 parallel jobs. Wait for busy hosted
runners; do not infer account restrictions or restart queued work.

## Audit repair and next source investigation

The new compiler-cost host gate exposed an audit assumption: it expected a
measurement archive containing samples after any failure. Rejected hosts instead
have only qualification and preflight artifacts. The reader now verifies both
archives, skipped build/timing steps and the exact mismatch, retaining a rejected
outcome without inventing samples. Eleven compiler-analysis controls pass (guard,
4.63 s), including the actual audit entry point and seven corrupt-record cases.
These changes do not affect the running runtime measurements.

[Next layout candidate](measurements/recording-context-next-layout.md): investigate
keeping each numeric operation's parents/weights in one record. Large-case saved
ARM phase medians place about 57% in recording and 37% in reverse traversal;
instrumentation adds 2–3.4%. Small-case instrumentation adds 42–49%, so it cannot
establish a small-case bottleneck. Source review identifies four columns and two
capacity-growth moves; no cache-miss cause or speedup is established. Finish this
group before freezing a layout implementation. Saved AMD phase medians put
93.6% of the large case in recording plus reverse traversal, consistent with
the source investigation but not proof of a layout cause. Small-case diagnostic
overhead is 20–57%; the large AMD1 diagnostic is 2.1% faster than ordinary, so
phase instrumentation cannot be treated as an exact additive cost model.
