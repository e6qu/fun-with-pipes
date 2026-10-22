# Session handoff

## Current delivery and next action

Main is `3003e2cdebf6e98f45b06b4f523d8dd21d8150c5`, the verified squash merge of
[PR #192](https://github.com/e6qu/fun-with-pipes/pull/192). All nine production
jobs and documentation passed at `36998a99f689b254edfc127bbbc8e8aac054c509`;
complete logs and identical merge files were verified. Its subject is one line,
with no body or trailers. [History](roadmap-history.md#string-ownership-and-repeated-file-cleanup-pr-192)
records the result. Redundant same-tree push CI `39724206828` was cancelled;
the post-merge documentation check passed.

The next substantial delivery is `manual-pointer-ownership` in
`/private/tmp/fwp-manual-pointer-delivery`, based on that merge. It groups manual
C pointers without tracing, interpreter C-string cleanup, checked 32-bit raw
allocation bounds, pointer-sized storage, and complete I128/U128 raw access.
The [report](measurements/manual-pointers.md) explains the contracts and evidence.
Pointers never acquire ownership of their pointees; callers still manage raw
storage and may not retain pointers into borrowed managed data. Checked ARC
callbacks returning managed C string addresses remain excluded.

Next: audit this delivery's exact-head production and documentation jobs, fix
all failures together, then squash-merge only after all nine production jobs and
docs pass. Use one explicit subject of at most 80 characters and an empty body;
verify the resulting message, parent and identical files. Publication and merge
are already authorized. Keep one active PR; continue through the seven plan areas
after this delivery. No additional permission is needed.

[PR #193](https://github.com/e6qu/fun-with-pipes/pull/193) is open at
`91502f538d2265f3f7afd8606760dfcc4a088005`. Production run `39725180238` and
documentation run `39725180233` are in progress. Publication passed the guarded
documentation, source-identity and commit checks in 9.25s. Audit with
`/private/tmp/fwp-audit-193-final.py`; its receipt is
`/private/tmp/fwp-193-final-acceptance.json`. Publication and integration receipts
are `/private/tmp/fwp-pointer-delivery-{publication,integration}.json`.
Keep the tested PR head unchanged while gates run; the primary checkout holds
this live handoff update. Do not create a duplicate PR.

## Accepted pointer preparation

Source `7173927b7bc899f8c43b17e909656d9550bb2bbe`,
[run 39721437783](https://github.com/e6qu/fun-with-pipes/actions/runs/39721437783),
passes all six native hosts and the actual 32-bit interpreter/WASI job. All seven
complete logs were audited. Each native host passes 24 test functions across
seven targets; Linux AMD64 also passes 176 compiler unit tests. The 32-bit job
passes three interpreter tests and the generated-code test at O0/O2.

Independent inspection covers 150 native images and 12 WASI modules, including
actual architecture/code, absence of tracing in ARC images, exact outputs,
missing-release/bound controls and library unload ledgers. C/binary/disassembly
hashes and log hashes are in the [JSON report](measurements/manual-pointers-2026-10-22.json).
Raw artifacts and individual receipts remain under
`/private/tmp/fwp-pointer-evidence/7173927b7bc8/`. Do not repeat completed downloads
or inspection. The guarded all-host inspection passed in 37.18s.

Five preparation commits were replayed onto the identical #192 merge tree.
Compiler, runtime and program files match the accepted preparation; only the
report, history and handoff change for delivery. The source branch/tag remains
available; current preparation/audit receipts are
`/private/tmp/fwp-pointer-boundary-publication.json` and
`/private/tmp/fwp-pointer-boundary-acceptance.json`.

Preparation fixed missing Windows executable suffixes, missing OpenSSL setup,
and an unexported regression fixture before the accepted run. Every failed
job/target was audited. Earlier receipts retain their source suffixes; their
failures are resolved evidence, not next tasks. Native-build errors now aggregate
through the corpus instead of hiding later cases.

## Next batch: move strings through map

Preparation branch `string-map-ownership` reuses the completed pointer worktree
`/private/tmp/fwp-pointer-ownership`, based on PR #193's tested head. Its old
uncommitted preparation reports were byte-verified and preserved at
`/private/tmp/fwp-pointer-preparation-local-docs/` before switching branches.
Do not mistake that workspace for the immutable pointer preparation source.

The new compiler pass selects fully applied `map` calls whose known, uncaptured
callback takes and returns String. It consumes unique input nodes and strings,
keeps shared tails owned, and builds fresh output nodes. Changed ASCII case
conversion can reuse unique young string storage. Captured/unknown callbacks and
resource-bearing inputs keep their existing contracts. Runner validation is
pending; do not claim verified compiler support or a timing gain.

The exact new runtime helper, inserted into previously generated word-frequency
C, passes the 64-word/eight-base-word oracle and whole-list/tail/string aliases:
274 requests, 130 retains and 5,376 peak charged bytes versus 296/194/7,744 before.
All four cases end at zero charged storage and collections; retained C/images/
count reports are `/private/tmp/fwp-map-runtime-evidence/`. Guarded check
`fwp-prepare-string-map-check.py` passed in 3.39s. The failure/cancellation probe
passes; omitted source/result cleanup each fails with expected status 245
(`fwp-check-string-map-unwind.py`, 2.19s). These are local runtime diagnostics,
not all-host compiler evidence. Raw interpreter fixture checks passed in 0.73s.

Preparation formatting, workflow syntax, primitive contracts (392 declarations),
all 11 native-runner tests and explicit coverage of all 252 native targets pass
(`fwp-check-string-map-preparation.py`, 15.37s). Negative timeout/exit cases in
that runner test are intentional and passed. New `string_map_ownership` tests
compare interpreter/native output and retain cleanup controls at O0/O2 in both
memory modes. The six-host `string-map` suite is running at
`972d0fda9a25722f568c7d1163772ac7716619bd`, run `39726199897`. Publication
passed in 6.88s. Receipts are `/private/tmp/fwp-string-map-{publication,acceptance}.json`;
audit with `/private/tmp/fwp-audit-string-map.py`. Next: audit every completed
job, fix all failures together, inspect binaries,
then repeat equivalent-work word-frequency C/Rust comparisons before selecting
budgets or claiming improvement. Keep PR #193's final head stable during CI.

The first focused source fails generated C compilation because its new direct
helper precedes the `FWP_K` macro definition. All six completed jobs have the same
cause across every failed target; full logs have been audited. The repair moves
the helper into the existing direct-callback section. A complete-runtime local
compilation now passes success, source/result cleanup, shared aliases during
failure/cancellation and partial output-list cleanup; three broken-owner controls
each exit 245 (`fwp-check-string-map-runtime-order.py`, 2.84s). The earlier
saved-C helper diagnostic inserted code later and did not check emitted order.

Local pending changes also add a runtime-selected callback and caught-error
fixture, physical ARC teardown checks for the actual language program, retained
language binaries, and an explicit baseline revision for word-frequency runs.
The final host log is audited; publish the combined repair and rerun all six hosts.
Use the existing accepted word-frequency source/run as the benchmark baseline,
with the prospective budgets in the preparation report. No new performance
result is accepted yet.

The preparation report is `docs/measurements/string-map-ownership.md`. Private
notes remain `/private/tmp/fwp-map-consumption-design.md`. Do not mutate old
immutable list-node fields after a callback: collection can make later writes
of younger references unsafe. The implementation builds fresh output nodes.

## Roadmap status

| Step | Status | Area |
|---|---|---|
| 1 | In progress | Remove tracing; limit ARC. |
| 2 | In progress | Remove avoidable functional costs. |
| 3 | In progress | Improve measured machine-level performance. |
| 4 | In progress | Improve autodiff time, memory and precision. |
| 5 | In progress | Validate CPU numerical kernels. |
| 6 | In progress | Establish comparable measurements and budgets. |
| 7 | In progress | Complete the finite application suite. |

All seven remain open. A completed PR does not finish the language's memory or
performance goals. JIT compilation is excluded, not deferred. The [plan](../PLAN.md)
and [application suite](application-acceptance.md) define the remaining work.

## Workspace and local checks

The primary checkout is detached at the verified #192 merge, with this live
handoff as its only local edit. The pointer delivery remains in
`/private/tmp/fwp-manual-pointer-delivery`; independent map preparation uses
`/private/tmp/fwp-pointer-ownership`.
Use `python3 scripts/local-guard.py python3 SCRIPT` from the primary checkout.
Keep checks serial; preserve 64 GiB free disk, target below 2 GiB, sampled
workload RSS below 1 GiB and the 180-second deadline. Full builds, suites and
benchmarks run on GitHub. Do not raise limits or use the separate fr guard.

Focused fixture/export, allocator-observer, formatting, workflow, documentation,
primitive-inventory and native-runner checks passed before publication. Scripts
and receipts remain in `/private/tmp`; all-host binary inspection and final
report/handoff validation also passed. The final documentation check was 2.64s.

Completed evidence is archived losslessly under
`/private/tmp/fwp-task-record-evidence/c10934f5dadf/` and
`/private/tmp/fwp-task-await-evidence/f2b5d400feda/`. Each contains
`completed-native-evidence.zip` and a byte-verified receipt. Only extracted
duplicates were removed; source and current evidence remain intact.
