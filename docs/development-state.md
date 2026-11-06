# Current work

**Next:** run the complete focused group (`numerics.yml`, suite=tape-record-checks)
after publishing the runtime/probe batch. Audit all three hosts and all targets,
then batch any repairs. Keep local work serial and guarded. No new timings until the
whole implementation and correctness batch is ready.

Branch `tape-operation-records`, worktree `.worktrees/recording-capacity-gate`.
Reference/user merge `ef0a54a1da660fcc4c4e094e96c30c1adbe0fb5d` (#266), identical
in tree to `3595f4b0cec1e37bc7874fca5e09bb176c87a1af`. Squash subject:
Finish tape-scope measurements on approved AMD hosts (#266). No body/trailers.
AMD 7763/9V74/9V45 approval persists; no decision is pending.
Contract commit `036662872` preceded implementation. The new runtime/probe batch
uses 24-byte numeric records, 8-byte typed parents and checked operation bounds.
Updated moving-allocation, partial typed growth, cancellation, registry, workspace,
raw storage observers and actual wasm32 probes. Added duplicate-parent arithmetic
order checks in interpreter/native code and a deliberately reversed native control.
The old metadata driver now compares records with the fixed #266 column runtime;
obsolete separate/interleaved choices were removed. No measurements have run.

## Roadmap status

| Step | Status | Next result |
|---|---|---|
| 1 | Implemented | Numeric records, typed parent pairs and matching interpreter operation limits; native acceptance pending. |
| 2 | In progress | Updated affected probes/readers and prepared one three-host runner batch, including actual wasm32 bounds on ARM. |
| 3 | Pending | Same-source storage/reference preparation and one complete measurement batch after correctness. |
| 4 | In progress | Retain previous full production audit; monitor merged-source CI and carry repairs into this PR. Final new-head gates remain required. |

## Carried verification

- Shared-access production `42248510976` at `e187b92d75bf936bc7191ea11eeca0c573005399`:
  all nine jobs pass. Complete runner artifact/log audit `42288455657` / `128135316320` passes
  from main, source=e187..., attempt=1, docs-job=127996978359, audit-host=all.
- #266 merge CI `42288270547` and docs `42288270157` queued. Inspect all failures.
- Original-image run `42256902374`, tool `3595f4b0...`: ARM `128026386626`, AMD
  `128026386739`, both pass. All 48 source/image/stack/inlining hashes, original
  commands and complete logs locally verified under the guard (0.25/0.90 s).
  [Retained records](measurements/recording-context-images-2026-11-06/README.md).
- Docs `42256883929` / `128026304503` pass at reviewed #266 head. Full log reviewed:
  only three intentional runner-failure controls. Repair docs `42254513622` also
  pass, including nine host-policy and eleven compiler-analysis controls.
- Approved AMD runtime `42251223529`, source `1720c3b8...`; complete audit
  `42255876958` / `128022817587` passes. Session 1 (9V45) has six long-case
  misses and 2.6728% zero-update history regression. Session 2 (7763) has eight
  long-case misses, 3.2922% one-update history regression, and 2.0091% copy variation
  on 3/1999 current. All seventeen misses retained; never rerun qualified sessions.

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

## Local and delivery rules

Guarded focused Rust formatting passes (0.13 s). Python syntax, actual raw
allocation hooks/missing-hook rejection, workflow sizes, plan/handoff and contract
subject checks pass (0.13 s). Actionlint syntax/expressions pass (0.13 s;
shellcheck/pyflakes disabled). No local native builds, suites or timing runs.
All 49 focused Python controls pass: capacity/context/lookup reference readers,
derivative ownership profiles, depth and retained timing groups. The first run
found missing historical fixture files in this sparse worktree; restored only
their small tracked reports/logs and reran the affected controls (19.06 s,
9.55 s sampled CPU). No fixture data or acceptance limits were changed.

Use `python3 scripts/local-guard.py COMMAND...` for focused checks. No local full
builds, suites, benchmarks or large regeneration. Last free disk 73 GiB; retain
64 GiB. Large original audits stay on runners; keep only needed small sparse files.
The user has 20 parallel hosted jobs: wait for busy runners, do not infer billing
restrictions or restart queued work. Group repairs and docs before full final CI.

Retain all earlier timing misses and inconclusive controls. All nine exact-head
production jobs, docs and complete audits must pass before our squash merge.
Commit/squash messages: one line, <=80 characters, no body/trailers/attribution.
Continue the plan after verified delivery; a completed PR does not close it.
