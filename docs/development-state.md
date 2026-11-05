# Current work

**Next:** monitor the repaired `gradient-call-checks` run on all three hosts
in [PR #259](https://github.com/e6qu/fun-with-pipes/pull/259). Run `41957591695` is fully audited:
22 native targets pass and the same three fail on each host. Do not start
measurements or final production until grouped correctness passes.

Branch: `gradient-call-storage`; worktree `.worktrees/owned-numeric-updates`.
Last tested source: `68f71c14` (compiler record-borrow repair). Docs `41957597604` pass;
its full log is audited (only the three expected negative-runner diagnostics). Other worktrees are unrelated.

Contract: [gradient-call storage](measurements/gradient-call-storage.md), frozen at
`1ed3ad99ef7263161d526cea816c33b36ac40b9b`, tag
`roadmap/gradient-call-storage-protocol-2026-11-05`.

## Roadmap status

| Step | Status | Evidence or remaining work |
|---|---|---|
| 1 | In progress | Direct derivative scope and word worker; caller-owned input proof awaits native controls. |
| 2 | In progress | Numeric fold fields and bounded constant proof; record move compiler error repaired. |
| 3 | In progress | Explicit single-root scalar/owned-weight peers; failure, token and precision controls running. |
| 4 | In progress | Consumed exclusive 64-bit scratch; alias/view, both zip positions and unwind controls running. |
| 5 | Pending | Resolve focused failures; exact counts, compiler/runtime measurements, then final CI and delivery. |

## Current runner results

| Run / source | Result |
|---|---|
| `41957591695` / `68f71c14` | Failed; all full logs and 75 native target logs audited. Complete repairs below. |
| `41957597604` / `68f71c14` | Documentation passes; full-log audit complete. |
| `41956890550` / `73261bf2` | macOS lint/build failed E0509: moving a record out of Value, which has a destructor. Both implementation and unit pattern now borrow fields. [Complete failed-job audit](measurements/gradient-call-checks-2026-11-05/README.md) retained; no native target ran. Unassigned Linux jobs/docs cancelled. |
| `41956076516` / `6f322d1f` | Replaced before any runner started, to include direct-seed token/unwind controls and allocation predictions. |

Current job IDs: AMD64 `127016115892`, ARM64 `127016115577`, macOS `127016115852`.
GitHub exposes completed job logs through `gh api .../actions/jobs/ID/logs`;
`gh run view --log` refuses until the whole run completes. API output needs
`--allow-escape-sequences`; preserve raw bytes, strip controls only for display.
An in-progress job log returns 404. Do not treat that as a compiler result.
Scratch downloads: `../gradient-work/gradient-call-checks-2/`.
[Retained failure audit](measurements/gradient-call-checks-2026-11-05/README.md#grouped-repair).

## Implementation and review boundaries

- Direct scopes use a private word worker. Ordinary exported/dynamic entries
  still own inputs. A later caller use must keep each borrowed input alive through
  argument evaluation, return and unwind; returned/stored/resource values exclude it.
- Fold fields admit only concrete scalar records. Constant proof accepts bounded
  literals, acyclic nullary chains and scalar zero/one; arbitrary code stays evaluated.
- Backward takes an explicit root/seed. Scalar code borrows word slices; typed code
  selects list or single-root traversal explicitly. No fake stack heap objects.
- Scratch consumes only dead I64/U64/F64 arrays. Runtime exclusivity and ordinary
  layout are required; shared arrays/views keep independent scratch. Array storage
  and partial list output have separate cleanup, with all callbacks before mutation.

## Repair batch

All reported failures have source repairs: add list `length`'s no-escape contract;
use paired scope/worker iterators; update the missed backward unit caller;
correct the pure-scope and owned-weight-list fixtures; update packed-fold counts
and move fault injection before the remaining export allocation. The borrowing
unit now checks the contract through primitive, worker and scope. No selection
requirement or memory/timing limit was relaxed. Native verification is pending.


Script-only work adds `gradient-call-time` and `gradient-call-report`, including
exact count acceptance and independent reconstruction of the saved reference.
The original host, schedule, copy, time, memory and stack limits remain intact.
The workflow will publish compiler/selection diagnostics before native tests so
future root-cause analysis need not wait for the entire target queue.
All failed jobs are audited; publish these changes as one repair batch. No native measurements have run.

Prepared `gradient-call-census` requires passing focused jobs and identical
compiler/runtime/library/test trees. It predicts 11,145 fewer requests, 1,846,744
fewer bytes and 3,184 fewer retains for eight 129/199 solves. Zero-update counts
must be identical. [Fresh-solve attribution](measurements/gradient-storage-2026-11-05/README.md)
is a different driver: 2,121 → 727 requests is a prediction, not a measured result.

## Checks and resources

All local checks use `python3 scripts/local-guard.py`; full builds/tests stay on
runners. Formatting, native assignment (255 targets), primitive inventory and
roadmap links pass. Reference controls: new 3, historical gradient 6, packed 5,
consumed storage 5. Phase controls 4; iteration selection controls 3. Generated
library docs pass both regeneration and unblessed verification.

Measurement controls: allocation census 6; compiler schedule/timeouts 10 (3.04s);
runtime budgets 23; reference/evidence reconstruction 18; retention 3 (20.57s
group); saved-session audits 12 plus workflow JSON settings (5.95s). Workflow
syntax passes. A synthetic missing peak field was corrected before these passes.
Documentation full-log audit: 2.32s, retained in
`../gradient-work/gradient-call-checks-2/docs-job.{json,log.gz}`.
Repair checks: `cargo fmt --all` passes; primitive inventory (397 declarations),
reference controls (3 new + 6 historical), 255 native assignments and diff check
pass (1.36s). The first inventory invocation omitted its required output path;
the corrected invocation above passes. Staged roadmap, actionlint and format
check pass (7.71s). Full and target-log retention passes (0.49s); both Linux
artifact/full-log audits pass (110.41s). No local compiler build or native suite.
Latest staged roadmap audit: 282 link sets, 106 preparation pairs, five steps.

Free disk at handoff rewrite: 64.950 GiB; preserve at least 64 GiB. No local full
build was attempted. Three verified, reproducible `owned-numeric-checks-6` download
archives were retired after guard refusal at 63.964 GiB; all retained controls,
logs and digest receipts remain. Full audited Windows downloads from #258 are
also retired; do not redownload them. Other dirty worktrees remain untouched.

## Previous delivery

[PR #258](https://github.com/e6qu/fun-with-pipes/pull/258) is verified and merged at
`68115090b161f198e11fb625946259f65f781580`, tree equal to tested `35745c0b`.
All nine production jobs `41939753207`, docs `41939719588`, and full/target audits
pass. [Delivery receipts](measurements/owned-numeric-checks-2026-11-05/platforms/final-gates.json)
verify tree and one-line squash message. Redundant main runs were cancelled.
[Four AMD64 speed misses](measurements/owned-numeric-time-2026-11-05/README.md)
remain open, separate from this comparison. Do not rerun unchanged timings.
