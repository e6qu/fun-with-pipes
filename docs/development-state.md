# Current work

**Next:** run and audit the final production gates for PR #258's published head.
Native correctness, allocation census, compiler costs and all runtime raw-data
audits are complete. Publish the completed evidence/docs, mark the PR ready,
then require all nine production jobs plus documentation. Inspect every full and
target log before squash-merging with an explicit one-line subject and empty body.
Keep the tested head unchanged while its gates run; no further focused rerun is needed.

Source `07541ff956d582bb9c3936b86261e43fa25b0b2f` is frozen at immutable tag
`roadmap/owned-numeric-measurement-2026-11-05`. The branch's later changes retain
evidence and update docs only. Keep this source for comparisons; do not move tags.
[PR #258](https://github.com/e6qu/fun-with-pipes/pull/258), branch/worktree
`owned-numeric-updates` / `.worktrees/owned-numeric-updates`, is the only open PR.
Full production CI starts when this completed batch is marked ready. Earlier
skipped draft jobs are not gates. Resolve the exact final head from PR metadata.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve frozen ownership, selection and measurement contracts |
| 2 | Verified | Preserve three-host native checks and all failure/cleanup controls |
| 3 | Verified | All raw measurements audited; preserve four AMD64 5% misses and separate older goals |
| 4 | In progress | Nine exact-head production jobs plus docs, all logs, verified squash/tree |

## Verified behavior

[Native run 41920964943](measurements/owned-numeric-checks-2026-11-05/README.md)
passes at the frozen source: GCC ARM64 `126893053080`, GCC AMD64 `126893053575`,
Clang ARM64 `126893053536`. Each passes 285 units (four existing ignored),
103 integrations in eighteen targets, twelve complete-program checks and formatting.
Every full/target log, all 660 image architectures and all 671 statuses per host
were audited. Both real gradient forms select consuming maps and coordinate zips.
Seven exported fixtures select their consuming entries; a later read keeps borrowing.

Arrays reuse storage only when ordinary and exclusive. Coordinate lists reuse
only an exclusive prefix, after all callbacks finish. Shared roots, ancestors,
tails and views keep aliases unchanged. Temporary results and earlier constructor
fields retain the right owners. Tests cover O1/O2, both interpreters, float bits,
overflow, traps, cancellation, allocation failure, disabled reuse and broken controls.

[Earlier failures and repairs](measurements/owned-numeric-selection-2026-11-04/README.md)
remain recorded: missing real-program selection, an outdated borrowing assertion
and an older fixture's layout. All are repaired and reverified; none is hidden.
Protocol `1c5e6a66` and extension proof `c99451ec` precede their code and retain
immutable tags. `roadmap/owned-numeric-premerge-checks-2026-11-04` preserves the
original sources before rebasing onto #257's squash; that rebase changed no files.

Documentation `41920859686` / `126892668039` passes at `07541ff9`; full-log audit
finds only the three expected negative-runner diagnostics. Previous docs
`41919183424` / `126886829262` also passed at `3b5adde4` and were fully audited. Evidence-only head `cecbaeaf`
docs `41927585967` / `126915921557` passes with a complete log audit.

## Audited measurements

The [allocation census](measurements/owned-numeric-census-2026-11-05/README.md)
passes at `07541ff9`, run `41925013907`: ARM64 `126907012020`, AMD64
`126907012115`. Independent review verifies all 99 commands, 24 native images,
48 executions and the exact reference per host. No unexpected diagnostics.
All six cases, both result forms and workspace settings match the prediction.
Largest eight-solve counts: 223,026 → 17,098 requests; 16,684,704 → 10,124,960
requested bytes; peak managed 15,232 → 13,664 bytes. Retains stay 3,192;
raw peak stays 33,904 bytes; final managed/raw storage is zero.

[Compiler costs](measurements/owned-numeric-analysis-2026-11-05/README.md) pass
on both hosts: run `41926855499`, ARM64 `126913414500`, AMD64 `126913414809`.
All 336 commands and six untimed checks per host are audited. Maximum time ratio
1.005943, peak RSS ratio 1.011100, identical-copy ratio 1.010600. No failed limit
or unexpected diagnostic; both exact references and native images verified.

[Runtime results](measurements/owned-numeric-time-2026-11-05/README.md) are fully
audited: original run `41926862701`, replacement AMD64 session 1 `41927345094`;
independent audits `41929272270` / `126921722690` and `41929960201` /
`126924072225` pass. Four qualified sessions and 5,336 raw-file records reconcile.
All 48 count comparisons in both workspace modes match the untimed census.

Long solves take 3.36–10.50% less time. Four AMD64 5% targets remain open:
session 1 3/199 current ratio 0.966403; session 2 3/199 current 0.956684,
history 0.962306; 3/1999 current 0.952365. Both ARM64 sessions pass all limits.
All copy controls, small-case regression, count/cleanup and stack limits pass.
Retain verified reductions under the agreed policy, with every miss explicit.
Process RAM is not consistently lower; frame growth is at most 16 bytes;
text-size changes −128 to +1,184 bytes. Older timing goals keep their references.

The initial AMD64 session 1 job `126913419469` rejected EPYC 9V74 before building
or timing. Its evidence remains; replacement `126915090828` qualifies as 7763.
No collected timing was repeated. Do not rerun unchanged measurements for a pass.

## Delivery and local checks

#257 is merged as `30c2bad9b89d8086a8822f992eaa0e9331bd9bd1`, tree identical to
verified `519fc966`. All nine production jobs/docs and the one-line squash message
are verified; duplicate same-tree main runs were cancelled. [History and final logs](roadmap-history.md#packed-derivative-inputs-pr-257)
record its reductions and three still-open AMD64 timing limits.

Focused local work uses `python3 scripts/local-guard.py`, serially. Limits remain
64 GiB free disk, targets below 2 GiB, sampled RSS below 1 GiB and 180 seconds.
No local full build, native suite or timing was run.

- Compiler-selection controls/format/lint/reference/roadmap checks: 15.01s.
  Test-repair format/lint/roadmap checks: 12.01s. Final roadmap check: 2.60s.
- Current native collection ARM/AMD/Clang: 40.23s / 57.17s / 41.39s;
  complete audits: 0.13s / 0.14s / 0.13s; durable retention: 2.08s.
  Current docs full-log audit: 2.48s.
- Census download/full-log audit: 28.97s; raw-data verification: 3.28s;
  exact command audit and durable retention: 3.03s. Rejected timing host
  full-log audit: 2.24s; qualification and safety retention: 3.22s.
- Compiler-cost audits: ARM64 41.33s, AMD64 53.56s; retention 1.59s.
- Runtime audit collection: 6.13s / 5.50s; combined retention 0.51s;
  all runtime/census counts reconciled in 0.26s. Current docs full-log audit 2.60s.
  Final documentation/roadmap check: 2.53s (278 link sets).
- Exact fixture formatting with verified #257 macOS ARM64 package: 0.51s.
  Formatter/parser sources match. `../gradient-work/verified-257-compiler` is
  usable only for unchanged formatter checks, not new compiler verification or
  a build dependency on an earlier fwp version.
- Freed about 721 MiB from the clean #256 checkout after matching its merged tree.
  Removed 778,568,743 / 791,742,404 bytes of duplicate #256/#257 Windows downloads
  only after verifying artifact identities and all 157 retained logs per host.
  Branches, durable evidence and dirty older worktrees remain intact.

Scratch: `../gradient-work/owned-numeric-checks-5` holds current full artifacts;
`owned-numeric-checks-2`, `-3`, `-4` preserve earlier runs. Collect with
`collect-owned-numeric-checks.py`; verify with `audit-owned-numeric-success.py`.
`retain-owned-numeric-success.py` retains completed controls. Keep failed outcomes,
use a new output directory per run, and leave unrelated primary/older changes alone.

Census scratch: `../gradient-work/owned-numeric-census-2026-11-05`; audit and
retention scripts are `audit-owned-census.py` / `retain-owned-census.py`. Reports
and raw evidence are retained under the matching `docs/measurements` directory.

Runtime audit helpers: `collect-owned-numeric-runtime.py` downloads a successful
`owned-numeric-report` summary and checks all logs; `retain-owned-numeric-time.py`
combined `owned-numeric-runtime-original` and `owned-numeric-runtime-amd1`;
both independent audits pass. It preserves the rejected host and all missed limits.
