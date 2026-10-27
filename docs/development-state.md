# Current work

**Next:** rerun isolated sort timing with eightfold longer batches after auditing
both hosts of `40513939015`. ARM64 passed both sizes; AMD64's 256-key identical-code
control deviated by 12.7%, so that candidate was not measured. The 10% noise limit
is unchanged. The short samples are retained; longer batches should reduce brief
interruptions' relative weight. Draft PR #220 contains the whole A3/A4 batch.
Focused correctness `40512388783` and saved-artifact audit `40512399031` passed.
All completed target logs and 62 probe statuses per host were audited, including
12 inline-key and six scalar/fault outputs. The fixture's missing signatures and
formatting are fixed. Full production/analysis validation follows timing.

Work in `/private/tmp/fwp-sort-key-fields`, branch `borrow-sort-key-fields`.
PR #219 is merged. The branch rebased onto its verified squash with an identical
tree; the timing protocol source is `7da1a783`. Source `dfd844c1` remains the measured
compiler/runtime, retained by `evidence/inline-sort-key-probe-dfd844c1`. The next
commit adds timing and retained reports, not compiler/runtime changes. Keep one
active PR and defer its full matrix until the batch is ready.

## Combined A3/A4 work

- Scalar record reads no longer acquire temporary owners for unused fields.
  Known `sort-by` callbacks use existing specialization, removing a duplicated
  input pair. Shared/String-result and interruption controls preserve required
  owners. [A3 measurements](measurements/sort-key-ownership.md) verified 2D fewer
  retain/release pairs for D distinct words, unchanged memory and smaller code.
- A4 now stores selected `(I64, String)` keys together and calls the existing
  field-based worker on `(String, I64)` inputs. The saved String remains owned;
  partial cleanup and stable comparison use explicit initialized-prefix storage.
  [The declared budget](measurements/inline-sort-keys.md) requires D fewer boxes
  and D additional retain/release pairs without peak-storage growth.
- New probes exercise empty/singleton inputs, equal-key stability, integer limits,
  every scratch/output allocation failure, callback-entry interruption and
  deliberately omitted String release or buffer freeing. Source programs cover
  newly allocated key text, partial key failure and cancellation. All new probes passed at e19eed00. Concrete fixture signatures and formatting are repaired after auditing both
  hosts. The failing source never reached these new C probes.
- Docs remove stale GC-removal status, shorten completed roadmap work and now
  record verified A5. A5 delivery records now match its verified merge.

## Existing evidence

A3 prototype `00957a15` passed both Linux hosts in `40499978041`. Combined source
`a44ed18ee72301fd9363ef934596064b55eb751f` passed correctness checks in
`40501234007`; its original budget incorrectly expected fewer successful last-owner
queries, although the removed queries returned false. Reader repair `2baf3ec0`
requires the exact attempt reductions and unchanged successful queries.
Artifact-only audit `40503213568` passed without rerunning unchanged programs.
The full report and immutable source tag are linked from the A3 report.

All completed target logs and six scalar/fault artifacts per host were audited.
The A4 report in `measurements/inline-sort-keys-2026-10-27.json` passes its
declared budget; it does not replace or discard A3 observations. Sorting timing and the final
production/analysis gates remain required before A4 acceptance.

Local checks used `scripts/local-guard.py`: Rust formatting, workflow lint,
twelve evidence-reader controls and documentation links passed. No compiler
build, full suite or benchmark ran locally. Keep the fixed limits. Free disk was
about 73 GiB; check it before another workload or large artifact download.

## Verified deliveries

#219 merged as `413a10ebe1b2b08375383bebae8272129043d94a`, tree
`5653457a60d29370c82bad2367f17816860ddba0`, identical to tested `aab8fe71`.
All nine production jobs `40498383568`, docs `40498379836` and both analysis hosts
`40498382182` passed. Complete logs were audited: 256 passing target summaries
per Linux host, 126 per macOS ownership host and 201 per Windows host. The squash
message is one 56-character line without body/trailers. Duplicate postmerge CI
`40511055857` was cancelled after tree verification. A5 is complete for the
restricted local-array shape, not all arrays or containers.

[Delivery history](roadmap-history.md) records #218's callback/count attribution
and #217's verified GC removal. ARC minimization and roadmap steps 2–8 remain open.
Continue A3/A4, then A6's scoped parser workspace, preserving G2 analysis budgets.

## Recovery

Primary checkout remains detached at #209 with a worktree pointer and an untracked
`docs/measurements/compiler-abort.md`; preserve both. The original intermittent
Intel compiler abort remains unexplained. Preserve evidence and investigate its
source/input on recurrence. No detached merger is running; active timed checks
monitor CI. Squash merge only after all exact-head gates pass, with one line
<=80 characters and an empty body; verify the message and tree afterward.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve GC-free lifetime and binary checks |
| 2 | In progress | Finish A3/A4 and A6; A1/A2/A5 are verified |
| 3 | In progress | F1–F3 functional calls and recursion |
| 4 | In progress | P1–P3 measured CPU budgets |
| 5 | In progress | D1–D3 derivatives and time/storage budgets |
| 6 | In progress | N1–N2 numerical accuracy and kernel budgets |
| 7 | In progress | B1–B2 repeated baselines and enforced budgets |
| 8 | In progress | V1–V2 application correctness and scaling |
