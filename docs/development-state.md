# Current work

**Next:** inspect complete focused artifact audit `42319311816` (suite
`tape-record-audit`, producer `42290415866`, source
`b4b291e3184cae5046d7a1eba27e777c67b1884a`, attempt 1). It is dispatched.
Batch any failures before measurements; monitor the documentation repair too.

## PR and implementation

[PR #267](https://github.com/e6qu/fun-with-pipes/pull/267), branch
`tape-operation-records`, worktree `.worktrees/recording-capacity-gate`.
Reference/user merge: `ef0a54a1da660fcc4c4e094e96c30c1adbe0fb5d` (#266), same tree
as reviewed `3595f4b0cec1e37bc7874fca5e09bb176c87a1af`.
Contract `036662872` preceded implementation `b4b291e31`.
Preparation `a97bc703f`; measurement/audit dispatchers `fd131ae00`.
AMD 7763/9V74/9V45 approval persists. No decision is pending.

[The contract](measurements/tape-operation-records.md) defines 24-byte numeric
operation records, 8-byte typed parent records, checked capacities and exact
cleanup. Moving growth, partial typed growth, cancellation, registry/workspace
reuse, duplicate-parent arithmetic order and actual wasm32 bounds are covered.

## Roadmap status

| Step | Status | Evidence and remaining work |
|---|---|---|
| 1 | Implemented | Runtime layout; no native change after `b4b291e31`. |
| 2 | In progress | All three focused jobs pass; full artifact audit pending. |
| 3 | Pending | Reference, producers, readers and dispatchers ready; no measurements launched. |
| 4 | In progress | Production CI running; docs repair and complete audits required before squash. |

## Active CI

[Focused run 42290415866](measurements/tape-record-checks-2026-11-06/README.md):

- Linux AMD64 `128142085029` and ARM64 `128142085462` pass 305 compiler tests,
  all ten native targets, observers, formatting, lint and primitive inventory.
  ARM also passes the real wasm32 allocation bound. Complete job logs have no
  unexpected diagnostics; their hashes and metadata are retained.
- macOS ARM64 `128142085304` passes. Four existing measurement-only unit
  exclusions are named in the logs; the auditor verifies their exact set.
- Preparation docs `42292580171` and dispatcher docs `42293845430` pass.
  Head `a55ea682f` docs `42294930890` failed: the handoff cleanup removed the
  required status heading and numbered/status columns. Restored that structure;
  direct `check_handoff()` and workflow-size validation pass under the local
  guard (0.19 s). This was the only failed step; subsequent docs checks skipped.
  The replacement docs run must finish before claiming the gate passes.
- The PR is now ready for review. Production run `42319169980` at `a55ea682f`
  has Linux AMD64 running and eight jobs queued; no failed steps reported.
- #266 merge CI `42288270547` passes all nine jobs; docs `42288270157` pass.
  All three focused native job logs are retained and have no unexpected diagnostics.

## After focused acceptance

Dispatch `tape-record-analysis` and `tape-record-time` with
`evidence_run=42290415866`. The preflight requires all three successful jobs and
identical compiler/runtime/library/native-test/build source trees. If native
sources change, obtain new correctness evidence first. Tool/doc edits alone do
not require another native run.

Both versions use the current compiler; only the frozen #266 tape section differs.
Its hash-checked fixture lives under `scripts/fixtures`, outside native test
sources. Generated C must match outside that section. Readers parse saved
preparation identities as data, never execute saved code.

Before timing each input, check both workspace settings: unchanged managed
counts, one numeric growth request versus two, equal payload bytes, unchanged
adjoints and exact cleanup. Keep all earlier time/copy/stack limits. Audit each
completed producer with `tape-records-compiler-report` or `tape-records-report`,
passing its actual `evidence_run` and `source_revision`. Preserve every miss and
host rejection; never repeat qualified unchanged timings for a pass.

## Verified tools and repairs

Guarded focused checks pass: tape references/observers (9), context references
(5), runtime budgets (24), historical groups (13), compiler costs (11), depth (5),
correctness prerequisites (3), runtime retention (4), production/focused audits
(7). Commands use `python3 scripts/local-guard.py python3 scripts/test-*.py` with
the relevant explicit filename. Rust formatting and changed Python syntax pass.
Actionlint passes all changed workflows with shellcheck/pyflakes disabled.

- Complete-manifest controls caught the reader expecting a compiler file instead
  of the runtime file. The corrected reader rejects changed/extra source files,
  tampered patches and wrong frozen identities.
- The focused audit checks exact native target names, unit results, wasm32 result,
  native image architectures and every saved file. Missing/wrong targets, missing
  wasm and extra unit exclusions fail its controls.
- Sparse checkout omitted historical fixtures. Restored only required tracked
  reports/logs, including one 5 MB JSON, then reran affected checks unchanged.
- Longest local group: 19.06 s, 9.55 s sampled CPU. Latest audit controls and Linux
  log checks: 0.13 s each. No local native builds, full suites or benchmarks.

## Carried evidence and operating rules

The previous compiler change's [nine production jobs and full audit pass](measurements/recording-context-delivery-2026-11-06/README.md);
ten job logs and 1,456 target/probe logs have verified hashes.
[All 48 original measured images reproduce](measurements/recording-context-images-2026-11-06/README.md).
[Its runtime misses remain open](measurements/recording-context-time-2026-11-06/README.md);
[compiler costs](measurements/recording-context-analysis-2026-11-06/README.md) and
[allocation/work counts](measurements/recording-context-census-2026-11-06/README.md)
are complete. Their source/run IDs remain in those records, not a new backlog.

Use the local guard serially. Last free disk 72 GiB; preserve 64 GiB. Large
archives and audits stay on runners. The user's 20 hosted-job slots can be busy:
wait for runners, do not infer billing restrictions or restart queued work.
Bundle repairs before final CI. Squash only after all final gates/audits pass,
with one line <=80 characters, no body/trailers/attribution; verify tree/message.
Continue [PLAN.md](../PLAN.md) after delivery; one PR does not complete the roadmap.
