# Current work

**Next:** publish the complete evidence/documentation head, mark PR #260 ready,
then monitor its nine exact-head production jobs plus docs. All focused and
saved-data audits pass. Runtime measured source:
`373955e82a74d8de2eb12ff2b81f6cc74c089e5e` (tag
`roadmap/packed-pair-cleanup-census-2026-11-05`). All four sessions completed;
retain the 34 timing misses under the agreed policy. Do not repeat measurements.

Runtime `42018849842` supplies ARM64 session 1 and AMD64 session 2 (audit
`42021767931` passes); `42020017429` supplies ARM64 session 2 (audit
`42022105422` passes); `42020313941` supplies AMD64 session 1 (audit
`42023850878` passes). Rejected hosts never built/timed; all records are retained.

## Roadmap status

[PLAN.md](../PLAN.md) and this table track the same five delivery steps.

| Step | Status | Work |
|---|---|---|
| 1 | Verified | The unchanged private helper consumes input; borrowing/escape contracts agree. |
| 2 | Verified | Reuse with one protected owner; keep two owners only when allocating output. |
| 3 | Verified | Aliases, both layouts, bits, traps/cancellation and physical frees pass on three hosts. |
| 4 | Verified | Four complete sessions and full audits; 34 timing misses remain open, all other measurement gates pass. |
| 5 | In progress | Evidence retained; publish final head, pass nine production jobs plus docs, audit and squash merge. |

## Branch and source identities

