# Current work

**Next:** publish the fixture-formatting repair and completed census tooling,
then run `gradient-call-checks` for the exact head. Only after it passes, freeze
the measurement source and run `gradient-call-census` with that correctness run
as `evidence_run`. Keep all work in [PR #259](https://github.com/e6qu/fun-with-pipes/pull/259).

Branch: `gradient-call-storage`; worktree `.worktrees/owned-numeric-updates`.
Last tested source: `cd479a9aae17f91e49fb79b106c930211636304c`.
Other worktrees are unrelated.

## Roadmap status

| Step | Status | Evidence and remaining acceptance |
|---|---|---|
| 1 | Implemented | Scoped input controls pass; counts, compiler/runtime measurements and production matrix remain. |
| 2 | Implemented | Numeric fold and constant-seed controls pass; same grouped measurements and production gates remain. |
| 3 | Implemented | Scalar/owned-weight, precision and failure controls pass; same grouped acceptance remains. |
| 4 | Implemented | Scratch alias/view, both positions and unwind controls pass; same grouped acceptance remains. |
| 5 | In progress | Fix formatting, complete measurements, final nine production jobs plus docs, then audited squash merge. |

[Contract](measurements/gradient-call-storage.md), frozen before implementation:
`1ed3ad99ef7263161d526cea816c33b36ac40b9b`, tag
`roadmap/gradient-call-storage-protocol-2026-11-05`.

[Run 41960705621](https://github.com/e6qu/fun-with-pipes/actions/runs/41960705621)
is fully audited. All three hosts pass lint/build, 292 units and all four
transformation checks. Each passes 124 native tests in 25 targets, with 798
native images and 814 probe statuses checked. Four ignored units are existing
runner-only measurement tests, not native correctness omissions.

Only fixture formatting fails: put the short `read-input` let-expression on one
line. The local fixture matches all three runners' formatter output, SHA-256
`243c68beb9511ff816b33f9acb6f7fbd29400bbd4951cdce015ea7925a354736`.
The workflow now formats copies before the native queue and publishes diagnostics
early. [Full repair evidence](measurements/gradient-call-checks-2026-11-05/README.md)
retains this run and both earlier failure audits; all known failures have repairs. The handoff audit required its fixed status-table
heading and values; restored that structure after simplifying the prose.
Docs `41960692624` pass and their complete log is audited.

Current scratch: `../gradient-work/gradient-call-checks-3/`. Completed job logs
are available through `gh api --allow-escape-sequences .../actions/jobs/ID/logs`;
`gh run view --log` waits for the whole run. Preserve raw logs; strip controls
only for display. Audited generated sources remain in scratch and original
GitHub artifacts; digest receipts and all diagnostic logs are retained in the PR.

## Prepared measurements

No native allocation or timing measurement has run. Pending script edits finish
both drivers in `gradient-call-census`: repeated solves and fresh solves, each
candidate compared with the declared same-source reference. The fresh driver
adds O1/O2 phase/site attribution and independent source reconstruction; partial
failure observations are archived too. Count limits reject extra or missing
savings, changed work, wrong phases, live storage and peak growth.

- Fresh 129/199 prediction: 2,121 → 727 requests; 230,864 fewer requested bytes
  and 398 fewer effective retains. Other inputs and zero updates have explicit limits.
- Eight repeated 129/199 solves: 11,145 fewer requests, 1,846,744 fewer requested
  bytes and 3,184 fewer effective retains. Cached initialization occurs once.
- After both counts pass: `gradient-call-analysis` measures seven compiler inputs;
  `gradient-call-time` uses `comparison_session=both` on both qualified architectures;
  `gradient-call-report` independently audits saved samples and source bytes.
- Keep the frozen speed/copy, compiler/RSS, frame and managed/raw-memory limits.
  Preserve older failed timing goals separately; do not rerun unchanged timings.

## Checks and resources

All local validation uses `python3 scripts/local-guard.py`. Full builds, native
tests and measurements stay on runners. Primitive inventory (397 declarations),
255 target assignments, formatting, reference controls and roadmap links pass.
The initial inventory command omitted its required output path; the corrected
command passes. No local compiler build or native suite was attempted.

Measurement controls already pass: repeated census 6; compiler analysis 10;
runtime budgets 23; evidence reconstruction 18; retention 3; session audit 12.
New fresh-solve controls pass 6 (including 3 historical controls), actionlint,
Python parsing and diff checks (6.90s); missing-phase and partial-failure archive
follow-ups pass with roadmap/actionlint (9.63s). Earlier source-reference controls:
new 3, historical gradient 6, packed 5, consumed storage 5. Generated library docs
pass regeneration and unblessed verification.

Full audit of the current run: ARM64 59.55s; remaining collection/retention 148.14s;
macOS preflight and docs 5.42s. A scratch collector's shadowed variable skipped
source retention on its first pass; corrected and retained sources before retiring
only the verified download copies. Keep 64 GiB free, target below 2 GiB and guard
limits unchanged. The guard refused below 64 GiB; deleting three already audited,
reproducible failed-run downloads restored the margin. Their receipts/logs remain.

## Previous delivery

[PR #258](https://github.com/e6qu/fun-with-pipes/pull/258) merged at
`68115090b161f198e11fb625946259f65f781580`, tree equal to tested `35745c0b`.
All nine production jobs `41939753207`, docs `41939719588`, and full/target audits
pass. [Delivery receipts](measurements/owned-numeric-checks-2026-11-05/platforms/final-gates.json)
verify the tree and one-line squash message. Redundant main runs were cancelled.
[Four AMD64 speed misses](measurements/owned-numeric-time-2026-11-05/README.md)
remain open, separate from this comparison.
