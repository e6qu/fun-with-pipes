# Current work

**Next:** publish the approved host-policy change and request only the two missing
AMD64 runtime sessions. Use `recording-context-time`, `native_runner=ubuntu-latest`,
`comparison_session=both`, `evidence_run=42213041403`. Monitor the merged source's
production run alongside them; audit and fix every failed job before a repair push.

Worktree `.worktrees/recording-capacity-gate`, branch `recording-context-verification`.
PR #265 is merged; open the next coherent PR for hardware qualification, missing
measurements, original-image verification, discovered repairs and final delivery.
The user approved EPYC 7763, 9V74 and 9V45 on 6 November. No decision is pending.

## Roadmap status

| Step | Status | Next result |
|---|---|---|
| 1 | Implemented | Three-model qualification, exact-host recheck, reader restrictions and future compiler-cost qualification. Focused controls pass; publish the amendment before AMD timing. |
| 2 | Pending | Two AMD runtime sessions and complete evidence audit; preserve all ARM results and old host rejections. |
| 3 | Pending | Original session-1 native images on both architectures; source/phase review for the next optimization. |
| 4 | In progress | Merged-source production matrix queued; final next-PR head still needs nine jobs, docs and complete audit before squash merge. |

## Merge and current CI

User merge `e187b92d75bf936bc7191ea11eeca0c573005399` equals review head
`db94106b3ad2e8c65a384379c653bd395069b5fb` at tree
`26c54d4b20611841e36f6c465e837a5474fdad94`. The actual squash subject is one line,
with no body/trailers: Reuse validated tape access across numeric
calls and loops (#265). The user merged before final production acceptance.

- Main production run `42248510976`: bench passes; five jobs running and three queued at last check. Complete bench log has no unexpected diagnostics.
  Bench `127996982688`; Linux ARM `127996983403`, AMD `127996983681`;
  macOS regular ARM `127996983198`, AMD `127996983302`;
  macOS ownership ARM `127996983804`, AMD `127996983252`;
  Windows ARM `127996983442`, AMD `127996983555`.
- Main docs `42248509969` queued. Review-head docs `42235592916` /
  `127952223193` passed; complete log reviewed with only its three intentional
  runner-failure controls. Logs/identities: `/tmp/fwp-context-merged-{review-docs,bench}*`.
- Superseded docs `42233681205` was confirmed cancelled. Draft production skips
  are not gates. Leave current queued jobs in place.

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
| `42228557375` AMD replacements; audit `42231927387` / `127939715479` | Both rejected before build/timing. No AMD samples exist. |

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

After AMD timing/audits, commit an image input plan selecting session 1 per
architecture with protocol `recording-context`. Use the ARM source/index above
and the new AMD source/index. Require append inlining for both reference and
candidate; reconstruct all 48 original hashes with matching C/GCC/flags and no
execution/retiming. Then finish exact-final-head gates and complete audit.
Squash merge with an explicit one-line subject <=80 characters and empty body;
verify message and tested/merged tree equality. Continue the plan afterward.

## Local checks and runner queue

Use `scripts/local-guard.py`; last free space 74 GiB. No local native builds,
full suites or benchmarks. Nine focused host-policy/schedule controls pass
(0.13 s guard): approved/unknown CPUs, all other requirements, altered policy,
historical exact-host records and changed CPU within a session. Both completed ARM reports validate with the amended reader; all production
source trees match the native proof. Python syntax, handoff, merge subject and
workflow size pass (guard, 1.22 s); actionlint syntax/expressions pass (0.25 s,
shellcheck/pyflakes disabled). A scratch check initially omitted the scripts
import path; corrected before rerunning it. No production defect was involved. The branch switch removed sparse measurement files; restore only
needed small tracked records, not all historical archives.

The user has a free GitHub account with 20 parallel jobs. Wait for busy hosted
runners; do not infer account restrictions or restart queued work.