- Draft [PR #260](https://github.com/e6qu/fun-with-pipes/pull/260), worktree
  `.worktrees/packed-pair-storage`, branch `packed-pair-storage`.
- Compiler repair `14707729042f3202527998296ec8c5f196615cb0`. It changes
  `src/cgen.rs`, the selection/native controls and a stack preflight in the census.
  Observer repair ecdf2476 passes focused checks. Measured head 373955e8
  adds explicit dynamic-memory stack commands; later commits through fa61a619
  add audits, controls, retained observations and docs. Compiler/runtime/library/
  native-test sources still match ecdf2476. Failed-run artifact audit `42013195562` accounted for all 25 targets, 775 images
  and 791 probes per host; only the recorded failures were found.
- [Repair protocol](measurements/packed-pair-cleanup-repair.md) was committed before
  code at `54a3ae468d3751d3d2ac2972777dc054da905d9d`. No thresholds changed.
- Original [contract](measurements/packed-pair-storage.md) at `3b7954ee`, tag
  `roadmap/packed-pair-storage-protocol-2026-11-05`.
- PR #259 is verified and merged as `cbb779446162efa71301f64350662f2c7c0d8073`.
  Its tree equals tested e3a2e1d3; all nine production jobs, docs and complete log
  audits pass. [Delivery record](measurements/gradient-call-delivery-2026-11-05.json)
  retains the tree/message/gates. Its 17 timing misses remain open in PLAN.md.

## Verification and measurements

Original [focused results](measurements/packed-pair-checks-2026-11-05.md) and
measurements remain separate from the repaired implementation below.

| Evidence | Source and result |
|---|---|
| [Original census](measurements/packed-pair-census-2026-11-05.md) | e4d645cd, run 42003323499; both architectures pass. Artifact audit 42008501553 passes. |
| [Original compiler costs](measurements/packed-pair-analysis-2026-11-05/README.md) | a1f18947, run 42005106056; both pass. Full audit 42008507459 passes. |
| [Original runtime](measurements/packed-pair-time-2026-11-05/README.md) | a1f18947, run 42005111118; three sessions, 23 speed misses and one AMD64 stack failure. Full retained-data audit 42009905049 passes. |
| Repaired native checks | ecdf2476, run 42013253058; all 25 targets and controls pass per host after the observer/formatting repair. |
| Repaired full audit | 42015894951 passes: 25 targets, 822 images and 838 probes per host. |
| [Repaired stack/counts](measurements/packed-pair-cleanup-census-2026-11-05/README.md) | 373955e8, run 42015900941; both pass. Full audit 42018351007 passes. |
| [Repaired compiler costs](measurements/packed-pair-cleanup-analysis-2026-11-05/README.md) | 373955e8, run 42017186500; both pass. Full audit 42018554796 passes. |
| [Repaired runtime](measurements/packed-pair-cleanup-time-2026-11-05/README.md) | Four sessions complete, all audits pass; 32 long-case misses plus AMD64 zero-update 2.2158% and one-update 2.8315% regressions. |
| Repaired docs | 84c0eeaf run 42018338260 passes. Evidence head fa61a619 run 42019150880 passes. |

Fresh 129/199 results, independently reproduced after the repair: 727 -> 528 requests and 1,034,366 -> 625,222
requested bytes; peak managed storage 9,248 -> 7,200 bytes. Retains/raw derivative
storage are unchanged; final storage is zero. Compact reports/observations are
committed. Large generated archives remain in their digest-identified artifacts.

The first reuse implementation protected one allocation twice, then cleared one
owner. The repair keeps the original owner through mapping and returns it directly.
All 12 reported frame maxima on each architecture equal their allocating
references. Full audit 42018351007 independently verifies them. Dynamic entries
remain explicit; reported bytes are not total call-stack bounds. The preflight
compiles the same
six complete workloads, both forms and both compilers at GCC O2; it records all
frame-limit failures before allocation or timing work. Source/C/images/output and
stack reports remain in `pair-stack/` inside the census artifact.

AMD64 session 2 never measured: original run and replacements 42008084704,
42008513001 and 42009708231 rejected EPYC 9V74/9V45 before building. The frozen
host is EPYC 7763. All host reports/logs are retained in the runtime evidence;
stop requesting the old candidate. Never repeat unchanged timing for a pass.

## Documentation and audit repairs

Docs 42011765327 rejected nonstandard status labels in the handoff. Both offending
rows now use the existing vocabulary (Verified/In progress); their explanations
remain in the work column. The two completed audit-control scripts passed; later
checks had not run. Full failed log: [status-label repair](measurements/packed-pair-docs-status-2026-11-05.log.gz).
No validation rule was relaxed. Repair docs 42012233154 pass.
Saved-stack audit 42017767534 initially rejected a valid GCC dynamic entry.
The corrected audit retains dynamic entries separately, recomputes unchanged
limits and passes at 42018351007. Both architectures are audited even if one fails.
Failure receipt/log and seven passing controls are in cleanup-checks evidence.

## Repairs already verified

- Full-history/tag checkout fixes the five historical-source control errors:
  42002432263 passes all eight scripts/76 tests. Original 42000589145 is retained.
- Census retention now separates outer/nested archive paths, rejects duplicates
  and rereads hashes. Audit 42008501553 passes without warnings; the original
  four duplicate-name warnings remain at 42006250074. No measured program reran.
- Mocked audit output is captured only in its unit test; real diagnostic filters
  stay strict. Documentation runs at a1f18947, 1203b457 and 4eb6ec6a pass.

## Local resource limits

Free disk fell below 1 GiB; removing 399,065,683 bytes of verified duplicate
original downloads recovered about 1.27 GiB. Latest free space is about 17 GiB. Keep local native checks/builds and
large original-artifact downloads stopped below the 64 GiB reserve. Both task
build directories are empty. Other projects remain untouched; the user was asked
to pause other disk-heavy work/free space. Small audited retention bundles were
copied into docs; no native program or measurement ran locally.

Cleanup receipts are in `../gradient-work/removed-verified-downloads-2026-11-05-{pair-preparation,disk-emergency}.json`.
They retain original artifact identities, logs, reports and earlier verified copies.
Before the disk drop, guarded formatting, inventory/shard and reference/budget
checks passed; receipts are `../gradient-work/packed-pair-{reference-checks,inventory}.json`.
All current validation runs on GitHub. Final production gates have not started;
draft skips are not acceptance. Keep one active PR and squash only after all final
checks and log audits pass, with one <=80-character subject and an empty body.
