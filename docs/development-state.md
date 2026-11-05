# Current work

**Next:** watch the final production matrix for PR #258’s latest published head;
audit every completed job and repair any new failure before merge. The retained
evidence batch is ready for publication and `ready_for_review` dispatch. Also
finish auditing old production run `41931018786`.
All expanded focused checks at repair `bc1bf40ea0c8ad7733b9042e2b552ae261970dce`
([run 41937012404](https://github.com/e6qu/fun-with-pipes/actions/runs/41937012404))
pass their full log, source-selection, native-image and control audits.
Do not merge the failed `f71b5308` head.

[PR #258](https://github.com/e6qu/fun-with-pipes/pull/258) is the only open PR,
Focused verification is complete; final production delivery is pending.
Branch/worktree: `owned-numeric-updates` /
`.worktrees/owned-numeric-updates`. Keep unrelated primary-worktree edits intact.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve frozen ownership, selection and measurement contracts |
| 2 | Verified | Three hosts: 110 integrations, 722 images and 733 recorded outcomes each |
| 3 | Verified | Preserve four AMD64 5% misses and the separate older performance goals |
| 4 | In progress | Nine exact-head production jobs plus docs; audit logs; verify squash/tree |

## Current failure and repair

[Production 41931018786](https://github.com/e6qu/fun-with-pipes/actions/runs/41931018786)
uses `f71b53080008923ea40af8deb6c5cd6b60ca041c`. Regular macOS ARM64
`126927610517` fails only `float_formats::scalar_array_identity_moves_owners_and_preserves_aliases`.
All 131 target logs and the full job log were audited. The probe wrongly requires
a fresh allocation when the earlier identity rewrite is disabled; native ownership
lowering now safely reuses the exclusive input. Original exit 82 is reproduced.

The [repair receipt](measurements/owned-numeric-ci-repair-2026-11-05/README.md)
retains the failure and local O1/O2 controls. Expectations now distinguish identity
elimination, exclusive-array reuse, shared arrays/views and disabled reuse.
The Rust harness checks actual operation selection. The focused workflow includes
`float_formats` in lint and execution. Compiler/runtime/library code is unchanged.
The saved crash report is the passing intentional cleanup-abort control, not a
recurrence of the [unexplained historical abort](measurements/compiler-abort.md).

Completed passing full/target-log audits: both macOS ownership jobs
`126927610766` / `126927610478`, benchmark `126927610309`, docs `126928374140`
(docs run `41931242053`). Windows AMD64 `126927610561` finished: 154 target
commands pass, only `float_formats` fails. Both Windows TLS archives (100 logs
each) and regular macOS Intel's 131 logs report the same eight exit-82 probes;
no separate failure was found. All currently published target/corpus logs are
audited. Linux jobs and Windows ARM64/regular macOS Intel are still running.
Continue checking every newly completed target; old results cannot qualify the
repaired final head.

Scratch: `../gradient-work/owned-numeric-platforms-258`. Its `failure-mac-arm`
folder holds exact C, original archives and local repaired probes; `interim`
contains every available target/corpus artifact audited before publication.
Use `owned-numeric-final-status.py` to poll the old run. Full collection command:

```sh
python3 scripts/local-guard.py python3 ../gradient-work/collect-matched-option-platforms.py \
  --run 41931018786 --source f71b53080008923ea40af8deb6c5cd6b60ca041c \
  --docs-job 126928374140 --output ../gradient-work/owned-numeric-platforms-258
```

It intentionally fails on the recorded macOS test failure. Do not relabel it.
Use a new collection directory/source for the repaired head. Mark ready only after
focused checks pass; draft synchronize skips are not production gates. Require all
nine production jobs plus docs for the final head, audit every full/target log,
then squash with an explicit subject ≤80 characters and empty body. Verify the
raw one-line commit message and equality of merged/tested trees.

## Completed measurements: preserve, do not repeat

Frozen compiler source: `07541ff956d582bb9c3936b86261e43fa25b0b2f`, immutable tag
`roadmap/owned-numeric-measurement-2026-11-05`. Later changes retain evidence,
update docs and repair tests/workflow. Do not move tags or repeat unchanged timings.

| Evidence | Audited result |
|---|---|
| [Native checks](measurements/owned-numeric-checks-2026-11-05/README.md), run `41920964943` | Three hosts: 285 units, 103 integrations/18 targets, 660 images, 671 statuses; new regression target still needs verification |
| [Allocation census](measurements/owned-numeric-census-2026-11-05/README.md), `41925013907` | All six inputs, both forms and workspace settings match predictions; final managed/raw storage zero |
| [Compiler cost](measurements/owned-numeric-analysis-2026-11-05/README.md), `41926855499` | Both hosts pass time/RSS and identical-copy limits |
| [Runtime](measurements/owned-numeric-time-2026-11-05/README.md), `41926862701` + qualified replacement `41927345094` | All four sessions independently audited by `41929272270` / `41929960201`; four AMD64 speed targets remain missed |

At 129 coordinates/199 updates, save 25,741 requests and 819,968 requested bytes
per solve; retains and raw derivative storage are unchanged. Long solves take
3.36–10.50% less time; process RAM is not consistently lower. Preserve all four
missed limits and every older goal in [PLAN.md](../PLAN.md).

Scratch helpers live in `../gradient-work`. Collect new focused evidence serially
with `collect-owned-numeric-regression.py --run 41937012404 --source bc1bf40ea0c8ad7733b9042e2b552ae261970dce
--host arm|amd|mac --output ../gradient-work/owned-numeric-checks-6`. Older helpers:
`collect-owned-numeric-checks.py`, `audit-owned-numeric-success.py`, census/analysis/runtime collectors and retained
`owned-numeric-checks-5`, `owned-numeric-census-2026-11-05`,
`owned-numeric-analysis-2026-11-05`. Use `audit-owned-numeric-regression.py` for the expanded nineteenth
`float_formats` target: 110 integrations, 722 images and 733 statuses, including
all 62 new float-format probe outcomes. Preserve the old 18-target receipt. Earlier failed runs
remain in `owned-numeric-checks-2`, `-3`, `-4` and linked historical evidence.

## Local checks and resources

All workloads use `scripts/local-guard.py`; full builds/suites/timing stay on runners.
Repaired saved-C probes: O1 3.83s, O2 3.76s; each verifies original failure plus
24 repaired/control executions. Rust harness formatting: 0.14s. Evidence retention:
0.50s. Interim target audit: 7.75s. Coverage: 0.14s, all 255 native targets assigned
and all 19 focused targets valid. Documentation audit after condensation: 2.42s; 279 link sets pass.

Archived the merged #257 checkout's only dirty handoff/patch under
`../gradient-work/archived-packed-input-checkout-2026-11-05`, verified its tree
against squash `30c2bad9`, then removed that duplicate checkout (0.62s). Its branch
and evidence remain. Free disk was 65.769 GiB afterward; keep at least 64 GiB.
Windows evidence downloads are large. Other dirty worktrees remain untouched.
Two contradictory “pending” statements in #257's measurement pages are repaired
in this batch; the linked completed receipts and original measurements are unchanged.

## Independent next-group preparation

No new implementation or frozen contract. Scratch review:
`../gradient-work/owned-numeric-remaining-storage/README.md`, `inspection.json`
and `source-predictions.json`. Untimed attribution run `41932568083` at immutable
`07541ff9` passes both architectures; independent audits took 12.72s/12.10s.
The [current source-site report](measurements/gradient-storage-2026-11-05/README.md)
retains audited records and identifies the originals. Complete scratch archives:
`../gradient-work/owned-numeric-current-attribution`. Retention took 1.47s.
The historical index wording and one moved-anchor link were corrected; all
280 documentation link sets and four plan steps pass (2.42s).

Source formulas reconcile with all 96 observations (0.14s). One fresh solve has
eight forward allocations per update and two retain sites. Candidate proofs cover
scoped input borrowing, scalar fold seed/results, single-root backward seeding and
coordinate scratch reuse. The review identifies call-convention, cache-effect,
scalar-width and cleanup requirements before code. Seven fewer requests per update
is an unimplemented target, not a measured saving. This fresh single-solve driver
differs from the repeated shared-input timing driver; do not interchange their counts.

Repair documentation `41936992630` / `126947841108` passes its complete-log audit
(2.49s); only the three expected native-runner negative diagnostics appear.
All three focused jobs and full evidence audits pass. Collection took
65.72s / 45.32s / 43.76s (ARM GCC / AMD GCC / Clang); verification took
0.14s / 0.14s / 0.13s. Runner receipts and the Windows failure logs are retained
in the repair report. Production gates remain outstanding.

Additional old-job collection took 9.81s (expected failure on the known test);
interim audit 4.66s; retention 0.13s after correcting POSIX status decoding
(20992 means exit 82). Three-host evidence retention took 6.84s.

Final documentation link/source audit passes (280 link sets, 106 immutable
preparation pairs, four plan steps; 2.67s).
